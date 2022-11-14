Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D1062887E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 19:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiKNSoE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 13:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiKNSoD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 13:44:03 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F054B64DC;
        Mon, 14 Nov 2022 10:44:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnESpzo0pKHlxdshz0QBBVpf5iCPaFYKJBDRrMwxp6jxtIsJZQ5reAy8AfgpdqNS60isdtZ3x5D1xmV3LQoIRsq6r0KX3VTEEYSVf8wWZ4hwBVQQ4RAukSpyDmTp0mlV+A8P2jfK4UKuWfCR1xJwfQ0Z5mtinjv0YZGI+8dcxVDHSviWlLwLJaEPGBi0FlyCH9xjge3yz8w3XBbzGLFIID4IWTHKqgeNSlB5LE42VzzaGVTOaQLRkNqEfO0Jet/VyplW5FD2/LQdC0BkhYBc7UM09RM3X3N5rg1QNFjCtj5GMIb7Q5hJI/9o6lmE8VTCbN/qxEoDdEKEEYNxF4Zx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsV1baQSd8ilPQl+ipAWe/6Cl+WBAGfK/gJCcwbb4KI=;
 b=E5aEvDdjP5eEkog2E+x9LxYBpDaFWKiL6dr7L7WclB3OVfs14/SvTCyC5FD7iG0R8HEOie90+z+lLVEHC02ebL4Tc9Ud57ccpenF8UYXy3OMjBP/i5upYnZ8clwaWIbZVhLPIbIYF4MfPRGJsEOuFbV374akxrA3XrruL81NVEZEpRitcwynIpGqmRKj2Z3l3sgYt3sQAS5xhF55igrMZIB5596cAvY9huti02aJY07KycqVfktcDIWo0kI+V4690OvD0NjxaFcaTH+Fb+Z9+4Fq6SnTxSjMxseMBvlxTJkJNNZzDtiqnU0NOjX4zIzijzwmNDASuY4guyfnnZDchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsV1baQSd8ilPQl+ipAWe/6Cl+WBAGfK/gJCcwbb4KI=;
 b=BDRwtgI0zZpcgBK3KrT+/yxRuVgvzL8VQB5Uamt0/iHQJUioq7hiBrgAMP7IeZnH7ZwVyN3tOtiqzzbtk6yruyxaxc76Uf2SKeR7bjSy0yh1PXYozL4Kf/gnw0K6gDYbebw6vGgeZR0kIARUn2nW5uNSJxL95WOol9SPv2WKOR0jg+rz8ILmDKyzvA6bDAsSWCEuJ7wNPgOHW4DzUSY96x8QqyrKyGFh3bzWuLK3vqHjtw+21j51z3+iv90UH2qif3BLKILF9ndyfY0zHLiEpoe7oMagDFrhcIrq50REkaOrEzJRlib2l80ieB1B/iqBxJoI3WBFQMWPWEA8bQhK4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB5639.namprd12.prod.outlook.com (2603:10b6:806:22a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 18:44:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 18:44:00 +0000
Date:   Mon, 14 Nov 2022 14:43:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 09/17] iommufd: Data structure to provide IOVA to PFN
 mapping
