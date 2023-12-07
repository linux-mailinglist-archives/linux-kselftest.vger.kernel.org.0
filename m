Return-Path: <linux-kselftest+bounces-1375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC906808FF9
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 19:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A78B20A82
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826EB4D59F;
	Thu,  7 Dec 2023 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbMavK1S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20059171C;
	Thu,  7 Dec 2023 10:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701974131; x=1733510131;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a0XTHyAi40JPmfv4mrWRB4hoiyBXU5t15cyHpNSGfXU=;
  b=bbMavK1SBw03wxdTajQCrPe9bL/GqmHMydOqqS97rUTkSpVZ682fw0c9
   Xp4l+aPWMxF/vuYkh5bMHWKliU1x8DH39ooYvsJZ1/nqE2mV8GBLkws3L
   iv8900HEap7+jhZl9PfO7kvnknD/Rl8emzOlRh3hCTA1tSj77k6E9O00I
   esEmazH/V2dDXpJL+usdfWU0vvKZ0+GhYkoyTW9dJ5St9D7B7S4mDS1YF
   HWy3dyQmWmClsZpq/WxY2vbonpMbrboZXDSK+5TwpCqYAZQsUdHs+JBqS
   J81rjWVVn+x8jkRZNwEVpaGqW5y7uLE0qr8nk2pTvL0j0pIen6/qbM5bZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="374448203"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="374448203"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 10:35:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="837830160"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="837830160"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 10:35:30 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 10:35:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 10:35:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 10:35:29 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 10:35:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJvvx1Puo18FIE8CEpbmZKZ41McYnC7EQPlwwJMvwmNKW6mRioA44BuFYw0TuNakCMd9QB9VBToBO35MJzBuukcVmFtw55MCkw2+mbvYTepWlUqZ6aS2qyY/W9Ty4c9HCum/wfcUDmvo1Wuiovu5I6Oc0gG2meD2qCar2W5PT+wHL8R9CYe+la9xy/OEt0M3wyNebf3+X16UN0cMxXX23z/UD4Y+59oUFspdOLQpkMjhSaF9KpgpQ3lFnF33ItCVQ1vsEO9hPuT/+lnNuefxAUDcSuyKm/EIz4teq80nEF0rbqnem0cpy+TK/u4Ls4ZpWQmtnw0GLskcHn9JPUBS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIe9Kj34TXVMvyZwLYvNYZBHxuVPQjG7i08qcp4tjBw=;
 b=BgMlBr1V/NT588b05qQZh9U3K7RM7bP7aikWJ7y49bks8oZHjmR74I2pXDr9/fF+PRRPRb0++Uc2ewotUNtBeoCMv3wyUfUunfvg2/3+dD7fgo46Xxkq9axcrYT269GXmOU9YHu6juSj0VxL35L+IzUAAXXjPB/a1b8VIn5eTTIpFdJp6MuY216RHkuLWVpfcKqP9Qzseq91Hcz1HJJ4sOItBi4BvyLkB3Sgl8Bp2vpEHmZzNoDIc8sIrVnA6wQEZDhSBYfctlevDK8xrruCCxCPyUPa0gu3lexIo+OrV6vhskPENOfwODJgK9AOXpxnZ1AGtvOaESOEDfgm4p4jHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 18:35:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 18:35:27 +0000
