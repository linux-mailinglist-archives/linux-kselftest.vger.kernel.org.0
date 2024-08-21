Return-Path: <linux-kselftest+bounces-15910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8AB95A56B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990221C2203B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F19416EB7B;
	Wed, 21 Aug 2024 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPxzhjAy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E849137745;
	Wed, 21 Aug 2024 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724269825; cv=none; b=oTmrSX8ZZfA9JLzdMUsmbOBHkJOA9qJo3uSTrYDcPiP2iIcJ+9om/MyiEVARfg1JqJBFU8ykoOVkqT9dBpORrffVmrcfZuRnnjMvR6RvdN1E4i7WVpjdvJWuGcANulATdXWcRshOX7XZPXJQMkYxsk4WuOQb2DrlME37yy6gH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724269825; c=relaxed/simple;
	bh=m2nIsRe6Hg4c4rDLREiu8oA1iMxD8hzbeL0+DtBl5Fk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LA/+G3zDxL5oKVLoufuBVmObNP4VTGpiEXpQk7a0h7ENQmbdhAYFIbcsaTfxS60GTFj1zagfILsV/1GUu/xagCgiaYAgCJ7pPJoOgZjfT1DAkXe2pdMMbR5aM0UD73qNrHolKsogq7vN/udewR7gWpyBA9tnztWe8F1LVPNlBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPxzhjAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60125C32781;
	Wed, 21 Aug 2024 19:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724269824;
	bh=m2nIsRe6Hg4c4rDLREiu8oA1iMxD8hzbeL0+DtBl5Fk=;
	h=From:Subject:Date:To:Cc:From;
	b=LPxzhjAy9+Oh4Ebb8gZ8wJ2oURVHdB9UvMBzhvY7u0x4WOCgN9diiZ9E+D0PFvgXl
	 AP+vDeJRbtiRoaJvaAkwBxuyEC2b71C0QjELgsKEw08d5tJE3sOeiTR0Pqtm3IMhb+
	 PQOXfJelvBK0vz6vaLDtjD9e4gUlksj/wjXYBf64oZDXbZTJ9lGdvHqLP+dvAt26ny
	 GC1o+/bxAf+34gTIPynHeGbTWEO/JXIZ/eQJaAJrgKwEpJgiINlxIjy7/Psa8imqVK
	 mZ3Pbo6Fb2MR7ilQHcVAB9h7+jSVDJogQK6bABHeH3phc1tvWjzLB9Iemqq4hYv5lM
	 tOYe+6ObsSBNw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH RFT v10 0/8] fork: Support shadow stacks in clone3()
Date: Wed, 21 Aug 2024 20:49:46 +0100
Message-Id: <20240821-clone3-shadow-stack-v10-0-06e8797b9445@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANtExmYC/3XSS07DMBCA4atUXhPkGb9ZseIAiB1i4ceYRq0Sl
 FQBVPXuuEEoRU6WHsuf5V8+s5GGlkb2sDuzgaZ2bPuuLIDf7Vjc++6dmjaVAUOOAji4Jh77jkQ
 z7n3qP5vx5OOhAZUkTxiyEpqVkx8D5fZrZl/Z89MLeyvDfTue+uF7vmqCeesXRbGKTtDwJlltE
 g/FT/zxQENHx/t+eJ/BCRcEQK4jWJCgQWSrLYBSFSJuEOTriCiIN8FSEoQ+xgqRt4hdR2RBbEC
 bM8msja4Q9YdIjnyjiSqIQIzaKWdJhgrRC6K3wuqCOCJjrAiQg6sQsyBGwDpirk2cEkgUcoBUI
 XZBLN9oYgvCfczCRJ9B1mHdDbLx+SZ3fY7GZGR2Tmr5D7lcLj+HBvf75QIAAA==
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
 Shuah Khan <skhan@linuxfoundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=7519; i=broonie@kernel.org;
 h=from:subject:message-id; bh=m2nIsRe6Hg4c4rDLREiu8oA1iMxD8hzbeL0+DtBl5Fk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxkTzPU7RYe26CQLcYL7UT4DmCw5GdQsenK52eani
 ejJtQBiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsZE8wAKCRAk1otyXVSH0JlXB/
 9VyZCNK8gyRAh6LU1dGiL1HtL6jkwOIEFWOssytMFSwZ8TDdNzuNQeYUXZgrQD7MZRf2bVJeoEH6sj
 zhtCbbxI3d7Hm9YCHgJ33QlTNcCsEUdpDT+2+ZZI7XAstNC6AX80RkYb7ETc+NhbYxTLQkWIzs7mlG
 U3c9xQoK6ABBeuwNJOeMX11Uqwg3flg+tzwLSwBuspYkpC5j/StIoGEyzvB2SyUuvYtnyud+BTIb4o
 9Mflu1GEPoRyapfIjrl89eIfaqa5CoXvF9HREH8bXWSLEcwetgc0lcHwelQm9ZUcsmkSqkmq9x+i7e
 nerMTOhNREmlxkBQF/LB27wEUC/LPx
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
      Documentation: userspace-api: Add shadow stack API documentation
      selftests: Provide helper header for shadow stack testing
      mm: Introduce ARCH_HAS_USER_SHADOW_STACK
      fork: Add shadow stack support to clone3()
      selftests/clone3: Remove redundant flushes of output streams
      selftests/clone3: Factor more of main loop into test_clone3()
      selftests/clone3: Allow tests to flag if -E2BIG is a valid error code
      selftests/clone3: Test shadow stack support

 Documentation/userspace-api/index.rst             |   1 +
 Documentation/userspace-api/shadow_stack.rst      |  41 ++++
 arch/x86/Kconfig                                  |   1 +
 arch/x86/include/asm/shstk.h                      |  11 +-
 arch/x86/kernel/process.c                         |   2 +-
 arch/x86/kernel/shstk.c                           |  96 ++++++--
 fs/proc/task_mmu.c                                |   2 +-
 include/asm-generic/cacheflush.h                  |  11 +
 include/linux/mm.h                                |   2 +-
 include/linux/sched/task.h                        |  18 ++
 include/uapi/linux/sched.h                        |  13 +-
 kernel/fork.c                                     | 121 ++++++++++-
 mm/Kconfig                                        |   6 +
 tools/testing/selftests/clone3/clone3.c           | 254 ++++++++++++++++++----
 tools/testing/selftests/clone3/clone3_selftests.h |  40 +++-
 tools/testing/selftests/ksft_shstk.h              |  61 ++++++
 16 files changed, 593 insertions(+), 87 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20231019-clone3-shadow-stack-15d40d2bf536

Best regards,
-- 
Mark Brown <broonie@kernel.org>


