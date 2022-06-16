Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C6C54EA26
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350793AbiFPTbM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 15:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiFPTbK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 15:31:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4523856C38;
        Thu, 16 Jun 2022 12:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655407869; x=1686943869;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SC5Tv3lXOsYW+M8t4EabTl3A+/MHLhrCqgd9Bk5nl2w=;
  b=jCH3U1eBb4nFhvmc7cYT33g7NhMoBE81eI32vAcFHx4TxmpbgY2pReVd
   rF100khnJpZrissRX0HbqDQXHAW3zRjY8GuevLc2TWbvFWD7SW3VRL58a
   HHcYK+tsDcFLBF1oyotQJclPaEnytoIrUILV31XqLpJIC6OQTgrMCn52b
   +1JK8GQ+k2yk2aDNBqBPqreiEnHjrN5K3dlORl5MRXgvtnYKq9lZRRUd9
   wOOnVo7vPzPCI0dpE85/KMcsTLGfh+XmwiAbUVrVCwA7dKsMBFPMuX68/
   zrGLXkj1XKCaMrrkS4Jm44EjufVbYcRKmeif+iN7CMNn0X+vcdEcHK4Dn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280048362"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280048362"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 12:31:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="589779336"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2022 12:31:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 16 Jun 2022 12:31:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 16 Jun 2022 12:31:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 16 Jun 2022 12:31:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 16 Jun 2022 12:31:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6Z8J6b358t23oQhzmYWeblgY++l8neytzqUst8mhRPaPkZLJh4YfDJh4JowH+PYtEqbFNwmZsKfnX7s49BWwRq5GYwLZ2dKQjSG0/1al3xnNk+gTKP73X+vcX0JwTPvxCaPVW826hxlYHdsKP1SIP7p9pSnO3JdMatXymdgH9SIJaieskALbW6P/AaZv2Kl/czxM+3YYwdAC1c6JPuGYym+59ZLJFpdP4RNCNC383k+d7ZO8hv77w94zuVszafFNNe9BN961g2K8UwNrGnpzvRqrryJZK3AlD3RuHG2yuj8X9lwdGjde81xqDdVyPxrbX5IIYia1LjpXRZ3VcLdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDkZVf7UfCRL4cECNj0uC8dNFhdBPmXnkdUzbhD5jdU=;
 b=oavOKbEFbuFC0ZkHmT8xBxlvOfh3a3AnhmYV2GxcXvlr1f+2XCAnLbiWQNFfZBOZNVaKoRIJyIfOs09QOTR4ifWIJuKpmDSHP0SCMmu7eyDvEKLAH7Zgn5FSrZXPre2HTQ8tXatRJ+Ev9uM1Go7z71PoT7xkjTP5zOhGNjsUwaQb4lk5fTPCSkmiFU/yKTUIBy32+KJzYv+pq0DNTzyVEWYrA9QZ1Ati9E/JWTzNiQ+xJAp2S0Oz3Buu1LtZpGz0ZRy28IxA0i4jsqdzriFRhZgk3isRM979AP6bEHOxhL9SCwMG1tokSZ4IVdOX490i8S1LeJSTHRlHfyX+7I/4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CY4PR11MB1687.namprd11.prod.outlook.com (2603:10b6:903:2e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Thu, 16 Jun
 2022 19:31:05 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a4e0:2e7e:45de:a62]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a4e0:2e7e:45de:a62%6]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 19:31:05 +0000
Message-ID: <c88e73b2-69cf-4f74-2776-3644f48edfe5@intel.com>
Date:   Thu, 16 Jun 2022 12:31:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 4/6] pkeys: Lift pkey hardware check for pkey_alloc()
Content-Language: en-US
To:     <ira.weiny@intel.com>, <linux-api@vger.kernel.org>
CC:     <ahaas@chromium.org>, <clemensb@chromium.org>,
        <gdeepti@chromium.org>, <jkummerow@chromium.org>,
        <manoskouk@chromium.org>, <thibaudm@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        <x86@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
References: <20220610233533.3649584-1-ira.weiny@intel.com>
 <20220610233533.3649584-5-ira.weiny@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20220610233533.3649584-5-ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::31) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47016173-22ee-4a7a-bd80-08da4fcec113
