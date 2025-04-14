Return-Path: <linux-kselftest+bounces-30742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F85A88B02
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E10170152
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D1C28B50A;
	Mon, 14 Apr 2025 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZAgIhwu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE428A1FE;
	Mon, 14 Apr 2025 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655303; cv=fail; b=Nhhz9KVpj2ljWPt12UjGGtVLjN8oFJIfXBLAVyVfnWxCxuF/2XOzCp4kYDiQVPN1Y6mtmjEu/o2lqyLeAJqwmFy8HLOm/HLWmUAU/M+iQm+CUjGx9kFvwR6Z2nb3DXQy6XfUF0Y3UTBGCL9sFcryeuFbnIbtIdJSW7rVkHZKai0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655303; c=relaxed/simple;
	bh=ebUITl6VJH/EGEYkpGMYCUHbSTNjrSc+55ZEeKuWHZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ERMIjH/NK30W9+A5obW3147FfTiYDJJCO3tvKqe1m+iFpt05Ppt8mt0/0s7xtZsYfuEgHLCLPOIL5X/afdg9YVSLYIurifesxc/4MKOSjOylX1zTqahqEHD8Wwe0k3SW20d6NJuIFSWDCN8DsK1VMZtAG7ld1JY4XCAvsjh0/eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZAgIhwu; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744655301; x=1776191301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ebUITl6VJH/EGEYkpGMYCUHbSTNjrSc+55ZEeKuWHZc=;
  b=LZAgIhwuwcFGn20+S2PoGyMqC4saji8W5/iv3eYPcSKJ1vJg/xB6Of6X
   5QjnOp8f385xjBJ4vVh5FLhaYpuCIbVk3NdWJXG+YNEAC+v0p0/e3PxOM
   YuHzmKkDvmpg8pktc7sw2kqwB47dPpePvVfXtD/AFST2mPcnN3pW9KG7N
   jC2Z3mPy2tY4hFHHh/NTfcs8nSphL/HAtvHlSEr2Bs90Rmpoytk5TDPLU
   bEo306I98U7AOc335whrnZ0FdmXKD72EEgXoCIHMoLMyI9LXRNFt0riuI
   VL3LI0o11ckYZv6KINQLGSm4C/QmTnAH01DZo7Gw7Xh+T4w0zXhnsaibT
   w==;
X-CSE-ConnectionGUID: QN62HJkASBW3gsH4EVV3yw==
X-CSE-MsgGUID: WMf4EUAjQiGe7KGezmpLAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="49972533"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="49972533"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 11:28:19 -0700
X-CSE-ConnectionGUID: x1jtpaJyROyk+iweRlmZ9A==
X-CSE-MsgGUID: MEMZmfAKT2W6fHAi4l9JDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="130220969"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 11:28:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 11:28:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 11:28:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 11:28:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMafOZkdZibSY9E0nzY/Ghlm/uHO9tdLVdOKFFrD99W7L7NLLq6xS9S8qQmJOMVMSSPPl6Nq78s7GMhgDDu3gNs+0/R0eFw2yHLcf7sDnbaeTOhIVn2zpYIc06ZuMmEjK84uj/C+w6z2iBVb2aIofCQbAMiX1/Be8aGRPhnBK52OR4eaCgrC87YTC4B71JyGLHLYYRdsQ6952S6Yak1bRaEvBnaatZTKLUs86LeKHjZ1aBoFz4gHnFVxSx5Xa91NsFocfFW8XEaqmIJIhPThlKO40iVKdJCDnV7GiRQXe3+hEodCTPhEAC5n0HWQ6shDhEKGY/5YClspB0z6jaehxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebUITl6VJH/EGEYkpGMYCUHbSTNjrSc+55ZEeKuWHZc=;
 b=yZpTh7q7FmT2Jtji6K3efLwEmxQDBPLxRDF6nuZd0R5UUnHP6CoFe678H8QqdwLORI1N5mhlr1WGlZ5jitu5tSf0ih2qoCWv+hHGE+biVbtPW36MAiLujA8jzq5CkXtJ/wBJ22L3xGKAVXu8gu4Fv0ERYlhOe5NiWtI3LyIZjMjxQL/DhJtXVc7HJK9KQZbIQ+2oxwV6kBi2eMlzDTqdq6Ai4MsWFtcIlw10k5Mak22SvLm1U6dF7chDLdB9lGTKcCllESjUpg40rdgvV1a7bSjtE9wdp1Exux6XOs5qFn73dP0QlHUZxoZXRshHnfrDOVn9rPlyLjMeix4p3jd1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB6619.namprd11.prod.outlook.com (2603:10b6:303:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 14 Apr
 2025 18:28:15 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:28:14 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
CC: "yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "jannh@google.com"
	<jannh@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>, "kees@kernel.org"
	<kees@kernel.org>
Subject: Re: [PATCH RFT v15 4/8] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFT v15 4/8] fork: Add shadow stack support to clone3()
Thread-Index: AQHbqLcvorlLga3BFEGJ399tjalR3bOjhIiA
Date: Mon, 14 Apr 2025 18:28:14 +0000
Message-ID: <b15bf40b530f74d3339a313e7f5f5cb09205d348.camel@intel.com>
References: <20250408-clone3-shadow-stack-v15-0-3fa245c6e3be@kernel.org>
	 <20250408-clone3-shadow-stack-v15-4-3fa245c6e3be@kernel.org>
