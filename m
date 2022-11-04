Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2EF619C7F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 17:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiKDQE7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 12:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiKDQE5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 12:04:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE3D326EE;
        Fri,  4 Nov 2022 09:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjnP2Hq17rrslLseMkaakxBUplfGH7mqVHSO0PWJnCOca0pTdjn1xOUZy+yhEy1SQCxNiop+4F8iLxd4s0BiyoTNP1YWncPlJtXRofFg5onIKDJHugYt8bl8c/5Js/q0WUkqIn2IhqfcaZSX1NkWSFYyyeE/EHm0WmEJCR84oUIP37/4crKiJ9JY8BoJRq3Rg7pGqPLlbYrQbWChmUvtj5kJif9VrHaM88C+pVPC4g4RbVf5nQTXz4DhwVZxTHlliQpubfbqKEza+q/Ez/2QcO0vrQmTYWnr8wbztGWJxLWSppXsgprZndxe1xCsK2luQuIynPBvcMcHCZabJlA8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8iKWNXnm7gLelKKKiyt8WiVc9Y6d2JEJZpQJCvFzhE=;
 b=ZD3quxzYW+4C81Jeb+B6q2JUaYlrov0DxUom9QDpgigcxxbzxF3YC8ih8eOsEdMqJbZsK8Mz04HWAexYe7KFYUJ0lecosYt9hmAHZOIdLZNt2+bhLUu8JX1EQ1kIHOjkRti2EWaqG77VSW8N9qpZgXV2NQ5M3IbHNqqkK5WF9hzHKy3IclX7yV0/Am+tdYhl8D6EMpykbvu2BcpBVbKju5xYp7nkhX8tycgfQ07sZOFFDVOwfZLUX4L1y3TjJ4yiuFmiduKs9HOg+GPkDS/20PVvazEoS7w0hjfKlDh9fTeLUXyFjuMiRW6+dfZUFJvLrwD/Iloz7Znf/zazf22ISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8iKWNXnm7gLelKKKiyt8WiVc9Y6d2JEJZpQJCvFzhE=;
 b=WAkzSt2nUImYqbCsR8+8XgrkHvlJ+AIn8sFsYeulfEBp3YHQOC2jUeRHrx0cYScP7TIbGwRuJWdodaOMXH1l9SrpKgcqeKmG+ytY6EQT9tlcW6dM/v7P17zccNqPX/GloDYbwHtOy0zID7By0C9fvo1Tl3DKC3YF5UhEMNFzdPGpRNr2IE3tscS14tXjSJeNgHgm3EBu9lXhVgf9FLPgOb5KIc3PhdRtMTG5uidFUgnLWrU178vjiEAU6rH95Qj9Mj1B4+tX7+yPfogEYeu1PQsfyuIV0DPvAaV8xtRLc0WQbG05OGToBQhHbM4HVSjz0BckkGz+EWtU+vrF4lnftQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Fri, 4 Nov
 2022 16:04:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 4 Nov 2022
 16:04:52 +0000
