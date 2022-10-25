Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3046360D32D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 20:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiJYSMq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 14:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiJYSMl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 14:12:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729DDB5FFC;
        Tue, 25 Oct 2022 11:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSGJBv3B6VPvviEhtxNZ1Id4KwWKW9or389CKOtHiAKroHxmiRhOCChcoy3MWFQ+LZiGUrLoQyi1EjR9e+68orxc8L1C5QdNUPj9XkI/d3QImfqZonepszsn/uo5jH0mlNGznAtHDXo5fawu0CnnYCLMOvDseIm5U5GFGuTrHLce36Gl9o0VC6rEF1EwLCrghj77gq+lVHTWr0YrLt84pPJvQ296Errf9CGVMjJVG8Wgx1coANZ0O+LwSn07LeQQs7Z8TMeDu5Iq/B9c1oN9vjfvNcvdv7YkkhyKjRMPDtvIemP052xiOUy/hjaWIpeJs4Xjne4leqVBO/wxly8euA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5APcT/YVEmWY6StPinZLnAR66lxoMugoP/yJgZr6esM=;
 b=DTt5PgnVdOeg6At4VCuYlKRc8txX6NZNdQbfSs+BkSpcBDlvm7C/sXpj3T7z++beINJjArFGti5BmQu7y+pYs7aAbqVGb6MngdGJjpl9evKpnLGrnCkrmW9EAXaLrw4ecZLwW5eV7NliVI5+RusKCKoyMX5dQH82Uu7N86cYY8lsUWBYOosj4WcukhI1Afa0w2gj1gFTfokHvIzZr+iSKuVWsUHOOo/f9HiJ/CBoevVhQDFH7gYGweM/qEGZ/03h4eCdjOHWqC1qN0LpnZTfS1wD6byiSZQMNPVnAItRnZU6nnA1fxX47ytNwx/1qt+nkBF43FkXYLjxyNKPhKT42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5APcT/YVEmWY6StPinZLnAR66lxoMugoP/yJgZr6esM=;
 b=gUpFsmZYSAxQOFaYnC1nkArBfwLedBy8G/qmXOqUtYaIe8PhAxDhJ0TUgBe2H67GhJQbBCxJZYlTmoqVCB1IFCfD4FxWKzNnj1GHiHVRBZTEHaBagcKEirwFev8vizw59eNvYvxujS4n1wCVCrF/Jtrb0xqudk0QWURfSHl8Souy6ktovAo8hz5GTap5tgdhBRx1JKZskMpq0wYnLgaCAQ6EAPH6GUPnGYlQsW5qzDxSO1i5Z/HIzYcxeUE/Lg0nOV4TvZTiZT6SDzNNxEXFKRUaord0vqDu2Swhbs/dDs7rUA90vRaLxbCRLSVvGR7E+6fqHAEVrM8eZS0kGJBLiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 25 Oct
 2022 18:12:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 18:12:30 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
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
Subject: [PATCH v3 08/15] iommufd: Algorithms for PFN storage
Date:   Tue, 25 Oct 2022 15:12:17 -0300
Message-Id: <8-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:c0::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 8515f1a3-a8be-42f5-999a-08dab6b47897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 86trc3mjuBDiqUTyKpzi3yb67+R8XVGrPRhUHnLpzrrIjCd2/eiWO/bMvBVlVwioSzB/f9X7rzsIzkOCACi6HnGIRJAnXt2vOPuwMJ97msxrq5IgpVAkGVbTlI4MyrpNy/4UX9yKGHO/QDftiE5yn7YJ9S4mDY65MkpaZzRZe3lUecp+SrwoXioRXMaf4atabR5IHx551p/cMQz39WyCO35WV4EknFVRk+ChXF2xrdJgz7+ffj3OoJO0wuCoayq5kW0V9GCmwReFf/PMoisQuIImWJhGy5Pg33p3TN0/pAjuSgvNHN0J+5yZV8WeeXUlQhTHGPJSFJRfiiglTAFnLKx/7PNtjQd72mFV2SQy8q7rLP1AbnXrdiWtwPr6M9QZHJPRqjCJbPcbT6JKhOT+LG2kI+gqQJc7Z3JQaB4gLYCOvBhhIDmOURdsS45XxfyS4vETanc7KK0rXzQ6b6OW6GwM2Z7zGK02Fmc4X/a8x6R61KdradlRrnaabVJV4If17zuDJH4cADyr6UZPIEJYsBwUjh3FMmYoWZ3mzWcTpIJLG/24CT3/ltcWZPsTusvAjlqhrLwL0445yGxV8NJV76JHDT5pSb0UUAWrpnSvM+2j9EFBICj2eBde2j51s0aBulY07QCk29lzoxrcOXf6v61J01rZgI5TUNo3rBR9R1PXnnHX3xbSiAMwB9+1Ov0LtltQteEdXxIPeB0Kon8H+TnDxkWBhyoB8EyGH0zmSm6/t6GTogICnG2NDcaHqhBGZBZaHoQYdzyj71ODx71CsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(6666004)(316002)(41300700001)(110136005)(36756003)(2616005)(6506007)(54906003)(7406005)(30864003)(7416002)(8936002)(66476007)(83380400001)(5660300002)(26005)(2906002)(4326008)(186003)(66946007)(8676002)(66556008)(6512007)(921005)(6486002)(38100700002)(86362001)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wOzRLECQw8D4pgY90apUcUGCUKXNB88rdPc83JwognGHx0LZonID/wQuJXyz?=
 =?us-ascii?Q?8AYTn5cjq5Cp2qUpGN/l+e3LTlKfuNVYDuVhg7gd9+pJxgBTKYLd4QbPb9oi?=
 =?us-ascii?Q?PiPrj7y5G7NWENqdMqDVFtztUw4JQoLg8Lu3CPg9tcHH2nlCont7qsaNrRKc?=
 =?us-ascii?Q?XqXgmOiUrX2kG1PFeb/YVn5QqsDHl11gBGv7ahdn+VakTwTGvQKgTaZn4Ba/?=
 =?us-ascii?Q?6WbLcV8TJ4+XjzDpMhgHgdYd4xklmZEQq605FfCGv4x30msJlPcuP39WspFN?=
 =?us-ascii?Q?3XdxCmCq7IRi3xWUblCccLqGgkWGJ0GSKZCwKAjH2xWZzEDienjIc8bgMY07?=
 =?us-ascii?Q?BKYNNWMwuN6ChEwmwmvSnCH2jCvXaqGU95cf/QNV2eySYy3kE1vinUc1ci7a?=
 =?us-ascii?Q?7hGplLoP18IGsIXkmIqzt43LnzIRp3SAtqERMjrM85W503uq5jixTyp84CIr?=
 =?us-ascii?Q?Ucc0N3hgDH1b2NqftfmAtRzscSyYK9IeAwg5IT+OeoVWkej9xofjzs0onwjs?=
 =?us-ascii?Q?bSwVAzRYHTYzqmQl8ip9oYsiF0ljbOxxvQkW/hBmMiHo22WtjXeDY/8rENFx?=
 =?us-ascii?Q?Bhw4qXwxXb2FZ38S0iUHqBEy9lDSUy4VdyPmzNwMg6VLX0EZs/8gYJRCIBS9?=
 =?us-ascii?Q?5fDNrVmfQ0/CCw2Z2ofE6gIhqht6Ln42bDaxZfoNgLUaySaU2pmpMwZp1led?=
 =?us-ascii?Q?U/4/hWTQNhfyak1YTQ1Rdx66zwHoGc8AfxMAmYxq5ZUFMCoMBm8nRSSL6rJY?=
 =?us-ascii?Q?OER0UmRRMl+fypB7yFqKEkFzxOB6Uwy5elbxSyuqqruHI9H6PECPu1mFySdV?=
 =?us-ascii?Q?1TKkq7UwqxaTe7sBIGLRA1c/jOtthw/2O8+jS3uYfg5DekZSsTA00g6GVl/V?=
 =?us-ascii?Q?eNGmrZfcNsrEXGB6IQFQazWTO6ToAOY+c96tt+58iaRBmHmYQTQh3oiNEmTh?=
 =?us-ascii?Q?/MXE7xOQS9exKGl/zlK/ZZ4tyr1YXQUNQ3G3qmPkvcPFs4nKse7jBbuCUAxA?=
 =?us-ascii?Q?yubZG9y0PsblwWkZL5kSmydllgg5YtOfe6lynpXqCccYUvKuGX/caLB2jWGb?=
 =?us-ascii?Q?L0dRUuMVk1uDxnPIujUfLX3kglBaY75A6mmg3ojvc/7PLtE9cc/3+ay3QPtB?=
 =?us-ascii?Q?5jsmIEipi/TvTo66jNnfhpJRbxC7dqptyglAcC2jZDuejtz41izB5P/XZu2v?=
 =?us-ascii?Q?4LoPuMf2v/WebwVdkazYpf+Ji4BMGlg+H6m15Vu/6uB3Lcjchqr33RQibCNG?=
 =?us-ascii?Q?/mCw3h9987CttBs49Lx0+MwLLJMKtwh/hh6/cWZHUpcPDJL9l4ssBn81P6bv?=
 =?us-ascii?Q?cv0cfgcpygHSLbVYu8i7pAtKzElOtLnoGY4D+sl0L6zOx2O1wsB72vVfz680?=
 =?us-ascii?Q?z0SAGCVpXA7SLGAZSBgHi6l325iduYZRfNe3HcHkMEbQkZQmuExIF6D4cVAY?=
 =?us-ascii?Q?d1cyx3z7pE9ACT12cnlRxBWFyK5FK4N0onLKQRz6YZs7L92dMzA08sKb8FHE?=
 =?us-ascii?Q?NMYcnp8DqGqgQp602V5aiGrYO1qQU8kvJs12CZOlEmunTW+4QFyM3fZZEKmA?=
 =?us-ascii?Q?OXnKanZhb2ImXtrO9BI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8515f1a3-a8be-42f5-999a-08dab6b47897
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:12:26.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xjjyYoRtxNneBtBsJrFBgLTetXSm5qIIUMe7uwTCB05VCshRUvX9fV2dpHz3oKm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The iopt_pages which represents a logical linear list of full PFNs held in
different storage tiers. Each area points to a slice of exactly one
iopt_pages, and each iopt_pages can have multiple areas and accesses.