In-Reply-To: <20250408-clone3-shadow-stack-v15-4-3fa245c6e3be@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB6619:EE_
x-ms-office365-filtering-correlation-id: d92ce44a-b776-4ea0-d811-08dd7b821ebe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?MHowUWhiMWtzcHE2VE1MVFNwZEdEQkgwUlZCZFVzOTlvOXNHbk9semN1T25Y?=
 =?utf-8?B?NjJLbjY1UUFZVU01ZlZjTXpUa1dOVExyYWdZd0J5U0U5YlViQkdsZnE1VG1u?=
 =?utf-8?B?QVBPVmt5Y2gybVlZNWVyTDBhZlhTUXJWcVBNa1IwbW1QaWJRenZuQmZSSGk0?=
 =?utf-8?B?aE1sVFFNdm9QZER5V0NCYWdLUkc2anZwTVJRYml1aTlFUm5pdXNWTjU4VU9G?=
 =?utf-8?B?dmFoN3p2bEF0WXNCdUI5WjFlNERYZnR0dlhpTUFLU0czVy9tYjUxUy9lZTMr?=
 =?utf-8?B?QVdTbEszejh0SUs1dXFOWjJaTDdkdHh0QWVNWGhzY3VXK3JsV2lmYWN6czJL?=
 =?utf-8?B?aFBUbzRtYmFGeWx4a0dvdUorcmlDWVNwYmtpMmxuLzVTdVJWYmpvTUJxZ2s5?=
 =?utf-8?B?V1c0cGE2QzNsbHdZZVkrMWtjN0M4WFh3RCtBdjFGTWRzckNSQ0xwM3djNnNH?=
 =?utf-8?B?ZEVZUGFpT1gySmZLZ0ZpVk1nYmVLNzN3cmg0RE9TNTc2WHUyTktNQ1BrK2ZT?=
 =?utf-8?B?RDdJSHZGUWszalBpMjMyRk41ZEF2b01yeU1vTGkvTDdYcWtLWVBlcUVPdnR3?=
 =?utf-8?B?T001cm5IVzgvaGllSEtSUUFiSHdlVzJ6djFGOW9KMk1RMEkxSEtMczhiYSs4?=
 =?utf-8?B?d2poVytnMnpMOWxnSktuLzRpYTZWbVNuMGpieTVhL2RpS0s0ZnlRYWFwOGww?=
 =?utf-8?B?Mk9BWjNYRUpSK2krSlNrUHFnSXpzMkZKeitjUWNCVWFsYURMVWg2YTZNdlcy?=
 =?utf-8?B?ZWI1aG9GSDdsWlo3OUozL1pxT1lyQlBoeEd5S1BPeVVLZURYUnZCR0h0Rjdu?=
 =?utf-8?B?WFE2OGN2akxjRFloT1Q5ZCs3UFNHL3JlQWFvVEwrampKdGtOR3o1UXdOK2tk?=
 =?utf-8?B?eGVhYzh4VHFOc3hUbEhSZS9YNnBnSWxReXdpOThibXZFaktrcjB1ZmVUeUZG?=
 =?utf-8?B?TG9HYkY0TjJYQWFKU01DK2RDUUcxQUlvYWVuSVl1UHZOMlh5bjhGbVFmVmZS?=
 =?utf-8?B?YkZ5Z2NKaDhQczVwNS9YUDYzRlpxU1k2enZ4U2poSnF0Q1lvOCsxT0dHWGZ4?=
 =?utf-8?B?enh4aUxTcWNTUDg0VmlKRXZZYk4vT3BpQXFlbGVTZXFnN0VnQk1GZDhyZzJp?=
 =?utf-8?B?K3k1ME90N3RwUEVjc2pDYzJ6a2plYk85eWN0VWFXQmRIekttdm1tUHlRMFc4?=
 =?utf-8?B?MUV4Yk9USlQwMWlHemJyelYwdlgxOG1lL1QwdStLWFZhdFNwdWc1WTVPa0RG?=
 =?utf-8?B?Umsrb0JoelpYN2l3SDNPeEh1VTNQZFk2N3J5dUNKa3hXRVJSS0NTd25kTzdC?=
 =?utf-8?B?RFdweGRnMUxYbHJEczZhSkh4OUpwNXphcklOcFdDbUZOdjFNdlkxOTFmRTFM?=
 =?utf-8?B?UmIxN1ozUVUzQlZTODBWd1dxTzE1bWkzWm5XS29zSFpJMXV2cUxzTlVUNW5o?=
 =?utf-8?B?QlcxUzFLRVBnQjhYYjgwWUQwdnpPT1p2Y1EyV0ZnKzQyNWhKRUI5cHZuTjJw?=
 =?utf-8?B?TG9xSFhoa2czTnlWME9iNVhlR2MyVzVXYjVERDJXK3RNU1ZnSUJ5Vy8wNGFj?=
 =?utf-8?B?MHhZVGRrSzVhdTNENi9rSktDUTN4OUFFTXFJMTdENEJjUlBMY2lUM3dCTTVJ?=
 =?utf-8?B?Z1QrWERzMmg4UlpwcVdKWHJhQnh4bnJ0UFR3d3RvbC83Z3NZY1BxZFhiR1Fv?=
 =?utf-8?B?dVFjWUdaSjFsSzFXRmo4UlFrc0UrK3crUGg1OHBYZG9aU1NhNXVSRHRocHZG?=
 =?utf-8?B?dEgxUk1RZU0wRFlOZzlzQ1Y0MTVkTXgveDdkMXRTWWNSVnI0RXZLL1p4c2JC?=
 =?utf-8?B?KytXT25MY243cEZqRnB4TEVod0prN05zMW9NVk9hMFkyMVIxR0VkdVhDWXFK?=
 =?utf-8?B?S0k4SXA1OTR1ZG9HakxOQ01tY2dkRnJrTDJ4M1Zua09jN3AwRVRMbVh1QSs3?=
 =?utf-8?B?WTJ1NEljZFZ5QXVERkExVCtRN2N1VjhaYlBQUmZRYnZXTUEzb1MwVXc1Ynpw?=
 =?utf-8?Q?rnr4B7zyc9L2G+7J2oKO96/7fo6GrM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1d0UG5pSSs3WkpaZC9jRGNtNnp1RHFvYjhFRWROSUhtOTQ1VkZkZkNHZmNX?=
 =?utf-8?B?K290Um1VM3ltUE5yQWQvMGlWbVZCSkc2NURERUcwRnZzQUVZbmlpL053OUdK?=
 =?utf-8?B?QWFRb081bUlZUUtnb2YyMVdtR1NvaVV3UzdwK3QvUW16UmdhMGh3ZEFwMWtM?=
 =?utf-8?B?SzdBcElWbGY2Lzc2ZWFLc29nL1EzeGtwdVhTZ1dkNUV3T3BCSW5nWGEvbEx3?=
 =?utf-8?B?KzlMeFAzNzY0cnZsSWplZlFYam9ud1lxS1ppN2lRdU9yd3M0ck5zVGRhb25T?=
 =?utf-8?B?RWtVajBubVljNEp4RlhhNkc4MXc4amI0cDk5REZaQ2xTUXJJZjYrUnZxaHFU?=
 =?utf-8?B?NGlucFJ2dWRmWGZvZ3M5ekhJMzZWSmhMSVZhSmw1eWZWNndHWXRYekpyYUVG?=
 =?utf-8?B?aExvRjIwZW1TTTBXOEpMc2RPUlJIdlhZOXZTbVl1ZzBJYmdPTjNra2NWNVFQ?=
 =?utf-8?B?QTZVUm54b2xBWGxKS1gwR21ZQTR2UnpTWHc1TkdNYnNEVzdVT2VzQUFKWUk2?=
 =?utf-8?B?QzdHSU14UGlnSVF3aTRTZlRtRzh2Z2lyL0F0R3dkY2xIZE1Oa0tNK3ZQSmxR?=
 =?utf-8?B?MnVrV1hJN0lib0M0OVNsTjhzZmZERlphVHRKYkQ3ZnJwR29uWEdsdXB6YjZZ?=
 =?utf-8?B?VGx2M3Nsc01WSXVyOTJjcWRmQU15TDJvdEtHaGc5SU9zOHZiUGFrOHRmTFZE?=
 =?utf-8?B?SHd4aytCdHZpMHNJY3JiaFNpK1p0amljaUtMZHNFUUdFS3VvM1UyVGswdzJu?=
 =?utf-8?B?aFcyTElZdnMxT09XTUhYb3ArQVkvR0w4YjMycWZ3QzlUdHNSZFRKdnRUcGVF?=
 =?utf-8?B?MHJ2WGRKcGh0MnlrUEV3NmJ3QS9ZK3R0Zi8xZm96MTBvMjRycHpSNkd2YjlS?=
 =?utf-8?B?b3JxMjcyZURWVUtrSndyRXl3N1A1M0RqdHBWZDk3M3RxOXRMOG1aSjhnVEVj?=
 =?utf-8?B?V0V4dnp1WlB1NHpnWGJxWTFqUVFsTFk5djFFQjRJamdSNS9sNktwZjVtTi9O?=
 =?utf-8?B?REpRaHV4SDU4cVJqRzhOWCtmYzRBelhlT1IzTlVBUUFwN2FFM1cvd2ZzbG45?=
 =?utf-8?B?cGlYc0gvaWR0R1FBK3pqSnkxTi9saGdpUExXS2FMSzRneGl1TEE0YU0wblg0?=
 =?utf-8?B?TDg2OGxtZkN4NnRQNW1UaW41alFaSHk3ZDNZYkVuODhmTUxrTnE3c2hNV2tX?=
 =?utf-8?B?TUhBZVJGbFFLV1lUZDZSRTNVbi9kSU0yTlhHbDBxK25VcXBoWHFTOVYrQVdB?=
 =?utf-8?B?WXIvbHlTY3R2cHB2a1lSTVFjRm5CQVh1d0U1WVdhYS9EckhEaDJ0QWN6bHhh?=
 =?utf-8?B?M1BnM3JsM1ZUc1F6d2V5UjhRdnZlL2kxdTk3Y2tKWDgveHp3OVBMQkZVUHJ3?=
 =?utf-8?B?R25VVW8yZ0M3TVdXK3VOZzMwcmZyellieXVKcTVIUWxFQldHUXFzMmxQc3FS?=
 =?utf-8?B?ZjRuTm1sTkFSQm8zdy9ERjR4R1BuWXhFZFdwdUNwL243TyszcHNYV0czT2Vn?=
 =?utf-8?B?UlVaYUdlZWpYVDhjb0ZDY0wwa005UU41akI1QXpoR3pDbUtQdEZzL050ckRh?=
 =?utf-8?B?amxxejlBYVkrWWIyeUNEZmtTOXhwKytvNnF5YWE5OHNvdWdSZm5yT1lpU1k0?=
 =?utf-8?B?MXpZVVZsbG8rVThQc1duOERyak8zKzdlVG1iYUdId3R5bXl1OTZ0cCtaRXIr?=
 =?utf-8?B?Y1c5aHgxMkJyaXQ1OUhKL1VTUFE2ZGlXTVNMWlNScVlxb1VHOTQycFU2MFc4?=
 =?utf-8?B?MG1wSjV1bklPdVdTd3YrZVVMZjVla1UwVGNxYWd1cHpMa2lxeDdwUVlGY2JT?=
 =?utf-8?B?aTlxTDU3WGNPVHd4QVZUM3J4UWR0RzlDMXhaNjVnWGF3MXZLODkwRkZBYWY3?=
 =?utf-8?B?dWgyaVV4ZmJlanM3RGdqZXBXN2xuV2Q4cDdaMjVSbGcrVEQxWS9NZXljS2hw?=
 =?utf-8?B?bTdmQ1gyN2pPQUlxZDNrVVU1MHNSWWJ4cUpJWmVQY05pc3YwZ09CVDJMcVJW?=
 =?utf-8?B?d0N4ejdhUHlrVS9tK2syT0ZQNGNNTXJlZElrczVnS1NGY0NzYjNFYUZKUnJG?=
 =?utf-8?B?MXJLeEhvcHYzTzFjRnpCSVFKRmpOR3dlMXdLT0toOHdDTE5MQnQwUDJyY09L?=
 =?utf-8?B?OFBkVDFPZUJxNUVORTNqMEhxeFNiS091bUk3RnkxemJwU2kxQ2pFNUxSWnVX?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B122F645C9FA241830E6702EB1C0C87@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92ce44a-b776-4ea0-d811-08dd7b821ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 18:28:14.8098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMjnyH2MoR29tZa8vCwnA+tUcI9tnT3lYJRygGJEuHeh9PkAIiEe0wZ/AHoVI9tMqx3oCd8OmKHqJUxkmyI3KWIN4GRnEi5WUjjxQO/tbRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6619
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA0LTA4IGF0IDE5OjQ5ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiAr
aW50IGFyY2hfc2hzdGtfdmFsaWRhdGVfY2xvbmUoc3RydWN0IHRhc2tfc3RydWN0ICp0LA0KPiAr
CQkJwqDCoMKgwqDCoCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4gKwkJCcKgwqDCoMKg
wqAgc3RydWN0IHBhZ2UgKnBhZ2UsDQo+ICsJCQnCoMKgwqDCoMKgIHN0cnVjdCBrZXJuZWxfY2xv
bmVfYXJncyAqYXJncykNCj4gK3sNCj4gKwkvKg0KPiArCSAqIFNTUCBpcyBhbGlnbmVkLCBzbyBy
ZXNlcnZlZCBiaXRzIGFuZCBtb2RlIGJpdCBhcmUgYSB6ZXJvLCBqdXN0IG1hcmsNCj4gKwkgKiB0
aGUgdG9rZW4gNjQtYml0Lg0KPiArCSAqLw0KPiArCXZvaWQgKm1hZGRyID0ga21hcF9sb2NhbF9w
YWdlKHBhZ2UpOw0KPiArCWludCBvZmZzZXQ7DQo+ICsJdW5zaWduZWQgbG9uZyBhZGRyLCBzc3A7
DQo+ICsJdTY0IGV4cGVjdGVkOw0KPiArDQo+ICsJaWYgKCFmZWF0dXJlc19lbmFibGVkKEFSQ0hf
U0hTVEtfU0hTVEspKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiArCXNzcCA9IGFyZ3MtPnNoYWRv
d19zdGFja19wb2ludGVyOw0KPiArCWFkZHIgPSBzc3AgLSBTU19GUkFNRV9TSVpFOw0KPiArCWV4
cGVjdGVkID0gc3NwIHwgQklUKDApOw0KPiArCW9mZnNldCA9IG9mZnNldF9pbl9wYWdlKGFkZHIp
Ow0KPiArDQo+ICsJaWYgKCFjbXB4Y2hnX3RvX3VzZXJfcGFnZSh2bWEsIHBhZ2UsIGFkZHIsICh1
bnNpZ25lZCBsb25nICopKG1hZGRyICsgb2Zmc2V0KSwNCj4gKwkJCQnCoCBleHBlY3RlZCwgMCkp
DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCXNldF9wYWdlX2RpcnR5X2xvY2socGFnZSk7DQo+
ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KDQpGaXJzdCBvZiBhbGwsIHNvcnJ5IGZvciBu
b3QgY29udHJpYnV0aW5nIG9uIHRoaXMgc2luY2UgdjkuIEkndmUgaGFkIGFuIHVudXN1YWwNCmVu
b3Jtb3VzIHByb2plY3QgY29uZmxpY3QgKFREWCkgY29tYmluZWQgd2l0aCBteSB0ZXN0IEhXIGRp
ZWluZy4NCg0KSSB0ZXN0ZWQgdjE1IG9uIHg4NiBhbmQgc2F3IGEgY291cGxlIHByb2JsZW1zOg0K
MS4gSSB0aGluayBrbWFwX2xvY2FsX3BhZ2UoKSBpcyBzdXBwb3NlZCB0byBiZSBwYWlyZWQga3Vu
bWFwX2xvY2FsKCkuIEJ1dCBzaHN0aw0KaXMgbm90IHN1cHBvcnRlZCBvbiBoaWdobWVtIHN5c3Rl
bXMsIHNvIGxldCdzIGp1c3QgdXNlIHBhZ2VfYWRkcmVzcygpLg0KMi4gU29tZSBvZmYgYnkgb25l
IChmcmFtZSkgZXJyb3JzIHRoYXQgY2F1c2UgdGhlIGNsb25lMyB0ZXN0IHRvIGZhaWwgb24geDg2
Lg0KDQpCb3RoIGZpeGVkIGluIHRoZSBkaWZmIGJlbG93LCBidXQgaW4gZGVidWdnaW5nIHRoZSBv
ZmYtYnktb25lIGVycm9ycyBJJ3ZlDQpyZWFsaXplZCB0aGlzIGltcGxlbWVudGF0aW9uIHdhc3Rl
cyBhIHNoYWRvdyBzdGFjayBmcmFtZS4NCg0KT24geDg2IHdoZW4gdGhhdCB0b2tlbiBpcyBjb25z
dW1lZCBub3JtYWxseSBpdCB3b3VsZCBoYXZlOg0KDQogIFNTUCA9IHRva2VuX2FkZHIgKyA4DQoN
CkkgYWx3YXlzIGFzc3VtZWQgdGhlIEhXIHRva2VuIGNvbnN1bXB0aW9uIGJlaGF2aW9yIHdhcyB0
byB0cnkgdG8gc2F2ZSBhIGZyYW1lIG9uDQp0aGUgc2hhZG93IHN0YWNrLiBPbmNlIHRoZSB0b2tl
biBpcyBjb25zdW1lZCBpdCBpcyB1c2VsZXNzLiBTbyBtaWdodCBhcyB3ZWxsDQpyZXVzZSB0aGUg
ZnJhbWUgZm9yIHRoZSBuZXh0IHB1c2guIEJ1dCB0aGUgY2xvbmUzIGJlaGF2aW9yIGlzIGRpZmZl
cmVudCB0aGFuIHRoZQ0Kbm9ybWFsIHRva2VuIGNvbnN1bXB0aW9uIGxvZ2ljLiBJbnN0ZWFkIGl0
IHdpbGwgaGF2ZSBTU1AgKmF0KiB0aGUgdG9rZW4sIHdoaWNoDQp3aWxsIHRoZW4gaGF2ZSB0aGUg
bmV4dCBjYWxsIHB1c2ggYW5kIGxlYXZlIHRoZSB6ZXJvIGZyYW1lIGFzIHdhc3RlZCBzcGFjZS4N
Cg0KRG8gd2Ugd2FudCB0aGlzPyBPbiBhcm0gdGhlcmUgaXMgU0hBRE9XX1NUQUNLX1NFVF9NQVJL
RVIsIHdoaWNoIGxlYXZlcyBhIG1hcmtlcg0KdG9rZW4uIEJ1dCBvbiBjbG9uZTMgaXQgd2lsbCBh
bHNvIGxlYXZlIGJlaGluZCBhIHplcm8gZnJhbWUgZnJvbSB0aGUgQ01QWENIR2VkDQp0b2tlbi4g
U28gaWYgeW91IHVzZSBTSEFET1dfU1RBQ0tfU0VUX01BUktFUiB5b3UgZ2V0IHR3byBtYXJrZXIg
dG9rZW5zLiBBbmQgb24NCng4NiB5b3Ugd2lsbCBnZXQgb25lIG9uZSBmb3IgY2xvbmUzIGJ1dCBu
b3Qgb3RoZXJzLCB1bnRpbCB4ODYgaW1wbGVtZW50cw0KU0hBRE9XX1NUQUNLX1NFVF9NQVJLRVIu
IEF0IHdoaWNoIHBvaW50IHg4NiBoYXMgdG8gZGl2ZXJnZSBmcm9tIGFybSAoYmFkKSBvcg0KYWxz
byBoYXZlIHRoZSBkb3VibGUgbWFya2VyIGZyYW1lLg0KDQpUaGUgYmVsb3cgZml4ZXMgdGhlIHg4
NiBmdW5jdGlvbmFsbHksIGJ1dCB3aGF0IGRvIHlvdSB0aGluayBvZiB0aGUgd2FzdGVkIGZyYW1l
Pw0KT25lIGZpeCB3b3VsZCBiZSB0byBjaGFuZ2Ugc2hhZG93X3N0YWNrX3BvaW50ZXIgdG8gc2hh
ZG93X3N0YWNrX3Rva2VuLCBhbmQgdGhlbg0KaGF2ZSBlYWNoIGFyY2ggY29uc3VtZSBpdCBpbiB0
aGUgbm9ybWFsIEhXIHdheSwgbGVhdmluZyB0aGUgbmV3IHRocmVhZCB3aXRoOg0KDQogICBTU1Ag
PSBjbG9uZV9hcmdzLT5zaGFkb3dfc3RhY2tfdG9rZW4gKyA4DQoNCmRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9rZXJuZWwvc2hzdGsuYyBiL2FyY2gveDg2L2tlcm5lbC9zaHN0ay5jDQppbmRleCAwNTZl
MmM5ZWMzMDUuLjJiMGY4NGFlNDM2NyAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5lbC9zaHN0
ay5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYw0KQEAgLTIwMCwyMCArMjAwLDE5IEBA
IGludCBhcmNoX3Noc3RrX3ZhbGlkYXRlX2Nsb25lKHN0cnVjdCB0YXNrX3N0cnVjdCAqdCwNCiAg
ICAgICAgICogU1NQIGlzIGFsaWduZWQsIHNvIHJlc2VydmVkIGJpdHMgYW5kIG1vZGUgYml0IGFy
ZSBhIHplcm8sIGp1c3QgbWFyaw0KICAgICAgICAgKiB0aGUgdG9rZW4gNjQtYml0Lg0KICAgICAg
ICAgKi8NCi0gICAgICAgdm9pZCAqbWFkZHIgPSBrbWFwX2xvY2FsX3BhZ2UocGFnZSk7DQorICAg
ICAgIHZvaWQgKm1hZGRyID0gcGFnZV9hZGRyZXNzKHBhZ2UpOw0KICAgICAgICBpbnQgb2Zmc2V0
Ow0KLSAgICAgICB1bnNpZ25lZCBsb25nIGFkZHIsIHNzcDsNCisgICAgICAgdW5zaWduZWQgbG9u
ZyBzc3A7DQogICAgICAgIHU2NCBleHBlY3RlZDsNCiANCiAgICAgICAgaWYgKCFmZWF0dXJlc19l
bmFibGVkKEFSQ0hfU0hTVEtfU0hTVEspKQ0KICAgICAgICAgICAgICAgIHJldHVybiAwOw0KIA0K
ICAgICAgICBzc3AgPSBhcmdzLT5zaGFkb3dfc3RhY2tfcG9pbnRlcjsNCi0gICAgICAgYWRkciA9
IHNzcCAtIFNTX0ZSQU1FX1NJWkU7DQotICAgICAgIGV4cGVjdGVkID0gc3NwIHwgQklUKDApOw0K
LSAgICAgICBvZmZzZXQgPSBvZmZzZXRfaW5fcGFnZShhZGRyKTsNCisgICAgICAgZXhwZWN0ZWQg
PSAoc3NwICsgU1NfRlJBTUVfU0laRSkgfCBCSVQoMCk7DQorICAgICAgIG9mZnNldCA9IG9mZnNl
dF9pbl9wYWdlKHNzcCk7DQogDQotICAgICAgIGlmICghY21weGNoZ190b191c2VyX3BhZ2Uodm1h
LCBwYWdlLCBhZGRyLCAodW5zaWduZWQgbG9uZyAqKShtYWRkciArDQpvZmZzZXQpLA0KKyAgICAg
ICBpZiAoIWNtcHhjaGdfdG9fdXNlcl9wYWdlKHZtYSwgcGFnZSwgc3NwLCAodW5zaWduZWQgbG9u
ZyAqKShtYWRkciArDQpvZmZzZXQpLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGV4cGVjdGVkLCAwKSkNCiAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCiAgICAgICAg
c2V0X3BhZ2VfZGlydHlfbG9jayhwYWdlKTsNCg0KDQoNCg==

