Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74214794684
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 00:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjIFWqp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 18:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244494AbjIFWqp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 18:46:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02561BC5;
        Wed,  6 Sep 2023 15:46:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9422FC433C9;
        Wed,  6 Sep 2023 22:46:38 +0000 (UTC)
Date:   Wed, 6 Sep 2023 18:46:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     zhengyejian1@huawei.com, akaher@vmware.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        shuah@kernel.org, skhan@linuxfoundation.org, yeweihua4@huawei.com
Subject: Re: "[PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc"
Message-ID: <20230906184650.074dfdcf@gandalf.local.home>
In-Reply-To: <20230906145000.29291a1b@gandalf.local.home>
References: <b62e6539-7b25-c8ab-6b6c-47e723023297@huawei.com>
        <20230906142652.191866-1-naresh.kamboju@linaro.org>
        <20230906145000.29291a1b@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 6 Sep 2023 14:50:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> BTW, when you ran these, did you apply:
> 
>   https://patchwork.kernel.org/project/linux-trace-kernel/patch/20230905183332.628d7cc0@gandalf.local.home/

Can you both try the above patch and this patch?

-- Steve

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 35783a7baf15..0827037ee3b8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4973,6 +4973,33 @@ int tracing_open_generic_tr(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/*
+ * The private pointer of the inode is the trace_event_file.
+ * Update the tr ref count associated to it.
+ */
+int tracing_open_file_tr(struct inode *inode, struct file *filp)
+{
+	struct trace_event_file *file = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(file->tr);
+	if (ret)
+		return ret;
+
+	filp->private_data = inode->i_private;
+
+	return 0;
+}
+
+int tracing_release_file_tr(struct inode *inode, struct file *filp)
+{
+	struct trace_event_file *file = inode->i_private;
+
+	trace_array_put(file->tr);
+
+	return 0;
+}
+
 static int tracing_mark_open(struct inode *inode, struct file *filp)
 {
 	stream_open(inode, filp);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5669dd1f90d9..77debe53f07c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -610,6 +610,8 @@ void tracing_reset_all_online_cpus(void);
 void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
+int tracing_open_file_tr(struct inode *inode, struct file *filp);
+int tracing_release_file_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index ed367d713be0..2af92177b765 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2103,9 +2103,10 @@ static const struct file_operations ftrace_set_event_notrace_pid_fops = {
 };
 
 static const struct file_operations ftrace_enable_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_enable_read,
 	.write = event_enable_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
@@ -2122,9 +2123,10 @@ static const struct file_operations ftrace_event_id_fops = {
 };
 
 static const struct file_operations ftrace_event_filter_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_filter_read,
 	.write = event_filter_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
-- 
2.40.1

