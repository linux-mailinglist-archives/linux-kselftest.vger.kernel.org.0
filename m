Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E256C3A33
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCUTQw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjCUTQv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:16:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E9833471;
        Tue, 21 Mar 2023 12:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iO1+YEDjpsp/JOOwjYj4+4UzmtlVHonVw5aUaD0s05EL2BdGaYZVm7RQ4KB/uIIoRje/tEKa+8pmpsxCW6+YT+fybB8y5cxY3y93nS363BY8T+a3u6+SUq1NlZoFLGVn0rlBQcSR1LxK/gE2b12wU/g+Nu3tWLURR/HB2JWyRQ06HW4PenXNBpp8l1QdPxhDv/o5no/VQIe5AtuYH4k5x2tVMUVJmvFvzyijr2Ql3NGUpdBSiYx4tdtmkUDOWkZOU6oiZVEKQfJujfd/TWcdbwuTZkT31B03Qdgwh+b19K2m9MP2Pc8kgJTPIh/GSgLciLrZdLKQMLJ7pB6S1GyCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTJtTJgjYY4nXvded4UVZSZO0OQMo6yXwCDdWQMochI=;
 b=d+ilNsnt55yvDDq5gbR7pfbtK26ubxO1C9JqzlTWGnEnYitvbYAV66dPI7thv6jUGTskp/LiGr2AVFs362h3TWt+coVQpI725Qaf+bus4DaXqOqYCROeFCh81amtmCGICqkj71yMDBwcN2QZhVDW5m6RPHfSdZz1524OSAuxRjXNIX/AzsQCNObvjmZcrU2Rrm9mwKwI91p5Eb1uk35KxHxhT67PGYLCNXUxJt76mIO3pBelGLoJqlkzsFOOvzgulHJeDPFZnWe+Q31IX0RT1sdDayh5U3FGM2uBXzkDUNzej7r/PYRQmGkLxC8p+gzUlTfEQv+xchhNH+5j48OOIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTJtTJgjYY4nXvded4UVZSZO0OQMo6yXwCDdWQMochI=;
 b=LI8aTkF2G2wNUfDlN5TMTOwx3Heb9R+KpfUlR5tK6Z7ibMWgYMIIqgoFAZCZh7/11eTzPun8WxVahbMwbGnLsH2uIg2nv3yvg/siaPuBzm4G4pwUOwwn/xhU9H8GiAXd1rQ2T4bUy4/sFaH0cxM4X1/0blYIy4QKPSmGIKjfZaL0r0arrcZU97VdviHupZ912S0nK2bb/jG7DfmyJQcKSGzWbMfOlTjFv84E2cclF/jIr5wDXlyvUaBr5iR9HxZ4s5N6KEmg7VlItHH7TmvZXSlV78Ll4+P2mlFlV+F4lKGkFbbZY0vlztycItOmMOZD6bXsOeLfrDuSckTXgICANg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:59 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 14/17] iommufd/selftest: Test iommufd_device_replace()
