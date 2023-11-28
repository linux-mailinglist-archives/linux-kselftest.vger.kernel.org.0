Return-Path: <linux-kselftest+bounces-766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AA47FC93A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7509C1C20BE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A08481C7;
	Tue, 28 Nov 2023 22:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwvXxyGz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F958DA;
	Tue, 28 Nov 2023 14:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209692; x=1732745692;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nFheWMl8Q6PsgRdxEk37gC3Lb/0iSEhQVLADUqotUn0=;
  b=FwvXxyGzbaHtIMt72krwEVRdDi1FvryUgy2RFVXEzP2625YGH2NfmcLN
   aQRmsUV6xA+GLpDzT8Jrr2MwRoXvp92CcDkbJAy+aN0RWzLWpZHHjrM3M
   qkVdfzCbGVzM/zm0+7YQyZvw04dW7XKDAeKlsRAhbySdovDoIs+DOFuAR
   /vw7cVNTqrU3/hpqtxFyic2iQsnpbMnxEcgTG030MIo+CHyBSqQzu7BnO
   L6Ng/B5G/hdL1UH4JYew4kMQLZX3q6bw8HSGH2MbWjyqB4jlJR3QXNiM1
   Ncpbbzjpu1A4B8s/jI2D4Lk66WEwIN728bRjzz99zM/XEhy3hOQs/p4Ra
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="390201643"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="390201643"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:14:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="839207991"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="839207991"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:14:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:14:51 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:14:51 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:14:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:14:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjwaQmMgiq23e7mNQQ5OIVWCfZptOiBzdH+4GQ92bMpDDTl4nWkt2oEfSxXFngG+6c2f9Ic+WFY0YXRxaNFUvO7JdWi0QBD2M5BH+vj/RI0Zhlcy9PzkAtDdwbBI3k5yBixRfEAcGBkpTqSwdLh3Cqv1ceacWgkLpmVyU2ZhHmoK3em+ply1qTGIp+idiTdzz2Eyb/g3bbce7zwunGXJTJqvwLQLBU/ImPDcDqLD3fh+Hf1FhUp43wznze/W1rdSqYyWIWNIBJlD0Xa8AKTyuL8G2OsnniAUmJz11/5XFAsCPH2OSFw9dRRt8jK2nfxwtu86F5JUYQqa1YJQ6BEXhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJnFfK5BgEvWg2jC0F1XCvMOt8C3z/SluwbAcUGP+XM=;
 b=GrldhCRNkVtgBAfTAYq9Z0jduQ7PrsaLYUUgZjrxYY+AgaBB2/qDsV9xXJgugjg9qXXb4KlfAPHyYynyJLVea9KJqI4e5cYyRgKtRtjtLrzlZ1XMWIORz0RGZ9sSX1kRMvMQ4aH+L0gwZ7YyuCTezuNttCRfX/ljUXSesmXUWDnTg1XgxS1tNzZBhQjRTu0gbekKgQChrv0scdKjg1T//aABT9qs/MgY/GZH0ZPElzJN0cJqYUw7y3dVz8am2mLUsLmhfSrcbsEsGR5roFzXcGMuxtU/vfmAghRNttWOJIPSHIwaQdCZOut+D4UdpiYOV9RhSy/f7oVlfu04atbaTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8024.namprd11.prod.outlook.com (2603:10b6:806:300::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:14:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:14:49 +0000
