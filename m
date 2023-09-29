Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A81B7B3827
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 18:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjI2Qzs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 12:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjI2Qzr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 12:55:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929131A8;
        Fri, 29 Sep 2023 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696006544; x=1727542544;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Eu7Wi9PQKsGE9R3WeViXl8/O/l654jnXZRKtt9wjdYI=;
  b=XwzQZSJ4D1rULdiOCXjLYMSzTo4H5kQV71GVJvlpPt/pkd7XgDHyQHtd
   BvOAy2vrtO9dIQ1kSuilfqHVJxr+OQ0KVBfxSbv19XUgA2PuWnmUgV4XR
   aa5VSv/HgPhw3x8sn8hQ7gThBHY2XKHNnHedauwKU08HTzppIFXYJdGyO
   O5HbOhM0V7ArGIunl9A2NEa4su6LyA2Tg+yF1V4kuZaYzuCeFOPhmJGOv
   gRJa5u3sfR49RNoQFaMUHI79rPxLwUX+Eq77gs8o7Q0vMs7daVEMJK+e0
   peXiz1YbtUELGMYUM0UH9wHfI2Lgd3Z60FGpk6oEl2brNVwFr13RNRO8M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="362588374"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="362588374"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 09:55:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="699704467"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="699704467"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 09:55:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 09:55:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 09:55:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 09:55:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 09:55:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWaPxOoVvZDFFhft+oUdme4GLZtafSiGdSIr/F9BoR+Y47A/uBU2LQ/vkVxb9kU+Qiy1FqgnUh3VRvPY9IXljWkIp6vS/IJjzx0OQhoia3DS4ohE9MeFuojIBh64wXtaMRBB+wZDZlUL7mIfvzzA5kFb/J2fXKvsAbSXNxW/wwiglv0dHU6n+6kORHLxpswscC+RN+80OYNlblW3x1PC9vOkWlmX8lXL9WTFVIRePqO14STDTCbUAcT2Om1aMEPdUQqBZXL6XZnBsbW03Ff8F2XGw1hSJu8ndt04hIAMKHh6WrXQFK45R9use42zQl+G4NYbtpRzUnF7E3Pc0fHp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbxpI5GviCQMzPnAdS0Hr5OzE6Ghy1Th7dYPiVXW40E=;
 b=C9FvrTk2KtpI50wfP+9yqOaR/LIVDh0EjYcCvr6gOK4Lj9/Yub4sNPAYiVl3PEv00amtQ91NUlMX2KAV3TzfiXua4w1NSH17Xf2XgcQQpHazbXf67hB7K85VfVvKmJrK5+R/Jho+0lPMS2iEWFXI+8WdAkFh3OzEJXywaeDV6BzHENUITaDdiGonWDP5jQGEhEy0RqvCOom/ZHiOOtVxH1/0PbGD5ABkWWLdaJlWIZrTH4wvV86S+b0Z2BJM2afJxz2UJZwwgurcv0p693qLl/CB+mV3y95EIL8Au6pYwpNN5zvl5Wa7GKa/tE6ycQ98/P4updThuQYRVKmVHhkeRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Fri, 29 Sep
 2023 16:55:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 16:55:26 +0000
