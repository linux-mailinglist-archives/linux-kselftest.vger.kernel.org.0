Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084CB75B44C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 18:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjGTQdY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 12:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjGTQdX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 12:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EFF1FF9
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 09:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689870740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/8mq5c0cbFoNC4kMb4OaVtFnN/bUBn9qmubvCUjumA=;
        b=Iqa7XZfAbrPeqeIHzZdxZrC8conlXzvzc+DavlGijcQ6qvfMzkxZTMpfQQ/l7woa+R/0YI
        b43y0Dtnx8Z5ziWnJZ9legigCfrecTGZm2P1dL5Ik3evanDom/jeK2NzeVov2J4mvrR4vN
        Hq6yfq5m6WNAvGU5DgZzmEwQly5Hb0w=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-y6uyriohNKyYlI_N0r9yPA-1; Thu, 20 Jul 2023 12:32:19 -0400
X-MC-Unique: y6uyriohNKyYlI_N0r9yPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84E3A1C05EAE;
        Thu, 20 Jul 2023 16:32:16 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83E5540C2070;
        Thu, 20 Jul 2023 16:32:08 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: [RFC PATCH v2 03/20] tracing/filters: Enable filtering a scalar field by a cpumask
Date:   Thu, 20 Jul 2023 17:30:39 +0100
Message-Id: <20230720163056.2564824-4-vschneid@redhat.com>
In-Reply-To: <20230720163056.2564824-1-vschneid@redhat.com>
References: <20230720163056.2564824-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Several events use a scalar field to denote a CPU:
o sched_wakeup.target_cpu
o sched_migrate_task.orig_cpu,dest_cpu
o sched_move_numa.src_cpu,dst_cpu
o ipi_send_cpu.cpu
o ...

Filtering these currently requires using arithmetic comparison functions,
which can be tedious when dealing with interleaved SMT or NUMA CPU ids.

Allow these to be filtered by a user-provided cpumask, which enables e.g.:

$ trace-cmd record -e 'sched_wakeup' -f 'target_cpu & CPUS{2,4,6,8-32}'

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
NOTE: I went with an implicit cpumask conversion of the event field, as
AFAICT predicate_parse() does not support parsing the application of a
function to a field (e.g. 'CPUS(target_cpu) & CPUS{2,4,6,8-32}')
---
 kernel/trace/trace_events_filter.c | 92 ++++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index cb1863dfa280b..1e14f801685a8 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -46,15 +46,19 @@ static const char * ops[] = { OPS };
 enum filter_pred_fn {
 	FILTER_PRED_FN_NOP,
 	FILTER_PRED_FN_64,
+	FILTER_PRED_FN_64_CPUMASK,
 	FILTER_PRED_FN_S64,
 	FILTER_PRED_FN_U64,
 	FILTER_PRED_FN_32,
+	FILTER_PRED_FN_32_CPUMASK,
 	FILTER_PRED_FN_S32,
 	FILTER_PRED_FN_U32,
 	FILTER_PRED_FN_16,
+	FILTER_PRED_FN_16_CPUMASK,
 	FILTER_PRED_FN_S16,
 	FILTER_PRED_FN_U16,
 	FILTER_PRED_FN_8,
+	FILTER_PRED_FN_8_CPUMASK,
 	FILTER_PRED_FN_S8,
 	FILTER_PRED_FN_U8,
 	FILTER_PRED_FN_COMM,
@@ -643,6 +647,39 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	return ERR_PTR(ret);
 }
 
+static inline int
+do_filter_cpumask(int op, const struct cpumask *mask, const struct cpumask *cmp)
+{
+	switch (op) {
+	case OP_EQ:
+		return cpumask_equal(mask, cmp);
+	case OP_NE:
+		return !cpumask_equal(mask, cmp);
+	case OP_BAND:
+		return cpumask_intersects(mask, cmp);
+	default:
+		return 0;
+	}
+}
+
+/* Optimisation of do_filter_cpumask() for scalar fields */
+static inline int
+do_filter_scalar_cpumask(int op, unsigned int cpu, const struct cpumask *mask)
+{
+	switch (op) {
+	case OP_EQ:
+		return cpumask_test_cpu(cpu, mask) &&
+			cpumask_nth(1, mask) >= nr_cpu_ids;
+	case OP_NE:
+		return !cpumask_test_cpu(cpu, mask) ||
+			cpumask_nth(1, mask) < nr_cpu_ids;
+	case OP_BAND:
+		return cpumask_test_cpu(cpu, mask);
+	default:
+		return 0;
+	}
+}
+
 enum pred_cmp_types {
 	PRED_CMP_TYPE_NOP,
 	PRED_CMP_TYPE_LT,
@@ -686,6 +723,18 @@ static int filter_pred_##type(struct filter_pred *pred, void *event)	\
 	}								\
 }
 
