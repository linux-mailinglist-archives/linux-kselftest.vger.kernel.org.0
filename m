Return-Path: <linux-kselftest+bounces-16826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED342966660
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 18:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D2B0B250DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0811B86D2;
	Fri, 30 Aug 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBYxlvD+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BAE4D8AE;
	Fri, 30 Aug 2024 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033649; cv=fail; b=aBxD+7pQxe/CWLMPkmlMFwAksz1gvMw7eXc98iISurpJjj2FOeRkJGvw4Ih3TRtp/5kHQUY41cr4kOT45rbbzQumPVO17hgmsaXQ2pPyE5JVAM42PyZGI/77rmsD7r/2B3ptsSgLvxR8hfbL7to5ppJCFUuwpCtxQWDsbqxM5Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033649; c=relaxed/simple;
	bh=K9JQpHdmiKrnNl66nQ07DgRXQZCFVX0irKBogAHcLl4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TUmYigvnv1xbUoAC7J+JVvbfu4FfIhV+EJB5JF3wiHFpQkST3K8KxkDiKdo5sn4VehZyKQdQ4AiaPAgCRPYukT1pMIyNueYPzlIG8vwM5n0mNQvQBMRm44P0cRpYjX26HWYjne6aqHcdKp7E/J8bTa/Mm9StSXSgzh+b3rnAH2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBYxlvD+; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725033647; x=1756569647;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K9JQpHdmiKrnNl66nQ07DgRXQZCFVX0irKBogAHcLl4=;
  b=EBYxlvD+aBFXH81TJIAw3O9BsCJwaLmJbyMsEj1MZQVnueDeXUS2j7jB
   0c5NJkDzEomfZFKZeC1NRRasFIpQAu7m58Bx2pGpaakYT/WLLDApDkoJ/
   N13a+/AYVdE+JuV5lyfb0KvDB5RViKh6465cHiTvuCaZFBxjRaAnKS2LO
   +rIsS05Tcm66rmIr0/J+v6VRA5NYHOzcrfzRRdfk7ji/EpmXeiD/fKSAA
   Z+1aHFMTblgYh6imfrlanlBJJaf+Rpvsu9Y44xyCo8ftZufU9XRUJ5EHa
   jhRDLe3bORIQfgDOjTQSiO4V9MJFkBMKi6Fvcw3BOw0gqSv2FR2BFjTlD
   A==;
