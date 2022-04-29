Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDD6515937
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Apr 2022 01:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381894AbiD3AAZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 20:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381900AbiD3AAY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 20:00:24 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D31F3EA88
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 16:56:59 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b6-20020a170902d50600b0015d1eb8c82eso4854054plg.12
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y2U6N/SaFktITLsdt43NK/igdRg3kVW252737IBt0LU=;
        b=ZGtQirrtNgXHKRVauFBtG+/sgxRYvk5XZr0WfLUwxPVfzq71bBqkfVmqmZJFCCYzAM
         EeR6l9JIrhRPwfAFrPtu7ReRC9acMq0O2cxebjqEH3+dd7Aq7Xw5fn7FO86LDCdjh1vM
         McqYBJcvqSt4izZK5Cx2P14o4+3iJDE5hrGA8ZUvln3LftkJXlqFqhiijXAm4YzEbr1K
         HgSew1IkNTU2D6cX62XJfYwiOMP9cdMsU3P6sWd+5gEHoT4S/NuKeGQ7LioUaQU9n7gU
         8rRW4CN8j7cvRn89ri03+6o6a3hs0vGLtCagVgA7AWQMLAcA6hmDMaFTk6YTalDxwADS
         fsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y2U6N/SaFktITLsdt43NK/igdRg3kVW252737IBt0LU=;
        b=wYOPueV0TeQh/45SfMvqgl3VEARwmT3m6t/cSJH2UTksDSkW3wVtdNf4xSfg2txlR5
         yv+eu8MWhHElvRhXbj0U2Cb41IIA79PNwgemJqTkzPmLgFzqfPl3w4urqJX8BPHlPCAY
         ZYqHD0IuMET//K/u5w8SEHy3W2lMoEYgqpmuGCLFyVH36yjiKPc/ozVewm1kMwTAQUqg
         6ec+ydaN7VtHbN6DdMdxd0PJz8Q0mqDhOOYJNeslGeJKL0S5a97/rSSbU0aPzW55L4mk
         TUN7dzQg+4ZgCczs+VNaYU8sPqzw04GoJwnTPVwjdhkaD6dsS8ceRrRiVl9otD98PJLS
         t82A==
X-Gm-Message-State: AOAM533ctqeFMqmDMpMnDptEf1jIHzhoEJ43WFkErfmqWGEwfptCGeNB
        wdcSTLmz0d38VazfjZ8jtcatKp0ctW8WbQ==
X-Google-Smtp-Source: ABdhPJybU3tuDpqq8Uoh7B87O4KK/KSqVfWaE8DjxnMMELo/U7FUT5BAmeuLOCGT+nBWxSAB5NqgEkWT32gRSg==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a17:90a:3486:b0:1d9:3abd:42ed with SMTP
 id p6-20020a17090a348600b001d93abd42edmr6692184pjb.32.1651276619241; Fri, 29
 Apr 2022 16:56:59 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:56:43 +0000
In-Reply-To: <20220429235644.697372-1-cmllamas@google.com>
Message-Id: <20220429235644.697372-5-cmllamas@google.com>
Mime-Version: 1.0
References: <20220429235644.697372-1-cmllamas@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 4/5] binder: convert logging macros into functions
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

Converting binder_debug() and binder_user_error() macros into functions
reduces the overall object size by 16936 bytes when cross-compiled with
aarch64-linux-gnu-gcc 11.2.0:

$ size drivers/android/binder.o.{old,new}
   text	   data	    bss	    dec	    hex	filename
  77935	   6168	  20264	 104367	  197af	drivers/android/binder.o.old
  65551	   1616	  20264	  87431	  15587	drivers/android/binder.o.new

This is particularly beneficial to functions binder_transaction() and
binder_thread_write() which repeatedly use these macros and are both
part of the critical path for all binder transactions.

$ nm --size vmlinux.{old,new} |grep ' binder_transaction$'
0000000000002f60 t binder_transaction
0000000000002358 t binder_transaction

$ nm --size vmlinux.{old,new} |grep binder_thread_write
0000000000001c54 t binder_thread_write
00000000000014a8 t binder_thread_write

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 41 ++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b9df0c8a68d3..bfb21e258427 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -133,19 +133,36 @@ static int binder_set_stop_on_user_error(const char *val,
 module_param_call(stop_on_user_error, binder_set_stop_on_user_error,
 	param_get_int, &binder_stop_on_user_error, 0644);
 
-#define binder_debug(mask, x...) \
-	do { \
-		if (binder_debug_mask & mask) \
-			pr_info_ratelimited(x); \
-	} while (0)
+static __printf(2, 3) void binder_debug(int mask, const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
 
-#define binder_user_error(x...) \
-	do { \
-		if (binder_debug_mask & BINDER_DEBUG_USER_ERROR) \
-			pr_info_ratelimited(x); \
-		if (binder_stop_on_user_error) \
-			binder_stop_on_user_error = 2; \
-	} while (0)
+	if (binder_debug_mask & mask) {
+		va_start(args, format);
+		vaf.va = &args;
+		vaf.fmt = format;
+		pr_info_ratelimited("%pV", &vaf);
+		va_end(args);
+	}
+}
+
+static __printf(1, 2) void binder_user_error(const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	if (binder_debug_mask & BINDER_DEBUG_USER_ERROR) {
+		va_start(args, format);
+		vaf.va = &args;
+		vaf.fmt = format;
+		pr_info_ratelimited("%pV", &vaf);
+		va_end(args);
+	}
+
+	if (binder_stop_on_user_error)
+		binder_stop_on_user_error = 2;
+}
 
 #define binder_set_extended_error(ee, _id, _command, _param) \
 	do { \
-- 
2.36.0.464.gb9c8b46e94-goog

