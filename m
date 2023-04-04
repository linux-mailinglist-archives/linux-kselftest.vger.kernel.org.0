Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782446D64CD
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 16:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbjDDOKG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 10:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbjDDOKE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 10:10:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45918116;
        Tue,  4 Apr 2023 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680617397; x=1712153397;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=L78+e0tJ5ruzos9E6wT4kZ3o5XjRiUNTl6iAt0Kgia8=;
  b=BdZwVW2HUVTE/4+ziJd8nBAH3Pubz1JpKAkT2M28sZCckzGeEvRt/tac
   irWffK6bXmc021zOpeQB/s78smEa1I97RZo4I8sy2Jadcs0KS0FhO7UUH
   eu2isaXtFNEceWQOpItXj8EyhYlxs1xDIH7XLKqsa0wwC3knpMFgttnnm
   iHDCzHI+cElHphYUFXM5f3j0BmxtzhTpNzIn0jNkqhxHnkplKmDUZmIWl
   yIfbloJEKGxb9FpL5dxx5vkF8AGOlskqibBPy0X5G5IXMD5KJ26p8A4Ng
   s2kEvBfBDQrx2kIc6b6IECwL7qhVbFxO20L0ir+eMlgMeyxpqs6WwdfVK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="344756936"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="344756936"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 07:03:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="755647975"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="755647975"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 04 Apr 2023 07:03:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 07:03:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 07:03:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 07:03:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 07:03:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9E/KY3rzJ6xMLQwXTLImyW1nsqtL7uzbPZce/edPAFjyn39bBTHzoiYnz3l0lLkfBjxmrcybSq7GOQ2RaoXwyKDM/1wB2xGaXH6iw1EZeZ4Pa64L5F2fxKr5yNe6LQR+qL/78jLU0cHJaCkhLqDQbWD+WnEITAgTI1itVSmhjFsDvsm+4y2oanGjmmo34spHnqdXHG0q6CLT9jurORxk0yvwyjR2+QMfJSmRtkMq4nNm9r1SO3eCMVVa+p9n+YuodxsqskRMbrA06L0US5kWaTov/NKDEVY3ULHpreWlNI1MhOA93XKxcsI/1FjeReakP8Wf4raW+rjA0XIJugJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmWQZMf7C89h3B4f7b74yWhJWJZKZ25QbRUI9mQkoos=;
 b=FoSX7IQJgHuzaVpABor89t2gdXeuLQ3MZ8HWHnx0PUpPggHtW1Ck7l4vC91b4tzkRt1CV72DG1VZtKnvNJvPWbftb1mg3slL6RdMwmamKwyzLDGLWCiiO6FJX9KHeLRgD52QVdcedbUmd/o69uQpunAefCg1N9Oa21FOBIy++ndlGJeQrJaBD4fDPxj+NAcUgdqoxXKTYyrwowOHc4aV5283Gl27Oxz5UHoYDcmisxNmdURzfKxU68LCaB4+JqrS+77CwZ2u9B309x5I7oVUhOKCLx5kwoclYk7tjHGAxEsLoGR0TNP5Iv10hsP+waExxsfJGDu3iLHGB9qzrSeTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by BN9PR11MB5546.namprd11.prod.outlook.com (2603:10b6:408:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 14:03:28 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%7]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 14:03:27 +0000
Date:   Tue, 4 Apr 2023 22:05:02 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Eric Dumazet <edumazet@google.com>
CC:     <linux-kernel@vger.kernel.org>, <ast@kernel.org>,
        <john.fastabend@gmail.com>, <heng.su@intel.com>, <lkp@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <yi1.lai@intel.com>
Subject: Re: [Syzkaller & bisect] There is WARNING: refcount bug in
 sock_map_free in v6.3-rc1
Message-ID: <ZCwujl7qJPvMsHKv@xpf.sh.intel.com>
References: <ZAdMB+eGT3TQEo7y@xpf.sh.intel.com>
 <ZAdVvximUvRXcGZZ@xpf.sh.intel.com>
 <ZCvusEIauvO8BLM5@xpf.sh.intel.com>
 <CANn89iJjqTyev28kzEwBjoNafn_4Ku3ZijJxQ_+Tc93TaG3D=g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJjqTyev28kzEwBjoNafn_4Ku3ZijJxQ_+Tc93TaG3D=g@mail.gmail.com>
