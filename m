Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC576A744C
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 20:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCATak (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 14:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjCATaj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 14:30:39 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8A05FCC
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 11:30:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HA4iVdcvnp4vpQ0dduoN2UsKpVubBxeR9QZVCYEqepKV5tpnpWXyHl640sbvc0h52RKMDePj8kMiBM6uP1uS78U9uwAIzw253GkzQsl836PvR9eXBrKLctRbAIpX9qvw3npv8z8nCFS2VXMsWGBA+0gg9TSjaa+IOC6Gc4FSq8dL8vPmf7hu08PSXE8NPW7+YtC+Gt4VNGI24h4wJhxEn8ffC8NY7xSxBXdmLLUYwBxZWREdTOsPgMW3qir1HfIQCDaq/5srG9dWBBfh5q0SaEKUovqPUQBj52PRB0vcy95A+liUlcAmnCXPUQtqDEWJczwMNusVIT7hJUAegzmlFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2dMUdHgo5mRr5g/vACCk/f/a9jXivTNVGtvSI0QC2w=;
 b=hoRkgyKwrNqM1dttQYD43qqdPw6On3/+YWddHUei4/A2yyQF+XGwA0biBouxKaR452zC6zYEBkaRBMNOPWaJkfq+tD1fzeWafYvPleWdUuKjD79RwLFDfurw14jt8Oq0FwkawBgJftH2oTmj1y8XgVJPSo5VRzm/fR9Cy1Ip4HFf5RSX1eV6+q8jZxUevTCKbRI3O6zLz6hr5H4UqFkhHBjw/pKzPOkbusaDWsgt8xKxL1OnES52ew2iwHO4J+gDSX3yz2r+E6xpSlPAj0cuCj/AMoBQ4U+WVQBhOWcNpM6UTbJ6rqBs/weAcpb8fVcd7xNAuymHhe0Jyr1nkZcUSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2dMUdHgo5mRr5g/vACCk/f/a9jXivTNVGtvSI0QC2w=;
 b=pKiyXa+6Zat689wefn/Qx35R3/D0rCq2isaU/VECuOQsWQUrx8QOWH2/CNVLaDor6uB+fZZvGXnz6TDidF+q+OZnEH3mAo9iYxpUAlsCJh00er01HRYjc8SLY/tq+WAcwnxH7+/ncOGuc/9XzSNy127Pt7/5ZdMF6ZaZlMren0wLzZXlgOgLG8oWn467v2ZClqRbxxOOT5frwF2uxfUySyv9nq2ncB/tLYVScPl32woKPTEWhi6UGKvKQBKjIWBP/BjB9ixchGy3cEqSsjqvkUAFbiJYmjmtAw0wDQ4Xe+oncu8tGVXnxVedUY9I2GnSXz7KKU0f1vvd9vbMNSDvFw==
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
Subject: [PATCH v3 08/12] iommufd/selftest: Rename domain_id to stdev_id for FIXTURE iommufd_ioas
Date:   Wed,  1 Mar 2023 15:30:25 -0400
Message-Id: <8-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ce7b94-f9ce-4d43-3fc0-08db1a8b6c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYY9Ekvct9ePtPQhEDfxz5F4hZ+sE8CYxR8EehmSuR9nDv23apRPA4UZudec5zi20el4cbr3RNxyqkz21cQz8xUloEKgODsG2CxlcCznVtFpVwP/p2O+PU7xe8hy4CPnd3KGzMg89MCGPtG/5GkMS/79mbAoevvfDtpLfTIFgvT+b+eSEForF0E9UfM26NVEEoX4zfo6qppPxckkgy5tWKu+NDuqiEUb30lpMTKC26FqFf+mEQ3MEq/qfUzw1sx+n3imyZt3F4NBhwO2Qf6+rPdkjU2mR8L5AyDp+9lU6XDHVLhAO8XcsCB/hepqooESQS4VgBp6pbzaPh8V7gkoxN0I/QiQHpugMdVllBCXEICj85RkMm6mNx/8giaefh4chepvSoB4xw/W4yNud3GjMRTAuiOo4kVV+9hA6zqTwPmIz700a9lhYgBOS+1zvBD27S1sh/cVCwq9lMZi0tIaUQM6yiVNHTRLRibI2df2eeKu0RPW8zxHp7qZ+pzhpzLupVeqLTljzIWi9isgG6NWyDcTCmqghCQaZ4Zhr/CqlAPcvzi12Qw9F7ApI0y46roOcstCMeUQ5lCtlO1BmF8f4wcsvDeVW6ZXzrR3iMnsIw9cBxe6EtXDBNcWb1YsU2E6x862wCmX0fvNIMnzPidWmYsAYBs7wsM6+9Y/BMr6rBjJfFbcs0u6jFrh2o+1yvSW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(186003)(2906002)(6512007)(5660300002)(38100700002)(26005)(6506007)(8936002)(4326008)(6486002)(41300700001)(86362001)(2616005)(8676002)(66946007)(66556008)(66476007)(6666004)(110136005)(36756003)(54906003)(83380400001)(316002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4hyl+d/Q274tQCSfbi0SQGgPt5eVJK0zkaDsMUrKxp5jd2CbpANsvfKrY1gc?=
 =?us-ascii?Q?1/82BCQe66TF8Bsy6DIgMNqPlVMecrWseF7ndJDIbXbN+N2hwbysr0M3A+fg?=
 =?us-ascii?Q?NVq2kbbkFHVHlGry4kV9rnWS+HjcwRghImsLqRQq+DaUZoOxu3mFORESovaV?=
 =?us-ascii?Q?7SRm3FP/jMJx6bZnFxLYcVrDXZMUo4t59SUCe5sMRO20VzeR0mefd40vquu+?=
 =?us-ascii?Q?h6G/T7eY18QO+NRCHxW5X7aRpTvC/vH3ka5zZTgikbHx7mHUbEjn2/CIK2gC?=
 =?us-ascii?Q?+dgYuMxvkoqyrTvnm4Tlznh7YkVAuyxDvE8KpNwmhUCeSdSm857Lhd0Oc3Pq?=
 =?us-ascii?Q?hePFNzU8LrOISlTOL1knx9FeqIfHBWz38l/cJl8r/tVY7hfuhgxnX/Z/1eXe?=
 =?us-ascii?Q?eOHrJ+XnXIsQkqM6492kooXzIupFwAlleZeKQ0YAjF3ngYuq05sQHRHf+1Ff?=
 =?us-ascii?Q?BcDDg9PqZHMJ/aYdiBEoK8vCOdGivxgvYtVTgNyW8jRnz/Z+Ol9l5UJ7/eCF?=
 =?us-ascii?Q?iEYHpEs43Gd+GJ5TLd0Bem938FbhJ24V3jObr7SqG9+wI6LAyppu99kbOIIP?=
 =?us-ascii?Q?lRqfjIuq2V8mj4HBgz8h1VgSpuaNgiK8NtkOv9dJwCOjWoGDWFexcH6ISO0O?=
 =?us-ascii?Q?JvBTaG+FObFYlA8Zs7pk2fSIBBoZnwffUZK1h4etHYgpeDphH8wWKAEnuoIN?=
 =?us-ascii?Q?ozoTlLPXMe0sPylwcWxbo7sR3hot87xT7UOYExPB6f6WfkOGwhZL6pUgnnRJ?=
 =?us-ascii?Q?ZRM9y25YcKUt97V+sVyb1BXCWT5sUApWFOlZ6WU5ok3wGSuI+X7yF4Qn1zDP?=
 =?us-ascii?Q?TVNNNz+aXGiU/mXNtQ9YPjvdp9Y+HRse8gqwfN1r6RlN2Z1p4IPk3AtTUHll?=
 =?us-ascii?Q?Cr980jy/j0Ri7bO+0QgnqiNhGErTle6/U1CBRvdR1V3VmW/3qHHXUByg+KJw?=
 =?us-ascii?Q?hjHNrHzx3fOsU3wSFakTP+xZPBQqZUKcbmZCpg2E6ZiKxUlBU5xZRhh5Wwf4?=
 =?us-ascii?Q?Ubx7ujMUBmzMeEJIb1LhuhlweYSkMd3mYvOhAuRQPLDgIM/UAknpBD2JPtLg?=
 =?us-ascii?Q?a8DuAQ97nz8RHwB7oInXpZQg66CmrZ3hrV/YoHb0pWER3PganT0Z3qfUX9iS?=
 =?us-ascii?Q?3H0pcwHYf8UmdqGwOKN/+1/QItE9C91rlkqHC2HT+bur+x4sthNHJBG9EGfR?=
 =?us-ascii?Q?cdhHIJ8NLvGayGzc4BxPDjhBaEfOxPTPFjb622o0YVm8eIBVpmXUcIiznnF7?=
 =?us-ascii?Q?w2xpYQBLosRiWReuvHOGITPZ+DFelbvF01GHgz4TTOfcVFONroFdOu9xJoZt?=
 =?us-ascii?Q?epWBwwV+mKoOXGzPEEkCc9f7umfHgh9jzNUqwyWr7ODVHinxYkCv6MVERKBm?=
 =?us-ascii?Q?G+nYl5+skAJBocA0It+vbrhiXS0c60jkVJzoFjY3kE2zDXbnL4jT5IeYZ3Ts?=
 =?us-ascii?Q?cfuOqrPaiUGAopEkUK5JsC6LE5sYpqQMazY1jm7+l1k9jSlhuu+TqVwEhFs0?=
 =?us-ascii?Q?fsuvcITPWSaSjOE+Lq0LUhWTb1+9qXTZMB5NUWJckhpEHp4K75P3TsomnKQt?=
 =?us-ascii?Q?KmmrXmulHsmz9h61PdUMLFvaqRYNe8IzkxUTY+tn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ce7b94-f9ce-4d43-3fc0-08db1a8b6c27
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:30:32.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrpWZvNQftzOGzCEHZDqDqpDhgue2lB8J9LO63bjVXZGVl7YKlTA8Q5czZJtBLkl
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

Nothing uses this for anything more than checking if a mock domain had
been created. Rename it to stdev_id to match our naming system. Currently
domain_id is the hwpt_id.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index fa08209268c42f..000fadf8110833 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -186,7 +186,7 @@ FIXTURE(iommufd_ioas)
 {
 	int fd;
 	uint32_t ioas_id;
-	uint32_t domain_id;
+	uint32_t stdev_id;
 	uint64_t base_iova;
 };
 
@@ -212,7 +212,7 @@ FIXTURE_SETUP(iommufd_ioas)
 	}
 
 	for (i = 0; i != variant->mock_domains; i++) {
-		test_cmd_mock_domain(self->ioas_id, NULL, &self->domain_id);
+		test_cmd_mock_domain(self->ioas_id, &self->stdev_id, NULL);
 		self->base_iova = MOCK_APERTURE_START;
 	}
 }
