Return-Path: <linux-kselftest+bounces-34466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E63AD1E4D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74C9188CEA5
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 13:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2D124EF8B;
	Mon,  9 Jun 2025 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ0STp+Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D57C148;
	Mon,  9 Jun 2025 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749474076; cv=none; b=mUF3NbDsecsmb0EqbLVSPUNsDqKul2MVBnYdJJ6ZpagVxf7f8ZK1V5o64oXB5mmtfynieqBgrcy5J9iXNCkcQaGjSgdGDCLAx7QmLIvgfD5aPbr8CSNqVlXtMPVxSwE9L7Xv6Tw2vlG0HD7qMXoLQ4jW2n8lbyKRR/uZZN6Hr0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749474076; c=relaxed/simple;
	bh=dBgWK/WtMBY8eHbXtU5/oIqL9LmSp63eIAxK880ghxc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=abupx6WUIFNQK3JbNLI9u503u0AmXbU2xAy9103GaooDkyVmNKTVsr028ycyD6453n4hVl8YlhbCmgckMIMqvFoXVz/+nflywsUo2YO9fQFl4+46ysV18JCk2za0EAsIyZibWLKPmJN0ttoOtCny3jq4i6HusgicRTeMpJTbzXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQ0STp+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F4EC4CEEB;
	Mon,  9 Jun 2025 13:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749474075;
	bh=dBgWK/WtMBY8eHbXtU5/oIqL9LmSp63eIAxK880ghxc=;
	h=From:Subject:Date:To:Cc:From;
	b=DQ0STp+QR0WOTLnIeuMS8KnU5+J5ZzAmgpLD+jvzXarpEEmNe5LleurtJDPrYBBD0
	 E6N/0Z9bnhfN5AcZmQ6pL91p7F6qUag+ooOY5ZtSes8YkZPVhH+aZt5n/FtIQ1GTD+
	 NdBws6fyJlK7hzZu+PPrjffqckrrtyImyX4efzR5d5V+0Ppu8qIHg5QKnC9wmGbzZD
	 40ZqYYf1tWkdAn1/Q6jmtPr6tjg1u4K4Mcn/1vwlB1ZY/n1Rb4n9lcb5hMmZj4/z3A
	 9igNNllXyRC1YsxL85YZb9jDsa7UFyRKDU4mc+Pp30YODClACHhF4nI6MdFKQuwgvm
	 FVZbhXfL9caEA==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH RFT v17 0/8] fork: Support shadow stacks in clone3()
Date: Mon, 09 Jun 2025 13:54:01 +0100
Message-Id: <20250609-clone3-shadow-stack-v17-0-8840ed97ff6f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGrZRmgC/3XTy26dMBCA4VeJWJfIM+NrVl31Aaruoix8GeegR
 IcKItoqOu8eQ9VAZbzEiA88/nnvZp4GnruHu/du4mWYh/FaLsB8uevixV+fuR9SWehQIIEA18f
 X8crUzxefxl/9/ObjSw8qSZEwZEW6K0/+nDgPvzf2sfv+7Uf3VBYvw/w2Tn+2Vy2w3fqLIp2iC
 /SiT1abJELxk/j6wtOVX+/H6XkDF9wRAHmOYEGCBspWWwClKoQOCIpzhAriTbCciNHHWCHyiNh
 zRBbEBrQ5s8za6ApR/xApUDRmogpCiFE75SzLUCF6R3RrsLogjtkYSwFycBVidsQQnCNmnYlTh
 MwhB0gVYnfEisZMbEGEj5lM9BlkPVh3QBrxLW7djsZkZHZOalkhIA4KNvYDYv0WzdY4E5yUdSn
 wGa0EIVSDWatFrz2GpJNWUDN4YFrThbVbA5Y42MAMpmZoZ5q5wFquo2Cdt+AV16cEn+mqUp1uM
 Fu7QgVFPhs6KQbUzsjWacNWb/YoVdRMgWtGHxhofc3aL+YcXfTkwPz/E9xutw+dNcji1gQAAA=
 =
X-Change-ID: 20231019-clone3-shadow-stack-15d40d2bf536
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
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8641; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dBgWK/WtMBY8eHbXtU5/oIqL9LmSp63eIAxK880ghxc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoRtsOm2OHhAF6XfEhjpWY7taLaBAUOik5oIkhCJqH
 r102eXCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEbbDgAKCRAk1otyXVSH0DMNB/
 9HoBiPYeEFZf0PNOxX+OzimgbVKBy8qimHZZwgJECYAk3dd6uNbWGVbkDnoGbDHjLmCutIEK7rSWsB
 eWLI035l6tMrvXFr4VSd+c+/b3dNT7apoypUIQaGidjm7aP/4KAtfvIjhbRu6C3paPaFMm/sevLsAn
 kHa0KWWR4HSwyFPkJ6sBz3h5EosjF46bNHon2QntC9v3pyOPVCyFf0EVIYOTu20Ivg7h9FAU043rkn
 Cg/0EH2YarVoBkJuRPrv45iEwWIVqml3qdC83Bg2QaKtBX+x2csuUNQ45iIzk2J+D3ee/bj/v+KgA7
 re6fGSuxHc9muIEKZMQ6JCzQdTq808
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
shadow stack when creating a new thread or process, keeping the current
implicit allocation behaviour if one is not specified either with
clone3() or through the use of clone().  The user must provide a shadow
stack pointer, this must point to memory mapped for use as a shadow
stackby map_shadow_stack() with an architecture specified shadow stack
token at the top of the stack.