Date:   Fri, 4 Nov 2022 13:04:51 -0300
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
Subject: Re: [PATCH v3 8/15] iommufd: Algorithms for PFN storage
Message-ID: <Y2U4I+xOFe5pCXtY@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <8-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d83cac-466d-4117-6445-08dabe7e4ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZUViWMiVdV4rzRT6i1CrO8WKO/OJV5IBqpZksxMEcD3aITEDgquV+kK4Zecggh6G4OLKIdhP9yBxHol/McAqvKt0ILHF/d8nQqyXG59lH/P+iN6moaP+SWX37cNxRgkQyGKwMteLKWN14paw9PIUiqBW83i7DJRfVrt9DXOgg48w3KBvvSVivlgH0fYplQwjd+jFQReUsPXy+zB90YULHrXeoc0uCbx35gKbB9E1UEjl9yKTf6hrGbywtp5HeU1OU8L47kmm8q13TxP8IUqDITU1NjnP0Cd7Z+w5AusxRbFAqFuLD2HEK1ppVNUoUuN/bLra76kqCGM41RVUf/ylG6Qr+jZaCOtHQOYwOmVqUrGUugF+XjuYyWmpvLfkCtG4UgRE+jvbQymhraaWCAOVyO3/72fDly3S4teaLOFQgcAVIp158lYgfxTxKv9DemF7PsGn8VqH1J8tgY9BPRXBzIs4k6o/lbOi/JppqC0Zio/dh6kUeD5R3bFF1Wh2F8+OA9uxdd5dB0GdHTa4HxLxQPAjdxBsTUUnCifiVJIVTluaAiEnZeh0lI83koeVEoRACmeof4RWH+UCbSTBZNrDxhP8RGsterLhbAD4W9/euEP8ilcdlANr+aQS2sf1v8lpYUHYbajDSbrZhRdHBUoUZzbOB+uWyu1/QW0qeZTjDt6hYniiFV159xpZOlgRwKNvmiUJVcTjQbMRVbLNk43rkR/IS84Awlxe62jjkdLUaz8jZ+adlUIn4TRsYdJb/ELtGCgT+Z5SzHqo4ytPxJbwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(7406005)(7416002)(4326008)(66476007)(66556008)(2906002)(8676002)(86362001)(5660300002)(36756003)(66946007)(316002)(921005)(6506007)(38100700002)(26005)(110136005)(2616005)(186003)(54906003)(6512007)(6486002)(478600001)(83380400001)(41300700001)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qKyAr/T/DE0gGy33B7TXPlXrm3a9QyTFOLie8R5hZJ/86XAjOIz1dZfaYSE8?=
 =?us-ascii?Q?hSGFUA8X6up5CS14LxlETBOuUd+vQeLmUk7RZMlfACKCbTfCagMRxGdUUWqz?=
 =?us-ascii?Q?RqwK2HDS+bwsO8eExdfMKfatiJgfhP/EtmA7vS+Cr1OW3VytgqIKyiawBLre?=
 =?us-ascii?Q?uAw5DT8G6ohfP/PkcDPX1Fgdbf+DQkSSwKt0RscwQKLShjhon/5PzoE3DCvK?=
 =?us-ascii?Q?XO1X0t4RmPr42jS2ctvXA4dUc3MEi6oeyZsoF2MM4uUJVWHRTpJqhrUQxo+N?=
 =?us-ascii?Q?bwMj0yvy8UQePxrWiUWc6onZP/mOnZO6uXRHNwc2F0LgjhPvPIqWep3bQ59i?=
 =?us-ascii?Q?FUnu6oLyEQbPWltBQEYk5M+aY1WryvLNeXzNop5aolSJprz9hI6wOGdCKja9?=
 =?us-ascii?Q?i5DNojTiOPt2VaJi6G7lAeMRbLlojZUS9JmPNkqxSuCHbAARbepdq9Xx0+5W?=
 =?us-ascii?Q?cgJefNSVW3JVAdn3rY8/SJ7vTxuyFkPN+pSnImw8DWe9VObrhq5BpktOmA2C?=
 =?us-ascii?Q?glZx6v4uUyVxULfV/qkYH2t9pPIk+ZDq4Llwjs95MoDK1wJ0USYnkYLfPPjY?=
 =?us-ascii?Q?JMFUTHpqIJ/juX6WgXM4NnuVJx3zeOtj84vTPuAb3oL5W1nqAa6zZqiyriaK?=
 =?us-ascii?Q?UaH5raQo+lGrEwGK1yOhC2ryAFLnbX9z7XcsfuJ/d7fq3tcxH90U04vdHNux?=
 =?us-ascii?Q?lrpRF02j/8ZKk1uDE+oTc1mVoRICXWbuPJt/rZkdaxxfqrBzAeo4S7qAn/DE?=
 =?us-ascii?Q?q0bKkHF6z/dSxvZU3/bHNwzTxN0ea+q07X63/d6inno/pNO4q5TSfkVo32wU?=
 =?us-ascii?Q?Wbw4e19fryBfgJIPXln76sNr4K0X7wWjMyeyPrrZkJ7jZN1Scw6UATtMjxq+?=
 =?us-ascii?Q?tR17lMZ9WcRdY/Ci4tOJwJ37J59zr8TGLGa/Nj8skLF6Y++mVTERUvXEh6aM?=
 =?us-ascii?Q?ErbyVhOQ5n926PZps0bDDmY25QrwHqu5l4YLwlhqYiLkEdYI8a8C+lg9beJL?=
 =?us-ascii?Q?dL1GNECvdvgAlmBCiYvIRKrK7BJ1BGbzDslYrBYMdSIbB6hH085pO5dPoxxN?=
 =?us-ascii?Q?E44f6OA0qAdq428VmaySNLUp83oX0DRs+oycUHNFLXL1QdROA/9Crk6edhGx?=
 =?us-ascii?Q?koKcwVxrewEof4SqpWl118yCIu24+tTEERjaaNMvwqdli6z8cTqtMrV9yGTZ?=
 =?us-ascii?Q?7+bLCBXQa7+MDIZYhyXH3Spvqj6WhZTU0m5+5KpqUiWJu1yGed/4omsQkpWV?=
 =?us-ascii?Q?LWfePG5Z1o3GM9763BQTN3y6ZIIU89DEdAA+Wk5ab9YjAQKW+ey2+35hvjrK?=
 =?us-ascii?Q?Sa/GtaUGIe8UZCEf8HpmJmM/ZLA/Eh21zmVlGFNyGXqAMs+k5nr6y7wxBkNI?=
 =?us-ascii?Q?Q0keLguwK4cv43KN9aJoWpeAPjLvYCix3laMKdbGZasSlOWPvhsB8+kdYGzm?=
 =?us-ascii?Q?p3QZ3jakLmaxv+swtIJu63SkWRklKQqTZQxr2zx/8G4DJA/3A9Txycxku3mI?=
 =?us-ascii?Q?uXMBON2WaXHIb0ftUmRTZKGHKvLMtzDAlos1bF6jPRonlrIMtNTjSuktN76+?=
 =?us-ascii?Q?WPIamnJyenwjheIFgG4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d83cac-466d-4117-6445-08dabe7e4ee1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 16:04:52.6615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15RjbKC68DNxORjonkx0NXoXiFNH6Ew3SCUhwZj9P5YMmwhXzclayxMABkfA+pBv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:17PM -0300, Jason Gunthorpe wrote:
