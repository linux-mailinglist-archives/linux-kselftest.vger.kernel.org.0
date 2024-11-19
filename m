Return-Path: <linux-kselftest+bounces-22285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25489D2A49
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 16:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1F66B32D82
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B8D1D1F7B;
	Tue, 19 Nov 2024 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hw1vnOoG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980881D1E71
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030631; cv=none; b=rqQ/pEPqDuEdYK/TIE0u3A+2fSvzJtWe+Rbl2BqWxJsAklNC73T9Dytmytilzx/BJJnD+nRHz13WIG0R5RxS5NxJk7Y1KhiwtEps6e1ieWsrn2KnKfAYhhh5OJwQbB292ViuuDasH+WjCjebfwTepSXlom916F5rq//pJra4VaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030631; c=relaxed/simple;
	bh=bTnrUBgUrau8YQv+XQ05EAUivqZb8FcVO7sSJMvjJKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayCW4IvKEN5FQbuox8HFBh+lpRGG0P0SXAxyO3VPfaCSYGUGaHknVYLutDKv4xqbPLhO/88MhZYIVjYexZlVZFMPYpIBnS6MLp8LnyJxcPAEO+DFKCB47AiBzFeFnMpJTDt4FWnIDS31LS1fbdf3R8iuD75qrClUCVZ+sSf700I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hw1vnOoG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732030627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/zjMAAzjZ63CvtK65oto4Glzya8ix3n4q04/5M16qM=;
	b=hw1vnOoGvihMnz5J0IjLUXQNS+DglJmSwpysWTGyYdip7IYJGFoqRJkQQ3H+Tppm9HYil4
	tJU/uFtitqo03rbyfWv2vzIt6V4PF8kVXp650EfpvanJnRpNOlMq4eXtA/3gXMl9qHWdH3
	5kGjaLlCj3NNZ5RAGo8uWxQzoN3ncxs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-nbrc9rTzMP-Bp1uCFPcarg-1; Tue,
 19 Nov 2024 10:37:04 -0500
X-MC-Unique: nbrc9rTzMP-Bp1uCFPcarg-1
X-Mimecast-MFC-AGG-ID: nbrc9rTzMP-Bp1uCFPcarg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4EB41952D0D;
	Tue, 19 Nov 2024 15:36:56 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.194.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC7F330001A2;
	Tue, 19 Nov 2024 15:36:40 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	x86@kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nadav Amit <namit@vmware.com>,
	Dan Carpenter <error27@gmail.com>,
	Chuang Wang <nashuiliang@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Petr Mladek <pmladek@suse.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Song Liu <song@kernel.org>,
	Julian Pidancet <julian.pidancet@oracle.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>
Subject: [RFC PATCH v3 04/15] rcu: Add a small-width RCU watching counter debug option
Date: Tue, 19 Nov 2024 16:34:51 +0100
Message-ID: <20241119153502.41361-5-vschneid@redhat.com>
In-Reply-To: <20241119153502.41361-1-vschneid@redhat.com>
References: <20241119153502.41361-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

A later commit will reduce the size of the RCU watching counter to free up
some bits for another purpose. Paul suggested adding a config option to
test the extreme case where the counter is reduced to its minimum usable
width for rcutorture to poke at, so do that.

Make it only configurable under RCU_EXPERT. While at it, add a comment to
explain the layout of context_tracking->state.

Link: http://lore.kernel.org/r/4c2cb573-168f-4806-b1d9-164e8276e66a@paulmck-laptop
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/context_tracking_state.h | 44 ++++++++++++++++++++++----
 kernel/rcu/Kconfig.debug               | 14 ++++++++
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 7b8433d5a8efe..0b81248aa03e2 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -18,12 +18,6 @@ enum ctx_state {
 	CT_STATE_MAX		= 4,
 };
 
-/* Odd value for watching, else even. */
-#define CT_RCU_WATCHING CT_STATE_MAX
-
-#define CT_STATE_MASK (CT_STATE_MAX - 1)
-#define CT_RCU_WATCHING_MASK (~CT_STATE_MASK)
-
 struct context_tracking {
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 	/*
@@ -44,9 +38,45 @@ struct context_tracking {
 #endif
 };
 
+/*
+ * We cram two different things within the same atomic variable:
+ *
+ *                     CT_RCU_WATCHING_START  CT_STATE_START
+ *                                |                |
+ *                                v                v
+ *     MSB [ RCU watching counter ][ context_state ] LSB
+ *         ^                       ^
+ *         |                       |
+ * CT_RCU_WATCHING_END        CT_STATE_END
+ *
+ * Bits are used from the LSB upwards, so unused bits (if any) will always be in
+ * upper bits of the variable.
+ */
 #ifdef CONFIG_CONTEXT_TRACKING
+#define CT_SIZE (sizeof(((struct context_tracking *)0)->state) * BITS_PER_BYTE)
+
+#define CT_STATE_WIDTH bits_per(CT_STATE_MAX - 1)
+#define CT_STATE_START 0
+#define CT_STATE_END   (CT_STATE_START + CT_STATE_WIDTH - 1)
+
+#define CT_RCU_WATCHING_MAX_WIDTH (CT_SIZE - CT_STATE_WIDTH)
+#define CT_RCU_WATCHING_WIDTH     (IS_ENABLED(CONFIG_RCU_DYNTICKS_TORTURE) ? 2 : CT_RCU_WATCHING_MAX_WIDTH)
+#define CT_RCU_WATCHING_START     (CT_STATE_END + 1)
+#define CT_RCU_WATCHING_END       (CT_RCU_WATCHING_START + CT_RCU_WATCHING_WIDTH - 1)
+#define CT_RCU_WATCHING           BIT(CT_RCU_WATCHING_START)
+
+#define CT_STATE_MASK        GENMASK(CT_STATE_END,        CT_STATE_START)
+#define CT_RCU_WATCHING_MASK GENMASK(CT_RCU_WATCHING_END, CT_RCU_WATCHING_START)
+
+#define CT_UNUSED_WIDTH (CT_RCU_WATCHING_MAX_WIDTH - CT_RCU_WATCHING_WIDTH)
+
+static_assert(CT_STATE_WIDTH        +
+	      CT_RCU_WATCHING_WIDTH +
+	      CT_UNUSED_WIDTH       ==
+	      CT_SIZE);
+
 DECLARE_PER_CPU(struct context_tracking, context_tracking);
-#endif
+#endif	/* CONFIG_CONTEXT_TRACKING */
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 static __always_inline int __ct_state(void)
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 9b0b52e1836fa..8dc505d841f8d 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -168,4 +168,18 @@ config RCU_STRICT_GRACE_PERIOD
 	  when looking for certain types of RCU usage bugs, for example,
 	  too-short RCU read-side critical sections.
 
+
+config RCU_DYNTICKS_TORTURE
+	bool "Minimize RCU dynticks counter size"
+	depends on RCU_EXPERT
+	default n
+	help
+	  This option controls the width of the dynticks counter.
+
+	  Lower values will make overflows more frequent, which will increase
+	  the likelihood of extending grace-periods. This option sets the width
+	  to its minimum usable value.
+
+	  This has no value for production and is only for testing.
+
 endmenu # "RCU Debugging"
-- 
2.43.0


