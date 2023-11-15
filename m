Return-Path: <linux-kselftest+bounces-122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA937EBB6F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 04:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C3B281377
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 03:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A0564F;
	Wed, 15 Nov 2023 03:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfzJo75e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5268647;
	Wed, 15 Nov 2023 03:04:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A098ADB;
	Tue, 14 Nov 2023 19:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700017455; x=1731553455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UF6n7r4p8ZSKx8eE9PyXcJ44YZ/WKjAIC+Hwn3oZo24=;
  b=dfzJo75eSes1fNEwqVTE0LE55xrKGKNM3KD1IcKV87u9qUBFKBOFsHQ3
   V8h6Ita//NtHtJyPYmN3V5LO49EN6n39vgcLu9woRWUpU6GyhKFUBdA+o
   JNsbmx1BA8t6ESzqrBQuEBmJc08ULxx9YLfAlo9tjK0TWgtDe3CQ+e4AZ
   mJSt6seY4MPXJFPjexdKzEBs4WNBtCrr9v//qO5oFaaVkOjH1OFLvDqrD
   lDP9lzA5zsjhNxWsg9ghHyZwUhOeUcFGNcu698Xp5L6llH8GeQuZW/B+V
   7znAi69Z7PUpILeUEQw3Ul3vRysKOWLdxfGhoObP/WdaDcKAEKxTquMlB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="393658686"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="393658686"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 19:04:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="855504055"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="855504055"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 19:04:14 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 19:04:14 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 19:04:13 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 19:04:13 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 19:04:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/AqejLhRrRHZlMjBUUu6Rsz92m8Im0w6HMASZugbP9GaBuRkjou4ns6ade1uBBbmM0e0UfVyn9dYMjrkw93A6R9AxLDXD3xCtoVg+1fBbHncHJHKcuO2ZE9L0KITb9Wz5AyO2+xEXVuQ5cQue/ANmyW8GgtHMFLgXFAvXL5uTc9B2TBciYyv7X5uKQiIKB5queYXaTVoRUam2sA7AGRCr/VsvB6EhwFJ5MlResUoQszGYYnYGhpFCktqd0HXKeXIa6HpAaMwyuet6ZUk95JgkMbpATmPUQ/tUQZlE/JF4eGX22IWr/PZCWasbvqo8sharNFnb6PlUzoztoRzbP10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjAEvYk31PkDcsZZhK6B0kRMyqOaEbA7xPMWvyEr9L0=;
 b=cE6DUC9WE9uhTV2h4e60tUzDU0CEm5jSTywYy5UcX56k9EuIixlgZYQkP0UaqhP+QLtAdkORrLaC5d/5HT1jRoW7Lukdyd+e+xedWExlM++Hf1rnx4k99ZQXwiiWjjGJtmYk9Wj12MN36//6CA4dmfqsMuNIO47ptTLSizeqPoODy4cqTPHAE9lNchln68wvFAdxjpQdQ/6znAVwWFe8PzABq+vzNTbyde6Zkjjynss2C8tqW/6088IalUT4LNK15yJWWg3+6nTTumTVh/vR6JtXCHRM5QczVklb1fl2/WFGJd1in2AvoWnWFLhDufY4Vaz6UkING6MG0HzPb5NXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by PH8PR11MB6754.namprd11.prod.outlook.com (2603:10b6:510:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 03:04:10 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 03:04:10 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "Cui, Dexuan" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v1 09/23] KVM: VMX: Switch FRED RSP0 between host and
 guest
Thread-Topic: [PATCH v1 09/23] KVM: VMX: Switch FRED RSP0 between host and
 guest
Thread-Index: AQHaEnYNVp8W1/G6UUCgoF/AFks5WLB3o3KAgAGj5fCAADFsAIABQIRQ
Date: Wed, 15 Nov 2023 03:04:10 +0000
Message-ID: <SA1PR11MB6734FF28F69913998F0ED60CA8B1A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-10-xin3.li@intel.com> <ZVGcaxYtabZxGt0s@chao-email>
 <SA1PR11MB67345297BC929DB49B422D2FA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZVMmHNHadleJfkGL@chao-email>
In-Reply-To: <ZVMmHNHadleJfkGL@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|PH8PR11MB6754:EE_
x-ms-office365-filtering-correlation-id: f3048a25-bc65-41c1-6410-08dbe58789f9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VOHSdNsfHQ1AWiP5riflaVg7m2fTkw1ihzLiQXYYW3CIgh196BO80+ja1tZVwd/hEXoL8nVLBWqHCT2cArb424WCW6hpUdu4Ju+e4CZz2lWtxWvDMP1++C2kcr2F+lv0JZlqHAArgBc6EdbVk8PuP17JimMEE1ihqRbS4wU3Ure6+2dLAZGGA01+Pxe8mCjfAVY+CH7feECi71NIbhjdqa4NLBazSI/2H3LKRZ1wB9FEfPFjd8IrPo5EnGNXduO1RguWBX1TbTU/SU9KhaYhhas2o62KvtWrbupJhqYqHvMvJXluKc4jiDhAfvQwCq8R5heGeLg6nyT0DeRjM58k4SKk+BLRERyJsJ9h+MsBK8JaaOWmiIj6ybbT6Wn4Cc2bsZqRyi6paAIhInOYrRGBMoEpv2nGO/xftJ6T2lrVbp4GNf6knPr9H0jl/BxQlG21MMAAix8p8YRzQX4ANpBFniec9CRxNgVVxcPw8P3oIZKYWXeCUyCrEja+9+Nh2bTxMUbu3y7K5xpxgJZoZ1LACjW1okFv4hXNJTp0FjhM+3WJkvjOPQNPYVpkjiiQfjv8pck1Jscj97r+BRZhziOAH4saiDKZqqU6FYQYRt101y8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(136003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6862004)(8936002)(4326008)(4744005)(86362001)(55016003)(7416002)(8676002)(38070700009)(2906002)(82960400001)(26005)(54906003)(76116006)(478600001)(66446008)(66556008)(64756008)(66946007)(66476007)(6506007)(7696005)(38100700002)(316002)(52536014)(5660300002)(71200400001)(9686003)(6636002)(33656002)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MrM9iYt7hnKLFJwY9brn27qRnQ8YgRCzfvXJKcFxtdeQvqmaXS03IIzTInHq?=
 =?us-ascii?Q?T7HakZSY7T8xeRDge0loswDCsrG1xkQYteG/JCPDxbfCPoEtd0g36lMYQRqT?=
 =?us-ascii?Q?cxOKAM46VBjh/Dc6xd+oRyN5bhmiqG2or5OcW6H2JXqrz5Tj10gvq3J4aWm5?=
 =?us-ascii?Q?4RPgi9DcYQURQu4IzuiM+3JWzbuiCr1T/pm8XYGviBaawu09gzsaxp92AEM4?=
 =?us-ascii?Q?lyfX6TKL+77ZQ276C32mRb+R/2xIK/TQCWiXbFbWKI064nWdyBgLWrp5n5oP?=
 =?us-ascii?Q?x0yjR87qI0t1IzGZ0KqxMq4e7mhtOd/zgunwX2DVq09F4hKlZidaRMSI+0gA?=
 =?us-ascii?Q?q+EcEyYO8yP6YWUQUfvomIq3M1Pst/RR5r/6TVU0QTLagqFP4bAmGWH8azrj?=
 =?us-ascii?Q?/SRGKn4Fa2g3PjyZxNR4TxV7l8NfiIwZoZ1+H7GZgfs7/GGfC4ZbMlXQkYJF?=
 =?us-ascii?Q?W2UX+QcrUCq1QePka4mJlrz5OO0F14Ow5Wijk7yBFfD+fqQjsKdsf1YPesML?=
 =?us-ascii?Q?pXjwMJijQ5o0qYWVwUm0b88J2EJKUZuVFS1dLVlKb2KK3/bBaxe41KVZic3A?=
 =?us-ascii?Q?CMdjfjCJpglpVG4WP9g9eakFB/RjFbmJKFY2s9XpEQI7OyeL2symkO2k+khL?=
 =?us-ascii?Q?+/Xz8sNyyegC4lJXWt//ZQVHKNWYvbIls70xTpacdIZAWHvoPwqvEjj8Q0gg?=
 =?us-ascii?Q?ZhY3KSwE+NEmY0sdUKSOl4H4tI1kGE2FNazAWsiNLYOM7ujPOqjiU42s4GCk?=
 =?us-ascii?Q?7Rf2iyyUgtvUny+vC0EdXMiEeBGz1507g/rDSvF2cfgPr+ezY7aiIwugR4ip?=
 =?us-ascii?Q?ff3EfrdW+fyzxIwC1X/BpVZp/nc0Ip7RPnq+W5F9cNixusgFknjXToYGTar2?=
 =?us-ascii?Q?SMNKL6k3+R265ay401a9c3qYPRPabXEVm2bEb5dxEsoeZBw9KtxF39vKL8dn?=
 =?us-ascii?Q?exbzz5X/wgqaEjPOo2/So9qfavrsEBwlYiBKObm8E7TiAv5yH7ZmvFg1Lmzn?=
 =?us-ascii?Q?v0M8RSjMXFE8aUDI2g4bLsi8cIhnjziDMcsZJcXPTozgtnkeZyXL1MqzLAau?=
 =?us-ascii?Q?toG0+K67VRoJMWClpJcgpGkR9uxeUPH85dCYAWyTW3vWAdzO0ZYHKHppDt//?=
 =?us-ascii?Q?LaSQ8uLYIpaT0WVmdKmFb7oU7/bg272GQBo0T+rcHktO8JUojbFSdi34qtcB?=
 =?us-ascii?Q?nhSmU3SRMQ67O+HlRdTw7alUNCMUmziitl+QLxvh8nYM0bT9m3e7Z6mEn5ix?=
 =?us-ascii?Q?XV6hyRyzxA4cmdtaXZ0akYK+so2g7Sim65s/w80m9pab0a4Fkx1x5EXTmC+5?=
 =?us-ascii?Q?aniMRfQB2pOTxLUqXWMn1BfBGbYXtVLIiJmJ9FqcWzgrevJW+4XLnVSa1Ue8?=
 =?us-ascii?Q?ZmFh6RSE7VOzAzALFym/ce8nGn/Up2ynbEDGeYnReBRze3h/ga+PhJDUExUf?=
 =?us-ascii?Q?eElAscbAgqL7De9lGtCi0GzgGxNMZ8aNql5zeO9eTtK3/vMTqkk6KD6UyB3s?=
 =?us-ascii?Q?bdn4FsT24t2h/K5Wh0ktVnrVfRfAG7LLlQp59g91tlTba0Q/xd/Ve4vNDtxb?=
 =?us-ascii?Q?9Hy/ODk6MCwg/za/2iMu+VjMSIg4iNw+4E7R0jMR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f3048a25-bc65-41c1-6410-08dbe58789f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 03:04:10.0854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9deAsp8EOxYCe/eWXPl4Pw07woD4SP39xftdo6wR9j6nh7l4+n6L3q6e96zp/+dtTAKlZ0saHIixDP8TEMpdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6754
X-OriginatorOrg: intel.com

> >> >diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h index
> >> >f8c02bd37069..328a3447f064 100644
> >> >--- a/arch/x86/kvm/vmx/vmx.h
> >> >+++ b/arch/x86/kvm/vmx/vmx.h
> >> >@@ -276,6 +276,8 @@ struct vcpu_vmx {
> >> > #ifdef CONFIG_X86_64
> >> > 	u64		      msr_host_kernel_gs_base;
> >> > 	u64		      msr_guest_kernel_gs_base;
> >> >+	u64		      msr_host_fred_rsp0;
> >> >+	u64		      msr_guest_fred_rsp0;
> >>
> >> resetting guest fred rsp0 to 0 during vcpu reset is missing.
> >
> >hmm, I assume it gets the same treatment as guest_kernel_gs_base.
> >
> >It seems we don't reset guest_kernel_gs_base.  No?
>=20
> Yes. But for fred MSRs, FRED spec clearly says their RESET values
> are 0s. for kernel_gs_base MSR, looks there is no such description
> in SDM.

Right, maybe better to set both to 0s.