+#define DEFINE_CPUMASK_COMPARISON_PRED(size)					\
+static int filter_pred_##size##_cpumask(struct filter_pred *pred, void *event)	\
+{										\
+	u##size *addr = (u##size *)(event + pred->offset);			\
+	unsigned int cpu = *addr;						\
+										\
+	if (cpu >= nr_cpu_ids)							\
+		return 0;							\
+										\
+	return do_filter_scalar_cpumask(pred->op, cpu, pred->mask);		\
+}
+
 #define DEFINE_EQUALITY_PRED(size)					\
 static int filter_pred_##size(struct filter_pred *pred, void *event)	\
 {									\
@@ -707,6 +756,11 @@ DEFINE_COMPARISON_PRED(u16);
 DEFINE_COMPARISON_PRED(s8);
 DEFINE_COMPARISON_PRED(u8);
 
+DEFINE_CPUMASK_COMPARISON_PRED(64);
+DEFINE_CPUMASK_COMPARISON_PRED(32);
+DEFINE_CPUMASK_COMPARISON_PRED(16);
+DEFINE_CPUMASK_COMPARISON_PRED(8);
+
 DEFINE_EQUALITY_PRED(64);
 DEFINE_EQUALITY_PRED(32);
 DEFINE_EQUALITY_PRED(16);
@@ -891,16 +945,7 @@ static int filter_pred_cpumask(struct filter_pred *pred, void *event)
 	const struct cpumask *mask = (event + loc);
 	const struct cpumask *cmp = pred->mask;
 
-	switch (pred->op) {
-	case OP_EQ:
-		return cpumask_equal(mask, cmp);
-	case OP_NE:
-		return !cpumask_equal(mask, cmp);
-	case OP_BAND:
-		return cpumask_intersects(mask, cmp);
-	default:
-		return 0;
-	}
+	return do_filter_cpumask(pred->op, mask, cmp);
 }
 
 /* Filter predicate for COMM. */
@@ -1351,24 +1396,32 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 	switch (pred->fn_num) {
 	case FILTER_PRED_FN_64:
 		return filter_pred_64(pred, event);
+	case FILTER_PRED_FN_64_CPUMASK:
+		return filter_pred_64_cpumask(pred, event);
 	case FILTER_PRED_FN_S64:
 		return filter_pred_s64(pred, event);
 	case FILTER_PRED_FN_U64:
 		return filter_pred_u64(pred, event);
 	case FILTER_PRED_FN_32:
 		return filter_pred_32(pred, event);
+	case FILTER_PRED_FN_32_CPUMASK:
+		return filter_pred_32_cpumask(pred, event);
 	case FILTER_PRED_FN_S32:
 		return filter_pred_s32(pred, event);
 	case FILTER_PRED_FN_U32:
 		return filter_pred_u32(pred, event);
 	case FILTER_PRED_FN_16:
 		return filter_pred_16(pred, event);
+	case FILTER_PRED_FN_16_CPUMASK:
+		return filter_pred_16_cpumask(pred, event);
 	case FILTER_PRED_FN_S16:
 		return filter_pred_s16(pred, event);
 	case FILTER_PRED_FN_U16:
 		return filter_pred_u16(pred, event);
 	case FILTER_PRED_FN_8:
 		return filter_pred_8(pred, event);
+	case FILTER_PRED_FN_8_CPUMASK:
+		return filter_pred_8_cpumask(pred, event);
 	case FILTER_PRED_FN_S8:
 		return filter_pred_s8(pred, event);
 	case FILTER_PRED_FN_U8:
@@ -1606,6 +1659,7 @@ static int parse_pred(const char *str, void *data,
 
 		switch (field->filter_type) {
 		case FILTER_CPUMASK:
+		case FILTER_OTHER:
 			break;
 		default:
 			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
@@ -1658,8 +1712,24 @@ static int parse_pred(const char *str, void *data,
 
 		/* Move along */
 		i++;
-		if (field->filter_type == FILTER_CPUMASK)
+		if (field->filter_type == FILTER_CPUMASK) {
 			pred->fn_num = FILTER_PRED_FN_CPUMASK;
+		} else {
+			switch (field->size) {
+			case 8:
+				pred->fn_num = FILTER_PRED_FN_64_CPUMASK;
+				break;
+			case 4:
+				pred->fn_num = FILTER_PRED_FN_32_CPUMASK;
+				break;
+			case 2:
+				pred->fn_num = FILTER_PRED_FN_16_CPUMASK;
+				break;
+			case 1:
+				pred->fn_num = FILTER_PRED_FN_8_CPUMASK;
+				break;
+			}
+		}
 
 	/* This is either a string, or an integer */
 	} else if (str[i] == '\'' || str[i] == '"') {
-- 
2.31.1

