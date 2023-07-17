Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252C8756B8B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjGQSOO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjGQSOL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:14:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC5E10E4;
        Mon, 17 Jul 2023 11:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9+7h8fBjBrrYrngckXp2NVLRcf0z6zSdpO0ky4oPx6L4ME+5gu1ED4HXZLPkEULWUtn+tfoq1/9fwbMtiGBE+DBWKIg/s1VzHExKSdr6kQ6ifT63cp0WKuWAFhU3h62IQVpT022J8z9WR+iXtdlwIUtbBcOFH0ibsrpFKM/nXtAW66wLZlF4ZGzXherqoGXzNf4jQgfkG/pscjKFV5OvnuqvCywi4ErZNTTvyPs4y755QdI7+T329G6bPCGikBwlpcbPvbJWsW7Uf6nq5HOKY+cljlTnuiO4EIxs2I5QHwtm1gB3aakWhcCBom7Pt1sEfgd8qOUU7rTjebLqjqejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoYtnkB0/YwcnPwmpggUl/i84RgyHrIPUcu/dBnZwUc=;
 b=Lq5WZdaoVsv6SskCApIDf7QB6xNrmovcb1r54KLAy4Nax0W59RUW3uXee9AWuMnmTInYc0Fw+wunkagnKjPb1Rapxd+/Ra3VmMHdSUbfh53LKTZMsN34HMmVkZn4hepuu0JERITPyj5YitYkQwy5epYkIwZaVvMxpT+jOH8u3NO+k59xA9TRfEI5+wGPobr9SlHicwat0R9b/H2r5sCSpK1sEunuoe5+C1+HbcCjVSJwIOn7JvouZoS5NEgS0bGa7YPk9aOHhvnYO0ArNr79JitwMogN8WHTXVISISBDSMMQ7n76IGJqvAJ0FS5r/4EUBiEtqKlvbCkrYey4yB9/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoYtnkB0/YwcnPwmpggUl/i84RgyHrIPUcu/dBnZwUc=;
 b=I3NqIN0uLOc1rkg0SRprFgllJi265bemBDwxNuligHwAZtglLDkJ4RiukrzqgrscfrnqEESyTXTVTPSv53Zqgt4pijd4BYrU2/vaIbQbH5m4JN3x+Ku+XTY5Q228MxWRKciEYSvnkUArIkuukmWMpzu8E1UYTOI/WkGtj5nd/Xwk2L88bAH6+tfCegh5zwbcNwoQYDpkujVLMRzpWXiEZLxwpPR9fJcU+wC33ai3ro9i9soJsGtG2Z+PvYf5eyvZ0NiL42D1cT4gebnONsXb1szX/+CraF/6jkHte4S0njz1VJHSt3hLBdY1TKXTUFMerKTENiZQs2BIfWI6fiuaVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:12:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:22 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 16/19] iommufd/selftest: Test iommufd_device_replace()
