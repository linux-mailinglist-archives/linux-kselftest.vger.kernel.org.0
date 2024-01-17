Return-Path: <linux-kselftest+bounces-3172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC87830CF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 19:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F2E1F227D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 18:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6A1241F7;
	Wed, 17 Jan 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqY0uHy3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBAC23761;
	Wed, 17 Jan 2024 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705517354; cv=fail; b=FLEh2SB1fH8MccAYPC5b6dVBBR4H57rYzixXNykmFGn7Qi5D1iYUMIItKhM98gbaugDCwD7tmd6/uT0Mj1qZB5pTDFLfL7rIW5lhdN/w3Ei+hs9luN6wE3UW9T8oU4vi6Al3by/6EXZ23OK9CmouDXExkHlmUPVT+TaBWO58xtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705517354; c=relaxed/simple;
	bh=kJJx+UH+G+XpblbF+smh0DFkrhYx/KME+14iGETLYYE=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Message-ID:Date:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=Hp4R8AfN1nMOajQKb0K7FMIAtrzUJEI35yZoP4WTtK9iHuqE+DOtTf7LEb3yx4BKHJTRXa4f1thuq95POvJF7LuI5lpFOcVLEuLJC8dfNH2Lf3MA+P/QBmMizURDQz1MKcR97cIRGq/x61oIkT6VbrMO4VF2Cqg6qxARRSWUscw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqY0uHy3; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705517353; x=1737053353;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kJJx+UH+G+XpblbF+smh0DFkrhYx/KME+14iGETLYYE=;
  b=IqY0uHy3eZdBvnXPPVR2rhtJQnhRjEU+DB2wOXHMm17lQWudjzhvw9iD
   /THWgYHjSY2ZVAyuyn5fpk682QfHpXrNojHewkgtsKseH5Be7RoqP2rZ9
   gXqxBhtt9/CQurc4X6uFhpTgct+Euzx9GKi5j6clakuDUbWKurzgEz8Ye
   T3iLf9Ps/r4kX9uMUa9QQLbPmjQFOnYkvxd6HI8QgySCdBUB4kbQLiGqW
   tVokW3nP3JLrsCtk4KS4Z6epYdo/WcJn2zsfcky+N9A5wFJSC7YHF9tJi
   uzQ3gyRPsgY2DypCuDHNjzjcwXkR2mpHyAxyzOOfijYxqyn9AZrxX64/U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7335424"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="7335424"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 10:49:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="854763125"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="854763125"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 10:49:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 10:49:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 10:49:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 10:49:09 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 10:49:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd8hCYyPzQt4sD9Bc7soP4VR3YR1x6e6GzXIt4VetOFBi/ZIwgcm+5I0miK5HmicE7JEn/NuHOfh8aOP/QROhgiOwJSDPObaa7zADLeQdur/ydGppmUgPXcVD4keVxEuiWswxoLzOKw77+m9vcLv2Olid+8FJsZvdrMjmEXYhWyliZOUYaclxTO0ZF6eY44FA+0II4W+1I7Dx7yRPS9aE0ywBNmbswtcfvs6mWbLbi0ohiz5RJmPfoX97fiZOgG4UuFkypBijIkC/deWAs/8UvMaGScKgivorMVIqGWIsIuz2n3rhsnPZG2WrXz1F6ScAGDbfqETFl5rUM4Zax6sUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLM1Kq2Bs2QM7x/KWgx8av+d9pbh9VRrfQADGDXgvOg=;
 b=ZXNyg2oYra250LgmQHcTo2TeayywRv7eIs9gEhcOufytU5XOgN4rgj1XbQ+6zDzeuH9qai08N1XgkAKXkrs/rLyHEmKq7dZ2wtxmIpvg70WEOqU1kxMy60OiqcRH2KGPMUlkbMnShaWZO1UkA2XAyhEmEs70YgbPaJCW+68oDfpMozpS8/6e3oQPzYkJrW8M4nb2ItY6wccO6HVyl9Btj+G1pJ4b2Ikhizc6bLgwTerCFXaw8MtcXC69Wql7atno2VD+RJ7dh+y+mBfuc5v6JgbbbZ26EqMqlnhslSXTDQfjbyNMLFYX+phnTz1ZaiOuMayQkMWEH00j5LlVd0koGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7367.namprd11.prod.outlook.com (2603:10b6:208:421::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 17 Jan
 2024 18:49:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7181.018; Wed, 17 Jan 2024
 18:49:07 +0000
Message-ID: <73cea732-3757-4aec-a39c-4f0e50f6fb70@intel.com>
Date: Wed, 17 Jan 2024 10:49:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Content-Language: en-US
To: =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <10c3afd7f62c63db31a3d4af86529144a5d7bbf9.1702392177.git.maciej.wieczor-retman@intel.com>
 <fd6acf6a-2610-406b-b363-220121a45aee@intel.com>
 <6v4hgra7bd5nwubcgtbsidmoohrgxdw7no4faa4a54g4vrxo63@c6qnujvwn5ej>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <6v4hgra7bd5nwubcgtbsidmoohrgxdw7no4faa4a54g4vrxo63@c6qnujvwn5ej>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 888ae059-78a9-4b00-f164-08dc178cfc32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRSXNyTHkZSVJi7POgCKnMXus2kZ1ee8SB0N4lF0oLWcbY34uzWGBK/COE123oGSlu2vklc/yC2NKjVYcfOE5u63mEuh9/n7Tsi5a2ZYho34oS3CPdXPXG32p9eTjKoMA4+TxVt0V84FEujmt6o37hCd/TRKlg6jgMLh4xjslKwT9N/DN2TPtL3weZbZfC1Vh6z+HqpNBN4ZMqyfbhgr8PjU0PV51NjG38uVLs4VAHXnS+FBdhWNqkzHbAKDrRoEwIDY1OIUl92kmX0imtNRXGYX9nmSq5SmzLEONjQ0YHb9recYhehPQpcOgLhznFjanYLlFU5hlmmEhY2r47ImSyGiSSu8aSiyLKtwdLlS724f2gVxsHon4L7HNyEkdY0JqU4RBNqB7IxeJ/+CcSGLu/5YofHUIX56tylvemmplzvdwzO55QT7pCmKxBrFzSrn43/3bX6j20CxtDhDIB99E7dt0CIec9I2rdLU50tHi8piWAwA3CyajHIP7vswyUlbrNPQ7a5cwqO3mpEfC8rHM7hVASR9snh+hs6hY+MuZ+iYFqTFBxnDUrdjLmLG2DkfPqSeNeAHilaprG/KdNQpWwKWdw2b+Jlcs4m0kfR9YHF9CfbGD2s3AmuPaREiLmFs/cz7qQMUYbeVq1NlGk1fog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(2906002)(478600001)(5660300002)(8936002)(44832011)(4326008)(41300700001)(37006003)(6862004)(6486002)(82960400001)(8676002)(66574015)(66476007)(66946007)(53546011)(66556008)(6506007)(54906003)(31696002)(86362001)(6512007)(36756003)(26005)(316002)(38100700002)(2616005)(83380400001)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzloNXNHS0czeFkyKzV4OWFFU25OSWdYbGdYa2NzYWYyZFdsVFFGMnJnZVV5?=
 =?utf-8?B?L0pkUW01Y1JxMjErZjYyUHhrTjRCdTZldm9zM1owcTFZSURQWjZHNnNNd3Bu?=
 =?utf-8?B?SW1jcUV2cjlwTGJmSURZQU5WZE5MZTVNZGlYYm1kTGRNNXR4V1VqU2t5cVBw?=
 =?utf-8?B?SlRhbVorQ2dTUmQ2LzRoZkJIU2JEL0V2eDRRazgyYy9HMjlaSFdxMGluQ3Vk?=
 =?utf-8?B?M3VTeWJTSkoyVjZELzBKUTZtaVd1TVBFTy9VTzFoUEhNNnZXbXZPUnhuK1Z6?=
 =?utf-8?B?K0k0aTJ2QzhqbUJhRm0rb3pySktsV2pCZFBZUmdpL1JSTFVsN2VrdGtML3cy?=
 =?utf-8?B?SUtnNmFLRVp6aGZOVkIyTlVKK3Fnc1JwMUczcS9GbnNja0dPdzF5am5LT1Uv?=
 =?utf-8?B?SUU5V2pPN3BBbmxMUjZvQnE1eDh1RkFzNU5jOTV6UzV1STJ4QUFuNUdoSDNt?=
 =?utf-8?B?UlZyUk50R0tEYVNRZnAySGlIcWhTb2krVWpuVkhzK3Y4S3NBTkM2OENQZHFB?=
 =?utf-8?B?c25zNnRjbjhHbHFNVng4VUg1cC9RK1dzNTQ1TUZXelR0akU4M1ZmWmJJcVZx?=
 =?utf-8?B?eEVEUG1LWlRPbVZ2SG92U0pxRXZRdTJ2NzdhUTA4V09jVGc3a1F3MXdTVnlC?=
 =?utf-8?B?MGJiYXE4cGVQOVB2dENCRnArNUk5bDZUSE9sUEdXTE9paG1seVhveDRsMWtD?=
 =?utf-8?B?aU5vc05LYklzOEY3ZmRlTGY2ZFlCdDhvcHBUMkwzTWZSS3B6S1pyYUZFOGl3?=
 =?utf-8?B?c2V2UElHY0hSUDNmUy8xTXhqRmhNaXBVazIyZzJhd3lEWmpDanB0c3FRMkt3?=
 =?utf-8?B?YmxaQTdKaDd1MjdrcTZENzlBZmk1ZC9JbXluVFpJTEdBVlI5MFF4RnhvU0d1?=
 =?utf-8?B?QUp3amdkUGF3bUJ0enhQb1krQXhrMWxpNExjMW9lUzN1QWJGQ3FCcXh6cEQz?=
 =?utf-8?B?M3RJaWRnSjFZazVlaVV3REtjbTF6WmdCdWh2a2lyNnRJYzUwaHRmMHgrdVhy?=
 =?utf-8?B?VkU2Um12Qll4Vyt1N3NqK0hrc0VpMjJJb1BBTWVPdTJTQzhmcG1HdS9QeGF2?=
 =?utf-8?B?SHlBQXF3elM3ZVd5Vk5zdkc5ckUzNDk3V09IRnhWZ05UTVg0MXNlaHpwcjkz?=
 =?utf-8?B?a0JycXFtTjBQT0NoU3NTOHVYNHZyK1VvNkp6ay9SRzNpMWR4ejVpVnVWc29r?=
 =?utf-8?B?SzRRcXBTY0pSckRjL2U4T0ZJL2FlSTlUaE5pYU5BY2xwNVROYVd6ZzEvZEpY?=
 =?utf-8?B?ckJoY0RybWxScHNZTHFCZ1MzZkJlWGJROVkzZ2ZYMHZ5Mjk1ZVpkeTNiTUwx?=
 =?utf-8?B?TnNyRVNzWTVCOE52dldsemZjeVJ6ZTFZOHhPK0l4T2l4dkNZT214WUpNZFlX?=
 =?utf-8?B?S0ZQNkQ1bjZEdlA1eWJUVG5FdndLMmx6VVNCWElsbjN2czNhUUxUWHR4TG1w?=
 =?utf-8?B?TmZXcm1nNWxqNEFQbzNJZUp5ejVOVHBBY3BHQzVLZmdLMnNsTnQwMzZvdkRN?=
 =?utf-8?B?NE04eVlQVXZFUHFjWEZZUTR2eHozeGFOZDB4M0JzbmZGTkRBQytER3gvV0Fx?=
 =?utf-8?B?MGhWbXFUQ3Y0N05UZHJNN0EvOHFiSjdNYUdlZk1oUTdFb3BSeGE5NGJaVng0?=
 =?utf-8?B?a2xGSEVjQStSMXpnRWt1S1VzOXd2UWRBUzh6bmttSkZ0RXNDdGNUV0FrSTd5?=
 =?utf-8?B?K1BJOTVNU3VhYTBwTTluYklxc2pqMytqYks1czlsbitZYjk1T3JrOHpTU2Jh?=
 =?utf-8?B?d3FqNzliWEtoMjEza05xcXo4aUV4ZTZ4L0F6NUFqcUx4bHBrNHVlQlVFQ1g1?=
 =?utf-8?B?eWl5MHpKajFaM1hQOFg1K1pFM2pIMU1wSHFRUEsrMVBmS2FkVkJLWnh4OUpz?=
 =?utf-8?B?c2lCbmxpQ3Z3ckxTSkJRMFZXMytOeDdMTjBONUtqK0NPYjUzY0VsZHdIT294?=
 =?utf-8?B?OHlhbk5kWXFiWVF0aHRpcDZHMUsrcmpSMnE2WUpKbmdlYzhXVVE4K3hjSzRX?=
 =?utf-8?B?VkNKS01pSlhINXJ3QkY2S2d6WmlSQUxNTXdONkxNM2kzbzlaV1BWa3dIZkg4?=
 =?utf-8?B?V29ZTzVMRFBBU1d1L1pMSGdqNkk1bUJacFhzbjUwQUNVbW1pL0NGeXIwaEFM?=
 =?utf-8?B?V0c3T25heTk1QmttU05FZDQ1NWhOYXVlMFBXanYzeDJwblZvUGxLbFVMWmdW?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 888ae059-78a9-4b00-f164-08dc178cfc32
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 18:49:07.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/Inqkn9iNXaaofpOn+0yNKOmTJ22gqOX8p8SUwbBTD4ErNi5fpyCRigT9Bwmm02zFtpiGhpwnIAK8CvkNUltsLDZWsLIl8KynVo01zBscI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7367
X-OriginatorOrg: intel.com

Hi Maciej,

On 1/17/2024 12:26 AM, Maciej Wieczór-Retman wrote:
> On 2024-01-08 at 14:42:11 -0800, Reinette Chatre wrote:
>> On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:


>>> +
>>> +	if (sparse_masks != ((ecx >> 3) & 1))
>>> +		return -1;
>>
>> Can a message be displayed to support the debugging this test failure?
> 
> Sure, that is a very good idea. I'll add ksft_perror() here.

I do not think ksft_perror() is appropriate since perror() is for
system error messages (something that sets errno). Perhaps just
ksft_print_msg().

>>> +	bit_center = count_bits(full_cache_mask) / 2;
>>> +	cont_mask = full_cache_mask >> bit_center;
>>> +
>>> +	/* Contiguous mask write check. */
>>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>>> +	if (ret)
>>> +		return ret;
>>
>> How will user know what failed? I am seeing this single test exercise a few scenarios
>> and it is not obvious to me if the issue will be clear if this test,
>> noncont_cat_run_test(), fails.
> 
> write_schemata() either succeeds with '0' or errors out with a negative value. If
> the contiguous mask write fails, write_schemata should print out what was wrong
> and I believe that the test will report an error rather than failure.

Right. I am trying to understand whether the user will be able to decipher what failed
in case there is an error. Seems like in this case the user is expected to look at the
source code of the test to understand what the test was trying to do at the time it
encountered the failure. In this case user may be "lucky" that this test only has
one write_schemata() call _not_ followed by a ksft_print_msg() so user can use that
reasoning to figure out which write_schemata() failed to further dig what test was
trying to do. 

Reinette

