Return-Path: <linux-kselftest+bounces-681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DBA7FAE9B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 00:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7104A28167A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 23:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660D949F99;
	Mon, 27 Nov 2023 23:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WospnarM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3EBD4D;
	Mon, 27 Nov 2023 15:46:06 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc9b626a96so36245565ad.2;
        Mon, 27 Nov 2023 15:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701128766; x=1701733566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpgmz+lE50DZaA/oBKT5EnJWyAwPJO9gmArvQZM8Xwo=;
        b=WospnarMH3s7gP4jnTAcqFmb9elrS9WMCLt5UyLSG7l8UFBGsachNOuOeFiUiHgyOd
         ffdVV57l8ekFlblhtbj24xwIZlgmsstURHWxJXNXJ67jqg65yusHWJnW6QT1dojLvdOb
         O4jmCEJJNnnZVZx/4un5vA2k1IBr4jkOIIFWnkZCd3xIGr5QPoNhhdVoeuuyDx+Uv1GS
         nRLYTh0XY0LmpcqKlVLBXX2cS63cmsRy3fbiXZ0I8bAB+btFSCj3zs1nqdqYa1iC8hAr
         BUOpZJxAD6CJoH9/zEzrDCfN6oUVAdR9+JFxI9opxqqRdAhX/jEgqb+KuPpKebqAt0jM
         r1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701128766; x=1701733566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpgmz+lE50DZaA/oBKT5EnJWyAwPJO9gmArvQZM8Xwo=;
        b=j6L8xZ/ztwJcWPlxDTrXBQqJ1ETxQjMzy3Eu4q9bhWQE+vw5/qzVTWIEdaWFaEfucK
         rw/qh/7p/zn+dOvH29CFUh/7XkMmXAdxPhxjnaZ53vPUEkobSa6HeSuwtU6nB4y6RPfi
         hvYx7H66L+QtdBaUHTo3mMSVDWyOpJKEENtn90V1cXCk6iQdfikiCAOIGomWC8PPnkEp
         NIeM+mrzcOXf9QTuFosH20djuKWP+yUsCNWT38pnSlqTBq9lvSvbOeSL/86oCSMFQh/x
         ZdjEEC33isD2g+6ON8Kny430ilUSq0gm2HgGljpAzSvXSlPBtOUoVx5kJCs4Kglck9fU
         Ih/w==
X-Gm-Message-State: AOJu0YybwPghOYMppq6wkqJkN5t0Q61/0Qia3uQWDiBVgq7qctyvjeca
	Fu5XiZlH9moSNJ92HHBipF0=
X-Google-Smtp-Source: AGHT+IGu6efuRIiSCPKCUDwRobB76N4xJJlnLFjZnsosc5Yzt4lkGdloLxXAga7HCdsLQ7YjiKz6pw==
X-Received: by 2002:a17:902:c411:b0:1cf:a0b1:ec06 with SMTP id k17-20020a170902c41100b001cfa0b1ec06mr15743491plk.55.1701128766074;
        Mon, 27 Nov 2023 15:46:06 -0800 (PST)
Received: from localhost (fwdproxy-prn-011.fbsv.net. [2a03:2880:ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902c1cc00b001cf96a0e4e6sm8166994plc.242.2023.11.27.15.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 15:46:05 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	cerasuolodomenico@gmail.com,
	yosryahmed@google.com,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	chrisl@kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH v7 5/6] selftests: cgroup: update per-memcg zswap writeback selftest
Date: Mon, 27 Nov 2023 15:45:59 -0800
Message-Id: <20231127234600.2971029-6-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127234600.2971029-1-nphamcs@gmail.com>
References: <20231127234600.2971029-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index c99d2adaca3f..47fdaa146443 100644
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
 
 static long get_zswpout(const char *cgroup)
@@ -73,6 +73,24 @@ static int allocate_bytes(const char *cgroup, void *arg)
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
  * Sanity test to check that pages are written into zswap.
  */
@@ -117,43 +135,51 @@ static int test_zswap_usage(const char *root)
 
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

