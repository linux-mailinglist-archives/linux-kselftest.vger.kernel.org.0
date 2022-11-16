Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A1B62CBE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiKPVCx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbiKPVB6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:01:58 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288D96A6B3;
        Wed, 16 Nov 2022 13:01:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORvtD2X2xvB3P5Aq2nIkNjjluL2vqRIpQB7+r5FDZkA2qpnNPmS3QteVy8Aja6IcawWelZl717d887AbJ3X4hCDoB7n5ra3szMxVkqDTlUyOeUUOEdgaHizbDU11nRaFiKED3/OZnu6OKFyrRTl9bj3BhKdSypqg24nrYxH5QDefJwWYjex+I64j6zAH5MBkuSJS9NmT/2rn9BbAe585hDCR+rP5XLbIkkqX/RSUju35J3Xv/T6P1zm9px7DuW6PVR5aVkQsUih/lBb+jFr6u+L9/kHXMEcHrAcn6+3Dwy/8gDBaFcWuQwBzDezlgx7s7Bpv1azV9dCCAKqUrAQ5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM0J8I+cDDsR7EFJ2KWf9L5XHLZ6bTPo+155hHNKXoU=;
 b=UXnLk1yrlJKLbknNjs//FiJQ0r6JlSa0ja35IubT4Ecc8JlpBetfofVd0StahSwQyW07I/ixF7/JLhLziNgFiQTDCIxFkMIp5/JVY4yeQf9VkQaU1ekBJ8x6f9N3/zihMbEDejVDv1p/a9G/irpWCpYK60YTjaYlVoOy5olVNvY9dxEViKy/YmjCtEZfNLZeqK4dXQS3njxjnvAaiZJmJ7G20NaboAofFqbTkcxFGlp9o5/7DEENzWlTbQNtvVoeLh3sjY3rQWKl24qVF1DhJVEXTXn9PgVPHj5jEtAx0hmlWYQoYnF+iJqv4A79DtpVXCbb/q+I5wxiZ2ECXpnnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gM0J8I+cDDsR7EFJ2KWf9L5XHLZ6bTPo+155hHNKXoU=;
 b=TbZYuhmvDbaq96BRaokjR1ieAzhlk5BBs4Ot+XDWRkPhw37SeEZytWybBL7JILyeStjwRQ9RUjW1ebHVHa1qNGepTBmg/Ffn67sUJaGbViFnizfSuU10Xn+lHtfNFfz0F05hMvQGDUkWhNXJKozfFD/yURPdNMkM6cD57LeX7f9XOIBt2DMjgdQWpIBqoCb+G9XFzQGn5BiFThb9tu84tVGTswEA3h9tf8SC9rCALBUkS1Bj90MQET6SX5oZ3X8v4ViaXrV/2tYNSNK4ZODkMX/Z3Rv6+Kc83+rJwpu/PhMgSddIuhnnIqljqqbitvRH1BYvyGLaXW8fjwuJUn9Zpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:01:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:01:01 +0000
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
Cc:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v5 17/19] iommufd: Add some fault injection points
Date:   Wed, 16 Nov 2022 17:00:53 -0400
Message-Id: <17-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:208:a8::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f882a76-b704-4733-2fce-08dac815a8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XPJP9iHnyUhgwoMbogEjhX3owrLd+1c7GpFEwEGguqikB8cTh3YpYjEV0A1wUa/ZhjgH73an0HCzbMSUcSHr+SxEJ1/QWd0R+IrW7R54IX84fwCrtkt1QLvukC8pnYcQlkyjoE5nE1oWfTCj38APMvNt+N/8R5xTtDf8zCsCQcfIyHzWnuhKIyPHuB82gOjpyOcy2YZfx51XK/mBO4MNQrTrYqStju1V4JONtZ7tc5zIn2XKjOdy/Olx7j/BoWwOVtSmAKAt9LzcXH0CWHiwLGWdsxQmpLphI51dUlrOHtTOgngTB06IITl+Z29TAFy3mVu97U3TTKDm9cVMAdPiq0tafLw9S2HgrhdujI96j+IFqbUpxvAIr0EP3+YraECjfGF9FN2S6NfjllksaCKgewhhUe7lqggOckJjyIszNrpf7of5Kn59uQc79n7E4WwidvSJgXVxAMCP/1+DYJRwFP5DI2L1suCoLaHvgJRj+zuXAvkquBC5Dp6z2PFYIW45EcECe+3F0pO0IMkiVOeqNGd5pbdQ/p9P//4N7j7ou9wWPFxbmbgdyfi08NWVfkA6+Yub4j7ybm57CyarIV+uG0FFlakyZaUznAOhJ06exC4/5M9uZemlLMBwBCVyi/4SInRn9mm5LFf1wFxNbhCyJruzCc6085Voc1FvfV4Tv9DZCYKg8LP/QgHvihT0fj74KZteU70/Y/noDdnF1Zyj9XEhZc/nTcy5YSPnga4kWgSwKnQggS4vnqeMO6Xsa6o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199015)(478600001)(36756003)(38100700002)(6486002)(921005)(83380400001)(86362001)(7416002)(8936002)(6666004)(7406005)(5660300002)(186003)(2906002)(66476007)(4326008)(8676002)(66946007)(66556008)(110136005)(6506007)(2616005)(26005)(6512007)(316002)(54906003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tv5gu0IXQPDXq1Xyp6IWo1mMdmuaw2W/JqaCIgByA8WJcobW/y+Qjft9xaWq?=
 =?us-ascii?Q?lIHz/7tdIGT2fZN0TB+WqVp32dg5Z5QJq1L3VfJxUnJf25u+NfYYcAPRxP21?=
 =?us-ascii?Q?DcrqshpKE5vb7g++T4bZjYoWlelrOasFg0ENq3GqThNQcphRJxX5LdCuL69W?=
 =?us-ascii?Q?PQ9yhMg8x7riD5cku8nDXjMycz/vy9j/DT5wUutaiPCfUMpM9TPiPLsZreIz?=
 =?us-ascii?Q?8iopapI6yt5KnTByrEw39zlGrydDA2UPtqGITeju6ZY+EedzlI+1AVasEL/B?=
 =?us-ascii?Q?3H3CpN+7a8E+KAbBiKg8hPjYe51Bp9klc2UWSYDB9XeAL8P61i79gR4Zqeit?=
 =?us-ascii?Q?Qhkof8LxZqh7fS77ChPp+RQU+qs2QdBJDJk9/1MaldKdcR18KbUJHQxNZG9T?=
 =?us-ascii?Q?ZiFrWwzsEfWiheYT6hRMjbZysuXBvbfjLMnTm5H3Ig7KfcEAyRCH3MKkzP+R?=
 =?us-ascii?Q?OJqBtxIa4vq7zQ1qVeJSoo1/AKK0uqdeYDFSK91Gc7PUK+isgbktWqB69jY+?=
 =?us-ascii?Q?fIpdkUCZ5Q1su1xaqi5+oIKoy5mYiy3RSbBd1N8v4rtKZb/mWH68Zx0UyJDS?=
 =?us-ascii?Q?m4j6dzOF2agpbn9n2SBUN8nAvRtNJWDVylwhXrg/q1sOpxiTkAAleHp8pzQT?=
 =?us-ascii?Q?cNS1R7JE0gTYQ68SsQtWzQJBGtTsLHG3E2j1Vum8QbceMJO8ozZ+WQZ0pFso?=
 =?us-ascii?Q?80RLngnzXoOCsIyTwBI3r5nvOUS5SG7nORg+R/eYaQrH/28jUywXu1t5QtR5?=
 =?us-ascii?Q?XGleveEBgT14hFTuhMHKRx21Ysnn2rQvZiBXsKJyD5LtVu4oI2PJaNOfdNA4?=
 =?us-ascii?Q?0H+3n5hmLkhU5q2DqGGu/R1MLXkvp9nQYFPdMVUE+yaun4jeTHaLJ3FheBWk?=
 =?us-ascii?Q?cRKfKRTjlovQmiaykQNbw3MHEGwv+VOArkDNmf7imws3Hkn/42rGb0x3w+Gk?=
 =?us-ascii?Q?MplofOVlve/VOZGgteHjriniBaZ5ezl2QRDuk5x0rhTJ8vxFegg1FHgmAXNn?=
 =?us-ascii?Q?htstoPQpXm4EvR7MYPgiybCqzoV+4oPWqwjJ6U/ORsLKd+aOEqJcNp5v5MgO?=
 =?us-ascii?Q?PfTR7bZazm3aClggUKIJeA388K5JYmH+PNYtgu1rUyl14L8Q7dczemM+bt2f?=
 =?us-ascii?Q?f12SBGAPqjXrNunuYfuY//j/Rn11B83D915kcNRuiyrwrYvCF41nUOowrYgg?=
 =?us-ascii?Q?dVGk1eC5F8JoSeD5JzFLHlE/uy1BuDQDROr/8+ENaYNNWPWZfSVg6Rla+I+B?=
 =?us-ascii?Q?QaIHf8weZfdiuh1v5RVNgXcXklHXJXm/J85Hoj3PtXeSDs6P5hZJ8dU5LON9?=
 =?us-ascii?Q?UrHK7kVnHV9pWwUar3TaZpdrraDzOdJ56TXVFANV//p1+CkvxPqotNztgeGB?=
 =?us-ascii?Q?hQgyq00Fy1iBQ2GSsbpKhL19KBk0TgIa6Bo6UPt6XvjRFcW4ffbJmnIGIaWx?=
 =?us-ascii?Q?Ko2nAomQ+tWVts//KVwoK08yeD9Y5invkEbJxYANrpfPArrvlQHHouw4axYc?=
 =?us-ascii?Q?8i4lWzDHQvE1UIDM8A/Lh1QrTBcLyaaUmbKGv1bnclNBNHZSJEdGjFmDc6J7?=
 =?us-ascii?Q?2Dfqw8GhpmLw6iU8LBQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f882a76-b704-4733-2fce-08dac815a8d7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:58.2014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZ6ILNYt87Pjlw6ecqactw6bnfLaUWjyIyOJwWrdyvd0GqZb/rwdVnkezpt52f5+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4936
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

