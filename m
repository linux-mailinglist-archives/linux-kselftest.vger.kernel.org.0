Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D3C4D6A30
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Mar 2022 00:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiCKXOu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 18:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiCKXOs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 18:14:48 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBE01136;
        Fri, 11 Mar 2022 15:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647040425; x=1678576425;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9GqsJ9BhZ7cJpwuhmFNemtIt1G6/g6HgkRRlAkPURsQ=;
  b=ARXGdPi2f4++LZLooTG+iHKrzRXB8bDIOY7pPvVOTvfl9Wcl/rdXbLoH
   1VWq2MEVmNOvv6ZUETTTaJoXCx/uzKwmkdUpTzUtknophyIGyDNyjB1wU
   WPMd3WaJFw+7PDVp57TrScuMH2suwDEB+TiurOOvGEz4eF7Wu0dDJW1UV
   o1Ai+ADgFIkoJhFM0aaoKROp+ejlNKPFsLST5Ga/ureQQDPzP5n9nhFac
   ZvufcU3wlfdbaCZDAYpcth5Ahh1jFoESJrzqG5lQMbLS3gCatIqNfJfdX
   fHWKsxSdgjxpQ/CtvWFSZ1GBnYYBEi+k7KzBTyST8XOYIbft9EKw+q6K3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="316392714"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="316392714"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 15:13:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="633564000"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Mar 2022 15:13:44 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 15:13:43 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 15:13:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 11 Mar 2022 15:13:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 11 Mar 2022 15:13:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzdqFqYxFMK/g4yh0x4DuLZpqIXX0IGYMe55/BCJC3uKQxYU+SmoHMkTDSqDmN26VDG/pwPa/DOOyVgL7OMd6S6qW1ro0iXTOU+BtfRYIx9D7GWAJt86yzorVGdSNILNnJPa/vKWMXk3M8aYuy95h9KyCxFFsvHG6iNIEZ6shYELWrdwrmhFjudrxYrGs0hvWrBu0+5oPd09oKK+7+QT6wTSfRGu7EgOKO+cpSGVmFsVyvlIlWsDaBg7BGO3xNPKsl8UQdTxbF5zB3yZQsFyV7jefAkHOlo9VAQ8gGC1u3vPp+a0Qr4N4Xbmrny8H0XbGb1pppSE8PwsoLjqRCOfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Daz01MXEKh7+/U1Iy87IxN8KlISus0GxJi5aJinjsnw=;
 b=e4Qb13130OBeLvu8KhnXxkfl1gQ09V0fydc5zfwUrGJ3xy5jxy0ovcnbQA7cHZ4/1HdNdJZn6vR0nvOP2rq1fQ5SHf3tQdvPlrSasM7Uz8Rc3FsuiGp+uwHuzmcLknckLZr1aQtlguY70gpZS+7P+MpE1nYKYAcK+2z7XciiCTiVg3VcxwG1pYiYBiqq4akQr3rBc5ugJbfgFJ/e2O7q+wPsuxLdShIuYEfQooiVjC9vWDnhUp6XqRa/oik2O5wLcnco2xk3j0ZazTrYuHIrbl2D289/9ez8lhFm6gzHNxYmuXRg3XTVyFn6izri4AaG2B4BVXWcYpyq/rV8JjfjJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5740.namprd11.prod.outlook.com (2603:10b6:610:101::7)
 by CY4PR11MB1512.namprd11.prod.outlook.com (2603:10b6:910:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Fri, 11 Mar
 2022 23:13:40 +0000
Received: from CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::b432:16ba:2819:d702]) by CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::b432:16ba:2819:d702%5]) with mapi id 15.20.5061.025; Fri, 11 Mar 2022
 23:13:40 +0000
