Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902A0480F4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 04:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhL2Dfi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Dec 2021 22:35:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:41294 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233058AbhL2Dfh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Dec 2021 22:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640748937; x=1672284937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PWHrdcWhO9svLojTTxn8Ax2zcyImZKh7bg+j0cnZmb8=;
  b=AuUnki8hXtYBWX6rzOx/urEhpmMDlKPHTutpiDKqRz7D76dW99H/2MrF
   Yd7u3AwSTileeLr7qraqcbMnw5dn+uK5XaIZ+nC7ovmTvAZlLDkYPuupH
   lP+facqV9nyKPbPsEZek7zaZJwVQLlYIqEcwlsMKq29rGCVKf0BLi/Teq
   Ap2JyYCkqzYiQlszSHcmQJUglNkfwfRFj0E83SnrcUduXXSSH0ZgDo5fJ
   z/PIz5gMtkBx+deQmEa73ZeswvkpUsSNmqK4uAMjUg8guEx1Ju+HDsK6V
   CGO1aZyhcSFRcZtCL6pQaN+IMBQq7fEG5+cvQvSkNiKEkZSxcU62EYt/o
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="238999921"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="238999921"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 19:35:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="615822092"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga002.fm.intel.com with ESMTP; 28 Dec 2021 19:35:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 19:35:36 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 19:35:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 28 Dec 2021 19:35:35 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 28 Dec 2021 19:35:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RX4Et2VvxiF5Wu7HkdpjWxwYHZSkQ46rk+gVU36sbQs/eLf1Y0w1G5fN7GrWdYZ+fZ9/f1R3RnQ40YlfZkadt2HEOQfQfzzIle46xhbbWzglvAh2fzDmVSQuziJ7uyBBJK3UwAi0ZP/jju2VfSXzEfPXbNkOESyWze99lBSNGzY1KrKN0M9G/GEcRoCvM7jtan813VFBtq4eLYjQylq8d+l/4dUUjF2GBdzWeoXEspk5RXwO9xnFEGL9CEAUlksSC+axwryCj3UxkjkHqU1wkb86/VYW2R6uWgpzm10M9mtLYIlxw17CLzAFd1qsD4QNcdwzOxCdPSf/kD4tGDbAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu5Jh476T4HcBktEjCQnmlxhsvbyvZ7NP+sVjXD3tyY=;
 b=ObJVNJBth8kvXq1kOyZEfX5+4CQ6/+7OJWupgCulUufcGOQhTlIFL/xFOriYghM5N652IxavTb06Y/55s/d2oL5HyN+D6Wcn0XJ7gwLyIDWBiqAJGs28uqYL+nOyaeh2n5OBISEXGhQ+xmG8jNAI/6ju+8M2PIguJ8Mo/st8LHy7aHl9CIvkbY3I+2RN7wBztGdFNaeFYdlS298kkIZZdCfG9M47yczEridN9KJ6xH7v0nZodlgXraSE+I0dJDwHCJafV0KCtLgiPb0ThnAHLem23QjK6RfNn92xOIi0taV9x6OjWKEF4a1pWcokLAe3o1HSs+6eM0f2kGftEZwd3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1858.namprd11.prod.outlook.com (2603:10b6:404:100::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Wed, 29 Dec
 2021 03:35:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 03:35:27 +0000
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
Subject: RE: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on
 demand
Thread-Topic: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on
 demand
Thread-Index: AQHX9zE4gQJMQm2XFEKlfvGX4m1Fn6xIsbuAgAAjG3A=
Date:   Wed, 29 Dec 2021 03:35:27 +0000
Message-ID: <BN9PR11MB527653AF0BEC5BBA007B72408C449@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-23-jing2.liu@intel.com> <Ycu0KVq9PfuygKKx@google.com>
In-Reply-To: <Ycu0KVq9PfuygKKx@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6690ee2-1d1d-47e0-554c-08d9ca7c41bf
x-ms-traffictypediagnostic: BN6PR11MB1858:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1858B8DB8A25598BA96848F88C449@BN6PR11MB1858.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IW8W+J8E/V4Uv8YtZsG7V+eX167jpWoeDrJIutc5tJl8biW/U1JCBios+fh8d2gubcJNUT3iVpnS8lEbD48xomvYqQs4u8Lr8hbNbcG02H6ts9h6ptxGCb+cjcO/NGQlHIADzOPOPVtuhrfG74PGza1d0yj2fszZJskeinhNP6hCCx4V482+rRWkq8iwPziSMc1gLZ/bm4ModO+fICv5QU7OXd960YEvwU74T209qsDBvi/oO+WMBY3P9YOJlHzwq5c2pMUdm7cKUxkiD7kM3PrCtj+rIDmTZIARHMUVzxygLltpbv5pNv/gCSa674Qef85eWKKC6oyR73RKjPV/iPGhRirzXQ2UA07Glp/7EcZDPWlCvkPdSKjviJ+XEec5p+Ql2MXpeEbZCFpuO0ATJScRQXgIw85ZyHBNf52uKm0OTQ4l/qdUI6u4+BLpaafvhXckCae/6X3OWUqyJWEhyWVwiE310plRw0anITLMW5NwNPKwy/HPrDPHcQM42zRf9PZHyzJTVKe7MzI6V4ZZFeLQtHCIZGD4xrFmGnKtXURLFs7EMrvjHlkLf2JUos3Cb+ecQehgWr99/dU8a9ofTNfhXEb5xnt5rPFQ5WeU1KgylwJe1tX75HW7E02pPmaoujxplW4bEHSaTscf2kOJHo0TwD64zUbS6u5TpBP5qGiknuEWeDh6KOvkhmXTOtvGo/7u539igiQhVSmsZF+tPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016003)(122000001)(6636002)(82960400001)(9686003)(66476007)(4326008)(66446008)(7696005)(6506007)(83380400001)(5660300002)(2906002)(8676002)(8936002)(66946007)(7416002)(33656002)(76116006)(66556008)(64756008)(38070700005)(54906003)(316002)(26005)(186003)(52536014)(508600001)(110136005)(71200400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iV1e/AUrx8SucTIhI0zT5pGzjUL8WdfTqvUYvVHcI/YdkIyUqsolU0Zj9rFc?=
 =?us-ascii?Q?uzOD3/+Bkn/MZAk2A+H88HIW0q7AN2KOKYwsREvRHb/wMJf6+Mb/Vma2k1tC?=
 =?us-ascii?Q?nfkO7tumz3fyeBV4x3tM276/SEugXLmI5tRRK6B0GuBrAmPJdfFlLjklgNQQ?=
 =?us-ascii?Q?los+NMXCGYYCFo8HFsEVV++FOkNK3xlkRDvr/KUSUZMGjibU9XHvp27pO+RT?=
 =?us-ascii?Q?xT9d5CAU+gqETTM7Y69XlZ50o5jn9bUzlJ2olhzog4aJrDEstFVTYmQx0lYE?=
 =?us-ascii?Q?EvmSZhH4fxyJLVNWliBmort30Ape/P/ojSwn4grpGG5EV9o4qf/slyqW7LUk?=
 =?us-ascii?Q?uCQWco0HC55xmGiUeq7YoAXBDtvCSwauTOzGvmXTsMtdRuTfYNnrzLpBg77E?=
 =?us-ascii?Q?0/d9cNN0R+6GQLrIQBM6Qga+X2jCVQ4xxFGTNqBiEXVVHTEeQ2yp/fq/Kc98?=
 =?us-ascii?Q?UKQGVsyt70J0CwQd4AUWu1Go6FPfnq7cBy15T6dndPt10WNHL7MqX35ioKVv?=
 =?us-ascii?Q?bxQkDciltvWa5I7uI590CNRr9hA+me3wGC5CHywunmkC1KoXqSL2miAgK7O0?=
 =?us-ascii?Q?JJcDYcqCH+Cxb9w/hYF9CLW/RX0sKW3YxGdRxIt20czB0+uzsF59u9mN3PrG?=
 =?us-ascii?Q?H8ohO8OwZbYr44g7Btn+K0LWGi4ID+DcdCCBhNZd6rgkP+GB2QaNFC7CrgUc?=
 =?us-ascii?Q?9xVu9Bl87RhQbpeI76UFuI1XwKdverUPFnRlxCi6oclvKJpablGV/MjpIv++?=
 =?us-ascii?Q?adfN52u5l7KALj6vaLCYzZezI+T7FPIZCV4+ZASkzLFAYdQq2nert9b79OaY?=
 =?us-ascii?Q?f4WGOCQFA6Hwr4gWz0OXENdw+qxRNGVHB3633/Er+qI5EalWQKFSnvOIYT51?=
 =?us-ascii?Q?fuFrF707YieegSMJM5QEjJ2xzkAgw2kQi/Tev6bHpGPSYm2j0/bSGI8QvjWc?=
 =?us-ascii?Q?oND/opX3kYhm/GcURtb+MQGshWV6M4183e3T/76QwVSu7tiyo31r9X7K4KHp?=
 =?us-ascii?Q?W7nSZBXvxOm68nYdbHFlGC5n4KZKbUbXfyr9iRMeAwyFT6FuzEyM8jcGcFJt?=
 =?us-ascii?Q?c3cm592cSuPTibDjbpbtp4i2ewT4PD28ajeADPpJKouYedREiar5gGbDIQB8?=
 =?us-ascii?Q?LnCgmXyHjHUSr7rGuff6QIW3pdz15dBtYpVsyFnhLcTk7nLYe+Nb/2jMcBzW?=
 =?us-ascii?Q?7Zk6+oTP9Pawhq0Y0Iub8P47ONsCjDMXCxNn+0Qgyg3jXaYCx1RQuci9j4wB?=
 =?us-ascii?Q?O1iFgfs0aVd5Ges1V0o8vljxQ7jLMfPv9MraXRNj9MTI191HllqWoN1NM86G?=
 =?us-ascii?Q?qnOczP/l46rpPIHeWS6iExB8VvItRNBmjapJmxsDrcTKS0sueFTpmdAIj1kD?=
 =?us-ascii?Q?CICim3whw7dQPAS9lVrV+IVnb5VjbOyXTA/4pjhRNF0pBQMfoOcRrYxdKn3Y?=
 =?us-ascii?Q?G+WjqfOJ1QwzmW9joJ4z1/HSYztPct0jUJiY8yAphDaS9Sc7WgkUUhbzx/Ov?=
 =?us-ascii?Q?5TJIgPDrh1fod3ixCnOZDbDgyYJoH/PZRXUFWs2rVVFESYYec/xtPKXWOWEw?=
 =?us-ascii?Q?8TyqdvZpPfLSJNBQQcOjQhFjPcQf4oYJZtJJ/tSdO0h8TU+po7ohtxLCf5gF?=
 =?us-ascii?Q?+iuGrRfCXJL47baDFynJQtE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6690ee2-1d1d-47e0-554c-08d9ca7c41bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 03:35:27.6324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/Ncz1nAu0lk43koeKR+wbWkAnAXMsz4/WnrnpyY9cDYaSMwExguHc8pkjnqESk5fdw1NOiQcIdqggb3D6wnuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1858
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Sean Christopherson <seanjc@google.com>
> Sent: Wednesday, December 29, 2021 9:05 AM
>=20
> On Wed, Dec 22, 2021, Jing Liu wrote:
> > @@ -1968,6 +1969,9 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu,
> struct msr_data *msr_info)
> >  	case MSR_IA32_XFD:
> >  		ret =3D kvm_set_msr_common(vcpu, msr_info);
> >  		if (!ret && data) {
> > +			vmx_disable_intercept_for_msr(vcpu,
> MSR_IA32_XFD, MSR_TYPE_RW);
> > +			vcpu->arch.xfd_out_of_sync =3D true;
>=20
> xfd_out_of_sync is a poor name, as XFD _may_ be out of sync, or it may no=
t.
> It's
> also confusing that it's kept set after XFD is explicitly synchronized in
> vcpu_enter_guest().

yes, sync_xfd_after_exit might be more accurate.

>=20
> > +
> >  			vcpu->arch.trap_nm =3D true;
> >  			vmx_update_exception_bitmap(vcpu);
>=20
> Ah, this is why #NM interception was made sticky many patches ago.  More
> at the end.
>=20
> >  		}
> > diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> > index bf9d3051cd6c..0a00242a91e7 100644
> > --- a/arch/x86/kvm/vmx/vmx.h
> > +++ b/arch/x86/kvm/vmx/vmx.h
> > @@ -340,7 +340,7 @@ struct vcpu_vmx {
> >  	struct lbr_desc lbr_desc;
> >
> >  	/* Save desired MSR intercept (read: pass-through) state */
> > -#define MAX_POSSIBLE_PASSTHROUGH_MSRS	14
> > +#define MAX_POSSIBLE_PASSTHROUGH_MSRS	15
> >  	struct {
> >  		DECLARE_BITMAP(read,
> MAX_POSSIBLE_PASSTHROUGH_MSRS);
> >  		DECLARE_BITMAP(write,
> MAX_POSSIBLE_PASSTHROUGH_MSRS);
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 3b756ff13103..10a08aa2aa45 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -10024,6 +10024,9 @@ static int vcpu_enter_guest(struct kvm_vcpu
> *vcpu)
> >  	if (vcpu->arch.guest_fpu.xfd_err)
> >  		wrmsrl(MSR_IA32_XFD_ERR, 0);
> >
> > +	if (vcpu->arch.xfd_out_of_sync)
>=20
> Rather than adding a flag that tracks whether or not the MSR can be writt=
en
> by
> the guest, can't this be:
>=20
> 	if (!vmx_test_msr_bitmap_write(vcpu->loaded_vmcs->msr_bitmap))
> 		fpu_sync_guest_vmexit_xfd_state();
>=20

We can use this

> That might be marginally slower than checking a dedicated flag?  But is h=
as
> the
> advantage of doing the correct thing for nested guests instead of penaliz=
ing
> them
> with an unnecessary sync on every exit.  If performance of the check is a=
n
> issue,
> we could add a static key to skip the code unless at least one vCPU has
> triggered
> the XFD crud, a la kvm_has_noapic_vcpu (which may or may not provide any
> real
> performance benefits).
>=20
> Speaking of nested, interception of #NM in vmx_update_exception_bitmap()
> is wrong
> with respect to nested guests.  Until XFD is supported for L2, which I di=
dn't
> see
> in this series, #NM should not be intercepted while L2 is running.

Can you remind what additional thing is required to support XFD for L2?
If only about performance I prefer to the current conservative approach
as the first step. As explained earlier, #NM should be rare if the guest=20
doesn't run AMX applications at all. Adding nested into this picture doesn'=
t=20
make things a lot worser.

>=20
> For the earlier patch that introduced arch.trap_nm, if it's not too gross=
 and
> not
> racy, the code could be:
>=20
> 	if (is_guest_mode(vcpu))
> 		eb |=3D get_vmcs12(vcpu)->exception_bitmap;
>         else {
> 		...
>=20
> 		if (vcpu->arch.guest_fpu.fpstate.xfd)
> 			eb |=3D (1u << NM_VECTOR);
> 	}
>=20
> Though I'm ok with a semi-temporary flag if that's gross/racy.
>=20
> Then this patch can change it to:
>=20
> 	if (is_guest_mode(vcpu))
> 		eb |=3D get_vmcs12(vcpu)->exception_bitmap;
>         else {
> 		...
>=20
> 		if (!vmx_test_msr_bitmap_write(vcpu->vmcs01.msr_bitmap))
> 			eb |=3D (1u << NM_VECTOR);
> 	}
>=20
> > +		fpu_sync_guest_vmexit_xfd_state();
> > +
> >  	/*
> >  	 * Consume any pending interrupts, including the possible source of
> >  	 * VM-Exit on SVM and any ticks that occur between VM-Exit and
> now.
> > --
> > 2.27.0
> >

Thanks
Kevin
