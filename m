Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCD4484BA0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 01:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiAEAWe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jan 2022 19:22:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:34016 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235309AbiAEAWc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jan 2022 19:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641342152; x=1672878152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fBeznG9cIKhC276vaaqEtqZudIjiHzEQFLwjvuaZIg4=;
  b=dfqlwkotftObTGvcNZsuudGity00IgDSCdhrXdpHkGAqm6UMPMqgChc2
   NqHB5A5qDsjuMb3v9cEI3Zgy3gJ6CHtz5AJC5M9iCzkwhFiJmkXSPhDSX
   wn3V2mGDzd0EwEhWa95RToEPli2OXmE7Wf52X2hhk6JYk/KLDn38ZA/hS
   ivBQaIPDDGbkWe0wzCUb1QcIuRWpp5gCMcqsQfcV17EDBgq2BpzUyNIwZ
   HUtFa8Mrn0D89XLh8RAy7yWy9yqm4VSB/Qn3izNDqK89eshuUueTSmWJ8
   KhiyWijU8MUtC522IgWCr+0UYBk5x6xPGxniYlLMopgDHKk80e+CoxnQ2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="239876304"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="239876304"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 16:22:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="526270095"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2022 16:22:31 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 16:22:30 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 16:22:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 4 Jan 2022 16:22:30 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 4 Jan 2022 16:22:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IichPKxXXBvQ8iEvM9Tl6oWfNrmjAJulU5/yPEdvA5uWmgq9RjQurVCMJ39DwtoF2JmIrmTN7vW96j46jNoZSUZkIB9GWmpzaOkgLZ1q/iywVdRT9iJ4CXux2E9hpveDxhGFgUUR9sKFdEmm8c0yyXImkcMJNDJFXQ7UZrCAx7ICTzesU4tk9WUwUr0kRG8iBr3/9+nN8ewK02MF3EsvlBj5epcDuhaF65W+/9QWBvQFTpEgIEBabp5pIhZvPMXlpQJbA1JcwRyjJLlTiyRC5D+cfF3kbQjYKs3BTsEyCK1P8/z+kYYIVM//Il3nbJX1NFal8b3kRDmPsk+SGQeusA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIPKZCIsrdI2nt7w6/O8HwNkPflwltdhp2Q4BuegkTo=;
 b=LLNo2BrnDEJTeqFi4Tpu4s8JvLykUE6KiWMEhCxkxRoHimT9G+4WCcvvBUos+Dy+0LSDPiGeJWKeNOXSo3DlFsTbq/Q9ehvBxNzQlxt88ZXg7Rd+PlQ5oyldscSj83954IYac7WVNprDn4A8UIC95WFCw0AbRmD8OCY1cZjCGwcRIAp29YPk8EcQg+09z5rCOX9aleYW9eruA8rhGSgBMcE8KcXRQKf7GIrDgl4ujeJ4a6+MwCpf7exb8vXUnEiFTq9QKTg1AbsMURAoIukgk+RyiUbxqM8k6qzw3zCSBAdKfKb4EnFby7d+LGjD6XXLrtxcunfFQgbHFKYpydvtLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1396.namprd11.prod.outlook.com (2603:10b6:404:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 00:22:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 00:22:25 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v4 10/21] kvm: x86: Add emulation for IA32_XFD
Thread-Topic: [PATCH v4 10/21] kvm: x86: Add emulation for IA32_XFD
Thread-Index: AQHX/LXrTMdgUmFiNUul2c+SerJZ36xTSjQAgABQqqA=
Date:   Wed, 5 Jan 2022 00:22:25 +0000
Message-ID: <BN9PR11MB52766D60A78E5C736E1BD4FB8C4B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
 <20211229131328.12283-11-yang.zhong@intel.com> <YdSgzsiBft/NgxdF@google.com>
