Return-Path: <linux-kselftest+bounces-15868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FF695A223
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72256B27E3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB42C14EC40;
	Wed, 21 Aug 2024 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJFMgFFg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3266E52F6F;
	Wed, 21 Aug 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255696; cv=fail; b=nUWN2aViefxoDuIE+pWK+fX8rV2m9WvbANp5ZbMP7I+VZPGbvvZZRbfKYWVOa6nIKTNJEu0G8q6h4LPF57Nu352AoVzbOch/k9NpjNZpvNtAg2AhQ9OX1YRaoSChzhiVdWq87qumzcPVs7/vgskS94++7/hFSByE7yITU8F1fsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255696; c=relaxed/simple;
	bh=R/Z+mOuv+yZd2BNHnj2MtOkxtJ9d1On28+AtnQGmh3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XoB+6susOsu1PMRc+bvjnk9V2K8d9QYHTM37VwaHHqceCX3pgDAjFc5ExP/O/OimCrvZFkRchR1p7a1fsqCOREgVVrkNX16Ly/hfwizP+LpLDQKmwTKFMiELmZUrK7V2eQXBNIw+FBMJNegJPL+YkHYxLlPfzJGRNZIf885iF/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJFMgFFg; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724255694; x=1755791694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R/Z+mOuv+yZd2BNHnj2MtOkxtJ9d1On28+AtnQGmh3U=;
  b=RJFMgFFgiYgIBPxyBSvQscoFysBAKK5liQA4/m9Hh5MhsFpjfzWK09QN
   TqtKfKaM89b3QfmhNY3vpGIpMdyaC3ETH7cODJbxMqUxqM5xx7idQ2T7h
   gFBcgDfghsfgGcae19gAeVLflocKNkVY1R1MfzGJj9qe4qIYRVJ/G0+qq
   AIKPcfJ7fiVc1kNQ1wsSqQi2btOlnbfLvNzWLx/F5AUOp3AZSBJ4nl1Vg
   70mBmamiWpIdvXl9CYDvNWzzTb+6s8BgR+Z6ZR6002Mu1JV6uhRKkUlMY
   MnNwKcdBFuf+0erT8KmtX+RzSXa4ilf2FxbrX86FS/DdGjj0xQpEWUK8Z
   Q==;
