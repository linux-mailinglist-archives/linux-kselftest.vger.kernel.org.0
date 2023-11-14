Return-Path: <linux-kselftest+bounces-66-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C23877EA8D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 03:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767EA281018
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 02:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D971123C0;
	Tue, 14 Nov 2023 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbvUZpV9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285BA7E;
	Tue, 14 Nov 2023 02:50:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD0C198;
	Mon, 13 Nov 2023 18:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699930253; x=1731466253;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qSWwaStIedOZvbWupjytivSaPk3UgYFsp/JjUNBwSC8=;
  b=cbvUZpV9ueCCm0/lbT5M7uhwYlKVq0fY431UIBKyZHN3HLujmztvvMFK
   EMa/33lIIzkIMb4M+DAOTB8nrqHN9lQJlAWUbu3VxPf+Yz7vF1I1EclBX
   xLG+iA5eQk65S8eeVjEUmohmaMSoVTbc/uQ/LqjyQEb/4yzD7Stn08f6t
   JFhgLMMYVfXzqY0Sbf0+ETTWko1Y+X17IzpQ/l9gj3F40lDrXNv3pKSBr
   T/EzoKdsStIoupiYDUu3gQ+i2cHGpEwjO0P3c644bIX8D//DCcWhgw5EL
   4TUL/QWOzl+HlF1sZi0eFjDy2Cc7rvNuKYuEVBSyxRvPJdgCzzmfGgLrw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="389420071"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="389420071"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 18:50:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="758013547"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="758013547"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 18:50:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 18:50:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 18:50:52 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 18:50:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUGQ5Rp3jxiKB3hRjxgHbRet36FQnX4p9uD8hQa+cDmIVuRgHimwxTijKIVoP/8201jd+YpVqQZBkEe7Op4g3aWBNlyqtjrxWZMVgQ07vLaK19eCj+ZBTucOAApQsfxj6dfYwJdxxJ7/mB8LYvGVd4lYTA5PGXVYGJnkdyX9zY24CJFZTneAQIg0WHFSWFjzwudUBsHXoWTu6uNuIWYENp1tM5cpp3p6D3+RGyFJp/8XzIJTyORYnaAZv4opjOabWIFQF2+UkUDdSmvBGEgkp5yNgdytA27W9OlOhOu+n+vC32LptueWbij1RhEzGbMVb8f10BMYgjGPOdG+Qhe7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9800w37A00qsBg1FFa+1SLcZDbtuTOaXU/pWRy7d/Y=;
 b=AqGOqlJrsoImXvznPOjSSCRdrhQTdErlEcGv8aabJKb+mP7v2Sr4/U4hxoTnjB1paAGfUMgvEm/ZFhfUGB/KQOPc7wm1ZNuD2uQMk+ZV/WBbV3IWogNbJR94XBdlXhUM3Lyb0hhc7UxOai0o3aLpDqi8OpfFtUKdeus2encIGY64dMrSkm21Xwr+En6Y+U5vTiBpx0yRnO/Zm7I/YewiL4Jb8nuJ8ZEJ3L/lHYuL/m7qgjEsI+fUogks3r7gfRRGlOQvVO5bwQtgm640hshe4b5WJSLzZ5+kGnFIPkKirQLVpSezEO67WkIORVhAvsOONVNgk9ddvVIC3J4td7hXKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by PH7PR11MB6929.namprd11.prod.outlook.com (2603:10b6:510:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 02:50:50 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 02:50:49 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "Cui, Dexuan"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v1 06/23] KVM: VMX: Defer enabling FRED MSRs save/load
 until after set CPUID
Thread-Topic: [PATCH v1 06/23] KVM: VMX: Defer enabling FRED MSRs save/load
 until after set CPUID
Thread-Index: AQHaEnYK31xdVTOu4kKzxsXb22qo7rBxtbMAgADxRyCAAArtAIAGWH4A
Date: Tue, 14 Nov 2023 02:50:49 +0000
Message-ID: <SA1PR11MB67345D35CE3FB950A0C90BDDA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-7-xin3.li@intel.com> <ZUyjPtaxOgDQQUwA@chao-email>
 <SA1PR11MB67347A31E38D604FDF2BD606A8AFA@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZU12zoH8VtcZ_USh@google.com>
