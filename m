Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B066D2E89
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Apr 2023 08:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjDAGVq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Apr 2023 02:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjDAGVp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Apr 2023 02:21:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA810F74C
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 23:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680330103; x=1711866103;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KcccnyaQkqF9c3DBEneB981TrWWP3j9x9qOIKKbGLBg=;
  b=AD5snhKeWnrl99C1PIc88wiUXhjIhzAHPI3DmzaBSATEZrkKh+P/AnII
   +24QPyVWmMpWtDnjQ9NkkCmZnAb/KVeVWii/+seBKiUGfH6OuAeXfIv22
   1WGlPk+I3+hBpeT9vjdcReINAW5DWMuawWFqvJ09wg1ALGnJxZdRXF1rV
   rytyS6k9oMkzYmmYRpjUMTIRMVYCeHpdLkJgAh4cQ4U5n0B1kgbgc2YTP
   +cBxrC4tICOrvlRU18I06+Ia87hv2xFko7ByUVNc34gWzbECiLQoQVFG3
   BjlDv7NkmY9yy4odrXZgjR4XiNFfHgQMFOWY+QpMKuHZ4AARNDdX471wh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="339121763"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="339121763"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 23:21:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="859582676"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="859582676"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 31 Mar 2023 23:21:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 23:21:42 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 23:21:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 23:21:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 23:21:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+8bgFNYXFNPE72W9JRqXWXi30gAbLQpGYemCTfl1TW1Hj/Xzg7jfaFXziAp4yPb53zQgpmPs6PcGzB13aR0Df2RG2iue/0VO/QZ6OmV2CjsJH5iN8HsRnSK5F+D/jW1U1XFqfEQ5ybNBclqDSQyX4EGP8zoiQUnA2AlvOhEE6hEedZp8SqF+hr7IqUmjmwo7T93JQKJrRdP/ZPngdfFgEmaTlAVanLFpMB48iGY0ixGFlkXG0jGD63PHORbotJfARGio2wrk9OVntQk6yTfVf/E1PTi8wlrIMRro+uZBU7+k45Kq7Q0cDdHby60679twAK7ly9NbfWU22Op5diSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcfWLBA7TsZl2sYkGGUTnu7B6KH1nwI2Dt4vWFcjUSY=;
 b=mv6zhXuqBT5lfCLPwKXLwZI2+0Y5Gr1x3iSsFB1hKWSXuJMkGgAR2tqyz+3hTJB9LWocbblH/2D1RqxFDB7j4fuhNypCfid0kyRrrEi1TAmQN8MuHR+ZrKEhZSqYnQlXmvhDM3fggWn4J+1Rg/VsRs+zgEjCmWzHC/PUhl/+UUpS+7q7uzICWHx5HxXdDqyNFEN1OCYz0C/sOCx6qD6kY+2ki7x+F7txdIfltnVQJCqD/7w3fhyXZ2ZMfW9Jg++LjvmVZIhHlhElrdUjDOSXhadDweqc6B6ffEzjuusCtE/YE4D2gtxRi3yaNnN/1Av28TjpeNtPktmAKYojhOsBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CYYPR11MB8386.namprd11.prod.outlook.com (2603:10b6:930:bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.26; Sat, 1 Apr
 2023 06:21:39 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%6]) with mapi id 15.20.6254.022; Sat, 1 Apr 2023
 06:21:39 +0000
Date:   Sat, 1 Apr 2023 14:23:12 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <iommu@lists.linux.dev>, Kevin Tian <kevin.tian@intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/4] iommufd: Fix unpinning of pages when an access is
 present
