Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E1E3FBB65
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Aug 2021 20:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbhH3SGW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Aug 2021 14:06:22 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:42064 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238393AbhH3SGV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Aug 2021 14:06:21 -0400
X-Greylist: delayed 1020 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Aug 2021 14:06:20 EDT
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17UHbuUS007487;
        Mon, 30 Aug 2021 17:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=bSPAPBZIRO/c0shsPCpJUf9muPzU0pArUo4SGzaqS5A=;
 b=Rp0ja2GtKzBq5acw7gsakj+CjtUKCGbTjHBAJ5z9pDHJ0gLSLDAyqhXNfNvL9OjnS22A
 zv1ugdLIXINOKiTJf+fWTlQyf7jmRg2u3RbploiRj0oBQ9Qpr1dh1zXRNw/oF0Hy9Qj+
 IXsXGFP3qrPEl0Us25c+Tzj8NXTCCqMkHMoVvt6zCEb43EFLILaMCwZIWjmJDhFGuSEG
 MNh8jFqvat2Lj5bg6HX98p/1z3Haaatota+UG/PAjC4//2PcaWZSy3WhCH8RAR35sJLc
 nFMeOWgjIy5PNj9nGL6VySza8o8/DOLMi2cMM6Q34edc72wHDLHql1/sGUb6Kv2VbpEs hw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx08-001d1705.pphosted.com with ESMTP id 3aqf46s914-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 17:48:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NonLFw5+TBouG7q7S/y4wAGSrS1Xq6LQtFqly/IVp97PJEcte8Ts4DMqcTyxNbzmGE0/vzVE/TrmxtE+T45XJLF3V8OWTamclztZkVPUIW8RDnKdyMUj4AROwv9w4zNCosZBUmD2Gg+injDG5Mg9voBXYe++UDEVi/a1bxDt75HwwdWX8oroqBDy08JxA7T/rXrVrQ3JNuHm2MZBxYoVnJN2ZnxH7qgYjd7/rPbEGoSBQ2sKt9yILGALzVemBCqO4cmVF2lisr+GNE/XAREhStUvsSPwtSiGYamPQlI5sccIBVoN7IEJNSi3bHUK3yKgcGfz5zCXYR/bKdy7yCEhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bSPAPBZIRO/c0shsPCpJUf9muPzU0pArUo4SGzaqS5A=;
 b=ldiAjhQwo/qJgFY4MPeSL2LP02iR/8+S12BjmRr7koV+5QWla2FSNrXqDz+RH7P1o2Y8lROHEZsQeQ/rZ4vG5w4lUtmwHAwDzM08AwhTUwHWzOlUAovTUwk4HsaktPYcsw6Fbpx3QkBpqrGtEzz/9yq33mD8Zb/38VIoN9NsIDqzpHzJ8u03YAVYne/VmzWhg5gFXvTtH9E4Zk/G4TgNIkPnBUCXAZ6auqNoEimN/0P2UioVXQjPV1tkymJUZJdsAaD3X6f5pWmslfm/tkPlSxGueQJ2f4fh5XV4DCgNYXylV0bEcgBseVEOedjsiDHi/SdGFjI1TfBlH3REGPO7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by BY5PR13MB3029.namprd13.prod.outlook.com (2603:10b6:a03:183::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.16; Mon, 30 Aug
 2021 17:48:07 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::5190:4162:72e8:7998]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::5190:4162:72e8:7998%7]) with mapi id 15.20.4478.017; Mon, 30 Aug 2021
 17:48:07 +0000
From:   <Tim.Bird@sony.com>
To:     <keescook@chromium.org>, <rmoar@google.com>
CC:     <brendanhiggins@google.com>, <davidgow@google.com>,
        <shuah@kernel.org>, <dlatypov@google.com>,
        <kunit-dev@googlegroups.com>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernelci@groups.io>,
        <guillaume.tucker@collabora.com>
Subject: RE: RFC - kernel test result specification (KTAP)
Thread-Topic: RFC - kernel test result specification (KTAP)
Thread-Index: AQHXjj7+R2tK76sch0Cg3jcbmYTJxauIrqsAgAOyNyA=
Date:   Mon, 30 Aug 2021 17:48:07 +0000
Message-ID: <BYAPR13MB2503A4B79074D8ED5579345DFDCB9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com>
 <202108272330.AE55FCD@keescook>