Date:   Tue, 21 Mar 2023 16:14:48 -0300
Message-Id: <14-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:208:234::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 218a8755-6f35-484f-8ac5-08db2a408e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibk7wD4KV4X28G06FkZYmFQc8aD3g5sDgo31LKcMWObCC+05mPG6f6eSXcae/7EXWptVFf82Y3sEFlWNcDvyVbx7Ue/d1d/1SaMhfS9TtuTDl6lPdY9S1pvdPd9/ZaGD2W5mHOrnbTYelOlhlC0qdiOaYPO5CmbNc9KjsF9OnEks25u0dui7qeBQTkHRihsytb6FLQRL17Q1Zwf/CVLp8gPLj3VK8edk/plPVrFDf5G9fu0pteJ2mxVmV5OypD59OqEKNzjmVLdUxwRffpHA4Wz7wwLy+SQ4WegvAxNtLhOcCV3SVuWI2hZayzewPit4eunW2GdhSZbF3jv44QeSomwDufuby/KnILM78ZglAY0Y3jNvkMzn3qkY/8auoGygvZ08hREvBB/dFCn1gXKQwpuB4DB1lnm3stdB1uNplJr1U19c871JDoGVjFLQmR0YsrsFzrbW3I/9ki5I2rCt2Fg1ekt41IdZIkWe5LxyznKJArFf8fy4KRNZHcZz5qR2UNa++wSLRd+jx8On5RCThfyHuSM7mvTQIjO8P75Ce5KNv/vsNUXPmhi/cMSMT9TMjZrScR+HC2yACM+wypZU6g+08PWjaEd7ZPxaZ/0F4KhPHCKfsJ3FUDrOhd00qcU7Feoc1nrZh3K6Re3OqO0COg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199018)(66899018)(38100700002)(36756003)(86362001)(83380400001)(26005)(6506007)(6512007)(186003)(6666004)(2616005)(6486002)(8676002)(66476007)(66946007)(4326008)(66556008)(478600001)(316002)(54906003)(5660300002)(8936002)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NKTXPqpNPM6RB7sB46kTHdQdOiW0vR6YWDcH0MjDIsYUiBkO7FrInv98RPYR?=
 =?us-ascii?Q?qodcFX8GhP+zvr2+w4CGCqfwuw28p01sIoFFSSjwzKYK3T12I2k19Xeu54xK?=
 =?us-ascii?Q?E4epWGvGKLRMVGBDXrS85O/DHsqFE8Zt6X71bASUc2kUU+YqjiQkwlqvrlDK?=
 =?us-ascii?Q?K/iKweNekGDmsyW3TsBtqOanFhqjVYMQzXjkZbsrtM8nedJVwszXbHyj+k8F?=
 =?us-ascii?Q?Ukk/3gEnaEJu8OuD2UlkYHWPMe5pA4EsCuJCtEkyM0D+KA5coZoxKcjk8NSu?=
 =?us-ascii?Q?38RUcZ+BTxTHQVAJsNgTQ88caYo/niZWdQoYp80WZw4QfjZG/+qKnTdnv3RD?=
 =?us-ascii?Q?FJtN5GlVolxJ8ZuyyVPl9VNL51hcY7ZEJbgUCWTHC4ltX8qGIihfMj26Wttu?=
 =?us-ascii?Q?PPOzUQGBEYNb7Tt5V6HpLvpRcl1nWQsIeDPv3lVGhmM1UiWLBXVDWwEeLiFX?=
 =?us-ascii?Q?CN3ZyaVvXHtT2/c2mZQmju7XRN8XNjkgVXJqW2xwvME879cVlU/zJn9CeBdZ?=
 =?us-ascii?Q?x0C+r2mYwySz2uwLilj6nqZTnVRTIQ4lZTROvqOk1ZoU0Gs2q9DeCi2VBigo?=
 =?us-ascii?Q?VTPrFbqQ63LOmtcHR67CcoosZWHCkKq0qTVLUS3++PokuEuwN6WE88LWnnLP?=
 =?us-ascii?Q?RtLXUBbl7nDJhgcFB8DZilM/KcHPV6eBncu74cksW/5QN0OhaLixuOf8mhGc?=
 =?us-ascii?Q?uKD4cQzuQ8ssBzqhLyVopm0OuP4fkr9hikjiEv6FUf6C5GTMeMFNbvfme+2J?=
 =?us-ascii?Q?eEfUbJdyT/s1vgh+GPTxudtJwhh0tatorBOMhfaiKIZ0C0zoBAQoLoC2+8IR?=
 =?us-ascii?Q?wet4nRIQ3vfIc2QwgaPIATlzZ15Bn0+N4Nlpo05v3nF1HSsH7Y+K+o1qsLSt?=
 =?us-ascii?Q?7e1Gn49nQ/jDj62iwsHxKPHPPwqojhkqiK6ueRP6meYD6nIhVM+f/oaKAQs1?=
 =?us-ascii?Q?rwnwffreBcwI6uI641YfEjIdN5oBIxIhYbZBY1nLzenfxA+onx8+iih28VeV?=
 =?us-ascii?Q?2Q1xGJbz5TDLWVq+rnwF8NuCUSYFic/ljs4fVoYbUQnXNxnAWf19sz7OLeys?=
 =?us-ascii?Q?Z2HNaGU1suEuTgHovGmPTjkS0KR8I/yRxW4S0A7pmlW6kHDW9ntCBNgSjx23?=
 =?us-ascii?Q?HzeBWir74iWPp4DxjC2xPAeslMu45Gw5eG7aco5Py0NNkr2ZmCvdAG36wv37?=
 =?us-ascii?Q?DquOvkODFHKwpY+XL31WH2Hcz5yjurev4GSZoVQmE8NxRYMpX0U3mlOAu5aG?=
 =?us-ascii?Q?IeQj5awNRcY74j4d4D1DG3jMMS74yBRNVO65H030WUknnb/ySW7OjH5/c1ff?=
 =?us-ascii?Q?c1FePMfQao82/vapd+5E5x68rmdNeOi0Up4gnPMHZSsj7Jd3VzCCq6t+IGXU?=
 =?us-ascii?Q?HgK9RxdstKISQ1UsBvcqmZCFVv8Bg3R8U2ePJ09Em/EcXp47k0juqcZR8hV7?=
 =?us-ascii?Q?Qz3Q9Dmo1iwlxvAQlyRBpnbFgqQOC9u9c5UyGcjgGp8guT8RCZsJ6HbnhYv3?=
 =?us-ascii?Q?0dalSlQD6ErC3dMSiUpT8Nb3XNjwWihqxPGV+khhLDmqG7tX3q1a8tF5vUJb?=
 =?us-ascii?Q?hPiz60EEws9+o+kdNdvEyeovoibQjbab9kRLkyqv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218a8755-6f35-484f-8ac5-08db2a408e38
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:55.7275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4orRkK19Rzfa1JlP5EMyth2aBAgl7cxq3yEmW6z8QpdBg0WH5gOrh8CiV8xdfKiz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

