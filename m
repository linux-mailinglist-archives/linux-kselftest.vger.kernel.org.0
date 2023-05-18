Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261C97080A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjERMDK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 08:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjERMDD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 08:03:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2D8186;
        Thu, 18 May 2023 05:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfDtj4EbkT1uf0QQhY312n+C8sUQ++m08o9l7woHN8xpv9siRGBbDm9U/WkpeoJkyft73+VRcrt4zxyEWiUDY9TZtxnA0K8E1/NSBIaCvpxjHQKYvfea2JFnR7AyTpSaAkle0xvcGldikb8WKUoZYKff5d14xXclAnx4fkvTk/pNt06ewI2yWNQVXxMdTyRuYo24g841h2mXrLWn0crxycv/tHOvav9B2UO0A6ewlPkLsZMKdjTKNOsiLR9VpxjEcgi2n3wvLHtDF03VEAPrLTuerUri+fcGPgvoaeZioHXlSRIFj+OL5x437ll2AsepBNogE6wW/iELzOY15s4LAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRJRmQqHebkpdjJsLaebUNMc7sk2ix5m0Y9ZD4Qpbs4=;
 b=ZuBdqzs8bHA03gkVq1i7YziuzSsNUuruNVt8ctnliXpxGzr+WV9C3Kyx9n5rdmRvM6k6uC2NlvBtRiCQGFmRjRxLDqoGQIQW6TgoNoTAYj+mCLC4sgjtqcmylsCwpwwIvuUhXFkntPl8+3t2YETqF8x0FznH0B8utuFyXFLhDfMpGcVnLXVHnRMtxsFnSMkcKkgh+eM+HAqcE6FEA9Dr8GAu61F0NjnmjQG3Vidzs3gIJD8AGE16fITtNmN6MlwCrf3cIr/IxcPdus+dZydEdkvisW2dkA3w14LSSkuq+m81lrrfcXi+33ngcNzMn4mgPF4rUB0pATcb/eonwKbVBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRJRmQqHebkpdjJsLaebUNMc7sk2ix5m0Y9ZD4Qpbs4=;
 b=PFPY128OjsRXsVK3XzmquuR3mGt8PmZw3a9gSQZZtUKbDT+294CsoSjO5n+RJp3yRhReBFZdF1QH2e6Y8hvhb5/g+O1XPgejLPpzjOXc7PYU2l1QpG/z56VSbCujWdQuvhLCEo7wZGIBpvrDQ2o3tqfbVRlnlKcJPM3zuANe637+nutGbmsNswdueE8weKQlZ10g+zMBIsb58WH55UajknoQUcRQTEVfgD8f1n1Ijg4K6XqL7BzutsxDjKRKmw2QOBtx8w3tmK97ONxDBHdgEIiSoBuCRkHEssKqTRvTa23tfKr7WBgG2q+auAnlObeZdyPDH9/g2nD67g+Lyx2vnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 12:02:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 12:02:59 +0000
Date:   Thu, 18 May 2023 09:02:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 03/19] iommufd: Replace the hwpt->devices list with
 iommufd_group
Message-ID: <ZGYT8RmGM+vwNzDa@nvidia.com>
References: <3-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
 <569b959e-a702-fc19-3d67-0dde4e77251a@linux.intel.com>
 <ZGN2yvhpIvrvu74r@nvidia.com>
 <852e85b3-9fd2-bfc2-6080-82cea7ab6abd@linux.intel.com>
 <BN9PR11MB5276DE1BC30E90B1032C0E468C7E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGTMCSJKvgpyYxG/@nvidia.com>
 <5cdc1a83-f29b-6862-d513-dbfd5c500807@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cdc1a83-f29b-6862-d513-dbfd5c500807@linux.intel.com>