In-Reply-To: <202108272330.AE55FCD@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=sony.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aacc3f63-2e8c-4da0-5851-08d96bde5334
x-ms-traffictypediagnostic: BY5PR13MB3029:
x-microsoft-antispam-prvs: <BY5PR13MB302955CD9B7F0B32C189D0B8FDCB9@BY5PR13MB3029.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C7sKjyVt8cvA41zEQfM5F+EMQCBAgQFQEdbO+vsBxxktQ+G1llp7CGdIn6gvzoqs3rterh7Q77Y4Wb1ZSnh1sjcq6umToeGFzG3JDbej5ucmsnS36iMav5BzXsh6ImNl6ZVaOYX+FYV4g5E6rdyTOyrqO/wDGodK4+m14qfGo2n+IXqb3MBpvE7LpSZ7NidZDpal+gUJfK/t+TTrT23FLXLpaisfxgkeeITyL5OPClJQuTbkgPQmTEYiiirPiFGtD0LpdtDC9VYvrVE4ykVp1Z6k3BxW653CwVenaWzNh5Q0EudoliOGuPdpXXBDWtbK44p8lI43qhL90Z8d2Q3+oG9wZSR4kls0GjOwnfTNN4ICESXnzcDpK34MejR1lTKeQwqgnRmUoOlJve8ORBjPcb4822QJCjmax6GxMX33I+6ecx3QDWN5DbJy7cHz8RKR1nJgBZt/DL0ZdkqWqizwKxvHT/5Bbb9GSsG12/NWOwmT4rDCEeN7II+Y8FAwLXR+589aRxYIfEVU1udY1H1vPz1bVlHZ/wX22Z0sK2aHFMTVUAw5qZI2vsz7omAchmvHL3rq7vDMljURBix1hXatMmbLabQ/iWFzKzZIIVHEj4CQbfwaRUn8YCh0XZml13xT2dddZyucCKEKmB6ayOlw57RC5QCUVl/BLp0p3GUhSsEeR8mEGuSoMMJEFo/eaMAz/YekgeadnFG8gTJi0Oas2YBjd+AFi3nXHM+Aux1ejihgHsuItrvdmYjKTkIGdYqoGnp0PTS9sq6V+ClWtZv7N89SPl9eNa6QDk8SUYGNvqkNhHU6M31fPaWlN9SgYbSNrTgG2SDYA5lWut+WzAQdjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(76116006)(478600001)(9686003)(55016002)(83380400001)(64756008)(66446008)(66946007)(66556008)(66476007)(26005)(45080400002)(186003)(86362001)(316002)(33656002)(71200400001)(30864003)(8676002)(54906003)(5660300002)(6506007)(7416002)(122000001)(966005)(4326008)(2906002)(7696005)(8936002)(52536014)(38100700002)(110136005)(38070700005)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oRWumd08QLmHTZwUjyS7984+E2eWAl63I5ThuEDCInQqPvJWH83+w9wtua66?=
 =?us-ascii?Q?b5hP+GXIHIAcpV+zs/THLnDlS47IPuVqPs25QbxXixdYJhn0N+mHu4V9xwbK?=
 =?us-ascii?Q?+Mq5KID30pqhacwB3h0wWW+dMJtjxRdvyCXuzNUtjli1srR6QEeW5lt6uprE?=
 =?us-ascii?Q?GjCEzfqKBXz2cRRVFYT+NeXyQYyYsZmsReAJPNM7ck+RdlsUJVxE9+g67sum?=
 =?us-ascii?Q?JqM1gGDoGha4RSLMP5xbNS491ceZuOI4JU9pIsySoD+seaB09kCAa0pkpHkP?=
 =?us-ascii?Q?vbCqs2PpqLdRIKbVcFvomivL9+P50ScmtxS9O0OyQcPxzfDFDrtF5eNL8Ifb?=
 =?us-ascii?Q?eceKbpRDLZtjTCW+ImcInznpnYDHXwNXEQ4JGqi6Ofg7HHrdQgWSAZ7pd56M?=
 =?us-ascii?Q?/b/CMs5A06nGXY9ca3+NWeYJQnM+B9mFNrZ+sbTpn2VWGglGzlFd2pcGFsLo?=
 =?us-ascii?Q?sp6wGRgBleJtlZVs5ACPvYqwraKkvOxsWodJZAMGmr3K14Ios8SZ1RQR6QHE?=
 =?us-ascii?Q?cUuDgKbhfg2+965SkcMRJBw2ZwJksJdwwq19sH8/LErXIH3DN+V/dtSBNcjd?=
 =?us-ascii?Q?lCLFY21hcYM2Xl5MlJ2CdpdMZ06Q7MXpqG8n0kre2aYIH1FTwQ44UgnERQy1?=
 =?us-ascii?Q?fBR6/8hwGPbv+jb/J+qJ6poVn4YKEyo38RoBrjiKWdF0Hjp77kwH7yWbjY6m?=
 =?us-ascii?Q?ELuWMAVZ4lcbh7Ndwmz7FqBlp1ZaHEPhcQjEa7JLafwy3IqQngxtXlB9vC16?=
 =?us-ascii?Q?yn3lqRj48XAv5KMHZU3T1j8+iNlvP0njHMb/8Nb0G0CyEgaIX3z0hpF+40ZL?=
 =?us-ascii?Q?TDXDAZMEz36qhtUUUtfigpN4nGGa7PVqc288F3h1KBPN3X3nT3CqFVgrIthe?=
 =?us-ascii?Q?VkZM0uWziCUa6fHmAQMSoJH/p6BIGVlbxNAjWJDrUQXq0BfSHsR8nqrC9de6?=
 =?us-ascii?Q?9IQ+9jOJdLFvmRSHB8z7gNQ4BvwlsAngrs8t3ZlLBFvcWM9NAquZQETxpR1D?=
 =?us-ascii?Q?Bo45eEJ54WtoloFkrKvvruuWQ0Ts5V/JX4dU9sVsIK1UdLQhR5yixfxbwNue?=
 =?us-ascii?Q?Fx0iUlUFPLZkOoUyqpRmAdMseiN1fcXbj2dfgx53HMQhyNbOR0bMW4PCMEB7?=
 =?us-ascii?Q?qD5I1pZtLQiI2vc4VDjENNotn6TlV8LLg7IXuzHjkc5UJ4PmgHfxp4Cx2V34?=
 =?us-ascii?Q?8mwz7AE0W2ccxeqvq2ygt7hvQe30q4bMj4bXGcu9jw/w/XRpWvjLjXvPUt8p?=
 =?us-ascii?Q?2cOckn0DyM//7OBhTDmY1uKK/2z8Ggxt+3DBF8UeI55P8Gt1hG5plRVxe5jY?=
 =?us-ascii?Q?pQ1Izgn82HwBeW9LQUcmXvcJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacc3f63-2e8c-4da0-5851-08d96bde5334
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 17:48:07.1207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XTbQdM3VI19BzaI+39Dmo13m58UBiP6dHy1w4YhLSXi7LHWFjJyU/3Yrmo7S1VEpgr8kJNUBnSaUwCwVZLAZJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3029
X-Proofpoint-GUID: fu992sQwR69gc-jxQkE3-PAs8WYHwT8V
X-Proofpoint-ORIG-GUID: fu992sQwR69gc-jxQkE3-PAs8WYHwT8V
X-Sony-Outbound-GUID: fu992sQwR69gc-jxQkE3-PAs8WYHwT8V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-30_06,2021-08-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300119
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Kees Cook <keescook@chromium.org>
>=20
> [+kernelci, +Guillaume]
>=20
> Hi!
>=20
> Please keep me in CC for these kinds of proposals. And thanks for looking
> at this again! Please understand that while I may be coming across as
> rather negative here, I would like to have a rational and documented
> specification for the kernel's test output, too. My main objection here
> is that we already _have_ a specification, and it's already being parsed
> by machines, so making changes without strong justification is going to
> be met with resistance. :) So, with that in mind, on to my reply...
>=20
> On Tue, Aug 10, 2021 at 04:25:03PM -0700, Rae Moar wrote:
> > We are looking to further standardise the output format used by kernel
> > test frameworks like kselftest and KUnit. Thus far we have used the
> > TAP (Test Anything Protocol) specification, but it has been extended
> > in many different ways, so we would like to agree on a common "Kernel
> > TAP" (KTAP) format to resolve these differences. Thus, below is a
> > draft of a specification of KTAP. Note that this specification is
> > largely based on the current format of test results for KUnit tests.
>=20
> The kernel's largest producer of TAP is kselftest, and the largest
> consumer is LAVA[1]. I would want buy-in from at least those responsible
> for either side of those two things. (And I'm one of the people working
> on both sides of it.)
>=20
> The fundamental purpose of the kernel's TAP is to have many independent
> tests runnable and parseable, specifically without any embedded framework
> knowledge (or, even, any knowledge of TAP).
>=20
> The tests run by kselftest come from 2 different TAP-producing harnesses
> (kselftest.h for C, kselftest/runner.sh for TAP-agnostic tests) as well
> as several hand-rolled instances in Shell, Python, and C. There used to
> be more, but I have been steadily fixing their syntax[2] and merging[3]
> separate implementations for a while now.
>=20
> [1] https://github.com/Linaro/test-definitions/commit/8bd338bbcfa5a03efcf=
1d12e25b5d341d5a29cbc
> [2] https://git.kernel.org/linus/b0df366bbd701c45e93af0dcb87ce22398589d1d
> [3] https://git.kernel.org/linus/e80068be21824e4d2726eeea41cac6178d212415
>=20
> > Additionally, this specification was heavily inspired by the KTAP
> > specification draft by Tim Bird
> > (https://lore.kernel.org/linux-
> kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.p=
rod.outlook.com/T/).
> > However, there are some notable differences to his specification. One
> > such difference is the format of nested tests is more fully specified
> > in the following specification. However, they are specified in a way
> > which may not be compatible with many kselftest nested tests.
>=20
> I commented extensively on that thread. :)
>=20
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Specification of KTAP
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > TAP, or the Test Anything Protocol is a format for specifying test
> > results used by a number of projects. It's website and specification
> > are found at: https://testanything.org/. The Linux Kernel uses TAP
> > output for test results. However, KUnit (and other Kernel testing
> > frameworks such as kselftest) have some special needs for test results
> > which don't gel perfectly with the original TAP specification. Thus, a
> > "Kernel TAP" (KTAP) format is specified to extend and alter TAP to
> > support these use-cases.
> >
> > KTAP Output consists of 5 major elements (all line-based):
> > - The version line
> > - Plan lines
> > - Test case result lines
>=20
> These are required.
>=20
> > - Diagnostic lines
>=20
> This is optional.
>=20
> > - A bail out line
>=20
> Bail out should be optional, and possibly not included at all. (See
> below.)
>=20
> >
> > An important component in this specification of KTAP is the
> > specification of the format of nested tests. This can be found in the
> > section on nested tests below.
> >
> > The version line
> > ----------------
> >
> > The first line of KTAP output must be the version line. As this
> > specification documents the first version of KTAP,  the recommended
> > version line is "KTAP version 1". However, since all kernel testing
> > frameworks use TAP version lines, "TAP version 14" and "TAP version
> > 13" are all acceptable version lines. Version lines with other
> > versions of TAP or KTAP will not cause the parsing of the test results
> > to fail but it will produce an error.
>=20
> Maybe "TAP version Linux.1" ? I don't want to needlessly break existing
> parsers.
>=20
> >
> > Plan lines
> > ----------
> >
> > Plan lines must follow the format of "1..N" where N is the number of
> > subtests. The second line of KTAP output must be a plan line, which
> > indicates the number of tests at the highest level, such that the
> > tests do not have a parent. Also, in the instance of a test having
> > subtests, the second line of the test after the subtest header must be
> > a plan line which indicates the number of subtests within that test.
>=20
> I do not want "subtests" as a specification concept, only "nested
> tests".
>=20
> >
> > Test case result lines
> > ----------------------
> >
> > Test case result lines must have the format:
> >
> >     <result> <number> [-] [<description>] [<directive>] [<diagnostic da=
ta>]
>=20
> "[<diagnostic data>]" is not defined below. I think what you mean is
> "directive details".

