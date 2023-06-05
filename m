Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F078F721F95
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 09:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjFEHbj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 03:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjFEHbh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 03:31:37 -0400
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE25E45;
        Mon,  5 Jun 2023 00:31:21 -0700 (PDT)
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-6b0d38ce700so3441174a34.2;
        Mon, 05 Jun 2023 00:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685950280; x=1688542280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jenmxpk3FCUjrB1H59Y+BPd1oj6QHHG+nDgkIblmsLc=;
        b=END/PCz6Qqx63+YZ4CglmYskMGCIoAIzcjTGgJvNTLhXG1XgoAI2ADrR05B5vTw0IM
         SvIGA3Tz2TTVf6b4jBAz2av62wW8fgZ15DzK+jRmjZtzYLErGNCgaZUP7jn7LDX/gWOi
         zerM1cglO3Tf7l7/yew7VHgjCq97OwaWAta1UXhokNmFyKJkye06J9GB60fKdzQHDHbd
         +z8kxpUvlh1nRVaOVjxETx7EmIpzFzlme5tPqd21y3yMRhBrXNUbckIhQagzR8urNrFE
         zl9cUN2FMhWtsAF/QE1cwJhcsHbxWm90iNBChFPNcnKNZmoayQwHCWAFnvmAEwAm8pJJ
         JnDQ==
X-Gm-Message-State: AC+VfDw3Y8d+wFarmQ2Q431jWC0hMdm5d4cfk459iGnVMs6wcGomPOrT
        K6xg3YmnR7dSfMM9Hvi++aLbXn6rmfHRfSJfBA==
X-Google-Smtp-Source: ACHHUZ6HiIra3nLWT29yDqqsEPoW/TSJaWQ0rO+8JzEp6Y54qU7FfkunFQ7WUu4mmmdEdTgwJ8HCHw==
X-Received: by 2002:a9d:74cc:0:b0:6af:95c0:fe1e with SMTP id a12-20020a9d74cc000000b006af95c0fe1emr10072502otl.5.1685950280156;
        Mon, 05 Jun 2023 00:31:20 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 128-20020a630786000000b0053ba104c113sm5200419pgh.72.2023.06.05.00.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:31:19 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH V2 3/4] selftests/user_events: Clear the events after perf self-test
Date:   Mon,  5 Jun 2023 15:30:22 +0800
Message-Id: <20230605073023.923316-3-sunliming@kylinos.cn>
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

