Return-Path: <linux-kselftest+bounces-13682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BA092FE4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 18:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6421F239AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717C51741F0;
	Fri, 12 Jul 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtwIUwHu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75E16F8F5;
	Fri, 12 Jul 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800966; cv=fail; b=lMt2cHRB8MQQ6QphHEydJofhc6/hl06WGxMyQgaEfln/GjBXI8lwcSFu+MepuppETlSKktVbGrIZ8CArqoXnpyAsj8NlkW5bMwX4jUw9/1vA3zcCgWWtcY8p2+1KWo9Ys/XpEyhqaGB7oo5XGPbXbZBGTM4o4ShmN6EDYZXdVLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800966; c=relaxed/simple;
	bh=i68Nkwtv8oWkDVmjxST3D+2KrZ+oRRw4NBVs3zrSMjI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLFCHV/gsNGHC2fYN8XXfOgdDEWKZGkNU4fj2xux+xa833O58QNqi9sCF47kzZ1gvEC7rsyiD3HUFLiJJ1Xsu+RgIT56CEZTF0A/qBGN8IPhjbH/C2kwY8lyvI+c4uYpOcys5yN/Cor+jhHNKN5vV+dijX+MhLoIE/9KaLflzIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtwIUwHu; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720800965; x=1752336965;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i68Nkwtv8oWkDVmjxST3D+2KrZ+oRRw4NBVs3zrSMjI=;
  b=OtwIUwHuDxHKn1SuPZdippAVZ3N9RfcQ5rIe7nhdDuAqYlFmn0E9F+Ml
   Bh7Q68SYvo8NxmRe4OPliFh2aUNOb9elAMe+js5aIWCH39Yfdl80wl7/g
   /eTFq9WIPVYJjQr1dQJrfgiPCGadv3Uet9GgxykPv/eWFY/45pIxRoBHX
   ICPaP7dfsZGy6rY30OABfEi6ca0tCH2Lv07ju9w/CGF1Mqv5C8kV7qnVw
   z8DVjFHKjntBj+9rtRivEH9WbshOCLiMxzEAW0siYt+bNnDdgXiM+mF1l
   YgE4fZcP3EfZcHoy13ukQI2vLE/oBN8TnIti8PGAvIlUOlZ4ZWK8Xu12A
   w==;
X-CSE-ConnectionGUID: Syphrx2+QbqZrH/22fhkpg==
X-CSE-MsgGUID: fzxXnvCpR3qd6k0SvDmCxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="18399813"
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="18399813"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 09:15:53 -0700
X-CSE-ConnectionGUID: 0OQg6WWzQpC7aJrz77GeMQ==
X-CSE-MsgGUID: nO2UbFhLTzuy10uNQJeIzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="79655384"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 09:15:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 09:15:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 09:15:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 09:15:52 -0700
Received: from outbound.mail.protection.outlook.com (104.47.57.169) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 09:15:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnqBjuB03CDSvRvWBXVhDht5lDf609mKU0oEHOO981UoDuyI6RsZJa5pWt6e+ZdL0xrsUgp0QK25SZs5mPpMVQlc4PJBU7eV8Nf/s0uifpX/dbHs9eFGxa4LGPkOkDyLReSbK7/JA5gLr+NgUL8pDuDdS8uo8Wk+XiGjauqxOMzg8c/Stw/GHhlemQgG7qDcjOBX6rY6hA1cy2yKYESBs4AtZ1WBUZPX2P9OBKcoIL+ZqPULayApPhagkC1JfemrQPZiGtQdBjx3QN6Wn5lwpuIySdXkTs1EyNXIU5mJ19f7kD2pLtjuXvOarpySoB+wTP42OX4Y+faZ5SHMEFH1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuNPXAElQWN9VlWtTYR8KnkgFWSIiehi1sfIJZG4KsA=;
 b=BUL7fJyhWyMxzj1RZOshC+Cwb41PJm3Wl2otlVn1qRN8t9+UKAIYe6UE2dzPvmIidOryt4ZE149m7EY/ENAma90VQvbKuXKxyKHIHITk9QB/csqRKFHThXxaB4VEKOBI+2Fw4kauuUYy2ikgs17dxE2lPBV6hw7/P4vd/fct2L9S+JkrIrpFk6xrWV6yS722cLmFqvTWuKtK6gBiXYXS9i3T8Xywo0bjbCEnrENCnVZptd7hxMBAQrkjojkKnPfGrXxqg5/7P9WoljRnzwo3/O7oq0VierY4408tLOvey5ZzzoN15cnTjBahaAKDlq1IQSm1HdULHwTvvZDekhb/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by MN2PR11MB4614.namprd11.prod.outlook.com (2603:10b6:208:268::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 16:15:08 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c%4]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 16:15:07 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: RE: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and
 guest
