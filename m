Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C18D4810DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 09:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbhL2IOG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 03:14:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:25678 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239247AbhL2IOF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 03:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640765645; x=1672301645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2jTZ0iegeXh5uP8xVD54BW96KzVY6z4ls9e8FZ1SS3E=;
  b=PmPQMPgjg0ZQhCQ15VZdWaUXOXbGAAN36g+RBErfHyRxBHPmhHEoL41l
   BN591OZmJUJM5QUSWAQoydPALeChtEHTIIkcn8stLlwcIj1T2jMehAx47
   WJSb3YkaDCfw39w6ulDBFcHfLngh3WYp7Zf0wm9T7xHOIQhJkHrDiTVHN
   /8zUAeCSFLx4JJfTMN8ciuqGDF4MqjpeZH9vbVli/sHANzxHyN3Xzs/dw
   bjOLU4iBgVrQGN5YF1yTMWS0irj9aYl7FcubrfMLPy6/vcs4X09o0UVJA
   gpCDM45rgNQCpcL36rDH3IajKNwy26Jn97HVbQWPiIekFofNoo8Vkuq2S
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304843869"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="304843869"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 00:14:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="686821033"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 29 Dec 2021 00:14:03 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 00:14:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 29 Dec 2021 00:14:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 29 Dec 2021 00:14:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggqorKtMP/m9uhmjWtbKGSl2RhUz8y9jmdaOW88y+PMDnG/CPGoAcsUJwDWJfybNvJSgiSSf+ojAMczrPZfFgOzpmZ7goH431wyEnfNqh9FYt1ka2uSdfCOoRIHEjDs+f3dzNBzCy/9NPd/Uhi+9PTsivOyIUKsMWefmNKKW37mE8hm79C34FfwEfKqE/O8ZIn6NcpWftrMQNuU865gXmQ7WzcrC78cAaPqAf/ZBwq1bOv1akMXJMGR9u6L3/QRTqJPGmK942RfLByLQaNv7b8gIdG5Bm/9wzn7ml1OXMFIKdoK79yGffozC01K+8/Yqn/60i32sKUS8wWDnz+Op4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1nhGeQ44vcSnMiCYhM8dxHQEnxBmbCjPXrBoyMENdI=;
 b=IVEWtUW0++0xYGlGTfEhWTjlhyYCC1YAlKtJVEU/WvXTfLIwQuxGWhagUiYg6DXtxt2bNcTOIFziQPXe+yjAi8gmGe7TohjZPRNdwmbJdkOk89+dfRWi6KWLfkyMUisVsYpfNBuTqfiAAMYKkHLUGI9SfrHpGQZCVAoLFoicqz5ckX5HX3yiY6e+PPIwrQWR/30m3lzRH9f80iPscLQ8wc8Var/ToKyx12mUPjn5UxaamgHxj0kyEuoIvsGcVWVrkayn/JWcLjpVQ7CJ2S7gCkAeYou5eAWh3+TKeLAMarCyfLsWoFDCc76JYbQO2lkAmVPbDLB2vTUYDDoRC0hlzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB3857.namprd11.prod.outlook.com (2603:10b6:405:79::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 29 Dec
 2021 08:13:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 08:13:54 +0000
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
Thread-Index: AQHX9zE1lVRiv1UsgEq40a+CF3C7OqxIomKAgACA4JA=
Date:   Wed, 29 Dec 2021 08:13:54 +0000
Message-ID: <BN9PR11MB52762B6AD795B6376F6474588C449@BN9PR11MB5276.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: ff67e56d-f5ae-41cc-c3c9-08d9caa327b6
x-ms-traffictypediagnostic: BN6PR11MB3857:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB38575F095F6F8B412C8B60168C449@BN6PR11MB3857.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WajCyRw39j/1e2mxqngePkWkkgkbV5aaKlTcPmdfUDhUzthQH9tMm4gm/7ijuVc8PuUKvE6QQZKidS8cYhbPQiwgs0U0K2ACiED4tX8jixWJqb/Wqbj47essU4O1Yr+hRfw0vDsHTCpiyTDawQe8py0JgFnSGL6o5kgrFVm3W6goN2KCM3K3sqG+AhsXmfUBSZ7FrPUjjSJ4m5fo8dOV0RfCtbRYuJ4ytP4I0g0gNLbXUdOrnvXiXXDkuF+s+633EvWNPtU1dqBLFGVziABMDw57nwdhbxuMNH0uksabHZk76C/zj6JbYanjWTkc3Py21khcd+6Gykr1pduT6hYVBss2Al/otd0P4cDtp1vamx4DkzdVsEz6TWoK4umV+lkstmMYruR7IZjYn+IPgxIRRWiwQEdayT+HVA99AmAYLKo3GDvp017lIxvThOxCpOIERf7k5n3wkn9VC3y6i/U/sylIJRZWoz8lGMde7wT4EKBcDn8gbI9V3m6o62Jdu+v7bZtfRqkrNV7NA3QjVtM5RLc170FA5l1lwiBYgWN2Q990YMQCdE2NogcCcUTcIcbchIHmIUPLuOG8GFpqdMyjQfqk+hh/BUiwY08aGmb5oIcSv1Mn9UuQGj7q7H4jyGy/3dtmGqo6oT5PMhPCGHY3X+e7nA9pMgWQpLoSfUvlICBJIkrGzfhA4+RXOsaW1IbhOEl4TqjzO0CiJI7LQhYcmc06PlmPtWROGC/5+HaU57jh5ZFp7iJ33751z3oPS4dSVorI8YwPGP0jd7DwQn8hN1IpvhyNSROx7GP+yFkzqWU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(7416002)(76116006)(5660300002)(55016003)(7696005)(66946007)(86362001)(66476007)(66556008)(186003)(66446008)(26005)(83380400001)(64756008)(52536014)(8676002)(82960400001)(4326008)(8936002)(508600001)(38070700005)(966005)(54906003)(110136005)(2906002)(38100700002)(122000001)(71200400001)(316002)(6506007)(6636002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pTDDprcrt0YARcc6uK23nknagvG5S8AeonYmNoiRW0VzSnvZQofqZ/dYx5mV?=
 =?us-ascii?Q?nFoKASa8fj6Maplx1ChrxM8BFZua2rrGppyZLwEhd+qCBIaq6VUdruhYVWQn?=
 =?us-ascii?Q?SLgc+EqMkrEtLZgsgrtbzerj51W7B2t2MyUOgay9wNG+yt4PI1DWHRi7MSDX?=
 =?us-ascii?Q?CyQ5cLTbOSJVcfNV1UyYFzq/AugDBvklPXpX9hzB3YlUOS7nUVoTyRhP+QBm?=
 =?us-ascii?Q?13l9Ee74Xuf+SPIxotQxVo33pxpH7cG/nIiKaQh+OvetiiejEXa8VHmfpR9M?=
 =?us-ascii?Q?rRlMGlx9FDXW0ZaTpr5GQZtfZMdTT+EfPBw8EJ5efi3aHqLEdLfC1RNs+xFL?=
 =?us-ascii?Q?QPOSMvGTlloV9fzlRtAksiefZ3gOEhc355YCybFQAftoMoOi/QgSDYpKyZid?=
 =?us-ascii?Q?OkOdarivZboDUZFc3SAZpvf759OMnmWkybFR2YleZiXMvPJwG/znni5+498y?=
 =?us-ascii?Q?S1w3ln/xisBLsz9hkVyCBCxCYptLhyKLyz9Raq63gK7sqFoIY4l49ofvQun0?=
 =?us-ascii?Q?jAPJh/ZcAA2+OktP4yHg0E54KqAkfsUG2+xOYOGlDuCUoEtikkNhlEj+QwBE?=
 =?us-ascii?Q?9FN+hrznZlTz+s+ubTmbCBmqjCEv2C9lzl6yQO/a22IfGdZnBkOixUJAUgAG?=
 =?us-ascii?Q?GjNdqNSGeQFWqiNY2Fs7tWtQuPfl9A4S1kFALxPfp5fC1toCxsccDHEBckcO?=
 =?us-ascii?Q?CNSlUCXTnt/mwHUphJ8auLLyu4WutPO9XeWYMhdK28lp/8NTMPG0/2Ec4Tiw?=
 =?us-ascii?Q?IEasnhBkEyXOa3gCiqxbedzAAtWQD1zCwrYhxc9MGljvVjmdecMxPYvYsnT3?=
 =?us-ascii?Q?uvzwPnp8F1x/PWVfK/piWnz/f27Wc+QEMHG5efOh5qSLuVSLJF4CgtDQ/0eL?=
 =?us-ascii?Q?2mpR0VPdRmmit6SamYyV2WEs1JM9Mg7SKSbr5k9s97OSuFkYaEeO9fSBPLcR?=
 =?us-ascii?Q?JIiHclMdNq9AzSlEHxiL7Ztta8EwhJWuL7Ss6PeoFH01nCMPONDZOG1J28+Z?=
 =?us-ascii?Q?r+2gzYbCGLBUDOjdmTEtoCynTxjfEJPRcG8SRjKUvjhN8yA5Wb6/sVFDLRT9?=
 =?us-ascii?Q?14irTXdkShJNus4iiGVWY6a3RwIDsypfjR5PnxQNlGIUf88T3nHDxSMM7Fzo?=
 =?us-ascii?Q?2hd3w7lLELCpLOndx8bc02Yoo23vONouXtE5/qjoSrWV8jYvPBaF39qGWRA8?=
 =?us-ascii?Q?uWVcBOGH2VTI61f3Ed16KZE/s9JibjvZcQw0razRrLScY4HhYZ8AVLiugZcK?=
 =?us-ascii?Q?Fc50kv9m/EDyIth1b23u/3fR2Jz4N6Be3zgUvIIwc139CuOYIgD2NFm5QSQm?=
 =?us-ascii?Q?4Jl8Obu/sBryKy8Y+RfeuOwDa5SXR+GblO+3g8Ds0XMIOQrnc0F00IkzpFpf?=
 =?us-ascii?Q?Kva+l0feZufNUqQDcNpfgTQkwQG7gfr48yE1N9WF/IYR0iOV+VB923vLjZ+1?=
 =?us-ascii?Q?DLP+Q0Zu4aHZYU0mD/0GsHay/nKRLkQ4aUK+Jd/iV/2TQEMEodyMPq2MGOYd?=
 =?us-ascii?Q?2mxDpQWlH3OcE7Oqq5jllBYMYz+C8fwXHobfEk5W1UV2nXgxfPx7JJQNxSjY?=
 =?us-ascii?Q?eDBgjR1S4DAQuNIwpM94JizPf5PEQ93UUOHHsnNUfwhvoKaeVecKJnjOTIVx?=
 =?us-ascii?Q?oaW7g5Sc31emzYtT/Eyg0hw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff67e56d-f5ae-41cc-c3c9-08d9caa327b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 08:13:54.3170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ewvAO5VYdHMOZknXnmQUGZ1m9kGo3tTg1TqDuIo9UOiG96esJRNZ1oZvCDo0B6fx+glfKFbl+59gHAk2kKhEFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3857
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Sean Christopherson <seanjc@google.com>
> Sent: Wednesday, December 29, 2021 8:10 AM
>
> But why even bother with an extra flag?  Can't
> vmx_update_exception_bitmap() get
> the guest's MSR_IA32_XFD value and intercept #NM accordingly?  Then you
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

btw follow Paolo's suggestion here:

https://lore.kernel.org/all/6e95b6f7-44dc-7e48-4e6e-81cf85fc11c6@redhat.com=
/

He prefers to disabling xfd interception in vmx specific code instead of
introducing a new callback to be called in common code. Since we want
to always trap #NM after xfd interception is disabled (which is done
after calling the msr common code), it also reads cleaner to call
update_exception_bitmap() from vmx.c instead of here.

Thanks
Kevin
