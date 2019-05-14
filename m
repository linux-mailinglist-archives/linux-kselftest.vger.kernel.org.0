Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B591E45B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2019 00:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfENWRk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 May 2019 18:17:40 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:54870 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfENWRk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 May 2019 18:17:40 -0400
Received: by mail-yw1-f74.google.com with SMTP id g203so612346ywe.21
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2019 15:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Wtv/g4YDlWnregZkMuB6vGhT6mZK0s7Z+NfaxgtLekE=;
        b=Q5HMOrwbJNM89YqHu+vD+8sRwSzKie4sE8pkjwQqXKbmvl8uUCrm4SpuFW4UU8JhnY
         XeejyhCTCS9puS98uTFx8EFmIo2ivhwCloJ/U0p1hceMXJW+JMLxh7E0E2tQeOq2UuzA
         uZxI0Ym2j+bs+4rerFEZdMmaFjvrOGk6StJ+TQn+bqsoaYxZ80ISDElTpKf5y0SFPk8h
         VcJ7yADl/NR3VI+Ila1czReqJ0pnzAfR3bA5HRbf56qnKlhiN8U8YpErBnLxR7gClHqR
         Qbxvzr+zfsgs5Z9UI/MeioiOkmyTPiLUIyzAE8HdShxJSC99+danDDMnvJhADTYyrN5z
         MBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Wtv/g4YDlWnregZkMuB6vGhT6mZK0s7Z+NfaxgtLekE=;
        b=iEA3jLtjf1+Ny3MKzBa3/+wUDqMCGJa9grXThcfGSixEIWtDtSXFtBIbSXsJEtqbVU
         /yynNDykfL3Gy48KohEKE0AUGD2oU4WbGUD8Y1Di8mkQrTvBjE6mvIXGK7yzWq3/5UGz
         NJpYoYeoquJw7Fe7l11j47c1zmLsdYDhdK2AK3WlsiGW9Vq9r0iCxU57ftp91RHxOjtG
         WTR/X7eo/t80VjjWo6RJJJjhABzYViJGWwXb615DUpcy4QvJFpQY9xSCU65aH5J0E76f
         Q0dEqQ217NCjvQPYqVw6wJc5uiRZwS/RnGfxphY7TKRGrvTrTK2pOsdsf0u2Q7zuwLoT
         j1eQ==
X-Gm-Message-State: APjAAAWj4/+4dOUGcTIX73FJsU0QsgqpBxIC+l4QFfxc3BJSNkJ/oxbN
        QYhJYooc/9gxB/gKBE1vbi7w68OJSrZ5nxdHc53vlg==
X-Google-Smtp-Source: APXvYqzLw2GNR1CD/N7FU0EOf+vQnR8bF44lpYMHhbVCeioD/fNqnQCXEG9eHOkDZWuQz7kMqOBLBdCDFgs1RbGB1Bb/ig==
X-Received: by 2002:a25:690d:: with SMTP id e13mr18821319ybc.178.1557872259260;
 Tue, 14 May 2019 15:17:39 -0700 (PDT)
Date:   Tue, 14 May 2019 15:16:53 -0700
Message-Id: <20190514221711.248228-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v4 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## TLDR

A quick follow up to yesterday's revision. I got some feedback that I
wanted to incorporate before anyone else read the update. For this
reason, I will leave a TLDR of the biggest changes since v2.

Biggest things to look out for (since v2):

- KUnit core now outputs results in TAP14.
- Heavily reworked tools/testing/kunit/kunit.py
  - Changed how parsing works.
  - Added testing.
  - Greg, Logan, you might want to re-review this.
- Added documentation on how to use KUnit on non-UML kernels. You can
  see the docs rendered here[1].

There is still some discussion going on on the [PATCH v2 00/17] thread,
but I wanted to get some of these updates out before they got too stale
(and too difficult for me to keep track of). I hope no one minds.

## Background

This patch set proposes KUnit, a lightweight unit testing and mocking
framework for the Linux kernel.

Unlike Autotest and kselftest, KUnit is a true unit testing framework;
it does not require installing the kernel on a test machine or in a VM
(however, KUnit still allows you to run tests on test machines or in VMs
if you want) and does not require tests to be written in userspace
running on a host kernel. Additionally, KUnit is fast: From invocation
to completion KUnit can run several dozen tests in under a second.
Currently, the entire KUnit test suite for KUnit runs in under a second
from the initial invocation (build time excluded).

KUnit is heavily inspired by JUnit, Python's unittest.mock, and
Googletest/Googlemock for C++. KUnit provides facilities for defining
unit test cases, grouping related test cases into test suites, providing
common infrastructure for running tests, mocking, spying, and much more.

## What's so special about unit testing?

A unit test is supposed to test a single unit of code in isolation,
hence the name. There should be no dependencies outside the control of
the test; this means no external dependencies, which makes tests orders
of magnitudes faster. Likewise, since there are no external dependencies,
there are no hoops to jump through to run the tests. Additionally, this
makes unit tests deterministic: a failing unit test always indicates a
problem. Finally, because unit tests necessarily have finer granularity,
they are able to test all code paths easily solving the classic problem
of difficulty in exercising error handling code.

## Is KUnit trying to replace other testing frameworks for the kernel?

No. Most existing tests for the Linux kernel are end-to-end tests, which
have their place. A well tested system has lots of unit tests, a
reasonable number of integration tests, and some end-to-end tests. KUnit
is just trying to address the unit test space which is currently not
being addressed.

## More information on KUnit

There is a bunch of documentation near the end of this patch set that
describes how to use KUnit and best practices for writing unit tests.
For convenience I am hosting the compiled docs here[2].

Additionally for convenience, I have applied these patches to a
branch[3].
The repo may be cloned with:
git clone https://kunit.googlesource.com/linux
This patchset is on the kunit/rfc/v5.1/v4 branch.

## Changes Since Last Version

As I mentioned above, there are a significant number of updates since
v2:
- Converted KUnit core to print test results in TAP14 format as
  suggested by Greg and Frank.
- Heavily reworked tools/testing/kunit/kunit.py
  - Changed how parsing works.
  - Added testing.
- Added documentation on how to use KUnit on non-UML kernels. You can
  see the docs rendered here[1].
- Added a new set of EXPECTs and ASSERTs for pointer comparison.
- Removed more function indirection as suggested by Logan.
- Added a new patch that adds `kunit_try_catch_throw` to objtool's
  noreturn list.
- Fixed a number of minorish issues pointed out by Shuah, Masahiro, and
  kbuild bot.

Nevertheless, there are only a couple of minor updates since v3:
- Added more context to the changelog on the objtool patch, as per
  Peter's request.
- Moved all KUnit documentation under the Documentation/dev-tools/
  directory as per Jonathan's suggestion.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.1/v4

-- 
2.21.0.1020.gf2820cf01a-goog