X-CSE-ConnectionGUID: g3gNW4UMTOa4K7BhJq0mwA==
X-CSE-MsgGUID: JURYgf4CSAeLAOAtzwkiDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34253972"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34253972"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:00:46 -0700
X-CSE-ConnectionGUID: q52QoLUARQKsLR35g9awYQ==
X-CSE-MsgGUID: t9NRVvwqSQmTnYbpICBosg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="94673078"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 09:00:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 09:00:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 09:00:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 09:00:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 09:00:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fS6vFQxXaZtCUxe7dqEqWS/+q0VrVdXg5ZnYyhWMePiQuPJp9+sghWMY/TEKn3XqesGhEh+qeJXFmeHPx1G2BVzavfI1tBb/zIw3PvuvTbc/tjPkaRD/VWEB6iqg10X4yPZxDk6rTBX54nM1j2umHZmR2NGT0wuv+ho8FK64G0YRPtCT5uz69FKr1AvPRvLtvMznvW1hSsNrWgCkLcyKosFLAwd7IOGTAsvOH+wl/uxhSCbdcoQQUHkmGalN+pJbS4tkaxVqO1XqeRCJKPdxt0KmvwYsZrXzB0X2JYkVLc6ofMZO/34HK61txaIt20wD4T9TQIL43kKUvoweV7lxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieO62g/yAFmnOKyz3c6Y1FV6MlJS34Up0cUgarzIqI0=;
 b=p1TMvUPxyGr1lwFvcGp8hr0MPkOloG9nuOG338E/InbeqT1xXrWK6LSSF0J4i1OocVJJq4VhJ4riwnGOWO22s4rBSwBVXRp2UBfeEjxgNPbmWW6m/ShgoEh9TvfTkcoSOubtceAbPyIkyJvVKa7IdfcqJriYgdzRVpOikU2LdEWvAKQW2xJl6YUMj7gV1d8XUkxTCTUv6QVsttOEyuwR538f7JONYFcZ4yySGhylJ3LIO1cHRSgafXzir7KW5PJ5Mx8Z7OACTELbiu2XBfxjrCikSDxLIBRZOhUsinTWXjFnokh91IN+VotbXO2CWzilPnRLc/Pq1crxAUGMh8wU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5934.namprd11.prod.outlook.com (2603:10b6:303:189::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 16:00:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7897.029; Fri, 30 Aug 2024
 16:00:37 +0000
Message-ID: <87e4788c-6407-41a8-b201-e3f05064e5a6@intel.com>
Date: Fri, 30 Aug 2024 09:00:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] selftests/resctrl: Do not compare performance
 counters and resctrl at low bandwidth
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1724970211.git.reinette.chatre@intel.com>
 <9bbefa3b9a62319698907d10e8b78f1b999c311b.1724970211.git.reinette.chatre@intel.com>
 <5d063290-9da4-c9ca-e5c5-cb0083d7483f@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <5d063290-9da4-c9ca-e5c5-cb0083d7483f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:303:b5::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f9b467-2396-4fec-4a32-08dcc90ce369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTMzd0o0c0tDSlkvaFVGQi9NRUJQTVFUeHRiRUJ1NGtOOUUvdUJ3cldBWjVp?=
 =?utf-8?B?U1Y2RlZ4aVRJTzJubVM2YjB1RzhtVjFZWE1hUnREZUcyZDM1Y2FMRXo3Z01F?=
 =?utf-8?B?NkYzcWdCOUY2TWEzeFdpM1V3andBeUxxOVJOTVpNVVByWUVsWWxpTFpDL2di?=
 =?utf-8?B?bFRqNEMxY3JRUjZ1d2lmMHlUdjhQMWdmWmVkZ1g2Q0hma09FTXRpTm9UUUEz?=
 =?utf-8?B?VFp3U3BTSjlKdm9wbFhNckYzUXBjZWxpRS9yUFhoSThhWEQySngzNW9KejZp?=
 =?utf-8?B?TWtiTHZqN0hGZUhtUlhBeCtvSDdHWDgxelk3alJyMVBNM1JPazQ0cGVsdTI4?=
 =?utf-8?B?bWl6STB5cnRWaVlkUkF4Y2hVRE9CN1hsKy9GSUVxOVcxSTJFWThxVlB6MmFk?=
 =?utf-8?B?Z1JIcS90MVpFeDVFeGxTcUl2c1BROG1DUGRJblhTMjc2MjVwOXl0dWJEOTNw?=
 =?utf-8?B?YnY4dHl2M2RzZjB3ei84Wk9wUW96blFCM3VZS2tYc05XcktsMXV4N25BYXE5?=
 =?utf-8?B?bk9nMjNrY3dlRk1rN0M4aUY3aHJScDBCUGd4RE8yclB0NzBGRjNoeUdRNWUv?=
 =?utf-8?B?V0xjR3BzNWc4a2MzdTIwclVZY0hxSkRoby84ZkVJTlhGcXVvQnNJanpsd0dG?=
 =?utf-8?B?eDhHTnN6UzlsOUFkVTJ4OTNXcmt5c2t6UGZKTElTeUJEeU51TDRJN1g3VERZ?=
 =?utf-8?B?TjlMQ0JTKzJXUC9HTGltWmV6YXZBZG54ajJqUWFTZWNNUkJiVmRrTEl6N05D?=
 =?utf-8?B?S21aZVFjanYwdzdjRUtCUTIwcER1dVl1QnVBeVFMWEJPdmhyaTV1NFJvaXVo?=
 =?utf-8?B?aWR6cnMrZXFSUWVmeHZrRjMyTmt2aEVuZHFybm5mTlVkb1dzVU1OU0dtUENl?=
 =?utf-8?B?U2NJTWpmWTZpU2tmTGFtUmtDbXBiQ3hKOE8xaUE3WTVqeHBKNDdsaTVhdjRh?=
 =?utf-8?B?V28zYXA2VmROaUJtbGN4WWdCWHpKS2d4MlVpdDM4aFFjUE1JOGZTZWJJdVZP?=
 =?utf-8?B?WlhMK2N5cXNOVjlDaDZjczlXVzcyNm1hbFpyOU5nMHBmODBISk1yVkdkT25I?=
 =?utf-8?B?UzFSeTE2dU84SjFPaUxOcjBWRis3eEM2QmRXK0pSaS8xOXZoSVc2TEwxU3NB?=
 =?utf-8?B?UnNLbmxETmNjakd5bEhmNGptYmdaM2hjLytHVEhnOGFRRy9SekZjckVRUFpV?=
 =?utf-8?B?a3FEUFZSTnlMdzBxdlpvV2hzdTBlYzF4aWdnbmQ0bWdUTWNPbElERlMzcmZQ?=
 =?utf-8?B?M3NwSEtRbTNEYVFrejVLVjhVN0twUDRoZDBIRlJNWjNldnkxb1R6R0NBSjdk?=
 =?utf-8?B?TnZ0alp3NFd4Ym1zdU1YY2tnUW9Cb0NHb3Ziamw3aTJCSDR0a2YyZHBMcTRo?=
 =?utf-8?B?Y2YzcEd4eHd3T2pYdFZ4cG8raTgwUWk5V3ZxNjFyUVRNWWlNKytPbEhlODBj?=
 =?utf-8?B?RFFaaVZPOWFjakZ5V2Y5MFBUL2ZrdmUxdWVpckg4Ri9HNlUvOVBhTm5vNng4?=
 =?utf-8?B?aEpkc1pMMWo1YXMvUnVqSDI5Mkk3TEoxUWlKUWxvNEJIUlM2bEEyYTNINDh3?=
 =?utf-8?B?cGY3d1M3OHVIRDRlelQyblVnNkc4UHdGQWllTjhlRkRFTzJvL2hkRkN0Z3hS?=
 =?utf-8?B?T1BVOVp5YkhFNkRQN2lsY2doZU9ZK1B4ZlpQdEVaUGFhdjdEdTNSMTNYYms5?=
 =?utf-8?B?OHY0SzI2ZGo5NS9rd2FNQitzZDVzY3NlcE9od2FJV0dXNStPS1V4cy9WUWRw?=
 =?utf-8?B?aWdITjFmMlNFTTB0QzNPL2RaSFlRanpkZCtuMCtnckJTUHJMZmJmMEp6bU9V?=
 =?utf-8?B?NDkxRGxLWENWZ1hVeFFWUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjVBUm5YS242ejA4SE9rWFFnc0ZkTHFYU3V4aU9jaWNHSExkSWdIdTdIU1Mz?=
 =?utf-8?B?UEhhOEtDM3ZHWkNZcEc0dEpvMEk0V21ndXR5TWFTOFA1ZVFGL25GVmM2Y2cz?=
 =?utf-8?B?dXplZVltSy9nNUNOTDVBb2ZwVWl1bXpucCtkUVM1czZiTWNYT2tZc0tqREts?=
 =?utf-8?B?T3EwNEpJU3l1NW1qZ01oV3JKRXcxck9PblpEeHV4clpYUWhhWHZYTHZaUXhs?=
 =?utf-8?B?RGFObWkxYTYwaTNoZGpPUXVNMFFNbjlOV1ZJOVJtQ1cxUGloOG5yS2tGeDBa?=
 =?utf-8?B?UFZCOVhIU3pFM3ZtdzlOVmdhR1dNelpQaWdiRWlzQ0YvYW1icUxDWG9yc0RU?=
 =?utf-8?B?WStZOVJEZXVDejFWNjllalVJMVlJb3lxdmlPRkNqZzhTR3FsZ0RScE1iWVh6?=
 =?utf-8?B?QWlIaDNpNnczN3RIaXFlSEhaQzBMWkJBeDc0My9JVFNGdnEycTNZZExHZ1Rz?=
 =?utf-8?B?N1VRUzk3NyszVjhIRE1HTWpLWjBwZFdud0JOQnREZkFiem1BMkVNRlVBMXJT?=
 =?utf-8?B?dVdPc1EyeGhKcW9MdlNOcHEvRjNUN3FuTmM0T0toK0JWc1V1VjY3TmhBcktO?=
 =?utf-8?B?d1l4UWxXZVlYK25wbDNPbi8xTVF4eUNGRFZHNU50RVd1cVJMTVo2NVJEMXpv?=
 =?utf-8?B?MEpaSjNYbms4ckJOZk11UXNGQ0EwK3JyU0d4ckVUbEpmNUVJOFBDeGs0Vklm?=
 =?utf-8?B?aXdQUnFkSVJIdkNvRHFUT2MvdldRN2g3dnh5YjE2NDE3djRpUE5yYzFCblZV?=
 =?utf-8?B?SDZsUVlmUy9CTFV4R0VOczJCaFNkSGlhRW1Zait5LzZmaDF5NXRTSGdmcDg5?=
 =?utf-8?B?OGVJdUhrbE05YnpHMTlYWWp1bVBDbUcvMUFNam90cGZHaURSWFFGSkg3SThP?=
 =?utf-8?B?NTUxOCtaUFIxU0FMcmx5UGJCVi9TN3RCZjU4SEhiQWIrSzV1TUZ3NjFObmcv?=
 =?utf-8?B?QzJmZ0NYUEJ6bGFPMEo0WmtZYjlha3p0aFdEa1Z5QnVGZ0dRUTAyMVlhSU9h?=
 =?utf-8?B?ejRsdUUzQ0pyL2dDcTRLWkkreXhtSzlhc2psZmJWLzdQYnJySWRVbzVuM2pl?=
 =?utf-8?B?ZGpDcHF2RVdoazJ6Z1pPZS9aUC9NeitCV0Z0eG9maE9xZ0RvNG5RNkxISXRk?=
 =?utf-8?B?TnNjUHJlam9HcEg0MzJGUGFpeEI3WTZwRTNkUHdzaUZjcTJMUUpaU3BzMjlU?=
 =?utf-8?B?dEwxSDNCZ25XRVhRSCt1dzBkZjg0MFVRSnlHbVp5TGp1Q040SGVOcWNoK0dM?=
 =?utf-8?B?aVI3bHFua05IaFZCZzVNYWUyQXQ4V096My9FZVk3cUR5NEZWcUIwK09oWWd2?=
 =?utf-8?B?OWtybk1VNSs2MUxjdzNsV3oyMXlxWkFuT1Nja2dyK25FSytnTzBjRnVMdkRH?=
 =?utf-8?B?L0dZQ2Z3Ry9yNU95NFBVQmFKLytEVTM0Qkp3eWcrZnpOdGM1SExJNE5rWGlY?=
 =?utf-8?B?U1JYNkpBQ3hTOGZ6L1dYQlBodW5MYkV4ZGpwdDdFR01CUTJCMzF2MzlqRDNM?=
 =?utf-8?B?Njd1a1duOWJvMGZlVVJqY2VZdEJxRDBGZ0VWdHh3T0UvNU1rOEFhZXh4d1NU?=
 =?utf-8?B?UndZdHg0aU1lUGxxenlaNzlDNHVOaG5FUFhwbGtJRFJXY1J6Uk40WDlvZGRl?=
 =?utf-8?B?Wk5kWkdUMzRrcEVGaHorSW9Uc2dGNUlDeEhsbXozR1kzN0pPc1lUL1FhQk5w?=
 =?utf-8?B?YURxd1I2aWtxY0ZBNk9GaFBsckdVVG5CVmt3ckdTMXlxUHRyVnM5d3N2aXZy?=
 =?utf-8?B?U3BmWTlvcE1oc2xNTkplcUUvRitLUjZ4RWhFR21yclBsMTFnZUtYNWt4U1FT?=
 =?utf-8?B?ekFITjJNK05rMEt2eHRTWVRheWdEdWF5MSt4enM4a0U4cXEwS0ZFOUM2OG1a?=
 =?utf-8?B?aHJpZFZnS0ZTRE9JOEcrZFVrVVV5WHc0WVY0S0tWRmVBN29IWkRidzFmMVVq?=
 =?utf-8?B?b0I5c2pCRDY0TVltRHh1cXYyZHJIbEFOSkVYWWVEUTk2cE1HSkQ1Ym9QUWUx?=
 =?utf-8?B?aXNCUDZJRkZDS00vWHVrTkgxanVHcGhpanFjcDV6SFZGSldVbXI0YjJkSnV3?=
 =?utf-8?B?WjRIRy9aM0ZkSmI4YUJnMkdwTUc3VEkyUEFrYTNrL1NyK3ZmSmg4K0k5dmd1?=
 =?utf-8?B?RVA2NldTLzlxU2R3TDhqSjA5OHRtdjd4MEd5OVRiQ0hZT2xTaUptZUlsL25W?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f9b467-2396-4fec-4a32-08dcc90ce369
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 16:00:37.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYOQJz+cSuR7jH+RUihifdVXdmUcFGUkVMyNahcEUF4bxAivfB/UQJniYVmuQhN04xmy8myjsr0HtfAx543DiPOnn2vxb07683q29sGECA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5934
X-OriginatorOrg: intel.com

