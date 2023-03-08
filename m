Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6CE6AFB43
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCHAgY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjCHAgS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:18 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03CB58495;
        Tue,  7 Mar 2023 16:36:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHAmNSzOT5mg8K083Ub3pC8eO+xYYTVC0cZyvA65cgcT2Z++N4rwUpjfRUZyEl0+/mVKcD0wayF1tLkMCuCeb2s9sfnCZ4Jab9gqqUTuQmfj/qG6yCiqrkehM4bc2LekcMRfOHqOF5evAi05qaVtKMsRpSIp978zbUg2rtOaRMYCf57/LiAPnlZS1hJ4Tp8vuk3hRA8+Vd8OvXqmPKG5VxeCWq5Ax1GDqnkAfzGPoW4x9B2yNvZwDS2KUdROjwmbrxy8kg1hxqlajR12jT6+6RoUVsA24fCdRFno3HmlDWJAWMQUfLQWyWQvSzU4z4r+kK4QVl0Ak7a6X1fkmhkAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQ7eAL0iM4ezK6Fs66vWPlxFOinFHhdwE4p0UCl83vM=;
 b=bJQYVDvCPoXRr/9eiODZ5qJn5v6H/47c0kAQYw22jIZh9PEkFm+wpk+9PCkPHTne+Hrp78xNAobGYvqr+xi5Pk4SjkweKkyKz0z0fONGNOaBZJzs8Qk8bI+pPD9nlFNhCXgt/gBVkBByuSdGPjz61bU9JB1sE8yvvhsdcj4uc4CT+6B6UQT4djg1xRQCDpi61HmF5Y6o+3C+TUBSmnGHnhONFp7VGiPgnZVlNpmdLKyPDhA0CMPPl2gbVSzBgsHMm97oXQL1iyatEeikztaMQz+Dmcr45SQC/Fni+RKPeRfTEdqlxL23Tz7NOZSqNz/FG1sigFrSP8wnIrDVUL6zrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ7eAL0iM4ezK6Fs66vWPlxFOinFHhdwE4p0UCl83vM=;
 b=IpLdri9/YCy/uyiwd4UYyP5ZxqGvG+Q79tVM9/UUrgs6UL08MHPuJqCZbKent5cVOa4AL+VZ5dZnr6rxWvB9Wj53TC7TRL4AhmliX7X0fRo5Rj0RuX4gcXjs4VDt5A6ZDqC2nlMMGfSLkXrqfytf7gmyphCF0nRgXgm3Rs1/AHNj8t6W05s4jjwatk76gPUu+L0efqmXnDvZ2M1GGkVZIIxqcuyg4b+xnCz74hi5TL1EWD7srEjT6O5zeN0nFneaZESL8+17zdJdbwCYfjDNFcyyXEF6SfwUHbcTYs/K9xZQetcjPxWpxDn5j0OUw32/FXkkrCTe/WBbR0GXEzJVfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:36:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:36:01 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 14/17] iommufd/selftest: Test iommufd_device_replace()