Message-ID: <bf59d8f2-7977-4dc6-afca-9c80e06ee549@intel.com>
Date: Thu, 7 Dec 2023 10:35:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/26] selftests/resctrl: Split measure_cache_vals()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Shaopeng
 Tan <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, LKML
	<linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-9-ilpo.jarvinen@linux.intel.com>
 <c303ba1b-d7bd-47cf-9e81-8ea0c60b973c@intel.com>
 <e87d8ba-141a-5779-fc6-27e4735fc1bf@linux.intel.com>
 <8f6c7b40-5218-4427-865d-55e5f09c594f@intel.com>
 <f6f42f73-ef84-535-78d7-c93685625aca@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f6f42f73-ef84-535-78d7-c93685625aca@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0138.namprd04.prod.outlook.com
 (2603:10b6:303:84::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ee73a9-424a-4172-84c5-08dbf753488a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3YrbvFMBphsDYtxdWtajZGcwY80N6VfCaytNA52uvTLHnOGW8io6WnDCWPaBxc2MeC+1lnDAIj7z9Aldutn7lqY0DrpB+/b86c+GAGAxWjDbQMa38Yoy+r4z7pXece5ZJPEvD9cFr34JXLaKHEEGKMpQ6Sk/U4Sh3YXKrnuBjMA9EvNKBiKqIzhNGDnu8t+2b68jP0GPrbqrKvNPzkof00HxMjGs8icPy4Zy5l5wW/Z9f1qgVErspmiqyUxfHRvdSkVrZHOwSbOZoyjcR6eTAyurEOiX0pEC2lmIMm83rXDa4IR9/yDMxK1vNmeB08hLN9cS7d1joV3ez0AUpQlqWmHzfc1V0J82FSNDqr/nAruV9pCu0dKbYLRSJmfXOqjryehizhvNHkndEi/ySQ+qe3MwndxuejI2CqzLFNBkA7xpgZg7+wFJwfnyfChvYiFnoK1SYNIry52DjtaioFwA1cvJnNHM6x4I+061qMfKW79U6tYCDB+8KDAmd4eYZA4uGJWqk7hp/m08JPK2uI9QR32SuWBsjhb+zXugKTefuxWzMxgbZNrCIqFmDB5jveJm4XhW3hQKQJ+urt4od++GaO8Pultl37vBAqg/2UrgV7wnQsHXDgLIsLJ9CLWV4PpoVi/UTesXnKfLjBq8qaO0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(53546011)(26005)(6512007)(8676002)(54906003)(8936002)(316002)(66556008)(66476007)(66946007)(31696002)(31686004)(6916009)(38100700002)(6506007)(6486002)(2616005)(82960400001)(478600001)(4326008)(4744005)(2906002)(5660300002)(41300700001)(36756003)(44832011)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3d4eTFYZFYzRkdGRFZMY3lIa2s2Z2sxeGxMTHBIYmtkYU55NTdkZTd3cHQv?=
 =?utf-8?B?K2gxRjRjak5zekhPdFF1VjNxWmxnYU9yc3VnN1VoK0k4TE1OKytIcXVVbVdM?=
 =?utf-8?B?TlZzczBmU2ZmWnJHN2pFSGRlVVd4UjZUK3BkUDZVNmZhOTBHSDZhUzJNVlJC?=
 =?utf-8?B?VEZJMVByL2RpRm5GVGZySE00VHdXK0ZaYkx0MGY0RGZyeHZ0TVJybGZPNjlW?=
 =?utf-8?B?Y096VjdEZjdDMVYyV0ZiTHRSYzRYZTZoMTdIc3VlcFhZa1ZNNVRSajNRTm5i?=
 =?utf-8?B?SGN2RndBVGI1SG1DcU9WanhGUEl1anp3RDZTMjBzeis3SXU3cHZKNWxGa3pm?=
 =?utf-8?B?cUJlTU1wOXdYU3VaU0FhT1lta0hEYmpVZ3JOZENobmdkamJWWUsxWVN2bnpy?=
 =?utf-8?B?YTlUL3R2Q3lSQ3ZmM3NQeWxudE1QZzJqb1hUWU5FSU1IeW5hV0x5VEROd3k0?=
 =?utf-8?B?Nzd0Mng2T05UOGdHZjNmbU0rOHNDZzRLL3hBb3hTTnRFekV2d0pINHJLUjB1?=
 =?utf-8?B?cVVJSlorbVRXdTUxTUZzV1M4NUUrdHJQTElSZS90eHQzQlp5L1A1cTJoTU1a?=
 =?utf-8?B?TWhUWTY1T2pyUjg4K2phMENza0h1MUdXM0p2encyWDI5MVZWaTkzOUJQNjBw?=
 =?utf-8?B?Zlg3d0w2NHJsM2JNNEo0S0oySW92cjIreXRzMHhjeE5tWmwzQ0FuTmNKcTVm?=
 =?utf-8?B?S1JYc0JUMkpaOC9UQ1FGUC9zTTNja0tlNk9UcXVRUHlFL2RmM0oxVWdaM2JG?=
 =?utf-8?B?SVRyOCtOb2p3VkVJekpXZXIyTjMyVjFNd1g3K1lIaVZZSmEvZzBjWlQ5QVJx?=
 =?utf-8?B?aW5HOWFqb0d0cnkwT0dpNTd2RkFJY0JrSzlDOGk2WW10REQrWXZ3MkZaSW1W?=
 =?utf-8?B?ZVpIQ3dYTU1sTEpjcUd6K09LRHFZV1F0Snluckw3ZnZ1Ylg1WDBoVW5BR3Z1?=
 =?utf-8?B?eDJtbno3TzczVmVaTGNyYm9Id0FRTFZyb0FRTzlERXRmdHRHb21RMDd4cmUx?=
 =?utf-8?B?eTRNdXNMZGN5bmZudzNuVFpTZnltbWVBUllBR0hXSjU1SXFDdlRIMnRwTHBy?=
 =?utf-8?B?MTZYeUppclhDNTJRSEtwa3Z6N1NibW01Nmx4WnlWQWRTWkJCNEt3cFRVdlg4?=
 =?utf-8?B?M3o1cDZsOS9qYzZRQ0E1YllkYXZBckwrUUh2SU8xbkNqTXdDMzFVeFA4T2lY?=
 =?utf-8?B?NG9zNmFPZWt4dkRjUzlVYm9EVHUzNlpJbUhtNUU1ZFF3VTdQeEd1ajdTWDRG?=
 =?utf-8?B?RjRDZ1d4Wk1zbDgwVXhXaUFKeHk1VGtwN2xvWHE0ZkRhL1VMWjVXNmFILytw?=
 =?utf-8?B?RzBYMnpNcFB6R2ZtSDRaTTVURUkzb24rVWdyM2hmeC9ESEJ1NWY4eHBUWWIx?=
 =?utf-8?B?V2lqTlN2Qm14Y0p3bVJVS2d3VGVoVDcrTGl1R0FnVTM3aW53eS9BbGlrNDJu?=
 =?utf-8?B?eHowT3orNzFFYzd4RFVmeExtK2V6NlpJcVFMdmFTSHFsL1dmZ0lBTWdHeHQv?=
 =?utf-8?B?K3BJcnRsbitKaUdMeUlHdzhyT1ZkTzRaQUZpRWthWEZLS3FIeFVtdWRKSzVx?=
 =?utf-8?B?Qi80QzJQc3R4S1cwc3hhQUljUExMOTFXbTFPeVc4ZStyajF5aVVGanIvZGE2?=
 =?utf-8?B?MllZSFp0dy9yUmRDQVpOL0s5cGVVSTZ2YWhMcW43dzU3dWZIRUV6TEVBVDJG?=
 =?utf-8?B?SC9vaGRObm5YSjdUSWJlNGVTVklFZkRNMnBkak1TeXhQZUc2NzVGSjBCMFZ2?=
 =?utf-8?B?OEZFczU1anU5OUpZbDdKKzJkOXlSYVZoa2Vrb1pLT01KZ01SSG02NjVMVmx4?=
 =?utf-8?B?VlJFY0NlZWxwbE1ybUtpb0pqSFJQWWhjbXRRM3NCNGVsREFvdjVQeGcyVEZU?=
 =?utf-8?B?bU0yWmdQcUQyRnlTM3VJNlFWM0tiK09VSWlaZDBaUDdyYjBKeXROV0NLTnZl?=
 =?utf-8?B?dzd4Z2loM3VEQ0JsU29JNldzT244a0dFNHdrUmM1SXFmSm9KQWQ3MjdMZVll?=
 =?utf-8?B?cTJYUDZKSGpORmdhQ1MrWnBUTFBwZUlpVU96WlBOYmdXY0JWaTVOMFJabHNP?=
 =?utf-8?B?eGp1U1g4cVluZWNhaGNtWkNlNlh3Zy9USEpERmtlRWZlOTdrcHJ5N2xmOHc3?=
 =?utf-8?B?MUxlWTFJUkVNbGczK0pJdS9VcDJLM0s1STlVdXpSZHIyZElVNzQwTzhHbDBu?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ee73a9-424a-4172-84c5-08dbf753488a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 18:35:27.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DBvWt39ezSyNKkrorUMXPbj/l8Bn0k7XrFeRHo51A4FHz2CKR5oF5P3IpRHrpzebBNdG7WMeSQylXN6QtGSt3XtS+pegxOZlUjhivh+ZOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5373
X-OriginatorOrg: intel.com



On 12/7/2023 10:33 AM, Ilpo Järvinen wrote:
> 
> I already spent some moments in converting all return error -> return -1, 
> since all such places do perror() calls anyway (which I also converted to 
> ksft_perror() or ksft_print_msg() where perror() didn't make any sense) 
> there's not much added value in returning the errno which was not 
> correctly done in the existing code anyway.

Thank you very much Ilpo.

Reinette

