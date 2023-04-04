Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A226D5BED
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 11:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjDDJbK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbjDDJbJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 05:31:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3541BEF;
        Tue,  4 Apr 2023 02:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680600665; x=1712136665;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=cqFxUOgOhPUAC/nu92/t69/qlO5kwHZW1igxlOOdGn0=;
  b=JbFoXWFTQxU+8ardoNg2pAn4ozApK9bwq2XJT7EfIWAxA3at0J43J+dj
   2dG8q9/2ttfTT1UJEsWZsf7ZYub69tAwPVv/O091N+QQ1WgB69gaEqYa2
   bjIXuQEoO3YIPyIOr8VeaNhjSXvFq75v+gzhsdAyySUcmcVtL49vJX2eO
   eDrkiT6NFbJsHYcbsJ/R0PbjqpaMFhPG41HtNhSGexYGVlX6J8iV0urDH
   vAnfXXaLQMQuoKvVqOMwWfbQrQi4MNj1wfxTNLIRimAIxXwaSLzO2YXA6
   H1G7oc3nQ8KAAVYFmE1/MrtKE8NaMjvlurJmlhiDtpzQkt9ngokd80zEo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="342159052"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="342159052"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:31:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="679826901"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="679826901"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 04 Apr 2023 02:31:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:31:04 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:31:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 02:31:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 02:31:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYw2k1iwIKbJMjOJBIR3Vg8HbU1Oj9JvsKCQ+VMSK3X/0a7/AHKLmyZegRbOWTg5Q+CxtpC5C9i/FkhUPervFMhXIPI0eEOz2qVGZx1xWXunxubcjjyjtfGkauYduBW7hNbD7zdxnnI2t8BHfeTOOmdWy6239lBi4CD1OGAYWkOaaz1IJlxVUZIZdwWLZ/kR4LkSkryq7hKWVV5kQSzVhayznmBt/On6DQQtLwM9sPyJtboBYGs5cB9kFjAWA93qNqp3jdtg0k9s1CryERaQnV4Dk3M9QP+aIbZlvbEG4Xd/owOdXA2GBLFEeLhfHhMH65CG3xOL/yRgkE0VCaAq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZD2XTI9/U6FFaJha5qpDKh7c6pUTr/gCtFh40ecNsY=;
 b=hbo+XJJ7fYsW8ObeWdAJyDcpDFMYiJyzKtIcCYENO/a8RrDV5c2ITLCmSe0QEmOoiQ90Oo1t9/Y6wv5dzslpMhf9tJrj8W+TPzVdRoNKdKF6BDy70w2dUdeRHdwpDLTRiQoG0wwwzmxLcq866lttsREWB2up8qYqEldL3A0gzVgKtBIGmPICa8jkbXAKdcYgR1EhlONBx7nYbupseYtfIhusO9qL0ZI3GuRt750FRhb0LCE/aBXb1VZGFzKX+mbgXY7cjSNa7fUFaLJnxT7HpPgqadgQ70SSwZ1O3xo2SZM69eEBb95IPb+xE59G2wTo7T522E3xgodj2XX1hSHrig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SN7PR11MB7511.namprd11.prod.outlook.com (2603:10b6:806:347::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 09:31:00 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%7]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 09:31:00 +0000
Date:   Tue, 4 Apr 2023 17:32:32 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <edumazet@google.com>
CC:     <linux-kernel@vger.kernel.org>, <ast@kernel.org>,
        <john.fastabend@gmail.com>, <heng.su@intel.com>, <lkp@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <yi1.lai@intel.com>
Subject: Re: [Syzkaller & bisect] There is WARNING: refcount bug in
 sock_map_free in v6.3-rc1
