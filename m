Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F1367AB81
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 09:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjAYIXG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 03:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAYIXF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 03:23:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52507279A1;
        Wed, 25 Jan 2023 00:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674634984; x=1706170984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PIBIYWjFUWrv2uzg04TRHETzAcGdaVf2ERiCqorop3U=;
  b=Z5xvmTcYh+Zy8eCN/LDPnR95xQ687cRx0C5MRtEkxBiZ1+f339539cpF
   H8irfuJOP5C04UFUe8Nf0d6WnDkSu4vrZgeCyT2N55dwD94afBAE1ywDW
   CyR/dLpybZToDvWKr0pL7jnF+H+t7pM8+XTNNnNRiTOqgTM007yDYxHwW
   pqRZNCs/qNxm1J06wJ1zE+jSReM4lPZ5M7X2lu2IO0ImJ3V6T1a6zffd7
   JBdrawHoEQFueWj5B/1tKgFWZ9mB7nwUyXyLj8J2g9qvYXwaADJU3TvaB
   hiSSvzg07Y6MlJFLmhwkBwt8jZ/dHzcgK5lw6artqkKvajpt7mbXRf1PA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="326537057"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="326537057"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 00:23:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="804923739"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="804923739"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2023 00:23:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 00:23:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 00:23:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 00:22:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDhkyFn9WOSqr6HdbBKouEs6eoE6nUarhB+MKdX70bM/U5iOZAg6NyAU3w4M51x+es63p0ZLCiws05jnQL9MSZ6iAXbMNhB+/p4WI4NUCe26XRV6BOKdEoyeo2+0IQqxuf3m07OekJ4S/1u1dhiAaLOyZkluGkp5Qy4a7t3km77eruVHBmULC1XMvgQxfsURWtg55nQLzStc0ZcodiUHvxewSyY2jOqMF/poYGIW5F7/E0P95p2ZMuiE1V/AfRVYLzBA5K3CjasN9ALOSBPgMiZXsjBoAp/NG/LX1Y4qbccqZtk3lfnD1N+J1KaWsTn02qhvpHSXeuMnQDkzif/0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6H3fyOnO+adw6ERWBQV79B5owbjDM04kWpdIn3N4fc=;
 b=eoPUEQMhUdpechYZfehS+RDjuGqVinpV+GVoqywxsqAyK0LvtRP1qms3A5bjFMwgZKxGhUvSeFZ/kL7KIEQINuRTNQRGfuX8W3QP5l0CCKUr3JncyjbdNALJIUAsaLIZoNaP1ldBJur8WJc9mL2MneDe0xc2w1j0xxzw0DKexW/wrJRG3veNuXoyb36lKjvGoNAzG007P/1XRI2YO+Frji/s2lXKd6T16sf2mxbOisBMzuUzm1ed+T7oOZcDXqlSXuFqUiyr9YzYCx3GT/zsSxg7WywWsbAdFAhn0gxJlw7pZ3zFyVamdEt1pk9epdJIHm+MIrK5AwxSJ1JAYHUF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DS7PR11MB6200.namprd11.prod.outlook.com (2603:10b6:8:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 08:22:50 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811%5]) with mapi id 15.20.6002.026; Wed, 25 Jan 2023
 08:22:49 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v5 0/2] sysret_rip update for the Intel FRED
 architecture
Thread-Topic: [RFC PATCH v5 0/2] sysret_rip update for the Intel FRED
 architecture
Thread-Index: AQHZMHAoqvs/lwdyjkiVXoNdsc7iCK6uxqlQ
Date:   Wed, 25 Jan 2023 08:22:48 +0000
Message-ID: <SA1PR11MB67345C4DFEE720C08D30D93DA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
 <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125034958.734527-1-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20230125034958.734527-1-ammarfaizi2@gnuweeb.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DS7PR11MB6200:EE_
