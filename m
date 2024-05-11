Return-Path: <linux-kselftest+bounces-10083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366028C2E64
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 03:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6311C216D1
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 01:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEDCFBF6;
	Sat, 11 May 2024 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNKOhaa0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA7F8F5E;
	Sat, 11 May 2024 01:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715390662; cv=fail; b=SO3aFG2Ac924SM7pwEyRne6RhartqB7a4kCYGBPqdGQLlJEnXHBoHp9q1Aj2VUxkv9dxjZRdDWTksaQRF42j7l0D5KMW5k+6m9lGZS4lihChfQfXp9xrrNBW11vFE3Cdis8s5+2hRgQroU2Ft4V6MW8Spm94ZzM2tps6jWFQNMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715390662; c=relaxed/simple;
	bh=KSIWB4MS4RicdIIZSlGAYAZZoQ+NUScC+TEewIRaPDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T9FFsBhiKzgUEmTxfj6DR77Zt0hUChY83k0uiT0/z8M1leT7zRvIQb51Qm7fzwqrcTS7saXOAYsN+M/mu6XyxDqAvGfnDLjujbVVJeiyXr064Qn0azVif1aSWMaOQBzW51wpnDpYs9/jJcGpFsqsKT339nsVBLrM5wTancMPuVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNKOhaa0; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715390661; x=1746926661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KSIWB4MS4RicdIIZSlGAYAZZoQ+NUScC+TEewIRaPDY=;
  b=HNKOhaa0ds4k/8vxv6zD4AAVaZ6khXPoPhyL/D+1ORIxbiqXobmcmYDQ
   +1M+9vHkNpN29g0JfhuGOrOz+J8gjUwfpRVFwF4T8CaLeS8+366NMxGpy
   KPaDN9OC2Bix+9YZgNbRoGkafJj+V1T2nM+d+NVvsJzF+O8LOCN03hlPv
   hd51hVxWMt4tDhvfc40lYCWYphJUIBNCobt03Sgm4ZnmWCYofywDDuH96
   i78MFkcyuG5MyvvAEfk6XWoonO0z5Z2FBZ2uvJo750d1m4Oy0HO9Rd3o9
   /E0Xpifg6HXIlq5LfJDcb8sZX8WDP9M4IG+XteatgIx0/n0uT8QRor34w
   g==;
X-CSE-ConnectionGUID: eNUSen/9R62GNImjMSa4Ww==
X-CSE-MsgGUID: ILaSB0X8RO6V9i6wY7XJFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="22066648"
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="22066648"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 18:24:20 -0700
X-CSE-ConnectionGUID: hCYiEumTSYeCVC0nqvP5uQ==
X-CSE-MsgGUID: DPGtEqgUStK1KxKVLBvAOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="30178066"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 18:24:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 18:24:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 18:24:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 18:24:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldcwn/oT/KzXMzyeormdaoOIalEaN6EYgX/sGIkmBCxLjnV+FydKutQIVrrZLWryNR34OdPbJm490BA9pECiZ0oK73BXndvVj7dVfWc7g+dgP0r+Px1anXLFOEFDuqFzf6dyUn4d3dHdYV+BaKioUqBQZSFcaHynM0d+vvaOcGmT61+eIR4eD4xfL4oQwKdLa7AYbiXoaSSdB3Grj/aSNcAmdRsMDVWzbhBIvivzXrwZt6b5QswHDe5BOEnHVyxIBcU+S6vP9sFR2/XKhhMz0780OZ9C8fJPXAq5ag8IjSYzEDxdtriqiHuDKD3lm2OsPOUgtbKCHj+ei8IToyovEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSIWB4MS4RicdIIZSlGAYAZZoQ+NUScC+TEewIRaPDY=;
 b=f5eumb6ZRoh+adtjU6M+3dUr88nAD1D7Uv+ZNe5tFqT/XhcmnhHvFDo9UOVbM4o90vDM3fRGrh3R/gsOJF3pGDABPqATUI571L6gCDPGmgtM+SDlxEBbKCyIbS1eA7MzoqGoZVzjy25XtpDoxmKQHDpQ+QWrvVIdb5+lQSNrSv8boEHB2uxF4QCjmmpuRtC6tF3J+Spe8RmLFyfhrBUCu/hQMu10oTu+/5drIo5I1F/p6c/KYxIdWoL4uwbu7D++eq4Cl7iG3/PLzGlX8bz3p6DKToIcapOoJty8VNl03gjK04WWXz/MUxiibKz/osnosADABpwSW+B6yClU3EyG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by BL1PR11MB5318.namprd11.prod.outlook.com (2603:10b6:208:312::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Sat, 11 May
 2024 01:24:12 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c%3]) with mapi id 15.20.7544.048; Sat, 11 May 2024
 01:24:12 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: RE: [PATCH v2 11/25] KVM: x86: Add kvm_is_fred_enabled()
