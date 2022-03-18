Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A577A4DE329
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 22:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiCRVB4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 17:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239224AbiCRVBz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 17:01:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD9A2BBDD1;
        Fri, 18 Mar 2022 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647637236; x=1679173236;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VzYT2jRuhQpK0fjrLSlZ7quzr+ZJ1jXntxKGYEmFQ1Y=;
  b=IXcG/c/q0H187ZgAaAPswKDKnR72YHg5BiIcogtSfehbcr5kccuCxi8W
   dwYrhz2qRrfifOABCvyYf5Y+hGNsFSGy2axafxxMWvEtjXB0OEIsYYiny
   qlKbP0SFEoWEbz2Iqcp8f9c/2aZUTpyvBFBCyWBTsrZAhwUU1LIp202ik
   HPCxPVOgjNIy+gmHN2vNKhCWAWGxSqcnKPb7v7SkEi6pBzy2AP5PZXyUj
   RlU38il7JA1kiyVHNz1YHtGDlgGw53s0/HxGmMbruolf/LoyeOMrfeOOs
   TfTkE5i6n6ZMNTTF3FW+cW6YAn3yP+J1Xj1wyldQh7QKqj0cUUBNOr/D9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="237166532"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="237166532"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 14:00:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="514080572"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 18 Mar 2022 14:00:26 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 14:00:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 18 Mar 2022 14:00:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 18 Mar 2022 14:00:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYRpOiYfhUpJEqynWgyjSS6tEpARNO2PvC7BD/aZRINdYr1ikQw2yXryE/6+tNsWu2+pyqlD+a2+eOY9QzEoNhdSST3NZU8tomkU3rCMAyrZjAy0roSQofZS76VUIHSed/Y2cBPmpulczH5XDxl5hWmNwAL1ki7TKOH75c8Z1ZI6WsVx15GRGZBnGQ5HPWSyWW3XgRutF4d/bPbldoqExKXLxwxKwpQAY37pDlP7Fs8l+/aK8ZStrg1+Z4+zyKvfqBVvlq9lFo4dxUDrvqiXTwVYoisP4RGq+ZjLpJdxFkhuq7vgJhPGa/B6/arTB0Avxc9XQ62ZFiHdeQYvXFCoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5n08w4sGEGXK4k+XgiTvHIpY3H9JVfMIML4sbSnnneg=;
 b=n/v74RagWcHLJc6MfXDVpqfUKWjdL3CASUf7Rz0p6px5KqzZEA75oqL4qKS5BJhEf10Yd4XGiBHtGGQShOk44my+wrdUWRldsUqJyuvfW01WcrIsqb+glQmkOvs6Uqv1xIZ7XN3kWKCoTra5Jlp+Y4smYp7T8D9CBe4tHh/oBIgiENJmccTDoANSWYkFBKs+c5I1IP1Iub96vCHQ2sx+/q3SefoLsSUGHD1jODtIwVM8qK3T6yWig5z59MaWSal4K5kr0/wfRlqtBRXnBJMl4z/fGRy6EaUmQtgz2F/M6bBl/Ek80swyWYKxTSsSQMHyoBrS3TpzN4GPOJUp3mlxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR1101MB2146.namprd11.prod.outlook.com (2603:10b6:405:50::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 21:00:12 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 21:00:12 +0000
Message-ID: <f0a5fafb-7246-6fc5-ed3d-070e88874b26@intel.com>
Date:   Fri, 18 Mar 2022 14:00:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v6 6/6] selftests/resctrl: Add missing SPDX license to
 Makefile
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
 <20220318075807.2921063-7-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220318075807.2921063-7-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR10CA0065.namprd10.prod.outlook.com
 (2603:10b6:300:2c::27) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7915c4a-2a59-40dd-0f09-08da09224b84
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2146:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR1101MB2146B761EE488020BE1E99F1F8139@BN6PR1101MB2146.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: czswHgI7rUWUNJgaXZNcyg/cUmH2fQ+i80IXaIvNdCkaNZxgbnW1UYZUbsM3UkEc2Wbjrc2yRYBUlbkRSY6eAC0vG9S/udl3Cvuk69j6UNkh1g7yBPWkxfIMJg3/xoEO12kymkMd6ynjdPIhuCwBHvbs+aLmncMM14r5tqT78/LX3FznY2ARIpd/6+o/wETqFZZhBPRgY/RAXM8TMJpfLS6iRR+0IiV3hZx/aNaCAraDA0qQxPPPsuu5O4J/dGmNGiO8YSwJrXsnIPyxQ/cx053CenSc2hj/bTEv0Nh4z4Jmx8TUp72Dfj5Gzg5fjP9dTYg4Y4kr/YTDhEYrXemveIY0hfYOZBRENtqvWoC9VGtzym1/qpuxPZyJ3ZJAX+JpWEPGgYAx6bhcPBKM7aSZJcxnOmYHIo68n9ljtPfp8LpNxRf8CObp4BKEQljDYtUbqB4rD56cy5Ef4mA3YWr/BhOGI7R24rD5mDomkVhbD2mW/9QWYF0n0aurljo3OzKaf1vczKhyKY2KgPHb56GHpzSqbur7NbTu8NkX8GW+CxqfZMEigBDVOnBTPTjRo+VYoeHKtUJd6TcRcziVn4etfVPtWgrxodYnzu0iUS+o9IInuQWAxHLXlqhPHSkKA71AGOrcxAS0oGrpMX2YorHTJptDNHDloIJT0kPme1IOCC4n4tBE5FMM5PzUUwhm0FRLFE/d5n6M59gAO9Q7k4p3sFOVFLPRbFU3ylsvKEFvHy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(4744005)(8936002)(5660300002)(186003)(53546011)(26005)(6666004)(31686004)(6512007)(316002)(6506007)(36756003)(2906002)(4326008)(66946007)(8676002)(66476007)(66556008)(508600001)(86362001)(31696002)(82960400001)(2616005)(6486002)(38100700002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDJNV0VCcWlTV0JnRm9Ha2QzK3lkSkRPN0lzanFhdTNQdTlYNllXdURIZmxT?=
 =?utf-8?B?NE11TXhCeDYwWkYraWJ6Mk4xUG5palR3Yk00YVZnaEg1S2lRWnd1NXo1YTU5?=
 =?utf-8?B?ejZsMFhFZ3RVWERhZytzblRpdlB0NW5QQ1ZKVHRiRytQU2NlOU9pZFp5UEo2?=
 =?utf-8?B?Ni84ZzVwdTJGU0tUY0RnSUdRUnF0K1loemlHL043TjJPM2RHR2NydGt1eWM4?=
 =?utf-8?B?dzQ4ZndBY25kNmRFV1Bsd01lcXFaYW90Q09JRDY1eUZabHhYdlRpOWlJenNm?=
 =?utf-8?B?K01jelEyem54MGtVSzVJb3dRbnVmTVhKYXVFelJYaFE5d2N6aGlzR20yRWI4?=
 =?utf-8?B?ZGlpdWZsaDFzRGlBdElGcGtnNU0rd3VqY3JkM010ajN6eGRJNnFpWlpXMm9S?=
 =?utf-8?B?dFhpTzNHQWVOdSsrekZXZ3FLOTIwTTVRTldRKzFTRlZtTlpubFAwNG5uRXIz?=
 =?utf-8?B?M2ZmWXZ5K1dDY3BBNk54SVE4Sy9VUzNnbGxrZk51dlpNby9CWW5hOHZDUkpt?=
 =?utf-8?B?bk9qN00yejBNc1B1YU11WmR1cDhGZGdsanFFNXIzakFRZjk5WmV4dGtHQkVM?=
 =?utf-8?B?SmlpS1Z6VVdXVUJ3VXdzM0htcEhnTjVsdk9MSmhRNDZXcHUxem5xbXk5YTQw?=
 =?utf-8?B?ZGhWZDlzYWhLcWJCOW93U0l0dDY4dXJ1cFV3MlJUODhIbitBdnNGNSt6ckow?=
 =?utf-8?B?bjhrMm9ldjZqY2xDcDRibklSMXpxMUZLTUhhVVlrZmk2SnhXektxcGtmeU5t?=
 =?utf-8?B?RGlWMmVnd3d6Tm5KdE9HYUhlR2YxbkxDL2krUkJBWkk4SzdHUTlhTndZbENm?=
 =?utf-8?B?cjF2by9nTEt3M1ZhQllCeXEwdERZOU50ZjRFYWk1aFk1dnhQVWhkZFZtUkh2?=
 =?utf-8?B?QWRPbE5Lcjl3T3NqT0tQL2NzK2RBandGeGdFMFZJYXJJRUUrRlVyODVGMDV2?=
 =?utf-8?B?OUhPL1NiOVRwL2kzNEZKSHhtNDBuQXNSR3ZBYWkzMVhZRXRCOHpXR1RIQU9Q?=
 =?utf-8?B?QnovZEIzdnk5SjhMTnlEd1lrNlZ5cDV5ZGExdlFMcHBGWHJiOHlvV21xcGli?=
 =?utf-8?B?TithT082dGFMSzhJZisxT0Zpbm5oM1FFcVdKMjJNS1JGazY2Q2h5czh6TUJ5?=
 =?utf-8?B?dVh1Q2krdGVyRnBIZHI4dFkvdklTazFnUTVjcFV1WkwyRzlsekc5c2VrT3JQ?=
 =?utf-8?B?MmcwSG95Y1VBZGFPeGF6ZVRXZi9saE1hdExtRnVaL09tRUdQdGpUWDlYZTVw?=
 =?utf-8?B?QUhUcTZMYWp4QmxXM0RERzc3NHFxbHFHeGRsY0xIc1ZmNTEyT3JubVJMK0Nh?=
 =?utf-8?B?RXUrVUhEeU1rc0p0Njd3VnlHM3VaVkRRa1BaTHFLL0ZlNmdqNFhpSmx2TVVr?=
 =?utf-8?B?ZmJ5dFVyRUpRL056bFhjcnh5OVl6VVVrajVGQzJOWkpkNUNhQlZFWW5aOHR1?=
 =?utf-8?B?cnJPVUE2ZGVUS1NSM3BqUXhONzAzUERXbXJaNnBHc3ZBendvVEZxUEVwTCs5?=
 =?utf-8?B?OUh6NTRES1ZPd21aaFVBeHRhdzJlV1pNaFJRZDRlNWNNTHAyUWQ4aUlETExG?=
 =?utf-8?B?Nmg5OG5YTFdDOG1mK2xjNEExMGxFYzRmalZ2MkRRZkNTbXNDVThlek5jcXIw?=
 =?utf-8?B?WndLM0RiK3VSMFpIaWc3YWJYVUVoemdFRU81bEJXQzdNKzg3QW5wSnBHMzRR?=
 =?utf-8?B?TzVINWVuaGw1UHFmclk5M2RjSkRvWVlkSjFWc1N4OUZKcldqL2EvczF5WHRm?=
 =?utf-8?B?OHh4RFBGUUgzb1pPa0lGTU9hODNBZ2RjYUhsS3JFNSsvQnZxNWxnZnNqSk1a?=
 =?utf-8?B?eWovbEJTckRwWGp2YWgzSmtsczdYK1ZZcTZLQ051RzF2TEgwR05XYkJLY2Fl?=
 =?utf-8?B?V2xLZm9QK0h2aE9LWmpJNnJFSXRHcHFNUGdHbndNeVZyQ0x1QUtMdUxyM2pp?=
 =?utf-8?B?bzQ0QkJnUWwxcFRjREcwY25ZVzlTT1JlcW4vbGI3WTE5cDYyOTEwU2xlS2J1?=
 =?utf-8?B?TlU2bUJJN1BRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7915c4a-2a59-40dd-0f09-08da09224b84
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:00:12.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0I+TXiQrYzr3erWkoZ1vBySWxznrFcNHoQv/4Ez3nwKU2B5X07IpxHiHYa11sX32q1t6FDMg5NsR6mRek4H/SOpLyVX/+uPoicwcNs87SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/18/2022 12:58 AM, Shaopeng Tan wrote:
> Add the missing SPDX(SPDX-License-Identifier) license header to
> tools/testing/selftests/resctrl/Makefile.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index bee5fa8f1ac9..73d53257df42 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,3 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
>  CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
>  CFLAGS += $(KHDR_INCLUDES)
>  

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