x-ms-office365-filtering-correlation-id: b1d0f53e-6430-40cb-56c3-08dafead5842
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sn4JExY7Mwb3X/Dlj921a84rEWaGbVGfIRXFLH1dNFe6T3R3dWG7I6uy4+8aGErDeNxgN06m89n8iEAUxASRvrIMEZZgPD1DqEYIVsrj0YtStlSRMxRNdTI2XwEzFmiOcj/ajEidPlHeq2PIMRF+NT42bDZObOuv+9o2kJ2rzY3yOZauBPa8ZFDht4ldlzSfpFlC0N0d1nDjFopwvxuuT3yGTweenmHm67jlLXlvpYO5xo38c1GOElWOjHJrzqpMwrfu82yG9af3/yHV+rCqVMI6rp9isWLgyJOjS3WAp3bucj6Oeovf1UAmXJjPAvW7ftMBiP8suK8UQU+5KF0bxjFM2ZorALP5MjcHRWTte1OAeyX3jb5W8CKHXwuR7VdGdzIFneXlB0cj4eMKUylyg7KDUxPa61iMVfBmjGkl9ondx0VFKUW4xzekIc+qpK5MtCSH6qYkkGs85y/wAF+XXAOHG3Nw+Y1yfZGL7CK+KB0rgBhSXRfzAFaFQgLkPuiyEMd6B3Pez7gCGlEvWzE1qR7oKdHkvT4HlyRsjRVsmzeMSIu9/7k49B+HU27vUiPpKR6WTNtozall1G7xFoH3fFZO6stGQWLGq0UpBi9xM5FeJe04P0ETzJjFz9ZoozUXwBOv5A3LdFI6ASE2vYUBUKHs+fQ2R0NF4OPD43EjM4/lZoCWfFVCm+n5hMeCqoWr9ejciOWO9LIQTl8z7OyIO+BFXyQt/hfG6zC63tuycOU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199018)(8676002)(316002)(86362001)(66946007)(66446008)(71200400001)(38070700005)(54906003)(33656002)(8936002)(5660300002)(15650500001)(52536014)(82960400001)(38100700002)(2906002)(9686003)(66556008)(4326008)(41300700001)(122000001)(26005)(6506007)(186003)(55016003)(76116006)(66476007)(64756008)(966005)(478600001)(7416002)(83380400001)(7696005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I7Nc550ZepVSmW0MjTXdtvTofsPHV2MNdckw8Dcl0VDPe7Fj+X+UcjpT4bUs?=
 =?us-ascii?Q?O47NBUlPSF7jZ5K7kaTcAeSz9ZWoF0tLe01HfSYTCYSALzt9QQWGa/Q13pNs?=
 =?us-ascii?Q?gKF8Bl4lHeWYaCGy/p+Fdz5bi0wIrgyOtcR7eV6/i6VxN959zHH5dbsXxH/j?=
 =?us-ascii?Q?R8SbGO0KwXVePEKswGLLGSs2Fo6jeSZ4jBGOBeT5hGd5HMXoE91fRXRmiKuM?=
 =?us-ascii?Q?mOmCMh572I12gQUF1SsWQX+hx70t7o864DlYCvMYqvlkyR9S4D0qzaKB17pK?=
 =?us-ascii?Q?luTzPp7SsF1Xn2/W/hyfpZ6i8yF2qToHZ5N7B4sjFiiAnXQHUntSeoJ2b+YQ?=
 =?us-ascii?Q?PSl1CfdlLLFGuMogP6gKTU04yx6QViqFgDfydpFlnehyzJMmSIEESAoQtabE?=
 =?us-ascii?Q?oS9DQxqiyVRTfk6BMtRuSaeWc4W7i5tZPt4LS6UR34+A4tX0OKDU8lMFBrUf?=
 =?us-ascii?Q?JZ35ZUqdyr1BGdG4II0IAX00ZGI4f2rC/7xwR71INXLQOFIaiJMyi9D3kUjG?=
 =?us-ascii?Q?3qbmlBeuCIViXnoU6LN6SipuEE+xoMXI2aXSvfH2GFSCaxFpb8/iXKzwz1QN?=
 =?us-ascii?Q?eQ+IhDLKS24MID+sM7drd6xAPluRsPhmYbzEL8gQ/M3ZLTTYvSLh7OCn/24T?=
 =?us-ascii?Q?qK7kTAd9QIA0y9cIGtuOeV3r63ak0HtyM8qos4619P9P20yxZOZE0rXlRCOk?=
 =?us-ascii?Q?tjfSnVnd7e70DKc80QxzSfsdRcUhk7+tJAr2zCZ71FS6SClcwaCaOaS6h8XJ?=
 =?us-ascii?Q?IJc4qY3NxLLj2wwR0owmETSWxlMty3aTICQ9RLkhl5vxz8BT3aRrVvMYO7NW?=
 =?us-ascii?Q?Kv4y7eYso22ctrtgBelt+3p5r7U2J4ySfplZHb/op44HTdGSBR1zYD/XFdkC?=
 =?us-ascii?Q?59Sv3qCOWG8RPIwvQxsT0VOcm02opRYnbJ04ePBKCDINr3MzsCOlmxGi4nDS?=
 =?us-ascii?Q?gWv2hg2sAS5Xlc//XGZjHWUYqckmyP6RM1aL210Aibh6XXmmN0LjJS1zN6pB?=
 =?us-ascii?Q?ljODnits3i8VWXS4P6gPb1QiqymlaQgA7tLeTPEQTNgKhAJV8DEJwfV2qaCx?=
 =?us-ascii?Q?fxFV7KgPBaeqp0E7FffGuVo+YXrb3UNpntzBJ2Eo7nF0z3USVJspSxfwPXrL?=
 =?us-ascii?Q?YYg9LPyazkYI75zzuU73P22kAm5AsubivVk6oTEOLhupQyjtAeyKSx4Qhbv3?=
 =?us-ascii?Q?SE5+7YAS0SEA8sbGWBZ2IgaHm+zhjym9nkQfqxMc80Q/PhMtg5TFAFqclCgI?=
 =?us-ascii?Q?HoVPayC4dBuaNIzyKGBCRn5OLRZWDY0wsuKY/o2gw3ftmazcxvyfq/JjBUXZ?=
 =?us-ascii?Q?FePm3b/SONF7Piz06ysZPkFbGjpesAKLMnvmbDcDTWhqktwFnmzEJK1gbFlR?=
 =?us-ascii?Q?WSHDLiKwqdxXvBLMd4JAaN9nb13xzuHdPKKuCUVerzg5udye0bFkPSy+PRJd?=
 =?us-ascii?Q?S8/WReb3TwGlHXRbFK8P0U1VHmSnK893tjVGt5wuEJs/jOl4hvgN6ta5XXQT?=
 =?us-ascii?Q?eb1mrFCAZvt824GCtVd4AhBj/ExMORvkc5aNh8HnHsPdV3bZOUKa/w+GZUnG?=
 =?us-ascii?Q?a408IbZBmwCFzJJMULfZz4E5TlNFqtYAbSWaNeOS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d0f53e-6430-40cb-56c3-08dafead5842
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 08:22:48.9261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Frqt8MIaglxEPjy9CQ3Kzt0O+8SlP9UhD+B/1OcmOcrH2buHvuP5ER3VDZn0oBbiVf0wWTjYcQEVev2yP9AEMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6200
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This version passes on FRED, thanks a lot for quickly fixing it.

  Xin

> From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
>=20
> This is an RFC patchset v5. There are two patches in this series.
>=20
> Xin Li reported that the sysret_rip test fails at:
>=20
>         assert(ctx->uc_mcontext.gregs[REG_EFL] =3D=3D
>                ctx->uc_mcontext.gregs[REG_R11]);
>=20
> on the Intel FRED architecture. Let's handle the FRED system scenario too=
. The
> 'syscall' instruction in a FRED system doesn't set %rcx=3D%rip and %r11=
=3D%rflags.
>=20
> Syscall and sysenter in a FRED system are treated equivalently to softwar=
e
> interrupts, e.g. INT 0x80. They do not modify any registers.
>=20
> Link: https://lore.kernel.org/lkml/5d4ad3e3-034f-c7da-d141-
> 9c001c2343af@intel.com
>=20
> #### Changelog v5:
>=20
>    - Fix do_syscall() return value (Ammar).
>=20
> #### Changelog v4:
>=20
>    - Fix the assertion condition inside the SIGUSR1 handler (Xin Li).
>=20
>    - Explain the purpose of patch #2 in the commit message (HPA).
>=20
>    - Update commit message (Ammar).
>=20
>    - Repeat test_syscall_rcx_r11_consistent() 32 times to be more sure
>      that the result is really consistent (Ammar).
>=20
> #### Changelog v3:
>=20
>    - Test that we don't get a mix of REGS_SAVED and REGS_SYSRET,
>      which is a major part of the point (HPA).
>=20
> #### Changelog v2:
>=20
>    - Use "+r"(rsp) as the right way to avoid redzone problems
>      per Andrew's comment (HPA).
>=20
>=20
> Co-developed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
>=20
> Ammar Faizi (2):
>   selftests/x86: sysret_rip: Handle syscall in a FRED system
>   selftests/x86: sysret_rip: Add more syscall tests with respect to `%rcx=
` and `%r11`
>=20
>  tools/testing/selftests/x86/sysret_rip.c | 146 +++++++++++++++++++++--
>  1 file changed, 137 insertions(+), 9 deletions(-)
>=20
>=20
> base-commit: e12ad468c22065a2826b2fc4c11d2113a7975301
> --
> Ammar Faizi

