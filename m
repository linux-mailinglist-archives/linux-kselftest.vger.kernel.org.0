Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC546DE144
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDKQnz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjDKQnx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:43:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E321755AF;
        Tue, 11 Apr 2023 09:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyWn910rMBJgIeOmajDZRt5Ho2+urQJQMQKNYeNmoNrxRymrMK4VM1OEOdir4wfkGSMB1Og1dcths3e54r/fdpeb6jf9VaZKXQ3Me/mmziRCdt0NGXK5qnp2rWoozpvU6cULd0K26Ko/dsZgG8Ik1ug5uXYio8NV2r33jwJGD4sNfzloz9Cq9jS4tnu1UOrmVaASHHbwjggECHPyv0c9Z/M68FL+2joxKVFXlM65SQEuaEdpvsRJDmgTV9nv2oGWJf8R4hPhKJlHjZyL78QvJlL5gzzVF7V0Kap7aEc+Ks19F7WAeWFNbiRz1UQoKoz/pl62DTrtx6tzdoDSOUuj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ghKHbRE07T4XrpixzlOMsV4FCPz3qkBGoHREdGoGiI=;
 b=aOsrVNraIle5kudgChtOG7c9WH061sIpzi7U+pPjY2B4aBbC/b1I5SGg14uB63UtGe6WWKXNOLuLqyk7BlknWUy0++b2GCfEn71fZePU6LaT5qhamAdqcRBUE81QvEMneg3J4JeVNNqi6BnQ7luyYBmvq7oiuvWXfL63SE5jRBbBs+PhD8iD3f77VOPXmHhAKpLlI/mbZN0Rd/tTQGdnMtQBTqe5jCKON6hUSUkKv924yBxJTfe2pByOQz1Baa08CkJcuu36Ahe5LAkfIv+FAXnXOTYkH4Jb3/ZMHi6dA9IZgGO4bqrtjD+qLazTjzbYcMFZnj080m0GAc0ORrQjiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ghKHbRE07T4XrpixzlOMsV4FCPz3qkBGoHREdGoGiI=;
 b=O7JcwHZxlxdAGrZZ9bd6Imj6ovZHRLH5ijcbt3SgJqAHoXet/+yfvIL2FJvXmiKKmYYmxFv999IeTSWUmdHCp9IAWvi0NGikUj13IctGWXccxphbQtQDXOz/OmFvpk9i33B7vUK1n6WZxxsDiYBfQsQ1ElwvY3XaHC7oOa04vwWa/vgNhmK790FbeoxX0VLi+UyCCKodsDO+kTuPZUVJcXK1GTfVL7FXodm5cXdAGuH2Pk4MvQBKLQ7EHfvgJa+v6+BDNAzCOxjI9YvGuHzzrMeqi8KP2II21BBE2DIG9puSQqnxaGqpSmtidOELhw5HccgquRDlV2l3TGqN92hXOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 16:43:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:27 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 14/17] iommufd/selftest: Test iommufd_device_replace()
