Return-Path: <linux-kselftest+bounces-25183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4DAA1C6BD
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 08:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E8A188827D
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 07:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11FD13D893;
	Sun, 26 Jan 2025 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip3YgJ3Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB7C132103;
	Sun, 26 Jan 2025 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737877693; cv=none; b=aUJWFnnizTfyhyXc/UwsznmQSiIn7ECW8m6mIdaAk53vBEKbVzdBHdQDQs2zbSS56DJEWh52ErN3tajuPprCgYZ4ZSgRzJe53YNlb9b4azx+3kmoHfiKiuxwXJ1CATwC1BWCjCT6v8/Wf1ze8wc4m5/80SWM7WELd+siqMSfgRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737877693; c=relaxed/simple;
	bh=UnbrmexawgONPYMAXBvIF3DzXjQu5/b5KeCmUo86HRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4PAdDZYepXLyeLfV/k5K2ENmVHtdAY/EAzXa0wCTOErNncdo++oVvfVb+Yryeb4/txSfSGNcvP686ZIoQY+JkHXqJm8Ci0x9M0w+lYBTff/vfPE/oCsDRxE4fePfg3PWx+kh+dVupesbyinhkcDDYhRNs2RqW4vH1Vn4P5zx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip3YgJ3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EF0C4CED3;
	Sun, 26 Jan 2025 07:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737877693;
	bh=UnbrmexawgONPYMAXBvIF3DzXjQu5/b5KeCmUo86HRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ip3YgJ3YSP9SXdUh/kxhiQVdDs3WVvuBouH5X89T+VIIo6TzzE7FCt0gM5JJ90qdB
	 qFokyCnFrMLuusz7d73gejhGjtpaGSOXriTKI4BIE1yBpNhZEiDufYAcmk+Bny0+pi
	 mka5HQUFLD61qPJQ38dTyd3ZKji3uDer4OdT9bFadlUYLCQs+5YalQ3gY2xBjNUrYT
	 hZa97zbHTVoKXZmQKChwE4mHoQs3pRngNrmPu2jrkNiOIXVi1uwbrn+txO4g/aUq6L
	 gISj+VrDa5T7aQN4aew1n4foLfwHD83fvLl/TKDYXV703XcKmVLgmgNS/HPpngfLaF
	 tGV4//yCmaeKQ==
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
Subject: [PATCH v3 2/9] x86/mm/pat: drop duplicate variable in cpa_flush()
Date: Sun, 26 Jan 2025 09:47:26 +0200
Message-ID: <20250126074733.1384926-3-rppt@kernel.org>
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


