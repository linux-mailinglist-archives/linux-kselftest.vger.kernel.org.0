Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F96D721F92
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 09:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjFEHb0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 03:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjFEHbX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 03:31:23 -0400
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58BD187;
        Mon,  5 Jun 2023 00:31:11 -0700 (PDT)
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-39a55e5cfc0so4180634b6e.3;
        Mon, 05 Jun 2023 00:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685950271; x=1688542271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Wp+Nr/5/fNTTFPeTaVacXKMU22jIpYdcfNJ7LUWQ4s=;
        b=SbJNVxdLDz3Ze4gGFdXAD1FNgYWe1M8VCSHe92y2Nd52RcHmMt3kJuZQ11cpaq3Wqr
         9NKJACPafxIE7PohDuHB6irQpMzT9z3M8AXEfNh5xnSuXtBL8lK8t3WGHvPj28fhNE7S
         wnRvI8EH5iygRLqA9pDS7uPZiBCV1pbbrJih7K7F0snjE1mRwefa8qTZpAhISXx+8Jsd
         XdTwMPCWBwO7gNB3bffOlrAaNuvSpJSYcPVRsOwtYghkkSoIrWhsU6tJyNJBe+Y7PAw/
         GLcSrtsub4uclp16Pn6AToryIM65QUyv5bPY5Ec1XcRnNuyvlm13U3VtQnSjoAp9ahHQ
         Z6hQ==
X-Gm-Message-State: AC+VfDw87HWTcaulSibXQHtFGMWPbudxoLHrAi62Moua+gwYgavg9rps
        DhsjiAqQ5YBzg6vxdyB0PA==
X-Google-Smtp-Source: ACHHUZ6Il/jMAEvOZLaYAKAkYj+X+egF+l6TXBh90LyIWBvvgxGLE9VkZOPIfsrArwimJFkHg8qyzA==
X-Received: by 2002:aca:2202:0:b0:39b:80:5c7f with SMTP id b2-20020aca2202000000b0039b00805c7fmr545451oic.32.1685950270939;
        Mon, 05 Jun 2023 00:31:10 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 128-20020a630786000000b0053ba104c113sm5200419pgh.72.2023.06.05.00.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:31:10 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH V2 2/4] user_events: Add ftrace self-test for empty arguments events
Date:   Mon,  5 Jun 2023 15:30:21 +0800
Message-Id: <20230605073023.923316-2-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605073023.923316-1-sunliming@kylinos.cn>
References: <20230605073023.923316-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