IMHO it's useful to keep this called 'diagnostic data'.

The directive is optional, and having this be diagnostic data means you can
put explanatory text, or result details, that are independent of the descri=
ption,
on the same line as the result.  This is convenient in some cases.

I think diagnostic data should always be prefixed by a hash sign.
Or, in the case where diagnostic data appears on the result line,
the hash serves as the delimiter.  This means that the description
text must not include a hash character.

For example:
ok 5 - check return code # rcode=3D0
or
not ok 5 - check return code # rcode=3D17

>=20
> I suggest:
>=20
> <result> <number>[ [- ]<description>][# <directive> [<directive details>]=
]
>=20
> > The result can be either "ok", which indicates the test case passed,
> > or "not ok", which indicates that the test case failed.
>=20
> Yes.
>=20
> >
> > The number represents the number of the test case or suite being
> > performed. The first test case or suite must have the number 1 and the
> > number must increase by 1 for each additional test case or result at
> > the same level and within the same testing suite.
>=20
> Yes, though parsers should handle ordering failures and missed test
> results (this is the purpose of the "plan" line).
>=20
> >
> > The "-" character is optional.
> >
> > The description is a description of the test, generally the name of
> > the test, and can be any string of words (can't include #). The
> > description is optional.
>=20
> Yes, though the optional "- " is strictly part of the optional
> description.

It's mildly annoying that "-" is optional.  It's trivial to deal with in th=
e parser
to just ignore it if it's present.  But it has no semantic meaning whatsoev=
er.
IMHO it would be nice to either mandate it or remove it, for consistency's =
sake.
This could be based solely on the consensus for whether it added or detract=
ed
from human readability, since parsers don't care.

>=20
> > The directive is used to indicate if a test was skipped. The format
>=20
> The directive is a single word -- currently only "SKIP" is recognized
> by TAP 14(?), but kselftest uses also XFAIL, XPASS, TIMEOUT, and
> error. (Though I would love to hear what "error" is intended to be used
> for, if different from regular "not ok".)

ERROR usually means that there was some kind of failure
in the testing process that makes the testcase result indeterminate.
(like loss of connection to a server, or crash of the program executing
the testcase).  This can be due to a bug in the test or the test system.
I'm, not sure if ERROR is used this way in kselftest.  It is, IMHO, a usefu=
l
distinction to make.  TIMEOUT is a special case of ERROR, IMHO.

As an aside, I've never liked XFAIL or XPASS.  Semantically, I believe they
are quite confusing, and depend on the level of testcase execution.  XPASS =
is also
redundant.  Isn't the default case always XPASS?

In the case of XFAIL, does it mean that an operation that was expected to f=
ail
all the time, failed, and so the test passed?  Or does it mean that this is=
 a known
bug that a particular developer or site has decided to ignore (as in "we kn=
ow this
is a bug, but we expected it to fail, so just ignore it for now).  The latt=
er, I really
don't think should be encoded in the tests themselves, but should be put
into a layer above the test and parser, that is applied according to develo=
per
or testlab policy.

>=20
> (This could also be called "context" rather than "directive".)
>=20
> > for the directive is: "# SKIP [<skip_description>]". The
> > skip_description is optional and can be any string of words to
> > describe why the test was skipped.
>=20
> I would call this "directive details".
I would not, since it is human readable text, and may be present
whether the directive is there or not, I would still call it 'diagnostic da=
ta'.

>=20
> > The result of the test case result
> > line can be either "ok" or "not ok" if the skip directive is used.
> > Finally, note that TAP 14 specification includes TODO directives but
> > these are not supported for KTAP.
> >
> > Examples of test case result lines:
> >
> > Test passed:
> >
> >     ok 1 - test_case_name
> >
> > Test was skipped:
> >
> >     not ok 1 - test_case_name # SKIP test_case_name should be skipped
> >
> > Test failed:
> >
> >     not_ok 1 - test_case_name
>=20
> This isn't valid. No "_" is recognized for "ok" vs "not ok".
>=20
> >
> > Diagnostic lines
> > ----------------
> >
> > Diagnostic lines are used for description of testing operations.
> > Diagnostic lines are generally formatted as "#
> > <diagnostic_description>", where the description can be any string.
> > However, in practice, diagnostic lines are all lines that don't follow
> > the format of any other KTAP line format.
>=20
> I still think there should be a distinction between "diagnostic lines"
> and "unknown lines". For example, if kselftest is running on a console,
> the dmesg output may be intermixed, and possibly temporally offset. Such
> lines may not be useful, and may not be strictly correlated, where-as
> the output from kselftest is at least self-consistent.

I think this would be a very good distinction to make.  You might have
unknown lines that (inadvertently?) start with a hash, but trying to=20
make sure that the test itself always outputs diagnostic data with a preced=
ing
hash gives a reader potentially more information about where the message
came from, and could be useful.

>=20
> > Diagnostic lines can be
> > anywhere in the test output after the first two lines.
>=20
> I don't see a reason for this strictness. They can be anywhere.
>=20
> > There are a few
> > special diagnostic lines.
>=20
> No; diagnostic lines must have no meaning: they are for humans and nothin=
g
> else. If other details are needed for machines, we should explicitly
> create new format lines. I made a mistake when I used a diagnostic line
> for embedding the test names. :( There is a need for parsers to discover
> the name of a given test, though, so we do likely need something for this=
.

I agree it is handy to have the test name for sub-tests.  However, I don't
see any semantic difference whether we define sub-test declarations via
diagnostic lines with special syntax or by creating a new syntax separate
from diagnostic lines.  Either way, we have a new syntax for parsers to
understand.

>=20
> > Diagnostic lines of the format "# Subtest:
> > <test_name>" indicate the start of a test with subtests. Also,
> > diagnostic lines of the format "# <test_name>: <description>" refer to
> > a specific test and tend to occur before the test result line of that
> > test but are optional.
>=20
> I don't think the above should be included in the spec -- diag lines
> should have no parseable meaning.
>=20
> >
> > Bail out line
> > -------------
> >
> > A bail out line can occur anywhere in the KTAP output and will
> > indicate that a test has crashed. The format of a bail out line is
> > "Bail out! [<description>]",  where the description can give
> > information on why the bail out occurred and can be any string.
>=20
> I'm not a fan of the Bail out line. It's not a problem, exactly, but I
> find it redundant. If we want an "end of test" line, let's make one.
> "Bail out" is a special case of exit. If we want to handle test exit,
> let's define it. E.g. make kselftest's test summary lines not
> diagnostic lines:
>=20
> # FAILED: 85 / 87 tests passed.
> # Totals: pass:83 fail:2 xfail:0 xpass:0 skip:2 error:0

How consistent is it for selftests to produce test summary lines?

>=20
> Also, parsers should treat a new "TAP version..." line at the same
> nesting level as indication that the prior test has ended (and any tests
> without result lines should be considered failed).


Agreed.

>=20
> >
> > Nested tests
> > ------------
> >
> > The new specification for KTAP will support an arbitrary number of
> > nested subtests. Thus, tests can now have subtests and those subtests
> > can have subtests. This can be useful to further categorize tests and
> > organize test results.
> >
> > The new required format for a test with subtests consists of: a
> > subtest header line, a plan line, all subtests, and a final test
> > result line.
> >
> > The first line of the test must be the subtest header line with the
> > format: "# Subtest: <test_name>".
>=20
> Please no. There is no reason to force a nested test to suddenly have
> to know about its test execution depth/environment. A subtest is just a
> nested TAP result. That it is nested is only meaningful to the parser, no=
t
> the executing test, and it must have the same output, nested or not. (e.g=
.
> running the test alone or running the test under a full kselftest run,
> the only difference is the indentation level.)
I agree that the sub-test should not know about this line.  I thought
the "parent" test wrote the line.

>=20
> > The second line of the test must be the plan line, which is formatted
> > as "1..N", where N is the number of subtests.
> >
> > Following the plan line, all lines pertaining to the subtests will foll=
ow.
> >
> > Finally, the last line of the test is a final test result line with
> > the format: "(ok|not ok) <number> [-] [<description>] [<directive>]
> > [<diagnostic data>]", which follows the same format as the general
> > test result lines described in this section. The result line should
> > indicate the result of the subtests. Thus, if one of the subtests
> > fail, the test should fail. The description in the final test result
> > line should match the name of the test in the subtest header.
> >
> > An example format:
> >
> > KTAP version 1
> > 1..1
> >     # Subtest: test_suite
> >     1..2
> >     ok 1 - test_1
> >     ok 2 - test_2
> > ok 1 - test_suite
>=20
> Again, I see only downsides to this. Nesting for the spec is simple
> indentation-based recursion. Let's just keep what we already have:
>=20
> TAP version 13
> 1..1
> # TAP version 13
> # 1..2
> # ok 1 - test_1
> # ok 2 - test_2
> ok 1 - test_suite
>

I prefer spaces, but whatever.  Is the prefix on the 'TAP version 13' line =
guaranteed
to be the prefix on all lines for the (sub-)test?
=20
>=20
> > An example format with multiple levels of nested testing:
> >
> > KTAP version 1
> > 1..1
> >     # Subtest: test_suite
> >     1..2
> >         # Subtest: sub_test_suite
> >         1..2
> >         ok 1 - test_1
> >         ok 2 test_2
> >     ok 1 - sub_test_suite
> >     ok 2 - test
> > ok 1 - test_suite
> >
> > In the instance that the plan line is missing, the end of the test
> > will be denoted by the final result line containing a description that
> > matches the name of the test given in the subtest header. Note that
> > thus, if the plan line is missing and one of the subtests have a
> > matching name to the test suite this will cause errors.
>=20
> A plan line is required. No special cases are needed. :)
>=20
> If nesting level is lost, a parser will understand the nested test to
> have ended, but probably so did the test runner:
>=20
> TAP version 13
> 1..1
>     TAP version 13
>     1..2
>         TAP version 13
>         1..3
>         ok 1 - test_1
>         ok 2 test_2
>     not ok 1 - sub test unfinished plan
>     ok 2 - test
> not ok 1 - test_suite
>=20
> > Lastly, indentation is also recommended for improved readability.
>=20
> Indentation is _required_. :)
I strongly agree.  You can't disambiguate some outputs, unless the
indentation is present.

