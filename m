Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68671770D8D
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 05:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjHEDi6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 23:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjHEDi4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 23:38:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1F24ED8;
        Fri,  4 Aug 2023 20:38:54 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHpDH703GzVk4V;
        Sat,  5 Aug 2023 11:37:03 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 5 Aug 2023 11:38:52 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <vnagarnaik@google.com>, <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v2 1/2] tracing: Fix cpu buffers unavailable due to 'record_disabled' messed
Date:   Sat, 5 Aug 2023 11:38:15 +0800
Message-ID: <20230805033816.3284594-2-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230805033816.3284594-1-zhengyejian1@huawei.com>
References: <20230805033816.3284594-1-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Trace ring buffer can no longer record anything after executing
following commands at the shell prompt:

  # cd /sys/kernel/tracing
  # cat tracing_cpumask
  fff
  # echo 0 > tracing_cpumask
  # echo 1 > snapshot
  # echo fff > tracing_cpumask
  # echo 1 > tracing_on
  # echo "hello world" > trace_marker
  -bash: echo: write error: Bad file descriptor

The root cause is that:
  1. After `echo 0 > tracing_cpumask`, 'record_disabled' of cpu buffers
     in 'tr->array_buffer.buffer' became 1 (see tracing_set_cpumask());
  2. After `echo 1 > snapshot`, 'tr->array_buffer.buffer' is swapped
     with 'tr->max_buffer.buffer', then the 'record_disabled' became 0
     (see update_max_tr());
  3. After `echo fff > tracing_cpumask`, the 'record_disabled' become -1;
Then array_buffer and max_buffer are both unavailable due to value of
'record_disabled' is not 0.

To fix it, enable or disable both array_buffer and max_buffer at the same
time in tracing_set_cpumask().

Fixes: 71babb2705e2 ("tracing: change CPU ring buffer state from tracing_cpumask")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8870078ef58..b0e8eb6ea8ac 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5277,11 +5277,17 @@ int tracing_set_cpumask(struct trace_array *tr,
 				!cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			atomic_inc(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
 			ring_buffer_record_disable_cpu(tr->array_buffer.buffer, cpu);
+#ifdef CONFIG_TRACER_MAX_TRACE
+			ring_buffer_record_disable_cpu(tr->max_buffer.buffer, cpu);
+#endif
 		}
 		if (!cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
 				cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			atomic_dec(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
 			ring_buffer_record_enable_cpu(tr->array_buffer.buffer, cpu);
+#ifdef CONFIG_TRACER_MAX_TRACE
+			ring_buffer_record_enable_cpu(tr->max_buffer.buffer, cpu);
+#endif
 		}
 	}
 	arch_spin_unlock(&tr->max_lock);
-- 
2.25.1

