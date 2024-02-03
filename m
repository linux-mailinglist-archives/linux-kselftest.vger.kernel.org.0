Return-Path: <linux-kselftest+bounces-4057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B9847D6F
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 01:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3171F2907F
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 00:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180BF388;
	Sat,  3 Feb 2024 00:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7H5wlvG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6478636;
	Sat,  3 Feb 2024 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918725; cv=none; b=qRfgvA7KQxQaezVFEZ2JwwaItxIvbdPRf6D2WNN+2KKo1z8Il2ctcUqVIbrMkovOXu9EJYtSrkxuH7I/yVYCfXBDwdw4JtUdK9mEZAvp03G/WGX7qps89ekY+9+taPuZUeiao8W+iV3c12WLvL+Jw0RiSKPUDcFsY070HCCLYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918725; c=relaxed/simple;
	bh=ADET036q7av5d6Yajw8qW29bC06EEDm2pUfR64LXErM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EcDUw8rJKiNo8bh8O43XpUuZCmcmssaWWSo37p79p2t1ZstjB2/fIq2ULgtM72IAKpxvJSjI7v5NG78RHD88q301abMEywvCl8Ll60GG8xmEZ2/QaxVT3zafM5vyVqvXXE6jjxU2DNTwchyqDG1zMiRjoFy+KmYpSIigqMOOPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7H5wlvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C955C433C7;
	Sat,  3 Feb 2024 00:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706918724;
	bh=ADET036q7av5d6Yajw8qW29bC06EEDm2pUfR64LXErM=;
	h=From:Subject:Date:To:Cc:From;
	b=m7H5wlvGMIflskB2V2LNCSlNdSOkBWhdrO38vDOjn0bD0CqcIIfyc/b7S85r8oQcT
	 NQR1JVNgd7XAapTnhvd9TwepVLrgAM6EEB0tfGeTXPBssX9t/I0COeIyTXjLXZ6Dzn
	 7f37ivgQQjPF9KC0ywtT5/3fK8eYAYfFKU0igo+bbKIhnX02T25I456qq51jhCji0B
	 C0Ush9k4+qWeuNmO5kAm0auz6QZgunbzIrW7ty4vM8WDTJTFh7xFjMkG36GS+NGB4e
	 E0ZSmfgWMF0tq6dXPjTbyajK2df8caqjlrcUUjDwgwwvouyFeOaLAp0SvEhazFH8Hm
	 2FrndW3Sfq71w==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH RFT v5 0/7] fork: Support shadow stacks in clone3()
Date: Sat, 03 Feb 2024 00:04:56 +0000
Message-Id: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACiDvWUC/23Nu04DMRAF0F+JXGPkGT/WUFHxAREdovBjnLUSr
 ZEdbUDR/jvWUhCULe9czblX1qhmaux5d2WV5txymXrQDzsWRjcdiOfYM0OBEgQ88XAqE0neRhf
 LhbezC0cOOioR0SctDeufn5VS/lrVd7Z/fWMf/Tjmdi71e12aYa1+UZSb6Axc8GjNEIXvfhQvR
 6oTnR5LPazgjH8IgNpGsCPegEzWWACt7xB5g6DYRmRH3OAtRUnoQrhD1C1itxHVEevRpkQqmcH
 8Q5Zl+QHMEaZJiwEAAA==
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
 "H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, 
 Daniel Bristot de Oliveira <bristot@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>, 
 jannh@google.com, bsegall@google.com, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 David Hildenbrand <david@redhat.com>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5783; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ADET036q7av5d6Yajw8qW29bC06EEDm2pUfR64LXErM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvYM3npsMX9TJ+rXiQ0MR0Q5jhU9ckhziWi5BnCOV
 qmUQ+H6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb2DNwAKCRAk1otyXVSH0O0EB/
 9q7W39KKLWQLLXi4q1NOuQYVFhxUGNYybGDasHnhcRQElcx/0UJ7t6RIxdYvpsRR/CVm6k4WQLoM5i
 wd9FlIPxvERr0Y1HGvktUQ4QKWTBWor9YvgEGjgvmVqR6IZlnrY2LMthdAyhP4mXto+2IQSXUOBLQa
 961D4KEDpcBeslzQ9t0yRMlIcyvq3ike15JsN55lowvAOe/LI0zyMEdI60UJFCIRnReUzpUaut30ac
 igDJs+rKoF5JKwEAtMqgqAObX8UcEU6UOst/Ycwq1o9WsbocVpsYHPY6DNy/04usqX9Z1igSIjQUOL
 dhLkftMeLi26qCqnHv49h53oAxILjS
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The kernel has recently added support for shadow stacks, currently
x86 only using their CET feature but both arm64 and RISC-V have
equivalent features (GCS and Zicfiss respectively), I am actively
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
through the use of clone().  The user must provide a shadow stack
address and size, this must point to memory mapped for use as a shadow
stackby map_shadow_stack() with a shadow stack token at the top of the
stack.