> +/**
> + * iopt_pages_unfill_xarray() - Update the xarry after removing an access
> + * @pages: The pages to act on
> + * @start_index: Starting PFN index
> + * @last_index: Last PFN index
> + *
> + * Called when an iopt_pages_access is removed, removes pages from the itree.
> + * The access should already be removed from the access_itree.
> + */
> +void iopt_pages_unfill_xarray(struct iopt_pages *pages,
> +			      unsigned long start_index,
> +			      unsigned long last_index)
> +{
> +	struct interval_tree_double_span_iter span;
> +	u64 backup[BATCH_BACKUP_SIZE];
> +	struct pfn_batch batch;
> +	bool batch_inited = false;
> +
> +	lockdep_assert_held(&pages->mutex);
> +
> +	interval_tree_for_each_double_span(&span, &pages->access_itree,
> +					   &pages->domains_itree, start_index,
> +					   last_index) {
> +		if (!span.is_used) {
> +			if (!batch_inited) {
> +				batch_init_backup(&batch,
> +						  last_index - start_index + 1,
> +						  backup, sizeof(backup));
> +				batch_inited = true;
> +			}
> +			batch_from_xarray_clear(&batch, &pages->pinned_pfns,
> +						span.start_hole,
> +						span.last_hole);
> +			batch_unpin(&batch, pages, 0, batch.total_pfns);
> +			batch_clear(&batch);

Syzkaller, and then the nth test suite found this - the required loop
around the 'batch_from' is missing. The normal test suite should have
found this, but it turns out it is using huge pages, and not enough of
them to overfill even the limited batch.

Testing also showed that batch overflow accidently zerod an xarray
entry that was not actually stored. Thus this:

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index da95b28b41772c..3640f83f57069b 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -479,10 +479,11 @@ static void batch_from_xarray_clear(struct pfn_batch *batch, struct xarray *xa,
 		entry = xas_next(&xas);
 		if (xas_retry(&xas, entry))
 			continue;
-		xas_store(&xas, NULL);
 		WARN_ON(!xa_is_value(entry));
-		if (!batch_add_pfn(batch, xa_to_value(entry)) ||
-		    start_index == last_index)
+		if (!batch_add_pfn(batch, xa_to_value(entry)))
+			break;
+		xas_store(&xas, NULL);
+		if (start_index == last_index)
 			break;
 		start_index++;
 	}
@@ -1407,6 +1408,20 @@ void iopt_area_unfill_domains(struct iopt_area *area, struct iopt_pages *pages)
 	mutex_unlock(&pages->mutex);
 }
 
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
 /**
  * iopt_pages_unfill_xarray() - Update the xarry after removing an access
  * @pages: The pages to act on
@@ -1437,11 +1452,8 @@ void iopt_pages_unfill_xarray(struct iopt_pages *pages,
 						  backup, sizeof(backup));
 				batch_inited = true;
 			}
-			batch_from_xarray_clear(&batch, &pages->pinned_pfns,
-						span.start_hole,
+			iopt_pages_unpin_xarray(&batch, pages, span.start_hole,
 						span.last_hole);
-			batch_unpin(&batch, pages, 0, batch.total_pfns);
-			batch_clear(&batch);
 		} else if (span.is_used == 2) {
 			/* Covered by a domain */
 			clear_xarray(&pages->pinned_pfns, span.start_used,
