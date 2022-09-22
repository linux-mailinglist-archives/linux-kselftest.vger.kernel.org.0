Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB075E69F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 19:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiIVRwZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 13:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIVRwY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 13:52:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01436102539;
        Thu, 22 Sep 2022 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663869144; x=1695405144;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xgtTmUV1kRYHuQG534pxGgT5YNgOWCGkj2Ixlds5nxI=;
  b=cZe1yKm+CPaDe7+g4LMrsWcPfBk1IgywKXPEPH4apaio/kjPu1ydTL4P
   5TR8eo8VDLkd5qv49cR7S7icBaiNNfT3oFt1/+WNQ/zxGWisvv9kINB9/
   S0Qxb81HrJUXwAbC5AwiYVvjr0TCYyeR1jD6FTMh5HbYKXKyi/Lrkep+y
   R0cMb669Exj4J2p0yNfxTlX461BCCqyIgekovYWIPtt4PkkxUSvxYVDmu
   U4/+yQSNaNYBQ4b3K6M7FchV06/5tvWFJe4AhDU/T7BzjasII0lwgimDp
   +tivTqSSHIXcx2omDdv/oINk71fbuS1bqS9M/sKENCvmp4bykxPnB/9wK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="287463278"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="287463278"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:52:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="688393027"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2022 10:52:23 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:52:22 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:52:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 10:52:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 10:52:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1ZrZ0K4bib1cFE4O9zctGXxSEIASY7Hbk37c7S5awG9zXhpQDv+vgmbxMxyo641zXIiwxm3WEL8Dpo87QT7ZcyqYmVveupws5ck6FoiF2GCz97KRXuYVFO/WMy28TBKFcXcGmD0iXfEBJEcp4vleClYsEqN3wxdQqX5FjhqLPi8rqCLJF9b8cEY51W3WtYpWiMLV1YRtvyNJeuXYP+LWU8HWD/CzrMn9HomU8jRNQoAKO4xvMjN1GvijTRQf/4iC6xrZ15/FVJz1iE0rejZtLSgeSjcyKTbG6Xod0/6EIKmNP9kCDEODEgcelEO0u0dML5B9We5Od6ANSa9TIAfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fF4szzHZqZtDpT77XT2tDyE27VlPbdr93+rNxZ98wfE=;
 b=XEWk2NQWMH79VG7LEwae51Uv/wiOurzD+Y374t0JJOvvJfOTakP+qfn8E9CpphoAj1Jl4Lg5P1i9+wTMb596uwW0lwfRf10tEPZhmf7v+gIZIRTP9i3fIXki91A4O8z78ZpYXSJt4D7MztshOPzkdp/RacZVnOAaxWVkNSqsvnRmC0yLQCtNvTs3lXdk6GuuJWtFJSjTWS3929rZ+Q7SUDPyVTtzOBRwwrShUy5Osjy3Bt8pAM5S54bZicvL9t1bH2DC8BKDYGSl/ZJvzqnKRZBOqkWSkC8BcfS8k/8oY//RF0k1P5LEqIKmh/lSZG7TJUMLdQdjJm+YDCQKNADQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA0PR11MB7282.namprd11.prod.outlook.com (2603:10b6:208:43a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 17:52:18 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%11]) with mapi id 15.20.5654.016; Thu, 22 Sep
 2022 17:52:18 +0000