Message-ID: <Y3KMbyVwS6D505cA@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <9-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <BN9PR11MB527638FCF4A1351DBA1A644E8C059@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527638FCF4A1351DBA1A644E8C059@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:208:91::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6e07df-875e-4215-41fd-08dac67031ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hbp1pt3AYmL3wPJWk1027JAbdegTFRAXpfGjOgRJ5K/PX9WYCo6R+2dwQvZk+97FlFJpbUyh/UyF+UeJE0Y8YdOoQ6b9Ah12Af5x0D9jm99SYRRobeXCJGxcpC7veMCKmXDiSzkj1PoTgK6sQHed/nsMvtvNKeWzPxvSpTXl2Ls1tFNvD94wG8biyQZMUn/MITLJF7x3U/2W7baEuD2uyJSZZB5pSokXFIxSk239of8681iZCjRwnD61AbtPo2eyZAQ1p1blK6G7FNJl7t9tJW9j97J5xAQTNRRdxDPSfez8KPxeFR4YXQYu3oT6W7dRv5+/493+ai/mE4elkIDFQNfaYYtQM2wmtPJctj8zjuFcxZ+OPceky8dLPNgKD2074cy1Rdf4NV7GQy4/k4hVpl3LCovn3ezniY3rsXmSB+Swai3WcO/IiHomdL2nVlvJcEClj4yt2amxg+up3fg7xrdNdkdaZJ46X0ACQXDcB61Ld3FzleZHmnDAA7WPf27somX69h0UDxclRcuwAReB7mtpnMi6ZF7ZtOqKu30uQuDfsZ/iriZo578AaH0Z/LgmtORTPW6Q99Y1bW7CPvLoC/JaX+bKBPTAj/0s3RMcBTxSF2EMtpmlzfZBYczRq+YbWafnjr7lj4QgeD7Eh+sxmLzyDQ+BbJiD9v+e8H3WerbiH5Mhkw4FnsQrdrNsMKRz5VtLm1cYUU/ynXGz3OoHRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199015)(6486002)(54906003)(478600001)(6916009)(6506007)(316002)(86362001)(26005)(66946007)(66476007)(6512007)(66556008)(38100700002)(4326008)(8676002)(186003)(41300700001)(8936002)(2616005)(7416002)(36756003)(7406005)(5660300002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OTlQ9PPCwHphZwBf8/BaY3IrGq0tagGYaUlteIEj3R594Ha6kvQviUu7YUkk?=
 =?us-ascii?Q?sUL6hN6RgKLu2afJpm+izBr9gaK+yTDCxlj/Epx7dMBSQm434yPcdXe0eYNJ?=
 =?us-ascii?Q?a2H2GbjQtevEwsTvgiluvbM1ALR/OSc+zQOdPUYMXb0FOqsY8RcmaAQw+ebr?=
 =?us-ascii?Q?Pi6JxyWnjGEw58c31cWCykEV94Xp+M5I9H/l/nv8jpbvbzyDtlRl7+COm/TV?=
 =?us-ascii?Q?EONF1qZpD1PYYWWy9PEI5R7wMLzLppc0xZVc/T4SYcasu5Tr6CXJwmMcQSKT?=
 =?us-ascii?Q?QhYfLOz2yCi6XPgBpCBPklxtQEDzl3b2UW2O3zVpV5Vak5+YiwfHjOaBkkZX?=
 =?us-ascii?Q?qCIpfht1iVWxIq1JUYjk6sVb2Mpl+OCTUt/crbroJWF5vPJY5FYRE8aWBQ0p?=
 =?us-ascii?Q?NEpgQSesRHG2bDw9796owhgLIpJg2LmK7rduZT23lRvtadYARtFShW0Xs9vC?=
 =?us-ascii?Q?GQ+HwVOKLwUqe3h4KGy2OQLUoaDMnJWBKh0GdN5qc89jkJOJpR3kJPgq4y1H?=
 =?us-ascii?Q?sXXfqvdNT4OaCk1iub6MKaT9/c9mKN6RVD8peNYsocZL0QW9mSl8fIV/fQS/?=
 =?us-ascii?Q?3v7V7HdA4zV36fCVA6sWNS/9s535WSwEmluE4uZ+hVfbmBXwjWiS+oN/T5j9?=
 =?us-ascii?Q?v9Jq2fzsnyVC+BATEsjHd9NsHJKBmff/2LpiWmkRKq9gZvv9SEz6zhYJWM5p?=
 =?us-ascii?Q?hHn6JNFTChBGBImpA2F9zBXlgRNtnh4uv+c+pY708FlBD/K4sYkM0P4JTY19?=
 =?us-ascii?Q?ZqOB3X+HVSNTy0SFuvO00+e1eKTU67Q9iaNsp3XocHm7cMQqfKRqyo9kJi3m?=
 =?us-ascii?Q?HuprjOv5UTCunJatPHtKRL/HQVuXea/b53YVyoxRVcaum6bOC+UDROBqob5j?=
 =?us-ascii?Q?HGO8prMr/4sC58lfI40or8fWEqWAIqtldXPgjniWcdw9gcjcqx/l+HmxxR9g?=
 =?us-ascii?Q?p6pKBxgwqF4wHM43Wutt3TxDxuGDygNoPrcLmZc7xK9gQ36mXM53CIOtCsd+?=
 =?us-ascii?Q?Ka0aMbqccvD21hqvJqRItqm5wSDExAhdC1+4f8cUgGsD318Ldf/4pAfTnlbh?=
 =?us-ascii?Q?L8AkNX+iraKHTiSOTYMvTnRX0a05bSKM3z6Cn6lyPVk9uwM8H16ik0J+1hZS?=
 =?us-ascii?Q?QgYXnUKJfwAT6kFYp25i9MjiSr7E9FSsiDHief6RC4VMESOOcQ6IlJDZCx+f?=
 =?us-ascii?Q?iu8JllbwjVZjggovyhHZzPGQv4Lk6TGDKtO99LD8GqVU+0lzlMy60FtVLLU0?=
 =?us-ascii?Q?wc/WbnZIdnrcckjmPsrmNIC/vUEJcc7IflPKsqL7fi+H5sI3+QebGe5Be6vS?=
 =?us-ascii?Q?4MuEgRPJMBnkRA/aejA0lX8OXUz+0tACoKt9dP4CV+hqqUQAoPPbraHyj1KR?=
 =?us-ascii?Q?TBOEJjEE6Ism/TxzOKoHt8wbyk5KhPJLvMLHuC0gap5kaDSG9tfBKeoo5Yj3?=
 =?us-ascii?Q?x0W3L5JszjdVImmAvaV2/XcIbaf7NfzQ0sWw9VVW2aadDVYXUzoz74E0b42q?=
 =?us-ascii?Q?SRFgql4vy58v5rO1Y+QJ92Vu8xztCTtmx3BBan6ieLsLNNNxjzNY1uSKYJL2?=
 =?us-ascii?Q?f8SnpN96AnHBTjX8xDY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6e07df-875e-4215-41fd-08dac67031ad
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 18:43:59.9983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLH8yy3xcRqhjWhssvVsK6b1bLXlm71vKmwsGXzhpQuI6x+hBKMQrmktjUZLuaDd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5639
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 14, 2022 at 07:28:47AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, November 8, 2022 8:49 AM
> > 
> > +
> > +/*
> > + * Automatically find a block of IOVA that is not being used and not reserved.
> > + * Does not return a 0 IOVA even if it is valid.
> 
> what is the problem with 0? should this be documented in uAPI?

0 is commonly used as an errant value for uninitialized things. We
don't automatically map it into a process mm because it can cause
security problems if we don't trap a bogus 0/NULL pointer reference.

The same logic applies here too, the allocator should not return 0 to
reserve it as an unmapped IOVA page to catch bugs.

I don't think it needs to be documented

> > +	interval_tree_for_each_span(&allowed_span, &iopt->allowed_itree,
> > +				    PAGE_SIZE, ULONG_MAX - PAGE_SIZE) {
> > +		if (RB_EMPTY_ROOT(&iopt->allowed_itree.rb_root)) {
> > +			allowed_span.start_used = PAGE_SIZE;
> > +			allowed_span.last_used = ULONG_MAX - PAGE_SIZE;
> > +			allowed_span.is_hole = false;
> > +		}
> 
> statically initialize it when iopt is created?

allowed_span is a stack variable?

> > +		if (!__alloc_iova_check_used(&allowed_span, length,
> > +					     iova_alignment, page_offset))
> > +			continue;
> > +
> > +		interval_tree_for_each_span(&area_span, &iopt->area_itree,
> > +					    allowed_span.start_used,
> > +					    allowed_span.last_used) {
> > +			if (!__alloc_iova_check_hole(&area_span, length,
> > +						     iova_alignment,
> > +						     page_offset))
> > +				continue;
> > +
> > +			interval_tree_for_each_span(&reserved_span,
> > +						    &iopt->reserved_itree,
> > +						    area_span.start_used,
> > +						    area_span.last_used) {
> > +				if (!__alloc_iova_check_hole(
> > +					    &reserved_span, length,
> > +					    iova_alignment, page_offset))
> > +					continue;
> 
> this could be simplified by double span.

It is subtly not compatible, the double span looks for used areas.
This is looking for a used area in the allowed_itree, a hole in the
area_itree, and a hole in the reserved_itree.

I don't think IOVA allocation should be a fast path so it is not worth
alot of effort to micro-optimize this.

> > +static int iopt_check_iova(struct io_pagetable *iopt, unsigned long iova,
> > +			   unsigned long length)
> > +{
> > +	unsigned long last;
> > +
> > +	lockdep_assert_held(&iopt->iova_rwsem);
> > +
> > +	if ((iova & (iopt->iova_alignment - 1)))
> > +		return -EINVAL;
> > +
> > +	if (check_add_overflow(iova, length - 1, &last))
> > +		return -EOVERFLOW;
> > +
> > +	/* No reserved IOVA intersects the range */
> > +	if (iopt_reserved_iter_first(iopt, iova, last))
> > +		return -ENOENT;
> 
> vfio type1 returns -EINVAL
> 
> > +
> > +	/* Check that there is not already a mapping in the range */
> > +	if (iopt_area_iter_first(iopt, iova, last))
> > +		return -EADDRINUSE;
> 
> vfio type1 returns -EEXIST

Hum I guess we can change them here, it is a bit annoying for the test suite
though.

> > +static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long
> > start,
> > +				 unsigned long end, unsigned long
> 
> s/end/last/
> 
> > +int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
> > +		    unsigned long length, unsigned long *unmapped)
> > +{
> > +	unsigned long iova_end;
> 
> s/iova_end/iova_last/

yep
 
> > +static int iopt_calculate_iova_alignment(struct io_pagetable *iopt)
> > +{
> > +	unsigned long new_iova_alignment;
> > +	struct iommufd_access *access;
> > +	struct iommu_domain *domain;
> > +	unsigned long index;
> > +
> > +	lockdep_assert_held_write(&iopt->iova_rwsem);
> > +	lockdep_assert_held(&iopt->domains_rwsem);
> > +
> > +	if (iopt->disable_large_pages)
> > +		new_iova_alignment = PAGE_SIZE;
> > +	else
> > +		new_iova_alignment = 1;
> 
> I didn't understand why we start searching alignment from a
> smaller value when large pages is enabled. what is the
> connection here?

'disable_large_pages' is a tiny bit misnamed, what it really does is
ensure that every iommu_map call is exactly PAGE_SIZE, not more (large
pages) and not less (what this is protecting against).

So if a domain has less than PAGE_SIZE we upgrade to
PAGE_SIZE. Otherwise we allow using the lowest possible alignment.

This allows userspace to always work in PAGE_SIZE units without fear
of problems, eg with sub-page-size units becoming weird or something.

> > +	interval_tree_remove(&area->node, &iopt->area_itree);
> > +	rc = iopt_insert_area(iopt, lhs, area->pages, start_iova,
> > +			      iopt_area_start_byte(area, start_iova),
> > +			      (new_start - 1) - start_iova + 1,
> > +			      area->iommu_prot);
> > +	if (WARN_ON(rc))
> > +		goto err_insert;
> > +
> > +	rc = iopt_insert_area(iopt, rhs, area->pages, new_start,
> > +			      iopt_area_start_byte(area, new_start),
> > +			      last_iova - new_start + 1, area->iommu_prot);
> > +	if (WARN_ON(rc))
> > +		goto err_remove_lhs;
> > +
> > +	lhs->storage_domain = area->storage_domain;
> > +	lhs->num_accesses = area->num_accesses;
> > +	lhs->pages = area->pages;
> > +	rhs->storage_domain = area->storage_domain;
> > +	rhs->num_accesses = area->num_accesses;
> 
> if an access only spans one side, is it correct to have both split sides
> keep the access number?

Er, this is acatually completely broken, woops. A removal of an access
will trigger a WARN_ON since the access_itree element is very likely
no longer correct.

Ah.. So the only use case here is unmapping and you can't unmap
something that has an access established, except in some pathalogical
case where the access does not intersect with what is being mapped.

There is no way to tell which iopt_pages_access are connected to which
areas, so without spending some memory this can't be fixed up. I think
it is not a real issue as mdev plus this ancient VFIO interface is
probably not something that exists in the real world..

+       /*
+        * Splitting is not permitted if an access exists, we don't track enough
+        * information to split existing accesses.
+        */
+       if (area->num_accesses) {
+               rc = -EINVAL;
+               goto err_unlock;
+       }
+
@@ -1041,10 +1050,8 @@ static int iopt_area_split(struct iopt_area *area, unsigned long iova)
                goto err_remove_lhs;
 
        lhs->storage_domain = area->storage_domain;
-       lhs->num_accesses = area->num_accesses;
        lhs->pages = area->pages;
        rhs->storage_domain = area->storage_domain;
-       rhs->num_accesses = area->num_accesses;
        rhs->pages = area->pages;
        kref_get(&rhs->pages->kref);
        kfree(area);

Thanks,
Jason
