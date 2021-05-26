Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DE33921F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 23:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhEZVZq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 17:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhEZVZq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 17:25:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24C6C06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 14:24:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k34-20020a25b2a20000b02905149e86803eso3206195ybj.9
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9okIvi+X1htjg1cyj98qs5wA20hMIDWTyPU/QT/n3TM=;
        b=LIUyIiE+oujE06wyd02Isz6HB+vA1TeSXALb+n9kj9Z5lFfGwDmy8aljPIa9udFg1k
         tb16WVsm69K1zZFqkQEQ46c6KEVzDi/jml1shZK/SPps8p0eEUva41TQZVYlX8dVz+3X
         P6DindVI+/tOaSG3yXm2PxZlOlMcV3jc3L6rrNjkjPnsCzEQ0xMveg6BIs1RFBNYOAok
         uZgrL/YmJIDDWiYzlwcgEnS+XCFl04w5Hi+2PYhWOaaqdBYZ5E2upogB3DIhdv4EENQM
         eq7DDvtSmFOxxJIykQvTxucV5XAmxxBMEEQFsvqS6w3ay3BiQULMFx6uwdQo8Z1sOfqn
         hqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9okIvi+X1htjg1cyj98qs5wA20hMIDWTyPU/QT/n3TM=;
        b=U4JaYb9FRzhTOssfDJw63VDUBIowm3ijEvzLGOQh+qD0u+LGBPsJkTbiPxwhfncsW/
         +EI4MFqdi2yfYO0ewd0y+Iay1nyeTB+tVqSAis5J8xZaDSh2XLP5TA0QySuaSTP6pXFW
         lbam8UFkdyt2H/txLTvyp8X7N5ZhD9hcF3b9B2a+73S8vK/PdcfxJ7tB2vqwpGx9TL/U
         lfJaWyRtkquw3BxEG2XogZ/M+sOoidN26RmSHaIePcZA118eRBYU7DiKeSeZ8msWMtYG
         EfvppttSrn7VNnraE+EsNThUvdM0Ecl0EVbKQ2buB3yXkFkfoQvcZTRDM/y7VvNfwEo8
         UY5w==
X-Gm-Message-State: AOAM530cB0SpWuP9+s8QcUWZhbM7o6CxfjrXOLXm1rVwwzmeIEMJJpX9
        oVLF7WGZ3xhv4hhpO3cRDC2YAhobZ3KftJ83k/PEdw==
X-Google-Smtp-Source: ABdhPJwdjc6UP/ZZUJeUs4cgA8LHIo+lhX/G1LJ35xLm9QMLOKPm1yyGekkqDdxZWORJA1vA3wl0tV7F5ZqOPgINtbaDFQ==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:2a22:5aa3:3643:4ddb])
 (user=brendanhiggins job=sendgmr) by 2002:a25:6d82:: with SMTP id
 i124mr95766ybc.78.1622064253777; Wed, 26 May 2021 14:24:13 -0700 (PDT)
Date:   Wed, 26 May 2021 14:24:03 -0700
Message-Id: <20210526212407.2753879-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v2 0/4] kunit: tool: add support for QEMU
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, sboyd@kernel.org, keescook@chromium.org,
        frowand.list@gmail.com, dlatypov@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

TL;DR: Add support to kunit_tool to dispatch tests via QEMU. Also add
support to immediately shutdown a kernel after running KUnit tests.

Background
----------

KUnit has supported running on all architectures for quite some time;
however, kunit_tool - the script commonly used to invoke KUnit tests -
has only fully supported KUnit run on UML. Its functionality has been
broken up for some time to separate the configure, build, run, and parse
phases making it possible to be used in part on other architectures to a
small extent. Nevertheless, kunit_tool has not supported running tests
on other architectures.

What this patchset does
-----------------------

This patchset introduces first class support to kunit_tool for KUnit to
be run on many popular architectures via QEMU. It does this by adding
two new flags: `--arch` and `--cross_compile`.

