Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F17480F20
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 04:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbhL2DBY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Dec 2021 22:01:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:23167 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhL2DBY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Dec 2021 22:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640746884; x=1672282884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2tVw15A7V+NjMEtwqMLZ5/md2a/SodLKHfBi7NQ1xMk=;
  b=ALnePv4XLwtHGUdCLBhb19kE469aTa4aD9xEuMqU6ExYZANAAILslU2/
   kT6eHjmrBvy380/lgEFbSM+v4NTY3b444pIqej+Lvi7FrwalXYUaoWy4+
   K88rehbse12U/Zg7b4oKj/XUKqbul904yUfaeX+iMWBqXFyUKE44U/HJ/
   BgxVUFwVovTH+iJ9fG4zF1BKvPAhvXWcxU9lMnv3N0Xne4ArDeOMWXbkg
   uK8JCkfCQhuPG9KNkBfgUMTQIXESQg9kRd5JfPMJLNFDuY1S8AcIL005m
   YxbJLdzjcVFxAKNgfQArL19eWJNQBPf+Ez3cBbkaL/FyPXpTVc87ZIWVP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="221449817"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="221449817"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 19:01:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="470194562"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 28 Dec 2021 19:01:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 19:01:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 28 Dec 2021 19:01:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 28 Dec 2021 19:01:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9XrQhpf3pknBs0z702nyKkAAW+mH/g8bQlyqbWnqFnfQQvr+UCYlfPYdCgMHdj3+06Z3POZu+nwpkdWeZOip8mA3JsEIrwmbUMhoSahtrW46nUHgVsNxavQInEysdFDK9VOnmzi5ja/r5MdfCNe8123I4X820zR0LSAp06S06fc0qeFzxlTl5GTg/vZ7J186kuFiItGk1TToZWZ2ZxbqoXJRUUNaSc6sCqAviM8SDvk/4l7ybjG1q9KGQy9iNbvlar71L+elwxXZh55fmEXyyC2vAjgkjg3V87YjaU/r3pNysii+Kk7rPmlpoteK8I/v05Qy9e8wNn/24cbPvW8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cC4FbQMFdChHh81wJY7Q8VqnQ3zxx7uv77UI8AX2qRE=;
 b=KliCtidTyQIJnOUAHHFLVkiYQ334jQCTntgkRwbbx5laJe7+GQwSgFXQVpZBw1kcO2YLFknPdoeU+ljuGubFzq6BRugDyLkc3qRkianun+G9/lCR7uKGd6K5wpW26D8a2eWwtSE3Yi3aj5/Eyl7ZCptQrAbw7ntYxmmL1sabz4W06x0zENWVn8JAMqvMu9gTg0doUebVREOEN8hHAqQ390K+pnN+W7O9euNQ99uZRv3n1zJvnAguF1sM7PI9c5lhnq9qEhIYOVCNoRv9A8gDWNOqHRzhG8zFqcerFEQDxsAbNDM6o3QYUdHugopHdk8B0OrmPkCB4RXd7PVDGTMNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1857.namprd11.prod.outlook.com (2603:10b6:404:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Wed, 29 Dec
 2021 03:01:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 03:01:19 +0000
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
Subject: RE: [PATCH v3 16/22] kvm: x86: Add XCR0 support for Intel AMX
Thread-Topic: [PATCH v3 16/22] kvm: x86: Add XCR0 support for Intel AMX
Thread-Index: AQHX9zE1CDJu9TXQlki+g1y/a9bZPqxIpY4AgAAqVMA=
Date:   Wed, 29 Dec 2021 03:01:18 +0000
Message-ID: <BN9PR11MB52767A662EE36412B166244B8C449@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-17-jing2.liu@intel.com> <Ycup8opdHrjCIy1V@google.com>
In-Reply-To: <Ycup8opdHrjCIy1V@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7175855a-0afb-4e52-3cd4-08d9ca777cab
x-ms-traffictypediagnostic: BN6PR11MB1857:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB18571F333B159E2DC6DCC6F68C449@BN6PR11MB1857.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tQs/sO18emGoUlAcP7k2YxMDCfS8hwENl0XbDlgtuEd/6EFmsGRNizlfXpBMDWF0yYXX0ZCbG6+aAbW6s/87yDlI0mB5QOOUkzjuDkkIE4+Kfo9m0pcMLFrc7sVgHU0ZUUFr6k4V874gr+TPm2uXDb7v0ieQkLxVxzR/Fe5A9oWX3mqlnm7yvEL5X8Bd+0MKelE3LeKIg2DZ8iFjdnSZu5cdtX78+c5IHp4SroFhqBHc9jOuGdqjhoVqfmJmj+apockNo5m7qeK9446ctO1XuEothZbUNM2AwHySslDVUaus0FGzsJw0xDg+AUR/iu0QviyZRD2mY3GjKhHWlFF5bDsekyZCQ9k4ZgJ8Uha/xcp1HEZPdaIen3AQBGcXqpRGHrRxfT19HeVemQWfaErewqf3z0qK2nNLqkxSqQRRb+yqRFWW2XbFYe9RYOaH8zyQZRNQbuT2SqGVf12FQdo20MF6Ma3FpVERvgwzXigm5H1b5IQS7SouR3V9babgB6wyegwJF5PQDNQ0+VrMRPDnHYNssJuL4d7aC3C6Fk6yXkbdb/AyalA7HkdBaQPoZ/SWf4HVhD0irDmx2uv5XnJ+MJ7wtAjHNHRNNlAaAKrCIakU/5QcD9Bq6ZHsRUhLL2nv0RlI4Zd1Gry/Bf0aoyjYR1xOaOKsRXOXukeP8CGe+bSpk0QG0/kxgIK/NxkAb9U+YL9/XndeA5XPQn2Uk/hPUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(8676002)(9686003)(6636002)(33656002)(7696005)(38070700005)(55016003)(6506007)(54906003)(71200400001)(5660300002)(316002)(7416002)(508600001)(110136005)(83380400001)(186003)(2906002)(52536014)(86362001)(66556008)(66446008)(64756008)(66946007)(82960400001)(4326008)(76116006)(8936002)(26005)(38100700002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/ga222Meoz7bPpRQ6XFfGW30+6tqXkzR+2b9TXsJzf0ogmz+RaI0t/NujDyS?=
 =?us-ascii?Q?t93JOXSdh+aN00/DWIiEUZ6tWxCBtJfGi58u1tLewAVPzIAHyGprrcaNbLMn?=
 =?us-ascii?Q?WuITKxfXh0vsR4STRYlptZI5QENaWGYlsAtBviZi52MAWBb9eHqiFMf6Q5ay?=
 =?us-ascii?Q?U0rIo1h9n7EWg1CGMR6YPq0gpzzUsgIa8oVnPXjO1zsZBYXI0n+8tl3FEbkm?=
 =?us-ascii?Q?7KsJBN+D1HNPu/dHy/o7ygfleTKD+dELxZdpokXBFHvcWJfGYgm4HP9nS11K?=
 =?us-ascii?Q?7FYUhZ8Dh5yBDHgKiwqnh809one/TikPSVCYsQ3QK1/glpqbXWzNJGpbNGFt?=
 =?us-ascii?Q?drmcVypi/ll8R6J1yDi+OhtB9q7Vd94LDd2zzVUos7RVFPdcmaGeHQ9pe1Ml?=
 =?us-ascii?Q?DRSNdoUz2kBM48hSDiUM79dJVE07atbtHdK6I/ONpFitmoRuIL44AJU8lsIC?=
 =?us-ascii?Q?ZcDRAKNna52J4pmPTAj3/ywbV1vf+K8mww6xaAylWENKVXb293DemzX50Cpc?=
 =?us-ascii?Q?aB4iIm2IUALQUfYV5v1VCujFgL7Pb1Cc/rAPacv//TMB67VvQ+cZ1OBSZqqp?=
 =?us-ascii?Q?hSFDds3Ov7EUM79K5Ihm32rwEsPicPFL8Eb8wz/D2GAwXpoUpb0XCDXT5OX+?=
 =?us-ascii?Q?0hGSZWczxrvztYQZjm/xiNZyZ0zInn+g/K7vtWELEfCpHlsyx5z4QabRSPAR?=
 =?us-ascii?Q?I8CZHa78ekGpJ/aK45hoWDZ8Inx8d6gcWpDNYBJgmsWiB1+0GQDIm9QP4kXT?=
 =?us-ascii?Q?zPwXE5cPrP4aFgqoExRLn2E5mmPDE8x4+Z4fkG4Z2DtAQ6sGN64DbMXD98S9?=
 =?us-ascii?Q?HIiTaCoaI0XxxBYHqZHOXHjLYR4H63v6DR0AO97V/Pz8530Pkm5cUFqLxR6c?=
 =?us-ascii?Q?/jgd09dqiSHFxSOMzLZAUrF289ZNs9Z3K6UpNbuRY/hL19TYuRHaLb1+L0KT?=
 =?us-ascii?Q?ZnzhwZ9grlV5vQ+ze6I8Zqr06d3iTomSp0P8C44WGCMMQgnf4tGeJFdrs1um?=
 =?us-ascii?Q?CcLyeD1DWXu3JFOWvEXo81jRZfrLVQe7z3PNu9yJ7aOH5iNsWBJbSG6S0YI2?=
 =?us-ascii?Q?rAoeWOt6VrYjP+zfDMunCZr7ZtDQpjflh8G8zryoNkgxQP7FwlrcH0Ywwn9T?=
 =?us-ascii?Q?0mRTZ6XVEWvpg36Jmtfr3pCRtEMGiuA/PieJ+Kx0QnjKc9DXGwbc8XH0ogZl?=
 =?us-ascii?Q?41nichJ7t4MtEyVOAWDkH62Ml1Xf0+U4hqNtA/5IxVQxEihDofsfvx9mNvQi?=
 =?us-ascii?Q?WpfDYDX0yUv9eSyPaJMx+wgxeVhZ4XJTuanmT2ztQ7jA/e6zlQfNJMSZBShS?=
 =?us-ascii?Q?DX6IALhr4gyjnvkdzOcgb4kxi2LO/GH2UFBtIMjezuANh+oP76Rd+qrvMnGJ?=
 =?us-ascii?Q?YI5+LeKdVbnee7dP8OAy0K4bpTVrjb64qjhQDdm9uGqh1XzwF9uMLv2GbPJV?=
 =?us-ascii?Q?dBGecyUn8qBNA9nwFhzHeN107dHI5gXcLcoDwkXMgL1CBIAvf8j++XklmeaN?=
 =?us-ascii?Q?vGX9HDlsaB79bvV/APz2ZYekKVkNWwifcPnGDeP0IXlXKIrY9oLqb9KZiY6Z?=
 =?us-ascii?Q?iHRd3S2au8qVqgVUxZLYYquTl//PXe2KaIKHk3u6hXLAXl4HA00Te54amyvf?=
 =?us-ascii?Q?51v+dfAEv5ADVdbN550ZHuM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7175855a-0afb-4e52-3cd4-08d9ca777cab
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 03:01:18.9399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNa3wkvcgBcUNbJCj8MooQbKlM4MK9QMWTjGK9bKKsd2PCLX9ZR5gqLFf51XcfI5PGx9JNyOD2J8ORFR5JAfbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1857
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Sean Christopherson <seanjc@google.com>
> Sent: Wednesday, December 29, 2021 8:21 AM
>=20
> On Wed, Dec 22, 2021, Jing Liu wrote:
> > Two XCR0 bits are defined for AMX to support XSAVE mechanism. Bit 17
> > is for tilecfg and bit 18 is for tiledata.
> >
> > The value of XCR0[17:18] is always either 00b or 11b.
>=20
> Is that an SDM requirement, or an arbitrary Linux/KVM requirement?

SDM requirement

>=20
> > Also, SDM
> > recommends that only 64-bit operating systems enable Intel AMX by
> > setting XCR0[18:17]. If a 32-bit guest tries to set dynamic bits, it
>=20
> This is wrong.  It has nothing to do with 32-bit guests.  The restriction=
 is on
> 32-bit _host kernels_, which I'm guessing never set the tile bits in _hos=
t_
> XCR0.

make sense.

>=20
> > fails to pass vcpu->arch.guest_supported_xcr0 check and gets a #GP.
> >
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > Signed-off-by: Jing Liu <jing2.liu@intel.com>
> > ---
> >  arch/x86/kvm/x86.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index a48a89f73027..c558c098979a 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -210,7 +210,7 @@ static struct kvm_user_return_msrs __percpu
> *user_return_msrs;
> >  #define KVM_SUPPORTED_XCR0     (XFEATURE_MASK_FP |
> XFEATURE_MASK_SSE \
> >  				| XFEATURE_MASK_YMM |
> XFEATURE_MASK_BNDREGS \
> >  				| XFEATURE_MASK_BNDCSR |
> XFEATURE_MASK_AVX512 \
> > -				| XFEATURE_MASK_PKRU)
> > +				| XFEATURE_MASK_PKRU |
> XFEATURE_MASK_XTILE)
> >
> >  u64 __read_mostly host_efer;
> >  EXPORT_SYMBOL_GPL(host_efer);
> > @@ -990,6 +990,12 @@ static int __kvm_set_xcr(struct kvm_vcpu *vcpu,
> u32 index, u64 xcr)
> >  		if ((xcr0 & XFEATURE_MASK_AVX512) !=3D
> XFEATURE_MASK_AVX512)
> >  			return 1;
> >  	}
> > +
> > +#ifdef CONFIG_X86_64
>=20
> Drop the #ifdef, it adds no meaningful value and requires the reader to t=
hink
> far harder than they should have.  Yes, it's technically dead code for 32=
-bit
> KVM,
> but no one cares about performance of 32-bit KVM, and in any case it's
> extremely
> unlikely this will be anything but noise.

ok

>=20
> > +	if ((xcr0 & XFEATURE_MASK_XTILE) &&
> > +	    ((xcr0 & XFEATURE_MASK_XTILE) !=3D XFEATURE_MASK_XTILE))
> > +		return 1;
> > +#endif
> >  	vcpu->arch.xcr0 =3D xcr0;
> >
> >  	if ((xcr0 ^ old_xcr0) & XFEATURE_MASK_EXTEND)
> > --
> > 2.27.0
> >
