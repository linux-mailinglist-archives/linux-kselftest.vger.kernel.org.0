Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754A5702AEC
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 12:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbjEOKzf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 06:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbjEOKze (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 06:55:34 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D80C10F3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 03:55:33 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-77d218b74cdso3694559241.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 03:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684148132; x=1686740132;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zl70zTEBArfF6eM/itV88/Ihv7L5dJb+Bq1w/eYn/JY=;
        b=ByQbNXpRcxoI1h14hMmzXNeum2EXAhJwRQbnuqx4gGgO8ioteDx3+Ww6YNcDfQ5XqG
         7pQc/qmsjGKxVdySTRwNEF6CZXV0ZiaPVy2w8aiYdmW7DZT+C7GbUJVhPn+6YsuM5M+F
         +HCPYhTFVhHSvkjpA3eh92zGAQ5R9qst6oELNUWsfc1v5+ErLH/RECy3SEWm+BOoi7DO
         370C5Rh8WP/CNvQx1CAvq4bcQyLV4DkRKGtiUrysLu40NeWLRwOQokvdcLdZFYnOc60i
         JzYyzpPJJ92GvNaFdpVKOttGEeQ951NV/Mhw9SWMpOg9E8iYHfMghajcKRpNXi08iVSI
         eYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684148132; x=1686740132;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zl70zTEBArfF6eM/itV88/Ihv7L5dJb+Bq1w/eYn/JY=;
        b=TKl1WeYOPhPa+j9Alsrob+fFzTtusEoxb7YIMmQWcDgRl15Pi11/75U44fpbqje0P9
         2zE2KR0CmqhFrJaFsTqZP2yeVDIjBiDReF5Y1PO9MpZjHhrnuBKcmCyTszOU1qD4BB+8
         u0XnCvwTNpQ73W8ESrLrxLg+dN6JF7SsSmq8qOus+BQQPnF5uk0PYAVSWYM13hhxqoRy
         2NV3YO98l1eaqPQmSpYk0VPlqv7TWddK6CuMkyZXIkK1af2WOsrLWZB5UuspJ7da+otF
         vEaleTOQsxK3xY0FsDjw1vlRPR6r+pOM0QX3Ht/pWALwMg8O4OGJBWO5sHfvKlW98yTa
         JqCg==
X-Gm-Message-State: AC+VfDwRaE/w6pX9jSqg87+embyhh63GCK7gBaBlJmC3vKbC2itgUsHB
        2w0RbKq/adPTdNr+JfsFgDA5NBDFUHc9bUk3m2nsKzkJXLnSZMa8Juxf+A==
X-Google-Smtp-Source: ACHHUZ5Z43/jj5a+Wf14scaZq+2/R6j34GZRFRvk2a/6q0K+1bDEBMgS7mKwQa68VPhh7h4gpLlwNXJosQmtjXnjYL4=
X-Received: by 2002:a67:f946:0:b0:436:4dda:ee63 with SMTP id
 u6-20020a67f946000000b004364ddaee63mr2369734vsq.0.1684148131970; Mon, 15 May
 2023 03:55:31 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 15 May 2023 16:25:20 +0530
Message-ID: <CA+G9fYvcXKxGrMLDSS=BV=k+SN7h78+hVOxG5De47tbbXr1WYQ@mail.gmail.com>
Subject: selftests: x86: mov_ss_trap_64 numbering_64 amx_64 lam_64 failed
To:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following selftests x86 test cases failing
Unsupported feature can be marked as skipped instead of fail ?

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

 - x86_mov_ss_trap_64 fail
 - x86_syscall_numbering_64 fail
 - x86_amx_64 fail
 - x86_lam_64 fail

# selftests: x86: mov_ss_trap_64
# SS = 0x2b, &SS = 0x0x404188
# Set up a watchpoint
# DR0 = 404188, DR1 = 401368, DR7 = 7000a
# Segmentation fault
not ok 10 selftests: x86: mov_ss_trap_64 # exit=139

# selftests: x86: syscall_numbering_64
...
not ok 16 selftests: x86: syscall_numbering_64 # TIMEOUT 45 seconds

## The default timeout after 45 seconds occurred due to slow qemu-x86_64
## pass on x86 device and other fast qemu_x86_64.

# selftests: x86: amx_64
# amx_64: [FAIL] cpuid: no CPU xsave support: Success
not ok 18 selftests: x86: amx_64 # exit=1

# selftests: x86: lam_64
# # Unsupported LAM feature!
not ok 19 selftests: x86: lam_64 # exit=255


links,
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-rc2/testrun/16949493/suite/kselftest-x86/tests/
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-rc2/testrun/16949493/suite/kselftest-x86/test/x86_syscall_numbering_64/history/?page=2


Steps to reproduce:
------------
# To install tuxrun on your system globally:
# sudo pip3 install -U tuxrun==0.42.0
#
# See https://tuxrun.org/ for complete documentation.

tuxrun   \
 --runtime podman   \
 --device qemu-x86_64   \
 --boot-args rw   \
 --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2PnaPptGlD8AJHQHUvVnCbca522/bzImage
  \
 --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2PnaPptGlD8AJHQHUvVnCbca522/modules.tar.xz
  \
 --rootfs https://storage.tuxboot.com/debian/bookworm/amd64/rootfs.ext4.xz   \
 --parameters SKIPFILE=skipfile-lkft.yaml   \
 --parameters KSELFTEST=https://storage.tuxsuite.com/public/linaro/lkft/builds/2PnaPptGlD8AJHQHUvVnCbca522/kselftest.tar.xz
  \
 --image docker.io/lavasoftware/lava-dispatcher:2023.01.0020.gc1598238f   \
 --tests kselftest-x86   \
 --timeouts boot=15


--
Linaro LKFT
https://lkft.linaro.org
