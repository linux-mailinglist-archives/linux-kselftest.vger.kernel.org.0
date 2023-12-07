Return-Path: <linux-kselftest+bounces-1345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2A7808533
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 11:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C9F1F22697
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 10:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1423529D;
	Thu,  7 Dec 2023 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFca53Vz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF11B9;
	Thu,  7 Dec 2023 02:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701943797; x=1733479797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DRHCv5WAhRB3KOrQWsR/0xE5OXpRqjn+7xrlZgK+TTU=;
  b=iFca53VzxvNO4XIegi7UprjjJRSnNsYJZXKDK4QK8/YWcdvMPRKbbR35
   yDAJCfieoyN5cMd+VH6xK141jR+T/VhoN1tjdxA5ASyT4l78VUMCoxBVG
   iwsxcj7iZzgP2wXGaRkVJOgtlYW2IfLk+zPEcLW0cYKfPfN43pUaTpoEu
   aQMUImYtObV7SjT2ylDlOmMaTLloMzPMnZM7zEx8BzRENbnf3T9lPXR8B
   g/YYR+uqMHij5FQN38kXqZP6w2IMNz7GRLO4m3GbYK7PJzBuonh37CHVq
   j7mdKSzagIUcaJp1mm3+JJVxuwZOU6LamiQbuz0ei48tE6tgaksJDcGAT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="374374065"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="374374065"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 02:09:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1103151809"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1103151809"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 02:09:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 02:09:54 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 02:09:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 02:09:54 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 02:09:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0tJ0WhSNyXkp4KlsVQY95YR3q3mB5ffuhO9ieuEMSDgkrvQgJVeKU+M3CzW5KPybNft9hUykeEp82oe1XYHUQm56PeXsY24TPu4A7OkIU0A1k4Vz60PmSKHlAiOPKJhmwmgfgJT9zwvaWxqK02GvlTCXu2UqosBbBbBx57aG8boyCA0U/1C+CVietIzbYnK052k/NHuAmPSw85MZNgonVQlDxNXEA0ekl9CHc1jgy0QexNvbGk/COvECTT8x85mnZX3E1kqBJwpKKf3ET0zxwc6giie0U5YK30gc1vY1Dr00J9tSyxj5ndKYIWcF1/cZtfLEYJ5ekIuhw2I74Dexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fpV/mWabOiJge2xbzHNB89KDwH5FdZ1lNELh+fD0v0=;
 b=AEU4pnlxZ7mCGTm1F4fpEBWbo0qn0IwNQg9yxB3uH5XU/xADArEgYO4Sp3Rz1bqcbFRJxmmMLe3vr2DptepnQwSu3RFQaLdyPo674dCBbXCndoA+lKaazS0P/Et5ma4Ee/eZ7DZpayaORcoZh/T/av3FYQezujdwIGrRET03lNpvyTMGO9CdkGB3uN0JLeTOBhzyRo2uEDOhqyGWxz0ugDF1vBVrvZ/FagRGAgNysrqzutA1R90TTPm+iCSSiPB+Lj52gxRwaoRIbbWsaxO/sCz+QaSaK6mRifDh0aPEuKhZ09q8A2/CvQgub8iYnoiRvnGA0huRc/HXYoF0XhML7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 10:09:46 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.7046.034; Thu, 7 Dec 2023
 10:09:46 +0000
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
Thread-Index: AQHaEnYXOQlvFLhpWkG4lt/jksLCm7B5dqYAgAFC3tCAIVOmcIABoIUAgAAStHA=
Date: Thu, 7 Dec 2023 10:09:46 +0000
Message-ID: <SA1PR11MB67342A44E1C2E17E127AA44AA88BA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-14-xin3.li@intel.com> <ZVMkVmBPVfaMjDTL@chao-email>
 <SA1PR11MB67348D3637C2BC6B107C5CCAA8B1A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <SA1PR11MB6734EFF17E15C68AAD12A227A884A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZXGFcuwwmkBlqq5s@chao-email>