>=20
> Whether this is "# " or "  " I don't really care, as long as the change
> is coordinated. "  " is easier for humans to read, but may make parsing o=
f
> "unknown" lines more difficult for machines.
I prefer spaces for human readability.

Just as a side note, in some Fuego tests, it was very useful to include an =
identifier
in thethe prefix nested tests.  The output looked like this:

TAP version 13
1..2
[batch_id 4] TAP version 13
[batch_id 4] 1..2
[batch_id 4] ok 1 - cyclictest with 1000 cycles
[batch_id 4] # problem setting CLOCK_REALTIME
[batch_id 4] not ok 2 - cyclictest with CLOCK_REALTIME
not ok 1 - check realtime
[batch_id 4] TAP version 13
[batch_id 4] 1..1
[batch_id 4] ok 1 - IOZone read/write 4k blocks
ok 2 - check I/O performance

Can I propose that the prefix not be fixed by the spec, but that the spec i=
ndicates that
whatever the prefix is on the TAP version line, that prefix must be used wi=
th the output for
all lines from the test (with the exception of unknown lines)?

>=20
> >
> > Major differences between TAP 14 and KTAP specification
> > -------------------------------------------------------
> >
> > Note that the major differences between TAP 14 and KTAP specification:
> > - yaml and json are not allowed in diagnostic messages
>=20
> Agreed -- these are overkill (and very difficult to implement as they
> _follow_ the test result line: anything generating them has already
> finished running).

