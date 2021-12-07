Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911B746C34B
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 20:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbhLGTGZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 14:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbhLGTGY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 14:06:24 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B0AC061574
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 11:02:54 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id m15-20020a170902bb8f00b0014382b67873so2881005pls.19
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 11:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=8q51zUwHuJfhXkm4t3PDBh8T8/WWWNZrP/ln+mfXd9E=;
        b=nbm20WZ+jVXjHrFDAZT9Mtyr2NdB1tcau+0H4kMeB4KlEFiJbD4alL28ZPdMNlgkJj
         FFTYwHQObwr4VdA4539Cagxu4xysq98EiP7KK22SWOjG0NUYCHylNtMzw5XA3OQnrKlT
         g5s0wu1wkUKqRhBzA0PFEVbpuXuihMaraIZ5Bsb/NQvO1quDnJxtWZjspjevglDo29kq
         876I0QUm/ZO2jcaivw+koc7Ozm3a6jKyKsrGdTKs4+wFE7VMADdwxLxYHhBMs8caOzdK
         mr1rUBNZiuMdmRsBuijgzgYuCWmeYcC5Rvw2IigqhJGrr4ZVJvSNuIS0cCeRA++gTlD3
         58BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=8q51zUwHuJfhXkm4t3PDBh8T8/WWWNZrP/ln+mfXd9E=;
        b=lgf2WcMY9Rm7KIh0h/8OK06oxujkMplrbXvn/DgcByDB1iz9FR7qwJhcPNxK/ON6Sz
         a13pxlTfBxGRvZ7B8Y48KYXMMoZIbv+ykWawQ6Jq9hbfzEHf4tDm/pcAVlYq5HukhRmI
         NSc+OydDVfIC908LmVzuCiUms5zm4ByrV3ECPwj5ATqV7JF89QU/q+bcC/m2XOh1+vMa
         R9pmHL2QKAQXKZxOtQ+bALtku/EBsIRIdUoTu9cXS156qreqsqX7J5v2ZIqdCCUCEeQR
         I0rgLUlZT9glqUp34sCy8noMcEW/UlX+W1jM0okH/4rtKwd62RwZ5Fglg3bKu+GaBSpK
         q9ZQ==
X-Gm-Message-State: AOAM532TjMP9qhHOQOgPwGwmhvWypBg1esd0tOkIoGiHBPS7Abhxlf2b
        o358suGv9c9+YS2HG+IGVmWWjRfseKlMqw==
X-Google-Smtp-Source: ABdhPJwxiMjj0eRUrmptJlP62mAjB2juBg2U8ySx/Cfl7N7nEZkB/AoFVpzNeaC8pQJ8VjC8cBwtrI+DB1NNIQ==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:36b6:7f4b:d39a:e417])
 (user=davidgow job=sendgmr) by 2002:a17:90b:4b51:: with SMTP id
 mi17mr1298440pjb.48.1638903773471; Tue, 07 Dec 2021 11:02:53 -0800 (PST)
Date:   Tue,  7 Dec 2021 11:02:51 -0800
Message-Id: <20211207190251.18426-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [RFC PATCH v2] Documentation: dev-tools: Add KTAP specification
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>, Tim.Bird@sony.com,
        shuah@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rae Moar <rmoar@google.com>

It does not make any significant additions or changes other than those
already in use in the kernel: additional features can be added as they
become necessary and used.

[1]: https://testanything.org/tap-version-13-specification.html

Signed-off-by: Rae Moar <rmoar@google.com>
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since RFC v1:
https://lore.kernel.org/linux-kselftest/20211203064840.2871751-1-davidgow@g=
oogle.com/
- Add a "see also" section with some useful links.
- Remove the XPASS directive, which isn't used anywhere.
- Clear up / reorganise the discussion around differences between KTAP
  and TAP14.
- Improve the wording around some directives.
- Fix a bunch of typos.

See prior discussion in the following RFC:
https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqa=
Jk+r-K1YJzPggFDQ@mail.gmail.com/.

---

 Documentation/dev-tools/index.rst |   1 +
 Documentation/dev-tools/ktap.rst  | 298 ++++++++++++++++++++++++++++++
 2 files changed, 299 insertions(+)
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
index 000000000000..878530cb9c27
--- /dev/null
+++ b/Documentation/dev-tools/ktap.rst
@@ -0,0 +1,298 @@
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
+currently used in the kernel.
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
+In general, valid KTAP output should also form valid TAP output, but some
+information, in particular nested test results, may be lost. Also note tha=
t
+there is a stagnant draft specification for TAP14, KTAP diverges from this=
 in
+a couple of places (notably the "Subtest" header), which are described whe=
re
+relevant later in this document.
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
+A test plan provides the number of tests (or subtests) in the KTAP output.
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
+- =E2=80=9CTIMEOUT=E2=80=9D, which indicates a test has timed out (note th=
e result of the test
+  case result line should be =E2=80=9Cnot ok=E2=80=9D if the TIMEOUT direc=
tive is used)
+- =E2=80=9CERROR=E2=80=9D, which indicates that the execution of a test ha=
s failed due to a
+  specific error that is included in the diagnostic data. (note the result=
 of
+  the test case result line should be =E2=80=9Cnot ok=E2=80=9D if the ERRO=
R directive is used)
+
+The diagnostic data is a plain-text field which contains any additional de=
tails
+about why this result was produced. This is typically an error message for=
 ERROR
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
+The test "check return code" passed, with additional diagnostic data =E2=
=80=9Crcode=3D0=E2=80=9D
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
+   - "test_1", which passes, and outputs the diagnostic message "test_1: i=
nitializing test_1"
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
+
+See also:
+---------
+
+- The TAP specification:
+  https://testanything.org/tap-version-13-specification.html
+- The (stagnant) TAP version 14 specification:
+  https://github.com/TestAnything/Specification/blob/tap-14-specification/=
specification.md
+- The kselftest documentation:
+  Documentation/dev-tools/kselftest.rst
+- The KUnit documentation:
+  Documentation/dev-tools/kunit/index.rst
--=20
2.34.1.400.ga245620fadb-goog

