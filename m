Return-Path: <linux-kselftest+bounces-72-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF217EAA68
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 07:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A3B1C209EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 06:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F86910A3C;
	Tue, 14 Nov 2023 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4Z3Gyix"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008D101CB;
	Tue, 14 Nov 2023 06:02:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293BF124;
	Mon, 13 Nov 2023 22:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699941777; x=1731477777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qfUCHmimlXyjo6SomxYWIxtf+pIp7ei/3smI4ho/R0g=;
  b=B4Z3GyixQT18l92MK/rNqDeRk1mVM7bDc8M/Bnk1O4Nc7KasZxcg8z5k
   Rc8/tSrvuU9igTh1enR5llZQIk/gYGicQEHklWSZPQcJOZ6RgavURDioF
   4RLox5ccJgD2x/U1E2HC5l229yBGqEO7b9/zcR0Mqp6QU97xa2a+V8d33
   n5mMDPRoQPeYcDElJJqonQF9Y/H85XP2h1f8Zn/H0qQvqKLmPOt2exGQ7
   w7YLGZRlLcQPm7loSIN/6SQcG+DEfYZG1wwt5NAMPbqZGdxhFjs5fFt4n
   gcpeXayKa03YKkeeqemJyvj7XU4JqgaCHbDLCC8+dK3/9lAdtj5rVzr2F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="387752198"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="387752198"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 22:02:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="937960747"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="937960747"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 22:02:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 22:02:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 22:02:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 22:02:05 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 22:02:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BU0DyW1KcFCnYB8KsDj7911jVP3PsJ9iaCAo9ap5gIdN4LjLufEHmR9qTFXRXdRSfWdxn2lfqQHyZHA8na3Mj5ExOpF0dRE5eweJt9kGqYOlZh38CFmyzpWQ4Ql7tOAtRp7fVaF9Y5+IxRP2e1WG7zSqP6oTk9Cv94gzCNlEUa512UoHpeFOUFf5ER6BgIiU5O35ZgnNnv6Ytm1lI3BV6PHZCKyrlNc+BJcbasm7lZzLGTNzoJm5uOYqAb1ZA6pXKrhEo6oesG5TnqL/M5S2wT86uMRU2LW3epl8f2GnJLjgi38a7POnqQ3Ob+MscoviyadcZPTK4NyWz46MSkfp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IyVVroUwUTvMnrSProQUgLYMZjQD7Ea+eVSsrbNKi8=;
 b=JnhVFDExzA2INtwz7XX5qNQz3MKJ4UH0UaiFiiVjyTWJ6OHwQbDUV/JVQJ3T0LhqiiLlHa7Wa4BrdOpdLYnyc/xNkWW9MvjS9t1T+ystGxqP7kTLTgztB061ekDAXCfwISDV1jYISy8gSDMrkfp/ZyIyg3y5E4MxhxMqLIJWtpu2SYnpmkT2/0/7GfJUfFRzmmXy22VAdwfR5Cq+FaF2CK5F5osr8+3a57Zd4SEAdiOyWt3VZFIAp7Wg/0sOcMQaDB9H3OT8Xg9L8KxlNhbgbQeobbOO0gYxbmvJqA6mmC9Medv1IRWRcPijZAxfH6zexaAkofusBeaZsejJPIjfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 06:02:02 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 06:02:01 +0000
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
Subject: RE: [PATCH v1 08/23] KVM: VMX: Initialize VMCS FRED fields
Thread-Topic: [PATCH v1 08/23] KVM: VMX: Initialize VMCS FRED fields
Thread-Index: AQHaEnYBo7QIXf2yMkSc9/SUosFb0bB3l1MAgAGzI4A=
Date: Tue, 14 Nov 2023 06:02:01 +0000
Message-ID: <SA1PR11MB6734E58758C5611087B5E688A8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-9-xin3.li@intel.com> <ZVGSQHdt39vwkeRh@chao-email>
In-Reply-To: <ZVGSQHdt39vwkeRh@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|PH7PR11MB6676:EE_
x-ms-office365-filtering-correlation-id: 15e26cdd-6221-41f1-0864-08dbe4d73816
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tfn8sMF4EF/6ipEyR0cuIq6lqmA46u6+DNE3GUDOT7ZwSVWyztK02x8MJfbfis2HBerFHvYGVIoIQ/Fyz3OShkBXOG4j6INr0MM7DdyJZYLg0ZSy/UV3KSXiGdsiB+OA9qJQFIun1XVmpNiefKsT/H/no+jDfATQLfy4gfVdVilFqh47uYCdkXbAQ5/CIdVrrXoiLpAz/sksSfqJofcshX39tNv5jXVw3rV3CnTpn/uN01eo9B98nCW/QIu+F3XBAYL2OaYIW0dz9nprhQ5DRkXzWaebvo9qInl5gj7gvQ1AQZK+L8EMmYxJpOjrbdPcajAyXb61IA0kocn2gnnbvHiSUaXYgVECrl90z2uDbfCIQWrWJVQO7hY5HhG1A9cMrUzOfv7WnrTyc5UUfv3uUp9iagYrIxVsiEjBxUQTKZorw32/y7ywkgnZ/OWrBgqsDfJPGdCHfleAeAwOAZMn90u0162pl/Aa8kx2CGQVLgNxBR9Oh9dk87uEC3Fyve31faPqbIAqYxONw7zXRf0WNgZwks0I9LkZl2aJF0XMutZM1ybJpjrdsMkf9YdvqednGTFOS7WC6B+4Zc3WImN+MSWDk9GzsdW8L8Jw4c40/DU01cDbL4eTJolRHUqAx2Ch
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(8676002)(6862004)(8936002)(55016003)(41300700001)(5660300002)(7416002)(2906002)(83380400001)(316002)(52536014)(38070700009)(4326008)(33656002)(66446008)(66476007)(64756008)(54906003)(66946007)(66556008)(6636002)(86362001)(38100700002)(9686003)(7696005)(6506007)(71200400001)(76116006)(122000001)(82960400001)(26005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jjwVIDGGZXaH0diwc2kgIimSaanVxblNqoui0aomYq3jMBDIQreI4fnT897a?=
 =?us-ascii?Q?5o2d4yw5EWJmOu80Xi2E87GC9NOZQmKsCmPrMEYrepWwjp6Vl9dNu/FhIkZ8?=
 =?us-ascii?Q?tSfJPgVC66/6hKKFUzlUqF3XQIR6btOr+ixc7NpiBjonK7mFNpDUtcEseWBz?=
 =?us-ascii?Q?MVlFBB1SyDmD5FLh2kWOAa4igkmoZl7L7Fxz4fPfmX5ZaV6sOQHNABaSbQ/c?=
 =?us-ascii?Q?DytXOlN2Ctmvgf3zv4E7sneHDQi3EYYvBBJkC4xWyPXIIaoXygbl2Qx7Qike?=
 =?us-ascii?Q?qWc3WtXBv7afuPIgbOh12rgaVSUxdoC+Xfy/MmKshsVRVK4iVBF7ZXHfPeYT?=
 =?us-ascii?Q?O5ALfJNqCsjxew6sJt2kT4lTl7Xh3OEYm2mlvb/xoTZx2IPR71eJg1xWmq6E?=
 =?us-ascii?Q?Lk7Qfolo61+EjruJzdRGpklPYwnv3QIxkDNv3az0SdN8SZ396kPHj8S+2+zA?=
 =?us-ascii?Q?Pdf1FraH+44xz3rRUHVzfO98/QDt7DOihw4ADVCPdqXhgQRoAlK5JC+r0TCA?=
 =?us-ascii?Q?osZu4O627k1i21o9XHn7NqM0X/KpllwGClozwiybEUYankrC+PrRHlFBI280?=
 =?us-ascii?Q?Br0vzzjvWEhxdzGHYGGHYcpbkKTmZeqnVX+prWBTs4GD9Hs9JCasK/IvsfMs?=
 =?us-ascii?Q?JiF2QeXhRnG0TohoMgNl86PS1dgqB9wE3bbGc7o29RYxdu1sQcilJb3VzUjC?=
 =?us-ascii?Q?+KbuYvR2CzU+XaxbqBx8F1C56zcxPUPllOl9cNR6bFYLz53vFd6lbqbT02RQ?=
 =?us-ascii?Q?BAwlAVt29tUp8JTI8bRxuGDBiA3Psm1auzFAJ1f29r1DcVhUG9hF21OXW9Yu?=
 =?us-ascii?Q?TFJR3DuhYM45/Vp66sxu9KDW6RgAhBBxs4kn2+jRWeTu3b+Cs7X5zrKJDeP4?=
 =?us-ascii?Q?dklDdCdP5NfW+yoHsbVC9WmKu3qmTTOfFqzUJmiGGN7SY56n3ytrDvq6fIaB?=
 =?us-ascii?Q?TlTiE0XI0FbUV4ku1TY7ePaARI2hHPYFqaXNZ/nqC+i33qQegSDh07xAstzB?=
 =?us-ascii?Q?N8YCkHmWwXHhdPxyCVkmg0W/gteLy+NvrkG8hD8ciApWv1N1fWObjE+9hBHF?=
 =?us-ascii?Q?Uo2buFv0brCPHour+E86R5BKrnP/nQnwW4STx52h2DtVlzGxC1GTKw+xiD1U?=
 =?us-ascii?Q?mZXhY/aBiQbKqRM2oTgMP8Z0x16RARfOZdlW0DxzuIjq6828a/quz38S1wiB?=
 =?us-ascii?Q?lxEsWZLuTEsf4JeIg/6mdygmKlCU3iiMiLXLwj4J1sxKUidck9DTpvqAxapT?=
 =?us-ascii?Q?8kRthzlQ90wpQY2+sOn8lcZ3T8JuvstscdeBnncNyaBwVdxsNs7CjQutStDS?=
 =?us-ascii?Q?JtRuD2LoiOwnagNZH3RB1XHCBNeMQFKHZ29bHBLYvtIHhOJ0JiI6iGTZf02p?=
 =?us-ascii?Q?maDvGBYH2ZPmplKoRFs3CIkNCUYvRylT+r5F/3fBDCVOURu4Ux9nLNfjl74m?=
 =?us-ascii?Q?4WMIUqLW1q2IrSnGfema0jvHE9Hb3SvLtt2sfab6wDQn1w0n53hexHACbskx?=
 =?us-ascii?Q?5GPoO416fmnURxAEBleSYAd3YI4QO0yI068rGU8Ldl5vcr+eyzfwxB1lM/eq?=
 =?us-ascii?Q?4580uVQ+vNyuMqVxDd4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e26cdd-6221-41f1-0864-08dbe4d73816
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 06:02:01.2768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qux8FGhBeg6z8MoF50X9Xjkl3CBdv6ix7ZEEDiGOjaUE/MgoFM7pzFf/xi2hWagCubZMhbDsAqg+tLcA8Uojcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
X-OriginatorOrg: intel.com

> >@@ -1477,6 +1477,18 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, in=
t
> cpu,
> > 				    (unsigned long)(cpu_entry_stack(cpu) + 1));
> > 		}
> >
> >+#ifdef CONFIG_X86_64
> >+		/* Per-CPU FRED MSRs */
> >+		if (cpu_feature_enabled(X86_FEATURE_FRED)) {
>=20
> how about kvm_cpu_cap_has()? to decouple KVM's capability to virtualize a=
 feature
> and host's enabling a feature.

Very likely I guess.

> >+			vmcs_write64(HOST_IA32_FRED_RSP1,
> read_msr(MSR_IA32_FRED_RSP1));
> >+			vmcs_write64(HOST_IA32_FRED_RSP2,
> read_msr(MSR_IA32_FRED_RSP2));
> >+			vmcs_write64(HOST_IA32_FRED_RSP3,
> read_msr(MSR_IA32_FRED_RSP3));
> >+			vmcs_write64(HOST_IA32_FRED_SSP1,
> read_msr(MSR_IA32_FRED_SSP1));
> >+			vmcs_write64(HOST_IA32_FRED_SSP2,
> read_msr(MSR_IA32_FRED_SSP2));
> >+			vmcs_write64(HOST_IA32_FRED_SSP3,
> read_msr(MSR_IA32_FRED_SSP3));
> >+		}
> >+#endif
>=20
> why is this hunk enclosed in #ifdef CONFIG_X86_64 while the one below isn=
't?

As if the compiler doesn't complain, I should NOT add it.

>=20
> >+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
> >+		vmcs_write64(GUEST_IA32_FRED_CONFIG, 0);
> >+		vmcs_write64(GUEST_IA32_FRED_RSP1, 0);
> >+		vmcs_write64(GUEST_IA32_FRED_RSP2, 0);
> >+		vmcs_write64(GUEST_IA32_FRED_RSP3, 0);
> >+		vmcs_write64(GUEST_IA32_FRED_STKLVLS, 0);
> >+		vmcs_write64(GUEST_IA32_FRED_SSP1, 0);
> >+		vmcs_write64(GUEST_IA32_FRED_SSP2, 0);
> >+		vmcs_write64(GUEST_IA32_FRED_SSP3, 0);
> >+	}
> >+
>=20
> move this hunk to __vmx_vcpu_reset() because FRED spec says
>=20
> "INIT does not change the value of the new MSRs."
>=20

Yeah, will do.

