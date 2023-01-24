Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5826C67A4FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 22:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjAXVc0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 16:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjAXVcZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 16:32:25 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D390442DE6;
        Tue, 24 Jan 2023 13:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674595943; x=1706131943;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5KjZduuKtfdP2kEbVqNcKj2aYTimSlJ1S28EeIkeWvE=;
  b=AikmI93SSzyWrcidE9dGJltSEbyhKJw63Op6cHenkwYkGXl/B6fdqZjy
   XN6IpFafAT2VlgleK607CpDgKdw5w03jr5ZgUYjZ4k+0ZM4AgcNKAXXmN
   PKb0EbWv3iU5Uk7C1+Tv1UctmaysT+wze219Ib19hh7l9TrtRX4UjNgkM
   0KKfdlVZ+/7vEnDgIdfGfqGuC0nqqb8bngtlRphDxomqHVWMH7y/1xVxG
   ktoAL/nzQgBXYTwsACLF4iSS8c2jgW9SAZ6w+BoIZ1EM9i7WmtZAxOikh
   kHg83XEvrF6QICmr3sQk0qHi7IQ3arOfK458iIylD6p+vI1zlfVVkxbfw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="388758088"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="388758088"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 13:32:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="804765135"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="804765135"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2023 13:32:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 13:32:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 13:32:21 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 24 Jan 2023 13:32:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBT6nxeO8bbHR2Rq4uo4aqM2f/5o2JlORrqFNMCKCfQpsVdNgubTFbjU4PgN2h7AvPTv6QWvaF+jJ4HCpMZChgDPkJqujCJkJ1ql3jOhHCA0inY7qpBwwDbZeS4q6ps+Nz0U7/O6DhRbRFrtCGj0iMbuLcRLKTpCly+dkYMXrsiBYFGFl6b8FutdDJFGuGAIAt2664CI9ta7mFvfX4nmde/to34NB7Ifos0dYLmUBu8Uc3hNEmPD9aQCy35q5BBvITgsI1oj9kyosf1fDhwe14nc+e6EIddhPlXztpqYH7KexUmDMqSqVwYcS02/PwWwjtNukQKPl5hPfAEifpcWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMUdYXbzSURoQFJ9voCxmTVjOHPZCyfP88xDHfzAbbA=;
 b=MAHkqR+BPODRayCKuf/IOzr3iaqe2SidjXEkT9+jcqC7XZNRK+T0w2EG48FqNVXr+49ta5bFmE2SvGKRGEzd3XIJ2S91uHxH1/yCyOjAOxcYWwjm77yWatutrUQiOtEKURhBcSdX7asDDQ1jI4QJo/43mFPUuCEMQmLqhbNoclVdjpOSmu9WR3YjZkQzekE6/MV1Mf4kCxyIEsJZzSOG2bDd7jItOpM/Fuv2oDX04Y6QyoO6nHKNKE/86RpDm9WVgaDX3s737FO20xL8DhAmh4jsuBdWI7JmhbjXNtskZkUlangU8YLybvK4ccMQPTfqOxZkbPyfIIeEnXVo1690kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SJ0PR11MB4960.namprd11.prod.outlook.com (2603:10b6:a03:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 21:32:14 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811%5]) with mapi id 15.20.6002.026; Tue, 24 Jan 2023
 21:32:14 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 Mailing List <x86@kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v3 0/2] selftests/x86: sysret_rip update for FRED
 system
Thread-Topic: [RFC PATCH v3 0/2] selftests/x86: sysret_rip update for FRED
 system
Thread-Index: AQHZL9wHXOCNBEx4pEaxwC77ioU9Ra6uFIBQ
Date:   Tue, 24 Jan 2023 21:32:14 +0000
Message-ID: <SA1PR11MB6734CA3184183E490D18CA72A8C99@SA1PR11MB6734.namprd11.prod.outlook.com>
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
 <20230124100926.637335-1-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20230124100926.637335-1-ammarfaizi2@gnuweeb.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SJ0PR11MB4960:EE_
