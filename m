Return-Path: <linux-kselftest+bounces-335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F2A7F1B3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 18:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8521C21224
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 17:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33388224E2;
	Mon, 20 Nov 2023 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MW690q5i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDA411C;
	Mon, 20 Nov 2023 09:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700502177; x=1732038177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pp+obdMcLUD/huZCUv1VKLTv/begvYI5kcTx2YVo02o=;
  b=MW690q5iHOqac/CpwvCIyfCBMUTp87JM3ewGk3QL1ST+O+6sh5J9OcrJ
   X4hlD0Pc/gPjj7ngQ5cbXIHXy+xhlrLUsVz/1zHcsUvFdtKNsSsAePI9s
   iPY37uOBacsxjS5I98ma2z0lSCnnj5LPr09WRPuT9nPUgx+dWC6fPJ3KF
   NLggrQaDHKUU4DsVmLE2DykAbqzwx0AUngovCWe/Of28BxqVW7YkjN9sb
   dg2YwChqxyBg2mRJd8vioW38XRq91QYncgtHrO9eRAuR4JciAv0nKFLsL
   6JsVAl/lNu0wWeIgTX9ly+7gZk0uFsOmO/rvX7Cum7NrxloorJPJcFylR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="13217967"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="13217967"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 09:42:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="7785544"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 09:42:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 09:42:25 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 09:42:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 09:42:25 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 09:42:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBiS6SikU28WtW4yr7BCEhzv5GCcLX/4tteCaxlrY+UfuoFBHHGt9O8Sxadz1c1UxHYUjK0tiIVicf9vHmF6TveTS+qde+GbUqCYDEN42azT/B/m9kaNVtjaEjwuWsfqhHkRS/viXOlf2IlFsUfqHDao9n6MadezaMa5ggLPCFzRy8uSspFWg16RKm/07nCktS8WgbuejyTqMz1vyr/FRUGsYF+yySeIzJHXpyeOz93AB7jN3RKJl/juvU+wH7j3vpMfegf5zX20ZxPhFT4Ck6pHhxd4rvs+ondJGb6qZMS2lLcDVfGeJ6gxNmNPLdqap43Vt9phCJGatDTtSQTmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWydx6WF5uHqvIGXrjA04n7f9ktgK/9Xj1vSgTgvhHk=;
 b=cZV+cABHPq5tYwZOp3cO6TDo3hSFg//oh0uup37PyviKM6mjL4bFkQQawND1FgXPJx9PvxydII1qz0IkdgxhAAKDG33vd88UpOc+Z/cOFPnq6m5gNEdTmWeWo7NLbQrIUABP0fqZzG3HsgIMRZOUOaV3T6KYmjK7CcC1W4e1olo1ttQdOzedqYlcsuVa4BypYrY8uemix3ZmE94dB808+OMzUhgiXvByOXKz6wLVKDZICPCiosVDOZuJBco606WyVoE9H/0LAHKYsu7BOwt6BcGhEfPzbMZ5HbmsgeAAK1YoS3gpnTcoaR3M/ot/QeGilX1ieUqHPILVMpDhhn4ozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by IA1PR11MB7677.namprd11.prod.outlook.com (2603:10b6:208:3fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 17:42:21 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.7002.025; Mon, 20 Nov 2023
 17:42:21 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
CC: "seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "Cui, Dexuan"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v1 15/23] KVM: nVMX: Add support for the secondary VM exit
 controls
Thread-Topic: [PATCH v1 15/23] KVM: nVMX: Add support for the secondary VM
 exit controls
