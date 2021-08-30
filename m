Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854163FBEAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Aug 2021 00:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhH3WFg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Aug 2021 18:05:36 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:14462 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229887AbhH3WFf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Aug 2021 18:05:35 -0400
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17UK1Yji013274;
        Mon, 30 Aug 2021 22:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=p5FESTLXFKatQHDdp4PK5y9h5wVtRgxO6ASVmNEZJWk=;
 b=dLJrm7C/Xts8RIcETLUahcUo8rbu9CwVQHRN9j96YeAYbWYbjnxb+gwXo7hXwgUujsri
 E8WAynA3c/FGkGPlb1j/2RcL9PYYWxbuUQQfREGOb7D6CQKlYfsyyWJbsLHD+9oIyAyD
 bKGEpWmjgSG7z+XQPl8bRoff2/2ub8Y+G4YG8YNQdJk7Qz1EbvmgxNuHF27+OIoKdtb2
 hgp+Pyxyh+Nf2PiFI8Np6owQcUQcP8Qks20tFgFE98cVTg7HzA7GXsyLOISJdbGkQ+17
 ESp+ZwhexmQ6yHzrNpsbG0fcrj/6ixJnPxL9knsxT9R+vNvXltw3Gtq2Vca3zYN9vmIt 1w== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx08-001d1705.pphosted.com with ESMTP id 3aqfcxtsx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 22:04:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlSHnF1KlG5RPK0u1tS1vk3HgNf5MNprG+EbcPY9mqh+evJjAl/xkajc3W1cKvLOlQF43X+b9k0+f1TJsrIesRQWBSUJwqGGDUdkv+Dyhgrr4hyaSaw2jYG3K2rel6WGjrkqYpbg1KZAfzwSAMuZeBM0zQCClHSJ1xMM3QK1O4vkHF47YI1mqMF6JLNAOPaX47PbfXK+mXjjD06VuMo3nji87YtNNDsobKx6LojYDuyytK67VizaWfp7PaGDVvESyDTmeEK4nOLs4x1KOIELcFcifVF1saUJ1yyK0VukXSb7BwbI3Z0M36IFjvlMbAJvTc5qC936VKFReoD6VGzvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=p5FESTLXFKatQHDdp4PK5y9h5wVtRgxO6ASVmNEZJWk=;
 b=NU7wOuDR6ZhJbx4b7GxVZBE4GKRReMLH4lGAd/3CSNhZAZla5eL39GQ06fvDt+NdeVytT7QaF2wLQ0pWnjEWvgMNDm+N9GhDStRTu6WGqkxelTNV5RpPrrU+FiC4WVAZcz7oyRu0b5aX2nlgRltPLwMlJfzeXm2C8ebYPjPFnU0xnLkJW5Kr5CqdqrSBk9SVzbYiFglr+2NRu7RkK1IXe0NzzsxkJaJ1jEUH/GM4klmrok5e6nVwQnm6teY7/V/F2Jr0n0PVdpAMMRnZP/0Bn64w2zq14actR7wb3ZZ6ZbjvgpjIhLNMQxXM7dvE2dRn2Zdele9k13L2Rt0Jznk7+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by BY5PR13MB4372.namprd13.prod.outlook.com (2603:10b6:a03:1f5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.14; Mon, 30 Aug
 2021 22:04:24 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::5190:4162:72e8:7998]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::5190:4162:72e8:7998%7]) with mapi id 15.20.4478.017; Mon, 30 Aug 2021
 22:04:24 +0000
From:   <Tim.Bird@sony.com>
To:     <keescook@chromium.org>
CC:     <rmoar@google.com>, <brendanhiggins@google.com>,
        <davidgow@google.com>, <shuah@kernel.org>, <dlatypov@google.com>,
        <kunit-dev@googlegroups.com>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernelci@groups.io>,
        <guillaume.tucker@collabora.com>
