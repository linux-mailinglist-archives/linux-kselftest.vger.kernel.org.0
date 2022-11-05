Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85AF61A70C
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Nov 2022 03:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKECwe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 22:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKECwc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 22:52:32 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730D33FB8E
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Nov 2022 19:52:30 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 8so4453930qka.1
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Nov 2022 19:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=102zPobI2UCzZFYJfQ6W0YbWDm+eTOkX0gf/oCnQz2U=;
        b=BhkDD2m+dHxDTTE8PUg8n+8FDifwARJY/czahSUEz9t0qC/XYnI6eDSQvxa7uhHeGv
         l08NeotC1Xn9p98wFICv+UbKcRVQYXoIhe0yXVc0GWVq9rH7+pkF+jj1pIS7Hyd45Br2
         3AQVwp/IB+SHvc+DhyFoH6lYq9HLAJIdT3/l96XmNmNmjusI9QuDKQj5kgDMOGfNHRM/
         6zL1O6bIOT2BnuZlVOhF1QyL0ZUpUs548iOfJWCDFE2zkoMVk9UXe2e6PMyGUvsEmzOJ
         yLKcRsOtw8NQfbgdQu5Ky4+h8EUjMm1hFDA7AUIanfg7gG+4tmQn65gWEb9jaSpN983A
         J/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=102zPobI2UCzZFYJfQ6W0YbWDm+eTOkX0gf/oCnQz2U=;
        b=mrlm+v1iCJo8564Ax1nb1WZTzuX8CyuiHN6eRb2ZUyk3vaWV4prUzAGOzGHaYzEBVo
         XBpGoQPSK29BRjCu+z5aExmL5asCg0/F9I77o2evQnrhrM7muGkRNs1Ea9yMBgcy9OBm
         vwznwl/W7p/jR7fChMEz1bE0FGjMsLf+jO7VGZaCO7ZwSf+KViARPBTCZmYsy+SgjF60
         ifrjusUxZAnRaKMFDSAiAxKLPErfKkLBruLOtH8CLR/fOvbhls/MZIS4Rs+N9n1gd3p8
         AZz2yoSKfz6bEeTiJPd6BFVsTNu7surcBpig9IdLx1LGAoX5tImkkvh/TMc6M0UsqVXT
         Rc6w==
X-Gm-Message-State: ACrzQf3M7Lc5hcTma7UKwiwUjq4SYaO3S6jEBlQp/u7seMHQOCy2LcYo
        v/76u8UeXWQQs8u1IXRWZ0zpcg==
X-Google-Smtp-Source: AMsMyM5LsDyyCf9+Zw1mXGYA4ucuY6NTuWddGyD0n37vQWA/+Hl7Tl+10ZExPfW37GvB/rpQ5+iIiA==
X-Received: by 2002:a37:69c5:0:b0:6fa:d6f:e848 with SMTP id e188-20020a3769c5000000b006fa0d6fe848mr27896590qkc.17.1667616749442;
        Fri, 04 Nov 2022 19:52:29 -0700 (PDT)
Received: from 192-168-53-12.byted.org ([130.44.212.119])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05620a178e00b006bb366779a4sm805905qkb.6.2022.11.04.19.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 19:52:29 -0700 (PDT)
From:   "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Hao Xiang <hao.xiang@bytedance.com>,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Yifei Ma <yifeima@bytedance.com>,
        Xiaoning Ding <xiaoning.ding@bytedance.com>,
        bpf@vger.kernel.org
Cc:     Ho-Ren Chuang <horenc@vt.edu>,
        Ho-Ren Chuang <horenchuang@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: Add unit tests for BPF htab map's used size
Date:   Sat,  5 Nov 2022 02:51:46 +0000
Message-Id: <20221105025146.238209-5-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221105025146.238209-1-horenchuang@bytedance.com>
References: <20221105025146.238209-1-horenchuang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Integrate with existing unit tests such as basic,
read/write-only htab maps, and concurrency testings for
testing htab map's used_entires.

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
---
 tools/testing/selftests/bpf/test_maps.c | 74 ++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index b73152822aa2..3bd202d27563 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -38,6 +38,8 @@ static void test_hashmap(unsigned int task, void *data)
 {
 	long long key, next_key, first_key, value;
 	int fd;
+	struct bpf_map_info map_info = {};
+	__u32 info_len = sizeof(map_info);
 
 	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value), 2, &map_opts);
 	if (fd < 0) {
@@ -50,16 +52,32 @@ static void test_hashmap(unsigned int task, void *data)
 	/* Insert key=1 element. */
 	assert(bpf_map_update_elem(fd, &key, &value, BPF_ANY) == 0);
 
+	/* Check used_entires is now 1. */
+	assert(bpf_obj_get_info_by_fd(fd, &map_info, &info_len) == 0);
+	assert(map_info.used_entries == 1);
+
 	value = 0;
 	/* BPF_NOEXIST means add new element if it doesn't exist. */
 	assert(bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST) < 0 &&
 	       /* key=1 already exists. */
 	       errno == EEXIST);
 