Thread-Index: AQHaEnYCzFnG3GUP+kCaRbBMUKVZALCDblcAgAAdo1A=
Date: Mon, 20 Nov 2023 17:42:21 +0000
Message-ID: <SA1PR11MB67344F9713F27B95454B73C5A8B4A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-16-xin3.li@intel.com> <87y1espgkl.fsf@redhat.com>
In-Reply-To: <87y1espgkl.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|IA1PR11MB7677:EE_
x-ms-office365-filtering-correlation-id: 39d7c7fb-1f44-4a74-f149-08dbe9f00c8b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dQM1EJ2wGV4oLE7DyDZLtrGBNRxuZJgL17HZa2fmZOdIQ3GRu2bqn66ojXJh5nJd+51xzqxUMSxy+3Mfj5EWHsJx6vRjWzx0tWYcTt42qZzwgCl9PjBgf42i5p+b85T9xNjWRhDQIw8+c55eaVYjlvCqNfs4EN3M0CtGb/NB0f+tBtsu7lzhJ/s65ljr19lYFVUY1uXEQ0wijpBdFQvFQSPPnhjAuZGNKD8nffUbfCF3Ex2tYFo7qsamXMe11MEvNM/f2ZxanoG4B35QYD2o0jMekfrgTgLt7chVWRbZCNGpbm+vUy4gyehDiKLDQBdY6PUiRAwRaDmbNR23+jqJAyCkLF8tdxueIzg4CeEN1XMZzxjP3zA2exEHpInRgYjIVvaqPNKClV0s0j7udoqzdSbPj7/p8EN1t1J5MbT5LANmjnxxwIlYB/VdOfcHwjhPxAcBGYMRP9ODhD3N2EVGbYdC9UiwUkfRzVs7nYrItL4gvkGLOqtS/BgGhcvZ0JgRzfOsXFuRUXwGHmkME9mO63CjJK2NltHXmUED72WP/nBVEmdAJ0wna7XyvSDw4HIJk/owGZ97mkcAjANRbPK6td2ad4Bk8yb9qR/r4mIXZyw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(122000001)(7696005)(6506007)(41300700001)(9686003)(38070700009)(83380400001)(26005)(82960400001)(8936002)(4326008)(8676002)(52536014)(33656002)(7416002)(45080400002)(55016003)(478600001)(5660300002)(86362001)(966005)(76116006)(2906002)(71200400001)(66946007)(38100700002)(66556008)(64756008)(66446008)(66476007)(110136005)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2dgxneMFInTJknPm22AOQyOMQKVccgzrPnSb9gO92N52SaSkKM1ceuHim1NM?=
 =?us-ascii?Q?HqJbvyYMTXzO8Tq2IgdBRLNa59Rm0MHwOuuAtd867C9psabvO76i7M8WiNA1?=
 =?us-ascii?Q?X+kRmao4KQQXQscnxGx7/xxXeHS4ZiSdNZSFdfoTl7aHlra1DnMiu+koWSXP?=
 =?us-ascii?Q?OlyJ65OCf0zNlrcSXxXGvqWkAU64y39RrR20ukRPSINrGv8GKKidxXSiBibq?=
 =?us-ascii?Q?hr5jNzEf2A0v9UllqoSjYg5nfXw/UwvLE54EcFKpabQL8V260CpHTk8pBplU?=
 =?us-ascii?Q?AekQHmJkpwGXQjiSdPxCjxI0GOtxrBBKtUJL3wxUHLxSDUOui9/UbNNOFRgT?=
 =?us-ascii?Q?av+X6Breq/c3IjuuwvDWHWUTL4DSU3/LSaD9LMzf0XphXlskD2vvABsqV6+n?=
 =?us-ascii?Q?dP77bvgKCk9vr/mpsuV5vmHTx0FT9ZvcH4EG+BHafrfywkLpDaTdNIytVRVI?=
 =?us-ascii?Q?WnqWHBaL/tm0/jfV4liEyZRXhJAn7/0Un1JkRUB5QbmS+9I+rbd1bhRsFENj?=
 =?us-ascii?Q?O4VQyzKDclZcDxw0EzF7UIuRemuFzdmj3oCjU3xlO6ZKg7vy+FI6Axmn54Ze?=
 =?us-ascii?Q?O+qGA45lfHRMsT64ua8KW2U4T9wKUrnZxMB4M44iP/21iVyckvI9t9cMZIXi?=
 =?us-ascii?Q?1KXbOjpD345OM/aZomFFSoUzBjSqHXsyCoEyFNOTkcmAPKaJbz5GtregZmW0?=
 =?us-ascii?Q?ozbD9oXnxXbh6lABri/eh6rZy5isn5lgY+RWrqVOPlFVwpU2PZPSl4htNtyK?=
 =?us-ascii?Q?TsrOYbXvrsQHga39k4codgwwRMG5ggWKoHhbof5JrV0NIU+SM+4LmhyE12Ek?=
 =?us-ascii?Q?b7zI+zck3IRUf8AUaEz9ltN2cIddw48w9SAu74XHptJA94UcGGLZ5u0iOKTf?=
 =?us-ascii?Q?f1B6TGjpr2kWD6Rx9G1ODzE70VzBYUAezvMg5RLUCGji3qgqOsCrYoofGN2H?=
 =?us-ascii?Q?N5c92QeP59BMbbO8HWcyUVS0Y4NnbhDr6MNZC0qrmQ3gMOthQnhwxfP+amaj?=
 =?us-ascii?Q?gxX3a6Zsib0Q6P3LWYx8JkRHEIhTlkBBe8yxkxJGJ8Pvq9Qp4iE3JlocWSXM?=
 =?us-ascii?Q?HuM8BY3YXX3LRyNe8TXC+lOeCb1lp48p579FLsWGOY0oWTmRTt6YtsQYt4/r?=
 =?us-ascii?Q?XX9SZZf5o5+0v75fl8Uf/OfJ9zJSXvmlF/yC1c+gRCgpmAlAbvQ7aeEmjJd1?=
 =?us-ascii?Q?hLV5FtoBtLJryTrHzJav6WUTbfiu8doWjwjeEgY005QARrWZplVlJ7QU+tDN?=
 =?us-ascii?Q?9OI7aRtmFoAtuRCuIuzrj9pjarKm4zhfr7BnmZtOb+wMEU2fZDL+Ptz07K/9?=
 =?us-ascii?Q?7PFFpzYeroALsP3Do47dOGuILaiM2CO9NERbMJnblB5ZYdeLYxW5YpwRi2Up?=
 =?us-ascii?Q?zj3j+fnfAKcF5pCH0xNsLZPCBPA16jNDYWmwBT5PzAjSLyr5nsangWMMXzYV?=
 =?us-ascii?Q?4Rk1KlRYxYU/lKxTqlIANnBOrwJJvTbbhNqz78ae4ZR1QPE0MOM38Lg2/ZEy?=
 =?us-ascii?Q?qY0rlaspZny8wepGTJ6vMlv4yMB+ihRprCWEfvoX+DdehOG1N3EB/WGN3dF1?=
 =?us-ascii?Q?RTVfPKatuHHImobt604=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d7c7fb-1f44-4a74-f149-08dbe9f00c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 17:42:21.4488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jSg53oqSDwS3UL9MSDI+aYp6CmlK/uxaQLWaZNWjCX3cS4Fkyago00e+13Lb6m0bkl0eyGotVvuxMeqLPX5fBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7677
