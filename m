Return-Path: <linux-kselftest+bounces-11604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13537902A9D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 23:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75D828292A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 21:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201F35588B;
	Mon, 10 Jun 2024 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJoqGTCf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE471CF8D;
	Mon, 10 Jun 2024 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055131; cv=fail; b=tV1nngZG0maVqMHer7/Hakrc72DSlcjvxlXMu6GaO3srm3TVz9n0gRckYrbsjF+z9mx8brHDJUkTj1COHQ+N8wi+AEeGJUshtCkEo/BiQ0BeHO/MkrAOwD2ax/2Y9TkrCtyBU0NkvGQp81v58rmO4Lv0uGhvI35o1U7X8MXrcAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055131; c=relaxed/simple;
	bh=AFF2Vh46kMW3LtrCxWMkcTGvR1KPTy7Eb4spiMVbH48=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gI9qvCQ1XhzmHW0Zrr3zpW/+zcdwlFPrbcy46oqcT2bnLsvLkpsYeZf1N+74BvVfIdxU2L5j21bbA3yxcAadhUfOKdpzdbglIcWp+V11dI6Ok2wVFMkv4uBzgIo1BAHMngAv4BBl2u9XY3t2B8MpjhCBTKCRqAQcTUS5kTmK3gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJoqGTCf; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718055130; x=1749591130;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AFF2Vh46kMW3LtrCxWMkcTGvR1KPTy7Eb4spiMVbH48=;
  b=oJoqGTCfLK0PT6ebVWa59eCaBoHyq61+Bhwr6Ucw+7n8luOG1uMu2fIi
   kFoSxsrpEMyhmYzk6Arj26tJ0yp72RyvFEws1M4BW1YL8KglebZ+hG0bC
   WBoReTislytCviXfj1W9O7oVY/n/h4g1Lgi7KTYoECREn9CtF+pEej9dr
   +EQE/xvbvdmi/KHUoajUqO7zpZW1EL0EVyfzqmQsCVKkJgtKR0MRdDZq7
   FmXiYGtX6g9c6AN4MnAyypldGCG4IRU3H3BZfufv9n6+g9rtw7uiwqxWx
   c6Fpb7VmJ4lPcXBbNt8fTHrpYiN9X4EW0XGv1YBXdBLLN1boaDxx6mbRa
   w==;
