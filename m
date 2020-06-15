Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC001F9FEB
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 21:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbgFOTHl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 15:07:41 -0400
Received: from mail-bn8nam12on2138.outbound.protection.outlook.com ([40.107.237.138]:15008
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729354AbgFOTHk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 15:07:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYRCgaRe6DxTuulhcXoEM7eXqagEdZx7O8k8LgQ6dxwSVr9qrjeqEtdvcL2cFxFWG3ZE9tX22lFZm03M23T0f66GkXDZ4vZjxzLRnZoswoS2E2bZBQyJCX//5xepIKC3NFP+l3sFjpYEIBZU0xM3HU6sz9mJTRsff4Hbjy5Q9PRvN3stWGU+/whIJeYUds2c0zqMUcROY/A5lL3wSmDEgtx7HYFX2siFKRMWUK3DZgPlwfyH+k6ZYXA+ztRl7AEFSNmyuLVDOrR6daLZw7eVGviYWhaqzczRD1UwbAbqNGfpfVpdqQo2kbL4XmqESFEcFfCV0QhI6dRVwErz2R8YAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVf5Rq/lUUpCd20D16hWV91ADdA8YY5KpmwOookISxw=;
 b=MuSdvL/vA6g8hMQCft3YdB94TeMoxk+us42wlAc+3n9SJJwvvzbLMMB0oO+ZZ1K9mRX5bhoKpJXVo9DrjeakRLnYoRKIcmiXJ4+gD8aIsZYyYRpbqOorVdJ/mJ9ev6gLau7DJLYRxApOSkrSPaiLBkAFAtvgIe2CnoDIUi/NUv75rKfdMaLCsi0PSW+8ON+YCqgGn478474OP7lyeZVKg84jn2x0L7Ep2WzjRTFGhYIXYLlc5EOjqcuGFbsaA5VV0VaE9y4L2yBM+lYHAE+WpmyuBP2hzJWI2zgLTbA7xuQV+0y7fsoQ7Qw3szqWS8+q5OVJ8/ekm77DtzMGjwNHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVf5Rq/lUUpCd20D16hWV91ADdA8YY5KpmwOookISxw=;
 b=Rz3/Hg6MKrzeinjai1XjlLYTs58sHNOVjik6Jjs+xphIEBHjV6Sa0obbl17Tiu5mKY+Mn07i4egV0OCTTOtktZc2/wvJYBEo//3TEMMxfE6HJMxztVenXEOVi+TaOncvzv3/2VqrCwHIUE3j09L2EdaRy3zl1IHKi3wwy2nqhLY=
Received: from CY4PR13MB1175.namprd13.prod.outlook.com (2603:10b6:903:40::23)
 by CY4PR13MB1384.namprd13.prod.outlook.com (2603:10b6:903:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.7; Mon, 15 Jun
 2020 19:07:35 +0000
Received: from CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e]) by CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e%9]) with mapi id 15.20.3109.018; Mon, 15 Jun 2020
 19:07:35 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Kees Cook <keescook@chromium.org>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: RFC - kernel selftest result documentation (KTAP)