+	/* Check used_entires is still 1 because we are updating
+	 * an existing element.
+	 */
+	assert(bpf_obj_get_info_by_fd(fd, &map_info, &info_len) == 0);
+	assert(map_info.used_entries == 1);
+
 	/* -1 is an invalid flag. */
 	assert(bpf_map_update_elem(fd, &key, &value, -1) < 0 &&
 	       errno == EINVAL);
 
+	/* Check used_entires is still 1 because the last
+	 * insertion was invalid.
+	 */
+	assert(bpf_obj_get_info_by_fd(fd, &map_info, &info_len) == 0);
+	assert(map_info.used_entries == 1);
+
 	/* Check that key=1 can be found. */
 	assert(bpf_map_lookup_elem(fd, &key, &value) == 0 && value == 1234);
 
@@ -68,6 +86,10 @@ static void test_hashmap(unsigned int task, void *data)
 	/* Insert key=2 element. */
 	assert(bpf_map_update_elem(fd, &key, &value, BPF_ANY) == 0);
 
+	/* Check used_entires is now 2. */
+	assert(bpf_obj_get_info_by_fd(fd, &map_info, &info_len) == 0);
+	assert(map_info.used_entries == 2);
+
 	/* Check that key=2 matches the value and delete it */
 	assert(bpf_map_lookup_and_delete_elem(fd, &key, &value) == 0 && value == 1234);
 
@@ -89,6 +111,10 @@ static void test_hashmap(unsigned int task, void *data)
 	assert(bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST) < 0 &&
 	       errno == E2BIG);
 
+	/* Check used_entires is now 2. */
+	assert(bpf_obj_get_info_by_fd(fd, &map_info, &info_len) == 0);
+	assert(map_info.used_entries == 2);
+
 	/* Update existing element, though the map is full. */
 	key = 1;
 	assert(bpf_map_update_elem(fd, &key, &value, BPF_EXIST) == 0);
@@ -102,6 +128,10 @@ static void test_hashmap(unsigned int task, void *data)
 	key = 0;
 	assert(bpf_map_delete_elem(fd, &key) < 0 && errno == ENOENT);
 
+	/* Check used_entires is now 2. */
+	assert(bpf_obj_get_info_by_fd(fd, &map_info, &info_len) == 0);
+	assert(map_info.used_entries == 2);
+
 	/* Iterate over two elements. */
 	assert(bpf_map_get_next_key(fd, NULL, &first_key) == 0 &&
 	       (first_key == 1 || first_key == 2));
@@ -127,6 +157,10 @@ static void test_hashmap(unsigned int task, void *data)
 	assert(bpf_map_get_next_key(fd, &key, &next_key) < 0 &&
 	       errno == ENOENT);
 
+	/* Check used_entires is now 0 because both elements were deleted. */
+	assert(bpf_obj_get_info_by_fd(fd, &map_info, &info_len) == 0);
+	assert(map_info.used_entries == 0);
+
 	close(fd);
 }
 
@@ -292,6 +326,8 @@ static void test_hashmap_walk(unsigned int task, void *data)
 	int fd, i, max_entries = 10000;
 	long long key, value[VALUE_SIZE], next_key;
 	bool next_key_valid = true;
+	struct bpf_map_info map_info = {};
+	__u32 info_len = sizeof(map_info);
 
 	fd = helper_fill_hashmap(max_entries);
 
@@ -302,6 +338,9 @@ static void test_hashmap_walk(unsigned int task, void *data)
 	}
 
 	assert(i == max_entries);
+	/* Check used_entires is now max_entries. */
+	assert(bpf_obj_get_info_by_fd(fd, &map_info, &info_len) == 0);
+	assert(map_info.used_entries == max_entries);
 
 	assert(bpf_map_get_next_key(fd, NULL, &key) == 0);
 	for (i = 0; next_key_valid; i++) {
@@ -313,6 +352,9 @@ static void test_hashmap_walk(unsigned int task, void *data)
 	}
 
 	assert(i == max_entries);
