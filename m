Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6C66287CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 19:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiKNSEQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 13:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbiKNSDr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 13:03:47 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AFF2F00F;
        Mon, 14 Nov 2022 10:02:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVHM/k346cD9pIWW4ImEeeVmhcCi3x9bsYN+PuAHLEPw2ecWagC7LARF0TZGapPaOAxswZBQZfmz9HjcRMXPw0ZdpQBaB5KR54R05akRqasBuSL5eegrk4rSfMsYMIH/LJ7EyqTWPWWG6L7qev8iWmMC2DmEkS3x/xNu2TcyXYtlgP4+nAYMv+y4LJqz6xwrTNQnPYdcbn7iCLVvH3N7flvAAwbuglBRoWsVjJASkB6DPcIxCeXCfMdBFI9qFMYtwNWhWQ2GetbsVLEcEFuGs0U0zoJGJjnA6zBVJ1LNRmn1R9p/c4aVZs37WsWwEeX9vIrk33nwRaDaKZKNt5GKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Z12w9YKBAWurkXRk53m4T3Ac4PmczkssdGIk2oOzwE=;
 b=lrsQrfJuSBDBC04zwW6g6TjZxv8PoMATaI8s+jmYbdoSIvaMCe18d4+TRc+ZQo1ZnfN3BVVlVv/7bEDLmlbLXis+IuT7v2TdLRucd/A62FyIIRI4zbjDKu1MOLVqk3IEj0msGGyMnvoq93TGkHXzRZHZaGsE5FwlPcR8nkoZ+OFnm2mfsJ1toOL5Fj9+zRcXalgZhGT7/w1Jf+SnVTdZHFXHDYEvGQJvnkKhilMU/bM3qiZ+RE3g8pM1BtVxFWvkX4HiOD7ezcnGKQ8l4zJNjVwfxMQ/6V1LDeVmvoOa9Gj5jxkt2Sta3ZA03A5hRG39P5FN6jG3ScHBiQpki3/K9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z12w9YKBAWurkXRk53m4T3Ac4PmczkssdGIk2oOzwE=;
 b=hlWqCcX2D0u7I+J98Y28E/9DSJkgxTuRnRZLolr9MlK+Z5HvUE5ED7qnWUHzxn4DWyvWAPTDQdav7oq+vVW7VsU+JNoTPo9q4NRcby7FygwBbQE6HEkIg+ayr0pCDWPPE4Gf3mBHg5REj7S6WQMKmFoiBx96qUDL1gn8NUC6N/op9C9Fdyv0RfiNPsINMJsr+uAqfr++Bw2pnxiR6sxSzDQdM3uRm5994ZK/0h2TFNfsXSIptxcuptzxQTnYdoVZmTN0y86CIPPwV+0VaakwX+XvaaCNMBSbrEmPf0plvis2kD6Cg5zvXpnTf3fPlryD4jtzZ0zlVdq9HYB0TXMD7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 18:02:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 18:02:40 +0000
