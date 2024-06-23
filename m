Return-Path: <linux-kselftest+bounces-12511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D9C9139FA
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 13:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E611F21D08
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 11:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D6E12EBF3;
	Sun, 23 Jun 2024 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUJD0CbC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321312BF1B;
	Sun, 23 Jun 2024 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719141964; cv=none; b=oLkXhuw75ZKPgFFotljBrRCYLMcunaEeXEhMe97GdXMcD7C84rHdhpLOKnG1luE2sY6d9FylmzVWD9qPxI0pysFYHy/sUYDaUfr8jStDxL9F6fAz1rDZoyj0tQgPKJb2lo1yuvYTWbtLY9qYObRWQkzlZq8rPSlx6b/hAjHNM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719141964; c=relaxed/simple;
	bh=n73qLstihOUso6THGt4MThsoV4+BipZJ1B2cja+oGFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rGyuLNWeeahGu0Urx7Y5/B1VeVWFEbHbxO6M0Rulm0XcatxZ3QsCoLuVGtL+y4CH7JbTa9pKzY5epw0bFdKAXe7gqtbI5nxjNVPeLi1Kf8YoQmBjVMrlVUr1rcVIl1l5IBewi5qnzG75o6gHZpptYNylD/XLcBHH7D4yFIeox5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUJD0CbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF92CC2BD10;
	Sun, 23 Jun 2024 11:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719141963;
	bh=n73qLstihOUso6THGt4MThsoV4+BipZJ1B2cja+oGFM=;
	h=From:Subject:Date:To:Cc:From;
	b=eUJD0CbCOqVeOM1asXlIeQVV3v1zAiHgEtF0XCHqN0Vf1Kn5Qpet6Xyc37z+ELMRK
	 E9DiS9XApKr7Zn4abU8z4Ow4BnOwtGCcM1tIQ3s3Y3LVbJvLJHmJDuYia2VJWmJIOT
	 Rp65+PG64fJdigS7ddnu9g+HBBBYSm8E88OCQAalb0ta2L28mnSwfr6NYWNgSJQiVv
	 ceQ5q0j+LFJ25HbBJsBezn/Rn58iujbJv9gXdwTAk8GmWZKCSNLXK1zhjanjYhuc59
	 sQiDDU4hYArGlaWWRqMGXvxHdP/Ow1o+J5eh5a5/T3JziDqX4+Cqctg/tRsqOAqrO+
	 UYs7K38XXbAjg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH RFT v6 0/9] fork: Support shadow stacks in clone3()
Date: Sun, 23 Jun 2024 12:23:42 +0100
Message-Id: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL8FeGYC/3XQy2rDMBAF0F8JWldFGj0sZ9VVPiB0V7rQYxSLB
 KtIwW0J/vcKl9IUu8s7wz0DcyMVS8JK9rsbKTilmvLYgn7YET/Y8YQ0hZYJMBCc8Z76Sx5R0Dr
 YkN9pvVp/plwFyQK4qIQmrflWMKaPRX0hx8MzeW3DIdVrLp/LpYkvq28UxCY6ccpoMLoLzDU/s
 KczlhEvj7mcFnCCX4RzuY1AQ5zmIhptOFdqhYg7BNg2IhpiO2cwCATr/QqR94jZRmRDjAMTI8q
 oO71C1A8iGbB/fqIaIgC87lVvULo/yDzPX2gCBo3QAQAA
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
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Hildenbrand <david@redhat.com>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=6303; i=broonie@kernel.org;
 h=from:subject:message-id; bh=n73qLstihOUso6THGt4MThsoV4+BipZJ1B2cja+oGFM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmeAY962k/VeTx4/xZqO6Lnu+NJEEykrNGpoaM6MSl
 pJBtbh2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZngGPQAKCRAk1otyXVSH0Gz1B/
 wLlbZadLxX5LPeWcPRkqU2GdGdLVfJX4e1LVytTHTsiUKaWlVS3etlJqN5+j6R1+nr1MsJfXJoX8D0
 mYbwRH1LUMVk7eVSzKXGbwME8GXLsyj/SwGuFuuStQQBojbWU1Z+1bMmbGf5Rm64cBv0D+a5MigKEA
 RrehFRD1nCQ7bP9XJoS+R/dRy2RcErGYGJeuzc37A2Hn2a4LvTU4E8QHy2OagvvxKKXrwjCU+ZrPfi
 bzdk9fbQ7ugAmt6I/ub8jLPZCc68+gFbDEDuxmkPshJEslEkm9CxVilaCvgyaqZwR+pfMB6bVsMH++
 WFk+3M81cv+sBwcxO4JKCOpzzAzW22
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
Changes in v6:
- Rebase onto v6.10-rc3.
- Ensure we don't try to free the parent shadow stack in error paths of
  x86 arch code.
- Spelling fixes in userspace API document.
- Additional cleanups and improvements to the clone3() tests to support
  the shadow stack tests.
- Link to v5: https://lore.kernel.org/r/20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org

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
Mark Brown (9):
      Documentation: userspace-api: Add shadow stack API documentation
      selftests: Provide helper header for shadow stack testing
      mm: Introduce ARCH_HAS_USER_SHADOW_STACK
      fork: Add shadow stack support to clone3()
      selftests/clone3: Remove redundant flushes of output streams
      selftests/clone3: Factor more of main loop into test_clone3()
      selftests/clone3: Explicitly handle child exits due to signals
      selftests/clone3: Allow tests to flag if -E2BIG is a valid error code
      selftests/clone3: Test shadow stack support

 Documentation/userspace-api/index.rst             |   1 +
 Documentation/userspace-api/shadow_stack.rst      |  41 ++++
 arch/x86/Kconfig                                  |   1 +
 arch/x86/include/asm/shstk.h                      |  11 +-
 arch/x86/kernel/process.c                         |   2 +-
 arch/x86/kernel/shstk.c                           | 104 +++++++---
 fs/proc/task_mmu.c                                |   2 +-
 include/linux/mm.h                                |   2 +-
 include/linux/sched/task.h                        |  13 ++
 include/uapi/linux/sched.h                        |  13 +-
 kernel/fork.c                                     |  76 ++++++--
 mm/Kconfig                                        |   6 +
 tools/testing/selftests/clone3/clone3.c           | 225 ++++++++++++++++++----
 tools/testing/selftests/clone3/clone3_selftests.h |  40 +++-
 tools/testing/selftests/ksft_shstk.h              |  63 ++++++
 15 files changed, 512 insertions(+), 88 deletions(-)
---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20231019-clone3-shadow-stack-15d40d2bf536

Best regards,
-- 
Mark Brown <broonie@kernel.org>