Message-ID: <0df7f82d-de3b-3e51-ffc1-5aa4e23db62a@intel.com>
Date:   Fri, 29 Sep 2023 09:55:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/7] selftests/resctrl: Fix uninitialized .sa_flags
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20230929112039.7488-1-ilpo.jarvinen@linux.intel.com>
 <20230929112039.7488-2-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230929112039.7488-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 636549fa-77cb-454c-c80f-08dbc10ce0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6gI+JJWmAhquz3+WjpgyGJqRE+XpEaco9OHHWium6BqqUoKikjHwIUulNSOBHqvdmfz8WxVROcLwfq4qzj6dHog3D+lrvYrgJP7/2NXJgssRa3+hPtSM31+Gw3z+gXWNQJJ5yLIWJ3N23A7CAlUMRFPVQaDuQwzj4g8ek9j/IdxiY70vlgorRvoG3DvAtOMjROiQ4o/Z2rkwzkU6D5p96qxvMBcZwqHgWhNZdqNa4I8Cx77e1UYbtErqBvjDyj22NlBtFPWqcZ9yKTn0O+t1w20gyI+qHngxLO7eYzoOTWS8mWJOE1yiAUxCldoLkD87fkku+G/a695+y+Ab0RG+wlPJEpjsLx9NEXAQxmy+WxU5wg2ZRhzUBHRg6s+9x2ZilIwaZqTSMpghzP85u6Wugd3EgY81Ikm0vqqZ2zdDSUnondYjA+MLwO0nshMwFuepMqHcKVq3lnfedPv/VRSF6wijiuV1+kpBAYACDhxmhlfSGaxH7Iy9VJxMdVYF8SCnNYRt4VYiQTSil1IC4OkkXXTG1JOybq/x+Je2APnzdjx1XI/kVMKQo45EFXg03dEFVgqpBnir6QNRRs3isKjjPCnSvtmXBdltgJ+Kn+FVgMNaGRejXSVa7sOWSKTDiGxowwUI44AEP1Hb6t7B52udVGsPxJbyxLOyu94/xSS8CAm1heOZdKGLX/l5QSle3hv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(53546011)(6486002)(6512007)(6506007)(2906002)(86362001)(31696002)(2616005)(36756003)(478600001)(6666004)(4326008)(8936002)(82960400001)(316002)(38100700002)(83380400001)(41300700001)(5660300002)(44832011)(26005)(8676002)(66574015)(31686004)(110136005)(66476007)(66556008)(66946007)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRDUElPZC9lVFNDc3JqR3ltMEpNLzFKZHF5VTVNc2hwRnVOcWFEeVpKbmMz?=
 =?utf-8?B?Nkk2S1VGVTkrQUxNNGhpOThuMWoxWDl2NWZ2NUxZREl0enhlY2M5QXozS3Zx?=
 =?utf-8?B?K2drTXRPbzBsd05GZDlHN0xleXMyREtPc3cvdTZLOWZPbmlDM1VOZVZUT2Vh?=
 =?utf-8?B?bjFLRlQxdzNndmM3R0N5T05HSzlSTHFxQUdwRFM5OVVDRDBFSnV2NkdMb0dv?=
 =?utf-8?B?c2gyTk14cDBFYk9FTjJoOU9TRDEyYTEwRWdUTk9WWmVKcE41QzNkZUE5b0k3?=
 =?utf-8?B?dlUrU01MRGxadG1TMkFRTkxBcG04c1dFOXhpbnFSS3BPZjRRMlVmSExIYTRC?=
 =?utf-8?B?UzhRbmswMFVhYjRPQVlQWGpmSDJWdTE4WHl6cUtoeUZBVTg3Z1h4UTFUN25O?=
 =?utf-8?B?aHQrSG1aRlkyWU5lMktYZFk4d2FhZ1YzYkd1SXRZbXdIYkFrNmg2b3o2MFRj?=
 =?utf-8?B?R2kxYiszd1JSa3l4MllJdlJ1dUlSM0ZFaG03NmhGMURlU3JWdXp4N243TEJm?=
 =?utf-8?B?NkdOMVFtdU5iNEYrREREaVQ4YVluK2hxdjNGQmhRYkEybTQ0azBLU292a3o3?=
 =?utf-8?B?Qmo1RnprNzQ2VHBjTUE2dlgxWGJhYjdkeG5zVG1HZ1JzZ2ZYaFMyNENhalRQ?=
 =?utf-8?B?enRoOTg5NzJ5S3phMzNrRWZpVHBMQ0hKQ1ZjSkc2OVRzYjFSc2tkN29YL2NN?=
 =?utf-8?B?T291c3g2dlRETHBNTk4vQnVpSThzVExDYSsyeDd0cHdRV2VnMWVUc256bita?=
 =?utf-8?B?SS8xaTRIVnBhTWljaVdHenhsb2FBSmk1VzBWNEFGVjZ0MEFmcVU1N1VMNnph?=
 =?utf-8?B?Y2NPTERyb1VrcnBnYmZ1QU03V1BNbUwyclp2ZElqbFFkS09oWHVQamYxUmtx?=
 =?utf-8?B?Q1F1OGZWSnJ3OFcxaTNRYzRrM1VXM3UvaHNlQVZPN2NJaTgvNXByQUdXWnpJ?=
 =?utf-8?B?SDBLdzh3QUljSEhJdmttU21hQ0NUeTIvQ2RWOEM0WkFKem1KRGZIQzRmL29w?=
 =?utf-8?B?bEFIY2ZHbWw2eEZwVWRnYkl5eWxDeHN1Z3RIR0N0d2tZVzM0cHF3K1g0YXdy?=
 =?utf-8?B?Rm5tdndIYy9KTVJhcXJGeGo5SkJ1Z1lsYTV2UDhBbCtVUWd0L242KzVHKzda?=
 =?utf-8?B?L2VudjQrSnB6eTJmcEFMUERkMVpPaFc3UGcvdmJ5T2FNaXdHbSsxVFJKaUp6?=
 =?utf-8?B?cFhxaGdRanl0V2hGemc3d3BXWERzdTJBKzJZbEVuRjVtUXBYcml0RUltZGVn?=
 =?utf-8?B?dkNHVWtHR0R2NlBQRlNBcmk5WjhUNWVTMUVlWFZPdG4wNlk1L09BR05UM1ZE?=
 =?utf-8?B?bzdzRXEvZVcvNExyd0hjVmhtNDlvb0tLenhlbUFyUkNjNk51eTBlZGlIQmZl?=
 =?utf-8?B?V1pqVTE0VThWMmo0QXlaTDhHU2xkM1FXOTlQV0h6c2FGbzRFVG00bk5VV0Vr?=
 =?utf-8?B?SEJ3ajduRFpQTlVaK3VzRVdoMzF1OWs1S0c4Wlhqbnc2bmcyTGUxSC8zOGpt?=
 =?utf-8?B?L2tDd3ZlaG0ycm5IWFErUEtMYjFHbU1XeXc0RmlWeVI4TVZ6NDNBb0VObjUw?=
 =?utf-8?B?NmZkOUhRWlRNeTVOMUhDd1FpOTlNNEx5KzdmSE1jeG9BZ1BUWlo4eW1JNFNL?=
 =?utf-8?B?eC8wK1NaMy9zMDVlVFdiL3FDTjZ3OEsvc2xKUXVYaEd6ektCRnY0QmZHM05n?=
 =?utf-8?B?bnVqVkdjT2pBOC9xdzZ2VmxrK0lBNWZDemo2c1JGdGFRUGxBbllIRkg3V0lz?=
 =?utf-8?B?enI5WE5CUEdpMGtlOFFxak8rWi9SOWpncnJqdjN5MDI2Rno5OTM5cmxNRmlo?=
 =?utf-8?B?Z29EKzhTTms4SmtKM0hDRTJMN0U3S0lWb2hFZ2MyZ2w3TUZYRGVxcmoyRjRw?=
 =?utf-8?B?UDJvclJ0R1ZyNld1T0xXVDd0VVF4UnM5aUhmZ3pmeFN6aUtVeS8yeHNTV1Rn?=
 =?utf-8?B?Z2hreXJmL05aaUFjem01QzNLOGxmTFJOaENMcWRTVTA0MFl1WWdPeDRLQ2l6?=
 =?utf-8?B?dUpGZVNTQlljbTZOSWV3VXNtdU5pcnpnNFJOVmhWa3g4Qm9SWGpFSjlpRG5w?=
 =?utf-8?B?MCtlRFAvanRPOFQxalZRWUJXSUFlK0lkdDBMZ1JwMXE1TklyajhxSGF0Uk56?=
 =?utf-8?B?NHZsdXJhMmZ3OWt1N29IcVhkbXY0M0l4MTVNd0JVMkZ6OVBrcnJtRXl4QTNo?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 636549fa-77cb-454c-c80f-08dbc10ce0ff
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 16:55:26.3035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ULDixK3JkBqpNZi1QRK4rblfuM6sFuSc/l2g06RbxDL1u6dWzUVB9V/1mB+57vgM80X/Y8maW9B5g5DHe6UL9x0AabC3wvk9yrfmumWgaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6269
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/29/2023 4:20 AM, Ilpo Järvinen wrote:
> signal_handler_unregister() calls sigaction() with uninitializing
> sa_flags in the struct sigaction.
> 
> Make sure sa_flags is always initialized in signal_handler_unregister()
> by initializing the struct sigaction when declaring it.
> 
> Fixes: 73c55fa5ab55 (selftests/resctrl: Commonize the signal handler register/unregister for all tests)

Please place the title line in quotes (checkpatch warning).

> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> ---
>  tools/testing/selftests/resctrl/resctrl_val.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 51963a6f2186..1e8b90077218 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -504,7 +504,7 @@ int signal_handler_register(void)
>   */
>  void signal_handler_unregister(void)
>  {
> -	struct sigaction sigact;
> +	struct sigaction sigact = {};
>  
>  	sigact.sa_handler = SIG_DFL;
>  	sigemptyset(&sigact.sa_mask);

Could you please add this initialization to signal_handler_register()
also? I understand that the particular issue of sa_flags is not 
relevant to that function but there are other uninitialized fields.
I think initializing the struct makes the code more robust without
needing to reason/understand glibc behavior.

Reinette
