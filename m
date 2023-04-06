Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3200D6D8E9C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 07:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjDFFCL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 01:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjDFFCJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 01:02:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8989ECE;
        Wed,  5 Apr 2023 22:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680757325; x=1712293325;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=i8diCeNiOCtCxGzfs3PXvI00i7h8IMsJoADzQJf2c7U=;
  b=OSnePQWZKemlkoA+1gOjC8TWD+OM68XvFqtq6gZSXjZtq/tbrdLUO971
   wTQsjDHNh0fclg1pCX410JqA9cEnr8ZLrnYPA1NFhxOgeuGLaiJOjvrG1
   upQ1EeJes91PWUbbzeynqHQsrRCpKAXbXF/aR1YvsgHzHI95KyxyG7ny4
   c4PMr4mGCPaL9QAucFJ1N8Mu7Bf7nb0HBWbskbRo2yGw29v3cDeY577Uu
   1f20gtc2Jna0kulxbePIL5GGTyxmxLNYL4ortNq5dQj90NN6zvtZl3vsv
   HWvp+50AacD1UappksLfcKBvcx8mky69nrugMtVPJvUCOL37+cXQ8D4y5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="428927355"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="428927355"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 22:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="1016734762"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="1016734762"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 05 Apr 2023 22:02:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 22:02:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 22:02:04 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 22:02:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hM6ZXodt4L5ij5h0A9IYHa//Mnb8niAjUlVkv0Z+Yxnm9W8SblEw6qrOd8eZhwKMwjSyNTeIF7KLLgiwZn6L+YWYvHHBUd+Ph3wCDC+Bn1VdZf9FmYHhIxbgeAYW70xNZxFusBiijgHOrwIahjZD4g4QGk7riFl/ncgodGJEVqbBZNhj1wzrIB/iiPhqROeWHPjk38+bqW90xgi9PeC4rPJ00gT+w47OrNquJSxxf+XBWi/6qqGgO4IZ8a+a0Fz73OwEcf5i16ui+k3EPl4H/TweHCHUYK7fX1qH9BWPUwGPTclXd1HIFsB3Fxph95Ui13RUqxXyjqWzqC+Guw1sEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4odnr7GsDpoiXq7N27ln0lHGDkN99Muu++DodEWALes=;
 b=ajxXWOhPlm8zj6h1HOJcsVTJvUoNw3BIXjxWmmZDJUvvEMuMD24ZLz03PtYac/001b3BK6rlO9wWKmhzZWc/4j+toyf9z7V5QK8e6J+4W73gdTtwJqnI0extQvO2hR12su/Fl3YoYqMT1ln0kzeDbVxYLfQNNK80Dkznild4CKTbZ7mppo5JsXIiMnT0vhfQ/389Eatppl8Gz0UXoW+3DF76PF0M5LBZUmxqxGTj+cer5irRSN8Rx+1fFV3xYwYcm7OvbS6ZFEYCF6r/cb+Q99Wor3F9NUR2yc0x6RZYXPYfMsmfR5JJ+dtUWYzDj0b4K7EwzL7P5bLVII59llPM6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS0PR11MB7735.namprd11.prod.outlook.com (2603:10b6:8:dd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Thu, 6 Apr 2023 05:01:56 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%8]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 05:01:53 +0000
Date:   Thu, 6 Apr 2023 13:03:28 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     John Fastabend <john.fastabend@gmail.com>
CC:     Eric Dumazet <edumazet@google.com>, <linux-kernel@vger.kernel.org>,
        <ast@kernel.org>, <heng.su@intel.com>, <lkp@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <yi1.lai@intel.com>
Subject: Re: [Syzkaller & bisect] There is WARNING: refcount bug in
 sock_map_free in v6.3-rc1
