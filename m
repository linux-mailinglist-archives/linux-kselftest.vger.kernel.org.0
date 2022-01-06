Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1C1486E0D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jan 2022 00:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343519AbiAFXuK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jan 2022 18:50:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:21845 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343501AbiAFXuJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jan 2022 18:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641513008; x=1673049008;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FHJU9kcq7fsxc2/3Tk/88p+0tgoBBMvDcipMDDk7nU0=;
  b=LvEdKncnQfoTuG6CFG3kv74fab6mR6ZNVDfqb8yv8kZK7LE9aoxm1Wph
   ORXPOtFSFQcIz6EJfqqjp4NxnR/uipIw8ykFmSpe7X3dIZmprneXUQB+c
   zjIhmswnpaDVLoyYhfzaBRjZa/TT+it8v3zBPUWAnWlC7gnK0mZqUnI2E
   Sv1UmJB1WmKj7y4TNvpUsZrLxbvnQKd9qoTZChTcjz8gUrBvhaDnKbv/y
   fqb92znck4zqT2IpkiJEi9te8v4w7mbhyItNljNOp8sp4sLmSsEOLW/K7
   i4MKJU+Yu8Irl53t7caOpH2UreZR8IKt2rGN+ITPP7NU7QJB2MN2qLOF5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="306130273"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="306130273"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:50:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="761313987"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jan 2022 15:50:04 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 15:50:03 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 15:50:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 6 Jan 2022 15:50:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 6 Jan 2022 15:50:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0rLPlOko/lLOm5l0myG6eCZX7Tt5s0oDUeDN4S7uQDFPhXKAFCpNfnStezIhfktmi3eX52nU2Oingxrf+V/wnueOG4J99vbVmg1UO84zJM2owj+n9afZxrPEAxvWi48NiwfT3mzfQFz4veYD1frKKQhyO01yHW7s+tMJTRA3K/n8C0Mz/nPZdevGvsyKd2mAqLiUDE681vuj0I50j3aapP5CNvtPnNgqCIxo7CUR5VOH+9YRxzp67GIpOZ7vXX7DuaF/6gXkR/kwPVpidGD3cGnHY5spyn+vkXPXGA6t9SxLy6XwqANRtsDlawvi0LrjqXFOHjruES7FnNB+9eCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3z8ZBeVZgdX45EhnKKwxUsbkKUC8KgcsmaQR7K4zzM=;
 b=io754p0w3E4kso141dV+Tc2gSHMViU8lzTjiYYzwEBmWrgtvF7EdreVJ1DZWx36q3KYT+g5lNK3ISX/CaP+mRY56FXYPzaLeiNp3dBMSfsIKKIZdgGWR9TAraNKGpGHBhIbLye+/13G7pG7nDhKNycyN7ytbTs8auTzjYFQHYKjwFac/EhImqd5aci+ukYdjElDOTFxY9A5Wa+SYEN30QhTPd8HE4jgn1lctPxRXIwXcQ7nzaN6L924YA/WQ0E/YGM4XjnQEyx2p/QFLqMA/PQDy1N9WXgjY+UWtqFqvPMLUU07Vcp17x9qmvLMAGKG8ez/jhhll4WFOcZbd7805wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1969.namprd11.prod.outlook.com (2603:10b6:404:fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 23:50:01 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%6]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 23:50:01 +0000
Message-ID: <c8fd3125-b61c-8182-d7af-0f7a85eba345@intel.com>
Date:   Thu, 6 Jan 2022 15:49:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH v2 4/5] selftests/resctrl: Change default limited time to
 120 seconds for resctrl_tests
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
 <20211213100154.180599-5-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20211213100154.180599-5-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::17) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1c6fced-dddb-4e1b-6f91-08d9d16f4112
