Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76D46204F5
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiKHAtV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiKHAtU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:49:20 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8DA1FF9E;
        Mon,  7 Nov 2022 16:49:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0b5wVcJlA7HYk0M8fMkfSW/tQ+t4gahzqdP6ZxwNyNFay391m4nhPR1G4cE4KNls6uqr7ENg4O2bEv3OjaACGMwVHjZQsI2nuwghXvWAhdPcPKAwpUwlWde1DmadrZY4wHbgcBohyRIXZI66EANSv39Vu8WrvG4lNCEygJt6/+NxGEEH3jLU5jOkigT3toHDr3A9ZkRgo0Dj0WfdiLAXX7phIPm2n1X23B0qjT/h5dkPp20n4Z2yGDLP3sud/9Y07I2+VnUeil2+itwnoYl4PkHNXLasDnh3SeOgD1pttjUAQYPq8ueVkIxFC8+HJwRTXc4hkP0anmqSPe1zZr/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zfo1nweUziXTIC46MzaVsd6gCPm7DhMdYDgTF0tBuF0=;
 b=Y8cxy/bImnF9bGEM+dknsjA7QX6OhRXUcdpgBRsnHmQQe0yjD/JORqo/eOol+11MPqRGwtXIW+vKsem2EE01FE6Nui6yktW6lv19d6js5PGjG2WZitLDl8yQAn6fq+u8W5rRLte9ZXjMY37G+tUVKClIbrMWjVZpWJ5wsxgSBmgYZHLbd6W30s3Al/BtDnF1TeYy0J6qyioxIYciaEaBCoTE+nqxOLv7ShhrvtkD4PCu3kOdIe68TcExk7EZEantqlonfcu9X4K7wUGp1zS14RB6FnB3jkXYrK5NWiSI48K/RQfcaQ4gVWcxaRjH8qiE3+diBz+sKMuWOMzJeoLW/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zfo1nweUziXTIC46MzaVsd6gCPm7DhMdYDgTF0tBuF0=;
 b=Wf51TWsyEO0C3tVBJ2lzwO3BBIYK+E1M81AoeFF4/gDJG+VG2WYpdtvna5kDJ/IxUvoHi0vSdlYis0F3V30eElfFC7RBpK3BJP32B2pOvBkbTuyyIO9YQrsK2LhdP7Ix9liSDNCCwdaQhU+c0Wi5WbLPtD0n26YJ+328+px+bhLme5ABFw7fNXpP2UaDkrV0UqntfcWcV5mX9o230v/cKNgB3BTT7ljlkNRLtAGiZoJ9YpvPjQjjO9RH185YQIGf9LID5YNoGrA9owNpPGZDoTCnBw53t7gfUw1CKTfSlWT12hxlgNqygE/q/d2xar1/x4+H6eR+fiuqyJjb97ylWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:49:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:49:14 +0000
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
Subject: [PATCH v4 08/17] iommufd: Algorithms for PFN storage
Date:   Mon,  7 Nov 2022 20:49:01 -0400
Message-Id: <8-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0034.namprd16.prod.outlook.com
 (2603:10b6:208:134::47) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8807e4-77ea-45f7-46b3-08dac1230d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxksgMJvckXS4WuCl2Nt1pF0n4W4cCC7AoM0nMQMtfQtJ164vlMHzIi97188mDKbMSgQsGTT5K0pq26G7TCkSTls1ee0esDNv8YLKnRpotSqEtp8b9meKeTh/gjpPLKqPvi6Z3brUOBlWr+MiRxgfTcRZ40bB7OWwCtGTijSgKOO4lTRj0TcVRvs5GYa5mUEQ3oycc50+LgTN772/VJHKsDYyyuH2xnaoEdoUt5AQXvU9Cr40ioe38WCakUR2UP8EG0gq/nsLZQP9g17e+yRJAv+7tkn93+Lbp2Vc2rFR3rlm3nxomcO02ZjWbyD5XaTw0/ln0xWKNLbCI4AnXZVoa3HkWA+edPdA/P6JV/f1pj1oAXetht2EDgKqupAR+vzIyTfrYLeMW7504nhZXPEorkAFqV/aH+kcesxviicAPVPZ9AqJxaf+EWOlRCOmWvbOiEVwZWI8v6qylYIFB4j4FqBQ98DMT/5pacCPVp85a4LesG1oAHmwJEx3hQTjxdCfkwVKrGFGxofau60wyRNEk7osRzpIDyQaCMQ3jDNRmnatatdyAj0MtJcQJqv4tbe93sCH0a9FxFcUOpEoV/eKwFFf2uP0wnrhrXiAiD2i+Zofne/+IKG0W5cu6jQ7MCdsKJVNpNUg3WhZGsRNFkXbipWoAIsDFZlz/sApO00jpHg6amaosmPtTW9IVE7LgjNUOH1fIELM1GxB/mrdC+8tNbA6uGqb4uoeouQ9LVf+5H6Dz3yE67LrqkIzPFeIYOpEXxbqhQMVasIJ5NFlr1hmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199015)(30864003)(8676002)(54906003)(110136005)(66476007)(8936002)(7416002)(5660300002)(7406005)(2906002)(38100700002)(316002)(66946007)(41300700001)(66556008)(4326008)(186003)(2616005)(83380400001)(6486002)(478600001)(6512007)(26005)(6666004)(6506007)(86362001)(921005)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MtcL4M9q+FPYPnQPlygw5zgKRT6NnOzPg7HYOCxDCBi+4iAKZFjp8/77zklx?=
 =?us-ascii?Q?eBa3TaGxgbI/ne8nzF8tR7lpScdQ1Mfcfh90kE0jzp7I6jTOSz2flb+ThKOz?=
 =?us-ascii?Q?lSB26cvcvmyE84oq4qTDXu8vaHtR9E/aN545UheMtBgfSDoqf1yNkZ8Ocr+w?=
 =?us-ascii?Q?ywfHzG+eiWmYzyeecZvR/+FYXBS2BWf2DLZQuvyAEZlCD/Z0E9K2MeX3OnMd?=
 =?us-ascii?Q?JHZqSkaZFkaX1WjzwewA31nv4n5hpWVdN2+8T2xCYC5Ld/hORzfRel+bm5k6?=
 =?us-ascii?Q?Wo4PCiMcZjQ/ta/v2xiHF7z825xJtaWrqr1+Ecu7u4KBhMdt4cP0fKIdiY+t?=
 =?us-ascii?Q?txKH6K8pz14X2WahivFWnpXnVXNoHz8ds/W0O3XA3kB1fpY4C3coCAFSn3ie?=
 =?us-ascii?Q?w044GRliFTVTuY39MhVNv46V+PG7uuGxt8Ooq/remZHX4wd2KlvlpNb0gqBS?=
 =?us-ascii?Q?1zEarh0lKCbEnaH50RIxeDjFmcgObpVr5Wkwwso+tFBOkL/UhrKdIFbkthBY?=
 =?us-ascii?Q?k+RE6ONCztAfM5xCStsX2OMoh9/Sr24v8B/HmaL6qHISZV7G3g1Ht7da+e6X?=
 =?us-ascii?Q?hgbBIXF0ch2iXm1BbBGaIZyWKWCHYz1OxNkwQtBCRR1OCIaLctv0BeAtSmLV?=
 =?us-ascii?Q?AZMBwRuiDLtuFeVLoITY04VYlBS+lTIAVoB4rIUHQ0tTi+Yfcm+HQ5EzwoY5?=
 =?us-ascii?Q?V2m354ce2hHENNWwAz/6IBywlgpgR8p50ht8NLt9GyoJu89dEaWT5kuAGlmb?=
 =?us-ascii?Q?U7rqsSzYMzyWdLVh8sLZaHFreP+Gnu6gWH+Ntoq5eqcSNhFD22LB0r35IGw1?=
 =?us-ascii?Q?fO2hTh8ZA8pNkE6i2wnecz4C/VWUKohrT4A9RRasgnaSAhE09ZYjEyqEpqVM?=
 =?us-ascii?Q?8jxjtkujSQY/sDqAwNqQT/AScJwX3dml9FWM5C3NFPaeTdSZ7ErfZ83x3CXD?=
 =?us-ascii?Q?lMn68k8vfWYApgg3/lysnU38iH+0UHJUO4OeSLbr7qzocwHrL1Ejjkj/+yas?=
 =?us-ascii?Q?h+S2CFjLMH3ab/FJ5w4hhgP79EQZ/VMyXNE4TylRCNec9U6lHHvGBmV5fB48?=
 =?us-ascii?Q?Tb7tYQDBzfRAhpov5JS/MZUV/bXdNkssbrETL3YLB7lPPUJi2bTHdFxoTQWn?=
 =?us-ascii?Q?XFde8TqYi0bLGd/tu8VV1uCKcU3K4vfJR7TypnLb/+BQ+jh4j7BQjlD+7IqP?=
 =?us-ascii?Q?vMAwNqf1TFIjuboxQwsEFik1CPp1wkMyGgPThoCAylQacd0Ee6uxMNMJq07x?=
 =?us-ascii?Q?k++xPV/jFzwQR5yW36gqA1P4ErSV2DTHMz83hJ868ueZhWUlxIUfyEdTrBuQ?=
 =?us-ascii?Q?rr38hYixJMIQrf2+C6b2nXv64lgcMN26lgTew8sxOLzl5+6a4xMw4ktUSeH3?=
 =?us-ascii?Q?R7iy2lb+mkzFGM1+Vb7aOrx7s2hKEQ9Zomiqya4/Lc6VQzAF1A1QjzwZX7bG?=
 =?us-ascii?Q?zSBfK8cp/x/1wrKTOXOOybovrS9UW9LlHY/shxHISDIvd32Bhj54iUkMIXqO?=
 =?us-ascii?Q?4N3JTvoWPCirvJM5T1QFjU7deC0hGcAJusV46Aw7hQZAVcmk/cyWU9GhXew6?=
 =?us-ascii?Q?Un0j+dmNSSgxpKkqrb0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8807e4-77ea-45f7-46b3-08dac1230d07
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:49:11.5755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p47hd3WFbMJ+NBiY+dFC9fmUxWK7xo1ipwHY/F6AUKexRwUKnrguyGo6rfjZVWU4
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

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.h |  74 +++
 drivers/iommu/iommufd/pages.c        | 823 ++++++++++++++++++++++++++-
 2 files changed, 893 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index b74bf01ffc52c2..aebb9a496258ce 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -49,6 +49,15 @@ struct iopt_area {
 	unsigned int num_accesses;
 };
 
