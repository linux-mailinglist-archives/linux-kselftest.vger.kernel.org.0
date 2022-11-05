Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B0561D884
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Nov 2022 08:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKEHbw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Nov 2022 03:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKEHbu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Nov 2022 03:31:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C618A1D337;
        Sat,  5 Nov 2022 00:31:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so6317320pjl.3;
        Sat, 05 Nov 2022 00:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+otlA4QIboUDRueQO9e4GFOwBfPboTuyVI0TCrHZiY=;
        b=OSlIZ4vgf63ujANh33Jm6gnIp26soIo9dURSwkOmBrN2lYPD61iNXtmoQ4Z7QcNxwa
         NyRdxNbG/9htPnPIvwaYPhP/H0ptk3Qo0CKpfZgQNcFqGK3hR5CCb97nfJAzZpggwA2K
         APKc36+sVP9KIcPWIzoCEiNyu962kmXTHpy2Mu6BKU9l6dG/IMnXe2Y9Lx6HQhLqxHZF
         muv3B6zwr+FjMiz9TEpyOdKFosMi5ByjB4zxfmQ8O1vE4ZOb6g7Sxn/zHMir3pCK+kyf
         m72lEcn+RQ6xq9AUhLF1R3sRRvr/t1yhOe9uy4+/jFzAjxv0TCE9GaguhE9oJXI9aPpd
         ovfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+otlA4QIboUDRueQO9e4GFOwBfPboTuyVI0TCrHZiY=;
        b=D+uG0iUyLWC5+XmH9xx60fNW+8d+RyCFEPilN08P543wHs6W1mHW4n9hQfVa82/BdB
         xzowSJkjaZOxuwbM9DG8kC0MTYoTfHapNbRwZsL5wGMfMBtCv//XFxF1UJ4ro3ZQ14sQ
         68nZQ8m52nR868GQsK5hhqRGHbPn29RPM6PcMrTtmekPcQCqgebFn6qNrqemeNMPEivS
         WH61zRLv2Om7RpKcYgQ11KjlNoShe9CG+HshjYrv0ASvQdSpeTCAUMPThoC5BtZF4Ee5
         EMs02wMXfxaYRFeuSbZP7UXY5eyDOv/ijQDxUCNqhAB8bTWoXPJvaZZO4k0JC02d1uRL
         cr+w==
X-Gm-Message-State: ACrzQf0kXZssfI69HOKxo9RgrEnFdqju30N6B2n7PL1rD5OVs8jasSRG
        G+3WM+ujH/C6b5EqtVaAnIg=
X-Google-Smtp-Source: AMsMyM6YEP+hyToflLqz8ACVY84G85eNrK7UzfsXin9v8FJDg1n8T2H1caiieSaLKlrE0m0rOzw9sA==
X-Received: by 2002:a17:902:be03:b0:17b:80c1:78c2 with SMTP id r3-20020a170902be0300b0017b80c178c2mr39825484pls.34.1667633509134;
        Sat, 05 Nov 2022 00:31:49 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id y28-20020aa79afc000000b005627ddbc7a4sm713067pfp.191.2022.11.05.00.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 00:31:48 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH] kselftest/arm64: fix array_size.cocci warning
Date:   Sat,  5 Nov 2022 16:31:43 +0900
Message-Id: <20221105073143.78521-1-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use ARRAY_SIZE to fix the following coccicheck warnings:
tools/testing/selftests/arm64/mte/check_buffer_fill.c:341:20-21:
WARNING: Use ARRAY_SIZE
tools/testing/selftests/arm64/mte/check_buffer_fill.c:35:20-21:
WARNING: Use ARRAY_SIZE
tools/testing/selftests/arm64/mte/check_buffer_fill.c:168:20-21:
WARNING: Use ARRAY_SIZE
tools/testing/selftests/arm64/mte/check_buffer_fill.c:72:20-21:
WARNING: Use ARRAY_SIZE
tools/testing/selftests/arm64/mte/check_buffer_fill.c:369:25-26:
WARNING: Use ARRAY_SIZE

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 .../testing/selftests/arm64/mte/check_buffer_fill.c  | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_buffer_fill.c b/tools/testing/selftests/arm64/mte/check_buffer_fill.c
index 75fc482d63b6..1dbbbd47dd50 100644
--- a/tools/testing/selftests/arm64/mte/check_buffer_fill.c
+++ b/tools/testing/selftests/arm64/mte/check_buffer_fill.c
@@ -32,7 +32,7 @@ static int check_buffer_by_byte(int mem_type, int mode)
 	bool err;
 
 	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
-	item = sizeof(sizes)/sizeof(int);
+	item = ARRAY_SIZE(sizes);
 
 	for (i = 0; i < item; i++) {
 		ptr = (char *)mte_allocate_memory(sizes[i], mem_type, 0, true);
@@ -69,7 +69,7 @@ static int check_buffer_underflow_by_byte(int mem_type, int mode,
 	char *und_ptr = NULL;
 
 	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
-	item = sizeof(sizes)/sizeof(int);
+	item = ARRAY_SIZE(sizes);
 	for (i = 0; i < item; i++) {
 		ptr = (char *)mte_allocate_memory_tag_range(sizes[i], mem_type, 0,
 							    underflow_range, 0);
@@ -165,7 +165,7 @@ static int check_buffer_overflow_by_byte(int mem_type, int mode,
 	char *over_ptr = NULL;
 
 	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
-	item = sizeof(sizes)/sizeof(int);
+	item = ARRAY_SIZE(sizes);
 	for (i = 0; i < item; i++) {
 		ptr = (char *)mte_allocate_memory_tag_range(sizes[i], mem_type, 0,
 							    0, overflow_range);
@@ -338,7 +338,7 @@ static int check_buffer_by_block(int mem_type, int mode)
 	int i, item, result = KSFT_PASS;
 
 	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
-	item = sizeof(sizes)/sizeof(int);
+	item = ARRAY_SIZE(sizes);
 	cur_mte_cxt.fault_valid = false;
 	for (i = 0; i < item; i++) {
 		result = check_buffer_by_block_iterate(mem_type, mode, sizes[i]);
@@ -366,7 +366,7 @@ static int check_memory_initial_tags(int mem_type, int mode, int mapping)
 {
 	char *ptr;
 	int run, fd;
-	int total = sizeof(sizes)/sizeof(int);
+	int total = ARRAY_SIZE(sizes);
 
 	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
 	for (run = 0; run < total; run++) {
@@ -404,7 +404,7 @@ int main(int argc, char *argv[])
 {
 	int err;
 	size_t page_size = getpagesize();
-	int item = sizeof(sizes)/sizeof(int);
+	int item = ARRAY_SIZE(sizes);
 
 	sizes[item - 3] = page_size - 1;
 	sizes[item - 2] = page_size;
-- 
2.34.1

