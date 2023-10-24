Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BC47D5C7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 22:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344349AbjJXUdO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 16:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344312AbjJXUdL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 16:33:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A44E8;
        Tue, 24 Oct 2023 13:33:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5ab94fc098cso2949983a12.1;
        Tue, 24 Oct 2023 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698179589; x=1698784389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQKZ6uKAgGpieDKxwUlilWEMw/a+RaeqsurH8iiKhxA=;
        b=HjsiBt+oe/JIjYANIgipf1L3XjhrzeRwZWUKzRsdduyUF6dVr7rAopzpI5DyU70+aG
         Mq7rihOB7XCXjv8Drrfl6e3dFA6O6OjzDyFEccvqCai+EjaVfp8ekRTdWfCownDdrWSu
         pF717bgH+TcZtcN421F9ibh+YsEC4oJlYgyOk2djOsd8FzwFhuS5TI8WIYdLYJU3qKKs
         iPZ7kBHg6lje71nj8zdYTI99v9rEU1LTeLeGEQoQrkhWcgCt/JVqg9vaqZUYeZrh6ldR
         BUVrbJCLanY6HdezgId3shCqYdbmJ05OkCzq1q83o6JYtcDAwekhrQy/kRU95ItIrZkK
         IbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698179589; x=1698784389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQKZ6uKAgGpieDKxwUlilWEMw/a+RaeqsurH8iiKhxA=;
        b=A3B2wWIxJouevo1MenboD/9A3MnrKUWcZHl6ioB5zfhPDP72J0+IjkznTOvfCJlHeN
         4lslmp1tvcxRIpunTGmqV1cUvyV7PFizPdqiepLnqd6Zj1fzm+F3tzgRau1pSKrboSaF
         pz72xLIBnTf8PTPzFiBMYUWi+ldEHuN5nUz9xXk5JuZ5xbPwRnIfX1ui29lBc6V7f1tk
         H66GIgn8b7MUzFE+XMW98/YzaJMXpkYwi6gkF15h7etUPoTLhit6ltXjzSWRiOYNBjaB
         o+QcYwKhXxm/wrJNlHo3u0fbbEHve0mhIfa6+78X5/crqWqbwY2+9DCpcY5+JaeGYujh
         tsug==
X-Gm-Message-State: AOJu0Yx+REN6xYHqryg6F6V7x+uN9pd1+UtkAp2DVRuUuj4wIp3Z1h4g
        vPLEiakc/iXpKeuzNr7FVYw=
X-Google-Smtp-Source: AGHT+IEdh6gJU1X2/iVdLS5lJvKFyVc7ZJw1XUoLtyNLtcPrs2JkBuF22gxZi/yRwglO2Q8TK15BXA==
X-Received: by 2002:a17:90b:35c2:b0:27d:6d9c:6959 with SMTP id nb2-20020a17090b35c200b0027d6d9c6959mr10606621pjb.25.1698179588924;
        Tue, 24 Oct 2023 13:33:08 -0700 (PDT)
Received: from localhost (fwdproxy-prn-119.fbsv.net. [2a03:2880:ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a7e8d00b0026d4100e0e8sm7201098pjl.10.2023.10.24.13.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 13:33:08 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: [PATCH v4 4/5] selftests: cgroup: update per-memcg zswap writeback selftest
Date:   Tue, 24 Oct 2023 13:33:01 -0700
Message-Id: <20231024203302.1920362-5-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024203302.1920362-1-nphamcs@gmail.com>
References: <20231024203302.1920362-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

The memcg-zswap self test is updated to adjust to the behavior change
implemented by commit 87730b165089 ("zswap: make shrinking memcg-aware"),
where zswap performs writeback for specific memcg.

Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 74 ++++++++++++++-------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 49def87a909b..753a3b9de1ad 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -50,9 +50,9 @@ static int get_zswap_stored_pages(size_t *value)
 	return read_int("/sys/kernel/debug/zswap/stored_pages", value);
 }
 
-static int get_zswap_written_back_pages(size_t *value)
+static int get_cg_wb_count(const char *cg)
 {
-	return read_int("/sys/kernel/debug/zswap/written_back_pages", value);
+	return cg_read_key_long(cg, "memory.stat", "zswp_wb");
 }
 
 static int allocate_bytes(const char *cgroup, void *arg)
@@ -68,45 +68,71 @@ static int allocate_bytes(const char *cgroup, void *arg)
 	return 0;
 }
 