Tested-by: Matthew Rosato <mjrosato@linux.ibm.com> # s390
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
index 640331b8a07919..c5d2d9a8c56203 100644
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
@@ -544,6 +548,7 @@ static int pages_to_xarray(struct xarray *xa, unsigned long start_index,
 			   unsigned long last_index, struct page **pages)
 {
 	struct page **end_pages = pages + (last_index - start_index) + 1;
+	struct page **half_pages = pages + (end_pages - pages) / 2;
 	XA_STATE(xas, xa, start_index);
 
 	do {
@@ -551,6 +556,15 @@ static int pages_to_xarray(struct xarray *xa, unsigned long start_index,
 
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
@@ -561,6 +575,7 @@ static int pages_to_xarray(struct xarray *xa, unsigned long start_index,
 		xas_unlock(&xas);
 	} while (xas_nomem(&xas, GFP_KERNEL));
 
+err_clear:
 	if (xas_error(&xas)) {
 		if (xas.xa_index != start_index)
 			clear_xarray(xa, start_index, xas.xa_index - 1);
@@ -728,6 +743,10 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 	npages = min_t(unsigned long, last_index - start_index + 1,
 		       user->upages_len / sizeof(*user->upages));
 
+
+	if (iommufd_should_fail())
+		return -EFAULT;
+
 	uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
 	if (!remote_mm)
 		rc = pin_user_pages_fast(uptr, npages, user->gup_flags,
@@ -872,6 +891,8 @@ static int pfn_reader_user_update_pinned(struct pfn_reader_user *user,
 		npages = pages->last_npinned - pages->npinned;
 		inc = false;
 	} else {
+		if (iommufd_should_fail())
+			return -ENOMEM;
 		npages = pages->npinned - pages->last_npinned;
 		inc = true;
 	}
@@ -1721,6 +1742,11 @@ static int iopt_pages_rw_page(struct iopt_pages *pages, unsigned long index,
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

