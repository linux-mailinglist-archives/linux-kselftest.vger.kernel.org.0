Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE1E75B46B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjGTQeP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 12:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjGTQeG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 12:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9246419B3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689870783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eoYdZ3j5mn2MTw1iUVYlPJSnwNWgHj3M8L9iz2kPLwU=;
        b=HydDn72CehzrZvIyJPDBlvtdLiM6MpixhN2qMqtTinigwG/7HU4e0olqgpIn9cuSSQLoGb
        C5MmBi5fFL+l/9EY0pJ/fkQA5rt04R8VqJnFuIe/daNQRYTS1LLMjJblGUPa7xwlvT4lR0
        JpOWIcbZIvhcQu2fXLAfo6Du0t/UFCc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-xF48V0OiM2SJcrNgAEdCkA-1; Thu, 20 Jul 2023 12:32:57 -0400
X-MC-Unique: xF48V0OiM2SJcrNgAEdCkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1AF3936D28;
        Thu, 20 Jul 2023 16:32:54 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1F9740C206F;
        Thu, 20 Jul 2023 16:32:46 +0000 (UTC)
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
Subject: [RFC PATCH v2 07/20] tracing/filters: Optimise CPU vs cpumask filtering when the user mask is a single CPU
Date:   Thu, 20 Jul 2023 17:30:43 +0100
Message-Id: <20230720163056.2564824-8-vschneid@redhat.com>
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

Steven noted that when the user-provided cpumask contains a single CPU,
then the filtering function can use a scalar as input instead of a
full-fledged cpumask.

In this case we can directly re-use filter_pred_cpu(), we just need to
transform '&' into '==' before executing it.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 54d642fabb7f1..fd72dacc5d1b8 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1750,7 +1750,7 @@ static int parse_pred(const char *str, void *data,
 		 * then we can treat it as a scalar input.
 		 */
 		single = cpumask_weight(pred->mask) == 1;
-		if (single && field->filter_type != FILTER_CPU) {
+		if (single) {
 			pred->val = cpumask_first(pred->mask);
 			kfree(pred->mask);
 		}
@@ -1760,7 +1760,12 @@ static int parse_pred(const char *str, void *data,
 				FILTER_PRED_FN_CPUMASK_CPU :
 				FILTER_PRED_FN_CPUMASK;
 		} else if (field->filter_type == FILTER_CPU) {
-			pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
+			if (single) {
+				pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
+				pred->fn_num = FILTER_PRED_FN_CPU;
+			} else {
+				pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
+			}
 		} else if (single) {
 			pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
 			pred->fn_num = select_comparison_fn(pred->op, field->size, false);
-- 
2.31.1