Thread-Topic: RFC - kernel selftest result documentation (KTAP)
Thread-Index: AdY/UfZiI2pZQBRwRN+1JBazpeVQogDKTT+AADBmbQA=
Date:   Mon, 15 Jun 2020 19:07:34 +0000
Message-ID: <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook>
In-Reply-To: <202006141120.96FF8C5@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [160.33.195.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67f79e6d-b951-413b-8a55-08d8115f5ce9
x-ms-traffictypediagnostic: CY4PR13MB1384:
x-microsoft-antispam-prvs: <CY4PR13MB1384BFD06A5EBDCBCBE53F7EFD9C0@CY4PR13MB1384.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mi+vQ3qo7hLwECiT0IC7Pa19hrNGvJaF9XfW87BtU56cnJmfcCNXGSV2nKJI+uuGg4PNOInrxU2AqB2VcudbVnbvCe46fBCsuqJkNbxqc7mrzwvJ1ooIjqrzO9AOUejXrqXuB1JHPvTIvLZEIs9D6RbCNJw4BukWThhtv2j0giWIQJ3zffrWiOX3vzV5HccBj9ko4TaWJzOJKkCDHcCCrSSGlykHq51p8X+ZM68tuyMRD7YIbZnxgpyxf233yhYJSV1AGewsEMwPdsU1D0nWxkc202vjE+Gk7VJ2+GS4l0vqZSSpMScUK+kVRAtONkvY4JvJ4C0Q21SZMBRxpy4J3VM9m9T5uxIIg2q9n/k7/DoAuMRDrBwRxyWfdSkq5B70+xvvmLy28vKghnFgOYFecQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR13MB1175.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(83380400001)(54906003)(71200400001)(8936002)(5660300002)(52536014)(186003)(8676002)(30864003)(26005)(316002)(7696005)(478600001)(66476007)(66556008)(6916009)(64756008)(66446008)(33656002)(6506007)(76116006)(66946007)(966005)(2906002)(86362001)(4326008)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: i9zJP3HA8DcgzbevqzmtJzPSYUDOlAMGjTtcZBpVQ1805Yr2nxeq1zDh50vSgZiT9GPtuuLjrcJc/RM0yvr0ORuB+IQ8Za3+myQT+NEGRHHp2mjoAYUvI6wK+udPBHPpMM35LRpeihllb1tnul+DGEWKuwQ7PIReJ6KBIPrreVoqNS8atK4dubICFA1MxtZGz0k2Fh4p2WhPGhk94P66LcRZrBQWeAGy+GV8xt4qt7qC8Mq73PLTKYoLozEFKAWmtKlrxmnJI1xaV3NRJD9hxlBW9cmKaczp0tP5byTb6k6FGGcs6uKazzB4qKE92QiR/2aucyc28keiYr/XRoviFi5ZQOILXuWtLsGqZVAsEZNeIzzASXDrp9/JpafbRbeSpp7YQMsIap4NhHaDVz3Caj1DlayrvME0gRk/FPdmAYL+7sEDz5Mb1x19Q1WNDRQxYXtzx94sCQJTVgV2rlXlhMVDjPvUagIMor7Ar4N+oJA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f79e6d-b951-413b-8a55-08d8115f5ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 19:07:34.9770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfXKBOmBdKkuHrYZSG+BzbALiWeCvm8DoL3pCX1+ULXxdmqJaOfjIThM8eo82zh84r/v56j2cv1HzHh1yCRK3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1384
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees,

Thanks for the great feedback.  See comments inline below.

> -----Original Message-----
> From: Kees Cook <keescook@chromium.org>
>=20
> On Wed, Jun 10, 2020 at 06:11:06PM +0000, Bird, Tim wrote:
> > The kernel test result format consists of 5 major elements,
> > 4 of which are line-based:
> >  * the output version line
> >  * the plan line
>=20
> Note: making the plan line required differs from TAP13 and TAP14. I
> think it's the right choice, but we should be clear.

Noted.  In re-reading my doc, I've conflated my sections.  The first
section is "single-line", and the next section is "optional".  ???
I'll fix that.

With regards to making it optional or not, I don't have a strong
preference.  The extra info seems helpful in some circumstances.
I don't know if it's too onerous to make it a requirement or not.
I'd prefer if it was always there (either at the beginning or the end),
but if there is some situation where it's quite difficult to calculate,
then it would be best not to mandate it. I can't think of any impossible
situations at the moment.

>=20
> >  * one or more test result lines (also called test result lines)
> >  * a possible "Bail out!" line
>=20
> "Bail out!" to be moved to "optional" elements, since it may not appear.
> And we should clarify TAP13 and TAP14's language to say it should only
> appear when the test is aborting without running later tests -- for this
> reason, I think the optional "description" following "Bail out!" should
> be made required. I.e. it must be: "Bail out! $reason"

I'll make sure this is listed as optional.
I like adding a mandatory reason.
>=20
> > optional elements:
> >  * diagnostic data
>=20
> nit: diagnostic lines (not data)
OK.

>=20
> > The 5th element is diagnostic information, which is used to describe
> > items running in the test, and possibly to explain test results.
> > A sample test result is show below:
> >
> > Some other lines may be placed the test harness, and are not emitted
> > by individual test programs:
> >  * one or more test identification lines
> >  * a possible results summary line
> >
> > Here is an example:
> >
> > 	TAP version 13
> > 	1..1
> > 	# selftests: cpufreq: main.sh
> > 	# pid 8101's current affinity mask: fff
> > 	# pid 8101's new affinity mask: 1
> > 	ok 1 selftests: cpufreq: main.sh
>=20
> Nit: for examples, I this should should show more than one test.
> (Preferably, it should show all the possible cases, ok, not ok, SKIP,
> etc.)
Agree.  I will expand this.

>=20
> > The output version line is: "TAP version 13"
> >
> > The test plan is "1..1".
> >
> > Element details
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Output version line
> > -------------------
> > The output version line is always "TAP version 13".
> >
> > Although the kernel test result format has some additions
> > to the TAP13 format, the version line reported by kselftest tests
> > is (currently) always the exact string "TAP version 13"
> >
> > This is always the first line of test output.
> >
> > Test plan line
> > --------------
> > The test plan indicates the number of individual test cases intended to
> > be executed by the test. It always starts with "1.." and is followed
> > by the number of tests cases.  In the example above, 1..1", indicates
> > that this test reports only 1 test case.
> >
> > The test plan line can be placed in two locations:
> >  * the second line of test output, when the number of test cases is kno=
wn
> >    in advance
> >  * as the last line of test output, when the number of test cases is no=
t
> >    known in advance.
> >
> > Most often, the number of test cases is known in advance, and the test =
plan
> > line appears as the second line of test output, immediately following
> > the output version line.  The number of test cases might not be known
> > in advance if the number of tests is calculated from runtime data.
> > In this case, the test plan line is emitted as the last line of test
> > output.
>=20
> "... must be ..." ?
>=20
> >
> > Test result lines
> > -----------------
> > The test output consists of one or more test result lines that indicate
> > the actual results for the test.  These have the format:
> >
> >   <result> <number> <description> [<directive>] [<diagnostic data>]
>=20
> This should be:
>=20
> <result> <number> <description> [# [<directive> ][<diagnostic data>]]
>=20
> >
> > The ''result'' must appear at the start of a line (except for when a
> > test is nested, see below), and must consist of one of the following
> > two phrases:
> >   * ok
> >   * not ok
> >
> > If the test passed, then the result is reported as "ok".  If the test
> > failed, then the result is reported as "not ok".  These must be in
> > lower case, exactly as shown.
> >
> > The ''number'' in the test result line represents the number of the
> > test case being performed by the test program.  This is often used by
> > test harnesses as a unique identifier for each test case.  The test
> > number is a base-10 number, starting with 1.  It should increase by
> > one for each new test result line emitted.  If possible the number
> > for a test case should be kept the same over the lifetime of the test.
> >
> > The ''description'' is a short description of the test case.
> > This can be any string of words, but should avoid using colons (':')
>=20
> Must also avoid "#".
ok.
>=20
> > except as part of a fully qualifed test case name (see below).
>=20
> TAP13/14 makes description optional, are we making it required (I think
> we should). There seems to be a TAP13/14 "convention" of starting
> <description> with "- ", which I'm on the fence about it. It does make
> parsing maybe a little easier.

I would like the description to be required.
I don't have a strong opinion on the dash.  I'm OK with either one (dash
or no dash), but we should make kselftest and KUnit consistent.

>=20
> > Finally, it is possible to use a test directive to indicate another
> > possible outcome for a test: that it was skipped.  To report that
> > a test case was skipped, the result line should start with the
> > result "not ok", and the directive "# SKIP" should be placed after
> > the test description. (Note that this deviates from the TAP13
> > specification).
>=20
> This is what TAP14 changed, I think (i.e. directive follows description
> now).
>=20
> >
> > A test may be skipped for a variety of reasons, ranging for
> > insufficient privileges to missing features or resources required
> > to execute that test case.
> >
> > It is usually helpful if a diagnostic message is emitted to explain
> > the reasons for the skip.  If the message is a single line and is
> > short, the diagnostic message may be placed after the '# SKIP'
> > directive on the same line as the test result.  However, if it is
> > not on the test result line, it should precede the test line (see
> > diagnostic data, next).
> >
> > Diagnostic data
> > ---------------
> > Diagnostic data is text that reports on test conditions or test
> > operations, or that explains test results.  In the kernel test
> > result format, diagnostic data is placed on lines that start with a
> > hash sign, followed by a space ('# ').
> >
> > One special format of diagnostic data is a test identification line,
> > that has the fully qualified name of a test case.  Such a test
> > identification line marks the start of test output for a test case.
> >
> > In the example above, there are three lines that start with '#'
> > which precede the test result line:
> > 	# selftests: cpufreq: main.sh
> > 	# pid 8101's current affinity mask: fff
> > 	# pid 8101's new affinity mask: 1
> > These are used to indicate diagnostic data for the test case
> > 'selftests: cpufreq: main.sh'
> >
> > Material in comments between the identification line and the test
> > result line are diagnostic data that can help to interpret the
> > results of the test.
> >
> > The TAP specification indicates that automated test harnesses may
> > ignore any line that is not one of the mandatory prescribed lines
> > (that is, the output format version line, the plan line, a test
> > result line, or a "Bail out!" line.)
> >
> > Bail out!
> > ---------
> > If a line in the test output starts with 'Bail out!', it indicates
> > that the test was aborted for some reason.  It indicates that
> > the test is unable to proceed, and no additional tests will be
> > performed.
> >
> > This can be used at the very beginning of a test, or anywhere in the
> > middle of the test, to indicate that the test can not continue.
>=20
> I think the required syntax should be:
>=20
> Bail out! <reason>
>=20
> And to make it clear that this is optionally used to indicate an early
> abort. (Though with a leading plan line, a parser should be able to
> determine this on its own.)
>=20
> > --- from here on is not-yet-organized material
> >
> > Tip:
> >  - don't change the test plan based on skipped tests.
> >    - it is better to report that a test case was skipped, than to
> >      not report it
> >    - that is, don't adjust the number of test cases based on skipped
> >      tests
>=20
> Yes, totally.
>=20
> > Other things to mention:
> > TAP13 elements not used:
> >  - yaml for diagnostic messages
> >    - reason: try to keep things line-based, since output from other thi=
ngs
> >    may be interspersed with messages from the test itself
>=20
> Agreed: the yaml extension is not sensible for our use.
>=20
> >  - TODO directive
>=20
> Agreed: SKIP should cover everything TODO does.
>=20
> > KTAP Extensions beyond TAP13:
> >  - nesting
>=20
> (I would call this 'subtests')
Sounds good.  Will do.

>=20
> >    - via indentation
> >      - indentation makes it easier for humans to read
>=20
> And allows for separable parsing of subtests.
Agree.  I'll try to work that into the doc.

>=20
> >  - test identifier
> >     - multiple parts, separated by ':'
>=20
> This is interesting... is the goal to be able to report test status over
> time by name?
Yes.  KernelCI and Fuego have the notions of a testcase namespace
hierarchy.  As the number of tests expands it is helpful to have
the name-space for a sub-test be limited, just like a filesystem hierarchy
provides scope for the names of objects (directories and files) that
it contains.

>=20
> >  - summary lines
> >    - can be skipped by CI systems that do their own calculations
>=20
> Right -- I think per-test summary line should be included for the humans
> reading a single test (which may scroll off the screen).
>=20
> > Other notes:
> >  - automatic assignment of result status based on exit code
>=20
> This is, I think, a matter for the kselftest running infrastructure, not
> the KTAP output?
Agreed.  This doesn't have anything to do with the API between
the tests and the results processor.  I'll take it out.
>=20
> > Tips:
> >  - do NOT describe the result in the test line
> >    - the test case description should be the same whether the test
> >      succeeds or fails
> >    - use diagnostic lines to describe or explain results, if this is
> >      desirable
>=20
> Right.
>=20
> >  - test numbers are considered harmful
> >    - test harnesses should use the test description as the identifier
> >    - test numbers change when testcases are added or removed
> >      - which means that results can't be compared between different
> >        versions of the test
>=20
> Right.
>=20
> >  - recommendations for diagnostic messages:
> >    - reason for failure
> >    - reason for skip
> >    - diagnostic data should always preceding the result line
> >      - problem: harness may emit result before test can do assessment
> >        to determine reason for result
> >      - this is what the kernel uses
>=20
> Right.
>=20
> > Differences between kernel test result format and TAP13:
> >  - in KTAP the "# SKIP" directive is placed after the description on
> >    the test result line
>=20
> Right, this is the same as TAP14, IIRC. KTAP's big deltas are the "#"
> diagnostic lines and the subtest handling.
>=20
> > =3D=3D=3D=3D=3D=3D start of ktap-doc-rfc.txt =3D=3D=3D=3D=3D=3D
> > OK - that's the end of the RFC doc.
> >
> > Here are a few questions:
> >  - is this document desired or not?
>=20
> Yes.
Great.  I'll make this a priority to work on.

>=20
> >     - is it too long or too short?
>=20
> Should be slightly longer: more examples.
>=20
> >  - if the document is desired, where should it be placed?
> >    I assume somewhere under Documentation, and put into
> >    .rst format. Suggestions for a name and location are welcome.
>=20
> Yes Documentation/*.rst Not sure on name yet, but where do kselftest
> docs live? :)
Documentation/dev-tools/kselftest.rst

I'll put this at: Documentation/dev-tools/test-results-format.rst

>=20
> >  - is this document accurate?
> >    I think KUNIT does a few things differently than this description.
>=20
> Let's fix it. :)
>=20
> >    - is the intent to have kunit and kselftest have the same output for=
mat?
> >       if so, then these should be rationalized.
>=20
> Yes please.
>=20
> > Finally,
> >   - Should a SKIP result be 'ok' (TAP13 spec) or 'not ok' (current ksel=
ftest practice)?
> > See https://testanything.org/tap-version-13-specification.html
>=20
> Oh! I totally missed this. Uhm. I think "not ok" makes sense to me "it
> did not run successfully". ... but ... Uhhh ... how do XFAIL and SKIP
> relate? Neither SKIP nor XFAIL count toward failure, though, so both
> should be "ok"? I guess we should change it to "ok".

I have the same initial impression.  In my mind, a skip is "not ok", since
the test didn't run. However, a SKIP and should be treated differently
from either "ok" or "not ok" by the results interpreter, so I don't think i=
t
matters.  Originally I was averse to changing the SKIP result to "ok"
(as suggested by Paulo Bonzini [1]), but I checked and it's pretty trivial =
to
change the parser in Fuego, and it would make the kernel results format
match the TAP13 spec.  I don't see a strong reason for us to be different
from TAP13 here.

I raised this issue on our automated testing conference call last week
(which includes people from the CKI, Fuego, KernelCI and LKFT projects), an=
d
so people should be chiming in if their parser will have a problem with thi=
s change.)

[1]  https://lkml.kernel.org/lkml/20200610154447.15826-1-pbonzini@redhat.co=
m/T/

Thanks very much for the feedback.
 -- Tim

