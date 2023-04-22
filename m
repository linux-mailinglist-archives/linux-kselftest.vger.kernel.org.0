Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAAC6EB667
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjDVAUr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjDVAUq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:20:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23340F0;
        Fri, 21 Apr 2023 17:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122842; x=1713658842;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5+oWCZTR1NaHevERPu2xEaPu3HZ5hrcdvRRUzXwRL2U=;
  b=XUn1VO3pkBO6jAjD1/1ZskApwrqiiqdw6Cz4+ancHtc1b9lKNVvpJBo3
   ej6GyQU59szlrsn08UFZ8DPoMd4gbgZViUy9iUBVQItAuHz2WKM2udIQ4
   hCNL5smRqMboTJ3qM7Hw3GilQYh8gGoRldEzbD3GwhlZ1jlrSwru7sLdP
   Ld3PF3S4r+4ATew6z71g2VfdQfGCWxdHeKrzCboiNe2Dg/AFMa5AoVv2S
   uxfhwk3FVK5du2KJv9PD/6mgdHYmofJ9MSIpYAOCFnrr/rs5qM1PdNfLG
   tdzZit2qK9RYp4ZwjbNe5E3twlXj67xZBfkh23or05EwsyDKmpZqe+ZrC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="346129099"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="346129099"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:20:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="722938172"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="722938172"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2023 17:20:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:20:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:20:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:20:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:20:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B66nBmVdjVFwUZGvO2MrDRYxsmTyp4YQusuVNGmfhJWnL+I+UJlJC00b8KAFOh6b1RlpiJfXSiSM99C66BFhDhhNyXYPly6nZ73RpZXbZZdRZJiHedSHUop4SNnWEKI3oUnQBQZ/uAdj0iKwVMGkgnGaXRPl2wYhvR+yI/JkarK8ZfX6YGVo/yvawd2b/BvcmKAUeJB2/tr11HyXT0Vhl9uU2Z2Dd2Vy6qY5XgWLY60McJXlenFAez1f12oQBNdUMchSCr6T4kgV9vJ7Xi9rZrdPgG85B4sxfB2VjrWiUT2UpFuNtuqhcyGT+smaScCar7ySuS76om7QXf5Ebdkv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8SN+AEAJbWb1ZCvyZTRQpDIKcWD+0gssS36YapxA58=;
 b=XWm98YuQGHU9TLY70CcagDZ0vTwmrk9F6HzMFSLp/pXZyiWwX2KMXDOCgoetnxqdfpf1Z5J5lNr/nd7Cpo1ZQLe+loh5jkVvef4v2swPBqaUsngi2mg+P4i70hivZfWbbqZ/yHwmB3uFzZoOhl7AUxXy1AYRjiUDdNPxDuMVqTfgXYmZkfLCYerQOqEkVxTDbSmJ4IBcRmdm44orDvj7kigjXLkNfKcC6/OHy48jNMQpSoqhawygYgzTvfb0NOoDjvkzp0WnBygO+CIn4si8oW03CazjbKrL8menALQiNT1o09V95Rewe7J7oEr4jrnfz3RePvNFddh3kQ5WuXz/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:20:39 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:20:39 +0000
