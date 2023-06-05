Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56BD721F97
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 09:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjFEHbo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 03:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjFEHbk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 03:31:40 -0400
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430AF118;
        Mon,  5 Jun 2023 00:31:24 -0700 (PDT)
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-6af81142b6dso4282034a34.2;
        Mon, 05 Jun 2023 00:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685950283; x=1688542283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjH9eOPUMgvUuYzrotRDm7fc4vW9NrXoyCCMM1Pnj9g=;
        b=PzoCWjDIfjBUXkIQSRxM3jQGUVhZWCaVNkL6zVdxA6TxvlpmEqkwD7Zb2dsPyGVxKi
         jKuPWXiuIgZlVmx845eo/rSEpBOOnT7fLi6zbzwonOBUpNiMDtWWSs+K4/oKYIEXF7Je
         Jrws/5NaoT3SKTJZlv5WJCt9aC5eLzIIi+0pSWaIgpKrii4lR0RSK2PaJ1JewFy8uTCb
         jOQVkHBJQYLMa4OSx0WMbR+0+1g466tx4lYKqWWZP+VJztwobrDIHmFuStNNj8xhTuVJ
         9/alDi9T4tpEmH+AgKFGKBF5xePFkjGCg0Q30KaXTYbzoEXWZhAnoQoGjHKwSF5w9/g4
         kVRQ==
X-Gm-Message-State: AC+VfDzSo/lx65dgEpewcYguqeAEUnSGw8WULJQpnQTxzkdAnICph/0R
        j6BkXhDGIIOZk5O6X9jDPQ==
X-Google-Smtp-Source: ACHHUZ7eiClij7spmG73QbIuI4ywtDluEPQnki3nFEPvmFkWEfZ8FCRSvGZySA0GRuT1y4Zl1DLl3g==
X-Received: by 2002:a9d:7a91:0:b0:6af:7e7e:d7b with SMTP id l17-20020a9d7a91000000b006af7e7e0d7bmr9926291otn.15.1685950283566;
        Mon, 05 Jun 2023 00:31:23 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 128-20020a630786000000b0053ba104c113sm5200419pgh.72.2023.06.05.00.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:31:23 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH V2 4/4] user_events: Add perf self-test for empty arguments events
Date:   Mon,  5 Jun 2023 15:30:23 +0800
Message-Id: <20230605073023.923316-4-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605073023.923316-1-sunliming@kylinos.cn>
References: <20230605073023.923316-1-sunliming@kylinos.cn>
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
correctly when using perf.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 .../testing/selftests/user_events/perf_test.c | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index e97f24ab6e2f..c0e7eb7fab0b 100644
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
+				sizeof(reg.write_index)));
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