Allow the selftest to call the function on the mock idev, add some tests
to exercise it.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  4 ++
 drivers/iommu/iommufd/selftest.c              | 39 +++++++++++++++++++
 include/linux/iommufd.h                       |  1 +
 tools/testing/selftests/iommu/iommufd.c       | 34 +++++++++++++++-
 .../selftests/iommu/iommufd_fail_nth.c        | 27 +++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 28 +++++++++++++
 6 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index b3d69cca77295c..e3f1035cbd6464 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -17,6 +17,7 @@ enum {
 	IOMMU_TEST_OP_ACCESS_PAGES,
 	IOMMU_TEST_OP_ACCESS_RW,
 	IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT,
+	IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
 };
 
 enum {
@@ -52,6 +53,9 @@ struct iommu_test_cmd {
 			__u32 out_stdev_id;
 			__u32 out_hwpt_id;
 		} mock_domain;
+		struct {
+			__u32 pt_id;
+		} mock_domain_replace;
 		struct {
 			__aligned_u64 iova;
 			__aligned_u64 length;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 58471f9452be55..dd792294298ffd 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -455,6 +455,42 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+/* Replace the mock domain with a manually allocated hw_pagetable */
+static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
+					    unsigned int device_id, u32 pt_id,
+					    struct iommu_test_cmd *cmd)
+{
+	struct iommufd_object *dev_obj;
+	struct selftest_obj *sobj;
+	int rc;
+
+	/*
+	 * Prefer to use the OBJ_SELFTEST because the destroy_rwsem will ensure
+	 * it doesn't race with detach, which is not allowed.
+	 */
+	dev_obj =
+		iommufd_get_object(ucmd->ictx, device_id, IOMMUFD_OBJ_SELFTEST);
+	if (IS_ERR(dev_obj))
+		return PTR_ERR(dev_obj);
+
+	sobj = container_of(dev_obj, struct selftest_obj, obj);
+	if (sobj->type != TYPE_IDEV) {
+		rc = -EINVAL;
+		goto out_dev_obj;
+	}
+
+	rc = iommufd_device_replace(sobj->idev.idev, &pt_id);
+	if (rc)
+		goto out_dev_obj;
+
+	cmd->mock_domain_replace.pt_id = pt_id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_dev_obj:
+	iommufd_put_object(dev_obj);
+	return rc;
+}
+
 /* Add an additional reserved IOVA to the IOAS */
 static int iommufd_test_add_reserved(struct iommufd_ucmd *ucmd,
 				     unsigned int mockpt_id,
@@ -944,6 +980,9 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 						 cmd->add_reserved.length);
 	case IOMMU_TEST_OP_MOCK_DOMAIN:
 		return iommufd_test_mock_domain(ucmd, cmd);
+	case IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE:
+		return iommufd_test_mock_domain_replace(
+			ucmd, cmd->id, cmd->mock_domain_replace.pt_id, cmd);
 	case IOMMU_TEST_OP_MD_CHECK_MAP:
 		return iommufd_test_md_check_pa(
 			ucmd, cmd->id, cmd->check_map.iova,
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index c0b5b3ac34f1e0..3044a432a83e22 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -22,6 +22,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 void iommufd_device_unbind(struct iommufd_device *idev);
 
 int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id);
+int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id);
 void iommufd_device_detach(struct iommufd_device *idev);
 
 struct iommufd_access_ops {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index da0443ba16830f..77b0601fd13a71 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1001,6 +1001,7 @@ FIXTURE(iommufd_mock_domain)
 	uint32_t ioas_id;
 	uint32_t hwpt_id;
 	uint32_t hwpt_ids[2];
+	uint32_t stdev_ids[2];
 	int mmap_flags;
 	size_t mmap_buf_size;
 };
