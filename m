Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D1D668FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2019 10:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfGLIRw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jul 2019 04:17:52 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:55744 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfGLIRv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jul 2019 04:17:51 -0400
Received: by mail-pg1-f202.google.com with SMTP id b10so5261103pgb.22
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2019 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UvKno1DQ1En2T0BAydqL8aKwWtOHxHpLOB0ZXuFETLs=;
        b=JtlStr7snNzmz5ulMB5eP37s7rbgIx50z+AVGP2t2WlEdfRbEZO8W2XTT3bE3WZnLv
         keBpChTguji20fGG9MZtiJLfIGuGAQMR0xBWsqfAPNv7xBwu2S4omSfLGIwdCobd9HG0
         xEIx+MC/l52zarabPfgQ095HslgbhlLi4Z2VOa7yRbXGn1OMnhIjlbG9wufHRgT48Rw8
         N31KLcKdJR3xIPKj8X7rcKFfr9bJzXFefGvAJSqFErU5ciZBVgJrNxh12tyuyphu+Fd0
         ntbZjblO4lofJT/rrUQvPdmmolFfkVV45QPFi2V3CSuuX8nBjrc2V4ynCPPNIkIg5MTd
         4B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UvKno1DQ1En2T0BAydqL8aKwWtOHxHpLOB0ZXuFETLs=;
        b=tn9VwJDcsAaWC4XRPvO1rxzXzdygDAduPSgjplMPLZOqs1JuOxyJQ2k1v7RCMw9qJW
         19KOTK+v9taTxyHkpDFryWoln+kBxvHt/TO/436hGQAXAajfrc0daHXmnKYqD3mgARQw
         TPZJS1GMg6wClZ+QwoWOS5tG4+NSAQDsSM+ShKiYOLWFDnWXfAsLjS/V9vM9z3x3ASlW
         7DmF1GOlAIuENNf6Axls6GWyVqFhbI04uzdazA8C1z+vX/Wrf5pgnfl03wVUCUsO3Gxy
         r0n4mYPoDEX6v4rIFfZ8zWQIh96+cDaZDe0rC3VnvLNQ1Zi72LrjZDEjV8wC3A3LlBxQ
         98fw==
X-Gm-Message-State: APjAAAUG+2i05tHYGDhV17uo683fOvQmbmgdARYNfYvKg10keXP19sqt
        KQyZi9aj3GQcnxWczZTbQzkn5/RQS+0qDFrYWLA/4A==
X-Google-Smtp-Source: APXvYqwxVjSSyLsmH5X5K9D5aFhrhgELvG+6tDMdeYJeUGZ3SfBpCQBrCaJmP5g1KYNhq+xNRut9+ZtuWUgQ3Ro3jfxY+Q==
X-Received: by 2002:a65:5348:: with SMTP id w8mr9232476pgr.176.1562919470178;
 Fri, 12 Jul 2019 01:17:50 -0700 (PDT)
Date:   Fri, 12 Jul 2019 01:17:26 -0700
Message-Id: <20190712081744.87097-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 00/18] kunit: introduce KUnit, the Linux kernel unit
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
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## TL;DR

This new patch set only contains a very minor change to address a sparse
warning in the PROC SYSCTL KUnit test. Otherwise this patchset is
identical to the previous.

As I mentioned in the previous patchset, all patches now have acks and
reviews.

## Background

This patch set proposes KUnit, a lightweight unit testing and mocking
framework for the Linux kernel.

Unlike Autotest and kselftest, KUnit is a true unit testing framework;
it does not require installing the kernel on a test machine or in a VM
(however, KUnit still allows you to run tests on test machines or in VMs
if you want[1]) and does not require tests to be written in userspace
running on a host kernel. Additionally, KUnit is fast: From invocation
to completion KUnit can run several dozen tests in about a second.
Currently, the entire KUnit test suite for KUnit runs in under a second
from the initial invocation (build time excluded).

KUnit is heavily inspired by JUnit, Python's unittest.mock, and
Googletest/Googlemock for C++. KUnit provides facilities for defining
unit test cases, grouping related test cases into test suites, providing
common infrastructure for running tests, mocking, spying, and much more.

### What's so special about unit testing?

A unit test is supposed to test a single unit of code in isolation,
hence the name. There should be no dependencies outside the control of
the test; this means no external dependencies, which makes tests orders
of magnitudes faster. Likewise, since there are no external dependencies,
there are no hoops to jump through to run the tests. Additionally, this
makes unit tests deterministic: a failing unit test always indicates a
problem. Finally, because unit tests necessarily have finer granularity,
they are able to test all code paths easily solving the classic problem
of difficulty in exercising error handling code.

### Is KUnit trying to replace other testing frameworks for the kernel?

No. Most existing tests for the Linux kernel are end-to-end tests, which
have their place. A well tested system has lots of unit tests, a
reasonable number of integration tests, and some end-to-end tests. KUnit
is just trying to address the unit test space which is currently not
being addressed.

### More information on KUnit

There is a bunch of documentation near the end of this patch set that
describes how to use KUnit and best practices for writing unit tests.
For convenience I am hosting the compiled docs here[2].

Additionally for convenience, I have applied these patches to a
branch[3]. The repo may be cloned with:
git clone https://kunit.googlesource.com/linux
This patchset is on the kunit/rfc/v5.2/v9 branch.

## Changes Since Last Version

Like I said in the TL;DR, there is only one minor change since the
previous revision. That change only affects patch 17/18; it addresses a
sparse warning in the PROC SYSCTL unit test.

Thanks to Masahiro for applying previous patches to a branch in his
kbuild tree and running sparse and other static analysis tools against
my patches.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2/v9

-- 
2.22.0.410.gd8fdbe21b5-goog

