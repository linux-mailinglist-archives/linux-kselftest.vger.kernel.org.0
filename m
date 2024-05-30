Return-Path: <linux-kselftest+bounces-10903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E26B8D4640
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 09:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FCC1F2286E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 07:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6664D8CD;
	Thu, 30 May 2024 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="as4V1IIi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C24D8BC;
	Thu, 30 May 2024 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054910; cv=none; b=WUmxBPDeIOBAzYNXPQBBeccWJ6vXd7wA7AaGgdmySwDGmBLphgAWcMYe9P65Aoy+9H5HwvkxSM6gGnnM4V/nnFlgnedLy3sRZH+neiudeb9iCcTaX+8iahaXdbfRoxAshZMlK+GSMzShIA/lsSN4QMWNd/NcsMncJbqrYh8l7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054910; c=relaxed/simple;
	bh=kN8DTt3/fuWpg28jCbwg16PYfKIoMNSWYxHMbtRoOOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVCARHZ07DLiguyKTiLAvWY878hSyyfRUhWeZC1TBWhLa29RsLpABTNKvWElcVybHuA1Hdbo5G4dyeRu7c06f0+3unY0nJXWDnlYkF7qoiWw2FYQBEb0sNYnhCOGZvZia0DVlLoYS/eOOVtSHff9VfYsbm8faXcNuLL7J4Ciki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=as4V1IIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871E9C3277B;
	Thu, 30 May 2024 07:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717054909;
	bh=kN8DTt3/fuWpg28jCbwg16PYfKIoMNSWYxHMbtRoOOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=as4V1IIicN+7gQPHjFh/ztZBuKhFbnFCQ97ey6s3G2Z3yTFWSJeYGNpAVisRBYb0J
	 0AezAOMKbcXKy//Z9D6QQGiFhqD3rShNSY5iu8FJi+9fjJxLFrdBO2Thm4dFA6zYSD
	 wi0karLseGcFE6ye+zd4IAE2YoXOgWU9CkRWj1+RtOwgkIpO5TVZpxYbWdRJa9WKHD
	 eRVZPurMW4YuSEDD7MOMyxtCsIVAEZ/b/PvWgmoPwIHjffccxK9405Hf8F8KMdtPWX
	 H3+/ajkSJj8wj7diHeXqBmtISnn+XOD83S2lnCOXd1YN0aYEC6lSNQwCvUSNNcXOtw
	 LsQuiHTlbMLUg==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 4/5] selftests/bpf: Use start_test in test_dctcp in bpf_tcp_ca
Date: Thu, 30 May 2024 15:41:11 +0800
Message-ID: <9938916627b9810c877e5c03a621bc0ba5acf5c5.1717054461.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1717054461.git.tanggeliang@kylinos.cn>
References: <cover.1717054461.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The "if (sk_stg_map)" block in do_test() is only used by test_dctcp(),
it makes sense to move it from do_test() into test_dctcp(). Then
do_test() can be used by other tests except test_dctcp().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 27 ++++++++++---------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index d10217169ff8..1b27d0232cbd 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -72,21 +72,10 @@ static void do_test(const struct network_helper_opts *opts,
 		    const struct bpf_map *sk_stg_map)
 {
 	int lfd = -1, fd = -1;
-	int err;
 
 	if (!start_test(NULL, opts, cli_opts, &lfd, &fd))
 		goto done;
 
-	if (sk_stg_map) {
-		int tmp_stg;
-
-		err = bpf_map_lookup_elem(bpf_map__fd(sk_stg_map), &fd,
-					  &tmp_stg);
-		if (!ASSERT_ERR(err, "bpf_map_lookup_elem(sk_stg_map)") ||
-				!ASSERT_EQ(errno, ENOENT, "bpf_map_lookup_elem(sk_stg_map)"))
-			goto done;
-	}
-
 	ASSERT_OK(send_recv_data(lfd, fd, total_bytes), "send_recv_data");
 
 done:
@@ -163,6 +152,7 @@ static void test_dctcp(void)
 		.post_socket_cb	= stg_post_socket_cb,
 		.cb_opts	= &cb_opts,
 	};
+	int lfd = -1, fd = -1, tmp_stg, err;
 	struct bpf_dctcp *dctcp_skel;
 	struct bpf_link *link;
 
@@ -177,11 +167,24 @@ static void test_dctcp(void)
 	}
 
 	cb_opts.map_fd = bpf_map__fd(dctcp_skel->maps.sk_stg_map);
-	do_test(&opts, &cli_opts, dctcp_skel->maps.sk_stg_map);
+	if (!start_test(NULL, &opts, &cli_opts, &lfd, &fd))
+		goto done;
+
+	err = bpf_map_lookup_elem(cb_opts.map_fd, &fd, &tmp_stg);
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem(sk_stg_map)") ||
+			!ASSERT_EQ(errno, ENOENT, "bpf_map_lookup_elem(sk_stg_map)"))
+		goto done;
+
+	ASSERT_OK(send_recv_data(lfd, fd, total_bytes), "send_recv_data");
 	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
+done:
 	bpf_link__destroy(link);
 	bpf_dctcp__destroy(dctcp_skel);
+	if (lfd != -1)
+		close(lfd);
+	if (fd != -1)
+		close(fd);
 }
 
 static char *err_str;
-- 
2.43.0


