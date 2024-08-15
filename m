Return-Path: <linux-kselftest+bounces-15371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFF19526C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B73282198
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697E11878;
	Thu, 15 Aug 2024 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGa2BkUM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02F22CA5;
	Thu, 15 Aug 2024 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723681194; cv=fail; b=uG6tpr774l+wSqb8oW/8blu9y3wgLSMQ6hMghRRRJjDwrb7zgOtWTHZawgJVq2nckQ/yQRMoQcD3Szfylt9DirdOhoR0CkLU4S3WE4NrdY+OPJQsr3VTGqyilHRroh0Tq7PeiMnDMe8wHpBtTZOOJR7zIRSgg8uYLnZ1A4JWpME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723681194; c=relaxed/simple;
	bh=m1GXab4adhoze/Vv8TfRWZEMm3Q+QhgyTpXP8R2b5vY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QuLIZn95M7pzomNU9esV8TTk5ctk/FoV5S6E+lMvQ2g+jTC3Wr3gCWZwt+Fsb1EMpyv/oHWXXvHMExA3EUCSVzXZmImmm4QdHQWmj0dCUospg6wLncOLsZLDjGVFjXZflv4khyx8yKaeDkq1yOi/QbwbsUSJ37RuDKRlB05OIEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGa2BkUM; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723681192; x=1755217192;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m1GXab4adhoze/Vv8TfRWZEMm3Q+QhgyTpXP8R2b5vY=;
  b=hGa2BkUMfOpqKqZaluCKJnJGOrgtRoG0Gdy+W+esrfSQqNQnfYaUCMDy
   wpbuwYbJY/djL29tkU/n9FyoIyTQ2Iu6ixGqQEFi4R8EEk8zHjdwrQe15
   49NQOLhRT6C2/fGRX24GM+jfLDONrpFzv3nO5aQ6aXNBM0HHBeN1Yu4Si
   MiiTodxMt0TelVh9jvbfye3UT2+wJgSmfubA5OkU63yo6WF634r4fAT2C
   lugayUgjB23EbpoO7rYBuKhwyFfukx4BzOkWtbVAM1iMmWHdg1gK76pFt
   e9F8Q4lVrh3G0R3KLSSjiT4NZqElroYVEsMLMeeaLNAewi+8H6couaXiQ
   w==;