Message-ID: <ZC5SoIRIFJpSpivX@xpf.sh.intel.com>
References: <ZAdMB+eGT3TQEo7y@xpf.sh.intel.com>
 <ZAdVvximUvRXcGZZ@xpf.sh.intel.com>
 <ZCvusEIauvO8BLM5@xpf.sh.intel.com>
 <CANn89iJjqTyev28kzEwBjoNafn_4Ku3ZijJxQ_+Tc93TaG3D=g@mail.gmail.com>
 <ZCwujl7qJPvMsHKv@xpf.sh.intel.com>
 <642dea024554c_1ab91208f4@john.notmuch>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <642dea024554c_1ab91208f4@john.notmuch>
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS0PR11MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb05afc-6487-4d0e-0736-08db365c09ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adqF8J7uL+Rq7nJffAhiCqZRS0T6Sz2eCxA6KBPR4+VpUP7J+g4osfakGR7/6j2CW9r/YubBIZ1y4iDbiSMoaHWwgz8rJo/jGjHhNNKkAfSJ6CbygujtG9hTOQfE0vmYxtM36WuYq5XDPMFasqnSvRkLl6E1/r1RQbGlwx2jBgf/T0iTpO3MQrpptNPfKuw/4k8dZ4+IEx/5STBbdbbsDx76rKXrHQf+uOB+fSRMkMoXeR9e05byCt1DqbuOcf5ztX9k5bwd4VayYgXO5FueQL0nEZ2bTjGC/mI7sxsFuGAmgRReq7pxupim5xTpFJp+AmCLYFGN8TTF8kcC6kdCpPUlmZ3Kxi181Ng3obRTCHyqD5A6K0//BeJ5z8zzLKNJlH3DV0CDR5862QngnVifsV7Lr5RZF+L0H07qwBJ0AlbjyK49BMhjC2qcy/Oi5y7zTEPmyD0XaYSe0hrPOBgXOC4pvYjiFk96aN4jx0Pj+09Iz1CGBTRUaWMMd19VFVd6NMhGEXRynCcNoruHPakfdEx5c7o5K2lltDL48MItqPZfwaxWbYKcKG65YGHOkmLc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199021)(66476007)(4326008)(8676002)(66946007)(478600001)(41300700001)(82960400001)(66556008)(316002)(44832011)(8936002)(5660300002)(38100700002)(6916009)(107886003)(53546011)(83380400001)(6666004)(186003)(6486002)(6506007)(26005)(6512007)(45080400002)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmxJYzM0eGZUWXlQVkFDL0oweEpaRjN0NkhCZktSYjNSdi9ickltZkNJaSty?=
 =?utf-8?B?UVpSTEJHZXEyYUo4QWx3VDBjK0QxRWViNkI5NU9ad29BWmZvQlg0TXNPZGlV?=
 =?utf-8?B?WGcvMzl2UEViSExreVpGZzZKeGdUcURzbm5Ta1FpOVNTMjEvbWxpT0JBN0Vl?=
 =?utf-8?B?dy92WjFham9RNDBiZVJRemw5WHVsVk5SMnE2M21HQWxacHErRWU2c3VLZ21J?=
 =?utf-8?B?TVV5WUFSYnhGQWJ0c0pYak40ZGw1TVZxZWRWQmRzQ1lSRFpHOHRlazhBZkl1?=
 =?utf-8?B?TlVmckgvSERJcVBJejhuZnpLVDF1TFhUc3ZPQUUzT2gwTnlaWFdiNDBQVmg0?=
 =?utf-8?B?anNyZXVSWGtaNUJ1YnBFWWlXN0FEZVFPc3BOeXF1cC9xZTZDalN3U2ZTb0FX?=
 =?utf-8?B?RDJwQWJOR2dqMmVGOThmemhUKzF6SUNwRmJlaVVDdlFPbVY3b0xCMjlXTG9y?=
 =?utf-8?B?Mm9XOE51RDg1S21BUXo2Y29JLzUrVHpYQ0ZlV1JGRmVKVVZzOHF1ZHBRakk4?=
 =?utf-8?B?QngxRDV5QWdaOWNsZHh3YlI0eGNMeTJrVzRuU0pFMHl5SWM0M2VDSGhhcFhE?=
 =?utf-8?B?RWpOYmI4M2k5bUR6NFM4WmtXaVBRUVZ0RUp5TWUwL1NOSERrRitkRDBXUVBI?=
 =?utf-8?B?S045TEdBTlZiT1NQeXprZmtxQVAva0x6L2dMc1ovcXVHS0xoM1Rra2I3b0lN?=
 =?utf-8?B?ZXJNZitjSmorVU1QaHdVZzBEREtXa0wzU1M0T0dITGduUCtRaG92T3NCWmdh?=
 =?utf-8?B?ZU9TNldFazhJUGYxVHYzSG5EVnJpaEpOMDlaemVSYjBqVGNPc09Tdlo3b3lU?=
 =?utf-8?B?QmsvRkY1d2diQWFCSFUvVGJmNnRzWTUxMDVOY1gwTmlpbTg5bHZTWDk4WEQr?=
 =?utf-8?B?UG5iLzNhWlRpMm1JaFp5L3RPRjM0MWlpY1pJQ1p4NWc3ZDhjOEExbnArWENm?=
 =?utf-8?B?ejl2b21wK25hY2t3Q2szUm9uNWduVk5Yam5ncmQxSzhCQVlyamNDaEIvL256?=
 =?utf-8?B?cmdIMmI4Wk1adTZEMmpTWkc0aWNTOXEyRCtNd0pNR1RnSkZVNWc1ak5pMDN5?=
 =?utf-8?B?SzlieklUTG9aZWRodmVnVnNyL1BMMHFJck1qbzhONldpeTBYUTM1aDJPMmx4?=
 =?utf-8?B?elpNRjVxQ3BJYitPejVBYlovRXRobzRKVFlhZmg0eXQ1Uy9zeFVQZ0RhaFlv?=
 =?utf-8?B?aE4yM0llaDB2N0xvWFBZVnNLT3lQcUYyWW12cjFKcnRmNzNvZ2ZUVmUxTVNi?=
 =?utf-8?B?ajJKYklUNjF5bnMxY0lNZ25MZ0RRR2lpdk5EZmNLUnpyN2F1SXk0OWtGWVVj?=
 =?utf-8?B?c0lqamlaUkdEelZ4aW1kT0lLdG5zUWd2L0I1eCtJaFIwbEx2RHQzdXprcnN5?=
 =?utf-8?B?eFJOYmdsQlllVkpUQ2Y3dk9LRS9tS0hJeXFBelNlM1VXZ044cGJpTTZmSktw?=
 =?utf-8?B?WGk0UlVkT1U2NkRGbVNsdXVOYW53WVBPUmxLbE45NEdMWUh6YjFuRHV4eUg1?=
 =?utf-8?B?Z0ZUdzVISlVlT1VCSms0b1QxMHRFMUROUVhwZEU4a1htUnozbzBUeHZyOTFt?=
 =?utf-8?B?eEMvQWNzdHluOHYxeExVZWxkVmptWXN2RkxIbFIvbzgyRnZnTGFDYUFkUDBv?=
 =?utf-8?B?a0NlUGt0ZnV6VXBTNEtPUWg3RmNLTjNCN0crTGNJckxCVFRnaUFqYW4wdk1R?=
 =?utf-8?B?S3ZadmwycVVsR21YcVpXdm9NNG1GU2h3Tk5IdHNoaHFsWkRubGhPQjFwV0FO?=
 =?utf-8?B?Sk5IbEt5WVBwYkt6b0xmNkE0d3lISHo4OE4vWDBjT01jUzFCWGZRdGlQZkZI?=
 =?utf-8?B?Nk0wV2ZrMnpMa2crT2xzbHpCWnQ1RWoxYVlTUjlWc0FNZXg5N3ZzS1R1Smlr?=
 =?utf-8?B?eFRndFNiSU9CdGtya3dLelBXallObEZYRXRLNlR5Zk5Ea0R4R1AvQmZNVHJr?=
 =?utf-8?B?akNSRldvZi8yclZhSUhmd1VLRkl6Q3BBMG5zWE1TRHJJWUdQNENXWUx6MUVa?=
 =?utf-8?B?aWsvZGw0SUkwQVRVSzEvTzFSVUpqSzVtaGZ6VFV5UzFpU1NNeHNtV044OUhi?=
 =?utf-8?B?aHV1dDhkR3FJQlZtWFhTMGJQVXUwRGJLTDM0NFRvUXlETmdXNXpYQk1wbGpm?=
 =?utf-8?Q?4ahcu7dHlxMpnO2lyV61fAdqS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb05afc-6487-4d0e-0736-08db365c09ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 05:01:53.6257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKATZpC9BCmr9VAx6EtnFCecBnhDLnvqcI9PRiWw1KKCGRnIi/RYmLMbJz0sTqXIsmsFWxCytKgmn7v1K4fUFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7735
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi John,