I thought that some tests put the diagnostic data before the result line.

I don't care whether it is before or after (and indeed Fuego's parser
can handle either case).  But it can't handle it when some testcases
put diagnostic data before the result line, and some testcases put
it after, in the same test.  There's no delimiter for the separation
between the two different testcases diagnostic data.

Could we possibly have a rule about diagnostic lines positioning relative
to the testcase result line?  Maybe a rule like this:  For a single test,
diagnostic lines should either always preceded the testcase they
are related to, or follow the testcase they are related to.

>=20
> > - TODO directive not allowed
>=20
> I would just say "unrecognized".
>=20
> > - KTAP allows for an arbitrary number of tests to be nested with
> > specified nested test format
>=20
> Yup.
>=20
> >
> > Example of KTAP
> > ---------------
> >
> > KTAP version 1
> > 1..1
> >     # Subtest: test_suite
> >     1..1
> >         # Subtest: sub_test_suite
> >         1..2
> >         ok 1 - test_1
> >         ok 2 test_2
> >     ok 1 - sub_test_suite
> > ok 1 - test_suite
>=20
> For a good example, please include all the possible combinations (SKIP,
> not ok, diagnostics, etc etc)
>=20
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Note on incompatibilities with kselftests
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > To my knowledge, the above specification seems to generally accept the
> > TAP format of many non-nested test results of kselftests.
> >
> > An example of a common kselftests TAP format for non-nested test
> > results that are accepted by the above specification:
> >
> > TAP version 13
> > 1..2
> > # selftests: vDSO: vdso_test_gettimeofday
> > # The time is 1628024856.096879
> > ok 1 selftests: vDSO: vdso_test_gettimeofday
> > # selftests: vDSO: vdso_test_getcpu
> > # Could not find __vdso_getcpu
> > ok 2 selftests: vDSO: vdso_test_getcpu # SKIP
> >
> > However, one major difference noted with kselftests is the use of more
> > directives than the "# SKIP" directive. kselftest also supports XPASS
> > and XFAIL directives. Some additional examples found in kselftests:
> >
> >     not ok 5 selftests: netfilter: nft_concat_range.sh # TIMEOUT 45 sec=
onds
> >
> >     not ok 45 selftests: kvm: kvm_binary_stats_test # exit=3D127
> >
> > Should the specification be expanded to include these directives?
>=20
> Yes. (Though "exit=3D" is a mistake in runner.sh -- this should probably
> be reported without the '#')

