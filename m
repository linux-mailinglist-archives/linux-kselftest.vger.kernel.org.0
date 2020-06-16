Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B731FC0D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 23:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFPVQG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 17:16:06 -0400
Received: from mail-co1nam11on2123.outbound.protection.outlook.com ([40.107.220.123]:2145
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725967AbgFPVQF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 17:16:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKl7YAV8iM1CACLBHLrpoW7S7tArF7ND9Iwm7NqROwync66KYl1pmz5jdbst24deB8xWCFUt5TmzEXQBaZlgANeYnj5Z7xqj78egikbdDPm85Vd6joxHhKa9q1gKu/ApL0en5BXCtb7o9UxQZqITv2RiOYGklFgr0jy85wKfSTJpmzuQcO1rsdnmVuwpnqsOhhRMBAoiTHxvyPoYY4e9HnE8tekvMPzjkb/jkhEEgoPEVy7rekzX4qAGFn4y57kQeF4mn0khwJRJtr3moO50Tq5vRCELsaVoqtVF/yizxPazVVTN3a+2gSUV/wkoiJP1NtmAHVHhgaySLsR+7WzDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JYOTXhmiwBRaoPZGlE0Xl+8SUnz3YSYRb+XpCJFItg=;
 b=iofl0HPX2TPMKzqph0w+y30DZttN+XYyzLW3CiqsEN00xJIFgVFHFgLgBCwDjyqZ8QeCMPA6vOJJkhXq/m2qmBmdi9KowkKcSaj4WqLjIgfgjm1mOfZw3w7Fd/48fj7rCJtsi6q1NSzaLeg5NKIW9aSYuTjhKkXz91tykMVCNDC6P1QnAnWGkDf/V/yI7Sf+et+mxvzOWBVeSVwRlbiaXUY8qVVKum++bXVjKiMBKgAr8+8/CKAnSQuaZB/WPLGWrhZ/Xh+45sS/C71goC+xXxm7GeKVuNgmIU3vslBHd/pmXYbMZ6jlNxVUnBTmc/bli8BAmI6+jCV4k0qeF8/IsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JYOTXhmiwBRaoPZGlE0Xl+8SUnz3YSYRb+XpCJFItg=;
 b=hQ0z8oPPQW+cxBrJMEEsIWPY1lBBmQ33hsp/K8BD7GeaElwDTknEtOp+S2rvT8hQ0RLpfJpymjlTPR0vhV/5fEfcPHdg3ELcSO1D3O0oZ7aFPgtfitlSyO5Gu2Mjfm1iQgKcnhcAMRTJmhSSAbt3IL0lpp8Z6CP+H9z18DZ1DQs=
Received: from CY4PR13MB1175.namprd13.prod.outlook.com (2603:10b6:903:40::23)
 by CY4PR1301MB2199.namprd13.prod.outlook.com (2603:10b6:910:41::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.13; Tue, 16 Jun
 2020 21:16:01 +0000
Received: from CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e]) by CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e%9]) with mapi id 15.20.3109.018; Tue, 16 Jun 2020
 21:16:01 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Brendan Higgins <brendanhiggins@google.com>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Gow <davidgow@google.com>