Subject: RE: RFC - kernel test result specification (KTAP)
Thread-Topic: RFC - kernel test result specification (KTAP)
Thread-Index: AQHXjj7+R2tK76sch0Cg3jcbmYTJxauIrqsAgAOyNyCAADVlAIAAFh+g
Date:   Mon, 30 Aug 2021 22:04:24 +0000
Message-ID: <BYAPR13MB25037E7EE38DE8717DC7D254FDCB9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com>
 <202108272330.AE55FCD@keescook>
 <BYAPR13MB2503A4B79074D8ED5579345DFDCB9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <202108301226.800F3D6D4@keescook>
In-Reply-To: <202108301226.800F3D6D4@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=sony.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb8a9f77-95d1-4e2a-ebec-08d96c0220e2
x-ms-traffictypediagnostic: BY5PR13MB4372:
x-microsoft-antispam-prvs: <BY5PR13MB43722411E741E1B693C3DC2FFDCB9@BY5PR13MB4372.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ByEkOPCUUJnDx3xb+LAEKugZA6rmUVTOwDCRT43xkp3oV2Tq0ZdLM7BUF0najsou7LUYi0+guOEzWnU8R/WB8l2SGPI3t6T61qvxCgoOpYeUoxqJ+blU2EdVkJ/r6V3FfKXAfYDAtd6VfZafiG4c9LX2Bi1Htim2Knd8HI3RS3ntY0zmAltdZ3LofECni9NmmSV+2jg+4E91xxeVrW0TLhauG2VjsLpQqJ0P9iWT+yeBAZjpf3RhWZd8XU652I3Tr9LPVDWmUJGdFj9X0+8fVsgPvqji/JWchV2Kq8RUZxUWiUxiDSOLR/G+t90KBcWK8nlWGvGCKIslCuUgPatY8MJSHEMROOJq/tRwvGNwXuz/AIvKZFwUTIDmab3+f97ovFbT5kHbYoPeMrAUNT6YbUGXj1i6M1wPpLtNWMqO6kxAIvM5ElJZPYI/XonbytCiuCqwgF55xXkw+5fGSTK7NUG14WotgnwVNmpBAzR3ck7WACddMMEu7IMUgwcQnTTB9/FqaZ64r+Q4j4fB8zTrhN/7rsdUULe9gosKHPxaVM2RcLiopKwgJWqlsJ9g2oeEF0IOP1A0QaAcgCls/TfsmhPGrVfjANovSyEfHBRgkUwpr2pEVlBurjE9MbGHCnrbGgxqb+2X8Mc3PJMAH7h9Cld34uLi3umn29txkKPgzxFWxMn41Jg1Rkyf/W5ah92F4x3w0vCasWwTKO01iSqqQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(71200400001)(4326008)(9686003)(54906003)(478600001)(55016002)(30864003)(76116006)(6916009)(83380400001)(38070700005)(33656002)(52536014)(66476007)(66556008)(86362001)(66446008)(122000001)(186003)(8676002)(38100700002)(26005)(8936002)(316002)(5660300002)(7696005)(66946007)(6506007)(2906002)(7416002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nsjvydyXoK9m3mJA4aSgEdb7ZsUOqMAs4fWBxzfEO7wXdP8PbPcmBYm4zAJp?=
 =?us-ascii?Q?wrZe42PMPcKTiAClbGEFs4AksO1Bf0vmOGSC8bqU86wkav64keFo0wU2+5KA?=
 =?us-ascii?Q?Ni0l0j5zcnAUQuZR7avzoxLIW9vUq6HECe7VAZgKfFdiGO/Xrog+1xM/gtGS?=
 =?us-ascii?Q?exeOkPyVTTgwWRXXyl/S9HHmad2QYojNoLd1tuIXtjimTkfynE2EvOlMc/kJ?=
 =?us-ascii?Q?kqScxj7mo/wxG4ND3c4w9pq47ol6ehI7vcETVjoeGkCAOzC1QsEyefjEdWP9?=
 =?us-ascii?Q?eKS6OyVq+ddyCNOawIOS2HWrjKK+rqHyW1VliuazJwZiQboSDJWpJEJ6yT6I?=
 =?us-ascii?Q?Ie4tXnAkYmDgh8ZxOFhnd9cQf/6Z+wSHLKAKUgPNnhw/985ife1OAwqzhEyB?=
 =?us-ascii?Q?zncinL5lTePi5SSTobwtZJ0/tSQEDvLorfq+dnA5/roi4J1mdLuio3Ew7Qfh?=
 =?us-ascii?Q?ynig1XOWGUv/SlkFKoGRNqG1m1uA2OYtNtks5O4ty3qCoPo6ebjtf/eaCbrt?=
 =?us-ascii?Q?ROvn+/WRqlAFxHxA1QclOk/mDbvVpA3ZocPPGs55dZkCvS7ZCybfysFKCqfj?=
 =?us-ascii?Q?15cfhyqfTu047diLay6rMie6ZAvYx76cEh5c4YP2iwuqP5oY00kVHD0yiRwX?=
 =?us-ascii?Q?4pht+TLPYcVNVphHu2wUec3iLI8NMQmww05eYHLEL9WnuJZW0yxo1xPt9Zxx?=
 =?us-ascii?Q?iaFJF/AiVYAlqs95PbqEc2OtXnGvOk+ZaElotMoJ0SqZ0W4b8/wnKOxD8SXe?=
 =?us-ascii?Q?2cXluh8nVI6nW7Xhy1e0/XYCL+21udjD5UDGnn/jyr3owk+DJwKarUmDvrFi?=
 =?us-ascii?Q?n9MkA5boQTWin8BXbeczevknbwtHDlxDyi0dCI1VW5DPbdHIkXwx05gQSJNo?=
 =?us-ascii?Q?OuyDk44vMP1pEz6IYH65vUunUS42iPYOa5yuJoqMcHJ3OyURnkK1o+65HZt6?=
 =?us-ascii?Q?NZAda7lljxDPDponkUYzBdApXBE7UPKxO7NuXFAZbclo0bc1r+K0hRRlGTiz?=
 =?us-ascii?Q?Va+Eqtx/0w0U8XssqVRG+oFF643gnht6+AWe7eODZ/y7kJo4Nm4N/HKqZn2k?=
 =?us-ascii?Q?+A/8ieek3WJiTbRVYNvaPrxyXcchoeh7Lohol/jLigfFFa5WhLFENM/6rDnx?=
 =?us-ascii?Q?Wbeeo4dQYmYECsJwAnifXbT3Kdy6cWEtiwgpZVSinQkLMHaeSCw6xxi7Hode?=
 =?us-ascii?Q?LV/HEQzb+6oVq/lQpsfh9K6K/oxfnkViyZf3vIxItUGo3igl/r/HCgJJGM74?=
 =?us-ascii?Q?Z1aantItRiFbynsPHP74kxQuRly9yz0+Jnajm0pOfWJA+oF+J67RhrwDDmGF?=
 =?us-ascii?Q?3gbaVeDiC5h/CBNgxjgHWBWV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8a9f77-95d1-4e2a-ebec-08d96c0220e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 22:04:24.5403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCfr0PG7QbTaX/0GEakSnPOQYVb8tG0aNwkYqXJ10m0Hgc6LS/43RldBDpRYzndffqnUXVK4UXnYiJvyg4/mFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4372
X-Proofpoint-GUID: HKF6VR0xRMS9ldsHmbpn3g-k6zwKxCJq
X-Proofpoint-ORIG-GUID: HKF6VR0xRMS9ldsHmbpn3g-k6zwKxCJq
X-Sony-Outbound-GUID: HKF6VR0xRMS9ldsHmbpn3g-k6zwKxCJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-30_06,2021-08-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300139
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Kees Cook <keescook@chromium.org>
>=20
> On Mon, Aug 30, 2021 at 05:48:07PM +0000, Tim.Bird@sony.com wrote:
> > From: Kees Cook <keescook@chromium.org>
> > > > Test case result lines
> > > > ----------------------
> > > >
> > > > Test case result lines must have the format:
> > > >
> > > >     <result> <number> [-] [<description>] [<directive>] [<diagnosti=
c data>]
> > >
> > > "[<diagnostic data>]" is not defined below. I think what you mean is
> > > "directive details".
> >
> > IMHO it's useful to keep this called 'diagnostic data'.
> >
> > The directive is optional, and having this be diagnostic data means you=
 can
> > put explanatory text, or result details, that are independent of the de=
scription,
> > on the same line as the result.  This is convenient in some cases.
> >
> > I think diagnostic data should always be prefixed by a hash sign.
> > Or, in the case where diagnostic data appears on the result line,
> > the hash serves as the delimiter.  This means that the description
> > text must not include a hash character.
> >
> > For example:
> > ok 5 - check return code # rcode=3D0
> > or
> > not ok 5 - check return code # rcode=3D17
>=20
> The directive is currently used to answer the question "why?" as in,
> "why is this test not ok?" ("a timeout occurred") or "why is this test
> ok?" ("a SKIP")
>=20
> The "supporting evidence" for the "why?" answer are specific details
> about that: "the exit was was NNN" or "the timeout was YYY seconds".
>=20
> Test diagnostics are all the lines preceding that (currently prefixed
> with a "#").
>=20
> > > Yes, though the optional "- " is strictly part of the optional
> > > description.
> >
> > It's mildly annoying that "-" is optional.  It's trivial to deal with i=
n the parser
> > to just ignore it if it's present.  But it has no semantic meaning what=
soever.
> > IMHO it would be nice to either mandate it or remove it, for consistenc=
y's sake.
> > This could be based solely on the consensus for whether it added or det=
racted
> > from human readability, since parsers don't care.
>=20
> I have no strong opinion on the "-". I was surprised to encounter it
> as it's not part of the TAP 13 spec. I would prefer to drop it, if I had
> to choose.
>=20
> > ERROR usually means that there was some kind of failure
> > in the testing process that makes the testcase result indeterminate.
> > (like loss of connection to a server, or crash of the program executing
> > the testcase).  This can be due to a bug in the test or the test system=
.
> > I'm, not sure if ERROR is used this way in kselftest.  It is, IMHO, a u=
seful
> > distinction to make.  TIMEOUT is a special case of ERROR, IMHO.
>=20
> Well, I think TIMEOUT is a "why not ok?" answer. "not ok" seems to be
> the same as ERROR, but I guess it's really a catch-all, but must come
> with the "evidence" portion:

'not ok' should not mean the same thing as ERROR.  'not ok' means the=20
testcase was run successfully, and the result is that the test determined
that the testcase failed.  ERROR means that the testcase was not
run successfully, so no result can be assumed.

But ERROR is confusing.  Maybe there's a better word for the concept
that is less likely to be conflated with the result.

>=20
> not ok 1 description goes here # TIMEOUT 45 seconds with no results
> not ok 1 description goes here # ERROR lost connection to server
> not ok 1 description goes here # ERROR non-zero exit code: NNN
>=20
> I might go so far as to say the directive is _required_ for the "not ok"
> state.
As I said above, I don't think they are the same.  I would reserve
ERROR for the case where a test error occurred and the test case
result could not be obtained.

If we go to the trouble of making our own spec, maybe it would
be better to support a third result value: 'unknown'.  This would
break all the TAP parsers, but it's much clearer, IMHO.

'ok 1 description' =3D test case executed successfully, and the testcase co=
ndition passed
'not ok 1 description' =3D test case executed successfully, and the testcas=
e condition failed
'unknown 1 description # SKIP # reason' =3D test case does not apply for so=
me reason
'unknown 1 description # ERROR # reason' =3D test case could not be execute=
d, for some reason

In the case of SKIP and ERROR, the result should be ignored as it is either=
 inapplicable
or wasn't obtained.

I remember we had a discussion about whether SKIP should have an "ok" or "n=
ot ok"
result.  IMHO it doesn't matter, because the result has no meaning when a S=
KIP directive
is used.  (Although it's useful for humans to see why something was skipped=
.)

>=20
> > As an aside, I've never liked XFAIL or XPASS.  Semantically, I believe =
they
> > are quite confusing, and depend on the level of testcase execution.  XP=
ASS is also
> > redundant.  Isn't the default case always XPASS?
>=20
> Nothing currently uses XPASS, and we should remove it.
>=20
> XFAIL capture the condition of the test logic in that a test for
> something arm64-specific on a non-arm64 machine is _not_ a "pass". It
> will fail. But it's an expected failure. And, as a directive, must come
> with the evidence bit:
>=20
> not ok 1 PAN catches bad accessg # XFAIL PAN CPU feature is arm64 only
>=20
> As a test author, I want to see this as distinct from failure and
> success.
I agree that this case is different from a normal failure.

In the example you provide of a feature that applies to only specific
architectures, I would use a SKIP instead.  It's not that the testcase fail=
ed.
It's that it does not even make sense for the device under test.

Whether something is 1) a testcase failure or 2) a testcase that does not
apply is a matter of perspective.  Is it the case that the feature should  =
exist
on all architectures,  and it's just not been written yet?  I could call th=
is a
'not ok' or an XFAIL. However, if it's a feature that is never intended to =
be
written for arm32 or i386,  I would report that as a SKIP.

