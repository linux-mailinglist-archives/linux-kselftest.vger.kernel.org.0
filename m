Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A7F6A2590
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBYA2R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBYA2O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:28:14 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB4B1BAEB;
        Fri, 24 Feb 2023 16:28:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8OfYasEZUjO/6OpQjFtrFZPfNuJy25NohqrS6nF/1Sm9NWIUCUG1jmd7KQ07cz9gogwp8OAUgVdUGYkzZMbAYZ5bQNmPEk8+FU2ckRdmxOPoebqjW2n3gZJCZRFJcdcD+xTI2owuSBRxYKMjktlaPhbijuZgfK6YjknCITqL5ELviJCdEpGZbVDV9/m83DP63FdK01i0belTUCO37ghVEfur83CH/kh3ML2Q/8b3Gx/qHUeUSAVcty3BxgI3L7nn3+JeDbSWkLGsbJ6ZCWjPhwMB5V4PNtDca2ONYv4rVpFW+3Z1pr8CFyZlq79+qjubVuJBX4rM+dbTRMiJKZj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swjuu6Z5wkpRyJTkrod1mEtKh0a9mnBCrV1OjTmR1SA=;
 b=j9/ZZsu3wz73jwa4v9xkhPSK9kn5QNW3Wd+hWCumsGSN06CsRqISznaHfdXKoVucFE9z52esMEzKbgUHeWGO5SCskxBSy6X0+k4+bj6Tdh7nuvMiYBWGPNQEca5n1l28sQGR22/sc5gtRlKaYwYC2zicMOh3AmT0KSh6VC0JYYQigVmrF9istbdQZLb36nfXLAT2UmtwRPn/fyGkwlXQ10nQtrgIC+xkd1ljZxc98IdosIIycLkDovsvm0ykNctnuoEN8EUNqKn8EL7gEigfIY3EkiUCW8w4zC/uq+BgkmVfL2fu2li9ZYqhFSjKgl2SSvlTh0wSausZbNouQEtZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swjuu6Z5wkpRyJTkrod1mEtKh0a9mnBCrV1OjTmR1SA=;
 b=qvxZvSfQVE8suaAjTpXmDqWB/2Y2cqL4+qZJkrTCDakuGBBSwIIhQc5YzE642M43v/tnh+E3ksG2eHW8+H1suot4J6+mzrvPw/3gZC6+8VPT3rbtCitSSxdsZM9vCpcRN/pwn3aKK7W6g2TxFug3/nOJWQmmSFxZllZIS6QmDzcBTMVOrNTx4NZ9Ngbyq3BaO4D9sq33wPjahWx2Ud3VWUcs9+ncl4mlX81iKyVyW+D3TfDmex0vP+SfTS5zRnhhxsj9Wwz5nNPSOVKG2O2voNkREqHU2CL573Vls6x2omQZkM8rH2512Yhcn4gc+pqFlMw+2BlfFaStU9G0r8RKRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 00:28:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:28:07 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 14/14] iommufd/selftest: Add a selftest for IOMMU_HWPT_ALLOC