The three storage tiers are managed to meet these objectives:

 - If no iommu_domain or in-kerenel access exists then minimal memory
   should be consumed by iomufd
 - If a page has been pinned then an iopt_pages will not pin it again
 - If an in-kernel access exists then the xarray must provide the backing
   storage to avoid allocations on domain removals
 - Otherwise any iommu_domain will be used for storage

In a common configuration with only an iommu_domain the iopt_pages does
not allocate significant memory itself.

The external interface for pages has several logical operations:

  iopt_area_fill_domain() will load the PFNs from storage into a single
  domain. This is used when attaching a new domain to an existing IOAS.

  iopt_area_fill_domains() will load the PFNs from storage into multiple
  domains. This is used when creating a new IOVA map in an existing IOAS

  iopt_pages_add_access() creates an iopt_pages_access that tracks an
  in-kernel access of PFNs. This is some external driver that might be
  accessing the IOVA using the CPU, or programming PFNs with the DMA
  API. ie a VFIO mdev.

  iopt_pages_rw_access() directly perform a memcpy on the PFNs, without
  the overhead of iopt_pages_add_access()

  iopt_pages_fill_xarray() will load PFNs into the xarray and return a
  'struct page *' array. It is used by iopt_pages_access's to extract PFNs
  for in-kernel use. iopt_pages_fill_from_xarray() is a fast path when it
  is known the xarray is already filled.