Message-ID: <52d96f37-3068-25c7-4a1a-dcf76a3d0870@intel.com>
Date:   Fri, 21 Apr 2023 17:20:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 19/24] selftests/resctrl: Pass the real number of tests
 to show_cache_info()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-20-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-20-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0072.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::49) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN0PR11MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 6162c642-cfa6-4198-e9c8-08db42c766ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkdBO+oyl6yXvVsOAMVBAxzy93dm3UnjS+qqqYX3r0P9gfieNhb5mJCoOuJd5Z5GfuRzdvOxgQDyIim23RBwK7wwv639FxEjd182KWfWURwCt1LYE3UV0MvqxCbYZFDJVvu7urnaM+K7qhG62lCtp4CXbDKFN+3VsS5VP/htvwUroJmzGBwttUEMGFVBb+fKIKpzvu08t1xJjt6MEtcCTz2DY2s30P1yhM37YfG9vKuUshJ9Rtw1I93HcUefF9OmJt1h0Q0ZTUiTzC/X3W+0uMTOnC0AOwM18f7JQJa6RVC4gx33UgC5RMlLQKSgUVSwkH31aedHKCK8zCPdOZsE5fWsN0xuzCerMvORPcAraGz131rPu2h7ji4ZXBrMJ5r0IzrMXsdn2v0/2UqDniGyCB6Ipv2xR4lKEjCHnDv4ZQbjFWhuBaHezVe5US0YkWr5+gKfs22nq2ZkiKdACQ2XemZoVhJ9rECIdB4cIsTmU7YN0WuIFXFI+wq4ylnUizBGQZ5oJyu66TwkSoM2qWB3mGv1ewhbQbR1LnWaJ/GYJE5HSl1tP7PCS3zfosBu6JoqJgDx3OjZBw8/l2SuGmRw7meTWEUyZ7ksYezMN3xgRm7aT2VNjZk4vsJv52NPvJRvuCx5TKUBcVFZzS32Ro3t4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(36756003)(44832011)(5660300002)(2906002)(4744005)(41300700001)(82960400001)(8936002)(8676002)(38100700002)(86362001)(31696002)(6486002)(6666004)(53546011)(6506007)(26005)(6512007)(2616005)(478600001)(66574015)(31686004)(186003)(66946007)(66556008)(66476007)(4326008)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUlwWnd1cW1aRTZRVmFZdWpGeUdMYnh4S0hBUlpwSGIzRFRvblhIVDQxQVg1?=
 =?utf-8?B?YWxOODBCNHQxLytQcWlBaWVwMTZLU1B1ZFB5NmZZaHB2YWlwdW9wNFpVa2Jp?=
 =?utf-8?B?ZkdJWTUxYmNiWm44b1JNQ0wrekYwM01uZllHQlNOU1AybU1rU1U5V3AzNllu?=
 =?utf-8?B?VFdYVFVnN0hpYTNRK2R3YW4vYjdyWGVIR3lTQTNRMXR5VGNoWWROLzU2cVIv?=
 =?utf-8?B?MmNKaVkxczJ6ZVh4Wlo0cnZuSGNiajNmeWxWZE5jNXVmbm41eW95UDJRRzFY?=
 =?utf-8?B?RWhXclB5SzRMY1ltY0Q1aWpBS2puVW84dFBJb1Fzekcrd1JJSnBhMmwwQnY4?=
 =?utf-8?B?Rnduc3htRlVpazd3ZW4rT0VuZkJVaEpGanRuNWxGV2xicFc3R0REU1kzejRw?=
 =?utf-8?B?dURaVHdycW1LTXNWU205SkIzdmpHcUF4azZIZS96RlNJY0pjalFzQTkvRm5r?=
 =?utf-8?B?eXgzbXJpUEhpaEd3NjJQTStIOVZ6bGxyeHJrNkpxQmIwQXROZS9pamVnNFpJ?=
 =?utf-8?B?TG0yTll3RW9XejJXdkY5azhabm5SMnRrODR1YzAyNGpYRFg0aVNjbjFnUXk1?=
 =?utf-8?B?QlVZZlVjNUZnV3ZFVzNubEptY0JDNHl6M3pNcTg5V2hOUGZJdUlSdC8vdUhv?=
 =?utf-8?B?aEtvSi9Bak9WSjg1dTl0SEZ2cC9VSkJHbm9IM3RDUGlLTXd4bURpdlR2ZUZq?=
 =?utf-8?B?YXU0cjF1TkxvNUI3MVRrK1lWLzBPTDBicFVHK1krVDJIWWJxM2MzK3I2amRj?=
 =?utf-8?B?YWUycUw3ekt1NkgvbCtUSDJtd2N1c0NOclhCS3pLbG9UbGNvZC9WZVY4ellS?=
 =?utf-8?B?K2U4WjNabWlLeUhlY1V1b1lhS0FubTVTeHAxem5VbXNEelBITXhodjNXdGUy?=
 =?utf-8?B?SUs0UXpBRU4rQ1c4eTdTNHhCZW5QVFoxdEJlQlEyd0JMS3cwbXVoY3dWKzJE?=
 =?utf-8?B?VEs4MmlJZFZjZlc1YU5mYTkweW80SVk1U2xKQmxBNm5qc2RIOG1Qb0NXREdM?=
 =?utf-8?B?OURlcmtUbzJMeGlOL1lkVFJadmFPV0o3b1p6NWZXR0tMSHNyNVNIckxrQVpB?=
 =?utf-8?B?dnZ4SWV2VFdzWnNPSU9jYTFGMTZXYTY4N1crWlhuTkJNM0cxS3dVN25HVG1m?=
 =?utf-8?B?WmZEQ3VjVUpCVTdybWZaUXdCNDRTSC9tQ0pDc3p0MGRIKy9VVGIzVlRLOXJ4?=
 =?utf-8?B?ZGpnVExtWTN1aWlTR3ljRHdCcXhTVDlXN1pDOVdLZi9peUFDWEJMLyt2YUU4?=
 =?utf-8?B?SG93SmlPb3BpZVlhc1RRa3B5bXV4QkRGc3psZlhacHZVcWN3ZVliRmpsU2Nt?=
 =?utf-8?B?cVhDK3plSWplbGdRTHFDQkNEaS9nVEsyMEwrUDR6TnE3VUNuTjAzcmtNRlpG?=
 =?utf-8?B?TGR4T2lTMDBZbFFiajlNeTVaK3R3OGxDUzY2TDg2ZjZVaER1SXlFTEdieGhl?=
 =?utf-8?B?V1ptVFBaZHUwQTFvaDBoN0lkdHdrS2s1cmlrb05nb2xlb0FQR3RJNUhJaFd3?=
 =?utf-8?B?UkV6MDFDUjE0SldxUzg1SHRyUWVteWsyQ0NSK1JVUzdrYmhCUER1cjRZd3dH?=
 =?utf-8?B?Q0tBZTRmK1RRTUFlZFB2UG1NQlNuanpzZUNuRTBhS1IzNWViU0ZBZ0hiOHNj?=
 =?utf-8?B?b0FFcVV2TXJQSWhrbmo0ZFBXNktTd2RUN2JLYVJIZ2xlY0p4T29KcW9hblpD?=
 =?utf-8?B?ZGdyYnd1cStybzQ0d0RWRHFoWmY1OGNiZW0xdmhnT1BCdUNNTmNWaUc1WHZX?=
 =?utf-8?B?anBNNW5YRjJnTU9CdXVIUVFNZjRzbXdzL0I2NWRPZmNNMVBobHBGaFc4Z2JP?=
 =?utf-8?B?c3FwaXc2R21QZnUyRDFtbk50T1p5dFJKVTJzbFNFQm42eE1sUkdaeWR2MWFt?=
 =?utf-8?B?QlNpZFRCUHZrRU12RnNXY2YrQmRxa2lEdCtkOTJVM2FudWdhSVJmWjIxVG9J?=
 =?utf-8?B?T2NIMndVaU5JZndPaTNpSXA1L0x0VzBlaTNSeUlhaUJnRlZrTCsyRWF6eTZs?=
 =?utf-8?B?Yyt3T2NwOG1RQnNORHhnL2N6bHVPRFFYejNzZEZZd0tkMDZSK3prL0tQc0R5?=
 =?utf-8?B?TUczRWJHQWo3MHlPMzduUEpoclIxT1VTYk9WVVplLzZKQlgvUmJJZ1JTNlp1?=
 =?utf-8?B?OHZ0Vk5XYU9VSFNtcnBGN3pFcDk1aWF0VTFycjBNR0lLa0lxMmdYZUZ3OUVW?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6162c642-cfa6-4198-e9c8-08db42c766ac
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:20:39.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeLKq5PUrM45h0eASxQTFLV2xbqvliuASABz/LqscnJNRWwoXhQy/MlF3UmKOaD4aX/SRyzw+kyyrLapx3p1a6YjyiwlLejAqvYIXoGjVkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6304
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/18/2023 4:45 AM, Ilpo Järvinen wrote:
> Some results include warm-up tests which are discarded before passing
> the sum to show_cache_info(). Currently, show_cache_info() handles this

Please drop "Currently".

> by subtracting one from the number of tests in divisor. It is a trappy
> construct to have sum and number of tests parameters to disagree like
> this.
> 
> A more logical place for subtracting the skipped tests is where the sum
> is calculated so move it there. Pass the correct number of tests to
> show_cache_info() soit can use directly as the divisor for calculating
> the average.

This is not clear to me. How about "soit can use directly" -> "so it
can be used directly"?

Reinette
