Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFAB6CAD45
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjC0Sjw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjC0Sjt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:39:49 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1900F271C;
        Mon, 27 Mar 2023 11:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ja/5UyaA3Wn4QVpnsXV1lwBMzWIAe+1EwUS+syWs4ewa2Rvs4htFoBFCaSy3vUSpbPECuGoaY46Y6KD58euoQp/5Wjpgix/XniS7cOGhp8l2hYB1fnpOr6UFPlXulkWTw5opxiedod+pPPJJ1Mn6TmkZacHmRBYbWoAcqJEuBrxEG4zH17ebhf2XO88XK1eUOkKNCQVNf2jC9wTYqbcsZvN+sPwyJ8Lxsnvfdqcbzw5OVzFs/kY3i32TYCC94e/zI1TQRi1ayQJaweeZiIlGV1FDG4bpefAfrs4+npvJJBenMru5ylKCV+eLGl+NXET2Bhgn2ATHw5wK4q6iEfIb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9NAWuhQYRmr0aJbsrLbSRT+BQzLs2Y7zxvm9cTGI8k=;
 b=RWeMF4v7NilxXQKaAI2krpwV8T322u8DZ8pLjKEFUYMARUYYFui1rfBAP0ud7CRR5o/nZsL07v3BvGeMSFaWsPwTNVKVE2irCnE30ifigQXzAW9crwMZLJ4tETUsMCv4XoWajv+JuHl88tLKDEIths44hd10Fe/VyrZsk8jKIbvN9ymCjTIA2+W12O0eYeUoUOZyveBJac0ETpdC39UFgJSvlXLagReXRIC7xKXYc5tv/yrXHRfSw2dw6rTDGDv4o2essKtk428CT+hhofQJk3Xe7VmpmOel/grxrudRThl/7V7VIdCbG8NsF5iC2nbI6tm2DaQkZ9w4QSk3YOg2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9NAWuhQYRmr0aJbsrLbSRT+BQzLs2Y7zxvm9cTGI8k=;
 b=UUjIM0TlD+lSwWKDCvPYcb0rLU9qVUEDdg7fG3oP1/xirq8MbCRFvPjmwIaHHn6JESE8PHc3kLLxXYSBpCev6XMcA+ZLoNuKlzyq5VL1t5epaIZz/SLbmsGSqyLJlNY+eBc5xCeGg3hP0VuIwkxAukcvV1/BakV/h64PyNaQ/DrzQHF9JIVDyS4yCgWoJVIjMr8qbscRPRpY/DsjZRKmGaxrMt/FLMPGXT14JbzICYiExq5IfjXWJzxqV/iehrbHeOzulJuKZBlFf15eavv5v5YLOIzB+wTNDKR/0JW1k7s/Q0zwjIzHxrLQsME06ItFFvK0e3kth0cP2VZ4nRuCCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:20 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 14/17] iommufd/selftest: Test iommufd_device_replace()