Please note that the x86 portions of this code are build tested only, I
don't appear to have a system that can run CET avaible to me, I have
done testing with an integration into my pending work for GCS.  There is
some possibility that the arm64 implementation may require the use of
clone3() and explicit userspace allocation of shadow stacks, this is
still under discussion.

Please further note that the token consumption done by clone3() is not
currently implemented in an atomic fashion, Rick indicated that he would
look into fixing this if people are OK with the implementation.

A new architecture feature Kconfig option for shadow stacks is added as
here, this was suggested as part of the review comments for the arm64
GCS series and since we need to detect if shadow stacks are supported it
seemed sensible to roll it in here.

[1] https://lore.kernel.org/r/20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org/

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v5:
- Rebase onto v6.8-rc2.
- Rework ABI to have the user allocate the shadow stack memory with
  map_shadow_stack() and a token.
- Force inlining of the x86 shadow stack enablement.
- Move shadow stack enablement out into a shared header for reuse by
  other tests.
- Link to v4: https://lore.kernel.org/r/20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org

Changes in v4:
- Formatting changes.
- Use a define for minimum shadow stack size and move some basic
  validation to fork.c.
- Link to v3: https://lore.kernel.org/r/20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org

Changes in v3:
- Rebase onto v6.7-rc2.
- Remove stale shadow_stack in internal kargs.
- If a shadow stack is specified unconditionally use it regardless of
  CLONE_ parameters.
- Force enable shadow stacks in the selftest.
- Update changelogs for RISC-V feature rename.
- Link to v2: https://lore.kernel.org/r/20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org

Changes in v2:
- Rebase onto v6.7-rc1.
- Remove ability to provide preallocated shadow stack, just specify the
  desired size.
- Link to v1: https://lore.kernel.org/r/20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org

---
Mark Brown (7):
      Documentation: userspace-api: Add shadow stack API documentation
      selftests: Provide helper header for shadow stack testing
      mm: Introduce ARCH_HAS_USER_SHADOW_STACK
      fork: Add shadow stack support to clone3()
      selftests/clone3: Factor more of main loop into test_clone3()
      selftests/clone3: Allow tests to flag if -E2BIG is a valid error code
      selftests/clone3: Test shadow stack support

 Documentation/userspace-api/index.rst             |   1 +
 Documentation/userspace-api/shadow_stack.rst      |  41 +++++
 arch/x86/Kconfig                                  |   1 +
 arch/x86/include/asm/shstk.h                      |  11 +-
 arch/x86/kernel/process.c                         |   2 +-
 arch/x86/kernel/shstk.c                           |  91 +++++++---
 fs/proc/task_mmu.c                                |   2 +-
 include/linux/mm.h                                |   2 +-
 include/linux/sched/task.h                        |   2 +
 include/uapi/linux/sched.h                        |  13 +-
 kernel/fork.c                                     |  61 +++++--
 mm/Kconfig                                        |   6 +
 tools/testing/selftests/clone3/clone3.c           | 211 ++++++++++++++++++----
 tools/testing/selftests/clone3/clone3_selftests.h |   8 +
 tools/testing/selftests/ksft_shstk.h              |  63 +++++++
 15 files changed, 430 insertions(+), 85 deletions(-)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20231019-clone3-shadow-stack-15d40d2bf536

Best regards,
-- 
Mark Brown <broonie@kernel.org>


