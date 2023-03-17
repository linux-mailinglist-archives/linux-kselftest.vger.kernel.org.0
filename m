Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67E46BF01D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 18:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCQRuB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 13:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCQRuA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 13:50:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0034EDCF5B;
        Fri, 17 Mar 2023 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679075399; x=1710611399;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e7Q2D+fCz0L/qZJRLYQvMztRNqy5DEJq0yUAatN53PM=;
  b=iyRpuWZ29hxafQwhTUmeAnSLHoCFt2rhUMyBWaYZcvekSuVDhp19GAxs
   vl1bYpXjKxY+VaF1QSoMieKVl1U7Bn5750d3PuYnJJlkqsUjX0/lQwWHj
   eQMSoyvA+yUNgqo/DXZReSFoqnfLHvRsnVW/qjPAoNVZBYDQw8HdLudez
   Qal8myo5xUucbREdFT7qg8BFPuAIbhrbp+oWupJLRJhdgJc0POLl99ZZ4
   YRCtFhuXvz8WDj27W1O9xNriuuwsBWeCxHvxSzOZKQ8DTuJiC1IJsFxqp
   G9ryIMtrdTVTGN2e95cA2G25y4aOF5YhrGp9slTT+zp1yKDcOEiLs2cKm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="337027113"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="337027113"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="682762408"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="682762408"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 17 Mar 2023 10:49:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 10:49:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 10:49:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 10:49:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtlQY/nU7toQVn2Sn2oRclixhBVF0OzixIs9mJjs3fGUsftmDQnDeOYY5ebtftIvMvTs3mWUY0eX3Jimv74CLMd2Xvw2ubTI1hcqVRfuE+4zEQ4B7/Gowi1bL52S3WBDZEyqJ0vE/CevL9PRijDtgksz/xrfhuiZlffjUm/1a43RC7GNdtGpqXllt/tEk156Ndueo3t4Q8VrnhH6pfN5Rz8QDTn6dHdDPsWTMQTLpF0Bb+um65ChNP5+d8JW3ex8bqvvMvqhK8tUO5ZgitG0SaiTWDHZvOchBzIFwiIQSj3YABgjtdXB6DagB7dNMVjB2yeJaeVXUq/6mT7JuLhUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XG8U7+YykeY2I5YtEncJZe/tnQ9I+tT4xeHqhgU5XfY=;
 b=my8vx3VqwLXdoph7ZiwWud+wdM+s9XBt5a++VZO3xpeHFRDWLS9LCDbzA/ncUOyix1p4qgYUJ87lgqaLbNAZ6ZYxC6AQVmTB13rSg9Wbm4CttZqxrBqhuErd/SDWDwY850HzazsPWh4EZxeir//16EckGCzYphI/Fz8bi1lennF/TROYXANV4rzfKedKLCcM0Wx798rS7Wdgp27VmF6IJGUkDunkHq3frkrSKr1xigVvaqSGJ/zME1mg3Xju36/d0JSMEL5ywVb0oyWHdszs6pr8GVupBgbXr/xIXNVVviJIMZ9mrmLgeSYeMVsnNsWihU7GewnCh7ij0bFD/0rNOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 17:49:56 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.035; Fri, 17 Mar
 2023 17:49:56 +0000