X-CSE-ConnectionGUID: QTXyye8JQoW4h2nOFCuRcA==
X-CSE-MsgGUID: 86H5K2uQRO+1yNZlElTWSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22773467"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22773467"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:54:53 -0700
X-CSE-ConnectionGUID: tvE6/jySRteygxLRRS9DnA==
X-CSE-MsgGUID: wNaeme8QQF+cP/qLSFoJEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61882043"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 08:54:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 08:54:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 08:54:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 08:54:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOaXz1vj3WZTHPrKzvAgicHETIvp2Nc6XVjlx2epWec12LithI8zGaBHywK8hP3a5vPT9dFeKZPftqTYswdkElsl42W5oHdD8gx6IjImmgmSqX37SIQIaLkzsF4E9QnDqUYGInT34OxlQ/rBP5My10OFTLjGAWDdImJw47hjmH+t6YHKij/WI0CqviKsgj8FwZRZCC+sZ/9MuCdC7cPc0jbvL8loROFZTI8vbQ3OUsTTaaexO+bNWz70qfktLFPWZpDkLmeNOEtc30WT6bulcWzLvGftE5y+D+GASXsbHELDrjtQ0AM1mwJyJK/RC2Jf0WRMahg9fzbhOG/AP2vzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/Z+mOuv+yZd2BNHnj2MtOkxtJ9d1On28+AtnQGmh3U=;
 b=MbsPBNOfybGBQ1ZYhKu8cQ4qL/BHizHhNfVdfNkUUjxzc89X5KZzmoQfxkyIgX2Qp1Px0OJhLazd02PGLtcDE275VeSPKfdq+Y6ksutDB++iaLSI1zea85iqnin8vxwNQR7/NmuIpFJz8urqeRg8A5lzYAnlasiDyOcGbUUsFLuLkG8FS8xteD+fep03I9PpzDxCC+VG1euIemoDaZnm5/ZV0rr78V8NYCgK0mJTgJ6gNVTh/Z10m4AxVCsoA9zupiSEfgNBak2VhGtpZc62BnKjAjrzcmj5Ojmmgwwt28dEgmX04Z0HMGWArQr+PdVyjyh8hEmMih5/aL4yClJLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB8291.namprd11.prod.outlook.com (2603:10b6:303:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 15:54:49 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 15:54:49 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"brauner@kernel.org" <brauner@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, "will@kernel.org" <will@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "jannh@google.com" <jannh@google.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "yury.khrustalev@arm.com"
	<yury.khrustalev@arm.com>, "bp@alien8.de" <bp@alien8.de>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "bsegall@google.com" <bsegall@google.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Thread-Index: AQHa8m26gF70aSw9iE+4TuW+hH2kDLIwrUEAgAAg74CAAAZZAIAABi0AgAAX+ICAALiNgIAANM8A
Date: Wed, 21 Aug 2024 15:54:49 +0000
Message-ID: <5464b915b52bf3b91ec70201736479a5347838af.camel@intel.com>
References: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
	 <20240819-clone3-shadow-stack-v9-4-962d74f99464@kernel.org>
	 <dc8328dbaa01ca7443eeb75024752c673904e3a4.camel@intel.com>
	 <cc2e7d86-c890-4cb1-8cad-1cfaa9f53dc8@sirena.org.uk>
	 <82be9ec6e43a018add8d9bbc6ba67feee676f32e.camel@intel.com>
	 <5643761f-cc38-4e41-9ddd-f0a1934f8724@sirena.org.uk>
	 <9f022aa4cd3e2dc82d0c963e9d2bf5c7ddd5b92a.camel@intel.com>
	 <77bc051d-b2c9-4e3a-b956-be8879048e20@sirena.org.uk>
In-Reply-To: <77bc051d-b2c9-4e3a-b956-be8879048e20@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB8291:EE_
x-ms-office365-filtering-correlation-id: 5c7b815e-08da-4bc5-20db-08dcc1f996a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d1J5QTZpRFdCbU1rdHU4NXNoQlBWR01SV0FyZmR3MlBFSTkwV1FybHo5K3F5?=
 =?utf-8?B?c1p2SlFWU2g5QjBmSmU0N3ZZUnViSzFHMzh6OVdEdlQweWJVS1dKZnJrT0hP?=
 =?utf-8?B?cC9saE9pVkdjemdVT1p4aXBDbVNXYXZKUjJqdlFEdlJidUhVUUltL2h5MDdL?=
 =?utf-8?B?WWhtQUNQdjNWRG9ZS1U2clRielJpV2hUQWwzbWRYR1lxYTRsZmI4a3hIVmky?=
 =?utf-8?B?eGt3WXlQWXU0U2piamFCb0ZBYzlvV3pMbDEvUTVOZzNtb1FGU2NBK2pOTmNI?=
 =?utf-8?B?ZzQrR0xxenlia2pYQ2ppT0xxZ2thNjZ2d09vUmJLSmsxVm5iNCtQL2YwL1lS?=
 =?utf-8?B?VExveVdZaWNQYVBpRWJxdXU3ZkUvTHpZb1JpS2FCYW1XSkVZWGUyMXNaZzZC?=
 =?utf-8?B?L0FlOTdVRmJBT3d4VVBQM1BkSHFIL2diT0sremNLV0NFaTNlRVh6ak5UeEJX?=
 =?utf-8?B?M1RhK013TEtSbEl6a3ROUWNQVVNOaVdLeHUreW9icGxPQWVEQlNrNTE3dVpm?=
 =?utf-8?B?bXhFdFFvNDhMWW94R0RwWU9MWlVkaFNYeHhYZFV1TUYrb0dJUi9CMmxGK1hP?=
 =?utf-8?B?OVFzaE1qWllEOGMrcER5dzFGYkh2bUlEZCttZDEwZDJqU1dQTG9oMUpqSHRI?=
 =?utf-8?B?eklIWmdKVEtaK0VKSmw3M3o5UiticHUxQ0l1STE1ZGZNRXVkaER5QWpMMk16?=
 =?utf-8?B?T3A3R2ZISnlYZ0FMaEJUVXR6ZnkvUUVZRjMyLytqZzdkRm5LN3U2eElYUFB1?=
 =?utf-8?B?dkFVb3pSa2crYzkwTlVIRndBbHdoV3F5WEZQeExEaVBHWTVqUGQ5emh6clFN?=
 =?utf-8?B?TnpiWXIxWVB2NjcvV0VnN2V6S0FFeFpPYTFaeFdMREc1WVVNcWp1VUhEeFd3?=
 =?utf-8?B?VGl4OTl1RzhSNk13cGxJQms3TXBZbUZ3Y2JxdmNnT0ptcWNPTzZySFY0ZG9m?=
 =?utf-8?B?cmo5cDhFaC94TlJmS1dXT1JRZjZtOFNQYXBwKy9UZSszbURHRVJCaFI5bEY0?=
 =?utf-8?B?ZlZxaWppV2RGZDJLR3VJV0ZEajZObjBYSFowZ0JUZ0M2VGxVMGZuK1NMdG1D?=
 =?utf-8?B?bkpRYXV5dVlMM1lYYzJkQTBOSHVCaWkxMjlya20vNDE4TjVRa0hKZGhueTh3?=
 =?utf-8?B?TDJ6REc3MFpXV2ZHV0lzT2Q1YTlqQm9wWEUxM0NHNzhjRHVVcDVEYzEyWXAx?=
 =?utf-8?B?Z3J4NXVYdU5WL2xNdW0xODB5OE5CMEZnVjZmYlpZYTFuZHFwbHIzVHkvOUJV?=
 =?utf-8?B?TVRjMlp5amVsRDVOTisxZXhtTjYydWxmcjRLYkJPMm9LSDUrOXhDaHJUdy9Z?=
 =?utf-8?B?eGJSOGUvNDZoWDRybEdSYzlYWG5nSUxVcU1Sa3B3cVBJY0t4RDVLeS9DMGR0?=
 =?utf-8?B?R3FoQW5nZGpYcDJqWnI0YTEvT3F5UitvTm5BYis3YjBoQy9TY2ZpY0pYOEhz?=
 =?utf-8?B?M09Iakl6Q0RrTlBFUW84bnBOOW1pNDl2Vmk2UXBvdCt0YldEKyt4dWluN09H?=
 =?utf-8?B?czdLQXI1MGo2dTlzYzhHY2drK3lmdm5uUTkza29Da2FTWWJtS3h4TFNybzZX?=
 =?utf-8?B?eWhhRnpPZEt4WnVWV0VFWDhmRnc1bmxqa29kblZxbU43a2FIMzZPWVRQZGZD?=
 =?utf-8?B?ejcrUkJkY0kzbFptYUo4clVYU2VnNnlSaXQxUDNrNjMrVWhpQ0M1aDQvM29C?=
 =?utf-8?B?cFhObXh2SEZ4amJtbnF3OVRnWG03c2JqQVpKcCtDbGN5VXAwTExHTVhuR1BC?=
 =?utf-8?B?MW9rWlhMTHZXWTdTeThPbUt5djJpR0JObXlsZkJXWWd2V0YxamdxY0lsSWdT?=
 =?utf-8?B?N1NnYStLVThaRDc3YVZXOEF2YkJURGRRRHpDa2ZpODR1U21PZWhEb21uRWJR?=
 =?utf-8?B?UURSVG44SndQNVhsb2Jpdm1PRkIwaUxjc3Btb1cxT2RCMmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejBOQlZweEM4ZFJ5UHFKeUc4Y1JsTmlWK09RYU05VlJkQTRZUXpnbW56UW43?=
 =?utf-8?B?eDBEb2RHUkhpWm5qRitxaVFtaXMrQlNwTU4wM3ZBL1UwZzNGVmkrQ2VEblQr?=
 =?utf-8?B?ZFQrZmVRaXpnQm9zVExrb210ZStPRTF4QVgyQmtzSzNOWWhldW50Kzk0anFX?=
 =?utf-8?B?OU9PL05janhUTjJlR2tQZkQ5bWRPUzl5cDZkSkRNdXNVYndMcDdCNnY1QkYz?=
 =?utf-8?B?a0VIMUt3emdwL3pQRHVkL0pLSGtoVlZKZ2JXVnluRWVpLy9CZTI4dnVWOTM5?=
 =?utf-8?B?ekdsWnQrSzFQcmpwT0tqOW1ZZDYwZmlHZnRaL1VRcVRkb21GUS9mOWdJLzNn?=
 =?utf-8?B?ZkJWUjlHUjdtRmF5WVl6bitVMVFXZWtIVjhtUjFnUURYZDFPTC85Sll2azBW?=
 =?utf-8?B?YlB6UkoyQ0JCRUl4TFE4dXpkUFd1d1NMQ011ZVNZU2ZCQ3k1ZzJja2dKcjNn?=
 =?utf-8?B?L2gwS3NYR3A4dmtHUlRBQTFVNjlYUit2MUVwdmI5dENUT1JtVWFMaC9nSFlH?=
 =?utf-8?B?VkJKK0NPNEtEWUJjbWwwZHNDVE00WEtLc1dBVkREdG4rREdKNEpSM1hnaTU0?=
 =?utf-8?B?Vk8zNExUQXFnQU1UZThYcUFqMUd3UzBzVndnbjFSVFRZY1JBSkxML3JkMGJa?=
 =?utf-8?B?YXlXNUZVcjlvNE5WZmFXU0RTN052RnpicmwxNFFKZDcyZk5SZUNDSUQ0aUFy?=
 =?utf-8?B?ZDUxTkhEelBaMEhoSll5emxycTNIc1ZPRHRKNHY4UVhzVldOclZRdnhKY0pK?=
 =?utf-8?B?TlJuWk9uMkt1WHVGZGd4R21ZendTRWM5bmhhZHNCR3dNeFVVRGZ2Y2VHdFlI?=
 =?utf-8?B?VUNvUlcvcWJRR3p3V1V0L25KaHgwMkVLY0x0d1YzVGxsbmFoVm5HNGlUSTB6?=
 =?utf-8?B?K0sxcURTL1ZWTVBrbjZmd2VFUU1JTEpBOGhPb1BkVG9KMTBPbU1zQnpSNXFF?=
 =?utf-8?B?aGtDK05XeXpwQ1U0UFBTclZ5RFB4cUJUZHgxcEc1Ry9VVE0wV21jM09VNCtx?=
 =?utf-8?B?ZlVQWmgvRVljUm5VdC94bGhDSUNJcEFoN2QxSWtLSmhuNTBQOHJ5OEpndFJE?=
 =?utf-8?B?OGNtUFlyUEFzS1RYRWdYMW1FWGxHVktpbmlxU0RlV0M5UWljMnM4TGxiOGpm?=
 =?utf-8?B?aFRPRnl6ejhycnhpc3F2c0dUOXc2cEJNL1VMV2dsWmRPRHdxMDhrRXNpU0RF?=
 =?utf-8?B?VVdpSE1xeCtuSXF4ZnAvUmNiWVNUdGFqQzVwK3I2ZEtsZFhXNDhqZnNjVkI3?=
 =?utf-8?B?S1RWR0Eyc2h2VmVWUzl5VTFtVnN5ekcvODN6WlJQbFErU0xVN0wxbStkOW1v?=
 =?utf-8?B?Yi9zRzVWM2NrcDZpbkE4NnZVcHRITEg4ZFhhWk5lNkN3dWZGS2tkYks1RVA0?=
 =?utf-8?B?SmhHdnZoVU00d21tV1ZrZTNZSnhxRTJGNzNUWWp5Q2FvSW8zSk5OQXVpV2tK?=
 =?utf-8?B?TEZYVTNVaDlGd0w0YzNDanY0VlJKQWxZaHVUMWh0VllJblhrWGprREx4cUlx?=
 =?utf-8?B?K05jejc0ejlFQ0J2SEhldCtLZFRvcFFKdFkxMVZTOVJIUzA1NUZ4SGpGYjNs?=
 =?utf-8?B?R2pGWVQ4UGxyUkJlY0phZHpDN2NxNWlTaGs3MWxDNlBVWTBZUVdOcTNQNm9L?=
 =?utf-8?B?cURiaU15bEtMVXp6eGJEbXdQTkhiQ1dtNVhXY2U3U1djMEM2eFVPWkd2QlFH?=
 =?utf-8?B?YkQxcko1MVFrdWFYeHM0R1FTZWNNdDViUmo1YVgyOHJESXRNdW9nMHIzRHdp?=
 =?utf-8?B?QjhhZzJhOHVGYWRjeXZiYmRPUUVTeDVHRnBMYURRNUxISVEzcTh6Qmd3TEpX?=
 =?utf-8?B?Q09FSUZIUnQyRXdOZm95ZXRGczlmaGZ3SlplTmVDT1JRdzMzakNna1E5SUJu?=
 =?utf-8?B?b0pTek9BSUVTTEUvUzROcjdHdjBNUDZ2aTRua0lRK0R3b3ZoQ3o1dlIwWEI3?=
 =?utf-8?B?MkhaVU9kYy85SVl2SmZwTHBscjRYaHBZMUhLcXF5eHg0dEkvUkdrRVZBS3RE?=
 =?utf-8?B?ZklLS29JYzFjVkJqdnZsNzNrUjdCS2hpbndpb25JZVo4NXRQOTZNTmpOVnNE?=
 =?utf-8?B?WnBSbGJROVhxZkQxU2ExbGZuWUxBeDRtRWovS1c4WHZwK0p2bm10WGZnSmlN?=
 =?utf-8?B?Y0lselk4cHlnVHd6WVVpbldrdDdPa3JiL3VVWmlPaHBOemMyWVhYN3N3WHo2?=
 =?utf-8?Q?9UOppcontndnN8cLYUf0RQs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA64B2271990A2449029AD667803F06E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7b815e-08da-4bc5-20db-08dcc1f996a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 15:54:49.7869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MGrzjtJmzBNkZHklGk9heutrSckwWD3mNWanCbvdJPO4RJm8jt0gWZKLbdZi4wJFI3DCchL1UvOyNE8WomDW8k6J/4t8/L7UNLgzaLMliz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8291
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDEzOjQ1ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBXZWQsIEF1ZyAyMSwgMjAyNCBhdCAwMTo0NToxNkFNICswMDAwLCBFZGdlY29tYmUsIFJpY2sg
UCB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjQtMDgtMjEgYXQgMDE6MTkgKzAxMDAsIE1hcmsgQnJv
d24gd3JvdGU6DQo+IA0KPiA+ID4gSSB0aGluayBpdCdzIGdvaW5nIHRvIGJlIHN0cmFuZ2Ugb25l
IHdheSBvciBhbm90aGVyLCBlaXRoZXIgeW91IHNwZWNpZnkNCj4gPiA+IGEgc2l6ZSB0aGF0IHdl
IGRvbid0IGN1cnJlbnRseSByZWFsbHkgdXNlIG9yIHlvdSBoYXZlIHR3byB0aGluZ3MgYm90aA0K
PiA+ID4gY2FsbGVkIHN0YWNrcyB3aGljaCBhcmUgZGVzY3JpYmVkIGRpZmZlcmVudGx5Lg0KPiAN
Cj4gPiBJIHdvdWxkIGd1ZXNzIHVzZXJzIG9mIHJhdyBjbG9uZTMgY2FsbHMgd291bGQgYmUgYWJs
ZSB0byBoYW5kbGUgdGhhdCBraW5kIG9mDQo+ID4gdmFyaWF0aW9uLg0KPiANCj4gT2gsIEknbSBz
dXJlIHBlb3BsZSBjb3VsZCBjb3BlIGVpdGhlciB3YXkgLSBpdCdzIG1vcmUgYSBxdWVzdGlvbiBv
Zg0KPiBjbGFyaXR5IGFuZCBub3QgY2F1c2luZyBwZW9wbGUgZ28gZG8gbmVlZGxlc3MgaW52ZXN0
aWdhdGlvbnMgdG8gdHJ5IHRvDQo+IGZpZ3VyZSBvdXQgd2hhdCdzIGdvaW5nIG9uIHRoYW4gYW55
dGhpbmcgZWxzZS4NCg0KWWVzLCBpdCB3b24ndCBiZSBhIGRpc2FzdGVyIGVpdGhlciB3YXkuDQoN
Cj4gDQo+ID4gSSB3YXMganVzdCB0cnlpbmcgdG8gZmlndXJlIG91dCB3aHkgdGhlcmUgaXMgYm90
aCB0aGUgcG9pbnRlciBhbmQgc2l6ZSBmb3INCj4gPiBub3JtYWwgc3RhY2tzLiBJdCBzZWVtcyB0
aGF0IG9uZSB1c2FnZSBpcyB0aGF0IHlvdSBkb24ndCBoYXZlIHRvIHdvcnJ5IGFib3V0DQo+ID4g
d2hldGhlciB5b3VyIGFyY2gncyBzdGFjayBncm93cyB1cCBvciBkb3duLiBCdXQgb3RoZXJ3aXNl
LCB0aGUgcHJldmlvdXMNCj4gPiBjbG9uZSdzDQo+ID4gZGlkbid0IG5lZWQgdGhlIHNpemUuIEJl
Zm9yZSBjbG9uZTMgdGhlIHN0YWNrIHNpemUgdXNlcnMgc2VlbSB0byBiZSBrZXJuZWwNCj4gPiB0
aHJlYWRzLCBzbyB3aGVuIHRoZXkgdW5pZmllZCB0aGUgaW5mcmFzdHJ1Y3R1cmUgYmVoaW5kIGtl
cm5lbF9jbG9uZV9hcmdzLA0KPiA+IHN0YWNrX3NpemUgd2FzIG5lZWRlZCBmb3IgdGhlIHN0cnVj
dC4gQ291bGQgaXQgYmUgdGhhdCBpdCBqdXN0IGxlYWtlZCB0bw0KPiA+IHVzZXJzcGFjZSBmb3Ig
dGhhdCByZWFzb24/IEkgZG9uJ3Qga25vdywgYnV0IEkgd291bGQgdGhpbmsgYSB0d2VhayB0byBz
dWNoIGENCj4gPiBmdW5kYW1lbnRhbCBzeXNjYWxsIHNob3VsZCBoYXZlIHNvbWUgcHVycG9zZWZ1
bCBkZXNpZ24gYmVoaW5kIGl0Lg0KPiANCj4gSXQncyBlbnRpcmVseSBwb3NzaWJsZSBpdCBqdXN0
IGxlYWtlZC7CoCBNeSBvd24gYXR0ZW1wdHMgdG8gZGlnIHRocm91Z2gNCj4gdGhlIGFyY2hpdmVz
IGhhdmVuJ3QgdHVybmVkIHVwIGFueXRoaW5nIG9uIHRoZSBzdWJqZWN0aSBlaXRoZXIsIGl0IHNl
ZW1zDQo+IHRvIGhhdmUgYmVlbiB0aGVyZSBmcm9tIHRoZSBnZXQgZ28gYW5kIGp1c3QgZ29uZSBp
biB3aXRob3V0IGNvbW1lbnQuDQo+IEVxdWFsbHkgaXQgY291bGQganVzdCBiZSB0aGF0IHBlb3Bs
ZSBmZWx0IHRoYXQgdGhpcyB3YXMgYSBtb3JlIHRhc3RlZnVsDQo+IHdheSBvZiBzcGVjaWZ5aW5n
IHN0YWNrcywgb3IgdGhhdCBzb21lIGZ1dHVyZSB1c2Ugd2FzIGVudmlzaW9uZWQuDQoNCk9rLCB3
ZWxsIEknbSBzdXNwaWNpb3VzLCBidXQgd29uJ3Qgb2JqZWN0IG92ZXIgaXQuIFRoZSByZXN0IHNl
ZW1zIHNldHRsZWQgZnJvbQ0KbXkgc2lkZS4gSSBtYXkgdHJ5IHRvIGF0dHJhY3Qgc29tZSBvdGhl
ciB4ODYgYXR0ZW50aW9uIHRvIHRoYXQgQ01QWENIRyBoZWxwZXIsDQpidXQgb3RoZXJ3aXNlLg0K
DQo+IA0KPiA+ID4gwqAgSSBzdXBwb3NlIHdlIGNvdWxkIGNhbGwNCj4gPiA+IGEgc2luZ2xlIHBh
cmFtZXRlciBzaGFkb3dfc3RhY2tfcG9pbnRlcj/CoCBUaG91Z2ggSSBkbyBub3RlIHRoYXQgYXMg
eW91DQo+ID4gPiBpbmRpY2F0ZWQgd2UndmUgYmVlbiBnb2luZyBmb3Igc29tZSB0aW1lIGFuZCB0
aGlzIGlzIHRoZSBmaXJzdCB0aW1lIGl0DQo+ID4gPiBjYW1lIHVwLi4uDQo+IA0KPiA+IFNvcnJ5
IGZvciB0aGF0LiBJIGxvb2tlZCB0aHJvdWdoIGFsbCB0aGUgb2xkIHRocmVhZHMgZXhwZWN0aW5n
IHRvIGZpbmQNCj4gPiBkaXNjdXNzaW9uLCBidXQgY291bGRuJ3QgZmluZCBhbiBhbnN3ZXIuIElz
IGNsb25lMyBzdXBwb3J0IGEgZGVwZW5kZW5jeSBmb3INCj4gPiBhcm0NCj4gPiBzaGFkb3cgc3Rh
Y2tzPw0KPiANCj4gQ2F0YWxpbiBkaWRuJ3Qgd2FudCB0byBtZXJnZSB0aGUgYXJtNjQgc3VwcG9y
dCB3aXRob3V0IGNsb25lMygpLCBhbmQNCj4gdGhlcmUncyBjb2RlIGRlcGVuZGVuY2llcyBhcyBh
IHJlc3VsdC7CoCBJIGNvdWxkIHVucGljayBpdCBhbmQgcmV2ZXJzZQ0KPiB0aGUgb3JkZXJpbmcg
c28gbG9uZyBhcyB0aGUgYXJtNjQgbWFpbnRhaW5lcnMgYXJlIE9LIHdpdGggdGhhdCBzaW5jZSB0
aGUNCj4gb3ZlcmxhcCBpcyBpbiB0aGUgaW1wbGVtZW50YXRpb24gb2YgY29weV90aHJlYWQoKSBh
bmQgc29tZSBvZiB0aGUNCj4gZGVwZW5kZW5jeSBwYXRjaGVzLg0KDQo=