X-ClientProxiedBy: SGBP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::13)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|BN9PR11MB5546:EE_
X-MS-Office365-Filtering-Correlation-Id: 55fd385b-9348-4887-406d-08db35155cfb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icguLl8kVQyW7tnhnALsz8rpp1XDxOWnpDofupllnSBVY0gQMW+cAwxe70i0B34B67SxiaxjbIJWzMcN4KptbBK9heclTCmCKzRbH9KUSpma0zDx+0RhHEFY0x/72XFgc2SuepzIJ1p1hL8GhEQs6o0gsud8RAdi9oQ0Q6RN06STHKq5NZ4bdJpqC7uCPR0038Qoi+oKluXPO+044Owq1KUh247ML6tjMZ0vXmj13wENFVtKrtsXtSyiIBftFLJnmmdGWSFr/jg6ScGJBPEigMuRjyzIN7ysfio60aMPH3OX5+gnxFhINpBTLQkCmKqsy5J1mvWniv3N1GDQ0UJu9+VAL0W8rrsPf+jCSXFF6mNlnBVHPyLZ8Ujt2ZZmW1b0VLToCrBLWwnmUqfZi22dC+kCeVsMycnolfuWmEqaA6/wNzOPSEtVzDw3DLnnzzHeb+rzfRkULuna0AWz0Bx1k52KYUTvUFFhnSI5t1a+z4TTJMvogPXewIqPmYrGg+hkvU8JWV4vx6cOHWRqhrXIhjxZvxalj8PHcC6F6BKRBe9Nd8UCJ+tbyzzj1GfXGbs4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199021)(66556008)(316002)(478600001)(45080400002)(66946007)(66476007)(8676002)(6916009)(107886003)(6486002)(6666004)(4326008)(38100700002)(2906002)(8936002)(41300700001)(44832011)(5660300002)(82960400001)(86362001)(6506007)(6512007)(53546011)(26005)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1YxcFNhUFRKK3pwVmZrM3gxb0UwTUJ5YVQwTGNLeXVEc3NrbjZ3ZkFpVzAx?=
 =?utf-8?B?WVFvWCt2b3VwOXlxMFFOazJQRDVLY21QV0JmUHpRbWIvS25xa1A1ZndiekFt?=
 =?utf-8?B?YmZBSDJaSUI1ZDRtbm1MRXJpZXJ4K1Q1YTdHNEJIbU1GY3RNaG05Y1NDY0Mw?=
 =?utf-8?B?aUpwWUNsY1pNNVNtdWlWdnRtaHU1dWlnSTdxaEtkSTdWdlNNTmpPOEVuZjll?=
 =?utf-8?B?YWRjV2NDcm9QelhBb1EyQ013TVVXWnJZcGZnZXZrV2VVVmxKNmZaTWpPdjlB?=
 =?utf-8?B?ZTg2NzFVNmtPY2lCZmFQdnFoRURMSlo3VVVyRTk2RFh1dmpZRVFJZGZJZFBI?=
 =?utf-8?B?NXUzQldDL2hhYnF6RGlLYUFmTndDNnduZDJQR0dkUU4vYVFOQm9XUS9YMVk4?=
 =?utf-8?B?S2EyWWZMRVdmSmdzdlk0eklqZGlLZVpIWmRyckFqd2hDcUdlNEJlQU4wSjhm?=
 =?utf-8?B?ZWVNVDRqMVBUN2dwN0FYQkxjQVExdGtyMVBsRFFzamg1Qm40eVU3NUpxYUhw?=
 =?utf-8?B?V3JJV01pdFVUT0ExYzhXZVpuOUxqVi9zMlVtb3IvUkR2bGxFY2xlTkZLbC9O?=
 =?utf-8?B?VlR0OGRBNTN1dURUNm8vM3cvOHFwdjBKNlM3aFZGTGZkbm81ZERkZGl0R2Q2?=
 =?utf-8?B?U1FiU2dTZVYwZUdNSXNnTUI4VmRYeU8xVzdlTVB5bzJVM2hKWFR4ekdvaEdX?=
 =?utf-8?B?bmNHOXNobTBtTkhMK1pPMVpnNmJLK0JqdnVxQi9EeldvL2RNeU5wc002L0Zw?=
 =?utf-8?B?NTFBdTZBS0hYejRHWi9HM3pYMndmQktDb2hmZzU0Z3p5d3FIeWwvczVWK0Mx?=
 =?utf-8?B?RlZXME1MV2V0YXpMbDEwYzR0SVlJSXpzOGlib2tsdGU1bkZqcTVUVUJ4bi9z?=
 =?utf-8?B?RENOOTZjTk9sNmMrQnord0hMOTFQU3BqMFVycFJ1Z2E1VEs2OFRZeEdWMHpX?=
 =?utf-8?B?NGx3MXZLa1VoZEMzdjhQSlRvMGIvUDJnZ3AxS1dPMW5EZXpET2xGRVhvaTRz?=
 =?utf-8?B?VXFMdHhLSFRNQ01iS3N3U0hUY2dFQ0RmQ1c4Szl4VGlkUlo3U1NiWXFRMkZQ?=
 =?utf-8?B?YjdMQkdjVjRMZWZPZktCOGt6USt3cXFqREd3VHRrMmhWc2I2SXFxS09reXJp?=
 =?utf-8?B?ZW91byt1SlJmME1VOVAvRjFqdWpCck94Q0lhT2F4TjFHVEdUcGY2c3NQVHg1?=
 =?utf-8?B?Rml4VGs3TFhtTUZldEx6NVFOUEdIZ0cycis2bnBJd0FzeW1RMXFoYUVMNENp?=
 =?utf-8?B?K1hONFRzU1BzWDZhbVJMN3hrZm81YmFzanFFd1o5SDluSVJ2VnhETUM0Zm5P?=
 =?utf-8?B?dm5xTE03ZFZZRDU3TU8yZDJDblJUNnNRRTU4UGpNclJmTnJBVjZhRzhlS3RT?=
 =?utf-8?B?MnpFTnFHdG9PenlmdlpvZzl4cVlTa0dobHdUcmw1cnIwaFZlNmFsNkIwSGVU?=
 =?utf-8?B?dnZid1dvMVY5ZEZhZ1Y2VGx6M2plZUVrdmRyZ1FXQWN6L0QrV2ZWT0VBNUt0?=
 =?utf-8?B?Z0FCT3d6YVZuWmxrSUxROEsrTWFZZzRZS2Q1aGxwWityZUVFUWkwS0VxdENU?=
 =?utf-8?B?R3d2R0taVVQxMnRjSXBUZ3BNaEQ2ekhoSWFkdG9yMkRNUnB5MnRwRldIQ0VO?=
 =?utf-8?B?Y3c1dG1QTFIza3h0UU5wRGJad3RnYTZQOEUybStNeEcrY29wT2RWTmRqbGo1?=
 =?utf-8?B?blFkSVpCVHRuamU3SURld1R2MHJJbEdUd0ZvczJMM2tNWU93VXIvTkhYT0Vx?=
 =?utf-8?B?ZkNiQWpGYUdyYldLNnhvZmp3eC80WlBNT3hSNjFkNWFYbWRxNU5aTHRWV0ZN?=
 =?utf-8?B?cW0rdHV4OHorMFdWTXFnZDl1UnhpeUp4bkRFSUtGMnFEaVNrVzZTNjhRUlo0?=
 =?utf-8?B?S2hmcjdka0YrS1ZEcEEzaXVVSk53ZGtxU3JPMDdkM0VpSVRuQjcyVDBWMnp3?=
 =?utf-8?B?ZmxYZkZEVjNKWEhZQ0tqVDdlUkhwZzNnUTJhdWREMnFuUnNrK29NL0FCSm85?=
 =?utf-8?B?OHB3ZG9MR1VVYUx6WXdEcFRjbXJPeUlGcEU2R05Db2dnM1BsNlMzcTlSZEoy?=
 =?utf-8?B?bFBFTGd3cHlhdFJQT2tvS3QrajE2cjc5VGJnN0wrOFdOY1NDOXFSV1hnSVVQ?=
 =?utf-8?Q?xxMvEmmHinZWSqflTm5V6lbBt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fd385b-9348-4887-406d-08db35155cfb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:03:27.5498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4AsdJWes91iCN9Kd+rkLvxQQK1U5yAHcIUH3EsEsoVYB+1kr80I7eKdfdO/IIuPlCRBtF1Fv9VPJMI+DdDt1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5546
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-04-04 at 11:43:36 +0200, Eric Dumazet wrote:
> On Tue, Apr 4, 2023 at 11:31 AM Pengfei Xu <pengfei.xu@intel.com> wrote:
> >
> > ++ GPIO and kself-test mailing list.
> >
> > Hi kernel experts,
> >
> > It's a soft remind.
> >
> > My colleague Lai Yi found that similar "refcount_t: underflow; use-after-free"
> > issue still existed in v6.3-rc5 kernel on x86 platforms.
> >
> > We could reproduce issue from kself-test: gpio-mockup.sh easily:
> > kernel/tools/testing/selftests/gpio/gpio-mockup.sh:
> >
> > "
> > [ 5781.338917] -----------[ cut here ]-----------
> > [ 5781.344192] refcount_t: underflow; use-after-free.
> > [ 5781.349666] WARNING: CPU: 250 PID: 82496 at lib/refcount.c:25 refcount_warn_saturate+0xbe/0x110
> > [ 5781.359550] Modules linked in: gpio_mockup isst_if_mmio isst_if_mbox_pci intel_th_sth stm_core intel_th_pti intel_th_pci intel_th_gth pmt_telemetry pmt_class intel_vsec intel_rapl_msr intel_rapl_common nfsv3 rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace bridge stp llc sunrpc intel_uncore_frequency intel_uncore_frequency_common i10nm_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp iTCO_wdt ofpart kvm_intel intel_pmc_bxt iTCO_vendor_support spi_nor mtd intel_sdsi kvm spdm irqbypass dax_hmem joydev asn1_encoder snd_pcm mei_me i2c_i801 spi_intel_pci isst_if_common idxd snd_timer intel_th i2c_smbus spi_intel mei i2c_ismt ipmi_ssif cxl_acpi ipmi_si cxl_core acpi_power_meter crc32c_intel i40e igb dca igc pinctrl_emmitsburg pinctrl_intel pwm_lpss fuse [last unloaded: isst_if_mmio]
> > [ 5781.438080] CPU: 250 PID: 82496 Comm: modprobe Not tainted 6.3.0-rc5 #1
> > [ 5781.449711] Hardware name: Intel Corporation, BIOS IFWI 03/12/2023
> > [ 5781.461615] RIP: 0010:refcount_warn_saturate+0xbe/0x110
> > [ 5781.467585] Code: 01 01 e8 75 56 8e ff 0f 0b c3 cc cc cc cc 80 3d 4c 67 ac 01 00 75 85 48 c7 c7 b0 31 cd a9 c6 05 3c 67 ac 01 01 e8 52 56 8e ff <0f> 0b c3 cc cc cc cc 80 3d 27 67 ac 01 00 0f 85 5e ff ff ff 48 c7
> > [ 5781.488761] RSP: 0018:ff45a7f44d39feb0 EFLAGS: 00010286
> > [ 5781.494745] RAX: 0000000000000000 RBX: ffffffffc0b36540 RCX: 0000000000000000
> > [ 5781.502871] RDX: 0000000000000002 RSI: ffffffffa9c065c8 RDI: 00000000ffffffff
> > [ 5781.510984] RBP: ff31c1afa78cb800 R08: 0000000000000001 R09: 0000000000000003
> > [ 5781.519100] R10: ff31c1b6fc000000 R11: ff31c1b6fc000000 R12: ff31c1afa78c4f40
> > [ 5781.527215] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [ 5781.535337] FS: 00007f9bc705a740(0000) GS:ff31c1b700280000(0000) knlGS:0000000000000000
> > [ 5781.544529] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 5781.551063] CR2: 00007f9bc5e50dc0 CR3: 000000093b36c003 CR4: 0000000000f71ee0
> > [ 5781.559180] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [ 5781.567307] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> > [ 5781.575413] PKRU: 55555554
> > [ 5781.578551] Call Trace:
> > [ 5781.581394] <TASK>
> > [ 5781.583868] gpio_mockup_exit+0x33/0x420 [gpio_mockup]
> > [ 5781.589756] __do_sys_delete_module.constprop.0+0x180/0x270
> > [ 5781.596112] ? syscall_trace_enter.constprop.0+0x17f/0x1b0
> > [ 5781.602354] do_syscall_64+0x43/0x90
> 
> I hear you but this trace has nothing to do with the bpf/sockmap commit ?
> 
   I just saw the same WARNING from kself-test: gpio-mockup.sh, maybe
   it's different issue, sorry.
"
refcount_t: underflow; use-after-free.
[ 5781.349666] WARNING: CPU: 250 PID: 82496 at lib/refcount.c:25
"

  Thanks!
  BR.
  -Pengfei

> My change looks correct, so your bisection might simply trigger because
> of a wider window for another bug to surface.
> 
> John, do you have an idea of what is going on here ?
