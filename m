Return-Path: <linux-kselftest+bounces-39313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32425B2C996
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 18:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611607A5E43
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 16:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC16A253951;
	Tue, 19 Aug 2025 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI1/Q6RR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B826214A6A;
	Tue, 19 Aug 2025 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620829; cv=none; b=NnCw4ynXBhg1EfRP0Apgyrn5pb7ywsvhpRVLAdPwl7hEKIZoVOhYpwFOtODAbUssT7bdfyDibkACTgSvxWCbhqaGtNR5avxPo02yGAxqJmt2g/dZoEWL6kncdl58dM8W+NNoSoIVY7aX+LyAfC1uQD2BiwF/1Ae3DUYdn2FHsZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620829; c=relaxed/simple;
	bh=4h1WhlTg/8gt4ubcPmtYGHL1ULdqgi2r+OySUEwlYuE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VHKlA3Ze4LDa0SHDGenkoe2f9sQv3w89nSVIlPe8BFpuzkzPiOuFpIQ9A5jZc2nU7m4q3KqVJPioGTn9vhAaIObVzOo8nfkbHHQRMDeBlu3akSFjYmj+bXUhYuGtBDbMFlTAQs5177Us/KljXyUJkHgFfC4QDtVY7FwP93oL18E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI1/Q6RR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A1FC4CEF1;
	Tue, 19 Aug 2025 16:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755620829;
	bh=4h1WhlTg/8gt4ubcPmtYGHL1ULdqgi2r+OySUEwlYuE=;
	h=From:Subject:Date:To:Cc:From;
	b=oI1/Q6RRoyOlRTesNrrLkXuEmJ6BcnmZK4nMtZlhkwHZYs4E22REoZ3+8L5r9GVOp
	 aHwkeAzlHRNJW0SXqAJzskzV4YslPJMI1ECW4RaZ1dmqpBbB3E9eFCFTPi30ZPjmcT
	 TUKNEQvDdSsevlfNfT3YGULnoaUrtXzT/OZ3n21YQQF2CUgRIL4LVsaARlaOFR5jrC
	 HS6avihAtWSujItJapeHDX81DcHW52PO+PtbKIJGrhxkybpEQZddYsWaElQhe2UiKO
	 RMOhUx5OjudVdXr7WwS+Y+9RRhODN51suuUqfehYTn+3u8bY9ZFI4PhsGQMVE7gCFN
	 kaZL1MX42fl7A==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v19 0/8] fork: Support shadow stacks in clone3()
Date: Tue, 19 Aug 2025 17:21:46 +0100
Message-Id: <20250819-clone3-shadow-stack-v19-0-bc957075479b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJukpGgC/3XUzW7cIBDA8VeJfI4jZoABeup7VD3wMWStROvKj
 txW0b57YdXEjjBHLPlnGP/t92HlZeJ1+PbwPiy8Tes0X8sC3OPDEC/++szjlMqFAQVKEODG+Dp
 fWY7rxaf597i++fgygk5KJAxZSxrKnb8WztOfO/vjZ1lfpvVtXv7en7JBvfrfQ3nqbTCKMVkyS
 YRCJ/H9hZcrvz7Ny/NQwQ13BECdI1iQQCCzJQugdYPIA4LiHJEF8SZYTpLRx9gg6ojYc0QVxAa
 0ObPKZKhB9AeiBIrOTHRBJGIkp51lFRqEdoR6g6WCOGZjrAyQg2sQsyNGwjli6kyclsgccoDUI
 HZHrOjMxBZE+JiliT6DagfrDkinu83V4xAmo7JzilSDgDgo2DkPiLoXYmucCU6pthT4jFaBELr
 D1GrRk8eQKJGGlsED05su1G4NWMnBBmYwLSN3ppsL1HKdDNZ5C15z+5bgM11dqqMOc29X6KClz
 0aeFAN6Z1TvbcO93uxR6UgsA7cMHRjo7ab2izlHF710YNqPAMzOkOhkA7Vga5Xg5EzOlFvG7ow
 R2GFqw8aRLr8+cip93c3tdvsHayLOWF8FAAA=
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
 Andrew Morton <akpm@linux-foundation.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=9873; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4h1WhlTg/8gt4ubcPmtYGHL1ULdqgi2r+OySUEwlYuE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBopKXOk60N8lsS5h8/8PwRX0jOuB36qjOQFIBpp
 Z8XbYRrK/GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKSlzgAKCRAk1otyXVSH
 0KqNB/0dDldMl2UFVKiG41aoiQLQ+j4NnhKiOQHJxS1dioBWqAalOkUu+1FWOJHFPwRo+BDZLqX
 W45xVyyfFtPBDfdlRVYVWb24X2yT7OUFV83xOjrp/HO9taRKcVkmHQ8AgDbfPXmO22RxVsUJvZy
 VDY7vd/A2AiSLK2+6mJA8D1KBjJaLMbTy17vhSA7nAE+l7mVKSRODLCTtsyof8F0v3fFZkffFoe
 pvqwTYilH/yOg4PbQmDr0tgtpQjBqLDqVl4XGUGwUIgaOxg9bP/YFe7+ih8JgNOgqzwr9aK+Kj2
 0SaiwbnHhNFttwjAWnt2JGqAPIXq+tqMqMnVnq0oylcpfVMg
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

