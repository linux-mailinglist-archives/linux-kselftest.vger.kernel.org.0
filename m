Return-Path: <linux-kselftest+bounces-23770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5709F9FD132
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 08:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6EF163CF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 07:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB211465BE;
	Fri, 27 Dec 2024 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIKjst/1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9241448DC;
	Fri, 27 Dec 2024 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735284536; cv=none; b=AkpuyGN9dpZhc9qgwKIcy1PEHionrJ5yN3iVMX0iBI9Fww56jempGUNpp6ROXc5O6WQwZjkBh4BwQYcb9aY13GsM/Oq8C10Hh+0tASP7I3FZJDVcubHxhgb7ZuWw68wVVmD5pyQqSh4AuuZjrMj6CyGyol9UMUGvWCQGlNvfShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735284536; c=relaxed/simple;
	bh=dDY3jvGc45EmH43gWTWL5MYq9/Q1o2IM8rTUBWv64F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSymvEPxNwS1YCCFq5V3MaOn8WfRAIFVxMRVlsWSiVk/RqWTKnxmoGiWv44SSDYbXOuJBtA1YNsgjuFnmXsIiLhji+6w/IQXlS8YtRYzK+yhVrNF+0VBOIk21CnMQCaqADdVRTQIf/3kI9SOwz34dDZMGLC+Qmc2jX/bGvLmix0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIKjst/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE67BC4CEE0;
	Fri, 27 Dec 2024 07:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735284535;
	bh=dDY3jvGc45EmH43gWTWL5MYq9/Q1o2IM8rTUBWv64F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XIKjst/1wY9OLHzpWhKj4UYzvvFmcR4hmg80K6xgftHuqpsmSc/WhiGud59GDjjzi
	 aNz3dTtAuVNVEHjllJa1agh/PcGzzQ66TpAnxGLd8odvdPn/NGL5AyLFLNK0v+Lnhp
	 bhPN1Os0xv0DFA2Rowt02pnOqtwzGCgnOcp8m0lYJbqUII24zTaeAR3jrs4wuFfxUY
	 +QIvMRxsnN0EZtVPbUliy1r7vLNbumpP1LYjLd+z4MU8NZ06lZWiXEn3S3nkWyCjKQ
	 N/1w2f1V8lMe32qPhndZ+dbjWAY10MCC6iOXhG754bFZ9u/qEZfhDQflknVMn5jliH
	 ZskGTUVYsxgjw==
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
Subject: [PATCH 1/8] x86/mm/pat: cpa-test: fix length for CPA_ARRAY test
Date: Fri, 27 Dec 2024 09:28:18 +0200
Message-ID: <20241227072825.1288491-2-rppt@kernel.org>
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

The CPA_ARRAY test always uses len[1] as numpages argument to
change_page_attr_set() although the addresses array is different each
iteration of the test loop.

Replace len[1] with len[i] to have numpages matching the addresses array.

Fixes: ecc729f1f471 ("x86/mm/cpa: Add ARRAY and PAGES_ARRAY selftests")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/cpa-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/cpa-test.c b/arch/x86/mm/pat/cpa-test.c
index 3d2f7f0a6ed1..ad3c1feec990 100644
--- a/arch/x86/mm/pat/cpa-test.c
+++ b/arch/x86/mm/pat/cpa-test.c
@@ -183,7 +183,7 @@ static int pageattr_test(void)
 			break;
 
 		case 1:
-			err = change_page_attr_set(addrs, len[1], PAGE_CPA_TEST, 1);
+			err = change_page_attr_set(addrs, len[i], PAGE_CPA_TEST, 1);
 			break;
 
 		case 2:
-- 
2.45.2


