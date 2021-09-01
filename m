Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2ED3FE3FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Sep 2021 22:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhIAUbf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Sep 2021 16:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhIAUbc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Sep 2021 16:31:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99867C061575
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Sep 2021 13:30:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z15-20020a25868f000000b0059c56f47e94so635384ybk.21
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Sep 2021 13:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=W1dxeMSnjrWamgGdUCD0sYJfSJN9IbPKQnQHF6ba9Zk=;
        b=IQ3nzeVkBaQ3+GaVFpdDRiwa1F5iA/5Zp/cm/bF8X3UWxA4Toc92TTI+eIn+naxoj4
         ET+Zt+Rvu2Fr2/xquoH0yyIu1XZMcmT6cboCyI5rR64pNT2lIrUM9xsZrqNNRFzptE9I
         wsjHcW+VBGjjK0s1f/t7DFUqU3PrzpUZIO7H21qkNMgtq3NBIoSIXL8a6Wi2vk1qkqG1
         BaUOcKIMQ08Iy5Y7BqvrFMwn+huvKoc2AWIhhSBz+VoHhzJ2fNfVJZIWBlgZKOH4ctt1
         0w2Bp1svSX94Jl0zODWdtTreSksXnGqUiHiy/S7N6hf8RY5t4uNFQqLBoR2dt7fhnNYr
         B6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=W1dxeMSnjrWamgGdUCD0sYJfSJN9IbPKQnQHF6ba9Zk=;
        b=Y6E/W/t7VrkqWGsmvbYciBp++wupLSUpKI1QiK9OUNTYy2D3ZMnf/Dm88yPJaKd9je
         otKCiHjdS2184XjXXw8HOeURZGyseqJunBvOQSieM/QVpQa2aEnBFXIc5ZUgiZQhmMJc
         5NfyTNNMQreDfPFTg5z4p7OLYf4P8/hxql70ae2jG+ZNFo4ncecZyc5mSRiLLpSFBNXd
         BWvM2sdBa5wwQXPO1rQD4RPDQsYum6McMnTOAhWSD6IigxcdVfWia7qMYg2rvS2cXZdc
         IH5yz4YpIW0ERzRzRA61HwNb29N1grT3jzLWCBG4thA1qLPg+P3QzKp3dH5xUIxzWVcT
         LrGA==
X-Gm-Message-State: AOAM53141Xr1eZo8sySZLaefzJRFR4nEba5JLI+sPrOwGGYmayTCN/pA
        coQMihwG4/0RgVXrP0kZaf97QvD6F5E=
X-Google-Smtp-Source: ABdhPJztMghe8pf2r0RN3BmnZkigpSEdqe6AO5tWh0SkJaCpcvF1MtRyRWIuMac/iI8RQmjvTQ8oDXGaxcw=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:9935:5a5e:c7b6:e649])
 (user=seanjc job=sendgmr) by 2002:a05:6902:513:: with SMTP id
 x19mr1875181ybs.90.1630528234743; Wed, 01 Sep 2021 13:30:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  1 Sep 2021 13:30:25 -0700
Message-Id: <20210901203030.1292304-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v3 0/5] KVM: rseq: Fix and a test for a KVM+rseq bug
From:   Sean Christopherson <seanjc@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Patch 1 fixes a KVM+rseq bug where KVM's handling of TIF_NOTIFY_RESUME,
e.g. for task migration, clears the flag without informing rseq and leads
to stale data in userspace's rseq struct.

Patch 2 is a cleanup to try and make future bugs less likely.  It's also
a baby step towards moving and renaming tracehook_notify_resume() since
it has nothing to do with tracing.

Patch 3 is a fix/cleanup to stop overriding x86's unistd_{32,64}.h when
the include path (intentionally) omits tools' uapi headers.  KVM's
selftests do exactly that so that they can pick up the uapi headers from
the installed kernel headers, and still use various tools/ headers that
mirror kernel code, e.g. linux/types.h.  This allows the new test in
patch 4 to reference __NR_rseq without having to manually define it.

Patch 4 is a regression test for the KVM+rseq bug.

Patch 5 is a cleanup made possible by patch 3.

Based on commit 835d31d319d9 ("Merge tag 'media/v5.15-1' of ...").

v3:
  - Collect Ack/Review. [Mathieu, Ben]
  - Add explicit smp_wmb() instead of relying on atomic_inc() to do a full
    barrier. [Mathieu]
  - Add lots and lots of comments in the selftest, especially around why
    the migration thread needs a udelay(). [Mathieu]
  - Delay between 1us and 10us to reduce the odds of having a hard
    dependency on arch/kernel behavior.  [Mathieu]
  - Dropped an s390 change in patch 2 after a rebase to upstream master.

v2:
  - https://lkml.kernel.org/r/20210820225002.310652-1-seanjc@google.com
  - Don't touch rseq_cs when handling KVM case so that rseq_syscall() will
    still detect a naughty userspace. [Mathieu]
  - Use a sequence counter + retry in the test to ensure the process isn't
    migrated between sched_getcpu() and reading rseq.cpu_id, i.e. to
    avoid a flaky test. [Mathieu]
  - Add Mathieu's ack for patch 2.
  - Add more comments in the test.

v1: https://lkml.kernel.org/r/20210818001210.4073390-1-seanjc@google.com

Sean Christopherson (5):
  KVM: rseq: Update rseq when processing NOTIFY_RESUME on xfer to KVM
    guest
  entry: rseq: Call rseq_handle_notify_resume() in
    tracehook_notify_resume()
  tools: Move x86 syscall number fallbacks to .../uapi/
  KVM: selftests: Add a test for KVM_RUN+rseq to detect task migration
    bugs
  KVM: selftests: Remove __NR_userfaultfd syscall fallback

 arch/arm/kernel/signal.c                      |   1 -
 arch/arm64/kernel/signal.c                    |   1 -
 arch/csky/kernel/signal.c                     |   4 +-
 arch/mips/kernel/signal.c                     |   4 +-
 arch/powerpc/kernel/signal.c                  |   4 +-
 include/linux/tracehook.h                     |   2 +
 kernel/entry/common.c                         |   4 +-
 kernel/rseq.c                                 |  14 +-
 .../x86/include/{ => uapi}/asm/unistd_32.h    |   0
 .../x86/include/{ => uapi}/asm/unistd_64.h    |   3 -
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 tools/testing/selftests/kvm/rseq_test.c       | 236 ++++++++++++++++++
 13 files changed, 257 insertions(+), 20 deletions(-)
 rename tools/arch/x86/include/{ => uapi}/asm/unistd_32.h (100%)
 rename tools/arch/x86/include/{ => uapi}/asm/unistd_64.h (83%)
 create mode 100644 tools/testing/selftests/kvm/rseq_test.c

-- 
2.33.0.153.gba50c8fa24-goog

