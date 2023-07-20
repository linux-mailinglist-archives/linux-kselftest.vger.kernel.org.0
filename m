Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B249675B44A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 18:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGTQdY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 12:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGTQdX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 12:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA53619A1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689870717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FgooZspr4TQIjuc/tHX/XT4D8n/wo2nwvhkclMi4+iU=;
        b=jPPiAZqqYxOAXry4nBWbwLOw7CAhzUdoZVDhrintt9G8yRHxlz+JgS/dE4wKnktMJeELJ7
        yzdmRyQgc6qMr5aAvYbgqbMtrSjxpk9StOxXc1bAME32XGqrGUgzdglI0r0Fp6d4au7/Y1
        pFvdcLslC0JxsH0vXaZwQ/fo0/1/MKE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-fsF-jKQQP5yEcGDp2gQ-Yw-1; Thu, 20 Jul 2023 12:31:53 -0400
X-MC-Unique: fsF-jKQQP5yEcGDp2gQ-Yw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 986C22812951;
        Thu, 20 Jul 2023 16:31:49 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C05640C206F;
        Thu, 20 Jul 2023 16:31:40 +0000 (UTC)
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
Subject: [RFC PATCH v2 01/20] tracing/filters: Dynamically allocate filter_pred.regex
Date:   Thu, 20 Jul 2023 17:30:37 +0100
Message-Id: <20230720163056.2564824-2-vschneid@redhat.com>
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

Every predicate allocation includes a MAX_FILTER_STR_VAL (256) char array
in the regex field, even if the predicate function does not use the field.

A later commit will introduce a dynamically allocated cpumask to struct
filter_pred, which will require a dedicated freeing function. Bite the
bullet and make filter_pred.regex dynamically allocated.

While at it, reorder the fields of filter_pred to fill in the byte
holes. The struct now fits on a single cacheline.

No change in behaviour intended.

The kfree()'s were patched via Coccinelle:
  @@
  struct filter_pred *pred;
  @@

  -kfree(pred);
  +free_predicate(pred);

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 64 ++++++++++++++++++------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 1dad64267878c..91fc9990107f1 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -70,15 +70,15 @@ enum filter_pred_fn {
 };
 
 struct filter_pred {
-	enum filter_pred_fn 	fn_num;
-	u64 			val;
-	u64 			val2;
-	struct regex		regex;
+	struct regex		*regex;
 	unsigned short		*ops;
 	struct ftrace_event_field *field;
-	int 			offset;
+	u64			val;
+	u64			val2;
+	enum filter_pred_fn	fn_num;
+	int			offset;
 	int			not;
-	int 			op;
+	int			op;
 };
 
 /*
@@ -186,6 +186,14 @@ enum {
 	PROCESS_OR	= 4,
 };
 
+static void free_predicate(struct filter_pred *pred)
+{
+	if (pred) {
+		kfree(pred->regex);
+		kfree(pred);
+	}
+}
+
 /*
  * Without going into a formal proof, this explains the method that is used in
  * parsing the logical expressions.
@@ -623,7 +631,7 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	kfree(inverts);
 	if (prog_stack) {
 		for (i = 0; prog_stack[i].pred; i++)
-			kfree(prog_stack[i].pred);
+			free_predicate(prog_stack[i].pred);
 		kfree(prog_stack);
 	}
 	return ERR_PTR(ret);
@@ -750,7 +758,7 @@ static int filter_pred_string(struct filter_pred *pred, void *event)
 	char *addr = (char *)(event + pred->offset);
 	int cmp, match;
 
-	cmp = pred->regex.match(addr, &pred->regex, pred->regex.field_len);
+	cmp = pred->regex->match(addr, pred->regex, pred->regex->field_len);
 
 	match = cmp ^ pred->not;
 
@@ -763,7 +771,7 @@ static __always_inline int filter_pchar(struct filter_pred *pred, char *str)
 	int len;
 
 	len = strlen(str) + 1;	/* including tailing '\0' */
-	cmp = pred->regex.match(str, &pred->regex, len);
+	cmp = pred->regex->match(str, pred->regex, len);
 
 	match = cmp ^ pred->not;
 
