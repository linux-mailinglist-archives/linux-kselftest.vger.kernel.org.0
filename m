Return-Path: <linux-kselftest+bounces-15689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A1D957456
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035421C2103F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3701D54D6;
	Mon, 19 Aug 2024 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUKxhCQz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9444438B;
	Mon, 19 Aug 2024 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095568; cv=none; b=CJCrFxY+pkV6ADaqPZJGMhQa+O9S1qALL8pgBCF91HGNidYlfUaP+dFDgAqR81jgh3LZALP1TYBp8EkRgzMJFXxjRYzoGvNr67i4WTkDb0i0bKiCyF1eScnx8wKFellcXirLVc51oNMRtDW4E/00oRoXpQOOfxr9f91GDySytjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095568; c=relaxed/simple;
	bh=pj9y3YT21eohJt+VRvR27VYmk6fPSiEjMjB6/3OpFns=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k+pC19tmW7R5yn31frbgOZ5HjHkBftu6j5hwoazOszMwiZvkiuqGTVkCdZrm5IRRihugNetv8xiFCLVO+Gbf5+FIZWe6q2KY9eE4rMLXcehb831vBX1X+riN5LCc7BPPnM+uuUqRZWxXA4EEYKJOqePFrjtBVMvp+wxpAZCNJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUKxhCQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C024C32782;
	Mon, 19 Aug 2024 19:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724095567;
	bh=pj9y3YT21eohJt+VRvR27VYmk6fPSiEjMjB6/3OpFns=;
	h=From:Subject:Date:To:Cc:From;
	b=NUKxhCQzPjbsk5Mx+nTn/omrUyLWeUwzwLrkc2tXxAbYVSbt5IiWGxQQMFtZz6kV7
	 9yTjiygcVaVxwE709tpyTMFE2nAqn8zI3ExRD9tGvdCRijMGCzLBgKLDujMI0duuyn
	 SpkYhAXeNekHf69NZeTqaNJ7NIn1bB5Yc02yYOuXxoeBsWCV8MjaFHE9+YP5pVWhez
	 GHs2Q89DeXc+MO8OmNlpe9/zW8bj1mtDP8Sr8qb/uOgialb3mrx/9Ih0MXj6K7oH4j
	 tBrlfXw5cR6nTcv+SxYgvvSQ3xo5wZ/tmTy8Q1gmuvSwYU4EfeFUlzm09TF1HujBYH
	 6DY+MGpQYH9pg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH RFT v9 0/8] fork: Support shadow stacks in clone3()
Date: Mon, 19 Aug 2024 20:24:21 +0100
Message-Id: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOWbw2YC/3XQS07DMBCA4atUXmPkGb9ZseIAiB1i4ce4jVolK
 KkCqMrdMUEoRUmX45G/kf4LG6hvaGAPuwvraWyGpmvr4O92LB1Cuyfe5DozFChBgOfp1LUk+XA
 IufvgwzmkIwedlcgYi5aG1Z/vPZXmc1Zf2fPTC3urj4dmOHf913xphHn1i6LcREfggmdnbBax+
 lk8Hqlv6XTf9fsZHHFBANQ2ghWJBmRxxgFovULkFYJiG5EVCTY6ypIwpLRC1DXithFVERfRlUK
 qGGtWiP5DlEBxo4muiERMxmvvSMUVYhbE3AprKuKJrHUyQol+hdgFsRK2EfvTxGuJRLFEyCvEL
 YgTN5q4ioiQirQpFFD/w07T9A35bPscnwIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7108; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pj9y3YT21eohJt+VRvR27VYmk6fPSiEjMjB6/3OpFns=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmw5xCPnGVaM6Sgr1IfiZ3Ls92yLT15FEAMtV3vI++
 3taK6uyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsOcQgAKCRAk1otyXVSH0IvjB/
 4hXHaihaez12Aje5MKKzddyRykJhlz/p5wFEStp61TouaaiXMNsom+T28MRMzSn+qPPYcY4aPYUJUR
 qwswRFIX+IbqsnxI1ve4kOMY8nPWEWJcGZIBSzLonyqP+rfXdgQYSJGiXoRp0hVuyN+jAIgDv6LVJX
 L6MCKCWiIGnGwc0qShxHAKolGr7LzvG+O3siranfoeW4Tej3RdlklPpb4RAkuDlHuHxk/oNIYwRfsz
 1fnl5WUX0ZZdzfDEY+SH/F/owjfsFC76MDJt5gPbtRnqNkVy/SbBVlfdBdnRxrAAuuUewcnlg4rUPo
 Rb1pJJpGqYyiS5Hn2EhO3M3AJbi2x6
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
 arch/x86/kernel/shstk.c                           | 103 +++++++---
 fs/proc/task_mmu.c                                |   2 +-
 include/linux/mm.h                                |   2 +-
 include/linux/sched/task.h                        |  18 ++
 include/uapi/linux/sched.h                        |  13 +-
 kernel/fork.c                                     | 114 +++++++++--
 mm/Kconfig                                        |   6 +
 tools/testing/selftests/clone3/clone3.c           | 230 ++++++++++++++++++----
 tools/testing/selftests/clone3/clone3_selftests.h |  40 +++-
 tools/testing/selftests/ksft_shstk.h              |  63 ++++++
 15 files changed, 560 insertions(+), 87 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20231019-clone3-shadow-stack-15d40d2bf536

Best regards,
-- 
Mark Brown <broonie@kernel.org>


