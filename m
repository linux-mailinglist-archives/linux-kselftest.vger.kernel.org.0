Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5CD702F02
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbjEOOAp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238730AbjEOOAo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BB6E77;
        Mon, 15 May 2023 07:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efgvhQDn23MTDq4vAJ4dgRaqsnPi9R4h2JSa2AU0MxOqIzpRL9ee5TWZjdyKtrCIcB8NzYclORuef6aF3Xq4zOiYJ4LAy7f+VsDwytbYyMyxZ3Vm3SqzoYrXQds7NgmZANH41nI3Kcjk5msGBqrk+XguhIk1thvAttggsVryNATX7r9QBRH4SZb5Xy5TEM1eF8qFkaFx8Bjigb1VxuAUZ0b2ElMRyl3xNUJ8EZiZEBEl2H2najl4Xh3TbG6Xf6Z35AwsCVvOVzYNgm2QxlEah37PKjPjdhSH2CNG/d42PloYCnokRZGKZ3tQ2w0ieyV6VSo/GUcIFoKUgbOampmavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZyR0U/o6oO6MxraN+X1E6cX68S0UTh5ZjW3DLdbl/k=;
 b=QxH1SXpDUpeWi7VbBBj/qws60u5Yg8GE9vcZ5esvSEQFnrV0kuwzmsi+/uUBoZBRpkdwwzN55J4siK8bvecTP8tw1K/dWZrxuPJZ5siTMWPdyWOq8kXWiG6PK5F+M1CDnY7JhSBnSP3QTFFas3jCVUAMrHNbWmX6FgYh7RBLRokakqEhI6Dzt88epeTc97gtOJrCWctk2YJkF571eex1+cAh5YzYmnPafeZ3vC2V0jn0aK7FJNjtCTRBmKKn8Vvsk8bimEjdEkQQKKu7m6ZjqE8O+HY6M6yUcHvo1d1qjC//X7FabFsThIYIGEIKPJmTXriEkIMP2RJ6pzT/sMMQ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZyR0U/o6oO6MxraN+X1E6cX68S0UTh5ZjW3DLdbl/k=;
 b=Yph+1Gj4YwKQEynCf0HYcw/JHOPScevxvhRS/quI7XvY9rj9iam7I07+WuBFZ5RFzlkKdBfkpQRwMCsXbJFCQDyVl7EIzsofA8TXifxfuxL9Usx6p8MEB1UbjexxKk6Bi0BfiJFIfaTTJL+YpNt8ZgkwQCY9g57B5Exnn/6JpUoMr167nODnKpmHrls4kXRT6mZmBiTc2jNHH1wh52RcbylPr76Cbi4oIHS/yfKag62mkU2glUxh5XaABE1wpEvcnxAr+nPKSsUWaAztH9p45J+M844gAoqbjeD12Rp8C4qiYZi3/+xDl2FWS41gchxIN+WNnJDq9gyR6mv/DIYg1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:38 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 16/19] iommufd/selftest: Test iommufd_device_replace()
