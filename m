Return-Path: <linux-kselftest+bounces-12508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D233913730
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 03:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FAC11C20EED
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 01:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7084653;
	Sun, 23 Jun 2024 01:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSD3uVsc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133D10E4;
	Sun, 23 Jun 2024 01:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719105664; cv=none; b=txDBWhnGY8wCv6QgPa9sNsy4rsBBGHU3ivj0x3Af4LDOprpU9hjjcRMt3Mp/uRj6vDKvmtrY370Go7vc6sQIFRul8Cwkvqt/OKM6S0+zB5wgykb6qy64jcHocrUEbUJJIUA917BBRj8mUxF3ZPwWKfbBSQ9tMvdf7Z2QTWuiDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719105664; c=relaxed/simple;
	bh=BjQ5/tmBwgON0M53VKil/t5eyQrCC3L1Lla7CBl+1EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQ6QGnLgyRCW+pJJxCz7StxIqczI7TsSmSicKSRg4XwuopbTaG7+fyrY86F/sxFVKj11qtZ2ikA9jrNONBQ2zTD7wCLmnDH8d31/O1xniYC/ZqONeAapPfxoPNjZvMkt7dpjNZ5BdBwdL3raWkzr+6889jET2BdwVKSmU8XHvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSD3uVsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5104C32789;
	Sun, 23 Jun 2024 01:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719105664;
	bh=BjQ5/tmBwgON0M53VKil/t5eyQrCC3L1Lla7CBl+1EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSD3uVscmHLc7a1nAx6B4+0w79ro36LocEMV3LmN8pcqixPnxyn5UjiRlNFIuB4VY
	 EpHiD18uSBLz363l2v6G1y5fu6bephSjL3sNwyFYxPUcd0XtCMcDXJ64TdokgwER7n
	 N+FMzv7pXYfZCx2+bxZ08ue882tDBhfeDu0XOreql9o1ll2Om0gNwVSUb2xRYtPjlQ
	 YkQlhKlZS/tqs9MDhTA9R3RhSx2oOfM6so2KiKqBp+fYVa5DstZ1GLl57X6fI4EK2O
	 ZbyU3xm2x7N/gJrwsuaCkKd3CwLp8WsEUzch2NaMu2J3lvJE+Zpkrccj5QMa6ep03i
	 AScf96/pfO6Ag==
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
Subject: [PATCH bpf-next v3 6/8] selftests/bpf: Use connect_to_addr in sk_lookup
Date: Sun, 23 Jun 2024 09:20:00 +0800
Message-ID: <91551dc5eb799941438e3a4efc174e1cd7bf3033.1719105178.git.tanggeliang@kylinos.cn>
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

Use public network helpers make_sockaddr() and connect_to_addr() instead
of using the local defined function make_socket() and connect().

This make_socket() can be dropped latter.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 20 +++++++------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 4a4fc22ed0d2..ba386484f785 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -230,23 +230,17 @@ static int make_server(int sotype, const char *ip, int port,
 
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


