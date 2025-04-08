Return-Path: <linux-kselftest+bounces-30369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9373CA814F9
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 20:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889C3466593
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 18:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E59123E358;
	Tue,  8 Apr 2025 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paCFTSx4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005E123E344;
	Tue,  8 Apr 2025 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138228; cv=none; b=WXmZUK5MkWBhX4/LhgA0ZCBF8nSbBCWu8J/f6SE2A1f9T/BeZPLiSW2RZS1OVAPPH9HU/AndFe1LY7rN5WPM4C62Tuf0FeKGsPhBRJRnscmM5CJDIAwYwJ6vEavZndtwDEAJdsuj0L3Y+u7yNcgZVhK+K/xoDH0WYP0AtLzUbO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138228; c=relaxed/simple;
	bh=A4Yb0U9k25QtuHQO7QIEYy/YADI+++Icds+3VEKg/mM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WwOM/EJA13hY0ays3bGQ3RgNgtKHKNKrMbfzXqejf/sOVb21AwmQD7zyK8KPKdNomyA5/SmfJXzr9RvLplK85FIw6skGWd96fOrV8sAChJ+iouWPjBIVMHQg64ThOhPbPBwJB/MT6nV5X2+4Vdv/TqFxt3QffIluqLrLUEPrRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paCFTSx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEC9C4CEEA;
	Tue,  8 Apr 2025 18:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744138227;
	bh=A4Yb0U9k25QtuHQO7QIEYy/YADI+++Icds+3VEKg/mM=;
	h=From:Subject:Date:To:Cc:From;
	b=paCFTSx4wNQCFDdEummkLJMfprDnL1rw23N6WZwrXLmotkUhruwQdoq+lUMSo+X73
	 782pUU6qqrnNkgWTkJR0+IZ13C3V1MOHFjKZtg5XGawBx//7BAenJMw9YzYhqk5hZc
	 hn52GRS2Qe2WSYt3BpV5lS+rDEDWn1sWUysH0ZdtCj3HnWULO+MkvicOCP8Z21hPGj
	 cNS/5m0qPSYaB5U5bgbcsRPcMoHLaytyfEIRICe+tNr6ayjLmDJd4hDnofDhz3QRAI
	 hCt8caCY6IknPgxYAmP8CGKoOCMG6aYqxP1Og+KB53e7O7xWy5hdqS99FTBtjP8hI2
	 P6Iku1DWyavoA==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH RFT v15 0/8] fork: Support shadow stacks in clone3()
Date: Tue, 08 Apr 2025 19:49:40 +0100
Message-Id: <20250408-clone3-shadow-stack-v15-0-3fa245c6e3be@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMRv9WcC/3XSzW6cMBDA8VdZcS6RZ8afOfWUB4hyi3Kw8TiLE
 i0VRKRVtO8eQ9UF1fiIkX/g8f+rmXjseWruT1/NyHM/9cMlP4D6cWq6s7+8ctvHvNCgQAIBru3
 ehwtTO519HD7b6cN3by2oKEXEkBTpJu/8NXLqf6/sc/P48NS85MVzP30M45/1UzOsr/6iSIfoD
 K1oo9UmipD9KH6+8Xjh97thfF3BGTcEQB4jmJGggZLVFkCpAqEdguIYoYx4EyxHYvRdVyByj9h
 jRGbEBrQpsUza6AJR/xApUFRmojJCiJ12ylmWoUD0hujaYHVGHLMxlgKk4ArEbIghOEbMMhOnC
 JlDChALxG6IFZWZ2IwI3yUynU8gy8G6HVKJb3bLcTRGI5NzUssCAbFTsHIeEMu/aLbGmeCkLEu
 BW7QShFAVZqkWvfYYoo5aQcngjqlNF5ZuDVjiYAMzmJKhjanmAku5joJ13oJXXN4S3NJVuTpdY
 dZ2hQqKfDL0XzHX6/UbIgFwt0gEAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7791; i=broonie@kernel.org;
 h=from:subject:message-id; bh=A4Yb0U9k25QtuHQO7QIEYy/YADI+++Icds+3VEKg/mM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn9W/mWn9ycIHyQ1Cz/Vw+dpFhsFaddAhiNVe/PVUz
 pIDxDSaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ/Vv5gAKCRAk1otyXVSH0KqKB/
 wOvpF3UaFshiKO47t/3K9u4hZIzRbReO7+nQKY1piwasQ5f++Q2+4a4Yv20FYEykJ6XW9lWTWarZCP
 vjVB3Ueq6mDUK2OPSp8PPh03ln94uz8fCmXTAi2977kusCN1kd9PMiScysf7JDOUlO42fg9vYueLw6
 nkKytfuJ/VNfQ5MjMGNwhUAT69LvQgVCjh/5wCQyOL9PbSV4CsiSw/z/qwaZujlgD3rKQ9uyzmmAmu
 Imfd8ymC4d4eN+ZF+I7AgyWOvc+NlQclUpWsvOE9mKoxmPUgpaq5q+x816v14ZVv0LjEI2WoL7rCKz
 9UqV6LJi7ApwEsKkdfAzKg8rj7Yu/V
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

Please note that the x86 portions of this code are build tested only, I
don't appear to have a system that can run CET available to me.

[1] https://lore.kernel.org/linux-arm-kernel/20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org/T/#mc58f97f27461749ccf400ebabf6f9f937116a86b

Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
 arch/arm64/mm/gcs.c                               |  62 +++++-
 arch/x86/include/asm/shstk.h                      |  11 +-
 arch/x86/kernel/process.c                         |   2 +-
 arch/x86/kernel/shstk.c                           |  57 +++++-
 include/asm-generic/cacheflush.h                  |  11 ++
 include/linux/sched/task.h                        |  17 ++
 include/uapi/linux/sched.h                        |  10 +-
 kernel/fork.c                                     |  96 +++++++--
 tools/testing/selftests/clone3/clone3.c           | 226 ++++++++++++++++++----
 tools/testing/selftests/clone3/clone3_selftests.h |  65 ++++++-
 tools/testing/selftests/ksft_shstk.h              |  98 ++++++++++
 15 files changed, 635 insertions(+), 81 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20231019-clone3-shadow-stack-15d40d2bf536

Best regards,
-- 
Mark Brown <broonie@kernel.org>