X-MS-TrafficTypeDiagnostic: CY4PR11MB1687:EE_
X-Microsoft-Antispam-PRVS: <CY4PR11MB168710FF114D420873A14BCDE5AC9@CY4PR11MB1687.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTBPpn28Kvz4cpGlPxFi7foB3MVsOvBRU1DVEmYvmfABnec9WyZMaFrFBklvxHNulCkKWp260yCJlprH7mF816Hv5RMMSZ+E+pI9umVM+hQtzMsya3mzJm/xnDv+2Z/ErmTirQZ6MO4+0I6eOCuOyLFfLitxXiI6z+hINmf5EL2JvlONXh29kkQ17tgJ7Y+Py3SRF8lgkoF4woYE4Cc4XdK6GEVb5gMzI0BjDWUfbx6YGQEkuJGiE399zqD/mIa7Pwle88LlU9XtO3RAN85lVr5z04kmN3cXzgjcgSzlEozYqPDbzP2D9lbkfgnkrY6rNnX5aNfT2Bj44xCObAnW910i4MLDDnH+5Nbg81e8VC/SNzbtHBFE2pQd6sRr8yFLl22qVwmJ+eGoTQ60DbegXOk3jws7MCBdBj/4sTy5rtACem+gJm5JElMl3f2y3V6b1ZtekPDdevPw4AVxo/wxxysLyrgMICQnU+WHyG98Ptkk3KFKg/eWUKPaC01nA+jTo9Gh7we80oiTFUHMwqnNaoHWpv2Nc5Yv8hvdZDI2El941VL8dvYaK6PjnsFGmwzNPT+GF7339BfCORAEi/10S8PTcF5GmsWotbD3umtPmy+4IDLP4CBCRFwF10+KjkqypA3l8rXz0/XH+QvlOb98qJJ2lQW/FAmHXfCjweDX5B9UxXTEr4zj3hOo59JQnMc4YwT8qeGuBb/1XknSPVu3gfU/V5sP185lMf7/ffiLR5fvbGKxv5BMKR59i3Y/fLwf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6506007)(6666004)(5660300002)(7416002)(2906002)(508600001)(82960400001)(6486002)(31696002)(26005)(4744005)(186003)(66946007)(38100700002)(6512007)(36756003)(86362001)(8936002)(44832011)(54906003)(316002)(66476007)(8676002)(31686004)(2616005)(66556008)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkU1N2hpZ3pRLy9HQlpPdkQ1bjhmdk5KeXBGQlQ4UHNHVW5jTXVMSFUycDNY?=
 =?utf-8?B?ZXpNaG9uejhxVDV5d0wydUxGM2NzZ0hZMjkybTFyK3pQbUI1Rkx2MWlDN1ZI?=
 =?utf-8?B?cDNSbEwzdnVwREdsVDVFcnNGRGhldW5NUDBSOGF5Zi8vaS8xckhNTU4xNWJR?=
 =?utf-8?B?ZmJ0ZjJ2MUNLa0ZRbXJiS21EUGREUldtaDNPWUNIcFJNc3hrWSs1dWtyMlNj?=
 =?utf-8?B?RDhwRnhjWWt3ekJob3U1R0wvNFlVL3Z4WlRUY3kvejg5bjRVQThVNlc3TW5h?=
 =?utf-8?B?T2JWbk8xVkNvU3NKQS9BMDlqdm5hVDhNWjFrSWFHUEh1ek9BS2JmUWdqNkRa?=
 =?utf-8?B?TGpFZGNYSUNSVXF3OWE2TEkvNGNFREJNVkVrNnNQTlQ4QzR0NlRFM2trQU44?=
 =?utf-8?B?NXIrSnoyTFpXeWJKSGk2QzFJZmsyZU9TYTRNWk5Va0o0QnF6THR1YnZhcGJF?=
 =?utf-8?B?Qkx2SmRTN1lMMUtzaTBhbUYwd2swaUtSNHRkUndobnBWM0dOQVJFdklYcjFt?=
 =?utf-8?B?Ly8ySXJ4Ynl5eEl5dCtWUFdnaUxxNzh4cGhiTURNaUtVak1MOE8wNFAyaUE2?=
 =?utf-8?B?QlFDcWdUWGJmWmNWVTgvdmJrTUYwQStTWWlPMHNQL05HUnRNajlvR2tudHo0?=
 =?utf-8?B?V1FKcmpBVVR3T3pFK3dTOFJTSVFqeGRMbFBDNzZVaWRsUFhaOTNvZFprT0N4?=
 =?utf-8?B?dlo5blJvdnh2dklXSHkzdUs2dDNoTzU5cjVucU9tUWZ6WnVLTzBoU050Titx?=
 =?utf-8?B?Yk9sN095VyswK0ZTRzgrY2RCVXBrbVhJYWV1OVRueE92elQ1cU1qUGEzY09G?=
 =?utf-8?B?a3VhV2ZGTEc5RzdjQWsySkZJdWh2cGFyS2RtZjVvUVU4aDFSbzY5ZjlHSUlh?=
 =?utf-8?B?TXpnRDgrOTdIbUZNN2tZYlBDMFROSGxJTlI4SWVPTzFtZlljZUlhVENVMTFE?=
 =?utf-8?B?a0wyRUdaSnUzZEF6cmtCREdZQ3JwcTd6aGJJZ0hUNkx4YktEL01iaFgwclNh?=
 =?utf-8?B?NGlDMUdiYmFWNC9OR3dDRHhURHZPNDlyOEtWWU9XNThlMWIzbU9HdEYrajFh?=
 =?utf-8?B?S1dNbjd5ZDd2MDBpbXdDQ3ZQY2NmVkNiT2dSQVgrZ3FsQ3RtVkp2ZE1FYStX?=
 =?utf-8?B?OHB6SHJZT0RIQmxWU2pDQjVZYUVpdkhMUWgwbEVyWFpGZmprS3ltekNTcHBs?=
 =?utf-8?B?RmpUZkRTRmFkWTM3aEpLWTBRcEt5UzZUaEpNTEYvSnkxL3FvNC9zV3VHR2ht?=
 =?utf-8?B?MzNKTi9JSFQ3b0xzVGZ2SFVsbENYMmx6S0prbmhCbXlxdWNHdUtMMHNPMFBV?=
 =?utf-8?B?WlJ3UWhkWGNDK25WbEwvTkR4eEVFUkIyZnFrTWUwZzRDZEhkWGZycHJaYWth?=
 =?utf-8?B?TFF1eGJLRlJJVURSdmtXeExtemRpYVUvak1uV2VrZWpVS3VzZmZiSDF2dWF3?=
 =?utf-8?B?SFlRQUtkMXdWZHVTampldzIvMXJwb3RSWDl3U0pyNHQvUkFhUis3VUdUNUtx?=
 =?utf-8?B?MHZoalNKemsyTnRIcG5ycDArWDVSa0U5ak02Z051T3dLQURnL1N4MnpZbHpW?=
 =?utf-8?B?S2JGRFJOWjhTVFpuYTBKWTZLeVI2UzZRUUtZUzhjTXc4WC9wTDVFeGNJZ3dm?=
 =?utf-8?B?T2dBakNBRlJHaUoxbTFlckNIeWUrdjQrbzFDcUdsNzBEV2xPbFdvZ0JmSzJQ?=
 =?utf-8?B?cTBEQUE1L2JPNjF1VFkwRXM4ZE0vaEpZejVPR3F4Q1ZNMys2bGE1OEcxNnVO?=
 =?utf-8?B?RzZxREJvRW9yRzRqQkVvQmoxQWQ1MENTZ1RqV0o4VEFmTDhtdFVNMjNvb0Nn?=
 =?utf-8?B?MUtZbWFCOWMwM2JyVnRKa3lNQXJBbHBjWGFqRklhbjlZVmJ2eksrUVc5czZ6?=
 =?utf-8?B?RmZlb1p6aDRNVmtSOWQwU2JqZVo4QmxobGI5MWkrQkpIOHp3QkVnRHQ5Nk9Q?=
 =?utf-8?B?dXpoTGtkSGtrcmhuUlRaQjVheDhjb0VCRXl3NnlBYkxnb0dFL3gyeHZPQUlo?=
 =?utf-8?B?aUh2Q1lwb3FqNTJHV0thV244Z1N1Y1VsbzEzTU01dHlyQU5PVXluUlNzWUln?=
 =?utf-8?B?ZTdaK3dRV2xuS3NqQm44ZDhRbGJSeSs4V09nZmo2TzR1bXQ4MjlxWnp2L3pQ?=
 =?utf-8?B?ZFFzZHFIQ3Zyb2hXQnJmbTJrekJLTDZPWmVGaEJoR1dUUkwyVmNFb0xRRUkr?=
 =?utf-8?B?YS9aMWIyWEcremcvUzZjV3FRdWNGZk5VYjhYL09nWXQ0NjlIWW5vdFpINHpq?=
 =?utf-8?B?SmNJdHpKUlcyT3VIa0RVWGV4VzR4VEJyb05ISGtFTWpSTW1nMnFUbllhQ2U4?=
 =?utf-8?B?UVowYUpxZGJkL1ZrV05zYU50NVNxMGtQWWFNSzB3ZWpJdFBpUkZIbFhxeldw?=
 =?utf-8?Q?C0Lc0PYMvck6AZTU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47016173-22ee-4a7a-bd80-08da4fcec113
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 19:31:04.9999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: focaG/gL+l8GUEPPErpf7PfvKDQsdc8QisQjaAl/OVTTv55p2aCGhkmP6ssEUrLJy+sxVcSRzsQN0lte/PRObw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1687
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index ba5592655ee3..56d35de33725 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -773,6 +773,9 @@ SYSCALL_DEFINE2(pkey_alloc, unsigned long, flags, unsigned long, init_val)
>   	int pkey;
>   	int ret;
>   
> +	if (!arch_pkeys_enabled())
> +		return -ENOSPC;
> +

See comments in patch 3/6. Since we are modifying (fixing) old behavior, 
should we just return ENOSYS to make this consistent?

Sohil

>   	/* No flags supported yet. */
>   	if (flags)
>   		return -EINVAL;

