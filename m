Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF186D2E94
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Apr 2023 08:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjDAG2w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Apr 2023 02:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDAG2v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Apr 2023 02:28:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04A31A474
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 23:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680330530; x=1711866530;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SjXQ5GoqbWi/3oA9jFhIeItOwQKjZwt2ufS5/AXfep8=;
  b=npwIJi/tUAuepZVjS9zv0rkpbhD1rVrfah4OzyLcy7ZtVXUsOYBoi33P
   F7NOr52o9/r9kYELFMXo0i21eIA4eC41yKpf+jGtsqYGXun0ojuqwToNt
   jUzezTXDbQTvJyZqhWrSPfBLq5SsKx8knN90KdecBj0pNQfRy8zApnqsU
   PxC9+WGvtgiQegUBLwmr4tQYzJSmKaR6tMSozKHWHLAFW2FJftsb8njBX
   MR3+HgJWTBhiKrAk9TWpjdaqF4s1vo9qNwD2fJOMWlfcmWf7zzMSyu1Im
   Pw/ZmtKzIceBtybO0ry2pqEOgA/Hu6L2Rx8kSOvDvU1bHvwixh13R5o+l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="340349105"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="340349105"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 23:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="635538014"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="635538014"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 31 Mar 2023 23:28:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 23:28:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 23:28:07 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 23:28:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2Hh6eTGmHei+J6jkvPhhIUTxvIduNjHdN5uM/xj+0lpnjZbqBH3CQVvYCwOoxXwH4+e8IaRa0ocI09utRNKtnn2FK1TTgFcLw/sKh3qtRXXJgY02Z2VFxSv/9go7TkdiBESDrBfGXz0nOqFVJmn3GTPUUoHSAzFGJiXS/6X4WqH7WoS/eULpAs8jCvp5LeyVkRgxIlS9HTdC334coNXOX7DOgOZmeX8FyMSJYfMb7t1pA2JyBf8OgKznHVwfv0snuadosAiG/Y8OcTo5Z/11yw7zxDpA90zZX0uMX71b/QqY14Hnu8qS1bekGnuiUSJi1GPeyX8DmTOwrOFXcVM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6TYwifdMSceodi9jNyYUgF6bdj2926QndJnNWSEzuk=;
 b=ijWpvcLxMYLONEZK345A3s14UGxTIxm6kQ/7uddMNP+/2hSvn23v9a0MLqxrjs4yNdN8khFzI1rlZ4KHdv7RoSFUVk2TmTjxUkm10hH+J+CehYOa0cssiO9JiEJD797bJCd3vO9vpLOTVI6LujXXTQTmqOVkqKoJDxkkCzsu/25MpZs5OIJM9s9RPnOCxQ1+lr9Ea3JPXtNpYmZ7BawxPYbh1k6rlqvS5Do8eKrh4sxCyL8oN0DkINJPhY2q/bPJZdRj65sRmK+TiGUrHhbDfqV0uK9p01Nddt/HDsh7eTKu85HMn97Q8j7/kqIRHzSbF+FX8DLNl9VO3XfM0jc0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Sat, 1 Apr
 2023 06:28:00 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%6]) with mapi id 15.20.6254.022; Sat, 1 Apr 2023
 06:28:00 +0000
Date:   Sat, 1 Apr 2023 14:29:33 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <iommu@lists.linux.dev>, Kevin Tian <kevin.tian@intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        <pengfei.xu@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>, <heng.su@intel.com>,
        <lkp@intel.com>
Subject: Re: [PATCH 3/4] iommufd: Do not corrupt the pfn list when doing
 batch carry
Message-ID: <ZCfPTfmYA7SvNd+a@xpf.sh.intel.com>
References: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
 <3-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SA2PR11MB4828:EE_
