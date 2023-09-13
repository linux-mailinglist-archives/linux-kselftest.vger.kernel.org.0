Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E91479E48E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 12:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbjIMKHz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 06:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbjIMKHy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 06:07:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6B8196;
        Wed, 13 Sep 2023 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694599670; x=1726135670;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LB0KrmpFYku3E3d3V1Vi9229KiDvvUs4ovM0w3CfM1A=;
  b=BvsqlI1oteHKjYnuHl5T6p5lsSYB6JSNZ7T+YCgipizymyMT6aebv1aA
   Oi29qv+Bi8PSQR3VzwtWvps6S946sIyDyN7RXlpp/m+KE7OBVTf27gVka
   7RueWK8UMhWaCDYUPPX2uk/Fb+I+fbiF+lgVAHxuduUazMCFTCGardt3o
   wfsxwOUXGOzfJ11bANqYFccSEjiFQO9mqgxojD8JA/Gb+1giGAKLvFpf7
   5bkXefHV227PYf7F99+/GQ0ZJud9Zfzbj4rksUehjHjpeGjP6IMqc7s7q
   obCGoQShIgHhtrLMrsYeDvWXRKqjHxw+kmhFoRtM/HqnovDsGVg1N940O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358888719"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="358888719"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="1074896738"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="1074896738"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 03:07:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 03:07:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 03:07:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 03:07:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhLShkx/p1tw1ACESk6W5H3DFW7yia4sqz/epXutXzo05ACxWawRl4+hKV0rVdQ4Jxg+OzATTf/O+NqSXQsBU+g5kk10qDbOTy13t7a5dL75pJRA/Y7CS3ajV34A8cTQpAvw8qtD2u4AGb1AR2F63bGM+1LHgNRiJLjrS0OsKvL+u6HCwXJxwBqKFT+XgTT1VphGI5qD7Q4RgDYPEBwuxKaaAtvozzQwjOLDH5FcqyPF4DFZDVXHM2qwp/9IKkIs7JZU71snJbBS40bWEPbu0PzQ7rBeUUhsxcpqvsd75zPVHwgnN+cFwMq+pDAtniqZrdvGAKPMTSB5BwexRrJ8dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLjeKtPddiTjFEK5ezNYcc/u7YdKXYqRlV3YLhS9VZM=;
 b=aatAqieRihz7Zm0jJjVGpYiNyOna8wYFHfxF2KfgfUjHU+Bsw++F8b1DR71bwn92rgRTQHBntdyk+BgwTxepkWWWR0fsUBRwOvDNFev1Bks60hB6mA1hwkdQtCxjbVCrzujLdxXf9I41BcoUrpz8cBu5KMPM5+d1k/kU0mc7SwEqWYCXGV/qHo0ANGosF4UE/JwQLvly5WTk3FrhMKGqPxwNl162mMscO31o5z8ruAvQqs8VDGN4g1q6X9I3PGvoy5dygpAMPImDhPR6X9dFngo2e1CWCUNzwK72imrBl5Dn0KCQk3zK2E5MkwQQX8HFpL/EnvOHY0I4cYsMs2yDAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DS0PR11MB7624.namprd11.prod.outlook.com (2603:10b6:8:141::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Wed, 13 Sep
 2023 10:07:43 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 10:07:43 +0000
Message-ID: <a1531a48-b59d-d5ff-130b-5cc6a571a9d1@intel.com>
Date:   Wed, 13 Sep 2023 12:07:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tracing/user_events: fix long size check in the ABI
 selftest
Content-Language: en-US
To:     Shuah Khan <shuah@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
CC:     Beau Belgrave <beaub@linux.microsoft.com>,
        Ira Weiny <ira.weiny@intel.com>,
        <linux-kselftest@vger.kernel.org>, <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911160935.10720-1-aleksander.lobakin@intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230911160935.10720-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DS0PR11MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f88dcbd-ba77-43e8-5e32-08dbb4414511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcRMUzUEUkYJmv8KX2s7ojdRRH0xfJLleI1pQYD+KEmfZFZ3zxNM2g2TPJhMtAUl7lS7mQ2GT1HuKweVILty9hkU/Y3MBlZJtgoKwsvcEhneZ/KGGzuCezMexIHu9IKOxhZNR2vvFE+J24L4CWRh+oXh1qB4QLX+2zeIvEwo9kTBkwxtZu42rqmPX4V2CicnZA783DRvwNf4gia4z14YPj0er6eE+86W9QIOArECWVvF5HgiFxKJ0897la8LAhtcAOo4qhzAiKPruHkIwf9tAlUvHg2whRpRtZ10ZGrrhP48NmOwGO2zASui3rrWj8CtKYwlRZw5s1lGtZFVxlycMZuWa/ltMJbIpgfsLLXqSA3mc9lcPcEfQe4rc6CT8oElY90b+zApbNgNVFrXoPBLoR4vNk0AduULFQ/cDsQ1m7B1wV1DZCEseGy7RdO6NfaMdwbZIqvmlNYnh1Teg3nFjf4KwxYdRlqrp4Spzi/X/JUJYICguC5doZXaYLXe7McF/+HK+ZxAhQpu5/FNdqosfu0dSyiwxbRd0slLYWw106J65gPN2ZoNidp8sr8RS17fUz50IsH2v3NCazNYym2XEAfUvozFRp5v0oKOF2+iGFN5FX5dg+GBRHXGaHYm9p/yb7fbFS4Q5sw0Y5oXiC18uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(1800799009)(186009)(451199024)(41300700001)(31686004)(6486002)(6506007)(6666004)(36756003)(86362001)(31696002)(38100700002)(82960400001)(316002)(2616005)(2906002)(6512007)(8936002)(5660300002)(110136005)(478600001)(4326008)(54906003)(66556008)(26005)(66476007)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekkzMzROYkYwVUtqdFRpNnZPWC9PMit6b2hJdWdKSElLQ241OGtYMnA4UnpZ?=
 =?utf-8?B?ZEVpNFlQUXVsQnRrQ2JPMTdUb0ZhcVdNODFwTUVkTU1MdXl6ZHpNWWluN1lW?=
 =?utf-8?B?U0VOd1JvSHhUVEQ4UC94cVM4Qldxdk1LYVkyZDNOZ3h1MnJjKzZ1UlA3bE9W?=
 =?utf-8?B?eDZoN3kvTnhmdUJQc2JFWHVaWXcwUTlGYWJ4WlIzQ3FlRWM4UjNsRWlHU3FO?=
 =?utf-8?B?WkJoYUc5WnQwYTJ0Vi9GcnlRRS9hNisvd05rU2l1VmlRdEVYRW83TVR4bEVE?=
 =?utf-8?B?SkJpY2ZUSDAwdFZvT1lMdUZIUHNYOXRIZDlFVDRiWUt4WkNhMFFWZHd0TVB2?=
 =?utf-8?B?blhVMkMvbFNSYTBOQzdPejFFRVBhL2ljSFVFVEpVWXp6SE9UYUxrUlZUR3Bh?=
 =?utf-8?B?VHBtelIwQUVWUFpadFdGQ3NleklOWStRVk5uMnhKdHVsTmZ2aWVVRTdBdERj?=
 =?utf-8?B?K3BZTUNYNTFBUTVuZ0JOblRZNHhhSnBIYXh1MDRtMlJTeDQyaXhWbGZtbEhy?=
 =?utf-8?B?V01CY1hIck96OGdHWXc3SE02TkJqSDRqK3F4U3BHczFBeFVwRERpV2hkSm50?=
 =?utf-8?B?Sjd5ZzNvS0pQU3M5YTllWURmb3FvN3l5ME9JeCtxNzRoeDFkU2NmQkYvbXpG?=
 =?utf-8?B?NmFlTzBjRzZUYUlVSGxpbjdqUGFBQWk3Y2RRV0gwaHhJSDVzYSs2M0hIVGZF?=
 =?utf-8?B?L0YyMGZIcXVPTXhWcnJQVGhGRzVUODBLQ1IrRkl1Q3ZmeGxRNWZJZzNLRENu?=
 =?utf-8?B?Nm1PbEpaSHlIWjcyU3RNTWVUMG5uNktpZzVpS1E3ZzlOZHFhRHlJOStWL2N0?=
 =?utf-8?B?bFBlNnEyUGVLUFhjN2NFMzN4aU4vblNMcGtudEN2TzVCZkFMbjhKMUU4ZlZm?=
 =?utf-8?B?MFhrQ2ttYjhBandLMTR0N0ZSM0o0OTEvdG1HN212NTFGZXg4VExiYm5LaXM1?=
 =?utf-8?B?UHE2UVJPWUVmbEo3ekhIempzT0dxN1V0Q05BZTNvcGx4TG9jdGFOODVkWVZx?=
 =?utf-8?B?SWVhSVBybVc1NFJzZG1oRjhWbG5LcDRLQmZvTUJpZCtkUFRLaExOeTV6Umcx?=
 =?utf-8?B?dHM2a3hZWGI4bkJrU1l3bFcrNDNrS0p4RXc2U3k3WlI4UFdzVHRDT1Y4NWdY?=
 =?utf-8?B?U0Vqb1NHM2I5clNTTzc0WDlNS044WFZ1bUwwUkp2TjYrQXlGSHJDK2VYcVNH?=
 =?utf-8?B?L2lHQjZURnZveDRKYTY0T3g2Qld0cFZWZFh6ejZzaHVqUHlpV1pYOEZyMmJB?=
 =?utf-8?B?MjgxblYrd0hOM1lIVWxrZDg1N1F4emgwU1F4L1ZXV0RrVTJ2SVFQa0tLUkFS?=
 =?utf-8?B?TUI3V2h1NnNTdnQrbXlhSEFJVHJPUStoZXVwdTRhbFY2bjZLWDlSUjZIaUlZ?=
 =?utf-8?B?bFJHc05Zd0RDdHcweE4yWGNMamlJalR2R1UyTnBTR3VkMkhvTkk1UHloMVZ6?=
 =?utf-8?B?ejhDWmQ5Nm00eEZQL3RNRDg4eW9sT0FwVFpBSzZkSzJQaDFVQ2JaQlZDV1hI?=
 =?utf-8?B?dE9DM1ZLQnZabVJzWWxUVWZTL0VLQlhORUJXL2xCenUyanFxMmxuN2ZtdjVo?=
 =?utf-8?B?MUpxTkRQZjJsNllCM1krV3JqaGhINGRMMnBRamRScWhoQTRGQlJEWFFpL3cy?=
 =?utf-8?B?cVFCMkNYaTExbjF6cDY2MFY4V0pST1RVRUprTXRqY1hkQUNsTzhwdUppUWFo?=
 =?utf-8?B?UjdZZ2JwUEpYTmJzdW5KUlJMcHloT2FwTW1oU2lVNWc1SEExTlRndlllejJU?=
 =?utf-8?B?VVJzRUo2RGVXemx3bFVsdmZTRzlqSk1yTmlBVk1YMWNkZ1gwamw0K2RKL0J4?=
 =?utf-8?B?dVJMSDJrWWZYZGkwTXdQaytkRTNvVU82ZlN1VGU2djVOeWRzWGRiU3dPWGxu?=
 =?utf-8?B?Rlo5cGJiQTlrY0lZYVR1K1NQcmZGZmJYUVYwQnp0cGNWT214QThyVndPVDFy?=
 =?utf-8?B?ajRzM3N0K1FFbkNGZlgyZ3BoNGxoR05lTmNXbFNQU1daZHZ0TnpzcjdqV0ow?=
 =?utf-8?B?SitPNjRCTnMrT2Vic1YzZHlVeklJRDFhUGV5aHlPTVB5ZitNd1FMN0R5Z3dQ?=
 =?utf-8?B?cUhQZTBkZEtHYXZTK25Rbk5kT241TzliRDNudG5UUTJSVDVzMG9PSGhTNUZ1?=
 =?utf-8?B?bGNLaUpEejRnZFk4ZFJ1ZkY2eGdabWxCalhxYStkclFCTk5xWXpCVnBpcDdP?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f88dcbd-ba77-43e8-5e32-08dbb4414511
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 10:07:43.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mYS1T0erp/Fm3qBvwt9iKU5r7mJo3szk+HxfvzCJDSSniR6ga30PSNep8G64nuatIXDFGjU6eTuwCLgGxV17PNuIE88HO/DCDWzCLsb5tE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7624
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Mon, 11 Sep 2023 18:09:35 +0200

> The current check for 64-bit architecture is double-bugged.
> First of all, %BITS_PER_LONG is not available in the userspace,
> the underscored version from <asm/bitsperlong.h> must be used.
> The following check:
> 
>  #if BITS_PER_LONG == 0
>  #error
>  #endif
> 
> triggers the error in this source file -- the macro is undefined and
> thus is implicitly evaluated to 0.
> Next, %BITS_PER_LONG means "bits", not "bytes". In the Linux kernel,
> it can be 32 or 64, never 8. Given that the tests guarded by that check
> are meant to be run on a 64-bit system, the correct value would be 64.
> 
> Prefix the macro name and fix the value it's compared to.
> 
> Fixes: 60b1af8de8c1 ("tracing/user_events: Add ABI self-test")
> Cc: stable@vger.kernel.org # 6.4+
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Patchwork says "Accepted", but I don't see it anywhere on korg O_o

[...]

Thanks,
Olek
