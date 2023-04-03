Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332E96D3DBD
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 09:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjDCHDe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 03:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjDCHCy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 03:02:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B415F26B6
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680505337; x=1712041337;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6EJuAlgBgrnm68lFWMUSH3JlonExYyCa87EqEgyjYIw=;
  b=WHmYqkE6KwqD7jFz2kYMlS86uih2/EZL05VCOcIttq2UZ8GEiubG/YC/
   PKBgE7VIMk8uNMhKMvLbzP++Ws6kzLbNUMclIHICXubRQ8DResuUrpqDP
   MP79bUbTVY6SstDJgMeCyvUIVIPdmHAMNBpHOO5JC5Kjf8Fa6igTBU1ke
   N9FgSNoCuPgFxzov6e6i0NK/bey07vsnjjunWlHF/tH00StRwrOXOgbV0
   3PJr8bNhNRe/MiPhs0t4gsc/tPvY7NfGtB7DBmk+Z8v6PMsSjBtdCKIOs
   I4tfb7DMXllK8o1DD7aTolzmchXQ67GPsmJjfJuYIqMXYAD3JWhdt74QE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="321488139"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="321488139"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 00:01:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="718432356"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="718432356"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 03 Apr 2023 00:01:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 00:01:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 00:01:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 00:01:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 00:01:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9TXVnOR4jzD9pz+2x0tYKJxwMFJDRCaGtoyAdoxNWVW+Q7WawMP/GHeF+2M7fd8T6PAduk4p/Zub3KR8y1eomJFWoeTegDkVCNAS2Q/umztYGIorT2odAsHgIdjPRAQ2KD/pxktRegM0e2ySZeaxH9WN7PkaGrHt2e9cmf0quIdPEAoW/8m2uL6koyz7epPJHihKS9GhuOGlVpnIfmo1lTVunOlNZMSy0kPQp7wEbeBrW7g8rVi+HZJUUjWhYReUwaebYuoXLkjATGPFyVwfBmg/R8Hh2Jg1ygYeUZahByBnAblD2qXSnriaZ8S7hDqVT3odTL9lj3qo+d1GxO1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMrRfFUrDeAOX/cT9RsyLzNGr6MQ1wuIeKz6D8nRspI=;
 b=oQOJLMSgBXox2pl6Nym/Ipz+urLrEdUAvq98oG5cgwAn/+dIOUCMcSIrQF8Xv7W/qQYY1J/R0t91y/KBw8mdFP897ngvcJ8kIn59YoI+QAxUX7h3i9STK12OaiIGJwk4XNyLHzd2GDm3eojwsA6RrPWZ4YJEbyff0eNmwzD+AiDgznxQ4H0AZdksUHtnCvylFOzqyezgnuRAMCK9V+vCIGWUVa2Q+KuRqPoP/Wtd0sGzGWuu2H7T3exW5lYnsS7Bm7MBdLjZzTup472AwKu/Lemp8QNsJodJFrB99SEYZSmYY+GUH1bSoE4M3tOpL8iGlIiZ1nQSgaXMp+NZIMIqfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by CO1PR11MB4833.namprd11.prod.outlook.com (2603:10b6:303:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Mon, 3 Apr
 2023 07:01:22 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::9bec:338e:49fb:54cf]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::9bec:338e:49fb:54cf%6]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 07:01:21 +0000
Date:   Mon, 3 Apr 2023 15:02:56 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <iommu@lists.linux.dev>, Kevin Tian <kevin.tian@intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>, <heng.su@intel.com>,
        <lkp@intel.com>
Subject: Re: [PATCH 3/4] iommufd: Do not corrupt the pfn list when doing
 batch carry
