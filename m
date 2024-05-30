Return-Path: <linux-kselftest+bounces-10904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F968D4642
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 09:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EE81C21712
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 07:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EED64D8CF;
	Thu, 30 May 2024 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnGmsLi+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170FB4D8A0;
	Thu, 30 May 2024 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054916; cv=none; b=NINdXerQAHV/LqxqsrVmwZUIImuurfKiAIit6V2VGlQEUKRoSTm8lZLduP96xeXFoiD4kEx9OdsB/9veYF4ixTJ3+DQBG6ENofjpShtzvy3dxgJ2IzQGxGglRiNEYQuTHareIxA13sB1aSnK7YvA6a/Psdyzu7Lbjkwk0QtTpXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054916; c=relaxed/simple;
	bh=IYEJ53AgPCYwmivBTBsq0j/rl3dzTTkkvNgNdoVK9y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRXbO9VgeIU+M4AdEU94M0VOKgcdJe8SOqkqi6BCMdPFS3V6BsIsEejx4Y7fSk/IpBFzs6eeurWVLjWaCcr7TuOQiESSpv4ve+cDeaRY0vsNArG4UEXja4lG9WH7NqapM/oTSRhdeEKnfKtVKsoiE0HnNO/UPFB6gxnV0gs4JFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnGmsLi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D78C4AF07;
	Thu, 30 May 2024 07:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717054915;
	bh=IYEJ53AgPCYwmivBTBsq0j/rl3dzTTkkvNgNdoVK9y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnGmsLi+C07oxtmKISXR5y8NuaIEFPZxupf8qQ/1kf6w/EVVBHnhf5ChzHzPgNkvL
	 XSV8ubdUONaubN6VfsBj4EvNzXb7bjzuUhXo4ulVZ5aY7Ga1gC1uzzc1TCIP3mtoOc
	 GN3EpTeSCPgrkPBMgwFsZfufQtXgdSSYhSY+cUSa5Yu9X81EnfLQtkmJHUBm+QoXY3
	 tVcepyw+mV/F4G8lg2JA1uGJZl10aPVgQnPA3q44sgeSG3Bg9ZJCb9uhGm6B9n6wNZ
	 FmOh4UZQvLYZuED60aZyvrPCdO/M+zGBEFf0EE/U2EfcWH8nE0+b2UL294BWw/NuJm
	 tmtC3qH8h4D0w==
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
Subject: [PATCH bpf-next 5/5] selftests/bpf: Drop useless arguments of do_test in bpf_tcp_ca
Date: Thu, 30 May 2024 15:41:12 +0800
Message-ID: <7056eab111d78a05bce29d2821228dc93f240de4.1717054461.git.tanggeliang@kylinos.cn>
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

bpf_map_lookup_elem() has been removed from do_test(), it makes the
sk_stg_map argument of do_test() useless. In addition, two exactly the
same opts are passed in all the places where do_test() is invoked, so
cli_opts argument can be dropped too.

This patch drops these two useless arguments of do_test() in bpf_tcp_ca.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 1b27d0232cbd..67358adf5db3 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -67,13 +67,11 @@ static bool start_test(char *addr_str,
 	return false;
 }
 
-static void do_test(const struct network_helper_opts *opts,
-		    const struct network_helper_opts *cli_opts,
-		    const struct bpf_map *sk_stg_map)
+static void do_test(const struct network_helper_opts *opts)
 {
 	int lfd = -1, fd = -1;
 
-	if (!start_test(NULL, opts, cli_opts, &lfd, &fd))
+	if (!start_test(NULL, opts, opts, &lfd, &fd))
 		goto done;
 
 	ASSERT_OK(send_recv_data(lfd, fd, total_bytes), "send_recv_data");
@@ -114,7 +112,7 @@ static void test_cubic(void)
 		return;
 	}
 
-	do_test(&opts, &opts, NULL);
+	do_test(&opts);
 
 	ASSERT_EQ(cubic_skel->bss->bpf_cubic_acked_called, 1, "pkts_acked called");
 
@@ -382,14 +380,14 @@ static void test_update_ca(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test(&opts, &opts, NULL);
+	do_test(&opts);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
 	ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_update_2);
 	ASSERT_OK(err, "update_map");
 
-	do_test(&opts, &opts, NULL);
+	do_test(&opts);
 	ASSERT_EQ(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
 	ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
 
@@ -418,14 +416,14 @@ static void test_update_wrong(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test(&opts, &opts, NULL);
+	do_test(&opts);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
 	ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_wrong);
 	ASSERT_ERR(err, "update_map");
 
-	do_test(&opts, &opts, NULL);
+	do_test(&opts);
 	ASSERT_GT(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
 
 	bpf_link__destroy(link);
@@ -455,7 +453,7 @@ static void test_mixed_links(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test(&opts, &opts, NULL);
+	do_test(&opts);
 	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_no_link);
@@ -562,7 +560,7 @@ static void test_cc_cubic(void)
 		return;
 	}
 
-	do_test(&opts, &opts, NULL);
+	do_test(&opts);
 
 	bpf_link__destroy(link);
 	bpf_cc_cubic__destroy(cc_cubic_skel);
-- 
2.43.0


