Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50A2515938
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Apr 2022 01:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381903AbiD3AAY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 20:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381888AbiD3AAX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 20:00:23 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDB23C495
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 16:56:54 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q91-20020a17090a756400b001d951f4846cso7576770pjk.8
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 16:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xFhTGH9QeJ5qiB/zXRnDTivkTaz87eqIQdVVal+AQIE=;
        b=jsTFJVAZ4rGCpZ4ReIt8zBt6uWxZBtjqmkI/o/IJC9aS5dGeOFyznv/dB2oUdWWTEx
         htv3+XKz3FWRL5ut86hgRwU+3xBqQI/LSj0kcYgZ+hSwTkxrmBJ7cSOsar3iBwmcGGmM
         vgjqOkvrqOYb+zcWQwfxyMZI8OkfXRBqmS4cKRdN7EcmOw+HEaO+sz+Pm5H0BWj8uFp2
         +qNwoB+xwjEjqcH7WS1eZLzijKiEEbBiMkK7NKvNnbqjy+++1kA/sgYAedlCcRMTuyvR
         qV+zG6n79jP6ZjxTGZoM2uk5cs0E/dujv6nH0wo3qmTaFVL9YBytG81ZTK/QBFdmxS+0
         R7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xFhTGH9QeJ5qiB/zXRnDTivkTaz87eqIQdVVal+AQIE=;
        b=kJw03lj5S3DUeA9GEXo7BYYXdmDAOp/OOaXml9WzR1nnyLmdlazpNTcJUa7PwcVNNH
         P931BJLmPVSyvOU/9IjQ2UXGYsuDflS8DOV4HiUN99tQM3M3HMCzXYZl02UgUMDMQR5r
         HrIwy9i0SnKGhlF3fMpU/OS3YiAlL9aRbTdT7waZeDTdLUT4zmtVttPLf6dpqrELs6cI
         3B73ibe3WwYZyMVyH0yn5FurwPnfX7HJhQ7HmDvQ+AOZwr2n/LUcm/6l+amZMcFsh11E
         UlIwN9vzRTivnwv8q9j0sFx6weBhl/G8ERTLLvCnysWtrBPLyKH89RUppLeTyZZat4Mk
         4aUw==
X-Gm-Message-State: AOAM530AlCaf+5xO1G8EgUERJnWPU8lZPf+CTnqt2hw302LDXUK7L+wN
        dUWEFMUJPoQtzN0/3fOY1OHcWnE58i7Axg==
X-Google-Smtp-Source: ABdhPJxryxQ/W5f0mnRCA3VXeYsHPAOW3KmhV77eCRQVRyQ7xJ2vWAUFMEAVfxyiYM+pYR8BJB0aKpps/mGfzw==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a17:902:f70a:b0:153:88c7:774 with SMTP id
 h10-20020a170902f70a00b0015388c70774mr1440396plo.166.1651276613804; Fri, 29
 Apr 2022 16:56:53 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:56:40 +0000
In-Reply-To: <20220429235644.697372-1-cmllamas@google.com>
Message-Id: <20220429235644.697372-2-cmllamas@google.com>
Mime-Version: 1.0
References: <20220429235644.697372-1-cmllamas@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 1/5] binder: add failed transaction logging info
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

Make sure we log relevant information about failed transactions such as
the target proc/thread, call type and transaction id. These details are
particularly important when debugging userspace issues.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8351c5638880..f0885baa53a1 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3459,8 +3459,12 @@ static void binder_transaction(struct binder_proc *proc,
 	}
 
 	binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
-		     "%d:%d transaction failed %d/%d, size %lld-%lld line %d\n",
-		     proc->pid, thread->pid, return_error, return_error_param,
+		     "%d:%d transaction %s to %d:%d failed %d/%d/%d, size %lld-%lld line %d\n",
+		     proc->pid, thread->pid, reply ? "reply" :
+		     (tr->flags & TF_ONE_WAY ? "async" : "call"),
+		     target_proc ? target_proc->pid : 0,
+		     target_thread ? target_thread->pid : 0,
+		     t_debug_id, return_error, return_error_param,
 		     (u64)tr->data_size, (u64)tr->offsets_size,
 		     return_error_line);
 
-- 
2.36.0.464.gb9c8b46e94-goog

