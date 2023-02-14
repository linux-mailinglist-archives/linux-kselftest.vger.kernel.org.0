Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666D7696E49
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 21:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjBNULK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 15:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjBNULJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 15:11:09 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7795E2448B
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 12:11:04 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id v6so1787148ilc.10
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 12:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1676405464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zF3hu4p13Xrgt6hd2z4ZxB8I11c7NMF84pPWg9WVYpQ=;
        b=GASobBK+pr22NKaOyKqb49BcIeEVstEsLXoqCPKRvdYG1DK4sZR920cSqMa5ydd8zj
         EokywgUal+nAiznci2fxUoenMPhG5GUjwYCGxjlkbcadE1QLD9JYcruUf3wTKynQSMZ4
         AASgvPOJCJ6FbedyEraM5Z70Gx6dY1+5BW0Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676405464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zF3hu4p13Xrgt6hd2z4ZxB8I11c7NMF84pPWg9WVYpQ=;
        b=XDUpimD7BCRSehmAVeXVyVVxK4sOIqxaAlFdltpXgOlviLRp1jWbZoqg8cTIqZjngb
         6qauTNioYAjslHx3vwGfdCOWA+S1ievZmzJ7j2uX2KN4OADfkiFbMx+LyT8nBB7T5emR
         FxkfmqQcxHmWKJ80EYMqiEg/tupfaUPWcV+W0gGA2beBu+QQsoIkvwE7J+0JW/41J+jm
         7811WwII5BM/TO9zxFmEGT+Ac9M2e/Od9BcVEcG3gJj2ovR+tJFEL1ysjMwVxznFVsuC
         oCyBY6lzeITcP/3IUoidtCewYSopedv3xwx9m9M0y3ARTjE24Zth/jAY1N5RLDGqyyq0
         vw8g==
X-Gm-Message-State: AO0yUKXZHx3AVuxnEQb627j7NxDc03vrneanOgnZH4PTt1/BIBRI9p9y
        EqffZVULKerSAI3x7BwoJzoYxQ==
X-Google-Smtp-Source: AK7set+ryjNtAnAjN/WU1vjqHfnCCI+j2jZOJx8dggz3EnlHr02CaaHV9v0mDZ2naWrhewl8J6XEPg==
X-Received: by 2002:a92:c80b:0:b0:314:11c9:955b with SMTP id v11-20020a92c80b000000b0031411c9955bmr19640iln.1.1676405463758;
        Tue, 14 Feb 2023 12:11:03 -0800 (PST)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u7-20020a02cb87000000b003b8708902c0sm5205102jap.21.2023.02.14.12.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 12:11:03 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/user_events: add a note about user_events.h dependency
Date:   Tue, 14 Feb 2023 13:11:01 -0700
Message-Id: <20230214201101.26392-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This test depends on <linux/user_events.h> exported in uapi
The following commit removed user_events.h out of uapi:
commit 5cfff569cab8 ("tracing: Move user_events.h temporarily out
   of include/uapi")

This test will not compile until user_events.h is added back to uapi.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/user_events/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/user_events/Makefile b/tools/testing/selftests/user_events/Makefile
index 87d54c640068..6b512b86aec3 100644
--- a/tools/testing/selftests/user_events/Makefile
+++ b/tools/testing/selftests/user_events/Makefile
@@ -2,6 +2,14 @@
 CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 LDLIBS += -lrt -lpthread -lm
 
+# Note:
+# This test depends on <linux/user_events.h> exported in uapi
+# The following commit removed user_events.h out of uapi:
+# commit 5cfff569cab8bf544bab62c911c5d6efd5af5e05
+# tracing: Move user_events.h temporarily out of include/uapi
+# This test will not compile until user_events.h is added
+# back to uapi.
+
 TEST_GEN_PROGS = ftrace_test dyn_test perf_test
 
 TEST_FILES := settings
-- 
2.37.2