X-CSE-ConnectionGUID: hI4/koycT/iTkPEgpNGwAA==
X-CSE-MsgGUID: hDZI3pfvTA+dfi67ajr9Wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14908128"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14908128"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 14:32:09 -0700
X-CSE-ConnectionGUID: z9UjxCHuROyuEmHyyZOnNg==
X-CSE-MsgGUID: VtEzrw8JRJ6knt19copVDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39188632"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 14:32:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 14:32:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 14:32:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 14:32:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHVD+ByS4LJDjzXqe2QQDMjjBU4EOFRxuFerK1nEtssx10/aZiZdJn1uXqT9JvKSwIxt2IN3jbbmqloZEa5oPqbLN6cDSN92yedTFpWsoX+ZlYsGj7uCrS+pYXJRq/rxGDqgT42RKhXbAxoU6rEKmVirnNs4RHByqEnMUNU9NJrHOXsIoC4tXLFT/H49vhatzPPoxWLu7m+y/EvQX6oGhV7FgphK8nfWqZUZsRgSGOGCEsxyCDJRk44hgK+Cfz3U52AWJJZ8DYSpx9hRh7ftVenAitW8IiEnJOoQwfBjnyKxxu6BFq9rT7bD7jUfM56KRIcShQ6Y+FboWImUhBv+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1b/pb7wgub1bXTXHQllUyq/y3/LoHSD8qrbx/WrT8E=;
 b=QZ+KLK5RCXIFJB70tGpE6FWnTl8LmiYYgrOK8hX+UzM7MNapJ1pwv6Et2muXLnAPA4K+28cL75yn6B18XMNzsEPEMw2noye3yQJdboozegdpzb9d4vFg6h8yqwVe04O2g+DfIoFGrRCAweYRjJmevyTgzIffIXC4kbYRlJQztGBKpWxAcqvq1mblBS2UbwBxSDZKPll6JJNg5VVoDxO+jxbULbfDWE3PCgQ946vTHlSHxVlIy7qhlOAAJ/6gl85Pzg3y8/deMqWQdsrw/FeBV21nzGMClsZePWIiRqJfbHxYafXxSwFZEkRRrt0Pu2bwbprbnq9q9+v2Icoxe9GIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7593.namprd11.prod.outlook.com (2603:10b6:510:27f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 21:32:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 21:32:05 +0000
Message-ID: <6a78de4e-8d36-400c-9eb5-d3d6aa9e1e23@intel.com>
Date: Mon, 10 Jun 2024 14:32:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/resctrl: Fix noncont_cat_run_test for AMD
To: Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
	<shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
 <7679d70a0ea939db13ae9dac20de56644460d6df.1718035091.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <7679d70a0ea939db13ae9dac20de56644460d6df.1718035091.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0361.namprd04.prod.outlook.com
 (2603:10b6:303:81::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 2215d49b-35f4-40b1-d814-08dc8994c668
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWxoSktUV29leG9NcjZuOHFpcWlhSDBYZDdYRUM2NWM5Z1lvWFB2NGpqZDBL?=
 =?utf-8?B?R2NHeWU4aGxuajg2VVlCZnc2RHhDYXdKT0VkZmx2WmdRQzN5TmtZS2Zwc0xm?=
 =?utf-8?B?NWFqOTJzWFFIT1IzQWgrM29qSUFGZk05L0xWUXJlVG9taVhlMXVlNFE3dTFV?=
 =?utf-8?B?UTgvRjJYeXY2blBZZ1RvOWZCMGVlRzlETEljUUVHRDV4dTlMUS85QmpFY0E0?=
 =?utf-8?B?dzNHRFd2QUlPWU5mN3RZeVdPU1JWMXZrOWJkV21YV0dWUGJvSmJnaWJ2QlNK?=
 =?utf-8?B?cHFPSmJ2Y0daU1YwSjFrcDFEc1AxMEFrRk4yUHVVQWorSkx0dkFQSkFidHRJ?=
 =?utf-8?B?UnRhUUxPckcwTVlmaWsyUFNUVnNiUXBCNGdhMDZrY1o0YUpiY0dGL3Y4MTVX?=
 =?utf-8?B?OGt3dzdkcmFkOEtrcEViQzZuaWN2c2ZBMUUxbFZoSGNmVVF3TXJTQkgxSzR1?=
 =?utf-8?B?UTdlQTNNWWpKa1piMDREWThPSTlpS2NxTWcrNWgwYy9HTkUwdmxncEF1blBn?=
 =?utf-8?B?d3M2SGlBRXdmNjRSdW16Qzlaa0FGY1E2NllrbG9TQnoxRk40ck96bXBZczla?=
 =?utf-8?B?YmFZajlkeDlRZU9ZOXRrZmN1MVBCTlJESTJpeUVSSmcvcHpzeVRLeEF1ZFF3?=
 =?utf-8?B?WWFaOGRsNElTM1g2bVF1WmtMeHdjQmoydGcvKzJzNlJoMFV3Mmk4Z1BkQytF?=
 =?utf-8?B?T1ZkMVB4ajBieXFzdERTdjU0WXlYZW1aTHYzMUZiZHpIYmFNYjg2TW5pS2Fo?=
 =?utf-8?B?UjFnZ0FjNkNSOGNEdmxaUi9NcU53OTNyT0xwOVd1clRaT2pDTG1nQ2crZGpi?=
 =?utf-8?B?V2RvNzdwaHJkL2syRGJBZmJ2R0lKWk43MFF1UUdPa2E4b2k2am8yaWlPRDI2?=
 =?utf-8?B?T0cxOEdUY1JaWExJVEZsUEJySmdWOFFCNEk2VW5VamJ3VkhvbnROMzMrd0Fs?=
 =?utf-8?B?WUlGT2M4dm9Mb0hsb3dEUmRPOWNHOWJhcXNTVjVReEQyb3lQcXlUZVhHd2JM?=
 =?utf-8?B?bm5Hc3Zkc1NIdmt1eFRGY3ArMFJ2TVlhREdJaEFhTGRodnQ0QTBQcUNsMlgw?=
 =?utf-8?B?MG5FOFIwaWcxZ2dFL2Z4QlRJSFYzNjVDMWFWdjJ4SEtWditOdENJYndVOFJZ?=
 =?utf-8?B?ZDVXRmVGOTdPRUVOVGlrT1lac29YSVprWVdKQWkyMFlJTXowVlJ4ZmczclVZ?=
 =?utf-8?B?MGMwNXBmcUk1UG9rZ3ZHWVRRellmZ0QzZ2grZXE2eDZIUjBwTFk4cmxRUXN1?=
 =?utf-8?B?TCtGVFlkWkZtOEhJTjRiUWVRd3FvcWxEVlVtTlM1YWQxaVdGdmJVOVNYNnQ3?=
 =?utf-8?B?dUFVZ3FxT0VQajFMMHpWYmlJaERIYUVDeVN5eDBKZi9MaTNJUUR4UmM4RUZi?=
 =?utf-8?B?dFdpb1V4UFBnd2JYdWFON2pRQXRNc053Z1B0TmMyREZGYjAwS04zbzJnQUtv?=
 =?utf-8?B?c0gycEdkdFVSOUhueGcybjcyMHVOc0xUNDdsU1V5YlcwZGtlcVQ3OVBHbFFI?=
 =?utf-8?B?Mnh3RWxpL1VkUVd6bi83ZFh3Nkt4clo3b0duaVRITWxJWWYxeDV6NldCVTBI?=
 =?utf-8?B?bVpVd1dJZzEwVmhaQTM5cjRRQ25ZUWtVS2hFNktkTjYrSy9KNVBJY1hoN2p2?=
 =?utf-8?B?L0NtNHdyMjZQZ0YwVWs2L1orQXBjSmZNMCtlVzk3L2hmdDBwOHVQT3lhVUhS?=
 =?utf-8?B?K29KR2V1Y05aeTJQbk5pT2V3dnRRM2txb2QybE1SZnZsVUErUEJzRFduSjcr?=
 =?utf-8?Q?dxRdJi6C4iY0yU2rnXd5b9+tO6PymKeglYOmJD+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTM3Z3hEbDVNZWtxOExQaDJGdHQ4dzd5SUY1UGVTYVdRVTVuTXJNeE5lZ3Ux?=
 =?utf-8?B?WnAySllBdVdYRHNFeGM4TmlJd0FXSzVFZ1FJRXBLd2VrcTZsY2l6SFZ6Rkl0?=
 =?utf-8?B?YkdDMUtCOFhDWFlMdHZEdHp6aE9jc2V0NmtMT1dQR0lkMUxMbXAyZDZ5VTBG?=
 =?utf-8?B?U01vUTd3WmpCeVJmUFJtbkN3VkxnQmd3VjkydDFsR21yYVp6elh0UUt3RDdM?=
 =?utf-8?B?YUFneUdoNlV2NnBIOWFWeXBIU2xwRklVUWhoTTJFR2pFbjNvMjcrcHFxblBD?=
 =?utf-8?B?S1dRMllreURnZ2tMN1hrMFJVdXhQTzZSL2ZtajJRN2YzZW5SelNQM3lWV1RK?=
 =?utf-8?B?eGsrZythSnRDaVlNbThSQ3NZb2xORHVJYlhuQ09rY0Y4UEJHb29qUjVVNmNC?=
 =?utf-8?B?N2VrWHVKeWNEK3RiMGRCZ3paR2toMG1HamhRV0N3T2pDek9PcDFtRlY3NXpm?=
 =?utf-8?B?R0Z6dlVqZ1RNRERlNDRKOXRoM2QwakJBLzd2RVBwa0g2Q2xkNVRsanlVdjR5?=
 =?utf-8?B?RXl5Vlo3TC82aEg4TlBjcmxxTDhpTXBKUXp4OWNPOUEya050ZkgvSlRFd1NN?=
 =?utf-8?B?QnFZS2VQbzBFczV3ald3TGF6MURMQmtOaGhkVEdCUWliN1lGcHZicDF3L3BY?=
 =?utf-8?B?Q1JsanFUYnV1MW5xKzNQZy96VjN2eG9XdGhTUy80aGc2WXY4dUxzRmJnS0Zl?=
 =?utf-8?B?bkc1eVRxQTdIUlN5NndoV2MvNzhBNUhobkQwZURWMWxtOUFlSlFjSHRJSXFj?=
 =?utf-8?B?NmxGNm5qOGZteUlyZ1pFK1ZiUjVZbDdGZ2llUmRZQVlBWmF3c2FhdXpnbzVY?=
 =?utf-8?B?aFExL2xHdm1DRVhYSlJQMUlXU204VFJpNVA0OVBFZEViWDJjdmZrV3Y1SkpJ?=
 =?utf-8?B?QjY0QW54Z004Mk0rSlE4WXpYb29vb01tUkVlNSsvZ2NBeUh5NFhZc2k5alB5?=
 =?utf-8?B?MTcxMDk1MTdPZmxhMHkreDYzM1VTeHJWRm44aHB4eTYrRlhWejhJZXQ1MFRM?=
 =?utf-8?B?OG9wUzNBK24rTVlLWGJER2lqNGNTZVVKcEpleUJ6YUxpQXkzNXJRSWtxZFh2?=
 =?utf-8?B?T1NPRjNYRHJJN3lQeXVUbzF1Slk5dVBrWEMrb3RLUSsyd0lFU3Y1YUFLamJ1?=
 =?utf-8?B?Y2FabDYvazhLRTBUMzNxdmN4S0xVS0VtbVdJc3c5MG53V0xiMFkrNGswUURo?=
 =?utf-8?B?S2lzLzc1dG1teTBoVWlPU29WS0ZNeEJvZ0VkalhjT0pjUFprS1dtWndNSms2?=
 =?utf-8?B?cXdKQklLTFNRK21xVS9MMHdEeEovcUJOU1MyQ0Jwb3lYcUFGZGszaE5SR3Na?=
 =?utf-8?B?QW5KNCtVaEwxN3B1VHpCVGVhL1ZBcmxWN29EZnlXSWFkVU9YWXIxTjgzdXVa?=
 =?utf-8?B?dk5UQUxsUWFaOGpLcWFLVFV4dmJCQk1xczBQQnVIK05DTUMzeTBTWjRTazNm?=
 =?utf-8?B?UEkrQXJxQ0laQk1CeHl4bHA3ZGphUmRWYjduaFlrcjlETVN5QXdsM2pISTBq?=
 =?utf-8?B?TlEyS1A3c0ZqM2wrWE1Ha2tTdC8zdVZNcE9NVFBsVTdqNDFWbVM1NWdHOE51?=
 =?utf-8?B?aEJ0bm4zR2MwR21ha09NOVQ4a09uWHQ3ZHkyWWkxSkZtUXJiZ04yVzd5dUIw?=
 =?utf-8?B?MzVQblI3OHVGQkZ5c1Z0Mkx0UU85Sm1wTTRjd2QyZkg5UEY2RFZSVUUwaWR1?=
 =?utf-8?B?YWJnZkU4N00wUThNYlFYNWhJbFk3Ky9qRWwrTEt5R0xyMG5ERlhEVFpzK2tT?=
 =?utf-8?B?eXovN3lpMlc3ZFBuVXpJa3F6Q3hmMExiei9hK1VEdjdxNmUwclVPTFlPZmg1?=
 =?utf-8?B?d0REV1NFcEd3d3FuYTAzcjQ4ZXFKUGp5VmFhcEZ6a2h3ZkxIeHowSDgwRCt3?=
 =?utf-8?B?cUMxaWMwbzh3S1g1eXN3TURQWnZjekxXSkd6OXJzclVvL0NJQ2hXTCt3RzVk?=
 =?utf-8?B?anlWY29LTE1nejZxbU5DeTdqZXhSU1I0RTJjTzZOdXUrRktka3ZnUU1Md3Zl?=
 =?utf-8?B?Znd4ak9zelBBcUR6VmlCMzBVWmt4NFhERkFLTkFXL21kSFJYSUF1ZnhGU05q?=
 =?utf-8?B?aHN1MjdVM0Q2YzJ6NThnaXlqelpOeERnRXBwek5XUksydlg0dDV3KzFwMXNy?=
 =?utf-8?B?OUJ6WVphdEF1ZmlJR3c0VVFnV3hmdVoxelZCZ1cranlXeWhrWTlUM2ZUNTVW?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2215d49b-35f4-40b1-d814-08dc8994c668
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 21:32:05.8852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hn+YuQsoaxg8pUUvsTposBTIXtZT3ftPfb+pPaawAR6Pz7ulRN1/b4TwcP5ie5nscECfS2bWdixFq3PPHRhvXuMEOBrct7QrwM2IbyOCluc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7593
X-OriginatorOrg: intel.com

Hi Babu,

(please do not send new version of patch in response to previous version)

On 6/10/24 9:00 AM, Babu Moger wrote:
> The selftest noncont_cat_run_test fails on AMD with the warnings. Reason
> is, AMD supports non contiguous CBM masks but does not report it via CPUID.
> 
> Update noncont_cat_run_test to check for the vendor when verifying CPUID.
> 
> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

The changelog needs to be reworked based on discussion in other thread.
With that complete, for this patch you can add:
| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


