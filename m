Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AEB7DD12E
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 17:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344890AbjJaQHJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 12:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344881AbjJaQHJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 12:07:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17838DA;
        Tue, 31 Oct 2023 09:07:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5210CC433C7;
        Tue, 31 Oct 2023 16:07:04 +0000 (UTC)
Date:   Tue, 31 Oct 2023 12:07:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
        Mark Brown <broonie@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: selftests: user_events: ftrace_test - RIP:
 0010:tracing_update_buffers (kernel/trace/trace.c:6470)
Message-ID: <20231031120702.70dbb21b@gandalf.local.home>
In-Reply-To: <20231031104551.6e0f3620@gandalf.local.home>
References: <CA+G9fYuDP3hVQ3t7FfrBAjd_WFVSurMgCepTxunSJf=MTe=6aA@mail.gmail.com>
        <20231027192011.GA436-beaub@linux.microsoft.com>
        <20231027183640.2529ab68@gandalf.local.home>
        <20231027223344.3854ac1f@rorschach.local.home>
        <20231030163102.GA1853-beaub@linux.microsoft.com>
        <20231030124223.4e4ddeb8@gandalf.local.home>
        <20231030173151.0631169b@gandalf.local.home>
        <20231031002707.GA107-beaub@linux.microsoft.com>
        <20231031000031.1e705592@gandalf.local.home>
        <20231031104551.6e0f3620@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 31 Oct 2023 10:45:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -1404,7 +1424,7 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