In-Reply-To: <ZXGFcuwwmkBlqq5s@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DM4PR11MB7351:EE_
x-ms-office365-filtering-correlation-id: 3f8bb752-20fd-46bd-c8a9-08dbf70ca3df
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZifDK4y3eASt6wGYDUdtDebqItqKPVFYgJGtZAg67MSIx+YQwXLJNmsV6O5bnYuzJut+4kRHmajQbBEchuJubPMohfIbxM6rOWv7ccBGvvn4DzQpn+ycetEp2goMPrzBLkzSmQFphKWUZSD1RM82/Qas0T6hW08e85Uqlt+koAGaSAMV2NktDEC735WK2/y427E7ThwiAK0zsBPsAN28+nICROVojKoVU+wpby+mHKvbhCh/g1X6ScpTrcUMn4QfoVDwGQgpF291SBN9qOTHR1TaIPEyXxfsWp+DKj5zKT2e4Yac6FNu7rNeIxOhCgunyX2Ck3/Je9zwjr3SPVa4/aSDXDUcKT65Gv7QcTpEmJ/PUFdLvr/Ki8JIPcQJcd2DUcfd4CKAM4AlzLYBxCu40kpBLBvWS23NTA1nKvSurEyxzPjJxYCv/R44VPCcTYEC8Zr0jMpIRx/87oZuSZ/XoK56CHGnLMKC/Ss4X3S9RTDRCfQ4Dzduo8p72mmqcPWWPg9YzLtyYiCn5aECifFiNsn1aEqXB+tfBtSmi5EM/tAXKvRnrREanlQdAsbxhX/NlnIqsV7y21f+XUvF4feK3Zgby0+gfooLI9nsafis3IxQLjM+7BhuVzfj8tZmdGqpA9RN2Ahx1JRgh3DOWgw1q7nXtFk1sjgrmasprlpd5TE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(186009)(451199024)(122000001)(38070700009)(2906002)(38100700002)(26005)(83380400001)(55016003)(86362001)(82960400001)(33656002)(7416002)(7696005)(5660300002)(6506007)(71200400001)(8676002)(52536014)(6862004)(8936002)(4326008)(9686003)(66446008)(41300700001)(54906003)(316002)(76116006)(6636002)(66476007)(66946007)(478600001)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d86xj6oXZKLCWQJ1rY4Ef4QFVMTleOLYe8sQEf9JiXIAO4/phBket9yjqNYO?=
 =?us-ascii?Q?oIyB2s1eIWYtOU4w1iVJWmR0AtDsSXfiNJZQL9a5MhOhHvPN0ZiuosoasF8t?=
 =?us-ascii?Q?ub0mYiO/NCKTUKgOlh8X0tiTg5UYb/EB/czMJkJwtaMV/+xK86wl6hbgBJnB?=
 =?us-ascii?Q?snAt6DrSg0XNwFUYDABdQ92bOdlyjTgvCGOo/MtdLf7hPz9+37LvZ8phD5gI?=
 =?us-ascii?Q?l2SzUtO78x33WLs43+NSvKCNT7PAnRJIU+ejSvZsbJpuUjsydU4gv27DWnIP?=
 =?us-ascii?Q?J4vztjH7zsNaqnl/foXyQb5gzPrxo263YMfZ/45WkPGNJ09bEIgAG/bkVNcn?=
 =?us-ascii?Q?VCRmG1kUnlVyaEslbHsaDluDnFDMBIce1gr6CUub3o+SpeDbAuu0HCAbYATP?=
 =?us-ascii?Q?Zb28dWRsTeq/XmRCCVQiMjkNroo4RAqYJGHrZ0BdM5UCZfJVF4ocH5Z/2McA?=
 =?us-ascii?Q?U69iH/oFbQnh5KqUroW/3wISbRIR56zY5rnQBSRn2kZuF5h/IEhluErQ1Rgf?=
 =?us-ascii?Q?mzdqOVQH2Npz3yhwq1o2y5YYIK34QuLvsqpcmiU+uIAxv77ZoWfGyM1ZezLn?=
 =?us-ascii?Q?8EIMmHI4Ppo1XYx4TL0SNyryLUdFkOA2VS8g/ycfGlwEPx+FLd/zYnbDCvtq?=
 =?us-ascii?Q?QT3lH6BpOixdXyGeRkbHP2EG5fdvAcW1aQAFZj/j9p3nTCxHZb+TgwAwqBL0?=
 =?us-ascii?Q?HEI54XivpJ2wYROgbAUMJVzRQsWarhNkuR84vG8wk2ET8mzKzVh7OYv4uJ3K?=
 =?us-ascii?Q?6UnwOPzSvz1wxkkJ38u8UU1PziWyGhX9CHw2Mtg7ens38NnPZUn1b5BEDHfE?=
 =?us-ascii?Q?E3IsaqIXD7dC4F3Hg1SUsCXkmrBPk7eyBxNQLr77+s2+8pOBfX4IoUmLO4s3?=
 =?us-ascii?Q?F7rpI2zwwNz3Vuom6Crl4+4MOnpXVuKz1gi+mNJdPthJ9GPFjDTL50k458yZ?=
 =?us-ascii?Q?eHPXXezLBO1Wtzhq7rFP5RQzn+o+YSJUKlNBseOKRxNZWOqHeqz2CPUIehWF?=
 =?us-ascii?Q?vDKDqpJuzEigxrzVir/NaXnXfkvN5bt1M7x8iQgAp7dYBO1lCnws7qeKfQ9w?=
 =?us-ascii?Q?OaMx0xoiQNxcSSNr28qL/VZI3mHd104IhsPCUjR1RkSb9HZ1/taaEXcKZjSK?=
 =?us-ascii?Q?GyKKZg2tyZIuyKb/TngxpgVGJ3KiP9LawBFz1y1WTQJQgFKF9td15zpZK+8X?=
 =?us-ascii?Q?5tTw7Z4q6RAE3fC2meFZiN13yl7NX8BHiGR0YYgqWfiWPEcnFDqMiDwMwz1p?=
 =?us-ascii?Q?alQqLzhVy7AkJGCWvVvORTxaCVgxeqInIfmMt8lwysyImhpoOlX4IVu1S8WV?=
 =?us-ascii?Q?65mj1llQEPfJYxbVwDyyKQxq2lHAheIU3NGj8ixyflK212wjHA6OU0gDeD+b?=
 =?us-ascii?Q?otNImXSv+i/ZkAQeXIb1CkUaZJnPz8N+VJA3p/E9IKkBZhLerqumIy7zU6py?=
 =?us-ascii?Q?JCSEs8PSgyUxm8K3igzDbpCiOdgTzn8w7wAF8tohEeJYZtc4siKXd5ytamhK?=
 =?us-ascii?Q?WDDjKaSxOtTmJ6UU+/9J+wFxtoeoSzWfciXyJiL3cpHVSGne+OrioNNE9PQK?=
 =?us-ascii?Q?uBC0SW5un0lr4edNZwg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8bb752-20fd-46bd-c8a9-08dbf70ca3df
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 10:09:46.3842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: blCkVG2ftWahGx/O41NyKoDFJfGO4SyyA8Bh3PgdFFy+IyE9tXsxkP3tPahye1GqIo24tXBHR2sSTVBJiGaB6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
X-OriginatorOrg: intel.com

