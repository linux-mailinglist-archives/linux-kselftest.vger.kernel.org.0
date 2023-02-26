Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5D16A2FC7
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Feb 2023 14:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBZNRG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Feb 2023 08:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBZNRF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Feb 2023 08:17:05 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CEE113F7;
        Sun, 26 Feb 2023 05:17:02 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ee7so15402330edb.2;
        Sun, 26 Feb 2023 05:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677417420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4MQkzTFY7oFLk7HS5mTlDP6H3MWtlVl305nioGoqUIs=;
        b=Cw96/L1RHzMm7Iwoev/iq9NQQD4j4GnUH9LI9hf0FsI7wpXOyF7SPk8t4sj26swyzx
         NoiuVoyttuLYzz6AkKaKAxzFsgN9YUejX+v/ekVf8Lt3h7MJYwNVH1SqG2XSo8NYCdlg
         OtUI1WZf2hD8ndAhpOM+BAOjCp10hXvhXrVmiwWsI7LnC3kwhrcVfsTa/u9vbkTGukNL
         Htl/vGkWLNa/aPzZOaw1WBlsiOeVy5wJ9T0+Tr+uWMisrEBBZ5Wqwfr6tsnjga9Los6O
         x4PJoNWIOeFMjvXEP+/GvphKdLQcqlNsifDVayI5uePvFO70xyMmJC2L/mb0Wagx6bHh
         vIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677417420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MQkzTFY7oFLk7HS5mTlDP6H3MWtlVl305nioGoqUIs=;
        b=SGc61OiA+fADQzJvNS0UwPPWkBj1SrwC+eMEj2xD+Afd8cxcJKEAmw7P1WfA2itEPF
         GYf5tALIqmTfdB97W64hwtFwb+Z9Dng+0oaO5WiRyosd23byP56t4H2qTSj5dl4s61gJ
         z2xzTOls2Ezgc0skc2t5vnJf9jrRIf+9Ue3qh1g6850kkXjmsfzMOeA/978njWnsqABi
         yIOj01yqhxHx+5IjQLPkG1Xq5StvQz6Aqc2pxNT1nZ0/O6AUSvdo/FZIKWxoagXzumSd
         3aTPpvq8SpcVV/7eTT6BnMb3mhePmnDJHFFAaLw/XmLmav4E+mvQ+EgGs09ORVDF4xB0
         AoaA==
X-Gm-Message-State: AO0yUKWmhmNcg4O25e0MEuEhuAWXuPFqpHIzUdxTqj5ZZfk7mVjhGohc
        IeR5OFfA06W/3EIwy7DbM2w=
X-Google-Smtp-Source: AK7set+eUagH/xey6K9nUkb+yayfzAZAtxqqWU//2CxFZ/bP4zU9yXjY1lC0f4dAaOA0Pe2LN2C+/A==
X-Received: by 2002:a17:906:256:b0:882:bffc:f2d2 with SMTP id 22-20020a170906025600b00882bffcf2d2mr30458808ejl.2.1677417420590;
        Sun, 26 Feb 2023 05:17:00 -0800 (PST)
Received: from mineorpe-virtual-machine.localdomain ([37.252.81.68])
        by smtp.gmail.com with ESMTPSA id bq7-20020a170906d0c700b008c5075f5331sm1957965ejb.165.2023.02.26.05.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 05:17:00 -0800 (PST)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev, tj@kernel.org,
        lizefan.x@bytedance.com, shuah@kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: [PATCH] selftests: cgroup: Add 'malloc' failures checks in test_memcontrol
Date:   Sun, 26 Feb 2023 16:16:33 +0300
Message-Id: <20230226131634.34366-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are several 'malloc' calls in test_memcontrol, which can be
unsuccessful. This patch will add 'malloc' failures checking to
give more details about test's fail reasons and avoid possible
undefined behavior during the future null dereference (like the
one in alloc_anon_50M_check_swap function).

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 1e616a8c6a9c..f4f7c0aef702 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -98,6 +98,11 @@ static int alloc_anon_50M_check(const char *cgroup, void *arg)
 	int ret = -1;
 
 	buf = malloc(size);
+	if (buf == NULL) {
+		fprintf(stderr, "malloc() failed\n");
+		return -1;
+	}
+
 	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
 		*ptr = 0;
 
@@ -211,6 +216,11 @@ static int alloc_anon_noexit(const char *cgroup, void *arg)
 	char *buf, *ptr;
 
 	buf = malloc(size);
+	if (buf == NULL) {
+		fprintf(stderr, "malloc() failed\n");
+		return -1;
+	}
+
 	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
 		*ptr = 0;
 
@@ -778,6 +788,11 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
 	int ret = -1;
 
 	buf = malloc(size);
+	if (buf == NULL) {
+		fprintf(stderr, "malloc() failed\n");
+		return -1;
+	}
+
 	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
 		*ptr = 0;
 
-- 
2.34.1

