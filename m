Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EAC7D37ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjJWNZl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 09:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjJWNZO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 09:25:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F8A270C;
        Mon, 23 Oct 2023 06:23:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2B8C433C9;
        Mon, 23 Oct 2023 13:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698067406;
        bh=WuXo+hl017On/dv4mXs2jfRGaw2UtVf9077Uy1SbwGI=;
        h=From:Subject:Date:To:Cc:From;
        b=opVAdzew2cj23GxSoUDjFLwrfwYXiZMmeiEu7MJBKUIZwRain6lhHn0qy3Be+OVDv
         PtYkQIUsxaVUiSikZkpuQVqibgAg7UYGeOGLbSOcHHSZ6STOoQcFbYxU3TM7P1Nh/b
         kFEbukMHw92d/8nZ2U4bd7JtRhxOgjWoHedD8uemMn5Nxu73jmD7Scxbcs6C8+P7KM
         WJPcr/oOsDCigWnaTcs6JVcJm8FQeszUnqpAxzW+y+PsliKtuurpPdRF1fZgYyKR1H
         KlD4/WIXHu3XOMNFnjVnrtNIsB+0rHzcWgc8kWWiAiU3QfwyJ+1YEybwrP9S+GIuk4
         uyRWETRpIB8/g==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH RFC RFT 0/5] fork: Support shadow stacks in clone3()
Date:   Mon, 23 Oct 2023 14:20:39 +0100
Message-Id: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAChzNmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA0NL3eSc/LxUY93ijMSU/HLd4pLE5GxdQ9MUE4MUo6Q0U2MzJaDOgqL
 UtMwKsKnRSkFuziCxILcQpdjaWgBkqKSUcQAAAA==
To:     "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        David Hildenbrand <david@redhat.com>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4488; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WuXo+hl017On/dv4mXs2jfRGaw2UtVf9077Uy1SbwGI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlNnPC6R+tB0Xy00AJDIdmFhiDw43xBruz0mgu1aUK
 0yMkzauJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTZzwgAKCRAk1otyXVSH0L2nB/
 sGH3e076WCR4fBGI26gY30gODX/A7H4HzZA5XzxsBALw1UpV7dYno2Et+pFxbiE+ixbTiLhye7903K
 K1Vu8vqZqaWnK8jDCAdr/jaKNcQJ8fDSiFQHOFWymYl9t8zPZ2GsZD10Z5vAjCqpUm5lBtNqIBPSg+
 xNYOcuABDCGtrHefdjECAXpWIhlTabVtfFfzT4tJHjpAJiiYrpjydxnq8kvPK/y/bdG5DJQLDmpvju
 Bev+TPPk/d5yfKaDBF373iRut9QbrE44b8PIFxc4b85sEcSO5SyJgbV/AlNAtvpdsEnx98xJYMfynb
 AENS0iX2NSUY+bqi6Lt+Yu/RjY574v
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kernel has recently added support for shadow stacks, currently
x86 only using their CET feature but both arm64 and RISC-V have
equivalent features (GCS and Zisslpcfi respectively), I am actively
working on GCS[1].  With shadow stacks the hardware maintains an
additional stack containing only the return addresses for branch
instructions which is not generally writeable by userspace and ensures
that any returns are to the recorded addresses.  This provides some
protection against ROP attacks and making it easier to collect call
stacks.  These shadow stacks are allocated in the address space of the
userspace process.

Our API for shadow stacks does not currently offer userspace any
flexiblity for managing the allocation of shadow stacks for newly
created threads, instead the kernel allocates a new shadow stack with
the same size as the normal stack whenever a thread is created with the
feature enabled.  The stacks allocated in this way are freed by the
kernel when the thread exits or shadow stacks are disabled for the
thread.  This lack of flexibility and control isn't ideal, in the vast
majority of cases the shadow stack will be over allocated and the
implicit allocation and deallocation is not consistent with other
interfaces.  As far as I can tell the interface is done in this manner
mainly because the shadow stack patches were in development since before
clone3() was implemented.

Since clone3() is readily extensible let's add support for specifying a
shadow stack when creating a new thread or process in a similar manner
to how the normal stack is specified, keeping the current implicit
allocation behaviour if one is not specified either with clone3() or
through the use of clone().  When the shadow stack is specified
explicitly the kernel will not free it, the inconsistency with
implicitly allocated shadow stacks is a bit awkward but that's existing
ABI so we can't change it.

The memory provided must have been allocated for use as a shadow stack,
the expectation is that this will be done using the map_shadow_stack()
syscall.  I opted not to add validation for this in clone3() since it
will be enforced by hardware anyway.

Please note that the x86 portions of this code are build tested only, I
don't appear to have a system that can run CET avaible to me, I have
done testing with an integration into my pending work for GCS.  There is
some possibility that the arm64 implementation may require the use of
clone3() and explicit userspace allocation of shadow stacks, this is
still under discussion.

A new architecture feature Kconfig option for shadow stacks is added as
here, this was suggested as part of the review comments for the arm64
GCS series and since we need to detect if shadow stacks are supported it
seemed sensible to roll it in here.

The selftest portions of this depend on 34dce23f7e40 ("selftests/clone3:
Report descriptive test names") in -next[2].

[1] https://lore.kernel.org/r/20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org/
[2] https://lore.kernel.org/r/20231018-kselftest-clone3-output-v1-1-12b7c50ea2cf@kernel.org

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (5):
      mm: Introduce ARCH_HAS_USER_SHADOW_STACK
      fork: Add shadow stack support to clone3()
      selftests/clone3: Factor more of main loop into test_clone3()
      selftests/clone3: Allow tests to flag if -E2BIG is a valid error code
      kselftest/clone3: Test shadow stack support

 arch/x86/Kconfig                                  |   1 +
 arch/x86/include/asm/shstk.h                      |  11 +-
 arch/x86/kernel/process.c                         |   2 +-
 arch/x86/kernel/shstk.c                           |  36 ++++-
 fs/proc/task_mmu.c                                |   2 +-
 include/linux/mm.h                                |   2 +-
 include/linux/sched/task.h                        |   2 +
 include/uapi/linux/sched.h                        |  17 +-
 kernel/fork.c                                     |  40 ++++-
 mm/Kconfig                                        |   6 +
 tools/testing/selftests/clone3/clone3.c           | 180 +++++++++++++++++-----
 tools/testing/selftests/clone3/clone3_selftests.h |   5 +
 12 files changed, 247 insertions(+), 57 deletions(-)
---
base-commit: 80ab9b52e8d4add7735abdfb935877354b69edb6
change-id: 20231019-clone3-shadow-stack-15d40d2bf536

Best regards,
-- 
Mark Brown <broonie@kernel.org>

