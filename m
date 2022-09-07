Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B175AFE10
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 09:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiIGHuI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 03:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiIGHtt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 03:49:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FCB12AD0;
        Wed,  7 Sep 2022 00:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662536977; x=1694072977;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7vGP8HMFgBO+IHOgzMjS9fl+FzzMif1O19E0hDeW1sM=;
  b=bKoT7hFZtSWe5G3aQAGGXAA7lmHmIgFdSLPJpaNEm38EAKAXHy3bugfo
   A/uxC3CQnRR/69fRHipO7dGxV6MX4E/+HPErcmS+GIj9VEefWo6qETjln
   2EOeFNPbwn5kEBJdW20liys7KxHKnLoN6kyU5yoQDZmiXWaBg7+8ACjli
   sLDR3GWhQJQz8PPEmlQXpp+1p0V80vfW2E/K1ArYPJTHoIKGADLvLXzbR
   +5LRr5ZpJYAKaj5mJqFvuwl6wBfB0OZ5lSdG/StSX5xLHJBSFtbS7TWQB
   CYQsy6UVhuNmyEhuy/UgR5nUX4b9aJ3X5LnSKMGbmpvdPtFHEB6W1dnvZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="383102834"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="383102834"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 00:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="942789401"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 07 Sep 2022 00:49:32 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 00:49:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 00:49:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 00:49:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naS1Go3HnKE7xDqdQyaJmjg/88RpWRwSj2l6kqEbsFDA0hG31On8zhq3bbeTu+z3OHV4BgVLw57AEQD5C/UwJuVRqgxmfMW+p+EMG+X3VygcjiM1uBep6phg0ZaKmHDMBEFakBA0cuDjqDY5oxf/srYv04XeP4NAsFY0+SJC1WA28RNTWVPIsnB238UTU9JwdZauZThTqStdQPSXgfMhY0xG3INIysCgeJmw5EL8kRkcbUqbFZMsackDHRghPCZb500LH7I8eyb1P+mUHfFZUuYYFuBVBRkcJGQWGSGg+lQss4+VPPLNRDcrZ9w7o8bWy6R6lN1Ym4MsO6/e3zbBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzu7tCUOTU+xDhAlzQsH8NODqqqQOd34swN8B5zVbhY=;
 b=RCWNuPID3E4lh0r4idYmXo2H4bxnxgHXeg5tckWINEq1SHyqvV1g1gti4SIzvCJQc9R/I/Mkt195LmhammMm/3ACPhICazWICHhvJkHIj6Nm0Oqg0sdH3lkIdDKifBRCGINpqAfPm+bXo3YMkRjezgAB8EBrs4wb5GiPh2vb1zAxj/FfUgWrZh8blvaD5t04LZK/EQEqUzgGfaQt8VBqtS8q/XXHemRjfXCKCjgB6aG79JVEpbITrRy3fsHU7bKcH2WAA2WfIHGoNucRDIzN6VitbLrWGwi0mQFBV0N1QxkE4WHshWIj0OD15RJimfkpGr5wpGp4IsBXnKL+akr26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by BL3PR11MB6387.namprd11.prod.outlook.com (2603:10b6:208:3b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 07:49:25 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::a022:f698:30d:3779]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::a022:f698:30d:3779%6]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 07:49:24 +0000
Date:   Wed, 7 Sep 2022 15:49:14 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     Kees Cook <keescook@chromium.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <linux-hardening@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: [fortify]  728833277d:
 WARNING:at_net/netlink/af_netlink.c:#netlink_ack
Message-ID: <YxhM+kszs2mCFVyV@xsang-OptiPlex-9020>
References: <20220901065914.1417829-2-keescook@chromium.org>
 <202209071317.245c5751-oliver.sang@intel.com>
 <YxhKp4n7K4h3aMQt@work>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YxhKp4n7K4h3aMQt@work>
