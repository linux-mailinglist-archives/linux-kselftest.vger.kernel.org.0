Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07EB61A11F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 20:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKDTi2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 15:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKDTi1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 15:38:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1A1233;
        Fri,  4 Nov 2022 12:38:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9MOHJX0Eo4URfqTQcYd/NxK0F69punBcI0/ZOUWqgrAdYVvGCYLaq6IKJ+nkReedzn0vJTXpVRBnX3BVu1sHfRKhYR0+EjV/1W2cwfj/t2lm3IQOXP8VdtqBejPnr52EqheAa+T76oErtxCTuiBCN25uB8x7oS6DRAI3w/KaO3zGj5/wgdfo8z/YXIBqxT4KiXYMUccNo1g49esCcn7+DOHT/0tlteoc8wqgiDq5VsRxN7XyeCiWPywC6wWzm7QucjEeIcW4kXVpyejkFS8qgj3kWGtJrbq+g8KSsMWAgp+5U+7huJbWJgvf02F0m662gPjSIFZei39ESICbaH9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc6SBY9LB5znsGTBZSL5qn0+1MXVufxNsrh9BBBMhz8=;
 b=fVotcvU+EWQzQ8fTuElSDxfnb9489in9DP+nbuQkmAfjK/xcdQ1onkyF3eJG3wEXPaau33ufPZ+IF/6i8hKV2un7Sas5OrpJPEauUhJmOmK0eyAzcTPV3OWxWeB8ChNxtFusaAH5EvE1ElLxdM5GLFc9avqWrDDrO+/JNlaTVFtjOjr7cBrtPNBscJO/qnBY9L1kBts0AKqjh13jEDhNBmZXhAfAv6xC2gu/ukCOg14E+KEmEoovKuHnh5+S2TuKxwuaUuKDEst5gx7w0iGUQyzbEQbM2SWIRC8Ow2NyMgXMenx+nDaWAaXKGugfOXImoJi1wakZjSSC3NXWzL/2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc6SBY9LB5znsGTBZSL5qn0+1MXVufxNsrh9BBBMhz8=;
 b=jwLo4uKww1tjjUQCggst8ZyN+b91772gQNMkKBKJT1HdUE5UYKfmeT7JEsx01FCfjmykXlj0klmTHvOcPgSB5c5NxjRgZvTQiQ5VljVnBFujYmTeND/da6l0+r8ys6o2CDENhKFlnWyuMehjqWvYisW1stlZ3Vhl+JP5/I/I6NVR92Dr3HVEUqpTcxDxCM1Fp1PimdaLLpjQRWrkSBIVWdiMUw/Zistq4jbxtGY6pwGMx9QEuAfyeE3e2PZjCb+lNwBSJf2RNpfSktZr14TkVj1hlu3FsPET/X4DxHa373iJESJ9jf49evNMPjwxUJxj2U5cPmkEZREMW4xSOxjUGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 19:38:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 4 Nov 2022
 19:38:21 +0000
Date:   Fri, 4 Nov 2022 16:38:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
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
Subject: Re: [PATCH v3 03/15] interval-tree: Add a utility to iterate over
 spans in an interval tree
