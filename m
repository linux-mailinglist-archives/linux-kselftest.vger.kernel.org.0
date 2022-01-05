Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD36C484BA6
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 01:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbiAEAXu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jan 2022 19:23:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:36993 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233081AbiAEAXt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jan 2022 19:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641342229; x=1672878229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pvnhnh22yJk+PN8GLMPnBtapqXQ5D1KZ6olhP9wBbIA=;
  b=XU5YM0qDB6sSG1B2/uKBBp2D47W5cz2B78uyxyZJ9tjWwPAYlmiPlO68
   9MbbgsS3y+8215mp1PhrdYGJntZuHk05U1/8eFFlZ6jBzTcp10EPIUNT8
   LgtkQoyG9f+yK85w8CNIHbxwRWA6ijKPmSv5fEBBqiWa4NcdzaG0T18q6
   w4TMMDswnvrL1o4gq0d1q0wUu64T/iZblcBZCDWR9kAOCx8HcG7ox+5yD
   k5BWRjY2xXM4yoGqnltjqvyBv7BG/L3QZIfbrzjPV70RWO4xfXM/6Hh9T
   06kdDdzeq1zc5gmkSWSEVFefCNj3Cp4mX4+4TFANIofqYhDPj4unLU2d8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="222329694"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="222329694"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 16:23:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="472257270"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 04 Jan 2022 16:23:49 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 16:23:49 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 16:23:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 4 Jan 2022 16:23:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 4 Jan 2022 16:23:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0jQmSLxpx15OZ81D6ahxtKoq4fytPcowc+f1B81xig8Z3U6klsaxh3G+1gb3cscgxgUAV0uKT6VvwqaH1ikiCgfG5VPUz86GA65CdMTVd7yqb8moAycZ2lYH70+LtFTyWInMYbPN6IZVj1sFOjQJ/NbFpF/SbAaFSOhsHFYmbxz4TShpXVp+e+hIwl0EOaTvPrUxBVR1SxDbUYay8QfxVrGr/1WVyWIfZJ+x2DRhvw3712be/YNfByvrdl8Sdc74B5g8IgS/AYJ36TOWaa3ZFSDgGe6dYiigPxdLD9oFIYWZp19S7N14d0q2OOY0oilH5vKf0mg3y0mDX/vxL8Wiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAdVB6w+PLE3B3XLeREky2Wz8YTZDReXctO7/xb+Imw=;
 b=dYbYHXYOP1IilFBD4/nhq+CchhegbKDj4FUzfISceXqWQ7hix5QJRJztN5YFc7zvzBOmisyuisN3DVRmd3yzngYMlRhHgIjPriUHiZOZTWY8Y4Qatp0pL8LTbwgZNk5DUGbWtoNMeHh3sQHnPI8FgIF31u0QiDaVbnd6xMk4vfV7v9+V7ZHuL2P1GpkcEiTldjpdeKD4RlfcVQcKJbKYLO++J+OzNWHcXRadhLmJ+1SsXYUZSOQWNoYsCYowbb8bTZYEo0xAhwr2xd8o4b0IePGtQxvpOJC8pVk0rccDl/HciHI36k5qCRdbQqZ2ZY7nub3/nq3qSaSXFw6FJA5RYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5371.namprd11.prod.outlook.com (2603:10b6:408:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 00:23:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 00:23:45 +0000
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
Subject: RE: [PATCH v4 14/21] kvm: x86: Disable RDMSR interception of
 IA32_XFD_ERR
Thread-Topic: [PATCH v4 14/21] kvm: x86: Disable RDMSR interception of
 IA32_XFD_ERR
Thread-Index: AQHX/LXtnmRirTxyVkeQHwgogS+qmqxTSsoAgABQfTA=
Date:   Wed, 5 Jan 2022 00:23:45 +0000
Message-ID: <BN9PR11MB5276F75834DB60F73B8BDD258C4B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
 <20211229131328.12283-15-yang.zhong@intel.com> <YdShTDdOQISmku2H@google.com>
In-Reply-To: <YdShTDdOQISmku2H@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb598dd3-a62c-434f-4477-08d9cfe1a2b9
x-ms-traffictypediagnostic: BN9PR11MB5371:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN9PR11MB53715F828FAA473611704BB78C4B9@BN9PR11MB5371.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t8eVULL+raoRRpYsEuzbJ+G0IrZjxQbRSVsptZIB7OeJqq5VSiqILZcO1adJ3v/Xp45gDYji7DVmz3gZVaCJfh8sMjqOXy8c1y9XBFQOS5R+xVUSw6lWVWjub+B2mQzhiCxnKnQ7nnkfT122UftNTQG1T6QXI/LDsqZa2CWMMvLujLM7Oz99UClOyVMxQpuNGBa/Dw4cFoMt+kaccMhSfYSD+77jwRbkGRsGO5IzD1PM7/FiHhn5caMd752pelmP1lsQBdeMEdHqhXMgtT3oY2ALVZJPpovppLPLOLIwW+voISJQrpH/OHGjVNTM7GmVZ5jtrI+oVyoC3XQTnge07dnjPuBYcWVRJUFhxGnCFHPTvkU4HOD1GdmaxVqDe56+hUhItm+VtEQrrpTPzMd9jExvJOx0tP1DFc+nrHBl6FcLR21rPcB9F05WwlVssajX9yHG+GAkt9qxqOimYMN8F0iN/3gSwVtZVS3iN42qCJ6ETyHHVQdwJd7UZM2C4Smz8RD/FTSAx5rZ+A/k4+fqUFImMx4/4Ubf0P2drHLWBCY7toyFa6ALaUtuJ0VjSvTJoV5e3uHzA3jPM8lI67xDN8k6NKFmoGt2JMagTsMv2tkgqotXgO/HF5q/2NQIfjvjEeR/nr7kkaE6SzpGEwBqEAR2l1gfe4MJsS7sNq81rXWq7YFsncrFBD719f1HxJfwyShZDzOMe9J9lHVfZs9MgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(38070700005)(66556008)(86362001)(316002)(26005)(6636002)(4326008)(54906003)(66946007)(66476007)(64756008)(110136005)(76116006)(8936002)(2906002)(52536014)(83380400001)(33656002)(7416002)(9686003)(38100700002)(8676002)(66446008)(55016003)(7696005)(186003)(122000001)(508600001)(6506007)(71200400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zgX7oM/qdPohzzwVjW3u7YkWmxcMM+Czn/c0vmZYHVHryF/ltdDBRBI9L/H9?=
 =?us-ascii?Q?jq2M6Wd2Sp666CCIo9BF2k3cgEZj83Mtti+a2Vl56qZoONaKMarNOoUVqTC+?=
 =?us-ascii?Q?rL33uckW5J8cy6DTO8lcIce2M73pkCOVHfL/ellHWogl8RTpE07KHHL4bAS9?=
 =?us-ascii?Q?SLDAbmT6hv9U2DsSRlts8YrrouzgHsEXD5X37NV9qN5zK0Sow70eNTZ5dD9N?=
 =?us-ascii?Q?6W99Jf6NPQwXDJFTw4ChpFY5anNxoCPuc+LxBN6i0cmcQBCm38TlEnyvvD6R?=
 =?us-ascii?Q?QYYMjgqGgJccfBYIzPzrP2Z9ddWMtqY9W3ry6SFltqhGGXTnHI9iz+9hGabo?=
 =?us-ascii?Q?LswmxDZJwAzohaVGSOrctb81GhHw1SYcsj9dTPGkK5lV3UXnB4orthvW4woj?=
 =?us-ascii?Q?59RyXonjxocMYC/lVkQCqz4RmdHDwduXILSZQ3pgmonQPEBwy9v/KSwe+Cs9?=
 =?us-ascii?Q?5q/R6bEe4PkTNaanyfxDg+16GxJ37GZG4UVvTNDShFBFw0RBzauUFY96jeFR?=
 =?us-ascii?Q?wgmq9VrdPDmREK+fXkz2L0zdc55u8lv+hNrhweYEminpKemLOHs+pY+GIfIs?=
 =?us-ascii?Q?Vj5wbyUoFV10NXd1jauoeF11F9oAZ9zz90nj3po13HG5WnvY4NDj7lLcbiqZ?=
 =?us-ascii?Q?RyTxaoipFGhdNw1VZyl0jBzJ0wiQ6QPAeSMdm5d72PtbnPD1jeppjM4U2zCL?=
 =?us-ascii?Q?5a2AhegmF2xDEXfsI8t6v+0UXUD5Nns+6W2MQKgxmEAHhdpZ/aepGok7cWqW?=
 =?us-ascii?Q?ju0xwwYM2AJq/+XBKi3dF25Fq5BAGOy9mfRCYC+eQzsHf3RKugoM+rSSuWm8?=
 =?us-ascii?Q?sXBIqg60Ff5JZS8ReHvD+fM/nWCQrV1zzLUegmb8fbd+xGyeIoih+T5oxthq?=
 =?us-ascii?Q?V5ofJYZ1WhgD2gYSoUNRoRnATKNtg9Mx7g6rN5cAdjXQTXb4nxIZOpRrZvNN?=
 =?us-ascii?Q?TOqRru19UP+ABi72Wk87M3k6srQSfUJi1wLjO+LnMbk0lGrfaEoyn+GM7VEc?=
 =?us-ascii?Q?4FoVnNiJcSu2+U3UP7I1svIZHvyOtxVONyc+5ekqnViNwabCZGekLJuuPAsR?=
 =?us-ascii?Q?iAfvKkYHsdYytmT03q8Gj3IqFrig782i6J7QhM4VC5WZPJhx/feJFhxeGOQp?=
 =?us-ascii?Q?tmNIBtY9tCudLFAkX7sRpLttW9j4NdGZwpvJqk2oCOVJAPyoQjpkb2iBtGn6?=
 =?us-ascii?Q?A0OfBtVPV7nCKQiWOcoQ0lyaaWrASoNrfVz/mSc+q615o3rgtqKj/VHpo6b6?=
 =?us-ascii?Q?/WQEb6wiSOQZm0bGbZq7CdUW5nIcDZiqBPJIpeUpypie8KnPEE/yXo9sXdyS?=
 =?us-ascii?Q?T9X4Vjx+Up7gialm4ypU/NWOcdX4694sgTTpg0cPNxN78ie/eITkVCdCWu8y?=
 =?us-ascii?Q?ku2DrHKswx4LIx2ibtm9yN7cNLZ/m4F3AqgttDLxhavEO0odYVOYjkhUNLOx?=
 =?us-ascii?Q?J8unBh7S41rlBGSdP3SihwCiDyfvR3bmbekjvgZJ8PUwwwGnAOp0V4Y8+CXp?=
 =?us-ascii?Q?VJiZ1wBEe73QEpmrzxJGqVHRAynpTi3l80nh2l7RXk+gVZprExbxUDfbq8uv?=
 =?us-ascii?Q?q6ZAcaHPU2Ih5Zd/5fk2+3922nGmuJrd/SrFubKIniaZyuSBsdtS7KgCL1Jq?=
 =?us-ascii?Q?uP7bTN2iPoF6PLIrXgvrwRE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb598dd3-a62c-434f-4477-08d9cfe1a2b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 00:23:45.2734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6u20tg3Gq6ty8aE+POpwcUZsnIgFTqeZQwLdfwUbeySQGPz7WVjrq7eJB8GxJi0XiQ4aIBcpeWyMKUoStIxnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5371
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Sean Christopherson <seanjc@google.com>
> Sent: Wednesday, January 5, 2022 3:35 AM
>=20
> On Wed, Dec 29, 2021, Yang Zhong wrote:
> > From: Jing Liu <jing2.liu@intel.com>
> >
> > Disable read emulation of IA32_XFD_ERR MSR if guest cpuid includes XFD.
> > This saves one unnecessary VM-exit in guest #NM handler, given that the
> > MSR is already restored with the guest value before the guest is resume=
d.
> >
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Jing Liu <jing2.liu@intel.com>
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > ---
> >  arch/x86/kvm/vmx/vmx.c | 6 ++++++
> >  arch/x86/kvm/vmx/vmx.h | 2 +-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 4e51de876085..638665b3e241 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -162,6 +162,7 @@ static u32
> vmx_possible_passthrough_msrs[MAX_POSSIBLE_PASSTHROUGH_MSRS] =3D {
> >  	MSR_FS_BASE,
> >  	MSR_GS_BASE,
> >  	MSR_KERNEL_GS_BASE,
> > +	MSR_IA32_XFD_ERR,
> >  #endif
> >  	MSR_IA32_SYSENTER_CS,
> >  	MSR_IA32_SYSENTER_ESP,
> > @@ -7228,6 +7229,11 @@ static void vmx_vcpu_after_set_cpuid(struct
> kvm_vcpu *vcpu)
> >  		}
> >  	}
> >
> > +	if (boot_cpu_has(X86_FEATURE_XFD))
>=20
> This should be kvm_cpu_cap_has(), not boot_cpu_has().  If 32-bit kernels
> don't
> suppress XFD in boot_cpu_data, then using boot_cpus_has() is wrong.  And
> even if
> XFD is suppressed, using kvm_cpu_cap_has() is still preferable.
>=20

Make sense.