>  		ret = -ENODEV;
>  		mutex_lock(&event_mutex);
>  		file = event_file_data(filp);
> -		if (likely(file)) {
> +		if (likely(file && !(file->flags & EVENT_FILE_FL_FREED))) {
>  			printk("update file = %px\n", file);
>  			printk("update tr = %px\n", file->tr);
>  			ret = tracing_update_buffers(file->tr);

Well, this won't apply because I still had debugging in it when I added
these changes.

Here's a better version:

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 12207dc6722d..696f8dc4aa53 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -492,6 +492,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_COND_BIT,
 	EVENT_FILE_FL_PID_FILTER_BIT,
 	EVENT_FILE_FL_WAS_ENABLED_BIT,
+	EVENT_FILE_FL_FREED_BIT,
 };
 
 extern struct trace_event_file *trace_get_event_file(const char *instance,
@@ -630,6 +631,7 @@ extern int __kprobe_event_add_fields(struct dynevent_cmd *cmd, ...);
  *  TRIGGER_COND  - When set, one or more triggers has an associated filter
  *  PID_FILTER    - When set, the event is filtered based on pid
  *  WAS_ENABLED   - Set when enabled to know to clear trace on module removal
+ *  FREED         - File descriptor is freed, all fields should be considered invalid
  */
 enum {
 	EVENT_FILE_FL_ENABLED		= (1 << EVENT_FILE_FL_ENABLED_BIT),
@@ -643,6 +645,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_COND	= (1 << EVENT_FILE_FL_TRIGGER_COND_BIT),
 	EVENT_FILE_FL_PID_FILTER	= (1 << EVENT_FILE_FL_PID_FILTER_BIT),
 	EVENT_FILE_FL_WAS_ENABLED	= (1 << EVENT_FILE_FL_WAS_ENABLED_BIT),
+	EVENT_FILE_FL_FREED		= (1 << EVENT_FILE_FL_FREED_BIT),
 };
 
 struct trace_event_file {
@@ -671,6 +674,7 @@ struct trace_event_file {
 	 * caching and such. Which is mostly OK ;-)
 	 */
 	unsigned long		flags;
+	atomic_t		ref;	/* ref count for opened files */
 	atomic_t		sm_ref;	/* soft-mode reference counter */
 	atomic_t		tm_ref;	/* trigger-mode reference counter */
 };
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2539cfc20a97..9aebf904ff97 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4978,6 +4978,20 @@ int tracing_open_file_tr(struct inode *inode, struct file *filp)
 	if (ret)
 		return ret;
 
+	mutex_lock(&event_mutex);
+
+	/* Fail if the file is marked for removal */
+	if (file->flags & EVENT_FILE_FL_FREED) {
+		trace_array_put(file->tr);
+		ret = -ENODEV;
+	} else {
+		event_file_get(file);
+	}
+
+	mutex_unlock(&event_mutex);
+	if (ret)
+		return ret;
+
 	filp->private_data = inode->i_private;
 
 	return 0;
@@ -4988,6 +5002,7 @@ int tracing_release_file_tr(struct inode *inode, struct file *filp)
 	struct trace_event_file *file = inode->i_private;
 
 	trace_array_put(file->tr);
+	event_file_put(file);
 
 	return 0;
 }
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0e1405abf4f7..b7f4ea25a194 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1669,6 +1669,9 @@ extern void event_trigger_unregister(struct event_command *cmd_ops,
 				     char *glob,
 				     struct event_trigger_data *trigger_data);
 
+extern void event_file_get(struct trace_event_file *file);
+extern void event_file_put(struct trace_event_file *file);
+
 /**
  * struct event_trigger_ops - callbacks for trace event triggers
  *
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f9e3e24d8796..f29e815ca5b2 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -990,13 +990,35 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 	}
 }
 
+void event_file_get(struct trace_event_file *file)
+{
+	atomic_inc(&file->ref);
+}
+
+void event_file_put(struct trace_event_file *file)
+{
+	if (WARN_ON_ONCE(!atomic_read(&file->ref))) {
+		if (file->flags & EVENT_FILE_FL_FREED)
+			kmem_cache_free(file_cachep, file);
+		return;
+	}
+
+	if (atomic_dec_and_test(&file->ref)) {
+		/* Count should only go to zero when it is freed */
+		if (WARN_ON_ONCE(!(file->flags & EVENT_FILE_FL_FREED)))
+			return;
+		kmem_cache_free(file_cachep, file);
+	}
+}
+
 static void remove_event_file_dir(struct trace_event_file *file)
 {
 	eventfs_remove_dir(file->ei);
 	list_del(&file->list);
 	remove_subsystem(file->system);
 	free_event_filter(file->filter);
-	kmem_cache_free(file_cachep, file);
+	file->flags |= EVENT_FILE_FL_FREED;
+	event_file_put(file);
 }
 
 /*
@@ -1369,7 +1391,7 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 		flags = file->flags;
 	mutex_unlock(&event_mutex);
 
-	if (!file)
+	if (!file || flags & EVENT_FILE_FL_FREED)
 		return -ENODEV;
 
 	if (flags & EVENT_FILE_FL_ENABLED &&
@@ -1403,7 +1425,7 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		ret = -ENODEV;
 		mutex_lock(&event_mutex);
 		file = event_file_data(filp);
-		if (likely(file)) {
+		if (likely(file && !(file->flags & EVENT_FILE_FL_FREED))) {
 			ret = tracing_update_buffers(file->tr);
 			if (ret < 0) {
 				mutex_unlock(&event_mutex);
@@ -1683,7 +1705,7 @@ event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
 
 	mutex_lock(&event_mutex);
 	file = event_file_data(filp);
-	if (file)
+	if (file && !(file->flags & EVENT_FILE_FL_FREED))
 		print_event_filter(file, s);
 	mutex_unlock(&event_mutex);
 
@@ -2902,6 +2924,7 @@ trace_create_new_event(struct trace_event_call *call,
 	atomic_set(&file->tm_ref, 0);
 	INIT_LIST_HEAD(&file->triggers);
 	list_add(&file->list, &tr->events);
+	event_file_get(file);
 
 	return file;
 }
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 33264e510d16..0c611b281a5b 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2349,6 +2349,9 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 	struct event_filter *filter = NULL;
 	int err;
 
+	if (file->flags & EVENT_FILE_FL_FREED)
+		return -ENODEV;
+
 	if (!strcmp(strstrip(filter_string), "0")) {
 		filter_disable(file);
 		filter = event_filter(file);
