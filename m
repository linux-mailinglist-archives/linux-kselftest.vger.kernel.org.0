Return-Path: <linux-kselftest+bounces-12963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 674CE91CA04
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 03:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2061A1F2315A
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 01:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CBF1C17;
	Sat, 29 Jun 2024 01:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ia8XmHlu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62A386;
	Sat, 29 Jun 2024 01:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719624075; cv=none; b=nropUq1Sryo5dNy0qDc8G3K4t47w+3nrG6plhgMWmbf7JGIMDC9bgLA9HbPrFftHbbuqXtuDWp13N3qESCYiOaqhR+T0/WIRWQ6jo5lX0+pdu0X4a9VfcIK3bTgMZEp8U/GvY7bTf5Rw8o8cVhNu88exHfMXhpSj1MsZqmzY8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719624075; c=relaxed/simple;
	bh=waBpOVBBTtv22Hz1oPTjYfI552tMcY2GrZ7PLsZ6UaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQ/WiEpSj3xxDFmwRWUB4kwxf55aL5MrPBu/H67VtXu7YdHPxngkyxaZnV4cvxhIVB2/e4161AnzEBADovBVH3i5BsjJ7tHWdZKrpVoEEK3wit7GJ5v7DuJAOhUKrLxyfiNiyFMP92dBXy4MSGSCSymOxzUjJ+Ejyo4HDZ5dulg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ia8XmHlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5D4C32789;
	Sat, 29 Jun 2024 01:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719624075;
	bh=waBpOVBBTtv22Hz1oPTjYfI552tMcY2GrZ7PLsZ6UaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ia8XmHluV1NxM4db29o/VioK1hwZKkCKCJIG2NezIId3Uw2UrlCEIEFl+K6sc36Ku
	 +lgz57tqyVFclt6ek48A6zXBNSJOmFjI9twwgdurudBX7T4op7x93T8YrOQ4W808qW
	 ieoq5HjBmN3iSSZ/hEYkA/Ah59TzVop9ruAtRNv/Zr9G2suIOyxcyBuSn3lqSJ2GY0
	 5hhioB3nCK+eG3eRp90LYcNi3yr7bCSScijCuaay+I0LJZIjtDPTNZd+oMO9t6U4uI
	 sXHmj339oWh3KrTFcRUaPTO3Mx9JVXe70U8F7Y18xfrsOmGrCYuC5t8SG0LbGF+Ui7
	 MfMNVMPbEdEDg==
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
Subject: [PATCH bpf-next v6 8/9] selftests/bpf: Use connect_to_addr in sk_lookup
Date: Sat, 29 Jun 2024 09:20:18 +0800
Message-ID: <d5caa0c6f5912a67876c250214a84b0dcd4f74e0.1719623708.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719623708.git.tanggeliang@kylinos.cn>
References: <cover.1719623708.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use public network helpers make_sockaddr() and connect_to_addr() instead
of using the local defined function make_socket() and connect().

This make_socket() can be dropped latter.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 20 +++++++------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 38382dffe997..005776f5964e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -231,23 +231,17 @@ static int make_server(int sotype, const char *ip, int port,
 
 static int make_client(int sotype, const char *ip, int port)
 {
+	int family = is_ipv6(ip) ? AF_INET6 : AF_INET;
+	struct network_helper_opts opts = {
+		.timeout_ms = IO_TIMEOUT_SEC,
+	};
 	struct sockaddr_storage addr = {0};
-	int err, fd;
+	socklen_t len;
 
-	fd = make_socket(sotype, ip, port, &addr);
-	if (fd < 0)
+	if (make_sockaddr(family, ip, port, &addr, &len))
 		return -1;
 
-	err = connect(fd, (void *)&addr, inetaddr_len(&addr));
-	if (CHECK(err, "make_client", "connect")) {
-		log_err("failed to connect client socket");
-		goto fail;
-	}
-
-	return fd;
-fail:
-	close(fd);
-	return -1;
+	return connect_to_addr(sotype, &addr, len, &opts);
 }
 
 static __u64 socket_cookie(int fd)
-- 
2.43.0


