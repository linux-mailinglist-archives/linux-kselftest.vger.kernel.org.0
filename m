Return-Path: <linux-kselftest+bounces-24843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F58A17AE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 11:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B5B16B724
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8581F1308;
	Tue, 21 Jan 2025 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lO3rwmtK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACB11EEA37;
	Tue, 21 Jan 2025 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453569; cv=none; b=twZpZKvE6cRCoYkTYB6RP0vRSGXPQkdz+Ln61Ek2qNIAwBlULN5qsRq95HdzgI5fCYVpoRKs6wp55HzqzTTZMq6qQM5YNtRC9jrC7vgCLtqifAJzVp47BpHq6Ei5qEzFdCzlNjgpZkEBqVlq3yLbU2Tl1N1RQ8bhXmbREstO6eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453569; c=relaxed/simple;
	bh=4TvuKJvEyJTpjYu41+xgE0YbwjdhXodJecvgvQg8Q9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0mcuFCsyTiju9Dml60+3ig9QDxeqyiUdAIVQENvb+UYVSSV+11TfS/qyZ62laqfFez2VBIIoE2ejEv4rtKsBDUR5e4m7OhzKu9e9gqkES/q/qL//8PgMvhYEQjNoP+blLiKY8mQGFMNiuZSQh9knQ7O4+gJRNO1hgULL/50ekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO3rwmtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653E5C4CEE3;
	Tue, 21 Jan 2025 09:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737453568;
	bh=4TvuKJvEyJTpjYu41+xgE0YbwjdhXodJecvgvQg8Q9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lO3rwmtKdjvSyOTkukuBYX/Kdfyf9ugRWHUvmt5sFPUPJJKND4k1Tfj4UvoLYIsdV
	 oMnnlIybnBcPJwyP7hLurwTy1FLO7xU5YCGVEO4Z9YNxa+A+ivvZR7sHrg0llrLDLo
	 zHUHAR4TwpX+KvSBv9cOcBh0SRHwfc9WH1EqHO/ASARkmR+neVEbRiV3a+OWzFyv+l
	 DQOMpeYbBHK4xkv86LMQM8yPr/9hrKuU0W9li6HW/W91RunXsLhWHt9O/DhA7s1odH
	 VV4Eh8wESQ4/3qjlQGGAmyrDuIfg102fTw3gngm4/Pzu406yb9upTxzi6m79TptDtR
	 IiWq4ZvvCndmA==
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
Subject: [PATCH v2 09/10] module: drop unused module_writable_address()
Date: Tue, 21 Jan 2025 11:57:38 +0200
Message-ID: <20250121095739.986006-10-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250121095739.986006-1-rppt@kernel.org>
References: <20250121095739.986006-1-rppt@kernel.org>
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


