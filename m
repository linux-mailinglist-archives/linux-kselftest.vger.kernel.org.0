Return-Path: <linux-kselftest+bounces-13963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B697893810E
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 13:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7138D282076
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 11:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2555084FAC;
	Sat, 20 Jul 2024 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZVrpwD2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C6629AB;
	Sat, 20 Jul 2024 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721475654; cv=none; b=BwmkVjexdIteN4sjxZLhxLAVeCeaaD2Od23zDD5TGqHUfN7Cpp1A4/AhbhBGtl58t9aHwe+yzMvYi+u9vzmddIfQEElaK4F2sl3mc7nBbKcAFA5rcaJLux9f2HnCpmYMMldXeiX2kyrZZZUvwtLSiDgPlHpY7qioLr2P3PzFYHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721475654; c=relaxed/simple;
	bh=wkqdp7kya0n3h+GrMwSd66zEgaaks7rxfiWYlU/VT0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyCrwUxliPDGDakh3JK7wXbuarjvKYa5lQcyp6aJOhQlAGvpTP3ze6IxuTP7yCPrU8r8Clng7qKOGdWUoNNpxKMNK0nO2qzA3cLKZb/A5bYcJIWRJ4HlbheuJg90Jfm68+bQOlrw2x6rzauS65ncIN3Wwx4qcSSwWhMo8kEByz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZVrpwD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB49DC4AF0E;
	Sat, 20 Jul 2024 11:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721475653;
	bh=wkqdp7kya0n3h+GrMwSd66zEgaaks7rxfiWYlU/VT0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZVrpwD2gTvLOmFUvec0eswhzdhyEAxg2Qx3WZABdwwuTThr0dvfJRqQ6V3/dBYz6
	 36isBwIv6oepzS+IWfy4y2sdcEYOeGTLBpFK1oRfH5YKo3ZEZQZhKCalodrR2+UKqB
	 79NxHrhoK4AeIBuvx9uOg5oQtWYD1HNVCt3bmmmgNPTFIdq+jcKdwUDMeJ1ZQuX3Jm
	 +F1LvyTQ0ahNhRt599gmiT6U1lAMKNa0Qt9FFbEhY0ObfnJ3Jc4Qpfc0Z5UgcAvg5z
	 k6xO3aMON3B0PAx1EqjLg6DiVAuQu6ZFWeZviAsTX3xKFm+ukptCF2lJXxBcAYFPto
	 RVdTp450VL2IA==
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
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 3/4] selftests/bpf: Drop inetaddr_len in sk_lookup
Date: Sat, 20 Jul 2024 19:40:05 +0800
Message-ID: <32e2a4122921051da38a6e4fbb2ebee5f0af5a4e.1721475357.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721475357.git.tanggeliang@kylinos.cn>
References: <cover.1721475357.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

No need to use a dedicated helper inetaddr_len() to get the length of
the IPv4 or IPv6 address, it can be got by make_sockaddr(), this patch
drops it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 88f2f9efeea5..96f3863da8bc 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -106,12 +106,6 @@ static int attach_reuseport(int sock_fd, struct bpf_program *reuseport_prog)
 	return 0;
 }
 
-static socklen_t inetaddr_len(const struct sockaddr_storage *addr)
-{
-	return (addr->ss_family == AF_INET ? sizeof(struct sockaddr_in) :
-		addr->ss_family == AF_INET6 ? sizeof(struct sockaddr_in6) : 0);
-}
-
 static int setsockopts(int fd, void *opts)
 {
 	struct cb_opts *co = (struct cb_opts *)opts;
@@ -810,6 +804,7 @@ static void drop_on_lookup(const struct test *t)
 	struct sockaddr_storage dst = {};
 	int client_fd, server_fd, err;
 	struct bpf_link *lookup_link;
+	socklen_t len;
 	ssize_t n;
 
 	lookup_link = attach_lookup_prog(t->lookup_prog);
@@ -825,10 +820,10 @@ static void drop_on_lookup(const struct test *t)
 	if (!ASSERT_OK_FD(client_fd, "client_socket"))
 		goto close_srv;
 
-	err = make_sockaddr(family, t->connect_to.ip, t->connect_to.port, &dst, NULL);
+	err = make_sockaddr(family, t->connect_to.ip, t->connect_to.port, &dst, &len);
 	if (!ASSERT_OK(err, "make_sockaddr"))
 		goto close_all;
-	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
+	err = connect(client_fd, (void *)&dst, len);
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client_fd);
 		if (err)
@@ -927,6 +922,7 @@ static void drop_on_reuseport(const struct test *t)
 	struct sockaddr_storage dst = { 0 };
 	int client, server1, server2, err;
 	struct bpf_link *lookup_link;
+	socklen_t len;
 	ssize_t n;
 
 	lookup_link = attach_lookup_prog(t->lookup_prog);
@@ -952,10 +948,10 @@ static void drop_on_reuseport(const struct test *t)
 	if (!ASSERT_OK_FD(client, "client_socket"))
 		goto close_srv2;
 
-	err = make_sockaddr(family, t->connect_to.ip, t->connect_to.port, &dst, NULL);
+	err = make_sockaddr(family, t->connect_to.ip, t->connect_to.port, &dst, &len);
 	if (!ASSERT_OK(err, "make_sockaddr"))
 		goto close_all;
-	err = connect(client, (void *)&dst, inetaddr_len(&dst));
+	err = connect(client, (void *)&dst, len);
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client);
 		if (err)
@@ -1169,6 +1165,7 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	int map_fd, server_fd, client_fd;
 	struct bpf_link *link1, *link2;
 	int prog_idx, done, err;
+	socklen_t len;
 
 	map_fd = bpf_map__fd(t->run_map);
 
@@ -1202,10 +1199,10 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	if (!ASSERT_OK_FD(client_fd, "client_socket"))
 		goto out_close_server;
 
-	err = make_sockaddr(AF_INET, EXT_IP4, EXT_PORT, &dst, NULL);
+	err = make_sockaddr(AF_INET, EXT_IP4, EXT_PORT, &dst, &len);
 	if (!ASSERT_OK(err, "make_sockaddr"))
 		goto out_close_client;
-	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
+	err = connect(client_fd, (void *)&dst, len);
 	if (CHECK(err && !t->expect_errno, "connect",
 		  "unexpected error %d\n", errno))
 		goto out_close_client;
-- 
2.43.0


