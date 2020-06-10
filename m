Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4A71F5AFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jun 2020 20:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgFJSLM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Jun 2020 14:11:12 -0400
Received: from mail-bn7nam10on2113.outbound.protection.outlook.com ([40.107.92.113]:34913
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728505AbgFJSLL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Jun 2020 14:11:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/QiuNV48KPqdJoYD7yPO4EyX4teswiMTqSavbixxsrZtuaSXU1vrCLzfKGTGim6OAFYqFmT7mKvA99Iyiq67NvWn1H6bxrulEc+KU7d1VJFYyIbQPV3LOxseedqTX0656CRosrKPFREZ3oLmKZNeY7S9Hvg+BalDzeD6aFqHrgTfqQLa3WWRsAviTcvGffYvSmZR9rF2tMDlX9rYUV0VzL93npeV55SuzPNKIBVeL7SXTPj+lukkU34FTQt4YTrldDFPa+Gi45YzUWAsRLU0aJU/CEWlpm1H9eAEM7/oRPpgnQF83dLFc4Xb6LaEMOkhxLKZlOtu7lPYdY41p9hzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9XK7/mIcUp6E9AnBWPjnXuO6pp3Y8gaIpNMwC6kVco=;
 b=RNfG9Tehn5BrXq8cEru3dg6CPIdDvNH+40tXFoA1SDlcpjgYkC4sq5tAMW7IUTosdP5Jwpir8WwVX3YYhpiQtTQdDW+NHcFirAbvPChg9+BNuTcli6TLH3YLSnf0IL4jYS7fxiAWiLLajQ/7tQ3SSBq3L99Ebzzq2Mjmus2jSsP/6xKmW9QLW8Kvlw90TzFezltFcIBpGtrDkCJ/aEKmpUInP6Rmr4sMjDoDqEjZcQTqcCXlOP+lVgzVz83MT+mCqPVHjUs8hO2rqIS4ifLluMPP99Vp9p6FB/399CH3DaQp4ZLwUeHSCwSZlmgSo8ckUormmXE2lqjtrC8WdTpi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9XK7/mIcUp6E9AnBWPjnXuO6pp3Y8gaIpNMwC6kVco=;
 b=Xjc8Nw5jjySxJLoJHT9tlPiPsHKxYk4MjChms3uAb+q89HlgPT2XJ+WlA0EC42NwEODZy+sL4Y0ygZgz/I/8tyKznIlH6VTufC4jRfId7iDCYR5U88DqWR5Ns+r80ImAYvvApeiQXA9EByGGlh4yLjepRwx56r7gY5kmaML82v8=
Received: from CY4PR13MB1175.namprd13.prod.outlook.com (10.168.168.151) by
 CY4PR1301MB2102.namprd13.prod.outlook.com (10.171.222.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.9; Wed, 10 Jun 2020 18:11:06 +0000
Received: from CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e]) by CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e%9]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 18:11:06 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RFC - kernel selftest result documentation (KTAP)
Thread-Topic: RFC - kernel selftest result documentation (KTAP)
Thread-Index: AdY/UfZiI2pZQBRwRN+1JBazpeVQog==
Date:   Wed, 10 Jun 2020 18:11:06 +0000
Message-ID: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [160.33.195.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9749fae-96ea-49ec-4673-08d80d69a538
x-ms-traffictypediagnostic: CY4PR1301MB2102:
x-microsoft-antispam-prvs: <CY4PR1301MB2102A976A3A6F3D6ACAA93D5FD830@CY4PR1301MB2102.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /HgC/p25Ot5THraIgB0rD2YNdgusRz4I/dO0g1s8bwqFhx/KPFf1RZo75EQI2njaDl2e6+Amx1qvBxo+R2Dp/QoTB44WsUNv8LdFyzsLWxPRoGBECzn/uThQWXS+dMA5aN5tzF7jRrqbeShbR9gHKqRZp7Pbh3MT4jFqhWmhhxxFp8WPnGyPAMFDjNaxVgDet3OfIkW03jayLc8lqY/WnaOkpt/zlNY1xQXnzWB4M5YukVVLJBV+mug8jS0hIffu9C6diRqQknVeznfTpWb1NKZHdAQmNQynwKaudwwtJR+xRHZfTPrqEEAdI/xk5JJUUhw8nA1CprekWClMD9lxrMNvKIAVgdLNhoZVsa2hD8e3ndWmTkzeJobmE7pyjAUAejm2eUFdv0eOLzbBGOIqmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR13MB1175.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(71200400001)(4326008)(966005)(478600001)(8936002)(9686003)(33656002)(66476007)(66556008)(64756008)(66446008)(76116006)(83380400001)(86362001)(66946007)(2906002)(186003)(5660300002)(52536014)(110136005)(26005)(7696005)(55016002)(316002)(6506007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: td/ufh4XRyRFdAZ8TBInN+8M409KDRte4VJEttEiqUSqCWvzYtt87+SYwh90STxksk7KAyQr9RwAziLeJ+BfdzC6RjOTj0rY2KlMYxgLiBl16lvM97bv99hcwIWpdC+cb16mRzMXAJt/vrnuqNLRupZj30u6wubpzCpUBDgmHL+lmQewlzz17kSOgyyZgQ0w+7nv1pocjNL6fWniUFxPMmNLu27lJeDlrHBwJ2/jZPkQWZY0QYEw0ugS7aujhVFR5L+VEYX3+R7R2O4/ciX/y6j9RFMgOzjfJez7JdNUh5yK7P29uAo7jNKi88XuzGbGUKrmpg60VxBev+ayDu1igO/2z/0EVOkXhlyhVjGZ7vwk/gPK9SHwpuTVyrHswrzO9SibvUM07zCIte+1LPMtel4JwJeC3Lf710la4XSGHW0juL92gcw0ZUtjhEDEwqAQwB3LTGYfYj7QAFK/aTIs+elDCN2Hw6f5GJX/5L4TeTA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9749fae-96ea-49ec-4673-08d80d69a538
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 18:11:06.5701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lyYNb0zcQqFgbTrMF+Pt0GmRQ6Z3ZoV8UwbZJpUPEfDyU70ucfI408vAgMIvM0AvJlKz+oXaamrDxP2XXhDReQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB2102
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some months ago I started work on a document to formalize how
kselftest implements the TAP specification.  However, I didn't finish
that work.  Maybe it's time to do so now.

kselftest has developed a few differences from the original
TAP specification, and  some extensions that I believe are worth
documenting.

Essentially, we have created our own KTAP (kernel TAP)
format.  I think it is worth documenting our conventions, in order to
keep everyone on the same page.

Below is a partially completed document on my understanding
of KTAP, based on examination of some of the kselftest test
output.  I have not reconciled this with the kunit output format,
which I believe has some differences (which maybe we should
resolve before we get too far into this).

I submit the document now, before it is finished, because a patch
was recently introduced to alter one of the result conventions
(from SKIP=3D'not ok' to SKIP=3D'ok').

See the document include inline below

=3D=3D=3D=3D=3D=3D start of ktap-doc-rfc.txt =3D=3D=3D=3D=3D=3D
Selftest preferred output format
--------------------------------

The linux kernel selftest system uses TAP (Test Anything Protocol)
output to make testing results consumable by automated systems.  A
number of Continuous Integration (CI) systems test the kernel every
day.  It is useful for these systems that output from selftest
programs be consistent and machine-parsable.

At the same time, it is useful for test results to be human-readable
as well.

The kernel test result format is based on a variation TAP
TAP is a simple text-based format that is
documented on the TAP home page (http://testanything.org/).  There
is an official TAP13 specification here:
http://testanything.org/tap-version-13-specification.html

The kernel test result format consists of 5 major elements,
4 of which are line-based:
 * the output version line
 * the plan line
 * one or more test result lines (also called test result lines)
 * a possible "Bail out!" line

optional elements:
 * diagnostic data

The 5th element is diagnostic information, which is used to describe
items running in the test, and possibly to explain test results.
A sample test result is show below:

Some other lines may be placed the test harness, and are not emitted
by individual test programs:
 * one or more test identification lines
 * a possible results summary line

Here is an example:

	TAP version 13
	1..1
	# selftests: cpufreq: main.sh
	# pid 8101's current affinity mask: fff
	# pid 8101's new affinity mask: 1
	ok 1 selftests: cpufreq: main.sh

The output version line is: "TAP version 13"

The test plan is "1..1".

Element details
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Output version line
-------------------
The output version line is always "TAP version 13".

Although the kernel test result format has some additions
to the TAP13 format, the version line reported by kselftest tests
is (currently) always the exact string "TAP version 13"

This is always the first line of test output.

Test plan line
--------------
The test plan indicates the number of individual test cases intended to
be executed by the test. It always starts with "1.." and is followed
by the number of tests cases.  In the example above, 1..1", indicates
that this test reports only 1 test case.

The test plan line can be placed in two locations:
 * the second line of test output, when the number of test cases is known
   in advance
 * as the last line of test output, when the number of test cases is not
   known in advance.

Most often, the number of test cases is known in advance, and the test plan
line appears as the second line of test output, immediately following
the output version line.  The number of test cases might not be known
in advance if the number of tests is calculated from runtime data.
In this case, the test plan line is emitted as the last line of test
output.

Test result lines
-----------------
The test output consists of one or more test result lines that indicate
the actual results for the test.  These have the format:

  <result> <number> <description> [<directive>] [<diagnostic data>]

The ''result'' must appear at the start of a line (except for when a
test is nested, see below), and must consist of one of the following
two phrases:
  * ok
  * not ok

If the test passed, then the result is reported as "ok".  If the test
failed, then the result is reported as "not ok".  These must be in
lower case, exactly as shown.

The ''number'' in the test result line represents the number of the
test case being performed by the test program.  This is often used by
test harnesses as a unique identifier for each test case.  The test
number is a base-10 number, starting with 1.  It should increase by
one for each new test result line emitted.  If possible the number
for a test case should be kept the same over the lifetime of the test.

The ''description'' is a short description of the test case.
This can be any string of words, but should avoid using colons (':')
except as part of a fully qualifed test case name (see below).

Finally, it is possible to use a test directive to indicate another
possible outcome for a test: that it was skipped.  To report that
a test case was skipped, the result line should start with the
result "not ok", and the directive "# SKIP" should be placed after
the test description. (Note that this deviates from the TAP13
specification).

A test may be skipped for a variety of reasons, ranging for
insufficient privileges to missing features or resources required
to execute that test case.

It is usually helpful if a diagnostic message is emitted to explain
the reasons for the skip.  If the message is a single line and is
short, the diagnostic message may be placed after the '# SKIP'
directive on the same line as the test result.  However, if it is
not on the test result line, it should precede the test line (see
diagnostic data, next).

Diagnostic data
---------------
Diagnostic data is text that reports on test conditions or test
operations, or that explains test results.  In the kernel test
result format, diagnostic data is placed on lines that start with a
hash sign, followed by a space ('# ').

One special format of diagnostic data is a test identification line,
that has the fully qualified name of a test case.  Such a test
identification line marks the start of test output for a test case.

In the example above, there are three lines that start with '#'
which precede the test result line:
	# selftests: cpufreq: main.sh
	# pid 8101's current affinity mask: fff
	# pid 8101's new affinity mask: 1
These are used to indicate diagnostic data for the test case
'selftests: cpufreq: main.sh'

Material in comments between the identification line and the test
result line are diagnostic data that can help to interpret the
results of the test.

The TAP specification indicates that automated test harnesses may
ignore any line that is not one of the mandatory prescribed lines
(that is, the output format version line, the plan line, a test
result line, or a "Bail out!" line.)=20

Bail out!
---------
If a line in the test output starts with 'Bail out!', it indicates
that the test was aborted for some reason.  It indicates that=20
the test is unable to proceed, and no additional tests will be
performed.

This can be used at the very beginning of a test, or anywhere in the
middle of the test, to indicate that the test can not continue.

--- from here on is not-yet-organized material

Tip:
 - don't change the test plan based on skipped tests.
   - it is better to report that a test case was skipped, than to
     not report it
   - that is, don't adjust the number of test cases based on skipped
     tests

Other things to mention:
TAP13 elements not used:
 - yaml for diagnostic messages
   - reason: try to keep things line-based, since output from other things
   may be interspersed with messages from the test itself
 - TODO directive

KTAP Extensions beyond TAP13:
 - nesting
   - via indentation
     - indentation makes it easier for humans to read
 - test identifier
    - multiple parts, separated by ':'
 - summary lines
   - can be skipped by CI systems that do their own calculations

Other notes:
 - automatic assignment of result status based on exit code

Tips:
 - do NOT describe the result in the test line
   - the test case description should be the same whether the test
     succeeds or fails
   - use diagnostic lines to describe or explain results, if this is
     desirable
 - test numbers are considered harmful
   - test harnesses should use the test description as the identifier
   - test numbers change when testcases are added or removed
     - which means that results can't be compared between different
       versions of the test
 - recommendations for diagnostic messages:
   - reason for failure
   - reason for skip
   - diagnostic data should always preceding the result line
     - problem: harness may emit result before test can do assessment
       to determine reason for result
     - this is what the kernel uses

Differences between kernel test result format and TAP13:
 - in KTAP the "# SKIP" directive is placed after the description on
   the test result line

=3D=3D=3D=3D=3D=3D start of ktap-doc-rfc.txt =3D=3D=3D=3D=3D=3D
OK - that's the end of the RFC doc.

Here are a few questions:
 - is this document desired or not?
    - is it too long or too short?
 - if the document is desired, where should it be placed?
   I assume somewhere under Documentation, and put into
   .rst format. Suggestions for a name and location are welcome.
 - is this document accurate?
   I think KUNIT does a few things differently than this description.
   - is the intent to have kunit and kselftest have the same output format?
      if so, then these should be rationalized.

Finally,
  - Should a SKIP result be 'ok' (TAP13 spec) or 'not ok' (current kselftes=
t practice)?
See https://testanything.org/tap-version-13-specification.html

Regards,
 -- Tim

  =20