> >> > Exiting-event identification can also have bit 13 set, indicating a
> >> > nested exception encountered and caused VM-exit. when reinjecting th=
e
> >> > exception to guests, kvm needs to set the "nested" bit, right? I
> >> > suspect some changes to e.g., handle_exception_nmi() are needed.
> >>
> >> The current patch relies on kvm_multiple_exception() to do that.  But =
TBH, I'm
> >> not sure it can recognize all nested cases.  I probably should revisit=
 it.
> >
> >So the conclusion is that kvm_multiple_exception() is smart enough, and
> >a VMM doesn't have to check bit 13 of the Exiting-event identification.
> >
> >In FRED spec 5.0, section 9.2 - New VMX Feature: VMX Nested-Exception
> >Support, there is a statement at the end of Exiting-event identification=
:
> >
> >(The value of this bit is always identical to that of the valid bit of
> >the original-event identification field.)
> >
> >It means that even w/o VMX Nested-Exception support, a VMM already knows
> >if an exception is a nested exception encountered during delivery of
> >another event in an exception caused VM exit (exit reason 0).  This is
> >done in KVM through reading IDT_VECTORING_INFO_FIELD and calling
> >vmx_complete_interrupts() immediately after VM exits.
> >
> >vmx_complete_interrupts() simply queues the original exception if there =
is
> >one, and later the nested exception causing the VM exit could be cancell=
ed
> >if it is a shadow page fault.  However if the shadow page fault is cause=
d
> >by a guest page fault, KVM injects it as a nested exception to have gues=
t
> >fix its page table.
> >
> >I will add comments about this background in the next iteration.
>=20
> is it possible that the CPU encounters an exception and causes VM-exit du=
ring
> injecting an __interrupt__? in this case, no __exception__ will be (re-)q=
ueued
> by vmx_complete_interrupts().

I guess the following case is what you're suggesting:
KVM injects an external interrupt after shadow page tables are nuked.

vmx_complete_interrupts() are called after each VM exit to clear both
interrupt and exception queues, which means it always pushes the
deepest event if there is an original event.  In the above case, the
original event is the external interrupt KVM just tried to inject.

