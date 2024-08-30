Return-Path: <linux-kselftest+bounces-16827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B36966662
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 18:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC1B1F265F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1821BA269;
	Fri, 30 Aug 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCEaYGBm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1051B86D3;
	Fri, 30 Aug 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033651; cv=fail; b=obNkwhAz1cqMb2kPlV5RNkpiAZjs5gwXcKfW5mQbGj5LhV/FlnXO1ykUM7TW11c6bA/dtgMXQ+wYAAz87l/MPzGlEpXqhsiyU1WSr0qPkQnU8jpeJAdnM8Px43iBBxpNLxYzdMEPvGsNvWnldlBtAI/K3AcY2irs60SB/xwn5qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033651; c=relaxed/simple;
	bh=pUho1sVnG8km8TrEkgsnXqnBtnMQPi920zqdQBJ09Xg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gAjs0H3Eh1te9mg2xcSbFRwUxev5esFuHSbbaIpR6gFPlGvx0AMbKqBwF8sXn0BDVujrWORhyg4xiT8ac+pANPk7+SdUK39ZiYY6Wsbclyy4xqZFm1i0gWothlkUqY10Z+fyMBfab8hSHKQo2seAixbdB0hYxtL7xpp8R68Il0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FCEaYGBm; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725033649; x=1756569649;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pUho1sVnG8km8TrEkgsnXqnBtnMQPi920zqdQBJ09Xg=;
  b=FCEaYGBmWhOWHClsYEAO6FuDiumjq2aiKeevmx/pxvTR/bIiCvvzwEEG
   ZuPDyluNq/xfbqBQkY6rnDDfwobEx6fujByRhyk+NSf19U5Geh6kI74AQ
   xMnbzjIe2ZHTkmwUbxAzUmUKDWvhoZ8xEiFoONmJ32/w0drEp2EF8Tuy5
   91EBjAnswNH21zYn5Vsu5tn+Litzg8Nd4OmOS2up+KP0em7pEySghr90k
   r/TaZ4FdeViJWP7AiqYB79ZheMcez62Irdnp5/7I6xcx1pjYku7ldMy+L
   XfLTg0481TCpeS/nI1US0NT6YKHwfXXo90FxFAm7SADTBYAIC6xBTYgwL
   w==;
X-CSE-ConnectionGUID: ZHdj+cHES6yIAX2cwH1KVQ==
X-CSE-MsgGUID: GE+lU1SDTNy61/28GBlrfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34253987"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34253987"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:00:49 -0700
X-CSE-ConnectionGUID: 0c2qszTGQ+CXX+ia+ErWlw==
X-CSE-MsgGUID: jUuu7fLdRNG/7Llgk/mI7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="94673104"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 09:00:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 09:00:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 09:00:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 09:00:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 09:00:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQ85jRvCFoUJWbCSrUMisJu8ognQu4rwWGav9o+9V+/uZ+LrwenFl8PyDvhVwwGpUJWgQoX2c6uJtqk1nrKzSz3ikoJadS+0gWEPw0139Tjv0mal/BK9/LDRfdZDrDRmxccvRo4+DwWsuXwMP3yqEpBSGLEfzqeojtIFw+fwmfd+IWKSGBj8yJOgNpYpGUctTh5YiKAbr1M6uMG8oHlsZlrSGK4D3xukdVtupvtyTxdCKiksNQ3jh3karvV/MABV+2vPvbvFIpHifZoCiPUFRVjk0cxeIl4GDsE9C+VHJFF2aWMPndfwQKWbGBPR2CW7JvLz1aMrdcf78/cJNiBSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwTwfHqX5lB3aG2/gvngohvgo25QM0hhjoitM4eMAUI=;
 b=puNi0wXXkzaU0uDpicq9z+MtK3Tvyb2bgIua/2fundVdQ61U4bbR4rGmi5pTMDyizafXNK7i5qFG/PVvxa0u3HiHYKfz47zrfx6bPf0H79HxRL4FqtAta19wgpZcKFl8ymvkEgUkkrYT1QT4sKfxaigvkU9+YH70DvhGVeQKJhqDagoS1LRpw73oFjF2+HEK3TX78wB4LSSyL5YxL31drx7MYO0fqpuHfpKO2JW+i6tCUT2fUd/bb52Rv34CceH/nZp1IqYzeeKe6orNjLhjbr9bI75FfZTT2fJGB8LZnt+5rVxgu/Q6C+gJbn0V6llTu+webZ1Y//bhcBugp+fhtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5934.namprd11.prod.outlook.com (2603:10b6:303:189::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 16:00:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7897.029; Fri, 30 Aug 2024
 16:00:46 +0000
