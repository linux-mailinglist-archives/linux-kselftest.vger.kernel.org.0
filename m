Return-Path: <linux-kselftest+bounces-12509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE556913731
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 03:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241941C20FA9
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 01:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C937653;
	Sun, 23 Jun 2024 01:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Daeo5J0u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6363B;
	Sun, 23 Jun 2024 01:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719105669; cv=none; b=cVXHppWqq6Eib5AvEZOKCeSkasA9zrepIkDIMLVRY9troO1rZ+rIV6Sul7olzqTdXPU8jnHULD7Nc+HZmDjPFIPJ1yXOxZyXGq/SKKKPmdJPbyrCqQ+paVFcGL0WE7GVGYixD2Y4TEXcXti/RTPQAdAd/u7MeX/tb7uR13cmKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719105669; c=relaxed/simple;
	bh=Uv3Veawq41cRk7HDSAwkwv8rOMzc6SdcshDahoslgfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxPRkvMKMVVwOe7wK57vTPfQmFedpfpMz6EuerTgZfa2aPQH5Mo8UG8J14lM8hT9/CiuC9xAlRDVuwcF3G1tDAfUkKB8E4CQ48aIUdpLbB3EvbFxTnkrt3flG1rvlbVfSuJ9QQtcv08NvPyjYnxQINepNoEYzyp8tzIJTbZvtUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Daeo5J0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2284CC32789;
	Sun, 23 Jun 2024 01:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719105669;
	bh=Uv3Veawq41cRk7HDSAwkwv8rOMzc6SdcshDahoslgfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Daeo5J0urXMVUmgNsk7UGJzeeq6RGu5YWOHz779XTK6KH1MdYuUyv0f0XsfVmMvif
	 XV1BPugPctD8uqKcX8ibormb5bwlkTANOD0Fkw0qDseB4YL3Ejw+iTtWYZgxQNZ2Pd
	 zD4rU6jfyBjcZ8nWzs88TAjbbeScU2hAF5xwApRKg+eC8lmLT89pA3ctdUzAozYrTV
	 5ufFjNGz5AbjV0Oc9BlvquA6Zj7iWfA7PGVCbL55PJMWe+/cnRJxyL9Dh90y2bUSSV
	 otABEfJT9rOinodPeNOZFY+r7dybaz74OfBB0KLeQ7YMOJWY7UlpafwxgOsQt+7K6s
	 87HGMAOrXe8lw==
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
Subject: [PATCH bpf-next v3 7/8] selftests/bpf: Drop inetaddr_len in sk_lookup
Date: Sun, 23 Jun 2024 09:20:01 +0800
Message-ID: <cd6d2eb7e23db6274fd2f2246bc13122806ffa14.1719105178.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719105178.git.tanggeliang@kylinos.cn>
References: <cover.1719105178.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new parameter "len" for make_socket() to get the length
of the address by make_sockaddr(), then local helper inetaddr_len() can be
dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/sk_lookup.c  | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index ba386484f785..d3821bf350a1 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -108,20 +108,14 @@ static int attach_reuseport(int sock_fd, struct bpf_program *reuseport_prog)
 	return 0;
 }
 
-static socklen_t inetaddr_len(const struct sockaddr_storage *addr)
-{
-	return (addr->ss_family == AF_INET ? sizeof(struct sockaddr_in) :
-		addr->ss_family == AF_INET6 ? sizeof(struct sockaddr_in6) : 0);
-}
-
 static int make_socket(int sotype, const char *ip, int port,
-		       struct sockaddr_storage *addr)
+		       struct sockaddr_storage *addr, socklen_t *len)
 {
 	struct timeval timeo = { .tv_sec = IO_TIMEOUT_SEC };
 	int err, family, fd;
 
 	family = is_ipv6(ip) ? AF_INET6 : AF_INET;
-	err = make_sockaddr(family, ip, port, addr, NULL);
+	err = make_sockaddr(family, ip, port, addr, len);
 	if (CHECK(err, "make_address", "failed\n"))
 		return -1;
 
@@ -1220,6 +1214,7 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	int map_fd, server_fd, client_fd;
 	struct bpf_link *link1, *link2;
 	int prog_idx, done, err;
+	socklen_t len;
 
 	map_fd = bpf_map__fd(t->run_map);
 
@@ -1249,11 +1244,11 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	if (err)
 		goto out_close_server;
 
-	client_fd = make_socket(SOCK_STREAM, EXT_IP4, EXT_PORT, &dst);
+	client_fd = make_socket(SOCK_STREAM, EXT_IP4, EXT_PORT, &dst, &len);
 	if (client_fd < 0)
 		goto out_close_server;
 
-	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
+	err = connect(client_fd, (void *)&dst, len);
 	if (CHECK(err && !t->expect_errno, "connect",
 		  "unexpected error %d\n", errno))
 		goto out_close_client;
-- 
2.43.0


