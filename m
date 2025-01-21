Return-Path: <linux-kselftest+bounces-24833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F743A17AAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 10:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621E93A2AA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 09:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E8C1E231C;
	Tue, 21 Jan 2025 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rh/Hlilr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCB21DED4F;
	Tue, 21 Jan 2025 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453479; cv=none; b=i4wX1ejHcam1W0MhM5cDwGUdPinHcUAZpuHNVGYCrqpiUGbAGY6xW7vfZV5SsVdnmEStBGz/B6hXXipmq2iqcDoZnzfbqpXokYi+L+jZF+JFM7gKkiTvFO/SAp5HGRNfFORe2FH4iGWvZDwky++GkOn/wMYsRtPr8XVn1h+nLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453479; c=relaxed/simple;
	bh=Wme3RadWyvhvMdPRne38RcnHRR4tq7D20M16ECVXgvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EsRU2mTUs1lXVMTY8GYVot6925NhFUprkH/+iu35La09uCiAIDQiTtfPA81wBiHEni1r4XcnWXRYYf0blk0D5YR3E2SJmBI/FNee4MLNJRDdEK9N2CBXK9tqCTNJsK7oJv21HVjzP/aWSxZ+v1aSnVK6nRxUaezs+Fte+G8fl9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rh/Hlilr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B91C4CEDF;
	Tue, 21 Jan 2025 09:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737453479;
	bh=Wme3RadWyvhvMdPRne38RcnHRR4tq7D20M16ECVXgvE=;
	h=From:To:Cc:Subject:Date:From;
	b=rh/HlilriYiUfxxSoSn1Dvm4ive39BJjvEcaYkJPYDB4Bq159WaYziRMj9GttPwV4
	 oNJSZE/CM2l9cUTU/sgeYj916s4tKhaxqflrklPGwUoUglcrt8k38IZ3mnKVmfe85Y
	 w1gmDK9AOGg0wGUcs/4/ufhN7/imdYoNgMCLLC4f6HA8JR1YIM/ho6/94/W16wKcUh
	 HqZ3wE417GufCR++pfx67iGYJhxnZ1tnwT6vt2+4pq4r8W3tAcMQ3/lc3PDxJbju9x
	 5DU87NBLb7gkP2FrZ5zr5ekyyUTyizVQkPCFzaKNT9bc5g12mboVzYrIz0bs5KMlAE
	 6HjYs6N1b8mgw==
From: Mike Rapoport <rppt@kernel.org>
To: x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Gomez <da.gomez@samsung.com>,
	Daniel Thompson <danielt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Gow <davidgow@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Rae Moar <rmoar@google.com>,
	Richard Weinberger <richard@nod.at>,
	Sami Tolvanen <samitolvanen@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kgdb-bugreport@lists.sourceforge.net,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	live-patching@vger.kernel.org
Subject: [PATCH v2 00/10] x86/module: rework ROX cache to avoid writable copy
Date: Tue, 21 Jan 2025 11:57:29 +0200
Message-ID: <20250121095739.986006-1-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

Following Peter's comments [1] these patches rework handling of ROX caches
for module text allocations. 

Instead of using a writable copy that really complicates alternatives
patching, temporarily remap parts of a large ROX page as RW for the time of
module formation and then restore it's ROX protections when the module is
ready.

To keep the ROX memory mapped with large pages, make set_memory_rox()
capable of restoring large pages (more details are in patch 3).

Since this is really about x86, I believe this should go in via tip tree.

The patches also available in git
https://git.kernel.org/rppt/h/execmem/x86-rox/v9

v2 changes:
* only collapse large mappings in set_memory_rox()
* simplify RW <-> ROX remapping
* don't remove ROX cache pages from the direct map (patch 4)

v1: https://lore.kernel.org/all/20241227072825.1288491-1-rppt@kernel.org

[1] https://lore.kernel.org/all/20241209083818.GK8562@noisy.programming.kicks-ass.net

Kirill A. Shutemov (1):
  x86/mm/pat: restore large ROX pages after fragmentation

Mike Rapoport (Microsoft) (9):
  x86/mm/pat: cpa-test: fix length for CPA_ARRAY test
  x86/mm/pat: drop duplicate variable in cpa_flush()
  execmem: don't remove ROX cache from the direct map
  execmem: add API for temporal remapping as RW and restoring ROX afterwards
  module: introduce MODULE_STATE_GONE
  module: switch to execmem API for remapping as RW and restoring ROX
  Revert "x86/module: prepare module loading for ROX allocations of text"
  module: drop unused module_writable_address()
  x86: re-enable EXECMEM_ROX support

 arch/um/kernel/um_arch.c                      |  11 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/vdso/vma.c                     |   3 +-
 arch/x86/include/asm/alternative.h            |  14 +-
 arch/x86/include/asm/pgtable_types.h          |   2 +
 arch/x86/kernel/alternative.c                 | 181 ++++++--------
 arch/x86/kernel/ftrace.c                      |  30 ++-
 arch/x86/kernel/module.c                      |  45 ++--
 arch/x86/mm/pat/cpa-test.c                    |   2 +-
 arch/x86/mm/pat/set_memory.c                  | 220 +++++++++++++++++-
 include/linux/execmem.h                       |  31 +++
 include/linux/module.h                        |  22 +-
 include/linux/moduleloader.h                  |   4 -
 include/linux/vm_event_item.h                 |   2 +
 kernel/module/kallsyms.c                      |   8 +-
 kernel/module/kdb.c                           |   2 +-
 kernel/module/main.c                          |  86 ++-----
 kernel/module/procfs.c                        |   2 +-
 kernel/module/strict_rwx.c                    |   9 +-
 kernel/tracepoint.c                           |   2 +
 lib/kunit/test.c                              |   2 +
 mm/execmem.c                                  |  39 ++--
 mm/vmstat.c                                   |   2 +
 samples/livepatch/livepatch-callbacks-demo.c  |   1 +
 .../test_modules/test_klp_callbacks_demo.c    |   1 +
 .../test_modules/test_klp_callbacks_demo2.c   |   1 +
 .../livepatch/test_modules/test_klp_state.c   |   1 +
 .../livepatch/test_modules/test_klp_state2.c  |   1 +
 28 files changed, 442 insertions(+), 283 deletions(-)


base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
-- 
2.45.2


