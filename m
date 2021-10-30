Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38ED7440837
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Oct 2021 11:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhJ3JZg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 30 Oct 2021 05:25:36 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:26213 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhJ3JZg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 30 Oct 2021 05:25:36 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HhDM7049Qz8tjw;
        Sat, 30 Oct 2021 17:21:39 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sat, 30 Oct 2021 17:23:03 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sat, 30 Oct
 2021 17:23:03 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
        <ast@kernel.org>
Subject: [PATCH -next] bpf/benchs: Fix return value check of bpf_program__attach()
Date:   Sat, 30 Oct 2021 17:30:51 +0800
Message-ID: <20211030093051.2609665-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If bpf_program__attach() fails, it never returns NULL,
we should use libbpf_get_error() to check the return value.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 .../bpf/benchs/bench_bloom_filter_map.c       | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
index 6eeeed2913e6..6879340b20c4 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
@@ -296,6 +296,7 @@ static struct bloom_filter_bench *setup_skeleton(void)
 static void bloom_lookup_setup(void)
 {
 	struct bpf_link *link;
+	int err;
 
 	ctx.use_array_map = true;
 
@@ -304,7 +305,8 @@ static void bloom_lookup_setup(void)
 	populate_maps();
 
 	link = bpf_program__attach(ctx.skel->progs.bloom_lookup);
-	if (!link) {
+	err = libbpf_get_error(link);
+	if (err) {
 		fprintf(stderr, "failed to attach program!\n");
 		exit(1);
 	}
@@ -313,6 +315,7 @@ static void bloom_lookup_setup(void)
 static void bloom_update_setup(void)
 {
 	struct bpf_link *link;
+	int err;
 
 	ctx.use_array_map = true;
 
@@ -321,7 +324,8 @@ static void bloom_update_setup(void)
 	populate_maps();
 
 	link = bpf_program__attach(ctx.skel->progs.bloom_update);
-	if (!link) {
+	err = libbpf_get_error(link);
+	if (err) {
 		fprintf(stderr, "failed to attach program!\n");
 		exit(1);
 	}
@@ -330,6 +334,7 @@ static void bloom_update_setup(void)
 static void false_positive_setup(void)
 {
 	struct bpf_link *link;
+	int err;
 
 	ctx.use_hashmap = true;
 	ctx.hashmap_use_bloom = true;
@@ -340,7 +345,8 @@ static void false_positive_setup(void)
 	populate_maps();
 
 	link = bpf_program__attach(ctx.skel->progs.bloom_hashmap_lookup);
-	if (!link) {
+	err = libbpf_get_error(link);
+	if (err) {
 		fprintf(stderr, "failed to attach program!\n");
 		exit(1);
 	}
@@ -349,6 +355,7 @@ static void false_positive_setup(void)
 static void hashmap_with_bloom_setup(void)
 {
 	struct bpf_link *link;
+	int err;
 
 	ctx.use_hashmap = true;
 	ctx.hashmap_use_bloom = true;
@@ -358,7 +365,8 @@ static void hashmap_with_bloom_setup(void)
 	populate_maps();
 
 	link = bpf_program__attach(ctx.skel->progs.bloom_hashmap_lookup);
-	if (!link) {
+	err = libbpf_get_error(link);
+	if (err) {
 		fprintf(stderr, "failed to attach program!\n");
 		exit(1);
 	}
@@ -367,6 +375,7 @@ static void hashmap_with_bloom_setup(void)
 static void hashmap_no_bloom_setup(void)
 {
 	struct bpf_link *link;
+	int err;
 
 	ctx.use_hashmap = true;
 
@@ -375,7 +384,8 @@ static void hashmap_no_bloom_setup(void)
 	populate_maps();
 
 	link = bpf_program__attach(ctx.skel->progs.bloom_hashmap_lookup);
-	if (!link) {
+	err = libbpf_get_error(link);
+	if (err) {
 		fprintf(stderr, "failed to attach program!\n");
 		exit(1);
 	}
-- 
2.25.1

