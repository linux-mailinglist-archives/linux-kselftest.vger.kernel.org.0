Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05236286E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 18:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiKNRV0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 12:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbiKNRU7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 12:20:59 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389161F9D0;
        Mon, 14 Nov 2022 09:20:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UK7SUkK+FCc5VvlEj9Ee54ALGNwiSlHytngEXPtPE/289cwjHQObzlS2lDmNwcNk8q7S0rDuJv2Y5Bwwx5FPMoxyrv2D02DgoYNv/n3knH5uvaNatw+GFmfzT0Sk/M8jzkGoFyZc8Jsxjb4wBX6qXfqPanLXMqzMlHzF7AJt2I+FSdc3Fk/qRLON09ukf0aqDYKFUha7hSk0RjxqEu3ACwPjford3qGa7X4CdHqDAwSx787bHhE7eaBRLISAGjvdDDbHrKsOo1j1bHKhZXeq1fUVINvN5fUySLEgi9gMrcQxJLNCmwwGWibBJvfivpsCyn+MZSJky65YGCpQKA4Swg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkHAlZwAEpAVUoM+Qb2ZATjemQTlKfed1klJCzoHzBU=;
 b=gjueQBQMlFQSJfbLv7Ltli9Eyvc8TBpYalwC/ceXZTVUapUuRGAIddPShO194w2/pIaSoUgzvFUX3kLXZtASHhxDBd8aOKd4wrQx6I7AJ9E21MyXZuWjjSZYeQdWvUAxj5f2KwOGxSKservsZdMxRCwDJvNa+XgIwOcuzXbIxB/SRPWuYhok10bR9UwgWg2ElYKEQEinkTQR4/qPUNXeppVnTio3IoFzAb7ruh1gQ9xwl0Dcs+lC5joyj6QWNwULlTEkhG2IKjw/lHMtsIVg7ekaNZEfnVfIivGNhN2ep8a1i0aY8kw+5SgicPn7MLp3gmuiXLvOLIOBV6idTQrE7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkHAlZwAEpAVUoM+Qb2ZATjemQTlKfed1klJCzoHzBU=;
 b=Aj3IkSODQNKbFf97DBJNIZeSbr9yhzSUxAfQlbmOtTM3ckHCuM7aS6WjZfj9vgeILdugn8K0J/9afF+oZqLgte7e4dM0H+IDHCmWwkKaynqMvrrwEQijRBn7ZgoBx52g+aHM6ZV3OOJmRTqxg8lVQoeiAU6MQCizXe+e8nCDsQPK1VeeM8HUCRB3ev9Z0BM+kgEONor4jKwOlcN5/rkAKsM8D5OB1UOHfvS5GVwsCfvegw/m9jjrUggYTbnp+MRFnRd6mytOvaO/d2YlQ8OpeHWRE8aPcOC8lRzJA/s6801hlofD0jSXtDtRN97bgJ4zy6RWGC48V7A371iLlpMTIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 17:20:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 17:20:55 +0000