Thread-Topic: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and
 guest
Thread-Index: AQHaWe/p8mDo/Zfb1Ue0O++EkKDe07HFceqAgCsrPICAA4rmgIAADUkw
Date: Fri, 12 Jul 2024 16:15:07 +0000
Message-ID: <SA1PR11MB67341A4D3E4D11DAE8AF6D2EA8A62@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-10-xin3.li@intel.com> <ZmoYvcbFBPJ5ARma@google.com>
 <SA1PR11MB67348BD07CCCF8D52FCAC8FEA8A42@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZpFH86n_YY5ModwK@google.com>
In-Reply-To: <ZpFH86n_YY5ModwK@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|MN2PR11MB4614:EE_
x-ms-office365-filtering-correlation-id: 21de68a6-6014-4971-8197-08dca28dcbe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wJgF46jCuT9NLSv/xMObNdwXrJFdXYd/1t3WlCfR7iBHhXvewfjBivuA7cY2?=
 =?us-ascii?Q?/2VIv+4cmXt98BfHBW9LL8gy55soLOR6KnZVNnflDDZ6knTuHR9F5HWnEUyi?=
 =?us-ascii?Q?ea3yVAY2GgqmThGwcponft5hRC5SwNsdABcwY8OxxD1pYP1ZpK4PucNw6cMP?=
 =?us-ascii?Q?XQT/9V3CmagN8u+jYlVLzYMjCTjcDBCr20Kfu5ZQOhFiWPLitki5NRXxJLSs?=
 =?us-ascii?Q?wpBNV7qGCsFieh2+NrxKcST1svq8R3mbBoMZr4hGLuijzAYtz2h8EGjosIxE?=
 =?us-ascii?Q?lEVenrCp3PiL09wuk2G8294XBPkJssOqI0R/Zx5t3sNLmhg+7nAcG1yv+AcL?=
 =?us-ascii?Q?30dOvxeBJ6mRuG9zWxRJh3Or2uBm86lYoOKybJT+4NaqwrZzZL8yfe+gnCGd?=
 =?us-ascii?Q?8qDct16+w/ADoSUfKZN5xBHF2C+2Q3H9DHP+yeQMVOHHxoJWcaZQt4NqVDZX?=
 =?us-ascii?Q?CncEcTeyYpZPkbdBI9IA+RiFm8q1aBfZRO6/orVPNCDUNPEtfCv2aHIbDOOm?=
 =?us-ascii?Q?tSBfzpoSQV63YUljZWtCl0Hd9mJ0nVVTUV1+SChpb7t8VA7SmtK/MN+DsrVX?=
 =?us-ascii?Q?OdImScUuy4HjPL3qLj8YKMnKd9pub/hUT+ky0Ld6Vpe8Rrj5vWFpx4yztOMG?=
 =?us-ascii?Q?MznyLe5xpqbEoho/4M76spuprcc/L8Ukp5r+AhQtIPqB9GGXAuXx4kOfmf1a?=
 =?us-ascii?Q?8niZbGHiMKVmo0GOhOd2uLFk2anuCcyDTEb0bc8+zOR1qud8f0cIcYyrZYyX?=
 =?us-ascii?Q?nDPslrBl/SNr7Cip16pVF96HQWAt8Xkon1f6LZlkD3YMpmWtFdmHLNyDgMLD?=
 =?us-ascii?Q?UGlAeVYpYYfsNpUquKM+SYWa51hN4fBHz54UOfouYmY2x4ENDzpngQ9kuu2J?=
 =?us-ascii?Q?XdF6FKV97VYTTADcxoK8xZOG+EXF8HR0PbSA/4P2zEUS+8MkW8pK/EoNB0ZY?=
 =?us-ascii?Q?bVgiPcyWxO07WxYqbrVnVmZ2X8QdK4q3MVowAqWju9e5K+uDTAorGTmgj4Zg?=
 =?us-ascii?Q?1qXGe2hO2ThWZeRXRX5a7isoNugka5oQPz9elTrjQRornrRpNfx5Q5IsGLmX?=
 =?us-ascii?Q?QdWflKTkQnoOmtYPeMsTCSckkz5dtStc8cDZ1HJNfsuVkdD9KfI1qItWuIU3?=
 =?us-ascii?Q?TLv2N7UclKlAi5ydIPg5KW2wAW60XjgLJPb65cTJINO/9jFkWt/xFu2zDr8t?=
 =?us-ascii?Q?HYHKuT/UXiekVLDEWJXZRXgGK8J16XtvL5z2OqGT5i8xKxd2kQdnWFq3TXB9?=
 =?us-ascii?Q?hENOF95ZhWSerUWOFFsKdUzneBdIrAr9yqZSv5CzuU4t3imVFnpmg3N+lo+H?=
 =?us-ascii?Q?ZAriX9y+mjuwfbbzEfHq4E9jmztuGsLCBTgNqq822SS5vC2/17tE/NYkv4MX?=
 =?us-ascii?Q?cKfJ1ldvBQj4Xrmi0QO5URkxLumVK8Y74LWuYGbt8tlwQMC5jQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aFr6pL00Hy6BMlF7kych2N8pu8IMZp6e6Gs0DhsQ6ln+ObFW2j+pQg4QZfMg?=
 =?us-ascii?Q?/DESFX+4zSTYRpfBC5fP5xfVdrfOG+EJdU+LOhr/sUBJaRwmwPxNUMSYxes4?=
 =?us-ascii?Q?okQkMEW59TqkbWoPVgX9iNiLNCFoKPKn+ZJuNOyRUOJ1pMbt7x1/aY5dxA6q?=
 =?us-ascii?Q?uFcYfNeL3D3lUNFdtl/B1IavkssxdT7npqO6ZuMK7iBVgcZWRvWxMXSc5ktL?=
 =?us-ascii?Q?bZ/vswl+m/8WxNf2IAldz5/dnkSJVXJUZyQf324rC6v/JBuCjlMV5iwaFy4j?=
 =?us-ascii?Q?/X0/kTgLiFFgNOXfH2uW7ADEjY5EKOP6ts/MF7HWOHj2c3eYeHUShpw6Hr5d?=
 =?us-ascii?Q?RObjRimRR495taixIiEqXRGIqw7bDCuZtTtlAQbyBYwVgBHdSFxIZgluWhOc?=
 =?us-ascii?Q?hUA6kWVmU7SQ48VvWZAdRouZQVaqH02tPLKrO3CU4WFaBHyy2kWEWfxzJmTd?=
 =?us-ascii?Q?TdHOi9z7rf4hZ95j14a4fKDjCTeAwuphj/CF4YqJVsIsVKrmN9PATmU9Upo9?=
 =?us-ascii?Q?bNcPHhZw4IQnH53kE/PiWJNNiMRazL/GG42RaeNpUviKr2cahluKh6yFqjpr?=
 =?us-ascii?Q?Ct/T+RTDKDWQWX6jyFJFlP+GUVlF4Np7hodJm7tUeBNN9fLOocDgQ6ufr88Q?=
 =?us-ascii?Q?zJ/4K8WdgDOl087dDuWonTRKo1oTNM4zmJKgrVruj5lj3ZDCWNQSd+liGPp/?=
 =?us-ascii?Q?0C/1Y/4YSylETpKYQiHcHKJRikrzeSLJfdx9y5QjAoCpM3r8KTGZx98ivhlP?=
 =?us-ascii?Q?But/XmGeWhiTPD3OisFr0qEoXGFR8qHQkUb8rDlwneNXe5QNw8CQQZYYVA90?=
 =?us-ascii?Q?6T9qHiQLS4JpvIUVBoW6k+tO4myrYy55XEA9iXRhtpQ9DvAiwTXDr2Kafb6I?=
 =?us-ascii?Q?8w3iXr3HUpQiq8xTH2RoNyEaTNse248RzAqbqZFqx+MbU7Rx2omGTTqy7pFb?=
 =?us-ascii?Q?HXJSRbvdgH2znPpxyP/foDoq2TYQp7ExvGBUPRMVBQD6oHFURBHvzc7WGJVP?=
 =?us-ascii?Q?eHgqoR9WBVrpn/t0azqTt4iPrdpKqNt38q8y8m2xf0GIsGWHa8uz8JizWCP6?=
 =?us-ascii?Q?BDgn9eVfgQ8yEh1MdzZ1lHI5titzg4VpyP0+e4g+8Xq4awSyuq8/ZK/AridP?=
 =?us-ascii?Q?yandpUj9np8nLoGKfXoCfT9W+LZTpv4ooaR/+knhqi4tU2Qg3xiFGpHq8wEa?=
 =?us-ascii?Q?RLBBwcQJABAVmrfEkSzlvaV/YdkTrKTX4qz/X4F02zOop8He2ha3o5sn4rl5?=
 =?us-ascii?Q?ocYHUECz6h1MrAi1i+nY/kiaJF3L48YSrVcfKXLrDnSBa2rDarw2nlcochBo?=
 =?us-ascii?Q?bvM0CZgkSq/lUbfnDjUhyFNA1oR8WliBEB2Xg2LdI8xr7I9ahjqFGjbWBe8/?=
 =?us-ascii?Q?wFsYMus0Vt92LEM42jQ5XeI+mdPQ+mPPTyHdP93us1/a7zUmTueTd59552bS?=
 =?us-ascii?Q?4ZXB1xCVYEnoqfaQiji9hNpBxr7chI8gFFRoCL90FJrwhSDJLlMOmMTZoecP?=
 =?us-ascii?Q?uW/4Tz9nHQX60+HKCA28TkGFXoi3+zqUq5hVUOiqLncAnQIvhULVs0cckyMx?=
 =?us-ascii?Q?lKVChyDwHZc+1GClXFc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21de68a6-6014-4971-8197-08dca28dcbe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 16:15:07.3922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfo23wb4Y+ekiduq1o5ksDc1jY9AEaAleKFPVSxedER+8UeuLgnwqGBT6veKlJ/tw60BXcYIv88cWDWHiiM8PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4614
