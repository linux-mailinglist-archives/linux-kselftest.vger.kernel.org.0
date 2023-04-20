Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C0D6E9C0E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjDTSw1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjDTSv7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:51:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321AA3C2D;
        Thu, 20 Apr 2023 11:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuJWuzcvHe8/E9DtBthWWptQWuCqy6v5aQ6IBchQZ+buOPH4czVyvUIzyT4BOhGGJhReXrgxq+27oi4AlJlIn1ouT7dB+D4A1tzAgSOYppHQW33kgzvKCnJdB9E0PTn3/7/qzxJMvoW3ymc2/BMDjmxjnHLgCB0YUJngGi6zFfLYPuAoOtDpmW7FcleSXMfD8t+BB14vmYGVnPtw7eSvlXnvA7eksDS+V1X8rBnFsszeu6OfY4YQQoiY6Du/1bRk19NkX2N247/vF119uYEfPMZndrmovtgE154M3X2dyfFxI3TDBvQsB77pbU7rhWtFwLBu8UhuS+UD2C5+TRHKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ghKHbRE07T4XrpixzlOMsV4FCPz3qkBGoHREdGoGiI=;
 b=G5korABzuLiIshOplo2j/8M40/qDR6uNE/nsgd3ZnSucITNE3vAW4oVlcaCGTTg47DAnu6m11B80wwaLyLIU9kRFznbOLBZxM8SXCi2wkgjeSNLlcxt7dKd8s5gar7DaetR1ozh4Sp0ixAqM1NsEaBHs/cIZBRYF9eAu5ef8sFvI4sKor4kh4Uj2z07N3QR5gOF7/i2BcPyBIKgQcqDj8A/grdxcOyxTzz4bCtyrfJUszGqRFQV6/c9jUsD+ZchemzJTCsmtVCkDcFqzQzCgNhqiu5KYYBhiXrja4j1cyM8KhmY3lrlqaMq4LHdMA9a8Acd/UoYlhJWOp8PjH466Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ghKHbRE07T4XrpixzlOMsV4FCPz3qkBGoHREdGoGiI=;
 b=k6VJeqH2f1g5YNCfZOiQGdlnCI9BvZZkgWRrvEYHD+iaAwFvzBzegvWoVz7Nprsp5jtjDUCbmSaxGvKtXljRl/47ywvwdKuTWFd3KCdUHLS30fb9grySPG8Oc0U+Vh+yk1WSljKb5LUnp+tG9HlViPlLCTGW+lcfn1mpcrLvMAC+diCRBZb7AOjQrrccyJwLZOSHJj2Jovy88EYTgley38TuMC3/fbnO7PAfB5aZ8MCXqP4OfC/uLAJ76bwd8KF2axx1obIY1SLgEkvNf3unS4BMYIKEpBMrVy73Qt31tJN/JD9sqQRUQ4Qk+3EksV41pT5doNGkyMjaMCngucgAMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:47 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 16/19] iommufd/selftest: Test iommufd_device_replace()