Date:   Mon, 14 Nov 2022 13:20:53 -0400
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
Subject: Re: [PATCH v4 07/17] iommufd: PFN handling for iopt_pages
Message-ID: <Y3J49YEYsAXxLfQP@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <7-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <BN9PR11MB5276A7603D48E46D82B763118C009@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A7603D48E46D82B763118C009@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:91::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: cecc41da-b8b9-4a98-c872-08dac6649650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylltoyo5SgbcMKOJ/Ulh8uQ7rJvDevDP++lrNO8sUeFCG604PILoz4XAe/ISNv8mqT6LbwN+E86RX+mOzj2Hm/uJV8+zjUs3q2MgPAPzc/qV4NLEuz9/ZY473YrlL4a1ofC/DNIXcHoWsVVfcy67cd0NJJo58LSefX46mTtmq4/L/mfz31GYttis9ds6p85ZSQkIK9TtjYdmtmXX1J7ZDDirwu/9gyKS9KJo+GcJgFZ1E8LoWgY5sNyEkXKtWQIMmaaL1jNoL6vLmwJt0GeAxJG/wM0HK+RqMscZ6JJHeHlC1TJx9aWc7uBGd8hyPzAoLGVeNqPrdYA0jNZzITZ6gCkXi1QPpmVt8dwJmg9j16naAbNoQF80euhQP1nlJmVoxe9LEyTnhCJxleqfpqRjyBSsKJpP8GKx7E7Vkv+fg8Ru8WETXLrElOowwpLTXlHgaQ5yn/4Oe46Z8Ug/s9DAU/iDbjhO5env00c1pjPiqKt+y9szPESTijCs++GbLcDrHzt74WxPKfslTMnHgcI/XuWym/55arc3jy+rLVNeWoopA83r9Qlb2Uu2VXfyCNcOJnFNwvIicRJjGKeYycKtMWK04hJwqP5tVSAxldjma//UqyiO8fmWMRvRmZ1NjgCUa3Eeu/U8Fj4C8hpF7T7hgKhJaC+IHieci3dN1JJHUVKBtkx8oPlH5kAUmw56VqcfiYGMwuI6lJV9UCz6ZTDC3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(7406005)(2906002)(7416002)(8936002)(5660300002)(66899015)(36756003)(66556008)(66946007)(316002)(8676002)(54906003)(6916009)(6512007)(41300700001)(6506007)(6486002)(26005)(478600001)(4326008)(83380400001)(186003)(2616005)(86362001)(38100700002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8EJq1iAa4DKnDX+dq1voKUs4KO6y2bdvAVkrHF6AkDIfZRQtB5rRni9N+oZ8?=
 =?us-ascii?Q?W2W21Vwrz1ou++vwpNPHfGADRevXSy2W42o8NltmNEa5x5hZUISfU8aJJVPq?=
 =?us-ascii?Q?AU9IeJq9X2ee4J7Pp41R0gxd7hmHbUJOjlYNNPl7mkAoFxZYN/aGcch1sU1A?=
 =?us-ascii?Q?3tg2IzOjeygi3fQDO5Pujkje0OYPYRqPUQ4tiLCbwCYcq0PNuWroFYV07J0A?=
 =?us-ascii?Q?vWWPV8/PgElGvUz9rnuxf3brZzorW+Q+SrT5yebapkS0aXM6PGP/yRPgRa0Z?=
 =?us-ascii?Q?f0Pt9VQuBTvXJfzjrycRmbYGuAV0fGQ2ewsijech0e6Z5cugY51046NG0U4T?=
 =?us-ascii?Q?p+tayrFkC4WS6NiuXjR1kxdcjNWhVeVpCknk4MKmdetZX/W7EWArm2GWZ+xJ?=
 =?us-ascii?Q?VrkU4VYhatR3oqVVHJ5DsqYGYCiJUkj/Tsp9qcAhyuu3bUMEEkzJcuWiXgxY?=
 =?us-ascii?Q?eLBTmbDvW8UQ20CAQLNZY+BPkbFUH8/9V7dzVRr7PrrHDQagL+7VNlfPXhbu?=
 =?us-ascii?Q?fHQCR5IwWH12mD2r8FtkbGOyZnUwkA6CDksxpgYMfcj8VMkMYehZCM8ytLza?=
 =?us-ascii?Q?fRM0BloCmSPY1GvEgauIlbpYnfYjtHP0884GkX1qey3DGgd346DniiOHeCFS?=
 =?us-ascii?Q?aS6eOvDkomfevD8BUf/Jz6gBnKOM8+nSPEwikK4HaR86wE3yrCiQQDw4ry53?=
 =?us-ascii?Q?OOh9DpaRUDV7shAvW/U9cXR2znoNfMrs7AlOyn1qzhWgq/HaPVwHrALhC3SF?=
 =?us-ascii?Q?U8ekj9onig2OvoTrvJd7YNLEwR64+hZuui5flHeSGyvh7DK0AJseC/KLa6Jc?=
 =?us-ascii?Q?f5VYGtDqNPcWQ7pL/qt911H5V9+oX0AEFDdWddiA+1j428qpvvDwUHYECVA1?=
 =?us-ascii?Q?rs6lqFFEfWSxg8LHblMDJwBfAa7leRxL8i9FYn3WAxJC7McuFh1UgyF31Pl3?=
 =?us-ascii?Q?mlNDXastkXADun5OI8IRW8bOc8OBi6lQhlBSO/HmxSfMik+n+G4Sv3Xvw6ol?=
 =?us-ascii?Q?iy1PBxPgJglAVvyt5xGQKuUlATlxWm4TGs48zOit2yrgeqPz86znkX0JLjYx?=
 =?us-ascii?Q?1tgS292FUiCOWRcvqX/zNM8BdrKZheQdNideiPJjRoTbB/yhzJXBW3COcQYD?=
 =?us-ascii?Q?o8lgW8xZGY7ajhW2O93nvSRnT3mfLuddpbqc8572ufTtoqQ9OeOC6TDvo/YI?=
 =?us-ascii?Q?1ot51ZQ2kyH6TmYixfXdDjpjPM1LhZyK6yMv+dJbblPHUKI/cFCc7OufL2+Q?=
 =?us-ascii?Q?NmN/y1i170jwciCRF8s469BVvT8/2fkm9snUl+J9Z/7w9qiH0oDQNQ8o6MIn?=
 =?us-ascii?Q?r9wwZgWPfxgZbEQyrxU4EWmyHN/9Ivc67K/IntBAwDEp29YQQfdgUcyb2vUP?=
 =?us-ascii?Q?VL4sFM1JkIFanW3rbJPPyHpi2uki6x4RZYhAp+mK0Y/YGQG1Jv8xpUW9xaXx?=
 =?us-ascii?Q?ZHid8uRVYVhSVyPrsPknuhf7hDTDaOyAJL1uKdJ9vf/ZMk3rUzoOfNNbFaQD?=
 =?us-ascii?Q?5GyC+MJPF6QZdjC8/BQhkdH6saiOX4NFQYTENSyPEKeIWE5hXSbhysEeiBWM?=
 =?us-ascii?Q?kE95nnr2pr2m7R+Ps50=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecc41da-b8b9-4a98-c872-08dac6649650
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 17:20:54.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppOtoS+ZmULwdF8tTQ5eesrkAqh8BGP3HpRkjdkhfG9YVDiVG3B/zYofWeGfeIe8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 11, 2022 at 09:56:58AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, November 8, 2022 8:49 AM
> > 
> > +
> > +struct interval_tree_double_span_iter {
> > +	struct rb_root_cached *itrees[2];
> > +	struct interval_tree_span_iter spans[2];
> > +	union {
> > +		unsigned long start_hole;
> > +		unsigned long start_used;
> > +	};
> > +	union {
> > +		unsigned long last_hole;
> > +		unsigned long last_used;
> > +	};
> > +	/* 0 = hole, 1 = used span[0], 2 = used span[1], -1 done iteration */
> > +	int is_used;
> > +};
> 
> lack of a comment how this expects to be used as done for
> struct interval_tree_span_iter. e.g. there is no value
> representing used by both spans which implies this is used
> to find valid range in either side. Those should be spelled out.