Date:   Mon, 17 Jul 2023 15:12:12 -0300
Message-ID: <16-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0046.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4236b3-8a68-4d8c-9a92-08db86f15b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JQo578oxYv3isr56h3YQIgSpoDeEu2OJbhcWtpF5hYMwlS8Oy8A9jJefNkdclPPpNLX8w/8CV4OEKgu9Dt/67U4ChvsNzFNbiYgauxq/KiHsR7daiz0e3FwM2p3AbXa0AyDTE183UGL8Ykf6DCswGQT6uIgC3CxrZ4P1+dV5Tr0sZ+Wf7CsjtywYYVdNntlUaexmfHw2HcPEJrm+1nNYqQ0bcdiiGY1V9tx4wCrH+yKRBewSL3cv91PSSOaVcq16E9KJzFtSBhTndsWG6rRSs7uBdKuca/H91XcIuN49wDVFhC4raVc5OXD3mjksOUEic4bYvFa68ONVDaT520Hejx+7K5LQ2oHQsJ/WlR9AKdSoGy2Xd5I1wjdIHgl9U85Ynd8081u4FxtUnDH+lkNQTHtXkVK5HqUciAEdooW7vHVrwsl4IdOJFaEUDu/lnmKt6r5YhZZ10k71+ZdVtxLNQADo0+Bwqqs+8dysh9e0YYghAevb+xCgJ2xflRiuWiofsHvu9Eyz/r9aV+j2wy8U2BhUhoAj9jJFgW9kZk5cauUNmoLzCVN/mHRW4B9NyNK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(6666004)(478600001)(83380400001)(186003)(2616005)(26005)(6506007)(66899021)(6512007)(8936002)(41300700001)(8676002)(4326008)(2906002)(5660300002)(316002)(86362001)(6486002)(66556008)(66946007)(36756003)(54906003)(38100700002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l5oh1D3BQqXujDnh91kGfFNsexEHPUd0yxk6rgPFapjUtV4ts4a2AO/KIg8t?=
 =?us-ascii?Q?1s3AO9FBMAAi43LTS7Wrlep+pdK/IubfZBLPM2CGg+bbf5941RlUMG5STl6i?=
 =?us-ascii?Q?UlmhOvdt56SuSLVt1VSW0dTCiolmod/JB4JFdKeuSfAt7GjwZLdXcLNGMUHG?=
 =?us-ascii?Q?xneyImAukGpl0sdS5EZda0VbRymnHsJ9eyGXFOy/p5PnlGLJMcZhJ61Hqys0?=
 =?us-ascii?Q?S4p66AaNfpYnO7f+P/wEFfvikDEhIyu7rwPk718fS8PlwJsS0tsSvthRaNu4?=
 =?us-ascii?Q?CGJRM2fgK0hBUROD5YX1+WRm+Wverb2PNXDxweSGK90yaMzjMS+d97MW4KZF?=
 =?us-ascii?Q?2gU19biTgGeFZ1Lar8fLiPxUSbUJtAg8MvIAIt1nI7b9WH1i00D2F89AW6dP?=
 =?us-ascii?Q?cWrBdtUUxMeTvKRgYDzIbmvnyloRa/AFh0xLhyEkT8YYl6JTjy8VedGOBrba?=
 =?us-ascii?Q?E/DpY7cm8K/uUiORcghGZuSCq/PhLtEKiJPJYcW+nDpziMGNwIHS6OXKz+Q2?=
 =?us-ascii?Q?gVLCSSclpprZufTTG/CmG5C+BrBqpfuIBYk51QrkzhHKhxzg0jmnjfK2nlRW?=
 =?us-ascii?Q?4vJ8GzTR2gN94Ckz5mnfPG/FfNZfx1AFMNShYrASytAAWEoqTncYc3qIVxr5?=
 =?us-ascii?Q?kI+k/9thOOjGXZpZu5ya9yHRoS7eaEs4O53XqzbopqP4zvCRoTFbO+rbe1iW?=
 =?us-ascii?Q?5BO33dNybuCQhPILwayXxreLmaOYqmh2T59am3tUWKk+qEGIF/I7jGx28a6x?=
 =?us-ascii?Q?+hoBzDkwHHBko/nCshCGMUhiCz/vnS4KbQ/lUJr3wpqYNpO2AUlmYw73Uzq2?=
 =?us-ascii?Q?0wlL8zvSrlCDssqwjm2nnUUbOH/v3bq6ebjEENvYys8WEcqLVeSSFiZuYLPs?=
 =?us-ascii?Q?vKZmstvVHwF62/LdM6VGmf1cxBVJHSLOyMxa+KPsse9nSpmw5LIZoeo8LSkE?=
 =?us-ascii?Q?jV4+hmuq+HXGnzHABkleHPZSHCoJezEkjRNLdSGsPevcvW2svIfFsUMDhOWz?=
 =?us-ascii?Q?ZzIKiUDNAaQ+5Jfo+zmqk/bXvgZpD+AsSM7nDuu5RFyrPv+2OCaTSIG3NVIr?=
 =?us-ascii?Q?+GVny5qTL69k+GJmvDke9AJNpBz90xNpLFdCDZfqpy9/4vmeFnCfXLSkm8HJ?=
 =?us-ascii?Q?jl32EYHZoZbnyg3mPJzku2zus91uXLqpKPCwdj/RcE3KqkQenwAZ3i/wxGDd?=
 =?us-ascii?Q?mHQCSplWA1BrgmQPruMaLP3iS6lPEV69HZUHTQeTqR0C2ZH3hHFSdq2B301F?=
 =?us-ascii?Q?MzJFUBXoHAV7si9w3huYfh+QmNoZt0q/qfjWS1WCNyOCo2m4yZSPFQ2ADqwd?=
 =?us-ascii?Q?vtkL++O6Wt4sCz3uINM9WVxhDDxFLhmQydreacvCdWX1ty54G332f2Ztrf8w?=
 =?us-ascii?Q?ZyYTR3inpmspyXswrLr9/EKlgzeoa0RLWBBDoC+/ztSq9fuw61D47fB4sjWY?=
 =?us-ascii?Q?KEygIJ0XoCLYp38K8Y1FmVWvedgkjbWSZTh6nzbu1IXo6NQp4WjYVDXrnzWk?=
 =?us-ascii?Q?wl/VeGl7tjR99H2J06l2XodofO4vYUtcJbduBcajQr52h83WgPkyxbHBYFoc?=
 =?us-ascii?Q?z3T96F/SO2PqKpa/xQKGlvoqqnuKIP+xmLk/bPTW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4236b3-8a68-4d8c-9a92-08db86f15b81
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:18.7209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhXkPhBa35/g36G+6/l+Y1tTsgjWOwERgwRSbx+U8LeFcdMBaTn5sW1jL9UGw5Oq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
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
2.41.0