As an iopt_pages can be referred to in slices by many areas and accesses
it uses interval trees to keep track of which storage tiers currently hold
the PFNs. On a page-by-page basis any request for a PFN will be satisfied
from one of the storage tiers and the PFN copied to target domain/array.

Unfill actions are similar, on a page by page basis domains are unmapped,
xarray entries freed or struct pages fully put back.

Significant complexity is required to fully optimize all of these data
motions. The implementation calculates the largest consecutive range of
same-storage indexes and operates in blocks. The accumulation of PFNs
always generates the largest contiguous PFN range possible to optimize and
this gathering can cross storage tier boundaries. For cases like 'fill
domains' care is taken to avoid duplicated work and PFNs are read once and
pushed into all domains.

The map/unmap interaction with the iommu_domain always works in contiguous
PFN blocks. The implementation does not require or benefit from any
split/merge optimization in the iommu_domain driver.

This design suggests several possible improvements in the IOMMU API that
would greatly help performance, particularly a way for the driver to map
and read the pfns lists instead of working with one driver call per page
to read, and one driver call per contiguous range to store.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.h |  73 +++
 drivers/iommu/iommufd/pages.c        | 803 ++++++++++++++++++++++++++-
 2 files changed, 872 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index b74bf01ffc52c2..083451afcdcf46 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -49,6 +49,14 @@ struct iopt_area {
 	unsigned int num_accesses;
 };
 
+int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages);
+void iopt_area_unfill_domains(struct iopt_area *area, struct iopt_pages *pages);
+
+int iopt_area_fill_domain(struct iopt_area *area, struct iommu_domain *domain);
+void iopt_area_unfill_domain(struct iopt_area *area, struct iopt_pages *pages,
+			     struct iommu_domain *domain);
+void iopt_unmap_domain(struct io_pagetable *iopt, struct iommu_domain *domain);
+
 static inline unsigned long iopt_area_index(struct iopt_area *area)
 {
 	return area->pages_node.start;
@@ -69,6 +77,39 @@ static inline unsigned long iopt_area_last_iova(struct iopt_area *area)
 	return area->node.last;
 }
 
