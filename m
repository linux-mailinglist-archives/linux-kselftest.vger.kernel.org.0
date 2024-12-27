Return-Path: <linux-kselftest+bounces-23771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F89F9FD13A
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 08:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 705097A080C
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 07:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BB9146D57;
	Fri, 27 Dec 2024 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I62KKwaq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4649214600C;
	Fri, 27 Dec 2024 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735284547; cv=none; b=RVmIo9kOZHdTJ2Yhr5EUSGuzd3kbXYgVMLO5K8S1aRqFEp8qk43CbiW6YAHdi+1C03llt4UUzBACtnt3eBNrDRrDNIVsTrpT0qT2hNXkuxEr1MpE0xTcKRp/dFPBmtf9YKGbumQafgi6EhaUoTejLVTycmgxoHbw+kptOcsuXwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735284547; c=relaxed/simple;
	bh=UnbrmexawgONPYMAXBvIF3DzXjQu5/b5KeCmUo86HRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snPL3nAWhBqSqnnKS2GSR1bgoTdcKfJJg4ZCoTA9gKldtKaQdPg4ATYUodOoYPickkJNsG8dK0Kr7jIKkfWlwOHH9YahHewcNQr7xZuCzEnHYm5VT03eWqf7RNDcUfwNziYViMmFFkbif9e/XGH6QIE7bIVzBo03Zu5Mv5lo5mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I62KKwaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AF3C4CED3;
	Fri, 27 Dec 2024 07:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735284545;
	bh=UnbrmexawgONPYMAXBvIF3DzXjQu5/b5KeCmUo86HRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I62KKwaqJJhDmiRCOCFElqHOy0IrCUY7TgPD5oMFrVNNByrLNnJBAipwrg+0oazxz
	 y3mtq9sKsa10GB3u8d7homMHDG3ejg6hZyXmqysnv3y72zQQVlk8gv9d80xJdQcAJE
	 7YWjLe1ZojkJECdhcV0Wy41WZB6wFXsuMBr1Qx0M17eU6vI/kUU9rpV2Q13ZDYTuj1
	 lwQUffG/rxRE/zOezN0IZLWyGMwQ12f4fnQs2qkkCEoxxkcP/2Pn4WBnEkiWebofpa
	 38EaHsODPEdVfQM4+KUaaXDC7p/NU+TzuG54YRN5ADzQA7S0uqpNaiowx7uOZeEfu3
	 COzDVqsamtyWA==
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
Subject: [PATCH 2/8] x86/mm/pat: drop duplicate variable in cpa_flush()
Date: Fri, 27 Dec 2024 09:28:19 +0200
Message-ID: <20241227072825.1288491-3-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241227072825.1288491-1-rppt@kernel.org>
References: <20241227072825.1288491-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

There is a 'struct cpa_data *data' parameter in cpa_flush() that is
assigned to a local 'struct cpa_data *cpa' variable.

Rename the parameter from 'data' to 'cpa' and drop declaration of the
local 'cpa' variable.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 95bc50a8541c..d43b919b11ae 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -396,9 +396,8 @@ static void __cpa_flush_tlb(void *data)
 		flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
 }
 
-static void cpa_flush(struct cpa_data *data, int cache)
+static void cpa_flush(struct cpa_data *cpa, int cache)
 {
-	struct cpa_data *cpa = data;
 	unsigned int i;
 
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
-- 
2.45.2


