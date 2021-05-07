Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35278376BC2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 May 2021 23:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhEGVcb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 May 2021 17:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhEGVcb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 May 2021 17:32:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19FAC061761
        for <linux-kselftest@vger.kernel.org>; Fri,  7 May 2021 14:31:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s8-20020a5b04480000b029049fb35700b9so11765474ybp.5
        for <linux-kselftest@vger.kernel.org>; Fri, 07 May 2021 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cQaK7keE0QRM0e4/CjmvDPViL+K1rpJ0LQ0dw+WC038=;
        b=dmpwqmI+QNSidbhJ4KlBhhjHMA/XLMoX4551oMz4YuRiLwKYQ4kyNztcr7FP+TxdNm
         6UMyxG4lt3swikmwV1K+XjayREeQH60E6UnD6qL4zjO1yU+CGggvPzWM+CTzITeB42nV
         xbKPtNhTf/5tW84bsIguhK0RjUjVIf9E9xD34vzKluZaWOqYguVw5UMwqwl6XdpACpO6
         w7EwmW4xPbVpsJtiNjKDJMJOjpDeOd/nnBN5Yiw8qgS8DnVQv7zBO2ZBYNX8gRj1t4RY
         eWitCrJczy+bp1dq1mjTdqpQxiB7Fj+xxOoIscAk1Gjk/tUSRPE/+mTwfdDt+Hv669p9
         SWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cQaK7keE0QRM0e4/CjmvDPViL+K1rpJ0LQ0dw+WC038=;
        b=MsI+jEOpdN0naMJQRUuDLFGG9JWxNHlK7EhpzJCe4RpYQzMnct8U+cEjwMbIZRSbH/
         BdyfnFFwT9pXsyQ1MPQAP5sZ52H4S74OaxiJ17HOH3NeoaNEmJ6Q0lhcmIs5V6+uR+Wd
         APRcv+I+oQnsqExcmHSRP+6mXRn2i6jTdGa1NLI2xrOLuZ7vDml8l50lMWNcx9jsRI6p
         mOMNVr4XQa0h6vhDWR/Sqm0qI7enesS/jK8OLKYMooWY4MF2GHPwEeRjPIzINqu+XmWq
         jcYYW3wddm2oTKDK352ycEWvUMZ32fq+QBnv6Xa01yWSn9RNrJtk0KzBJATpEJK1PWFD
         d8eQ==
X-Gm-Message-State: AOAM532BiaxGlt0O4L1BQIWApJOeF8yDOaHHlkNLF6Rlnee5X1sGHHSI
        qqQWiKPVWD+wG1MbEdsn2XW8Bk6CLldCZ3u6u1RTpw==
X-Google-Smtp-Source: ABdhPJw04MjOEIGjcdEhEjiyjvznn6dnzusSglnmDUp3y5c7FjnTyuOyWeSrKMe2H5uzSZflWys2THpyshdaXtJkxvY6mQ==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:8b7:10d:a11b:ba0c])
 (user=brendanhiggins job=sendgmr) by 2002:a25:d04f:: with SMTP id
 h76mr12140487ybg.261.1620423090124; Fri, 07 May 2021 14:31:30 -0700 (PDT)
Date:   Fri,  7 May 2021 14:31:06 -0700
Message-Id: <20210507213110.155492-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v1 0/4] kunit: tool: add support for QEMU
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

Mostly fixed lots of minor issues suggested/poited out by David and
Daniel. Also reworked how qemu_configs are loaded: Now each config is in
its own Python file and is loaded dynamically. Given the number of
improvements that address the biggest concerns I had in the last RFC, I
decided to promote this to a normal patch set.

What discussion remains for this patchset?
------------------------------------------

I am still hoping to see some discussion regarding the kunit_shutdown
patch: I want to make sure with the added context of QEMU running under
kunit_tool that this is now a reasonable approach. Nevertheless, I am
pretty happy with this patchset as is, and I did not get any negative
feedback on the previous revision, so I think we can probably just move
forward as is.

Brendan Higgins (3):
  Documentation: Add kunit_shutdown to kernel-parameters.txt
  kunit: tool: add support for QEMU
  Documentation: kunit: document support for QEMU in kunit_tool

David Gow (1):
  kunit: Add 'kunit_shutdown' option

 .../admin-guide/kernel-parameters.txt         |   8 +
 Documentation/dev-tools/kunit/usage.rst       |  37 +++-
 lib/kunit/executor.c                          |  20 ++
 tools/testing/kunit/kunit.py                  |  57 +++++-
 tools/testing/kunit/kunit_config.py           |   7 +-
 tools/testing/kunit/kunit_kernel.py           | 172 +++++++++++++++---
 tools/testing/kunit/kunit_parser.py           |   2 +-
 tools/testing/kunit/kunit_tool_test.py        |  18 +-
 tools/testing/kunit/qemu_config.py            |  17 ++
 tools/testing/kunit/qemu_configs/alpha.py     |  10 +
 tools/testing/kunit/qemu_configs/arm.py       |  13 ++
 tools/testing/kunit/qemu_configs/arm64.py     |  12 ++
 tools/testing/kunit/qemu_configs/i386.py      |  10 +
 tools/testing/kunit/qemu_configs/powerpc.py   |  12 ++
 tools/testing/kunit/qemu_configs/riscv.py     |  31 ++++
 tools/testing/kunit/qemu_configs/s390.py      |  14 ++
 tools/testing/kunit/qemu_configs/sparc.py     |  10 +
 tools/testing/kunit/qemu_configs/x86_64.py    |  10 +
 18 files changed, 411 insertions(+), 49 deletions(-)
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


base-commit: 38182162b50aa4e970e5997df0a0c4288147a153
-- 
2.31.1.607.g51e8a6a459-goog

