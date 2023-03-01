Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074B46A744D
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 20:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjCATal (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 14:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCATak (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 14:30:40 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF8438EB7
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 11:30:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItOK84QX7CwAyoV2sa+Z7hd+KbC3s9e+1LgeIHlmAfok5GSY/SJbhlf2koDHkCuZ5ZjGd2grNRBWYiN7hDwejN06TM2BerhlUfteusbM3Kn4mIYXLr7DG0j3QRZXqsf49HeFPWLJqwrYTu+Fe8jsGJp2TWoazWy7pcmJMA9MhjDxrOCJpC58+We+204ns5ULd1d6OiDnuOEabVFRIyA6VsYbycz87bEtpf0XyrkZRkFNm6RZEpAQyefInHa3iwBEaHh8MP3bp7eW/Bc/kRVqYZxyKiFvbmikT2+LeChCocjuhqusi2e/7QkYLwjQ51vS2sLvMbWQywKeN1Q1XM4weQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AB7dOaZggIQRsdIHBoUQaO85PFcCCbbJxJCyNAb/Pw=;
 b=YZPdBVtp9f2tlLBBSniq+pSOOzSy5dLa47XWMDKyn/1+S+3GRK/9BxvFNExDUZ2Qcn8/upUv1dCbRJks49eXFrZ1FL3X+3BNjB+5SpUciXvGqRJVbJbgkchGkiFo1tKWkvXAZ9h5JcvmcwfeHxBOHCs3cYw3v7bA9Aq9rxElLTjDU5mNcxy46h8vlqU/KA5czOcRUYH4HK9l45IOLCWkNVcWhxHbstZyWVZY6sIJpqD283akvYb981rF137CtLpAf48tPfZVXotpZOKgEFUke7ATzeCAlJVInwC2MwdrwqwAsv+W71/dIu8XQbQbPkRqv2jqf3Z61YC7btAYzlkbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AB7dOaZggIQRsdIHBoUQaO85PFcCCbbJxJCyNAb/Pw=;
 b=bk2Eies1wUFtTNlohNZ7xRGH4wTmG+lKzhvuiqrEqpwFz5UfobN7TWljzJbIdYCg6ZgAtH7tq9OkT7QXjVktKljGDLN9oD4MLiHkLZBQJ7vVpE1FiAtwPZOxs2NVmBrS4XOywPds+47/Evrix1t5yPsqcnalDMy7u54KraG0f6PxVCR9Em5X7KPZZ//nvuYvqOKt+lJpxKlpsdfPJsXUnSZMwG9doWkEY2iRbnwLPmXWAUy3VI8dXhBcB4fEzL64BcDkHSoYTJe5bkzu6KeJpM7gONLPNeXmv5VxXpuOrDklD8XaYDhBYDkk5sAD+1HMahvM+Gmlc6T3DayV7+8uNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 19:30:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 19:30:34 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 10/12] iommufd/selftest: Rename the remaining mock device_id's to stdev_id
Date:   Wed,  1 Mar 2023 15:30:27 -0400
Message-Id: <10-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 989d79d5-483b-479f-7b4a-08db1a8b6c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pQPYgqyXk2eO2LG4G/Vz45F+ga1G2kHk/109AyARRAi7jG6GSMnhJvhcryJROKla1MKEbuiQ43pGPnJlSdORRGxuitNwXRRQ0A1VlUZUlFPqN57AmpXP6ESrykNCrG/Ks1Vy5Qv3HVnGI8mrQqfpBEGQuvBumXlMkD1p6EtIY8Tr56hPBHJ/BsinSnb3qGr5T1s9AHDNM3P8LAIOngWgdNadTCS3xTh7KXDfC5sxiBd4CSH6kGrdlmJLiU2EkIrhfOA9opbNRcYNuSfIq0Mn8oGaHvHYxq6txUwuwbKHBvDLdMB6z3PidyCd8u28CzBibXCCI3cRpuGALTWaZUuk6T6wys3udo9T1qk5cdGqkjfMgLgKH/tF89epbzjbm6tBPCZb6axW4hErrjXn5Wv7urItb2DMq9ILrvuv/sPlO+5g3T7h7mkVQAmZZ4VpB4R0yiPBloNc3q0Prc6WCXxvAQT2ls9t5aQFGxcJr0kIIkjDbkj7o0DGPHD738ATynOPsspZrKN3S5HGT9DFql38LKRjZTXlYXvHNymILRFlRJtUd4Z8Ock4oAzLtSgdIeOXMJ1BNvS7L8GIBmsFKhCWocyQYCwARcBlkZ+ukA3c3xpe1jQnHWEO0zzfjwb7uuO3MRH8unaEVG0uZmGZPxLMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(186003)(2906002)(6512007)(5660300002)(38100700002)(26005)(6506007)(8936002)(4326008)(6486002)(41300700001)(86362001)(2616005)(8676002)(66946007)(66556008)(66476007)(6666004)(110136005)(36756003)(54906003)(83380400001)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cbGtZI6iwAN6PjB1iXjtvAxvEgMjxpp3qYo4WX7K8Cd4lS8QbBYc1PLlgKbr?=
 =?us-ascii?Q?RG1J/L+eAioYfud2wnsUe0CQM16N6jROcKaQnVayGonhKqKE61VR4DU1E7Xq?=
 =?us-ascii?Q?4PhsyDM9M5cB3FJFLu6zVpGHDHofF8HxmttPyNgLHtanrBGv8TBTnLv7O5cW?=
 =?us-ascii?Q?2ZSJbWsVEb+bR7XSOXXojK6KTYvlj25JFxf2MMAgKHWmamIiA3U2uPlcWAq7?=
 =?us-ascii?Q?UlwssRFPbp0Q22bWic1yAYTyqTI0IR7a1jo8AZgf7ov+/XBkzJRsxHQlzp2t?=
 =?us-ascii?Q?FB8mGFX0FByGuLeHQ/JqBv3ihZvysBBU9e2WH/eXHRf90Qcu7vy+ukYcx9xm?=
 =?us-ascii?Q?qfmcuCjtvSYgzK9aw6dWmzqZuFcZO1VVXcu8bMVmWHdKW1iI2lh/Z878EhD1?=
 =?us-ascii?Q?X1fARLlVTj22HOFePlk5gbgWO6UBWzhh+xyl8z07a2j8XSfP/mDXBAYmcZc/?=
 =?us-ascii?Q?X1usYme2u6Jf5szySXlCu8dOCAbB9eh9sZB4Op84fAdFcHRiatM04ncSiY+J?=
 =?us-ascii?Q?2Mqhd50+g7uxjxWh/17JXLGDHz4QMMLO8nkmiVCgBIvOTuQNWe6YuhiNsN4D?=
 =?us-ascii?Q?C51UqMDxiIHIplZrFzyQ7/IrIZngDv7siiqFXY5bsGsaqnTD2aiOOGpnw+BS?=
 =?us-ascii?Q?nW7F1bG6J5XJLz4Wit2CSihYE4ZXcsAKbb0uWUsfIaHSSRT5HGv0nehqpf5y?=
 =?us-ascii?Q?rIlCvSrYUsGU7VXTtpf+Bx8d/g4YJkXSjETSdfdGuftKrjsRnafQrGuyEti7?=
 =?us-ascii?Q?92P8onA+RV4Dq0MvL+g/oiG84+rr+0xP1jYt/3wR8a13DfDl3A63tTsZnqU/?=
 =?us-ascii?Q?LMUzu0TZlxaeAnbG6FpHh7P3iZ1Ssa5Hfd+LcB+joRc+kr1mXOkZE4IrGoBZ?=
 =?us-ascii?Q?dgyAite0HEsd88exmCz+HSuOScW7KCs+tTasirVP2dllzO8D3lHNHf5UIDKf?=
 =?us-ascii?Q?cqHMKBX3A7KtyzVLSijN0PHJ6BqjAl8kaqbRBU9eH7YmmAsHs6ycwrVn1+bg?=
 =?us-ascii?Q?CB3rYcGs45p8RAgHGjF3kM6Jy7Jjm5NDf/8YHuaYezSack6mY/6X8LiSV3vt?=
 =?us-ascii?Q?5UBQDovUR3OfRhJDc+tahBZ0yb6nbk/lLzMZVABpyghjkE2Rp19zq+NuFgd2?=
 =?us-ascii?Q?Phuc0oJQRuFdty2Xn8EA2WXYk1r0lM7ii33OHhoXT/YyDEVj5HZELwMU4JMY?=
 =?us-ascii?Q?ZHCUStKRZl5+j7u3OhHB2clmh5nfCDAq+imgZbNv5cVRRxLmtcalC6f7NWe+?=
 =?us-ascii?Q?GNxUzdxLNhBZa7gc5z7F/fjF2EIyacSIh65W9sql8VFN6H5kcBowh2SUXs+N?=
 =?us-ascii?Q?uzRsmnGXyBpnSQ+Wrq9M2J31oKUJ695IrDIcFQ6KEkmw5mp37/IvlwPl9q2u?=
 =?us-ascii?Q?waVq59nTTuTNIPFrFk4WLbK8Lmngiflmb3JbB5S+Kr159hTiUva3UvIn5jVd?=
 =?us-ascii?Q?07wYi5S93jrwlrf+dwsyqx4Vlkkea1b/oY5PSxvTEYdE+3Y/4+nOQXvtMnoO?=
 =?us-ascii?Q?nF9fcxYOqGOgRkCdfsAfcmDiVsbAgbRskHvnR4RyxgK3LBwV8R7H57c8Wli/?=
 =?us-ascii?Q?meYO426No5npvIkcfOwaEnQG9hwVVaYV2mnaN8bo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989d79d5-483b-479f-7b4a-08db1a8b6c22
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:30:32.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0p7vdtUZsC3Ppubx24OWCieQfQOA+eRBK7nidbtP+v1sIsn8qwYhtYVk7slPTfcM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For consistency.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 12 ++++----
 .../selftests/iommu/iommufd_fail_nth.c        | 30 +++++++++----------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 6a61ec84243572..a9b232c281c02f 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -605,7 +605,7 @@ TEST_F(iommufd_ioas, access_pin)
 			       MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES);
 
 	for (npages = 1; npages < BUFFER_SIZE / PAGE_SIZE; npages++) {
-		uint32_t mock_device_id;
+		uint32_t mock_stdev_id;
 		uint32_t mock_hwpt_id;
 
 		access_cmd.access_pages.length = npages * PAGE_SIZE;
@@ -637,14 +637,14 @@ TEST_F(iommufd_ioas, access_pin)
 		ASSERT_EQ(0, ioctl(self->fd,
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
 				   &access_cmd));
-		test_cmd_mock_domain(self->ioas_id, &mock_device_id,
+		test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
 				     &mock_hwpt_id);
 		check_map_cmd.id = mock_hwpt_id;
 		ASSERT_EQ(0, ioctl(self->fd,
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP),
 				   &check_map_cmd));
 
-		test_ioctl_destroy(mock_device_id);
+		test_ioctl_destroy(mock_stdev_id);
 		test_ioctl_destroy(mock_hwpt_id);
 		test_cmd_destroy_access_pages(
 			access_cmd.id,
@@ -1197,14 +1197,14 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 		for (; end < buf_size; end += MOCK_PAGE_SIZE) {
 			size_t length = end - start;
 			unsigned int old_id;
-			uint32_t mock_device_id;
+			uint32_t mock_stdev_id;
 			__u64 iova;
 
 			test_ioctl_ioas_map(buf + start, length, &iova);
 
 			/* Add and destroy a domain while the area exists */
 			old_id = self->hwpt_ids[1];
-			test_cmd_mock_domain(self->ioas_id, &mock_device_id,
+			test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
 					     &self->hwpt_ids[1]);
 
 			check_mock_iova(buf + start, iova, length);
@@ -1213,7 +1213,7 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 					   start / PAGE_SIZE * PAGE_SIZE,
 				   1);
 
-			test_ioctl_destroy(mock_device_id);
+			test_ioctl_destroy(mock_stdev_id);
 			test_ioctl_destroy(self->hwpt_ids[1]);
 			self->hwpt_ids[1] = old_id;
 
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 9713111b820dd7..e7d535680721b2 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -297,7 +297,7 @@ TEST_FAIL_NTH(basic_fail_nth, basic)
 TEST_FAIL_NTH(basic_fail_nth, map_domain)
 {
 	uint32_t ioas_id;
-	__u32 device_id;
+	__u32 stdev_id;
 	__u32 hwpt_id;
 	__u64 iova;
 
@@ -313,7 +313,7 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
@@ -321,12 +321,12 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 					 IOMMU_IOAS_MAP_READABLE))
 		return -1;
 
-	if (_test_ioctl_destroy(self->fd, device_id))
+	if (_test_ioctl_destroy(self->fd, stdev_id))
 		return -1;
 	if (_test_ioctl_destroy(self->fd, hwpt_id))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
 		return -1;
 	return 0;
 }