Message-ID: <094411c1-9ef9-4030-9c2a-35c78b4da00c@intel.com>
Date: Fri, 30 Aug 2024 09:00:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] selftests/resctrl: Use cache size to determine
 "fill_buf" buffer size
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1724970211.git.reinette.chatre@intel.com>
 <d357189fe0695b2140fc03efde75edc6fa0c88c6.1724970211.git.reinette.chatre@intel.com>
 <4434b263-9049-3d44-6b41-a840b39205cd@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <4434b263-9049-3d44-6b41-a840b39205cd@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:303:b5::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f4c94b-233d-4436-939a-08dcc90ce89a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1lzR29MOG9uTm9EbmZDS2NJSEs1RnlzZC9md0ZXOFF3LzVPYlNJb3NjeE9W?=
 =?utf-8?B?d1RkV1p0OExHRW5nMWZDYWlOQTA1Rm0wc1kwOWRMVGNqSVN2R01NWVNDSWFv?=
 =?utf-8?B?bTNwSDVLZ3JmZTBMWm1ISXl0RVJJNGJXYklWTk9nU09aY0N1QzNRamhrME5z?=
 =?utf-8?B?RTFhZGxsbkE5TTNpbVppdjE5Qkl0NnliWW8zSWlYZnBVbVBOVlQvczdtazNr?=
 =?utf-8?B?M2RicnJDeXNZdnNqMHBoT2FkcjNnNWJFcTJFeU1nZENsL2UxRHdRQ1orNTFO?=
 =?utf-8?B?OFBQZ2haVm5DbE5UOXFtcWJBSFlzMU1welB6a3Rqd2g4c2lYc1NCQmpNaFlU?=
 =?utf-8?B?bmJ2VS95TE0xK2xDL05WdHg5OUI0OGsxMC90bnJCZmpyUDFwNXRodGxmUUNo?=
 =?utf-8?B?S0d5VEgyVEYzMmYyb2s5TWJLUG40ajdlUTdNVGE0UXV6NVJsbnlFRElGbmh6?=
 =?utf-8?B?NjhrNkE1MmE0WTZzL0pUQ0w2QTR4OUJQMUVNTENRYlEycGlQbkMwdmw3SEpD?=
 =?utf-8?B?R1JzVHN1dVYzU0FOT1kwMm14cTM3NGVIRHFhaXRrWGthSGpMdyttelhyU1ds?=
 =?utf-8?B?eXA5YWlaYURwZDg2TlN6Y2pmZzg4cmhnelh4K1IzSTR2Y2R0T2pBMnpCa3hU?=
 =?utf-8?B?NGdFMTJacllYRmV2R0xxUzRjVXEvRHp2bWtYOVV4MXRDWDh0L1hENmFXUmlV?=
 =?utf-8?B?TGl3ZUYwbTNqT3NZQ1B0bkVLRWp5YU81SHlLUzM3SGVuTmpBSEZpOUh5ekRR?=
 =?utf-8?B?cllkd25GUTJLQ3A3a2V1ZnVXbm9UelhNNGlpNnNPdVREeWw3M3AyajFnbEZZ?=
 =?utf-8?B?NDNqM2JjNzI1Tmx2WndXU1pBcnUyR3BYWnpXU0FWc2RCdytEOHpXRTZtdFFt?=
 =?utf-8?B?M0krbU5hVU9RaVpCV3c1cGxtV2dISUViSDJVbmtRTVowMXIrL3RYRzdnOXNC?=
 =?utf-8?B?RkZrSENKYXZKZ1QwbVUvQmR3L0pMaFRFbzFlSGVXd3VldzFrTGF0ajMyckxV?=
 =?utf-8?B?NEFnZ0ZRbVB2RTVCTlFoeVRHUkl6L0k4cGNvL0xRMFNKWmExN0RDQUIyZDBk?=
 =?utf-8?B?Wnp6ZGdxa2d3N1dQMjUvcXFNMkI4cFNkY1pLa2pyNTJuT29vWmp2aXM1NXpJ?=
 =?utf-8?B?QXVzTHhyY1NqQStMVEhkSk9lZ1ZybXpMY3hCRGQyLzYvTTQzMmFxbWZmenFs?=
 =?utf-8?B?NzlXS1dTQ2dteUV0RnJJMjRmSmxmWFpqYUJxWFFHNFdpWlA4dVlWVUNqK1hU?=
 =?utf-8?B?U1NiYzdMNXpIdzJrcUVkUHJRUFJQa0xtcDVwNHZSYm5naytRWk1sSXNGd3B1?=
 =?utf-8?B?eVdoS2hTVFJ3Y2ZENm4zU2VXMU9wODBtTnVZVVhRUnFBem5JRFEwMXg1SXFH?=
 =?utf-8?B?Q3djZERablJJbjI5N3pTS2xPQmJPNGw0UkxiOStycmttcm9hNXFBb0hsd0d1?=
 =?utf-8?B?SHVqTHVsWWRDS0tnb0hxbnkra09kdURSNHJCa0R6anlLWlhhbFdoU1RrTjZk?=
 =?utf-8?B?V29yaVFKZ2N5TXJ5YjAvTHlRS2ZzaWJiY2lwcmpBTzZZb0dRTEE3KzRqMnda?=
 =?utf-8?B?dE9OZndkWEFqd2dnSjFmeXM2QkJDbGdPRE9ZZ1VVVWQxd2tCQ2RCamY5OHdZ?=
 =?utf-8?B?NDEzTUYwZmRjNjJXaXNTenQ5VWVzU0doeVlQbzhzQzZiZmQ2OElCaFJWU3dk?=
 =?utf-8?B?clRwZEIzaVVlOExreTRZZmFra0pFWFl2bmVYOUFONmpCYXpsSG9ydFZORHBM?=
 =?utf-8?B?eE1hemFUUkFXd3BEVStSVjJYMEpPRVh2V2VBcWhYYjZqS014cmkvNnA2dnE4?=
 =?utf-8?B?QlQ0V29jckNGSVFrWEpYUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlVuZlVKRUE2b01aV1F1dlczUlFMWnFKMXJHTFpzVDhFdTFtUFAvQXdVVlBM?=
 =?utf-8?B?L0lQbXJiS3RXa3FjMGRCNjczMzc5bGRXNi92N1FGYXVBQ0ZOMm9uSGp4MGZk?=
 =?utf-8?B?cEpuR1UzbFdhWWpta05XMTFOMXduNDFvVW9NWXg3TXA4am9Ga2lYa2U4aFR1?=
 =?utf-8?B?VHNFc0RnZGRuRjVHNkNxZFJMOFVPSHlZc1pqMjgrRHhiWXluTU9pNkdIMThr?=
 =?utf-8?B?ZTBCVkJVQ25OR3A3ZFpXR2RRNXhaUVlxUlZKcXc3Y282L1V4cm12RUl2SktY?=
 =?utf-8?B?R2tydThhVVYxd0Zib0V2V05mSDk2anZOdmFpaVZ4TUlaOEwvenRBcENPbHpE?=
 =?utf-8?B?dWs3TURmT01GcHlUdGlzNGVVbkVKbVI4K0NuREpvN2F1VzROUFBiTmFYNmE3?=
 =?utf-8?B?dk10ZWZWNzFUU1g4VyswZzNvb2kxN1Z2T2c2VzhmTE5CUFhiOFlGTGtvbDNv?=
 =?utf-8?B?VFNhVlQ2WUwwOXV6dXp3VEtKenJMNFhsYTkvNmt6UERnYllsNlhFanhNS0hz?=
 =?utf-8?B?WXhlY2ZSbDBxSUxUbzVycHFITkdGZlp0STBIRy9xSzlDSlI2UEJGcEs2Yllq?=
 =?utf-8?B?MlJGM1FLNXZON0dGcmh1S0hWa2FtUFpLblpKWGlMUDJPZndDWDk4SkdFTTlO?=
 =?utf-8?B?RWRNYkwxTVUxbEw0UDl1NFJycFVyd3MvNW0vUjFFanRRdkpwMTdGM3RFRXVt?=
 =?utf-8?B?QWp5ZlVlSlQ0VGY1MW9ZRWhLQVRSeU56NUM0VFUrdlRYKy9KTlBhUHl3ZmE1?=
 =?utf-8?B?ZlpXUWNYREVObVdXZkxkSjlqUmZERXRha3pWY2tiT0twYTRLME5QV1dNbGxT?=
 =?utf-8?B?VHUxRzQwZGFaeEpFRGVPRHBPQmh3cjliSXFxc1k3dlNzVVRLQU0xTWxHRkZs?=
 =?utf-8?B?YnRubDNPSjAxQ1NhUHhRWTJYMTc0N21hMUhlNzFkNExRb2tadHp0UTg0UFpV?=
 =?utf-8?B?QjR2UGpWQVU0eTZjN1RqZ0RkL2NmN0JyQjdkSm5TQjhQUnF6N0s3eXZ5ZSt4?=
 =?utf-8?B?VEJURFZ6WVJpcndlb2xDVjVITkJzbjNqeDgwQ2dDT3BVYmxmc1F4M1BrL2RK?=
 =?utf-8?B?TDZOTWlRTnVicVdJV1VmTmIvWCtucXZ6UXdKd0xMTFAwblpDTkw5b0RFbDZ2?=
 =?utf-8?B?cHNzd1hQNUNLM0FKVG1Ud0tHY2dMVzVKN3EyUStJWkR1Zy9JOUMyd3FYY3Jz?=
 =?utf-8?B?UmZSWFFKczhFK1BYalRDU1N2TUFqNkdvaXF4NjdDcjUxdjNWZnBKYXlseEFH?=
 =?utf-8?B?ZVBiZTVvUkNUdk43dzBTdTBvNTc3WS9BRzZOU0pVSG1kVDdlYllIQlVjdk1m?=
 =?utf-8?B?SU5RU3JWdCtlc2NxMUlHbzVIK3hpOTVzNVBseWFtTDFXY0pGUDZTM1Y3MU9X?=
 =?utf-8?B?Vm1RcTViQUR6Z1gyQmlzWnBTb3FIcW43MVFMSU43REtTYkVQNlVqNWQrK1Nl?=
 =?utf-8?B?WG5zS1lkUWpBVDJYRlEvV1BHMVBEREhWZHh0S1pWSzFsNjc1RlFXVWw3V0ww?=
 =?utf-8?B?NWNkM3FTTjViazRpMWtRSU1nWUdaalFCRlpiMUZoNzlwTEhOTjVPcndFYkN5?=
 =?utf-8?B?VGRLTXhEYkljWk4ydlNzT1NLV01KaGhzK250MmVWTndqalFrQkdNSGxwaE11?=
 =?utf-8?B?RjFaNHpjd1dZa3BJL0hFR1pmdWdUeXJCUmdlSHJJSmVXVmIwcWQ1U0RnMWNn?=
 =?utf-8?B?MVliTW9KS29PSUxnSi9kb2NPVVdUNXZyYUtwM2VTSXQrNXpRY3RDN2FYTWdo?=
 =?utf-8?B?ZFpodWRmNXYvbFJxc1ZESWJDWkc2bnJBZUtEbm1nakR4b3daTnFySFZiNzhj?=
 =?utf-8?B?L0RwTlE2U0EvTFNTVnFDM25iaEVwOTBnRnhZb0FteWk2ZXcrUXcvMGRmcVhN?=
 =?utf-8?B?TkxUclo4WjlvUUl1ZVRDLy8zRTVnamUyVGVVZlB5MXFmb1o2QlpMdVcxQ0px?=
 =?utf-8?B?WmtCS2kxc3c5MlIvK1dDeUY2WkZtSzVrN2Zpb0liUVYxd1pvcyttL2Rsc1lK?=
 =?utf-8?B?R09FT21Ga2VVWkNESTcyRnpNOUlQU2hxd1lhdnBlT3p1dVhPdHZBVzByWVFm?=
 =?utf-8?B?ZEYyODluWlpGc2xTY0FQdGR6SkZ3VDl2WDZ5VDhaeVh2bkRhUTVESDVJK3JP?=
 =?utf-8?B?aG1tWTFQdTRRdEhkQ3ZMajM5L29tNzB0eEtSMHY5cUN0SGEza1FGK2FmRUUz?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f4c94b-233d-4436-939a-08dcc90ce89a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 16:00:46.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2+nuYtxKLwdYe3CqC2POMUYwq9TF4l1ElmHj43PTWW/bIGArPTl8t/vNI3/UjOOtjUKYMst9TAUe1UHfN8WXUMNh/tAmB6zs/R4BvcTliI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5934