X-MS-Office365-Filtering-Correlation-Id: 73496a41-10cc-4429-5344-08db327a3d6e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBvPc8LvSrxdfvFQxEHqBNS+NeJVQ6Pt8QlccxiM67Xo7Fj2kowAdr08CzadPI/dnd0r3vOC9JW1tBVC3IOdB63nOWZjVkw4XKQ6/HxcJzcV+ijiHms03RJ5KrrssCQ2c1xUJIDX/htZRboXYUaXEA2bHXF6wl1dDxVy6dnklTlKg05/cOrKuD9NcNcKXfFIvpaN1HLMGotWvttO7tZSmfP9EEYjmw4+aXem0Bn5sHCvNExBhW6CoGd24E0XRWBBm/Ix4jBoZrZsM3U5LIdQWEGgT+x4ZDnOlIr7on1/DxLoYAPsjDmXE3pJaRRe5MPQ/Ht9qXedA9k2VSB6Iz9NujDlLlTVHusnaeEa6GNk3Klw6KtaaA1Mle9RxkqXo6oJBnBKxlr8hj5P2DsXZ/sT3pQ47SgYYxvFlkTM8ISxYjUbV7itDTFRDeOD21obtuvHreVkD2jzzEuQkUkNNKLrVBvWoAikg1waeNVBdfs/77b8qx8ql05yCK5KkcFOq3iRyjB0JDK8z9YpcidBJQZ0l4/MzDOHjI1L5oHzJ/ppHlFoNuYM5R/FP0TmNKq9X9K3qFmZVF4vqSf1SoZkMrIY1f0uqL1H/jG6RaKTzgaB3t669HskxGURF/1Nh1kHZRAEbEB9OEiOvuQDEIae1uWvSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199021)(6916009)(38100700002)(8936002)(5660300002)(44832011)(41300700001)(86362001)(4326008)(66946007)(66476007)(66556008)(8676002)(82960400001)(53546011)(6486002)(478600001)(966005)(83380400001)(54906003)(6666004)(2906002)(6506007)(26005)(6512007)(107886003)(186003)(316002)(45080400002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tQEM+Ag0rV39Y/zhkmVJjBh30EXXUwSImIpR+EQMpWlRmbeXrydTZPs+Zizb?=
 =?us-ascii?Q?fh4KjddN5SE/HtqWx3OAkm11ANNpHJv5rIC9U/nzbiNXGpWW76LQZY6WVO0J?=
 =?us-ascii?Q?bNt9cODShVdWzBPUOTAaiIrGkADZ6NSaAHfvHm3zarpUXsR/mTjBlj52xK2K?=
 =?us-ascii?Q?W/LtxvmOuIH+/qIBbpkJv4hw1bhQwYiVAoUlY41wSlxneiJsDTkn4MuBUJDX?=
 =?us-ascii?Q?YQyIM1rHC8K1j7nKjsPXF6qRhvCW5Qfjs5WCHRo3Q5fPbvCiWtP3f28QEjiG?=
 =?us-ascii?Q?z35LfOPq7qKR4nMQqLX6CMrNnuYG5i/k7cTxrfuV3Mr+CxEe9DfNLkfouHfG?=
 =?us-ascii?Q?xWHRPSKUvxZ4mDu67hfZk4mqtkftuUjK5l56oKwRH6Bz6KrAgbSjeUJDDfz6?=
 =?us-ascii?Q?Gmzv3GgA/v+NR3ajwpxyf/gGH9Ta8hXef0mVoYS5FsLt+l36p4YxoOEpCRu1?=
 =?us-ascii?Q?bpksCmevhSdDaMS3VOl5EMCBLGf/6vWH0Mfl0ITgoPq9J5u1h/aVe0SfryQu?=
 =?us-ascii?Q?ezXZala3gULSMki4q/BgpL2BqE5r8N7elep+I3i5YvY7Y1b5ChKxdbhPcXbt?=
 =?us-ascii?Q?4ELVIfAOMHHn3CHGeeHw/9pqm9tsqxApm9LQcJSsmEeWxC3HP9pcrJ63Abdj?=
 =?us-ascii?Q?bBbVCMfho6mA/DtS2k8wJrXks5rweCZx3j7NYZ/HLQo5FFDYYuCSEHI1owdy?=
 =?us-ascii?Q?ePb1aWHy0hKphwGjdV16vodOyY236SilxsLdO7ZL2eKP8JY2fFK6Wb+kh+Z0?=
 =?us-ascii?Q?Ep20VlYXuny5a8nd4BuG/xf3qpJot/HM9Ot4PtvZmUfTdGS4Gi3fzDYm9BaL?=
 =?us-ascii?Q?iZV3vT0zshdLGGpkBkK6bIokhtA42ragwEU63jMT2kDXkXaAw3UnuM0sIgE2?=
 =?us-ascii?Q?b78Gg8akGjX0C66AbcLyZo80yEg/F2SwdBJx2UjqqbEngBlQjJXhOCp0Fx5f?=
 =?us-ascii?Q?ChcnBao3uBcaYcrkdksxkQHkeg1j/IKIfsmi2MP3GJdx7l1rmEer9RoWgKY9?=
 =?us-ascii?Q?pW2TzC0hUX6Gts+DoRaHIwJsNj6rQoOvZCB1lrGACsjNaYyiq/UmRQcA/5ex?=
 =?us-ascii?Q?7HWD8S61RtRbybmKMoVjAg7CikwSCSQW8DkOOpeP/7Qb85L7n5SnNjKYMLfk?=
 =?us-ascii?Q?2ARUjXksHF3C8z+iEbxqZRZbsHsMh8PilgAeISYjfaCpsz5/kV8C0vkwU5xC?=
 =?us-ascii?Q?CLw5PmINW34RasmZgQuJXhnXiSlWvL4U5aT0tg32/DyEYT6HlVsYlffHm9ws?=
 =?us-ascii?Q?EFnJ/RocUG55cFC7B5fplR2S24D+03Gz4tLOw21F7Vt7GCNw0uRMF8PpecwX?=
 =?us-ascii?Q?rmlRxft75eutQzjnnMW//cpCzb65sUdICBZRTLlOdcUtE33GS8hYbOiamBhl?=
 =?us-ascii?Q?jZ2I5MVmzQ1716F3Xe/od4J3x9K/+Zsz1MbKt67ZboBdiretU9nuBo/7mm8A?=
 =?us-ascii?Q?8DHMi0P318pJGVX6wL3R1q9XavBDq6bAlXueFe/bQjTUTE3MOPBY3reTNObx?=
 =?us-ascii?Q?GWoQe45KjZfqpXeXbCkmleDIhGCZLdkYa0LfDfCUPDE73/WcoMoPPTGUxZSJ?=
 =?us-ascii?Q?sqfzXiAqGveC7TwyPxvzVu1UamlErR42XoSIVYqu+244vQPvFWQd/oZn4aTz?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73496a41-10cc-4429-5344-08db327a3d6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2023 06:28:00.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UecJWvqpYazdkHsHJFPkSaHNRqKzt2yM1A3YBKO5IXVm1gP/vxQQJrS4s2/zat73nO7ofKO1biDkJi0gxMZ7cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jason,

On 2023-03-31 at 12:32:26 -0300, Jason Gunthorpe wrote:
> If batch->end is 0 then setting npfns[0] before computing the new value of
> pfns will fail to adjust the pfn and result in various page accounting
> corruptions. It should be ordered after.
> 
> This seems to result in various kinds of page meta-data corruption related
> failures:
> 
>   WARNING: CPU: 1 PID: 527 at mm/gup.c:75 try_grab_folio+0x503/0x740
>   Modules linked in:
>   CPU: 1 PID: 527 Comm: repro Not tainted 6.3.0-rc2-eeac8ede1755+ #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:try_grab_folio+0x503/0x740
>   Code: e3 01 48 89 de e8 6d c1 dd ff 48 85 db 0f 84 7c fe ff ff e8 4f bf dd ff 49 8d 47 ff 48 89 45 d0 e9 73 fe ff ff e8 3d bf dd ff <0f> 0b 31 db e9 d0 fc ff ff e8 2f bf dd ff 48 8b 5d c8 31 ff 48 89
>   RSP: 0018:ffffc90000f37908 EFLAGS: 00010046
>   RAX: 0000000000000000 RBX: 00000000fffffc02 RCX: ffffffff81504c26
>   RDX: 0000000000000000 RSI: ffff88800d030000 RDI: 0000000000000002
>   RBP: ffffc90000f37948 R08: 000000000003ca24 R09: 0000000000000008
>   R10: 000000000003ca00 R11: 0000000000000023 R12: ffffea000035d540
>   R13: 0000000000000001 R14: 0000000000000000 R15: ffffea000035d540
>   FS:  00007fecbf659740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00000000200011c3 CR3: 000000000ef66006 CR4: 0000000000770ee0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    internal_get_user_pages_fast+0xd32/0x2200
>    pin_user_pages_fast+0x65/0x90
>    pfn_reader_user_pin+0x376/0x390
>    pfn_reader_next+0x14a/0x7b0
>    pfn_reader_first+0x140/0x1b0
>    iopt_area_fill_domain+0x74/0x210
>    iopt_table_add_domain+0x30e/0x6e0
>    iommufd_device_selftest_attach+0x7f/0x140
>    iommufd_test+0x10ff/0x16f0
>    iommufd_fops_ioctl+0x206/0x330
>    __x64_sys_ioctl+0x10e/0x160
>    do_syscall_64+0x3b/0x90
>    entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> Cc: <stable@vger.kernel.org>
> Fixes: f394576eb11d ("iommufd: PFN handling for iopt_pages")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Link: https://lore.kernel.org/r/ZBExkEW/On0ue68q@xpf.sh.intel.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/pages.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index b11aace836542d..3c47846cc5efe8 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -294,9 +294,9 @@ static void batch_clear_carry(struct pfn_batch *batch, unsigned int keep_pfns)
>  			batch->npfns[batch->end - 1] < keep_pfns);
>  
>  	batch->total_pfns = keep_pfns;
> -	batch->npfns[0] = keep_pfns;
>  	batch->pfns[0] = batch->pfns[batch->end - 1] +
>  			 (batch->npfns[batch->end - 1] - keep_pfns);
> +	batch->npfns[0] = keep_pfns;
>  	batch->end = 0;
>  }
>  
> -- 
  I tested the reproduced code in the kernel with all 3 fixed patches.
  Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230313_234302_try_grab_folio/repro.c
  This issue was gone and the issue was fixed.

  Thanks!
  BR.

> 2.40.0
> 