@@ -334,8 +334,8 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 {
 	uint32_t ioas_id;
-	__u32 device_id2;
-	__u32 device_id;
+	__u32 stdev_id2;
+	__u32 stdev_id;
 	__u32 hwpt_id2;
 	__u32 hwpt_id;
 	__u64 iova;
@@ -350,12 +350,12 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
 		return -1;
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id2, &hwpt_id2))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
@@ -363,19 +363,19 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 					 IOMMU_IOAS_MAP_READABLE))
 		return -1;
 
-	if (_test_ioctl_destroy(self->fd, device_id))
+	if (_test_ioctl_destroy(self->fd, stdev_id))
 		return -1;
 	if (_test_ioctl_destroy(self->fd, hwpt_id))
 		return -1;
 
-	if (_test_ioctl_destroy(self->fd, device_id2))
+	if (_test_ioctl_destroy(self->fd, stdev_id2))
 		return -1;
 	if (_test_ioctl_destroy(self->fd, hwpt_id2))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
 		return -1;
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id2, &hwpt_id2))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2))
 		return -1;
 	return 0;
 }
@@ -518,7 +518,7 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 {
 	uint32_t access_pages_id;
 	uint32_t ioas_id;
-	__u32 device_id;
+	__u32 stdev_id;
 	__u32 hwpt_id;
 	__u64 iova;
 
@@ -532,7 +532,7 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
@@ -570,7 +570,7 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 		return -1;
 	self->access_id = 0;
 
-	if (_test_ioctl_destroy(self->fd, device_id))
+	if (_test_ioctl_destroy(self->fd, stdev_id))
 		return -1;
 	if (_test_ioctl_destroy(self->fd, hwpt_id))
 		return -1;
-- 
2.39.2

