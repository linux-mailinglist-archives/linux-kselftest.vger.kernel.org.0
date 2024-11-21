Return-Path: <linux-kselftest+bounces-22417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232CF9D5455
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 21:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED85B20813
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 20:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5E1C8773;
	Thu, 21 Nov 2024 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4DZlTUg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269BA19DF8E;
	Thu, 21 Nov 2024 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732222450; cv=fail; b=HMtzquWCOrBwYVPhXH1jdGxHOwYzu7LURNCuMMEeKej9SqmkrHOWDG5Alw0UySgqKeg+Qt0O2tqc/SyIPCR4+FwsMfdJl/yhqyO1v7Ek0BOn7RI/n3GDSBTO9rGg/dIzX6drn1yQoiJAjtnwRzRfv1F0233IbB2nfqZxgVRyaXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732222450; c=relaxed/simple;
	bh=OoiSQEs+qHE8kRhIpBpToxhSdu8Pyu5SgaKR/rHOlEU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ODkN5cRSmRIJOKoxKIaHkOf7NrdGU9XrxIcPjLFqH1xCSxmgR/ySe+Zni4TNSUqc6o1NTMANlHyQrsY/KY/QH6HdCPEwGKd3CMLndojy3kUFNB6xcNKz1z81xOvw7ttb/0q+PpOelGyxDt4ILR1jBfYpkzvoI+4uDnaOJnvClPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4DZlTUg; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732222449; x=1763758449;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OoiSQEs+qHE8kRhIpBpToxhSdu8Pyu5SgaKR/rHOlEU=;
  b=g4DZlTUgYfC/uORb0zZSlDeTeyacLNcjbHGu9stf6hIau0vQHNDH41z0
   g0KuHZwV+mEPeF43FNC1WdlIf30Hx0VbfOVJa+uHcrv1cuuokm5/QRmL8
   7MXRuV4sxbW1bryPaDuLpHAXgtXLbguZMDDJSYcLhYFOE4IDWbrZ9BMtv
   M/2UAx9AqsXK+dvOpzWqw/UPWvUcfpVQzfzzeGu4rpq5VIYjh8dw7LZAy
   McMlZzmwPudM0pAxmlB1gK/FYruLMc+y454GB+4TE67DVmInVjHIDvLfk
   gyx9NuFNaGppK21LvZAp4RpOtIxvYplZbzcp11c/YaQRLx9bdGDakgUrT
   w==;