/*
 * This is a variation of the general interval_tree_span_iter that computes the
 * spans over the union of two different interval trees. Used ranges are broken
 * up and reported based on the tree that provides the interval. The first span
 * always takes priority. Like interval_tree_span_iter it is greedy and the same
 * value of is_used will not repeat on two iteration cycles.
 */

> 
> > +/*
> > + * The IOVA to PFN map. The mapper automatically copies the PFNs into
> > multiple
> 
> what is the mapper?

Let's just say "The map automatically"

> > +	ret = iommu_unmap(domain, iova, size);
> > +	/*
> > +	 * It is a logic error in this code or a driver bug if the IOMMU unmaps
> > +	 * something other than exactly as requested. This implies that the
> > +	 * iommu driver may not fail unmap for reasons beyond bad
> > agruments.
> > +	 * Particularly, the iommu driver may not do a memory allocation on
> > the
> > +	 * unmap path.
> > +	 */
> 
> didn't understand the last sentence.

Unmap path means its domain_ops->unmap

> > +static void batch_skip_carry(struct pfn_batch *batch, unsigned int skip_pfns)
> 
> add a comment similar to batch_clear_carry()

It seems OK as is, the comment describing what carry is just a few
lines above

> > +{
> > +	if (!batch->total_pfns)
> > +		return;
> > +	skip_pfns = min(batch->total_pfns, skip_pfns);
> > +	batch->pfns[0] += skip_pfns;
> > +	batch->npfns[0] -= skip_pfns;
> 
> what about skip_pfns exceeds batch->npfns[0]? looks this works only
> if batch->total_pfns = batch->npfns[0]...

Right, at this point the batch has only 1 pfn and total_pfns ==
batch->nfpfs[0]

Let's add an assertion:

@@ -239,6 +239,8 @@ static void batch_skip_carry(struct pfn_batch *batch, unsigned int skip_pfns)
 {
        if (!batch->total_pfns)
                return;
+       if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+               WARN_ON(batch->total_pfns != batch->npfns[0]);
        skip_pfns = min(batch->total_pfns, skip_pfns);

> 
> > +/* true if the pfn could be added, false otherwise */
> > +static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
> > +{
> > +	/* FIXME: U16 is too small */
> 
> performance or functional impact?
> 
> what would be the fix? and why cannot it be done now?
> 
> more comment is welcomed.

Er, as you noticed this was fixed and the rebase to fix it was
botched. It will be u32
 
> > +static void batch_unpin(struct pfn_batch *batch, struct iopt_pages *pages,
> > +			unsigned int offset, size_t npages)
> > +{
> > +	unsigned int cur = 0;
> > +
> > +	while (offset) {
> > +		if (batch->npfns[cur] > offset)
> > +			break;
> > +		offset -= batch->npfns[cur];
> > +		cur++;
> > +	}
> 
> 'offset' usually means byte-addressed. 'index' is a better fit in
> this context.

It is the offset into the logical page array held in the batch.

'first_page_off' would be clearer

Thanks,
Jason
