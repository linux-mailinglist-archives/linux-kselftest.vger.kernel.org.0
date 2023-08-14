Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7C677BF3E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 19:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjHNRsw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 13:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjHNRst (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 13:48:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BA4A8;
        Mon, 14 Aug 2023 10:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692035328; x=1723571328;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0OxCRr33puqwzewnob68WFDbr0J1jFepSDkWVmRNPYg=;
  b=fVTND+nNZgAWw+jogCVuEcz1BWEb0zdKQwsMGAioR70vy/srScA1xt6U
   5HWIpsbxtfyoQQjpThma04nRpLKXs8n5ZQVIh7m2st1KTUxYpLpnvA61F
   /OYVlHEM8w560xag3MnzuYEOK/XTf7LUA75m0f0UJtr57suR4hiLPAkhb
   WA+H8xiR3+osAtJBJE8L9JNO5tHdmqSAj6ziMXLxd8+wvz3anRhnf3uHD
   tmXnUxFVGfhV8ORk/eSl2CgAQG5jxj84HA6uG5SlkNukRp1iXT0d223jO
   Jka4tzFl6zGp30G6rwoPf9qtG2iGhwlWHnGeRNyufdtWfxGHME/ZXcibZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="374872990"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="374872990"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 10:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877050827"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2023 10:48:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 10:48:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 10:48:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 10:48:44 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 10:48:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rx0QwDREasYj/nZAQLF57MW4J4FMue3dK9iX+YYjrntBRmVqX1/dEachpjBjm6p1E64Cb8vEYyBPAA02mi2+EF4wztlOV672CtEPjMGgpXGqH4HUo7uasIiGXbtGk2LDUuUWJNDmIkRgLBwLc2x7mtXGgxon/X8AWVI+2+t+cr8frmmnj1szsuEHphoMYKXzCYSkUb6n1qK0t/dNsAlws4N5O7/QxFcObnsstbA2GvLx1p0TwnxhFwmo5vZQjH34tPxL6iSsZcr2LXSLvNTftstYKaSbmtmwBHnXk+vAWA5UCWFTtlaiUwpJft4pN5dNuxUDXTCeeazwjbXaFQGn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wK7W3ihjkRf/jzkgYHKqOKb4eX5jUyP9jrbpnuxKi48=;
 b=LafF/Uk1pecDc3mBQu9MWS8mVC2d3895FrtMHkO6HrtQAbYaxqDTKuPnZv7U7Yp4nqhHinMastV6gocTX7wtlI6oipbhMMiJZDugOGVNdFf+WTHQ2HvN+PYCO+I4o+wd/rfa000qPHvtnQ6ZEvZ2J17erfFIgpJmBQDeqOhWCNzCWr2LXlRXtovOzK85yW8AThQhGDzwIDYgyblkeLZzo60/z+KAxC9dVghem0oywCRXHn7HrRSwkRZPdpXF3GBbl1sqpySwllnTwQOjGCdFaPWkjH63VvnT0dcDVXShMND2QCfvQHiuNnCz1jPD+C2b+uuh5fD7KIIlnI9ebIXBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6809.namprd11.prod.outlook.com (2603:10b6:303:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 17:48:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 17:48:42 +0000
Message-ID: <9e56779c-4df0-654f-08e1-b27e0dd6b2ac@intel.com>
Date:   Mon, 14 Aug 2023 10:48:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH 1/7] selftests/resctrl: Ensure the benchmark commands fits
 to its array
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
 <20230808091625.12760-2-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230808091625.12760-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:303:85::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 96849118-c9d3-4c85-a731-08db9ceeb341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kh+ZOsDvvTZbaGVNRj0LfE6eLy6xcuTtiOZkx9yXzpsDLQokfTh31CDJtRlZ3gGx6qvVTVyKiVPq/YSJ4MVGhW9fjMviU3kdS7jpu28RNzttFE6GLv1X9GbPLDWXfvXAIsB9qrjVvQHbqprsYC3Puq/dy0Ug1Z8iM+tmeGHtNvzKN0UFiFXaylZz8+9FjCxV/egdfkaulDjEDEM1Kr/0tX5wd/VUJpaE8p0aIyNjIciG+5TKJEBUkK+nQ7guftjMOjg5svCFiuoXHzHHoqt0zhGdnaU1amURZ9aD32OLiP2nmUENHmFYTIxFwfPmsyTzZcfBE1dTxA+uHZuGJir7jqG5vGrHkM7XXUNK0AE3sjeRP/oZ7EfOTPTm4sh02nSwevNV69tnYTw41a/tcAJetEfKh01byz+U4ZMZBEomt+bZW4lS42n9iRr9soowbn9O4o/4B359yN3rM1YNyPW112L6i25vl1n79sDzlXJCGiGFkiJ5Sz9jR/otORkZ4cKIWWXvQRI+C7PN/Efjafcxa+imimAHDmXkLVTa4Z+j1IeZ7D0zxKRzuaIRQNiMvWPB2GSRhLkLxqUG8UzovCVWfBrthvhuzZ4OgGy495IHK0FUvi4O04AuSNs/c9BPAdS/Gh7RmySI1dutRgv4bhsNMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(39860400002)(366004)(346002)(186006)(451199021)(1800799006)(66946007)(66556008)(66476007)(316002)(110136005)(41300700001)(8936002)(8676002)(5660300002)(478600001)(44832011)(6486002)(2906002)(53546011)(6506007)(6512007)(83380400001)(26005)(2616005)(31686004)(4326008)(82960400001)(38100700002)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0xibmI1U2NZNVMwYXhlbVRLanExVHQxdWZXVEpBbWIvbi81RXVXdUpySmpa?=
 =?utf-8?B?VlFqc2pwSEMvNHlyckYyNWE3UklCMXBsSDl0b3czVnlhSHFSdlMrVm9zTDY3?=
 =?utf-8?B?WUNJd2x0MUd5ZllnUmdnN2sySmcxVGhTY1l2ckNJN2NtQlFjMlM3VVpRdGlG?=
 =?utf-8?B?WDJ5aTZkeElGdllVRDNmZkd4RTRheVUrZFJaMUpZc29kc1ZJTnZBdTFxZ09C?=
 =?utf-8?B?U016ejltTFd0ZTBJYWpDZUttRmwzcHcwUFZ4T0xUbmhhRExhc2E4OGgvQnB4?=
 =?utf-8?B?djdnSm5FMVluejRrRDMvQW5MZ0RKZU02eFZ3VlFlOXpjdEJ5cVZxV2lmUkZC?=
 =?utf-8?B?UzBIcFByY1JBc3JnVHRLdzdPeXdCM0xCOTMwNkI2TmtIZGF2TzNTaERSNno2?=
 =?utf-8?B?Q0paVUc2MUo3UGI4MDRvV2drTkZRNm91VmUxU3licmtnY0FNTWthMk8wZ08x?=
 =?utf-8?B?WDlEaXVMYk9oR1ZhajRPWUxhWnNrMkVxOTUwWDQzSk9iZXYzZzkrT1YxSmVQ?=
 =?utf-8?B?N1hPbG1GMUtzVUZEamg2bWV6bFBHVzdweWUvRFdmbWorcUZBVjhSVnByLzZq?=
 =?utf-8?B?eFJwNmlrajRXTW9jZjhrVFcwT2FCc0F6dUVUQWFDYXlqVUpSSVBrMnUwRXZU?=
 =?utf-8?B?dkNyaFVFdXNvQzZDOCsyUjdscGo0TUl4ZlFnQUMvWkRXNDR2V0k1cnpUSTBD?=
 =?utf-8?B?TFNZWWxiOERidXVFMnkraE53bXVvTDA5MzJIRlNiSUlvc1BNcllVdmJhbWtx?=
 =?utf-8?B?bEZDc3VkRVJYeU93ODVUUm5zK25hKy9QdUpCcnVURTJ4VnJ1THpjcGZPQkVs?=
 =?utf-8?B?N3dnL2g4cjYycGd5WGFzOUdFVFUrSDhSUDE3SDVLNGtTT3RCUXZmRUFPb2Jy?=
 =?utf-8?B?L05SU2RvSEhlNklNV1k0czlUb3g4b0lJSjJJN3ZIUlo1cHpQRjNtTzhlRlY4?=
 =?utf-8?B?R29PTVpBSnYvcitLcjArYlloVXJ3TXIxYWl6U1ZPSDZXY1JDaVpXMFlTL1pt?=
 =?utf-8?B?Tmh5cURXcndTMUorRlA4U24rZGtjK1lqWU5QRXdIL0NwbWxxZnk5alFYNVQ2?=
 =?utf-8?B?WkkvRGJMQzdydzlKTmtMRVJyUUgxeWJ5MTRaQTM2K2QweWFscnc3d2UrMUYw?=
 =?utf-8?B?SHRrdHF0MzE0d1BtZjVodHVjcUxqK2hzSU5DU3pwSlBvd1doQlV1dC9DWHZ4?=
 =?utf-8?B?SFJjV1J1UUxEeDQrbnA2UDRGQU9jZVRtSkZyS2tkSmdLd1pjdWp6eDU4NlQr?=
 =?utf-8?B?Ty9zSklWbjFlWndaTk54WXNXcURhK3pDTHNYT0k0SjA5SkJhc2FyWnQzUW5a?=
 =?utf-8?B?T0twS0VMTDRBMUpDYUhHU3hNblF4WXM0ZlFBUXYvVXlKK3Y3T2x2UXRzcVAw?=
 =?utf-8?B?blBNN3hvcVNhbDhNMkRtanFpbUQrenNqN1R4UFdmZmRvZjU5M3E3WVE1b3Bw?=
 =?utf-8?B?TUxOZGlNWXk0ZnlmUDdKeEhTV0VadHpHWFJkYUttSU1wRmZsMkdTU0Vzenlr?=
 =?utf-8?B?c054WnpjRHdqaWdwWW1VTWNrbXR2ZDZRcE9RcWk5YzI2a0RkSGQ0QnFkdVls?=
 =?utf-8?B?KzZOaTJVNGNFNXZJRXpSUHB5czRlTUx3WkxsMEZmWDhtOFBjclYxSjczTzBC?=
 =?utf-8?B?eG1JQ3lrREZFajlCQjVhOC9FaG4xK0k3U3JFTm83RC9YZFFwbE5XZStoM1Ju?=
 =?utf-8?B?NzQ5NVJEbXpwZWdHMVV6QnMxakZaZk44cityREhwTWxoR3JvMS82cnM5Y1B3?=
 =?utf-8?B?emx0dEcwQ01MWHN4bUs2WkVucXVXL1BEalFKRE16TmEydmh1SUtNMitFWTR5?=
 =?utf-8?B?S1pYaWp0OWgyeVA2OS8zVVVMTUxwbDh2QWhYWmVnT21NNS9QN1BVMUVhNjEy?=
 =?utf-8?B?UlNVSy9BOS81VVVzeFNiRmllM2o5K2R1cDY5bk5wRzBFTmxMWCtjWFNGbmZu?=
 =?utf-8?B?aUl0WTQrd0xZRFluK2dzQUZBNENxQmowZlI1dkg1SFdnOUhaRmw3MWRIVGhJ?=
 =?utf-8?B?S1F4ZFpwZ09sZHo3dTRiS1RmazVadHJ4RkJadUJ3RlFCSHF6VjNTU2FwZVkx?=
 =?utf-8?B?Mml0VUd1VTQ2Nm1xMlcxWTZEemd2OUlMV3N5QnNkQTRQUVVlL0NtWENJWDlL?=
 =?utf-8?B?QzZubElMVHFVSHkyUXpPU0dJaFNwZ3hBdXNGV1RZbUIzN01HS1ZWZjZneDhP?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96849118-c9d3-4c85-a731-08db9ceeb341
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:48:42.8304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9B3NtLoCcp3lswxqTKnjQ3Mo4tVpEL/7wcUJ8jadDGMdOvW0hN3QXblUyNc5ZZ+BOSEofkPRu6mMLNEGcrKVoHp0zqsTW4ups2+khf7J25o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6809
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:
> Benchmark command is copied into an array in the stack. The array is
> BENCHMARK_ARGS items long but the command line could try to provide a
> longer command.
> 
> Return error in case the benchmark command does not fit to its array.
> 
> Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_tests.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index d511daeb6851..eef9e02516ad 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -255,6 +255,9 @@ int main(int argc, char **argv)
>  		return ksft_exit_skip("Not running as root. Skipping...\n");
>  
>  	if (has_ben) {
> +		if (argc - ben_ind >= BENCHMARK_ARGS - 1)
> +			ksft_exit_fail_msg("Too long benchmark command");
> +

I think there are two potential issues here: too many arguments and too
long arguments. Current code can handle 64 (63 with last required to be
NULL) arguments each expected to be 64 bytes (63 to end with \0).
The above fix looks to be handling the first issue, with this the
error message could be more accurate if it refers to the
number of arguments instead. It looks to me as though the latter
issue still needs to be handled. I understand that this becomes 
unnecessary via the refactor in following patches but I expect that
this fix needs to be backported (cc. stable also) and thus
it may benefit from a precision added to the sprintf() that follows
the snippet below?

>  		/* Extract benchmark command from command line. */
>  		for (i = ben_ind; i < argc; i++) {
>  			benchmark_cmd[i - ben_ind] = benchmark_cmd_area[i];

Reinette

ps. Unless you have an updated email address that works, could you please
remove Sai's email from future submissions?
