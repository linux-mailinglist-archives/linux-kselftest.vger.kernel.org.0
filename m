Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB75629F64
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 17:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiKOQpC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 11:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiKOQo7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 11:44:59 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736881BEB6;
        Tue, 15 Nov 2022 08:44:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hs+NHMCheCKLroyU626KI2tJAYE0VkGt98X/x9ZRNgUabJpuRLCZ73y63bAdoeioyBty5+HOyyzKcLs5Q/7xXHX+vZbhu8qZjvNbRvm4nSbEFEKZow3WNNenPvSrFZsT8O/FDUKR6MPjmOjHLAQvEhCGmdavIHnULPOkjPkGSkqOcOlUE/tJX731wzKWc1D6YxDhAVrMc6pyZTcZuwuIDBu9RBxc/G6ujvFsJ3a4qi65+TE9FZDPNDQvm1yT8T3g0/uZaf6Bv6LuPkZH6zeYAOl5koVP3S5Y119/VZks1R1LeGNtsY9ywStvlJsLtVWlsj+UY14I/pGzh02lKvxqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yadb2DY0fufBAn9xcNz380NISVadgeCgKXblmyMCJyE=;
 b=Lv+7Hf2otQAOhKQSBL5BHmzK6OBuM1NHXrYXPg9DnFIBRUZgNEgo1HNoCNkz9taGqwDfE3UP88kev106jzZiGlIqgJqKNiC86E5ayZreeWOv/fuKZFv48WORGG0f/Ap3iks/KuoK56y1Tccy/SGFPtwhU6EM2hpyTQJgEXg87yxobEEFOi3aFpWG+ZUUE09CS7/5EHBRlAHtx77egfK4xtX0kotGCQa3GPguHF+k+A6muEeFXw7RSsDwPo4hNcdX2mjpu/MA7N1crjCkPzuit/stD+/KblaJ69XPZBdc6xwl18ogM1fqOIRjrWKYwZFdNwIqKS7H7b+Sm19NeTC3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yadb2DY0fufBAn9xcNz380NISVadgeCgKXblmyMCJyE=;
 b=Qxxq+taYL+NeXd7816984RYvfC9eH2U2NVeWtnCcMYx6RUTQpyi6KzZD1U/h+EaD3DM8NGpQEpmd20R+qRJ0kphhMI4/3upBGTLDPzC4DsaSZ42/Ujk0xF6j1A5AoZ2TEjPTPhbVP2PPHyFA+iJMl41uk3Bn6+z9kmkGoDbAUPZxxizMdScCb4Msm6lbh59Gi4UulU+8lY6yG2VBMi5joIJHlNovi538l/pm/VCjyR18HZ0Bog2CYO/wjGonxEwvQWdyI1VolqgXIDHif6E9BYyL4akhFgmCaCqCbgSHk/wku0Go1Qo2YyROeR9KjFVLbR9yIWhGDewNwLqA9h1RTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 16:44:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 16:44:55 +0000
Date:   Tue, 15 Nov 2022 12:44:54 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
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
Subject: Re: [PATCH v4 03/17] interval-tree: Add a utility to iterate over
 spans in an interval tree