X-OriginatorOrg: intel.com

> > > > Switch MSR_IA32_FRED_RSP0 between host and guest in
> > > > vmx_prepare_switch_to_{host,guest}().
> > > >
> > > > MSR_IA32_FRED_RSP0 is used during ring 3 event delivery only, thus
> > > > KVM, running on ring 0, can run safely with guest FRED RSP0, i.e., =
no
> > > > need to switch between host/guest FRED RSP0 during VM entry and exi=
t.
> > > >
> > > > KVM should switch to host FRED RSP0 before returning to user level,
> > > > and switch to guest FRED RSP0 before entering guest mode.
> > >
> > > Heh, if only KVM had a framework that was specifically designed for c=
ontext
> > > switching MSRs on return to userspace.  Translation: please use the
> > > user_return_msr() APIs.
> >
> > IIUC the user return MSR framework works for MSRs that are per CPU
> > constants, but like MSR_KERNEL_GS_BASE, MSR_IA32_FRED_RSP0 is a per
> > *task* constant, thus we can't use it.
>=20
> Ah, in that case, the changelog is very misleading and needs to be fixed.

I probably should've given more details about how FRED RSPs are used:
RSP0 is a bit of special because it's a per task constant pointing to
its kernel stack top, while other RSPs are per CPU constants.

> Alternatively, is the desired RSP0 value tracked anywhere other than the =
MSR?

Yes, It's simply "(unsigned long)task_stack_page(task) + THREAD_SIZE".

> E.g. if it's somewhere in task_struct, then kvm_on_user_return() would re=
store
> the current task's desired RSP0.

So you're suggesting to extend the framework to allow per task constants?

>  Even if we don't get fancy, avoiding the RDMSR
> to get the current task's value would be nice.

TBH, I didn't know RDMSR is NOT a preferred approach.  But it does make
sense because it costs hundreds cycles to read from CR2.

And of course this can be easily changed to
"(unsigned long)task_stack_page(task) + THREAD_SIZE".

