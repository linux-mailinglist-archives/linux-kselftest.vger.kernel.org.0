Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A0175B45B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjGTQdx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 12:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjGTQda (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 12:33:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E72D171E
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689870759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ru1xpHoly8RVJpDGIBIPQWc2v6Ebq5LepRuPaIIUDyE=;
        b=XBHVfK5P4B8SxU2qNjsgxERdRcr/YGunHigHs/+dmTqAs8u7cyYB7Y6uYNX/oR8ecMaSVa
        wXGfg1QANZZQLuJVBHz0uvry7cPixHjlrdpTyJgCeTaWqZvhOV0AaO3baPb7Hz2hJJHc+8
        hRZ4qA9ZtmcPJDhnZZHQ4F7zQ4VOnsg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-L0PDvKruOe6zKXZsgB5siQ-1; Thu, 20 Jul 2023 12:32:33 -0400
X-MC-Unique: L0PDvKruOe6zKXZsgB5siQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B209B1044590;
        Thu, 20 Jul 2023 16:32:30 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4F2E40C206F;
        Thu, 20 Jul 2023 16:32:16 +0000 (UTC)
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
Subject: [RFC PATCH v2 04/20] tracing/filters: Enable filtering the CPU common field by a cpumask
Date:   Thu, 20 Jul 2023 17:30:40 +0100
Message-Id: <20230720163056.2564824-5-vschneid@redhat.com>
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

The tracing_cpumask lets us specify which CPUs are traced in a buffer
instance, but doesn't let us do this on a per-event basis (unless one
creates an instance per event).

A previous commit added filtering scalar fields by a user-given cpumask,
make this work with the CPU common field as well.

This enables doing things like

$ trace-cmd record -e 'sched_switch' -f 'CPU & CPUS{12-52}' \
		   -e 'sched_wakeup' -f 'target_cpu & CPUS{12-52}'

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 1e14f801685a8..3009d0c61b532 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -68,6 +68,7 @@ enum filter_pred_fn {
 	FILTER_PRED_FN_PCHAR_USER,
 	FILTER_PRED_FN_PCHAR,
 	FILTER_PRED_FN_CPU,
+	FILTER_PRED_FN_CPU_CPUMASK,
 	FILTER_PRED_FN_CPUMASK,
 	FILTER_PRED_FN_FUNCTION,
 	FILTER_PRED_FN_,
@@ -937,6 +938,14 @@ static int filter_pred_cpu(struct filter_pred *pred, void *event)
 	}
 }
 
+/* Filter predicate for current CPU vs user-provided cpumask */
+static int filter_pred_cpu_cpumask(struct filter_pred *pred, void *event)
+{
+	int cpu = raw_smp_processor_id();
+
+	return do_filter_scalar_cpumask(pred->op, cpu, pred->mask);
+}
+
 /* Filter predicate for cpumask field vs user-provided cpumask */
 static int filter_pred_cpumask(struct filter_pred *pred, void *event)
 {
@@ -1440,6 +1449,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 		return filter_pred_pchar(pred, event);
 	case FILTER_PRED_FN_CPU:
 		return filter_pred_cpu(pred, event);
+	case FILTER_PRED_FN_CPU_CPUMASK:
+		return filter_pred_cpu_cpumask(pred, event);
 	case FILTER_PRED_FN_CPUMASK:
 		return filter_pred_cpumask(pred, event);
 	case FILTER_PRED_FN_FUNCTION:
@@ -1659,6 +1670,7 @@ static int parse_pred(const char *str, void *data,
 
 		switch (field->filter_type) {
 		case FILTER_CPUMASK:
+		case FILTER_CPU:
 		case FILTER_OTHER:
 			break;
 		default:
@@ -1714,6 +1726,8 @@ static int parse_pred(const char *str, void *data,
 		i++;
 		if (field->filter_type == FILTER_CPUMASK) {
 			pred->fn_num = FILTER_PRED_FN_CPUMASK;
+		} else if (field->filter_type == FILTER_CPU) {
+			pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
 		} else {
 			switch (field->size) {
 			case 8:
-- 
2.31.1

