Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153F9485DC4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jan 2022 01:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344344AbiAFA4D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 19:56:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:46384 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344138AbiAFAzq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 19:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641430546; x=1672966546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zUtm6wGKHLBRl2OVbZ+573W/c54EyZauTkrydzF4R8Y=;
  b=nXGSZLmfPbxs9pm3KE7kSlB5ukg43nZDEFJFbUd9T/Q7PWuB5mpPp7s/
   FeELl+JJfVptL9Ggf29Z0tvwQG0DWWfoHRVPfXiHfihml+f7CoXjOU2CF
   yXB2bXj4K6oAGbs2IhDLWr3Arq0Nw0Uli7IeUnKkY8v3Xf6cV+CYL3OQm
   O1Ptq9G4+mxy9XCIC5GAqkMUGgIMVlWhmIfn8EnLNuDfNqFU0NImD+HUs
   wHTiemKTaQL+c6SV89tiBGvsZzwnlPVZGPMKOWW8ohH1ZaQAFMcu5VLpb
   OIH7bcM9zlLv/YKE5G1NritBOOQfIbYeid1k+lCzTBSZWbMEbJ0M3mu/X
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240111208"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="240111208"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 16:55:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="556733339"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2022 16:55:45 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 16:55:44 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 16:55:44 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 5 Jan 2022 16:55:44 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 5 Jan 2022 16:55:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmDemZp+OKE7amQHp3qbH6FBcMEDDcpOB1j9AwGM4pvcoQXaYM0U/j36TozL1idlm5UP7iLgJRQn2+l1+YODT87bZBfzQ8urhlYhm0bMU4m6sQwGu7IcqFc51hat/ij7GijX7Hv3MqeOhktKQH/zzP2y6gYHFXMfBm5xfJn+iBN7hP1QGjN+h3/nns9hAep3bgQlAfzJOZhNn/UfJ33Hx3MEjPavxkkHUzUz/bZofVfRUhpMU0k6XRhRWJz0CkY6L30JIhRNmxWIxJpn0mUNJUqjHc7opI6C/j4Udrpbh0GbdyCYWez67mREQ8BR0MpKqM9YNSvck9zm/k4tiQsLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aToiL9PWjObcM0m0VcIULv1jD9aPs6zZdvn+nQihhPg=;
 b=itqt/3vaYl48nelsoj4qpWi1c+X8qvJRewyNLB5EWGrP5tgYFwYUTp6srGud3wN6eWIeLBCUm7L7vLzsmr/3YPDSwRys7AIfhU9vWQ6AAFjfr0nStbmZy9A4PctXMCdghEGs7Ps/hkcM+dGWgRBrHuEtp8d+5zOsDwQPCojUjaOMU3B78oemISJnclNgfd3apnOdQMu2MQdC7acHu6yXCS2hdRdrbE4ecSfmmi2nDYPBByUgqV10ekwehFBb0AN3TE+V/gtjDvuoJ0ygTqpdJ7fLtAyPzlQst2CN4yocIBBQ4MYQFXzjnFjiwau3b3LO1GHQVmwyXzUM+TLUrWHl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1393.namprd11.prod.outlook.com (2603:10b6:404:3c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 00:55:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 00:55:40 +0000
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
Subject: RE: [PATCH v5 12/21] kvm: x86: Intercept #NM for saving IA32_XFD_ERR
Thread-Topic: [PATCH v5 12/21] kvm: x86: Intercept #NM for saving IA32_XFD_ERR
Thread-Index: AQHYAjDG3grRPUB6WkKC4V40NrLWoqxVAQqAgAAqkbA=
Date:   Thu, 6 Jan 2022 00:55:40 +0000
Message-ID: <BN9PR11MB52760C5B8289B2DEF32AC63C8C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
 <20220105123532.12586-13-yang.zhong@intel.com> <YdYaH7buoApEVPOg@google.com>
In-Reply-To: <YdYaH7buoApEVPOg@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ef0d11a-2a7f-4a20-d318-08d9d0af4282
x-ms-traffictypediagnostic: BN6PR11MB1393:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1393AA8B058940D4DBF662DA8C4C9@BN6PR11MB1393.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J5/UOoSwVs5ySbk5f1TlCrIUyYEe4RxUZpPcqMRiWJGEjXjBWYdKu2dFz2djrVDbBm9zRFJRecI3dyVuHK6f88hKcKZAcWQLADhihUPmKi8+ZXTledc5W4j/KPnOA0L+mLSmMBbZzafaYHZmS554XhiAfZ10zS9UsepqADok9JvO8Eqwk9ljs9meFMULOWqjYDpG5tM5cPTuz0reTQkoproG10HNstWpGuPAqjzD3Sg0jy/6oybLmzT4Xb2GooJR6WEZS3XzKUqmCH3GcPryYjJ+W/WYS/diW9KE1ihteWPInbf9fEdrV9uHErin5EqF6e0/CUsWYu1GTPPO0/5qcc9j72wS1o88k6PdnYAUWRN+8dS1mUXCWEFHn9f2lrK+aaL6NS+l3QO/S2RQMjJcl2eVCKPbywJhqI/0aQT1E9v7Y7qUzzlCFZqk4r9SHMuEpB1vB+++p1pIISLMnRCJr3k/uIEynBC/UeFkinIWQMIcLwl9cekUNv5gaPsPMZcOeS3NXFkni1dCYHOXK6Y1u9Zf1iLhmneGr5PR5AlakSBBCLZ7tgB1kHq5f7z03yw2VG2MXcvu0YoeRKZsMNmib+PR3+JSVHvScv6H5N69Cb0eP6cEXuqxTH8MV5OeaJCXrROgAN9VhZQ5UlEB2O1lJmEbLPQ9QOBvdsOW+5iQK601gTNeYeoLO7dQ8gG8EpIEhzAXo7OmHadNAK+Gfc4HIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(316002)(6636002)(8676002)(64756008)(66946007)(5660300002)(66556008)(110136005)(66476007)(76116006)(66446008)(52536014)(38100700002)(122000001)(54906003)(38070700005)(86362001)(508600001)(55016003)(71200400001)(7416002)(186003)(4326008)(9686003)(33656002)(6506007)(82960400001)(2906002)(26005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QRzvs0kf+4m/TZG3ztXn+Kmi5nMJY9cfFJOaAKVi397WiwHRpYx+vRRvA6fo?=
 =?us-ascii?Q?6RY2oOGC6zNA0sm7cdHUZ0m9zcIwEv4SEkHOgGpaKqB3mddcpS7cizWY8mUz?=
 =?us-ascii?Q?ixn6Q7igFl0h5Sk8askCrbco726vBbr6+uauwAp3s5+MECqm3vipWpY77u1N?=
 =?us-ascii?Q?URNd2bX5RWcN12ahujoYmcP/NHA0aZAMgaXcGHWsybIDxGSArOV8Mzc4akFj?=
 =?us-ascii?Q?Qjv0JsUtd4VVTkzf/LDAFRou1C6TuUqW0GYu4bEi4zYf/Kk6kK3QM/Ce8rI2?=
 =?us-ascii?Q?efPCQliSsS3ic/YYBfgTpUjspZXScH/IHZfdT02KW7oW2/hmI4H/0/66GJ5Z?=
 =?us-ascii?Q?3gHBVfBI2hX2xLUxz7P/W7IgFz7CNEC6FdRoaQWcAa6p9y4D13lUAfCRKYdQ?=
 =?us-ascii?Q?yuP3raiYXiAdacgKw+QbuOLpp9qja18GufjfaxgZwKvO1Ccp2yqgaWkYZlp8?=
 =?us-ascii?Q?54O92VeNLWo7cHjhaQXf8XdlPxDErWADiiSSscZjLMPKTc+SKv6vU0OpkMjC?=
 =?us-ascii?Q?KZEmVZ7ZCzPqmpqmk5hG3pEMrZMQ8uDRCXcomtLjdU/PWn362Jc+4nM+OEon?=
 =?us-ascii?Q?PjF7+oFBJr0oG58Ot+WHiFT+JdciDxgW1h4tunk8haKjPhWVjasNB+HNDXC/?=
 =?us-ascii?Q?zlC/Lq8y5bdm+JwnsD1Lk5glLJgO7lIj/34rSaPOxvEcEAS7s/UO/B+AoKHc?=
 =?us-ascii?Q?g0UshkUwy7hC2GfucANa2t68izdCmHD1/e1ZU6lucSvvvUaIB2g3KhfHRMHt?=
 =?us-ascii?Q?fhO0pp6efRgtKmDlCQPccomZ4QYTGmB//aU0FoAeBf79p0ha+qo18lxNWREy?=
 =?us-ascii?Q?LDgEgIzNzhYgvjBtiEh7hIssFO6EA+VPyhLx7c9auX9XvoSw/3l5yuNoGRpi?=
 =?us-ascii?Q?lMHQzuMQJbefzY08jmhAK1eKu5n3m+dSs5w8O7biOj6Y5SdbLFL9g0YmfGcI?=
 =?us-ascii?Q?guyjJGviICBOudFJN8TGoe21uQFD1Jft4bYzRTHYF504pqbQafhtxzvHFJHP?=
 =?us-ascii?Q?M/nkL7nKkxOcnFInFAIuiPIOp/HkXeWMrloejBo1JVVv/TsS10B4AeQgffLz?=
 =?us-ascii?Q?BQDnrFdxhHm0nTBQdyxUDYutrBxSM2jIheWUR3W0eeT6iVys0NrAhIKPG9Bm?=
 =?us-ascii?Q?tt6hEXFPJbFMbs3SGxqEM+pr7lQC7/NlsrsPEOH1TJbm7bS6G3ktv3ycZGct?=
 =?us-ascii?Q?hmE555dj35kNaewgv0eRo9mqZIPXfgoVJs2OLO/lxQIubT38i3jBJAvtIudy?=
 =?us-ascii?Q?JTDiL3iZZBfUWMvCFVJM4wzci0Gzc070kpEKTGyOePxb8AGFPeBU2iEWlUlw?=
 =?us-ascii?Q?Y8THP1LCummFGZB9DJjEFUy3j2qtY2waVjo4nYcGnpZVKvQVZI7Jk8gwM/aj?=
 =?us-ascii?Q?KjcH1MbMEZjChs67X+W6BBGS1C+6PS6m38l9vqLcQiKADSaSFfaLUgzWkBWC?=
 =?us-ascii?Q?evEDWgZs2hDycQCIpNZyP1VDeRLbjFJmyKRaZdzU2uQvmYzgFVgnTBS8suSR?=
 =?us-ascii?Q?09lYCaesLbP48XejmK6bR120tLys51yyg4Wa7aiNfvePaXw9N3qxzfB1q1Zq?=
 =?us-ascii?Q?tXtqv5nL9pprn1pYuEfYgxSuPtsrdQecIboDjqSzFeOp5r4XZxaF+Ae60nSS?=
 =?us-ascii?Q?FNsmfdSuuz1ewwbfWTsTRTI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef0d11a-2a7f-4a20-d318-08d9d0af4282
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 00:55:40.1169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKbuX1zb4NWQG/GY8h+SDBLwUU9jJ8AoHwUbkP+OovRdecA1TbMVrU1gdpQyjpE0zdLCkPFVDs3KXti/gbJ5Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1393
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Sean Christopherson <seanjc@google.com>
> Sent: Thursday, January 6, 2022 6:22 AM
>=20
> On Wed, Jan 05, 2022, Yang Zhong wrote:
> > @@ -6399,6 +6424,26 @@ static void handle_interrupt_nmi_irqoff(struct
> kvm_vcpu *vcpu,
> >  	kvm_after_interrupt(vcpu);
> >  }
> >
> > +static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
> > +{
> > +	/*
> > +	 * Save xfd_err to guest_fpu before interrupt is enabled, so the
> > +	 * MSR value is not clobbered by the host activity before the guest
> > +	 * has chance to consume it.
> > +	 *
> > +	 * We should not blindly read xfd_err here, since this exception
>=20
> Nit, avoid "we", and explain what KVM does (or doesn't) do, not what KVM
> "should"
> do, e.g. just say
>=20
> 	 * Do not blindly read ...
>=20
> > +	 * might be caused by L1 interception on a platform which doesn't
> > +	 * support xfd at all.
> > +	 *
> > +	 * Do it conditionally upon guest_fpu::xfd. xfd_err matters
> > +	 * only when xfd contains a non-zero value.
> > +	 *
> > +	 * Queuing exception is done in vmx_handle_exit. See comment
> there.
>=20
> Another nit, it's worth explaining why XFD_ERR needs to be read here
> regardless
> of is_guest_mode().  E.g.
>=20
> 	 * Injecting the #NM back into the guest is handled in the standard
> path
> 	 * as an #NM in L2 may be reflected into L1 as a VM-Exit.  Read
> XFD_ERR
> 	 * even if the #NM is from L2, as L1 may have exposed XFD to L2.

sounds good

>=20
> Side topic, in a follow up series/patch, it's probably worth adding suppo=
rt in
> nested_vmx_prepare_msr_bitmap() to allow passthrough of the MSRs to L2.

will do.

>=20
> > +	 */
> > +	if (vcpu->arch.guest_fpu.fpstate->xfd)
> > +		rdmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
> > +}
> > +
> >  static void handle_exception_nmi_irqoff(struct vcpu_vmx *vmx)
> >  {
> >  	const unsigned long nmi_entry =3D (unsigned long)asm_exc_nmi_noist;
> > @@ -6407,6 +6452,9 @@ static void handle_exception_nmi_irqoff(struct
> vcpu_vmx *vmx)
> >  	/* if exit due to PF check for async PF */
> >  	if (is_page_fault(intr_info))
> >  		vmx->vcpu.arch.apf.host_apf_flags =3D
> kvm_read_and_reset_apf_flags();
> > +	/* if exit due to NM, handle before interrupts are enabled */
>=20
> Nit, drop this comment, it's slightly misleading since the #NM isn't full=
y
> handled
> here.  The comment in handle_nm_fault_irqoff() is more than sufficient.
>=20
> > +	else if (is_nm_fault(intr_info))
> > +		handle_nm_fault_irqoff(&vmx->vcpu);
> >  	/* Handle machine checks before interrupts are enabled */
> >  	else if (is_machine_check(intr_info))
> >  		kvm_machine_check();
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 21ce65220e38..2c988f8ca616 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -9953,6 +9953,9 @@ static int vcpu_enter_guest(struct kvm_vcpu
> *vcpu)
> >  	if (test_thread_flag(TIF_NEED_FPU_LOAD))
> >  		switch_fpu_return();
> >
> > +	if (vcpu->arch.guest_fpu.xfd_err)
> > +		wrmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
> > +
> >  	if (unlikely(vcpu->arch.switch_db_regs)) {
> >  		set_debugreg(0, 7);
> >  		set_debugreg(vcpu->arch.eff_db[0], 0);
> > @@ -10016,6 +10019,9 @@ static int vcpu_enter_guest(struct kvm_vcpu
> *vcpu)
> >
> >  	static_call(kvm_x86_handle_exit_irqoff)(vcpu);
> >
> > +	if (vcpu->arch.guest_fpu.xfd_err)
> > +		wrmsrl(MSR_IA32_XFD_ERR, 0);
> > +
> >  	/*
> >  	 * Consume any pending interrupts, including the possible source of
> >  	 * VM-Exit on SVM and any ticks that occur between VM-Exit and
> now.
