Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A12441B3E
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 13:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhKAMiO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 08:38:14 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13996 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhKAMiL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 08:38:11 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HjXWb4WvzzZcj0;
        Mon,  1 Nov 2021 20:33:31 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 1 Nov 2021 20:35:27 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 20:35:27 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
        <ast@kernel.org>, <yhs@fb.com>
Subject: [PATCH -next v2] bpf/benchs: Fix return value check of bpf_program__attach()
Date:   Mon, 1 Nov 2021 20:43:10 +0800
Message-ID: <20211101124310.3947887-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If bpf_program__attach() fails, it never returns NULL,
we should use libbpf_get_error() to check the return value.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
v2:
  don't use 'int err'
---
 .../selftests/bpf/benchs/bench_bloom_filter_map.c      | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
index 6eeeed2913e6..4afaa4adb327 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
@@ -304,7 +304,7 @@ static void bloom_lookup_setup(void)
 	populate_maps();
 
 	link = bpf_program__attach(ctx.skel->progs.bloom_lookup);
-	if (!link) {
+	if (libbpf_get_error(link)) {
 		fprintf(stderr, "failed to attach program!\n");
 		exit(1);
 	}
@@ -321,7 +321,7 @@ static void bloom_update_setup(void)
 	populate_maps();
 
 	link = bpf_program__attach(ctx.skel->progs.bloom_update);
-	if (!link) {
+	if (libbpf_get_error(link)) {
 		fprintf(stderr, "failed to attach program!\n");
 		exit(1);
 	}
@@ -340,7 +340,7 @@ static void false_positive_setup(void)
 	populate_maps();
 
 	link = bpf_program__attach(ctx.skel->progs.bloom_hashmap_lookup);
-	if (!link) {
+	if (libbpf_get_error(link)) {
 		fprintf(stderr, "failed to attach program!\n");
 		exit(1);
 	}
@@ -358,7 +358,7 @@ static void hashmap_with_bloom_setup(void)
 	populate_maps();
 
 	link = bpf_program__attach(ctx.skel->progs.bloom_hashmap_lookup);
-	if (!link) {
+	if (libbpf_get_error(link)) {
 		fprintf(stderr, "failed to attach program!\n");
 		exit(1);
 	}
@@ -375,7 +375,7 @@ static void hashmap_no_bloom_setup(void)
 	populate_maps();
 
 	link = bpf_program__attach(ctx.skel->progs.bloom_hashmap_lookup);
-	if (!link) {
+	if (libbpf_get_error(link)) {
 		fprintf(stderr, "failed to attach program!\n");
 		exit(1);
 	}
-- 
2.25.1

