Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD81B27848A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Sep 2020 11:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgIYJ5H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Sep 2020 05:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgIYJ44 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Sep 2020 05:56:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB4EC0613D7
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Sep 2020 02:56:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so2583441wmj.5
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Sep 2020 02:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7RJH7pZMCVV5iroyiFLpiFRNTiQn0SSX+69PgDO+op4=;
        b=Z5Tay6EcQTWazV7dTKt9RehYD/4epP7kRU3Ga/PrUGWrecnu5q/y5u3cYUdQDXeJ9c
         Tyz/nwhilwMzR4ntbwLfx6EoZ16+hl0EzUT8i/ih1BZiBOcm/WzdG1KAcIMWDxNltI6s
         e+yJCM3wjpKF1BppOv7Dp6OVp7eTZLCqSO4w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7RJH7pZMCVV5iroyiFLpiFRNTiQn0SSX+69PgDO+op4=;
        b=qlp43v5MDcesPKd2+SLP+D2a6O/79kWT5euPAXFcgJXwdEyuJXknYaZ0Jgm3ZpOlpN
         9FgtBGZVEZMKXVGmO/HZqBM7lAEVWgri88cHq3wUMw3PQNMhWqmprq4OYxqf3A+xZubM
         FWDrqIH8gDstq4yZV1cqfFrsU1ZV5Pl2roGWjn9wbDlkWOQhPFFLSsXIAgE0b2cY77W1
         luMrg7gvBzRNh2KlrAQfGd9iaj6r0s0TMIzyxqHmuAzQHWj6H/w3RcIA8HYdavHlA1mB
         TlNxyfbzsktVb0C1g6y+S/9axBrheHDWjdo+IGL8+z7LnKLGIb8sgHjgkiEHE3UT0QDF
         Iyrg==
X-Gm-Message-State: AOAM5319a+sYqEyaCoJCGngHZeusrGQ1V5CSAocwerRuMNJuwy82h6Qm
        TviemrHCYZ3qJO5wuhklVn/m3A==
X-Google-Smtp-Source: ABdhPJyXHCb7Koa9bhkkDBnbpeFU8UXjBvkZiVeQ6G92Q1rH+QgQoM9tP3HlGHJwhr+7X2lyLuGuKQ==
X-Received: by 2002:a7b:cc17:: with SMTP id f23mr2095213wmh.166.1601027813944;
        Fri, 25 Sep 2020 02:56:53 -0700 (PDT)
Received: from antares.lan (e.0.c.6.b.e.c.e.a.c.9.7.c.2.1.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:12c:79ca:eceb:6c0e])
        by smtp.gmail.com with ESMTPSA id l10sm2225084wru.59.2020.09.25.02.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 02:56:53 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 4/4] selftest: bpf: Test copying a sockmap and sockhash
Date:   Fri, 25 Sep 2020 10:56:30 +0100
Message-Id: <20200925095630.49207-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925095630.49207-1-lmb@cloudflare.com>
References: <20200925095630.49207-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since we can now call map_update_elem(sockmap) from bpf_iter context
it's possible to copy a sockmap or sockhash in the kernel. Add a
selftest which exercises this.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 14 +++++-----
 .../selftests/bpf/progs/bpf_iter_sockmap.c    | 27 +++++++++++++++----
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index e8a4bfb4d9f4..854a508e81ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -194,7 +194,7 @@ static void test_sockmap_invalid_update(void)
 		test_sockmap_invalid_update__destroy(skel);
 }
 
-static void test_sockmap_iter(enum bpf_map_type map_type)
+static void test_sockmap_copy(enum bpf_map_type map_type)
 {
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	int err, len, src_fd, iter_fd, duration = 0;
@@ -242,7 +242,7 @@ static void test_sockmap_iter(enum bpf_map_type map_type)
 	linfo.map.map_fd = src_fd;
 	opts.link_info = &linfo;
 	opts.link_info_len = sizeof(linfo);
-	link = bpf_program__attach_iter(skel->progs.count_elems, &opts);
+	link = bpf_program__attach_iter(skel->progs.copy, &opts);
 	if (CHECK(IS_ERR(link), "attach_iter", "attach_iter failed\n"))
 		goto out;
 
@@ -265,6 +265,8 @@ static void test_sockmap_iter(enum bpf_map_type map_type)
 		  skel->bss->socks, num_sockets))
 		goto close_iter;
 
+	compare_cookies(src, skel->maps.dst);
+
 close_iter:
 	close(iter_fd);
 free_link:
@@ -294,8 +296,8 @@ void test_sockmap_basic(void)
 		test_sockmap_update(BPF_MAP_TYPE_SOCKHASH);
 	if (test__start_subtest("sockmap update in unsafe context"))
 		test_sockmap_invalid_update();
-	if (test__start_subtest("sockmap iter"))
-		test_sockmap_iter(BPF_MAP_TYPE_SOCKMAP);
-	if (test__start_subtest("sockhash iter"))
-		test_sockmap_iter(BPF_MAP_TYPE_SOCKHASH);
+	if (test__start_subtest("sockmap copy"))
+		test_sockmap_copy(BPF_MAP_TYPE_SOCKMAP);
+	if (test__start_subtest("sockhash copy"))
+		test_sockmap_copy(BPF_MAP_TYPE_SOCKHASH);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
index 1af7555f6057..f3af0e30cead 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
@@ -22,21 +22,38 @@ struct {
 	__type(value, __u64);
 } sockhash SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, 64);
+	__type(key, __u32);
+	__type(value, __u64);
+} dst SEC(".maps");
+
 __u32 elems = 0;
 __u32 socks = 0;
 
 SEC("iter/sockmap")
-int count_elems(struct bpf_iter__sockmap *ctx)
+int copy(struct bpf_iter__sockmap *ctx)
 {
 	struct sock *sk = ctx->sk;
 	__u32 tmp, *key = ctx->key;
 	int ret;
 
-	if (key)
-		elems++;
+	if (!key)
+		return 0;
 
-	if (sk)
+	elems++;
+
+	/* We need a temporary buffer on the stack, since the verifier doesn't
+	 * let us use the pointer from the context as an argument to the helper.
+	 */
+	tmp = *key;
+
+	if (sk) {
 		socks++;
+		return bpf_map_update_elem(&dst, &tmp, sk, 0) != 0;
+	}
 
-	return 0;
+	ret = bpf_map_delete_elem(&dst, &tmp);
+	return ret && ret != -ENOENT;
 }
-- 
2.25.1

