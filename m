Return-Path: <linux-kselftest+bounces-25190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72858A1C6E5
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 08:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F0016609A
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 07:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FED1487C8;
	Sun, 26 Jan 2025 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4s+daeo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6729145B16;
	Sun, 26 Jan 2025 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737877764; cv=none; b=CVcwkyaFDusUOoDe/cAy3Pd0Xb3WMtzPNSKzWJUyMJkqnUSIuO9ce5W0+ymXATzUPHrM278ZJcmABHCzRUAPr3K3hk4BGA3rzwjeJ95hl5sjc8RBvZ922J4kasvjl9OVDaqO+FqMwCFkmEPySByk/jU2teIVxbZmhY3Yt+0K3pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737877764; c=relaxed/simple;
	bh=iCOJADJJ/sFPbuOid5OXzq1M+MQ1WlHyV9KAisT6QLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkXzEnc94JntCnYRoj3bvjx6hqBPntyGsHP6qJhQnpXfB+F0P3L67CnNWnFoqos6qBsUKlY2B7ItrtAohi/fd1/8a+e1v9yAbPA4QbP1xYNGyK23klMoMP3p43ro1gqLbQV7vPRZ4yX1md++CL20B7YFqNjdukdGPAYmQwn1GQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4s+daeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B87C4CED3;
	Sun, 26 Jan 2025 07:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737877764;
	bh=iCOJADJJ/sFPbuOid5OXzq1M+MQ1WlHyV9KAisT6QLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4s+daeo5ZtRx6Gu4vJ/P5va2/Zc1aBNvpydz9rKkSVitnt5s4tQ4p7lT4T7koHi2
	 wvqpFOfNIJ4JvEi6mI2AH0DeuLwKbVe3rJ5HBW4E9DuKwRa24y9nMYZzZEoMxFBPuj
	 r3lfMvP/zDLkxMw27lf06oOh8SETm1Dsfzs9boTj7kyerxd4kK4XYTdJQnf5NnqRU7
	 2nOaBRt/YCtwpuvvVDC9No5WR+kbAukE44WO5GnFFgtxx9m3AtHPGru2xrot7i52tK
	 my4z9DG0wF6kJFGXr/ty1oVp9XX+EnLvBW/nOKu6f8wEe7Q70aCehyXls3uZlat3aP
	 plrNoZEvAzEAA==
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
Subject: [PATCH v3 9/9] x86: re-enable EXECMEM_ROX support
Date: Sun, 26 Jan 2025 09:47:33 +0200
Message-ID: <20250126074733.1384926-10-rppt@kernel.org>
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

after rework of execmem ROX caches

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ef6cfea9df73..9d7bd0ae48c4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -83,6 +83,7 @@ config X86
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
 	select ARCH_HAS_EARLY_DEBUG		if KGDB
 	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_EXECMEM_ROX		if X86_64
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
-- 
2.45.2


