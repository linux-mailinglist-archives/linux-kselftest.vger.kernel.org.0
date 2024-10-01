Return-Path: <linux-kselftest+bounces-18834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD2798C8E3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 01:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42C51C23ECE
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 23:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7546A1D095D;
	Tue,  1 Oct 2024 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IzIRNOE6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D89E1D0950;
	Tue,  1 Oct 2024 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823798; cv=fail; b=tJ0qnMdIqAZNEZVlWSaUAetM0SdWF6IaN+apBf1cA1bufaK789gDPndosufb30jnCJCkA7ZxDPMtbQ7sdXTqdQfbnEeW5nw04Ya1rpyEO9OBAEg+tsFCnImUvFjiaFAWkyZtsqf0BQuB2599e7WljTPNc2C8NQSXlYA7Gsz5qUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823798; c=relaxed/simple;
	bh=0lU0ASYvqVIyLbTwikj9lUOps/sahKtk3nCP2zxjTWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JVWpXmDyXKtCKughPCQrDS30Bo3c6XeUbazCykkpsBg+hTMYvmAL1zArXaag3WqQbHAPXlhSDC67Fiis/7K4/c8mQjKFCUxNnz9eVVBdzBWCH55dNiVAQElQNxIuoGvgp06hWg+mE4qssezUEIdbC3DpsI6TVn0qPGwWVZqqiBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IzIRNOE6; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727823797; x=1759359797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0lU0ASYvqVIyLbTwikj9lUOps/sahKtk3nCP2zxjTWY=;
  b=IzIRNOE6uiXj2L5VjJpwzZL0iQVXVmwWRNoiKUfqx32+0MTlbaueelq9
   xloJljpkg55nS9GhWRjJMne4XBzJYps6zo6lEoQx9Zzes0IvtvD694hz+
   OKAdbgJ8L5D7o9GjLAFaN4egVKLwSQKrPxQl3noaRFueYhFu1C7h7p2hc
   kRzsOrV3CQ+T6udeBvPhmXb3IRvlFg4eaGc2E6ug/7N///m43TAj8nz1E
   aNQVeWsqWgAU9g5uNyspoRAzZzEAeN//iBgp63s5D1SCpIVNOmJxv/eJv
   QcEBBq6ykB0Qw2SnfXwl7eYcuGyVrXZtweWtiKtrfMR9VjUQkEdMyrBE+
   Q==;
X-CSE-ConnectionGUID: lzQEyQIwRhWE0EOkyleojA==
X-CSE-MsgGUID: Ve4teC/OSUewxpV0+Fm4Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="44508847"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="44508847"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 16:03:14 -0700
X-CSE-ConnectionGUID: 0B40wu2gTpiKjXS1Pyl2ug==
X-CSE-MsgGUID: OjqIWYE7RJKorIjyoGQpXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73484524"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 16:03:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 16:03:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 16:03:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 16:03:13 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 16:03:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6cypxNMjSk+29nRRt7e2UNBatie76smsVRk5WfuQdJHOoycxCthJeOr4ULgTevQYlW8TmOF36H6fJ5Ut7UT0ykUQlpJGOCAgEeFqYI6igS7seFkG296UyUTXCcuhDEF5WDAjqp0pKukVCItY8+sVuhoYb/hwmWSaoc9R3/Kea6Ia18eOpW5+mfEDmNEgre9c5DrStHa7Kf+Qz83v7nj0qiANquCW5fBpzFC/11xMxr395/Xb0+H8JXjo3/IaOiUjMU0w621gK2XySSg0aT2EA5hEY7+vHVYbHp7v1iDg8h5hZWBpVBQxaYbyL599E1zb7unx0M5LFvDnfChPILSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lU0ASYvqVIyLbTwikj9lUOps/sahKtk3nCP2zxjTWY=;
 b=vz/aN4JSbcjiiU+MZk+Ck9pJzAd3Dt0RQjZxUb+ZXKEs6wlm0hm8QBtv6ENT6j0on4O9LcoJZ2mIC6bPFc+ZOLew6xhmQvagF9KGNwjxvGuq5wF43ECMeMXrzfehiIz5NHkY1JgTN79wVJtctuXol2IWs46ZtY7XLD1+KVIcjL/aTdLS5ghvysJPsbzoPf0Mj7QVnNASTKPVXneq15ahGGIuc2x19rwzRSfUc/VHTt0qak1G34ArmgO60DaP4vyRo4C6ffOatCh4DyrQ5Qhfn2+9va1l4XJpxtmg1PC5V0UZWIhYEsIXelIg/+/5ow3A8iYkpfdEjbDHiANJUwd7GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 23:03:10 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 23:03:10 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "brauner@kernel.org"
	<brauner@kernel.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "fweimer@redhat.com"
	<fweimer@redhat.com>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "kees@kernel.org"
	<kees@kernel.org>, "will@kernel.org" <will@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "jannh@google.com" <jannh@google.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "yury.khrustalev@arm.com"
	<yury.khrustalev@arm.com>, "bp@alien8.de" <bp@alien8.de>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"bsegall@google.com" <bsegall@google.com>, "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Thread-Index: AQHa8m26gF70aSw9iE+4TuW+hH2kDLIwrUEAgAAg74CAAAZZAIAABi0AgAAX+ICAALiNgIAANM8AgAAYugCAOZcagIAAbUIAgAZGuACAACdJAIAAXC2A
