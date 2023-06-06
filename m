Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DCC723787
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 08:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjFFGVt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 02:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjFFGVQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 02:21:16 -0400
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ED2E44;
        Mon,  5 Jun 2023 23:20:55 -0700 (PDT)
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-6b0d38ce700so4323507a34.2;
        Mon, 05 Jun 2023 23:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686032454; x=1688624454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jenmxpk3FCUjrB1H59Y+BPd1oj6QHHG+nDgkIblmsLc=;
        b=jl6VK1lzKHRENIXwTvwq/9RkwDX+yUsOxdCFrddd8R+Tui23Hn6d0pLETOzFpd6tkr
         N0sa2diAiSvfdhkTOOU1+Ko6djPeIot1iT5+ijNCfQxKtiC04H/Enxinc5JwM3+mkO2g
         XxRAcq2Is0KWMf/hGuRaeT9xnNsX5Okqz8yUlHIaaZupbzChWk/4vTlA37O+CIBXI5VP
         g3E0dLHQKkcONQ+ab9hs3AxxC/D0wBIluGr+srZAZgHLz4/Vp4ORUCU/luT8s94hP0bq
         rv0cKvqJLh4PnhHpTf06NSihIVZMy//GHHL8tLY7IETxeTaRCpfUFFIhgYZfLWGOWbWS
         6bzQ==
X-Gm-Message-State: AC+VfDyFuxGnIK9ZWBpul1zf0K4hB8xDZJehqahIUJ6Bxaso6JaFLUWQ
        vBEQ+tMz1jUIogG5lfmVjDNUY3uvX1ApEVH9mA==
X-Google-Smtp-Source: ACHHUZ4SKLh21gHOApj5OPYGpmfaNf5ntQ0gowoeOveRDuuez09xTBqHjoD3idjdHNELC9kMFBEDnA==
X-Received: by 2002:a05:6830:193:b0:6b1:6958:9e1a with SMTP id q19-20020a056830019300b006b169589e1amr1383293ota.15.1686032454596;
        Mon, 05 Jun 2023 23:20:54 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id w7-20020a634907000000b0052c3f0ae381sm4960841pga.78.2023.06.05.23.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 23:20:54 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH v3 3/4] selftests/user_events: Clear the events after perf self-test
Date:   Tue,  6 Jun 2023 14:20:26 +0800
Message-Id: <20230606062027.1008398-4-sunliming@kylinos.cn>
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

When the self test is completed, perf self-test left the user events not to
be cleared. Clear the events by unregister and delete the event.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 .../testing/selftests/user_events/perf_test.c | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index a070258d4449..e97f24ab6e2f 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -81,6 +81,32 @@ static int get_offset(void)
 	return offset;
 }
 
+static int clear(int *check)
+{
+	struct user_unreg unreg = {0};
+
+	unreg.size = sizeof(unreg);
+	unreg.disable_bit = 31;
+	unreg.disable_addr = (__u64)check;
+
+	int fd = open(data_file, O_RDWR);
+
+	if (fd == -1)
+		return -1;
+
+	if (ioctl(fd, DIAG_IOCSUNREG, &unreg) == -1)
+		if (errno != ENOENT)
+			return -1;
+
+	if (ioctl(fd, DIAG_IOCSDEL, "__test_event") == -1)
+		if (errno != ENOENT)
+			return -1;
+
+	close(fd);
+
+	return 0;
+}
+
 FIXTURE(user) {
 	int data_fd;
 	int check;
@@ -93,6 +119,9 @@ FIXTURE_SETUP(user) {
 
 FIXTURE_TEARDOWN(user) {
 	close(self->data_fd);
+
+	if (clear(&self->check) != 0)
+		printf("WARNING: Clear didn't work!\n");
 }
 
 TEST_F(user, perf_write) {
-- 
2.25.1

