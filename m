Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB40723788
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 08:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjFFGVv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 02:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbjFFGVR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 02:21:17 -0400
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27971E7A;
        Mon,  5 Jun 2023 23:21:01 -0700 (PDT)
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-75d46c7cd6cso236203285a.3;
        Mon, 05 Jun 2023 23:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686032460; x=1688624460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rc7PLQvFEE8X9O2VY6JsXWP7Dk9wQWFYyen6iuJwNw0=;
        b=PlQleMlrvEziD3KF10E3UJhzXd4aIVHD0MsKcsLCor46sY6E10l+OGahrbAtqJeGxN
         KcTPhsQ8QvUN9T65TKOEmvLSmbyZKWmXQzn9AQ37bupJDkJK3oP/tYrZE/u3JOx5kpLB
         LxRS/ANQHDg7cOIxEujCWr+E5n0UX4XmwuRaK1+3QMcyFjUaupPejRJb/AXJIB8irtPL
         NE6zKNLg9lDWgDk/wBG4BY1AQ/8dNEmiKdu2UWLiYo1KjCVZOS+iF7A/Kz87uQeoJAZy
         RcnxxgQuYqbc9Kc5wJiA1f20gRcRj0sRrorZHajvg/GqA5QbwZ6KAz57oXJJm0JK/qVU
         mEkw==
X-Gm-Message-State: AC+VfDxjbxxQyu3osBDJxI7D1kkmk0NuUxB92is65WbR/b4SJDSTFX07
        Ri+zDj16jOTGxKNXzMtrCg==
X-Google-Smtp-Source: ACHHUZ6MTemUniypbt8RB6q/OMvYfJGTX2Zc6eFR1oaXfgXtfhvZBVGdVIf2m/ROdkWZBhlS5FO0Gw==
X-Received: by 2002:a05:620a:26a2:b0:75b:23a1:833d with SMTP id c34-20020a05620a26a200b0075b23a1833dmr830213qkp.56.1686032460250;
        Mon, 05 Jun 2023 23:21:00 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id w7-20020a634907000000b0052c3f0ae381sm4960841pga.78.2023.06.05.23.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 23:20:59 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH v3 4/4] selftests/user_events: Add perf self-test for empty arguments events
Date:   Tue,  6 Jun 2023 14:20:27 +0800
Message-Id: <20230606062027.1008398-5-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606062027.1008398-1-sunliming@kylinos.cn>
References: <20230606062027.1008398-1-sunliming@kylinos.cn>
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
correctly when using perf.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 .../testing/selftests/user_events/perf_test.c | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index e97f24ab6e2f..8b09be566fa2 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -189,6 +189,59 @@ TEST_F(user, perf_write) {
 	ASSERT_EQ(0, self->check);
 }
 
+TEST_F(user, perf_empty_events) {
+	struct perf_event_attr pe = {0};
+	struct user_reg reg = {0};
+	struct perf_event_mmap_page *perf_page;
+	int page_size = sysconf(_SC_PAGESIZE);
+	int id, fd;
+	__u32 *val;
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)"__test_event";
+	reg.enable_bit = 31;
+	reg.enable_addr = (__u64)&self->check;
+	reg.enable_size = sizeof(self->check);
+
+	/* Register should work */
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+	ASSERT_EQ(0, self->check);
+
+	/* Id should be there */
+	id = get_id();
+	ASSERT_NE(-1, id);
+
+	pe.type = PERF_TYPE_TRACEPOINT;
+	pe.size = sizeof(pe);
+	pe.config = id;
+	pe.sample_type = PERF_SAMPLE_RAW;
+	pe.sample_period = 1;
+	pe.wakeup_events = 1;
+
+	/* Tracepoint attach should work */
+	fd = perf_event_open(&pe, 0, -1, -1, 0);
+	ASSERT_NE(-1, fd);
+
+	perf_page = mmap(NULL, page_size * 2, PROT_READ, MAP_SHARED, fd, 0);
+	ASSERT_NE(MAP_FAILED, perf_page);
+
+	/* Status should be updated */
+	ASSERT_EQ(1 << reg.enable_bit, self->check);
+
+	/* Ensure write shows up at correct offset */
+	ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
+					sizeof(reg.write_index)));
+	val = (void *)(((char *)perf_page) + perf_page->data_offset);
+	ASSERT_EQ(PERF_RECORD_SAMPLE, *val);
+
+	munmap(perf_page, page_size * 2);
+	close(fd);
+
+	/* Status should be updated */
+	ASSERT_EQ(0, self->check);
+}
+
 int main(int argc, char **argv)
 {
 	return test_harness_run(argc, argv);
-- 
2.25.1

