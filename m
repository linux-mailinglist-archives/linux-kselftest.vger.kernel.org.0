Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C70480F0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 03:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhL2Cwk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Dec 2021 21:52:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:47795 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhL2Cwk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Dec 2021 21:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640746360; x=1672282360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/NQNOVQabTGO8rCUgeRkbF7flpLN8lqTEr4RaiJljzM=;
  b=kcDDd+Y4pZ53tN0Uzi5qRTkvGf+qLp0zKU7SNASv6c1NGbAc0uvjRPsU
   69/UG/tuxz7/wV2XVum13H9qdgq5MvHCa12qP3wvwlP55Fa5Cfg6DyJyG
   pJ9Q7YHR1uPQTLj/0DGLXaJb23D3cdIr2WefZXaxUgD5GqV2/jyuJFF+q
   7l0sxcB7A0C6FoJcuntK7lzxjRwKdZ3VKGEsq71MnKX7K7dSIBdsabuLO
   y1gErltJEOoc4yWVBj0Me9vWwUMAhhBYj9f6NY3+tYPVo4/82anBsYEVJ
   hM7BeDkry5xuvTMNl09KJzp2szxUCt4QIp7BwFljyDmom81TjtnCqA7az
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="241407931"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="241407931"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 18:52:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="524702315"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 28 Dec 2021 18:52:39 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 18:52:38 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 18:52:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 28 Dec 2021 18:52:38 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 28 Dec 2021 18:52:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTUOXcZpPHkr3nDN3/HrtDE1z664Nt5hMDazj+tdhqwsQq8FrxP/7NmG4KDkyuGY1fstR2JtbDEKTQYAmWhXVW7Cts8PCSSJQnzfGB2ObvF5KMrzyGz2gSrx6pE/O0pPmXGW9NXBS2GzTX2amBrd5sBv0uMCehbW+na3hiyJ677pIEvfKuHK1ghO4y5Ku1hGgot6NcryNpe9Tq8EUnx1VY2bJIybg323XqQAMWBRSv4mUciIxGEsstB61zh8S8XRzeglt/6KAoAdQRfZ/s8gcEbFPB/M41EyEUBjbLfP6V2yvIg5yiHN2j7KwJLiekaDLwURbcgDmgCupU1ZNIZhJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGdqb+ds9GPfA4CLSMVE1jEUPehM36EY88vMRiitvJE=;
 b=PPiIdM4oUCGXhpGAE4L3MMU4DR12pYGwrVPT6t6s8FLUQ+EtvQSKtddiRNNi5rV8Oss8XJejo6sccwnWClL5D90z2KaiLbFlsJrAvrvfpWBkcdXDHonHtbzVd2pN5G6KnWs1voGYcBgUxSqk5svWxi2PPRsdh6KVeI7H3KEYajKodVIRcCIG3rLhwd+74VYqtKyMFybbk9CoGM81soz6W3iyjsNEp5bDac0YjTqJHWvBvsjnBPDWGonhdHfHlZUcPBJMqwspHJOwvoV7x1wGhx8yVuFVNgGn/0QZB4hc5fMJzqnx6XJ5fCRgH9+MT/PvrzrZeE0zx2FbF+pnSbY7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5369.namprd11.prod.outlook.com (2603:10b6:408:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Wed, 29 Dec
 2021 02:52:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 02:52:34 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
        "Liu, Jing2" <jing2.liu@intel.com>
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
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
Subject: RE: [PATCH v3 13/22] kvm: x86: Intercept #NM for saving IA32_XFD_ERR
Thread-Topic: [PATCH v3 13/22] kvm: x86: Intercept #NM for saving IA32_XFD_ERR
Thread-Index: AQHX9zE1lVRiv1UsgEq40a+CF3C7OqxIomKAgAAmHcA=
Date:   Wed, 29 Dec 2021 02:52:34 +0000
Message-ID: <BN9PR11MB52760E4417F27BF9CA4F97B08C449@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-14-jing2.liu@intel.com> <YcunSb52LlGKT7dC@google.com>
In-Reply-To: <YcunSb52LlGKT7dC@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c796a08b-c24b-4477-47e9-08d9ca7643e7
x-ms-traffictypediagnostic: BN9PR11MB5369:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN9PR11MB5369644A9500ACF61C4EA6EF8C449@BN9PR11MB5369.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wD+7cWENNJgztgX3YFtKho/SkBobB2XGc1nWV7enJz8+7PoYCkaOpJ+Nu+y6mzm4lqjG8EzePMAXEGRAjrtb8eHgCeN58WVVIJJOjMgvaiGX8McvJ3RO3iYpmgVZg4xS2rCBdGZxtgKDF2YMereIQuKyyFMwfROYt9sKC6Mg7gmAWWMxF0Osg+5GHN6GzhU6Pd70/WeKJWU/wHuheNm+ZyDl05SdSWL0iBOr8gYjZ/3XnJrJ0PqN8hU0sgEfuB0nKve/WlxbwUwNXcLFTjhOCtozFUdi8Cxl8KE+z3l4WltRW5W+GOU97+51JOQATshS7jRzHM22rqVhfjYcgWnRHfxBrB7YZ/vSGg7DBHQ7C1RGkgjGCf9tDjTfp9gJHV8kBxUdPnjCT4G7HsH4pHb5g4qaFuW3DNGz6L9BczbUortazhLKUUVhkbijC2Sn2opHYcS9b88zMBCEry0z16WIrzUMhMd5YrynmsyCC/dArKft6tVNfHNZgPGiTO7Gn0B4hnElE3dsVRzcHQm9pzOXMR7cm2T0Trcvse3YWeVFeD3c6knWBdcIDFunqSHwNZ/j5i/HLAXneRp57ctS2nkJVdMNw4SUIOb4r/C+hJCxNAJLNRyjlczNA135+k40W2bwZ02BpZobQZ+majALRyLqC5xdcjR06xSW9ks9OebYM+8s/N7jo7gCmBQCWd1XwcKhfiLa4oHRnabk+9J8TMKZUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(64756008)(66946007)(66556008)(66476007)(66446008)(508600001)(7696005)(9686003)(4326008)(5660300002)(6506007)(26005)(186003)(71200400001)(82960400001)(83380400001)(86362001)(33656002)(6636002)(54906003)(122000001)(110136005)(52536014)(316002)(38100700002)(2906002)(38070700005)(7416002)(8936002)(8676002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vDp1zfkI+hf3HCnZLA56+x6ZCKB4ne4KmwDD1PHNVTDyd2x2aiibMPEV6um+?=
 =?us-ascii?Q?KOk8O5S5y+Ijhzg2CPyIOhcAPiGyyZmh1MW83tQmMHiZyf16sQ3dIzm/2ljJ?=
 =?us-ascii?Q?vwhnMiyPXtpKQrdyqJ+vP/BWsHTcrsQWLIptTrStVk1CbPG10NWIU8wgeQZC?=
 =?us-ascii?Q?DLWSw7/j9How8n7W8Azff/8Y6hTWqzOnmLO4z+cS8eZCzTMFsLIldXI5Au6y?=
 =?us-ascii?Q?V7f46HQgzZsc/0hTLEx0mJcUZKUeWinWEcahjxP4T3sLDHdKtyYD8FYVVPBw?=
 =?us-ascii?Q?jErl27/Oi2MLukBuyLplA3kTi/XT7BYko4rZsT9SRMgfUN/wA7SIgHCrGfhl?=
 =?us-ascii?Q?qVhs1Bh6FGsdtb6q62CLKFRb4xftFeTVJ0jaYw/3j7qrHTuwM35P2oQHFKUf?=
 =?us-ascii?Q?11W/jqEBHv5Cb41UJ4hA1QKmtrShX+kZeCbhA+bSYFst35bpi0a+nELN5DOQ?=
 =?us-ascii?Q?W6xicKWfor3Mc2wsia92/esD773HFgjvuKrspN8CFRmm8uLkTj21lvrGIs0u?=
 =?us-ascii?Q?CY0JLVEL75esPS0Qu+shPAPPcq7lk5KnR6l3HuIMOXAUBwZaoaRGipyWnLRw?=
 =?us-ascii?Q?bA5NCXGXyGLW0Zdmj4/7LhwF+ywkbQWgPWqxd138PJAt7i/K4lrpQr/0CNaK?=
 =?us-ascii?Q?+eneBWxcVcFHa6QyhvecBCkn+m/Elzzk7M10T0rCfgO+fZAPQGato7wZFLDA?=
 =?us-ascii?Q?Bw9UZF1DwPJFTs0A0xRaGkZuzRsW3Rv8w7DicxqD3g//ZqWPefgnj+a0GAh5?=
 =?us-ascii?Q?d8qVZFQRIdobGEpGBud2WJ4Kz21T0iXCyV798d3rY1xrUIoi0BDAvNr6nJ2J?=
 =?us-ascii?Q?JEcicurigcfhoGzW4VZN32rBr1GM75kQVnFK4Ve2zhTh7wZUza3hHyVWCLxn?=
 =?us-ascii?Q?dDuXN6IAhB2Yt3Prlw27TMeLXr1ZXJ5vtstUBbO0qYIZqOT47OJ9blx133cx?=
 =?us-ascii?Q?F15qLoEG7Yq/vMuCoPt3cNPZ3X4sP1h2lGiUKDhe67tbMI7hXT09l0C+3jGY?=
 =?us-ascii?Q?gTD9gzaKV+OVe3KPAhTC8q1+TsYf+iDKrKCET5wIK4/iAL6z07gN16LhQYf0?=
 =?us-ascii?Q?UeI+IBPjTWED8nE7a17VmmCdTYSghFVO4opugHwXZielWX1hpPEiNa9LMChZ?=
 =?us-ascii?Q?nGliLObvuokydB+Z8tG3C9QS3FdmFt3gCes/P4lY1d7cQFXA/clcMYKBnKU7?=
 =?us-ascii?Q?9TMUGRL8CUXcPabG/lRxXjOqtnPzI8y9l5yBsvYoMopGUU+xCd3XSF/P6lBU?=
 =?us-ascii?Q?lu15y6ojSwjAQ/beeSQnr8mxeveX9eJxc677I/8Zs/rBXC9pch+BOwVi6jey?=
 =?us-ascii?Q?2odZo9GM/iJQHP02kW31sB4Iup5Y0vV/AQB/Ae4FBEJVO/g4WtU/i6f/+8yx?=
 =?us-ascii?Q?dFWx6JXKuQr7HhZL8NhEE1Rf8RFFe3pGWMoCdLGlEYBBrDW6QzsDn1fkD1dD?=
 =?us-ascii?Q?PtMzXozQv2o96nPBkOzgkRuyatG9+0Oc2qTBE4vTmH+D56Vy/IIDLh3mpsKF?=
 =?us-ascii?Q?s74m1H6x/DDU3jWd49OMysCo5RGfnVkaN+J8BK2VP3CsWuarhU/8aXJ6Bnpb?=
 =?us-ascii?Q?sp0jCyKv9Tvc8qeuExmOa3QH9PCkw38qO3XpPKQKjQ2+J4VpS+lZm9vzDHIc?=
 =?us-ascii?Q?8Z3raCZ8bfBKdxVe5+s9SBg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c796a08b-c24b-4477-47e9-08d9ca7643e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 02:52:34.1926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvGG8kO68aVVainm7y/HHCaI1Xb02FjDPizOS3f61l+mjhBNk7/8KZwclYR+XnuOs9UfcT+SuGVSR+ByPDH3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5369
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Sean Christopherson <seanjc@google.com>
> Sent: Wednesday, December 29, 2021 8:10 AM
>=20
> On Wed, Dec 22, 2021, Jing Liu wrote:
> > Guest IA32_XFD_ERR is generally modified in two places:
> >
> >   - Set by CPU when #NM is triggered;
> >   - Cleared by guest in its #NM handler;
> >
> > Intercept #NM for the first case, if guest writes XFD as nonzero for
> > the first time which indicates guest is possible to use XFD generating
> > the exception. #NM is rare if the guest doesn't use dynamic features.
> > Otherwise, there is at most one exception per guest task given a
> > dynamic feature.
> >
> > Save the current XFD_ERR value to the guest_fpu container in the #NM
> > VM-exit handler. This must be done with interrupt/preemption disabled,
>=20
> Assuming my below understanding is correct, drop the "preemption" bit, it=
's
> misleading.

code-wise yes. In concept we just want to highlight that this operation=20
must be completed when both interrupt and preemption are disabled.

But we can also drop preemption if you prefer to, since preemption is
certainly disabled  when interrupt is disabled.

>=20
> > otherwise the unsaved MSR value may be clobbered by host operations.
> >
> > Inject a virtual #NM to the guest after saving the MSR value.
> >
> > Restore the host value (always ZERO outside of the host #NM
> > handler) before enabling preemption.
>=20
> AIUI, changelog is wrong, code is right.  This must be done before _IRQs_=
 are
> enabled, same as handling TIF_NEED_FPU_LOAD.

yes

>=20
> > Restore the guest value from the guest_fpu container right before
> > entering the guest (with preemption disabled).
>=20
> Same complaint about preemption.
>=20
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Jing Liu <jing2.liu@intel.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |  1 +
> >  arch/x86/kvm/vmx/vmcs.h         |  5 +++++
> >  arch/x86/kvm/vmx/vmx.c          | 22 +++++++++++++++++++++-
> >  arch/x86/kvm/x86.c              |  6 ++++++
> >  4 files changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/kvm_host.h
> b/arch/x86/include/asm/kvm_host.h
> > index 555f4de47ef2..f7a661f35d1a 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -640,6 +640,7 @@ struct kvm_vcpu_arch {
> >  	u64 smi_count;
> >  	bool tpr_access_reporting;
> >  	bool xsaves_enabled;
> > +	bool trap_nm;
> >  	u64 ia32_xss;
> >  	u64 microcode_version;
> >  	u64 arch_capabilities;
>=20
> ...
>=20
> > @@ -763,6 +764,9 @@ void vmx_update_exception_bitmap(struct
> kvm_vcpu *vcpu)
> >  		vmcs_write32(PAGE_FAULT_ERROR_CODE_MATCH, match);
> >  	}
> >
> > +	if (vcpu->arch.trap_nm)
> > +		eb |=3D (1u << NM_VECTOR);
> > +
> >  	vmcs_write32(EXCEPTION_BITMAP, eb);
> >  }
> >
> > @@ -1960,6 +1964,13 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu,
> struct msr_data *msr_info)
> >  	case MSR_KERNEL_GS_BASE:
> >  		vmx_write_guest_kernel_gs_base(vmx, data);
> >  		break;
> > +	case MSR_IA32_XFD:
> > +		ret =3D kvm_set_msr_common(vcpu, msr_info);
> > +		if (!ret && data) {
> > +			vcpu->arch.trap_nm =3D true;
> > +			vmx_update_exception_bitmap(vcpu);
>=20
> This is wrong, it fails to clear vcpu->arch.trap_nm and update the bitmap=
 if
> the
> MSR is cleared.

In concept you are right if just looking at this patch. It's pointless to
trap #NM if guest xfd is cleared.

But here we need think about patch22 which disables write interception
for xfd. With that in consideration we use the 1st non-zero write as the
hint indicating that guest might enable xfd-related usages thus always
trap #NM after this point.

It's not a good ordering, but Paolo wants to put the optimization in the
end of this series. But we do need to put a clear comment here explaining
the always-trap policy.

>=20
> But why even bother with an extra flag?  Can't
> vmx_update_exception_bitmap() get
> the guest's MSR_IA32_XFD value and intercept #NM accordingly?  Then you

Above is the reason for the extra flag

> could
> even handle this fully in kvm_set_msr_common(), e.g.
>=20
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2c9606380bca..c6c936d2b298 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3704,6 +3704,8 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu,
> struct msr_data *msr_info)
>                         return 1;
>=20
>                 fpu_update_guest_xfd(&vcpu->arch.guest_fpu, data);
> +               /* Blah blah blah blah */
> +               static_call(kvm_x86_update_exception_bitmap)(vcpu);
>                 break;
>         case MSR_IA32_XFD_ERR:
>                 if (!msr_info->host_initiated &&
>=20
> > +		}
> > +		break;
> >  #endif
> >  	case MSR_IA32_SYSENTER_CS:
> >  		if (is_guest_mode(vcpu))
> > @@ -4746,7 +4757,7 @@ static int handle_exception_nmi(struct kvm_vcpu
> *vcpu)
> >  	vect_info =3D vmx->idt_vectoring_info;
> >  	intr_info =3D vmx_get_intr_info(vcpu);
> >
> > -	if (is_machine_check(intr_info) || is_nmi(intr_info))
> > +	if (is_machine_check(intr_info) || is_nmi(intr_info) ||
> is_nm(intr_info))
> >  		return 1; /* handled by handle_exception_nmi_irqoff() */
> >
> >  	if (is_invalid_opcode(intr_info))
> > @@ -6350,6 +6361,12 @@ static void handle_interrupt_nmi_irqoff(struct
> kvm_vcpu *vcpu,
> >  	kvm_after_interrupt(vcpu);
> >  }
> >
> > +static void handle_exception_nm(struct kvm_vcpu *vcpu)
>=20
> This needs a different name, it's waaaay too close to the base
> handle_exception_nmi(),
> which runs with IRQs _on_.  And please add "_irqoff" at the end.  Maybe
> handle_nm_fault_irqoff()?

sounds good.

>=20
> > +{
> > +	rdmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
> > +	kvm_queue_exception(vcpu, NM_VECTOR);
> > +}
> > +
> >  static void handle_exception_nmi_irqoff(struct vcpu_vmx *vmx)
> >  {
> >  	const unsigned long nmi_entry =3D (unsigned long)asm_exc_nmi_noist;
> > @@ -6358,6 +6375,9 @@ static void handle_exception_nmi_irqoff(struct
> vcpu_vmx *vmx)
> >  	/* if exit due to PF check for async PF */
> >  	if (is_page_fault(intr_info))
> >  		vmx->vcpu.arch.apf.host_apf_flags =3D
> kvm_read_and_reset_apf_flags();
> > +	/* if exit due to NM, handle before preemptions are enabled */
> > +	else if (is_nm(intr_info))
>=20
> Same naming complaint about this helper, it looks like an is_nmi() typo.
> is_nm_fault()?

will fix

>=20
> > +		handle_exception_nm(&vmx->vcpu);
> >  	/* Handle machine checks before interrupts are enabled */
> >  	else if (is_machine_check(intr_info))
> >  		kvm_machine_check();