X-ClientProxiedBy: SG2PR06CA0210.apcprd06.prod.outlook.com
 (2603:1096:4:68::18) To SJ1PR11MB6297.namprd11.prod.outlook.com
 (2603:10b6:a03:458::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6297:EE_|BL3PR11MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b5a8eb-69a0-42fb-152f-08da90a57bc3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xrKjxhuYj7+Xo1zJrNOjyrOACQgZuX2d3THMwtafTo/R1x4CNm45i9cc3bUJ5C9zi/dYSVE6GN+v60vUxSVTsgNBZKtx+UzTf8kd/XE1qvPNMZ7WaJUuInqfYPV6e9rey9PWz7eV+a+TbJanALbtpb/JAddTpvkkWzjPQGeFITHQ4zfmKnprSKfwRCsJRheA6UNcZWT9gh3tyuB3o+++bwnzSKjfBSvEYQLJp47H7Za16/gWrA5WDgrQgMVmTfv9dvfgw+OALum/uQeKApumzRzXjyPrADExMsOSAZ2YyEM8n6NeLMpMP974jFcnMoKOza1J1Ah/HvRF+UkzI2ot/qCE1l0zSoRyN6zbrIB6/ZBb8wHk860UoOxLB2bbuUDb6Xv+kH64FIZtcodmErLZCXzFdeNzoWq8EP2qwf2DtKECOPoVVBHxelIBozHTc7v38svaIwW4CpQNOuswJhl965i/IhJ1vAQMGgtd5tifhOoa4SCfMpFvYyVX+9Axg08CKquSLjKn5QEPElwmUN3BzGcEqjqphPygL95SXwtCscqRNpO2stc+He+fC2bcf9hUSLtt7/voASFonDYBuM05sy2eHeMra2mTDoCN72FxFSaBK6QFdWWFssl7sOShtkR/Fj6hL+8PZWJLco90UmGJZCyMXM9FAyfVJjm0vPThmAYxicnbgau0yuo8tmIbzUiFRhv7Pjwa+ZccjePlXdqp2ohJWVmiI7DU7kaB6eeRZWlBLkMCi40Hfh8tOnSGrE/aThhINZoAq72jn881Tjvzy6qszAj3g8Rks1F+FTnYS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(376002)(346002)(396003)(366004)(136003)(8676002)(4326008)(66476007)(66556008)(82960400001)(66946007)(38100700002)(6486002)(41300700001)(44832011)(966005)(186003)(6506007)(26005)(478600001)(6512007)(9686003)(6666004)(54906003)(83380400001)(6916009)(316002)(2906002)(86362001)(5660300002)(7416002)(33716001)(8936002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o4H6IUIqj/FXd+fbQ0ie5RqOtbvKNSk4jZ1Pe064rS7H7ryTKyqkRL2Otv37?=
 =?us-ascii?Q?XZyT6Z2goV7nkaiXQ8emQHyVwTFpN1w76D+LMs8MWJXlBJ5uN3GOYgJf2oOm?=
 =?us-ascii?Q?3HUtuamUfhAqbGgqghTNKlhDPsbjzQy08HVISLCgMeLC3aD1EehmkSntMfC5?=
 =?us-ascii?Q?+hYNjTYGsDDKVlRHmSLzsB6HDeQn89pkbrAXm6Xn2cccK0RuljXGuQG2vhjW?=
 =?us-ascii?Q?KRoot2Seeha81PZQbeY9Vh2i9vyJVyFev4WWOmatqannNfmCZBtvaNYRClta?=
 =?us-ascii?Q?jEYFSfIX3u1nBDGnm+KR5fI2PP31SWczTJ+s1UQlZzq//1Mgo9YXvfegk/4y?=
 =?us-ascii?Q?SJd0Ka9dWCxdMxqNrtUbndfJA+fcmhLLKM/E5qZ7ywbscI55oyu0jJmCeGQ7?=
 =?us-ascii?Q?R3b75Uw0B5yvILRVt02shS5Pxn9G+3Yx+6OA++HadjjjIdOvia5/CU3k4vQy?=
 =?us-ascii?Q?Vtz0HBXH5VsLU46PYop77VmuE6Xb/hvWcTSJ5dX7KvW39uNjiogWfQpow5Jk?=
 =?us-ascii?Q?XXmWEGWkBI/GCCWnXAJG9NUvXrDu8W8id1Z7n2JFX3g3lI1xJM5gyGUpWAWT?=
 =?us-ascii?Q?owS2j91akeWsHa8sYds3y1w0aJLrT4sRGabUk8+z1rX+EcoCwjWusxFojMa0?=
 =?us-ascii?Q?9Xcj7hmoSHojYbWefMVSdr7KtyNSGZD7ADtxbozh6yiipD3tv/oVPIheuoKX?=
 =?us-ascii?Q?bEhSRuIVzg1JV0Hr1Okd2Qcj3pc9lWYd4OeWKC97mi8REDYP8J5na1hlQjNB?=
 =?us-ascii?Q?PCB3XTV7P7S9pD37eavTPw4AyBCLgwEcIkR1czdZOy+j1ylw9OnGKgLDkNl8?=
 =?us-ascii?Q?pglJ9gyQymmR2vPbcSuaC5s6qOrUOkQQozxFE4OeuPE9Ge9TnuAYzblxBFkO?=
 =?us-ascii?Q?oz6vsPilKzqBbU6lSTwtGXktAzU4unVXM+x6QH0Tjx0r8V2r1JkltVwagXRT?=
 =?us-ascii?Q?8ugdStuv5AWorD/E/SAEGmgCHUWadWY/IwHfCPPpFydbJFsFqzvaWYUPcoZc?=
 =?us-ascii?Q?P/7Tvuw6GeKVmN2Lc9l8RKoXVnzVImX+4/qFGsUu14HTopAwLyqXmEpK8vbK?=
 =?us-ascii?Q?3MxlEJeD7sDc96v5zwcop01C64Vg/fzfens6uEr/0CADHSN3FavX0QSg4ZTG?=
 =?us-ascii?Q?YlpMokDJdwA8q2metg/pKsmGosH8Zx1DiBbhfy8Ap/tAmbcb1x7KVC7JolLH?=
 =?us-ascii?Q?jTyVsJD0v1oLsTaAKWsQWKrPHkBjZlBOft3RBzf8qe/64jT2itACxpRSeQKd?=
 =?us-ascii?Q?vhNjZpP2mk4gJwJ6Ypp0CatRKt6KZLEpON0CR/C/E56En3WVOGn6bcj2jrxC?=
 =?us-ascii?Q?ehXKo9+oXqaIl0SBVzASCJy938+S5g/BObX+G9dfAXRWdXjH48BivTUlBwD+?=
 =?us-ascii?Q?hT0SOliZMpXzF48sqRmVrefvORAVp+jE01fVZzJfQ/k3T47EzsFLCYRoCqgc?=
 =?us-ascii?Q?r1vqziR9m4GmjvdZX8B0C05ATpECegkEnimOgG3dwqUaEb8Bb/+cUaR7qAvl?=
 =?us-ascii?Q?vealEh6AGos/3wDRpVGqZUrQFdRNSNl4VbnAzlnZmBGJqL8I97alLX5cNuYI?=
 =?us-ascii?Q?Lq3etfHlrDKo6WQsvwDV5pQN+9Rf2JqGiMA8qMtElwGqLs/ADahaD0JzfyAq?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b5a8eb-69a0-42fb-152f-08da90a57bc3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 07:49:24.8294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IV1jJMKEjIAhsZfQqEfuxp8CQD3Qa6nCOoljB0iXeImSXRv/1zFXWQniq6nn1zdW//XINiU5c1eSG2in4j6aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6387
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Gustavo,

On Wed, Sep 07, 2022 at 08:39:19AM +0100, Gustavo A. R. Silva wrote:
> On Wed, Sep 07, 2022 at 01:42:16PM +0800, kernel test robot wrote:
> 
> Hi!
> 
> > 
> > Hi Kees Cook,
> > 
> > the patch "[PATCH 1/2] fortify: Add run-time WARN for cross-field memcpy()"
> > raises a persistent WARNING as below report in our tests.
> > 
> > according to commit message, we understand this is kind of expected. but
> > we don't have enough knowledge if it reveals a real issue in kernel source
> > code and what the next step could be.
> > 
> > so we still report FYI.
> > 
> > if you think it's unnecessary for us to make out this kind of report, please
> > let us know. we will consider how to refine our report rules. Thanks a lot!
> > 
> > below is the full report.
> 
> It seems that the idea is to continue reporting these warnings, as they
> help us identify the places that need to be audited and determine how to
> refactor the code (in case it's a false positive), or how to properly fix
> it (in case it's an actual bug).

thanks a lot! very glad our report is helpful :)

> 
> In this case, it seems that the issue was already addressed by this patch:
> 
> https://lore.kernel.org/linux-hardening/20220903043749.3102675-1-keescook@chromium.org/
> 
> Thanks
> --
> Gustavo
