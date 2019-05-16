/**
 * @author anthony.beran@slalom.com
 * @date 10/8/18
 * @version 1.0
 * @description TopicGroupListControllerTest
 */
@IsTest
private class TopicGroupListControllerTest {

    static testMethod void getGroupsForRecord() {
        Topic topic = new Topic(
            Name = 'test'
        );
        insert topic;

        //setup
        CollaborationGroup cg = new CollaborationGroup(
            Name = 'My Group',
            CollaborationType = 'Private'
        );
        insert cg;

        CollaborationGroup cg2 = new CollaborationGroup(
            Name = 'My Group2',
            CollaborationType = 'Private'
        );
        insert cg2;

        CollaborationGroup_Proxy__c g = new CollaborationGroupProxyBuilder('new test group')
            .withCollaborationGroup((String) cg.Id)
            .buildInsert();



        insert new TopicAssignment(
            EntityId = g.Id,
            TopicId = topic.Id
        );


        Test.startTest();
        List<CollaborationGroup> groups = TopicGroupListController.getGroupsForRecord(topic.Id);
        Test.stopTest();

        System.assert(1 == groups.size());


    }
}