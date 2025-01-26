Return-Path: <linux-kselftest+bounces-25189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0863A1C6E1
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 08:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE02E16793D
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 07:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2733E14659A;
	Sun, 26 Jan 2025 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WptzH7Yd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E882C13D638;
	Sun, 26 Jan 2025 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737877756; cv=none; b=XwfKEb5qCLNT0cOOuOAFBjKzimSRA0lEp8jJHR4eY7X2WMAWoyLakJgslytHtcVI8YdIyb9cidREz5EsoWfkOEUo0BGuN0GtJlOk8YNP+sj/XsbhpabsbYv1uFin/ovia/s2FRi7au7P/PT88pT684F59JEoARXLTq5arFYnVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737877756; c=relaxed/simple;
	bh=ojukvsVbrsOautblNhkpoP7wuqi3ozWbxIf3p0+h6f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loF/G3/e6Gxc8ye/gcVPNKGZEm74OFcCy4vPJSF+/12MmEcKk4tjsUOBsOQL0chgWgRiPZyGckWgpGG4WCZPd9UHh9oY2ChbStPs61NghGUO3F4+darFgGsTOhj+idBV2/rMc9UtO0EeqbJ/SFIrZPUqg4R5058qi5pMc/1Q76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WptzH7Yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6817C4CEE4;
	Sun, 26 Jan 2025 07:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737877754;
	bh=ojukvsVbrsOautblNhkpoP7wuqi3ozWbxIf3p0+h6f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WptzH7YdSogdAkUSZLvcqplIdwp+MBY+laOzNuHQ78GWRSBBOknbXpAk7uYSnJrMz
	 wp2yZtsEj4Ft7cNz7tQlCeN1KsCLqDz9mqnl+TnipPcoTYtEO+sXiQJQboHjiChfNL
	 vA3aEX4vPp8wpDbDReIBYoQLGzjtwfHwBMvGsAAMDNHt03hVTP8VPftd6hLurGej+P
	 AsbRuca4pr2+C6v3mt4e73OWtBqd80b+EHsrPFjsLsq4grSJSpFTAnEyDf77cnhJcr
	 sx71WcZSLvCbmLvRIC86nvUK0DVK2x50qb/+CGX6umGCycAkK1HmtBx/EyszcSrn67
	 bHDc6aXclkXIg==
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
Subject: [PATCH v3 8/9] module: drop unused module_writable_address()
Date: Sun, 26 Jan 2025 09:47:32 +0200
Message-ID: <20250126074733.1384926-9-rppt@kernel.org>
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

module_writable_address() is unused and can be removed.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/module.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 6a24e9395cb2..d2cf30be10cc 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -768,11 +768,6 @@ static inline bool is_livepatch_module(struct module *mod)
 
 void set_module_sig_enforced(void);
 
-static inline void *module_writable_address(struct module *mod, void *loc)
-{
-	return loc;
-}
-
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -880,11 +875,6 @@ static inline bool module_is_coming(struct module *mod)
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


