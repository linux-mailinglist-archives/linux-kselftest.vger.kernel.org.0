Return-Path: <linux-kselftest+bounces-24835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EC6A17ABC
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 10:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05DE16B70F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 09:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6092C1E501B;
	Tue, 21 Jan 2025 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocKHZO3s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE51E32D4;
	Tue, 21 Jan 2025 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453499; cv=none; b=keogIRXzGDax7JJVyJqvJ/OpTPWpIpi+hNDN3joMi9Dv5/EqSxvSU2I2Yy7vOU+wPmfsZTJhMTqeDPWj577m5rz6ffm1VfStC6YkwJy5kroLimOnbhJwXHkrVfk937VnwOKSHv2Pv8zJshnv4jCMQSYGNtVvGF058rOcrY4tyc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453499; c=relaxed/simple;
	bh=UnbrmexawgONPYMAXBvIF3DzXjQu5/b5KeCmUo86HRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nA7bJx/XdGhfmztGvBnc10nqT9pmf4U46jihsFU6I12l1OiCK36g25rJkuhjyzkWeH0vDsFyd507JKq0QkTQ7tY4njNr7Wxxz005D9Fx1RVnqZKmmNgQU3RQaA60nmLyLXLjjTxzuMruB3TEiWxWn60ZOgQ376yQYrhKu0B+BW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocKHZO3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F832C4CEE8;
	Tue, 21 Jan 2025 09:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737453499;
	bh=UnbrmexawgONPYMAXBvIF3DzXjQu5/b5KeCmUo86HRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocKHZO3s2nYKgIMYKCvY2VaNS7oHl41C7lwHUgZWmzrlKfcRqfeTPH/2oE+oKfDNH
	 OrSjhn2wPOxotZh6XLFFH17DIMwJ77K637m8eOjgbObsKGTjWkqw/cqXJw4Vq+f9hj
	 V4HuHpNq551E1vMq/WQW9h9FYHP/xB5Ajio1yFAaO05tC1TioOjYhY7G+6x7nKWPNM
	 fxSG+eDu9zMUA4r3QGknOIc5jkTG+uvW/rxok6BPl3uzLgpGf8p3kIlfkj9yr37vwe
	 +LYxJAiKLEMuZdBZrOSm0cVUW1OUlMURK1CzBV8RsDKsDUXSJG2hpy7Pg4p/hTvJ/3
	 kpozfaZkrYHxg==
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
Subject: [PATCH v2 02/10] x86/mm/pat: drop duplicate variable in cpa_flush()
Date: Tue, 21 Jan 2025 11:57:31 +0200
Message-ID: <20250121095739.986006-3-rppt@kernel.org>
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


