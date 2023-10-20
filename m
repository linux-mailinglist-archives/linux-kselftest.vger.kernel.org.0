Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9127D1900
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Oct 2023 00:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjJTWUN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 18:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJTWUM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 18:20:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC931FA;
        Fri, 20 Oct 2023 15:20:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so1215213b3a.3;
        Fri, 20 Oct 2023 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697840410; x=1698445210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1EeBCEVO9LxbVa6WaU7VSYBs+wBD9B64Uc+nZwPxkVM=;
        b=jtJgRmqRI099rYVDuO22gC9JWgf3RBMof1ocGLbzMoqCvpMPDKbyzUq8jB61M3kJZL
         KoKPdpF7BE+PoX+g9Y4Fwwmy1mGLKwUOlKNGcBWVNM8f0zKydF1K0lT2WQhfDXCB+lf6
         kPFyw+rD0kcPlqZX5HL3aVvvQGts65NEh75gYAO4fk/eW1BdP7qtXCEBslAXmvH1x7E8
         IpQzxA8yt2/Xz2SyFf0s6whbC+srHHH5Z6/cFFhA7emTaGpu5UfznjIUfjc7oFJjLM8j
         /6ZdnI///1py+7PtUyhpqczTAzsxJ5AVRDpkA96Fm8XxuPTVVvrLkaKbGmLaRDdFjV/f
         Nsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697840410; x=1698445210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EeBCEVO9LxbVa6WaU7VSYBs+wBD9B64Uc+nZwPxkVM=;
        b=OrnR+HbU6vqXLb4n0AvsBxGqC4M84na805u4dKQa59c5S6ttO2WRyDWclgX746u8BJ
         l9M3YI3tlROsfUho0NvA4mLJ2qE6uURGUN49ycEQE3VIAFGlIDgQG5vMQvZtoB81/dRP
         GRTKwChazPehZq2rXjBB334fdDTrPB8uIfJkfpfb8Untk9dGUGaLlZiG73CnN8rZHDQX
         2mC5h6aufnX1igiW53SxrcG83+bkQa3Nefk23SWZmS2ycZX/mph7JZFr7XMiH6n2ScIr
         OgfozYV8bRHEprImITNJURrSPShDt2NErESd6eKrOfi6BiagG/8GDDaKoMeD8igObtOR
         Ldcw==
X-Gm-Message-State: AOJu0YygfB5FvSFJFovuE4iDTMdVU1BbxcKOndX/XeDlXuCA7Vd9muXo
        k4cKxtDi+br7+3XTShqiz7Y=
X-Google-Smtp-Source: AGHT+IECXhrANA0QgW4lL0jF6pcm/XmBaXcujdog1r7b1mT3+gIIldlT9Fee7TiRI8hSTb0nqBkZTQ==
X-Received: by 2002:a05:6a21:3b45:b0:16b:7602:1837 with SMTP id zy5-20020a056a213b4500b0016b76021837mr2842010pzb.29.1697840410254;
        Fri, 20 Oct 2023 15:20:10 -0700 (PDT)
Received: from localhost (fwdproxy-prn-015.fbsv.net. [2a03:2880:ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id f20-20020a056a001ad400b006b2677d3684sm2028041pfv.206.2023.10.20.15.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 15:20:10 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     shuah@kernel.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com, tj@kernel.org,
        lizefan.x@bytedance.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: add a sanity check for zswap
Date:   Fri, 20 Oct 2023 15:20:09 -0700
Message-Id: <20231020222009.2358953-1-nphamcs@gmail.com>
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

We recently encountered a bug that makes all zswap store attempt fail.
Specifically, after:

"141fdeececb3 mm/zswap: delay the initialization of zswap"

if we build a kernel with zswap disabled by default, then enabled after
the swapfile is set up, the zswap tree will not be initialized. As a
result, all zswap store calls will be short-circuited. We have to
perform another swapon to get zswap working properly again.

Fortunately, this issue has since been fixed by the patch that kills
frontswap:

"42c06a0e8ebe mm: kill frontswap"

which performs zswap_swapon() unconditionally, i.e always initializing
the zswap tree.

This test add a sanity check that ensure zswap storing works as
intended.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 48 +++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 49def87a909b..c99d2adaca3f 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -55,6 +55,11 @@ static int get_zswap_written_back_pages(size_t *value)
 	return read_int("/sys/kernel/debug/zswap/written_back_pages", value);
 }
 
+static long get_zswpout(const char *cgroup)
+{
+	return cg_read_key_long(cgroup, "memory.stat", "zswpout ");
+}
+
 static int allocate_bytes(const char *cgroup, void *arg)
 {
 	size_t size = (size_t)arg;
@@ -68,6 +73,48 @@ static int allocate_bytes(const char *cgroup, void *arg)
 	return 0;
 }
 
+/*
+ * Sanity test to check that pages are written into zswap.
+ */
+static int test_zswap_usage(const char *root)
+{
+	long zswpout_before, zswpout_after;
+	int ret = KSFT_FAIL;
+	char *test_group;
+
+	/* Set up */
+	test_group = cg_name(root, "no_shrink_test");
+	if (!test_group)
+		goto out;
+	if (cg_create(test_group))
+		goto out;
+	if (cg_write(test_group, "memory.max", "1M"))
+		goto out;
+
+	zswpout_before = get_zswpout(test_group);
+	if (zswpout_before < 0) {
+		ksft_print_msg("Failed to get zswpout\n");
+		goto out;
+	}
+
+	/* Allocate more than memory.max to push memory into zswap */
+	if (cg_run(test_group, allocate_bytes, (void *)MB(4)))
+		goto out;
+
+	/* Verify that pages come into zswap */
+	zswpout_after = get_zswpout(test_group);
+	if (zswpout_after <= zswpout_before) {
+		ksft_print_msg("zswpout does not increase after test program\n");
+		goto out;
+	}
+	ret = KSFT_PASS;
+
+out:
+	cg_destroy(test_group);
+	free(test_group);
+	return ret;
+}
+
 /*
  * When trying to store a memcg page in zswap, if the memcg hits its memory
  * limit in zswap, writeback should not be triggered.
@@ -235,6 +282,7 @@ struct zswap_test {
 	int (*fn)(const char *root);
 	const char *name;
 } tests[] = {
+	T(test_zswap_usage),
 	T(test_no_kmem_bypass),
 	T(test_no_invasive_cgroup_shrink),
 };
-- 
2.34.1