But all of this differs from what I originally described, which is labs usi=
ng
XFAIL to annotate bugs that they knew about but didn't intend to fix.

>=20
> > In the case of XFAIL, does it mean that an operation that was expected =
to fail
> > all the time, failed, and so the test passed?  Or does it mean that thi=
s is a known
> > bug that a particular developer or site has decided to ignore (as in "w=
e know this
> > is a bug, but we expected it to fail, so just ignore it for now).  The =
latter, I really
> > don't think should be encoded in the tests themselves, but should be pu=
t
> > into a layer above the test and parser, that is applied according to de=
veloper
> > or testlab policy.
>=20
> I agree that "just ignore it for now" shouldn't be there.
>=20
> Other arguments are that xfail tests shouldn't be run at all, but I
> don't think that's right because it makes it very hard to do large-scale
> test result comparisons because random stuff is missing, depending on
> various configs, archs, etc. It blocks a 1-to-1 comparison, and begs
> questions like "why is the test here in one case and not in another?"
I completely agree with this.  It really messes up tables of results when
the list of testcases varies depending on some board
or configuration attribute.  It's very hard for users to parse and compare
results in that case.

> where as an XFAIL will encode the reason it is an XFAIL in its output,
> providing a self-documenting test result.


>=20
> > > I still think there should be a distinction between "diagnostic lines=
"
> > > and "unknown lines". For example, if kselftest is running on a consol=
e,
> > > the dmesg output may be intermixed, and possibly temporally offset. S=
uch
> > > lines may not be useful, and may not be strictly correlated, where-as
> > > the output from kselftest is at least self-consistent.
> >
> > I think this would be a very good distinction to make.  You might have
> > unknown lines that (inadvertently?) start with a hash, but trying to
> > make sure that the test itself always outputs diagnostic data with a pr=
eceding
> > hash gives a reader potentially more information about where the messag=
e
> > came from, and could be useful.
>=20
> Right, so lines with a hash shouldn't be machine-parsed. (And this is a
> mistake I made in the current kselftest output for the LAVA parser.) The
> good news for the kernel, is that nothing else in dmesg leads with a
> "#" currently. :)