Hi Ilpo,

On 8/30/24 4:42 AM, Ilpo Järvinen wrote:
> On Thu, 29 Aug 2024, Reinette Chatre wrote:
> 
>> The MBA test incrementally throttles memory bandwidth, each time
>> followed by a comparison between the memory bandwidth observed
>> by the performance counters and resctrl respectively.
>>
>> While a comparison between performance counters and resctrl is
>> generally appropriate, they do not have an identical view of
>> memory bandwidth. For example RAS features or memory performance
>> features that generate memory traffic may drive accesses that are
>> counted differently by performance counters and MBM respectively,
>> for instance generating "overhead" traffic which is not counted
>> against any specific RMID. As a ratio, this different view of memory
>> bandwidth becomes more apparent at low memory bandwidths.
> 
> Interesting.
> 
> I did some time back prototype with a change to MBM test such that instead
> of using once=false I changed fill_buf to be able to run N passes through
> the buffer which allowed me to know how many reads were performed by the
> benchmark. This yielded numerical difference between all those 3 values
> (# of reads, MBM, perf) which also varied from arch to another so it
> didn't end up making an usable test.
> 
> I guess I now have an explanation for at least a part of the differences.
> 
>> It is not practical to enable/disable the various features that
>> may generate memory bandwidth to give performance counters and
>> resctrl an identical view. Instead, do not compare performance
>> counters and resctrl view of memory bandwidth when the memory
>> bandwidth is low.
>>
>> Bandwidth throttling behaves differently across platforms
>> so it is not appropriate to drop measurement data simply based
>> on the throttling level. Instead, use a threshold of 750MiB
>> that has been observed to support adequate comparison between
>> performance counters and resctrl.
>>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>>   tools/testing/selftests/resctrl/mba_test.c | 7 +++++++
>>   tools/testing/selftests/resctrl/resctrl.h  | 6 ++++++
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
>> index cad473b81a64..204b9ac4b108 100644
>> --- a/tools/testing/selftests/resctrl/mba_test.c
>> +++ b/tools/testing/selftests/resctrl/mba_test.c
>> @@ -96,6 +96,13 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>>   
>>   		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
>>   		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
>> +		if (avg_bw_imc < THROTTLE_THRESHOLD || avg_bw_resc < THROTTLE_THRESHOLD) {
>> +			ksft_print_msg("Bandwidth below threshold (%d MiB).  Dropping results from MBA schemata %u.\n",
>> +					THROTTLE_THRESHOLD,
>> +					ALLOCATION_MAX - ALLOCATION_STEP * allocation);
> 
> The second one too should be %d.
> 

hmmm ... I intended to have it be consistent with the ksft_print_msg() that
follows. Perhaps allocation can be made unsigned instead?

Reinette

