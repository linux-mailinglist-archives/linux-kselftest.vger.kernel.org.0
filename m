Return-Path: <linux-kselftest+bounces-23777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BB89FD154
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 08:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFEF163CB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 07:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845AB14F9EB;
	Fri, 27 Dec 2024 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojHOLd1j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E29F14B956;
	Fri, 27 Dec 2024 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735284608; cv=none; b=f06YEUfqlwsc7ig3XWDwnUgXYLFfj4NkJfR3g16k57P2KLX2R6qYu/E/jcLpqNmksGXcytF8chTx4Z6Y4xJNYjbYh3dYKd44pS0RmcDxKVgMYdms3wk2PqdVGp5X5Gfo8v3L0L9IVrBLB5afZ4GzgTIcCnjg8gTnnowOiftPCCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735284608; c=relaxed/simple;
	bh=4TvuKJvEyJTpjYu41+xgE0YbwjdhXodJecvgvQg8Q9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1PAE2na/PYy3nciks0l3qIPWMZzyufTAXPYQ+JqvOF7xKiwcmJ53hQLQD9380OJQIKTyoqHnReT8VdlV+Knfymy1UPI6G/CabAcNhCePDSSh0KaLSz2ikJIW+Vdd7DmeXI3E8wFIgMNPMfD1/uidOa1BxBYgeBhzjppB4LaE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojHOLd1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BE3C4CED7;
	Fri, 27 Dec 2024 07:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735284607;
	bh=4TvuKJvEyJTpjYu41+xgE0YbwjdhXodJecvgvQg8Q9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ojHOLd1jY+IbJlMWHlQqmy11U2unw6udkZruAXzLiwt6p3tf38LSDBsdZlSGAr5Ti
	 oWt8KIUmukiINpZQ30rlaQW/esY9vKKs3doeOUrzcy8pW5ZYTPFGO0ZI3gJxReLmOn
	 YaQcqvRdKh4p95/gxdtlnhOY0W/KmRAcMm6L8WPojyDC4zVUscK6EE9nVOGL4nLjWR
	 r1cjGnKgKxQGMvk4aIJGohIjP0qxuM3ubVIpYcu1eURVo5rELi+KYU6DKD9THakf4i
	 3tyThFwaKvxwFltVsRKo7mTf+dPkTgS+g+XxaWhLAOBU/pmfaSEwU9bFMm6R9seeLv
	 0fvxg0DCRWzQw==
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
Subject: [PATCH 8/8] module: drop unused module_writable_address()
Date: Fri, 27 Dec 2024 09:28:25 +0200
Message-ID: <20241227072825.1288491-9-rppt@kernel.org>
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

module_writable_address() is unused and can be removed.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/module.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index e9fc9d1fa476..222099bb07cf 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -774,11 +774,6 @@ static inline bool is_livepatch_module(struct module *mod)
 
 void set_module_sig_enforced(void);
 
-static inline void *module_writable_address(struct module *mod, void *loc)
-{
-	return loc;
-}
-
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -886,11 +881,6 @@ static inline bool module_is_coming(struct module *mod)
 {
 	return false;
 }
-
-static inline void *module_writable_address(struct module *mod, void *loc)
-{
-	return loc;
-}
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
-- 
2.45.2