Date:   Mon, 14 Nov 2022 14:02:38 -0400
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
Subject: Re: [PATCH v4 08/17] iommufd: Algorithms for PFN storage
Message-ID: <Y3KCvnLOZpGXAGhU@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <8-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <BN9PR11MB52762E5ACAAE7D7B398730D78C059@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52762E5ACAAE7D7B398730D78C059@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: d3801490-a290-4b20-7594-08dac66a6af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2fObPUs9Fe6Rz4hbVDnj3R6s41j3/rsoBngQuDfm04IPXCnzizWyRLA2dlzxAcrkymdb3OhC0g5X5OgqgyVvwJ4jzyx9vo8q7CUf+QzrSBmxFoAIiS74lSlfYuFJecFkP+fh0z0zjo9XX/6m9OOwbwKVJaAIWH4sk9Zb1aQnecBZJhJ+EKyTCLeGh4P0HxUuWJlDG3r+zO0IfzSzihPrWzEiHx4ptywZ6lcSHOqyw/PMp93xHCHnAR8uLCnBCk9oN/fOrOH+zHJeIaaRfIHzTX2h4lJxb2mlPMGNA2UOw6xfiZVJwQlHFi2XSZf3iYB/EugjOF0f6EGA+F3ex5akHAa1i0DUoMLdDtP8d+Twp4K1FAFwwxoPF7aT46pUlHDuZTwqypH5ElI+Q35Gk3NVB1QTIDFr/aoAUcaM5PtRilZ4ciIKl/0bBejnc1z4Cusrm0np09rU8WHAT2i7ltvKjynKJW8BTpDosP4UP76jrgEmlBZa9kV+8Zk1V7DcD7H20KUbq7d8o4it8D/k/OgLzFJnox9Rrv6FEWECy+cL6Cncls6L7sLwVX3Z8/DDbbVV9rezNLt6zCZ+/ur8XwR7V9cf1v71xeM3teYwLaOvypODmVgyp7ChygbJJX37Ywm0pi34/9SkYvtAc8i4LRUs5Ptnvapi7L1ciUQaIY0hqvixMz5WkLxHofPYrQ+PQs59GpNCfTplFQ7tvMMrvfbDljCWjpd8O2NSi7mknCDwUi81VxJgP3M8qXkfcdfLfxF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(83380400001)(186003)(2616005)(38100700002)(2906002)(7406005)(7416002)(8936002)(478600001)(6486002)(5660300002)(6506007)(26005)(6512007)(4326008)(8676002)(66476007)(66556008)(66946007)(41300700001)(316002)(6916009)(54906003)(66899015)(36756003)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BZj8a7btbt9j/2v5uQjjqck0TGlUilqBVO6XWp5Zf75vD8YtMztucPZSE3fW?=
 =?us-ascii?Q?w5RmDUTtUuTCpq7EFiUbPOBHcR3x274KlTXdvSPl6oo3wDNtvy3ChshbkdDS?=
 =?us-ascii?Q?eF3V5F2YJoQsrG+Kmdg87Gr/84hzUeLtG4/FWPNDO8CRXjipmLSxzFZLVPHc?=
 =?us-ascii?Q?1GCkJox1DM/FjVZQeGMyeh9sYVT+W3597mpqWuoUUq/31lQ7WKdVYEV18lna?=
 =?us-ascii?Q?s48hhlf/2xHJchFXczL5irSPIEHecvDKllNj5A0YGCEt/zkMnjGs6g/+ZYSb?=
 =?us-ascii?Q?+9+OnbLyQpwJMyfgjTdfSK1sxQfnRfY8ALVKoRbSX0Q2XDnAoaVbPjKtLX70?=
 =?us-ascii?Q?Y4f69Sci8bdqbW24f1DpnKbwSCIQEGTMOpy4QAimquLfteP2Tm7QIUNweeT9?=
 =?us-ascii?Q?Nr+CFxRKuSg9jNWwFShQSmbZcKMpgvjZrlNjI7feytX4G+BAF5kcgXhKBn8L?=
 =?us-ascii?Q?QhtnwQdUFDK9cXOV27IoXxQp4M3nvNBFj19DavxWL+DY/WeJTuaiOuVv/wmT?=
 =?us-ascii?Q?GjCxTyTPGhZRMBjskq2xv5nuYJvXh4/6hLpdnnpXAkC7V/UEjenwG4TECqda?=
 =?us-ascii?Q?e5x7yzDlvMKek4+aon5n6fasK0jld/Tq3vSvorhkhEMSxOIWb1YRpK6yFaqK?=
 =?us-ascii?Q?IoK6hbSY6/5EmD+klfx2WM9fiMgtMU77Nv+0agAVsJFJ0CddVOh/q27Jg5Q/?=
 =?us-ascii?Q?xuyhScRTc4qFe+vt+04h53PphkQhu8fgsIYZu2PPtnXhOGysJ++ZkE89mjMe?=
 =?us-ascii?Q?NkEIbtufsoQ8Ik8ft5CXgHdnS9049zuI/NNCmAOpZuLBeojmsEophQhSGo9y?=
 =?us-ascii?Q?PmnpKcotH95t63PJsCrS2lQkZlf5e6gKPsSqRc9LmNyF8Oi2hfcYQ0HHpRqP?=
 =?us-ascii?Q?bED0JwF7D5SBMONflJv7cukZEDTw7kBJ7M00LPqriYjDZ6xY+Jh9PM949vS1?=
 =?us-ascii?Q?C4SjAmraqjd2tLpfnhcPctd4f/X+K/V0BNNfNBt2V7JtsSewWtMO0JCUrxCU?=
 =?us-ascii?Q?zaFxGqz/vLjQJvkYOJANZfdssu+w7Z4TYm561I2XanMuJHlVcagqbUVRgFVs?=
 =?us-ascii?Q?fRe6OsRuuvZTozb0CwWXb3BqFaDsIC9NStNciAfm6FOi2TzfkUTKTafDk/tD?=
 =?us-ascii?Q?9DMbzLxkdhuAhmM8XLhH4wbM24zL0YA+KbJuihBrcqOZxcH1nzFvSO/B6721?=
 =?us-ascii?Q?N+yRMpOBMZ5OE07PKFjWoG4mX0oAKuszLghEa7gr6OJ8rJZolG8ss5605iOE?=
 =?us-ascii?Q?rVf6cjWAW9k2BKxsCo+5yKeyKQYib7cqmjw5tAzEfbGAATCTIT9u/+lYydu7?=
 =?us-ascii?Q?NjAxhV8EF18p82eHao/ZJ1RviLT2dp/qF7mqvcbteRPIIqvAzgeKvky/aIZs?=
 =?us-ascii?Q?ysS4KpVB53m0mqu4QIqPIJQ9l2bXEOKDkdLvrq5Xp5ZJ4jk4G1Cl6eWn3D3p?=
 =?us-ascii?Q?6VdPJ3JYuTtavlu57AvpWHMX3RTIfdEnIrpSItJgNNV7Lk9TzcSUoMPuMw4j?=
 =?us-ascii?Q?ysx/m2IZWx4DXOQIy4D3q1Z4ouLZQ9MyNowSSvTLjqAcBMtnKmGLE2MdGpSJ?=
 =?us-ascii?Q?+rUXLuM/VJBrh4HkYsA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3801490-a290-4b20-7594-08dac66a6af8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 18:02:40.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjSfnZ7dF6hNmnTi3CWxKUlCsySY7Vt3OOsKLGm3gYNdPN1qWofAyGCh504kj9e9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 14, 2022 at 05:50:50AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, November 8, 2022 8:49 AM
