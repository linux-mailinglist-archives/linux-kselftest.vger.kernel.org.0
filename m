Return-Path: <linux-kselftest+bounces-23769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16989FD12D
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 08:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB24163AAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 07:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188AD145B1D;
	Fri, 27 Dec 2024 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWflVN7V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077513DDD3;
	Fri, 27 Dec 2024 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735284526; cv=none; b=S6Ba99Hcy970ECNLXm9NlgyzNBJmKB/z21e/wE0gMzHbeD/xFzmg4lZ0XuD3+al+TVL78vTvhU7KpMRaEdv3Cxt9DXI9n0A6kRae21h3l0HzWyIhtN2ia1XWM96aLGvpoQnaD61NJ5/HICKv2VVNVQRlF/ZtQOXH5mVua/3ANA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735284526; c=relaxed/simple;
	bh=jbs+82vTwYkxQ3EpjI+1yvm0nBPBr9HhcF8xhKMgyb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sryd9bmshc9uGklD1hy/cCeXzwuudDVAqYTBr2h/FF3nkaO2bxTqKTlf4SpAnIVm3sfr1yKHcaILypQaL3MBH5RwZvGzJaIo7wLNrBRB+cmcGZOUdEH6lY401p9DCiltyMS8sCHsbmrMoiilfz58KbZTGpcejaOh6S+cJC27kW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWflVN7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BECBC4CED0;
	Fri, 27 Dec 2024 07:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735284525;
	bh=jbs+82vTwYkxQ3EpjI+1yvm0nBPBr9HhcF8xhKMgyb4=;
	h=From:To:Cc:Subject:Date:From;
	b=VWflVN7Vf0mMrePAw/GmezMrZdtva3K3h36HGmBxa/KroU575WF5NJHeh0C6TXNjF
	 qQhJ4X9PGAqzjrUVpQRiVvwIGMd+mISM5MQXFvk45sfhmzlny3nUqVMIbeY6kdii/w
	 zWWKCDoOIlTrr71quUFFRbqLg+DHcfKtQtVHdMmb1lnaMhGLAzyiY7V3autquhweL9
	 gpxz7kV3lQ4EAySR1yDZ2syQZsNyGHLgB/w6HxDmV2RAqrWKXeYkMQOMk5oc3c8Pn5
	 sSBAIqOuQ0ZL0h2iDfLAfuFMjvlnSpx46Mfk1CVcx/gQmlnCTUUVbl2c6KeEM5cwGT
	 y+LUWaqHdI5Jg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
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
	live-patching@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 0/8] x86/module: rework ROX cache to avoid writable copy
Date: Fri, 27 Dec 2024 09:28:17 +0200
Message-ID: <20241227072825.1288491-1-rppt@kernel.org>
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

To keep the ROX memory mapped with large pages, make set_memory code
capable of restoring large pages (more details are in patch 3).

The patches also available in git
https://git.kernel.org/rppt/h/execmem/x86-rox/v8

[1] https://lore.kernel.org/all/20241209083818.GK8562@noisy.programming.kicks-ass.net

Kirill A. Shutemov (1):
  x86/mm/pat: Restore large pages after fragmentation

Mike Rapoport (Microsoft) (7):
  x86/mm/pat: cpa-test: fix length for CPA_ARRAY test
  x86/mm/pat: drop duplicate variable in cpa_flush()
  execmem: add API for temporal remapping as RW and restoring ROX
    afterwards
  module: introduce MODULE_STATE_GONE
  modules: switch to execmem API for remapping as RW and restoring ROX
  Revert "x86/module: prepare module loading for ROX allocations of
    text"
  module: drop unused module_writable_address()

 arch/um/kernel/um_arch.c                      |  11 +-
 arch/x86/entry/vdso/vma.c                     |   3 +-
 arch/x86/include/asm/alternative.h            |  14 +-
 arch/x86/include/asm/pgtable_types.h          |   2 +
 arch/x86/kernel/alternative.c                 | 181 ++++++---------
 arch/x86/kernel/ftrace.c                      |  30 ++-
 arch/x86/kernel/module.c                      |  45 ++--
 arch/x86/mm/pat/cpa-test.c                    |   2 +-
 arch/x86/mm/pat/set_memory.c                  | 216 +++++++++++++++++-
 include/linux/execmem.h                       |  31 +++
 include/linux/module.h                        |  21 +-
 include/linux/moduleloader.h                  |   4 -
 include/linux/vm_event_item.h                 |   2 +
 kernel/module/kallsyms.c                      |   8 +-
 kernel/module/kdb.c                           |   2 +-
 kernel/module/main.c                          |  86 ++-----
 kernel/module/procfs.c                        |   2 +-
 kernel/module/strict_rwx.c                    |   9 +-
 kernel/tracepoint.c                           |   2 +
 lib/kunit/test.c                              |   2 +
 mm/execmem.c                                  | 118 ++++++++--
 mm/vmstat.c                                   |   2 +
 samples/livepatch/livepatch-callbacks-demo.c  |   1 +
 .../test_modules/test_klp_callbacks_demo.c    |   1 +
 .../test_modules/test_klp_callbacks_demo2.c   |   1 +
 .../livepatch/test_modules/test_klp_state.c   |   1 +
 .../livepatch/test_modules/test_klp_state2.c  |   1 +
 27 files changed, 511 insertions(+), 287 deletions(-)

-- 
2.45.2