Date:   Thu, 20 Apr 2023 15:51:31 -0300
Message-Id: <16-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:2d::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf3cbda-16d7-4f90-3447-08db41d0462b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFFijJLxIPetan91cBl7au8tj8dyfFjirjuL+/XkhOyrZqKlmVyWHKdBXauw0rgEinPE8/gmtrQQEKdvXSSLzusmVca6FYugGmgFA/Eg5cp38hUeRLAOOL54j70HcuYssPeO7nUw5e3i1UNaci2wqEL816potbvdDlMGA8H9whV0GXNDvnbx3LGLcOCUWOkkO+bKOFI0zkk0c2t5plz0tdrQ+xF5s9Ydt96qWnQRVyo0ViU4ukrjtpCfbRFTcjrX7U5Dz6dmo+1wZP/1UBjVxlZ/oKEZdxfNmFPMgkN2lPF37WnZIA3GIB/m2qo55BtIuLx9F65xIpupwg5NdY7Ej+1IbqRSOa/hVXEUJneZV4a45NC8t5V7mBl7SqmDYxbpedVC06DcIlRMHlB7FY9khznWLdRN+VehUl+0nbfdknq1zMeKEto3wi7zfj77yVcrUQFx7947CxKwnbxBG9DI38GPu1WA3c2SzdVqbXgCF84Mv2IDcWnJ6faWS+Z5vSk6MUh6bjMeWxAEx6WYR53OHIuT1PKBBLDvhfrMT0t2QE7Fa1FykVp6wvS/MuaERVaM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MuCJhKK8EhNjsQvBGXlwHsNZi/chZaeipFQ7XiqeII4K4NjTX+c0HOcfDjTv?=
 =?us-ascii?Q?jN3tZh0zB+eEINyv9GB975Zc/UDzrtY6kkHemaPAIQLO33jBqC1/Z/fTAfJw?=
 =?us-ascii?Q?ummZjhnPT5dwqaeijQQto5kU9734AlCjAdC2He8PthacdtAFUyysJVV+0KWW?=
 =?us-ascii?Q?tylD7DOHU47nbSfOsCJiM4dK8TvS9IBqeo2w3Zl5JIeRDctWxfPSJGAUr7sY?=
 =?us-ascii?Q?NnGhpjOYh9FtYmCotz5GgTmnGn7qJxA5NBZYovEwIxeM4cXl6Eilv5Tg+sw/?=
 =?us-ascii?Q?f2p+P/SHG7TeMGXyWgVNsOV467qOnFSbjlb+FxLmcR+7BB5JK+s8ftlJu6m1?=
 =?us-ascii?Q?9q2Q/VkP18pnh72hsTJJ4wSY1nuhTkLEkgLZMyh9l8sLwpyM0e9k5bpw9uVn?=
 =?us-ascii?Q?yjvvldzmpSselAXVlATIZ8UzcbK3sPz/U7K3WYOKP+6eetyKH7V0rq8buPW2?=
 =?us-ascii?Q?TnSr4VbTsfoFUVQWAxjjnCQHceVfe7P9E3qCEkioMf0RdfT+4jYfM1pyNDgW?=
 =?us-ascii?Q?N+e8Z4ptOut2WKErM80O1Nkj/1iE2Vm0DMMfmNke/T3f4QlLLLOp4SnUN5Gk?=
 =?us-ascii?Q?vaS/F7B3pK7V6jxi1kr2J6XMsqTtpyQAtmkD7m5UrFTqvHjjURjEQ4PEwnd4?=
 =?us-ascii?Q?jKfjq+bQ7M1TELEnbXPvR5HRBG/lJN/hncGslY2PFjEBMd2CJlC2+lAXIapF?=
 =?us-ascii?Q?UIGZfKVR99Iv/GYYX4+clVioHyDe612qlUvhi4bPMuc2+DhlbSu88YlW6FDr?=
 =?us-ascii?Q?aD5P4N/Bor6MKTs8V+OxjKKr3vXuK7Mz8MFXLtWbDsEr2kgI3qSxF7g1c0YH?=
 =?us-ascii?Q?BsSzhUPksQyImE20jNlem1RFpjzyBbTRk1F9qCsca0Y1XlDcl9vOawFF1K77?=
 =?us-ascii?Q?ur4mQAcjXDOxOyG1yXjG5b30LBMDzMsDUvmcaWW1BJh33+fHNMU7s15v6YdG?=
 =?us-ascii?Q?w9HtUgyoqrfY1JuVE60nAwkUP5aFGZq2VMwSKSQ8BoxAMCd1jA1LgOZSWo06?=
 =?us-ascii?Q?G9vOg9+HgQqyXym3wSWNkC7n4fEHt/Po6bLbJhtNXzayOvKd9qNPDIxAQ3tY?=
 =?us-ascii?Q?EZhyzWgHIz20XHGk5VrC55s2IzHAebOKGcZrNtab6jd81SJArfZzoqtbTiU5?=
 =?us-ascii?Q?iiivRtGe+Q+rbjQRS9Sz4zW+hTq3pmuITumMPIO41T6rQWbAsZaLayBbVmtF?=
 =?us-ascii?Q?PylvhCn2wGqOgxh8XqArwuRZJYdGrJpO2h0Qy5t98NI2Doj0cl9pLPOcId5n?=
 =?us-ascii?Q?XZjRpGSM0gcRvT3bSVoUCmqGfaNo1+lKToK3c66AMoSGAASYHeCZoXzcIdmr?=
 =?us-ascii?Q?mbHeiHalgNg7EnC5I1y2RB+EUfqKeQ71/RitiUcRF1HQssTNhJJV3/TJRhww?=
 =?us-ascii?Q?ZqTZyWQO6uI7qoYw3cJnmACSldEfnrhzdvnyXwt7Wnr6JNcjOTkSdCpRjCDt?=
 =?us-ascii?Q?v3UAciUPbBgM/wNdpY9+EAarPjba+y6Wq9um8O+jJClFso18gxroNs5teQa6?=
 =?us-ascii?Q?PTaI2s1uSkBw92m4DKoev/ig+mWE4W/Q+4Fhz6dno+pT5vDocAvgXNXk5Iw9?=
 =?us-ascii?Q?MCBHjaTA35tsB86HkjFa+2ljUhtR2f9KLVQqWxj9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf3cbda-16d7-4f90-3447-08db41d0462b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:39.1223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G78Q0wxEg6Ya72+Zd+Qisx9DOuJjQo03JVR/C7B4RYQ/HZBxCHjqYulRoccMkfQf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