+	/* Check used_entires is now max_entries. */
+	assert(bpf_obj_get_info_by_fd(fd, &map_info, &info_len) == 0);
+	assert(map_info.used_entries == max_entries);
 
 	for (i = 0; bpf_map_get_next_key(fd, !i ? NULL : &key,
 					 &next_key) == 0; i++) {
@@ -322,6 +364,9 @@ static void test_hashmap_walk(unsigned int task, void *data)
 	}
 
 	assert(i == max_entries);
+	/* Check used_entires is now max_entries. */
+	assert(bpf_obj_get_info_by_fd(fd, &map_info, &info_len) == 0);
+	assert(map_info.used_entries == max_entries);
 	close(fd);
 }
 
@@ -1303,13 +1348,14 @@ static void test_map_in_map(void)
 
 static void test_map_large(void)
 {
-
 	struct bigkey {
 		int a;
 		char b[4096];
 		long long c;
 	} key;
 	int fd, i, value;
+	struct bpf_map_info map_info = {};
+	__u32 info_len = sizeof(map_info);
 
 	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value),
 			    MAP_SIZE, &map_opts);
@@ -1341,6 +1387,10 @@ static void test_map_large(void)
 	key.a = 1;
 	assert(bpf_map_lookup_elem(fd, &key, &value) < 0 && errno == ENOENT);
 
+	/* Check used_entires is now MAP_SIZE. */
+	assert(bpf_obj_get_info_by_fd(fd, &map_info, &info_len) == 0);
+	assert(map_info.used_entries == MAP_SIZE);
+
 	close(fd);
 }
 
@@ -1466,6 +1516,8 @@ static void test_map_parallel(void)
 {
 	int i, fd, key = 0, value = 0, j = 0;
 	int data[2];
+	struct bpf_map_info map_info = {};
+	__u32 info_len = sizeof(map_info);
 
 	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value),
 			    MAP_SIZE, &map_opts);
@@ -1504,6 +1556,10 @@ static void test_map_parallel(void)
 		       value == key);
 	}
 
+	/* Check used_entires is now MAP_SIZE. */
+	assert(bpf_obj_get_info_by_fd(fd, &map_info, &info_len) == 0);
+	assert(map_info.used_entries == MAP_SIZE);
+
 	/* Now let's delete all elemenets in parallel. */
 	data[1] = DO_DELETE;
 	run_parallel(TASKS, test_update_delete, data);
@@ -1513,6 +1569,10 @@ static void test_map_parallel(void)
 	assert(bpf_map_get_next_key(fd, NULL, &key) < 0 && errno == ENOENT);
 	assert(bpf_map_get_next_key(fd, &key, &key) < 0 && errno == ENOENT);
 
+	/* Check used_entires is now 0. */
+	assert(bpf_obj_get_info_by_fd(fd, &map_info, &info_len) == 0);
+	assert(map_info.used_entries == 0);
+
 	key = 0;
 	bpf_map_delete_elem(fd, &key);
 	if (j++ < 5)
@@ -1524,6 +1584,8 @@ static void test_map_rdonly(void)
 {
 	int fd, key = 0, value = 0;
 	__u32 old_flags;
+	struct bpf_map_info map_info = {};
+	__u32 info_len = sizeof(map_info);
 
 	old_flags = map_opts.map_flags;
 	map_opts.map_flags |= BPF_F_RDONLY;
@@ -1546,6 +1608,10 @@ static void test_map_rdonly(void)
 	assert(bpf_map_lookup_elem(fd, &key, &value) < 0 && errno == ENOENT);
 	assert(bpf_map_get_next_key(fd, &key, &value) < 0 && errno == ENOENT);
 
+	/* Check used_entires is now 0. */
+	assert(bpf_obj_get_info_by_fd(fd, &map_info, &info_len) == 0);
+	assert(map_info.used_entries == 0);
+
 	close(fd);
 }
 
@@ -1553,6 +1619,8 @@ static void test_map_wronly_hash(void)
 {
 	int fd, key = 0, value = 0;
 	__u32 old_flags;
+	struct bpf_map_info map_info = {};
+	__u32 info_len = sizeof(map_info);
 
 	old_flags = map_opts.map_flags;
 	map_opts.map_flags |= BPF_F_WRONLY;
@@ -1574,6 +1642,10 @@ static void test_map_wronly_hash(void)
 	assert(bpf_map_lookup_elem(fd, &key, &value) < 0 && errno == EPERM);
 	assert(bpf_map_get_next_key(fd, &key, &value) < 0 && errno == EPERM);
 
+	/* Check used_entires is now 1. */
+	assert(bpf_obj_get_info_by_fd(fd, &map_info, &info_len) == 0);
+	assert(map_info.used_entries == 1);
+
 	close(fd);
 }
 
-- 
Ho-Ren (Jack) Chuang