Date:   Mon, 27 Mar 2023 15:38:08 -0300
Message-Id: <14-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f218e1f-9d0f-49a5-f450-08db2ef26c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37TBVVQk3EiYVzdQwO0ilkNRTcZaMnA5Obn46NDQEeQPZ6qqscURRHYfxFjwSPHPQvPY4g5ek9kcGkujUDEiByJDAP5I2n5y4Cg75lr10k47bMjo6IjUfDG3u7Iml7wFEGs/dj9xcI1YhhuMNvr/VrxYI4UcdSmO8gFowj5/kQl9pKPN/bS/tZJEkwyC2Zp4ZAL2OsI/YOnE151UhSDYOUYkvkf5jWuHGCKENPGURlQGbn6aQ6npyZ7S2PITZv6cCDv8MCuW89MsccW33eyPveMVdJpldiUThOUxvNVFeFG9Ch8U29N9mLLd8nEk1cTHHV7o+27ICffUZs9lnVgGjKl1CBCqlR1mrIHUJgigkFvSmB3X+fDw0SiukIJyYyL3WQIT8/JYJKCbAoQBYjuodSV4bAU42NNareZ2TceGlsOTkeotjUgg5zqG+ciPDAxbGkxl9i2DL1azU6YFeppbwNKRT7uiet4fQpqrKFQeyS3MWMQXv0aP6V9UHGSPo+JiJUB6xiZFJSZirebGSbNaB3SLSvKKie3XYcydLX39SJKaRSy773OMBED/89/d0BNx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(2616005)(8936002)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gzBBPkQ/8/xV7Vr3UpONeeJEZSucmQaLRAexXVB4QIVQnuWPSeKtkbfsa3yh?=
 =?us-ascii?Q?zKu4EO5GTr6l/0XNXz0Xhu80KnIoQBtRRAKMszieWtzEXgHu+R01E3PFkpNK?=
 =?us-ascii?Q?nmSL0InaF8M2E4/bQER4Tm61+fCmo/WszUSvPaVsp8KERAkcVK1DA4BKhe+d?=
 =?us-ascii?Q?q/Wnvt3w4DwpbUkDnDs04+dmaVa1/xR2znkiPaTM6AvFHTWiV1/nVkFj7Rbn?=
 =?us-ascii?Q?ROc/0/98ulaieZAApF+Td8qw+dg/SphkCNNS56NAQHUmbUTrEgkq5peiStNw?=
 =?us-ascii?Q?PXE4kq83UX+BTTb1un7OU5DnfC0bkcgDcuFUA2h8enmLC5k1sdbVBF0whder?=
 =?us-ascii?Q?Us4ntGdLkwSPgZzN1YljTHURrxXv3mhOHC0WhNHYPW+5Bn7UicNO/a3AWVgU?=
 =?us-ascii?Q?z5SUTjM1KL6p+iF6Ij78GoW2WF5LZM3vfzKBUToJaHB3LxZQlSRdR3vcCBhd?=
 =?us-ascii?Q?T2rNWCppuKVxZbuGswXU/fuxSauOVPKZsN48vwlZWUgzEicyn8fJon6Xo5P1?=
 =?us-ascii?Q?TNLx21A7bnhQGa7oOp4rrUDUpBhQDXjYs+uCswyGyzzeatxVD9nEeM3NFYUb?=
 =?us-ascii?Q?Vk2Yl2Vy+xTbStO9KxnFwZanEa3yWgF11sUU67cOaIZGXeOltTLNxyeLviTr?=
 =?us-ascii?Q?AEnC628XrzIbNcj3Kvoz/PkRb5JVxg1ZW8Yz0HYT+3+kHyuFda/gn1XdYISt?=
 =?us-ascii?Q?eM/P7e2o8Pu6KlB/bjZ41SOY/6R5kzNxTQJiA76yqZ2ApKtWQs8wADss+jMZ?=
 =?us-ascii?Q?1i2pEKDseDcDYptyK9+4PP1aIDxdOofsX5KsJxhN1h6vttwAmjZJL+QNVBM5?=
 =?us-ascii?Q?iArsr/bxTL1N4yfCC7MvueSvJcZC1ZQ0JgLcJhLfcIhMwNaxiGa/auJzO8IB?=
 =?us-ascii?Q?/FzfdSd7A89ArxdGQXnli+5W5AEtD2GuOLCXOb8EUcyAexWugp66M3VdWbIn?=
 =?us-ascii?Q?yBYj1mzb9WpK0tDlI4yKXD/bSeaEhGHCy4bwxtyCdVhT+cRr3k/P4AZ2Do7l?=
 =?us-ascii?Q?mqzvEp6DpSqTNmcH8iPoiuVy9Do5/n5O3MvyKszWyjCnumEPNJzgAwW7dXmV?=
 =?us-ascii?Q?JVRpcOl8X80zZZfy+K6hlfXshRQzetMP95CZqUOSH5l0ZRvIU5qrcxQJteQc?=
 =?us-ascii?Q?/0bvDSt5iuONFlRohbwhNjQfYxJpsTxQLg8KlCJNQ7aGQ2kpTWFP44aJyIqJ?=
 =?us-ascii?Q?5GtzyANOQekk3StO5ADzyMGi8mRjFheVg6Jq2bBNcMLcIs4p6luGxYxIqUF3?=
 =?us-ascii?Q?Y+LBPEUqSWdcjDWdp1q36AFDW1J2myi7n2d3vwRtuHEGzxS7boYVkjm7xXKY?=
 =?us-ascii?Q?Tq2Ao2kvYvTiGZVlif7vy48HIwTVCg8EW/X36YLL4ppva46LeYXcN6cPMN4m?=
 =?us-ascii?Q?g4gaZKQqX0JdF6Lq3SO76FsRSee/773IV5Ga4qJOhKSRXLReHtOB9MGuSeZT?=
 =?us-ascii?Q?nc8kfOv3cS4nJJylZB4HACVAGk3o20RttffC+bkbMz5Qi624IRs0UrLQXNhe?=
 =?us-ascii?Q?oIUsH3he2I4vKIKdMJA0pI1ndOh9/aD9voclTer8duiwj9ZkIuzp5DYjCFSW?=
 =?us-ascii?Q?rmCZuVvGj7nSFpV5mp/dOocSMwu4remsJkdO0DtG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f218e1f-9d0f-49a5-f450-08db2ef26c5e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:14.2088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nktdu0yj2wQwnMvA09HuiGjFyXok9GgBzmda3UCVSklUVHp1khTV0nDcucoAOfnO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
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