Date:   Tue,  7 Mar 2023 20:35:53 -0400
Message-Id: <14-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0025.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::38)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d134498-8934-4bb8-07c9-08db1f6d169b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8OCmUnRahMnopMNqJoLa5WhrPtvLQCGrapHv5NOGV5XS9iauJ2vvt6zVGTenQxF28YKry47SjqIklCj995y57p1Qjyo2GeI+1NWJM2xDpSyZp4a12bFzACdp0jPDaLR5qR/8hWacEjOJdGg7md1wzd+uRkFy4AxDbBVQUaaomp8m+jPLLbSo+6BUKzLBluOfHZrapz4dHHuprcwe6nCuywS8qVUczOb1sa1ozFQX9V94W0icGxnvnFjms910efRj3B6RfOijSMPJpCbLmbTSNlUFJ1cLFJ2Z5Opx4mMyhJpEDMvLrx95EYG4dMybUOZ7jNMCWGeU5RrVHBq3u1bRrkslO4khrsjiJLVOZidBtgFLs1WZElCVmX8KVu9qtqjKUbe2ujWEoyYVuzC5OevKntOE/A+xX1d8LPudCmHNNMxZvEiLrPV+nXu9ZYzeLhDmE5KBunZXsMe/UcwIchsqMOJKdyv0BiCDi2tGnFjPpJEe43Hw0H8DweMriAWaqqHsuPJmUJJGEbl7xDYK5lvHW5ktuXmvghNPfik97Z86EvCC7VTj9Y/OxhOBwbMcmB9ktyEO2YarmH6cAf2znYF80IKTSWmw5Xqd8GUhJKZMDfBojCOVuk98bHLyAZI+DoRSQc2brPbq7/PFFVjrjVS0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(66899018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hCi/0hbdNCHEr8j84kECsuHQmMVNC3+ZCaOQQSic4pU85qH1YM1Xb/bEroxW?=
 =?us-ascii?Q?Fz9g9Finu1oXJPpbvqX99lZLigzFd/RS9ebRyQc5/MAcXS7Wq7ER1ZK21i8M?=
 =?us-ascii?Q?Y7N/Ukqas3+52vSDSA3g26FhMfiqPSRAp5Qyd8eGJmK0w6Tu/2MqSf28HPAo?=
 =?us-ascii?Q?2drGpYXwueI+ViIKaxIYZSi+bTL534CJLMOnx1m4dm8MUPOjqCHXoegHDC9V?=
 =?us-ascii?Q?rnph0eksEeD0H04BA3xCnS8cXv/uesZG+XVrfMzyVU3pCHtLwePHVO4pJGfQ?=
 =?us-ascii?Q?IhN1e+b8waD5lwOPZ9HX6CDJ8fdcc784XQnEfkdw4pn4sYOwA4yzfG2JGZsx?=
 =?us-ascii?Q?+deUdXwqUD057Vpm306t8skahG0Fi9QhKkQlF8Uqdsel6W/v49Lfg5QGvPP8?=
 =?us-ascii?Q?aS5j7aBFkViEKHHQMunx6fmeYqU09W2r16lTRb/A+R8NhhLUmxLW+xKf1XlX?=
 =?us-ascii?Q?cGplMrN8SNxDAEVLkWI7U0ekpctPOtutL1bCroau8ikG5eW7QR8SqEXTjqcc?=
 =?us-ascii?Q?UBxlWf6Pfc1E98fhA/n6yDqr5hRykJJLJgaDfcTiOD6/wZvG8BnotqLXYEej?=
 =?us-ascii?Q?F8YtKXF6JNlqa0f6/+S/v6bHStR6XRJtxTDh89pfxcy4Ffy6OQo1XJblLanv?=
 =?us-ascii?Q?k2TfEL+vOFTIdF4YTMUoCdxjbvMBp3ysnAU1TyPFblppm7Zla+/xHvfgocsv?=
 =?us-ascii?Q?QBIT6yx7eoe8V7qZeUPQQf/OkYya/+iJTTpnqFsmg2A2VkY7/S/3yd3TsqKI?=
 =?us-ascii?Q?Hq2NgB6UsHESj4fGIDvqaR6DQ3laFcZlQyHbpbcCP87P546vO1H0h3RMn4T8?=
 =?us-ascii?Q?FpZCR9+7Pd1yRJh3g7ULgLpOFrdb56iGOVuuCSJYGw3hlHCDKf4eNH8Ang05?=
 =?us-ascii?Q?35GU5G8K562aBNrnn3lFtFyyaebeN+7To2unvX8cb89HdMuLZ/eAc4SAF2ZV?=
 =?us-ascii?Q?F6sPrHdbSMGsgxu7jAjUzGFjPMhK2vmPgLF/1Fagu4w70cvrSLoyrcHJf3VO?=
 =?us-ascii?Q?qcxQBhs9AyCpp2VnueUaSKpsTfr65tEESdL0UAF4LstND/yY8sPUW+ebUYL0?=
 =?us-ascii?Q?Y/vfHe7BoaAi3bec9UWmaBUylR7V+e/vewQb9n8VCMYoWIzo0iWyTu0OWDid?=
 =?us-ascii?Q?qX4xJ4eOI6tHa9Yyp3glenY4DJYUvCrZ/Yn6EQALcx9qiYleRSOyYD1Vevrs?=
 =?us-ascii?Q?hB0U4rqeIMXlB7ISbnSJm4v1YIStw8B6Ri9XKn65uv5byk2uPkZlIuKMP+yY?=
 =?us-ascii?Q?+XPvGqONpg9tU9XhPQiq4DisV8RgkpoSbYZz15N3+qyajojZJJhA92v9ef/h?=
 =?us-ascii?Q?UmMWGGuPidFvWVuY1rqJ2NvEuZdjxNdWL0CPAqMnWzqbsV10p3jCk0T+fY8M?=
 =?us-ascii?Q?cuu7lVH3KzSNV+qKZ42yGhWE1LBjeU6J/OSbjpaE28MzSKRG7C2cwGYM0HRu?=
 =?us-ascii?Q?El1MaVyBHsGJZ7b19Ff71PA3GIVpsZTrqiYCQDRmKq2Wi6qUj2YN29y+3fx+?=
 =?us-ascii?Q?JVV1QV3jzYe1ShASaecDIWOS4s+yNIYlpnw9DMo9WqTZbcW/WFxOMasyq8m1?=
 =?us-ascii?Q?TFuZFTMalp/VPk9u5fzmXyCxdBTjyofdgU73Q72g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d134498-8934-4bb8-07c9-08db1f6d169b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:59.6868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNs6fz+QEo+stRwUfXERHt7vmRld3KDLFW2x0qgmp+Fi1MrZN40W8kjLCp0c2Dwi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 17cb7b95eb2757..866d77247a07fc 100644
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
@@ -939,6 +975,9 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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
2.39.2

