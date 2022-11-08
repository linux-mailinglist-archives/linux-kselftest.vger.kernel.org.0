Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E5A620505
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiKHAt0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiKHAtX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:49:23 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8910025C5B;
        Mon,  7 Nov 2022 16:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSjnjg+7M1t5PP6RmiNNOjmmPDMRPQBTa3XNJP0hBzg269ksC42zQexx2p3qIp097r/5bMwdjTN7DYVfG4a0xP5yG3TwUIrLj1ufILiPC0TLJhidEGZW7Kj+oI5v27wgIn+EdZ3aWi7SVTYGP7Y8SfpGoZypD/haT2trJvwZhfzz9pBq/6/irYW3U+Lz1Pk/n3TW9HtIt1vbJ3qoQ3dtd/CZIgjRC5vh6Etiy6Rm+s78P/3l5uf5JArJp7EqfuxU/lqeTYnCTwG81Jy/3P+5ha+rF1EfjnCkWo6zifMtqNZDfqq/2bU2LoRzcG/NrOmQ/P7bgaVsJokcKNVWcknwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tCX21g5roqVRV8fAgjvp/BV1QbrAZq4X/8B2sXphOc=;
 b=agcR2GX/d5ddd682zOqWATmCZaNEn7oOPQRG9JETtPgU2QIWAZfMcjNxbs6wgJOJcVRj4MUWIggPDJVUasMaPkLBKObE0OFukXWUD6K3N5JN7tu2Nv3Uhl7wQ+wLXG3phCS/r47q9m4Ii8guP3bfcoFpm3aN9nWhxTfbeH4ThaxYe4Enqdok4zV27S1ESndkUqttgzYRyb4uDtI0W3SL8WGCoZZTJsnRbKT2t0zuRiuh9SZ9uwEmYcEWD8KzUtNrUAETxSW7Sb1tmbYvqdH9qeI/qHMfLXGh0MHw28Pi2OSJ8WjbWuhW5z89Gul2Vjqh1MotFhK0yw6WtvKm3dzzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tCX21g5roqVRV8fAgjvp/BV1QbrAZq4X/8B2sXphOc=;
 b=k1U00hW27QUoMAGV56PZRpbzgBu1Brfex63pEp/6Czl5bfu7NtAtOamXh+ngf0JBAlUocmzd8i73zpwH1T17xqx5DmpDmqCHJXyQQbtzdD98Z6YDuG89LoCsW7wiBea0cPmstKxoWiLYPE5gLDvI7WGotohJaweAId2XYNNn0KI4WYylVgX2FVOO+9+p3PTEUSrMuHAsL4ERIhufypgScZThjadR12lo/jNx8PExH9S2npjaW1y5NVkRu1DCto3xHbfvjX9k9MYnJCiFoRFA4dIKKcHlYws66mvSyFg5gEhhT81WRBr4O9JrVAhUnfmTNm5uYJwlK9A+H99wm7ILMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:49:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:49:15 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v4 16/17] iommufd: Add some fault injection points