@@ -813,7 +821,7 @@ static int filter_pred_strloc(struct filter_pred *pred, void *event)
 	char *addr = (char *)(event + str_loc);
 	int cmp, match;
 
-	cmp = pred->regex.match(addr, &pred->regex, str_len);
+	cmp = pred->regex->match(addr, pred->regex, str_len);
 
 	match = cmp ^ pred->not;
 
@@ -836,7 +844,7 @@ static int filter_pred_strrelloc(struct filter_pred *pred, void *event)
 	char *addr = (char *)(&item[1]) + str_loc;
 	int cmp, match;
 
-	cmp = pred->regex.match(addr, &pred->regex, str_len);
+	cmp = pred->regex->match(addr, pred->regex, str_len);
 
 	match = cmp ^ pred->not;
 
@@ -874,7 +882,7 @@ static int filter_pred_comm(struct filter_pred *pred, void *event)
 {
 	int cmp;
 
-	cmp = pred->regex.match(current->comm, &pred->regex,
+	cmp = pred->regex->match(current->comm, pred->regex,
 				TASK_COMM_LEN);
 	return cmp ^ pred->not;
 }
@@ -1004,7 +1012,7 @@ enum regex_type filter_parse_regex(char *buff, int len, char **search, int *not)
 
 static void filter_build_regex(struct filter_pred *pred)
 {
-	struct regex *r = &pred->regex;
+	struct regex *r = pred->regex;
 	char *search;
 	enum regex_type type = MATCH_FULL;
 
@@ -1169,7 +1177,7 @@ static void free_prog(struct event_filter *filter)
 		return;
 
 	for (i = 0; prog[i].pred; i++)
-		kfree(prog[i].pred);
+		free_predicate(prog[i].pred);
 	kfree(prog);
 }
 
@@ -1553,9 +1561,12 @@ static int parse_pred(const char *str, void *data,
 			goto err_free;
 		}
 
-		pred->regex.len = len;
-		strncpy(pred->regex.pattern, str + s, len);
-		pred->regex.pattern[len] = 0;
+		pred->regex = kzalloc(sizeof(*pred->regex), GFP_KERNEL);
+		if (!pred->regex)
+			goto err_mem;
+		pred->regex->len = len;
+		strncpy(pred->regex->pattern, str + s, len);
+		pred->regex->pattern[len] = 0;
 
 	/* This is either a string, or an integer */
 	} else if (str[i] == '\'' || str[i] == '"') {
@@ -1597,9 +1608,12 @@ static int parse_pred(const char *str, void *data,
 			goto err_free;
 		}
 
-		pred->regex.len = len;
-		strncpy(pred->regex.pattern, str + s, len);
-		pred->regex.pattern[len] = 0;
+		pred->regex = kzalloc(sizeof(*pred->regex), GFP_KERNEL);
+		if (!pred->regex)
+			goto err_mem;
+		pred->regex->len = len;
+		strncpy(pred->regex->pattern, str + s, len);
+		pred->regex->pattern[len] = 0;
 
 		filter_build_regex(pred);
 
@@ -1608,7 +1622,7 @@ static int parse_pred(const char *str, void *data,
 
 		} else if (field->filter_type == FILTER_STATIC_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRING;
-			pred->regex.field_len = field->size;
+			pred->regex->field_len = field->size;
 
 		} else if (field->filter_type == FILTER_DYN_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRLOC;
@@ -1691,10 +1705,10 @@ static int parse_pred(const char *str, void *data,
 	return i;
 
 err_free:
-	kfree(pred);
+	free_predicate(pred);
 	return -EINVAL;
 err_mem:
-	kfree(pred);
+	free_predicate(pred);
 	return -ENOMEM;
 }
 
@@ -2287,8 +2301,8 @@ static int ftrace_function_set_filter_pred(struct filter_pred *pred,
 		return ret;
 
 	return __ftrace_function_set_filter(pred->op == OP_EQ,
-					    pred->regex.pattern,
-					    pred->regex.len,
+					    pred->regex->pattern,
+					    pred->regex->len,
 					    data);
 }
 
-- 
2.31.1

