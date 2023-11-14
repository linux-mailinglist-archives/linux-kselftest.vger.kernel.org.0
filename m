Return-Path: <linux-kselftest+bounces-70-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C97007EA9CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 05:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F561C20A0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 04:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8A9BA46;
	Tue, 14 Nov 2023 04:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLTtbJWe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A096B660;
	Tue, 14 Nov 2023 04:48:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4368911C;
	Mon, 13 Nov 2023 20:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699937318; x=1731473318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d+u9lzVqcPBFUxd1rsh7J6zrkFnr1Ka+joiLBlNDzAQ=;
  b=ZLTtbJWeep4MutXZpmpUsIQB9LI92q4UxqhPH16MbBD55RAtXhD6W2hm
   E+dnLqCK3m3SnkIP7VD8p3bVWDko1yBfOjWYtlocHBqh4G9WaJeKsGzSc
   A+fY1hkD93ZN2T/XhJasx0in8zIQpsGrYr4dLkehfpn37NzMRZJBADY8B
   e1OdLrjBEN3sISAWTE7dhJSLmbCrqf1p0c/doYTHlcXBDiHg7UaSnqEdE
   T11C8QspXDkwuKb6L9IdLSJSXuupyeY3Bp1wWMZSgSZSeJtw03V630E9n
   xW8nxxPBrL+1SU96lHlfHkB/CwWFt6WuTIVB+CireF0zPkBTaocQkN5PF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="12125759"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="12125759"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 20:48:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="830470131"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="830470131"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 20:48:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 20:48:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 20:48:37 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 20:48:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEZFBvgqwyo0rJHxmOhoxZLkSfQPR5FaBznK8xWWt8afug5XwsyrlB8wX1llaaFIR3gtj2wNWBj1TC3hTNNJT0/AEitvozv6ek+/J5g0KghzU137QPN+iV2wiPhHHPIeozTCKS0u9Lo5rRV0AP3nNRJ3ipJN4twJWwjoAb7sxRkx7wbzbgNMxizJbwzqz4pP0XiNYEUWEjqEUnXjA5Iyjk39ibUs8z+/56m/8WxWlCvDilz+8n7B0aXwoNDeyxiNBkwy5IaNhh4uJ00Ik9h6WyK05iO9vE192BSM2N42HvEZUyko2IBtHyKJLoJrtTZwiQeTyrt3mxIV9HaY8cvL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9W4CD3AOXJGC/RPQSYYfGN4W8ESs+yfxcMnMZpcrVL8=;
 b=iPkP02o50tD4fCLmluto+AILfoewvb22lLyZvLl51kHtwjPpJAWEpGcoXO7pE48+Li5zjYAAJA/FiED99d+iuOPLCz/OmuGKaqAubFH5DnX3ARl2h1Qi4kpZkncVbB2x8bbiPopSBxGp+1Zhsnxh5duUibXSOiupQtiug/6iwQ+UY2ky8qF20bcrH7MvBzinmTyEw3ZoBzwHpeA8DEFjIHVd3sDxy9ZlOECU+V5jAALpRqY1mlsqcHRN0L/Zc9r/CJkfZyd/JsAEHpTh9Dfb6RfZKiC+EzK12GGxrozwllot8yOQp09UrXUDEPSiG2SexIsGLLjuwyHcKOD05pqRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by CH3PR11MB8520.namprd11.prod.outlook.com (2603:10b6:610:1af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 04:48:31 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 04:48:31 +0000
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
Subject: RE: [PATCH v1 10/23] KVM: VMX: Add support for FRED context
 save/restore
Thread-Topic: [PATCH v1 10/23] KVM: VMX: Add support for FRED context
 save/restore
Thread-Index: AQHaEnYCkIW9zFmRyUKN8egowj4StbB3vmuAgAGGtXA=
Date: Tue, 14 Nov 2023 04:48:31 +0000
Message-ID: <SA1PR11MB673495D9F346EF15C3A958A6A8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-11-xin3.li@intel.com> <ZVGzC66k0QtJywi0@chao-email>
In-Reply-To: <ZVGzC66k0QtJywi0@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|CH3PR11MB8520:EE_
x-ms-office365-filtering-correlation-id: d1d2b303-dc9b-422a-eadb-08dbe4ccf3a7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UOfD+dpjjYz/4hq5t9S7xgPcAAMPeG2tq5O/fTFOChB+W7K+8qIc3Wd2KC6RFxPM2wsohhkzb9jKyiwfLQ7rEHpNYNt3h5WGZoIen3HhLindZWMIrEWTGtccHEsFqahyYurhWNlPPzKjMKI5e65u3riOZ0J6LyjUcq2LcYDjtzZywVdUJu/+V/R+B+OQMwOt6SbAYUJ+gRTTntgdKhmW6M5oT/K9Jl5nx42MUtLTIK6/XRbgR1SI0koC2AmcefOFnHWLFBOXe7KTUdfIBqYtze/kdBn5UvlkqbTmMwuDQqMpc3Io/RWNSsuLJfVzd2euzTs2mIufgBeYKmidoBg44mX3X7fyBvX2W28hivs5a2FSeXMWYLexAjMhznHg/WAl9x4AXN0W5j/8J/5ixIdUimQDZ963syzgzjE5S4/VrBsLhuP9ed+wXTgPI8LPNWkubdN0/q4pQosTM5lThFwocb3lKGESOE10mAM4g/Kl04QeFtlpIEOW2GHicfhUZ6Eoz1h0qbgxyW1bBVQL3ntZGG0fVsRep4fKQ6ogk9rwmRLKncyCW4inbq9ORZNRKOZrzGchxGkN8tKhBh8CmLng9euZGDJtAIC2CW0IZik1wN4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(55016003)(38070700009)(71200400001)(9686003)(8676002)(41300700001)(8936002)(26005)(2906002)(7696005)(6862004)(4326008)(83380400001)(38100700002)(6636002)(66946007)(66556008)(66446008)(82960400001)(6506007)(64756008)(122000001)(478600001)(5660300002)(7416002)(52536014)(66476007)(54906003)(86362001)(33656002)(316002)(966005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7O32rsEGBvEaOgtknl8/M90qhN9/QWrM6Ho/C9mNjaL/uSbiE3moEnPqXXws?=
 =?us-ascii?Q?4qvcpeiqFdq9CI9U6pKhi5S3VxZukfoJMzgBtTH+qHMUIytmEawGMxsNYAi2?=
 =?us-ascii?Q?fqa63m9r2ivhK1fO6g3fY5ntKtT2jAt2j83CKPE4Zj30fGzlxwJZYvTRs7ky?=
 =?us-ascii?Q?/Bh8xBnfP9qIffiDcHZ7+IV8ySuOXT3Nq8gJPUAM99BbzkXw1VNBJBVK3bzx?=
 =?us-ascii?Q?VhvHVT8fVvPVFfS/nxr14e6LZfB5mLLv1LhvV5DPavXiwm3OSbp0SxabTlnB?=
 =?us-ascii?Q?+wdO3IlLSOQfnkYWeUe+XCZAQFJgTlsTV3Y38LjkYumrv4kB2aMyDWYaI0MZ?=
 =?us-ascii?Q?t31mCqvpMNieLEwqEKWrK506aeatR9MG6thowgbFJHNJyFtaKHzUXcMXHJKX?=
 =?us-ascii?Q?cei03Qo0v1EP6T5lJWrTJ5aaVuUurf+S0EibpWXNiUAwXlRMt+A5U1mJtGzp?=
 =?us-ascii?Q?SGdidnbw69eKQzWqIbZDfMFU+pzW3nRkA664oiTWocroJYqjcgaV2u+F1fPK?=
 =?us-ascii?Q?z6POzRQJbB71+Wy59XtwyOaboctEiSmDYQ6QG9fgtbJYmTP3R5eaNGS1KYhc?=
 =?us-ascii?Q?nyZuVIj83A/0oJ6phTnahEaG+Q3vVDLDdSIgUNFHdWz7iePsBFP6hACJRKLZ?=
 =?us-ascii?Q?rhuPD4vp0nv4VHALReLCWA039fOoNFwrMRYqnebi2rkx+MbAeoQ8S9YxTCzu?=
 =?us-ascii?Q?KrfztszQcXOXQhoxO7wyparBQyR/QerSS62bIp/NgHt0Badxzid+grpsNlfH?=
 =?us-ascii?Q?5jWiyjZPJjb97MtSL4TVczIoZGBLZz6mn/YnA1Joj/OmEjZ/d4ZLJkJ73Z/X?=
 =?us-ascii?Q?KhKq0NmcsgkftKS91r8enfCfihkLq2gz3wc/Le+Nv46GlihViF9yKPtszKma?=
 =?us-ascii?Q?3ZWOJgvxetjZUGF7NTCl4Web65bY58aNsWttiODjnFeMLbffW02ulQrstLIJ?=
 =?us-ascii?Q?rTJW1vNH7gH8N3OvB3eHFO/F9gWF5F2qZOELB8bM6xmCFrs5M19zPU5DnaJj?=
 =?us-ascii?Q?aIQIzO9mGsaed2TxQxLiFpMLMfPRKsoZekAbDae/O+mhAGKZCy3fuR3nwkzZ?=
 =?us-ascii?Q?YKO6n1qPOgrMgizn0sviN/bQql9ZMDn613EqpX3X/0Vmi+ynXxBM+fiuNoJe?=
 =?us-ascii?Q?89vczukOK7COpjJlWqkPXySjtOvLuyFCC2zuZJdRRlxJ++kH0TZkZ/r8A8pQ?=
 =?us-ascii?Q?TGTRSnB++hjEduKwp1RdXHVnmB1TBhqy1Hm1D+WUEYy8ulPW1TIf0Iw+Pt/u?=
 =?us-ascii?Q?UgnBz4ukexu/RfPFFIOuqkdjRO5vc1wjW8fKLH00kdujpwQ7es6Aez6F5EQj?=
 =?us-ascii?Q?o5LhnZNnMJHEvhILjNGIiG2HXovsAFBhEAijOlcNpmfJJePj3nXUW6W5SflW?=
 =?us-ascii?Q?+bvRsrjVxSp0sDcnZUrckzNf9JxoZxEj4+6W5QviMXgpxiVNaVu79fX/jyvB?=
 =?us-ascii?Q?VpKmSQOSRY9Z4rAlmFWLi//H/FaIhFmVhJgad8cBKQS8sFY6ElBMecT6hpBp?=
 =?us-ascii?Q?J1p/3ApZWWMq4VfsvJztUdhRmvTjBxIglGu2ZVv8ehpmJ7pq8TZESanA86Yh?=
 =?us-ascii?Q?hv2aNlyMp3OH4T61y0w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d2b303-dc9b-422a-eadb-08dbe4ccf3a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 04:48:31.5221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9vbLF66ii+kV55/8jPvesSmwM+L5KNqAF2LoBMaE1pdtC9PWILraPzUiVPuXqeHmVaMZF3gEJjoWQZRn//oP+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8520
X-OriginatorOrg: intel.com

> > #ifdef CONFIG_X86_64
> > 	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
> >+	MSR_IA32_FRED_RSP0, MSR_IA32_FRED_RSP1, MSR_IA32_FRED_RSP2,
> >+	MSR_IA32_FRED_RSP3, MSR_IA32_FRED_STKLVLS, MSR_IA32_FRED_SSP1,
> >+	MSR_IA32_FRED_SSP2, MSR_IA32_FRED_SSP3, MSR_IA32_FRED_CONFIG,
>=20
> Need to handle the case where FRED MSRs are valid but KVM cannot virtuali=
ze
> FRED, see kvm_probe_msr_to_save().

Will take care of it, thanks for reminding.

> > #endif
> > 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
> > 	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX, @@ -1890,6
> +1893,16
> >@@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
> >
> > 		data =3D (u32)data;
> > 		break;
> >+	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
> >+		if (host_initiated || guest_cpuid_has(vcpu, X86_FEATURE_FRED))
> >+			break;
>=20
> Nothing guarantees FRED MSRs/VMCS fields exist on the hardware here. Prob=
ably
> use guest_cpu_cap_has()*.

Ah, my bad!

> *: https://lore.kernel.org/kvm/20231110235528.1561679-1-seanjc@google.com
> >+
> >+		/*
> >+		 * Inject #GP upon FRED MSRs accesses from a non-FRED guest to
> >+		 * make sure no malicious guest can write to FRED MSRs thus to
> >+		 * corrupt host FRED MSRs.
> >+		 */
>=20
> I think injecting #GP here is simply because KVM should emulate hardware
> behavior. To me, preventing guest from corrupting FRED MSRs is at most a
> byproduct. I prefer to drop the comment.

From security POV, this is important to mention.