Date:   Mon, 15 May 2023 11:00:31 -0300
Message-Id: <16-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:208:120::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 719cf40e-4396-48b8-9265-08db554cc15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTSj316yEGi8niJLhW64B7qwZ2oiMTzWPJKonKoBNX/i+DzuWl+CveOoky7k0fFY8Ronomc10XIaWn4gvdThbNJPRngDOLCxMmeoLGn2K1BOfsbl69+zoR37+MctxXfPhlRSwGx+yGWmbeTowFhQVLvbQAaB45YgKRY9eNVqcP9V8HxF9fTZGjDoAcPU40MQdGnejLBcIGjj8KpKqTBcoENCVsJLh1jm4ebSV1FL/NhjkxtoJmlkwkR4kG6n2ECyE6a0LTgi6jusacIH8k8UodrRVaHiELEwR0GJPU0sEv2v2phEv/DjiAJrVT5PuSfpfL+fWN+U+QKz/iNU2uG0xfT78zNLCMGXdMTttnEbfVt64Cflm3/tFQu8D+WnvPNnuq3Dn+bhFUWqQgRjfzGvVTtuuR811d5Jxdii2EOhkZ+pLl1yDy2nGk3U8bF3/r9dMVuHWYsrQbYaYvDrTvfUKVNx3pk2HpkAcmWSS5P82D3908P5C2RWs8HLlY6TksnJ6PZDsSgJqaKPdU6oFFmZ8q0Dr7ZsSdYlD9OAgApCC48VcgQuCzvoHleip+pkNScO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CgMpldzb8BM2iX0qd1/Vcl94daU+RMMasMsRtigqkEKtAkiCRf7EXoXsVk+r?=
 =?us-ascii?Q?g59tnUdsiIajDS5c9K4BROtXbNwpS+iowPfwwfSjjA7GS/AksHbE2zFuM06+?=
 =?us-ascii?Q?vfmmEd9kOrt5hzu51Jlz3B/68js6tuuFkYW3MQn/rqOKB2IiJWPC7+2Zqua9?=
 =?us-ascii?Q?kxXuwenkSYg+scqJE2Ppobax5xY0rX006GfWvba2cQJwvrs6FJHbOd/UM/3V?=
 =?us-ascii?Q?KzrveNBMCIPGogGuSfc6VlSk+EBpJFeXfQdp5heAnRV9QoV/ZtEWPDoVzYQV?=
 =?us-ascii?Q?rgeq1F8stWSA/WXu+BmyEcenTOn6XSvsf7n7vENKSCIH8l8/Au0V7bm1pcEo?=
 =?us-ascii?Q?4oyGCiHYE7q33pIy329Eh1tVSTDa14RirJqTk3kUQVa+9DS9hOl7+I+eDWrI?=
 =?us-ascii?Q?j3hsYXGbmXYNkvc71OMpV05qA5+rsQl/ekS1m12ES8zoRPYZ0E7HWf0O6KnK?=
 =?us-ascii?Q?GJ3uaY+tkxxIELSLmgHzbJp4ijbvbyJfXx31zAgbRyaprCOoPFUA7L2QzyoA?=
 =?us-ascii?Q?rgWN8pY0/sY1cQQsT1/zKNfUYVL7jXOg8v1AGVGZcuX4JzhegpJ1VGw1Zsl+?=
 =?us-ascii?Q?ms2ZkPx/8IkxzwX3tqvySZVSPyV8lgeCnyjMmAaNy+f6V0I8QB+L/aoW1fdw?=
 =?us-ascii?Q?6DVuaDyLwhKh3Vw+T1/x4QogIxHltCu+bErNlr2nLgao1mdwn1SyHrrFLYHV?=
 =?us-ascii?Q?QrhCBH2N9HdYvQt69buRIMDEpDNHD4vLBDP1k9thPyM/4TX3KGCwLlG6e8DR?=
 =?us-ascii?Q?/q7kaurjsl4bjf2e/pV1PZmgUnVGSfVmAW5kTl8glhEQUTIpP/Jbl0dbckQM?=
 =?us-ascii?Q?pyFSZobFkAOneFr3aYnN1J6idcpGnurSQIwP5gGx+q/Ar8vYMygg4PGAF7XS?=
 =?us-ascii?Q?BMRY0wQRs5ItL/7DNBJQD+GsL7tNYSSRiEFRMT/6erPwQn/2/36ayD3mXg3o?=
 =?us-ascii?Q?fN7n5Ev+nMJIbr7qbF4EqBw5H/a8QWY8IfnoScWzqmc9MzTsus38ZWvgJoRf?=
 =?us-ascii?Q?iAuPwtuBGnQ3ol1KpafidsZeK5YqlnU0UMbUJ6EaXqVt2SP/K2C6iRHZnSOs?=
 =?us-ascii?Q?crLDhPBffq0T/SnP70rlnx9HL47RqimIogIaiq4f8KSgqB3fPNN/70fMe3U4?=
 =?us-ascii?Q?1yWJdmkuqXBVHqFQZo1cDT11RWziHMUyfMrwnshojbU9XJW9FTIhBtCxOCml?=
 =?us-ascii?Q?FhReL+Qdsm7ba/Egih6gUWLAdRc18kvg5XgawuXi19oWJ3Re9HBdu9BeV2jK?=
 =?us-ascii?Q?38NZbWuFfors29nhwsj0ip4dMmmx0OVFSzYkwKOCI7LgbA0QjsHnUde/laoW?=
 =?us-ascii?Q?uyXzS4vhy7yBGE0eZdsKTTVxWGAPv+TRGdCWvdMqBmF8vBpYgNU9Jv2/RNZq?=
 =?us-ascii?Q?7eTeYITjIUOFcyVi8LLjd5DolgeGTRFLNfRTzxnpHIQYVKm6di2YiVcmiB2q?=
 =?us-ascii?Q?5O3XmYi/L8A4vfNJiNweQIPVtOoCEErtKwEhPmong/n6EdSIequ6U9yPbOtt?=
 =?us-ascii?Q?XQ4/5kQzF8QAR3ICd4pE/aKW6zmIKdU6MC/Bcsh1pUpeGtACh9m6GTsQAWG6?=
 =?us-ascii?Q?aH7h+6pNISVp0E3RGcM5g8RDa05zGV5mp2PSP+c9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719cf40e-4396-48b8-9265-08db554cc15b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:35.4547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Cjr14/mCXzH/2QDByYvPhB2f1dLL78+czjLR/vFrNCMjtNBwd/FkZtObPMIJAGh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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
index 74c2076105d486..eb33dffb955dcf 100644
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
@@ -948,6 +984,9 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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
index 1129a36a74c442..5e417868f575b9 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -22,6 +22,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 void iommufd_device_unbind(struct iommufd_device *idev);
 
 int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id);
+int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id);
 void iommufd_device_detach(struct iommufd_device *idev);
 
 struct iommufd_access_ops {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index e4a6b33cfde48f..96881ecca5c757 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -9,9 +9,6 @@
 
 #include "iommufd_utils.h"
 
-static void *buffer;
-
-static unsigned long PAGE_SIZE;
 static unsigned long HUGEPAGE_SIZE;
 
 #define MOCK_PAGE_SIZE (PAGE_SIZE / 2)
@@ -1035,6 +1032,7 @@ FIXTURE(iommufd_mock_domain)
 	uint32_t ioas_id;
 	uint32_t hwpt_id;
 	uint32_t hwpt_ids[2];
+	uint32_t stdev_ids[2];
 	int mmap_flags;
 	size_t mmap_buf_size;
 };
@@ -1056,7 +1054,8 @@ FIXTURE_SETUP(iommufd_mock_domain)
 	ASSERT_GE(ARRAY_SIZE(self->hwpt_ids), variant->mock_domains);
 
 	for (i = 0; i != variant->mock_domains; i++)
-		test_cmd_mock_domain(self->ioas_id, NULL, &self->hwpt_ids[i]);
+		test_cmd_mock_domain(self->ioas_id, &self->stdev_ids[i],
+				     &self->hwpt_ids[i]);
 	self->hwpt_id = self->hwpt_ids[0];
 
 	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
@@ -1308,6 +1307,36 @@ TEST_F(iommufd_mock_domain, user_copy)
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
2.40.1