Please No!  (Unless I'm misinterpreting that line).

If you remove the '#', that makes the 'exit=3D127' part of the test descrip=
tion.
The test description should be invariant between success and failure cases.
The exit=3D127 (if I'm reading that line right) is part of data explaining =
or
describing the failure. It would be 'exit=3D0' if the test succeeded.

In order to correlate test cases (ie show results over time), the descripti=
on
should not change from one invocation of the test to the next.  At least Fu=
ego
uses the test description this way.  That is, the testcase description is u=
sed as
a testcase identifier, and if it changes from run to run things get confusi=
ng.

>=20
> >
> > However, the general format for kselftests with nested test results
> > seems to differ from the above specification. It seems that a general
> > format for nested tests is as follows:
> >
> > TAP version 13
> > 1..2
> > # selftests: membarrier: membarrier_test_single_thread
> > # TAP version 13
> > # 1..2
> > # ok 1 sys_membarrier available
> > # ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0=
,
> > errno =3D 22. Failed as expected
> > ok 1 selftests: membarrier: membarrier_test_single_thread
> > # selftests: membarrier: membarrier_test_multi_thread
> > # TAP version 13
> > # 1..2
> > # ok 1 sys_membarrier available
> > # ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0=
,
> > errno =3D 22. Failed as expected
> > ok 2 selftests: membarrier: membarrier_test_multi_thread
> >
> > The major differences here, that do not match the above specification,
> > are use of "# " as an indentation and using a TAP version line to
> > denote a new test with subtests rather than the subtest header line
> > described above. If these are widely utilized formats in kselftests,
> > should we include both versions in the specification or should we
> > attempt to agree on a single format for nested tests? I personally
> > believe we should try to agree on a single format for nested tests.
> > This would allow for a cleaner specification of KTAP and would reduce
> > possible confusion.
>=20
> We already use "# " and the nested TAP lines to denote subtests. Without
> a good reason to change it, we should avoid the churn with the existing
> parsers.
>=20
> > =3D=3D=3D=3D
> >
> > So what do people think about the above specification?
> > How should we handle the differences with kselftests?
>=20
> I'm probably a broken record by now, but kselftests _is_ the
> specification. ;) What about it needs changing, and why?
>=20
> > If this specification is accepted, where should the specification be do=
cumented?
>=20
> I imagine some .rst file under Documentation/dev-tools/, linked to from
> kselftest.rst and kunit/...rst
>=20
> --
> Kees Cook
