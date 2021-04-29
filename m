Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C41236F162
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Apr 2021 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbhD2UwH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Apr 2021 16:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbhD2UwC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Apr 2021 16:52:02 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBE4C06138B
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Apr 2021 13:51:13 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id v7-20020a05620a0a87b02902e02f31812fso28801289qkg.6
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Apr 2021 13:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dtgYO1S7XdMlHmgHKpXOFlISeb7ZWP6ta+z/fi7RlbU=;
        b=jFuL+TlClLAojEheY7NZlwRso47kGA92K349+XUxYpYLyR/RKh2MEe7I83WJEM1Qfz
         epQnQJlai5kQ4+6T4OKujuxZVIUgu9d+zVurCcHmZMRzu5bkgc7UyCZSAMwmCRay7Mg6
         yNuyebBe8gTvEKTdWhHEhLqbyxN43NJ2YFF+dC9pk1hyefxaR/4BsQSpBfp6yCG+saZW
         +Dhs2/3tO0qb9Wb8v8VzGLKgTp5rQ4uvLXI0HlkvNzBJvpzS/6TB2qyPdoJDyyTMgX7a
         J+0NjB4V7uFYISLkGYRq6ZLTniZZJJLqsbXkZx3gkUhoMNiTKGpe08QzH+8X4xpDatAu
         /F3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dtgYO1S7XdMlHmgHKpXOFlISeb7ZWP6ta+z/fi7RlbU=;
        b=P9FtQjXWGZ2w2xzE81fvlbIKGW2SWW6NZDO3Ior5WbKc69TFKmM/RXgeRgnkEs13OQ
         ZZx0KYvETRYujf8Irx4Q519B4DOg4946edOvIi38OxSKng/gstopTdLeD88Gde8sSow9
         bBPe0/P4MUiO11MEgggcqic+pzxrpf7DhcDYkmtqarAke7Vkg1ySCW/1ipRLGPxydSt6
         lKR4yiBQgvaAMQSw2Eo686gewkad6FtcBKCIxeSUbTymJOPejxDlv4qGUK74HdN3RIsz
         s92LUdCrw34bh2neiGfd3V8AEOc+0wFx6/cslbcia5RsiM097PAzcXz/HYoFiLrFKI8D
         zuyA==
X-Gm-Message-State: AOAM533Ady37Ho16j6FAFOVhJeN6F2jpktZ67A4b1zIOUGid9zLWdfUz
        VFiXF1cYIJEEZiTyhUIe6BB3Fx4Ncvd+rH0H47uFMQ==
X-Google-Smtp-Source: ABdhPJz5HQSIb3IbjAgzFERiyYXy98nvz2QX7ZMYpTInmokbaHrSH4oBuXMiGKV6ElZs0qQyqGSM6UzTe3GLlFuZJPoqzA==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:bab5:c64e:5a6c:36bd])
 (user=brendanhiggins job=sendgmr) by 2002:a0c:fd8e:: with SMTP id
 p14mr1770099qvr.23.1619729473077; Thu, 29 Apr 2021 13:51:13 -0700 (PDT)
Date:   Thu, 29 Apr 2021 13:51:05 -0700
Message-Id: <20210429205109.2847831-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [RFC v2 0/4] kunit: tool: add support for QEMU
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

What discussion remains for this patchset?
------------------------------------------

The first most obvious thing is settling the debate about
`kunit_shutdown`. If I recall correctly, Kees suggested that it might be
better to just add a new initrd; however, as I mentioned above, now to
support many new architectures, it may be substantially easier to
support this option. So I am hoping with this new usecase, the argument
for `kunit_shutdown` will be more compelling.

The second and likely harder issue is figuring out the best way to
configure and provide configs for running KUnit tests via QEMU. I
provide a pretty primitive way in this patchset which is not super
flexible; for example, for our PPC support we have it set to build big
endian, and POWER8 - we currently don't support a way to change that.
Nevertheless, having sensible defaults is handy too, so we will probably
want to have some support for overriding defaults, while still being
able to have defaults.

[1] http://patches.linaro.org/patch/208336/
[2] https://lkml.org/lkml/2020/6/26/988

Brendan Higgins (3):
  Documentation: Add kunit_shutdown to kernel-parameters.txt
  kunit: tool: add support for QEMU
  Documentation: kunit: document support for QEMU in kunit_tool

David Gow (1):
  kunit: Add 'kunit_shutdown' option

 .../admin-guide/kernel-parameters.txt         |   8 +
 Documentation/dev-tools/kunit/usage.rst       |  37 +++-
 lib/kunit/executor.c                          |  20 ++
 tools/testing/kunit/kunit.py                  |  33 ++-
 tools/testing/kunit/kunit_config.py           |   2 +-
 tools/testing/kunit/kunit_kernel.py           | 209 +++++++++++++++---
 tools/testing/kunit/kunit_parser.py           |   2 +-
 tools/testing/kunit/kunit_tool_test.py        |  15 +-
 8 files changed, 278 insertions(+), 48 deletions(-)


base-commit: 7af08140979a6e7e12b78c93b8625c8d25b084e2
-- 
2.31.1.498.g6c1eba8ee3d-goog