x-ms-office365-filtering-correlation-id: 62336c3b-ef5b-4a08-8669-08dafe5275ef
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UKcEvYY57kiYztgWsvGZJmYAJ0ali7pmvHDyDBZw3uWjsQ+IbQGU+2FHHuU/itMjtuyU/XI41ntWRX8tx6EZWqkZfk3SbuDqSZMsHQweuUeDM7SVdPbB/G16t+/7LfK9o9mduKUncNg1wmt19Y2B00tqwk8SeERDKqEoYg/wVkaMqrHsr0Vfs9syN6brPeno+5LnOlJ8qhAI3fMmxFH5EsAQneT1UYuqTyUn8qlFbv/PfFgSvNvy6hogIU4c2rFCO+yqUXnT0iUHaFqtX0kfn1NYGlepu/jetoNNP/ar9OTKdLjsZxskKtVmbS/mjxQTN3ZSQCr62OxkHwG3/ddOqQMMvnTN6Db6cLnQkWHSizgj7cbCMnpWrXMaeOtz2sTDnZthlwDhKFYOswhCyG+QRjhoIiy6BhNOsKYIgdp99xyc8Xlb7/5sBQB24YIpvUHsZRc7WVWt4x31gNeMdoWDWals4pIz7iew60huU06imrEeIQDtSuHSsSkwE/qWkeJjU9f+bm1TpgbN7bhRsCjLUfjdmpzakWapLR8DE+13+SRTcW2xJ7oTj3Mn9qE8gUbANRmhXNR4JDvmzSW5pLedBauPql15WJSdpbPftIX6I9kfhAUPspmtBj/SNIS8hVhBv6MLgQ0tvGB88pMIG8AMv4nY4TFFPNAhF7GycYQc3nSUUv+4/RBTyZ8TVZW+yQksgsRlioSovARbV9yKp/pFEmYgWadyzuTuS68sTlcXhx9FXbS3mDtVZI9VHVtIzGN580b+++6Egf24ZclEKMb8LQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199018)(83380400001)(38100700002)(33656002)(122000001)(82960400001)(5660300002)(41300700001)(7416002)(86362001)(7696005)(2906002)(26005)(4326008)(15650500001)(8936002)(52536014)(55016003)(316002)(6506007)(8676002)(186003)(66476007)(66556008)(54906003)(64756008)(478600001)(66446008)(110136005)(966005)(9686003)(71200400001)(66946007)(76116006)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kbHSDxbB0b/KtQtk/J4LNN/NjHTmeeL+wW3UG90y6cxlLLQsq340+IvdqelW?=
 =?us-ascii?Q?WK2yALeHs4G6qdcfcjzj3v0jAxSZOU/S4pqQCiQAPfjFLsikWM1PJbkOkgyB?=
 =?us-ascii?Q?xxg9y6Vv89mk8FQ+dsJaVofFupKwtNfh4B8ADVUEmQxSRldgT2bXRaWQJGIt?=
 =?us-ascii?Q?ZX/hhEvB352OlWM16WwZh0U5tuVi0s0R0NB0DYJ0wxyfgRYDyWbmVsolQBGo?=
 =?us-ascii?Q?sJZNK4LGO+ZUXZQVYQg5lwH0vpXMrSaM11EeEUdw/UYA3iPf9r3sVOBLcCWC?=
 =?us-ascii?Q?yOqEJxyOroQh0L+REuE5+3DXDty70SzaOsjVylZVgKaFkEjhyHEOp/rt3qKd?=
 =?us-ascii?Q?/InHi1w4BSj61EwpZjXGZkWrSUKWMECoiH8imeziAI8cBaH19+GQDv8WhWf+?=
 =?us-ascii?Q?hmpIVQhq4WoAv5AfSG2paIli8NKiO6CHgLyCyh23i7+69343YU2/lYNL5GMI?=
 =?us-ascii?Q?xjyrdCKXf0o5xhhSxQcSsi48dLHUw+RNsCZzr8AK48ZqmoDciyuAPmNjWkB8?=
 =?us-ascii?Q?Wbz0SN6bd3nmQZ+6ns4V3WknyuRT4aDbJLlAeap/FrfZURmZZFFDILrTf75z?=
 =?us-ascii?Q?TpDbGc6jqIf3L5caSDAS1aUtymuSJvXKXm/cHkksiOgtLHZnlYXmI+1TFD8B?=
 =?us-ascii?Q?PcQQkSYpTknC5XsErz8b4VvzvhV06LZ5t8cuSfaKtv2HSqjyNW3AadGvi3aD?=
 =?us-ascii?Q?dSd3B1Bdjq3Dy0u3N4ZweIag+K0QGUbtiZFhVFFXnjbduwQaxTR1hLj7omG7?=
 =?us-ascii?Q?c3GpHEg196PLY+zISAx5BF0Je6j5bARCWBqMuQ3f62p5UWOoV+Kz2GGqJMi6?=
 =?us-ascii?Q?UyHgDeXw7dM644mStAEiYA04bVJCQrCgJPoNIwe4vFeokrcOrqAA1ZG7Otdu?=
 =?us-ascii?Q?/+SnAkUWrMjWMHV033LzOWZnSLgztJaXcpp0Xz/XiTtIOiamJwO8pIDhYYKq?=
 =?us-ascii?Q?Bwye8ZYFUAJ4NQud8rdXUcauHYCePQShTlm7SuwcoT7utXTYWlUWrOX+cj/8?=
 =?us-ascii?Q?42+/XZ/VVp91pmFH8QVmbb+dPQHPAF8Uwq88U1G+BVFAbXBW8GH/RZGph1gR?=
 =?us-ascii?Q?dNSx5kdidN13b2pSyi+nry45o3G0btQSUhAirIiRA0g0O5jrmK/ArKRjaT5C?=
 =?us-ascii?Q?X+NA9VxdieLtK5HYiz9r2NOz/PmxSuusTl2nHhSU39VuKFUgm5AcEq9cXHHX?=
 =?us-ascii?Q?oCzdOfeXxxhklZSFeEIwMBsJ9HZvGa5i8HJZ4semr+DvUfMUL6tff6zDoyOY?=
 =?us-ascii?Q?Do1dax5ZxtYtai9uSPdb7+h+GxuJUJCDPOyRJTJebe81RWe4AiBx+E3n/p+U?=
 =?us-ascii?Q?8IoOGDodYUtLjxgf59dWc8TS/epOoXdy2NXps/g03wn+xIskuQ6QgK44yCrk?=
 =?us-ascii?Q?2iSdsrqISjatWKXs7IIyeOY59Lv5f2X2eWG0IIuHW3jJx++LM7XayvB4b1hd?=
 =?us-ascii?Q?ggxhDGSbwnP2U2nbMsJDg1Kt3rqXRqzAhfKa+qNIm08cLnn82UauFitimEi1?=
 =?us-ascii?Q?o92SEIuFK5p/2aD0j9swqbjlTlSvQy1UUQQJ9hxKnwowiURJGXWghDe9PYVr?=
 =?us-ascii?Q?S44/P9m1Lv/kCIu/OHDGKaBA32r1nW20UOHcJATZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62336c3b-ef5b-4a08-8669-08dafe5275ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 21:32:14.5595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvTSy3ECgLTV08JHLpfHTYVBhvSO5qCBb+vMqOJDhJ54w0QrglOEArlAwjvS0XnIa+pnNyh9FH6b/N/ce2mftg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4960
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
>=20
> This is an RFC patchset v3:
> sysret_rip test update for Intel FRED architecture.
>=20
> Xin Li reported sysret_rip test fails at:
>=20
>         assert(ctx->uc_mcontext.gregs[REG_EFL] =3D=3D
>                ctx->uc_mcontext.gregs[REG_R11]);