Message-ID: <ZCfN0MSBxfYTm7kI@xpf.sh.intel.com>
References: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
 <2-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CYYPR11MB8386:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b5c4a9-90df-4bb3-d81e-08db32795a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9/fZgQzbboW5BLtY/cdV2AU2vSMB+Q98YfQ1G8xrnwz6ySOJZL+n8+EK1Wqzk05cnoFH+w8vBLAcXQ6tnWRpiCbYvwuMBSLum+z1Oq9hhC4b/uhOqe3IHXfQDqoS1KMWVuYQgMMjUYV0XVttBREccv86AtszlZJHw5Ci/xw2AjqQfkMc2XD+vZLK0rCN9r0J7fGmCYPJkpAzzpC/g9Ma9peD8k3hEidE14/1qcjmdrxVo7OlfQPXPCNMolzxohJUjpJhYEj3cwPrpZfMMSM7+SpNLPHm1mOD9oYNP8M7psPdyC4/Qez4Is6MzlmNYKjMEh0c/cUVcKjYHXLS6s82M+0TI7mwbVfCL+rfzuSQ70qGGVg6QCg1rgJNCThR4o6NSpTKGTCJJOc53b03NHAWLN1QvXO9QIz0J60AleGXZGXZKEXJZVxAvxjq7puM2UKGITmVJSOHLlPopb2FNc7yr/YhPmnwIxHV5p+K5eq/2H3jyzyXWT+GOxfezCUBmBPt5Pv02TGj2qM44Ybr5ZwaoxPa4RjthEN+6kJRo/hOMSS986Muwq5aK/jaEF1aIxsW4ffmHxrup2+FULEaLTY5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(8936002)(38100700002)(44832011)(478600001)(6666004)(107886003)(82960400001)(41300700001)(83380400001)(5660300002)(2906002)(6916009)(8676002)(66476007)(66556008)(4326008)(66946007)(186003)(53546011)(6512007)(26005)(6506007)(86362001)(316002)(54906003)(45080400002)(966005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nkk7OM0/zx7FAqKXa5uunzZu/XFrQylpfzuIh8McWQMJyEd5kpxBzGQ9Ag4X?=
 =?us-ascii?Q?1emfvZ+8xNNunWSG6oEhV1avFeBbfXBVF+vK0zWMLnUZGMcvX2wlBsIvX6rN?=
 =?us-ascii?Q?06O622ztpyxEkiT5S7pMISZuePd8F14iTuImeCNiSv4l/A84E/Fzg4TWKUv+?=
 =?us-ascii?Q?N2IbuU1224tKA9+YZM30FbrR3vw7j2jAwHituMyLPCMLfDfLUWKEuPA/1OTt?=
 =?us-ascii?Q?0l8RZ0dcYV7PRqGTficOz5+jkmQn9iWltOYn4/QMFhsIoZ/CfzlaCQXb+VCj?=
 =?us-ascii?Q?Q3VKCc1MMFb6B4vncxpf5m62qjKTqR+ZyrMNCO79UccBGM9fjz2N8z7vDA2E?=
 =?us-ascii?Q?ZdYsHV6+Bp3PHAoOqmXYloGXO4zbDj4o26AzH4AkWi6jwntg28oE5RUAHnen?=
 =?us-ascii?Q?s+stxqlHne3b+lYPKrdKN7gwU2M9PgAznHUCL8aBxdKnsyp4caRBLk7iCRUC?=
 =?us-ascii?Q?QPo3hfH/2ifMRwswrRFxlWqqJKBCBlNNc81npmTGedg6vYify2kfcnXa/bWt?=
 =?us-ascii?Q?JU9EI+y28uBUVXOLQjAlO6sqlc3qKhScAfnfAEe7LMdV+KgJCmwnC73gjowv?=
 =?us-ascii?Q?e2NW2qXcjifBFNe1bJp7gl7rNQrovMAoQUsJ0HAVyEbyZMF9poNKDb+JaIvx?=
 =?us-ascii?Q?Xs3aBCd6VEZjQl0JkGGgwCKus1RBcARnlFhYobOS1q+5p7hMbrhtDpv4Yj0h?=
 =?us-ascii?Q?kK2xW5cvEZIjtshsf1C1ybXfhNKMUtp1/mQgfWMgGKE8ZKcTsfqweXPHEifh?=
 =?us-ascii?Q?8TlGPosz49YDiLh1VhbnSgg0nlVJKh2jrtjdunJIqfJ2Hrd8bzyHySaYKDWn?=
 =?us-ascii?Q?tHvebeYMwfIbt3oliYlF2nBNQTOi6+l19eE1CC4UnWUsmS+9bveDebNZe4i+?=
 =?us-ascii?Q?5TNbisxmgTRgrc+zY5whhSu7YsVriofGghWV2YVtVh1cKIAa2oFoZU0EBM+a?=
 =?us-ascii?Q?J+X9dLEuRIjwx9ZtuQUYs2gzUViYGLJLozR5wJrlmIpjWfe47LMQkRgJzSsa?=
 =?us-ascii?Q?Wh2vv1EZl45LeTDVjivO0qUlE15QgMrLberYeQRhyyozHp8xzW2cL8DLH/wC?=
 =?us-ascii?Q?h6KjzLxoJsBaZdE0lWwMx0VVa2QwzXAhtXF6QO4kYAXCHWlEJO6STjvx3PIS?=
 =?us-ascii?Q?oWwrGxd9QLCGDNcmbOpI/hYJ+Y9rBObw0Z0twWH+ILS4aOrkPzV64dO93MpK?=
 =?us-ascii?Q?+gbvFcGKUiRC2Yp33IwvwACMnHuur1o+o7zzqx8yf4zJVFB3/ybI/xwoHNsf?=
 =?us-ascii?Q?iTKATFH39IElhVtnIHxH9ZEfhkOdIiDXpNhB0MJX7fWPUJkW5XvbyvVaCUVl?=
 =?us-ascii?Q?eD1BkFfqs8w6xBnj6CNZSjcWe2YYcB1ze6wIPadgFz5Llumf/kg4aw3gfBQt?=
 =?us-ascii?Q?4DvaArbpQATfR8F5ky2L49BqzvQUB88E3YCPQrWE22hZ1ew1JkLyBjhHTtEV?=
 =?us-ascii?Q?6xTq5zwXujRz366hKeDR+0ZmHS3aMjTbs1Lflbq+RwFUKLhHZZwZ69LS3cNC?=
 =?us-ascii?Q?kNtH9B/Rehy/mEUBYeSYVDZwvngox4iA7ApBC6dKuET2HNYb5/yw7Fmxjauz?=
 =?us-ascii?Q?tKOVPuhnsk7tr2ph6Df9SLDA//3orOJ3F4bPc3oo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b5c4a9-90df-4bb3-d81e-08db32795a27
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2023 06:21:39.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxjRZWSmpivIGAw+b2ZRiIX5Rm1tySzyN/IKrixnqbsbnEI+D4gHKd8SthP195oojQSx7g7kAU9WZi8dHYcnzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8386
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

On 2023-03-31 at 12:32:25 -0300, Jason Gunthorpe wrote:
> syzkaller found that the calculation of batch_last_index should use
> 'start_index' since at input to this function the batch is either empty or
> it has already been adjusted to cross any accesses so it will start at the
> point we are unmapping from.
> 
> Getting this wrong causes the unmap to run over the end of the pages
> which corrupts pages that were never mapped. In most cases this triggers
> the num pinned debugging:
> 
>   WARNING: CPU: 0 PID: 557 at drivers/iommu/iommufd/pages.c:294 __iopt_area_unfill_domain+0x152/0x560
>   Modules linked in:
>   CPU: 0 PID: 557 Comm: repro Not tainted 6.3.0-rc2-eeac8ede1755 #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:__iopt_area_unfill_domain+0x152/0x560
>   Code: d2 0f ff 44 8b 64 24 54 48 8b 44 24 48 31 ff 44 89 e6 48 89 44 24 38 e8 fc d3 0f ff 45 85 e4 0f 85 eb 01 00 00 e8 0e d2 0f ff <0f> 0b e8 07 d2 0f ff 48 8b 44 24 38 89 5c 24 58 89 18 8b 44 24 54
>   RSP: 0018:ffffc9000108baf0 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: 00000000ffffffff RCX: ffffffff821e3f85
>   RDX: 0000000000000000 RSI: ffff88800faf0000 RDI: 0000000000000002
>   RBP: ffffc9000108bd18 R08: 000000000003ca25 R09: 0000000000000014
>   R10: 000000000003ca00 R11: 0000000000000024 R12: 0000000000000004
>   R13: 0000000000000801 R14: 00000000000007ff R15: 0000000000000800
>   FS:  00007f3499ce1740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000020000243 CR3: 00000000179c2001 CR4: 0000000000770ef0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    iopt_area_unfill_domain+0x32/0x40
>    iopt_table_remove_domain+0x23f/0x4c0
>    iommufd_device_selftest_detach+0x3a/0x90
>    iommufd_selftest_destroy+0x55/0x70
>    iommufd_object_destroy_user+0xce/0x130
>    iommufd_destroy+0xa2/0xc0
>    iommufd_fops_ioctl+0x206/0x330
>    __x64_sys_ioctl+0x10e/0x160
>    do_syscall_64+0x3b/0x90
>    entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> Also add some useful WARN_ON sanity checks.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 8d160cd4d506 ("iommufd: Algorithms for PFN storage")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Link: https://lore.kernel.org/r/ZBE1k040xAhIuTmq@xpf.sh.intel.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/pages.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 400ec7c91ed7e7..b11aace836542d 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -1207,13 +1207,21 @@ iopt_area_unpin_domain(struct pfn_batch *batch, struct iopt_area *area,
>  			unsigned long start =
>  				max(start_index, *unmapped_end_index);
>  
> +			if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
> +			    batch->total_pfns)
> +				WARN_ON(*unmapped_end_index -
> +						batch->total_pfns !=
> +					start_index);
>  			batch_from_domain(batch, domain, area, start,
>  					  last_index);
> -			batch_last_index = start + batch->total_pfns - 1;
> +			batch_last_index = start_index + batch->total_pfns - 1;
>  		} else {
>  			batch_last_index = last_index;
>  		}
>  
> +		if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
> +			WARN_ON(batch_last_index > real_last_index);
> +
>  		/*
>  		 * unmaps must always 'cut' at a place where the pfns are not
>  		 * contiguous to pair with the maps that always install
> -- 
  I tested the reproduced code in the kernel with all 3 fixed patches.
  Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/raw/main/230314_094459___iopt_area_unfill_domain/repro
  This issue was gone and the issue was fixed.

  Thanks!
  BR.
> 2.40.0
> 