Message-ID: <Y2VqK3m9i6FlQd9+@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <3-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB527666424E77F8417DF1BF4C8C389@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527666424E77F8417DF1BF4C8C389@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:208:256::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bac7c37-378a-4a5a-3e0a-08dabe9c20fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJ4hZqmMFMqFQ1jpBXWXD8nImIcpM+PWJYzciaiLhyNmYnaTxcCZ8U2ANuKGomhwGjrhXOkN+gOvnKfz7cuY9Pusq3EU3OQ3eyEzosTeZ1BxAIvXhuul+Pbq3c2FwAgilckdTXDXJGFb9YqRRQEKxB+bNg20SE17C35TdE2J1TjJVcZkaRA39FdCxtdgpMj/GCr092ksP2/sqdJR5gNmTbC9NhDAgAeqKHJfOmFk+mCzAYycjzpIVuYFVea3/rkxi4rzsr/+YFo1QxKCE2Om0GC4lTmsBd/gUp4VQPQRF9gEVHyFB7PdQUi+QLIb7o/awxYz9TT73KXuO36JcGr5VkRDmrzOnLFozTEuzyYobrQHn+tGNQHiXrLglySAmJo0ISbLpaxT9wd03857SQGwSLyXf6sufBa7ARROFhkxZMNSk97W+vlTqObhfmHmZgI0GVWI+alvYzhl5QMYnumWBzPRQiRwKMGdr3GWrnGFMf7DeJ5g4ciLkk8oaM1CVWh+4suwAaxJa+5f1NycmzqlQQQgkvW6A9SQ598LGwB8jSwlqqBOhCh7aroLlrLPlXRF8C8h6VPWHhhUg3QvxtlCILpicXil+vsB+kFdD5TyWS7pll+muFKM9gtYFM6Kidgkci8OefUx3X+qkop5jFE91Y8BCamqV+/xVUN+DGbYs/rHk5EgOFM3r2+ZTpBuc/JVGpAdml/jy9De+wxcguaADxWTTOKsU8Fx0LCQnuGecQwskttNOS+QhxJlrQoANJUk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(38100700002)(36756003)(2616005)(5660300002)(7416002)(2906002)(7406005)(86362001)(83380400001)(6512007)(316002)(6916009)(478600001)(186003)(26005)(54906003)(6486002)(66476007)(41300700001)(66556008)(6506007)(8676002)(8936002)(4326008)(66946007)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tASGuNGcW43x7UoAjPS2tGtRH6e9RQzyzAGQwhT+4A2BrzagCRaS2w/LCrZq?=
 =?us-ascii?Q?fqstNS137CFTHuKSktKod+G810oBvcgyW3KUhGAUvNFO95X7kdEuuYMGJJsx?=
 =?us-ascii?Q?Jvs/+gKRLvo0OvqDY26AkncIgi0nNrDvcmCQCkpcZxO7jZkBHvbU/u+v+o9R?=
 =?us-ascii?Q?kt1wXYWqv1ju2U2kLxUumFg1y8njt3Hd/NmoVqg5FOWgQO4lMC6e5aeDsvM+?=
 =?us-ascii?Q?0qtLpdsl8pUYKfVZJCAhyyMCHMq4ZVgB6o5qIYkjApr6vadCfegQrddOjnR2?=
 =?us-ascii?Q?5lICfLj6mVK88xatJexzt9wG267PU/W34PY/Jh4MmQWpZs94eiPmqQLLfCsP?=
 =?us-ascii?Q?hi4aH2g1ANhAdJk/nb4zpHmLD2Yfjy4jxtC64Z1LjjfOTgv30mmkeTI/vWLd?=
 =?us-ascii?Q?+GjvaAEmKyimD6wgSdXddeGM+xeUdWR/AEYvLsZbEAtuzKNIz+Ef3YjQyZBO?=
 =?us-ascii?Q?b9CGcNXzua1RiuYJnsXdQc9WMYKIAHfg+UeMBbB52LAqn2BtHgKSpRPXlttX?=
 =?us-ascii?Q?nAAVT7VUMAwLRB5kiqifaTHdI5AH7YclKn/cbGpClbIm3dEbzQO29sm8rnNQ?=
 =?us-ascii?Q?Hv9+VlaqXfnWzjgDv8HjRQPG4pwBWhMeywRpCins44z8NoS27hkUsjEUS47q?=
 =?us-ascii?Q?+zMnr62W5QoiGW0lomWc9c0aTOjfTZoRxDmxu0ew7baPDvCnHN40GBJ+uOA9?=
 =?us-ascii?Q?uden9QSsrm+lVeML3RdgbS1M7gtVCNM21xi6kUPHQe5qXYG3itByuEAXYAPB?=
 =?us-ascii?Q?4FcKQBfQe3tIJ/n2ta8tsGoYj7Z3+LStJxCygf1sxkaP2TYg7eYjHM9CcVpE?=
 =?us-ascii?Q?efJHdMHfrCHr0Qq71RYWzSlj7GgFFBozXP2lDFb1ZavAUfVCLslM4zX2Amco?=
 =?us-ascii?Q?mJtf3PK0juqFLx1jL29gNgZq8Hsy/ls29BErAxSCbsxjuZ14wiIUPUrSRZu/?=
 =?us-ascii?Q?sFCcoPiSht9YpQ1zY0BPYz+FkqTWJ7HP/1G0ZQC4N0y/RahfdtiKiQupsseY?=
 =?us-ascii?Q?FVq29RDbs7m03sz8LBos8x902e1fiGsb15Bry/g7CDzk2Fqq9ZpjcvbcfAyC?=
 =?us-ascii?Q?SvsTGoe/7uNqo8TesEZb5FczEXLespoKkRei79ukth7JS18WPNmKurhVnU9E?=
 =?us-ascii?Q?OG7Wpl3l1Uz6b41OlIJUiuaIOMKgEfCxQ2K9ff6txaSkzJkU2LovLq0gIhkJ?=
 =?us-ascii?Q?sReTSgn3m1S9l8ASmWBRWHOIjPrXkUcSr7y6ov7WHcOpTQ92mDywc+5K7KWx?=
 =?us-ascii?Q?fxASmrpjLPuuEhHMU0/muf46Grv2Cad4r2MVt8eyUXQwXyC8t7qtGgsEp6v6?=
 =?us-ascii?Q?HudcbOlKRuQNlSgILXKaR1oDTGFOyUupIhgYQ/7quRdIY3xwhURNKVoUwqAZ?=
 =?us-ascii?Q?pIXYdgqd9BYiIR7cw7mp2wB6vjmI45YeKDmWp/Jl0Z+fYI09Z8o56gayMdba?=
 =?us-ascii?Q?sTNXQJIyMfVA4qcnUtRu/5O38J2f0Ku+22lP7QvyLdy7wkmpgATgjDRsRtm1?=
 =?us-ascii?Q?nxafKHV3MQmst7cADIWiIUEcu/p+0u6gGwmt544sMsMCbHYDuSIJsjLmw5Dy?=
 =?us-ascii?Q?3xbnj3Tiz2r3YUsAh2g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bac7c37-378a-4a5a-3e0a-08dabe9c20fb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 19:38:20.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyfX/IpUwy/mkuALM8c3MHWZyyHV2cN9FwtFKlAC3GUVYMD0IkmXLlq92cBwspye
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 03, 2022 at 05:31:17AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, October 26, 2022 2:12 AM
> > +/*
> > + * This iterator travels over spans in an interval tree. It does not return
> > + * nodes but classifies each span as either a hole, where no nodes intersect,
> > or
> > + * a used, which is fully covered by nodes. Each iteration step toggles
> > between
> > + * hole and used until the entire range is covered. The returned spans
> > always
> > + * fully cover the requested range.
> > + *
> > + * The iterator is greedy, it always returns the largest hole or used possible,
> > + * consolidating all consecutive nodes.
> > + *
> > + * Only is_hole, start_hole/used and last_hole/used are part of the external
> > + * interface.
> 
> slightly better readability if moving this sentence into the structure as
> the break line

Do you mean like this?

@@ -37,13 +37,16 @@ interval_tree_iter_next(struct interval_tree_node *node,
  * The iterator is greedy, it always returns the largest hole or used possible,
  * consolidating all consecutive nodes.
- *
- * Only is_hole, start_hole/used and last_hole/used are part of the external
- * interface.
  */
 struct interval_tree_span_iter {
 	struct interval_tree_node *nodes[2];
 	unsigned long first_index;
 	unsigned long last_index;
+
+	/*
+	 * Only is_hole, start_hole/used and last_hole/used are part of the
+	 * external interface.
+	 */
 	union {
 		unsigned long start_hole;
 		unsigned long start_used;

> > +void interval_tree_span_iter_advance(struct interval_tree_span_iter *iter,
> > +				     struct rb_root_cached *itree,
> > +				     unsigned long new_index)
> > +{
> > +	if (iter->is_hole == -1)
> > +		return;
> > +
> > +	iter->first_index = new_index;
> > +	if (new_index == iter->last_index) {
> > +		iter->is_hole = -1;
> > +		return;
> > +	}
> > +
> > +	/* Rely on the union aliasing hole/used */
> > +	if (iter->start_hole <= new_index && new_index <= iter->last_hole) {
> 
> "<=" to "<"
> 
> > +		iter->start_hole = new_index;
> > +		return;
> > +	}

Hrm, I don't think so..  This is testing if new_index is valid for the
current span. new_index == start_XXX is a valid index of the span and
new_index == last_XX is also a valid index, so either of them should
just update start_XX and do nothing else.

Thanks,
Jason
