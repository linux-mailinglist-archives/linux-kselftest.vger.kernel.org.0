Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A28A723782
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 08:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjFFGVb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 02:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjFFGVM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 02:21:12 -0400
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28CB10EF;
        Mon,  5 Jun 2023 23:20:51 -0700 (PDT)
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-6af713338ccso3409357a34.0;
        Mon, 05 Jun 2023 23:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686032451; x=1688624451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Wp+Nr/5/fNTTFPeTaVacXKMU22jIpYdcfNJ7LUWQ4s=;
        b=N7+cd5NhCjywsqLyD63L4j7an4t6grXuJ2+9k7VOtBRE2QIWOGNsazmxLFQIudad1N
         MeYi0h9CrP2w7Mn63+tywuZIOZNykiSFi3j44CgVepLd4nFKuors2SUrT8/RZWRAdI6V
         akX2yP5lpV+Pp0ef/2tffhp82E21jdo/0xsGDB6FkEr0KEuKx70vq4bIPNcNKNiWgCKT
         C7dcccY8GMYFTmyMGK/C1zr/m6hEePJplw6c5wPL4tE8+ZpsH+NI+ryn/kWMxlLVfve/
         rzZ/00U5wl/MlQKyGVsbjXM4NNr9W5yAi4Qex8huVDZuS+rGZf0Ktg6IsKCxh62St0/8
         JT0w==
X-Gm-Message-State: AC+VfDz/eRDy6pkaFWW29HQfIcw/Wq8u4nJJ6PeRu0WOSy1IvSnrhnmK
        cHlHaxCsWuHkziqldWWbWA==
X-Google-Smtp-Source: ACHHUZ4lzxa5cVf6KHAc4U7TMd72sACGByjIUQNOFB5VJqIxECQZeq66I9VjVL7ejJO7+oHOTZIsZQ==
X-Received: by 2002:a9d:7494:0:b0:6ad:e8ad:bb1e with SMTP id t20-20020a9d7494000000b006ade8adbb1emr684016otk.21.1686032451032;
        Mon, 05 Jun 2023 23:20:51 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id w7-20020a634907000000b0052c3f0ae381sm4960841pga.78.2023.06.05.23.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 23:20:50 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH v3 2/4] selftests/user_events: Add ftrace self-test for empty arguments events
Date:   Tue,  6 Jun 2023 14:20:25 +0800
Message-Id: <20230606062027.1008398-3-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606062027.1008398-1-sunliming@kylinos.cn>
References: <20230606062027.1008398-1-sunliming@kylinos.cn>
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

Tests to ensure events that has empty arguments can input trace record
correctly when using ftrace.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 .../selftests/user_events/ftrace_test.c       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 6e8c4b47281c..abfb49558a26 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -316,6 +316,39 @@ TEST_F(user, write_events) {
 	ASSERT_EQ(EINVAL, errno);
 }
 
+TEST_F(user, write_empty_events) {
+	struct user_reg reg = {0};
+	struct iovec io[1];
+	int before = 0, after = 0;
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)"__test_event";
+	reg.enable_bit = 31;
+	reg.enable_addr = (__u64)&self->check;
+	reg.enable_size = sizeof(self->check);
+
+	io[0].iov_base = &reg.write_index;
+	io[0].iov_len = sizeof(reg.write_index);
+
+	/* Register should work */
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+	ASSERT_EQ(0, self->check);
+
+	/* Enable event */
+	self->enable_fd = open(enable_file, O_RDWR);
+	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
+
+	/* Event should now be enabled */
+	ASSERT_EQ(1 << reg.enable_bit, self->check);
+
+	/* Write should make it out to ftrace buffers */
+	before = trace_bytes();
+	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 1));
+	after = trace_bytes();
+	ASSERT_GT(after, before);
+}
+
 TEST_F(user, write_fault) {
 	struct user_reg reg = {0};
 	struct iovec io[2];
-- 
2.25.1