Message-ID: <ZCvusEIauvO8BLM5@xpf.sh.intel.com>
References: <ZAdMB+eGT3TQEo7y@xpf.sh.intel.com>
 <ZAdVvximUvRXcGZZ@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZAdVvximUvRXcGZZ@xpf.sh.intel.com>
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SN7PR11MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 848e2f32-b8ef-47b7-47fc-08db34ef4d25
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2Wrrf5gQecBCVW/WtIKM+uJaI0McYQQWppAsXi2vBHCqEC/J1sj3ClEP3yOsPAAuzF8wwqBDy0A+xocJYdU58Jlc23K9xSsclYorQCXICYtIyJpSKgISCbPR5qsan4kiHav8j8cPKJou89jisMT5XcTII9dzK92ioF//Duwo/biRFjJI/Htw/GGfL1KGcyd69AnDiDeTCjO0nz337hgweTbnhZqAPAi3iUWpGoEy86BYaWBCN2BOD69AX6lxARdrt1aEEDRXVQKShV5Rd9PKP2S1lGy2JBnixpOTCFufKQGQm8LsBqms15j2YT5y9mQ1TyFcer7DnGXrRBfiWJWlIGpTnlZmYA90+2gJ/dWCVMKhQszhXhHABzJ9cEvLV37qSpKOYJv2DiPz9Q7TKpR2b5CV2DmA56SjC3pXtDhQ74m+tIgW36MbzUpyvg5OaIGCAtMxz0pyeMlP7F2iD/z195wUSeRiH9A3pA/kJmcIWQR9O6D1PfhT3BHxP51S2eYSIyl0iyBCc6jv2PWT66gFOUHwXWbw/t738vzizollfC6NAMds2GOvpx2jNQBdQxIPB065rUQdnQ/d0Pu64H+bciwX61admb0NyylL7EAmiZlsi0vczf/CMKNLkOcuyjZE9cHFBAFKfN1y6RCgtFrhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(83380400001)(4326008)(966005)(186003)(45080400002)(6486002)(6666004)(478600001)(316002)(107886003)(2906002)(6512007)(53546011)(26005)(30864003)(6506007)(44832011)(5660300002)(38100700002)(82960400001)(66556008)(6916009)(66946007)(66476007)(41300700001)(86362001)(8936002)(8676002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D9xKy8HpWbLEHDLxdM/u45rw9EVquZk2e2c/vHW334RLdUNf+T9ffGOOZwom?=
 =?us-ascii?Q?zRg0QXIPSY/M88+Y2XUZvk5f+pX0t/Wm9LyQxTl/lTrz1+PKJYyWROXTZOri?=
 =?us-ascii?Q?lqHJ1nLEydleEqgVuGDAD7+KzEtWla8LImEuOIvoQ/ku16QJ9GzDg/sN6DO9?=
 =?us-ascii?Q?Fj2xC2nHO7eOfuxRojtNO/QKIuJ22RKWUnh+FlL6e5CKoSqid2ynKmwzdG6K?=
 =?us-ascii?Q?YPJLmrG3ZVpG4+TlLh6Pc6li3Zf/+gV5o0lHIaa5mW/jycn8KMdj2eIMiQgr?=
 =?us-ascii?Q?v9FWyDL5bqFnR6xeMsK04yGa7ijmVWWiTTR/W/165mG4y4E1OP5pmfwMbM8o?=
 =?us-ascii?Q?w6a0Lgoi1txNiTC3ERPO+iDxTcy9emdZX+YiK13ycs0uAc+O9pNTaIdPjvoN?=
 =?us-ascii?Q?k0FYma/Q+7UAdZJ0MVuID0tI8FVsrrBO65MuDJIRH+StTTP3qQ4QKPUEfKin?=
 =?us-ascii?Q?+HPCoFHaMrxWYAogM4CXq6srzvCJ1INeRGaaCSfquB3+5aQvi5hN1KALDzfd?=
 =?us-ascii?Q?xwBc0A+TB4NKnnoVxJ+J/SBdF5QhUJueg8SKoIKo6QqQem2QZ3B8m0g7H5TY?=
 =?us-ascii?Q?qyFEQS0VQUYB6GhOb4QYjaAmL/lvVnnBHX5hHjbUQ44RnfkDEObaLi3GcaqO?=
 =?us-ascii?Q?2hMVsXF8JYEUnhDgmGwWRT5vZNjj89GL6UboiMd39+58jpiGOSXpmBxFXKkk?=
 =?us-ascii?Q?9cFW+LrsabV4CbzUtH+w/s8WX3gYF7SGyi+cUqNBX+Q44zJuXCav6drRwlHx?=
 =?us-ascii?Q?kvIeDpqEnaHaj77d677K09OiUXOD1dB2XtFSSBjci/HEyjUHSOq5XGKnb5W0?=
 =?us-ascii?Q?p5WBGikKgrjZYwuDzqBkHX5MkAcnaypZWpMqJ2GFhQt4awDly6aANSxpltB+?=
 =?us-ascii?Q?gaxHMc/NJwjg1jfGUdOVzHAtpKaCOWzQTHnu5XCUunKGMySo7Y5iAbnjnQ9+?=
 =?us-ascii?Q?f08NNKbgEM8HC5ZcGulK19Paam/Ri8PdYq0JXV9/DdYFnoxlWn8XOnOH6utI?=
 =?us-ascii?Q?ZnQ36BbYWi7Qn/VUTPyDFLZqdwT4FyPnL1b/r0lRpf7+2YSknTEk2WAklu3R?=
 =?us-ascii?Q?3E0r2NrIMSVZqcH5GrEAWmE6jlQqld0UQCxeggf/fTnctXW48n9bYnyqdeVJ?=
 =?us-ascii?Q?H5n1u/WZ5QLsOdj0rrttQq4j24tYUTfOFB3wJEIkVPOSpAUCtNbFYjXFpA2b?=
 =?us-ascii?Q?FTRnmt/StQgbhuy4ueD3yQ1G/RjPlsp8BukxIKgVjK7hG+9MpqDaQrj3PfCr?=
 =?us-ascii?Q?/P3ukqzRQBNVvSW3qjnArnPw2JMzoIe09NvS0lKygDGqnPBvOVMWm5HFzSQs?=
 =?us-ascii?Q?UijpdLHqg3mrTojS54MojFF0ty/VlFpIG3GipONJhdweGTKgFLKyIYAW70Wp?=
 =?us-ascii?Q?XIw1NCM83EoBP3bbtotaSU1HnmE3MasXse+az4taI0JSRIvHpPDKnx+xiHVB?=
 =?us-ascii?Q?YFuNFcQISddBL4mh8mL3R56xkVIhnXLfQ5hCfUrUDKJsZ0BlLK1hz8khSCQ+?=
 =?us-ascii?Q?z4Ft37kbpSR6lzEZOnoehCZ5buAQOl3+u9PP6aA016AMR5gEC9NlmKvPddoW?=
 =?us-ascii?Q?HRX1btmuoZGoFou7pcGxFwGU3HgCbSFX9kC+KqAK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 848e2f32-b8ef-47b7-47fc-08db34ef4d25
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 09:31:00.1437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1ZxseGn6rYfPqAcyET80UGKK9HsBFAFcquGZVD+9tyJvSPjnA3LU5Aaqo3W7TiDQGDPFdZoDbGKtrp3XCvxCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7511
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