@@ -1022,7 +1023,8 @@ FIXTURE_SETUP(iommufd_mock_domain)
 	ASSERT_GE(ARRAY_SIZE(self->hwpt_ids), variant->mock_domains);
 
 	for (i = 0; i != variant->mock_domains; i++)
-		test_cmd_mock_domain(self->ioas_id, NULL, &self->hwpt_ids[i]);
+		test_cmd_mock_domain(self->ioas_id, &self->stdev_ids[i],
+				     &self->hwpt_ids[i]);
 	self->hwpt_id = self->hwpt_ids[0];
 
 	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
@@ -1274,6 +1276,36 @@ TEST_F(iommufd_mock_domain, user_copy)
 	test_ioctl_destroy(ioas_id);
 }
 
+TEST_F(iommufd_mock_domain, replace)
+{
+	uint32_t ioas_id;
+
+	test_ioctl_ioas_alloc(&ioas_id);
+
+	test_cmd_mock_domain_replace(self->stdev_ids[0], ioas_id);
+
+	/*
+	 * Replacing the IOAS causes the prior HWPT to be deallocated, thus we
+	 * should get enoent when we try to use it.
+	 */
+	if (variant->mock_domains == 1)
+		test_err_mock_domain_replace(ENOENT, self->stdev_ids[0],
+					     self->hwpt_ids[0]);
+
+	test_cmd_mock_domain_replace(self->stdev_ids[0], ioas_id);
+	if (variant->mock_domains >= 2) {
+		test_cmd_mock_domain_replace(self->stdev_ids[0],
+					     self->hwpt_ids[1]);
+		test_cmd_mock_domain_replace(self->stdev_ids[0],
+					     self->hwpt_ids[1]);
+		test_cmd_mock_domain_replace(self->stdev_ids[0],
+					     self->hwpt_ids[0]);
+	}
+
+	test_cmd_mock_domain_replace(self->stdev_ids[0], self->ioas_id);
+	test_ioctl_destroy(ioas_id);
+}
+
 /* VFIO compatibility IOCTLs */
 
 TEST_F(iommufd, simple_ioctls)
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index d9afcb23810e1a..baaea15b355297 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -569,4 +569,31 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 	return 0;
 }
 
+/* device.c */
+TEST_FAIL_NTH(basic_fail_nth, device)
+{
+	uint32_t ioas_id;
+	uint32_t ioas_id2;
+	uint32_t stdev_id;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	if (self->fd == -1)
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id2))
+		return -1;
+
+	fail_nth_enable();
+
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL))
+		return -1;
+
+	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
+		return -1;
+	return 0;
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 85d6662ef8e867..3222f246600422 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -66,6 +66,34 @@ static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
 	EXPECT_ERRNO(_errno, _test_cmd_mock_domain(self->fd, ioas_id, \
 						   stdev_id, hwpt_id))
 
+static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
+					 __u32 *hwpt_id)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
+		.id = stdev_id,
+		.mock_domain_replace = {
+			.pt_id = pt_id,
+		},
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_TEST_CMD, &cmd);
+	if (ret)
+		return ret;
+	if (hwpt_id)
+		*hwpt_id = cmd.mock_domain_replace.pt_id;
+	return 0;
+}
+
+#define test_cmd_mock_domain_replace(stdev_id, pt_id)                         \
+	ASSERT_EQ(0, _test_cmd_mock_domain_replace(self->fd, stdev_id, pt_id, \
+						   NULL))
+#define test_err_mock_domain_replace(_errno, stdev_id, pt_id)                  \
+	EXPECT_ERRNO(_errno, _test_cmd_mock_domain_replace(self->fd, stdev_id, \
+							   pt_id, NULL))
+
 static int _test_cmd_create_access(int fd, unsigned int ioas_id,
 				   __u32 *access_id, unsigned int flags)
 {
-- 
2.40.0