In-Reply-To: <YdSgzsiBft/NgxdF@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a7e8e16-ddf8-416d-8ae8-08d9cfe17335
x-ms-traffictypediagnostic: BN6PR11MB1396:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB13961EEC5FB0A4E046ACB2538C4B9@BN6PR11MB1396.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4kMgzlbELHOE4HW4vB3zo3EcATF4gbc2cwAMflVaW1IJz22WvvX+lHgn8ld6WhQam+FNB3AnFDisk1J0gTxiZkC2ALwWv5vAihCDZcJGGSIvaj3lzcfl1N67vZak1Y8BCM84vFemOoBzubuub/kLPZTuz1mynxFt0vwPm2Z6O7OiiJCRvzNUIdSZCmIUCNSnvahnNU36jEw2OqjcS/V0ariYJEf5UYLiudu3PlXZPXWdUmMJ/9bwfQChaaYzu+cYtfXDJV2qCDKm0SK4fSUEmWx3xtaBMlCZVSOQf+vwPkLmR6rPP/900vn5XwqWsOOkXbE+wdT+Ki7EPeBq+V+5Awnr0GefiOwiz9oPglCgdnozveh+Qbaj5HF72OetECF058KBg5V9TPYsvklIcXXAlcUd+TXnYldxW75a71UL3pGv3Dvwhd1I84lzw7nsuocYmKpFVwiSSEUh17GveHGQuTFM2Ss10A409KA0ZnOg+Dm74BnA0YIEoot80oVtGz0NX9AfYl6MDjMFNG/HYar4R/PdkIhWMII02SEJtSsriVlehlm75hyOoOLVePviDgRCZvUyaa3GF5fqPqJERIR/d+o7YoalyejPAD0eXnG4+S2MDSH1PmhMwzYINX+qbw74AuSzdcOD+u5NBXrRBePo9ljAzsT9DKRPAH3uPuGrwaoinXRS2biT1r7/FfanxhTf9G6esYXAtbGxHJGucg5Lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(82960400001)(38100700002)(66556008)(7416002)(186003)(26005)(2906002)(76116006)(52536014)(316002)(7696005)(122000001)(508600001)(38070700005)(64756008)(66476007)(66446008)(110136005)(6506007)(33656002)(86362001)(66946007)(8676002)(83380400001)(8936002)(6636002)(54906003)(71200400001)(9686003)(55016003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yqo+mLiRG+PyVadxLkJY/PltZ/rHALqFG7F/778KlLnC4rJX3SGMWoow1igt?=
 =?us-ascii?Q?OGsQESHLklbONWPtsmU2IekwYSsWPM1ngAKFd9rZ2BddUlnZR49jWWQ/zplf?=
 =?us-ascii?Q?ZcG12TIz/kDujxQtHy1RFVbgrJYT6LYiiJ6EZl6sAmL2z8DMVdBZNEbIDysk?=
 =?us-ascii?Q?h7J+qivrdNblH1V/5HalqBxsIFPRZkMeLSpXmW0C3K+xQqm49L5DZUzDZ562?=
 =?us-ascii?Q?1Yj/tbBaLASZw6uIrW9QRhMOyOnqQuN3hmTsfsByDGIISiIovZPbFscDLLtw?=
 =?us-ascii?Q?QbAojDIiopy8YAtdEjjjw6whRy4eWsCOct9ZeBdp1oIRJpmEMDjNLaKT28c/?=
 =?us-ascii?Q?uyOy6LdIRtQ1hsawHC1b7DOZ2BTMsTfNCX58wHrsHWTqZ1z7rXxo4SU9mxg8?=
 =?us-ascii?Q?hOS67OJKaPnAsIGXs2GZ4if2RrDUmBizLSYOn7AF8mBEZNHLQzI6idrunX8l?=
 =?us-ascii?Q?V6PClN9PJhftpmTjH2Y85zVQNfgDMpx+EQvqpPSE29mSfYkgqQUQ2D5gHNXs?=
 =?us-ascii?Q?86GM9GFCa7YD76JTWpSQQ9GJAI2N3JC2eOeXOrzzBQ338MoJheU2mTlW0q6k?=
 =?us-ascii?Q?+NNQufgmqh6vJunE2rt/OAa/cXqF1e+e7p/2XGRcuch7u+sAPpQA3Z0IdHG/?=
 =?us-ascii?Q?D2Qx1DK+FtArP5aQ62ekjXEVJlAxFi4FA5z39sTuYhy6MyWI37kARwB58Mq9?=
 =?us-ascii?Q?7afw/zb/pzrK1p1CfT0wXax6CXk1e8C0NlEBOVSg9qB+7PqZNcODr5utEifa?=
 =?us-ascii?Q?1WZGUjTmbQVzM/dlJKOe9Yr6Oiar8LcOP2ANPZ88kBdhCzXKn8g6e6qFwqql?=
 =?us-ascii?Q?jLEcqoJcjq1pwFOOUOwXyvpVEypNgW3yDNdghas+Goruv8vcaz35v5CFC5Ih?=
 =?us-ascii?Q?cgMgZSKyqBhHLoYKsY08/m7hANlKjAjBNOz7artla4FRjoww2/ciUKc2WLpN?=
 =?us-ascii?Q?qOdK1bE47PsbRDQZQaJXSRUh67WJzv+9hSGe2ojv5I/mn6T5bWbFSgLuOUtD?=
 =?us-ascii?Q?OMcTyK4NX9aFbfJWzLEzKoq5EUWf4oxjoXJNYI6HTYQB6/z0TscC++u2uXym?=
 =?us-ascii?Q?EsLmrM1dOgNeaQL9SQIG5nu2YbQDwkowgBXN5yVrpChFlrx8WGIp38cOgCf4?=
 =?us-ascii?Q?Le58yEapRDIwi1ZXOZU6/I80j1SGyz2A6Nqoq6358HOjuNbvGV6mj6nWEVbv?=
 =?us-ascii?Q?plmKehPPRIyiPnVPqSkAgRVM6NJby58TG+xAgZs0UbXK7rMYncAyJGolA4Wf?=
 =?us-ascii?Q?R5I5MXwMhcttTUkLvMVr2WXb+3FMS/nDXoiSn1QovmDJAwfCLqcx21mQUPw6?=
 =?us-ascii?Q?xe+TiKQT4fPbZaj130AHizocg064bNzHK6BDhRHsnTTsG8mck/O08TR8OPRk?=
 =?us-ascii?Q?AUN2ZqMr9Z0nvpD3a4wAAB2GzhJgNJRkeM6mJ4Wtq5bxljaOkvIofGNUqMEN?=
 =?us-ascii?Q?SVWqBFOCuuAnD74JpKrZDz1zSnBaXI9UmEOwILRnTWwWtKRwBeihAlv3baty?=
 =?us-ascii?Q?ff//ZT9CItPgcljqkDG9RUdLr/1vJX/5oOi2k/Gep9f7k624DEdMTm8Sb/zW?=
 =?us-ascii?Q?PAiw2Kn7oDQIXYyQZ6x393mSPN/BirglnFFBjyYE1+keAES5HJmrOpFNG3mg?=
 =?us-ascii?Q?Yt1kdrEN03IlokXCr5AoFyM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7e8e16-ddf8-416d-8ae8-08d9cfe17335
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 00:22:25.5731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHm3gYzrOhvHg29mg5wHX7HbKSDWv3up0/hIwOj9G/u1QM7PYqwCWjsrLokAL+WRSmCqmMM5Ry7OwSX8A+WGcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1396
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Sean Christopherson <seanjc@google.com>
> Sent: Wednesday, January 5, 2022 3:33 AM
>=20
> On Wed, Dec 29, 2021, Yang Zhong wrote:
> > From: Jing Liu <jing2.liu@intel.com>
> >
> > Intel's eXtended Feature Disable (XFD) feature allows the software
> > to dynamically adjust fpstate buffer size for XSAVE features which
> > have large state.
> >
> > Because fpstate has been expanded for all possible dynamic xstates
> > at KVM_SET_CPUID2, emulation of the IA32_XFD MSR is straightforward.
> > For write just call fpu_update_guest_xfd() to update the guest fpu
> > container once all the sanity checks are passed. For read then
> > return the cached value in the container.
> >
> > Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > Signed-off-by: Jing Liu <jing2.liu@intel.com>
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > ---
> >  arch/x86/kvm/x86.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index e50e97ac4408..36677b754ac9 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -1359,6 +1359,7 @@ static const u32 msrs_to_save_all[] =3D {
> >  	MSR_F15H_PERF_CTL3, MSR_F15H_PERF_CTL4,
> MSR_F15H_PERF_CTL5,
> >  	MSR_F15H_PERF_CTR0, MSR_F15H_PERF_CTR1,
> MSR_F15H_PERF_CTR2,
> >  	MSR_F15H_PERF_CTR3, MSR_F15H_PERF_CTR4,
> MSR_F15H_PERF_CTR5,
> > +	MSR_IA32_XFD,
> >  };
> >
> >  static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_all)];
> > @@ -3669,6 +3670,19 @@ int kvm_set_msr_common(struct kvm_vcpu
> *vcpu, struct msr_data *msr_info)
> >  			return 1;
> >  		vcpu->arch.msr_misc_features_enables =3D data;
> >  		break;
> > +#ifdef CONFIG_X86_64
> > +	case MSR_IA32_XFD:
> > +		if (!msr_info->host_initiated &&
> > +		    !guest_cpuid_has(vcpu, X86_FEATURE_XFD))
> > +			return 1;
> > +
> > +		if (data & ~(XFEATURE_MASK_USER_DYNAMIC &
> > +			     vcpu->arch.guest_supported_xcr0))
> > +			return 1;
> > +
> > +		fpu_update_guest_xfd(&vcpu->arch.guest_fpu, data);
> > +		break;
> > +#endif
> >  	default:
> >  		if (kvm_pmu_is_valid_msr(vcpu, msr))
> >  			return kvm_pmu_set_msr(vcpu, msr_info);
> > @@ -3989,6 +4003,15 @@ int kvm_get_msr_common(struct kvm_vcpu
> *vcpu, struct msr_data *msr_info)
> >  	case MSR_K7_HWCR:
> >  		msr_info->data =3D vcpu->arch.msr_hwcr;
> >  		break;
> > +#ifdef CONFIG_X86_64
> > +	case MSR_IA32_XFD:
> > +		if (!msr_info->host_initiated &&
> > +		    !guest_cpuid_has(vcpu, X86_FEATURE_XFD))
> > +			return 1;
> > +
> > +		msr_info->data =3D vcpu->arch.guest_fpu.fpstate->xfd;
> > +		break;
> > +#endif
> >  	default:
> >  		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
> >  			return kvm_pmu_get_msr(vcpu, msr_info);
> > @@ -6422,6 +6445,10 @@ static void kvm_init_msr_list(void)
> >  			    min(INTEL_PMC_MAX_GENERIC,
> x86_pmu.num_counters_gp))
> >  				continue;
> >  			break;
> > +		case MSR_IA32_XFD:
> > +			if (!kvm_cpu_cap_has(X86_FEATURE_XFD))
> > +				continue;
>=20
> I suspect the 32-bit host support is wrong.  The kernel's handle_xfd_even=
t()
> checks for 64-bit support in addition to the CPU feature itself, which im=
plies
> that the feature can be reported in boot_cpu_data for 32-bit kernels.
>=20
>   static bool handle_xfd_event(struct pt_regs *regs)
>   {
> 	u64 xfd_err;
> 	int err;
>=20
> 	if (!IS_ENABLED(CONFIG_X86_64)
> || !cpu_feature_enabled(X86_FEATURE_XFD))
> 		return false;
>=20
> 	...
>   }
>=20
> In this specific case, that means KVM will tell userspace it needs to mgi=
rate
> MSR_IA32_XFD, and then reject attempts to read/write the MSR.
>=20
> If 32-bit host kernels do not explicitly suppress X86_FEATURE_XFD, then K=
VM

I didn't find explicit suppress

> needs
> to do:
>=20
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 556555537a18..156ce332d55b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -455,9 +455,11 @@ void kvm_set_cpu_caps(void)
>  #ifdef CONFIG_X86_64
>         unsigned int f_gbpages =3D F(GBPAGES);
>         unsigned int f_lm =3D F(LM);
> +       unsigned int f_xfd =3D F(XFD);
>  #else
>         unsigned int f_gbpages =3D 0;
>         unsigned int f_lm =3D 0;
> +       unsigned int f_xfd =3D 0;
>  #endif
>         memset(kvm_cpu_caps, 0, sizeof(kvm_cpu_caps));
>=20
> @@ -545,7 +547,7 @@ void kvm_set_cpu_caps(void)
>         );
>=20
>         kvm_cpu_cap_mask(CPUID_D_1_EAX,
> -               F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES) | F(XFD)
> +               F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES) | f_xfd
>         );
>=20
>         kvm_cpu_cap_init_scattered(CPUID_12_EAX,
>=20

so this change makes sense. will incorporate it in next version.

Thanks
Kevin
