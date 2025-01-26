Return-Path: <linux-kselftest+bounces-25186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD545A1C6CC
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 08:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4886916791B
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 07:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831551448F2;
	Sun, 26 Jan 2025 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7WS+xrD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFDC1411DE;
	Sun, 26 Jan 2025 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737877726; cv=none; b=EBSPqRtjlaaOwmPclE3Y7PqWqaEVA/LKqqV735TmX3BDf4DliJuCj95cAf6BPsSwNNsELtmvxTsz1IsytkiuyUPY8Otf/1boDVIm7Jf+j+xuzfhahz6rf/BSlGR1fviCKly8yPz3xXTxVBWTV3Qe4PccftNCsiSQVQ8jyS5YNSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737877726; c=relaxed/simple;
	bh=mjWwPz12D8IuXSas4rcsP8ghTqzzxxLYwZNdxRHbGuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXFmPiwB9jFiHkN2beyddg+o/AAyE1xAwgXQaQdcGQlWQ3zEXc8ZHMvBihaJoipSbV8SMFPmLv8kG0/vwjZRp7GgI7cJIC7q6Qm6tAdS1RsD3hG1vC8PU28J4HtkicD2vkLAAcqojTBBs3srYM8nFPkMaRm5C0j8SfUU2thuC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7WS+xrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01143C4CEE1;
	Sun, 26 Jan 2025 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737877723;
	bh=mjWwPz12D8IuXSas4rcsP8ghTqzzxxLYwZNdxRHbGuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7WS+xrD8siDHHKIewMcy4VDu761ztpMzjAypCJJ2WsNTWgjM3mc6GgvHmJQlqhBk
	 OnkGkuyPc9CJKE6wqSVz9q5vArEIkaAs95yYliIfUZrn60Z6kTJscKscpbt5txLhM7
	 cRTNesO6U4XLYOzbbXL0WlzgBkPKBKmlhy1tx1WSfpBDU7tSNQU9viL0l7X9MIM9uF
	 cCfiOh26vaEB3Y9WpnrWOn86FsEiN31h+IvXpdqwTTQkykeWsOiCKoiH9f2lYv4AzZ
	 dbMj3rG/xphiE5ifXHBrt7di3cQmP1Y9JQNoeT88cxV+Hbw4MXvC0Z6tQxVLYsexB6
	 xRwqH+ad+TyqA==
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
Subject: [PATCH v3 5/9] execmem: add API for temporal remapping as RW and restoring ROX afterwards
Date: Sun, 26 Jan 2025 09:47:29 +0200
Message-ID: <20250126074733.1384926-6-rppt@kernel.org>
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

Using a writable copy for ROX memory is cumbersome and error prone.

Add API that allow temporarily remapping of ranges in the ROX cache as
writable  and then restoring their read-only-execute permissions.

This API will be later used in modules code and will allow removing nasty
games with writable copy in alternatives patching on x86.

The restoring of the ROX permissions relies on the ability of architecture
to reconstruct large pages in its set_memory_rox() method.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/execmem.h | 31 +++++++++++++++++++++++++++++++
 mm/execmem.c            | 22 ++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 64130ae19690..65655a5d1be2 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -65,6 +65,37 @@ enum execmem_range_flags {
  * Architectures that use EXECMEM_ROX_CACHE must implement this.
  */
 void execmem_fill_trapping_insns(void *ptr, size_t size, bool writable);
+
+/**
+ * execmem_make_temp_rw - temporarily remap region with read-write
+ *			  permissions
+ * @ptr:	address of the region to remap
+ * @size:	size of the region to remap
+ *
+ * Remaps a part of the cached large page in the ROX cache in the range
+ * [@ptr, @ptr + @size) as writable and not executable. The caller must
+ * have exclusive ownership of this range and ensure nothing will try to
+ * execute code in this range.
+ *
+ * Return: 0 on success or negative error code on failure.
+ */
+int execmem_make_temp_rw(void *ptr, size_t size);
+
+/**
+ * execmem_restore_rox - restore read-only-execute permissions
+ * @ptr:	address of the region to remap
+ * @size:	size of the region to remap
+ *
+ * Restores read-only-execute permissions on a range [@ptr, @ptr + @size)
+ * after it was temporarily remapped as writable. Relies on architecture
+ * implementation of set_memory_rox() to restore mapping using large pages.
+ *
+ * Return: 0 on success or negative error code on failure.
+ */
+int execmem_restore_rox(void *ptr, size_t size);
+#else
+static inline int execmem_make_temp_rw(void *ptr, size_t size) { return 0; }
+static inline int execmem_restore_rox(void *ptr, size_t size) { return 0; }
 #endif
 
 /**
diff --git a/mm/execmem.c b/mm/execmem.c
index 04b0bf1b5025..e6c4f5076ca8 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -335,6 +335,28 @@ static bool execmem_cache_free(void *ptr)
 
 	return true;
 }
+
+int execmem_make_temp_rw(void *ptr, size_t size)
+{
+	unsigned int nr = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long addr = (unsigned long)ptr;
+	int ret;
+
+	ret = set_memory_nx(addr, nr);
+	if (ret)
+		return ret;
+
+	return set_memory_rw(addr, nr);
+}
+
+int execmem_restore_rox(void *ptr, size_t size)
+{
+	unsigned int nr = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long addr = (unsigned long)ptr;
+
+	return set_memory_rox(addr, nr);
+}
+
 #else /* CONFIG_ARCH_HAS_EXECMEM_ROX */
 static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
 {
-- 
2.45.2