Yuri Khrustalev has raised questions from the libc side regarding
discoverability of extended clone3() structure sizes[2], this seems like
a general issue with clone3().  There was a suggestion to add a hwcap on
arm64 which isn't ideal but is doable there, though architecture
specific mechanisms would also be needed for x86 (and RISC-V if it's
support gets merged before this does).

Please note that the x86 portions of this code are build tested only, I
don't appear to have a system that can run CET available to me.

[1] https://lore.kernel.org/linux-arm-kernel/20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org/T/#mc58f97f27461749ccf400ebabf6f9f937116a86b
[2] https://lore.kernel.org/r/aCs65ccRQtJBnZ_5@arm.com

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v17:
- Rebase onto v6.16-rc1.
- Link to v16: https://lore.kernel.org/r/20250416-clone3-shadow-stack-v16-0-2ffc9ca3917b@kernel.org

Changes in v16:
- Rebase onto v6.15-rc2.
- Roll in fixes from x86 testing from Rick Edgecombe.
- Rework so that the argument is shadow_stack_token.
- Link to v15: https://lore.kernel.org/r/20250408-clone3-shadow-stack-v15-0-3fa245c6e3be@kernel.org

Changes in v15:
- Rebase onto v6.15-rc1.
- Link to v14: https://lore.kernel.org/r/20250206-clone3-shadow-stack-v14-0-805b53af73b9@kernel.org

Changes in v14:
- Rebase onto v6.14-rc1.
- Link to v13: https://lore.kernel.org/r/20241203-clone3-shadow-stack-v13-0-93b89a81a5ed@kernel.org

Changes in v13:
- Rebase onto v6.13-rc1.
- Link to v12: https://lore.kernel.org/r/20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org

Changes in v12:
- Add the regular prctl() to the userspace API document since arm64
  support is queued in -next.
- Link to v11: https://lore.kernel.org/r/20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org

Changes in v11:
- Rebase onto arm64 for-next/gcs, which is based on v6.12-rc1, and
  integrate arm64 support.
- Rework the interface to specify a shadow stack pointer rather than a
  base and size like we do for the regular stack.
- Link to v10: https://lore.kernel.org/r/20240821-clone3-shadow-stack-v10-0-06e8797b9445@kernel.org

Changes in v10:
- Integrate fixes & improvements for the x86 implementation from Rick
  Edgecombe.
- Require that the shadow stack be VM_WRITE.
- Require that the shadow stack base and size be sizeof(void *) aligned.
- Clean up trailing newline.
- Link to v9: https://lore.kernel.org/r/20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org

Changes in v9:
- Pull token validation earlier and report problems with an error return
  to parent rather than signal delivery to the child.
- Verify that the top of the supplied shadow stack is VM_SHADOW_STACK.
- Rework token validation to only do the page mapping once.
- Drop no longer needed support for testing for signals in selftest.
- Fix typo in comments.
- Link to v8: https://lore.kernel.org/r/20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org

Changes in v8:
- Fix token verification with user specified shadow stack.
- Don't track user managed shadow stacks for child processes.
- Link to v7: https://lore.kernel.org/r/20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org

Changes in v7:
- Rebase onto v6.11-rc1.
- Typo fixes.
- Link to v6: https://lore.kernel.org/r/20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org

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
Mark Brown (8):
      arm64/gcs: Return a success value from gcs_alloc_thread_stack()
      Documentation: userspace-api: Add shadow stack API documentation
      selftests: Provide helper header for shadow stack testing
      fork: Add shadow stack support to clone3()
      selftests/clone3: Remove redundant flushes of output streams
      selftests/clone3: Factor more of main loop into test_clone3()
      selftests/clone3: Allow tests to flag if -E2BIG is a valid error code
      selftests/clone3: Test shadow stack support

 Documentation/userspace-api/index.rst             |   1 +
 Documentation/userspace-api/shadow_stack.rst      |  44 +++++
 arch/arm64/include/asm/gcs.h                      |   8 +-
 arch/arm64/kernel/process.c                       |   8 +-
 arch/arm64/mm/gcs.c                               |  61 +++++-
 arch/x86/include/asm/shstk.h                      |  11 +-
 arch/x86/kernel/process.c                         |   2 +-
 arch/x86/kernel/shstk.c                           |  57 +++++-
 include/asm-generic/cacheflush.h                  |  11 ++
 include/linux/sched/task.h                        |  17 ++
 include/uapi/linux/sched.h                        |   9 +-
 kernel/fork.c                                     |  96 +++++++--
 tools/testing/selftests/clone3/clone3.c           | 226 ++++++++++++++++++----
 tools/testing/selftests/clone3/clone3_selftests.h |  65 ++++++-
 tools/testing/selftests/ksft_shstk.h              |  98 ++++++++++
 15 files changed, 633 insertions(+), 81 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20231019-clone3-shadow-stack-15d40d2bf536

Best regards,
-- 
Mark Brown <broonie@kernel.org>


