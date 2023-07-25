Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733D6761D55
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 17:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjGYP0K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 11:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjGYP0J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 11:26:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E196187;
        Tue, 25 Jul 2023 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690298768; x=1721834768;
  h=message-id:date:from:subject:to:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=lCGG2S39gl0Cejc5VbTJun4sCFJTSS7W7m28Q2fJoeE=;
  b=kPPS3g4R/KQ4PYYFpuloOtuQzbx4IXlxybd3CQ8Wdume78JDHeMNGmDr
   ID7Mt6HgGvbqJupbgapSlP+d2r5TgFd/biS7gDHtg9AIrHeGQGralxfDe
   LhfbpYq8u2Ms/QTBtxUBJx/tXQYvl06jHJ7+QM8et1TExGiu3YBTgeGXt
   yhpXr44m3q370h5sC4nNtgfkh7NCTun0iXnLPdgUj10rsL3+IB3qtf/dr
   7BnoU/dpul0F09vbkPftj9isxGUkno6IFEUxiECT30iLddQQTzATFlfMl
   HTbyhrAvfo1R7QpizaChsfvku+4Jx1F9CJK7Q6tRB32O76L76SIvZKch9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="352660356"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="352660356"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:26:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="761247964"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="761247964"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2023 08:26:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 08:26:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 08:26:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 08:26:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 08:26:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0FlFGAh4nEtXsOyDKKKm8p1CEcaSuRHLO1XXlUayGw8fnwarQTK6kjEwodKzKlJzTt+gQYIOpboUJhPk8uaGtdl506e+OKQ1jqymXCNjC+yDNvx+szCh7gjfNAROB9yu9V3Tcrk4kSl55vTK+G8u+0sZHuOE6Lul/U9AA/GUbcSLjzUS6WRtEHiIihLcrxsOTP1x6hYUT39qP3f7PUO9IMp1CVZux5VE0tuWBsNZpMpcs7BonBQJk6u2P8FOUbQJkjWJXdxZooQO/CY/vcuZ4bcH+jVWz87c+o0IMSWgOqTs8fVmBmIUtvL7HBrXptu6ttj1F0y6k76gG94rhzdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMh//1ic1f6ovLfn2XGY8tN3WeA56c/kJq4yVGlAnfA=;
 b=GJbrOR/HGEhNXi24iMYJt+CXbVyxz9PsHs8dS41odVafYBq3OIl79V5vvwWUCr8HtUx3J9CNoahGJMG9GqKnZxbzMfndgI99aCH4nxTVDc/yhbTApoTAOr325SOroyW0GrLI2hWCVQFH1vLLFRbTvydIM9SYSy04Jj/yJLoYJ3oJN/ZfBMnf2LcFAAfpajrbM5QNZ6VPpov6jYXlgrb8ldE4WQC0G2cXVyZy9Ez9lDZeHf3nuG4dB9zaCjVnnVZoHWdsJ9i9UF011+URwCwl8itje045M8DjpmkYc7Sl2A0nTZurhexxL5lv5/b3WLFr2oU7ua7wUEqy1fUTZb9PXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB7769.namprd11.prod.outlook.com (2603:10b6:610:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Tue, 25 Jul
 2023 15:26:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 15:26:03 +0000
Message-ID: <586c5547-1606-45b1-53c8-c322d7954c8b@intel.com>
Date:   Tue, 25 Jul 2023 08:26:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
From:   Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v5 04/19] selftests/resctrl: Close perf value read fd on
 errors
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
 <20230717131507.32420-5-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20230717131507.32420-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0159.namprd04.prod.outlook.com
 (2603:10b6:303:85::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 647de627-77da-4432-dcff-08db8d2374bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nECTj2ImpwFGZu+31IfP+PK2Wr39xB6comKPqfXONfp0/AfYsFnmGs/1Tu+TH9ehL5F3vgZeZIQnQy2GrDXeXza9pkPzYNK8pppGUvVE1ybetLo4txB+itvxoSm9QEHvz+aapQl041Lizib55n970iGmtL+WiqlpCGg2v+vbnnbsc3Y3RyETj8TSUsbaCK9j0ZGsZKfdtVDm1atdY31vSAXSvopXPe/7k1L2I6VKFjkyFxdc0+3UvDikTrlBCevyFHRGsfwPwV+txyxoroN1LFKNQuNeCc8cIf/lSboH+axZE6ycCyDJrVadmfC++NitmPGGvfemlAvUey91dbS6e5I0AUc47pNZ3bH5Xtk4aIUIpdovrhEkFE6NAlpTKPH3K7XO/TKGgqVYm/DP0ip8RIyXv8I+wt06c7RcJ2gNj6I39OHuKmcvcrQn8ksK9Tirst4p9KagX8HlVOMkgWdWodw7HYlPeILeHn2F5LUvn1/5nI4U6GqSnq6l7H3EKqiUIHvRmvsje9dNQ+O4YPsK5Ug80T+w+x0wl3MDeTjnUEB3pILHK8XkIRYiEzffbmVEBOi9h7N3z8nqa/XNACUsJfZp95qqILRzUUdO19dLhIUoM6VyMNeURwaNH5nBEDYOwNYM4r3YWABggvCRSo6Y/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(6512007)(82960400001)(31696002)(5660300002)(6506007)(83380400001)(2616005)(66574015)(186003)(38100700002)(41300700001)(53546011)(26005)(8676002)(8936002)(44832011)(36756003)(6486002)(2906002)(66476007)(66556008)(86362001)(316002)(66946007)(110136005)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWpmSWdrcnFsTjhnd2xoTmo5cVJJRGN2L0Q1c29mdHQveFZFVk1xWWxNdzFk?=
 =?utf-8?B?bnZDMkdVT3JQNGRYM1k1bnpBUE1yTDdtQ3FOdWlrRXVFa2RhaS84WXFMdC9L?=
 =?utf-8?B?VlFyMkRqMktVYnN2QW00OGg1OGpkR2hTN0RiUDkzQ21GMW4xS1RreGtpNUVG?=
 =?utf-8?B?SkluUXU5WlJYcXVFaTd4c3llR2IwNHJQQ29kY1ZIdCt1ek5qTjYzVHc2RzVq?=
 =?utf-8?B?N0tKekpmL2xrc2Q4UW91VzlseGZNUTBSSDJQYVg5cGNibUl6cnRiVzd0eTZh?=
 =?utf-8?B?aE5EYlhTWVBEbU1iMnphaTJTOEh5VFpXYmNwUEJTcXBpbCtZMUwySTlkdGtv?=
 =?utf-8?B?MlhTUlhyaDNzMlpuQzJhMWZhUXJmdmhhUHp3bklwVENnYmNSTzM0YXpzWEJ1?=
 =?utf-8?B?UjQwRUdHVGtTUWJjN3lOc1RpeUxrWmoxRCt1Rmw3elIwVFRxNjlCWVhtVDVp?=
 =?utf-8?B?ZU1LTUdPNjYzU0Y0Q2RJMzdUTmVFRzc2UEhXTWx6N3FwWkZRKzBIVlR1QTM4?=
 =?utf-8?B?T3hSOWhjSUtsUm90ZjJib2JmT3FiWkhGRE5LcUtuZDE2WGViK054aU0xbTUy?=
 =?utf-8?B?OXlIV2E2R3YrK09EOW5zS1g0U2dUT3pJRkFBVHVsRjdhcG0wUGdjemVTQmpi?=
 =?utf-8?B?TzRaTGxpd2NPUGlldWJXOHpsOTh4UDZBQmtDb0ZXY3VDQktKMDNWemUrRFlW?=
 =?utf-8?B?dCtTR2tEQWNQRnlDSVZubmV6N09yaHpVOHFEdlVOMHZJaXNkWGN5NUJ1UC9q?=
 =?utf-8?B?OFNRSWVrbDcwVC9teVBSb2ZDc25hb3FvejR2c1l3dzBqSzVIeXV2dXFsR1B6?=
 =?utf-8?B?dmlrMHVFUEdWSlNvN3RyYzNTcDRNMVExSmtoUFEvOVNJbUN4b3NlaUxxOXF6?=
 =?utf-8?B?cTJpSEZBNXZ6VlBRSS8vMWlWcmplSEVmdFVVdWcvN2E2SlRzT0xCVkp2UmZ0?=
 =?utf-8?B?M1NEVjA2c2RVZkxqeGN3MTFCQWttVnRHYUhvcFU0elYzUnM5UHVEQlJ5TzVB?=
 =?utf-8?B?aEdRQmxtckNiSmFta1AzWVZhNjVFbWY4cTJwekVyZDVZZ25WTlVoMnM1Q3Mx?=
 =?utf-8?B?M0tIT3dva1BxTFRPcXVsSjQ4bkVyck1yZUJJT0JqZzBXSmJYbTU3ZUM3MmQw?=
 =?utf-8?B?VzlSTGN5TndJRmFHbmUxdjBGNnlWTDgwS1VrS3NCVWFtRG1jLzFsemFxa2J6?=
 =?utf-8?B?R3lkakxjcEFsWk1MR29PSW5CTzdXNHEzUG9YOHo5MFNxSUg4UG85d05DcDMy?=
 =?utf-8?B?RUg3bVNhdDNPY09mb2phcWZ2VG1TM2NzQmxFVFRodm9tdkdEOWZ4UE5RdUhi?=
 =?utf-8?B?c2J5ZjJWVS9tdnhKMXZ1enpIaStQRkNNL2ZHek9vZWVIcWNmZDlBNEhTd1RM?=
 =?utf-8?B?V1ZQbFhjeEhTNkw2NW1IMFpxT092aVdsc2cwWCsvbTF6MXI0WU1yVXBmZHQv?=
 =?utf-8?B?anhJb1djNDFwcFBRQmk2QkJBaTBVaUp6UGJpZDNlT2xLR2N6bGhYcDZPQXRO?=
 =?utf-8?B?VEFYOFdycFFLQkdDNTZ1dERDc0dDVFJZY21pZGhXcEpxeW84M0RvdVN0YUNL?=
 =?utf-8?B?aHJiR1VYMkxLT2NZbDlhTkpjVXdIakJKdjFFZm1TWnYzTCtwMGE5TGt4aDJT?=
 =?utf-8?B?a3RrODBUV1QzZHozR2ZRYTdONzBLSGNoQlN6WlVUemdIQVk5bGpuV3NTOXRu?=
 =?utf-8?B?VEpVc3FPZjYrOGs1dlZGYytheDF0bk9vZWFhUjJZV1BJcHZrd2x4aHoyYkdG?=
 =?utf-8?B?TERRelBFZExMZUxhZ2MrTGgxekxHVHFTNndJMHl2dWxGdnJ3NEFoNlhGWnZv?=
 =?utf-8?B?VEZrK2VVQisyK3hOZmdrRG04Q3pmTlhzNXZ5dW1zNGt6K29ISnJPbG5hb3pl?=
 =?utf-8?B?dXg1YURIaDYrMkdITmhXU05qRzFzVXI1SFl5d01OU2VZWHRQcTcyUTdyL1VD?=
 =?utf-8?B?anlxTndlMlFCeFhRdm5xS2FlbnMxN2o4a3hUVmJoRjduV2lwTlJ6WEQrQmgw?=
 =?utf-8?B?Z0xLY2VNN1lDZ05VR2txakVtc2s3eHMxVWZGMGVNUzFGVDI4Zm8zMkZXTzI3?=
 =?utf-8?B?dTVQbWthdlZ1ZWVvNjZQUVJybHp5OWUxdXpwNnM5SU5jY0ZWYW11cS9ESk9E?=
 =?utf-8?B?Zm8xNHIxbjNoZUhmT0xWd2xRUyt3emdPa012ZElkU2tMMERHZVMrRVQ3RmVB?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 647de627-77da-4432-dcff-08db8d2374bd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 15:26:03.0280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmoG/0cZjLrppUSmkXhQCBa+SvhzVyCgGPDZpiwRxvFHm5wD0EoxaQfsKXLjkSWLBwPNR+N6lVkZy4Lf2oDwssDm89tRL3Q1E8vJ80ySUfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/17/2023 6:14 AM, Ilpo Järvinen wrote:
> Perf event fd (fd_lm) is not closed when run_fill_buf() returns error.
> 
> Close fd_lm only in cat_val() to make it easier to track it is always
> closed.
> 
> Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cache.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index 8a4fe8693be6..289b619116fe 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -87,21 +87,19 @@ static int reset_enable_llc_perf(pid_t pid, int cpu_no)
>  static int get_llc_perf(unsigned long *llc_perf_miss)
>  {
>  	__u64 total_misses;
> +	int ret;
>  
>  	/* Stop counters after one span to get miss rate */
>  
>  	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
>  
> -	if (read(fd_lm, &rf_cqm, sizeof(struct read_format)) == -1) {
> +	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
> +	if (ret == -1) {
>  		perror("Could not get llc misses through perf");
> -
>  		return -1;
>  	}

Above changes seem to be remnant of previous version that are
not needed.

Reinette