Allow the selftest to call the function on the mock idev, add some tests
to exercise it.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  4 ++
 drivers/iommu/iommufd/selftest.c              | 39 +++++++++++++++++
 include/linux/iommufd.h                       |  1 +
 tools/testing/selftests/iommu/iommufd.c       | 37 ++++++++++++++--
 .../selftests/iommu/iommufd_fail_nth.c        | 42 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 30 +++++++++++++
 6 files changed, 149 insertions(+), 4 deletions(-)

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
index da0443ba16830f..57559f60ca6486 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -9,9 +9,6 @@
 
 #include "iommufd_utils.h"
 
-static void *buffer;
-
-static unsigned long PAGE_SIZE;
 static unsigned long HUGEPAGE_SIZE;
 
 #define MOCK_PAGE_SIZE (PAGE_SIZE / 2)
@@ -1001,6 +998,7 @@ FIXTURE(iommufd_mock_domain)
 	uint32_t ioas_id;
 	uint32_t hwpt_id;
 	uint32_t hwpt_ids[2];
+	uint32_t stdev_ids[2];
 	int mmap_flags;
 	size_t mmap_buf_size;
 };
@@ -1022,7 +1020,8 @@ FIXTURE_SETUP(iommufd_mock_domain)
 	ASSERT_GE(ARRAY_SIZE(self->hwpt_ids), variant->mock_domains);
 
 	for (i = 0; i != variant->mock_domains; i++)
-		test_cmd_mock_domain(self->ioas_id, NULL, &self->hwpt_ids[i]);
+		test_cmd_mock_domain(self->ioas_id, &self->stdev_ids[i],
+				     &self->hwpt_ids[i]);
 	self->hwpt_id = self->hwpt_ids[0];
 
 	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
@@ -1274,6 +1273,36 @@ TEST_F(iommufd_mock_domain, user_copy)
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
index d9afcb23810e1a..96fb2f04623f23 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -41,6 +41,8 @@ static int writeat(int dfd, const char *fn, const char *val)
 
 static __attribute__((constructor)) void setup_buffer(void)
 {
+	PAGE_SIZE = sysconf(_SC_PAGE_SIZE);
+
 	BUFFER_SIZE = 2*1024*1024;
 
 	buffer = mmap(0, BUFFER_SIZE, PROT_READ | PROT_WRITE,
@@ -569,4 +571,44 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 	return 0;
 }
 
+/* device.c */
+TEST_FAIL_NTH(basic_fail_nth, device)
+{
+	uint32_t ioas_id;
+	uint32_t ioas_id2;
+	uint32_t stdev_id;
+	__u64 iova;
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
+	iova = MOCK_APERTURE_START;
+	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, PAGE_SIZE, &iova,
+				 IOMMU_IOAS_MAP_FIXED_IOVA |
+					 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
+		return -1;
+	if (_test_ioctl_ioas_map(self->fd, ioas_id2, buffer, PAGE_SIZE, &iova,
+				 IOMMU_IOAS_MAP_FIXED_IOVA |
+					 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
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
index 85d6662ef8e867..8b11bb70095269 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -19,6 +19,8 @@
 static void *buffer;
 static unsigned long BUFFER_SIZE;
 
+static unsigned long PAGE_SIZE;
+
 /*
  * Have the kernel check the refcount on pages. I don't know why a freshly
  * mmap'd anon non-compound page starts out with a ref of 3
@@ -66,6 +68,34 @@ static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
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

