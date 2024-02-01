Return-Path: <linux-kselftest+bounces-3951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF46684615D
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 20:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0033F1C24902
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE978528B;
	Thu,  1 Feb 2024 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqOhNoPi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF641760;
	Thu,  1 Feb 2024 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706816882; cv=fail; b=H+AaWg3PhP1shpxVB17LremLEStpgGy/gbXIgLjCmgAVq6eakyKF+GGf75mrGB6wO6qX/deps5pmKL+4nmsZY6X/YbM6TXF15V640IzCPwL/KWTDcstXJDNo+OgvfyRL1PPAa72PE4llKgE15kWcWtOGRM27aCB/LZe6DbXSZFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706816882; c=relaxed/simple;
	bh=ojwNmn99O58HBhAApebXyDtoSYEiseUOBQ6jjmFmviE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DHy6Z+Vp9jL6vDCe9A1pW5B7F2aYUVx2X9xsDcmPfUkiT/feHQLSMjQCbPWhId6oDz3T277oZ9IlzNQ7yQgXp41EFRzgCbS8MZDNbVZETqAzuhGdRt5e/zdVrQxS0qavKJ5JqLz+rIH4ZZzMycTrpOudPQ6NgBOTJgA2ML0s5wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqOhNoPi; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706816880; x=1738352880;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ojwNmn99O58HBhAApebXyDtoSYEiseUOBQ6jjmFmviE=;
  b=OqOhNoPibYa+VAuzjcDE/DfCM08ZBzQKm3oqP7C2tp+teEsVNCIc3Pon
   kV736tI6HmH06/n+sr7ldu87fBLI0b/9nMlfueXNAYFmxwoE7QyYX+9Zc
   VO/9mTrrcpzhDrUPbH4kOqpbkVRlteDNwzd+9k+PdfwwYveccjkoJKvmA
   SgHTaOdM0lkCLbfZYeZsgS8UHVqs5Pj/LdcU2Yoac7Kwc2o62Z5ygsSPJ
   JYMCQr4H3gdrzQzZ29IuHYrGabMH6nXXfdMKOWMmSppKqXCKDIoLS/CDo
   BiJQAM5f5dcvkeYlwJ7saH45GGx/C31Zow75HgrhgWhVcgsiZlq3HTBXU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10614721"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="10614721"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 11:47:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="195080"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 11:47:57 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 11:47:56 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 11:47:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 11:47:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 11:47:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8S/6QvvonPfG6gCKP7s1nw17fFDxX3YRelHr8ZmE3cSg6YG26ImWUeEq6yvesC+uIskfpwOM/IWPhpMgofQk11Vt2erSoDXjAwDpO0McehXabiPbx6kpQfD0lL3b2lZKlmbX2utDUtEw4JTAzkZU43YBZPKDyLBnazp6AqKqQ0oxF2PUiUMAJYDIb8iWNz7OzMTMqF4tBMYurX+BDTcE6wpnUgsTNWBjb4NxLwqKJKV56Q25J3gT9C7vpp1jUpR6sVQSnOJXlQ5NsXjpWBTcsNHNv2KREwrHuy7QNjpBAPvZLGJVyu45UVMkPCiQnVXc8So+nF8HPBc45PbLCT2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9Esk74yJC69BO5NjAL9lc9ghdAt/8btTLKYi6HG7/s=;
 b=ZRoHoD4zu8+Rqx2/qbednTA0+c27MZtZhzgMXaxlGy5JPKroZPAVWnYWazHUlojxT+RgSAPnjF1OB4/38CU26iN874sXDDIC4y87o1nEuor+5U0x57V6MvkHj70A6QVodVfw1afQdmKpz3ouRcFX30M2HJYRAftBHHksGxDiiqmmtWVAlan3KyL7nBU5a1ITLEk5Kn/LQJqm3P9CPB14jj7jHfPVA4uXgB5Pqa7CzBqD8v1lCbrnsFWsdxJrsiVavCTW1li3rSoYxuPzGdT1zWCZcZT40vhlrDRVyel2tqs5+fYNI5pesEBwyUKvkztXb357HWMa3dueJwEKoln7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5475.namprd11.prod.outlook.com (2603:10b6:610:d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.27; Thu, 1 Feb
 2024 19:47:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 19:47:47 +0000
Message-ID: <6a7b14a7-966d-4953-9b9b-0c847c83ddbb@intel.com>
Date: Thu, 1 Feb 2024 11:47:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
 <647fbfd449f8b0e0ad6cfe58bb280ff44ee162b8.1706180726.git.maciej.wieczor-retman@intel.com>
 <db08ba56-ae73-4c70-87fb-aae59e524238@intel.com>
 <jbgkiwfkotntcdzhwf27dceit4w3j37sumkayixmyuee6zyaqg@un22a2iljgmr>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <jbgkiwfkotntcdzhwf27dceit4w3j37sumkayixmyuee6zyaqg@un22a2iljgmr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:303:b4::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5475:EE_
X-MS-Office365-Filtering-Correlation-Id: 571e67c3-6493-4041-4b0a-08dc235eaa13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFk7WJtqyOPt9mZrJousYUKHrz9uJsh1Ayz3DOHnUHpIBNPe7v5RUc2jJPt9pExjtNp/EGjh3uWupmA/WeR+rlkby4O+Q/dwP/ymkje15t0BxqJMHmi2CglouRAa+Ajb4KvTrZHW5oKFTU7GZE6cOHROyiqO2h94zjqM+lrb6+T6KQMIIspLLxmbRCphGLuPdXfTSJZwby9BROPQoZlu8zgrnh7buGlys2tD3y3drd0Tl/qPu10adgbv0+HvqPSJbF4xS36AAeLX7BWDw2ukO/QzPLmfNtcK1H/caIgSOpE+t5vUIs7GPYfN85/CcA9jzk4BOKe9O9+0NE+wm7y1x4NQaq9c8jmL2Oddx2vpamOU3cmHVjINc83oRUV0P4ydYlhR4vpweWdARHUitIPtN6B2f5/+CUSG7AuSIl76mKKprq0hQc/8P+ochQmLUaQwuFXayhEphokDnSCxgiQNqbIIH5EdbEQCCCvdhn+pYp/jF5Lmw/n9L26An9GjlbY7iG7zmfL2BUwQfK6vwhiDOYdQVGDJC9Xj1qkkJKV/brgqafNgSWGPJ7P5pRsUycWW0fNaiUguaVrX1vJw79Duyp50fnhTmwXm+Hojal3f9rWtHBjSK2xq124DStzMkwG25zTUAg2CsWo0NsF31lM70A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(346002)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6506007)(6666004)(53546011)(478600001)(6486002)(31696002)(38100700002)(5660300002)(86362001)(44832011)(41300700001)(82960400001)(2906002)(31686004)(316002)(6636002)(37006003)(2616005)(36756003)(66946007)(6512007)(66476007)(66556008)(6862004)(4326008)(8936002)(83380400001)(8676002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmgwdUY2NTYvMFVmMTZLRExodmxwcVEweTdtbEU5Y0lId2ZHU1ByMzZWM0Q4?=
 =?utf-8?B?MU1QWUhPcUpyUkpyN1VsNWdydnlJOCtPeGlKbGFuZnNUUTluakdzeUlmbmxx?=
 =?utf-8?B?U3daVnlwMS8wb25wOWZYd1IyOS94VkwxeDFJRFNsMkM0eDM0V2VPUlVCMFFm?=
 =?utf-8?B?akY2VlZtTHk1TXlGRTAvbzdtNEg1SzkxYWZWUFc4YTlrSFROc2duRWgxc2hk?=
 =?utf-8?B?a0pSZHU3NW9LcE5SSExWeEJ5LzRNR0JMQloyY1FsbXV6Wlp4K3ZnTEZrQTlW?=
 =?utf-8?B?T2NaanQ3TklySnliVU1Ld0M3dGhSdGpNV3JCZnR1cXRFbW1XN2laYm12YnBL?=
 =?utf-8?B?WExydWU0TjhhZk1NaVMxNWl0QkgvRW4vVEVtM00wdzFOM0R4WTMrRWEzcVJR?=
 =?utf-8?B?NXRQazdtamk3Yjc2c2plUk9OMzkzaTNKQ2IxNm5lRXZyYUJuY2U1K2l4Tk95?=
 =?utf-8?B?bmV6am5EcTNUbFdzMFFMRnZmcXNhd09YUmt2REJyWWM0emY5cHc2YTR1c3ZZ?=
 =?utf-8?B?QnFobzRaVHovSGtuN0JyRFM0Q0tjV1RzN25aQmc1OEJmUjRqeDBMYzF5UnpR?=
 =?utf-8?B?b094OU13YUljS2l0S2M3MW1NWGRZdVEweTNOWVNRWjZXcXVwTHRZSmM3a1JQ?=
 =?utf-8?B?YVRlajlXQ2JFRyt4cTZ1TWZtSFpzK0FuVGEzWWxDTi9tODNhbDVJQVQ0TEl3?=
 =?utf-8?B?U2NNNHFZUWpRMVdpekpVQkRMdnloYjBic0hOdTJqbk05eXBGSnFnQnFKendn?=
 =?utf-8?B?OXBPdUZIUzJpN2h5OWNkcUJNWU5VSGZvSG43eVlQUSt2MXpOc21nUkFoeDJ1?=
 =?utf-8?B?djZTUWlGZVM3azRwREVBNWc3Z1Z0clorTVZFM2c2eFlGWUJkL2Y1M3pDMHM4?=
 =?utf-8?B?djlQVm5obUMrd3J5bFBtUXVpRWkxYTlUMWdvbk5RN0sydXJWREVrSXprcVRK?=
 =?utf-8?B?b0tBR0owQVg3S2hzN05qNSthcmxmSDRwV1gvTlppWkdzK29OZmpzMVM4U2Ju?=
 =?utf-8?B?VzZZRngzaU8vekQ1N0NVdEMzdnVhb3NGbG9tcGRsK2xNY2tJdnlNZFp1MmQw?=
 =?utf-8?B?QkdNR0o3UklqZE0rcjg1OVJsNnpzZHJXaGtrUVAxa3NsaHU4Qi9lQUczMzg2?=
 =?utf-8?B?ck4vTHZKWUkwMFhrNnZXOWthWTFpclRaNGNndW9GYzJ1UzcyTHVleDlGY2JY?=
 =?utf-8?B?YlpyWmVmY1JQeWJENHlqOEVPbkJPMVRlMmZvQ1R5Rmp1RExVbG5iNE5kMnp0?=
 =?utf-8?B?dnJ5VmdPSzloRWFaVVFZQnhvWUVacVFtWlR1cWdraXVDL2dyN1NoQ1JLTXN4?=
 =?utf-8?B?c1VpUUtJK3NJQ3hQbjYwb21uQyt3RE1vZzNVaTVac3ZaZWlMUnROTGxPQm9h?=
 =?utf-8?B?WUhlSDJNSmtTTUk5UVh0SWlFS2FJWlVGN2FuMldHb3FVZkFHYVRhd1FrNmJL?=
 =?utf-8?B?M3JRYTJsOGE1MVNYV2JoVzdNU0RTZThSalRSbDlJU0FnM0pNUWlCQ1NYUUxs?=
 =?utf-8?B?bE5WY3NPbC9McXJyUjFXZ1V5RVZpT0tTN3NOTG9LOENnQThZbFNhMys4NTBP?=
 =?utf-8?B?Q0Z4dk1YekN6cUxycjk0eEgzdUVQYkw5dXVoSVNhZFNLc0NLc0VLbTZoL0NM?=
 =?utf-8?B?TDZZYlRsSjZhOFlZc09kbGgyaDRlZDJiOThCYmNMZG5kL3pwaU5CNTNDcnh6?=
 =?utf-8?B?dlV0c2xveUlCRlpTU1czZHc3UkxPRU44SXZxYTR0MzdaR2pCQSt1TFZaeSsx?=
 =?utf-8?B?Q2dTYW9qTUJYajgvVi9ENHVhSzJ0VmNkWFdGMXBER1E3SmUzL2hCWjgyalQ4?=
 =?utf-8?B?ZERQeHdxa29kN0V3bUhESFl1emFiRTZCaHpSZ0F0QTAyZmRCNVNqTEhkM24x?=
 =?utf-8?B?clNLWFNyRHZrZkpnVHhFck9yL0ZlQkpibUdZRms4aVd1dndJK0xMK3NBNklE?=
 =?utf-8?B?SmlJaFR5RE1PQ3Bhd3pxNXlHdUJ4RW9YZ2U1V0M3K0NBYkRVNFN3RTBBOU1r?=
 =?utf-8?B?eEZCZlRYMmZXM0hidS9iSVBzdE1mK1BrVjdpdFBtSkQ4SmNycW9jZTd0Sml5?=
 =?utf-8?B?NmF0Tm5pREUxSWhWcTAwcy8zSWJMVVFyM2dMamJIdmIzTVRvcVdqaDZYWjEr?=
 =?utf-8?B?ZGl0TXE0eHllbHhJQ2x4bzAwTXdtT1lUUVRDa0xIQXVQajZWUkpsNHl4ZkZv?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 571e67c3-6493-4041-4b0a-08dc235eaa13
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 19:47:46.9826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjDe2k+KK1qWWrsx21z9HATTBdecznriQW0UUeGh9O5SzNlk66IvABTKcNx1VohYgRC53X4gBca5np9sdIixsgJKVseGqBT9PWh3CgDxoX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5475
X-OriginatorOrg: intel.com

Hi Maciej,

On 1/31/2024 4:55 AM, Maciej Wieczor-Retman wrote:
> On 2024-01-26 at 13:10:18 -0800, Reinette Chatre wrote:
>> On 1/25/2024 3:13 AM, Maciej Wieczor-Retman wrote:
>>> Add tests for both L2 and L3 CAT to verify the return values
>>> generated by writing non-contiguous CBMs don't contradict the
>>> reported non-contiguous support information.
>>>
>>> Use a logical XOR to confirm return value of write_schemata() and
>>> non-contiguous CBMs support information match.
>>>
>>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>>> ---
>>> Changelog v3:
>>> - Roll back __cpuid_count part. (Reinette)
>>> - Update function name to read sparse_masks file.
>>> - Roll back get_cache_level() changes.
>>> - Add ksft_print_msg() to contiguous schemata write error handling
>>>   (Reinette).
>>>
>>> Changelog v2:
>>> - Redo the patch message. (Ilpo)
>>> - Tidy up __cpuid_count calls. (Ilpo)
>>> - Remove redundant AND in noncont_mask calculations (Ilpo)
>>> - Fix bit_center offset.
>>> - Add newline before function return. (Ilpo)
>>> - Group non-contiguous tests with CAT tests. (Ilpo)
>>> - Use a helper for reading sparse_masks file. (Ilpo)
>>> - Make get_cache_level() available in other source files. (Ilpo)
>>>
>>>  tools/testing/selftests/resctrl/cat_test.c    | 81 +++++++++++++++++++
>>>  tools/testing/selftests/resctrl/resctrl.h     |  2 +
>>>  .../testing/selftests/resctrl/resctrl_tests.c |  2 +
>>>  3 files changed, 85 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>>> index 39fc9303b8e8..9086bf359072 100644
>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>> @@ -294,6 +294,71 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>>  	return ret;
>>>  }
>>>  
>>> +static int noncont_cat_run_test(const struct resctrl_test *test,
>>> +				const struct user_params *uparams)
>>> +{
>>> +	unsigned long full_cache_mask, cont_mask, noncont_mask;
>>> +	unsigned int eax, ebx, ecx, edx, ret, sparse_masks;
>>> +	char schemata[64];
>>> +	int bit_center;
>>> +
>>> +	/* Check to compare sparse_masks content to CPUID output. */
>>> +	ret = resource_info_unsigned_get(test->resource, "sparse_masks", &sparse_masks);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (!strcmp(test->resource, "L3"))
>>> +		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>>> +	else if (!strcmp(test->resource, "L2"))
>>> +		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>>> +	else
>>> +		return -EINVAL;
>>> +
>>> +	if (sparse_masks != ((ecx >> 3) & 1)) {
>>> +		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
>>> +		return -1;
>>
>> If I understand correctly this falls into the "test failure" [1] category
>> and should return 1? ...
>>
>>> +	}
>>> +
>>> +	/* Write checks initialization. */
>>> +	ret = get_full_cbm(test->resource, &full_cache_mask);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	bit_center = count_bits(full_cache_mask) / 2;
>>> +	cont_mask = full_cache_mask >> bit_center;
>>> +
>>> +	/* Contiguous mask write check. */
>>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>>> +	if (ret) {
>>> +		ksft_print_msg("Write of contiguous CBM failed\n");
>>> +		return ret;
>>
>> ... although here I think the goal to distinguish between test error and test failure
>> falls apart since it is not possible to tell within the test if the failure is
>> because of error in the test or if test failed.
> 
> Is there even a distinction between test error and failure in resctrl selftest?

There is such a distinction in the current tests (and from what I understand the reason
behind the logical XOR used in this test) . In existing tests the running of
the test precedes and is clearly separate from determining of the test pass/fail.
All the current tests have a clear "run the test" phase where data is collected to
a file, followed by an analysis (aka "check results") phase that looks at collected
data to determine if the test passes or fails.
Note how all the "check results" return either 0 or 1 to indicate test pass
or fail respectively. Specifically, you can refer to:
mbm_test.c->check_results()
mba_test.c->check_results()
cmt_test.c->check_results()
cat_test.c->check_results()

> I've been looking at it for a while and can't find any instances where
> ksft_test_result_error() would be used. Everywhere I look it's either pass or
> fail. By grep-ing over all selftests I found only five tests that use
> ksft_test_result_error().

Yes, from the user perspective there is no such distinction. This seems to
be entirely internal to the resctrl selftests (but I do not think that this
should or can be a hard requirement).

> 
> Furthermore there is this one "TODO" in kselftests.h:
> 
> 	/* TODO: how does "error" differ from "fail" or "skip"? */
> 
> If you meant the distintion less literally then I'd say the sparse_masks
> comparison to CPUID would be a failure. What I had in mind is that it tries to
> validate a resctrl interface relevant to non-contiguous CBMs. If it fails
> there is probably something wrong with the code concerning non-contiguous CBMs.

Wrong with which code? As I understand this particular check compares the
resctrl view of the world to the hardware realities. If this check fails
then I do not think this is an issue with the test code (which would make it a test
error) but instead a resctrl bug and thus a test failure.

> On the other hand writing contiguous CBMs shouldn't fail as far as the
> non-contiguous CBMs in CAT test is concerned. So if that fails there might be
> something wrong on a higher level and I'd say that can be more of an error than
> a failure.

I think that the write_schemata() can fail for a variety of reasons, some may
indicate an issue with the test while some may indicate an issue with resctrl.
It is not possible for the caller of write_schemata() to distinguish.

> But I'm just saying how I undestood it so far. If there is some clear
> distinction between error and failure definitions I could try to separate it
> more explicitly.

I do not think it is possible to clearly distinguish between error and failure.
These are already lumped together as a ksft_test_result_fail() anyway so no
risk of confusion to folks just running the tests.
I think the final test result may be confusing to folks parsing the
resctrl selftest internals:

	run_single_test()
	{
		...
		ret = test->run_test(test, uparams);
		ksft_test_result(!ret, "%s: test\n", test->name);
		...
	}

above means that a test returning negative or greater than zero value is
considered a test failure and resctrl tests may return either in the case of
an actual test failure ... but from user perspective there is no difference
so I do not think it is an issue, just lack of consistency in the resctrl
test internals in cases like write_schemata() failure where a possible
test fail is captured as a test error. 

I do not think it is required to be strict here. Keeping "test returns
negative or greater than zero on test failure" seems reasonable to me.

Reinette