+static char *setup_test_group_1M(const char *root, const char *name)
+{
+	char *group_name = cg_name(root, name);
+
+	if (!group_name)
+		return NULL;
+	if (cg_create(group_name))
+		goto fail;
+	if (cg_write(group_name, "memory.max", "1M")) {
+		cg_destroy(group_name);
+		goto fail;
+	}
+	return group_name;
+fail:
+	free(group_name);
+	return NULL;
+}
+
 /*
  * When trying to store a memcg page in zswap, if the memcg hits its memory
- * limit in zswap, writeback should not be triggered.
- *
- * This was fixed with commit 0bdf0efa180a("zswap: do not shrink if cgroup may
- * not zswap"). Needs to be revised when a per memcg writeback mechanism is
- * implemented.
+ * limit in zswap, writeback should affect only the zswapped pages of that
+ * memcg.
  */
 static int test_no_invasive_cgroup_shrink(const char *root)
 {
-	size_t written_back_before, written_back_after;
 	int ret = KSFT_FAIL;
-	char *test_group;
+	size_t control_allocation_size = MB(10);
+	char *control_allocation, *wb_group = NULL, *control_group = NULL;
 
 	/* Set up */
-	test_group = cg_name(root, "no_shrink_test");
-	if (!test_group)
-		goto out;
-	if (cg_create(test_group))
+	wb_group = setup_test_group_1M(root, "per_memcg_wb_test1");
+	if (!wb_group)
+		return KSFT_FAIL;
+	if (cg_write(wb_group, "memory.zswap.max", "10K"))
 		goto out;
-	if (cg_write(test_group, "memory.max", "1M"))
+	control_group = setup_test_group_1M(root, "per_memcg_wb_test2");
+	if (!control_group)
 		goto out;
-	if (cg_write(test_group, "memory.zswap.max", "10K"))
+
+	/* Push some test_group2 memory into zswap */
+	if (cg_enter_current(control_group))
 		goto out;
-	if (get_zswap_written_back_pages(&written_back_before))
+	control_allocation = malloc(control_allocation_size);
+	for (int i = 0; i < control_allocation_size; i += 4095)
+		control_allocation[i] = 'a';
+	if (cg_read_key_long(control_group, "memory.stat", "zswapped") < 1)
 		goto out;
 
-	/* Allocate 10x memory.max to push memory into zswap */
-	if (cg_run(test_group, allocate_bytes, (void *)MB(10)))
+	/* Allocate 10x memory.max to push wb_group memory into zswap and trigger wb */
+	if (cg_run(wb_group, allocate_bytes, (void *)MB(10)))
 		goto out;
 
-	/* Verify that no writeback happened because of the memcg allocation */
-	if (get_zswap_written_back_pages(&written_back_after))
-		goto out;
-	if (written_back_after == written_back_before)
+	/* Verify that only zswapped memory from gwb_group has been written back */
+	if (get_cg_wb_count(wb_group) > 0 && get_cg_wb_count(control_group) == 0)
 		ret = KSFT_PASS;
 out:
-	cg_destroy(test_group);
-	free(test_group);
+	cg_enter_current(root);
+	if (control_group) {
+		cg_destroy(control_group);
+		free(control_group);
+	}
+	cg_destroy(wb_group);
+	free(wb_group);
+	if (control_allocation)
+		free(control_allocation);
 	return ret;
 }
 
-- 
2.34.1
