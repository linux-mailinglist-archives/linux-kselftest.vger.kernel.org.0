Return-Path: <linux-kselftest+bounces-739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CD67FC335
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 19:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26D51C20A32
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 18:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A4F3D0AF;
	Tue, 28 Nov 2023 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIKPoBtJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C1D3D0AB;
	Tue, 28 Nov 2023 18:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C9EC433C8;
	Tue, 28 Nov 2023 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701196295;
	bh=NROPqiEQ6vDNcp6Pe2C3MvsogsqejvAhVuwaVCUo15M=;
	h=From:Subject:Date:To:Cc:From;
	b=CIKPoBtJ/QbC4Puo88DuBLNoFO9srfUroQZVKEWxP615vnnyRUKuoVi93BNUz7zxG
	 TYRE9V6/65uZKCUTjQtAQiGe27dUxg/c80zdoz/cKMqzMxWZ31XQ2bpXD/Whi6sLfN
	 CmA9DqW1jgxIYV71QjBGjdzqHTcJtTU5BaOct3o0b/+QeVxe+hCd9nUugV6D+c94C9
	 Tca7aGjGzSwoXNvdKHOON3hBNHsW30ATAUIdnxp1ncabviO++vIUxWLzL/fbc9gWl9
	 YYpFbHx0JP9KEwblM+wUV7RCTmCt40rTgGU8FmxZ5g7wrAo4Uvd3wYXjt+p7USgCDF
	 BM+N+jWJKuqrw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH RFT v4 0/5] fork: Support shadow stacks in clone3()
Date: Tue, 28 Nov 2023 18:22:38 +0000
Message-Id: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO4vZmUC/23NTQ7CIBAF4Ks0rMUw0D9dufIAxp1xQWHakjZgo
 KmapneX1IUau3zzMt+bSEBvMJB9MhGPownG2RjSTUJUK22D1OiYCWdcAIMdVb2zKGhopXZ3Gga
 pOgqZTpnmVZ2JnMTPm8faPBb1Qk7HM7nGY2vC4PxzWRphqd4oF6voCJRRXeaFZlX0NTt06C32W
 +ebBRz5BwFI1xEekSoHUZd5CZBlf4j4QjhbR0REZFGVqAVyqdQPMs/zC8rzE/pGAQAA
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
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4805; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NROPqiEQ6vDNcp6Pe2C3MvsogsqejvAhVuwaVCUo15M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlZjH8l9Ti0WgO7TV3nEmr2nHEZD+bNbFMAmto8y31
 cDYyzOqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZWYx/AAKCRAk1otyXVSH0KVBB/
 9UTQ8Gb5Mko1cMNdxosIdKOkPP7xuu/4gZvr95GtpZU/Zf5ZaLiEtwHpBLtjwYfjIwU4+fdkr5+HSk
 fEcdsHdm6JoP3KpSPNmfDU7LpYjBrEbfsM0T29Whx+ZYit11WF8u3bpI2hKIw61C2hpPYSYuBy6QGc
 JZFhsWNxwUaJ2VTvGMY1PB21x8r1J5jwfal4InabKs8Sd3RqTPsjLkmL6A44zrzxPFOxJdNEzv8ZyP
 wj8aHvy/mDeY1GrPjJOKpENz9CMFWFQdRlbGPzwnrGD681OFVm8mVQu8F5CVScFvS6v2SPoVWyy0Zs
 hy3YgoLqZwj6V5+YyUfQiUUK0vu9Rb
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
through the use of clone().  Unlike normal stacks only the shadow stack
size is specified, similar issues to those that lead to the creation of
map_shadow_stack() apply.

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

[1] https://lore.kernel.org/r/20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org/

Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
Mark Brown (5):
      mm: Introduce ARCH_HAS_USER_SHADOW_STACK
      fork: Add shadow stack support to clone3()
      selftests/clone3: Factor more of main loop into test_clone3()
      selftests/clone3: Allow tests to flag if -E2BIG is a valid error code
      kselftest/clone3: Test shadow stack support

 arch/x86/Kconfig                                  |   1 +
 arch/x86/include/asm/shstk.h                      |  11 +-
 arch/x86/kernel/process.c                         |   2 +-
 arch/x86/kernel/shstk.c                           |  56 ++++--
 fs/proc/task_mmu.c                                |   2 +-
 include/linux/mm.h                                |   2 +-
 include/linux/sched/task.h                        |   1 +
 include/uapi/linux/sched.h                        |   4 +
 kernel/fork.c                                     |  53 ++++--
 mm/Kconfig                                        |   6 +
 tools/testing/selftests/clone3/clone3.c           | 200 +++++++++++++++++-----
 tools/testing/selftests/clone3/clone3_selftests.h |   7 +
 12 files changed, 268 insertions(+), 77 deletions(-)
---
base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
change-id: 20231019-clone3-shadow-stack-15d40d2bf536

Best regards,
-- 
Mark Brown <broonie@kernel.org>