Oh. That's actually nice to know.  Interesting.

>=20
> > > No; diagnostic lines must have no meaning: they are for humans and no=
thing
> > > else. If other details are needed for machines, we should explicitly
> > > create new format lines. I made a mistake when I used a diagnostic li=
ne
> > > for embedding the test names. :( There is a need for parsers to disco=
ver
> > > the name of a given test, though, so we do likely need something for =
this.
> >
> > I agree it is handy to have the test name for sub-tests.  However, I do=
n't
> > see any semantic difference whether we define sub-test declarations via
> > diagnostic lines with special syntax or by creating a new syntax separa=
te
> > from diagnostic lines.  Either way, we have a new syntax for parsers to
> > understand.
>=20
> Pragmatically, I agree, which is what lead me to my mistake. However, in
> reconsidering it, I realize this leads to a slippery slope of just
> dumping stuff into diagnostic lines and pretending nothing will read it.

Good point.  Whether it starts with a hash or not, TAP 13 parsers should
ignore anything that is not a result line (starts with 'ok' or 'not ok').
So I guess we are free to make a new syntax without upsetting any existing
parsers.

>=20
> I suspect what we need is an optional "starting test" line, like:
>=20
> test N DESC
> # diag...
> # diag...
> # diag...
> ok N
>=20
> The nesting looks like:
>=20
> TAP version 13
> 1..3
> test 1 seccomp
> # TAP version 13
> # 1..27
> # test 1 prctl
> # ok 1
> # test 2 strict
> # ok 2
> # ...
> # test 27 user_notif
> # # eek missing CONFIG_....
> # not ok 27 user_notif # ERROR can't use ioctl
> not ok 1 seccomp # ERROR non-zero exit code 1
> test 2 netfilter
> ok 2 netfilter
> test 3 bpf
> # exciting things happen
> ok 3 bpf
>=20
> This is what we have now except basically just replacing "# $name" with
> "test $num $name"
>=20
Actually, I like this idea.  Including the number is a nice touch.
I think that will help to distinguish such a line from other 'unknown line'=
 output.
I don't know if I'd leave the description off of the result line, though.=20
A lot of parsers are looking for that.

> > >
> > > > Diagnostic lines of the format "# Subtest:
> > > > <test_name>" indicate the start of a test with subtests. Also,
> > > > diagnostic lines of the format "# <test_name>: <description>" refer=
 to
> > > > a specific test and tend to occur before the test result line of th=
at
> > > > test but are optional.
> > >
> > > I don't think the above should be included in the spec -- diag lines
> > > should have no parseable meaning.
> > >
> > > >
> > > > Bail out line
> > > > -------------
> > > >
> > > > A bail out line can occur anywhere in the KTAP output and will
> > > > indicate that a test has crashed. The format of a bail out line is
> > > > "Bail out! [<description>]",  where the description can give
> > > > information on why the bail out occurred and can be any string.
> > >
> > > I'm not a fan of the Bail out line. It's not a problem, exactly, but =
I
> > > find it redundant. If we want an "end of test" line, let's make one.
> > > "Bail out" is a special case of exit. If we want to handle test exit,
> > > let's define it. E.g. make kselftest's test summary lines not
> > > diagnostic lines:
> > >
> > > # FAILED: 85 / 87 tests passed.
> > > # Totals: pass:83 fail:2 xfail:0 xpass:0 skip:2 error:0
> >
> > How consistent is it for selftests to produce test summary lines?
>=20
> Any of the tools built with kselftest.h will spit it out. (Which is to
> say several of the "subtests".) The bulk of kselftest output is from the
> runner, which doesn't produce this summary.
>=20
> > > Please no. There is no reason to force a nested test to suddenly have
> > > to know about its test execution depth/environment. A subtest is just=
 a
> > > nested TAP result. That it is nested is only meaningful to the parser=
, not
> > > the executing test, and it must have the same output, nested or not. =
(e.g.
> > > running the test alone or running the test under a full kselftest run=
,
> > > the only difference is the indentation level.)
> > I agree that the sub-test should not know about this line.  I thought
> > the "parent" test wrote the line.
>=20
> The suggestion was that the subtest should _not_ emit the "TAP" line,
> which is what I strongly disagree with: it should be a self-contained
> TAP-emitting test.

OK - agreed.  Yes.  The sub-test should not know whether they are running
standalone or nested (with the exception of some line prefix opaquely conve=
yed
to them)

>=20
> > > Again, I see only downsides to this. Nesting for the spec is simple
> > > indentation-based recursion. Let's just keep what we already have:
> > >
> > > TAP version 13
> > > 1..1
> > > # TAP version 13
> > > # 1..2
> > > # ok 1 - test_1
> > > # ok 2 - test_2
> > > ok 1 - test_suite
> >
> > I prefer spaces, but whatever.  Is the prefix on the 'TAP version 13' l=
ine guaranteed
> > to be the prefix on all lines for the (sub-)test?
>=20
> That's the current implementation, yes.
>=20
> As for tabs vs spaces, I think it's fine to swap "# " for "  ". We just
> need to patch LAVA to deal with it.
>=20
> > Just as a side note, in some Fuego tests, it was very useful to include=
 an identifier
> > in thethe prefix nested tests.  The output looked like this:
> >
> > TAP version 13
> > 1..2
> > [batch_id 4] TAP version 13
> > [batch_id 4] 1..2
> > [batch_id 4] ok 1 - cyclictest with 1000 cycles
> > [batch_id 4] # problem setting CLOCK_REALTIME
> > [batch_id 4] not ok 2 - cyclictest with CLOCK_REALTIME
> > not ok 1 - check realtime
> > [batch_id 4] TAP version 13
> > [batch_id 4] 1..1
> > [batch_id 4] ok 1 - IOZone read/write 4k blocks
> > ok 2 - check I/O performance
> >
> > Can I propose that the prefix not be fixed by the spec, but that the sp=
ec indicates that
> > whatever the prefix is on the TAP version line, that prefix must be use=
d with the output for
> > all lines from the test (with the exception of unknown lines)?
>=20
> Oh, interesting. This would also allow parallel (unique) test execution
> to be parsable. That sounds workable. (Again, this needs LAVA patching
> again...)
>=20
> > > > Major differences between TAP 14 and KTAP specification
> > > > -------------------------------------------------------
> > > >
> > > > Note that the major differences between TAP 14 and KTAP specificati=
on:
> > > > - yaml and json are not allowed in diagnostic messages
> > >
> > > Agreed -- these are overkill (and very difficult to implement as they
> > > _follow_ the test result line: anything generating them has already
> > > finished running).
> >
> > I thought that some tests put the diagnostic data before the result lin=
e.
> >
> > I don't care whether it is before or after (and indeed Fuego's parser
> > can handle either case).  But it can't handle it when some testcases
> > put diagnostic data before the result line, and some testcases put
> > it after, in the same test.  There's no delimiter for the separation
> > between the two different testcases diagnostic data.
>=20
> Right. The current implementation puts it always before. TAP 13 (14?) has
> the YAML _after_ the results line, but that's totally unworkable for
> kselftest, which is designed to be first human readable and second machin=
e
> readable. Waiting to see diagnostics from a slow test is terrible --
> we can't collect it and spit it out later. Also, a parser would have
> no idea about when a test is finished if diagnostics follow the last
> test result of a plan.
>=20
> Making it "always before" is fine by me, and the motivation for making
> the "summary" lines be non-diagnostics because they technically followed
> the last test result.
>=20
> > Could we possibly have a rule about diagnostic lines positioning relati=
ve
> > to the testcase result line?  Maybe a rule like this:  For a single tes=
t,
> > diagnostic lines should either always preceded the testcase they
> > are related to, or follow the testcase they are related to.
>=20
> For the kernel, I would rather avoid anything after because that just
> confuses things.
>=20
> > > Yes. (Though "exit=3D" is a mistake in runner.sh -- this should proba=
bly
> > > be reported without the '#')
> >
> > Please No!  (Unless I'm misinterpreting that line).
> >
> > If you remove the '#', that makes the 'exit=3D127' part of the test des=
cription.
> > The test description should be invariant between success and failure ca=
ses.
> > The exit=3D127 (if I'm reading that line right) is part of data explain=
ing or
> > describing the failure. It would be 'exit=3D0' if the test succeeded.
> >
> > In order to correlate test cases (ie show results over time), the descr=
iption
> > should not change from one invocation of the test to the next.  At leas=
t Fuego
> > uses the test description this way.  That is, the testcase description =
is used as
> > a testcase identifier, and if it changes from run to run things get con=
fusing.
>=20
> Agreed, I think it should be part of an ERROR directive:
>=20
> not ok 14 awesome test # ERROR exit=3D127

As long as the line above means that testcase '14 awesome test' could not b=
e
run, and exit=3D127 helps diagnose that, then I agree.  If 'exit=3D127' mea=
ns that
testcase '14 awesome test' was run and exit=3D127 was a failing result, I w=
ould
say that the result line should just be:
not ok 14 awesome test # exit=3D127

  -- Tim Bird

