Return-Path: <linux-kselftest+bounces-25181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADDFA1C6B6
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 08:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F103A741D
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 07:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6F613635C;
	Sun, 26 Jan 2025 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O52qDEge"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516018C1E;
	Sun, 26 Jan 2025 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737877673; cv=none; b=nyMIcEL9ToiHQ7qRuFH2NpzebL+MllwFHEb1HZl+VHxWQMuNgPzEzjBBuFJf6xWl5HNUiL4PTHZT2w1Js6hSCG2/Y60ImBxwuQe51uMlPgNazTFUDg1/bOuxH7UinWISJi/nSHsKcCtLdYIBP7t3ljmTE6hM1cwnRLcglqI79cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737877673; c=relaxed/simple;
	bh=HLFoZ/RTXnZ46FvNWum031IGZxxS7sqpbzrgDdi90jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhAaHmV516PonQygZJMOFqlHppOaPrXQsLsECzhRZ+zgTviIuI1aXpdMpy8tFIpb3fZ82vhI/QudsawFwFf5XHkjqyXqaEHAXJcy8oG9iP4xXEy9jYkruzcIZuaV9V1E9Y4bmNaRggOXkO0RAdS5lTTXNibIeVKjrwZAwNDzwxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O52qDEge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0308BC4CED3;
	Sun, 26 Jan 2025 07:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737877672;
	bh=HLFoZ/RTXnZ46FvNWum031IGZxxS7sqpbzrgDdi90jg=;
	h=From:To:Cc:Subject:Date:From;
	b=O52qDEgeuHxYD2iQ4xVmnqYxiwXRFmkUqlcKMuNcYvDExkrNljEPYGIg5HmQGU/Ug
	 /xLdmcQJl0r8LS6YITXOURsoDrFjRH7Vf1NWeYRZBpPHxIex/Heg933xHgI+2XQYQt
	 T2FyMaAF6aDVsZgf2jH9M6BmaqSKuErVdM2ekeSAQHgs1ra7L/qWcBRJVfXA7Bwui6
	 JQIw6oanU4TdzC3qTSdWgiP5J0Fs8IwRp9NtQsJf2dYunc46TUkAwiH5EfpWpSIW0G
	 dhh2niwb+KzVKCI36j9CIUaA95SSBjMVt9Aoz8DpyaXk0a5r20lhoEcG6fpH76MmtA
	 YFbdLW4stYwdA==
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
Subject: [PATCH v3 0/9] x86/module: rework ROX cache to avoid writable copy
Date: Sun, 26 Jan 2025 09:47:24 +0200
Message-ID: <20250126074733.1384926-1-rppt@kernel.org>
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
https://git.kernel.org/rppt/h/execmem/x86-rox/v10

v3 changes:
* instead of adding a new module state handle ROX restoration locally in
  load_module() as Petr suggested

v2: https://lore.kernel.org/all/20250121095739.986006-1-rppt@kernel.org
* only collapse large mappings in set_memory_rox()
* simplify RW <-> ROX remapping
* don't remove ROX cache pages from the direct map (patch 4)

v1: https://lore.kernel.org/all/20241227072825.1288491-1-rppt@kernel.org

[1] https://lore.kernel.org/all/20241209083818.GK8562@noisy.programming.kicks-ass.net

Kirill A. Shutemov (1):
  x86/mm/pat: restore large ROX pages after fragmentation

Mike Rapoport (Microsoft) (8):
  x86/mm/pat: cpa-test: fix length for CPA_ARRAY test
  x86/mm/pat: drop duplicate variable in cpa_flush()
  execmem: don't remove ROX cache from the direct map
  execmem: add API for temporal remapping as RW and restoring ROX afterwards
  module: switch to execmem API for remapping as RW and restoring ROX
  Revert "x86/module: prepare module loading for ROX allocations of text"
  module: drop unused module_writable_address()
  x86: re-enable EXECMEM_ROX support

 arch/um/kernel/um_arch.c             |  11 +-
 arch/x86/Kconfig                     |   1 +
 arch/x86/entry/vdso/vma.c            |   3 +-
 arch/x86/include/asm/alternative.h   |  14 +-
 arch/x86/include/asm/pgtable_types.h |   2 +
 arch/x86/kernel/alternative.c        | 181 +++++++++-------------
 arch/x86/kernel/ftrace.c             |  30 ++--
 arch/x86/kernel/module.c             |  45 ++----
 arch/x86/mm/pat/cpa-test.c           |   2 +-
 arch/x86/mm/pat/set_memory.c         | 220 ++++++++++++++++++++++++++-
 include/linux/execmem.h              |  31 ++++
 include/linux/module.h               |  16 --
 include/linux/moduleloader.h         |   4 -
 include/linux/vm_event_item.h        |   2 +
 kernel/module/main.c                 |  78 +++-------
 kernel/module/strict_rwx.c           |   9 +-
 mm/execmem.c                         |  39 +++--
 mm/vmstat.c                          |   2 +
 18 files changed, 422 insertions(+), 268 deletions(-)


base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
-- 
2.45.2