X-ClientProxiedBy: BL0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:2d::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: ad48cc16-f667-4edd-96db-08db5797d2b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+to8jTkHI24+4Hq39iCZIGotd8FuEhtYuYzZJvsA3w3dgX7mGNH98fG61rhCSVE6Xr5AXydBib0g7zTYsrYApW2ZSoAcYa4KWUMo/Rn1NXrAhU7IEivsLGURsGmOVL18LZrITv1qiNiphRWyo6GD3YcQYy5/IFq4m91N1piWv0Z/2O4psMHMz9g8gqJYFc3s13z36+DLgNbyygAL7mXVU+HY3grf4kW5f+6E7+0q4nbadiKNoU2YJ9ZKFyDDfsN/XETAla1QrUzs6yeDyn+PX5hNKxlV5fNUwlE1f6CX/KDsM0TfYLpeY18ghkWYyDYI37+HkzOceoZWf1xaVqxjVJncrVN+ICvlL7c1DmSFlY9fu2BNwF96dO6oOrnvt82cJYov5qAnXNgIzqWsRwIIY2G1+suK7Tv6vJfGTqDVE8LkUU918NPJkEf4/72+ZoXPh29Xy6ZQHZYzhZIEHgZ/tc/iOPjVT2GBKiz3w0C3yP+DecvlmlI/uQKU1wL+JW+wL3iRJMNAUO2jwdLLML1vmsW1anleFV4zQ/qgG1Zr/APxKyramddtEbGohDXWrPzzBmnUJCjIsuLE0j8P1AwNl9aVHydPmt2SuQ6zVSqAJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(316002)(2906002)(478600001)(41300700001)(8936002)(6916009)(4326008)(8676002)(6486002)(54906003)(66476007)(66556008)(66946007)(5660300002)(6506007)(6512007)(26005)(38100700002)(186003)(83380400001)(36756003)(86362001)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pg1CWhwjE7zC4SuNz37a6qvHqA1Sx54ekDeEq/OJ100MQjsS02krmVUxaGPz?=
 =?us-ascii?Q?eVI007bVNEzYF1gSK9Ik9JUXQg36VXUcejr3L3xnBvcOj6WvTdZipLhuiqoY?=
 =?us-ascii?Q?OsUh3UI9osvFL4gDkrePvvP+EDwJAmrsDqdKUXM9fTfAD8Qh219xtZ9fJ5L8?=
 =?us-ascii?Q?rIjiURpsahVOHRt52rjcKKUy9VzC1ncwLjkU0hW5ZNntJjxXkUj9ANgwBWhG?=
 =?us-ascii?Q?U/NoeSvSx/HWQUIBZ0v/tvqDwAdbjKMqjNQQvjGqF6Q2gi5SvU0/QtMtuOkt?=
 =?us-ascii?Q?tKVHTwXNEcHSDuQcKQ6MlZ86Vjk++5Bepv2m4y+uhVhOlDTjg8WbQg+7Yqoi?=
 =?us-ascii?Q?i/K3zKITWJGv636i+6yv4LC36U16fjkLNAIBmtdMhM7/YePDd1sanqzOj6iy?=
 =?us-ascii?Q?JiVeVFpiE1GUTUvC8VcOLHzO+Y1fQE08WK341bpIDvdEuTn20i4pHvh8O/rY?=
 =?us-ascii?Q?Or86+l3CH7t+SrWwM7lNnO7OGcDs2yllkps7kzzsqrVggimBIn/yXs/mz8LR?=
 =?us-ascii?Q?4GtzOC8EoO6Tvy4xtSWigXIkcIsO0iGUpbbWZJw+/LvQpcNxZtXSwAUYVUFA?=
 =?us-ascii?Q?3J2vkJjnEufDgwNwp+23zmy7bSO5LGieZESwuKuym1/H2vMlL/12ROPe2xuA?=
 =?us-ascii?Q?Z1fP+U0sChsaf8OPWY0QmGOT1rwsh3gGj3adGIqGZ4Wcu5OzyaM23B6YWLwB?=
 =?us-ascii?Q?mD3/Z5B2RPlRAiu6mE8Yp7h+YgSn61CANFunwtwnnmjKSgSH10Tr8BVeKL+z?=
 =?us-ascii?Q?wDz+mOCKyFq4610DHjdMaaxqNIMXLVJfKtpqlpXWQ8r28OFmc5upTQHX2n1u?=
 =?us-ascii?Q?LWNfyH1dQsg+2e8c/qou7IMgGOjW9b3Lqy5dI+UbKk01nG687GLn0IdadLtT?=
 =?us-ascii?Q?4PdC5p6x8rzEd2JZ5ifIlhtNy3f24wyMrs29r4ryHIUtACHB2ZDzeTq8ysm0?=
 =?us-ascii?Q?KMnzjT0d15UuOAT7OIFDIqz7RWxVfwtn/l1+PJiC3cQdwzZ5pLqMF7mG6KJN?=
 =?us-ascii?Q?k955JxUx4ijryjlmvTwmNCS+BSNeIUTsG6wOfrr7D1lyHEv3wNZa6nwuFpr0?=
 =?us-ascii?Q?MZ+UptPLa0lnxGTWmQVvm6l2OFBC4YnIE1Ds9QzKHSuYGDY6GSX7Rd2S9gCA?=
 =?us-ascii?Q?vxmcQkYOqSeZSmGC1dh/9EY7ezTNb5wuQlCegTgMAic2AdHCj6vS++vsxXSo?=
 =?us-ascii?Q?LYhecLcQuIzzjmt8CCXQWRHfqitP5xBPtPdMSsXE9DPphcpJz2R+oypIAdwg?=
 =?us-ascii?Q?J3K6J1U7f/RSUBdipz16UKxC+QoOcLFKHSb0xHv+MPdq4D1JFNo8rO3Wtyyr?=
 =?us-ascii?Q?jJvBX56uOv5ajpjz2tl4GjcNRzFNC3ayuLFC+5JPARORLJUE7VHJam6e5xyW?=
 =?us-ascii?Q?K7zVme728etWbtuoJQqE2BZbknf/MTcnwu2Bxlt6ZsLOANWlJE8ClXYBYFcg?=
 =?us-ascii?Q?0BQshRA2KZcqv90z3rASWv/aUv9mzsDAk+Uhh6b17EaHSwP3UMVC1wBsMXJH?=
 =?us-ascii?Q?WxqLaIWgd0I5Rf/iNMvqAkz5tDEnB8P+g4wta2zPTz6SHhck1QGUrQD8pLN4?=
 =?us-ascii?Q?53Vx7/xr0Z0MnwktC/VvdWFb1agqEMgmEK+du3Xh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad48cc16-f667-4edd-96db-08db5797d2b2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 12:02:59.1626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgyfJt/gblL5J9rIgnAIs+mPGcUsw+lgNolWv9f7fyhaoXgH/dJ3voYSrQAJ20wE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 18, 2023 at 03:05:23PM +0800, Baolu Lu wrote:

> > It doesn't make any sense to store a struct like that in dev_iommu.
> > 
> > The fault handler should come from the domain and we should be able to
> > have a unique 'void *data' cookie linked to the (dev,PASID) to go
> > along with the fault handler.
> 
> If I get your point correctly, the iommu core should provide some places
> for the iommufd to put a cookie for each pair of {device, pasid}, and
> provide interfaces to manage it. For example,

I'd say when you attach a PRI capable domain (eg to a PASID) then provide
a 'void * data' during the attach.

> If so, perhaps we need some special treatment for ARM as a user hwpt
> actually presents the PASID table of the device and the guest setting
> pasid table entry will not be propagated to host. Then, the @pasid in
> above interfaces is meaningless.

As above, when attaching to a RID you'd still pass in the *data

> 1) Move iommu faults uapi from uapi/linux/iommu.h to uapi/linux
>   /iommufd.h and remove the former.

Please no, delete all the dead code from here and move whatever is
still in use into include/linux/

Then we can talk about what parts of it become uAPI and how best to
manage that on a patch by patch basis.

> 2) Add a device id in the iommu_fault structure.
>  struct iommu_fault {
>         __u32   type;
> -       __u32   padding;
> +       __u32   dev_id;

Why? This is iommufd internal, the void * above should cover it.

> 3) Add the device pointer to the parameters of domain fault handler.

That makes some sense
 
> 4) Decouple I/O page fault handling from IOMMU_SVA in the iommu core and
>    the drivers.

Definately, this SVA stuff need to be scrubbed out.

SVA is only a special domain type that takes the page table top from a
mmu_stuct and a shared fault handler in the core code to do handle_mm_fault()

It should not be in drivers any more deeply than that. We still have a
ways to go.

Jason