On FRED systems, flags is 0x200a93 and r11 is 0xfeedfacedeadbeef here.

We need to remove or change this assertion, maybe:
  assert(ctx->uc_mcontext.gregs[REG_EFL] =3D=3D ctx->uc_mcontext.gregs[REG_=
R11] ||
         r11_sentinel =3D=3D ctx->uc_mcontext.gregs[REG_R11]);

>=20
> in a FRED system. Let's handle the FRED system scenario too. The 'syscall=
'
> instruction in a FRED system doesn't set %r11=3D%rflags.
>=20
> There are two patches in this series.
>=20
> How to test this:
>=20
>   $ make -C tools/testing/selftests/x86
>   $ tools/testing/selftests/x86/sysret_rip_64
>=20
> Link: https://lore.kernel.org/lkml/5d4ad3e3-034f-c7da-d141-
> 9c001c2343af@intel.com
> Fixes: 660602140103 ("selftests/x86: Add a selftest for SYSRET to noncano=
nical
> addresses")
> Link: https://lore.kernel.org/lkml/25b96960-a07e-a952-5c23-
> 786b55054126@zytor.com
> Reported-by: Xin Li <xin3.li@intel.com>
> Co-developed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
>=20
> ## Changelog v3:
>=20
>    - Test that we don't get a mix of REGS_SAVED and REGS_SYSRET,
>      which is a major part of the point (hpa).
>=20
> ## Changelog v2:
>=20
>    - Use "+r"(rsp) as the right way to avoid redzone problems
>      per Andrew's comment (hpa).
>      (Ref: https://lore.kernel.org/lkml/8f5c24df-514d-5d89-f58f-
> ec8c3eb1e049@zytor.com )
>=20
> ---
>=20
> Ammar Faizi (2):
>   selftests/x86: sysret_rip: Handle syscall in a FRED system
>   selftests/x86: sysret_rip: Add more syscall tests with respect to `%rcx=
` and `%r11`
>=20
>  tools/testing/selftests/x86/sysret_rip.c | 120 ++++++++++++++++++++++-
>  1 file changed, 119 insertions(+), 1 deletion(-)
>=20
>=20
> base-commit: e12ad468c22065a2826b2fc4c11d2113a7975301
> --
> Ammar Faizi

