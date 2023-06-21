Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A1C73898F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 17:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjFUPg6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 11:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjFUPgq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 11:36:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D7EDC;
        Wed, 21 Jun 2023 08:36:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-988a076a7d3so535675066b.3;
        Wed, 21 Jun 2023 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687361758; x=1689953758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEOIwynIIsT/3TCYBn4hnrnBW3FX88KHSnE+980PXNU=;
        b=LeFLd/T5OM7aszQ1BHpFd0lDMx5q3DtKYmanSZjPYSO9vh9puF3ky8Fx90y7g5rbL/
         ZQesZAiEn4lr2smBWWC3dAzUstEMURZ+QSShkPF6FjFpZf/FHZ6X5GDVlslXIdQUxLfl
         KgT1BGP5eERxBDUn+DMzi4Tlv13Y8MqVVVbZC09Ve8oTJI9eLkqyqNPNCyWrHxApZj8y
         kgAL6n5oXWw5LVHF0E2lo2tQn6ylvgXV1O/8dxzLIbQXAwYVD8MQIDmxcYIi3A8Ys9nb
         PyPHQzQAr0tJmcixMtaFbr5pJDcFTYhJpajQz2ErIoQ/MpRwnd5ayZQRzSobig5ls2OW
         usAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361758; x=1689953758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEOIwynIIsT/3TCYBn4hnrnBW3FX88KHSnE+980PXNU=;
        b=Nq6UvMSc2h9ZMgoCU/lyL1wQqTJXU1f8QmX68URwVe3i1Txi/6/fvRq/AeMyHj+wCk
         j2DFSKJal8tCdYiV3NwaJB1yynaP3cVMEEG0ARdr01klWDB/O/hTYmfFr6LCOjvE9kZW
         w+8djj5ADnAAPdZswWOjuEv0xbWXCoFOI/qar962zu6+IHkwOayKTlhCZvXf10o/aQ7x
         V08kO/vXRED1+zQTxsC+MHmt6uHy/AnQM7OdppHShqJB9gKNSRBqMYd87KpARWirwX0w
         8861mnJJmxPzFb0KKmpxthk7uTmlfAmzS+N3ZTRRuwER/HX0+/sI6QpsyTAfwdNgZfa3
         DssQ==
X-Gm-Message-State: AC+VfDxuRQ+QAcdbNJ+hlk+JHRCm6FRKprdC34JO0LTs0J4PHapspJAC
        X1izMPGtyjv99POAioNKjMM=
X-Google-Smtp-Source: ACHHUZ6LtQ54cpRJgPi63hwfFLmdfXyweGSwpI6QswRtM85cslXGPokHfEWfw78YVyg9TcydvP83tg==
X-Received: by 2002:a17:907:2d28:b0:96a:3e39:f567 with SMTP id gs40-20020a1709072d2800b0096a3e39f567mr17431248ejc.47.1687361758375;
        Wed, 21 Jun 2023 08:35:58 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-87-21-158-222.retail.telecomitalia.it. [87.21.158.222])
        by smtp.gmail.com with ESMTPSA id r3-20020a170906c28300b00988acf24f9csm3266123ejz.97.2023.06.21.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:35:57 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        shuah@kernel.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, riel@surriel.com,
        nphamcs@gmail.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH 3/3] selftests: cgroup: add zswap-memcg unwanted writeback test
Date:   Wed, 21 Jun 2023 17:35:48 +0200
Message-Id: <20230621153548.428093-4-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621153548.428093-1-cerasuolodomenico@gmail.com>
References: <20230621153548.428093-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test to verify that when a memcg hits its limit in zswap, it
doesn't trigger an unwanted writeback that would result in pages not
owned by that memcg to be sent to disk, even if zswap isn't full.
This was fixed by commit 0bdf0efa180a("zswap: do not shrink if cgroup
may not zswap").

Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 61 +++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index e859fecd310b..49def87a909b 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -50,6 +50,66 @@ static int get_zswap_stored_pages(size_t *value)
 	return read_int("/sys/kernel/debug/zswap/stored_pages", value);
 }
 
+static int get_zswap_written_back_pages(size_t *value)
+{
+	return read_int("/sys/kernel/debug/zswap/written_back_pages", value);
+}
+
+static int allocate_bytes(const char *cgroup, void *arg)
+{
+	size_t size = (size_t)arg;
+	char *mem = (char *)malloc(size);
+
+	if (!mem)
+		return -1;
+	for (int i = 0; i < size; i += 4095)
+		mem[i] = 'a';
+	free(mem);
+	return 0;
+}
+
+/*
+ * When trying to store a memcg page in zswap, if the memcg hits its memory
+ * limit in zswap, writeback should not be triggered.
+ *
+ * This was fixed with commit 0bdf0efa180a("zswap: do not shrink if cgroup may
+ * not zswap"). Needs to be revised when a per memcg writeback mechanism is
+ * implemented.
+ */
+static int test_no_invasive_cgroup_shrink(const char *root)
+{
+	size_t written_back_before, written_back_after;
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
+	if (cg_write(test_group, "memory.zswap.max", "10K"))
+		goto out;
+	if (get_zswap_written_back_pages(&written_back_before))
+		goto out;
+
+	/* Allocate 10x memory.max to push memory into zswap */
+	if (cg_run(test_group, allocate_bytes, (void *)MB(10)))
+		goto out;
+
+	/* Verify that no writeback happened because of the memcg allocation */
+	if (get_zswap_written_back_pages(&written_back_after))
+		goto out;
+	if (written_back_after == written_back_before)
+		ret = KSFT_PASS;
+out:
+	cg_destroy(test_group);
+	free(test_group);
+	return ret;
+}
+
 struct no_kmem_bypass_child_args {
 	size_t target_alloc_bytes;
 	size_t child_allocated;
@@ -176,6 +236,7 @@ struct zswap_test {
 	const char *name;
 } tests[] = {
 	T(test_no_kmem_bypass),
+	T(test_no_invasive_cgroup_shrink),
 };
 #undef T
 
-- 
2.34.1

