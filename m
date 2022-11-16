Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70CC62CBE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiKPVCv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239204AbiKPVCE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:02:04 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0FB6A694;
        Wed, 16 Nov 2022 13:01:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJOqjFGxUG2R1//UDaA9Xw9fyF1RJA9C7aOFZHBQu12dpib4hqZ7O25HfeVQMl40ZsCcyGvdXeSaGGb6l30Xy/lX7LtB8iN7LM2xdWsGmgaUEDCJ/H3CCkwKzi4nRqMA0aGWkxO8fCkKkflXv+AO9i3wAG4k5ikoknCKtIB14LDybl6jEv+cQt5/gyCI//kYD+D5T5gPPaGtMUlwLQgGAS8hTRxHO/Ot1SXeunkbM6D40J9CAyk6SHHCe/yAuulJ8VIGezR4DtOu5c9603+nv5RTqlsQ7cQIem4UblQDuUVJ8LpHA8tLyzBJoU7XS4gfXSYxaQLJw6mAN9TPN5n1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NTJNKoCSKbDRQaTbdce6HfwYbSAKvDi6EQHainO3mE=;
 b=Sgfl773ln2N0RcTQcvgV2HRxbverYXEvqCzmqyWiTVwR7EHxskHiRVJBxBw4mgg0M2DX4kgJ30Kt7efagi+OuCdksZ6B5UjfqpGV1J+zheLH1bdMg6uZnOW1u9ZBLKaeIRZFLQFOcZmVoCV+eTSk63SFUSWDLtHNrFbL1youzecDXGVY6uVBT3gBVVeMWqaMKR8i8tdJe2yLGlxiAuaOVZPmJMFOH9x9TWYPlqGRk/IZX6hXqU6EIDoLP/SQCrqRSq59+FVLjzAZjODcjR+aRC5TPvwJXzc0y62hry/sY9hRgwpm3x7uAgg5sCGLdd1reqX55HauUYzA+TsJBBEvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NTJNKoCSKbDRQaTbdce6HfwYbSAKvDi6EQHainO3mE=;
 b=AABZqIeoI9B8o0KP1igQA1bDM1j3RY2mAyoPMWVjK631lKYv81T3bYmSgBrXfe6RfuqfF5Nwnw5XeCQpBn1o8TV0+DMBRrraOZ7By+EuCj8Djy8K8BzEfql/qhTQhqkgQSusC0qoHg8iXxCx1UzUkRcB22qk8E5BOQ1a8ewMF+LliLqPo37ML2hMj27b7MUquyTu2+xSmv5s111rcw5wuKer/D1DoBeI/sZMrhuZQGpjiwMIAmIAghV2IWZp86byhGpVt/Bj51FPTbehjgalpFW+mpdHBmFHbC+iUZ+UJ0n0JiI2/wPmMdiGtTXZPrcV0DdpqJ9zKRTGZQWpPag/Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:01:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:01:00 +0000
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
Subject: [PATCH v5 09/19] iommufd: Algorithms for PFN storage
Date:   Wed, 16 Nov 2022 17:00:45 -0400
Message-Id: <9-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:208:a8::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: ab68734f-bc0a-4dbf-47a2-08dac815a8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcSSIOGr+/nGDhaTit4ppAZYQcPXRK2QI1THLahIKfbCtpv93B4pGfQyNHFlmBX3ICpk1533TcAJglovjDQf6xGjHbvEaHF41BTO//tuTE2zujtuLty1H7IHdzGDv3ghYCccM5b1v//ZXJzAC3b2UZ/1C30BwErZtKV2qJsyttaGxvzHNhUSTC3YaYjjQXvrSzitbXUkzQemg2MthhHopIPzw/4C9KR2RdLZQXRWS1HHaMzllH8N+TNGBlxV8avJob5Fm0c3cR63KrX+4mfAcMRKIzRXKoYqPRKfSGvgrX32nX3tyItP3u9v3mXSYNeq1AB3U4VfSPL1yFj5aaYex//jrZaQUIDAvWjKPr0o2LH9Tr++9xNVzVSQybLbASzD1a8ubEuZ+0Xg7JlmLKvZLy5hItgDJ4HUBepUxLW+PPGzOcQyVVzgsRuT+QSwspMYx/SrvxghA3WLPhsoPQr5HJz3BStYShjfxShNhd1ovKevJ66rGb0/AYgQHpCGDBP8aH3Ek6xBNe1MnIrpYgRu1Sfj5Jn1SDKlQVhPdr/kWluwraBljcg/AAvY7CWT0iJmeQ7mfcxPmDW6FehuStUBL8eXZDXMTxYhhvyhGeaqS6fYGHqws/sS4hAUCWeAQbO5vi4uZDf6S2R2GLXGTDt5LSv6yZnxRm+c3NNHlp8NE4K2Beltdy4v71w1vCzycAo4Q/Qe23i7Hic9sFz+UKYaMrk6Sehn+IoqBnYQDYKMrMqfsksyNe98O12OFD5MevkVQgQZmrBBmw+mpNPBBxyaKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199015)(478600001)(36756003)(38100700002)(6486002)(921005)(83380400001)(86362001)(7416002)(8936002)(6666004)(7406005)(5660300002)(186003)(2906002)(30864003)(66476007)(4326008)(8676002)(66946007)(66556008)(110136005)(6506007)(2616005)(26005)(6512007)(316002)(54906003)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dZM8g3Ihc5wbYBxlj0pQr5ZfuvhUr1L1m4xpFG8u6nWXKXLEvQ9GIiIkImhC?=
 =?us-ascii?Q?96lBprPl8B56SlYnLQvyLW4x+kXxXLVyU99fNqxKxyrlPv/K8g6LrqdW8QmT?=
 =?us-ascii?Q?ycK64vRrqM4TdIxl9soKfgBngc4gYrp3SFDMSCF2NTYCTlI4a2l+t0P8i1Ps?=
 =?us-ascii?Q?Lhv0GJN78c264+8sG5tTJzHwXMa/K3DiWNp+vCkw7cPP5bmav+huoeuNoRiP?=
 =?us-ascii?Q?85DaKAG2qXcV+uCXzJQKoOKhRy5yik2Uzo8sze3LYOBEUdc1ljvdkZXColzo?=
 =?us-ascii?Q?eRNHJo7Uk0FBafsL3mU+lxIAk1bkUwigcgGEosq8DxpB2B0lGh02iwFermA4?=
 =?us-ascii?Q?mTzn7KyYD+IVUx+3kaTA2S7s14AMzA2N4xj7ZYG6uAkMMhpoCmlMUeZHWaUP?=
 =?us-ascii?Q?yBZQRLl/EL/eoU5vyV+5EsiQSiF63GPzf1gCrIUsieJiQmcMpI4R1ougpPai?=
 =?us-ascii?Q?VyGdwbigRaFK5NowYojk2k1g/lDttQ72F+xxsxUzK2p+Hm+xSpPN3pKGeoLY?=
 =?us-ascii?Q?WPvffgJmsiJMD47bsfI82S89R/7+0QchwYx1qn+H2v/h8G7xxdHN5Vsb++24?=
 =?us-ascii?Q?Gyx25dCbdjupXmpx8ZyURWyQXdg5ONSLuaJgCi5rQtDFtMKTCknhOXQ45AGr?=
 =?us-ascii?Q?vRvu78+u1D+XJWOOtW4mf8YurpyrtuIRtm2iTGSXOUqfCELjYqaT6QGkzMQn?=
 =?us-ascii?Q?dyanmhJJcFOx1cfy9blVoNewYknIrh8+QXEJrXw5xfn+xhtIeNUxJCUpwLIS?=
 =?us-ascii?Q?d1tfn8+ZxbUDi0W+tz4u0ORydbSMFgKynjqhb2Vn2LpYvDAHNs2B1on2uSza?=
 =?us-ascii?Q?JSjSShJsXW8DgdB727uVzri8P0wM2fao1SVqJJvXonrRMQgTSIBsbIZ2IQh4?=
 =?us-ascii?Q?l3s9uE7aI9LppJKmo+MyUtZ4BaiinmCrwl9ErMdIXT/ndumPCuiRvVFUgGf4?=
 =?us-ascii?Q?HZjZBebRVZRVUl7kjPjUfWkmd91bPIYRkhxugvSgGaOapKJrI4VVbb/VTmh8?=
 =?us-ascii?Q?KWI/2b9cOcovkF4Cs6CqD8yPl9XX1UcgCpjUCAXBf1XGN2d9V/HVgmymL3si?=
 =?us-ascii?Q?bGWud2Lj/UM88Sb+l4iz7BFLO+TepcdJKepksaOooMP64bCbix6NWkOzWfaO?=
 =?us-ascii?Q?LmS0pdNCg8BZJpJcbGXJwbQRuW2kNMYS6ms7xuei9ENJxOkjzWQGUangOfwe?=
 =?us-ascii?Q?ZobDTgINYXzTh4eg/pwAvzh2ieiSRU6pAvngR8ZN0v+Uxkv/liQ96tgUmfJU?=
 =?us-ascii?Q?qBLoFxaAZKpjv1lklAo0w+j5e2Lj4vWm2xtpncU3igkDGDrIBm7Eu5M28III?=
 =?us-ascii?Q?XXB0nlXQLLS6aa+N2XAMwaRfvJ34TrRjm4OB9UL5N7kQga1mO5WxK3HFkIfS?=
 =?us-ascii?Q?vGRb/YE1CFajBghvNeJrNpZw7c2Tv4P5b391hM1tIMwoKMbhWyfxxfuCVth/?=
 =?us-ascii?Q?NZ93xxIKceSJCX0xq4CLPoAtT6Siu8mMkyztN+RwjsIIAnY0ymnBv2X/VbyA?=
 =?us-ascii?Q?+43ah7MPsbfIPNdBg8Sp60q3CMosqx3Gh2EdpZC/0VPRuZhDSZDYTQWA3DI5?=
 =?us-ascii?Q?/wXAQ+Vq3xlbm18mboI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab68734f-bc0a-4dbf-47a2-08dac815a8ac
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:57.9826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1SLMaxVYd2aXyGcH8KF5ONC/9qdEy2MM3wTCQOduKKENosRdfwo8VPQcyfjbx9Z
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
Tested-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Lixiao Yang <lixiao.yang@intel.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.h |  74 +++
 drivers/iommu/iommufd/pages.c        | 843 +++++++++++++++++++++++++++
 2 files changed, 917 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index b74bf01ffc52c2..a2b724175057b0 100644
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
+int iopt_area_add_access(struct iopt_area *area, unsigned long start,
+			 unsigned long last, struct page **out_pages,
+			 unsigned int flags);
+void iopt_area_remove_access(struct iopt_area *area, unsigned long start,
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
+	unsigned int users;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index ebca78e743c6f3..bafeee9d73e8ae 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -212,6 +212,18 @@ static void iommu_unmap_nofail(struct iommu_domain *domain, unsigned long iova,
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
@@ -1064,3 +1076,834 @@ static int pfn_reader_first(struct pfn_reader *pfns, struct iopt_pages *pages,
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
+	/*
+	 * For security we must not unpin something that is still DMA mapped,
+	 * so this must unmap any IOVA before we go ahead and unpin the pages.
+	 * This creates a complexity where we need to skip over unpinning pages
+	 * held in the xarray, but continue to unmap from the domain.
+	 *
+	 * The domain unmap cannot stop in the middle of a contiguous range of
+	 * PFNs. To solve this problem the unpinning step will read ahead to the
+	 * end of any contiguous span, unmap that whole span, and then only
+	 * unpin the leading part that does not have any accesses. The residual
+	 * PFNs that were unmapped but not unpinned are called a "carry" in the
+	 * batch as they are moved to the front of the PFN list and continue on
+	 * to the next iteration(s).
+	 */
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
+	/*
+	 * If the range ends in a access then we do the residual unmap without
+	 * any unpins.
+	 */
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
+ * This uses the pfn_reader instead of taking a shortcut by using the mm. It can
+ * do every scenario and is fully consistent with what an iommu_domain would
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
+ * A medium speed path that still allows DMA inconsistencies, but doesn't do any
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
+	 * ignore any pinning inconsistencies, unlike a real DMA path.
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
+ * iopt_area_add_access() - Record an in-knerel access for PFNs
+ * @area: The source of PFNs
+ * @start_index: First page index
+ * @last_index: Inclusive last page index
+ * @out_pages: Output list of struct page's representing the PFNs
+ * @flags: IOMMUFD_ACCESS_RW_* flags
+ *
+ * Record that an in-kernel access will be accessing the pages, ensure they are
+ * pinned, and return the PFNs as a simple list of 'struct page *'.
+ *
+ * This should be undone through a matching call to iopt_area_remove_access()
+ */
+int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
+			  unsigned long last_index, struct page **out_pages,
+			  unsigned int flags)
+{
+	struct iopt_pages *pages = area->pages;
+	struct iopt_pages_access *access;
+	int rc;
+
+	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
+		return -EPERM;
+
+	mutex_lock(&pages->mutex);
+	access = iopt_pages_get_exact_access(pages, start_index, last_index);
+	if (access) {
+		area->num_accesses++;
+		access->users++;
+		iopt_pages_fill_from_xarray(pages, start_index, last_index,
+					    out_pages);
+		mutex_unlock(&pages->mutex);
+		return 0;
+	}
+
+	access = kzalloc(sizeof(*access), GFP_KERNEL_ACCOUNT);
+	if (!access) {
+		rc = -ENOMEM;
+		goto err_unlock;
+	}
+
+	rc = iopt_pages_fill_xarray(pages, start_index, last_index, out_pages);
+	if (rc)
+		goto err_free;
+
+	access->node.start = start_index;
+	access->node.last = last_index;
+	access->users = 1;
+	area->num_accesses++;
+	interval_tree_insert(&access->node, &pages->access_itree);
+	mutex_unlock(&pages->mutex);
+	return 0;
+
+err_free:
+	kfree(access);
+err_unlock:
+	mutex_unlock(&pages->mutex);
+	return rc;
+}
+
+/**
+ * iopt_area_remove_access() - Release an in-kernel access for PFNs
+ * @area: The source of PFNs
+ * @start_index: First page index
+ * @last_index: Inclusive last page index
+ *
+ * Undo iopt_area_add_access() and unpin the pages if necessary. The caller
+ * must stop using the PFNs before calling this.
+ */
+void iopt_area_remove_access(struct iopt_area *area, unsigned long start_index,
+			     unsigned long last_index)
+{
+	struct iopt_pages *pages = area->pages;
+	struct iopt_pages_access *access;
+
+	mutex_lock(&pages->mutex);
+	access = iopt_pages_get_exact_access(pages, start_index, last_index);
+	if (WARN_ON(!access))
+		goto out_unlock;
+
+	WARN_ON(area->num_accesses == 0 || access->users == 0);
+	area->num_accesses--;
+	access->users--;
+	if (access->users)
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