++ GPIO and kself-test mailing list.

Hi kernel experts,

It's a soft remind.

My colleague Lai Yi found that similar "refcount_t: underflow; use-after-fr=
ee"
issue still existed in v6.3-rc5 kernel on x86 platforms.

We could reproduce issue from kself-test: gpio-mockup.sh easily:
kernel/tools/testing/selftests/gpio/gpio-mockup.sh:

"
[ 5781.338917] -----------[ cut here ]-----------
[ 5781.344192] refcount_t: underflow; use-after-free.
[ 5781.349666] WARNING: CPU: 250 PID: 82496 at lib/refcount.c:25 refcount_w=
arn_saturate+0xbe/0x110
[ 5781.359550] Modules linked in: gpio_mockup isst_if_mmio isst_if_mbox_pci=
 intel_th_sth stm_core intel_th_pti intel_th_pci intel_th_gth pmt_telemetry=
 pmt_class intel_vsec intel_rapl_msr intel_rapl_common nfsv3 rpcsec_gss_krb=
5 auth_rpcgss nfsv4 nfs lockd grace bridge stp llc sunrpc intel_uncore_freq=
uency intel_uncore_frequency_common i10nm_edac nfit x86_pkg_temp_thermal in=
tel_powerclamp coretemp iTCO_wdt ofpart kvm_intel intel_pmc_bxt iTCO_vendor=
_support spi_nor mtd intel_sdsi kvm spdm irqbypass dax_hmem joydev asn1_enc=
oder snd_pcm mei_me i2c_i801 spi_intel_pci isst_if_common idxd snd_timer in=
tel_th i2c_smbus spi_intel mei i2c_ismt ipmi_ssif cxl_acpi ipmi_si cxl_core=
 acpi_power_meter crc32c_intel i40e igb dca igc pinctrl_emmitsburg pinctrl_=
