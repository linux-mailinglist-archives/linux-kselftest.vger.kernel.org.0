Return-Path: <linux-kselftest+bounces-107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539A97EB6A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 19:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823831C209C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 18:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BD617D8;
	Tue, 14 Nov 2023 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuL0PvZ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15501FD3;
	Tue, 14 Nov 2023 18:57:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8206BF4;
	Tue, 14 Nov 2023 10:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699988242; x=1731524242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mIQ3NYEzRnjrdVP+TVXurjNIBKW6+G/zrCUqt4urNmg=;
  b=iuL0PvZ7IEuVaGf2Jg6DTuMe9iHn8mXFO+WvbkZhP4HdbFdbJgf8h3Fq
   sq8ENXRthGOiqVmpZatF5zcG6+NLw3jTGn4px2tHVgUU6Z18sZXPKGq+d
   mmMsj4uW3RkTeh2yWG27OC+uFByUeTrRVhB0wz0omzwFF9Y21b8Ao58dn
   OX3O+tFBDGSseaukxKX6PP7gIo7iteGFYf1hj+HqVU6GamPkl3+a2vkz1
   qd0wxUhKDql2AEWrIheeMLVSRM2VDCTTW+Yn5WPrtJDPjrmg78lVZIP7B
   YngT+Cx0ofdV8g13tSK61kiBXoSO9uAT7jh1ToOPG76VvyFurzhBHRstx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390524837"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390524837"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:57:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741183020"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741183020"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 10:57:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 10:57:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 10:57:20 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 10:57:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9yZ2FlHdl2UW9zlef3xApxeSQF+7NOkNFgwfrgfHvaVoY+NsJvGj75skQmAEi2EQByvI3Yg8/UQweHNyhEvzrG9Ap4YjaD887YZ+lh1q9MJAsf+V9ECgx+P8obQjx4bYhf5HE1pe2c7Zp+kMqJwiyOoAOwGkxYWyXyKt0OjDPO0FZqcVByl/0diPZRctk9vOHfp5glCOI170FMWMVP1A/jOEQXxhtZfhzS/l+br8NV37AtPLmS5Ss//Ftr2BpBHUUecYD7kF4OHM4etlSu94AnrY64T6XHvCUGWBbncFB+ZlI713Pa5KH7catuDZPzGjaY1DBVAWWhM2QVh06CRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbltq3e2oI1fLym5erik9RctMwp9wceZNOucrfjW+7g=;
 b=nQKum9ly/MCx02V01GKp2yq4wTCf2InLrNgBQeyqP7dJLXOB878ThwJlV9ZH6zuZ1ZASqHkZtoB51x80BT+MtvREyio97zUzdo1cPOZl19Xb00gQbIosGHaOSF2XCR6YQD0gKHoR3oeZ20RUPoghGti4g0XQuV7Tv1gaUc7UtKqC5pRNiH//S75YJcZuM8EORKSbbCq5WwE5CFEoeAJZ2gmAtY8JE0Wl7kr1MdoABkGAOj3Wyl/Qj5G7oqKMOZuJuOwGNgy3HtMH7/LrDQLF0ZOZq0IMwFo+k7s4bJBrCFAdXDjpACKK/O0BTrNyG0KMJgSMpfnff7JbOehKyS4F4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DS7PR11MB6175.namprd11.prod.outlook.com (2603:10b6:8:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 18:57:13 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 18:57:13 +0000
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
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v1 11/23] KVM: x86: Add kvm_is_fred_enabled()
Thread-Topic: [PATCH v1 11/23] KVM: x86: Add kvm_is_fred_enabled()
Thread-Index: AQHaEnYQluTSIDRVa0GExAiuYWhTULB34v2AgAFfwqCAAD4hAIAAsgnw
Date: Tue, 14 Nov 2023 18:57:13 +0000
Message-ID: <SA1PR11MB6734EBD796D139957BFF2457A8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-12-xin3.li@intel.com> <ZVHRufhNmVTvJYWV@chao-email>
 <SA1PR11MB6734074A2E482AF6F911693BA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZVMs6vZyoqd2cUiV@chao-email>