Message-ID: <Y3PCBnGxPm2ZKrm+@nvidia.com>
References: <3-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <112905a9-ed6f-4aaa-2bfc-46502e558ab5@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112905a9-ed6f-4aaa-2bfc-46502e558ab5@redhat.com>
X-ClientProxiedBy: MN2PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:208:23d::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: b2bb139f-d0d1-4a35-15de-08dac728b996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CoStVEITRn5h3gV1Dk5+m7AhZoSBIK/s96Sbl0PSXtbnD66fcCYEZrcLh6b2HbJfyRRt8mHysH4JSLHm492Xm98tV5bKG8NpaqbySIVqQdh9QvEMuJ1pTRRdBib/oFAENzYjqmOJPegN6kXKWs0uoByoei05yiyKZ3i9vD3ppD+68FAh+l1k3So6NuiwDPm2SCLAb62muoxclfRCkLuS5VQz0ZnDpBZsWSSHBwtzb34IlO54QwrME5/Cd2w5o+h9KLS7ldPwG3iv0CdEiTHltbpIUGyiqjKfLuEuUrXiME8QQkFDYB0sO4i3yz/Qet1ZSfe+ht1AiPii01DBaAkjGGqEP4vGc/AmEFWf6SDErE9VFV3XN3SgljtAhq9bb5EfQlfVs3332Zk7MdKDKRVrhBipJ2I8qHNxjgQEZNTTXr5+oE0Ef3IpM/X62U48An089TqvcPH/EGOCCancbiF0Su/0NcfQUAUcdC+LIERbiH4vm1sL70DHNF7Extz2j8KrMim4RD8mH6VLXqXWHAPV+kXy2BPoiwxRtk/ur5mVMpu5CRWUgPDTUgpe2NYejmRxkT+2KqJxvTepiocG4o3t5TB5zibjUBa9FTrieSPKGwf/foPNxvOPCfe0CK1GXo/8ZJqVC7MgZn2/SkHJA10S42zPlXXRRRxndPNa8c/UXCiCHNDQPDT+gHl0qbMYX02ZnZAngdH4GPjXrGXaCxyBMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199015)(2906002)(7406005)(7416002)(66946007)(66476007)(66556008)(5660300002)(8936002)(8676002)(4326008)(41300700001)(6506007)(6486002)(83380400001)(2616005)(36756003)(6512007)(26005)(316002)(6916009)(186003)(54906003)(478600001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zxsIXjRvkDjAry3FO+8HNVEymt5B0g6sKzZ/c7To82FL3lG6N6AB12vVKJSw?=
 =?us-ascii?Q?Fw+1vc01Vm/5NllOYcIq5uWCH339x2/Y6P0NTg6vNdgjWkMytmdNE/c751KK?=
 =?us-ascii?Q?8hiz48822V64UHnLWZwpmperTigiFcSP28WaxD4DwipAiqaaR0GQpcLDvTRa?=
 =?us-ascii?Q?oeRi6ghYpio2hJ0Ps8yMGtrw5tp2dCPYPNFKFcEXJAdvkxhH/XNRwv0WEZJQ?=
 =?us-ascii?Q?aXXHWVvxlKmZGpL7NCswhpMI0rKWYV1pkFOJQ36lzvYdhSaP00u9EjXWgsEq?=
 =?us-ascii?Q?bq1rUZXSh3HdC8zUpZc3cSdNWma5zNmZS9E5d6n8bDMYoqXl/LVhGJnAd6iw?=
 =?us-ascii?Q?POPLSw7cWeYEZmsRtiGIGmZmylyj2OjeTzDKbJLiyOKNssQA4yL/Qo4KiW96?=
 =?us-ascii?Q?bKoaMMC7twlz8Eeg+cyGYzcYzUgNl+UJTjnEQ/E8tQYWgWh+fqpusrZFpxhd?=
 =?us-ascii?Q?zwylZGCqPcs5dl+5kwxydSnGzrSKQTp1lLQTLvYUzCuv8fzTC9XCwfTiicUr?=
 =?us-ascii?Q?f3eNnbM26L/nRt6YO/5sXP9tVz7TqKa05l9NKq2SJ/qGCE3+PH+Q5eHRB1zq?=
 =?us-ascii?Q?UiHTAiPjuQbceheB3UKnNnT+6KGfoCKE1HbJnvQbCuv7NYQnVGPOcccUxKa2?=
 =?us-ascii?Q?dugKmj+PhFuRpV4smRzm08bKADnAAFDQW2uXTo5aBL7a+3XzcbZuJRNFWFC1?=
 =?us-ascii?Q?POB+mR2MistKrDFAsQYCogw+tFIYqQnoPZ4pKPNF/ymoj5Hob2Z6IJYJ/pXq?=
 =?us-ascii?Q?vEMWio45laKDVLEawWqys3ZFVhDxWDexjAzaQ8K06mnq5vOwtKseW9/vlSWV?=
 =?us-ascii?Q?Qcs+DDJRhoTzM0z5DGkbc5IAGucYhKukVwGWOD7Twh/+GZ8bwgjEV/KHs9lV?=
 =?us-ascii?Q?jHj2wBprzObUlUkg0IKtqT5XIJLDlP4SWsBHmGO7cIC6ZWyfiz8We2wyyM8K?=
 =?us-ascii?Q?nGdRHnMKmTFF3/0TBqmvte+0baOnEdzTwhXiPc5cf6w61GEe7Kx+xTCoVerm?=
 =?us-ascii?Q?18A6r+5+JkMIM7hRY/23IPFEdK+HzRNNBQKJ+8P5c1qHn4qDTcWi+rnvSTnw?=
 =?us-ascii?Q?fxRUsEj/9sXzCbPkLCQvBIyAs+JBjs92ChUCUj2CytoYQj82RXieNZnsuxTW?=
 =?us-ascii?Q?t+NKg08P3MGP4F7DgLPaRe1IDWQKTnm/ixAo5ZT+4w48zKL3H8ztFWMKo3vS?=
 =?us-ascii?Q?adGhiL+aKLnp9/6Z1UoJ+ZibmLzT8CfcCUqOCvWEYH/ZBP7gP2KRXRAIxOsY?=
 =?us-ascii?Q?zTQGgAOO+JMeWdo7Jj89J9RFAYe5KVxGTC6R0IwD2g80NK3bEGJQrlaU3y1b?=
 =?us-ascii?Q?OK3SLNERcf0qbXgy5O7aL58J2qAJuMq5vgpH/uwQpjeF/9kyX59/TkntSpLw?=
 =?us-ascii?Q?NOWWQXAjHVklcqmrFH0ZlMGUWmBqwrxdGEXrAETHnkUPGfBoKXrqBQEbFtki?=
 =?us-ascii?Q?brqX505ylKuj6cBQv/fCIvJ3lCS/ZzVk0EL+HkS4RF2GUjaK06ZG9KBBYhr+?=
 =?us-ascii?Q?63e4l4Ikp0TSPEHB/DPwvehaveSztfKwGurdNGUKQBol2OvWodGonQfRcQP5?=
 =?us-ascii?Q?/TEh5F8dhWpwooHQjoQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bb139f-d0d1-4a35-15de-08dac728b996
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 16:44:55.5101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ar/hvdcZ0QE/UG5lhoj6uKr4WwdMnBBSe1iRPIIrp1H/uM9tEiDOsXQk5arf9Xxl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 15, 2022 at 03:14:00PM +0100, Eric Auger wrote:
> > diff --git a/lib/interval_tree.c b/lib/interval_tree.c
> > index 593ce56ece5050..d2882db8fa2a07 100644
> > --- a/lib/interval_tree.c
> > +++ b/lib/interval_tree.c
> > @@ -15,3 +15,135 @@ EXPORT_SYMBOL_GPL(interval_tree_insert);
> >  EXPORT_SYMBOL_GPL(interval_tree_remove);
> >  EXPORT_SYMBOL_GPL(interval_tree_iter_first);
> >  EXPORT_SYMBOL_GPL(interval_tree_iter_next);
> > +
> > +#ifdef CONFIG_INTERVAL_TREE_SPAN_ITER

> Maybe add in a kernel doc that a prerequisite is state.nodes[1] must be
> populated

Sure, lets just move the below comment up a bit:

/*
 * Roll nodes[1] into nodes[0] by advancing nodes[1] to the end of a contiguous
 * span of nodes. This makes nodes[0]->last the end of that contiguous used span
 * indexes that started at the original nodes[1]->start. nodes[1] is now the
 * first node starting the next used span. A hole span is between nodes[0]->last
 * and nodes[1]->start. nodes[1] must be !NULL.
 */

> > +/*
> > + * Advance the iterator index to a specific position. The returned used/hole is
> > + * updated to start at new_index. This is faster than calling
> > + * interval_tree_span_iter_first() as it can avoid full searches in several
> > + * cases where the iterator is already set.
> > + */
> > +void interval_tree_span_iter_advance(struct interval_tree_span_iter *iter,
> > +				     struct rb_root_cached *itree,
> > +				     unsigned long new_index)
> > +{
> > +	if (iter->is_hole == -1)
> > +		return;
> > +
> > +	iter->first_index = new_index;
> check new_index > iter->first_index?

It is odd but it actually works out OK if that is violated. I  guess a
WARN_ON would be appropriate but I've avoided adding assertions to
this code..

> > +	if (new_index > iter->last_index) {
> > +		iter->is_hole = -1;
> > +		return;
> > +	}
> > +
> > +	/* Rely on the union aliasing hole/used */
> > +	if (iter->start_hole <= new_index && new_index <= iter->last_hole) {
> > +		iter->start_hole = new_index;
> > +		return;
> > +	}
> > +	if (new_index == iter->last_hole + 1)
> > +		interval_tree_span_iter_next(iter);
> > +	else
> > +		interval_tree_span_iter_first(iter, itree, new_index,
> > +					      iter->last_index);

This call will reset iter->first_index to new_index and even if it is
outside the original bounds everything will work. Of course if the
caller does some 'backwards' advance then they are going to probably
be very sad and likely hit an infinite loop, but that applies to all
kinds of backwards advances, not just going before the original
bounds.

Thanks,
Jason