intel pwm_lpss fuse [last unloaded: isst_if_mmio]
[ 5781.438080] CPU: 250 PID: 82496 Comm: modprobe Not tainted 6.3.0-rc5 #1
[ 5781.449711] Hardware name: Intel Corporation, BIOS IFWI 03/12/2023
[ 5781.461615] RIP: 0010:refcount_warn_saturate+0xbe/0x110
[ 5781.467585] Code: 01 01 e8 75 56 8e ff 0f 0b c3 cc cc cc cc 80 3d 4c 67 =
ac 01 00 75 85 48 c7 c7 b0 31 cd a9 c6 05 3c 67 ac 01 01 e8 52 56 8e ff <0f=
> 0b c3 cc cc cc cc 80 3d 27 67 ac 01 00 0f 85 5e ff ff ff 48 c7
[ 5781.488761] RSP: 0018:ff45a7f44d39feb0 EFLAGS: 00010286
[ 5781.494745] RAX: 0000000000000000 RBX: ffffffffc0b36540 RCX: 00000000000=
00000
[ 5781.502871] RDX: 0000000000000002 RSI: ffffffffa9c065c8 RDI: 00000000fff=
fffff
[ 5781.510984] RBP: ff31c1afa78cb800 R08: 0000000000000001 R09: 00000000000=
00003
[ 5781.519100] R10: ff31c1b6fc000000 R11: ff31c1b6fc000000 R12: ff31c1afa78=
c4f40
[ 5781.527215] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[ 5781.535337] FS: 00007f9bc705a740(0000) GS:ff31c1b700280000(0000) knlGS:0=
000000000000000
[ 5781.544529] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5781.551063] CR2: 00007f9bc5e50dc0 CR3: 000000093b36c003 CR4: 0000000000f=
71ee0
[ 5781.559180] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 5781.567307] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 00000000000=
00400
[ 5781.575413] PKRU: 55555554
[ 5781.578551] Call Trace:
[ 5781.581394] <TASK>
[ 5781.583868] gpio_mockup_exit+0x33/0x420 [gpio_mockup]
[ 5781.589756] __do_sys_delete_module.constprop.0+0x180/0x270
[ 5781.596112] ? syscall_trace_enter.constprop.0+0x17f/0x1b0
[ 5781.602354] do_syscall_64+0x43/0x90
[ 5781.606488] entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 5781.612274] RIP: 0033:0x7f9bc5f2ff7b
[ 5781.616376] Code: 73 01 c3 48 8b 0d 15 8f 0c 00 f7 d8 64 89 01 48 83 c8 =
ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 8e 0c 00 f7 d8 64 89 01 48
[ 5781.637543] RSP: 002b:00007ffcac9c5e48 EFLAGS: 00000206 ORIG_RAX: 000000=
00000000b0
[ 5781.646146] RAX: ffffffffffffffda RBX: 0000557113827e40 RCX: 00007f9bc5f=
2ff7b
[ 5781.654267] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005571138=
27ea8
[ 5781.662382] RBP: 0000557113827ea8 R08: 00007ffcac9c4df1 R09: 00000000000=
00000
[ 5781.670491] R10: 00007f9bc5faeae0 R11: 0000000000000206 R12: 00000000000=
00000
[ 5781.678601] R13: 0000000000000000 R14: 0000557113827ea8 R15: 00000000000=
00000
[ 5781.686770] </TASK>
[ 5781.689343] --[ end trace 0000000000000000 ]--
"

And we could reproduce reproduce this issue as follow way also in vm:
https://github.com/xupengfe/syzkaller_logs/blob/main/230306_123510_sock_map=
_free/repro.c
I newly updated the syzkaller analysis repro.status repro.prog info in all
detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230306_=
123510_sock_map_free

