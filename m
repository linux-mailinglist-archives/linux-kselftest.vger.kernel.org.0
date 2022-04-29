Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E545F515936
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Apr 2022 01:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381900AbiD3AAZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 20:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381899AbiD3AAY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 20:00:24 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0273E0FE
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 16:56:56 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b10-20020a170902bd4a00b0015e7ee90842so1251754plx.8
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y+Q/IXhaWsRAPmKMqULGXX6gjgm8gHDF6bR4ysCjcTo=;
        b=H/13hmb9fVxI5t1ZecWpaw4gTqW7NjrFKShggGtAwvAf8hZmL82HID/5Map25vz02f
         ktp6VKa70yyumJRkYLfJaRo9vDQ6YyB+n7lpORTxXymQSBN4ANL7B8UHNPnPjY1M2u6P
         CbG0uV8ARLnKoGfgidygLgxZTAttlvlhnjHcGLGaaRR2WelA8P4TW0Xg/Da6c1HMDkXd
         D38+qOA1Q8G3Fj+ZJgfQNcXgRB5WK8npWF7gC3eLrTqMVQi+AekZP9J1sM/iatsIvodG
         HakktZ7TjQk2UsmNZHuaLxjG8VZ6nU+v8cOBjoKEvrZoUvK3JdEmts6GnFRPJPQNymZX
         v+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y+Q/IXhaWsRAPmKMqULGXX6gjgm8gHDF6bR4ysCjcTo=;
        b=FTF3I+oGkw01tkJNrz1ttOjIVK7UndfbOypFRaKJyLswfYJXevh64U2pxySfXZB2pL
         ZphXr6K1chJoT8uHfL3T3g8NER6sp+hSV9bKakiB0WQoDFQv/ay4qJQPY3kUp3AbsItv
         KQUB8h4dO9itcMPvMxpOecplt2i7yOIrlnBYCh9lGWS62wQwcBRntfw3IgDfOj0ZqAZp
         ADdIFfZjosccdW6j25Cw+Z6TE/LmyGVxl+9bKpy1gQl4gctIxQGfScL2kVWcYmD1FlQC
         LhN6hQY5CdvoxSU+Aed0MK6LdnQQDM8wSTY58uWe8Hh2hnNt4Y+9uiDk2QHgD+Ps84vc
         XnzA==
X-Gm-Message-State: AOAM530GkKDFZBG8iNpOAk9WNyR3a8PiHwg4lipdwaRi9b2AWQXyPXmI
        iMDc99nCAdJX2DoDGMSk2GltuX627NvbzA==
X-Google-Smtp-Source: ABdhPJx1Wjp0vuZg+qCJHHMrbauEyHFfDDCreh69orOH9EOfyhL5teusuGJLQDzJe0MC0WXjrog7rMPbfFQzzw==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:1494:b0:50d:4b12:8dfa with SMTP
 id v20-20020a056a00149400b0050d4b128dfamr1188736pfu.43.1651276615642; Fri, 29
 Apr 2022 16:56:55 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:56:41 +0000
In-Reply-To: <20220429235644.697372-1-cmllamas@google.com>
Message-Id: <20220429235644.697372-3-cmllamas@google.com>
Mime-Version: 1.0
References: <20220429235644.697372-1-cmllamas@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 2/5] binder: add BINDER_GET_EXTENDED_ERROR ioctl
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Li Li <dualli@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Provide a userspace mechanism to pull precise error information upon
failed operations. Extending the current error codes returned by the
interfaces allows userspace to better determine the course of action.
This could be for instance, retrying a failed transaction at a later
point and thus offloading the error handling from the driver.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c            | 60 +++++++++++++++++++++++++++++
 drivers/android/binder_internal.h   |  3 ++
 include/uapi/linux/android/binder.h | 16 ++++++++
 3 files changed, 79 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f0885baa53a1..b9df0c8a68d3 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -147,6 +147,13 @@ module_param_call(stop_on_user_error, binder_set_stop_on_user_error,
 			binder_stop_on_user_error = 2; \
 	} while (0)
 
+#define binder_set_extended_error(ee, _id, _command, _param) \
+	do { \
+		(ee)->id = _id; \
+		(ee)->command = _command; \
+		(ee)->param = _param; \
+	} while (0)
+
 #define to_flat_binder_object(hdr) \
 	container_of(hdr, struct flat_binder_object, hdr)
 
@@ -2697,6 +2704,24 @@ static struct binder_node *binder_get_node_refs_for_txn(
 	return target_node;
 }
 
