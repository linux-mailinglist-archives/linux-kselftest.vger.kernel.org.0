Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88549BABA
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2019 03:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfHXBeh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Aug 2019 21:34:37 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:46350 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfHXBeh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Aug 2019 21:34:37 -0400
Received: by mail-vs1-f74.google.com with SMTP id b129so3195398vsd.13
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Aug 2019 18:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=u6vmmnwRUzLKD5y/rsoe3hBquEKZMDYQLdEtGhcWv3g=;
        b=HVklJPxbqbRBtpBK3hdl+VswNRV4P2EWUoTQ6/jzlla/43tMUYx52ieNsrWja1cMAd
         aJXK63eT0AeMDFxYtZyBESJGuF52uPkRIRazyPmUFSSpZlHx/sV1I2pC8wcJoG/Jy+z7
         0ebrqRvPPaqx+epAoYNiv2Z6F0OPXUrzfluIz3B0PZsRxGAjoAWPYO3kBtG4yhrHecAA
         fwkXjbrqFMOaTYkIzZof+8WI+OZNq8YRk4OSEiBdVc0hDOjOiYENTJZIZIQpFAlgeRT6
         5UwDu9vDrX9VEXJMCDM32wr6kC4xm78SHY7UBAnZUT4L8JjxDdyUQ0eJ2Gew4CMdHuAQ
         esXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=u6vmmnwRUzLKD5y/rsoe3hBquEKZMDYQLdEtGhcWv3g=;
        b=N4ZgO2ZZI/TXJLetXHg0qsb3QisDJ0xBwtwCwGfVjIXAoQqf6Nx0pXHR9/I4ITk7h6
         Y88LrXCE8ey7pOHZxiXxEoLEA1jkNpG7RTLFRKOQUeuSBTrXaFf/F8+B9BF+sfFY3GXS
         Sm/HLOjPq62qGFbgM5hWbQXr+oMMib+fweKSVjTIikTAdJ5hVRdPbqiQZMg+x8/s9uIc
         lGyM7LQl0ekuNcFofgUD2/dhYP5hc9c+J2qByOY2fhNNNfxHWoIF393IJBoWXJZ8tkyv
         bLhPHAnchoEuOGw1fCjkvOSd7qXmbR+CKzpFXmIKTvhJxse10fMhQMeeVk8XWG4LRYCp
         X+/w==
X-Gm-Message-State: APjAAAUaWRPXrLd2RTuM0ZaJ5BIq/kqFK3Y0T/y+6hTC3fhflt5FtzKl
        ruM4KOV7poCI3WTYE310hXvQ9MCRl91G4PNxH7n8yw==
X-Google-Smtp-Source: APXvYqwBNX0MXCogqcD2ZWv4/PeYSKyopYGJC89lxHpR6CjYFzzu83jqcycsHbnwRnQxtUoBH+I61TfjBVcTRyxmbsVxMw==
X-Received: by 2002:a67:dd91:: with SMTP id i17mr4328220vsk.21.1566610475582;
 Fri, 23 Aug 2019 18:34:35 -0700 (PDT)
Date:   Fri, 23 Aug 2019 18:34:07 -0700
Message-Id: <20190824013425.175645-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v15 00/18] kunit: introduce KUnit, the Linux kernel unit
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

## TL;DR

This revision addresses comments from Shuah by fixing a couple
checkpatch warnings and fixing some comment readability issues. No API
or major structual changes have been made since v13.

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
This patchset is on the kunit/rfc/v5.3/v15 branch.

## Changes Since Last Version

- Moved comment from inline in macro to kernel-doc to address checkpatch
  warning.
- Demoted BUG() to WARN_ON.
- Formatted some kernel-doc comments to make them more readible.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.3/v15

-- 
2.23.0.187.g17f5b7556c-goog