> > 
> > @@ -171,7 +183,7 @@ static struct iopt_area
> > *iopt_pages_find_domain_area(struct iopt_pages *pages,
> >   */
> >  struct pfn_batch {
> >  	unsigned long *pfns;
> > -	u16 *npfns;
> > +	u32 *npfns;
> 
> why not making it u32 and removing later FIXME directly in patch7?

Rebase error, I fixed it

> >  static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
> >  {
> > -	/* FIXME: U16 is too small */
> > +	const unsigned int MAX_NPFNS = type_max(typeof(*batch->npfns));
> 
> use lowercase i.e. max_npfns.

It is customary to use caps for constants, eg enum values and things

> > +static void __iopt_area_unfill_domain(struct iopt_area *area,
> > +				      struct iopt_pages *pages,
> > +				      struct iommu_domain *domain,
> > +				      unsigned long last_index)
> > +{
> > +	struct interval_tree_double_span_iter span;
> > +	unsigned long start_index = iopt_area_index(area);
> > +	unsigned long unmapped_end_index = start_index;
> > +	u64 backup[BATCH_BACKUP_SIZE];
> > +	struct pfn_batch batch;
> > +
> > +	lockdep_assert_held(&pages->mutex);
> > +
> > +	batch_init_backup(&batch, last_index + 1, backup, sizeof(backup));
> > +	interval_tree_for_each_double_span(&span, &pages-
> > >domains_itree,
> > +					   &pages->access_itree, start_index,
> > +					   last_index) {
> > +		if (span.is_used) {
> > +			batch_skip_carry(&batch,
> > +					 span.last_used - span.start_used + 1);
> > +			continue;
> > +		}
> > +		iopt_area_unpin_domain(&batch, area, pages, domain,
> > +				       span.start_hole, span.last_hole,
> > +				       &unmapped_end_index, last_index);
> > +	}
> > +	if (unmapped_end_index != last_index + 1)
> > +		iopt_area_unmap_domain_range(area, domain,
> > unmapped_end_index,
> > +					     last_index);
> 
> a comment marking that it's for the last trailing used span of which
> the pages are not contiguous to previous span.

	/*
	 * If the range ends in a access then we do the residual unmap without
	 * any unpins.
	 */

> btw it is not easy to understand how this func plus unpin_domain()
> actually work. more comments are welcomed to help readability.

	/*
	 * For security we must not unpin something that is still DMA mapped,
	 * so this must unmap any IOVA before we go ahead and unpin the pages.
	 * This creates a complexity where we need to skip over unpinning pages
	 * held in the xarray, but continue to unmap from the domain.
	 *
	 * The domain unmap cannot stop in the middle of a contiguous range of
	 * PFNs. To solve this problem the unpinning step will read ahead to the
	 * end of any contiguous span, unmap that whole span, and then only
	 * unpin the leading part that does not have any accesses. The residual
	 * PFNs that were unmapped but not unpinned are called a "carry" in the
	 * batch as they are moved to the front of the PFN list and continue on
	 * to the next iteration(s).
	 */

> > +/*
> > + * This can do everything and is fully coherent with what a iommu_domain
> > would
> > + * see.
> > + */
> > +static int iopt_pages_rw_slow(struct iopt_pages *pages,
> 
> Can you elaborate what guarantees coherency in this function and how it
> becomes different in other rw variations?

/*
 * This uses the pfn_reader instead of taking a shortcut by using the mm. It can
 * do every scenario and is fully consistent with what an iommu_domain would
 * see.
 */

> > + * iopt_pages_remove_access() - Release an in-kernel access for PFNs
> > + * @area: The source of PFNs
> > + * @start_index: First page index
> > + * @last_index: Inclusive last page index
> > + *
> > + * Undo iopt_pages_add_access() and unpin the pages if necessary. The
> > caller
> > + * must stop using the PFNs before calling this.
> > + */
> > +void iopt_pages_remove_access(struct iopt_area *area, unsigned long
> > start_index,
> > +			      unsigned long last_index)
> 
> this is called iopt_pages_xxx() but the first parameter is iopt_area.
> 
> also it's not balanced with iopt_pages_add_access() which requires the
> caller to hold pages->mutex and populate area->num_accesses.

OK, see below

Thanks,
Jason

--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -565,7 +565,7 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
 
 	down_read(&iopt->iova_rwsem);
 	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
-		iopt_pages_remove_access(
+		iopt_area_remove_access(
 			area, iopt_area_iova_to_index(area, iter.cur_iova),
 			iopt_area_iova_to_index(
 				area,
@@ -650,15 +650,10 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 			goto err_remove;
 		}
 
-		mutex_lock(&area->pages->mutex);
-		rc = iopt_pages_add_access(area->pages, index, last_index,
-					   out_pages, flags);
-		if (rc) {
-			mutex_unlock(&area->pages->mutex);
+		rc = iopt_pages_add_access(area, index, last_index, out_pages,
+					   flags);
+		if (rc)
 			goto err_remove;
-		}
-		area->num_accesses++;
-		mutex_unlock(&area->pages->mutex);
 		out_pages += last_index - index + 1;
 	}
 	if (!iopt_area_contig_done(&iter)) {
@@ -673,7 +668,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 	if (iova < iter.cur_iova) {
 		last_iova = iter.cur_iova - 1;
 		iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
-			iopt_pages_remove_access(
+			iopt_area_remove_access(
 				area,
 				iopt_area_iova_to_index(area, iter.cur_iova),
 				iopt_area_iova_to_index(
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 3b85fa344f6be3..68bc3957534dd7 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -221,10 +221,10 @@ int iopt_pages_fill_xarray(struct iopt_pages *pages, unsigned long start,
 void iopt_pages_unfill_xarray(struct iopt_pages *pages, unsigned long start,
 			      unsigned long last);
 
-int iopt_pages_add_access(struct iopt_pages *pages, unsigned long start,
-			unsigned long last, struct page **out_pages,
-			unsigned int flags);
-void iopt_pages_remove_access(struct iopt_area *area, unsigned long start,
+int iopt_area_add_access(struct iopt_area *area, unsigned long start,
+			 unsigned long last, struct page **out_pages,
+			 unsigned int flags);
+void iopt_area_remove_access(struct iopt_area *area, unsigned long start,
 			    unsigned long last);
 int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
 			 void *data, unsigned long length, unsigned int flags);
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 01d2447eac4ede..e5f267d9e2b491 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1807,8 +1826,8 @@ iopt_pages_get_exact_access(struct iopt_pages *pages, unsigned long index,
 }
 
 /**
- * iopt_pages_add_access() - Record an in-knerel access for PFNs
- * @pages: The source of PFNs
+ * iopt_area_add_access() - Record an in-knerel access for PFNs
+ * @area: The source of PFNs
  * @start_index: First page index
  * @last_index: Inclusive last page index
  * @out_pages: Output list of struct page's representing the PFNs
@@ -1819,40 +1838,49 @@ iopt_pages_get_exact_access(struct iopt_pages *pages, unsigned long index,
  *
  * This should be undone through a matching call to iopt_pages_remove_access()
  */
-int iopt_pages_add_access(struct iopt_pages *pages, unsigned long start_index,
+int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
 			  unsigned long last_index, struct page **out_pages,
 			  unsigned int flags)
 {
+	struct iopt_pages *pages = area->pages;
 	struct iopt_pages_access *access;
 	int rc;
 
 	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
 		return -EPERM;
 
+	mutex_lock(&pages->mutex);
 	access = iopt_pages_get_exact_access(pages, start_index, last_index);
 	if (access) {
 		refcount_inc(&access->refcount);
 		iopt_pages_fill_from_xarray(pages, start_index, last_index,
 					    out_pages);
+		mutex_unlock(&pages->mutex);
 		return 0;
 	}
 
 	access = kzalloc(sizeof(*access), GFP_KERNEL_ACCOUNT);
-	if (!access)
-		return -ENOMEM;
+	if (!access) {
+		rc = -ENOMEM;
+		goto err_unlock;
+	}
 
 	rc = iopt_pages_fill_xarray(pages, start_index, last_index, out_pages);
 	if (rc)
-		goto out_free;
+		goto err_free;
 
 	access->node.start = start_index;
 	access->node.last = last_index;
 	refcount_set(&access->refcount, 1);
+	area->num_accesses++;
 	interval_tree_insert(&access->node, &pages->access_itree);
+	mutex_unlock(&pages->mutex);
 	return 0;
 
-out_free:
+err_free:
 	kfree(access);
+err_unlock:
+	mutex_unlock(&pages->mutex);
 	return rc;
 }
 
@@ -1865,11 +1893,11 @@ int iopt_pages_add_access(struct iopt_pages *pages, unsigned long start_index,
  * Undo iopt_pages_add_access() and unpin the pages if necessary. The caller
  * must stop using the PFNs before calling this.
  */
-void iopt_pages_remove_access(struct iopt_area *area, unsigned long start_index,
-			      unsigned long last_index)
+void iopt_area_remove_access(struct iopt_area *area, unsigned long start_index,
+			     unsigned long last_index)
 {
-	struct iopt_pages_access *access;
 	struct iopt_pages *pages = area->pages;
+	struct iopt_pages_access *access;
 
 	mutex_lock(&pages->mutex);
 	access = iopt_pages_get_exact_access(pages, start_index, last_index);
