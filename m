Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32EB47074C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 18:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244408AbhLJRhS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 12:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244526AbhLJRhQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 12:37:16 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476A7C0698C8
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 09:33:36 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so10288051otv.9
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 09:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/J3xxEJxkEvAAiRy+g/i0IsA4cENLPTzNbNRnvQozU=;
        b=MO5T+UaVz8ug6bW9OaRnZMX373bpG+BInMrxZgZYu0IMhZklmmEfDKCyN/K2MoiODa
         G6hO3uQZa9blhM3SlfDIt7aLnyMgJDl58ZaCKTgRJS1BUllpVaSen47Y590oxNA+YWox
         87Qo100HIDOoVJD0mJaPMQpUlA9+yPM0r9/9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/J3xxEJxkEvAAiRy+g/i0IsA4cENLPTzNbNRnvQozU=;
        b=GfVF3GcJa82WGHV2d29TSOswv6vrIERF6WMY89/Z28Mk+tag2W0jiwD34k/3AnPGrq
         kcOHC4D7ZRS4KLw48Ma+RiOGrCIrU4I5zmS8t/K8Ur8OSrEKZhuGOzzp5RjEo3rMi+ny
         ZXQP9OckBWIsJbtduUgqSyrAizECfhMNrREp6b2TIBSmqOretn157IT9ctVyDr5M8LEa
         pgibUn1+ldToAaXa7ROiYEbpNTk1gyqOZVQjfCTtPu2TOX4m90b91xk9ZrWvx/q6unb6
         VJwxwiIpImY2PyVP2i/UNFn6NaU9b7fFyh3YAX/cBAErlC/PlzbSUkGfNqMZd9tlci4B
         KBaQ==
X-Gm-Message-State: AOAM5312t8SEQND2OBmkUeq8XY5cFe7Dw7tcI1qsLUiIzVK1TxsbC6zM
        2kgkCtWbVvkNN36s2tq2YrAIYS6N/IE6Fg==
X-Google-Smtp-Source: ABdhPJyBok/xLU4m7kmNcpabZivXV4eEhLTbuaMZiVGExFqxo43MXq9in4SCZUd7RRqOP++fZsAALA==
X-Received: by 2002:a9d:7993:: with SMTP id h19mr12393753otm.245.1639157615401;
        Fri, 10 Dec 2021 09:33:35 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x4sm892224oiv.35.2021.12.10.09.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:33:35 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        keescook@chromium.org, mic@digikod.net, davem@davemloft.net,
        kuba@kernel.org, peterz@infradead.org, paulmck@kernel.org,
        boqun.feng@gmail.com, akpm@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 10/12] selftests/sparc64: remove ARRAY_SIZE define from adi-test
Date:   Fri, 10 Dec 2021 10:33:20 -0700
Message-Id: <1d59b5b24a98ffbc83de257c1a9cbe1fd9f01c63.1639156389.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1639156389.git.skhan@linuxfoundation.org>
References: <cover.1639156389.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ARRAY_SIZE is defined in several selftests. Remove definition from
individual test files and include header file for the define instead.
ARRAY_SIZE define is added in a separate patch to prepare for this
change.

Remove ARRAY_SIZE from adi-test and pickup the one defined in
kselftest.h.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/sparc64/drivers/adi-test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/sparc64/drivers/adi-test.c b/tools/testing/selftests/sparc64/drivers/adi-test.c
index 95d93c6a88a5..84e5d9fd20b0 100644
--- a/tools/testing/selftests/sparc64/drivers/adi-test.c
+++ b/tools/testing/selftests/sparc64/drivers/adi-test.c
@@ -24,10 +24,6 @@
 #define DEBUG_LEVEL_4_BIT	(0x0008)
 #define DEBUG_TIMING_BIT	(0x1000)
 
-#ifndef ARRAY_SIZE
-# define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#endif
-
 /* bit mask of enabled bits to print */
 #define DEBUG 0x0001
 
-- 
2.32.0