Date:   Mon,  7 Nov 2022 20:49:09 -0400
Message-Id: <16-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:207:3c::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: a2577718-59c9-4763-912c-08dac1230d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKXRoLRtssYeZIykUPUExgUBtNEufT13litGvalDV05SbgIVKmtUv80NmAcEUAmoLh7Qv4q/jSdqqM/HuESpTSKJpUKyq4bFhWKLN9bnhPY40LtJT/SIsqlBSKZZqpMyr82CzFguppVFzHbC4Yd35fKZDV7yyn9ImRSkCXS+iGBsA/yJboXNG3Q4Qb+kT/9Wc+HIAIuLXuXJpM7YWdyGSHX3olC+9oZFStugB6O3e0dM3ReLMt3qopxXUtdbtvqGd54v/8KogZD1Twf/rdq2PEsi6pjkUboC88gBdvUuuC2/tHiMq1UNfZwTtKPBbs5sOVMhvWqx64IvRsyCejJbvWocRzUhhD3V7sijfS+XAO3jhcMK+fycooglIXC50rt1vNEQvdp4IgeRkKyo/07W4lU9hUSFA/ZCOjKBzUsvWC8j4bSb6vgKyoPPh1Gg7LF6nm2lguogKOWqh1U22HgzwqTGc23e32krXLCSSQg7+mOiPMzmuijacM2HG7X1Pxfz7prcnsC2DsT3cmPBBtUTExNiNvsbpvmcV1J6O4F3a+hCYbt8UZgFfNPF+6m7CmBFZOLMr8YMv5htjZZxb6j696dywUY4kyNhquiFsRepPDwI/zV9RaeLOupYczD9g4C97mDXutS6h3fdb8V8lZbJvGbbpeopW/nB3qW9S751mFUDmFr+i5iRLDphvK9OXAaWqWJthTz+DR8OczybvTLt2/X/fdlXXboxGkyRh6E4SmX51iySGOTgIDNyIpUGRni4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199015)(8676002)(54906003)(110136005)(66476007)(8936002)(7416002)(5660300002)(7406005)(2906002)(38100700002)(316002)(66946007)(41300700001)(66556008)(4326008)(186003)(2616005)(83380400001)(6486002)(478600001)(6512007)(26005)(6666004)(6506007)(86362001)(921005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yg1yHx45PaXr3saIbn+mzvivKDMDWYkVpHf6jdHx+TeYQd21lHYmCPxuNeav?=
 =?us-ascii?Q?ognvsGT2XepotYZJZochwEGhA9j5EX8BTmurbAMXgcVhmpqb6pYKMGPdxmSH?=
 =?us-ascii?Q?ZhI01LC7FidzY/knU98cLQ07P7eaCzKHxRIzS4ec/oEgqu3hY3mjhRSs43D/?=
 =?us-ascii?Q?dgdVsY7kBrFZFt0FdJSgggaKfg/63WXRjbI1Pxp1JgJ30oqorS1cyYLalMqO?=
 =?us-ascii?Q?4Fdz9LatkqUvZDGUaAbFIAEpWcVlSwDAuAUifnT9fmUocyTfz640YRqN42Wr?=
 =?us-ascii?Q?VogAp9h7d5QG5/rRJg9O3GKL7uKBgzYWy1KC1dTex/9pPjaU8JN9RL1E+9D0?=
 =?us-ascii?Q?5TJKheevrQIMK2zziGyE6B+tDEeFPK9f0ifCAULt2aHWD0jHaEW+F9eoYtj1?=
 =?us-ascii?Q?FtmFguhpw2wuImgT8t4plncwZCxJpLJ2dfbj/mYqRI+ub3tmV9rO68hRCpGb?=
 =?us-ascii?Q?kOwk1pusMLbQIbWj8wyo16twGBP9tUnm8TAW28FVdbun/TC0ocuVd4o91g30?=
 =?us-ascii?Q?1K6rzH02UEWIjQ9VRXUGOv414z5IKDC/sbwAex4s3SRbCOufUSzll6+VSaHH?=
 =?us-ascii?Q?Egmz2yyurn1qgd+5Sl/4Phglhb+JHFLwoivBQkYRDmaR5BNmQxDLi2x2Exhe?=
 =?us-ascii?Q?emsN26du5ACjQ3V4DSegzreaOTxRMY9eiufHk1ShHZ4TKbkhLnN1JyA8LPV7?=
 =?us-ascii?Q?tKuyEJXaDb60lOKS/OVam5JGpmoPtmQT8lJCHWqyk5VT65k3vfUGx4MEz9/O?=
 =?us-ascii?Q?ZHDib6FBvZkRPeo4isHvE/+l/X7j8Dv510OUl5UCnt37f6mwa5GvIl+bbX+g?=
 =?us-ascii?Q?u8VTT/Gdo1zQIi8vbIeSQ1HjFQHV5NEYI3f1aFYEMsuf0roE4gAKmNvLPshw?=
 =?us-ascii?Q?lD7aUgauaRf31eEDj7ExziEODOCqOn+KZQs9EBihfLbZrfNhmZ/xUTp+tmIe?=
 =?us-ascii?Q?S27nAyLxpbtcC5BKfUXK1+NRCWGGZCP8YwapK0flVqFZJCfTviObyzclwdYp?=
 =?us-ascii?Q?EPK+00RXwDYb2eryb3S7HdKiHxsVA99evXfgJHXLIHH6oq0shUpmurAKjv/D?=
 =?us-ascii?Q?1RAHM6NBunyIhGz5JQNAbYpkLGkrqia7xP2L7T8PHcrOeMjyVJGxcSJQ+bNk?=
 =?us-ascii?Q?s9iXfVoUH0mmsSKECJry8s3h/OkdVPpbhgFsoGb/JlaFoejPi05XcHI3BO7S?=
 =?us-ascii?Q?FEEFtc9EkIo2nTj7h3KcH4+1SWki8LO6wN7SBzTvQGffUQhoGcggW74DtP3G?=
 =?us-ascii?Q?RYO3RtGaU+J0jL1p2cB1nCce1U0k3dkUypmCKatNDR0ecmbwbyYd203flqNB?=
 =?us-ascii?Q?NYZUAfkS5qXngalpDLoGl2FAdiNHrOrOMTdeyTJEFy1xETt4IR9pYZaACd3o?=
 =?us-ascii?Q?Zwp+WknbAufOHd9ZmqP6IIZ2ftblcfe4F52OVVZlQl1P64AqlYckXjbbyjMq?=
 =?us-ascii?Q?Q9CBGkbz3X1O8s5SqQP2SvfCrRAFFnsbSaytqTlT84UjyMYpCm0bXV6g5wda?=
 =?us-ascii?Q?rCS8T/xaJo2KpJu21UKO/7XE1l+dTFwp9rco5/Pixzk0JRlmD04vJzuYo44x?=
 =?us-ascii?Q?H+v0mctQZskljM3Le+s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2577718-59c9-4763-912c-08dac1230d34
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:49:11.7473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lk/7toKGIXFYC8pSxR1ptq0XI+ialBSXtfoKhznaJ3ZzOx1vYLA0C+KjglG0Y50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This increases the coverage the fail_nth test gets, as well as via
syzkaller.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/main.c  |  3 +++
 drivers/iommu/iommufd/pages.c | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 7de0f95f2ee68a..ab3fa05f38505d 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -102,6 +102,9 @@ struct iommufd_object *iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
 {
 	struct iommufd_object *obj;
 
+	if (iommufd_should_fail())
+		return ERR_PTR(-ENOENT);
+
 	xa_lock(&ictx->objects);
 	obj = xa_load(&ictx->objects, id);
 	if (!obj || (type != IOMMUFD_OBJ_ANY && obj->type != type) ||
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index c3783ea01d7996..2ddcb0d4f71e04 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -80,6 +80,10 @@ static void *temp_kmalloc(size_t *size, void *backup, size_t backup_len)
 
 	if (*size < backup_len)
 		return backup;
+
+	if (!backup && iommufd_should_fail())
+		return NULL;
+
 	*size = min_t(size_t, *size, TEMP_MEMORY_LIMIT);
 	res = kmalloc(*size, GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY);
 	if (res)
@@ -482,6 +486,7 @@ static int pages_to_xarray(struct xarray *xa, unsigned long start_index,
 			   unsigned long last_index, struct page **pages)
 {
 	struct page **end_pages = pages + (last_index - start_index) + 1;
+	struct page **half_pages = pages + (end_pages - pages) / 2;
 	XA_STATE(xas, xa, start_index);
 
 	do {
@@ -489,6 +494,15 @@ static int pages_to_xarray(struct xarray *xa, unsigned long start_index,
 
 		xas_lock(&xas);
 		while (pages != end_pages) {
+			/* xarray does not participate in fault injection */
+			if (pages == half_pages && iommufd_should_fail()) {
+				xas_set_err(&xas, -EINVAL);
+				xas_unlock(&xas);
+				/* aka xas_destroy() */
+				xas_nomem(&xas, GFP_KERNEL);
+				goto err_clear;
+			}
+
 			old = xas_store(&xas, xa_mk_value(page_to_pfn(*pages)));
 			if (xas_error(&xas))
 				break;
@@ -499,6 +513,7 @@ static int pages_to_xarray(struct xarray *xa, unsigned long start_index,
 		xas_unlock(&xas);
 	} while (xas_nomem(&xas, GFP_KERNEL));
 
+err_clear:
 	if (xas_error(&xas)) {
 		if (xas.xa_index != start_index)
 			clear_xarray(xa, start_index, xas.xa_index - 1);
@@ -662,6 +677,10 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 	npages = min_t(unsigned long, last_index - start_index + 1,
 		       user->upages_len / sizeof(*user->upages));
 
+
+	if (iommufd_should_fail())
+		return -EFAULT;
+
 	uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
 	if (!remote_mm)
 		rc = pin_user_pages_fast(uptr, npages, user->gup_flags,
@@ -806,6 +825,8 @@ static int pfn_reader_user_update_pinned(struct pfn_reader_user *user,
 		npages = pages->last_npinned - pages->npinned;
 		inc = false;
 	} else {
+		if (iommufd_should_fail())
+			return -ENOMEM;
 		npages = pages->npinned - pages->last_npinned;
 		inc = true;
 	}
@@ -1636,6 +1657,11 @@ static int iopt_pages_rw_page(struct iopt_pages *pages, unsigned long index,
 		return iopt_pages_rw_slow(pages, index, index, offset, data,
 					  length, flags);
 
+	if (iommufd_should_fail()) {
+		rc = -EINVAL;
+		goto out_mmput;
+	}
+
 	mmap_read_lock(pages->source_mm);
 	rc = pin_user_pages_remote(
 		pages->source_mm, (uintptr_t)(pages->uptr + index * PAGE_SIZE),
-- 
2.38.1