Subject: RE: RFC - kernel selftest result documentation (KTAP)
Thread-Topic: RFC - kernel selftest result documentation (KTAP)
Thread-Index: AdY/UfZiI2pZQBRwRN+1JBazpeVQogEzX+2AAAAmIWA=
Date:   Tue, 16 Jun 2020 21:16:01 +0000
Message-ID: <CY4PR13MB1175A71AE3937C0786721ABFFD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200616204817.GA212825@google.com>
In-Reply-To: <20200616204817.GA212825@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [160.33.195.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f42817d-d409-4491-0379-08d8123a78e3
x-ms-traffictypediagnostic: CY4PR1301MB2199:
x-microsoft-antispam-prvs: <CY4PR1301MB2199FD2F0C18ABC2BDE00C0BFD9D0@CY4PR1301MB2199.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NeXCL44s+3ueeVSb3Z/G8RfUUDbCUdNd+yoIOR2fBO4B7H/cotkjju/WSZD7zjI1oH5t9p8CmK7DE2/glUKTDPKOuMrMM0lZL+XN2nsbMyI8uYB1FIHrPIBGoVZjsWJPapmiL7tsHsiQAkbQpGe6EkWVYFT9znyW3jZJmD1cUmEtT8DTxJhju5qQzu6kWlok/1BbSlrw+RHsrDFXNtFAAzSbwIQ2V1RhPJTteAwbNtFnQoJ4iu/ZADN/MyuWHO/BWnn1RcaP8h1UZL6g6xrC5IRM9YkTA3WtH5qie4iCvRjmFr8+1gdMau2qx9Kus8+JwmoGuKCOQMjidCVwVmZtcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR13MB1175.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(478600001)(55016002)(9686003)(186003)(26005)(6916009)(33656002)(8936002)(83380400001)(86362001)(8676002)(7696005)(6506007)(316002)(2906002)(54906003)(5660300002)(66556008)(71200400001)(52536014)(4326008)(66446008)(76116006)(66946007)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: glMaeGajcOOP0hjxiA1j5H+fzbuo0I+VYkNryMXRQy2G+oJXSpWGj0XD6Ult7JsHb5ljAyznwxCg4jFD3J5toCL0N1XWWedj0JN4INj3yCm6hy499ky4+xtb2vnUZRn6vxHHext56WIi8wLhwwXgn8is+kjOyct1P6ANrVOa/bAfhVIc+h1WFS2evj1owuzMpvb0QjCtBNNHJZ4tKg3pLVVB3SsOZQ5XFxI3mBeAnKV/NWplCj6jzZe18JctOHCD43qnGb4wfXwhJFtyJ67p9IvViNructSkYT4r31reBg+wCq82Hocx/ILlsIkqkvnnUqy9nW+jDTO6i9XDBHLoEGkL0+l/4xUiGVALj7tFffHIgLWejJhkRIWm2tMDFqOTM16ypDNSfU9bOsj4/n3rp1udPTbe8+tzOP0C+k1r42DJGnUCAy+jnmK4XI1JJYNFXJ7MXbRXGe0Xlq++gPBLKxMjkZ5YX0G7+vgQEJ+QNuY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f42817d-d409-4491-0379-08d8123a78e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 21:16:01.7542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUgqFbe4Gyx0fNyQT1XqzkYr7d4qTk1YFH8yfn5H9pWrnxzOlaDyqgh5wZCkKwaICFYDFCY1oCyURb+nJm8t8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB2199
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Brendan Higgins
>=20
> On Wed, Jun 10, 2020 at 06:11:06PM +0000, Bird, Tim wrote:
> > Some months ago I started work on a document to formalize how
> > kselftest implements the TAP specification.  However, I didn't finish
> > that work.  Maybe it's time to do so now.
> >
> > kselftest has developed a few differences from the original
> > TAP specification, and  some extensions that I believe are worth
> > documenting.
> >
> > Essentially, we have created our own KTAP (kernel TAP)
> > format.  I think it is worth documenting our conventions, in order to
> > keep everyone on the same page.
> >
> > Below is a partially completed document on my understanding
> > of KTAP, based on examination of some of the kselftest test
> > output.  I have not reconciled this with the kunit output format,
> > which I believe has some differences (which maybe we should
> > resolve before we get too far into this).
> >
> > I submit the document now, before it is finished, because a patch
> > was recently introduced to alter one of the result conventions
> > (from SKIP=3D'not ok' to SKIP=3D'ok').
> >
> > See the document include inline below
> >
> > =3D=3D=3D=3D=3D=3D start of ktap-doc-rfc.txt =3D=3D=3D=3D=3D=3D
>=20
> [...]
>=20
> > --- from here on is not-yet-organized material
> >
> > Tip:
> >  - don't change the test plan based on skipped tests.
> >    - it is better to report that a test case was skipped, than to
> >      not report it
> >    - that is, don't adjust the number of test cases based on skipped
> >      tests
> >
> > Other things to mention:
> > TAP13 elements not used:
> >  - yaml for diagnostic messages
>=20
> We talked about this before, but I would like some way to get failed
> expectation/assertion information in the test in a consistent machine
> parsible way. Currently we do the following:
>=20
> =A0 =A0 # Subtest: example
> =A0 =A0 1..1
> =A0 =A0 # example_simple_test: initializing
> =A0 =A0 # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-exam=
ple-test.c:29
> =A0 =A0 Expected 1 + 1 =3D=3D 3, but
> =A0 =A0 =A0 =A0 1 + 1 =3D=3D 2
> =A0 =A0 =A0 =A0 3 =3D=3D 3
> =A0 =A0 not ok 1 - example_simple_test
> not ok 5 - example
>=20
> Technically not TAP compliant, but no one seems to mind. I am okay with
> keeping it the way it is, but if we don't want it in the KTAP spec, we
> will need some kind of recourse.

So far, most of the CI systems don't parse out diagnostic data, so it doesn=
't
really matter what the format is.  If it's useful for humans, it's valuable=
 as is.
However, it would be nice if that could change.  But without some formaliza=
tion
of the format of the diagnostic data, it's an intractable problem for CI sy=
stems
to parse it.  So it's really a chicken and egg problem.  To solve it, we wo=
uld have
to determine what exactly needs to be provided on a consistent basis for di=
agnostic
data across many tests.  I think that it's too big a problem to handle righ=
t now.
I'm not opposed to migrating to some structure with yaml in the future, but=
 free
form text output seems OK for now.

>=20
> >    - reason: try to keep things line-based, since output from other thi=
ngs
> >    may be interspersed with messages from the test itself
> >  - TODO directive
>=20
> Is this more of stating a fact or desire? We don't use TODO either, but
> it looks like it could be useful.
Just stating a fact.  I didn't find TODO in either KUnit or selftest in=20
November when I initially wrote this up.  If TODO serves as a kind
of XFAIL, it could be useful.  I have nothing against it.

>=20
> > KTAP Extensions beyond TAP13:
> >  - nesting
> >    - via indentation
> >      - indentation makes it easier for humans to read
> >  - test identifier
> >     - multiple parts, separated by ':'
>=20
> Can you elabroate on this more? I am not sure what you mean.
An individual test case can have a name that is scoped by a containing
test or test suite.  For example: selftests: cpufreq: main.sh
This test identifier consists of the test system (selftests), the test
area (cpufreq), and the test case name (main.sh).  This one's a bit
weird because the test case name is just the name of the program
in that test area.  The program itself doesn't output data in TAP format,
and the harness uses it's exit code to detect PASS/FAIL.  if main.sh had
multiple test cases, it might produce test identifiers like this:
selftests: cpufreq: main: check_change_afinity_mask
selftests: cpufreq: main: check_permissions_for_mask_operation
(Or it might just produce the last part of these strings, the
testcase names, and the testcase id might be something generated
by the harness or CI system.)

The value of having a single string to identify the testcase (like a
uniform resource locator), is that it's easier to use the string to
correlate results produced from different CI system that are executing
the same test.

>=20
> >  - summary lines
> >    - can be skipped by CI systems that do their own calculations
> >
> > Other notes:
> >  - automatic assignment of result status based on exit code
> >
> > Tips:
> >  - do NOT describe the result in the test line
> >    - the test case description should be the same whether the test
> >      succeeds or fails
> >    - use diagnostic lines to describe or explain results, if this is
> >      desirable
> >  - test numbers are considered harmful
> >    - test harnesses should use the test description as the identifier
> >    - test numbers change when testcases are added or removed
> >      - which means that results can't be compared between different
> >        versions of the test
> >  - recommendations for diagnostic messages:
> >    - reason for failure
> >    - reason for skip
> >    - diagnostic data should always preceding the result line
> >      - problem: harness may emit result before test can do assessment
> >        to determine reason for result
> >      - this is what the kernel uses
> >
> > Differences between kernel test result format and TAP13:
> >  - in KTAP the "# SKIP" directive is placed after the description on
> >    the test result line
> >
> > =3D=3D=3D=3D=3D=3D start of ktap-doc-rfc.txt =3D=3D=3D=3D=3D=3D
> > OK - that's the end of the RFC doc.
> >
> > Here are a few questions:
> >  - is this document desired or not?
> >     - is it too long or too short?
> >  - if the document is desired, where should it be placed?
>=20
> I like it. I don't think we can rely on the TAP people updating their
> stuff based on my interactions with them. So having a spec which is
> actually maintained would be nice.
>=20
> Maybe in Documentation/dev-tools/ ?
I'm leaning towards Documentation/dev-tools/test-results_format.rst

>=20
> >    I assume somewhere under Documentation, and put into
> >    .rst format. Suggestions for a name and location are welcome.
> >  - is this document accurate?
> >    I think KUNIT does a few things differently than this description.
> >    - is the intent to have kunit and kselftest have the same output for=
mat?
> >       if so, then these should be rationalized.
>=20
> Yeah, I think it would be nice if all test frameworks/libraries for the
> kernel output tests in the same language.
Agreed.

 -- Tim

