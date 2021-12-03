Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487D8467237
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 07:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378681AbhLCGwW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 01:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378679AbhLCGwR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 01:52:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1640C06174A
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Dec 2021 22:48:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g25-20020a25b119000000b005c5e52a0574so4777099ybj.5
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Dec 2021 22:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=7BcMbEYFzvBu0y1WaO1A9dnWDuTe/frFbo10PaaTJyw=;
        b=j22cCMCLeawQC/1AnIsfIyq8CzmEhP4d7LcsODy0V5LwsZR+CfKJn4Qf75TdBHn06D
         Ow9w3M3RTO99OVmnuqxEWwgOiwcEDORuH5o6e1Wg7irXX2nwRVFMJijOP4Pi03lu6fjF
         Gjiz1DpaCz0+9p/ED1zWP76WfUnA8UoBuAG4XFXBmadMaEwiu3OqlEleF7kvNmIDdaYC
         ppYHL5HXLlHXyXphLRAFGCEt9NT4hE/k12Rg60V5wVkOQXsvBahnQrcn/9LDxgb+UAjV
         /i2xPh1QemwoNh3dQXh4pefYGLU6WVPdxygjqLlElrymNnaDlGs9w8l9M3p+JTUaqNH+
         d2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=7BcMbEYFzvBu0y1WaO1A9dnWDuTe/frFbo10PaaTJyw=;
        b=25eX9/J0BN5BjiqEtz2I28kfQ/WCBLSRW4cq4cZLHXvjk90EaN66BgRAnEXGterTjx
         Z0B4a4N4l2gVqBaPed1WRDe+pTuhkSn+4Okomsb3h6eNCPgKdkD5wSL3Y0PYZmL2xFY8
         R/hHIHTZubT30DKU0bFYQIzTH9Fe3qWdMfGLou9fChDkCWfYGpC8ekKat6j9KxI3537Z
         HDYq+ahsi2Mx5uNyi4riuuCRAvI+JyM5jjFQkvmkLygjsf/7Q9MyYgkypxyaoovHwD1L
         jtFbGLyCGNaK5qVvSGsc7Ln8zpPDLtNymCcYm6BPJWo2T22jQih//2gP9yms8bZ9pYaQ
         YPbg==
X-Gm-Message-State: AOAM5301Kjw8EOphmbrmcwRKwB7CeaWFm+svUQPszV1jKiY71patDZkD
        13C5M+UYhnfoJccIOFSlLxPWr4jUkWRJWw==
X-Google-Smtp-Source: ABdhPJxVZ57eCBoR+qWf9H81oN0BENW/NgLSNZx380+w91p117Hx+E1xgqbVh3AgqnZMjxt2mS87sJCc+moC8w==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:a78e:7c38:5678:d805])
 (user=davidgow job=sendgmr) by 2002:a25:ad06:: with SMTP id
 y6mr20331579ybi.278.1638514133038; Thu, 02 Dec 2021 22:48:53 -0800 (PST)
Date:   Thu,  2 Dec 2021 22:48:40 -0800
Message-Id: <20211203064840.2871751-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [RFC PATCH] Documentation: dev-tools: Add KTAP specification
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>, Tim.Bird@sony.com,
        shuah@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>
Cc:     Rae Moar <rmoar@google.com>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rae Moar <rmoar@google.com>

Document the kernel-specific variant of the Test Anything Protocol
(TAP)[1] used by the kernel and kernel test frameworks. This version
is called KTAP, and this version of the specification should describe
how results produced by kselftest and KUnit (with some trivial changes
to bring the two into alignment).

It does not make any significant additions or changes other than those
already in use in the kernel: additional features can be added as they
become necessary and used.

See prior discussion in the following RFC:
https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqa=
Jk+r-K1YJzPggFDQ@mail.gmail.com/.

[1]: https://testanything.org/tap-version-13-specification.html

Signed-off-by: Rae Moar <rmoar@google.com>
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Hi all,

This is a version of the KTAP RFC from [1], with a greater focus on
being compatible with what's currently used, rather than prescribing a
new format. The format here should be a superset of what KUnit and
kselftest output, with a couple of notable exceptions:
- KUnit currently uses the TAP14-style "Subtest" header instead of
  nested TAP version headers. This will be fixed in KUnit once this goes
  in.
- The (unused) XPASS option is not mentioned (it'll devolve into a
  harmless comment)

Cheers,
-- David

[1]https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJ=
xqaJk+r-K1YJzPggFDQ@mail.gmail.com/

---
 Documentation/dev-tools/index.rst |   1 +
 Documentation/dev-tools/ktap.rst  | 287 ++++++++++++++++++++++++++++++
 2 files changed, 288 insertions(+)
 create mode 100644 Documentation/dev-tools/ktap.rst

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/in=
dex.rst
index 010a2af1e7d9..4621eac290f4 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -32,6 +32,7 @@ Documentation/dev-tools/testing-overview.rst
    kgdb
    kselftest
    kunit/index
+   ktap
=20
=20
 .. only::  subproject and html
diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/kta=
p.rst
new file mode 100644
index 000000000000..7c17956b998a
--- /dev/null
+++ b/Documentation/dev-tools/ktap.rst
@@ -0,0 +1,287 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+The Kernel Test Anything Protocol (KTAP)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+TAP, or the Test Anything Protocol is a format for specifying test results=
 used
+by a number of projects. It's website and specification are found at this =
`link
+<https://testanything.org/>`_. The Linux Kernel largely uses TAP output fo=
r test
+results. However, Kernel testing frameworks have special needs for test re=
sults
+which don't align with the original TAP specification. Thus, a "Kernel TAP=
"
+(KTAP) format is specified to extend and alter TAP to support these use-ca=
ses.
+This specification describes the generally accepted format of KTAP as it i=
s
+currently used in the kernel
+
+KTAP test results describe a series of tests (which may be nested: i.e., t=
est
+can have subtests), each of which can contain both diagnostic data -- e.g.=
, log
+lines -- and a final result. The test structure and results are
+machine-readable, whereas the diagnostic data is unstructured and is there=
 to
+aid human debugging.
+
+KTAP output is built from four different types of lines:
+- Version lines
+- Plan lines
+- Test case result lines
+- Diagnostic lines
+
+Note that, in particular, nested test results work differently in KTAP fro=
m
+the proposed TAP14 specification:
+https://github.com/TestAnything/Specification/blob/tap-14-specification/sp=
ecification.md
+
+Version lines
+-------------
+
+All KTAP-formatted results begin with a "version line" which specifies whi=
ch
+version of the (K)TAP standard the result is compliant with.
+
+For example:
+- "KTAP version 1"
+- "TAP version 13"
+- "TAP version 14"
+
+Note that, in KTAP, subtests also begin with a version line, which denotes=
 the
+start of the nested test results. This differs from TAP14, which uses a
+separate "Subtest" line.
+
+While, going forward, "KTAP version 1" should be used by compliant tests, =
it
+is expected that most parsers and other tooling will accept the other vers=
ions
+listed here for compatibility with existing tests and frameworks.
+
+Plan lines
+----------
+
+A test plan provides the number of tests (or subtests) in the KTAP ouput.
+
+Plan lines must follow the format of "1..N" where N is the number of tests=
 or subtests.
+Plan lines follow version lines to indicate the number of nested tests.
+
+While there are cases where the number of tests is not known in advance --=
 in
+which case the test plan may be omitted -- it is strongly recommended one =
is
+present where possible.
+
+Test case result lines
+----------------------
+
+Test case result lines indicate the final status of a test.
+They are required and must have the format:
+
+.. code-block::
+
+	<result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
+
+The result can be either "ok", which indicates the test case passed,
+or "not ok", which indicates that the test case failed.
+
+<number> represents the number of the test being performed. The first test=
 must
