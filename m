Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1FD7E2BFD
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 19:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjKFScS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 13:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjKFScJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 13:32:09 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7ABD47;
        Mon,  6 Nov 2023 10:32:06 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5aaebfac4b0so3175149a12.2;
        Mon, 06 Nov 2023 10:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699295525; x=1699900325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQKZ6uKAgGpieDKxwUlilWEMw/a+RaeqsurH8iiKhxA=;
        b=MQ3iJp7Xeqn3PN6RfzQYK5RPtfpgfaxLNvibFQyxjKHzPzFuKJeB+Xsnzwr28m3pCL
         C2vevFV1UTzqgzCRCdHzuvSmReF19EN+L8/mE9ugV5rB39wky86laYPaiXxXY3OXawSR
         GQLP5+9oTS3VAzfYneNOtLQxJl580694ZPVi538xrv23RHCYrXFcjNSPtBR98ksAJVCa
         i0bA0Lk0k1HKMotFqSf76haa9dbPrKAM76iFjmtXYJJS/84zZtU7+UCl3q4QR9xYuRAF
         qULO0cZbtCuGKrjv8Oa0+h4roM1/iNn86CfSFRqO2jp+8S2U3yy3sQ89UuxasIdg7bZM
         ge3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699295525; x=1699900325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQKZ6uKAgGpieDKxwUlilWEMw/a+RaeqsurH8iiKhxA=;
        b=kIRFiw7Yq/wcgMb9ReklR5rpkGhyeRY8BvfR8HblfS5l/Kli6Q2e/FiEwt+X0HuHXL
         U/BjD7B5sA+Bj1R1ZFRX4sAQG4BzG3sIZHXNSFajBjJVkLl/Hs9ArTcm3n4tEXp0349B
         Uv3tZwEabNppT1fOoBpt03mH0gHDxBQULQ2Mtq7dT82KF7dz9BnCKXDH9+oV+N8kWkfQ
         SFfD3Xgz020M5Is1Z1KZr1znAd8tlsnPNUy5wf5PKzG9XSdhPP8bPn5CixQpZ/0zme0p
         QCcpp9lndZAeLtbFZ1UJM23KGxTipvZ3zz0wceGsiC3Z8l5MXRY+ZcNXad+Havv44ooJ
         8THg==
X-Gm-Message-State: AOJu0YwwBDKkdjWn9k9+p/PrOcdactK5BHhGJS1ZPLF1tf2PNcteKEEy
        o4Jh2ywF4Z3GLvCY4Hiptso=
X-Google-Smtp-Source: AGHT+IE3472nXfqmh8O2FIqo+TXEJJPgsaUljC9xCLaQyRQ4pk9qek0sRUdOVNhr8wM4dIBARewIvQ==
X-Received: by 2002:a05:6a20:7487:b0:15e:b8a1:57b0 with SMTP id p7-20020a056a20748700b0015eb8a157b0mr25302832pzd.39.1699295525583;
        Mon, 06 Nov 2023 10:32:05 -0800 (PST)
Received: from localhost (fwdproxy-prn-007.fbsv.net. [2a03:2880:ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id r17-20020a62e411000000b006bc189378a7sm5859887pfh.196.2023.11.06.10.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:32:05 -0800 (PST)
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
Subject: [PATCH v5 5/6] selftests: cgroup: update per-memcg zswap writeback selftest
Date:   Mon,  6 Nov 2023 10:31:58 -0800
Message-Id: <20231106183159.3562879-6-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106183159.3562879-1-nphamcs@gmail.com>
References: <20231106183159.3562879-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
