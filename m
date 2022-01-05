Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083B0484B84
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 01:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbiAEAKq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jan 2022 19:10:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:28795 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231153AbiAEAKp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jan 2022 19:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641341445; x=1672877445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DwsWjk4ZQCVQMpcffQUBdFmNt6ZNKm6PQ6uBvVLZIbw=;
  b=JJh//a8tLJnSXfw+B4dLyLluRG7VcJJL/7vwVw8ROexuYl1sTUpMTYXO
   T7cpd/jbXhKTOGsrOKK7aAmVqaPKnxGRc7jrwyfl5ksJdHePIJ0v279Wx
   6P4K0gFZBxpffzRgQQUSW2MQtUuYeaIzQthcsj7WmrN0PWiOmxQhZVgEx
   mdfZawI1rxsdIo5xwOJE6U/K/xONv3FLMDIdCdBgOQGlO0OxKc68tAaLU
   DhI4AofD/eAy6M+RFic2UvE42vd44028CC5eTA1Yo1mb9Mjkum2jW6PYK
   KghxwPr/ImlAekf2QQNLBVxOn6Rr9i9GKe3Xa1fVNJwlz38f6FlBrrIZk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229649496"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="229649496"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 16:10:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="688772634"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 04 Jan 2022 16:10:44 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 16:10:44 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 16:10:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 4 Jan 2022 16:10:43 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 4 Jan 2022 16:10:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQLiaWbG2uXt4gXT0e8EosDN3eJAF4uIWpz2pdr04WWjkdYlXXMMon3oMHRwgc3z49trJFH08XKvKjWpXs7RNg1IFDe5lK1meH5sn2heO8SyzPgTK4M41LirXbbk68dXvtFaU9EnmQT6fQ8U47QqVXcCBRiiJgeQp++w5Zuna0kXks3csREG9S/QSKQyA4EFko1TfqZ3KRNUtbv9gUvKM2ghk7KuLYwShgBIY7dTSjU018+74GVuebJ1+WbVvUOYpT0YItHieh1ex9wU3447JNgzhM3EVrjRXLDXXNToT1a3N2ks41jg6fO7u1VSpUos5ocuRwGu4q4lD1o+ZWxWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5iaMNfrOF4K149XFY18mnsZEwIVyk+sUSvwSe9wyXA=;
 b=f/xHsdXoSvs9oJWM57bQAiyWfRNGS1EOMFPl1TClExlG+8GWhz/9O/xBqGnRdocBRQn54yLn427WFzpK3IC9eZlhJFM1Fkz/8HqlLa9e/BcrZ8wTYyTseguFXI5Qtxu9SJYtlKUb6cJVpwMutxy/7OrypP2RGMkxCq01GVGvrUO2EeN7l9i0JRKTRaxxMiSgN8MTtFUJtk/zqEDV36JwrTCMpmq6OxBSvbAFCr3d5e7KFOLCQKPxiewjgM57TynEoqMU25sVWyXjetgK8lp6nfHs985YqK5G3fboDKmO3yCfjDtbnlP4ZKO97Wc2vHQnbIwzbGz3zRoOv9mxgQYu8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1316.namprd11.prod.outlook.com (2603:10b6:404:3c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 00:10:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 00:10:38 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     "Zhong, Yang" <yang.zhong@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v4 00/21] AMX Support in KVM
Thread-Topic: [PATCH v4 00/21] AMX Support in KVM
Thread-Index: AQHX/LXk0wxp7FYH3EiGHHPzVpo8CaxTOqQAgAAE9ACAAFcC8A==
Date:   Wed, 5 Jan 2022 00:10:38 +0000
Message-ID: <BN9PR11MB5276900E6C273485C59B65608C4B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
 <d43887b6-630c-446e-caee-dcbaa72f2466@redhat.com>
 <YdSX6NANtx0SXjfK@google.com>
