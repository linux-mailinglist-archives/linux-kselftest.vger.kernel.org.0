Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C95C515939
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Apr 2022 01:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381912AbiD3AA0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 20:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381905AbiD3AAY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 20:00:24 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12B53ED2C
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 16:57:01 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id a24-20020a17090a8c1800b001d98eff7882so4620782pjo.8
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 16:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AO68uGU9cD6By78uqlUxDf+zWnjVaF+K9cH18r17tUo=;
        b=B7o7bsYL5gMDJ2VeneBvsWGodAd55b8taoMtQXFxhSvJJmNWfGghs04wH7wnTeDCL/
         iUstM8trkb6Qx2m8s/PQrcno5PKfBDyAOp5VGjDIbWPRN0XRhskuxP4rWQDza2pUv5G+
         Y5FL5NDk7aDoIYeEdBjUhKDafQnnO2Fo3jGEiDT8Sn5UW1K5G3v/eVGXqC9yz7+spDc1
         xa4inZkqJz/dYIMBcrTO60h0zKY9SeBitGyA+Xnbg4l4SrOHH9T/zKcDkNgarteJOw3M
         lgHlURSlaDF7CcWLzBtvRLLT7tvSFfHvocuYKinsHSrvQcNTsjBT7JNsQgTr3yuFuNoN
         oXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AO68uGU9cD6By78uqlUxDf+zWnjVaF+K9cH18r17tUo=;
        b=YfsiNspr5MyY6Vx60QLqzXNOoc9ba1a5o2W8l1XqzoJK5OFBOUqdamHaR/vEna3Mwt
         wE+wnPRt6z0rKpizy3TC5vMiQNMTeYAbxGffqUAuPuQ2/aieQfi0fLpz6kyp8QcGX/VZ
         fA0gcQpa0HnvL251o/aQAOxCuF3OgW9Pz1Uw4ExtHdXYyxPitQb5KLeHL4PqvQnkLMv3
         1U3F/elnrDZIA8gGVxy91dssfows9pYc3kRbG+ujxHL61zx6C4BzwOaSacBMbpQ3Ms8C
         GwshEavHb0GeHr0wqID5bLO6YqadvmJM7DSMEbkjCVLhGBc6T8WlW2gz0gJfEdz5Bt+E
         Kp5w==
X-Gm-Message-State: AOAM532rz7CV79LiDXGqo/Lf3xYoeaCK7knVekjnalokmKM5EQMVWOnI
        z96LZ/bAC2HqmsQHPRR3eiO3NbfBL9PsSg==
X-Google-Smtp-Source: ABdhPJxXCFRcDmlOq0B8N9UugLqfcMlhQJ/k4+4EOJUCpC6HEFYVqZxsfJ1ZElX/uNCoinjKAgrAXCDUbLBIsg==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a17:90a:730c:b0:1da:4630:518e with SMTP
 id m12-20020a17090a730c00b001da4630518emr1589437pjk.239.1651276620865; Fri,
 29 Apr 2022 16:57:00 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:56:44 +0000
In-Reply-To: <20220429235644.697372-1-cmllamas@google.com>
Message-Id: <20220429235644.697372-6-cmllamas@google.com>
Mime-Version: 1.0
References: <20220429235644.697372-1-cmllamas@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 5/5] binder: additional transaction error logs
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Log readable and specific error messages whenever a transaction failure
happens. This will ensure better context is given to regular users about
these unique error cases, without having to decode a cryptic log.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 48 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bfb21e258427..d7c5e2dde270 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -147,6 +147,9 @@ static __printf(2, 3) void binder_debug(int mask, const char *format, ...)
 	}
 }
 