Message-ID: <ZCp6IOS0UtUE8z9o@xpf.sh.intel.com>
References: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
 <3-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
 <ZCfPTfmYA7SvNd+a@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCfPTfmYA7SvNd+a@xpf.sh.intel.com>
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To SA2PR11MB4844.namprd11.prod.outlook.com
 (2603:10b6:806:f9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4844:EE_|CO1PR11MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e8c743-78e6-4be7-a762-08db34113b33
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utAo33fSCLsblcNtS6pohl4DFwtlDb9FDLWed9wRIo+hxFfcXEd4J3R6kLld2A627v7s/LnLP7IAbdcjMKsmsNobMTznijHNQQnl6M/Ts2qY1bALpfMmq3eG13Ogj1+lRAM2aOs/aVt9cU77FaiFFwtNCJqi6mjCLD9kgn3wvhpcqlHlWmAYp+28ckST1rqHT/UIdQ6HchINtNOOzrrToUIo0PIYPp96/12ejzyIV1/FC8h4VCNT9RsyqNET5omVXMi5ftqczgIi4LT88YxtWUPdVVP2Q5AWQcWA25ZbYMYThQGMMjEOkcl7fd10ww7ztFj8Lq5UlSDp3XyhFc6Jvk4HLT+P4Nri1HnSo5xeHcwlVb8UIcp2uZT1Us58IFMUfhhRVmRCCraZJHjE6hQnLpCccRezHARm03QYBxTKgY7cIYIRu42dlH1zHJH7zPfxRN5VJLeKwKWOosbiG76HkgkJxXVCEL7OcNdIhbv+6tbB/kSKWdhJnCA2tBvQctn7L95vKJBWCVfKvcH9+uZvLTi6Zf9SB2/GYotAPRojO+tbDYyktfBO8noMgblMTj5mHffm9y3wpn0Ii/pirdJ0QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(86362001)(2906002)(966005)(83380400001)(53546011)(186003)(26005)(6486002)(6512007)(45080400002)(44832011)(107886003)(6666004)(6506007)(8676002)(4326008)(478600001)(66946007)(66476007)(6916009)(41300700001)(66556008)(82960400001)(5660300002)(38100700002)(54906003)(316002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qRZ4n+684k/Z5MxJVs1RvuGlhvom1/3Lio4Pxl09DeW5BgyQ2SM2AR+3Hvwj?=
 =?us-ascii?Q?bsjlkcFIv+Adn/i9MDiB4vT2rjF5NdURpi5azKZcH2t9TPZ7XvYPALsAJfD9?=
 =?us-ascii?Q?D1aRJsCwiy7W/Jf7CuEGmVmKN4VhXbIDNzdochNtBkOdc4v320fQaKyfGo13?=
 =?us-ascii?Q?4m6n2uDThtRk464PxjT2H7OcJcAvCoI34Vr6AAjtnHKcU2hVGHh6tpVjj8UY?=
 =?us-ascii?Q?Yq4SmAjnqOxiFPNHHvBm9zFlntxyRb88FMlSP62MZjSyJZ8i9PZbt/htb/i5?=
 =?us-ascii?Q?z3MNjpF3kwE28LxDlbeCDnIGAgPY4tovFJwxgISxRgF9x7561X3SofzdZkai?=
 =?us-ascii?Q?vUYNVbia9UZLNk5CeExQz/zTuMC68TKiTeY3RzBm85z26M3Nz/IrQAKFbs1X?=
 =?us-ascii?Q?gNjcq/EsuAAkU0D3TsnTpxahCZcmIEf8pLftDg+ElHDnBTYn1NpyvaHn2EpQ?=
 =?us-ascii?Q?OVCU1L5CGX0kjDLa+IyeC0pbhbyBeKkze7e41JE29HvPFRfAe+CBGz5AftLa?=
 =?us-ascii?Q?lBAZlcftCRQz/1tjoc6cpEEjPIaFq83klCmRtvgYgqHaWN9rcFZi7+iLzOxb?=
 =?us-ascii?Q?JVAZVV1SPJpZqrXXbdbTLIs49eU1QGL4TrYYfQ88Nj4xwkc0d+jwlEQ1ubM8?=
 =?us-ascii?Q?qJSWZzLh4rLIV3qk6zc+3GN2qFB9o6+HPXcl+IqErE/PLP2/ieezCbq5jh8B?=
 =?us-ascii?Q?HKNJ7H9aBqCTfYtPET1Za3yXJx5y0ccqJFZcMTosHliLy8ljh7t7cISaj8h3?=
 =?us-ascii?Q?u65tnRPtrWq6ceVs+jZ+xRsDKu1a7UZrnJn4Zon1lNuM4Fi1PY15kSXVkRvm?=
 =?us-ascii?Q?02E23ZotjsOao9QyoS1ecJics32taFnhBzYYtCZkZkxW4hI9pSA6avEU1Nsh?=
 =?us-ascii?Q?UGvCSDYgi1Rx+tcCEV/WlV/ooebpSk8wADR9+hvwhSyyIRJZ5cUyH1JUuCkI?=
 =?us-ascii?Q?b4VufI1JepDHro40p2pULrN/DpKgQRgwFqt/cYuvEhdk3Q674IyQ1OYyY/Ha?=
 =?us-ascii?Q?7RXKd55hjlMQ63qLXwnicfavaomTRwesT3VjZl7wmNXjxA7Jt3t7mGvpc7iu?=
 =?us-ascii?Q?lga6oOfeSeVL1dXd3zgaJs0AHXeugZATWf7XC56jtkF1CS6ePtnF5PFMcNB9?=
 =?us-ascii?Q?0ctN69csWZec0j73bXIl+OnEMEKWNuPMqy5b8Pn7e6rr/4QZIeQd+4lHcjV7?=
 =?us-ascii?Q?X0e5ul7AVOgT7buyw9X0CnJxErc29PxuM9/Yn15+x1VJk4roPCQdu3sxhOSg?=
 =?us-ascii?Q?xMBeegGV7zhCmgNDMvg2DG/8jdMOZn5nsC75pd0xwwycm2H+FXW16jOeXRk7?=
 =?us-ascii?Q?X1noZXcAp3r/mGbyOZIEMXlOMN0cgvViAsEECGx2j+rplPu8rP11xqOLY8yV?=
 =?us-ascii?Q?yaTU4ZeoNvI/l/9O4rlQtkMSAKUqvV+sR3gELXiIAWc1O+HQNRmUvj/l0V7P?=
 =?us-ascii?Q?POttOep44WzqAp/bjJorwdOvRTeicNY/Hp0SJJAaWXS/3mfE5+10FXJtfIOG?=
 =?us-ascii?Q?ol11F5wLSTov6DtAtFakEyYg+xaQyNVRfixqzlpbe2NUkJBqx5OUKXSImCod?=
 =?us-ascii?Q?6OxDN/QTuw+nveNI4XPwwKO6kvXGb5OpK56rMgSl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e8c743-78e6-4be7-a762-08db34113b33
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:01:21.9096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Io3KymUMqmyaohgo197ZHYzXlPq0jgAjAFSmLjya9of8YPfkY3gLPyFbi1OoNdkdByylwnGERlWOSGE2rwfFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4833
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jason,

  Could you add "Tested-by" tag from me?

  Thanks!
  BR.

On 2023-04-01 at 14:29:33 +0800, Pengfei Xu wrote:
> Hi Jason,
> 
> On 2023-03-31 at 12:32:26 -0300, Jason Gunthorpe wrote:
> > If batch->end is 0 then setting npfns[0] before computing the new value of
> > pfns will fail to adjust the pfn and result in various page accounting
> > corruptions. It should be ordered after.
> > 
> > This seems to result in various kinds of page meta-data corruption related
> > failures:
> > 
> >   WARNING: CPU: 1 PID: 527 at mm/gup.c:75 try_grab_folio+0x503/0x740
> >   Modules linked in:
> >   CPU: 1 PID: 527 Comm: repro Not tainted 6.3.0-rc2-eeac8ede1755+ #1
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> >   RIP: 0010:try_grab_folio+0x503/0x740
> >   Code: e3 01 48 89 de e8 6d c1 dd ff 48 85 db 0f 84 7c fe ff ff e8 4f bf dd ff 49 8d 47 ff 48 89 45 d0 e9 73 fe ff ff e8 3d bf dd ff <0f> 0b 31 db e9 d0 fc ff ff e8 2f bf dd ff 48 8b 5d c8 31 ff 48 89
> >   RSP: 0018:ffffc90000f37908 EFLAGS: 00010046
> >   RAX: 0000000000000000 RBX: 00000000fffffc02 RCX: ffffffff81504c26
> >   RDX: 0000000000000000 RSI: ffff88800d030000 RDI: 0000000000000002
> >   RBP: ffffc90000f37948 R08: 000000000003ca24 R09: 0000000000000008
> >   R10: 000000000003ca00 R11: 0000000000000023 R12: ffffea000035d540
> >   R13: 0000000000000001 R14: 0000000000000000 R15: ffffea000035d540
> >   FS:  00007fecbf659740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
> >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   CR2: 00000000200011c3 CR3: 000000000ef66006 CR4: 0000000000770ee0
> >   PKRU: 55555554
> >   Call Trace:
> >    <TASK>
> >    internal_get_user_pages_fast+0xd32/0x2200
> >    pin_user_pages_fast+0x65/0x90
> >    pfn_reader_user_pin+0x376/0x390
> >    pfn_reader_next+0x14a/0x7b0
> >    pfn_reader_first+0x140/0x1b0
> >    iopt_area_fill_domain+0x74/0x210
> >    iopt_table_add_domain+0x30e/0x6e0
> >    iommufd_device_selftest_attach+0x7f/0x140
> >    iommufd_test+0x10ff/0x16f0
> >    iommufd_fops_ioctl+0x206/0x330
> >    __x64_sys_ioctl+0x10e/0x160
> >    do_syscall_64+0x3b/0x90
> >    entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > 
> > Cc: <stable@vger.kernel.org>
> > Fixes: f394576eb11d ("iommufd: PFN handling for iopt_pages")
> > Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> > Link: https://lore.kernel.org/r/ZBExkEW/On0ue68q@xpf.sh.intel.com
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/iommu/iommufd/pages.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> > index b11aace836542d..3c47846cc5efe8 100644
> > --- a/drivers/iommu/iommufd/pages.c
> > +++ b/drivers/iommu/iommufd/pages.c
> > @@ -294,9 +294,9 @@ static void batch_clear_carry(struct pfn_batch *batch, unsigned int keep_pfns)
> >  			batch->npfns[batch->end - 1] < keep_pfns);
> >  
> >  	batch->total_pfns = keep_pfns;
> > -	batch->npfns[0] = keep_pfns;
> >  	batch->pfns[0] = batch->pfns[batch->end - 1] +
> >  			 (batch->npfns[batch->end - 1] - keep_pfns);
> > +	batch->npfns[0] = keep_pfns;
> >  	batch->end = 0;
> >  }
> >  
> > -- 
>   I tested the reproduced code in the kernel with all 3 fixed patches.
>   Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230313_234302_try_grab_folio/repro.c
>   This issue was gone and the issue was fixed.
> 
>   Thanks!
>   BR.
> 
> > 2.40.0
> > 