Date:   Tue, 11 Apr 2023 13:43:15 -0300
Message-Id: <14-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0066.prod.exchangelabs.com (2603:10b6:a03:94::43)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: c237a09a-2974-4430-bea5-08db3aabe00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVEgeHe7PW34tbAP/YzvwZW+b4ukSfYYNYVpYEOwUgDKpHL+XNZM+rXkJEHGcSkVKBzxWFK4/nW+VpVHymA0+K91vMugDEH9W2mqg1iAzx49rsYzLPb+r40fo7z01U1rS2DvVrPVqcKmoYyteAp8VHMCC/3+DFbRQtL17u5Omt5eYg0dpOyfYYCr+LSxIZJUjTzn26dL/JyVJ5GWeNU516bsTbSngHNjaxTORLP4E9HEsdije0Hfq6OLEgB5BmNWMDanX0GbF6lyPmLX15hva8/Ux5xW0WUwTfJeNt6SWeq583Bwf/x1XvdqCh7TtEdC2fAj1WD8qoYgO3VRy3OBkVYfXDHiEr9JdlmXR9WXp8RPbsRL5ahnVgIjuw8PLo8xR9U1ZHBOoUpNgZFbucPeCE7ivM9S20g127BizGmFzow7qufowUfx98bQ6YSsgyN089rBnJP4vLDYpsvv4TDpMw41yV7kGwZWxb2S42iDk4d3rKTf+zm8cwprUegRPSuff8V6dg03QdgiRUE79TRO6u1Qus6fVBsKHhtv6y1FibdKHAMzEqCiRSTqEw3Fa/Eh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199021)(478600001)(26005)(316002)(6506007)(186003)(54906003)(2906002)(5660300002)(4326008)(66946007)(8676002)(6666004)(66476007)(6486002)(41300700001)(8936002)(66556008)(83380400001)(86362001)(36756003)(6512007)(2616005)(38100700002)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AAG3qhVBDIYNFp5YMQNiKXiv1OT+LO3hLVldwXXctBIBAh3DMeZflW4yX1sx?=
 =?us-ascii?Q?XFdGA70gogR8Bje/cCou5KKNh/1de7LouAVWCWc36U9bw8BO8sdinviecIQk?=
 =?us-ascii?Q?ZwfwdpfTVvrj0Dl2c39dIw+eF9XlLrtLChJE2lidPFamLuRFqHY+o7TXFAR0?=
 =?us-ascii?Q?FXmhPv/Q0+hm22CsvoGPoqManZIxR9wt6M3U5LGAM48l+gCZG3tgHs3EbRI+?=
 =?us-ascii?Q?N9YCFqgGfZSAGum4m8MbZzEHJyJYEwpUNS5TxFcZw/A3UTWNp62JIQVLIkfK?=
 =?us-ascii?Q?Mt8GtwLC6FRmJr6kVN8FcruZU4gIcSxgYOqbvGQyWfG+SjPXK2a1S4a5Yx3G?=
 =?us-ascii?Q?tG/nHahtueROeFFAayxAZYXROxlxeOkyifSyqx+hfQfEIZXpyJzwxhj1LnKA?=
 =?us-ascii?Q?ricWDt7tj5aVXZq99ZjqwQU5d5ZbUDBNS6kGVu+NbHfcU1hklTb8K3KCay6t?=
 =?us-ascii?Q?OMozQPQrqKWfeu4xXDgqlncTZy77utPOeSkSwmGutBUW0klftveuusnDy+Eu?=
 =?us-ascii?Q?dQG7xD1SZ8mOWH5l+8dimiuTUuvaxuH7SG84+/LoTtHZAqe0YujbmAOoVh6h?=
 =?us-ascii?Q?f2AMP0wB1Zf8RY8IA+1h8ECuNpqIBI7WduE7feMDQIiOJMr2uu3hml9Hwp2t?=
 =?us-ascii?Q?95rguQhHsQWeIWbQMJH3jFPpjFjeCvbN1Escsgtdj9RAfPBjUjyPoMDHrQP+?=
 =?us-ascii?Q?W+C1a5qANvgCZNuObfXnfFTPptx4rdMQGPwIT79Zox9HyXRnr54nxlgjvi/H?=
 =?us-ascii?Q?1ZQPmocg/cQPKdwzBpDT19sB5gTS9WhzZWTHVr3o9wLCToNeT29W1k5Y5Uss?=
 =?us-ascii?Q?BL2Furq7wK701Wpwi5itP2hKcAU1KLGvZwhEhekQJqMSd3XGrQI0ne6YQYYV?=
 =?us-ascii?Q?bn557jHlsYz/4F5a5VibWwhQTMiZaetjhYMB3toY8k29epxxwv2e4FYp/3r+?=
 =?us-ascii?Q?FENu1tFaXLzYyI7moIPto4pGJePzL/HoJC0EkK4aeiYnXOkhEG+87lLoTeOz?=
 =?us-ascii?Q?a7yloxH2cjw40WzLatmpaUcE0KIyQfIwqRZk+QOOc4REkzAeQCK4rqNAby0v?=
 =?us-ascii?Q?EqrcMjST1d0jt708ayedtNrnRjH59mVUhQJ5DO+CYGaQ3nBaJGxbVWtl6MOo?=
 =?us-ascii?Q?/ufkcqZFAjbXGbXQUTdsrXuXGwfr6Ln91BCFUQSsgNjYGY6wpeRZuYeGV7NX?=
 =?us-ascii?Q?i/0Y2X4FX+LsUJF8FMGIUwOV7Xc2P0CtzyvfblcvHQIPYXLUBa/vskYuSKNS?=
 =?us-ascii?Q?7eDwgGNn14XhYu7YKjkprUeuMtIe+Z/+CjZP1raMU2E7tbvs0WCS0lKM0Gqv?=
 =?us-ascii?Q?DuCwSTBLdZPtZSAMbwYgOjSjdhn5Fiwz1xlSAdTwrzjVZw8sX4EYizhHIs2S?=
 =?us-ascii?Q?OxtUC0/MfyGHVa4TWP9zy3xyW6sGqhTmb/4axlK0bHvirUqlqvONYt+zvMau?=
 =?us-ascii?Q?AKXovxB6c6S2RfBpdRsQY9GGz5iJjXTRTaxt6d/CM1aKb4bSLtkwqufaURFB?=
 =?us-ascii?Q?W8KSM+1zO42BdDaW8+oWvfmshEac6AtyCU73W4uVCyUj6HqvyibtAZQFzauE?=
 =?us-ascii?Q?bZN/Lu4uCjJsSa1k4fXdD4pE0tbnAnA06YMQNIma?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c237a09a-2974-4430-bea5-08db3aabe00b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:27.9479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5/L1VEH57mv2M1kFfeHpupHEGhCwAe9ogGUcy1OzXRWT9V8yfkuwcFAdnStLmf9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