Message-ID: <ef0ff486-afed-5b3b-34af-0b8a7c5ff5b3@intel.com>
Date:   Fri, 17 Mar 2023 10:49:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH] selftests/resctrl: Use correct exit code when tests fail
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <eranian@google.com>
References: <20230309145757.2280518-1-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230309145757.2280518-1-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0035.namprd16.prod.outlook.com (2603:10b6:907::48)
 To CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH0PR11MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: ec97b7dc-abea-4a3b-8ed7-08db271004e7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5vRUKndTCXMk+rLt/EVSJbg6Kt6BtUsgJg01zIRApVqrr0IrmiDQ0/25oeiVtt1IdsFCWBHo2hxcCZDgAn1RZvhWQQBqE+/RwV54kpE5P6mHEe6n1b2DRiv45qakgHCp5QbfgUspojrKb3KbvVOy1OY5gXc27VfSBoAGM8xMm/8H/4JsmsJbKCJVnciMW7svjY2A1To1tX0ZInHIBHDFcxrE6sEQ15rpBTHgDeE+hvrWDEkRsxkRsbEv2nLvsx37YVLjZIwxPCaLfgzAbmARQNPk6R5Isnu7p/6adSk+EzW9APB0aW2Ttp6LC8kvwf/l/xtX6oAFAuwzfPID1KhB1W+NIPcHHpBQ54PaipHdAmDKh9CAOAFaPgSfWwb8OnoMhnWVY27JyvvTFNFIvKGg7R8sut+GHoA/ilzLGMwBEPP4EFwM6ASDnTwjyHVi0iAL2fM38gBe3xZnm3iW1yZKXpkYf++Am1tOioD+ryC1hvuFSTVNCKM8wog7wOAsletBXnZvmRTq6FF62qrjctorqVwTujLPwRc9qx3w/PRq3BKpEPFD9mUUUR3b4aexrS7y1Y3WJKxmYVQ4DgcoQa+Yt9d1f235A+SIRosNDzdjkxWUtyep6M50/LVOWf04+uQ8Ot/ns2nJMOel+2wjLh0FG1SsdR8H4/8+pYiKt7cr2G/z4VNP9fLWW5zq+SMG98VuJZ8swfIX71qnrJLgPe2Bq2FrrvLziPPkEioU8IL7/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199018)(6512007)(2616005)(86362001)(41300700001)(31696002)(36756003)(6636002)(4744005)(44832011)(8936002)(5660300002)(54906003)(316002)(110136005)(66946007)(478600001)(8676002)(66476007)(66556008)(2906002)(83380400001)(38100700002)(82960400001)(53546011)(6666004)(26005)(6506007)(6486002)(4326008)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlpuVmx0QTdwTm5GUllsalo0UGprZ0dsZk1VQkh6Y0ZGSXIvcXF2bUNPdHla?=
 =?utf-8?B?bms1aFRJOGR0b0ZlYkw5ejkrR3NsWGQwaUpkWFdYSlNLbkpMRVJ2T0I4MTIw?=
 =?utf-8?B?UE9VOElVekJNT2Y1WUtqNEQ4QjRXUzNKOXh0YVp3R1orV0s5Y2UxaDFOMnNt?=
 =?utf-8?B?UnNaaEN4ZGxvT2Q2cENJQ2xSdk1xUHdzTUxCb3pVcmpRYisxUkNFVnFvV0hU?=
 =?utf-8?B?bGxUVEhYNTkwVzBaSm11dU9qYXJRYzFNOTcrMWZ2NDV1TFdZVkhCcTlKK2Rh?=
 =?utf-8?B?clc2UkpJZEdrZWFXNUpFMzk4MWhXMlZpMlZ2TUUrZFBjcUdrTVRWeUhqMVN5?=
 =?utf-8?B?ekRtLzZ0L0ZUdFNoOUc3UFM2S3QrVkpyMCtINGk5bXNzVmcvWmtid2h3aFRK?=
 =?utf-8?B?MitEUE4yaXJodjlrcEVUWG1LMlNkOXJ1RDdjQk5pMFV3Wm00WXI2emxkZ1Rl?=
 =?utf-8?B?cFkzQUR3TjBVaVRSdVErVkZhRHFaTXo5OFNLSlhtSGJqcVlTVEpOZWxwMFJy?=
 =?utf-8?B?SW5NREw2SCtwcFB6SHorQmNMSWJSV2J1Y3Qydi8vdUo3eTdaUms4cHBoY3Zo?=
 =?utf-8?B?TlozVFFlRURYeVA3UzNSaHNsamMyVjBRYjE2bVBpS29pSDhuM0xPU1Z2N3Bz?=
 =?utf-8?B?Wm9KOW51WlFjakJ5MEE0a2JGcTlIM1F6M3BNMW04eTU4UmxmYzRPakt3anUr?=
 =?utf-8?B?OVdudUdZaDV0czVUZXYyam5BNGo2VWZzZkdHSWUyOVBnTzUyS1VxU3Z0TStm?=
 =?utf-8?B?UVB6eUZpUDk3UDR1TjZwQzlYZXpLYjZRaHMvUW14K0hOUEd1L3hWUnk4OVN1?=
 =?utf-8?B?Vjdoeit4Vm5wZmhhWXg1VnRaQVkzc2VFTTJiOGxjcVJSbDJvdU03SDFzQ2E2?=
 =?utf-8?B?OTJkS2pVcWt5NVl1K3dCU2pkVDBzRXIwNkpnckZ0dW9tTWlGNmYyR01YdU9K?=
 =?utf-8?B?MjlHMk5GTjBDNkc5eklycTNaVU4yV3ZnTXhPT3ZGVjdqYXA2Zk9JQjcvN3Nr?=
 =?utf-8?B?bStXWitZdkhMcTlhaHB2QmVpWnZYS3F4ZTNlMUlaZzBFU3dNUUZITzJMaUht?=
 =?utf-8?B?T2tHbVdlU0FNcEc0TXc4OTJsbnRGK0g4Ri9DdHZ1aUhPZjBWTUN2U1RxUDJD?=
 =?utf-8?B?OGo4NmJleUVLcjg3YWxpUjJ1b3RPSGVjQlJQQVZuT3VjZGdITC9rTHJmaXBq?=
 =?utf-8?B?U3QvY1drYll3ZE9CRHhHZ0lsdUFUT0d6TW1VVTdObFBxV2RPOU9SOUFGTWNl?=
 =?utf-8?B?dmlRZ1huOUdiakhhdW02ZS9RSFNxMGhxaWF2UVkwZ0xJclBkVlRjU1phTXM5?=
 =?utf-8?B?bWxOVjJwNjA2TTF1aWE1Ykp6RGRNRTlBR3F2bWJYVWV0RHFOSk5qSEJjUlZK?=
 =?utf-8?B?VTYxdFNHS0xVZ3ZhUmo1elo5d3g2ZzIxUlNpRVhZbXJFVDRBVEhTUEZjdE45?=
 =?utf-8?B?Z1BFMTl6ckpCaFZDMDdyOWNVTEE3RjBYV241Zy91RytjYk00cktseStGSVdY?=
 =?utf-8?B?TFRoUkhhSGtVZUxIbk91L2JPT3F2TkxUelNWdGhtb1RQMXpTbHVJeEpJMUdU?=
 =?utf-8?B?YVJpV29uWEhoVkovRElHNndabk9BODhhdlBkc0JnU05kL2gxaE1mTkttcUwz?=
 =?utf-8?B?YjJmTVptYUM3RTVsZVRDRzBYQ0dwYU1MeFNuUlo4NlpBNEEvd1NWajZTcDRF?=
 =?utf-8?B?MVcwUG1ZTGdqUVRna3V3Y0cxVkdTU0dBb3lUUzR6V3AwUzd6ZGpKSVdrSGV3?=
 =?utf-8?B?V1hSd0t3TkpNWmYva1Vjc2JiZzRuRm5nODU0Y3hLUmM4OVNLQ0h6T2t6N3N6?=
 =?utf-8?B?VU1SWi8rUG42dWtabVlSTnNiK1ZlNUFBdGdhZXdjQWRXMnc1cXZSYlhHZUEy?=
 =?utf-8?B?Y3ZJNjBjUVp3am42S3F0eTIwMUVwZDloanZ1bTNieHdsdFpGTnFrK25uSnk0?=
 =?utf-8?B?eU5WemN6b3B4S3p2bEsrd09IVlBsTmI1ZnR1NHNMWXl3SEFBOEg3SXJhWWFZ?=
 =?utf-8?B?YTdLWWExeGxoWUpzSU80a2FUNUpyQksvOVdoaHBSK3kxbW5mU0VtT3Z5Y0F1?=
 =?utf-8?B?aGYxUUh5WGdVZG16cnovYmJNRDhaLzArR0JJdnR6dS8vejNLYkJnKzlmQ3NZ?=
 =?utf-8?B?KzJjWXo2K3V0ZXFUMVJQUjJEWEhrWDBnK3NQeGZ2NFByNXF1RHdaQmUwZG5P?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec97b7dc-abea-4a3b-8ed7-08db271004e7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 17:49:56.0957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+axNYpMUgIDuKzZg4QDeWfdMlKoI/3CLd6Ff04syh3dW0Q8lpvBhgKVirClWnTkNduHeV+kNu6BJ/xb2U+c2Nu+Xe4BuAkGyX6SLdqkXfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7493
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

On 3/9/2023 6:57 AM, Peter Newman wrote:
> Use ksft_finished() after running tests so that resctrl_tests doesn't
> return exit code 0 when tests fail.
> 
> Consequently, report the MBA and MBM tests as skipped when running on
> non-Intel hardware, otherwise resctrl_tests will exit with a failure
> code.
> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---

Thank you very much.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