Thread-Topic: [PATCH v2 11/25] KVM: x86: Add kvm_is_fred_enabled()
Thread-Index: AQHaWfAO0doE8sIK3Eq6W5ZDZAAx+7F/aX4AgBE3YdA=
Date: Sat, 11 May 2024 01:24:12 +0000
Message-ID: <SA1PR11MB6734D9EF8C2D9A762CBEBF07A8E02@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-12-xin3.li@intel.com> <Zi9ZSuwQXl8/Ncs/@chao-email>
In-Reply-To: <Zi9ZSuwQXl8/Ncs/@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|BL1PR11MB5318:EE_
x-ms-office365-filtering-correlation-id: f0776827-c9f0-4d2d-6f05-08dc7159107f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?haF3z6s7Pl/fwcI7tdp33HQoUtbixKQIY7kbICnh3VbBEeQ7I776g3Y+7m5s?=
 =?us-ascii?Q?jqqm1m4CJUKIIWbDBnmG/MFZPCj0pIUvPJ5liyVzBHY9B8wiZJVKcwBO+JQq?=
 =?us-ascii?Q?OEuY5Htip+CcA3hjQ6AtcKiJonIDdZflJp5xW11m7M+DfI4XPHknA/NH2JxL?=
 =?us-ascii?Q?mZyKN6GwfXHGeJpX6u7b5wZpJYxq/VVHaJD2QIzDmeiNdZVw0j/O8TVpdg28?=
 =?us-ascii?Q?yVpo45dfnTfIxOesuc4abTjBT/GRZvYb8N7MOLadvxFUb86Y+SameccmKrkK?=
 =?us-ascii?Q?ClHo3/TPNts+FWVR+MW/3fhyc9kNCUh3thLQEM/CBMjIgqUHcMQpIqvq0K3f?=
 =?us-ascii?Q?mmt1O7KaPLAqOdAqTParUIjl6EierKGD6wPMVssDZFDHhqurZISd3wwmJKHO?=
 =?us-ascii?Q?ZLCkepDanoAcB/4j4RUMVbcz1jKf6uHpRCX1r5iCcjbsRKBoGXKThfaBsyIz?=
 =?us-ascii?Q?WtGW+AgXeWDro+kPP72gWbSSRpKZEV/inUUpacC0GRiDEoNK3bZEjROHfJ/E?=
 =?us-ascii?Q?nQNE74bJmYHNWQc6/6g9Xm3/TyLwhoBAVxh9CD2a6eM4t4Ev73XJC6MMQwiU?=
 =?us-ascii?Q?8SiBpFWcQSksLYzLUUNrTkI6pHetBHiRxUDYO4M2vuSTPciY641UfWUZe42j?=
 =?us-ascii?Q?z0M9rlri+wDc4MhtPAB5NRW75oalBs9eryaBg2aGQQGi7i1/DNRqITY85JJk?=
 =?us-ascii?Q?FJBW78ajZiAgQFLjxHYeZRpQGKQm38zKoVvQL/FbyqDo4Fjn627QE6vq0XmH?=
 =?us-ascii?Q?n94xgPc604K+hoKT/9ZHOWTduW69bQVSCqL41zFqDp0q6dGFecmoyP1wxL4Y?=
 =?us-ascii?Q?PGhFc9lrG3R91DnbzLnkP9jQuQW5qkA7CD4a9bmzjNi25XgQn9ccjhISlbyZ?=
 =?us-ascii?Q?AhTMpIW4XbD0sxtTzDh1YMAet+boU+ZqWUAdjoc64VY6GT4RfXgB/5YhktCU?=
 =?us-ascii?Q?kATaRLFUvghHFgz9xdN+jLbgKkFZInPm+aRRM5NP13mykuOa7fXbwCQNu8nD?=
 =?us-ascii?Q?AgSJdZB1XM6kwQWFkdCgJhgH2/iQ5RqIAQ2d9pObV1zgas4/N8r2DVSsB6Tn?=
 =?us-ascii?Q?7ircFdv0l/1CKKDIEAY0+XzHu4fHlLbxMxw3EDnmPFUD8Twv70jP5CAarNP3?=
 =?us-ascii?Q?zKO9AovApEgD108/ySuiGeV0muCgmcQpkf0vp4c56gLSBFZAd8tP1nUxIDNP?=
 =?us-ascii?Q?UWN37CHyhunRXqFEw1XgV3nnekzcVEF9X3izQreiBLcKWOKCsmebtIu7SCCN?=
 =?us-ascii?Q?axvK2DvybCwwvnh5p92LHF4n+8HWWEAIfNkFvllgThDPAmS5Zmh6KKx0KWfF?=
 =?us-ascii?Q?dXXSFASkt00n/Mf+amr3C/u2Bpq57ncvHqh/OzSYjs02oA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5PqEv4r0zFIPapoLn1s+cUNZ34eF5Qm/uB8HV3Q2+BgPmTd5TM0l35qrbays?=
 =?us-ascii?Q?0eCdarpdGam9EpQLopkYSpVeHSPImm0KSxg797MIzVWUhEk1Qda8V17AsZ15?=
 =?us-ascii?Q?pBjpaVGE5GnBsS2PjBvNHYcSyiNfSHLvhZP6IkO4f65joXDQztqPQ1tajD/5?=
 =?us-ascii?Q?Su/xntkkhjUHaCNkNoT1j6j3shTFZBFHCN6v9yJIseQtC61uDXYAgOGzVztl?=
 =?us-ascii?Q?iCytdcc/20yll2cDvlqwsG/DjQOGPh62+2HJq4pCMhkTGdJvc8zeml/GDBhZ?=
 =?us-ascii?Q?JgGSqPOP9luwXbJ22tcUedeRy3je9VZRNh1KllOm/3IaW0T/a7ip3XUb15q7?=
 =?us-ascii?Q?e/f+bnt+1nROD8Y8+ePJclEHBtsmjJwnmZnm6wSV49LPO8H316GJgj1wjYJP?=
 =?us-ascii?Q?0tHZNq9KtiEZvWb263syo3SuxiKmNuMohxVjOzSe13rckMvJ1C+BoD6vEEVy?=
 =?us-ascii?Q?vXIS8FFQ0g0TnUgsF01cCQfFpVmF/wq9+yt0BIIfFzPJgBKn5rDqwoNI6YAS?=
 =?us-ascii?Q?lJ73IScdCf3EfMOKeR68puXa8Txjknlb3qE6j8lLy7/bFelfpTRo6Fn0W5B7?=
 =?us-ascii?Q?mBVyJmpnNXJBG446d8nRC0iXHbAlQfCrQN7Aj2n11oCKIJD+FosMo3YkMtcp?=
 =?us-ascii?Q?lJ9Zkn9ei+ObqX8uziAH1cbaWHCiebIdoYxjoVFsNMlQOJTqjP7V8/BEn8To?=
 =?us-ascii?Q?8ZmWc1ik2JGEaJRDFDPvlMKKZVwuh+Q40hBlHZ4FkiJe0SRnGh9uX4p3gaKo?=
 =?us-ascii?Q?1YGOPfJ7bLm1Zq6VDZlfZcaslACjLk/nyntpE2csqPHEElvSvg81Oh6IIB3z?=
 =?us-ascii?Q?aNyJWoABFhxo4iu+dl0dbo1GjyId6OAxncFfj8isVY05NKydEa4kHwZ2TDvH?=
 =?us-ascii?Q?9KNNOxxyZBlyFrmoxsLJxXaYpFXgpwjCvDaxMS1rTvTDNvsg6rpLjda9i+m8?=
 =?us-ascii?Q?2NFKsWuQTB+660jicK4sGiNz/lqlNJCEQtDi277j4rRcRxF9bU6M38Y6GTGj?=
 =?us-ascii?Q?L1B4ZjbtdVluiIte0ze3y2zEzvjRELZ1iyHr8B+/UKifMh3cjyLKkGMSTtUF?=
 =?us-ascii?Q?gceAH9vy4rn2GD0uHnLfDLExqlHzBPPhVb0qPuQ+aqUChKN7Nv61PoZWeJCp?=
 =?us-ascii?Q?S83usC/IlvUWkUi8dZli6YSCTPUrRFlUhYJX+TnS8s6YymXOxkKUL0afYZbT?=
 =?us-ascii?Q?+3xfGVwhep7IDnAK7Z2TpbpiKVJFG3cshRZI1li8f3NeZoMymGkXgYFn4Wpj?=
 =?us-ascii?Q?tECVB+4eLDykU8wRnDGSvuHpPMVra8umev1kR/KByEt9X44jvxpjmx5Jg3cp?=
 =?us-ascii?Q?U/27hZ+jddRH+eJDeyzDHqJdGy+pE4KgpAOPCSa0XANMLZSj4BCRZiSWRgp2?=
 =?us-ascii?Q?BcDDbxYxIITKqyvgTD2cZ2XMqcohH3Xb9IMMiCJnxN7ux0189gcurMZ4bM2A?=
 =?us-ascii?Q?iEnkMhWx7BspD6oME+/d6skyXfNiZ2SVeRR5I/C06u1zwBPOGXvxMWEy6Amf?=
 =?us-ascii?Q?xhYWclKLFuV9iPQpGjoQ24Z+mdnhBs1Xbqe/6PNyKgOH0zqmW9FT2SaV++/c?=
 =?us-ascii?Q?BHo0jR9EQF0WojL3L+0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0776827-c9f0-4d2d-6f05-08dc7159107f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 01:24:12.2202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IcoLmNgeqj+psq8d7LwqbhRrZZvBb8miFcBhfaj7NIEJokkmnGHd4ZXVNibZvxOAIwpsrQrtlPuq78RjukHxiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5318
X-OriginatorOrg: intel.com

> >+/*
> >+ * It's enough to check just CR4.FRED (X86_CR4_FRED) to tell if
> >+ * a vCPU is running with FRED enabled, because:
> >+ * 1) CR4.FRED can be set to 1 only _after_ IA32_EFER.LMA =3D 1.
> >+ * 2) To leave IA-32e mode, CR4.FRED must be cleared first.
> >+ *
> >+ * More details at FRED Spec 6.0 Section 4.2 Enabling in CR4.
> >+ */
>=20
> I think we can give more context here, e.g.,
>=20
> Although FRED architecture applies to 64-bit mode only, there is no need =
to check if
> the CPU is in 64-bit mode (i.e., IA32_EFER.LMA and CS.L) to tell if FRED =
is enabled
> because CR4.FRED=3D1 implies the CPU is in 64-bit mode.

What is "more context" here?

> Specifically,