Date: Tue, 1 Oct 2024 23:03:10 +0000
Message-ID: <0999160fd5282ac129aab300b667af35d7251582.camel@intel.com>
References: <cc2e7d86-c890-4cb1-8cad-1cfaa9f53dc8@sirena.org.uk>
	 <82be9ec6e43a018add8d9bbc6ba67feee676f32e.camel@intel.com>
	 <5643761f-cc38-4e41-9ddd-f0a1934f8724@sirena.org.uk>
	 <9f022aa4cd3e2dc82d0c963e9d2bf5c7ddd5b92a.camel@intel.com>
	 <77bc051d-b2c9-4e3a-b956-be8879048e20@sirena.org.uk>
	 <5464b915b52bf3b91ec70201736479a5347838af.camel@intel.com>
	 <158190d9-a4a6-4647-84e8-f4ae036d984b@sirena.org.uk>
	 <20240927-springen-fortpflanzen-34a303373088@brauner>
	 <727524e9109022632250ab0485f5ecc1c1900092.camel@intel.com>
	 <20241001-atheismus-stetig-4f6f3001715c@brauner>
	 <6bf15851-03fe-40cd-b95c-f7e2ca40ac54@sirena.org.uk>
In-Reply-To: <6bf15851-03fe-40cd-b95c-f7e2ca40ac54@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7215:EE_
x-ms-office365-filtering-correlation-id: d2122295-c513-4670-8626-08dce26d3834
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VVZzaUNvWTlmZ2VhWTlUcDRVUkovSEVxNC9JUHBhWm40cEhXZzZENjlPYkJO?=
 =?utf-8?B?QUR1U3ptQm5NS2FicWo2ZTJRTWJJaExsMUFYVm5jWkNTQWhQRU9ZU3BnU0g0?=
 =?utf-8?B?VkM1elZtNFRRZzRReXFZV2IrZGd3VExLdXl6dktkWTFGdkZtZUZ1d2dzUGtw?=
 =?utf-8?B?U002SlltRks5OE9TWUdwZCtYSHJmQitGMmdwYzZaR083Uis0eHRKdGxIR3RR?=
 =?utf-8?B?UmtBS29ORU83WE8rcHFIbnVaWUFraFFpUTk5V2N2WUhDSzhRb3oyM1pSeHUx?=
 =?utf-8?B?V3ZzQ0V1VUw0WlVReGd3UEd4dUZRNzgzSEFPL0ROVjdRTnFiVEI4WThtcXFM?=
 =?utf-8?B?TkdCc0Q0aGt4UVRsRDlid2FIeERhaGllaFBUZ2JuZzhJcDhKbVBiZDc4MEE4?=
 =?utf-8?B?T2dsa20rWjhaVXBLUWR0Ty9CWFpmSVZKeitpU3NscU1lL2hTR1Y3RmtvYnNj?=
 =?utf-8?B?T1llZnAzQVBjUWUzYlJ1ODBURkJFV003V0Z4VFdYeUpWZnliOTBaTUlhT0pT?=
 =?utf-8?B?a25zYjVvd3FRN0hDMFJ1cS9Qb0d6aUorM1BJVFpGVGtOTldSN29qNE5UMHgv?=
 =?utf-8?B?c1JDL3NUT0xpamJHR2hRMGVDdHdhVFBudXRGcWZCNGowbzRkOHB0Skk4bW94?=
 =?utf-8?B?VmdOVzdMOTQrdGNEb0J6N1YrNDBRVHhNelpuL1hJbFo0dWN0ZUVoNEkrUDE4?=
 =?utf-8?B?OHpiMXkxU1FhRFVQMzdBL0JUVzFUbDdtS2FuOEdMYzdHRmZoMTMxMHcyZ09i?=
 =?utf-8?B?L3JYMWlzYW1UV2E2bGovOEFBOVFURG5SV3lTYVRPTFNiaHJHaUJqOFlFTUox?=
 =?utf-8?B?cEp6M1g3SUhBWEdaWFhPTDQ3ZHdUMHgwUWdqaDZ3TjY3ejdQV3lzVm1sMUVn?=
 =?utf-8?B?VnltMDZUVzRqKzRtSVFVZzhqVzVycFRnS21tK0g2NUs1UGlMOWU0bnBJU2JG?=
 =?utf-8?B?cUpOWk8wUUo4cndTVEQ3TlBDdjVPTSs0bXdCRVBBa1lpOGJobHF1WCtOVlFj?=
 =?utf-8?B?MDhuS0VEQ2JUUnRiN3ZxQlJXSUZRc0xsWDBXWjdjUVRXdTRIVi9aYkFZQk1r?=
 =?utf-8?B?TmJwQkMyd25kRUxIRVZHOHd6cnVTK1owa2hGaVhtejJFR3JsTlhRSWZTSGYw?=
 =?utf-8?B?K3hLSFBIWjNKMm0xOE9wUlUyTzVNWFlQa2N2RnpYbWtzRXI5VmtNa0RLWVc4?=
 =?utf-8?B?L1M4YXdTTDBwYnltQ3cwY0dhWmh4RnkvaXRzNEZjY3Y5NXN3cG9jMU5JQVdo?=
 =?utf-8?B?cmZndUxjS2xWV1pZZEthOW9Rb081aGVFZHhxM3JQUUZOaFJ5ZUNNcTZXWllo?=
 =?utf-8?B?VWVmV2JYbHUvL0tyUFdhbWtScGZIZ3FUMnVHeHdaN2ZNY0UrS1htVXNLVGRy?=
 =?utf-8?B?NmRRYnoxUTh1ekNxNHFNR0prMHB2cldPZkczQ0Q3eVNwdWFaMVlOUWxxck0w?=
 =?utf-8?B?S1RLMkxFTkFibmpaL1N6SXE0bjV4T1FET2MxRGdXNU1HNVc4QTFJZk93QmZL?=
 =?utf-8?B?U3dMcW5PQzlHS3ZLOUt3SEp0RXM3SkJ5UDkxckFvODJWNSsxZnp3WThWMDhn?=
 =?utf-8?B?UVo2dElkeGRwV2QzYWE0ejBBVHZXcnUzakcweTNJRHM2TUhIa0RIMWFtaHpZ?=
 =?utf-8?B?Ykx3MlVzdmt5SWNkTEIrU210ZEFaY3hBSGZPYk5hdFBZLytSbXZmMEhSa3lm?=
 =?utf-8?B?UWQ2RmRSNXJBZTh3dk5BT0VKQzZNWUt1UkxKelBoUkJBM2VVQ3hOZS9ObnFs?=
 =?utf-8?B?amFoS1N3SEVZODlNK05sRFZ4MllXaUVZM2JqZDREVDZKdTR2OGFvZ0FsU1kr?=
 =?utf-8?B?dmVqYSsxbzRKVTBIUkZBQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2NEL1k5K2VIVEpkdGJJWnQvQXJBR0l5ek5zaENXKytscFhHWUdLQlQ3M3R0?=
 =?utf-8?B?bENQNlNLZzFUUlJrbEpENzhscnBOSWtMcEpSME9wRHRSYnhRNG9Sdmo5ZkZv?=
 =?utf-8?B?UmtubjB0ZGNwam9oeGZUZFd2ZWoxT1FqazF0UzBCM1daUHBFczlabzdXamtn?=
 =?utf-8?B?ajRBalJDL200RWVIdDBUNnhJVG14UXBmbnFHZFJxRVc4Qy9laVlTcWJmbW5R?=
 =?utf-8?B?WTUwNitnWHF4VUxRRUlKWkhTVkRCRnFUOEhiUnFMM1JnZWUvL0VvNlZycDIw?=
 =?utf-8?B?N2dGQzh3MkFWQjVkZjhuazV5U0F4T3RCNnRUMnZIbkh3b1p5alBzdlZQQTha?=
 =?utf-8?B?V1JPK3grRjJMQ2VCZHArMm9Wd2Rjc1k3Si9hWjdmRWtLcE5zMXcrOTc2UmVw?=
 =?utf-8?B?bjlJNHYzTGxxcytYaytJUlpVMkNtZ3hGbXQ5bFJ4VE1VWTIrSEg4MDAwYk5k?=
 =?utf-8?B?UE5OSThxKzJuOFdDaWJhdjF5ZmV1TTdJTC93MTVORVgySHVTR1lYNEpVamE2?=
 =?utf-8?B?dGYyWWlCdlVhOStTVHZvMndvR0RESm1NSldEcmhza3A0VHhxVUo5ZTFvcWdQ?=
 =?utf-8?B?SW1HakxtN0pzdzNIUWJRL3hBaVE4VkZPb3RTYnhpWlVZYVFCeERiT0hPcFlD?=
 =?utf-8?B?Q2d1WCtNTXJLbnFpTWJ6SnJLNytkVWhhTUpFd0x0MU1ya2xKejlYNUY0dmt4?=
 =?utf-8?B?UVpCN3I4ODI1UXVZMzBPOVlPVUtCTHlHdXgyZ2EwYVVoZGMyZEZ2NlFQM1JN?=
 =?utf-8?B?OXRGdHVSTnM4NXk5Y3RHR1NERkpxaUFvL1lYT1NUUkQ2Qi9OTzNlSkdod0tv?=
 =?utf-8?B?OXU1dzlISTRjVUhwRDl1Unpsb2g4dm9hdmJwa2k4VDRTa0xacll6UkZsK3Y2?=
 =?utf-8?B?MnA4bmUxak9sMDllbkJmT2UvSUhwL2w4VXcwV1UwQVRDT2lTbmFFOUN6V243?=
 =?utf-8?B?MmQ2a1N3UnQ4T2F5MlV4T1hWSk0zM043TU1TZGF2S0QxZ0tHbys1cmd0M1Zt?=
 =?utf-8?B?SzJpb3pGeHkyQ1BKWEpOeHZHVWJHR1VYZmM4YmR6QmNTUnNyTDQvRGlLbWxC?=
 =?utf-8?B?OFFhWlJJb3ArUUo0dUFuY2I1YThmWThtN1lOMDU0MW9OTnVMQm8rZVUyOC9L?=
 =?utf-8?B?a1dDNk02cU1KRkNhVzlxSERTdjNkclMzZGhQL3VoejJITDdGMzVNTEZEMnpB?=
 =?utf-8?B?SGZEYUNUeldRK1JPMkJOTlk3Y0tJaDFEd3k2ZXVOVllqQk9SczJOQjB3cXZV?=
 =?utf-8?B?Qy9PbDZWSTB0SFZ1MjZMaHFPTUljTlgvZTJ5OUZ5ZXRpY1V4VS83OVZ5dFVO?=
 =?utf-8?B?RGQ4STI1U1BQQVhDK291czR3bnJWaEs2SzhURWkrbitXUFczbkNXdnFqbU1X?=
 =?utf-8?B?VFJWRFZVZlQ4WnZpQUtidDhHUlBHeitLVkZJYStvQ0JEQm5vZ2dUUkM0SUx6?=
 =?utf-8?B?SFd1aEtUSWF3REdsQXhKVXZkT3NKUXZRUlNGSnplbkw0b2xIcWJFdUp4T1gy?=
 =?utf-8?B?NjhQWEhpVmI1VUtJQVN6ZTZNVUU5RWhHUlptRkt6VTM1NVhuU0t5Mi9TV1V6?=
 =?utf-8?B?YUpTendweklwYTR2L3MwbXhtSFRmRWVIL29KdkxrYWtKbklhZ2RYRSsvbDcx?=
 =?utf-8?B?akJNeXYxMk92N0pvSTdwN0tCOGJFUStiK3lYNWh1eHVxU1A5dUdEOHl4L2hM?=
 =?utf-8?B?Wjk1RXJxaDBvNyt1YncxUGxZZXc4TWc2ektyYUNBWWIwS20xbWtGWnhUUC9F?=
 =?utf-8?B?eVNZWUlVVmtjWm5oK3NLaTdQS24vd0tkRlV3M0JHRlIzQjVOWjZEUDMxQXRC?=
 =?utf-8?B?NnI5azRINGJhQ2NqZTE4eDZxbUxUSVRpT1F4Zlh6ZzAvWGFST1JPV0tEVXRa?=
 =?utf-8?B?c2JwSDJweGdnMkY4b3dXVTg4Sjl4YU4zend2T3VvSTFLc3Nablp2K21TaUxW?=
 =?utf-8?B?NlJ4Z1N3WUFtNDZDbFBtYm12R21hZytJWUtGWmdPVXNJK081Z2tOKzQxbXNV?=
 =?utf-8?B?c3ZjMGNPNVRqeEZiOHdqQWNLUWI2SGF0eDZNY3E2Q2ZIU2R6LzVUQXl3YnBO?=
 =?utf-8?B?cCt2VUlybWprRGRRZC8xTlgvNVBtMzd6VmFqSGtmdmpySVp4UElmQmZCSkh1?=
 =?utf-8?B?WXAvMmlnOFJZdDhpWUlSbU5qdUNvSHBIamxteUhrajgycE1jWGJ3cVVZbWxQ?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2E641ADEB678F40B1DD0D0C2A2E3882@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2122295-c513-4670-8626-08dce26d3834
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 23:03:10.1669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aUdivJ59Y836FKdLAKIo0YsJ0xr3DETwN9yn/KZcUyFoCGHKVf2mOWS+xX1p9scPsFUiiWvavwj2yAv64FRq0MCkygdkuq6b98I2uMT0MU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7215
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTEwLTAxIGF0IDE4OjMzICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+
ID4gQSBzaGFkb3cgc3RhY2sgc2l6ZSBpcyBtb3JlIHN5bW1ldHJpYyBvbiB0aGUgc3VyZmFjZSwg
YnV0IEknbSBub3Qgc3VyZSBpdA0KPiA+ID4gd2lsbA0KPiA+ID4gYmUgZWFzaWVyIGZvciB1c2Vy
c3BhY2UgdG8gaGFuZGxlLiBTbyBJIHRoaW5rIHdlIHNob3VsZCBqdXN0IGhhdmUgYQ0KPiA+ID4g
cG9pbnRlciB0bw0KPiA+ID4gdGhlIHRva2VuLiBCdXQgaXQgd2lsbCBiZSBhIHVzYWJsZSBpbXBs
ZW1lbnRhdGlvbiBlaXRoZXIgd2F5Lg0KPiANCj4gTXkgc3VzcGljaW9uIHdvdWxkIGJlIHRoYXQg
aWYgd2UncmUgZG9pbmcgdGhlIHBpdm90IHRvIGEgcHJldmlvdXNseSB1c2VkDQo+IHNoYWRvdyBz
dGFjayB3ZSdkIGFsc28gYmUgcGl2b3RpbmcgdGhlIHJlZ3VsYXIgc3RhY2sgYWxvbmcgd2l0aCBp
dCB3aGljaA0KPiB3b3VsZCBmYWNlIHNpbWlsYXIgaXNzdWVzIHdpdGggaGF2aW5nIGFuIHVudXN1
YWwgbWV0aG9kIGZvciBzcGVjaWZ5aW5nDQo+IHRoZSBzdGFjayB0b3Agc28gSSBkb24ndCBrbm93
IGhvdyBtdWNoIHdlJ3JlIHJlYWxseSB3aW5uaW5nLg0KDQpJJ20gbm90IHNvIHN1cmUuIFRoZSB0
aGluZyBpcyBhIHJlZ3VsYXIgc3RhY2sgY2FuIGJlIHJlLXVzZWQgaW4gZnVsbCAtIGp1c3Qgc2V0
DQp0aGUgUlNQIHRvIHRoZSBlbmQgYW5kIHRha2UgYWR2YW50YWdlIG9mIHRoZSB3aG9sZSBzdGFj
ay4gQSBzaGFkb3cgc3RhY2sgY2FuDQpvbmx5IGJlIHVzZWQgd2hlcmUgdGhlcmUgaXMgYSB0b2tl
bi4NCg0KPiDCoCBMaWtlIHdlDQo+IGJvdGgga2VlcCBzYXlpbmcgZWl0aGVyIG9mIHRoZSBpbnRl
cmZhY2VzIHdvcmtzIHRob3VnaCwgaXQncyBqdXN0IGENCj4gdGFzdGUgcXVlc3Rpb24gd2l0aCBi
b3RoIGhhdmluZyBkb3duc2lkZXMuDQoNCkZhaXIgZW5vdWdoLg0K

