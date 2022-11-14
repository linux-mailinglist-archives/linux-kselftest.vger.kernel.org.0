Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9A362814E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 14:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiKNNbR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 08:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbiKNNbM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 08:31:12 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F19222B6;
        Mon, 14 Nov 2022 05:31:08 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N9qqD4MCfzqSN8;
        Mon, 14 Nov 2022 21:27:20 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 14 Nov
 2022 21:31:05 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH bpf 2/2] bpf: Set and check spin lock value in sk_storage_map_test
Date:   Mon, 14 Nov 2022 08:47:20 -0500
Message-ID: <20221114134720.1057939-3-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221114134720.1057939-1-xukuohai@huawei.com>
References: <20221114134720.1057939-1-xukuohai@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.197]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update sk_storage_map_test to make sure kernel does not copy user
non-zero value spin lock to kernel, and does not copy kernel spin
lock value to user.

If user spin lock value is copied to kernel, this test case will
make kernel spin on the copied lock, resulting in rcu stall and
softlockup.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/map_tests/sk_storage_map.c  | 36 ++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/sk_storage_map.c b/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
index 099eb4dfd4f7..18405c3b7cee 100644
--- a/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
+++ b/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
@@ -458,7 +458,7 @@ static void test_sk_storage_map_basic(void)
 	struct {
 		int cnt;
 		int lock;
-	} value = { .cnt = 0xeB9f, .lock = 0, }, lookup_value;
+	} value = { .cnt = 0xeB9f, .lock = 1, }, lookup_value;
 	struct bpf_map_create_opts bad_xattr;
 	int btf_fd, map_fd, sk_fd, err;
 
@@ -483,38 +483,41 @@ static void test_sk_storage_map_basic(void)
 	      "err:%d errno:%d\n", err, errno);
 	err = bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
 					BPF_F_LOCK);
-	CHECK(err || lookup_value.cnt != value.cnt,
+	CHECK(err || lookup_value.lock || lookup_value.cnt != value.cnt,
 	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
-	      "err:%d errno:%d cnt:%x(%x)\n",
-	      err, errno, lookup_value.cnt, value.cnt);
+	      "err:%d errno:%d lock:%x cnt:%x(%x)\n",
+	      err, errno, lookup_value.lock, lookup_value.cnt, value.cnt);
 
 	/* Bump the cnt and update with BPF_EXIST | BPF_F_LOCK */
 	value.cnt += 1;
+	value.lock = 2;
 	err = bpf_map_update_elem(map_fd, &sk_fd, &value,
 				  BPF_EXIST | BPF_F_LOCK);
 	CHECK(err, "bpf_map_update_elem(BPF_EXIST|BPF_F_LOCK)",
 	      "err:%d errno:%d\n", err, errno);
 	err = bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
 					BPF_F_LOCK);
-	CHECK(err || lookup_value.cnt != value.cnt,
+	CHECK(err || lookup_value.lock || lookup_value.cnt != value.cnt,
 	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
-	      "err:%d errno:%d cnt:%x(%x)\n",
-	      err, errno, lookup_value.cnt, value.cnt);
+	      "err:%d errno:%d lock:%x cnt:%x(%x)\n",
+	      err, errno, lookup_value.lock, lookup_value.cnt, value.cnt);
 
 	/* Bump the cnt and update with BPF_EXIST */
 	value.cnt += 1;
+	value.lock = 2;
 	err = bpf_map_update_elem(map_fd, &sk_fd, &value, BPF_EXIST);
 	CHECK(err, "bpf_map_update_elem(BPF_EXIST)",
 	      "err:%d errno:%d\n", err, errno);
 	err = bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
 					BPF_F_LOCK);
-	CHECK(err || lookup_value.cnt != value.cnt,
+	CHECK(err || lookup_value.lock || lookup_value.cnt != value.cnt,
 	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
-	      "err:%d errno:%d cnt:%x(%x)\n",
-	      err, errno, lookup_value.cnt, value.cnt);
+	      "err:%d errno:%d lock:%x cnt:%x(%x)\n",
+	      err, errno, lookup_value.lock, lookup_value.cnt, value.cnt);
 
 	/* Update with BPF_NOEXIST */
 	value.cnt += 1;
+	value.lock = 2;
 	err = bpf_map_update_elem(map_fd, &sk_fd, &value,
 				  BPF_NOEXIST | BPF_F_LOCK);
 	CHECK(!err || errno != EEXIST,
@@ -526,22 +529,23 @@ static void test_sk_storage_map_basic(void)
 	value.cnt -= 1;
 	err = bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
 					BPF_F_LOCK);
-	CHECK(err || lookup_value.cnt != value.cnt,
+	CHECK(err || lookup_value.lock || lookup_value.cnt != value.cnt,
 	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
-	      "err:%d errno:%d cnt:%x(%x)\n",
-	      err, errno, lookup_value.cnt, value.cnt);
+	      "err:%d errno:%d lock:%x cnt:%x(%x)\n",
+	      err, errno, lookup_value.lock, lookup_value.cnt, value.cnt);
 
 	/* Bump the cnt again and update with map_flags == 0 */
 	value.cnt += 1;
+	value.lock = 2;
 	err = bpf_map_update_elem(map_fd, &sk_fd, &value, 0);
 	CHECK(err, "bpf_map_update_elem()", "err:%d errno:%d\n",
 	      err, errno);
 	err = bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
 					BPF_F_LOCK);
-	CHECK(err || lookup_value.cnt != value.cnt,
+	CHECK(err || lookup_value.lock || lookup_value.cnt != value.cnt,
 	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
-	      "err:%d errno:%d cnt:%x(%x)\n",
-	      err, errno, lookup_value.cnt, value.cnt);
+	      "err:%d errno:%d lock:%x cnt:%x(%x)\n",
+	      err, errno, lookup_value.lock, lookup_value.cnt, value.cnt);
 
 	/* Test delete elem */
 	err = bpf_map_delete_elem(map_fd, &sk_fd);
-- 
2.30.2

