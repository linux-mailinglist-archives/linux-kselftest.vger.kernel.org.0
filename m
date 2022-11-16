Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A0162CC02
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiKPVDY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbiKPVCA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:02:00 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9791C418;
        Wed, 16 Nov 2022 13:01:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bd6rlDIkCtjhcOCasNgOUZT9DwhNbDaCFQ28ryxD9aFa3lBL0oAhR6WmGw5DvPUp5zjcx/Lt06j7tKvARyZw862Aqna068fKL5uqzY0rAKK1t/20wqXSEZYoY22+7gTqcI2ZCxV6zRxDvwJb0wWJ6JfMx1NrY0tfBfqNKmmFgDzUzV9mYpBjeGDkqjGfCv8VO8jApTtFTvAnKPsCRXQA5hdG7zq7urUX3pTXzX/jc8oFoB/J+iR+BWMdrw+oJPoYbB1jpqHp8JK5X+ufQFVYcedAUQB02Ju/W07Gz0vdvNvdSMZsBUhBCJq7GHLqw4UjU0DA3NqC5QUHe2UaPTR+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W88SO10xccdsqF+CcdZ13NTL2mvdBP1SakI2v1PQROo=;
 b=EkGqqd2VLVJHEx9sLA1goPVn2+bjSKKpsqNheJh3Qan+7nXCPJ6zHovI8rW5bqSlW2MaROPklhj/9KjCF+s6d6Gt8CyWD00oWjCvblKaHA2ObGXwD2HGAxpeMvalXsA2QHaBupvsiFbLTsIHXAWFAYa79me5SvmWioPuO0oqLFATelYkzxvZr5bcGvhGNxA3HaPSZY/VNcNEmP0huRCISw6lembFRAr6ARNt9sreG4FmxyBsFDBrHrnVIHVeQ/NcPVs+CqbAnHI/dbe3fYhP0ih+H8mUL13sIC32x4w+dWf3OesWdg6MwHd5EPg6y+P30fAPjGBp7n+TYTS4etL3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W88SO10xccdsqF+CcdZ13NTL2mvdBP1SakI2v1PQROo=;
 b=leVkLoIKuDBgr8/0w4XdBkf1RlTvQ/18fyMVVGSgtxI06KnBfCTJIpVrPqxhTUNPbHSTylFxPp50tJFe/R2086KkSv4ICfK+DY3UzuHg8whoy7/77FAnYNETowa3vrrUul9CFKH1AozwnQk+i9Tp49G0fzyj7gZVW9qFB4dKi++FrtOYfq09gXx6TzaBpvniSa2MKKbUQ4LOZuVtn+jezGtvdZawlAUmWrMlssaKRwo7mtzOEwsFVsXr+m0BSAHZ7H/ix4UWqvqdLMgmcs5jnpU/SgIR/YQKFn6X/QR5KN+15Kp1aSpSMyF5CCpLXYIjFTLHtZhk8RB/trjbiVNpEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:01:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:01:03 +0000
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
Subject: [PATCH v5 18/19] iommufd: Add additional invariant assertions
Date:   Wed, 16 Nov 2022 17:00:54 -0400
Message-Id: <18-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0031.namprd19.prod.outlook.com
 (2603:10b6:208:178::44) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: dfff7a07-df26-43af-50a8-08dac815a91c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X8jTGjzqysHrSErq1UZ5RTfQsL4dBuXVK49p1vr317uOJvfFL25HApsSU0iS4aRbL8B+YQhgmx7ge3Oejz2/oYfFeR8ornRnSQQwaua9Ekh9h+v0ssjFVuW4he/ysZm1BfRFlpofnLEXVTna9NX89TucTx6IttUDf8Ffi7fQivPorOkIpzDK+j1Y5t1P3O9B72qrrVqGndg1B0DtcIytzva4z1cQ8sNdb2UxmH4odzCGVd5+Ta444u4c4o1+WrobU1IUhjMqV/3erltUSoKWMCYllD1WI13aEMexMdM7moeEERbzYYsFlz0VvRb/CdB9mGE0Hu3D/k/TmIBEZi9tyRMTCDx8nff/xUM4kBMyzLIaa1114ihmZrdF1oWVqGBp0VdxK9IV6+Ldn7CM8llZZS7lZ1FgRagPEhIh6vOBJEYnHM19ra2x1URPOnRSqDV57r4YP5sh4gPuSQq0OeoK4dIFFva+E1O1KRU0okmeOhjdP9ZlLZ7Yp9DHj/XvUqV66B015Ai0TI+D1Bb7UIdbgH7p54uS0tqeADZZfGnP4OcHDvPTe5YRU+5JBnGhGX9xWKLQFfbl1lSnwwBbp81uMboT7jdaqK38GCWmFsmzebwNviUm+HkR6q/GotrEQUiQQa8BxV5MAWsLzzwheYFdcyY5A77aJgfLG3t4PqYak55e1iKCSAGBwOfYOMiZfSQ7fq0zx7HB1/9ysQjvAQS3Hr56/VPHbiTOuchoelgW8VBMi3CoZVh1m11cyAib2o0G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(36756003)(41300700001)(4326008)(8676002)(66556008)(6486002)(186003)(66476007)(86362001)(66946007)(2616005)(478600001)(26005)(316002)(6666004)(110136005)(54906003)(6506007)(921005)(6512007)(83380400001)(2906002)(7406005)(7416002)(8936002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vmkUw53w5AZs3VT0lVqEH6xQXYIXdKr5kl14XAMZpIz4CYojkKtmQCEhIL11?=
 =?us-ascii?Q?INXInABr3zxyHy96TXNZ3ofsdHuJWAbsbsmvsl4pUkxss8NcJeHqFsMQC9rR?=
 =?us-ascii?Q?kZfXfZfAopyaOcf0yo6F8O6+deYgoV2bWa2DZtRrdZAi//plLfU4/sAu5Hk8?=
 =?us-ascii?Q?ewwP7eI962pPAj+PHM/H9N8cORxGMiTJFjVARWT9qzHp0AhV52EWcDmvkWQs?=
 =?us-ascii?Q?KwKRkn8+hJud0XOJxTClFr+BZZIfXLbTMMToG1VL44/FoQsf/VOksQ9ygi8A?=
 =?us-ascii?Q?nveQxCQS2fCKqgcENdep9xF+P/O0ENthhY6jdhdtdqVttl1CDW0CgNtW2mTX?=
 =?us-ascii?Q?FMctdbb8nK5Yt7rjEFMSBQqu8rgWKwWhPLycnuSasqlxPFKyPqnl/No+mAY2?=
 =?us-ascii?Q?osgTcOcXQrzm4TcxFFXPI9Z5vQUTAbgrDHM3GzAYt9rzJD7h/59aV6bbXI07?=
 =?us-ascii?Q?U8xuiOGHvHlkw7ZLjJPpPT3Illz0NxOb9rvB7bDLXi+HrkP4yKUmT06mlQFS?=
 =?us-ascii?Q?SL5d1gJPSP8wL0c2RTTvs5GHVabmfs8dKM6T7LUllEQKW3H1KE0c7XKUmCUj?=
 =?us-ascii?Q?TtRJNNG/jJ7XByOmpW51MKuR5+n21FZNA+Oijgc7j5qmAAaWFpupxsNjqe2c?=
 =?us-ascii?Q?/Y9wLkdu630iQZCkSW4laMLDmsBR7FICBzibW7euDBCN0EksulB2P+8kv608?=
 =?us-ascii?Q?VMS0dk1fWfrjnLHdExxhAmaGquHUK9cDWg3cCf2rt64BOd1/Dssa4HZI/Fgp?=
 =?us-ascii?Q?EOiPV5ppOCLLEpE4dXesYPKQ5bU/7r9xFt1gXF5N/6/hDw6QSI5xIRHPHrZd?=
 =?us-ascii?Q?xGA5pxvKiJdxYd0zcCCIPDnD5VZvRKbrJag9+cRB2giwgvA3ctyXQK0OZRui?=
 =?us-ascii?Q?2JBBuqPxb031BL0zzCpuPaGvaYaP1mMfK7nbDm5gn2uFHOvN28PM6solpbUf?=
 =?us-ascii?Q?VWrT5a4PrfCm0kFdpc7kWC/20xUSct2X+s5+CoxRm+Wp0v4TAhD6wLADkVUj?=
 =?us-ascii?Q?qdSr134iR0YdODenJGemuT1LYN6lxeSxel+NiErN1Tk2tup9+jU3O66tzinn?=
 =?us-ascii?Q?GAgvj8qPbNVUDZ9xkwSNMX4wJYRs5uk+C753YVPDowRaJ5Pwe9+gfXiGR6YL?=
 =?us-ascii?Q?BX2S/sk6TJZR9oxOe3bnqPZWwV9rEzS5pBHEt3TkMHJzWhDM09K8iI2fAXu/?=
 =?us-ascii?Q?SCN/0dJ10Yjg4bEggE//D213Di6CsPIPP66/xA6neXRKjq75FQK24rFxLsOp?=
 =?us-ascii?Q?WZFHr6vzVP6ecEFZo2mW9matLj/emOSQUmKMZAHmS+e2ru3XlOFnuuHDf54d?=
 =?us-ascii?Q?hxL/AmV3bTd+FLgKnH9whe6bTOeJ5z9UUGqrBuo1oVZdt50ZkSEYe9rO/V4c?=
 =?us-ascii?Q?prNKcbKXJmzyRhgKGTh3JNeGmO884UAT0NULhsiYMkUDZVzmZer7gPVUw8gc?=
 =?us-ascii?Q?TyMrzs7+GM7TiDOztNClIySlRBcIY+/BzrX7WyqYazl1teAxbT70oeU+wgtN?=
 =?us-ascii?Q?FXPNSPBUEXYiNJcbqNcHdlPj7unxY3hGprGL9+Ark/wzexTsbQFjCgs6izo8?=
 =?us-ascii?Q?u8rYmk6iPjg/qDACn0E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfff7a07-df26-43af-50a8-08dac815a91c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:58.7160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmRZ208yYKiAApvL1JCEfaOkyxrp+ZlxzRkelI5CDZVoORIyf3d/OeQGNQwkcS4R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These are on performance paths so we protect them using the
CONFIG_IOMMUFD_TEST to not take a hit during normal operation.

These are useful when running the test suite and syzkaller to find data
structure inconsistencies early.

Tested-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com> # s390
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c       |  5 ++++
 drivers/iommu/iommufd/io_pagetable.c | 22 +++++++++++++++
 drivers/iommu/iommufd/io_pagetable.h |  3 ++
 drivers/iommu/iommufd/pages.c        | 42 ++++++++++++++++++++++++++--
 4 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a9105237ec4131..07d4dcc0dbf5e1 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -621,6 +621,11 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 	struct iopt_area *area;
 	int rc;
 
+	/* Driver's ops don't support pin_pages */
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+	    WARN_ON(access->iova_alignment != PAGE_SIZE || !access->ops->unmap))
+		return -EINVAL;
+
 	if (!length)
 		return -EINVAL;
 	if (check_add_overflow(iova, length - 1, &last_iova))
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 4f4a9d9aac570e..3467cea795684c 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -251,6 +251,11 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 			(uintptr_t)elm->pages->uptr + elm->start_byte, length);
 		if (rc)
 			goto out_unlock;