X-OriginatorOrg: intel.com

Hi Ilpo,

On 8/30/24 4:25 AM, Ilpo Järvinen wrote:
> On Thu, 29 Aug 2024, Reinette Chatre wrote:
> 
>> By default the MBM and MBA tests use the "fill_buf" benchmark to
>> read from a buffer with the goal to measure the memory bandwidth
>> generated by this buffer access.
>>
>> Care should be taken when sizing the buffer used by the "fill_buf"
>> benchmark. If the buffer is small enough to fit in the cache then
>> it cannot be expected that the benchmark will generate much memory
>> bandwidth. For example, on a system with 320MB L3 cache the existing
>> hardcoded default of 250MB is insufficient.
>>
>> Use the measured cache size to determine a buffer size that can be
>> expected to trigger memory access while keeping the existing default
>> as minimum that has been appropriate for testing so far.
>>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>>   tools/testing/selftests/resctrl/mba_test.c | 8 +++++++-
>>   tools/testing/selftests/resctrl/mbm_test.c | 8 +++++++-
>>   2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
>> index 8ad433495f61..cad473b81a64 100644
>> --- a/tools/testing/selftests/resctrl/mba_test.c
>> +++ b/tools/testing/selftests/resctrl/mba_test.c
>> @@ -170,11 +170,17 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>>   		.setup		= mba_setup,
>>   		.measure	= mba_measure,
>>   	};
>> +	unsigned long cache_total_size = 0;
>>   	int ret;
>>   
>>   	remove(RESULT_FILE_NAME);
>>   
>> -	param.fill_buf.buf_size = DEFAULT_SPAN;
>> +	ret = get_cache_size(uparams->cpu, "L3", &cache_total_size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	param.fill_buf.buf_size = cache_total_size > DEFAULT_SPAN ?
>> +				  cache_total_size * 2 : DEFAULT_SPAN;
> 
> Should the check leave a bit of safeguard so that the buf_size is at
> least 2x (or x1.25 or some other factor)?
> 
> In here buf_size immediate jumps from 1x -> 2x when cache_total_size goes
> from DEFAULT_SPAN to DEFAULT_SPAN+1 (obviously L3 size won't be odd like
> that but I think you get my point).

Good catch. Will fix.

> 
> Also, user might want to override this as mentioned in my reply to the
> previous patch.
> 

ack.

Reinette

