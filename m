Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B8472740D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 03:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjFHBQ3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 21:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjFHBQ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 21:16:26 -0400
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DD726AE;
        Wed,  7 Jun 2023 18:16:22 -0700 (PDT)
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-256766a1c43so34154a91.1;
        Wed, 07 Jun 2023 18:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686186982; x=1688778982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fjZocQuLj2YEu+oxrRPhJbmjewTJfCmZq5g1FLSCZg=;
        b=P+4Dm75tmNxsfJSCwrBUJY0zB9KiieawRmiA2LFkOL5uoFE1xNqB6YpnTGpplIky2e
         0O6ANUn/oX0HDKufycEe4b/XvmGevWnKZYrXMwyN9pqDwtAtqAPWpvyoDHFgPXmncBvZ
         KgeN+VMKCPlw7AogKxwWp3tFyO501ZvUMLmSPF5ZW7Jq5ItVEasDHibe4GgUJ1AwFgyD
         py270dOzzo6UN4MKT6YVW1zZaa5sMtVMO6ZoKKIYomWTv/iPo92WwrNNphHqnho4Yns8
         D8gQE+0FDZzfcSlg3kQe3tRahTTTTWGG9sJQYRc26+sDC0hwN8v6qVF53R/eWZSsB4+1
         d0KA==
X-Gm-Message-State: AC+VfDxaRQwvUmaSpw6PSkh2YEDm3FpKb3ueb7ibpx0uDeSTxAHk0emO
        yg3UBPOcnRSg6Kn/PlIrZA==
X-Google-Smtp-Source: ACHHUZ5QvjEgG6Q8wAbgsgYjwXcFIa3cbvGL6K23v78TkeyNYGSc8+d804DIT9DZNEJ7ivrFsCrBqA==
X-Received: by 2002:a17:90b:e8a:b0:255:f693:cf91 with SMTP id fv10-20020a17090b0e8a00b00255f693cf91mr3490612pjb.30.1686186981761;
        Wed, 07 Jun 2023 18:16:21 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090a128b00b00250334d97dasm1906691pja.31.2023.06.07.18.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 18:16:21 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH 3/3] selftests/user_events: Add test cases when event is disabled
Date:   Thu,  8 Jun 2023 09:15:54 +0800
Message-Id: <20230608011554.1181097-4-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230608011554.1181097-1-sunliming@kylinos.cn>
References: <20230608011554.1181097-1-sunliming@kylinos.cn>
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
 tools/testing/selftests/user_events/ftrace_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index d33bd31425db..d3240a97f23d 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -297,6 +297,9 @@ TEST_F(user, write_events) {
 	io[0].iov_base = &reg.write_index;
 	io[0].iov_len = sizeof(reg.write_index);
 
+	/* Write should fail when event is not enabled */
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+
 	/* Enable event */
 	self->enable_fd = open(enable_file, O_RDWR);
 	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
-- 
2.25.1