[ I think at this point everyone is OK with the ABI, and the x86
  implementation has been tested so hopefully we are near to being
  able to get this merged?  If there are any outstanding issues let
  me know and I can look at addressing them.  The one possible issue
  I am aware of is that the RISC-V shadow stack support was briefly
  in -next but got dropped along with the general RISC-V issues during
  the last merge window, rebasing for that is still in progress.  I
  guess ideally this could be applied on a branch and then pulled into
  the RISC-V tree? ]

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
support gets merged before this does).  The idea has, however, had
strong pushback from the architecture maintainers and it is possible to
detect support for this in clone3() by attempting a call with a
misaligned shadow stack pointer specified so no hwcap has been added.

[1] https://lore.kernel.org/linux-arm-kernel/20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org/T/#mc58f97f27461749ccf400ebabf6f9f937116a86b
[2] https://lore.kernel.org/r/aCs65ccRQtJBnZ_5@arm.com

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v19:
- Rebase onto v6.17-rc1.
- Link to v18: https://lore.kernel.org/r/20250702-clone3-shadow-stack-v18-0-7965d2b694db@kernel.org

Changes in v18:
- Rebase onto v6.16-rc3.
- Thanks to pointers from Yuri Khrustalev this version has been tested
  on x86 so I have removed the RFT tag.
- Clarify clone3_shadow_stack_valid() comment about the Kconfig check.
- Remove redundant GCSB DSYNCs in arm64 code.
- Fix token validation on x86.
- Link to v17: https://lore.kernel.org/r/20250609-clone3-shadow-stack-v17-0-8840ed97ff6f@kernel.org

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
 arch/arm64/mm/gcs.c                               |  55 +++++-
 arch/x86/include/asm/shstk.h                      |  11 +-
 arch/x86/kernel/process.c                         |   2 +-
 arch/x86/kernel/shstk.c                           |  53 ++++-
 include/asm-generic/cacheflush.h                  |  11 ++
 include/linux/sched/task.h                        |  17 ++
 include/uapi/linux/sched.h                        |   9 +-
 kernel/fork.c                                     |  93 +++++++--
 tools/testing/selftests/clone3/clone3.c           | 226 ++++++++++++++++++----
 tools/testing/selftests/clone3/clone3_selftests.h |  65 ++++++-
 tools/testing/selftests/ksft_shstk.h              |  98 ++++++++++
 15 files changed, 620 insertions(+), 81 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20231019-clone3-shadow-stack-15d40d2bf536

Best regards,
--  
Mark Brown <broonie@kernel.org>