In-Reply-To: <ZU12zoH8VtcZ_USh@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|PH7PR11MB6929:EE_
x-ms-office365-filtering-correlation-id: 2cbd9422-a2f6-4a2b-c87f-08dbe4bc8275
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LpQUVz+ppBx39cF7OOpQEAbQBQFIzC2tiBp+nyj8bZFMabglQ9feNEbWgcP9u43sM60QCmhUKKVuotzb1jXBk4yLTGB2CQiD4IrKG3nCQCDiKJjkppi3jsNjy3JV6kTl2BqmSM7/V0zqtn6LlTpnzZvSsfseArDZKlBg+I3PJFxA8Xvr2KVdaG6ot/hu1ADabswmDuOGDPawmxedqhvD8F7yHMJ/D65E47/lfElbDuYFgQXWNgyOfPmFFul1vL/t+PaSBcfPfm6UzqD+9QvPyMzGchdVMuJdZZCtRoy+5G5FtccWP2n4qbbhw77JiGRAcl4ZIpCW9A9UFppSPYvz9XX3gc9nVnEHeyvjdJo+SNqsSKxlrGUCq+hZHZUyw5rMuwt3yp3tStElqXAfc/kSkKlPxMSAQ+igUn+wpqq+YDXpoWw2YQu4g2vCHpN3ofeUm6Xjjc8RN1RW7sHh0ZjDtzE4cHmIKr4ba1NjFWeqMtKgeClXQLNMOlAmVvr0VWXLIRFAE2ElBbkb4EcEuaaXEAD9oEWdR2GE959a4GwJbRbAjN1E/FW5wJnJQ+T4V3G/EY0cb9fZqdKw1tpCcaa8oVHMGy+b7gOhWeMFl5sl8E1C1kiWhE7iEXiwryzGd37Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(38100700002)(7696005)(9686003)(6506007)(83380400001)(122000001)(55016003)(26005)(82960400001)(478600001)(316002)(71200400001)(66556008)(66446008)(76116006)(64756008)(54906003)(66946007)(66476007)(6916009)(33656002)(41300700001)(8936002)(4326008)(8676002)(2906002)(38070700009)(52536014)(7416002)(86362001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?61RCCWR8eh5euTxC68tUIuuygy5PAs+OI0sDPdyn2DFZkQstPmjWTaEIvKmb?=
 =?us-ascii?Q?ZbpBMBs9gkBz9ZMpddZZ1NXSp49m3D8OIGPfQIubNFqem0Efc8bPSQmpyvR6?=
 =?us-ascii?Q?HsV6hTdY1ceWZt6wBDhcCrixwGdP7Pt45/FnkZqnfRT1R6m6T1fw4CXNb7At?=
 =?us-ascii?Q?Xhh/1Tfd53FVMdN7mRVQE6Aj0OAP3k8HRMiAa2FkpMz/N4d5G3QiGbRAdTpb?=
 =?us-ascii?Q?BMJJIzal7FZ4fLtKSGSwgq1Ek8z8Ee/fFh0GkDJoKNbVbjJSQjeZF3Hal9F4?=
 =?us-ascii?Q?wBuajZks4zfUrptD8iu1wFg6JQfvdIH8LP4Xy199nKsUlSouygn+SKbmbn2U?=
 =?us-ascii?Q?lxVYSelu9xWT04/LAGHXVnUbiqJuLCtxbb3D/ovee3vJKsTlXXNrF65+V6Wn?=
 =?us-ascii?Q?r4M2YLZu1P36fg4nX7DL5qV0k5EQ/r/i6Y1PA79icZOva++mO/Vc0KOKZCEf?=
 =?us-ascii?Q?9er+g7MD7rWqQVlqfg9jTdWb4fWhLvYc/z81RvIeRrANQZhsbZ0yDkUymjQv?=
 =?us-ascii?Q?2Q7/H6XzHyUqGI29EW7uNUZSdpuI3e1XvM7Fk+SjFwnxgr8nFafaV3ZgQafK?=
 =?us-ascii?Q?/tow2PfLTr+0dJhr+2n1Q6T8uBJNjOGmu02aLQK0c75+CTAUbmmi91JwZuHh?=
 =?us-ascii?Q?FxZcHzHgwYfvqk9akOjMYULsKK3NaGdmjZJU4q799XmF3Ii6vdMftaMsw6JY?=
 =?us-ascii?Q?phODSoevtMVNcEGfSxt8S6Idc59j5vgK20VkbRTe6Wcj+ZvQt5JrYgXjJoVI?=
 =?us-ascii?Q?U8CNbgYoR2u8DsZbek3uEzAEjtAqudHkT2Y32nl0sS4fg060az+cD6KDIGBT?=
 =?us-ascii?Q?AsfLEuF8QonuVZVTDNB/pLXBLvw0AG/bYdqBG1bInLPhCOte4D3x1r9Q5CjJ?=
 =?us-ascii?Q?R6SWR7iVkaqAesCVbl3TJ8qZ6LfjkT7LSg4uZBRnfZUNRpwW9NxGvsIN+89U?=
 =?us-ascii?Q?H6vmAIogut218ZwSkB0vELOgb1DvMH+EJaIUZiS1hlpTQidbH6OY2BcdlAaR?=
 =?us-ascii?Q?lqSZTQvKNw6cFyv7gcSiNK+SmvAJz5HRkHTdOp4JhCoxZZtD7ZOJsJB7YTkN?=
 =?us-ascii?Q?Xuhr/6TY6PYee/xLc67S+DrTIwRkQ8Je+bFx0wIAGrU780Yy4Chn+R3rbmrg?=
 =?us-ascii?Q?fe2YIFSSiSTKm9jimGjeqVsNS7LfQv7za6u65uznG/0+wIkQH68MNdpTxomb?=
 =?us-ascii?Q?RcdTFn7/g1dabO7rWSW//Ku8k40s6m+Q/gfiq0252TcotATiVJUW2SO7rQco?=
 =?us-ascii?Q?d49ynM9o1hGeUKpq0jthKOzhu9ZWPnUxKZYv9cmbeAgkurXqP9nwASaNtuA3?=
 =?us-ascii?Q?u4XeX3qZ7u1puu1Hd+3RMKUpv4j7m514MPGMw6JQZ7DQ8ATSuWxelY0eXy8I?=
 =?us-ascii?Q?aswewuZlA+nqqUqgG8p0nrWZcjiFcZeqyRp0K7hyCkZZRMtysmbabygx9a78?=
 =?us-ascii?Q?kFt2+EgmQF36c2uN1iTSAdW2R3w8v9hOYIk0KkiG5RhUFTVzlzJDN5FZnGNs?=
 =?us-ascii?Q?fEgasG6FXABkAyXgrEDuo0opByWuKdieeDlKdM15EVDxvwnb/ctXiqtr8bft?=
 =?us-ascii?Q?QBhIqYsZYL5+H/MuGOw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbd9422-a2f6-4a2b-c87f-08dbe4bc8275
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 02:50:49.6706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iv2HlVe9a72UXh/nu4UzoAUwX6ffXQvIpNxY+00S46TqVB7UrxcxYO5Zo+XmElvklzYQsZ4Fteax6bKeiMtpuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6929
X-OriginatorOrg: intel.com

> > > Clearing VM_EXIT_ACTIVATE_SECONDARY_CONTROLS may be problematic when
> > > new bits are added to secondary vmcs controls. Why not keep
> > > VM_EXIT_ACTIVATE_SECONDARY_CONTROLS always on if it is supported? or
> > > you see any perf impact?
> >
> > I think it from the other way, why keeps hw loading it on every
> > vmentry even if it's not used by a guest?
>=20
> Oh, yeesh, this is clearing the activation control.  Yeah, NAK to that, j=
ust leave it
> set.  If it weren't for the fact that there is apparently a metrict ton o=
f FRED state (I
> thought the whole point of FRED was to kill off legacy crap like
> CPL1 and CPL2 stacks?) _and_ that KVM needs to toggle MSR intercepts, I'd
> probably push back on toggling even the FRED controls.

To me, FRED is to _architecturally_ do the right thing for x86 event handli=
ng.

I don't think FRED's major purpose is to kill legacy craps, but longer term
it paves the way for that.

Yeah, I would like to discuss whether to toggle FRED controls.

>=20
> > Different CPUs may implement it in different ways, which we can't assum=
e.
>=20
> Implement what in a different way?  The VMCS fields and FRED are architec=
tural.
> The internal layout of the VMCS is uarch specific, but the encodings and =
semantics
> absolutely cannot change without breaking software.  And if Intel does so=
mething
> asinine like make a control active-low then we have far, far bigger probl=
ems.

I should have made it clear that I wasn't talking at the ISA level.  And
of course CPU uarch implementations should be transparent to software.

I mean a CPU uarch could choose to check the activation bit in the VM exit
controls first and then decide whether to load the 2nd VM exit controls.
While if resources allow, a CPU uarch could always load the 2nd VM exit
controls.

BTW, I believe the active-low controls are really gone with new features.
All new controls are all 0s by default.

> > Other features needing it should set it separately, say with a refcount=
.
>=20
> Absolutely not.  Unless Intel screwed up the implementation, the cost of =
leaving
> VM_EXIT_ACTIVATE_SECONDARY_CONTROLS set when it's supported shouldn't
> even be measurable.

I do hope so.  However, I don't know whether this is guaranteed or not on
all uarch implementations.

A decision to leave it set is good enough for now.

Thanks!
    Xin