+static void binder_set_txn_from_error(struct binder_transaction *t, int id,
+				      uint32_t command, int32_t param)
+{
+	struct binder_thread *from = binder_get_txn_from_and_acq_inner(t);
+
+	if (!from) {
+		/* annotation for sparse */
+		__release(&from->proc->inner_lock);
+		return;
+	}
+
+	/* don't override existing errors */
+	if (from->ee.command == BR_OK)
+		binder_set_extended_error(&from->ee, id, command, param);
+	binder_inner_proc_unlock(from->proc);
+	binder_thread_dec_tmpref(from);
+}
+
 static void binder_transaction(struct binder_proc *proc,
 			       struct binder_thread *thread,
 			       struct binder_transaction_data *tr, int reply,
@@ -2742,6 +2767,10 @@ static void binder_transaction(struct binder_proc *proc,
 	e->offsets_size = tr->offsets_size;
 	strscpy(e->context_name, proc->context->name, BINDERFS_MAX_NAME);
 
+	binder_inner_proc_lock(proc);
+	binder_set_extended_error(&thread->ee, t_debug_id, BR_OK, 0);
+	binder_inner_proc_unlock(proc);
+
 	if (reply) {
 		binder_inner_proc_lock(proc);
 		in_reply_to = thread->transaction_stack;
@@ -3487,10 +3516,16 @@ static void binder_transaction(struct binder_proc *proc,
 
 	BUG_ON(thread->return_error.cmd != BR_OK);
 	if (in_reply_to) {
+		binder_set_txn_from_error(in_reply_to, t_debug_id,
+				return_error, return_error_param);
 		thread->return_error.cmd = BR_TRANSACTION_COMPLETE;
 		binder_enqueue_thread_work(thread, &thread->return_error.work);
 		binder_send_failed_reply(in_reply_to, return_error);
 	} else {
+		binder_inner_proc_lock(proc);
+		binder_set_extended_error(&thread->ee, t_debug_id,
+				return_error, return_error_param);
+		binder_inner_proc_unlock(proc);
 		thread->return_error.cmd = return_error;
 		binder_enqueue_thread_work(thread, &thread->return_error.work);
 	}
@@ -4628,6 +4663,7 @@ static struct binder_thread *binder_get_thread_ilocked(
 	thread->return_error.cmd = BR_OK;
 	thread->reply_error.work.type = BINDER_WORK_RETURN_ERROR;
 	thread->reply_error.cmd = BR_OK;
+	thread->ee.command = BR_OK;
 	INIT_LIST_HEAD(&new_thread->waiting_thread_node);
 	return thread;
 }
@@ -5066,6 +5102,25 @@ static int binder_ioctl_get_freezer_info(
 	return 0;
 }
 
+static int binder_ioctl_get_extended_error(struct binder_thread *thread,
+					   void __user *ubuf)
+{
+	struct binder_extended_error *ee = &thread->ee;
+
+	binder_inner_proc_lock(thread->proc);
+	if (copy_to_user(ubuf, ee, sizeof(*ee))) {
+		binder_inner_proc_unlock(thread->proc);
+		return -EFAULT;
+	}
+
+	ee->id = 0;
+	ee->command = BR_OK;
+	ee->param = 0;
+	binder_inner_proc_unlock(thread->proc);
+
+	return 0;
+}
+
 static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	int ret;
@@ -5274,6 +5329,11 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		binder_inner_proc_unlock(proc);
 		break;
 	}
+	case BINDER_GET_EXTENDED_ERROR:
+		ret = binder_ioctl_get_extended_error(thread, ubuf);
+		if (ret < 0)
+			goto err;
+		break;
 	default:
 		ret = -EINVAL;
 		goto err;
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index d6b6b8cb7346..7c366a854125 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -480,6 +480,8 @@ struct binder_proc {
  *                        (only accessed by this thread)
  * @reply_error:          transaction errors reported by target thread
  *                        (protected by @proc->inner_lock)
+ * @ee:                   extended error information from this thread
+ *                        (protected by @proc->inner_lock)
  * @wait:                 wait queue for thread work
  * @stats:                per-thread statistics
  *                        (atomics, no lock needed)
@@ -504,6 +506,7 @@ struct binder_thread {
 	bool process_todo;
 	struct binder_error return_error;
 	struct binder_error reply_error;
+	struct binder_extended_error ee;
 	wait_queue_head_t wait;
 	struct binder_stats stats;
 	atomic_t tmp_ref;
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index 11157fae8a8e..e6ee8cae303b 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -236,6 +236,21 @@ struct binder_frozen_status_info {
 	__u32            async_recv;
 };
 
+/* struct binder_extened_error - extended error information
+ * @id:		identifier for the failed operation
+ * @command:	command as defined by binder_driver_return_protocol
+ * @param:	parameter holding a negative errno value
+ *
+ * Used with BINDER_GET_EXTENDED_ERROR. This extends the error information
+ * returned by the driver upon a failed operation. Userspace can pull this
+ * data to properly handle specific error scenarios.
+ */
+struct binder_extended_error {
+	__u32	id;
+	__u32	command;
+	__s32	param;
+};
+
 #define BINDER_WRITE_READ		_IOWR('b', 1, struct binder_write_read)
 #define BINDER_SET_IDLE_TIMEOUT		_IOW('b', 3, __s64)
 #define BINDER_SET_MAX_THREADS		_IOW('b', 5, __u32)
@@ -249,6 +264,7 @@ struct binder_frozen_status_info {
 #define BINDER_FREEZE			_IOW('b', 14, struct binder_freeze_info)
 #define BINDER_GET_FROZEN_INFO		_IOWR('b', 15, struct binder_frozen_status_info)
 #define BINDER_ENABLE_ONEWAY_SPAM_DETECTION	_IOW('b', 16, __u32)
+#define BINDER_GET_EXTENDED_ERROR	_IOWR('b', 17, struct binder_extended_error)
 
 /*
  * NOTE: Two special error codes you should check for when calling
-- 
2.36.0.464.gb9c8b46e94-goog