Message-ID: <b5b92667-b999-4922-8109-787c3fd85aa2@intel.com>
Date: Tue, 28 Nov 2023 14:14:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/26] selftests/resctrl: Remove unnecessary __u64 ->
 unsigned long conversion
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-11-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-11-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:303:86::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9b968c-c6de-4f5c-a674-08dbf05f6fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8JcFdYeL3Y0KqBBPBakCho/yOK6QpM9AXalKCBim+aiohTsipPPXru5vS2QNt+NGUJWkqXbE2Z8vgV4TezBVFak8N9fttNaC2GTQqRUFoguHvZE3llQTJ74m+WXGO7U0h5daaMq5vhFqivRGbHpKHnMc9NDc7lS/xmTnJHNhmgCiYU801qyJlWTAs+jV8t6wi4/+KCsuy5zJ+VFTOthhT73+nMVxkhanyMWmwcBttpoJ5AJ7SzXH/WMJTmjQEFaEvyvEOShN5mTONBuRpgyjKgvJHx8VapYI+JcI2Y3wGGyetIhZVYxUUCW9tyR6GEkm9l51e5BZjcoPM0QMkh8eHT0QfUR8TKdXo2lnicT16ZOMVMj2uZwhDU3Va48VIU0yayMzi1HdNFC+mtyypZXLC/OaClynJfrQ1e1UqWsGt+93IufzytvFkVwfOFYOGaEZwp10XIu1Ma1f0O1V3fvFN4sJP2mlProIA3MADXXyz4gPpQVvxi7Ux7Rnezzmc2GxXocns3oXbHfsyUQW+ghDzM5jx4uk8+brnk7cS1kFk5OUtC9GtFsiGBftFHA1rPnzHCDSnfl2ujMETU+IRIIq9jiUnct9vkLP+N9Cqs3XpG6GgkcaoAate0RlrXT3vGvekWCN9kYihC/yzOCUCbtJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(41300700001)(36756003)(31686004)(4744005)(5660300002)(82960400001)(26005)(86362001)(2616005)(2906002)(44832011)(6512007)(6506007)(53546011)(8936002)(4326008)(31696002)(8676002)(6486002)(478600001)(316002)(66476007)(66556008)(66946007)(110136005)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW5ocnJKQnVNalNNYTZ1M3Rmak9rNU9GY0Nwb3hQc3lrNHF3SDRPdTh2YlBh?=
 =?utf-8?B?R08xUnZ3Y2xzUk5LaUdESGdzY1NmNjc0d0FVeXZySU1jL0U2dWwzNkU3Sm5i?=
 =?utf-8?B?T20vVllzTTUvVTl5ZDRFaTFRdHJPRWhGQVBuTlNBUTE4L2pvM2QySytGNlNW?=
 =?utf-8?B?cktkMW10M2xsVmRqMjBYbTJhdy9EZGx5cHpLelkwWDFucGZnS3psS0srNXhC?=
 =?utf-8?B?bTV6ckg2TzVIMVhXSTJRbDFZbFVBTnNyMUl1S2Rna2Z0SCtpN2NhaHVOOUJ1?=
 =?utf-8?B?UWFZLzBNZlVVUHNjWlljdmZIb2xEbFhoSHJiRHhGZWNZZmRZU1A5c3poUk9r?=
 =?utf-8?B?RDRFOUtGR0hrQ2tKK3NDUEkzWGMyV090TzhjMWRpYVV4VXZOSFN3Z3JYd216?=
 =?utf-8?B?RDhDR2RBOVN1THFHMm55bnBUN0NLdVZhbHJDWjhMb3ZXdGdHVjhkOTlrZHhZ?=
 =?utf-8?B?QkVWUkZOVG1OTVM0ZThrZmpqbnNYUmVOQ3VSVWdBUFJKMUJsL1NHT1hGNXZI?=
 =?utf-8?B?eG9OODYzT1AwVEZnb095bW9hU2lIWGVWekZ1Y2tXRmxnUkNNbG5sRlZQSFBt?=
 =?utf-8?B?T3NnTHZBaXJ1dDdnaDNqVXFrMFM4U2VxM2ZlWmRtcHRoNmNaczA5VTN3Ujd6?=
 =?utf-8?B?T1ptd09JaHJOTWZ3ejFlME1rRUUyM1YvT3BURjJ3bVZHV21Wc3hEelkxMFMw?=
 =?utf-8?B?bENsU2tHaitkR2hzRTByS2lielV3NHhMMzhORGtrdmNTN3hkMnE3dW9BQlo2?=
 =?utf-8?B?Mmw4alJwOXY4dkgwN29EbWQ0VkFGeFcvNWpNTmNUaEQraW9tVDVGTzUyVTVp?=
 =?utf-8?B?Szk4R2c1dFI0a0JDcldOSDRaampPMThTMnRqOEkvUTdUY2c4M0FvanBOdHpk?=
 =?utf-8?B?aUtMVDRlNll2L3VmejlCRWU3dExleUtUU2U3ZldIUmsyS0N3MnczalAyR1Vw?=
 =?utf-8?B?SkowWEdhcEFKMWVLMmFIWXkxN0NmOVVYdXVoM1RrLy9VRElTeEJpcmVBNXFx?=
 =?utf-8?B?UWVQRVc0RmdlMjFiajBpZlBsNmpNb0NiWGYyYjNmZ2NmSXExYncwZ1lyVDdv?=
 =?utf-8?B?MjVjRjFEYkNtSWx3eXZNNG5KVVpNek9mWWIyOE54bmZxbUVLQ2o5ejVoMW1h?=
 =?utf-8?B?UzA1d3RqR2ZpaWVtMGVnNkNaZEN6RnlpeUNhUm1rRkJZWjR1VGZjdW5laWZU?=
 =?utf-8?B?MVQ4U1NvZTVBUk1RV04wRndjb3JGRUo1SVJOK0tsdENvL2Z1R0xIM1Q2dDRK?=
 =?utf-8?B?QTlwSGxJbUNEbVlsdXdQaFJMdlEwUGFlV3FjMWhoVktHd0UzK0tLZ3BNU25X?=
 =?utf-8?B?YnBIV2dvTnlrMWhZWDBNOXlaY1ljU3YzNjRBUlJlem9jZ29iMUFGMnZaMDND?=
 =?utf-8?B?VVYxa2FIMWtsUENnSUNzWlNqZVh5ZjhRR0Q5eGVCNWlZQUdVcmxnYllSWEVi?=
 =?utf-8?B?TWFNNUNNU3BjNU93OE81b05Kdld4YUxLY011MmMxRitTYXNQL1pMS3Q5VlFH?=
 =?utf-8?B?dFJ0cTlmeUJMeGF0Z2ZYbmJCL0c4aC9MTVdSRnJLMVFHdGgrK0g4VThQdlFO?=
 =?utf-8?B?Z2NveG0xdjgyK3dtcWpvVWdCQ1p1UnE4RXhoVVRWekgyWkZsalBsbGI2Q21C?=
 =?utf-8?B?dkk0bHpxY0kwY3M4MXgyeFg0OGtjUWowY1FoUS91K0pQVXZCcWx1bUt3cklz?=
 =?utf-8?B?czRLMElyVzl0MmhKVkUxMVdUOWlVTGFnbW5nb3RlUUc3U0ZZenc2aTJvVFh6?=
 =?utf-8?B?U2FPd0I0bjBzc3Vwdi93a0ZXZm1pbGN0cjg0N3lHSHRQT0pKRTNVMWFwS0tv?=
 =?utf-8?B?Nll2eHRkZHc2N3VTM2d3YXF1QVQ2dUFOZEpRay9KZ2lOS21KRWI2QTd3UDZI?=
 =?utf-8?B?K1NTS0NzVDZDekhkdXVwYnhseTF1a2MrajJVYzYra3d4c3RQZWtDWkhvQkxD?=
 =?utf-8?B?aVRQcGY5WHJLQm50N2xhcVgzZ2l0UFhvcloxV1J5WUdhRVVkYjV6TENPbmhJ?=
 =?utf-8?B?dDJYOHYwY0pkSDhVNGR5RFA3bHBKaDRtQ2xsWWg1U1F0YmhNemRxVjNDckpQ?=
 =?utf-8?B?dGZDQVN6cXlLRFdEbXo3bUJkU0FJRWhiREY0eEFTc0RMZ00vTXh3bzBCaERn?=
 =?utf-8?B?ekEzMFBPektJbjNONXAwRnNQekZWeGhLSTRqNTMxdzVoZ2xzNUJyZTRycmh6?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9b968c-c6de-4f5c-a674-08dbf05f6fcc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:14:49.2406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZ/r5Dzl51p9sUGtfqBG0WZljdYQT/OPM4IbEGSJcaUnHAH03VooZDPe4tZuNJNqRyaYKRBAkUf2USW7zKruXFe7esTNxmY7d0jdSqD3LgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8024
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> Perf counters are __u64 but the code converts them to unsigned long
> before printing them out.
> 
> Remove unnecessary type conversion and retain the value as __u64 whole
> the time.

"whole the time" -> "the whole time"

Even so, this does not seem quite accurate since not all callers of
show_cache_info() and print_results_cache() use __u64. This seems ok
but it would be nicer if this was highlighted and not use "whole time".

> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