X-CSE-ConnectionGUID: Xb8Nq6lcR06VVjgyFHyIew==
X-CSE-MsgGUID: kp7lKhaCR/+HJLRU6gEetg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="13019639"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="13019639"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 17:19:52 -0700
X-CSE-ConnectionGUID: 5pBjrw7QSCKxDpWae2t3bQ==
X-CSE-MsgGUID: LHCsS7UGQtCDRi1u47aQLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="58858582"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Aug 2024 17:19:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 17:19:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 17:19:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 17:19:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msFafqP+M68Op9n2EkfpMj8k4V88zl4O/IDtzS669RnHS5tStRdqm4/0BjX6zAZfauZ5mXTn4NWiCvPrrNLwVwQjsV/BqhMJM2Ujf5aOzxtVhCde0EJSEP2XRf0cEM5Lo4U847I0LS3nvuxcU6UhcwYSMnsLqA8FoWImKmvnNvuzPRDguiYofgBlGZ3snMolaPnLj9G+MMr+DWCHUCDohkQJjNM95EfsslYt5al3QKHOWt/SQW/YPkpjZzbRMpP0Ohsc56GTl8GvOdA/hJ0cH+LzPRwmaob6n/S4lV1x0GkAIy7XOnPSZMjlZBm1rh09UcjTVbff5gtlj1xcNQN6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1GXab4adhoze/Vv8TfRWZEMm3Q+QhgyTpXP8R2b5vY=;
 b=nHtC2Dm/aco/3P6HByK3CMq9SLXeZYmsosvwCPPUwr96eY9yYbexNcj9Q3c3gfSMDeqbXk9QvWQlxgAeNJSkBZoUD7gLO+LYpvnB38JC0Yzeh+rCdA+e9HDlzIYzE5vTqPO8sp6w5yxxdu22AhxYPStbHBqR5Zv7352In7JpbWIU7y+49bk2PapWYJzFxD4kPR5VWGbc1JVhPOVXvfclELyp/IjZ6Z6r5ElS9jMmH9rvaRUFKJem6bHa+6CRa7sIFBWhKZ6HW8ZwEuhCdzxAsmjZ0ATw9cr2lIVdYkva5jRZeVpahoFSW5AE1irR0zBEaYkRHzWTk/o6eqtntWLW6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN6PR11MB8172.namprd11.prod.outlook.com (2603:10b6:208:478::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Thu, 15 Aug
 2024 00:19:48 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.7828.030; Thu, 15 Aug 2024
 00:19:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kees@kernel.org" <kees@kernel.org>, "broonie@kernel.org"
	<broonie@kernel.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "david@redhat.com"
	<david@redhat.com>, "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"brauner@kernel.org" <brauner@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "jannh@google.com" <jannh@google.com>, "bp@alien8.de"
	<bp@alien8.de>, "bsegall@google.com" <bsegall@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>
Subject: Re: [PATCH RFT v8 0/9] fork: Support shadow stacks in clone3()
Thread-Topic: [PATCH RFT v8 0/9] fork: Support shadow stacks in clone3()
Thread-Index: AQHa6WtLzCrKeBBrPk66G4g/1p9vVrIdpTOAgAnZooA=
Date: Thu, 15 Aug 2024 00:19:48 +0000
Message-ID: <f8e5dc469c91a4f1dd0b602d3b78fd142b3ce6b8.camel@intel.com>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
	 <202408081053.0EABACA@keescook>
In-Reply-To: <202408081053.0EABACA@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN6PR11MB8172:EE_
x-ms-office365-filtering-correlation-id: 6370098b-6f1f-430b-a8ef-08dcbcbff920
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NzRMM3VFWTh1YXpvYmh3ZVRJM2d2ZWkwNW14elZSV3lrR3hoREN5MnFINWJh?=
 =?utf-8?B?SnRhYVEvSlN1YktpZnBpLzNQYkk0OStmT3VtMHFoaVllMy9VQ1drZ3ZMNGhU?=
 =?utf-8?B?Zi9Lbkk4UVhZOC9xZno5cGljNEdocXFFVWRjZzJ3L290MzNrMGlwWUNCQnpI?=
 =?utf-8?B?eU4vRS96cnRpbFdETitFY2dGdkQvaGQyNTJ0R016QVd1em5ZbkxmS1RDN21j?=
 =?utf-8?B?RHBtTVJXK0t4VzZIOVVYUEl6cXVOWVhCY05FL2ZqMnkxRElKMzRLWVhNeVJl?=
 =?utf-8?B?VzBYenluZm4yNTk4SVNJTXZGTnN0WFd5UUhnNlowaTlSaXIzNGNpbVRBTzdR?=
 =?utf-8?B?T3BYV2JRK2hGL0JpaHRTN3FZSkdRRGwyQjhCM2h0M3NZNmZqWW84WWY2K1Jj?=
 =?utf-8?B?Sk5mRUV6ZkxZUzNKZTZDSFEraS9sbnJjR1F1b1ZHRHlGV0loSEc2TGxnWHE3?=
 =?utf-8?B?Y0lzTVVyT1FFTkMybXl4dUI0eWZUWXpNVTJWajJOaTM4aTlTUUo3dEdENFF2?=
 =?utf-8?B?RnkrWjE5RVZycnN1QkhZOWVJclRBVUdwWXcxV3V4RmF0a0Q3MkkwcE1QN1cx?=
 =?utf-8?B?Z1Z2TWxJUkpjcjhxQUtJenlXNldoZXBoYWp2M240UHFmV3JQVDV0c3RvbmM0?=
 =?utf-8?B?YldMMHgzWENTOFVza3ByMEpYQVo1b1BDMDZUM2RMeG5iN0ZaTHphZWhlTDRP?=
 =?utf-8?B?K3lGMTJDSWRYSjFvZUpHV3JJR3RHRlVVNE1OOFE2dmVnWGl1U3hCTWZmSGZB?=
 =?utf-8?B?MVhVc2Q5dkZyc2p0T3o2VGZLZldJZDJ4RUtSUWpQZkNBU0hKem4wdnNWcVVk?=
 =?utf-8?B?WS9EL3N3NUt3NzZjcjhBUzFEU2dzZmFXenBWTlRzNjhQWHU0eHRhTG1hMk9F?=
 =?utf-8?B?T2VhNXFjZDdJL2VjVVg2Tmx0bnQ5M1dNL3NVK1FRbTMycFRUaGNrQnB2ZWpW?=
 =?utf-8?B?aDNzcEl6S1JZUXRKN0RvQVo1U2poS1BtMkxuUGUvNzlOS2xLeERYUHFkVVFT?=
 =?utf-8?B?U3JMVGc1ZW9qY0tBbGZKaUZtVzdRQ2xKdysyeURGUi81Q3NXU0lyMzBrRFRL?=
 =?utf-8?B?TzNUckxRZUNCUGlmZEpUdG03UkdEeWtWQmtRNDc2bTBnbHQ5aldvZlFwWFNU?=
 =?utf-8?B?b3VLOWVLanVzTEFtQS9TVkRuL2FUVXd6S09DSWJOMmsydWNkc1lJMzl6NDd1?=
 =?utf-8?B?c0tqVVJlNElnaHFHeHRUWFg2SmJKYnUxN3NDbFZHOGovOVBBUTEvNURWRm1Y?=
 =?utf-8?B?UmdaMVR4NnY4aEZzcnZLdHE3c05RUzA4T3lJb29IdjBFNGlEcEhCTjhGNCty?=
 =?utf-8?B?ZFhBcENwY1IvNWF6VWdqTWROWngwNW5oS0JPL2pQZ016SUpWT21MNnErZXk4?=
 =?utf-8?B?am5rVWxFRHNrbGI3SVBZblVCelk3b3RjZVp0MGpDUzZnZ1N2Y0tqeEQ0ZVZj?=
 =?utf-8?B?NkgwMkxxeG04Sk9KNnRtNTBFQS8zRnlEeTRuaE9MSk1hczdPNytpbDFYKzJw?=
 =?utf-8?B?Q09VbzkxclFZT25lS0x6NGRBNFZhZjAvcjcvMTJkVWNiWXR6bVN4cWlwZGt0?=
 =?utf-8?B?dE5ObU15a2JTdTVyR21VNWhCK2NxcnVBK1JUb2FncGNXeXNqTzIzaWR3dkdJ?=
 =?utf-8?B?OFRJME5vQmlSbjV3MDFtQkFCMWRTMHRCcGRDdzlqdEpBT2RqMlcvc0tHMC9i?=
 =?utf-8?B?cDBxZlZjMy9aZUpKZGowTHNWTmFqZFZDanNkR21MTktTZUxqb3hnWnBLdTJn?=
 =?utf-8?B?T2Y3dUF2S21tN1k3ZTdhSER6R0tKUTI0R1pBeVR4WHF1OEtjSE1sRTBzZ05G?=
 =?utf-8?B?ZU85OG9SVmNjN2swdzg4eE84MENUSzdyUWNXUEloRmxIUTJ4NUdPanpjb0Q0?=
 =?utf-8?B?K0RyTTFQMzdOSjc0Qm1tU05uRXVsaTFVclY1MWtaNys5Y1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1hmRnQ5ZjBGejNUMzIzbEcxVTUyVHdoVlE2eVRWTUJEODEzOVBxaksrUWpi?=
 =?utf-8?B?cGJQUk9PcWdtU3BFOTFOVTFhSzJydTFIYjBBalZTaTZMNWhnd01TSWhONzlL?=
 =?utf-8?B?MFR5VGxPaW5sSkx0amNuNHJSZSszRWtZbXh1M1Y4eFJqd0YzMC9nVm5RYWY3?=
 =?utf-8?B?cHM3eERGRTh0V3liNTIvdWVnVWo4UG5Pb09CTUNhc0VTUEt6NW5RVDVGbHVm?=
 =?utf-8?B?eU8yVXZFUWpEM3daZVJkWU9SV092ZU5PbTZQSU9KanFQVHF5cysyc1lOODVz?=
 =?utf-8?B?SUs4bCtCZUlMdy9ZcW1OL1dpaGc0dnoyTC9hQnZrdGd5M1RnaTNNdEVFRVB1?=
 =?utf-8?B?ckJIODFNMkF0WEY0d3kvWEdWczlHY0w5T2E1b0hsOTZJbVdaMzJ1dWFXTEZi?=
 =?utf-8?B?S3RXem1RRm90RFdBbUZHYldBOTZLWis5cWNlWm9YYkRoOTdkc1l4U0dJYXEw?=
 =?utf-8?B?VUNPMHNOeXhpZmFwUTlYaytvalNSODJDMUk1VTF2UUV3aVdTU2VUN29FT3Ni?=
 =?utf-8?B?ZlQvcVpyYjdoVU9JUEpPSWxKRld2WGVmWGdKK09mbnY0SnFsazVjRU5uRnJO?=
 =?utf-8?B?UHRVTHBDZW9mMVRvQzE4SzBrNUxCNktKMlNZTFVERVY2OHpWdkk3Sks2eHpY?=
 =?utf-8?B?V0NjOFQ3MnVyNnFrWjdKMkc2L2R4OFlpLy90SnZIalYwalJhblhTckxLOFBN?=
 =?utf-8?B?b0l2eWY0ZVBPVWxScHU1UUNiUkZvRy81ZGdPT2piQ3pFUHFFR2VwU3dXWHZm?=
 =?utf-8?B?Tk1pRHRJeEo2ejhaWm1hZ0FySVA4eGZEbHF1Nk5JS3VqNzhKUTlBN1JMaUR4?=
 =?utf-8?B?YmZnY1o5UGQraXB1Z0dGTHZqV2ZwZWgyamp2N1UrMVByUjRDWWd2cllrUk01?=
 =?utf-8?B?WVJtdlBsb2tIVG5yME5JaVBKVlZZaVhYT29BODdXYmMyVlZFZ2ZSMUwyemd2?=
 =?utf-8?B?VnhOem1rc1RsbDhlU0d6VUZiL1VwRjhJWUVZR0szdEVseVV4cm1yU0M5UFZY?=
 =?utf-8?B?Y3M5OWxBRjJ5QzJlN3VIMUx3ZmR0aDFoM3lFbktOYmxBOTgzWWNLSjV3ZXVr?=
 =?utf-8?B?cmVPOW5wZHlmRC9RSW1OdkdtdFY0c0NHalRoaHRIdnRvY0xUVCtHTDc5TzdT?=
 =?utf-8?B?d1RXZWtBZzg4dzYzLzFBVGlpSXpaQkVmV0ZKUWhrU1NVdm85OWIyUldMRHdH?=
 =?utf-8?B?anR2RmpGaHd4cEpyKzhvU0NGOXN3ZVFFOHRqSkVvV0dWZFZpaUhPVTRLc251?=
 =?utf-8?B?emxQZEZ4OHN1L0xnSUt3NjFwTmF4REdzVDZQR3NHZkgvTU9semlnOE9BcnZ3?=
 =?utf-8?B?R0tNd3Q3U0R1SCtVVVkwaURFZXR6SmJwbkNvVnZDdS9jNWNXRnhHMHFwZlFX?=
 =?utf-8?B?cWVkOUxicGxud0ErdGhwem5KODZISFo1YWdlaUsybGtyNXBaKzZtem81S2Jy?=
 =?utf-8?B?a1Bha3pKNEpibVBLV2NrSlFvUllLWERJQXVtY1dTZS9EdlNGUUJSZFBWeSta?=
 =?utf-8?B?ZHhrRTR0WWVQRWRFVXJWVWJZY0ZDVUdDQ1hBNDluUmUxd3pXbi92MzlUMmVl?=
 =?utf-8?B?U1NFcVJhQUJZMTduY0ZiUFdRaThycWZrMmEzckt3dUwyaFRNb3NvL2RFcHkz?=
 =?utf-8?B?WkFFZGwwY2FTckZsVWd2a2Fva3RWNlJ1WS9CZXo3OE1xb3c1NldrL2F5MG1I?=
 =?utf-8?B?SE1pRUg2c2FNbnlqOEhoakI5b0VOSlN3WHNwOXFrWUdlUCtqS1laQit1REo3?=
 =?utf-8?B?ZCtOZlV4M01BekkxSCszMVlnNnp2eGRtOXhKRjArMG83S2lPZ2ZEcXBBU1N1?=
 =?utf-8?B?aHJjWjduMFdxZWdCemI1ejBQR3Q3UW5DQmwrc3NrT2s4UGptbGFDbFZURVRv?=
 =?utf-8?B?Tms3KzlUSC81eTRERW9tQlpCNSt3cFhzMVV0WHhpUTF0QUI1SGF2cjVPQTBq?=
 =?utf-8?B?bzY1MGRNRUFkdWZYbWZ3cmxUYVZGR0lBK3ZyQllRMzZJTEdDR2thaW5sRC84?=
 =?utf-8?B?Z1I3d0ZUYkZJcTZOYW9VVVdRaVozV2xVaHJpMTVwdi9sNStZN2tPK3dEaXJU?=
 =?utf-8?B?WmxyVWdReEVJZVFIemxTbDJ0SVZUMkVwTlhwVHY2YXhNVFZaM3ZmY2puMVds?=
 =?utf-8?B?TlVES2x4aDkzQVNSc1pIWVhUWHBlejdJd21BQzR5YUZRRHg2MktNelA3dHhB?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35A53BB90E524F4C975080FF498FDA72@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6370098b-6f1f-430b-a8ef-08dcbcbff920
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 00:19:48.4061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kuEiHwwl3a31VHYUQXtKjh2xwTaGPrLhSt5e3jVIwu4N1ka+WLIYOCRrbnjJHna+0OFo8K/8pOu+/PzvEEOYykZGSkSUIR46nPLjFFrvx0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8172
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA4LTA4IGF0IDEwOjU0IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IFRl
c3RlZC1ieTogS2VlcyBDb29rIDxrZWVzQGtlcm5lbC5vcmc+DQoNCkkgcmVncmVzc2lvbiB0ZXN0
ZWQgaXQgd2l0aCB0aGUgQ0VUIGVuYWJsZWQgZ2xpYmMgc2VsZnRlc3RzLiBObyBpc3N1ZXMuDQo=

