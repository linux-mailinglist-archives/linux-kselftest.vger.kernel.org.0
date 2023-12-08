Return-Path: <linux-kselftest+bounces-1464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E662480B0B8
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Dec 2023 00:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D75AB20BFA
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 23:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BD85B1E0;
	Fri,  8 Dec 2023 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVCtLZNt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CFF1712;
	Fri,  8 Dec 2023 15:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702079327; x=1733615327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jEZsderOnNTub6tndL8lbUQrK7I3N0sK/2GGViDijos=;
  b=WVCtLZNt3biVA6w+wNlTS1peiby0BWDxAD6otuZfPZcuUbfRlUsDE9Jc
   QEtToMckLHCGgM4DmAJSnFWZ+2SfFLp3IxL3GkasLLbi+/gT+I+LV/vR+
   uaZbMMaTE6wgUxBeuLYZ280Z9Q3Xo5VyKJDaRNrzcTHZYdaXt+ZGGLrlX
   eT8liMh/95ET2/pkV8l/jgMwqclKL87lu8uDip987kcS70UVbi0UL5yBo
   ESRqP07+fxA/N1CdDSjv60/1yUlfNE2g5iwrL8hO2X8qvYLyhFYOXocFh
   +LlvU+XM5lnGgHgUqTT5DBJw/Bo+Jq5s6WNxHpkJUpr3OuYBI5RHUuIGv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="460955164"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="460955164"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 15:48:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="842786342"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="842786342"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 15:48:44 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 15:48:42 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 15:48:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 15:48:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 15:48:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLIQdQAPCqT45BL8pcXbOvtkcEzGc4JMbE0+GuNgXEDj1DjRd5Y0yhiuXMD/ID3Sc+rSKKI2ju8pD91+8lwfYgNIVn/ojh5QP5KXplVE2zLAAc7cnh49cngb5E0aNgf2CWHuJiTwe4REx4jM60PWjGJIlGDozT7i7sQ1hQRe0OHOHHzd1PEBmX4YILgs5gHVTwHhbN6DRdF6LLjzizNT4WS7X4WLfxt87iINYFoPORtfSv2lSwknrzAtQMxMvEsp9f6QRKad2Mc5K1YdAJ2rhZSVByMdzhLYsaSZOQSlaMLQPMZ5Fb/X/0NF6HDCg07wMWuyJ3cedXUo2/oF5eJP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wxTM2WTTvn6EeqqzIqAok8+ZlQbx2qnpZgGk8yMMGg=;
 b=ZTTqEaTe0nP4mbB7Pdne8khmHOVX77sKHAtTEWwyUvtUOePD61APy8//YAGI2TTj1mPPfPDVSWqB+2eShIJsiJGKeJli26M/eV6s3O43zaQDCJtKsSVhfo4xvN4yOAsPcRCac21wmlPmzKJU0r3GJ25lhHapdrAnd5k2kLfduI1GXVYDFGjXWqvU5XBko6zBciKYMV4KtaxKBnQWkTZM6aZneShBXEzdT680Veo7Yj0GiLJOn/J/wEkSuARVWPiQQusi1SxQzfmhiqpI//n07UyYDSPBupz6nizo19ytKWF4jUzVyzxim/gQQoqwoO0FrjbGOrvxcDUXWRgfu4wCfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Fri, 8 Dec
 2023 23:48:38 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 23:48:38 +0000
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
Subject: RE: [PATCH v1 13/23] KVM: VMX: Handle VMX nested exception for FRED
Thread-Topic: [PATCH v1 13/23] KVM: VMX: Handle VMX nested exception for FRED
Thread-Index: AQHaEnYXOQlvFLhpWkG4lt/jksLCm7B5dqYAgAFC3tCAIVOmcIABoIUAgAAStHCAAQ43gIABYtvg
Date: Fri, 8 Dec 2023 23:48:37 +0000
Message-ID: <SA1PR11MB6734FFE3D3500BFE4AF407DDA88AA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-14-xin3.li@intel.com> <ZVMkVmBPVfaMjDTL@chao-email>
 <SA1PR11MB67348D3637C2BC6B107C5CCAA8B1A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <SA1PR11MB6734EFF17E15C68AAD12A227A884A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZXGFcuwwmkBlqq5s@chao-email>
 <SA1PR11MB67342A44E1C2E17E127AA44AA88BA@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZXJ3z0yCqnHm52sC@chao-email>