Bisected and suspected bad commit is:
"
0a182f8d6074
bpf. sockmap: fix race in sock_map_free()
"

I hope the info is helpful.

Thanks!
BR.
-Pengfei

On 2023-03-07 at 23:18:23 +0800, Pengfei Xu wrote:
> Sorry to update the missed reproduced code from syzkaller:
> https://github.com/xupengfe/syzkaller_logs/blob/main/230306_123510_sock_m=
ap_free/repro.c
>=20
> Thanks!
> BR.
>=20
> On 2023-03-07 at 22:36:55 +0800, Pengfei Xu wrote:
> > Hi Eric Dumazet,
> >=20
> > Greeting!
> >=20
> > Platform: x86 platform
> > All detailed log link: https://github.com/xupengfe/syzkaller_logs/tree/=
main/230306_123510_sock_map_free
> > v6.3-rc1 problem dmesg: https://github.com/xupengfe/syzkaller_logs/blob=
/main/230306_123510_sock_map_free/v6.3-rc1_problem_dmesg.log
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/23030=
6_123510_sock_map_free/bisect_info.log
> > Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230306_12=
3510_sock_map_free/bisect_info.log
> >=20
> > There is WARNING: refcount bug in sock_map_free in v6.3-rc1 kernel.
> >=20
> >=20
> > [   58.955232] ------------[ cut here ]------------
> > [   58.955976] refcount_t: addition on 0; use-after-free.
> > [   58.956752] WARNING: CPU: 0 PID: 9 at lib/refcount.c:25 refcount_war=
n_saturate+0xe6/0x1c0
> > [   58.957846] Modules linked in:
> > [   58.958278] CPU: 0 PID: 9 Comm: kworker/u4:0 Not tainted 6.3.0-rc1-f=
e15c26ee26e+ #1
> > [   58.959340] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [   58.960854] Workqueue: events_unbound bpf_map_free_deferred
> > [   58.961630] RIP: 0010:refcount_warn_saturate+0xe6/0x1c0
> > [   58.962344] Code: 1d b8 c2 43 02 31 ff 89 de e8 c6 ab 52 ff 84 db 75=
 97 e8 5d aa 52 ff 48 c7 c7 d8 b6 be 83 c6 05 98 c2 43 02 01 e8 1a 55 36 ff=
 <0f> 0b e9 78 9
> > [   58.964836] RSP: 0018:ffffc90000053da0 EFLAGS: 00010286
> > [   58.965582] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fffffff=
f8111b6fb
> > [   58.966570] RDX: 0000000000000000 RSI: ffff888007372340 RDI: 0000000=
000000002
> > [   58.967569] RBP: ffffc90000053db0 R08: 0000000000000000 R09: 0000000=
000000001
> > [   58.968547] R10: 0000000000000000 R11: 0000000000000001 R12: ffff888=
00ec16200
> > [   58.969532] R13: 0000000000000000 R14: ffff888015808000 R15: ffff888=
00ed6fc00
> > [   58.970500] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) kn=
lGS:0000000000000000
> > [   58.971647] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   58.972447] CR2: 0000000020000000 CR3: 0000000003e3a006 CR4: 0000000=
000770ef0
> > [   58.973461] PKRU: 55555554
> > [   58.973851] Call Trace:
> > [   58.974206]  <TASK>
> > [   58.974520]  sock_map_free+0x387/0x390
> > [   58.975077]  bpf_map_free_deferred+0x124/0x2d0
> > [   58.975753]  process_one_work+0x3b1/0x9e0
> > [   58.976350]  worker_thread+0x52/0x660
> > [   58.976895]  ? __pfx_worker_thread+0x10/0x10
> > [   58.977514]  kthread+0x161/0x1a0
> > [   58.977994]  ? __pfx_kthread+0x10/0x10
> > [   58.978529]  ret_from_fork+0x29/0x50
> > [   58.979073]  </TASK>
> > [   58.979448] irq event stamp: 25237
> > [   58.979940] hardirqs last  enabled at (25245): [<ffffffff811eac21>] =
__up_console_sem+0x91/0xb0
> > [   58.981151] hardirqs last disabled at (25252): [<ffffffff811eac06>] =
__up_console_sem+0x76/0xb0
> > [   58.982466] softirqs last  enabled at (25234): [<ffffffff83023a3c>] =
__do_softirq+0x31c/0x49c
> > [   58.983769] softirqs last disabled at (25229): [<ffffffff8112b5a4>] =
irq_exit_rcu+0xc4/0x100
> > [   58.985055] ---[ end trace 0000000000000000 ]---
> > [   58.985813] ------------[ cut here ]------------
> > [   58.986530] refcount_t: underflow; use-after-free.
> > [   58.987460] WARNING: CPU: 0 PID: 9 at lib/refcount.c:28 refcount_war=
n_saturate+0x15e/0x1c0
> > [   58.988714] Modules linked in:
> > [   58.989207] CPU: 0 PID: 9 Comm: kworker/u4:0 Tainted: G        W    =
      6.3.0-rc1-fe15c26ee26e+ #1
