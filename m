Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D8878DBD9
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbjH3Shl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbjH3Rrg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 13:47:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415CC193;
        Wed, 30 Aug 2023 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693417651; x=1724953651;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Y2YCbcitUYBUY7fLEzP7RixtK1o2xg8faMyNqw5YlU=;
  b=Vi0OGjyZ9VsLSY1hlfSp7BfMnLmD0NJqKtb2Ta4q1aehPehrhij+pL+1
   m/lIHbJKet4wLIfA5niY6GvKtDEN4O5E4rSES9hV+qknId/SeRE8xf5Me
   YkGSr3bpOK0OeR85/I7/RkmZ8r2bYJl7CABR+u63OQRwA+AkZ9hHu5PpZ
   F446ACA1o8UXmW0JVkRaTRPagsxLpAuDidTz9CqH+2ZMGNiijkGMrZzlU
   FAWojP0NvMNljpCwMFEIEzGfRQX4BgkZME1A+BGLihNn46lPwT+mcBcGc
   yNuYy8AYLYUXnVbx81IXFvMzgBfZBBY8B6o054xbYD1xBVSI+TYv+BzTg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="379460040"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="379460040"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 10:47:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="829320007"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="829320007"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Aug 2023 10:47:28 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 10:47:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 10:47:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 10:47:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fC45ZecCXhkhw+ahKVWbOPBxRgwFHOhF4XX1LdWzBUUmg52DMW/DGBPAWhUvUvRBs+dNq4zQFxt3pbdVn9Nru1F+hE66+kBp4vP0M7BDRWESeRp6Uz88ADRoQDlCmPkLR0egToiitvUy6unDoxbxKylhGuT7PoUd/9f4/h+53l6cMLAsKCoH7s4h2j1+qyTaczv8kWh+v0QSxWbjQJyhWY2lLtB8D8tHwUeCzcg2OcA+Ma/Zdk70ukx2WFTvqbp/P+7DEATtg0Qx6AxL+DsRCY+W/vRI/QoK7XrRZ4faDHVEoaW6AN2OyhrzOrU+f8cRElTEyHFpqov3/PrWG5hzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGpDGuUozhbWEuH+EkW8TaRHUnvJwbohDl3Up1qF2Pk=;
 b=L7r9uckuC8rk6UvSgq3L6r7SvipUj5+Dwy4zDIJxcqlrw1HHBrF1RDbRX8eCGUN7psMVXNvzzRLEsTVQ6vy6wqcyvItwp9uvZLNJsQv28QJWgyDFvMPI4HbpZjDu5LqwCMOiF3x0SozricM2Xev4L6s+l3nnJit9MOSmEuzfV/yvQz5E/xqHCUoSLzKLYIIOdMIx93Y2Fuh/regSc3N+z6WuWL9ai+YIa3RNXHPgq7Yxdcc3+c4BfsaVFwRHifgVL24yHnz1EqZLxnWTGyfrQcXB61f2Jvhe5Le04EqyytWMo28JUhaFVB71bnIjrXSLkWmE++6a9IPkcpvrNHhT7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4892.namprd11.prod.outlook.com (2603:10b6:806:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 17:47:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 17:47:22 +0000
Message-ID: <159d8e07-cab7-9430-b83f-9c6de4d519d4@intel.com>
Date:   Wed, 30 Aug 2023 10:47:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v3 5/7] selftests/resctrl: Make benchmark command const
 and build it with pointers
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230823131556.27617-1-ilpo.jarvinen@linux.intel.com>
 <20230823131556.27617-6-ilpo.jarvinen@linux.intel.com>
 <bafde7cd-01ae-56ff-c1f5-53be610c2b10@intel.com>
 <184bd8bb-5622-64f9-9f65-6674db935a21@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <184bd8bb-5622-64f9-9f65-6674db935a21@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0148.namprd04.prod.outlook.com
 (2603:10b6:303:84::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4892:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ff9a6d-83a5-4791-75dc-08dba98129f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PF0D8LKD19Mr5YcROhyq5ngqTGoRPeydV6sYzfSRYBGDuSkhHw/Axf47HGlxGYwAXX4T2oPYpC0vygmqVsVf3w8cVhRYqgAkWqz06NsNXYCxVn3eg++qRwq7Jb3jxGTeQq/s5axBgywdNWPG8DjyfSCBKkUVeW8O18gQ3+mUhaPF1k02G0QMZ7RwnRPQDeB4ttNQYxTFWaSXQCn8sU6nufyEI4ie6PlbHKoiYjO55vpMShPRDhjMWyLU5MDyLd4rKvy6WVpFbOSPI5SDvlARuo0jfDiyMUiFBxnciiHYp/gEI2mFc5qM1dVQxH1FESZwOWi9DI88aMtaX+nL985rxcWFzqJfVnbqiLeeJO43K15yOROSWgfQ9noWR2GfmdS45UVwst93asE3gvzzgrDLXPARnH+wIAmU2qM/GTlrmv7Ib9lk+VLutAfHFmmhAgKb4DDOz2IwJjHB4sCkv3I7crakhgfaZ1Zn6STn9n2NeQE0OrdXP+gsM9r4eBRJp73wJTpksb/dwjEaTtIrefeqP0HpAcKMoJ4SRXuq3oxGZhQ7gYt15xwc2i/w4FMonAuQDIpHWUcZrPrmRsX47N5e4D9DKGfOLhAni6kYW0NmQW7Yl3PXdeQ2+PpkxrIl2VZyz7yYYDZ+b1fRKSKZomgbOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(6666004)(66946007)(31686004)(478600001)(53546011)(6506007)(66556008)(66476007)(54906003)(6486002)(38100700002)(316002)(41300700001)(82960400001)(6512007)(8676002)(26005)(44832011)(36756003)(31696002)(2616005)(6916009)(2906002)(86362001)(5660300002)(66574015)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ZNcFc1dkgzUElUU2hvdkgrR1Yrcy9aVk5QajFmMm9YMk1sTGN4dnkvckdL?=
 =?utf-8?B?aVNlQnBPeUhjeWUwTU91Rmdzbm1EWVpGV2ZOS0FsVXJXK1NxMkxBays5ZTBr?=
 =?utf-8?B?L0tVQk1NQnFncWxYZTFLampFMXVXbnhTc090WFVmRzlMZkplMm9PWE1NeXJn?=
 =?utf-8?B?OU5PL0dMdzlsWnNxV2hpNmhCb00vK25kdFJoQVVJT2RsY3k2dGorTWVYS1lX?=
 =?utf-8?B?S1lVaWM1NS9lUnhBYTQwMkVSWGV1L1pmMWxIV2JpS1QydUpEbm1qak5Zd1h4?=
 =?utf-8?B?ZmhCVXhGSy9VWDQyNytMMXUyWTlwY1I2ZkVRMURXbUNEUU9HSFUyUW56OTE2?=
 =?utf-8?B?c2cxSnJHMzVTN25RcytpNmNVOHdtS3d6S2djclVSYmRvN29Tb0MrYjZGZ200?=
 =?utf-8?B?eVA4aFJZRlNxc3ljaXFwdjNIRk9vUDVkV3hKZFkxVElwVjBYTzJVTGRLNy9N?=
 =?utf-8?B?bFM2TW9jM2NvV1phaDQyRDVBSkFaTkJ3SkN4R09PdXJKcE9uUUgrUVZNUmd0?=
 =?utf-8?B?REVCdWZCTDl2NnRQSHo0ZUdMYW1iTzIwbVZsVkNuYWxYMU42enFVdGhNSXRD?=
 =?utf-8?B?Y1hYWFFlZTg5TlpTQzFvaFQ3VHFjYmswRTc0Skc2MERDbE11N2d3Q1FwNTJR?=
 =?utf-8?B?OWtCbk00SEo4TWZUeFM1K3ROb3p0cWJUL1VEUG1NYzNJT3ljSXA4RnVLZ01Q?=
 =?utf-8?B?YURRajczcTgrWGozYXJOcGFReXFLaWlJTkdabXZ0STNSMDcxNzhpelB6N0l3?=
 =?utf-8?B?QzJSY2FkMkJJbmszZFkvcTltejNxTGlqYi9mcjgrMTQwN0dIejd1QkNFRVRB?=
 =?utf-8?B?MUZRTktFVDZ3dnQ1aUxkSU5rZy9IcXREL3JRU0FQQVdxUkgrclgzN1RUd1VW?=
 =?utf-8?B?UTlNdnhqZXRoL0FQeXJRZGh5N0RDc2xPOVUyWmRUdWNyWlVLcGZOckRGV0xO?=
 =?utf-8?B?MUFTdkhBNGtHdGtGVzdVZzRSNXZ2WnFlR3UwbVFOUXJqS3NZTUpwT3dYckFK?=
 =?utf-8?B?VmVUc0xKUU9hR29yWXNXWWhUYWh0SjFCUFJVYjMwVzNSNUpEc1dyczhndjRt?=
 =?utf-8?B?dDIvVTUzeDFCUVJ5U2kyOW9pSGpoUHU3ODlpWEV4T3AvN1hLV1l1V3VrRDBE?=
 =?utf-8?B?bUVpUU5PQWFuSjJtL1h6TkxtY1Naakt3R2lmWU1IS0k2TkJNM2lHMXg4RnBS?=
 =?utf-8?B?b3NUV0J5K01rRTJuUkFZVGtuNE1wRGhuVk53YTFpSTlKZGxDRWsrbjQxSXZF?=
 =?utf-8?B?ZzVpWDR3dCtleTQzbWJ3OXNsZW9oeW9oR1NTMlRTdCtUNzdIZXd6RytWK0FZ?=
 =?utf-8?B?WS8zQXlxei84ZE1MK1FkT3Q3N1Q5MmN1S2U1ZnVWWUNvd2hHdVhFOUdTZG9u?=
 =?utf-8?B?ZWhJZmJOdG90djNGZXBRYVUxVk5QRFdLTzJlUFFzN1hoVkU2STBFdzZrcnI4?=
 =?utf-8?B?TEZReWNvWm5KdE8xek85dklzb2Z1Ui84OUR0bU84blc3REswbklLalk2TmNl?=
 =?utf-8?B?bzFvSktQVzBYRlk0ZjJSeXZ5T0tiR1hJK1lKaGpDNTJsblNaaEVzb3FSaUtI?=
 =?utf-8?B?OFE1MEFOblBFbVFVOWgrTkVwREQ2ZUJPWm55MUNDKzQzcThNeUp6dzhUNGM4?=
 =?utf-8?B?WEl1ZVp6Sm1DMDFaMzBSa3dMY0pHUnF2amg5bUc2MFJmSEQvcnBvSXFxZy9M?=
 =?utf-8?B?bjQ3Zm9PU0JlYXBCa2g3dFVjODVDZ2ErY0Z5ZnBudTFNSzFyOEF4Uy9aQnl0?=
 =?utf-8?B?d2FCTmZ0UHliZHRuYWZPdFJXeUdBN0ZBZDdBZCtoaUNjZmJEZG5KOGRLcmVo?=
 =?utf-8?B?OEQzbjFJMUYxZmNodnNHcVJlWEc1Y0NqNmo3aitTSmF6bDd6SkhMZ3ZDaUY5?=
 =?utf-8?B?NVk4bTFHYlZhN2VHNGVJaUQzQTlWcUpoT3owa2FLMnlUVzBvNXJuSXRyYkl1?=
 =?utf-8?B?NFdFTUUrNFRYTDNoZmxIUkZpeUwxNmRxc1Q5NGtwaTBnODcyZVpSTFZ2ZE5K?=
 =?utf-8?B?cytuV2g2YW01cWdFV0JpN0JVSnNYbGZ5ZE52YUozS1N5VlJhNXkrdzZva0FM?=
 =?utf-8?B?VUg4bk1oMjNuKzE2cHhxQnA3MVVQWnRZaUpXSHkzbTVhd0duZDJPZEpYU2Er?=
 =?utf-8?B?VkN4dzc4RjA0dUovbjFOMkRKRVFDMjNIM2hKTkNUWm9jU1BEaXl1clMrY1BN?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ff9a6d-83a5-4791-75dc-08dba98129f4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 17:47:22.4640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8f+GsxBeXz5da+i16fZcwmNNpNCBB0dbkWp2FZzrHfgSC4bIh5QILkhR52wIyV6Ib7XKZFKPDd+yP/ryKrgCIHn9xxvMzCrzQGxcx7l0w6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4892
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/30/2023 1:59 AM, Ilpo Järvinen wrote:
> On Tue, 29 Aug 2023, Reinette Chatre wrote:
>> This is a tricky one. If I understand correctly this goto target makes
>> some assumptions about the state (no test plan created yet) and exit
>> reason (it has to be skipped). A temporary variable is also thrown into
>> the mix.
> 
> So in the end the symmetry proved to be not as simple as was depicted 
> earlier but "tricky"... I tried to warn about this and it's why I wished 
> to avoid the allocation entirely. Without allocation, there would have not 
> been need for the temporary variable nor adjusting the control flow with 
> that label.

hmmm ... I do not see why an allocation forces the use of a temporary
variable and a change in control (more below).

> 
>> Can this not be simplified by moving the snippet where
>> benchmark_cmd[] is initialized to fill_buf to be just before the tests 
>> are run? Perhaps right before ksft_set_plan()?
> 
> So I throw a temporary variable into the mix (has_ben) to keep track when 
> benchmark_cmd needs to be initialized to the default command? It doesn't 
> play well with what I've in queue after this when user parameters are 
> collected into a struct which is initialized to default value by a helper 
> function before any argument processing. That is, initializing the 
> parameters to defaults needs to be split before and after the parameter 
> parsing code.

No new temporary variable is needed. Of course, I do not have insight into
what is further down in your queue but based on this work I do think it
can be simplified. Since code is easier to consider, the snippet below
applies on top of this series and shows what I was proposing:


diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index ae9001ef7b0a..8033eabb9aa8 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -170,11 +170,10 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 int main(int argc, char **argv)
 {
 	bool mbm_test = true, mba_test = true, cmt_test = true;
+	const char *benchmark_cmd[BENCHMARK_ARGS] = {};
 	int c, cpu_no = 1, i, no_of_bits = 0;
-	const char *benchmark_cmd[BENCHMARK_ARGS];
 	char *span_str = NULL;
 	bool cat_test = true;
-	char *skip_reason;
 	int tests = 0;
 	int ret;
 
@@ -247,17 +246,6 @@ int main(int argc, char **argv)
 		}
 	}
 