In-Reply-To: <ZXJ3z0yCqnHm52sC@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SJ0PR11MB6622:EE_
x-ms-office365-filtering-correlation-id: f59a9df9-0570-4e8f-e8b1-08dbf84832c1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8jmgpWWuCw50cn82ybksFhnhdr013rRtK7mOWr523Q+31tGlRYyZ9dcDLiqAgIMCD8nqejx7rgbmxQJqT+5LuF2f8ooKdixfSlYGeS+wCZxSOcWQXIKLbiQe8RH0VjhGt6N+C5jVvUvwxgMGzhUm3xa/bMR8GzZ+c36N1c66V2j+sQ662DBkAJMCO8NSOqsR/i8ooDW5E+52djQ8jfHTixHAqsPipSnLcit7PuFySQw49l9KrdqE5IHKf+WYml/6grDF2tlZDhE3opiaI61GCTzSBkSFQxzpD9pZqwV5Gyt9FjlPykzJQLHE3wVv3hicGFAfiOAfXg3W9zL5H1lqdQ25hEVFnwKsEnVlVCft37DDanrqUXnAcJiXoIaCCTY9smStC76J+5zWNhb1R5H0nQjhZL3frD0N/vgD1dPwxMvIgazEc85JeJbDSRU9k11EHJ7Hu0TuI3SZVOcnECh29p5Baw427aXfm7vua2cE0DnoDJoizSmh4qg60cLmp33TvOjtHPy8C6NyT0cPsPiFgu8Hu9oeTQ0U2UKuXyAtnYENG6fooBrkh4x5wbxGkFvASyvxK/XWj9v2qsa8nAhELG2zsnWcAwLoYuaXRPdJ20uTlZAqWeOYuUMywuLqfS/j6YLoP1zeoQl+UYb5atNY/ZfiRrNVAtlgA4dMiyi/hsc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(41300700001)(38070700009)(86362001)(26005)(122000001)(55016003)(33656002)(7416002)(5660300002)(82960400001)(2906002)(83380400001)(71200400001)(9686003)(6506007)(7696005)(8936002)(6862004)(52536014)(8676002)(4326008)(64756008)(478600001)(76116006)(6636002)(66556008)(316002)(66946007)(66446008)(54906003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SqWlLhGr0ehKIw+fIeqmHonP+AxpxjREUUsVNmQBOuzS6l1bGV139U1OQq9l?=
 =?us-ascii?Q?BCsv0ggAU2nrcyS8EO7hj62Kk9R1AZeDcSQ5clanfynr6WhG1ZKbr7WvG4K8?=
 =?us-ascii?Q?H9Qo3OPFkvYjtS/+3+KhyK2bt+T0XMEAYNPJiSqQcsj9Ndo2/83nDM0blqyV?=
 =?us-ascii?Q?2uANXSL39M3L4ltbjXf0Ve2Fg03cbsA1tzEeCwxwJCGe+5A+EZ+oBPLTD4+7?=
 =?us-ascii?Q?IEhfdDI7H1iN/8ZlaqqcNcbbtBvy9qlto+rJHTskyqkMu8lZdgHc0Dl+fx/9?=
 =?us-ascii?Q?VaOrpefv5lK8jsr++PZBrb+ziZhEyFwO4pHYe8Pdn6cQfjXq1p4JtT6YtNbP?=
 =?us-ascii?Q?8n5RTZwGwfu87M5KXImAIFR0C+BoFnP7nLxh3fqsIO7mnOVsO5vLvu/YAgou?=
 =?us-ascii?Q?u0kpWWukcjUvO75TP0JawjG2jRbxB3hbZGSWY6UbKU/IT+eg4Jn1wPhndtIr?=
 =?us-ascii?Q?1rsFOs5Sf4Qb6T9Lo3uXJX/z9At0rLAnvQZBZYS7yVZqTAbIOYd222cDt7or?=
 =?us-ascii?Q?14w6tTOoUo3Ge6YJ9Fz6GRfACQvEHIeYNqjDeop7bc48Xtey1gFSl6lTm8fC?=
 =?us-ascii?Q?8XVd9L+qJNyB0hiqFpdXattuD9ftE03G6NoVB24c8XnhnX/yVOdpxA0sN/LQ?=
 =?us-ascii?Q?TzyeLnue41wP2IbLDR51kAVe4ZDZYQvpIEnjnfPTkBxBPQW6Er5Ly3bVNj/E?=
 =?us-ascii?Q?mlyZPq+pBcuvxc7LHH9IdbruNOpfWlx2tPamfYSJYv8dNvCOPry0WVuGGZUT?=
 =?us-ascii?Q?35M7J0AduTkArZeiZT4WdF2UuZqY2f9c4Ry3sCQPHzq45uHvYvTTL2bLleRa?=
 =?us-ascii?Q?jIYKZz5hkORgCAUpSrNeSlraqYAq95zqUPN8wiQsX7Nr0BkW7ZESCO5omDFb?=
 =?us-ascii?Q?AqQPa7mUgiGLEQ7Hnmxm6iXNIFDw2ZEuvg1kPopkPpWpz5oEY7qkIgxrYFjL?=
 =?us-ascii?Q?/dbJJLJjk7x75rJsal70gLmBxjDsfGq4B3psKTQo01G4K11OfYvYJPlft3cx?=
 =?us-ascii?Q?mmDsi3R1mjs0sbZqWrO8pKGIMqF1OI9ctwXwhdUOnpR8E5BDeGJJEnuKgxVQ?=
 =?us-ascii?Q?/j/DxC2N9NXImGgWmo0UvuubSY1GjnlWQ8eBE2+Rt052K7UlZfGRor0DlcKz?=
 =?us-ascii?Q?EHZhkCEwcDaxAKGnxuJk97vkRiS9S4Lza5vMHg52QeMBv6JBeS1uEotHkAdS?=
 =?us-ascii?Q?4gNIw2mYcgfaQtfpJvQ/iVFX0klpXp8kE/KSWLF5hDz594IbFnbmLm2pa89L?=
 =?us-ascii?Q?LsXPxbSXMpdLL7B4Hoh9Rwfi4lQWXLM6w9rR+agVl+uS1zHRIS/tcw8AQaLf?=
 =?us-ascii?Q?9fEu8fOKvsE4dkknovht2V4MkWUoi40pWJR5ROFZDnwjW9xi609Fq5Tjn0Ws?=
 =?us-ascii?Q?zCKP0RKEUf7JM5AF9hevZveQzCGR0ogRlNOofEOEw7yVS31TpRhKio6WEuvA?=
 =?us-ascii?Q?8SY23SC2P2pXTTV+23ZqsjYMPnNvGc5UGPAVHBO/EPb0Iip6GYgOJ5yupEFb?=
 =?us-ascii?Q?OG2ECcplOrLjB8VamFlY5qwCuzVV57RTsuZGtxU4rNMMzGWOR1KzSc6kmCVi?=
 =?us-ascii?Q?tB6x8CKHXcYY2d1A5IU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f59a9df9-0570-4e8f-e8b1-08dbf84832c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 23:48:37.5801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I59jxCVWQgJeaAOmZLmBEII1gagSyIbMZMt2RBqHksvZoH8lhLngn4nMbfVURc1Ev7HUJdHzr6JNXX37ysb5oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6622
X-OriginatorOrg: intel.com

> >> >> > Exiting-event identification can also have bit 13 set, indicating=
 a
> >> >> > nested exception encountered and caused VM-exit. when reinjecting=
 the
> >> >> > exception to guests, kvm needs to set the "nested" bit, right? I
> >> >> > suspect some changes to e.g., handle_exception_nmi() are needed.
> >> >>
> >> >> The current patch relies on kvm_multiple_exception() to do that.  B=
ut TBH,
> I'm
> >> >> not sure it can recognize all nested cases.  I probably should revi=
sit it.
> >> >
> >> >So the conclusion is that kvm_multiple_exception() is smart enough, a=
nd
> >> >a VMM doesn't have to check bit 13 of the Exiting-event identificatio=
n.
> >> >
> >> >In FRED spec 5.0, section 9.2 - New VMX Feature: VMX Nested-Exception
> >> >Support, there is a statement at the end of Exiting-event identificat=
ion:
> >> >
> >> >(The value of this bit is always identical to that of the valid bit o=
f
> >> >the original-event identification field.)
> >> >
> >> >It means that even w/o VMX Nested-Exception support, a VMM already
> knows
> >> >if an exception is a nested exception encountered during delivery of
> >> >another event in an exception caused VM exit (exit reason 0).  This i=
s
> >> >done in KVM through reading IDT_VECTORING_INFO_FIELD and calling
> >> >vmx_complete_interrupts() immediately after VM exits.
> >> >
> >> >vmx_complete_interrupts() simply queues the original exception if the=
re is
> >> >one, and later the nested exception causing the VM exit could be canc=
elled
> >> >if it is a shadow page fault.  However if the shadow page fault is ca=
used
> >> >by a guest page fault, KVM injects it as a nested exception to have g=
uest
> >> >fix its page table.
> >> >
> >> >I will add comments about this background in the next iteration.
> >>
> >> is it possible that the CPU encounters an exception and causes VM-exit=
 during
> >> injecting an __interrupt__? in this case, no __exception__ will be (re=
-)queued
> >> by vmx_complete_interrupts().
> >
> >I guess the following case is what you're suggesting:
> >KVM injects an external interrupt after shadow page tables are nuked.
> >
> >vmx_complete_interrupts() are called after each VM exit to clear both
> >interrupt and exception queues, which means it always pushes the
> >deepest event if there is an original event.  In the above case, the
> >original event is the external interrupt KVM just tried to inject.
>=20
> in my understanding, your point is:
> 1. if bit 13 of the Exiting-event identification is set. the original-eve=
nt
> identification field should be valid.
> 2. vmx_complete_interrupts() is done immediately after VM exits and reads
> original-event identification and reinjects the event there.
> 3. if KVM injects the exception in exiting-event identification
> to guest, KVM doesn't need to read the bit 13 because kvm_multiple_except=
ion()
> is "smart enough" and recognize the exception as nested-exception because=
 if
> bit 13 is 1, one exception must has been queued in #2.
>=20
> my question is:
> what if the event in original-event identification is an interrupt e.g.,
> external interrupt or NMI, rather than exception.  vmx_complete_interrupt=
s()
> won't queue an exception, then how can KVM or kvm_multiple_exception()
> know the
> exception that caused VM-exit is an nested exception w/o reading bit 13 o=
f the
> Exiting-event identification?

The good news is that vmx_complete_interrupts() still queues the event
even it's not a hardware exception.  It's just that kvm_multiple_exception(=
)
doesn't check if there is an original interrupt or NMI because IDT event
delivery doesn't care such a case.

I think your point is more of that we should check it when FRED is enabled
for a guest.  Yes, architecturally we should do it.

What I want to emphasize is that bit 13 of the exiting-event identification
is set to the valid bit of the original-event identification, they are
logically the same thing when FRED is enabled.  It doens't matter which one
a VMM reads and uses.  But a VMM doesn't need to differentiate FRED and IDT
if it reads the info from original-event identification.