> > [   58.990565] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [   58.992351] Workqueue: events_unbound bpf_map_free_deferred
> > [   58.993213] RIP: 0010:refcount_warn_saturate+0x15e/0x1c0
> > [   58.994119] Code: 02 31 ff 89 de e8 52 ab 52 ff 84 db 0f 85 1f ff ff=
 ff e8 e5 a9 52 ff 48 c7 c7 08 b7 be 83 c6 05 1f c2 43 02 01 e8 a2 54 36 ff=
 <0f> 0b e9 00 9
> > [   58.997238] RSP: 0018:ffffc90000053da0 EFLAGS: 00010286
> > [   58.998124] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fffffff=
f8111b6fb
> > [   58.999358] RDX: 0000000000000000 RSI: ffff888007372340 RDI: 0000000=
000000002
> > [   59.000558] RBP: ffffc90000053db0 R08: 0000000000000000 R09: 0000000=
000000001
> > [   59.001737] R10: 0000000000000000 R11: 0000000000000001 R12: ffff888=
00ec16200
> > [   59.002928] R13: 0000000000000000 R14: ffff888015808000 R15: ffff888=
00ed6fc00
> > [   59.004172] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) kn=
lGS:0000000000000000
> > [   59.005541] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   59.006521] CR2: 0000000020000000 CR3: 0000000003e3a006 CR4: 0000000=
000770ef0
> > [   59.007770] PKRU: 55555554
> > [   59.008260] Call Trace:
> > [   59.008709]  <TASK>
> > [   59.009094]  sock_map_free+0x36c/0x390
> > [   59.009745]  bpf_map_free_deferred+0x124/0x2d0
> > [   59.010543]  process_one_work+0x3b1/0x9e0
> > [   59.011288]  worker_thread+0x52/0x660
> > [   59.011947]  ? __pfx_worker_thread+0x10/0x10
> > [   59.012694]  kthread+0x161/0x1a0
> > [   59.013270]  ? __pfx_kthread+0x10/0x10
> > [   59.013925]  ret_from_fork+0x29/0x50
> > [   59.014570]  </TASK>
> > [   59.014959] irq event stamp: 25629
> > [   59.015589] hardirqs last  enabled at (25639): [<ffffffff811eac21>] =
__up_console_sem+0x91/0xb0
> > [   59.017047] hardirqs last disabled at (25646): [<ffffffff811eac06>] =
__up_console_sem+0x76/0xb0
> > [   59.018450] softirqs last  enabled at (25412): [<ffffffff83023a3c>] =
__do_softirq+0x31c/0x49c
> > [   59.019851] softirqs last disabled at (25367): [<ffffffff8112b5a4>] =
irq_exit_rcu+0xc4/0x100
> > [   59.021282] ---[ end trace 0000000000000000 ]---
> >=20
> > Found this issue existed in v6.2 kernel also.
> > And bisected from v6.2 to v5.11 and found the bad commit:
> > "
> > 0a182f8d6074
> > bpf. sockmap: fix race in sock_map_free()
> > "
> > Reverted the bad commit on top of v6.2, above issue was gone.
> >=20
> >=20
> > There was "use after free" in dmesg info.
> > And I found that GPIO kselftest triggered the similar Call Trace also.
> > "
> > cd linux/tools/testing/selftests
> >=20
> >  1.  ./kselftest_install.sh
> >=20
> >=20
> >  2.  cd  linux/tools/testing/selftests/kselftest_install/gpio
> >=20
> >  # ./gpio-mockup.sh
> >  1.  Module load tests
> >  1.1.  dynamic allocation of gpio
> >  2.  Module load error tests
> >  2.1 gpio overflow
> >  test failed: unexpected chip - gpiochip1
> >  GPIO gpio-mockup test FAIL
> > "
> > Related dmesg:
> > "
> > [ 9729.144086] ------------[ cut here ]------------
> > [ 9729.149680] refcount_t: underflow; use-after-free.
> > [ 9729.155478] WARNING: CPU: 75 PID: 809778 at lib/refcount.c:28 refcou=
nt_warn_saturate+0xd3/0x120
> > [ 9729.165489] Modules linked in: gpio_mockup(-) xt_state rds quota_v2 =
quota_tree brd overlay ntfs btrfs blake2b_generic xor raid6_pq ip6t_REJECT =
nf_reject_ipv6 ip6t_rpfilter xt_tcpudp ipt_REJECT nf_reject_ipv4 xt_conntra=
ck nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bridge s=
tp llc vsock_loopback vhost_vsock vmw_vsock_virtio_transport_common vhost v=
host_iotlb ip6_tables vsock ip_tables nft_compat x_tables ip_set nf_tables =
nfnetlink intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_unc=
ore_frequency_common i10nm_edac nfit x86_pkg_temp_thermal snd_hda_codec_rea=
ltek intel_powerclamp snd_hda_codec_generic ledtrig_audio coretemp snd_hda_=
intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core snd_hw=
dep snd_seq kmem ofpart snd_seq_device kvm_intel snd_pcm pmt_telemetry pmt_=
crashlog cmdlinepart snd_timer kvm ipmi_ssif spi_nor device_dax intel_sdsi =
pmt_class irqbypass mei_me mtd rapl snd i2c_i801 isst_if_mmio pcspkr dax_hm=
em isst_if_mbox_pci intel_cstate
> > [ 9729.165539]  spi_intel_pci soundcore isst_if_common mei intel_vsec i=
dxd i2c_ismt spi_intel i2c_smbus ipmi_si acpi_power_meter acpi_pad mac_hid =
sch_fq_codel crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3=
 aesni_intel crypto_simd cryptd ast igc pinctrl_emmitsburg pinctrl_intel pw=