-	/* If no benchmark is given by "-b" argument, use fill_buf. */
-	benchmark_cmd[0] = "fill_buf";
-	ret = asprintf(&span_str, "%u", DEFAULT_SPAN);
-	if (ret < 0)
-		ksft_exit_fail_msg("Out of memory!\n");
-	benchmark_cmd[1] = span_str;
-	benchmark_cmd[2] = "1";
-	benchmark_cmd[3] = "0";
-	benchmark_cmd[4] = "false";
-	benchmark_cmd[5] = NULL;
-
 last_arg:
 
 	ksft_print_header();
@@ -267,23 +255,30 @@ int main(int argc, char **argv)
 	 * 1. We write to resctrl FS
 	 * 2. We execute perf commands
 	 */
-	if (geteuid() != 0) {
-		skip_reason = "Not running as root. Skipping...\n";
-		goto free_span;
-	}
+	if (geteuid() != 0)
+		return ksft_exit_skip("Not running as root. Skipping...\n");
 
-	if (!check_resctrlfs_support()) {
-		skip_reason = "resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n";
-		goto free_span;
-	}
+	if (!check_resctrlfs_support())
+		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
 
-	if (umount_resctrlfs()) {
-		skip_reason = "resctrl FS unmount failed.\n";
-		goto free_span;
-	}
+	if (umount_resctrlfs())
+		return ksft_exit_skip("resctrl FS unmount failed.\n");
 
 	filter_dmesg();
 
+	if (!benchmark_cmd[0]) {
+		/* If no benchmark is given by "-b" argument, use fill_buf. */
+		benchmark_cmd[0] = "fill_buf";
+		ret = asprintf(&span_str, "%u", DEFAULT_SPAN);
+		if (ret < 0)
+			ksft_exit_fail_msg("Out of memory!\n");
+		benchmark_cmd[1] = span_str;
+		benchmark_cmd[2] = "1";
+		benchmark_cmd[3] = "0";
+		benchmark_cmd[4] = "false";
+		benchmark_cmd[5] = NULL;
+	}
+
 	ksft_set_plan(tests ? : 4);
 
 	if (mbm_test)
@@ -300,8 +295,4 @@ int main(int argc, char **argv)
 
 	free(span_str);
 	ksft_finished();
-
-free_span:
-	free(span_str);
-	return ksft_exit_skip(skip_reason);
 }