In-Reply-To: <ZVMs6vZyoqd2cUiV@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DS7PR11MB6175:EE_
x-ms-office365-filtering-correlation-id: 3699b54d-080f-449f-6b89-08dbe5438378
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nFzykWDHcv0zcph0eCcrmnpEKc3ZInkfGLyG6uElk5EJ1V0nPno6xnsrYGAeblYSMrDDFfxysrImO2/16+1g80RlX4/nuYdGLbpxl9w3lfY3qD90yak58kQpT6S72LEWIzapRQL1Yv0LOYEw5TrmTu5E4qn0Au01qr6fnHT3pXdgjOaGT3Xkc4uYs9d+mk8RLysdu0et/TTpYO0CPfokSSdOKutX0BOwU77fRonZuYhJ0jKDslcqjTT3UcXPsl8rdcRKLbZcfKusKXgYnC/la6PfoYgCaqmBQZKchyomaUBIxPQxR+WRqOS0deNYpRw3q/tFw0Di7jdhCOBIvCa03N8GaBPSP8sE6WG7yAYqO1b8f4YJWsHRtbnJ64TOQEzTBVehybQ3dDo0GnKnEzbBr0K5rEz6817Hi0R4IUu+sErzi4oAv3IAATr+iWEuA1Yb46rIWtL0+H8kaYXoPS0wRfAypgljqq8nqX1C684zoiaDFg6Q4Xs9k8q8ZPAuvy7xbMsg6tmcndj59P02rtMHEbVsP+7+Iz0/mpC7qI6Gg3idYNDqIu8CiFo6/ODERSKyJvRfgjM5YyPn4zDT8G9N9vyUeS/q1U1oHOfrNN0/8r7ROJWrK7SwIQXfukIG7QKB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(41300700001)(9686003)(55016003)(8676002)(71200400001)(6862004)(4326008)(4744005)(8936002)(83380400001)(26005)(2906002)(478600001)(122000001)(38100700002)(7416002)(5660300002)(7696005)(6506007)(52536014)(82960400001)(33656002)(316002)(6636002)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(38070700009)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q+ys/PjCJ7YBApgcEbVGhkRZKjz6vGiXjEKKn8Kji5bEmUidudVXIG1B4v2+?=
 =?us-ascii?Q?AGGpABQA2lk8P82JE2eFPOD6j9OAA3pEAPtxTdbOi+m6vip6exW5SdKiXi7n?=
 =?us-ascii?Q?vIZeDuAKIRBvdvRnFgJsFYCzimJWhdSSoXFNnUtyfsgEuz/s1tuG2KLoCtJO?=
 =?us-ascii?Q?F4Z+7D43SUEmM35L3j21wZr0R6eEffTOb8dxjy4kgGnj0qUDN95MldFa2dO+?=
 =?us-ascii?Q?WWY7liMHAuEuQZwODWabuLn8b6DFZCSTGypVL+MMz8Tt35PpY+5Wf0kP8Y3+?=
 =?us-ascii?Q?+32qfkvlWfRUmM/HYQc/DQeiMdDyb0gCzqBxP8vQSUMkuhpdbQTIVIslLXYj?=
 =?us-ascii?Q?KQbZwRbbGLW1kjcyYfNX7nRE3IJOe+kWTqAIwsnMp/kaan0D4c4K6/jDGBbZ?=
 =?us-ascii?Q?RrNtx6HKpk5APUprCXmPcdsi0K063s2zUFzLR+PM+G+n6Z1LgPHpkjTRVDHQ?=
 =?us-ascii?Q?gs9WdNORqISbbRy5d0io7Wvw5nwT6JCjPuh2BkPVjg0WXdNt+TWapyxLbN0K?=
 =?us-ascii?Q?MM6GkSrKj4JTFxxzZ+M9V85RlsNBI2H4oG+fOfFx0nqjchAVbiVGz3tbiEWG?=
 =?us-ascii?Q?x5ykgrtMYLqEyXRZjwsx/sjFR6O1UDEWJBEc8w3nPMi12941jUN9ePbnKneA?=
 =?us-ascii?Q?WGQvSA/Vah9xBOyd29Xakqio6u7Cu2W0Sl3A/9cWI3GMEV6OGte6ruriT8sC?=
 =?us-ascii?Q?V6o4s+GzipYXRwrwtGZSGVekAJG9ctE+cKP+4LLootsQ7t+sfBmaqEC3pu0t?=
 =?us-ascii?Q?IpgwHtl/CgWSlA9JIWYaUiLu5WUpzhKARHsTaFfn90YpGcYu4WtBdXGVE7zA?=
 =?us-ascii?Q?255i8i9VOH1lSeRN/oOqtrbUX+Dr/oTx/xVGc4ZBxgdE4O2+OQsWraKqJ5/2?=
 =?us-ascii?Q?NFT4RN0/05SUekQgiT63ATseJAsR9yBUI1eMpgy5DQ4AaW66lbR1lSFhEYGY?=
 =?us-ascii?Q?7OplgZBw/53MpmGINGxHoQyzaXQsKCwNqOXARkzeNwlxxuhgO6/4db247IYX?=
 =?us-ascii?Q?WiFx4KD/MYhfaBvBPD2vz0U7vzHJZ5r+u9Kaqa0wbMQuaPjDwAYMctuY5nVw?=
 =?us-ascii?Q?FubggYYdadnA2HwZ7fTr3j1frvg0ezUdK1tses+X6+ENjJokW7y2Ae4eWXVJ?=
 =?us-ascii?Q?9YGAi4Pefl8Ioz96wFvySA++9w8Ck2JdydqOidR4rz8byv7Z0FiIEMqy9rka?=
 =?us-ascii?Q?RWt+GDo/o+MQKu0D3R0jHLHTXSH77DAcruFjNO8HoCrwqBWY9KYqPmUqTWeE?=
 =?us-ascii?Q?j5txgjhVdtyKznr0xrGcF8LT5Jbid6ysVutmPZfACBiV/6y1kt3gFiF5yUaM?=
 =?us-ascii?Q?sF40MrMLozrO0SVyP54l2+NaUw3vkq+z9tJCcpZ05beu3w7zUsMFamXS+wyw?=
 =?us-ascii?Q?Hlp77wr3FNFUYG4bkz1nWUjtzWW/m/2ztGt7j80lKoim3G/vbTBnsY/AexIV?=
 =?us-ascii?Q?I974ixEk608w/yA9fSXFhMAaw2p4P9URr6JkHBYyzsV2f8s6qRFolINmG6iT?=
 =?us-ascii?Q?bpUYVaECcBRLXP6j8xVKVS+m/ExUxzFFTDxx7uACmGLGI8lBDwtoALD82O5I?=
 =?us-ascii?Q?6b4jJ+3ienw00YJN3P+IExm1SiDINLKSwXI/FF17?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3699b54d-080f-449f-6b89-08dbe5438378
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 18:57:13.4270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QCUmEI7H7spcq//D6vkj77qx8q4c8wf3OyXK2WU6HTd8ghaX5pgcnN3Bxm4/F6+Eustb1iNQK+2xa+Xi8H27kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6175
X-OriginatorOrg: intel.com


> >> FRED is enabled when CR4.FRED =3D IA32_EFER.LMA =3D 1. Any reason to o=
mit the
> >> check about long mode?
> >
> >It won' t allow CR4.FRED to be set if not in long mode, I don't expect i=
t
> >at runtime.  Or you have one?
>=20
> I was thinking about a very contrived case:
>=20
> 1. the CPU enters 64-bit long mode and sets CR4.FRED
> 2. the CPU switches out of 64-bit long mode
>=20
> and SDM vol3 chapter 2.5 CONTROL REGISTERS says:
>=20
> A 64-bit capable processor will retain the upper 32 bits of each control
> register when transitioning out of IA-32e mode.
>=20
> so, to me, it is possible that CR4.FRED is 1 while IA32_EFER.LMA is 0.
> and in this case, FRED should be considered disabled.

You're correct, this is a solid case.

It's not one-way, but I forgot the other way around.

>=20
> Anyway, I think we should align with FRED SPEC. If we deliberately omit
> the check about long mode, please add a comment to explain why it is ok
> to do that.

Yeah,  I will add it.