m_lpss [last unloaded: init_module(O)]
> > [ 9729.297472] CPU: 75 PID: 809778 Comm: modprobe Tainted: G S        I=
O       6.2.0-lkml #18
> > [ 9729.306942] Hardware name: Intel Corporation ArcherCity/ArcherCity, =
BIOS EGSDCRB1.SYS.0090.D03.2210040200 10/04/2022
> > [ 9729.318926] RIP: 0010:refcount_warn_saturate+0xd3/0x120
> > [ 9729.325020] Code: 9f 00 0f 0b 5d c3 cc cc cc cc 80 3d c5 72 b7 01 00=
 0f 85 74 ff ff ff 48 c7 c7 10 b9 2b bc c6 05 b1 72 b7 01 01 e8 7d 39 9f 00=
 <0f> 0b 5d c3 cc cc cc cc 80 3d 9b 72 b7 01 00 0f 85 4c ff ff ff 48
> > [ 9729.346438] RSP: 0018:ff38111b0f3b3e48 EFLAGS: 00010286
> > [ 9729.352524] RAX: 0000000000000000 RBX: ff1e4ed2436ee100 RCX: 0000000=
000000001
> > [ 9729.360745] RDX: 0000000000000001 RSI: ffffffffbc1ea3d1 RDI: 0000000=
0ffffffff
> > [ 9729.368960] RBP: ff38111b0f3b3e48 R08: 0000000000000000 R09: c000000=
0ff7fffff
> > [ 9729.377188] R10: 0000000000000001 R11: ff38111b0f3b3cb8 R12: ff1e4ed=
24b90fc00
> > [ 9729.385415] R13: ff1e4ed2436ee140 R14: 0000000000000000 R15: 0000000=
000000000
> > [ 9729.393639] FS:  00007f76415d5740(0000) GS:ff1e4ef0972c0000(0000) kn=
lGS:0000000000000000
> > [ 9729.402941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 9729.409618] CR2: 00007f764154fd96 CR3: 000000108c20c006 CR4: 0000000=
000f71ee0
> > [ 9729.417860] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [ 9729.426087] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000=
000000400
> > [ 9729.434328] PKRU: 55555554
> > [ 9729.437633] Call Trace:
> > [ 9729.440650]  <TASK>
> > [ 9729.443266]  kobject_put+0x10f/0x1b0
> > [ 9729.447520]  fwnode_remove_software_node+0x35/0x50
> > [ 9729.453158]  gpio_mockup_unregister_pdevs+0x3a/0x4e [gpio_mockup]
> > [ 9729.460233]  gpio_mockup_exit+0xd/0x3b3 [gpio_mockup]
> > [ 9729.466169]  __x64_sys_delete_module+0x140/0x240
> > [ 9729.471619]  do_syscall_64+0x3b/0x90
> > [ 9729.475909]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > [ 9729.481830] RIP: 0033:0x7f7641954f7b
> > [ 9729.486100] Code: 73 01 c3 48 8b 0d 15 8f 0c 00 f7 d8 64 89 01 48 83=
 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05=
 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 8e 0c 00 f7 d8 64 89 01 48