+int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages);
+void iopt_area_unfill_domains(struct iopt_area *area, struct iopt_pages *pages);
+
+int iopt_area_fill_domain(struct iopt_area *area, struct iommu_domain *domain);
+void iopt_area_unfill_domain(struct iopt_area *area, struct iopt_pages *pages,
+			     struct iommu_domain *domain);
+void iopt_area_unmap_domain(struct iopt_area *area,
+			    struct iommu_domain *domain);
+
 static inline unsigned long iopt_area_index(struct iopt_area *area)
 {
 	return area->pages_node.start;
@@ -69,6 +78,39 @@ static inline unsigned long iopt_area_last_iova(struct iopt_area *area)
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
@@ -106,4 +148,36 @@ struct iopt_pages {
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
index 87e2bd78ae91e8..d8f3f2a07e8378 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -151,6 +151,18 @@ static void iommu_unmap_nofail(struct iommu_domain *domain, unsigned long iova,
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
@@ -171,7 +183,7 @@ static struct iopt_area *iopt_pages_find_domain_area(struct iopt_pages *pages,
  */
 struct pfn_batch {
 	unsigned long *pfns;
-	u16 *npfns;
+	u32 *npfns;
 	unsigned int array_size;
 	unsigned int end;
 	unsigned int total_pfns;
@@ -221,7 +233,7 @@ static int __batch_init(struct pfn_batch *batch, size_t max_pages, void *backup,
 	if (!batch->pfns)
 		return -ENOMEM;
 	batch->array_size = size / elmsz;
-	batch->npfns = (u16 *)(batch->pfns + batch->array_size);
+	batch->npfns = (u32 *)(batch->pfns + batch->array_size);
 	batch_clear(batch);
 	return 0;
 }
@@ -246,10 +258,11 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
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
@@ -997,3 +1010,805 @@ static int pfn_reader_first(struct pfn_reader *pfns, struct iopt_pages *pages,
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
+ * iopt_area_unmap_domain() - Unmap without unpinning PFNs in a domain
+ * @area: The IOVA range to unmap
+ * @domain: The domain to unmap
+ *
+ * The caller must know that unpinning is not required, usually because there
+ * are other domains in the iopt.
+ */
+void iopt_area_unmap_domain(struct iopt_area *area, struct iommu_domain *domain)
+{
+	iommu_unmap_nofail(domain, iopt_area_iova(area),
+			   iopt_area_length(area));
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
+	unsigned long done_end_index;
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
+		done_end_index = pfns.batch_start_index;
+		rc = batch_to_domain(&pfns.batch, domain, area,
+				     pfns.batch_start_index);
+		if (rc)
+			goto out_unmap;
+		done_end_index = pfns.batch_end_index;
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
+	pfn_reader_release_pins(&pfns);
+	iopt_area_unfill_partial_domain(area, area->pages, domain,
+					done_end_index);
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
+	unsigned long done_first_end_index;
+	unsigned long done_all_end_index;
+	struct iommu_domain *domain;
+	unsigned long unmap_index;
+	struct pfn_reader pfns;
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
+		done_first_end_index = pfns.batch_end_index;
+		done_all_end_index = pfns.batch_start_index;
+		xa_for_each(&area->iopt->domains, index, domain) {
+			rc = batch_to_domain(&pfns.batch, domain, area,
+					     pfns.batch_start_index);
+			if (rc)
+				goto out_unmap;
+		}
+		done_all_end_index = done_first_end_index;
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
+	pfn_reader_release_pins(&pfns);
+	xa_for_each(&area->iopt->domains, unmap_index, domain) {
+		unsigned long end_index;
+
+		if (unmap_index < index)
+			end_index = done_first_end_index;
+		else
+			end_index = done_all_end_index;
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
+static void iopt_pages_unpin_xarray(struct pfn_batch *batch,
+				    struct iopt_pages *pages,
+				    unsigned long start_index,
+				    unsigned long end_index)
+{
+	while (start_index <= end_index) {
+		batch_from_xarray_clear(batch, &pages->pinned_pfns, start_index,
+					end_index);
+		batch_unpin(batch, pages, 0, batch->total_pfns);
+		start_index += batch->total_pfns;
+		batch_clear(batch);
+	}
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
+			iopt_pages_unpin_xarray(&batch, pages, span.start_hole,
+						span.last_hole);
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
+	lockdep_assert_held(&pages->mutex);
+
+	pfn_reader_user_init(&user, pages);
+	user.upages_len = (last_index - start_index + 1) * sizeof(*out_pages);
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
2.38.1

