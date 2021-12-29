Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DDD480EE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 03:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbhL2CXU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Dec 2021 21:23:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:35702 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhL2CXT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Dec 2021 21:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640744599; x=1672280599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H+ikthknLsaGs6Aar2srhrIk0NpTV6VrnNqk860EJfc=;
  b=ge7aIb7SROH+0Cff3mAzShT00epEfKQYHqjT57gjoY8FBRV2yp9pzdYD
   ThNfzQMto3Fdo3K0ne55ON9VmSSLzpXlM3/C4HZoUsLOqWAutXtaHIRBR
   JyiTZqPm7C8aeRShT3vXSOCYaTTgPKBKi802TNMSgLItrSnh1CLh+wlE/
   mBoTPZyF+wHAGAGQSO8I205X14VjT6Av6JMWvehSc8/ohKqdg5ZuDKEXW
   l8l5QOGAG4c4NL167sOkSiNU+vPKRDZlqqXQD2Ci2RbRwmTNNoeXcdlCN
   ZCgN71rnTvWACTUoVZvxNK86lCS8+W910ynwVNdSj5Sn8/i/YELgrElX9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="222121762"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="222121762"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 18:23:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="470185696"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 28 Dec 2021 18:23:18 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 18:23:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 28 Dec 2021 18:23:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 28 Dec 2021 18:23:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2W4QnPEDONLaBjahp8xOfvDugC/Q9+HyXDNR1SAJy/E00zGjU9/Jr6RrU+14ysGbiX0w9uCM2ZwC9Vh/4ZWXasksdtSUvSHPTMhDkWruS2f7IwbEhkbU7eF4BxiH1+1rtWrDSiKVZf+3J4JVk10iZu5ZnqwXGoqkY7YkDOpnD7OXTf2UZ3tyJuejxnkarRwo5OGzZYD339eecH1Uv8iEDD5fqPm9grbVDZPo+hgp+RHNqHtP1UNDARaLF5gdw+cqP1qY91L7tUCL/L+v9qP98d8aTU3JH+iEKc8q9iqbAom6xqAYVSTkVykxbWpGwv/FsvvJ5qTC6VgXhg/GQrmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1CZzVqGULt0rPFgRntCUj3L9pDJtq+sohWOUaCJJqU=;
 b=lTkRKUeZQ4hHrfyTsneTOE0rjEkDUqsB2R+soLUju6IihdoQ+mPQxWY6TGyAmLGFD7FaZ9ht0gHFDUWpuflACMTUoh7HKGXs/soOTCPsa7AwUMKKY0GG3QL22YWagMtlcqaHiMoo58Vcq87YKIUCEYFcM4TKJcrKddR6ZpAAN3aHbXddEG6YV0/Q/AJkgyGG8NHij6nxsltaMvWaVDLLqxSYfqm4fKxsNCJ5ZFo8bg7jbM7lJpjTTN2j0X/ZFm1HWFYTc8ClpUSfC0rQAWkLmmoLL6aMDQnWaMsPedkUOLbkhrMpvYzteowBrR7zM3rkGp+9N4DdqHDsiEpyuXkt/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1490.namprd11.prod.outlook.com (2603:10b6:405:d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Wed, 29 Dec
 2021 02:23:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 02:23:14 +0000
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
Subject: RE: [PATCH v3 09/22] kvm: x86: Enable dynamic XSAVE features at
 KVM_SET_CPUID2
Thread-Topic: [PATCH v3 09/22] kvm: x86: Enable dynamic XSAVE features at
 KVM_SET_CPUID2
Thread-Index: AQHX9zEymgm15iLWYUCWfjNv0yTBhaxInf4AgAAoZeA=
Date:   Wed, 29 Dec 2021 02:23:14 +0000
Message-ID: <BN9PR11MB52763224231BEAA1AD4793EE8C449@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-10-jing2.liu@intel.com> <YcujmvvSEuoC2xRz@google.com>
In-Reply-To: <YcujmvvSEuoC2xRz@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 196701ca-c4ca-41f1-dcfc-08d9ca722b14
x-ms-traffictypediagnostic: BN6PR11MB1490:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1490F696F8356C2CF11C0CB58C449@BN6PR11MB1490.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 40+waTvjXYfGJ/yd9TzhzJtt+ij6ICzHUXvIjUTuMLxo8gFhF+19aM2LQPeH9M70llHrj8F5L5Dgd020sUbSfnnMVeeFjYgtPsxBydYdsqAA2CPGrtVoQ+6uKyhYQQqwFsqk0LhP2qS0u3278w/5Mbe8ZVL3V0Uv+K+yTwonHuhp9W1HHmBTeP6wXTy6RXzP8KV+k1WSf8rdPfT6v/g5P0v12dbKcsm7mh0S+1gowNZIBPg8MuNZ77sfVWVwHTQ/kK9Rhi11KPR9J0h1749Ho4Ne9LWhKA3mKJr9EuS+EdFX4sp5X8L68vW37XdfuvlUNnKn+TOlEDANgnLuzOxWj5p4EhEjwhAQlkBmQJ+mD2b9+cIR6QTXjjIb+SocgvrImjW9caxLWBcMBXLR/S9GgHHxbiI1/Zw6Btok0anAxJMKEmIBLhPNfduAdD8c2wzJKV7YJwe1oUslOQOoUWnQ2JrtA23McRJ1NiMXle0qNnIGGCtph4YzwhX2y8LLHSs46upSw3v4kgBXYVoYYijzSI5MOWVjYUmTNjNELBtyUrpBD8gPLH6KAD4AJZmBjMNj42X58hMYnQNNSEidSkbtOANcXDodWZuYagWktPSVWPB8/Z/4vAko/gTXEJoF/3QwXcHMu5E4AFTkfTtlXoAYqWWWPqxxZvUw/B/py2EFK8OQIKxoU5warDlOx6SrFmGXf/0nXi8b0nejH38GyiYkMe/kb7lc29tnat1W80XE4B5IaQBUhecLC/IxqFdoCwpXEI9zpbIFXNURW6INJtaJRtJGAm0Vxv5R0Q/Cnkov5hY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(6636002)(26005)(83380400001)(316002)(38070700005)(76116006)(66446008)(66946007)(64756008)(66556008)(66476007)(7416002)(186003)(52536014)(8676002)(54906003)(110136005)(8936002)(6506007)(7696005)(33656002)(508600001)(2906002)(9686003)(71200400001)(38100700002)(86362001)(122000001)(5660300002)(966005)(55016003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kvyQCjcvRbYwXoCzYZUovRlUbosAOipIioQHQ9/Jj2LZqbXFdbP3hMdx6bTa?=
 =?us-ascii?Q?cEw1iqy1I6VnTp8wqKbbAUCVKxjEBz50dwBBhHZ3diE2E+xXRf+ubxKoDhBH?=
 =?us-ascii?Q?JmOUTbel9AatO8imrL3uh38ySyVyh8VNqNgA1W77gGwUbtqoSmZixExXrCcS?=
 =?us-ascii?Q?KD4f7FLR+s/B5kLm7CT8O+lbWXGNK4RMuzIem57CjYIIvJR0rNI7FnCykjHH?=
 =?us-ascii?Q?CyjI4iCh1Gkru9VCPLgoHWWLpLcUS2erbp/AIwy4Gi/lEpfFlfKDLihLwX8m?=
 =?us-ascii?Q?Qfwt3+5rfu6/t7aMaMNVKYIlzZM4/wx1/Ufvbr9Hf1czoPKRnaEKL0kAlnEp?=
 =?us-ascii?Q?6cSn4t//Bg6WscMrBIr2OKyudaz1DJohDVXoiE/FF3Tj5kmyAybuGYi9Mtiy?=
 =?us-ascii?Q?QRk7/jpjL6T9iLddUdAo89STs3L2gaIyMJjcOg29gknGb9awsAIrMauMS0gf?=
 =?us-ascii?Q?9aR13g2+nihej+D8LIZRBVhP6RxO6HBxE2zWy2BpAyjYTEOfQbOoobIhEfrJ?=
 =?us-ascii?Q?hO3HM+S9DC8sXlbZWvLviM1+aLgnSTQ8cANBS3INSOO0Rl428AUKu38tGIlT?=
 =?us-ascii?Q?z66CkoYHMR7K/ul8NXdN6Mt9KSgStvl9NXkF8UAZCdcYcceZFXkE8OW97uc2?=
 =?us-ascii?Q?bL0oY+Vwcj2x5smYn80pcjixJ47NtvftlE6JeSFB+4RvuOA9xn65jwAac9vf?=
 =?us-ascii?Q?0jRsuKVYbcjtrgEbUmyl270nv/psj7J0ToIESwa6m6ugfkLdvY9E9WXDj9fx?=
 =?us-ascii?Q?WAYPaU1u6fwSdQfRStznGbaNbsl5cP69DlyGByQsIZZnT/4qJ4xcUthU1Ad1?=
 =?us-ascii?Q?JMsCLwdHZVK5FmeehnvkUitIFaKDFt/swStyfpK4fRQVqqBmFylj1R00Y6xw?=
 =?us-ascii?Q?tpSEHN+YXlXlDoqhGphdrMNNFRHY13HwdofZDKiHZjLblGnnC1KKpqX9LPsB?=
 =?us-ascii?Q?qN6sSVVW9bXLBwemY9t26OUsTOr0tbG93WfSaiX5OFe+xO+hVejnURbqVVSd?=
 =?us-ascii?Q?MQfwYzj/VbS6r56I7b/1dBrfDu3CyO6qXSGZx4S8fIxYYQ6RPoWVYjCdxg7q?=
 =?us-ascii?Q?2QxTVUhTiFFN69BvRVbdgoe5TTtzLo60Q/NikPwSiHC2ourv1o1OoCTms6el?=
 =?us-ascii?Q?Bst/mdkWpKb1mkyNZp+W7Rxv+nqezdGI52mAYEr6XDz1Yq6++416QaFEYz9C?=
 =?us-ascii?Q?vQORq0nGrU1GJGGqjkygMyVDd3OEpM4ZEuNDPkl1Lw+jINoUdvL7g7vKbbb3?=
 =?us-ascii?Q?R84GVl9JmqB66gbk00biLU3CISnxbgmfPoV8yyzbPmqhUTIRzJOtVzUq/FGK?=
 =?us-ascii?Q?tM9vCv71NrS0+qolkubwcOroswl1IbsMDgdyj0CKnprKF0FE+Qys1UVsAACD?=
 =?us-ascii?Q?GimDonXpVJXlkCIumCfHDkFGPd4qIquwkDVWTfodaeHbWJh1FhiDPKD2dkXv?=
 =?us-ascii?Q?JmiBMSZ/Bp+Hb3G/9cKiwIycnl/EW+PJsKduNR+F1h2HHYXp2Gcqy2oP01tl?=
 =?us-ascii?Q?YX8FtArqfrqi8Z3GlY/Lh1ydCAaAk3HpML++bNmcEa0gAwteNyvN1P1f8z/i?=
 =?us-ascii?Q?0K9sskFQpQh5tC1c8Pb/+OzOFsAjV6b7D1Sl8M8Dze/rW4ChvMa+eYEDbzff?=
 =?us-ascii?Q?/o4Mh4u2gRe1NvH20Eh+eX0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196701ca-c4ca-41f1-dcfc-08d9ca722b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 02:23:14.5693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9MDaTChEtZJjMQE9nw9FIViwqMp2bQuH2ncf5EFR/5wgm0H5r/oyXIoTM59AU/hDj2FW2JZ61LC7Y/Bj1cPxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1490
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Sean Christopherson <seanjc@google.com>
> Sent: Wednesday, December 29, 2021 7:54 AM
>=20
> On Wed, Dec 22, 2021, Jing Liu wrote:
> > Statically enable all xfeatures allowed by guest perm in
>=20
> Statically isn't the right word.  It's not dymanic with respect to runnin=
g the
> vCPU, but it's certainly not static.  I think you can just omit "Statical=
ly"
> entirely.

make sense.

>=20
> > KVM_SET_CPUID2, with fpstate buffer sized accordingly. This avoids
> > run-time expansion in the emulation and restore path of XCR0 and
> > XFD MSR [1].
> >
> > Change kvm_vcpu_after_set_cpuid() to return error given fpstate
> > reallocation may fail.
> >
> > [1] https://lore.kernel.org/all/20211214024948.048572883@linutronix.de/
> >
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Jing Liu <jing2.liu@intel.com>
> > ---
> >  arch/x86/kvm/cpuid.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index a068373a7fbd..eb5a5070accb 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -204,10 +204,12 @@ void kvm_update_cpuid_runtime(struct
> kvm_vcpu *vcpu)
> >  }
> >  EXPORT_SYMBOL_GPL(kvm_update_cpuid_runtime);
> >
> > -static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> > +static int kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> >  {
> >  	struct kvm_lapic *apic =3D vcpu->arch.apic;
> >  	struct kvm_cpuid_entry2 *best;
> > +	u64 xfeatures;
> > +	int r;
> >
> >  	best =3D kvm_find_cpuid_entry(vcpu, 1, 0);
> >  	if (best && apic) {
> > @@ -222,9 +224,17 @@ static void kvm_vcpu_after_set_cpuid(struct
> kvm_vcpu *vcpu)
> >  	best =3D kvm_find_cpuid_entry(vcpu, 0xD, 0);
> >  	if (!best)
> >  		vcpu->arch.guest_supported_xcr0 =3D 0;
> > -	else
> > -		vcpu->arch.guest_supported_xcr0 =3D
> > -			(best->eax | ((u64)best->edx << 32)) &
> supported_xcr0;
> > +	else {
> > +		xfeatures =3D best->eax | ((u64)best->edx << 32);
> > +
> > +		vcpu->arch.guest_supported_xcr0 =3D xfeatures &
> supported_xcr0;
> > +
> > +		if (xfeatures !=3D vcpu->arch.guest_fpu.xfeatures) {
> > +			r =3D fpu_update_guest_perm_features(&vcpu-
> >arch.guest_fpu);
> > +			if (r)
> > +				return r;
>=20
> IMO, this should be done and check before "committing" state, otherwise
> KVM will
> set the vCPU's CPUID info and update a variety of state, but then tell
> userspace
> that it failed.  The -EPERM case in particular falls squarely into the "c=
heck"
> category.

We did consider your suggestion in the first place, but then adopted
the current way with the impression that all vcpu related changes are=20
done in this function. We can surely change it back to the 'check' point.

Thanks
Kevin