In-Reply-To: <YdSX6NANtx0SXjfK@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3d3cc71-a956-4e5e-be84-08d9cfdfcd92
x-ms-traffictypediagnostic: BN6PR11MB1316:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB13163D832F6212E9D6551F208C4B9@BN6PR11MB1316.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9ZHGy0Bsryq9soVhWp49CRpo3aWCBONUzcuwmh1guBAnqxSO9dgOh60xMYxDt5J9nEAHcdVngoyjfQHlnvAmRYWnU5+t4uAK3ij/tT0ZvxrG+BdnxZRmauiM3scSFxaOzMLiYFrW+w4s+nG3AqlQBCCybujn3uBlpwgP4ZmOKWnrF7aeEQhRONbPnODFkAFzTTzz/Z2FU2nUmyQbKV78H9Tj89EPPrtdUBKR5S0SLUBSPCMVzFE+/H8BPKmIRNdFvMPdplx7XM8lNAO21+GfqlcdBl/s5AI2oKzUxbKQPnCqNYo5pcMWbYDJn1jFXlwMGyrms8hEt69X8qf+IzaefxidDaZYWwuVGc8Zl9NNHCMeNimRgT8gJiW1RHH2Mms7SseM2oNFNbMCvkeZYYTEl35Ut2L894Q9sU3rBK2T7lO67+M8XTqPB1HENqMfuG+KOXQXczipvQd2ot96KNBFnZwxYCOo1O3rUOy10R17mmZ3hp3kYrVh5y/Cwj7zRm6+MDdHcPYZaDNHi87sVHODaKpk43oTg6f2wQKxUnoPejpaVTBqIyWMhA5RFCA94TESrrK5ne6sfo5FTHxDiw+M+c7i6E+1Uy/axcq2tUmS0K41MWgZIDq/i5ta2lHhuwl3TYVL/d0w1e1tA0nGVmJOH77a8A3VsAu2NEdO1NyC01wZiJsAONB4mpHvEWXljPURPwrP5J7s4gnZB6C38kdXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(8936002)(38100700002)(26005)(508600001)(55016003)(86362001)(186003)(2906002)(71200400001)(7696005)(7416002)(54906003)(6506007)(4326008)(66446008)(38070700005)(316002)(53546011)(33656002)(83380400001)(9686003)(66556008)(66476007)(64756008)(5660300002)(82960400001)(110136005)(52536014)(76116006)(122000001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xzPB7hBj59bNSfIP2RuG9LAhteQ5fAGvVJqr3RtjAXhykZCR61mRJiM05f1M?=
 =?us-ascii?Q?vA+UCU/Y+4xDsnbE5KxmoS/Lf29/NfaslOXhV8FlIxOWfQq15uEO2r87Q6pk?=
 =?us-ascii?Q?XyZN/hJ/20GDjHRiJjSscTd3Rv2WIKpMJ8pbJCNhU8fd+dSXtyRee9MfVXAE?=
 =?us-ascii?Q?bHaBvi5S01HZgDb9yTTvB/sHiQM5djerp1bt1/2/NlOgUDBhjkv2Jfns28qD?=
 =?us-ascii?Q?cllPz0kBYx909+Pc/msMkIUAoe3f+Y+1tMwvXaRw1RAQNnoCV4hCA4aYeT+Y?=
 =?us-ascii?Q?SfwG0JJ0GfYxKjnJxByT4j/rKYdcLggikZQmce0+tYuWksZ7oedGu8yAcbFq?=
 =?us-ascii?Q?6VlFKi47qLLgohB6WK5cDF+9U9QeEy//WKs6TT60Obwvsz0zB5ZiijmVmUWM?=
 =?us-ascii?Q?yHxmf3TgGALWynDwdv1V1CgHwwXbtCJ5HrwKNVbHQuHSm/Pxs3ayd9+4vgCs?=
 =?us-ascii?Q?6x7OBovf5UtqFUj+u6XcsbuiZlUZp12AXQe8HJR6QUYMR4MuWhiQYUYdkGJR?=
 =?us-ascii?Q?WCpFMPQDa3B4AlcFhIQqTxsedA9oOQK63ufqgI7wjSiI3T/dEw/oVVReXpgr?=
 =?us-ascii?Q?qKZwKTjQHOQBLdf9qWUgoP5dnXU8A3zNV2vjKpxn7Q2JaP+va/ZF8voyKWak?=
 =?us-ascii?Q?01GnRElmxZ/DC2W+3W+GvfXN0hHucKwVqED3ctArCy5hVhmxTA1/2ZRTwV0C?=
 =?us-ascii?Q?Z7Cfsdk+Ud6SfHj7hzCpbWCLwpalYudTmL2TgRtgNQDKDj8dBlbviJkchIKz?=
 =?us-ascii?Q?3eun900uOkvuwU6PyrcZq6WOiBpbJePjNcEgOAD74jn0CWL0nfzLcNbgR+3b?=
 =?us-ascii?Q?Do2Dl6wlKfHh75Dw6RXn1ewJfBkVl1LuKu13KzG/bEsBmIO+xjPi4Akhs1xT?=
 =?us-ascii?Q?8/tD56sYdx8+LgaKicTlm0I7h39oCIo200R7K9h2prHTq7NImJ5OgWGQelHv?=
 =?us-ascii?Q?6Ge9frZk6YIIWHkSnjC9MvEu9sv/vfkmX1gDRQikbvAO3CB750G9IEuaWx6l?=
 =?us-ascii?Q?3ddCpZelxCJUE0/7eTBl3mANdDVLGU+ybmRjpVIMv6PnJocVMoAE1gf3pg2e?=
 =?us-ascii?Q?R7vgNfQqSxsDHNm9nxa84J9xUxobjpdjqjJlF09OnNLrRIRAPODPYRH4gdmq?=
 =?us-ascii?Q?HC0/tdzwr8Aa3hMHSdaFM+VtAUWf7pQixtRPOxNgXvdyeWjiig2801BTaptN?=
 =?us-ascii?Q?2M29xMAyVIDvft5UU9aNk6KXrxQpkgtBLvpOCchaW9XvlP3PaEDjT9+rZI6Y?=
 =?us-ascii?Q?8ctP+8qKA/Vei92Qsn7SP7J/sEwzIfT6/ftxlkyQ1Q0P8+8IgkXlX/6AW0or?=
 =?us-ascii?Q?2cnDxwQH8HoaFJANVekxlZFcAB5XY8bGEcZrH5QQM8MJPG5b/9Ok73wcNa3e?=
 =?us-ascii?Q?hzOOBzHnGIJJzLlt2WVjYHFn0L9bV+3Z0LlRL90QjabsyaNBTa921TV7IlH/?=
 =?us-ascii?Q?19EPbbUaq85a2mCXJ2LI87btXvY9ik0yiO9SZhNRvaHFID9l2Bqp3v8bfMv4?=
 =?us-ascii?Q?kkigoDKyBUT2iDoIxFHUg4AOqHP0brvHY3YYuGRQlylrin1XE60+Uo35+4lS?=
 =?us-ascii?Q?9KXiHux7npuI4w/dv+MAUW1g0J4kQ4qW5J1zSDSLf/K/ena2DuN4j42grWul?=
 =?us-ascii?Q?YsAY6UHpr5/+XG+g8Bh5IDA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d3cc71-a956-4e5e-be84-08d9cfdfcd92
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 00:10:38.1586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBJjmfXJAQaHI2xfE+JJylf5qQR0tU3I19VUgI0uXveRpDbF766TsvoQ00UUkTxXCF44YheZbl2t2cLQa4/Oiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1316
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Sean Christopherson <seanjc@google.com>
> Sent: Wednesday, January 5, 2022 2:55 AM
>=20
> On Tue, Jan 04, 2022, Paolo Bonzini wrote:
> > On 12/29/21 14:13, Yang Zhong wrote:
> > > Highly appreciate for your review. This version mostly addressed the
> comments
> > > from Sean. Most comments are adopted except three which are not
> closed and
> > > need more discussions:
> > >
> > >    - Move the entire xfd write emulation code to x86.c. Doing so requ=
ires
> > >      introducing a new kvm_x86_ops callback to disable msr write bitm=
ap.
> > >      According to Paolo's earlier comment he prefers to handle it in =
vmx.c.
> >
> > Yes, I do.
>=20
> No objection, my comments were prior to seeing the patches that
> manipulated the
> bitmap, e.g. in the earlier patches, having anything in vmx.c is unnecess=
ary.
>=20
> > >    - Directly check msr_bitmap in update_exception_bitmap() (for
> > >      trapping #NM) and vcpu_enter_guest() (for syncing guest xfd afte=
r
> > >      vm-exit) instead of introducing an extra flag in the last patch.=
 However,
> > >      doing so requires another new kvm_x86_ops callback for checking
> > >      msr_bitmap since vcpu_enter_guest() is x86 common code. Having a=
n
> > >      extra flag sounds simpler here (at least for the initial AMX sup=
port).
> > >      It does penalize nested guest with one xfd sync per exit, but it=
's not
> > >      worse than a normal guest which initializes xfd but doesn't run
> > >      AMX applications at all. Those could be improved afterwards.
> >
> > The thing to do here would be to move
> > MAX_POSSIBLE_PASSTHROUGH_MSRS/MAX_DIRECT_ACCESS_MSRS from
> VMX/SVM to core
> > code.  For now we can keep the flag.

sounds good.

> >
> > >    - Disable #NM trap for nested guest. This version still chooses to=
 always
> > >      trap #NM (regardless in L1 or L2) as long as xfd write intercept=
ion is
> disabled.
> > >      In reality #NM is rare if nested guest doesn't intend to run AMX
> applications
> > >      and always-trap is safer than dynamic trap for the basic support=
 in
> case
> > >      of any oversight here.
> >
> > Sean was justifying this with lack of support for nested AMX, but I'm n=
ot
> > sure actually what is missing at all.  That is, an L1 hypervisor could
> > expose AMX to L2, and then an L2->L0->L2 exit/reentry would have to tra=
p
> > #NM.  Otherwise it would miss an XFD_ERR update.
>=20
> Ya, I was assuming there was something L0 needed to do to supported
> nested AMX,
> but as Paolo pointed out there are no VMCS bits, so L0 just needs to corr=
ectly
> handle #NM and MSR interceptions according to vmcs12.

btw Sean still made a good point on exception queuing part. Current=20
version blindly queues a #NM even when L1 wants to intercept #NM
itself. We had that fixed internally and will send out a new version
very soon.

Thanks
Kevin