On 2023-04-05 at 14:37:06 -0700, John Fastabend wrote:
> Pengfei Xu wrote:
> > On 2023-04-04 at 11:43:36 +0200, Eric Dumazet wrote:
> > > On Tue, Apr 4, 2023 at 11:31 AM Pengfei Xu <pengfei.xu@intel.com> wrote:
> > > >
> > > > ++ GPIO and kself-test mailing list.
> > > >
> > > > Hi kernel experts,
> > > >
> > > > It's a soft remind.
> > > >
> > > > My colleague Lai Yi found that similar "refcount_t: underflow; use-after-free"
> > > > issue still existed in v6.3-rc5 kernel on x86 platforms.
> > > >
> > > > We could reproduce issue from kself-test: gpio-mockup.sh easily:
> > > > kernel/tools/testing/selftests/gpio/gpio-mockup.sh:
> > > >
> > > > "
> > > > [ 5781.338917] -----------[ cut here ]-----------
> > > > [ 5781.344192] refcount_t: underflow; use-after-free.
> > > > [ 5781.349666] WARNING: CPU: 250 PID: 82496 at lib/refcount.c:25 refcount_warn_saturate+0xbe/0x110
> > > > [ 5781.359550] Modules linked in: gpio_mockup isst_if_mmio isst_if_mbox_pci intel_th_sth stm_core intel_th_pti intel_th_pci intel_th_gth pmt_telemetry pmt_class intel_vsec intel_rapl_msr intel_rapl_common nfsv3 rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace bridge stp llc sunrpc intel_uncore_frequency intel_uncore_frequency_common i10nm_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp iTCO_wdt ofpart kvm_intel intel_pmc_bxt iTCO_vendor_support spi_nor mtd intel_sdsi kvm spdm irqbypass dax_hmem joydev asn1_encoder snd_pcm mei_me i2c_i801 spi_intel_pci isst_if_common idxd snd_timer intel_th i2c_smbus spi_intel mei i2c_ismt ipmi_ssif cxl_acpi ipmi_si cxl_core acpi_power_meter crc32c_intel i40e igb dca igc pinctrl_emmitsburg pinctrl_intel pwm_lpss fuse [last unloaded: isst_if_mmio]
> > > > [ 5781.438080] CPU: 250 PID: 82496 Comm: modprobe Not tainted 6.3.0-rc5 #1
> > > > [ 5781.449711] Hardware name: Intel Corporation, BIOS IFWI 03/12/2023
> > > > [ 5781.461615] RIP: 0010:refcount_warn_saturate+0xbe/0x110
> > > > [ 5781.467585] Code: 01 01 e8 75 56 8e ff 0f 0b c3 cc cc cc cc 80 3d 4c 67 ac 01 00 75 85 48 c7 c7 b0 31 cd a9 c6 05 3c 67 ac 01 01 e8 52 56 8e ff <0f> 0b c3 cc cc cc cc 80 3d 27 67 ac 01 00 0f 85 5e ff ff ff 48 c7
> > > > [ 5781.488761] RSP: 0018:ff45a7f44d39feb0 EFLAGS: 00010286
> > > > [ 5781.494745] RAX: 0000000000000000 RBX: ffffffffc0b36540 RCX: 0000000000000000
> > > > [ 5781.502871] RDX: 0000000000000002 RSI: ffffffffa9c065c8 RDI: 00000000ffffffff
> > > > [ 5781.510984] RBP: ff31c1afa78cb800 R08: 0000000000000001 R09: 0000000000000003
> > > > [ 5781.519100] R10: ff31c1b6fc000000 R11: ff31c1b6fc000000 R12: ff31c1afa78c4f40
> > > > [ 5781.527215] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > > > [ 5781.535337] FS: 00007f9bc705a740(0000) GS:ff31c1b700280000(0000) knlGS:0000000000000000
> > > > [ 5781.544529] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [ 5781.551063] CR2: 00007f9bc5e50dc0 CR3: 000000093b36c003 CR4: 0000000000f71ee0
> > > > [ 5781.559180] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > [ 5781.567307] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> > > > [ 5781.575413] PKRU: 55555554
> > > > [ 5781.578551] Call Trace:
> > > > [ 5781.581394] <TASK>
> > > > [ 5781.583868] gpio_mockup_exit+0x33/0x420 [gpio_mockup]
> > > > [ 5781.589756] __do_sys_delete_module.constprop.0+0x180/0x270
> > > > [ 5781.596112] ? syscall_trace_enter.constprop.0+0x17f/0x1b0
> > > > [ 5781.602354] do_syscall_64+0x43/0x90
> > > 
> > > I hear you but this trace has nothing to do with the bpf/sockmap commit ?
> > > 
> >    I just saw the same WARNING from kself-test: gpio-mockup.sh, maybe
> >    it's different issue, sorry.
> > "
> > refcount_t: underflow; use-after-free.
> > [ 5781.349666] WARNING: CPU: 250 PID: 82496 at lib/refcount.c:25
> > "
> 
> The  ./gpio-mockup.sh thing doesn't use sockmap at all right? I can't see
> why the bisec to that patch would happen off-hand.
> 
  Indeed, I double checked the suspected commit, and even revert the commit
  on top of v6.3-rc5 kernel,  above ./gpio-mockup.sh still trigger the
  "refcount_t: underflow; use-after-free." problem.

  So "gpio-mockup.sh triggered issue" is a different issue, if I find some
  more clue, I will report the gpio kself-test issue with another email.
  Sorry for inconvenience.

  Thanks!
  BR.
> > 
> >   Thanks!
> >   BR.
> >   -Pengfei
> > 
> > > My change looks correct, so your bisection might simply trigger because
> > > of a wider window for another bug to surface.
> > > 
> > > John, do you have an idea of what is going on here ?
> 
> No idea here.