> > [ 9729.507517] RSP: 002b:00007ffef02671e8 EFLAGS: 00000206 ORIG_RAX: 00=
000000000000b0
> > [ 9729.516270] RAX: ffffffffffffffda RBX: 0000562e93269ee0 RCX: 00007f7=
641954f7b
> > [ 9729.524519] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000562=
e93269f48
> > [ 9729.532752] RBP: 0000562e93269f48 R08: 00007ffef0266191 R09: 0000000=
000000000
> > [ 9729.541004] R10: 00007f76419d3ae0 R11: 0000000000000206 R12: 0000000=
000000000
> > [ 9729.549266] R13: 0000000000000000 R14: 0000562e93269f48 R15: 0000000=
000000000
> > [ 9729.557518]  </TASK>
> > [ 9729.560246] ---[ end trace 0000000000000000 ]---
> > "
> >=20
> > I hope it's helpful.
> >=20
> >=20
> > ---
> >=20
> > If you don't need the following environment to reproduce the problem or=
 if you
> > already have one, please ignore the following information.
> >=20
> > How to reproduce:
> > git clone https://gitlab.com/xupengfe/repro_vm_env.git
> > cd repro_vm_env
> > tar -xvf repro_vm_env.tar.gz
> > cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used=
 v7.1.0
> >    // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058=
f65 v6.2-rc5 kernel
> >    // You could change the bzImage_xxx as you want
> > You could use below command to log in, there is no password for root.
> > ssh -p 10023 root@localhost
> >=20
> > After login vm(virtual machine) successfully, you could transfer reprod=
uced
> > binary to the vm by below way, and reproduce the problem in vm:
> > gcc -pthread -o repro repro.c
> > scp -P 10023 repro root@localhost:/root/
> >=20
> > Get the bzImage for target kernel:
> > Please use target kconfig and copy it to kernel_src/.config
> > make olddefconfig
> > make -jx bzImage           //x should equal or less than cpu num your p=
c has
> >=20
> > Fill the bzImage file into above start3.sh to load the target kernel vm=
.
> >=20
> >=20
> > Tips:
> > If you already have qemu-system-x86_64, please ignore below info.
> > If you want to install qemu v7.1.0 version:
> > git clone https://github.com/qemu/qemu.git
> > cd qemu
> > git checkout -f v7.1.0
> > mkdir build
> > cd build
> > yum install -y ninja-build.x86_64
> > ../configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc -=
-enable-gtk --enable-sdl
> > make
> > make install
> > ---
> >=20
> > Thanks!
> > BR.
