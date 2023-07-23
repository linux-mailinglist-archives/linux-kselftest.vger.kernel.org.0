Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B838475E0FC
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jul 2023 11:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjGWJij (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Jul 2023 05:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGWJii (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Jul 2023 05:38:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C655E67;
        Sun, 23 Jul 2023 02:38:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3174aac120aso392942f8f.2;
        Sun, 23 Jul 2023 02:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690105116; x=1690709916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oxNqVJ8M0RlStNJiqmdGBEdZEF6FgJ1pvu+FzFr7WF0=;
        b=FYJY+Bnur9aWsu4JUe2QcktPfX1ZzMT7ckqyKMJjd1FsziSSoGOxn7tMu0APZfH0Yc
         LqMCRiBaRJGPUuoJiWt9BOQdwz7fEHapRbLkQIpw9dq8bvJI03LVa80Ir8R2KCnnbGPi
         Gqs78Hc9HX2pHoStqBZHbnRRoYAbMLukkM88Bz+++peQC5xRWxYWZUGwXIVZHdIjzUip
         emvyfzWkkIuArKz7ae6X1L0xZ7+fHpiJi8Nc0hEApqibuoXtE5NhGJ6ZBiUOGNSoBDTs
         jjaVXyenoxODBkRjpLTcbru/9k1YWKSKxfvJj/53v9GBiTUk1KIjBbng/e8ROP4bOla4
         Pefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690105116; x=1690709916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxNqVJ8M0RlStNJiqmdGBEdZEF6FgJ1pvu+FzFr7WF0=;
        b=COi/Ioyh3RiEKkEDeg6N54t43tHTsDsuhdLqoulB/2E723lV1sSGmYtgujQpFu9xef
         6manY864kU28jrZXz5a69PFvW5wOz8YzdOKK8YUKgXyGxp5aFTFiOGV/K1CieoK1ARbN
         mf4z9wWz3gkYUPs6+XgZHpLQYn3aBGH2tz1bHWEPrHKRjO3yzH9U2aixQqFi8tBDuF+a
         hyak5jgbeXorLmNxhqDmPl1Uyn+7VuIDCwy/soEVU17Jekqj3KeG0jdQlzfmkLdEMFEJ
         YxIxp+tntmjPdJ7jYPVLlXch1jX49jg+ABedOpQOQam6GEpz1uOA/6sHD+jHptdRReNt
         Q88g==
X-Gm-Message-State: ABy/qLbnrpVHwPijR8ezLOgKT+xjB559UvIcZ284PHuycQXB8kzRF/gl
        ir8lJSxgca+o0IsMvAojWSE=
X-Google-Smtp-Source: APBJJlHEoHQAlhF6vEArYxkf108SJhFb8RJ0pr+GGHx6NyP863uApYvVhr8KpOvpDqncDS8OfFbWMw==
X-Received: by 2002:a5d:61c5:0:b0:30f:af19:81f3 with SMTP id q5-20020a5d61c5000000b0030faf1981f3mr4621201wrv.41.1690105115424;
        Sun, 23 Jul 2023 02:38:35 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx.. ([2001:8f8:1163:535c:ce7:4d43:f827:e4e8])
        by smtp.gmail.com with ESMTPSA id r5-20020adff105000000b003145521f4e5sm9186373wro.116.2023.07.23.02.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 02:38:34 -0700 (PDT)
From:   Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Subject: [PATCH] selftests/bpf: fix build errors if CONFIG_NF_CONNTRACK_MARK not set.
Date:   Sun, 23 Jul 2023 13:38:06 +0400
Message-Id: <20230723093806.2850822-1-mahmoudmatook.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
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

'mark' member in 'struct nf_conn' is conditionally defined
 by CONFIG_NF_CONNTRACK_MARK
 so any reference to it should follow the same.

 $ make -C tools/testing/selftests/bpf
	progs/test_bpf_nf.c:219:12: error: no member named 'mark' in 'struct nf_conn'
	                        if (ct->mark == 42) {
	                            ~~  ^
	progs/test_bpf_nf.c:220:9: error: no member named 'mark' in 'struct nf_conn'
	                                ct->mark++;
	                                ~~  ^
	progs/test_bpf_nf.c:221:34: error: no member named 'mark' in 'struct nf_conn'
                                test_exist_lookup_mark = ct->mark;

Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
---
 .../testing/selftests/bpf/progs/test_bpf_nf.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 77ad8adf68da..0b285de8b7e7 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -157,7 +157,10 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 		struct nf_conn *ct_ins;
 
 		bpf_ct_set_timeout(ct, 10000);
-		ct->mark = 77;
+		#if defined(CONFIG_NF_CONNTRACK_MARK)
+			ct->mark = 77;
+		#endif
+
 
 		/* snat */
 		saddr.ip = bpf_get_prandom_u32();
@@ -188,7 +191,9 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 				bpf_ct_change_timeout(ct_lk, 10000);
 				test_delta_timeout = ct_lk->timeout - bpf_jiffies64();
 				test_delta_timeout /= CONFIG_HZ;
-				test_insert_lookup_mark = ct_lk->mark;
+				#if defined(CONFIG_NF_CONNTRACK_MARK)
+					test_insert_lookup_mark = ct_lk->mark;
+				#endif
 				bpf_ct_change_status(ct_lk,
 						     IPS_CONFIRMED | IPS_SEEN_REPLY);
 				test_status = ct_lk->status;
@@ -210,10 +215,12 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 		       sizeof(opts_def));
 	if (ct) {
 		test_exist_lookup = 0;
-		if (ct->mark == 42) {
-			ct->mark++;
-			test_exist_lookup_mark = ct->mark;
-		}
+		#if defined(CONFIG_NF_CONNTRACK_MARK)
+			if (ct->mark == 42) {
+				ct->mark++;
+				test_exist_lookup_mark = ct->mark;
+			}
+		#endif
 		bpf_ct_release(ct);
 	} else {
 		test_exist_lookup = opts_def.error;
-- 
2.34.1