+#define binder_txn_error(x...) \
+	binder_debug(BINDER_DEBUG_FAILED_TRANSACTION, x)
+
 static __printf(1, 2) void binder_user_error(const char *format, ...)
 {
 	struct va_format vaf;
@@ -2823,6 +2826,8 @@ static void binder_transaction(struct binder_proc *proc,
 		if (target_thread == NULL) {
 			/* annotation for sparse */
 			__release(&target_thread->proc->inner_lock);
+			binder_txn_error("%d:%d reply target not found\n",
+				thread->pid, proc->pid);
 			return_error = BR_DEAD_REPLY;
 			return_error_line = __LINE__;
 			goto err_dead_binder;
@@ -2888,6 +2893,8 @@ static void binder_transaction(struct binder_proc *proc,
 			}
 		}
 		if (!target_node) {
+			binder_txn_error("%d:%d cannot find target node\n",
+				thread->pid, proc->pid);
 			/*
 			 * return_error is set above
 			 */
@@ -2897,6 +2904,8 @@ static void binder_transaction(struct binder_proc *proc,
 		}
 		e->to_node = target_node->debug_id;
 		if (WARN_ON(proc == target_proc)) {
+			binder_txn_error("%d:%d self transactions not allowed\n",
+				thread->pid, proc->pid);
 			return_error = BR_FAILED_REPLY;
 			return_error_param = -EINVAL;
 			return_error_line = __LINE__;
@@ -2904,6 +2913,8 @@ static void binder_transaction(struct binder_proc *proc,
 		}
 		if (security_binder_transaction(proc->cred,
 						target_proc->cred) < 0) {
+			binder_txn_error("%d:%d transaction credentials failed\n",
+				thread->pid, proc->pid);
 			return_error = BR_FAILED_REPLY;
 			return_error_param = -EPERM;
 			return_error_line = __LINE__;
@@ -2975,6 +2986,8 @@ static void binder_transaction(struct binder_proc *proc,
 	/* TODO: reuse incoming transaction for reply */
 	t = kzalloc(sizeof(*t), GFP_KERNEL);
 	if (t == NULL) {
+		binder_txn_error("%d:%d cannot allocate transaction\n",
+			thread->pid, proc->pid);
 		return_error = BR_FAILED_REPLY;
 		return_error_param = -ENOMEM;
 		return_error_line = __LINE__;
@@ -2986,6 +2999,8 @@ static void binder_transaction(struct binder_proc *proc,
 
 	tcomplete = kzalloc(sizeof(*tcomplete), GFP_KERNEL);
 	if (tcomplete == NULL) {
+		binder_txn_error("%d:%d cannot allocate work for transaction\n",
+			thread->pid, proc->pid);
 		return_error = BR_FAILED_REPLY;
 		return_error_param = -ENOMEM;
 		return_error_line = __LINE__;
@@ -3032,6 +3047,8 @@ static void binder_transaction(struct binder_proc *proc,
 		security_cred_getsecid(proc->cred, &secid);
 		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
 		if (ret) {
+			binder_txn_error("%d:%d failed to get security context\n",
+				thread->pid, proc->pid);
 			return_error = BR_FAILED_REPLY;
 			return_error_param = ret;
 			return_error_line = __LINE__;
@@ -3040,7 +3057,8 @@ static void binder_transaction(struct binder_proc *proc,
 		added_size = ALIGN(secctx_sz, sizeof(u64));
 		extra_buffers_size += added_size;
 		if (extra_buffers_size < added_size) {
-			/* integer overflow of extra_buffers_size */
+			binder_txn_error("%d:%d integer overflow of extra_buffers_size\n",
+				thread->pid, proc->pid);
 			return_error = BR_FAILED_REPLY;
 			return_error_param = -EINVAL;
 			return_error_line = __LINE__;
@@ -3054,9 +3072,15 @@ static void binder_transaction(struct binder_proc *proc,
 		tr->offsets_size, extra_buffers_size,
 		!reply && (t->flags & TF_ONE_WAY), current->tgid);
 	if (IS_ERR(t->buffer)) {
-		/*
-		 * -ESRCH indicates VMA cleared. The target is dying.
-		 */
+		char *s;
+
+		ret = PTR_ERR(t->buffer);
+		s = (ret == -ESRCH) ? ": vma cleared, target dead or dying"
+			: (ret == -ENOSPC) ? ": no space left"
+			: (ret == -ENOMEM) ? ": memory allocation failed"
+			: "";
+		binder_txn_error("cannot allocate buffer%s", s);
+
 		return_error_param = PTR_ERR(t->buffer);
 		return_error = return_error_param == -ESRCH ?
 			BR_DEAD_REPLY : BR_FAILED_REPLY;
@@ -3139,6 +3163,8 @@ static void binder_transaction(struct binder_proc *proc,
 						  t->buffer,
 						  buffer_offset,
 						  sizeof(object_offset))) {
+			binder_txn_error("%d:%d copy offset from buffer failed\n",
+				thread->pid, proc->pid);
 			return_error = BR_FAILED_REPLY;
 			return_error_param = -EINVAL;
 			return_error_line = __LINE__;
@@ -3197,6 +3223,8 @@ static void binder_transaction(struct binder_proc *proc,
 							t->buffer,
 							object_offset,
 							fp, sizeof(*fp))) {
+				binder_txn_error("%d:%d translate binder failed\n",
+					thread->pid, proc->pid);
 				return_error = BR_FAILED_REPLY;
 				return_error_param = ret;
 				return_error_line = __LINE__;
@@ -3214,6 +3242,8 @@ static void binder_transaction(struct binder_proc *proc,
 							t->buffer,
 							object_offset,
 							fp, sizeof(*fp))) {
+				binder_txn_error("%d:%d translate handle failed\n",
+					thread->pid, proc->pid);
 				return_error = BR_FAILED_REPLY;
 				return_error_param = ret;
 				return_error_line = __LINE__;
@@ -3234,6 +3264,8 @@ static void binder_transaction(struct binder_proc *proc,
 							t->buffer,
 							object_offset,
 							fp, sizeof(*fp))) {
+				binder_txn_error("%d:%d translate fd failed\n",
+					thread->pid, proc->pid);
 				return_error = BR_FAILED_REPLY;
 				return_error_param = ret;
 				return_error_line = __LINE__;
@@ -3303,6 +3335,8 @@ static void binder_transaction(struct binder_proc *proc,
 								  object_offset,
 								  fda, sizeof(*fda));
 			if (ret) {
+				binder_txn_error("%d:%d translate fd array failed\n",
+					thread->pid, proc->pid);
 				return_error = BR_FAILED_REPLY;
 				return_error_param = ret > 0 ? -EINVAL : ret;
 				return_error_line = __LINE__;
@@ -3330,6 +3364,8 @@ static void binder_transaction(struct binder_proc *proc,
 				(const void __user *)(uintptr_t)bp->buffer,
 				bp->length);
 			if (ret) {
+				binder_txn_error("%d:%d deferred copy failed\n",
+					thread->pid, proc->pid);
 				return_error = BR_FAILED_REPLY;
 				return_error_param = ret;
 				return_error_line = __LINE__;
@@ -3353,6 +3389,8 @@ static void binder_transaction(struct binder_proc *proc,
 							t->buffer,
 							object_offset,
 							bp, sizeof(*bp))) {
+				binder_txn_error("%d:%d failed to fixup parent\n",
+					thread->pid, proc->pid);
 				return_error = BR_FAILED_REPLY;
 				return_error_param = ret;
 				return_error_line = __LINE__;
@@ -3460,6 +3498,8 @@ static void binder_transaction(struct binder_proc *proc,
 	return;
 
 err_dead_proc_or_thread:
+	binder_txn_error("%d:%d dead process or thread\n",
+		thread->pid, proc->pid);
 	return_error_line = __LINE__;
 	binder_dequeue_work(proc, tcomplete);
 err_translate_failed:
-- 
2.36.0.464.gb9c8b46e94-goog