X-CSE-ConnectionGUID: MNPmW8rxSweLg/LqrloLDQ==
X-CSE-MsgGUID: Bu5B0n8nTsi61da1flkBRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="49881510"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="49881510"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 12:54:08 -0800
X-CSE-ConnectionGUID: qdE19u0rRaOExZHVgSpfXA==
X-CSE-MsgGUID: ephvCuVhSsyOYGsM9g1n/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="127886341"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 12:54:09 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 12:54:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 12:54:07 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 12:54:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lugksDRLlCkbvMzqejUbEr91dbCpEoSndqfgSEUyHgWBDQS2YcXOfHlfxxQsPz/vRNuyGDmLrR5lC5lZSskTzi5SilEfx0urz1pJ+O2KKsXFrAItQ05Mu9D5tP3rfkvhn7BIQwLC8FRCPVkRyWYoq9cBWIhVKDNfe7zC+JkwO3Hk4saqRzTBCiTdWa2z3TAsZFmU9J6EdTSZLnD+JGQf65iYG5H2nxAZjxAQCyt6+LbMAtvEIZ7m0RC9z7ojSjIrQm5vtC3bCE+vTuE13qz3h4hRiwXavyuozjjgVFnuPGGy+B4TVcPGUW7SrPDy8Lu4lMAxkuMgAUpz+julaEnlAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jM+8wpXgxqISuobztlhqzSBBeQ6H6G2TSTkoPZuNNRE=;
 b=jVELjiuPtmsBeSWasSuDcS5yzeL16IJIY4ief5aXTnZA8TyNh5mGahA/aQDPAt9wEjwy2LUXQbEOhRkFiVIxKSPM5TUsmcfmsAneBZsGBN6/odfdzi8hv0BlANRDRL+UfNO441eNnpjkVkLuHeIe9Utc4YURRT3TPthgxGmS4yOycm7L3zulgXSOiXwZO2G7rJIzjTKdAMr53ZJ2U4bjml0K1IYGvp2vGLIifFHOgv4xq2U2gOWD+9WIMM8WaEsj/U2pXZwBNIBD/NPR5b44zYfBj1qG7mRQVsmDVEjfBujw0q6YhQMY7BGf1iIkCVAYUpdvDmCt/ste5y0rPXgMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8675.namprd11.prod.outlook.com (2603:10b6:408:219::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 20:54:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 20:54:04 +0000
Message-ID: <4d907a82-9170-4207-850d-0596fd8c3397@intel.com>
Date: Thu, 21 Nov 2024 12:54:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] selftests: net: test extacks in netlink dumps
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20241119224432.1713040-1-kuba@kernel.org>
 <20241119224432.1713040-2-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241119224432.1713040-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:303:b9::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: da467563-e932-4db6-a463-08dd0a6ea21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzNvVXgvOUQxOHVCQW5JOXFVL25rMmdBZHl2TU1nU2lqZzFheXlpS3RMempY?=
 =?utf-8?B?LzdyNkFWWCsvRmFJMWFjN0loSnN3Z2RIS3RXQjZQSTF4a0VvZUZtWFBxNmFK?=
 =?utf-8?B?bSt6U0FwV0ZvTWNNeGpUV3lpNURucWpFL0JWc0pmVmpvRGNPYXdPVDhGSFhv?=
 =?utf-8?B?aFNoZWJtRXVEUlVERWY5THpLQjNXQVpIR1FRQWM0VXlrcDhXVkJjQU8yZkFD?=
 =?utf-8?B?ZE00Zy9rOWsvUnBWSm9vV2tlS3JXN1VjaEFSSzBJYU1peC9sVFprTzFZN1Vj?=
 =?utf-8?B?NlFWQVV2MDFlbURXWllaM202RGJ2cm9HL2d5VUxyK1kydXNrUDZoU0RsQytN?=
 =?utf-8?B?RlBGU2pQV1dPeU9TL2Z1UlZZZnhPT05wT3lXdEFjcFNUbzBKaXJsbWdkdEFa?=
 =?utf-8?B?c2d0QTBhZ3ZPVy9QTkFmSGZEYUQyL1c3UjYzRG1Na1lva2VQc1M2NlZPVVBp?=
 =?utf-8?B?bC9KUUtEVzNtNnpDWEVrU1pxcXVucWErbXVnQ1lkNE5TTlE0NFlPVEkyQWJt?=
 =?utf-8?B?QkdiaC84VzhVeWczVE82OVRNb2hHVXM3NUlUYVNlUTV3Y0JwWG8vZUpKMCtR?=
 =?utf-8?B?c3hvaXI0Qm1ab1luYXlNa2M3QU02ZmJYV1dJNU54dVF6ZGNNVytBYUxpZHhs?=
 =?utf-8?B?NGcyN3JUTWRBeW1ZUWpnZzIxN2gwczRNRmhQOTU2djZkWTh3dGgxcVRLWXlx?=
 =?utf-8?B?NW9YNUEvMVRtalprQzNTbmNaMUhBVTlLU0pwaGE2bTFYcTlBS3NpakczS3Fk?=
 =?utf-8?B?RFJ3K0MrZmExcnBZNDNDTDFoK2h1RVdYVTZ6OU5rdyt2OVNJZ0xGUjR6dFhF?=
 =?utf-8?B?a0Ivdyt3WXg0MnJaS0VBaXR3RUw1eDNZb0lOTlh1QXlnK096VU1OR093Z09S?=
 =?utf-8?B?aEJmVWxhRUEyQzd0bU1TMytyRWhHN1Fvdm5obzJpWTJiSDVJdzcrZ2xIZG8v?=
 =?utf-8?B?YldXN0xFdWhNRTVYNTl5R1RJazhSTXZkUTZZT1ppM2dzZlhjdFpzWm03T0Fh?=
 =?utf-8?B?Q3NXZEdWSjBiYlgveXJINjBKTWJSVzJCdDdlRE9EWEpWYXlNRGpiUm5iMFl2?=
 =?utf-8?B?MkJyLzdtVXhLQ01JMkVicVFubXFWelhEdXRITFJnMmlUaDN0bXZaSXp5aUgw?=
 =?utf-8?B?bGZDQ1B4djVxcHJoTGN6bDBBN3FwK1lFNjlsSm5nY0lPc0hrcmE4dTgvcUFq?=
 =?utf-8?B?NmxUcmVFOHZDTUovK09tUjdHaFRwZXE0QVdjRXcwaG5oVUIxTDIyYTdaOHQv?=
 =?utf-8?B?WFFpcy83Rzh5WE5BanVwZ05lVllHZGV6eklSdk5tTXppcit1UkRQbElYaWJY?=
 =?utf-8?B?ZG4yWUtmbXVBTktUOUhXalN1aHZkK1Q2V1o3RmtNY1J0eko2TzNIYVlHb0Ju?=
 =?utf-8?B?RU5lOThmc3c3Wjd3MkFiVmdYTGlYdHVXbFprUkFOMHJjZGpzT2hDN2NIRUdH?=
 =?utf-8?B?NFFiYmpjQjRSdXBRNVhjczFlMVFvT1Y5RnRyTjM2cUpKU0t6cXRLMEdlKzYx?=
 =?utf-8?B?elFjSVJsREpiYUlweDJmTWxWbTc3b1ljUW5hNFZFM3BuZTg2ZGFrcklhU2NG?=
 =?utf-8?B?UXI0ZmdZVTc4TDFBSGVNSG15OFVQdVQxdU5oU2hNck1rOUJxUWRURXl2Uncy?=
 =?utf-8?B?QmNWajV0aHc3UGwzVlRLcGlRUndtZXkrYjUxVW40NVNsZFVsRUNqa3RsOGdQ?=
 =?utf-8?B?S1J3UGltMS9NbVFVekxEWTRXTWsrTkxacG01RTY5eWlLUjduMXV1M1lVWVNR?=
 =?utf-8?Q?taFbuFYL/OaNyHE05/GTWiRqAdzdpxmmRDh+0bT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3Y4ZWpNNzZWVW4rUU9NU0hsS3N6dnoxMHFkeEZscnIxWENFVFlBbVd2RE9s?=
 =?utf-8?B?MkdSQ3ZLVkFCOWlyVU9sV1BhVjBxYjU0TDZsaDBXSHJrMHkxVm5yaFRLMEpw?=
 =?utf-8?B?VXlvZS9kREUvV015ZjE0eXg5VElacW1pNW12dldvNDdmUUczS2x5UnRlSEds?=
 =?utf-8?B?eTBRaGVidHhxN1BuMVpxd1Y4bER0OW9NbWZGSUhrMkMxUkN2L3Vmck1tTGlY?=
 =?utf-8?B?V3lrWW1RSEs2RFl5L3BVSkRpWUNuL0RJeU0xQ0h3UEtHd3ZVWGZrU3RWZ0Rv?=
 =?utf-8?B?L2N1NXlLTGRuVmhIWFB1ZWZjQ1N1dUF2RlJ0WlR6dmlsRnZJUDVUR3lUR3ZI?=
 =?utf-8?B?ZG5WdExiWnRoSVBKYlBJcXczUUpmZy9KTDlqbm50K3FvZkJFVmlGRlpDVE13?=
 =?utf-8?B?Tm1nQ2c1dGY2T0poYnhPT2x0OHQyajd0SzM2cG15cGxiMUdkUG1VdlVZYmxj?=
 =?utf-8?B?NUtRUWZjQlQvVGo5UFVDazBDRE1kQ3pETW9KenZuV0luZHE0bnVEM0d1WmZx?=
 =?utf-8?B?R1dOU2YxSFRnY0I5TzdVL2pSTjFuOUNieG4zVCtEc2VvNVJ5aFd5NlFZdkY4?=
 =?utf-8?B?UjFWaW1OejZyV3Q5d1ozMGF4WDZIVVFpWldUb2FHTnl1MUYvTGRQTzNCa1B4?=
 =?utf-8?B?ZDBZQ3YwdVptbFhPaG41V2hNM3lGZVpRTzF5NGlTd0R1OUxrb3ZlaDBZKzVL?=
 =?utf-8?B?ZHdSVjFUT1lBeGo2N3U4YnN0ZnpMU1ZTSUJWSkJZTXlvUGJlR2p5RmFpeUZr?=
 =?utf-8?B?dDJTbEV0U1p2MUZ2dk9oTEJEYXZxd1E5ZnlCL2lwZXJualc0czdVZzJjSDNV?=
 =?utf-8?B?N29OSzVmKzUyV0l2M0MyWTFrRytxak9QSW4zV01XVFBORjVuYS8rT0JZOU9s?=
 =?utf-8?B?dXpiTUp0MVNPU2x6K3Bza2RjZ1ZKTHNyeDlPWmprZ3c2WTBFeVI4NnhFU21Z?=
 =?utf-8?B?T2tVa1ZqWmR0VzNsK0Rrb1ZGZU8weDhVeUpKaWFYbW9MK3BTTmZ0VWlaSnl6?=
 =?utf-8?B?VjJrS2UxMzJwY0tWOUdVeGpVbHRRaGtkNG9sUzdWWUFrdENMTGpYS3JheUJt?=
 =?utf-8?B?M3ZGYW9PUi8wZVlMaDNDeElxR1RwbFNtQkVZS3RIMEVHOFNSbDRDcEtWTmVQ?=
 =?utf-8?B?MU5YRWFDUTRVOGRqMjhXYlMvUDY5azJoQW5QZzRwWUhBTTAxOGd1U1Y3VElY?=
 =?utf-8?B?NW1zeTJqdjdIRk1mTU45MXZTZXVFUXNzdzZCdXVHdHpzMmZYR1ZGUXV6bWJK?=
 =?utf-8?B?UVVJYnFVOFN3UTVDTGZ6K3p5TGFCL3ZITjZTRmRWeEVWWWphekVQYXR4N0tY?=
 =?utf-8?B?OFBVdUlDOGNGMS9wVVBQRWowbWo1TVBFUDJFZ2NUL0RWb3prQUZCeGlhZ0ZN?=
 =?utf-8?B?blBJTUp1eWpuRldydlFKeWJIdnMwMVBxTHdFNFlRNi9jRzNhZ2xaMVdwMW5t?=
 =?utf-8?B?cDZoKzkrbTFLbGJ2d09Qc2xyVzV2dDR1bEFoOTZVdTBqeWN0WVZMMXducCt5?=
 =?utf-8?B?RlJEM0hDRFhKK01nSHJlMmZjeVFRUUxhSFlBWEVkaWlxMDlLL1M0THUvVlg0?=
 =?utf-8?B?ZjdlVGFFVXVjd3dmSnhIK0Z0RUFjRXdrMmZmVE5EaEttd29ubnFOQmR2VHJ4?=
 =?utf-8?B?cE1tTmI5eXN3NXMxVmFFWEovK09jM29RTW42bHpxMHMvZXI5aWhJTkZla2JN?=
 =?utf-8?B?RVhXTHNER1A3OVQ2Umc1NE93WkJrZVFrUnJLblhybEY5ZEdkbjFxRzlBRlRJ?=
 =?utf-8?B?d1dQU3QrNSs5N0NCVXN2ZU9MTkdwNVJPRkJ6RjZacGYvbFlPeEVvV3hNejEr?=
 =?utf-8?B?cGZqVjd0aVczWWVUL3lqTEp0YjJWcjYxVEdiWnRJYXBGL1hrVnFzTlBSUDM2?=
 =?utf-8?B?d1Z6WDcram5HcmZyU0oxckJ0OExuUDNrQmJkSnpmS2xid0NuSHNPQk5Ddjd4?=
 =?utf-8?B?aThSbU5iQkNsUWdvVlBsV0I2TmZnMk1Vc2h2WUI3dHNwZHdEMFBFM05Rc3ZJ?=
 =?utf-8?B?MWdVUnovbXhNTmc5RGdWWjhlK0tFSFYvZmpnQ2ZJQS83WktheXlUdXR1NUhx?=
 =?utf-8?B?aG1mK3N5b2pnM1RjVU5INjFsMzk5aER6QzNsVHd4R0FwMVdWM0VNV3d5OHdQ?=
 =?utf-8?B?Q29qQmpwbXZKZVJNOUVienUwdUF3SmdGSHZGK1pzRHhQZWg2Szk5K01SMjZ2?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da467563-e932-4db6-a463-08dd0a6ea21a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 20:54:04.0037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFeZXghq6okwDaPDHjpas3AzP9A6Zllzy5oGDSZ+8vbluRpI/vHMqa1/9n9cZYSwqDDTgX0lVqJCLZ1ipxoL2E6BW8x4uL+IQNK0kRaj8vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8675
X-OriginatorOrg: intel.com



On 11/19/2024 2:44 PM, Jakub Kicinski wrote:
> Test that extacks in dumps work. The test fills up the receive buffer
> to test both the inline dump (as part of sendmsg()) and delayed one
> (run during recvmsg()).
> 
> Use YNL helpers to parse the messages. We need to add the test to YNL
> file to make sure the right include path are used.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