Message-ID: <26549e0e-d214-ad36-a690-03ac1fbbec54@intel.com>
Date:   Fri, 11 Mar 2022 15:12:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH v5 2/6] selftests/resctrl: Change the default limited time
 to 120 seconds
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220311072147.3301525-1-tan.shaopeng@jp.fujitsu.com>
 <20220311072147.3301525-3-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220311072147.3301525-3-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0088.namprd19.prod.outlook.com
 (2603:10b6:320:1f::26) To CH0PR11MB5740.namprd11.prod.outlook.com
 (2603:10b6:610:101::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8060cc94-a8a0-4376-0e08-08da03b4c797
X-MS-TrafficTypeDiagnostic: CY4PR11MB1512:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB151200A616E6C560709FCB37F80C9@CY4PR11MB1512.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdlrL9vWoQbwEG7qLFgF7PvW+Lvq4Eou6TfZJFE08CGDYbQfiSNJUDgRZuFsyl0ftaqiwk53P/hGSX4Za/F1vo0FqHCzfhrt8gYRqJ+GA0j+2FeySW3vOLHv8kO1/5glEuYPxc/WqufKrGo4ppjLo6nhcnxk7vKndANOOFJN2JEmU0tYiNJaZn7OHCx3e2FP/jdIOeq2DgTxdFHsPtmxM8hfDicv7cR56wZ9J329/g8zR1/HF2dkNjtXN/ln9nZM5dV+9hkcMqz+Wy2RCEt9acW04NqSxa1mEJ7kMEl1IPOv4mK3ZVpiRQr6ABIiCZui9pUsTgj7T9jJ1t6mhOKzte52gIPMHyULoAcZyzSERHAkJJ85tA6sdr4i060wtFwL1PmDt3Rxsz5W/uR+zeB0ZLnr09mlX98S4wYfTyciG4gi9kXHLvOmcVl0pQN0Ft6Dev6yNp29bmfRU0sOj/lsR8KUxca/sZFMVHEmDPlklHMiAIixYAvwayGzAgNwKTmncn4Y5x2yczpcAdfAm5Za2niHJy5frWCcdCJ0BF26+yputjghBkZnwfMKkqIC+Fajg/saRkUOXNDavQ9r5O18XEiN/x4tSXdSUq6DEVtHZ/V8XacOvdJxkPDkY+7AmfIsyMWuyekOvC8LDHWxBdWacwhaj/D+U9icqr0DgmI+5l2NH35W3A9YHI7YVPWvGrUosUvXs7DiMAnb30ABqGhiyBL5K2r14W5f2SEgCPuDB+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5740.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2906002)(5660300002)(26005)(66946007)(6486002)(6666004)(66556008)(66476007)(2616005)(4326008)(8676002)(86362001)(53546011)(38100700002)(44832011)(82960400001)(83380400001)(36756003)(6512007)(31696002)(316002)(8936002)(110136005)(508600001)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2JxeGVsMFdZbE1nR1lveDhpclFoMk50QzJONnQyL0c1L3B4QjlPQlVaN2dp?=
 =?utf-8?B?TkpqdW1heUR4QXJHS0dMdWZkUXhZT3FoWTdCWmUyZ3loWG85SmZIbXl5aGNE?=
 =?utf-8?B?Sk92RVhEdy9oRVlFdmtqVlRaNzVZMUpoTUpsdllTQ3lCT0l3TzBCVi96ejlw?=
 =?utf-8?B?RExSY3RjWE1Zd05UOHUwZklXa3dHdkpCRnhtWk1sSnJpQ0orRW5GcWFCZGVV?=
 =?utf-8?B?YWZEQlJuQlB4WnVGWDJiVGNhM2NkaGpvQlpLUXNmeVJ6alVpazBZbmt6K3Vl?=
 =?utf-8?B?TDFDYklFZ01wRHJTajV0K0NGNUxQUVdJWnNLQTRVazRKL2hHNmRiVWdCNmw5?=
 =?utf-8?B?Qys2VkxoZWFHS2x2bEk5NFp1YkEyNktKUXhWMEt2d05hOGpETUdTRGJqTVNC?=
 =?utf-8?B?ZWF6eUlGNnQvbXNob3NWc1NpalUyc2Zxc2VJVlFLaDdVTUxjcFFUK2tsTDhP?=
 =?utf-8?B?bWhGZHNpUWs4UjBpVGtVMUVBcXEvWExOazk4NTFzL20xaDN3NWZjQ3pqMFBh?=
 =?utf-8?B?WEc0alJ6OW1LZlo2UUx3Wk9zdEp5Z3pUOU1KaU5sZXZNU2kyTlZBWDlxZ2ww?=
 =?utf-8?B?bXI5MW5wcmR5dnNuRlBXY3AwclRJSkpoZGtpNmN4OU1sK1crTFh0dXRpMFlY?=
 =?utf-8?B?Q2tNMHhVUzZLa1JlVS85blRoRENoRUgwa3laanBuQXVYZlBudmw5dDA4c1U5?=
 =?utf-8?B?MkRPbUNGdVo1N3E3bFJqUmtLczZoRTNwdDBSeE4wcVVLN0NMVHRiY2FDS3dq?=
 =?utf-8?B?UW1FcTJrdWFEN3c3c3N1R08rN2NOcjhIOXFZNllMZ2FKaVRMOGpjazd2YnRj?=
 =?utf-8?B?VDJzaEZJV0ZXc29ScmRwS1ZwNWQrMnRTOU91WFlrM0ZIczJpYWZoSFpyZHpT?=
 =?utf-8?B?TE56UHJQejY2YzkydHVIUk5QSUZSTG5PcVN0VDAzakhCdUIyaWxQdUFnVmRo?=
 =?utf-8?B?ektXYUUyYmY5Y09jZFNyY0NPMW9sdjA2UTVXVDhWK2FDM2xTKzhUdkhLblhP?=
 =?utf-8?B?a2lRZ3RUNDIweEEwRFlpVnpnRWE5V2pHVGhUTGtTcmJiQUZTazNjazFqMG0x?=
 =?utf-8?B?a08xclljM29QL3UyRmNPMStHbVdnZ1JQZmR6QjRiRFNlWHFPTi9XRXVWVFBz?=
 =?utf-8?B?eGl3Y3RTYUdoUm9weGRwZGtoLzYwQ1VWb3Z6T0g0YW5qRVp5UlA5Vngvb0d1?=
 =?utf-8?B?UVo0YU1QM3lRSkY2OHJwNHhMb05wMm4xSDlMQVFSdXp4MWVwZHdkMysrb0d1?=
 =?utf-8?B?Y1I4aDgxalMwT2k5TUZ5Z0V0dDNGSzJReUpFNUlkNm9CSDBVbmIxWlMvVTNE?=
 =?utf-8?B?bHJDY0hHeTJJcFJzRURxVFp5SE9HbDVCbEp3WGpiczJGN2VnNmdiVHV0dDB2?=
 =?utf-8?B?K0ZCMGZqb015Sm84SElCWDVUc1NzaDZOSjQraXpqR3EzS2YxTVBxMnhESVB0?=
 =?utf-8?B?Mk85SXBVZjM2R1gwY1grNlZRbzg2SHRWVUkzTGJ4MVpOYWR3VVVXQmlBbHVO?=
 =?utf-8?B?djhEYUpYRVo2NG9wcUg0b0t2aGt5UFZZelBpeTdpLzlrVk5FWHpNZXI3SGtn?=
 =?utf-8?B?UStqemM5YnZiTHNZNHpIbnJDbDhFbk12TnFnVXI4dzhhTlpsa1ROd01rM0FM?=
 =?utf-8?B?UUF2a2xIR25KZm9NMDZRNlpQdW1LaGljTWhaWW5hT2RyeHhseTFERFp2WDJr?=
 =?utf-8?B?anZWKzR0YTROTVdtempXbHNOUGRUdUhPWklkNTlxZ1BiNXRIOVV0ZVk3Mnd5?=
 =?utf-8?B?NFlOUUNYOUdQR0lxUWozbUdBTmhFeVN3YzU3RlhBZ2VKdEVzVGphbXF0WnJt?=
 =?utf-8?B?VUgvTS9BWU9lM2hBd1A0VkhLaTZyY1BCS1dGYkNUOEhUMGhXQ1c4dFpvbXMv?=
 =?utf-8?B?cERVLzVwNXl2VURqNDB2cERvQVpzNDhvYnpJZGJKTTV1Rlg2WjdWSmpLeXRy?=
 =?utf-8?B?Y3MwNW9TVC9YWUkzZnI0Zkh5SWxERDNMK3RFQmR1VWQ4encwaGpMTGlIb043?=
 =?utf-8?B?ZzBLTVo3YmNSR1VpcFIrWjdXOTVvWjUrM2tlT2RueklFRDdOU1o4aXRVZm5h?=
 =?utf-8?B?c1FlREZFek03WC9FUTNLQnJXbkFkNkhDQTFWWTlROHh5NUlRUXFULzVtNHAx?=
 =?utf-8?B?cGUxdVBycmpRNFZtTWowTjVxZ1dRWVVqRmF1cVptbjhIZEN6TEpPMjVTY0o4?=
 =?utf-8?B?SVQyT0xGSU43SDRwa1l1V2RRVi83VnpLcWlFakZodmlhaUdUUisrRW04ZU9o?=
 =?utf-8?Q?RHdhi71BmNQ2SCZ9xflilYKxZy5XsgDTGluUCab3+o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8060cc94-a8a0-4376-0e08-08da03b4c797
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5740.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 23:13:40.5626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlA4Mwb1YPhDQi9di7zM0pPZh3rsaaufVCTmaRDg11QNA2v7hWV2N3FFFYbJDxZpNSfg93h9oj+mRmvG/5y5/ypKkicvhknyAqPD2OArxmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1512
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/10/2022 11:21 PM, Shaopeng Tan wrote:
> When testing on a Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz the resctrl
> selftests fail due to timeout after exceeding the default time limit of
> 45 seconds. On this system the test takes about 68 seconds.
> Since the failing test by default accesses a fixed size of memory, the
> execution time should not vary significantly between different environment.
> A new default of 120 seconds should be sufficient yet easy to customize
> with the introduction of the "settings" file for reference.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/settings | 3 +++
>  1 file changed, 3 insertions(+)
>  create mode 100644 tools/testing/selftests/resctrl/settings
> 
> diff --git a/tools/testing/selftests/resctrl/settings b/tools/testing/selftests/resctrl/settings
> new file mode 100644
> index 000000000000..a383f3d4565b
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/settings
> @@ -0,0 +1,3 @@
> +# If running time is longer than 120 seconds when new tests are added in
> +# the future, increase timeout here.
> +timeout=120

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