Date:   Fri, 24 Feb 2023 20:27:59 -0400
Message-Id: <14-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB5507:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9273bb-a72e-4bf7-fa9f-08db16c727f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+IFwpLN3lATH/pNxLG7+w61zEpOk871Pef+24N5aUMN5Zg0abs0D7/AB/sv4CHKf4LA91eaRjCJlZmgAWtPryjbmdI/pcLMexcgqZuys0Bptkh0HAYryt56cU8KRWBB9bUgJjLyXyslZg4G9Ys/OyVFcADqAzCHBkTeQMoUGMKT6KWk1iAGw9tYDDZ5MgApzT8mCeU8WByMoKDpMX2ZHZPlWmoQQbSGhOWuFYoch48fT78ki1Sd7wb4na/pkWGfU2eRkOOWNuvV45EXpZM8AaLeMliVgnea0nIXEZFFQDtlDD55mRYZR3DBPXYYhgCJVrlFQwreMYNy/JLVEZhrV40PUPAUfR7P02iQ1HznNvwWwCMOaw2WjvO3i4cyGkXs4tEBZBGyabAkXAF/G4zbttiW/2S96wIQKUP6HpP/rPR4U3Fb2FX0k1KBzulIAROvNDOPpbJwYrTzjI7NqEwZ/GnLDD62D4a/9J2ODFR+wD3BVSCaxZa0uUqZ8482/aHODd+GKJTvTNw4GXJEA6RIzba67dYw/WlanRNYyyfMWphdTS/fb6PhblpfBm7B2G+yhkhmIAzme54yu6uEA+314glKK9lEAWOEtVP5R9z/MU1rzS21AW00N1dNTcSDcwMbB97wlkkNJ12xHLt/d2wbhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199018)(26005)(6506007)(186003)(6512007)(6666004)(41300700001)(83380400001)(86362001)(36756003)(38100700002)(2616005)(66476007)(66946007)(66556008)(8676002)(4326008)(2906002)(8936002)(5660300002)(6486002)(54906003)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RTxWt1FHw28ZJcQTVQU4gC9UhzqvYgteNJVpQrMkj4hbWzdohL8vhRLgfGBa?=
 =?us-ascii?Q?C59bHTTvy74FLvE7MgVYkSdJShSw+d0lUk8nCStc0Z0Sh9HwnR4ue8OhD9WC?=
 =?us-ascii?Q?gxQ2gLdh2GQzfHxTNVH+SJ0SYyj6tPTE5BxnNHI22zNauQmvgUA92W42nZ0C?=
 =?us-ascii?Q?tCZ8bGWoxcz7WrrhBCNQdsfALHuGRCidk37sOuT060Jg+F7GxOeyQrSzDNA3?=
 =?us-ascii?Q?niBrHu3eCtEV0lShfi9m12nJAezAZn7mrIBiitLhZj0KFjaP1aKiKvuRgdz8?=
 =?us-ascii?Q?sg8rfSDlIsTp4nXYHXqc8XGOQLtuAqO9Udp8YwLcVjaUNUQzjHLsnv75Hbcj?=
 =?us-ascii?Q?aY+J+Gh0VV0E33QtLxNr5xyGtRilVvwtR9BGu5c/uTOuFyULFK++8gkEj21H?=
 =?us-ascii?Q?dhs1oAv3GiRHsEHoS+HxaMlkMWshJHiIpENx4UNuLtS3eoWQQ7eNTBJUVeYc?=
 =?us-ascii?Q?7k299T4w7TRt744M0VcqPEDueMon0+LUJbOOfhzbZRrm8XBAjv2AgsOdukrr?=
 =?us-ascii?Q?kPSavvh4yzhvyHtD8WqRBCPRv1mH9uqLQSfoZl3qfDLPp9/C735ZTuLzbrSc?=
 =?us-ascii?Q?AMP6lh6F7pQWpSbm26Z1a4kDK4ZMPHuQ8nSCeTymb3F65kKm4O3Yi6KmiaOR?=
 =?us-ascii?Q?L0wN4dgjeZTABQkHB69pBV+ShNBX/EuTMpSN6feypVxO7P0E9jvPjPBEvy6L?=
 =?us-ascii?Q?bWqKGY8I/YAoMSwpuAqRgbnPQ2N5SQgv+tVsDeQMkYB9aTMdCZWSMfqhtR1p?=
 =?us-ascii?Q?H0dwobeVQkIln/R55Iw5JqyM4/u1cuVelNe4BzL6eZv/2Yyalgb1qIDgGBJA?=
 =?us-ascii?Q?n5W93vENFMZPaxx4dKuRcaJeCmZmLjjR5xfnWYY/SSNvZlTqpjOEIVUdAwLZ?=
 =?us-ascii?Q?7DR1f+G4ej94OuI+1arULJR49xaDHq6eVJE151y+7llawt3ax5y8SCcZ3L+m?=
 =?us-ascii?Q?PQW2HDZDVtZrIg+q3rK6Gku49ymbgmVQriPgsA2cglY7kBbAH+0gUb6yFkCJ?=
 =?us-ascii?Q?X4m7bc0vpbk+RN6Jfqmi2f5p7x6ZK/7YCOw3ZqHBNDa96AJ4V54XysYXBLSX?=
 =?us-ascii?Q?ctonkk+0s5qRy5L5ZE/cxBOtGeJWAm2nmd+Ytis0XfAuxcPQVNvRZwuNXyHQ?=
 =?us-ascii?Q?W1kbQyB0qP09IN75pRqQ6QmOYqOd11I4g8iasJqnbcZ2Be4zO/eFqqz69dyg?=
 =?us-ascii?Q?iJCYOhMbTQnS++ThVtjMuuA474X/E/UoOpT6+Q8xwMluytMuj5QBHYIAVXRW?=
 =?us-ascii?Q?taurtjIzOrWrUkJkGsZ4nraiwB/iLcG9lERtaYuXgCfYA9cIgSWCkONpr7PR?=
 =?us-ascii?Q?mNZau4Q08ArYCMv2LOi8gUmyBpY6BVZ1H4ERjzxeLr8LdexCXvZ4shecRSXN?=
 =?us-ascii?Q?miRUI9DHkL8HkS/1lQEmLc6SBVyXvqaa+x8KgnoqH5vpHLQUsxuv+XL5f0Kp?=
 =?us-ascii?Q?Fbeu/GbExON6vqEvKhPSRR8rVUjhpU8es/3aVqwDFpy3XEA3gyT9AvCxJ589?=
 =?us-ascii?Q?EbsFUWvePeN0U44sKCnfu4HoO4DYJDeSIwd0poVWgTgbrXYYzhhUyGlB5tKL?=
 =?us-ascii?Q?nlHa/5rloYHjP/JoX/rB1hta+KD4Rcdm5erVmT7f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9273bb-a72e-4bf7-fa9f-08db16c727f3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:28:02.9203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTCj+qZFnEi8QkcDXfoN/ZOom6CRAlTQmhQf22f8szfWjyAFQx/MdZCo0KWbzUzb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test the basic flow.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 15 +++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        | 11 +++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 21 +++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 7e6fe263e1b62e..65f1847de5a542 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1307,6 +1307,21 @@ TEST_F(iommufd_mock_domain, replace)
 	test_ioctl_destroy(ioas_id);
 }
 
