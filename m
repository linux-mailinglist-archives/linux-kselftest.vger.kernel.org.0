Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9158481ACF
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Dec 2021 09:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbhL3Iqx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Dec 2021 03:46:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:22573 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhL3Iqw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Dec 2021 03:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640854012; x=1672390012;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KlvrENUv3HUKG/oL9Ygn92IfVfsCg+fy6Hs3P3RgLjY=;
  b=KoRV+tnKOgshnbKf6Ih3xYN2aKYShXWHiqxRz5drG/psGPTNc6v6BM2S
   e4rfkBPk7falXJujgVamPgOfWnhi1JetgwU5tKM+/rSWODGTW1lgFTiCI
   IkDA0H9KDoocKTACANX+8qBD/0Tqc18XOcgvpAKWlQj19KQvJIaIxwfba
   Vt5oCuU7PxDRkwR6EWROiLAX47l2BoFN26NH22yPOC5c9aVHtk9aFBmLk
   ozIFBVMzOOfHfLtSOfq8/M8HCOPfVeg6UxMutZCZ33yJQbGaLvV4yxJ7J
   GBgzAVnG1mUtkEk0Bkbmj9AwtqYSHp58iwrX+zJ0RdJLyxwW7tlUh+L8e
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="239183598"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="239183598"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 00:46:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="687157541"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 30 Dec 2021 00:46:47 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 30 Dec 2021 00:46:47 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 30 Dec 2021 00:46:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 30 Dec 2021 00:46:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 30 Dec 2021 00:46:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwWL6ajWNGWbr0Ouk+jb44+dJvNme20ItJoXJxAzuXRzpE0oi/+tYqhRxTqDIM0Vn8bbeEY/L59M9TrhwED9fxW2WSMtm33yqY5JWCEZkviKiqWfjttIKpgfixb1idxbqEBminHwT1s8nWpkffb+P24iZAhGjgvsQ7GK2QjxmMuFKsKh3W+jjJrCGzfrcHQKMwmmwQ9DYC9Tz0DLaW3GTyk8bTey/tehRsismlqRlQwfqi/fPOkKNTQS5q4kZ8dmJ24/KY7Y6chDArG76YfciWO/3wq4rG9HVC6Towj399s1dH22CxZ+JEUMLSqHquNUKPYO3QbJPNtau3DecP2rAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5K2cCuZph2BjDV+8KU7BgXVYw035SGdC37Oz5quq9k=;
 b=i0v8tVY++C2YRR+Pwlf7kIprSHODYPI44W1AqVAF9+Pq5nwAf/Yu2zP9LQgMxNrS/ZAEuDIZo/f1Qt1l2sGJW9s7sfjFvrKryiB0hsBWGXz4aYH7BZ1o7sRo3BBIBcGkp58h4VNQYRWOBya2JhHLmKvhvo3Y7liyb3+6yYxkuU5/gcopK1RZ00OJoO91orw6foMcR5uRHu2rl5bmLOy4RJKNYR94UPA5/xhnE61nQGF40E6N6ncbvewn2vpMlt+XuKbKl7EukpmPP9xCYu+hJqI3waQVFDYkRF8BcdrjSInJwg2RJ+jppWmVJ/0D9qOJB28O/sF21sF1Os77656gMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5275.namprd11.prod.outlook.com (2603:10b6:408:134::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 30 Dec
 2021 08:46:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.014; Thu, 30 Dec 2021
 08:46:42 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Zhong, Yang" <yang.zhong@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
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
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "Christopherson,, Sean" <seanjc@google.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v4 00/21] AMX Support in KVM
Thread-Topic: [PATCH v4 00/21] AMX Support in KVM
Thread-Index: AQHX/LXk0wxp7FYH3EiGHHPzVpo8CaxKslpw
Date:   Thu, 30 Dec 2021 08:46:42 +0000
Message-ID: <BN9PR11MB527605F94C336B49584328278C459@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cbbce89-61cb-46c3-431d-08d9cb70e72e
x-ms-traffictypediagnostic: BN9PR11MB5275:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN9PR11MB527546A854BAE668114ECCAC8C459@BN9PR11MB5275.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ApgIccjVh9bMnnm7gtQ7QKHK/kWWiLxiOz8ivXQ2TncXVWFJZ132Z9hajO8yQai0cwOPiqJkQjBJXCz1kqHN/LcMj3R0veZgncIpLEO178ZNLBpCKNUhMjd6jErsd02WXjvoh9pkSlvFdKGFns8NglUBIyftEeBUJ9bp2DRg3A3qXiAKOFU66I+KX3wenmUxKblPLqChtqCqFEcicHfrNLOy5z9/KuiMOdun/AS2pirJU9lYwSo/J9e/i0WexxpewImMi74JtlmmwUJF0c7KU+NHQPl28Pj/sAd2OlTM4a/BSPKttPs77YXsKRXClZgMv84Ze+v/GhPh9tWpFceIwmlue7cC6e51NZS/5wzb6n4abSAXuchgMfaD635+84176ronEbE/9mgVS7HyFtE5tFbaOGybA3/iFH7gdq39zUeBY1JDwNYzpiCxqIxDGWDd9UvWoPjt6I1+0uvT9i8Ui7ZNCrrkcHiLU7ENX3lVD5DYHxf2suM5ex0VhJRD8KhkmJKa7I1kex5qjSLhDJC4kbYT4I76F8qEyPYKGNtalqtZ1lOHJake++jwWTDJyK6vm7Jr7ooo5HQgqYqXzPY5H4AAxmHAqX/k08ke7rdFr9/naFftY3liOV5nM0oAv8er51CVdvvDFvRJo7ZvmQLwN/Cy0eyG61ngtX12xHz+vsNHxkkwwCColF1k7d7HLIkIEB3Cqgz0n7wkOh6O8QG4prolBR6rj7cKf4g+wn+bj9otFC0BMxwwlBDbea04CzK0+gIGOUVIppX7TLqTpKnkEC8SAHi8naXFDregtdjOQ4630s2swAEwNK54cIzbhiXD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(71200400001)(2906002)(66476007)(64756008)(66446008)(66556008)(7416002)(9686003)(966005)(6506007)(921005)(82960400001)(316002)(26005)(33656002)(7696005)(54906003)(186003)(76116006)(52536014)(66946007)(38070700005)(110136005)(5660300002)(4326008)(38100700002)(8676002)(122000001)(86362001)(508600001)(8936002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CZVIbKvOLgISEyXeYwiUZ7x2Tler0eJ9nrigm1T2NjzX5mkJwRArBgX5RjdG?=
 =?us-ascii?Q?EqGJJe/R39zcmIuMslAmICbmGNuxc0rjIIULnacMkLo+vNJOMxPYb9pPyKaC?=
 =?us-ascii?Q?M1Fs9oPfDm1KPm1c5GBT2Bi5TI/Q6Vc13eZ0+QK8tvM29eubqdNEubC9/SBR?=
 =?us-ascii?Q?Tm5o8ys3IV8LNnvyoFcynIhnWbv14N9R3BuWwmKJpOConrgx7gSuuc3cvpBa?=
 =?us-ascii?Q?9iQo5WC8vk6i1TgsjC4fy0F8Z4paoV67vai099DNzm9HlYaMBawH10Pw4Fo0?=
 =?us-ascii?Q?IjdDnzxslLcC/uVoq9L8+JwscuB8C749dUBp6PZvrlC5mjOT8L2IK0sRORs6?=
 =?us-ascii?Q?YZWqllOfc+JwdW2gX1rQu0V8/7HrFSu0s8FYDLVjldGFapGn6vheTCCkAnsD?=
 =?us-ascii?Q?S6sBlXZv/wGxk0q6F3mlGfSmXAY2HWZd0RwC23K5WDyjy4hkqWgAZG+z+v9t?=
 =?us-ascii?Q?4fIKTLq9CYDGK8jKPZgHcFyXoT4V+CMApr8agBzKb7cSPbIxu9eggSAfrevB?=
 =?us-ascii?Q?128L1XhNFct6OXcq6k7lIBXbG8b9Hvu1T1DPKddVHGIz6+hVKEvsHXw/hnVQ?=
 =?us-ascii?Q?55EDHqtIC9eWpDRinbJ+nKRlg7haSfr14lcLN3qg8Tf6Y5+dr8COWKfo9t8t?=
 =?us-ascii?Q?wsSECIXUvK5yLB4R4TQTVEwNUij14lx7daXS9ChHNSstGo6ZnTuTtmaQfhss?=
 =?us-ascii?Q?qnKWPTKBO91x+FmVMdXQRr7sK3d1k/hg9u3wbpkfl7EDkjvvUFywcp3FMU1o?=
 =?us-ascii?Q?+ElBQHmCo7Y7wPyRO4B/YrO/C6KHXn+6a1r4BL5LTcSUEL8WK1K7rtvSNOm8?=
 =?us-ascii?Q?JkFbtHU6jnEp1WeiVVBaL1iM1KXRWvprqIrLM3w1P7AxA15morwNl9blQ9yD?=
 =?us-ascii?Q?ma7DOWU3tTZAjYa8IMjLqFG5e7HhauNIRpdjIYrvbHIIwmgB2tNzHcF/LOXM?=
 =?us-ascii?Q?vtIfzqHhaQZVaEr5GBM2Pitbvb65HOc0ocVfeaKEWJhH74ZesYPO8MU8VkgT?=
 =?us-ascii?Q?EEfEV7Y7UIJHKMSLQ+ydTPdzkvwDuVAUQ36tVHbUsfF0WnPae4EkYKI3yTMy?=
 =?us-ascii?Q?spXH0hMgX9f0gPwZZijN1SRwZyT3CwfSqucCJ6yegRDVRzsNjZ4Z9YNN6l65?=
 =?us-ascii?Q?HnBkUEa7TJoUg/7oSDeuTDsm5iV3l/kChAVVtESzKkIZO1IC1CG+yKdxXwWx?=
 =?us-ascii?Q?28vtblU3nxsPIHORoV5K+3uwFVylTMoViAE5DEkTOPlP2Jdfvjl9XKIciuLE?=
 =?us-ascii?Q?8PagDcHxXIRAEUOyzjWeINP0ueleJGqkkwPXkO3EAOqNxzTSO1JSSdVXs/0+?=
 =?us-ascii?Q?nIf7KaFUPR5mjdqhEXyybh62JDxfiZjgcjiJxN1ECEIvj4lQVlZocq8ztI/I?=
 =?us-ascii?Q?kXvSnsaHZ0cOib/5NraRZ2ys8VzDesyDwf4cqQdA7HV0jlehIawJ3CFBzrWu?=
 =?us-ascii?Q?SH2kFfQJIqvzcas0SHh2Oe9MliJDHhYowA3HHQzT+gStLsLZpo0ut/SRMo8C?=
 =?us-ascii?Q?twnqURY44ApAazZP4axBr8U03IBxaQCiJ71p1UK4ZU4apJvfV4JuQuInWDb4?=
 =?us-ascii?Q?vPKxMK/BBHdW1p1t8gcONl5OsWFjIK5xDQlYkz69mwWkgMNDvlA18vdeWPTp?=
 =?us-ascii?Q?SwL4Tzg0FfMPo1sGA9a7PJQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbbce89-61cb-46c3-431d-08d9cb70e72e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2021 08:46:42.3725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lc6mn6j/veRKMVuoKu1bs38M4SFXmv4CjZ4CBlsGheG3BAPjFWmAzQH+DLt1ukTbVrTXaaRLcIkvBvZRl5cCzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5275
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Zhong, Yang <yang.zhong@intel.com>
> Sent: Wednesday, December 29, 2021 9:13 PM
>=20
> Highly appreciate for your review. This version mostly addressed the
> comments
> from Sean. Most comments are adopted except three which are not closed
> and
> need more discussions:
>=20
>   - Move the entire xfd write emulation code to x86.c. Doing so requires
>     introducing a new kvm_x86_ops callback to disable msr write bitmap.
>     According to Paolo's earlier comment he prefers to handle it in vmx.c=
.
>=20
>   - Directly check msr_bitmap in update_exception_bitmap() (for
>     trapping #NM) and vcpu_enter_guest() (for syncing guest xfd after
>     vm-exit) instead of introducing an extra flag in the last patch. Howe=
ver,
>     doing so requires another new kvm_x86_ops callback for checking
>     msr_bitmap since vcpu_enter_guest() is x86 common code. Having an
>     extra flag sounds simpler here (at least for the initial AMX support)=
.
>     It does penalize nested guest with one xfd sync per exit, but it's no=
t
>     worse than a normal guest which initializes xfd but doesn't run
>     AMX applications at all. Those could be improved afterwards.

Another option is to move xfd sync into vmx_vcpu_run(), given that
disabling xfd interception is vmx specific code thus it makes some
sense to also handle related side-effect in vmx.c. If this can be agreed
then yes there is no need of an extra flag and just checking msr_bitmap
is sufficient (and more accurate).

Paolo, how is your opinion?

>=20
>   - Disable #NM trap for nested guest. This version still chooses to alwa=
ys
>     trap #NM (regardless in L1 or L2) as long as xfd write interception i=
s
> disabled.
>     In reality #NM is rare if nested guest doesn't intend to run AMX
> applications
>     and always-trap is safer than dynamic trap for the basic support in c=
ase
>     of any oversight here.
>=20

Sean just pointed out some potential issues in current logic, about handlin=
g
#NM raised in L2 guest (could happen just due to L1 interception).

It's being discussed here:

	https://lore.kernel.org/all/YcyaN7V4wwGI7wDV@google.com/

Thanks
Kevin
