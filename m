Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E1A728E48
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 05:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbjFIDFS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 23:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238228AbjFIDEz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 23:04:55 -0400
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A6D30C3;
        Thu,  8 Jun 2023 20:04:34 -0700 (PDT)
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-6b16cbe4fb6so287553a34.1;
        Thu, 08 Jun 2023 20:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686279873; x=1688871873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETnK27P5xF7JUmROEHyWwtf42DA9xFAclMKuefb0oy8=;
        b=cdwAT6tcq0pwv2adOHav6DgMtseybTtV9/JAEXAgO+FmLlX2sxpQIz6xL/MnP20E4j
         P28pSrHwoT/HmFuxOkdKGrrDk62OWnS6OfwQtATbN5xEbR2PwncJ6xz5WUYYK852Fr+0
         fAPCjsMkQvwvks7REpWhDf5K7YOJ1gV5Skox9W5uoXnXmhi3C3+JoYotU0Yk04gvQAAr
         qYnJvcJuYkYZhnbRZVwiEO9a7MEW/Ddnj3qemRQODXfin2UbYNthz12jC4M5pLAbnMsf
         +zqAaQO6C1+w358Dwfvoc2bVAhOCHhprSUWso6/zcWiQuxSzGJcFd/tu9sHruUAWupEC
         curw==
X-Gm-Message-State: AC+VfDyt0qHcUDb1JevCGavg4+M8UmJtTnncexSXBP99sgL3dlwwetqY
        VCFLAHSKG7SKArqW7gcwgw==
X-Google-Smtp-Source: ACHHUZ7eBVoXvUzpnEf3GDChtDNenCaQKoZcCkXzXJ5F3K0hrKVdPhoCC8kS4fBa8omxMLrFjrMlNA==
X-Received: by 2002:a9d:7858:0:b0:6ab:3367:795b with SMTP id c24-20020a9d7858000000b006ab3367795bmr257752otm.12.1686279873419;
        Thu, 08 Jun 2023 20:04:33 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id a16-20020a62bd10000000b0065ecdefa57fsm1713778pff.0.2023.06.08.20.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 20:04:33 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH v2 3/3] selftests/user_events: Add test cases when event is disabled
Date:   Fri,  9 Jun 2023 11:03:02 +0800
Message-Id: <20230609030302.1278716-4-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230609030302.1278716-1-sunliming@kylinos.cn>
References: <20230609030302.1278716-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When user_events are disabled, it's write operation should be fail. Add
this test cases.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 tools/testing/selftests/user_events/ftrace_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index d33bd31425db..cf52789bafda 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -297,6 +297,10 @@ TEST_F(user, write_events) {
 	io[0].iov_base = &reg.write_index;
 	io[0].iov_len = sizeof(reg.write_index);
 
+	/* Write should fail when event is not enabled */
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	ASSERT_EQ(ENOENT, errno);
+
 	/* Enable event */
 	self->enable_fd = open(enable_file, O_RDWR);
 	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
-- 
2.25.1