X-OriginatorOrg: intel.com

> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h
> > b/arch/x86/include/asm/hyperv-tlfs.h
> > index 2ff26f53cd62..299554708e37 100644
> > --- a/arch/x86/include/asm/hyperv-tlfs.h
> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
> > @@ -616,6 +616,7 @@ struct hv_enlightened_vmcs {
> >  	u64 host_ssp;
> >  	u64 host_ia32_int_ssp_table_addr;
> >  	u64 padding64_6;
> > +	u64 secondary_vm_exit_controls;
>=20
> (I think Jeremi has asked a similar question but just to be sure)
>=20
> This doesn't seem to be present in the currently available TLFS version e=
.g. here:
> https://learn.microsoft.com/en-us/virtualization/hyper-v-on-
> windows/tlfs/datatypes/hv_vmx_enlightened_vmcs
>=20
> That wouldn't be the first time when TLFS lags behind but as I don't see =
anyone
> from Microsoft signing this off, let me ask: where did you get this infor=
mation
> and, in case it came from someone @microsoft.com, can we get their sign-o=
ff on
> the patch?

This is being worked on.

> > diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
> > index 313b8bb5b8a7..b8cd53601a00 100644
> > --- a/arch/x86/kvm/vmx/hyperv.c
> > +++ b/arch/x86/kvm/vmx/hyperv.c
> > @@ -477,6 +483,9 @@ static const u32
> evmcs_supported_ctrls[NR_EVMCS_CTRLS][NR_EVMCS_REVISIONS] =3D {
> >  	[EVMCS_EXIT_CTRLS] =3D {
> >  		[EVMCSv1_LEGACY] =3D EVMCS1_SUPPORTED_VMEXIT_CTRL,
> >  	},
> > +	[EVMCS_2NDEXIT] =3D {
> > +		[EVMCSv1_LEGACY] =3D EVMCS1_SUPPORTED_VMEXIT_CTRL2,
> > +	},
> >  	[EVMCS_ENTRY_CTRLS] =3D {
> >  		[EVMCSv1_LEGACY] =3D EVMCS1_SUPPORTED_VMENTRY_CTRL,
> >  	},
>=20
> What's the desired effect here? I.e. why exposing
> VM_EXIT_ACTIVATE_SECONDARY_CONTROLS when none of the controls are
> going to be exposed?
=20
This is wrong for evmcs v1, I will drop it.