+		if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+		    WARN_ON(iopt_check_iova(iopt, *dst_iova, length))) {
+			rc = -EINVAL;
+			goto out_unlock;
+		}
 	} else {
 		rc = iopt_check_iova(iopt, *dst_iova, length);
 		if (rc)
@@ -277,6 +282,8 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 
 static void iopt_abort_area(struct iopt_area *area)
 {
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(area->pages);
 	if (area->iopt) {
 		down_write(&area->iopt->iova_rwsem);
 		interval_tree_remove(&area->node, &area->iopt->area_itree);
@@ -642,6 +649,9 @@ void iopt_destroy_table(struct io_pagetable *iopt)
 {
 	struct interval_tree_node *node;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		iopt_remove_reserved_iova(iopt, NULL);
+
 	while ((node = interval_tree_iter_first(&iopt->allowed_itree, 0,
 						ULONG_MAX))) {
 		interval_tree_remove(node, &iopt->allowed_itree);
@@ -688,6 +698,8 @@ static void iopt_unfill_domain(struct io_pagetable *iopt,
 				continue;
 
 			mutex_lock(&pages->mutex);
+			if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+				WARN_ON(!area->storage_domain);
 			if (area->storage_domain == domain)
 				area->storage_domain = storage_domain;
 			mutex_unlock(&pages->mutex);
@@ -792,6 +804,16 @@ static int iopt_check_iova_alignment(struct io_pagetable *iopt,
 		    (iopt_area_length(area) & align_mask) ||
 		    (area->page_offset & align_mask))
 			return -EADDRINUSE;
+
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST)) {
+		struct iommufd_access *access;
+		unsigned long index;
+
+		xa_for_each(&iopt->access_list, index, access)
+			if (WARN_ON(access->iova_alignment >
+				    new_iova_alignment))
+				return -EADDRINUSE;
+	}
 	return 0;
 }
 
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 2ee6942c3ef4a5..83e7c175f2a277 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -101,6 +101,9 @@ static inline size_t iopt_area_length(struct iopt_area *area)
 static inline unsigned long iopt_area_start_byte(struct iopt_area *area,
 						 unsigned long iova)
 {
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(iova < iopt_area_iova(area) ||
+			iova > iopt_area_last_iova(area));
 	return (iova - iopt_area_iova(area)) + area->page_offset +
 	       iopt_area_index(area) * PAGE_SIZE;
 }
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index c5d2d9a8c56203..429fa3b0a239cd 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -162,12 +162,20 @@ void interval_tree_double_span_iter_next(
 
 static void iopt_pages_add_npinned(struct iopt_pages *pages, size_t npages)
 {
-	pages->npinned += npages;
+	int rc;
+
+	rc = check_add_overflow(pages->npinned, npages, &pages->npinned);
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(rc || pages->npinned > pages->npages);
 }
 
 static void iopt_pages_sub_npinned(struct iopt_pages *pages, size_t npages)
 {
-	pages->npinned -= npages;
+	int rc;
+
+	rc = check_sub_overflow(pages->npinned, npages, &pages->npinned);
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(rc || pages->npinned > pages->npages);
 }
 
 static void iopt_pages_err_unpin(struct iopt_pages *pages,
@@ -189,6 +197,9 @@ static void iopt_pages_err_unpin(struct iopt_pages *pages,
 static unsigned long iopt_area_index_to_iova(struct iopt_area *area,
 					     unsigned long index)
 {
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(index < iopt_area_index(area) ||
+			index > iopt_area_last_index(area));
 	index -= iopt_area_index(area);
 	if (index == 0)
 		return iopt_area_iova(area);
@@ -198,6 +209,9 @@ static unsigned long iopt_area_index_to_iova(struct iopt_area *area,
 static unsigned long iopt_area_index_to_iova_last(struct iopt_area *area,
 						  unsigned long index)
 {
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(index < iopt_area_index(area) ||
+			index > iopt_area_last_index(area));
 	if (index == iopt_area_last_index(area))
 		return iopt_area_last_iova(area);
 	return iopt_area_iova(area) - area->page_offset +
@@ -286,6 +300,8 @@ static void batch_skip_carry(struct pfn_batch *batch, unsigned int skip_pfns)
 {
 	if (!batch->total_pfns)
 		return;
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(batch->total_pfns != batch->npfns[0]);
 	skip_pfns = min(batch->total_pfns, skip_pfns);
 	batch->pfns[0] += skip_pfns;
 	batch->npfns[0] -= skip_pfns;
@@ -301,6 +317,8 @@ static int __batch_init(struct pfn_batch *batch, size_t max_pages, void *backup,
 	batch->pfns = temp_kmalloc(&size, backup, backup_len);
 	if (!batch->pfns)
 		return -ENOMEM;
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) && WARN_ON(size < elmsz))
+		return -EINVAL;
 	batch->array_size = size / elmsz;
 	batch->npfns = (u32 *)(batch->pfns + batch->array_size);
 	batch_clear(batch);
@@ -429,6 +447,10 @@ static int batch_iommu_map_small(struct iommu_domain *domain,
 	unsigned long start_iova = iova;
 	int rc;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(paddr % PAGE_SIZE || iova % PAGE_SIZE ||
+			size % PAGE_SIZE);
+
 	while (size) {
 		rc = iommu_map(domain, iova, paddr, PAGE_SIZE, prot);
 		if (rc)
@@ -718,6 +740,10 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 	uintptr_t uptr;
 	long rc;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+	    WARN_ON(last_index < start_index))
+		return -EINVAL;
+
 	if (!user->upages) {
 		/* All undone in pfn_reader_destroy() */
 		user->upages_len =
@@ -956,6 +982,10 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 	struct iopt_area *area;
 	int rc;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+	    WARN_ON(span->last_used < start_index))
+		return -EINVAL;
+
 	if (span->is_used == 1) {
 		batch_from_xarray(&pfns->batch, &pfns->pages->pinned_pfns,
 				  start_index, span->last_used);
@@ -1008,6 +1038,10 @@ static int pfn_reader_next(struct pfn_reader *pfns)
 	while (pfns->batch_end_index != pfns->last_index + 1) {
 		unsigned int npfns = pfns->batch.total_pfns;
 
+		if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+		    WARN_ON(interval_tree_double_span_iter_done(&pfns->span)))
+			return -EINVAL;
+
 		rc = pfn_reader_fill_span(pfns);
 		if (rc)
 			return rc;
@@ -1091,6 +1125,10 @@ static int pfn_reader_first(struct pfn_reader *pfns, struct iopt_pages *pages,
 {
 	int rc;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+	    WARN_ON(last_index < start_index))
+		return -EINVAL;
+
 	rc = pfn_reader_init(pfns, pages, start_index, last_index);
 	if (rc)
 		return rc;
-- 
2.38.1