+TEST_F(iommufd_mock_domain, alloc_hwpt)
+{
+	int i;
+
+	for (i = 0; i != variant->mock_domains; i++) {
+		uint32_t hwpt_id;
+		uint32_t device_id;
+
+		test_cmd_hwpt_alloc(self->idev_ids[0], self->ioas_id, &hwpt_id);
+		test_cmd_mock_domain(hwpt_id, &device_id, NULL, NULL);
+		test_ioctl_destroy(device_id);
+		test_ioctl_destroy(hwpt_id);
+	}
+}
+
 /* VFIO compatibility IOCTLs */
 
 TEST_F(iommufd, simple_ioctls)
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index f2012db43fbc16..5f293825fc37a0 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -582,6 +582,8 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
 	uint32_t device_id;
+	uint32_t idev_id;
+	uint32_t hwpt_id;
 
 	self->fd = open("/dev/iommu", O_RDWR);
 	if (self->fd == -1)
@@ -595,11 +597,18 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, NULL, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, NULL,
+				  &idev_id))
+		return -1;
+
+	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, &hwpt_id))
 		return -1;
 
 	if (_test_cmd_mock_domain_replace(self->fd, device_id, ioas_id2, NULL))
 		return -1;
+
+	if (_test_cmd_mock_domain_replace(self->fd, device_id, hwpt_id, NULL))
+		return -1;
 	return 0;
 }
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 807a2421121b51..bc0ca8973e7951 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -96,6 +96,27 @@ static int _test_cmd_mock_domain_replace(int fd, __u32 device_id, __u32 pt_id,
 	EXPECT_ERRNO(_errno, _test_cmd_mock_domain_replace(    \
 				     self->fd, device_id, pt_id, NULL))
 
+static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
+					 __u32 *hwpt_id)
+{
+	struct iommu_hwpt_alloc cmd = {
+		.size = sizeof(cmd),
+		.dev_id = device_id,
+		.pt_id = pt_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_HWPT_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (hwpt_id)
+		*hwpt_id = cmd.out_hwpt_id;
+	return 0;
+}
+
+#define test_cmd_hwpt_alloc(device_id, pt_id, hwpt_id) \
+	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, hwpt_id))
+
 static int _test_cmd_create_access(int fd, unsigned int ioas_id,
 				   __u32 *access_id, unsigned int flags)
 {
-- 
2.39.1

