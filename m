Return-Path: <linux-kselftest+bounces-25185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AFFA1C6C9
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 08:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047F73A84AE
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 07:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3905613D893;
	Sun, 26 Jan 2025 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IL59FVJx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ECC13BAF1;
	Sun, 26 Jan 2025 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737877715; cv=none; b=GS+1U9l3hafcjz4AzwNVrr7lx87n2YYltkg59pvxAbgS4RSP9itwLLDcWo5iiCbiXjDcxqYdB9uVVgBTNiD2mGcBIpW6CSPpTLAvxz7Q19RtHh4QLGEo88x/LqF4THiPsNggs5WJykgl6ZuBQNGcyudcxnciawahmmNdcLObtoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737877715; c=relaxed/simple;
	bh=WqNu22Xx50tarZUt/SmRrxy/7e4ez9U96yWXlx51zT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/7vARGCzdibSvoMlz1sbhNDOewkwSsIBuZK+exYCq75LIA9XYQwdwR/PhmbaHaCNZfvbsnpo0znDMnyxHKNRtNSOOYaP0LI8MrkWTdENuxO8lCldDS8rGLPiaLAJaSpnzdPByDv7Cw8WtRKBHbvqOa1cx0Nc4iPBt/v++qhW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IL59FVJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68E5C4CED3;
	Sun, 26 Jan 2025 07:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737877713;
	bh=WqNu22Xx50tarZUt/SmRrxy/7e4ez9U96yWXlx51zT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IL59FVJxiCVgMaLJ03jJ6YzpD01XNIwi0gBNBKK07c1A9UrVVp+DeEZ2rkk7RHr1N
	 3eCIN13xm6EvJVgb+JieAsSB1dycOK5Wu4U/lIDmwOBa+Ay/gXeb3XbE5qlN4n3kAN
	 G1IlICvvFL6lbfPBKeM4SUCMyOE/tFMGD4lfJ/zOBMWVcstXeVBL860ETBQnFLlBvf
	 Jyf0FcnNBGdRU/dR1FtpOF0iGnFBcVUFKQg9B0G1UEXNo0SXlQqdzGtBgyE3i8oivO
	 FhaZajQrYx2jRx1ihqabOGFmS9UJ4kFAH+SMbk13mmJb7Tlj7vJokgTrtOiuhYSown
	 5p9cUgf6XD/Eg==
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
Subject: [PATCH v3 4/9] execmem: don't remove ROX cache from the direct map
Date: Sun, 26 Jan 2025 09:47:28 +0200
Message-ID: <20250126074733.1384926-5-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250126074733.1384926-1-rppt@kernel.org>
References: <20250126074733.1384926-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

The memory allocated for the ROX cache was removed from the direct map to
reduce amount of direct map updates, however this cannot be tolerated by
/proc/kcore that accesses module memory using vread_iter() and the latter
does vmalloc_to_page() and copy_page_to_iter_nofault().

Instead of removing ROX cache memory from the direct map and mapping it as
ROX in vmalloc space, simply call set_memory_rox() that will take care of
proper permissions on both vmalloc and in the direct map.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/execmem.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 317b6a8d35be..04b0bf1b5025 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -257,7 +257,6 @@ static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
 static int execmem_cache_populate(struct execmem_range *range, size_t size)
 {
 	unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
-	unsigned long start, end;
 	struct vm_struct *vm;
 	size_t alloc_size;
 	int err = -ENOMEM;
@@ -275,26 +274,18 @@ static int execmem_cache_populate(struct execmem_range *range, size_t size)
 	/* fill memory with instructions that will trap */
 	execmem_fill_trapping_insns(p, alloc_size, /* writable = */ true);
 
-	start = (unsigned long)p;
-	end = start + alloc_size;
-
-	vunmap_range(start, end);
-
-	err = execmem_set_direct_map_valid(vm, false);
-	if (err)
-		goto err_free_mem;
-
-	err = vmap_pages_range_noflush(start, end, range->pgprot, vm->pages,
-				       PMD_SHIFT);
+	err = set_memory_rox((unsigned long)p, vm->nr_pages);
 	if (err)
 		goto err_free_mem;
 
 	err = execmem_cache_add(p, alloc_size);
 	if (err)
-		goto err_free_mem;
+		goto err_reset_direct_map;
 
 	return 0;
 
+err_reset_direct_map:
+	execmem_set_direct_map_valid(vm, true);
 err_free_mem:
 	vfree(p);
 	return err;
-- 
2.45.2