+static inline size_t iopt_area_length(struct iopt_area *area)
+{
+	return (area->node.last - area->node.start) + 1;
+}
+
+#define __make_iopt_iter(name)                                                 \
+	static inline struct iopt_##name *iopt_##name##_iter_first(            \
+		struct io_pagetable *iopt, unsigned long start,                \
+		unsigned long last)                                            \
+	{                                                                      \
+		struct interval_tree_node *node;                               \
+									       \
+		lockdep_assert_held(&iopt->iova_rwsem);                        \
+		node = interval_tree_iter_first(&iopt->name##_itree, start,    \
+						last);                         \
+		if (!node)                                                     \
+			return NULL;                                           \
+		return container_of(node, struct iopt_##name, node);           \
+	}                                                                      \
+	static inline struct iopt_##name *iopt_##name##_iter_next(             \
+		struct iopt_##name *last_node, unsigned long start,            \
+		unsigned long last)                                            \
+	{                                                                      \
+		struct interval_tree_node *node;                               \
+									       \
+		node = interval_tree_iter_next(&last_node->node, start, last); \
+		if (!node)                                                     \
+			return NULL;                                           \
+		return container_of(node, struct iopt_##name, node);           \
+	}
+
+__make_iopt_iter(area)
+
 enum {
 	IOPT_PAGES_ACCOUNT_NONE = 0,
 	IOPT_PAGES_ACCOUNT_USER = 1,
@@ -106,4 +147,36 @@ struct iopt_pages {
 	struct rb_root_cached domains_itree;
 };
 
+struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
+				    bool writable);
+void iopt_release_pages(struct kref *kref);
+static inline void iopt_put_pages(struct iopt_pages *pages)
+{
+	kref_put(&pages->kref, iopt_release_pages);
+}
+
+void iopt_pages_fill_from_xarray(struct iopt_pages *pages, unsigned long start,
+				 unsigned long last, struct page **out_pages);
+int iopt_pages_fill_xarray(struct iopt_pages *pages, unsigned long start,
+			   unsigned long last, struct page **out_pages);
+void iopt_pages_unfill_xarray(struct iopt_pages *pages, unsigned long start,
+			      unsigned long last);
+
+int iopt_pages_add_access(struct iopt_pages *pages, unsigned long start,
+			unsigned long last, struct page **out_pages,
+			unsigned int flags);
+void iopt_pages_remove_access(struct iopt_area *area, unsigned long start,
+			    unsigned long last);
+int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
+			 void *data, unsigned long length, unsigned int flags);
+
+/*
+ * Each interval represents an active iopt_access_pages(), it acts as an
+ * interval lock that keeps the PFNs pinned and stored in the xarray.
+ */
+struct iopt_pages_access {
+	struct interval_tree_node node;
+	refcount_t refcount;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index dd74aea60d2cc3..a09e197524be3b 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -162,6 +162,18 @@ static void iommu_unmap_nofail(struct iommu_domain *domain, unsigned long iova,
 	WARN_ON(ret != size);
 }
 
+static void iopt_area_unmap_domain_range(struct iopt_area *area,
+					 struct iommu_domain *domain,
+					 unsigned long start_index,
+					 unsigned long last_index)
+{
+	unsigned long start_iova = iopt_area_index_to_iova(area, start_index);
+
+	iommu_unmap_nofail(domain, start_iova,
+			   iopt_area_index_to_iova_last(area, last_index) -
+				   start_iova + 1);
+}
+
 static struct iopt_area *iopt_pages_find_domain_area(struct iopt_pages *pages,
 						     unsigned long index)
 {
@@ -182,7 +194,7 @@ static struct iopt_area *iopt_pages_find_domain_area(struct iopt_pages *pages,
  */
 struct pfn_batch {
 	unsigned long *pfns;
-	u16 *npfns;
+	u32 *npfns;
 	unsigned int array_size;
 	unsigned int end;
 	unsigned int total_pfns;
@@ -232,7 +244,7 @@ static int __batch_init(struct pfn_batch *batch, size_t max_pages, void *backup,
 	if (!batch->pfns)
 		return -ENOMEM;
 	batch->array_size = size / elmsz;
-	batch->npfns = (u16 *)(batch->pfns + batch->array_size);
+	batch->npfns = (u32 *)(batch->pfns + batch->array_size);
 	batch_clear(batch);
 	return 0;
 }
@@ -257,10 +269,11 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
 /* true if the pfn could be added, false otherwise */
 static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
 {
-	/* FIXME: U16 is too small */
+	const unsigned int MAX_NPFNS = type_max(typeof(*batch->npfns));
+
 	if (batch->end &&
 	    pfn == batch->pfns[batch->end - 1] + batch->npfns[batch->end - 1] &&
-	    batch->npfns[batch->end - 1] != U16_MAX) {
+	    batch->npfns[batch->end - 1] != MAX_NPFNS) {
 		batch->npfns[batch->end - 1]++;
 		batch->total_pfns++;
 		return true;
@@ -994,3 +1007,785 @@ static int pfn_reader_first(struct pfn_reader *pfns, struct iopt_pages *pages,
 	}
 	return 0;
 }
+
+struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
+				    bool writable)
+{
+	struct iopt_pages *pages;
+
+	/*
+	 * The iommu API uses size_t as the length, and protect the DIV_ROUND_UP
+	 * below from overflow
+	 */
+	if (length > SIZE_MAX - PAGE_SIZE || length == 0)
+		return ERR_PTR(-EINVAL);
+
+	pages = kzalloc(sizeof(*pages), GFP_KERNEL_ACCOUNT);
+	if (!pages)
+		return ERR_PTR(-ENOMEM);
+
+	kref_init(&pages->kref);
+	xa_init_flags(&pages->pinned_pfns, XA_FLAGS_ACCOUNT);
+	mutex_init(&pages->mutex);
+	pages->source_mm = current->mm;
+	mmgrab(pages->source_mm);
+	pages->uptr = (void __user *)ALIGN_DOWN((uintptr_t)uptr, PAGE_SIZE);
+	pages->npages = DIV_ROUND_UP(length + (uptr - pages->uptr), PAGE_SIZE);
+	pages->access_itree = RB_ROOT_CACHED;
+	pages->domains_itree = RB_ROOT_CACHED;
+	pages->writable = writable;
+	if (capable(CAP_IPC_LOCK))
+		pages->account_mode = IOPT_PAGES_ACCOUNT_NONE;
+	else
+		pages->account_mode = IOPT_PAGES_ACCOUNT_USER;
+	pages->source_task = current->group_leader;
+	get_task_struct(current->group_leader);
+	pages->source_user = get_uid(current_user());
+	return pages;
+}
+
+void iopt_release_pages(struct kref *kref)
+{
+	struct iopt_pages *pages = container_of(kref, struct iopt_pages, kref);
+
+	WARN_ON(!RB_EMPTY_ROOT(&pages->access_itree.rb_root));
+	WARN_ON(!RB_EMPTY_ROOT(&pages->domains_itree.rb_root));
+	WARN_ON(pages->npinned);
+	WARN_ON(!xa_empty(&pages->pinned_pfns));
+	mmdrop(pages->source_mm);
+	mutex_destroy(&pages->mutex);
+	put_task_struct(pages->source_task);
+	free_uid(pages->source_user);
+	kfree(pages);
+}
+
+static void
+iopt_area_unpin_domain(struct pfn_batch *batch, struct iopt_area *area,
+		       struct iopt_pages *pages, struct iommu_domain *domain,
+		       unsigned long start_index, unsigned long last_index,
+		       unsigned long *unmapped_end_index,
+		       unsigned long real_last_index)
+{
+	while (start_index <= last_index) {
+		unsigned long batch_last_index;
+
+		if (*unmapped_end_index <= last_index) {
+			unsigned long start =
+				max(start_index, *unmapped_end_index);
+
+			batch_from_domain(batch, domain, area, start,
+					  last_index);
+			batch_last_index = start + batch->total_pfns - 1;
+		} else {
+			batch_last_index = last_index;
+		}
+
+		/*
+		 * unmaps must always 'cut' at a place where the pfns are not
+		 * contiguous to pair with the maps that always install
+		 * contiguous pages. Thus, if we have to stop unpinning in the
+		 * middle of the domains we need to keep reading pfns until we
+		 * find a cut point to do the unmap. The pfns we read are
+		 * carried over and either skipped or integrated into the next
+		 * batch.
+		 */
+		if (batch_last_index == last_index &&
+		    last_index != real_last_index)
+			batch_from_domain_continue(batch, domain, area,
+						   last_index + 1,
+						   real_last_index);
+
+		if (*unmapped_end_index <= batch_last_index) {
+			iopt_area_unmap_domain_range(
+				area, domain, *unmapped_end_index,
+				start_index + batch->total_pfns - 1);
+			*unmapped_end_index = start_index + batch->total_pfns;
+		}
+
+		/* unpin must follow unmap */
+		batch_unpin(batch, pages, 0,
+			    batch_last_index - start_index + 1);
+		start_index = batch_last_index + 1;
+
+		batch_clear_carry(batch,
+				  *unmapped_end_index - batch_last_index - 1);
+	}
+}
+
+static void __iopt_area_unfill_domain(struct iopt_area *area,
+				      struct iopt_pages *pages,
+				      struct iommu_domain *domain,
+				      unsigned long last_index)
+{
+	struct interval_tree_double_span_iter span;
+	unsigned long start_index = iopt_area_index(area);
+	unsigned long unmapped_end_index = start_index;
+	u64 backup[BATCH_BACKUP_SIZE];
+	struct pfn_batch batch;
+
+	lockdep_assert_held(&pages->mutex);
+
+	batch_init_backup(&batch, last_index + 1, backup, sizeof(backup));
+	interval_tree_for_each_double_span(&span, &pages->domains_itree,
+					   &pages->access_itree, start_index,
+					   last_index) {
+		if (span.is_used) {
+			batch_skip_carry(&batch,
+					 span.last_used - span.start_used + 1);
+			continue;
+		}
+		iopt_area_unpin_domain(&batch, area, pages, domain,
+				       span.start_hole, span.last_hole,
+				       &unmapped_end_index, last_index);
+	}
+	if (unmapped_end_index != last_index + 1)
+		iopt_area_unmap_domain_range(area, domain, unmapped_end_index,
+					     last_index);
+	WARN_ON(batch.total_pfns);
+	batch_destroy(&batch, backup);
+	update_unpinned(pages);
+}
+
+static void iopt_area_unfill_partial_domain(struct iopt_area *area,
+					    struct iopt_pages *pages,
+					    struct iommu_domain *domain,
+					    unsigned long end_index)
+{
+	if (end_index != iopt_area_index(area))
+		__iopt_area_unfill_domain(area, pages, domain, end_index - 1);
+}
+
+/**
+ * iopt_unmap_domain() - Unmap without unpinning PFNs in a domain
+ * @iopt: The iopt the domain is part of
+ * @domain: The domain to unmap
+ *
+ * The caller must know that unpinning is not required, usually because there
+ * are other domains in the iopt.
+ */
+void iopt_unmap_domain(struct io_pagetable *iopt, struct iommu_domain *domain)
+{
+	struct interval_tree_span_iter span;
+
+	interval_tree_for_each_span(&span, &iopt->area_itree, 0, ULONG_MAX)
+		if (!span.is_hole)
+			iommu_unmap_nofail(domain, span.start_used,
+					   span.last_used - span.start_used +
+						   1);
+}
+
+/**
+ * iopt_area_unfill_domain() - Unmap and unpin PFNs in a domain
+ * @area: IOVA area to use
+ * @pages: page supplier for the area (area->pages is NULL)
+ * @domain: Domain to unmap from
+ *
+ * The domain should be removed from the domains_itree before calling. The
+ * domain will always be unmapped, but the PFNs may not be unpinned if there are
+ * still accesses.
+ */
+void iopt_area_unfill_domain(struct iopt_area *area, struct iopt_pages *pages,
+			     struct iommu_domain *domain)
+{
+	__iopt_area_unfill_domain(area, pages, domain,
+				  iopt_area_last_index(area));
+}
+
+/**
+ * iopt_area_fill_domain() - Map PFNs from the area into a domain
+ * @area: IOVA area to use
+ * @domain: Domain to load PFNs into
+ *
+ * Read the pfns from the area's underlying iopt_pages and map them into the
+ * given domain. Called when attaching a new domain to an io_pagetable.
+ */
+int iopt_area_fill_domain(struct iopt_area *area, struct iommu_domain *domain)
+{
+	struct pfn_reader pfns;
+	int rc;
+
+	lockdep_assert_held(&area->pages->mutex);
+
+	rc = pfn_reader_first(&pfns, area->pages, iopt_area_index(area),
+			      iopt_area_last_index(area));
+	if (rc)
+		return rc;
+
+	while (!pfn_reader_done(&pfns)) {
+		rc = batch_to_domain(&pfns.batch, domain, area,
+				     pfns.batch_start_index);
+		if (rc)
+			goto out_unmap;
+
+		rc = pfn_reader_next(&pfns);
+		if (rc)
+			goto out_unmap;
+	}
+
+	rc = pfn_reader_update_pinned(&pfns);
+	if (rc)
+		goto out_unmap;
+	goto out_destroy;
+
+out_unmap:
+	iopt_area_unfill_partial_domain(area, area->pages, domain,
+					pfns.batch_start_index);
+out_destroy:
+	pfn_reader_destroy(&pfns);
+	return rc;
+}
+
+/**
+ * iopt_area_fill_domains() - Install PFNs into the area's domains
+ * @area: The area to act on
+ * @pages: The pages associated with the area (area->pages is NULL)
+ *
+ * Called during area creation. The area is freshly created and not inserted in
+ * the domains_itree yet. PFNs are read and loaded into every domain held in the
+ * area's io_pagetable and the area is installed in the domains_itree.
+ *
+ * On failure all domains are left unchanged.
+ */
+int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
+{
+	struct pfn_reader pfns;
+	struct iommu_domain *domain;
+	unsigned long unmap_index;
+	unsigned long index;
+	int rc;
+
+	lockdep_assert_held(&area->iopt->domains_rwsem);
+
+	if (xa_empty(&area->iopt->domains))
+		return 0;
+
+	mutex_lock(&pages->mutex);
+	rc = pfn_reader_first(&pfns, pages, iopt_area_index(area),
+			      iopt_area_last_index(area));
+	if (rc)
+		goto out_unlock;
+
+	while (!pfn_reader_done(&pfns)) {
+		xa_for_each(&area->iopt->domains, index, domain) {
+			rc = batch_to_domain(&pfns.batch, domain, area,
+					     pfns.batch_start_index);
+			if (rc)
+				goto out_unmap;
+		}
+
+		rc = pfn_reader_next(&pfns);
+		if (rc)
+			goto out_unmap;
+	}
+	rc = pfn_reader_update_pinned(&pfns);
+	if (rc)
+		goto out_unmap;
+
+	area->storage_domain = xa_load(&area->iopt->domains, 0);
+	interval_tree_insert(&area->pages_node, &pages->domains_itree);
+	goto out_destroy;
+
+out_unmap:
+	xa_for_each(&area->iopt->domains, unmap_index, domain) {
+		unsigned long end_index = pfns.batch_start_index;
+
+		if (unmap_index <= index)
+			end_index = pfns.batch_end_index;
+
+		/*
+		 * The area is not yet part of the domains_itree so we have to
+		 * manage the unpinning specially. The last domain does the
+		 * unpin, every other domain is just unmapped.
+		 */
+		if (unmap_index != area->iopt->next_domain_id - 1) {
+			if (end_index != iopt_area_index(area))
+				iopt_area_unmap_domain_range(
+					area, domain, iopt_area_index(area),
+					end_index - 1);
+		} else {
+			iopt_area_unfill_partial_domain(area, pages, domain,
+							end_index);
+		}
+	}
+out_destroy:
+	pfn_reader_destroy(&pfns);
+out_unlock:
+	mutex_unlock(&pages->mutex);
+	return rc;
+}
+
+/**
+ * iopt_area_unfill_domains() - unmap PFNs from the area's domains
+ * @area: The area to act on
+ * @pages: The pages associated with the area (area->pages is NULL)
+ *
+ * Called during area destruction. This unmaps the iova's covered by all the
+ * area's domains and releases the PFNs.
+ */
+void iopt_area_unfill_domains(struct iopt_area *area, struct iopt_pages *pages)
+{
+	struct io_pagetable *iopt = area->iopt;
+	struct iommu_domain *domain;
+	unsigned long index;
+
+	lockdep_assert_held(&iopt->domains_rwsem);
+
+	mutex_lock(&pages->mutex);
+	if (!area->storage_domain)
+		goto out_unlock;
+
+	xa_for_each(&iopt->domains, index, domain)
+		if (domain != area->storage_domain)
+			iopt_area_unmap_domain_range(
+				area, domain, iopt_area_index(area),
+				iopt_area_last_index(area));
+
+	interval_tree_remove(&area->pages_node, &pages->domains_itree);
+	iopt_area_unfill_domain(area, pages, area->storage_domain);
+	area->storage_domain = NULL;
+out_unlock:
+	mutex_unlock(&pages->mutex);
+}
+
+/**
+ * iopt_pages_unfill_xarray() - Update the xarry after removing an access
+ * @pages: The pages to act on
+ * @start_index: Starting PFN index
+ * @last_index: Last PFN index
+ *
+ * Called when an iopt_pages_access is removed, removes pages from the itree.
+ * The access should already be removed from the access_itree.
+ */
+void iopt_pages_unfill_xarray(struct iopt_pages *pages,
+			      unsigned long start_index,
+			      unsigned long last_index)
+{
+	struct interval_tree_double_span_iter span;
+	u64 backup[BATCH_BACKUP_SIZE];
+	struct pfn_batch batch;
+	bool batch_inited = false;
+
+	lockdep_assert_held(&pages->mutex);
+
+	interval_tree_for_each_double_span(&span, &pages->access_itree,
+					   &pages->domains_itree, start_index,
+					   last_index) {
+		if (!span.is_used) {
+			if (!batch_inited) {
+				batch_init_backup(&batch,
+						  last_index - start_index + 1,
+						  backup, sizeof(backup));
+				batch_inited = true;
+			}
+			batch_from_xarray_clear(&batch, &pages->pinned_pfns,
+						span.start_hole,
+						span.last_hole);
+			batch_unpin(&batch, pages, 0, batch.total_pfns);
+			batch_clear(&batch);
+		} else if (span.is_used == 2) {
+			/* Covered by a domain */
+			clear_xarray(&pages->pinned_pfns, span.start_used,
+				     span.last_used);
+		}
+		/* Otherwise covered by an existing access */
+	}
+	if (batch_inited)
+		batch_destroy(&batch, backup);
+	update_unpinned(pages);
+}
+
+/**
+ * iopt_pages_fill_from_xarray() - Fast path for reading PFNs
+ * @pages: The pages to act on
+ * @start_index: The first page index in the range
+ * @last_index: The last page index in the range
+ * @out_pages: The output array to return the pages
+ *
+ * This can be called if the caller is holding a refcount on an
+ * iopt_pages_access that is known to have already been filled. It quickly reads
+ * the pages directly from the xarray.
+ *
+ * This is part of the SW iommu interface to read pages for in-kernel use.
+ */
+void iopt_pages_fill_from_xarray(struct iopt_pages *pages,
+				 unsigned long start_index,
+				 unsigned long last_index,
+				 struct page **out_pages)
+{
+	XA_STATE(xas, &pages->pinned_pfns, start_index);
+	void *entry;
+
+	rcu_read_lock();
+	while (start_index <= last_index) {
+		entry = xas_next(&xas);
+		if (xas_retry(&xas, entry))
+			continue;
+		WARN_ON(!xa_is_value(entry));
+		*(out_pages++) = pfn_to_page(xa_to_value(entry));
+		start_index++;
+	}
+	rcu_read_unlock();
+}
+
+static int iopt_pages_fill_from_domain(struct iopt_pages *pages,
+				       unsigned long start_index,
+				       unsigned long last_index,
+				       struct page **out_pages)
+{
+	while (start_index != last_index + 1) {
+		unsigned long domain_last;
+		struct iopt_area *area;
+
+		area = iopt_pages_find_domain_area(pages, start_index);
+		if (WARN_ON(!area))
+			return -EINVAL;
+
+		domain_last = min(iopt_area_last_index(area), last_index);
+		out_pages = raw_pages_from_domain(area->storage_domain, area,
+						  start_index, domain_last,
+						  out_pages);
+		start_index = domain_last + 1;
+	}
+	return 0;
+}
+
+static int iopt_pages_fill_from_mm(struct iopt_pages *pages,
+				   struct pfn_reader_user *user,
+				   unsigned long start_index,
+				   unsigned long last_index,
+				   struct page **out_pages)
+{
+	unsigned long cur_index = start_index;
+	int rc;
+
+	while (cur_index != last_index + 1) {
+		user->upages = out_pages + (cur_index - start_index);
+		rc = pfn_reader_user_pin(user, pages, cur_index, last_index);
+		if (rc)
+			goto out_unpin;
+		cur_index = user->upages_end;
+	}
+	return 0;
+
+out_unpin:
+	if (start_index != cur_index)
+		iopt_pages_err_unpin(pages, start_index, cur_index - 1,
+				     out_pages);
+	return rc;
+}
+
+/**
+ * iopt_pages_fill_xarray() - Read PFNs
+ * @pages: The pages to act on
+ * @start_index: The first page index in the range
+ * @last_index: The last page index in the range
+ * @out_pages: The output array to return the pages, may be NULL
+ *
+ * This populates the xarray and returns the pages in out_pages. As the slow
+ * path this is able to copy pages from other storage tiers into the xarray.
+ *
+ * On failure the xarray is left unchanged.
+ *
+ * This is part of the SW iommu interface to read pages for in-kernel use.
+ */
+int iopt_pages_fill_xarray(struct iopt_pages *pages, unsigned long start_index,
+			   unsigned long last_index, struct page **out_pages)
+{
+	struct interval_tree_double_span_iter span;
+	unsigned long xa_end = start_index;
+	struct pfn_reader_user user;
+	int rc;
+
+	pfn_reader_user_init(&user, pages);
+	user.upages_len = last_index - start_index + 1;
+	interval_tree_for_each_double_span(&span, &pages->access_itree,
+					   &pages->domains_itree, start_index,
+					   last_index) {
+		struct page **cur_pages;
+
+		if (span.is_used == 1) {
+			cur_pages = out_pages + (span.start_used - start_index);
+			iopt_pages_fill_from_xarray(pages, span.start_used,
+						    span.last_used, cur_pages);
+			continue;
+		}
+
+		if (span.is_used == 2) {
+			cur_pages = out_pages + (span.start_used - start_index);
+			iopt_pages_fill_from_domain(pages, span.start_used,
+						    span.last_used, cur_pages);
+			rc = pages_to_xarray(&pages->pinned_pfns,
+					     span.start_used, span.last_used,
+					     cur_pages);
+			if (rc)
+				goto out_clean_xa;
+			xa_end = span.last_used + 1;
+			continue;
+		}
+
+		/* hole */
+		cur_pages = out_pages + (span.start_hole - start_index);
+		rc = iopt_pages_fill_from_mm(pages, &user, span.start_hole,
+					     span.last_hole, cur_pages);
+		if (rc)
+			goto out_clean_xa;
+		rc = pages_to_xarray(&pages->pinned_pfns, span.start_hole,
+				     span.last_hole, cur_pages);
+		if (rc) {
+			iopt_pages_err_unpin(pages, span.start_hole,
+					     span.last_hole, cur_pages);
+			goto out_clean_xa;
+		}
+		xa_end = span.last_hole + 1;
+	}
+	rc = pfn_reader_user_update_pinned(&user, pages);
+	if (rc)
+		goto out_clean_xa;
+	user.upages = NULL;
+	pfn_reader_user_destroy(&user, pages);
+	return 0;
+
+out_clean_xa:
+	if (start_index != xa_end)
+		iopt_pages_unfill_xarray(pages, start_index, xa_end - 1);
+	user.upages = NULL;
+	pfn_reader_user_destroy(&user, pages);
+	return rc;
+}
+
+/*
+ * This can do everything and is fully coherent with what a iommu_domain would
+ * see.
+ */
+static int iopt_pages_rw_slow(struct iopt_pages *pages,
+			      unsigned long start_index,
+			      unsigned long last_index, unsigned long offset,
+			      void *data, unsigned long length,
+			      unsigned int flags)
+{
+	struct pfn_reader pfns;
+	int rc;
+
+	mutex_lock(&pages->mutex);
+
+	rc = pfn_reader_first(&pfns, pages, start_index, last_index);
+	if (rc)
+		goto out_unlock;
+
+	while (!pfn_reader_done(&pfns)) {
+		unsigned long done;
+
+		done = batch_rw(&pfns.batch, data, offset, length, flags);
+		data += done;
+		length -= done;
+		offset = 0;
+		pfn_reader_unpin(&pfns);
+
+		rc = pfn_reader_next(&pfns);
+		if (rc)
+			goto out_destroy;
+	}
+	if (WARN_ON(length != 0))
+		rc = -EINVAL;
+out_destroy:
+	pfn_reader_destroy(&pfns);
+out_unlock:
+	mutex_unlock(&pages->mutex);
+	return rc;
+}
+
+/*
+ * A medium speed path that still allows DMA decoherence, but doesn't do any
+ * memory allocations or interval tree searches.
+ */
+static int iopt_pages_rw_page(struct iopt_pages *pages, unsigned long index,
+			      unsigned long offset, void *data,
+			      unsigned long length, unsigned int flags)
+{
+	struct page *page = NULL;
+	int rc;
+
+	if (!mmget_not_zero(pages->source_mm))
+		return iopt_pages_rw_slow(pages, index, index, offset, data,
+					  length, flags);
+
+	mmap_read_lock(pages->source_mm);
+	rc = pin_user_pages_remote(
+		pages->source_mm, (uintptr_t)(pages->uptr + index * PAGE_SIZE),
+		1, (flags & IOMMUFD_ACCESS_RW_WRITE) ? FOLL_WRITE : 0, &page,
+		NULL, NULL);
+	mmap_read_unlock(pages->source_mm);
+	if (rc != 1) {
+		if (WARN_ON(rc >= 0))
+			rc = -EINVAL;
+		goto out_mmput;
+	}
+	copy_data_page(page, data, offset, length, flags);
+	unpin_user_page(page);
+	rc = 0;
+
+out_mmput:
+	mmput(pages->source_mm);
+	return rc;
+}
+
+/**
+ * iopt_pages_rw_access - Copy to/from a linear slice of the pages
+ * @pages: pages to act on
+ * @start_byte: First byte of pages to copy to/from
+ * @data: Kernel buffer to get/put the data
+ * @length: Number of bytes to copy
+ * @flags: IOMMUFD_ACCESS_RW_* flags
+ *
+ * This will find each page in the range, kmap it and then memcpy to/from
+ * the given kernel buffer.
+ */
+int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
+			 void *data, unsigned long length, unsigned int flags)
+{
+	unsigned long start_index = start_byte / PAGE_SIZE;
+	unsigned long last_index = (start_byte + length - 1) / PAGE_SIZE;
+	bool change_mm = current->mm != pages->source_mm;
+	int rc = 0;
+
+	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
+		return -EPERM;
+
+	if (!(flags & IOMMUFD_ACCESS_RW_KTHREAD) && change_mm) {
+		if (start_index == last_index)
+			return iopt_pages_rw_page(pages, start_index,
+						  start_byte % PAGE_SIZE, data,
+						  length, flags);
+		return iopt_pages_rw_slow(pages, start_index, last_index,
+					  start_byte % PAGE_SIZE, data, length,
+					  flags);
+	}
+
+	/*
+	 * Try to copy using copy_to_user(). We do this as a fast path and
+	 * ignore any pinning decoherence, unlike a real DMA path.
+	 */
+	if (change_mm) {
+		if (!mmget_not_zero(pages->source_mm))
+			return iopt_pages_rw_slow(pages, start_index,
+						  last_index,
+						  start_byte % PAGE_SIZE, data,
+						  length, flags);
+		kthread_use_mm(pages->source_mm);
+	}
+
+	if (flags & IOMMUFD_ACCESS_RW_WRITE) {
+		if (copy_to_user(pages->uptr + start_byte, data, length))
+			rc = -EFAULT;
+	} else {
+		if (copy_from_user(data, pages->uptr + start_byte, length))
+			rc = -EFAULT;
+	}
+
+	if (change_mm) {
+		kthread_unuse_mm(pages->source_mm);
+		mmput(pages->source_mm);
+	}
+
+	return rc;
+}
+
+static struct iopt_pages_access *
+iopt_pages_get_exact_access(struct iopt_pages *pages, unsigned long index,
+			    unsigned long last)
+{
+	struct interval_tree_node *node;
+
+	lockdep_assert_held(&pages->mutex);
+
+	/* There can be overlapping ranges in this interval tree */
+	for (node = interval_tree_iter_first(&pages->access_itree, index, last);
+	     node; node = interval_tree_iter_next(node, index, last))
+		if (node->start == index && node->last == last)
+			return container_of(node, struct iopt_pages_access,
+					    node);
+	return NULL;
+}
+
+/**
+ * iopt_pages_add_access() - Record an in-knerel access for PFNs
+ * @pages: The source of PFNs
+ * @start_index: First page index
+ * @last_index: Inclusive last page index
+ * @out_pages: Output list of struct page's representing the PFNs
+ * @flags: IOMMUFD_ACCESS_RW_* flags
+ *
+ * Record that an in-kernel access will be accessing the pages, ensure they are
+ * pinned, and return the PFNs as a simple list of 'struct page *'.
+ *
+ * This should be undone through a matching call to iopt_pages_remove_access()
+ */
+int iopt_pages_add_access(struct iopt_pages *pages, unsigned long start_index,
+			  unsigned long last_index, struct page **out_pages,
+			  unsigned int flags)
+{
+	struct iopt_pages_access *access;
+	int rc;
+
+	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
+		return -EPERM;
+
+	access = iopt_pages_get_exact_access(pages, start_index, last_index);
+	if (access) {
+		refcount_inc(&access->refcount);
+		iopt_pages_fill_from_xarray(pages, start_index, last_index,
+					    out_pages);
+		return 0;
+	}
+
+	access = kzalloc(sizeof(*access), GFP_KERNEL_ACCOUNT);
+	if (!access)
+		return -ENOMEM;
+
+	rc = iopt_pages_fill_xarray(pages, start_index, last_index, out_pages);
+	if (rc)
+		goto out_free;
+
+	access->node.start = start_index;
+	access->node.last = last_index;
+	refcount_set(&access->refcount, 1);
+	interval_tree_insert(&access->node, &pages->access_itree);
+	return 0;
+
+out_free:
+	kfree(access);
+	return rc;
+}
+
+/**
+ * iopt_pages_remove_access() - Release an in-kernel access for PFNs
+ * @area: The source of PFNs
+ * @start_index: First page index
+ * @last_index: Inclusive last page index
+ *
+ * Undo iopt_pages_add_access() and unpin the pages if necessary. The caller
+ * must stop using the PFNs before calling this.
+ */
+void iopt_pages_remove_access(struct iopt_area *area, unsigned long start_index,
+			      unsigned long last_index)
+{
+	struct iopt_pages_access *access;
+	struct iopt_pages *pages = area->pages;
+
+	mutex_lock(&pages->mutex);
+	access = iopt_pages_get_exact_access(pages, start_index, last_index);
+	if (WARN_ON(!access))
+		goto out_unlock;
+
+	WARN_ON(area->num_accesses == 0);
+	area->num_accesses--;
+
+	if (!refcount_dec_and_test(&access->refcount))
+		goto out_unlock;
+
+	interval_tree_remove(&access->node, &pages->access_itree);
+	iopt_pages_unfill_xarray(pages, start_index, last_index);
+	kfree(access);
+out_unlock:
+	mutex_unlock(&pages->mutex);
+}
-- 
2.38.0