+have the number 1 and the number then must increase by 1 for each addition=
al
+subtest within the same test at the same nesting level.
+
+The description is a description of the test, generally the name of
+the test, and can be any string of words (can't include #). The
+description is optional, but recommended.
+
+The directive and any diagnostic data is optional. If either are present, =
they
+must follow a hash sign, "#".
+
+A directive is a keyword that indicates a different outcome for a test oth=
er
+than passed and failed. The directive is optional, and consists of a singl=
e
+keyword preceding the diagnostic data. In the event that a parser encounte=
rs
+a directive it doesn't support, it should fall back to the "ok" / "not ok"
+result.
+
+Currently accepted directives are:
+
+- "SKIP", which indicates a test was skipped (note the result of the test =
case
+  result line can be either "ok" or "not ok" if the SKIP directive is used=
)
+- "TODO", which indicates that a test is not expected to pass at the momen=
t,
+  e.g. because the feature it is testing is known to be broken. While this
+  directive is inherited from TAP, its use in the kernel is discouraged.
+- "XFAIL", which indicates that a test is expected to fail. This is simila=
r
+  to "TODO", above, and is used by some kselftest tests.
+- "XPASS", which indicated that a test is expected to pass. There is some =
code
+  which tracks this result, but it does not appear to currently be used.
+- =E2=80=9CTIMEOUT=E2=80=9D, which indicates a test has timed out (note th=
e result of the test
+  case result line should be =E2=80=9Cnot ok=E2=80=9D if the TIMEOUT direc=
tive is used)
+- =E2=80=9CERROR=E2=80=9D, which indicates a test has failed with a specif=
ic error that is
+  included in the diagnostic data (note the result of the test case result=
 like
+  should be =E2=80=9Cnot ok=E2=80=9D if the ERROR directive is used)
+
+The diagnostic data is a plain-text field which contains any additional de=
tails
+about why this result was produced. This is typically an error code for ER=
ROR
+or failed tests, or a description of missing dependencies for a SKIP resul=
t.
+
+The diagnostic data field is optional, and results which have neither a
+directive nor any diagnostic data do not need to include the "#" field
+separator.
+
+Example result lines include:
+
+.. code-block::
+
+	ok 1 test_case_name
+
+The test "test_case_name" passed.
+
+.. code-block::
+
+	not ok 1 test_case_name
+
+The test "test_case_name" failed.
+
+.. code-block::
+
+	ok 1 test # SKIP necessary dependency unavailable
+
+The test "test" was SKIPPED with the diagnostic message "necessary depende=
ncy
+unavailable".
+
+.. code-block::
+
+	not ok 1 test # TIMEOUT 30 seconds
+
+The test "test" timed out, with diagnostic data "30 seconds".
+
+.. code-block::
+
+	ok 5 check return code # rcode=3D0
+
+The test "check return code" passed, with additional diagnostic data is
+=E2=80=9Crcode=3D0=E2=80=9D
+
+
+Diagnostic lines
+----------------
+
+If tests wish to output any further information, they should do so using
+"diagnostic lines". Diagnostic lines are optional, freeform text, and are
+often used to describe what is being tested and any intermediate results i=
n
+more detail than the final result and diagnostic data line provides.
+
+Diagnostic lines are formatted as "# <diagnostic_description>", where the
+description can be any string.  Diagnostic lines can be anywhere in the te=
st
+output. As a rule, diagnostic lines regarding a test are directly before t=
he
+test result line for that test.
+
+Note that most tools will treat unknown lines (see below) as diagnostic li=
nes,
+even if they do not start with a "#": this is to capture any other useful
+kernel output which may help debug the test. It is nevertheless recommende=
d
+that tests always prefix any diagnostic output they have with a "#" charac=
ter.
+
+Unknown lines
+-------------
+
+There may be lines within KTAP output that do not follow the format of one=
 of
+the four formats for lines described above. This is allowed, however, they=
 will
+not influence the status of the tests.
+
+Nested tests
+------------
+
+In KTAP, tests can be nested. This is done by having a test include within=
 its
+output an entire set of KTAP-formatted results. This can be used to catego=
rize
+and group related tests, or to split out different results from the same t=
est.
+
+The "parent" test's result should consist of all of its subtests' results,
+starting with another KTAP version line and test plan, and end with the ov=
erall
+result. If one of the subtests fail, for example, the parent test should a=
lso
+fail.
+
+Additionally, all result lines in a subtest should be indented. One level =
of
+indentation is two spaces: "  ". The indentation should begin at the versi=
on
+line and should end before the parent test's result line.
+
+An example of a test with two nested subtests:
+
+.. code-block::
+
+	KTAP version 1
+	1..1
+	  KTAP version 1
+	  1..2
+	  ok 1 test_1
+	  not ok 2 test_2
+	# example failed
+	not ok 1 example
+
+An example format with multiple levels of nested testing:
+
+.. code-block::
+
+	KTAP version 1
+	1..2
+	  KTAP version 1
+	  1..2
+	    KTAP version 1
+	    1..2
+	    not ok 1 test_1
+	    ok 2 test_2
+	  not ok 1 test_3
+	  ok 2 test_4 # SKIP
+	not ok 1 example_test_1
+	ok 2 example_test_2
+
+
+Major differences between TAP and KTAP
+--------------------------------------
+
+Note the major differences between the TAP and KTAP specification:
+- yaml and json are not recommended in diagnostic messages
+- TODO directive not recognized
+- KTAP allows for an arbitrary number of tests to be nested
+
+The TAP14 specification does permit nested tests, but instead of using ano=
ther
+nested version line, uses a line of the form
+"Subtest: <name>" where <name> is the name of the parent test.
+
+Example KTAP output
+--------------------
+.. code-block::
+
+	KTAP version 1
+	1..1
+	  KTAP version 1
+	  1..3
+	    KTAP version 1
+	    1..1
+	    # test_1: initializing test_1
+	    ok 1 test_1
+	  ok 1 example_test_1
+	    KTAP version 1
+	    1..2
+	    ok 1 test_1 # SKIP test_1 skipped
+	    ok 2 test_2
+	  ok 2 example_test_2
+	    KTAP version 1
+	    1..3
+	    ok 1 test_1
+	    # test_2: FAIL
+	    not ok 2 test_2
+	    ok 3 test_3 # SKIP test_3 skipped
+	  not ok 3 example_test_3
+	not ok 1 main_test
+
+This output defines the following hierarchy:
+
+A single test called "main_test", which fails, and has three subtests:
+- "example_test_1", which passes, and has one subtest:
+
+   - "test_1", which passes, and outputs the dianostic message "test_1: in=
itializing test_1"
+
+- "example_test_2", which passes, and has two subtests:
+
+   - "test_1", which is skipped, with the explanation "test_1 skipped"
+   - "test_2", which passes
+
+- "example_test_3", which fails, and has three subtests
+
+   - "test_1", which passes
+   - "test_2", which outputs the diagnostic line "test_2: FAIL", and fails=
.
+   - "test_3", which is skipped with the explanation "test_3 skipped"
+
+Note that the individual subtests with the same names do not conflict, as =
they
+are found in different parent tests. This output also exhibits some sensib=
le
+rules for "bubbling up" test results: a test fails if any of its subtests =
fail.
+Skipped tests do not affect the result of the parent test (though it often
+makes sense for a test to be marked skipped if _all_ of its subtests have =
been
+skipped).
--=20
2.34.1.400.ga245620fadb-goog