`--arch` allows an architecture to be specified by the name the
architecture is given in `arch/`. It uses the specified architecture to
select a minimal amount of Kconfigs and QEMU configs needed for the
architecture to run in QEMU and provide a console from which KTAP
results can be scraped.

`--cross_compile` allows a toolchain prefix to be specified to make
similar to how `CROSS_COMPILE` is used.

Additionally, this patchset revives the previously considered "kunit:
tool: add support for QEMU"[1] patchs. The motivation for this new
kernel command line flags, `kunit_shutdown`, is to better support
running KUnit tests inside of QEMU. For most popular architectures, QEMU
can be made to terminate when the Linux kernel that is being run is
reboted, halted, or powered off. As Kees pointed out in a previous
discussion[2], it is possible to make a kernel initrd that can reboot
the kernel immediately, doing this for every architecture would likely
be infeasible. Instead, just having an option for the kernel to shutdown
when it is done with testing seems a lot simpler, especially since it is
an option which would only available in testing configurations of the
kernel anyway.

Changes since last revision
---------------------------

I pulled out the QemuConfigs into their own files; the way in which I
did this also allows new QemuConfigs to be added without making any
changes to kunit_tool.

I changed how Kconfigs are loaded; they are now merged inside of
kunit_tool instead of letting Kbuild do it.

I also made numerous nit fixes.

Finally, I added a new section to the kunit_tool documentation to
document the new command line flags I added.

[1] http://patches.linaro.org/patch/208336/
[2] https://lkml.org/lkml/2020/6/26/988

Brendan Higgins (3):
  Documentation: Add kunit_shutdown to kernel-parameters.txt
  kunit: tool: add support for QEMU
  Documentation: kunit: document support for QEMU in kunit_tool

David Gow (1):
  kunit: Add 'kunit_shutdown' option

 .../admin-guide/kernel-parameters.txt         |   8 +
 Documentation/dev-tools/kunit/kunit-tool.rst  |  48 +++++
 Documentation/dev-tools/kunit/usage.rst       |  50 +++--
 lib/kunit/executor.c                          |  20 ++
 tools/testing/kunit/kunit.py                  |  57 +++++-
 tools/testing/kunit/kunit_config.py           |   7 +-
 tools/testing/kunit/kunit_kernel.py           | 177 +++++++++++++++---
 tools/testing/kunit/kunit_parser.py           |   2 +-
 tools/testing/kunit/kunit_tool_test.py        |  18 +-
 tools/testing/kunit/qemu_config.py            |  16 ++
 tools/testing/kunit/qemu_configs/alpha.py     |  10 +
 tools/testing/kunit/qemu_configs/arm.py       |  13 ++
 tools/testing/kunit/qemu_configs/arm64.py     |  12 ++
 tools/testing/kunit/qemu_configs/i386.py      |  10 +
 tools/testing/kunit/qemu_configs/powerpc.py   |  12 ++
 tools/testing/kunit/qemu_configs/riscv.py     |  31 +++
 tools/testing/kunit/qemu_configs/s390.py      |  14 ++
 tools/testing/kunit/qemu_configs/sparc.py     |  10 +
 tools/testing/kunit/qemu_configs/x86_64.py    |  10 +
 19 files changed, 471 insertions(+), 54 deletions(-)
 create mode 100644 tools/testing/kunit/qemu_config.py
 create mode 100644 tools/testing/kunit/qemu_configs/alpha.py
 create mode 100644 tools/testing/kunit/qemu_configs/arm.py
 create mode 100644 tools/testing/kunit/qemu_configs/arm64.py
 create mode 100644 tools/testing/kunit/qemu_configs/i386.py
 create mode 100644 tools/testing/kunit/qemu_configs/powerpc.py
 create mode 100644 tools/testing/kunit/qemu_configs/riscv.py
 create mode 100644 tools/testing/kunit/qemu_configs/s390.py
 create mode 100644 tools/testing/kunit/qemu_configs/sparc.py
 create mode 100644 tools/testing/kunit/qemu_configs/x86_64.py


base-commit: d7eab3df8f39b116d934bc17f8070861e18cfb62
-- 
2.31.1.818.g46aad6cb9e-goog