X-MS-TrafficTypeDiagnostic: BN6PR11MB1969:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB19692A8EDD68C758984791ECF84C9@BN6PR11MB1969.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:250;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X14dPIT88k7PJzlisDQ4FwgHFPs3xVcs+/FpdrbKwh05cwNpu2zWyS49kDff3JsZTLsjlUmzCQvtv4A57J8D3lAzHblPXTsVTPRGmA/UZHrieFaiRwDerRR3/1aBFYdDQ+Ni01j5KTtzVxjPOt8K6cte+R9ltGFM3AHS11fJBV/2Y2iDd/ojCK5l7vaRdOCFTYMw7p6tpiJkqlP7W79a1ONKh7PuYRVI13RlfnA9JkTFtGQiI44aRU7d3/EcqB7hxFVT/xmxSbjgDWYbzrmAy20TYPgDkzIi0l55MvbfS0vQTMYSpp6el8KTMSqJBWVhkied7v/mY4Uh3gKKa/mHoTaAIDX3a8emWULDhDnuSUFQ10upvxK6WgSCV4LhEMG5Q/pwTs3ae/weBoZJC47Uq5h5lMi7nBTiQSps1C3h62xC8gK7JNTyotu/kGJl9WyXoA5Ee1IQ/F2aiijlCEZnnaY33J08KTHwNZmsuMsTO3unZymsBup+e/ljOPJ4Ux0psSXm9iIzhPYNtmPSYPTb6qeD9Yj/AHzZDc40dk6fFO613+MFzRw5i6czonhipAErAn1vz7RjVNryhlCQq8CKSMhTHJAT22vizojs7yB2+/PVj6m8Shx0NQJ7IOYSy48e6gquOd2rHqxL7bI8Xf5TMN01U1IomXFL6fPnBE1VPw5NGsEgU++tQZzCd+x5W05DLNu15Laiv8i1lRWXVTTvIipueaAIxthva9pMNbfdusQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(186003)(6486002)(8936002)(6666004)(66476007)(8676002)(5660300002)(110136005)(6506007)(26005)(86362001)(31696002)(53546011)(31686004)(66946007)(4326008)(2616005)(44832011)(508600001)(6512007)(36756003)(316002)(2906002)(83380400001)(82960400001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enVWQWQ5ZkxxN0FDRlpLOExhREsvQVdnbk0yZGVEUEhFQzdyYmQ5Sm5FZldk?=
 =?utf-8?B?WG5mQm5xM1FXa0RFK3Z2bWMwNGVHRzlLOUpHbVNYN3VZWGdoclFQeFFFWC9P?=
 =?utf-8?B?dTkyZUlsdTV0Y0wyUE55cWt3bCtVSFVmOGxJUUozaWJxVjd0QkNNSDJpNllB?=
 =?utf-8?B?ZzVGN1FnY1NkL0Jzd1E2dWY0VmovRGszT1k4SnRxV2RXN1JHRmZWekJWaXpI?=
 =?utf-8?B?SktyVGtDWU0yU0FWREkwZXJKOGhhWjV6REJMdEZkUzFiQlRrQlN2M1c3UzU4?=
 =?utf-8?B?ME1iaGlDSU5LS1ZxU1doMDhQbVdldng0ZmlwMEdtUzdxeEJoZzZTUXRvKzFF?=
 =?utf-8?B?bkhTWXdqWEhyZ3Fwd3BXYTliYkxHUllsMEFuOFVlbHBOM3ZaREZRa09SUjdq?=
 =?utf-8?B?R0Q2MFFudnVPc1Q1VTBWUFhlaFN1Z3FJbncrSlZJS2RPY2U2VkhEc2xSZ2t1?=
 =?utf-8?B?UXlZMzMwaUFIdHRJZzBWTnVucGNhelhXakhxS25mVlNvOHlSZWZPbVU0R3pE?=
 =?utf-8?B?aWt6ZC9qZ2x6Ynh3dFllRUI5OGRmWlUzdnVEVDZVOFpNeEJvZC9CMWlrSW5r?=
 =?utf-8?B?dWRmbnRjMUp4ODlOYTFENDRHcGRHWm1Ydll4QU1tL0JERlFmWkMxMUFlUGFO?=
 =?utf-8?B?YTNtdXJhV3puVmQ3Ym13K1pBWDNlejdFUXkwQjVMZXVUY2w3K25JY1A3bEJa?=
 =?utf-8?B?RVVTdFh0dldGclJNVEtvbkQraCtIS3M2dE1IZ0Vqb2ZBUXJ1c0JVbUt4UVNw?=
 =?utf-8?B?djFRbDBTVmduZFVQR1h2dHp0WTB5Z1FuRmIwSEU4a0M3aVZYMmIwd2NlQUpx?=
 =?utf-8?B?c0hFVEdFdEVHQnBxOE9uK1hueWx0MzNxK29nUTc0M3Z2MkY4alFQTzdldndS?=
 =?utf-8?B?WTZESlRoU1Z1SloyRUNHMERvdTNGdXdqdWwvMTZ1QWJjUktybXJ5bnBVQi9E?=
 =?utf-8?B?VDhQRkwxU3BBbWdzTEtTb3AzQ0QvN3AyV01PcGJSRHZYcUM3SjVNOEZ1ZTNS?=
 =?utf-8?B?ekNERmZtcURFZ3RacURsdXhrYVh0S3Q3WWdhRGdYQ0p0UGd0akhCcHN1UmNy?=
 =?utf-8?B?SDRuMnEyZ0Q4Y3JWWUZ2KzJ5blMvbjFZd3MyL2duNlVJWHF4Q1pleTdKSi94?=
 =?utf-8?B?MUlOTUduMDFFRnNEREtyZEs5NUNuNkg5N0R0ZCtORkZDMDllVkVzV1F1VGp5?=
 =?utf-8?B?aGl5ajdpTTFYcXRKSnZIazd1LzZ0L1MyRXcvcnNrazRXbGdjK1JGTWNldXhT?=
 =?utf-8?B?dUdXQ05OczZRWllGSEl2b2ZISGo0V1JXYXpSU040ZXZoc2w4a3k2ek5zYlUr?=
 =?utf-8?B?dU1HUkh6UEdWT0NlMm85WEM5SzVOUmJGMjdac1d5RWpTRytCUDUveHZ1OU05?=
 =?utf-8?B?aVAwY2VnKytTaWNSL2ZWVmd2WFFKU1k3K0VwSEJ0SU9GdlFMSW1GK2hyVWUy?=
 =?utf-8?B?NDBFVklDZHByQ0xzMFFBR0JyOWtWd3R6emE5MTFWWDNtRGVqM3hzSm5SdGF1?=
 =?utf-8?B?akNwTGpmS243OUxscjlQemJXQ2JLY3JsUVFPUEU0SVh3VHk3QXVsNncreXZ1?=
 =?utf-8?B?S0xyWjJNRUljVU5tRUliZVJybnRsRUdIYlBSOWZXWnlHUEJ2ZzZGbGhpRGpo?=
 =?utf-8?B?emFSM2lRNTBwWWoySUFId0FVNFFlK3VJbG9jMUZDSVdYTnVRQXlBdGc4dWEv?=
 =?utf-8?B?ZjNqWnpaREFlTHpvN1locW9zQy9yWitmUDNZQ3ArMFo0dVJZV1hmOFBrbGFU?=
 =?utf-8?B?REtZV2UweGl3WnhtMlBvbVB6ZFBmVHRDUkN4dzBwdHc0bmJwNnFKZFFQWHV5?=
 =?utf-8?B?bVpjanRJdXNOZnZsTTNKMGNXZm1yRTlHclk2OFJuUkIvVnRzdml5dEgySjdU?=
 =?utf-8?B?KzlnZDA5QmcyV1BLZjArU29iODkyOGUxQUhJVWhINHJFbVluTWtMa0RoY09T?=
 =?utf-8?B?TG5sMXAzcUhaa3hOK2JFVTFIUTdxM2h4dXRlaWRic0dVSERLS1BtLythTFpM?=
 =?utf-8?B?bHhsVzI0UEI0NHVTUzZDYTRTbzllNkVCYjBwUW1hYnEvYXNoV3ZEYjVabm9o?=
 =?utf-8?B?VEp2WndSdWNkMlp0TE5JMFNPbGN4NlExZENjbThjbUpMNnhndnZRdUFBR2hH?=
 =?utf-8?B?ZGxIS1VLT2JTMFJTS096bHFOYW9DQnp1Sk9TRzVvVUoyUk5FYzlaY0NmcjdX?=
 =?utf-8?B?a0gxV0NHSVg0REpKeFp4aEcxYUdFc0EwbEdGTUErbDhTekYwQjNrem9tQjJu?=
 =?utf-8?Q?IrPsvoxD7DLNsqtHWbybw8oCTYH9PqYFoqDsfJKc9A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c6fced-dddb-4e1b-6f91-08d9d16f4112
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 23:50:01.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbBQf5wgG25R5jLOzRxcH9CaFW+xbP5hQx3I4A+iQvAJZ7rrDwQ+uTgY9/STS1aasxSu3NBkOVNrJrl0LZMp5ZSzv2pLYycQe4OL05JM6/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1969
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 12/13/2021 2:01 AM, Shaopeng Tan wrote:
> This commit changed the default limited time(45s) to 120 seconds for

(This commit)

> resctrl_tests by adding "setting" file.  Since 45 seconds may not be
> enough on some machine environments.

This sounds very imprecise when you say "may not be enough". From what I
understand you have already encountered systems where this is not enough
so you have established that 45 seconds is too short. The next question is,
how was 120 seconds determined and how do you know it will be enough?

> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/settings | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/testing/selftests/resctrl/settings
> 
> diff --git a/tools/testing/selftests/resctrl/settings b/tools/testing/selftests/resctrl/settings
> new file mode 100644
> index 000000000000..6091b45d226b
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/settings
> @@ -0,0 +1 @@
> +timeout=120

Reinette