@@ -249,7 +249,7 @@ TEST_F(iommufd_ioas, ioas_auto_destroy)
 
 TEST_F(iommufd_ioas, ioas_destroy)
 {
-	if (self->domain_id) {
+	if (self->stdev_id) {
 		/* IOAS cannot be freed while a domain is on it */
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, self->ioas_id));
@@ -263,7 +263,7 @@ TEST_F(iommufd_ioas, ioas_area_destroy)
 {
 	/* Adding an area does not change ability to destroy */
 	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE, self->base_iova);
-	if (self->domain_id)
+	if (self->stdev_id)
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, self->ioas_id));
 	else
@@ -382,7 +382,7 @@ TEST_F(iommufd_ioas, area_auto_iova)
 	for (i = 0; i != 10; i++) {
 		size_t length = PAGE_SIZE * (i + 1);
 
-		if (self->domain_id) {
+		if (self->stdev_id) {
 			test_ioctl_ioas_map(buffer, length, &iovas[i]);
 		} else {
 			test_ioctl_ioas_map((void *)(1UL << 31), length,
@@ -418,7 +418,7 @@ TEST_F(iommufd_ioas, area_auto_iova)
 		     ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
 
 	/* Allocate from an allowed region */
-	if (self->domain_id) {
+	if (self->stdev_id) {
 		ranges[0].start = MOCK_APERTURE_START + PAGE_SIZE;
 		ranges[0].last = MOCK_APERTURE_START + PAGE_SIZE * 600 - 1;
 	} else {
@@ -525,7 +525,7 @@ TEST_F(iommufd_ioas, iova_ranges)
 	/* Range can be read */
 	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd));
 	EXPECT_EQ(1, ranges_cmd.num_iovas);
-	if (!self->domain_id) {
+	if (!self->stdev_id) {
 		EXPECT_EQ(0, ranges[0].start);
 		EXPECT_EQ(SIZE_MAX, ranges[0].last);
 		EXPECT_EQ(1, ranges_cmd.out_iova_alignment);
@@ -550,7 +550,7 @@ TEST_F(iommufd_ioas, iova_ranges)
 			&test_cmd));
 	ranges_cmd.num_iovas = BUFFER_SIZE / sizeof(*ranges);
 	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd));
-	if (!self->domain_id) {
+	if (!self->stdev_id) {
 		EXPECT_EQ(2, ranges_cmd.num_iovas);
 		EXPECT_EQ(0, ranges[0].start);
 		EXPECT_EQ(PAGE_SIZE - 1, ranges[0].last);
@@ -565,7 +565,7 @@ TEST_F(iommufd_ioas, iova_ranges)
 	/* Buffer too small */
 	memset(ranges, 0, BUFFER_SIZE);
 	ranges_cmd.num_iovas = 1;
-	if (!self->domain_id) {
+	if (!self->stdev_id) {
 		EXPECT_ERRNO(EMSGSIZE, ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES,
 					     &ranges_cmd));
 		EXPECT_EQ(2, ranges_cmd.num_iovas);
@@ -789,7 +789,7 @@ TEST_F(iommufd_ioas, fork_gone)
 	ASSERT_NE(-1, child);
 	ASSERT_EQ(child, waitpid(child, NULL, 0));
 
-	if (self->domain_id) {
+	if (self->stdev_id) {
 		/*
 		 * If a domain already existed then everything was pinned within
 		 * the fork, so this copies from one domain to another.
-- 
2.39.2

