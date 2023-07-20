Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3238175B4B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjGTQk3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 12:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjGTQkG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 12:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC721FED
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689871087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPdSzcTTJlOeO2aEdgyECLhQy37txJLWdi6TDmez9kY=;
        b=LWKi0K/q2ObYXtpQvUhLsqzKoDTeKes4e0GXnlqnYpQMO8NYEmeIrfVOd7bmBuDRriu5GP
        dGnmn4Qc7SNbRZfSXmNOZ11Fya4QTCNaoIPGnx9qbaULS4N4wFAm0fMTPHRfrUGXN40YN3
        NtXC7pNwAPZ7tvbknJRn9U7IyABBIuE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-kFK-c7oyNgC289gF1X8KZw-1; Thu, 20 Jul 2023 12:34:11 -0400
X-MC-Unique: kFK-c7oyNgC289gF1X8KZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FA07101A54E;
        Thu, 20 Jul 2023 16:34:08 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29A9240C206F;
        Thu, 20 Jul 2023 16:33:59 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: [RFC PATCH v2 16/20] rcu: Make RCU dynticks counter size configurable
Date:   Thu, 20 Jul 2023 17:30:52 +0100
Message-Id: <20230720163056.2564824-17-vschneid@redhat.com>
In-Reply-To: <20230720163056.2564824-1-vschneid@redhat.com>
References: <20230720163056.2564824-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CONTEXT_TRACKING_WORK reduces the size of the dynticks counter to free up
some bits for work deferral. Paul suggested making the actual counter size
configurable for rcutorture to poke at, so do that.

Make it only configurable under RCU_EXPERT. Previous commits have added
build-time checks that ensure a kernel with problematic dynticks counter
width can't be built.

Link: http://lore.kernel.org/r/4c2cb573-168f-4806-b1d9-164e8276e66a@paulmck-laptop
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/context_tracking.h       |  3 ++-
 include/linux/context_tracking_state.h |  3 +--
 kernel/rcu/Kconfig                     | 33 ++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 8aee086d0a25f..9c0c622bc27bb 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -12,7 +12,8 @@
 
 #ifdef CONFIG_CONTEXT_TRACKING_WORK
 static_assert(CONTEXT_WORK_MAX_OFFSET <= CONTEXT_WORK_END + 1 - CONTEXT_WORK_START,
-	      "Not enough bits for CONTEXT_WORK");
+	      "Not enough bits for CONTEXT_WORK, "
+	      "CONFIG_RCU_DYNTICKS_BITS might be too high");
 #endif
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 828fcdb801f73..292a0b7c06948 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -58,8 +58,7 @@ enum ctx_state {
 #define CONTEXT_STATE_START 0
 #define CONTEXT_STATE_END   (bits_per(CONTEXT_MAX - 1) - 1)
 
-#define RCU_DYNTICKS_BITS  (IS_ENABLED(CONFIG_CONTEXT_TRACKING_WORK) ? 16 : 31)
-#define RCU_DYNTICKS_START (CT_STATE_SIZE - RCU_DYNTICKS_BITS)
+#define RCU_DYNTICKS_START (CT_STATE_SIZE - CONFIG_RCU_DYNTICKS_BITS)
 #define RCU_DYNTICKS_END   (CT_STATE_SIZE - 1)
 #define RCU_DYNTICKS_IDX   BIT(RCU_DYNTICKS_START)
 
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bdd7eadb33d8f..1ff2aab24e964 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -332,4 +332,37 @@ config RCU_DOUBLE_CHECK_CB_TIME
 	  Say Y here if you need tighter callback-limit enforcement.
 	  Say N here if you are unsure.
 
+config RCU_DYNTICKS_RANGE_BEGIN
+	int
+	depends on !RCU_EXPERT
+	default 31 if !CONTEXT_TRACKING_WORK
+	default 16 if CONTEXT_TRACKING_WORK
+
+config RCU_DYNTICKS_RANGE_BEGIN
+	int
+	depends on RCU_EXPERT
+	default 2
+
+config RCU_DYNTICKS_RANGE_END
+	int
+	default 31 if !CONTEXT_TRACKING_WORK
+	default 16 if CONTEXT_TRACKING_WORK
+
+config RCU_DYNTICKS_BITS_DEFAULT
+       int
+       default 31 if !CONTEXT_TRACKING_WORK
+       default 16 if CONTEXT_TRACKING_WORK
+
+config RCU_DYNTICKS_BITS
+	int "Dynticks counter width" if CONTEXT_TRACKING_WORK
+	range RCU_DYNTICKS_RANGE_BEGIN RCU_DYNTICKS_RANGE_END
+	default RCU_DYNTICKS_BITS_DEFAULT
+	help
+	  This option controls the width of the dynticks counter.
+
+	  Lower values will make overflows more frequent, which will increase
+	  the likelihood of extending grace-periods.
+
+	  Don't touch this unless you are running some tests.
+
 endmenu # "RCU Subsystem"
-- 
2.31.1