Message-ID: <3ffb6891-aa32-6835-2cbd-e9b2f204ac8f@intel.com>
Date:   Thu, 22 Sep 2022 10:52:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 5/5] selftests/resctrl: Flush stdout file buffer before
 executing fork()
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-7-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220914015147.3071025-7-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::12) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA0PR11MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ceeff4c-517f-4a71-da8a-08da9cc330e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAutDT/94vlmmhExxxC43DtSlupR67yhMepxFFpkMsXYHOD5+fBKBHPMkzE9SXx0gMEUpZaxxDgQ11UrOYTZ+JUwVaekfNwyZQ4i7rveFUqdi0jC57QEYdlPxerkfomzWEhD0EsWegr5ppKEnE3psbKGu+6C6BH3aEzorlqoPtEOvgzXyGqncXvAAn3Z5TsuJ461Vz0QBgWGaH+a0oZo1pOGKndqzh8K7AIxMANRLR5B17bW6+73MWZhts4lFBR0P+rJ2EYbigN9KPfRwYzHrUQQ2KkX9bsCsXrJDAwOsCu3aKU8uVL3oKCeJILhzah1FStUu5+S2ZZmIOuoI7XvVq4TZk07TuuV6mF562qLeRbW+pCiPA4VQ6c34uH323XJyCNtwsVqayRl2/S90k/rlG7SjuHir9qi4DbgV7IFRTa3d53yyxTFTv8kPtQ3dbTeIJ7XryRi7X8hFFcZFmFXNAFnJHQebDAQMRDBRoqHkt9bYppQ5zxxQ/+nv4je+/QDMDlsLVM8CMcTHYG/rt8NDjRKp7I/fkmmW3Op1oqzPx0XVcX/x82p7O9TfhFHdEJcclePgf2qD00cT1aPrshiC5Vgw2hTybtg+6Q+/cT9MVexogly9aJArhTNeY/31CCVHcrRWFec5beoQjHugwijRvVjOL6mRx3KBUAETTN3bNDjoLV8Y2WwAR9AtW3f9aOOjiTgO/Xw6z+zE86mCUQY46sKfMTdGsXzI9nAlRu7z9rdpwljl3K4iQAc/JnyWvHQa5/nh+tq9xyw6TpsrRlrSwfyNNT+71JNo8Vf7xg0dKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199015)(66476007)(31696002)(110136005)(86362001)(316002)(6486002)(8676002)(31686004)(5660300002)(66556008)(4326008)(4744005)(44832011)(66946007)(36756003)(26005)(6512007)(6666004)(41300700001)(2906002)(186003)(53546011)(6506007)(8936002)(2616005)(83380400001)(478600001)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWtEdThsRnlyNGk4bVFxOUxGZGEyYmxMd1A5ZUp6ZXE0b0lQRzdOOSs0TEpY?=
 =?utf-8?B?S1BmazFwRFRkUHNqMSt1U0hSVkgwS1d6aWkvSmdiTnV5MmZuS2tlMFF3SnVC?=
 =?utf-8?B?N3dkL1VPNFAwWndyUlN4N0ZHN3BsR3lPa3BCRXUwLzA5SzdiSUF2enhTUEFW?=
 =?utf-8?B?aERxS25NUEpPUHZVb2wyVmFmWlNsckVPWFZXajN3amlzMytYRnMyUFF1Wm5Y?=
 =?utf-8?B?QlFJajFvM29GRnF2LzFhbGxzN3AxOUtRWXN6a0ZKUkNVcUwrRzAzajg2VXFQ?=
 =?utf-8?B?ZC92anRZRjVqU0RNR3Ryekd1WGxPY0E4eHVZU3BNTlNiakRYaWsvVHQxTlJ6?=
 =?utf-8?B?U1d0Z2NVcmhrb0N3aEJSL3VKS1k3NW11YUY4dlNQaE95cExnckpERjZqdk95?=
 =?utf-8?B?aTd6MlBVSysweEZQVTVvTzdJS0U1UGxObUpoNjhlR3hDV2NaaGRrK2lyY1hW?=
 =?utf-8?B?MEUwVEZWbEpzMDdUdVRmQUlOZzl5aGhYS1I2MVdwLy83NG9NWlJabmhKRXV1?=
 =?utf-8?B?NHhYTGhUWDRqK28rVGsySG81TzRoeHUxS1luZ3Q0bHY4bFVzNmdlRmdjZCt0?=
 =?utf-8?B?U0daRXVBZUNpMDl3ZWNMeWpTaitUUzhMYSt2WjNoU2M4d2tBMmlLOTlSeW5h?=
 =?utf-8?B?ZFpRMzd0WGo2aElpT2hWZHp0RlF1UUVwMW9iOVdaVEk1cWtxM3JnbWFQYzNY?=
 =?utf-8?B?cEpDNGpNeXZmUGlvTWNMRjlkTUdRRHhQWXk1dXhJRGF5WEJiNFg2LzViNUNZ?=
 =?utf-8?B?U0FOekNFYjQ3OUQzUGpCREovSmV0a1h0SWUxNUlnWUJESW80SlJGVzJzMy9I?=
 =?utf-8?B?d3VhbnQ3MVFnVGEyU1J1MlpQenpmQ0lTaXhJRW1kS25ZQVY5eVNMKy9YMHpT?=
 =?utf-8?B?MVd4QVJtSjNFNjhmSzNCaFFzcEdwRXlzY0lMZTNCREhDRmhTdGhyQlpBU0g4?=
 =?utf-8?B?SUU5bzVRVFdvT1BKVDJjakZmN250ZklFb043Tzhqc21tSS9uTWlTNmtrM0Zk?=
 =?utf-8?B?eGhpU3ZHcENKSXMvV2ZvTXIxRGRpNXVFZnovaW9zWnJWREZYSXJQM2t0QVZX?=
 =?utf-8?B?WHBqWjlEQ2FOcmtnQ1A5dmRiSHRvdFRoQXRYanB5M0JSTmFhRkphZHNMei9G?=
 =?utf-8?B?MW92b2w4SEZBR1ovaVp6TzY1bHNMUjFMZ09Icld6WVFBTkZYc0tuVWRsQUlH?=
 =?utf-8?B?MEdiNnAzUStIWS9VSGdQZENGc3RyOTZJRG5NVE93eE55NGRsaWRkQmpMZXVz?=
 =?utf-8?B?cGF4b2RoQ0tPZWpmcVpZRnBzbDZnYnhCa2JJQ2NoUE56cmpEVGxhMWxURUlB?=
 =?utf-8?B?dEM0ZU9XRVYxWXpzbm9XRk5vUXltdWNIOXNheUtKdWhiamtWd3lWMjFTaS9l?=
 =?utf-8?B?ZkFaa0w5cm5hc2lVQ0FUNklSZUJ2ZDFSTm9RTVJLT2tLajd5UG51S3ZZcHRT?=
 =?utf-8?B?RXFQVFB0QkhlQk5ISHJpbVpaK2hSYWVVRk9mc2ZSYmhEMXY3RVY0eFYvK1h6?=
 =?utf-8?B?SHJDM3pjbUZtQTFFUFFaaVE0NGo2TGlRa1pnVkQ5VE1OSGgwTmVCSmU3Y0pq?=
 =?utf-8?B?U2Jpc3hUbW5IS05DNlo4TFNQM2ZSK005aTBXbFJBdXRGU3FlWWhVc0NWZWt6?=
 =?utf-8?B?V0w4T3JDd3hBUFA2eWd5d1BoZW1icHh6VUlrT0o1ZlppSHgvN21XV2F3UElX?=
 =?utf-8?B?VVhuYXZQS050TU9RSlNhbUo4L2Fxem1yTithQlpiTXg0dHM3VWxxVzZGNUxC?=
 =?utf-8?B?NFpBckdyRnNmUjlKZGZZWElZRmVnQmVkaXFhQkZ3czZ6L3p4eUg1Qm9iakh6?=
 =?utf-8?B?ejh0ZkM5dklNQlBXYTJVenZMYjRYampRU1drcmRKWlRjM0x3cGZZRkRkTXVu?=
 =?utf-8?B?ci9ESGJreTBmUHVXazZobEtaRkdrOWJrK295ODB6cUxPUVU1ekMxTUpCTjVL?=
 =?utf-8?B?b3l5aDAzU1pSL1JneXVlRmk4enNMKzZ1dGNtdlZMdTR6Ymh3Smp6UkdDUmJU?=
 =?utf-8?B?SCtTaXp0RUFETUg0Ni9wZVYxdnB0MlFMK2R0elJxYk0wclBJaXhkb1drTUxo?=
 =?utf-8?B?eGRSdHlyY29qMXFXSTRwYUZBQ0xzOGJsK1hSbDFaNXJZUndjWmk4NkoxUG1M?=
 =?utf-8?B?Ym5nTXgvQ1QrOGw5MUVHZmVzL0tVUCtmZGZnTzFQbUNMWXFzRDFGVFRoanBZ?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ceeff4c-517f-4a71-da8a-08da9cc330e6
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:52:18.1056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkjn54RQYLX9S6lmskBBwSYDzLrnzoTQ0AafH60llxwuYY+/ylVq24nrNmRdbtpJAz1Pj9NbQyXuEvqU9LatSMjKzQFqCQe9QOJfS8XTvKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7282
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/13/2022 6:51 PM, Shaopeng Tan wrote:
> When a process has buffered output, a child process created by fork()
> will also copy buffered output. When using kselftest framework,
> the output (resctrl test result message) will be printed multiple times.
> 
> Add fflush() to flush out the buffered output before executing fork().
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Thank you Shaopeng.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
