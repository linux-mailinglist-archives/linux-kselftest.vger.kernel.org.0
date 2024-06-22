Return-Path: <linux-kselftest+bounces-12495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDFC913161
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 03:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF52A286736
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 01:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F674A07;
	Sat, 22 Jun 2024 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="au1encha"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECDA4404;
	Sat, 22 Jun 2024 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719019463; cv=none; b=nEo8Oi0DzY7DTynjGi6yNHkWmKbQYLRslKXhJC3smXqr9HIM0/sTf8zUWOfqt/9+AR5y+eACf9wF71iUPK5N5RlPOt5IvBlDWcfXfdDiqU96mweheT1DL5kxZ9BgTJP8LiFLXLGl2YN2qfBVb308y0ThfVD8RqUPvnRMVOGYYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719019463; c=relaxed/simple;
	bh=BjQ5/tmBwgON0M53VKil/t5eyQrCC3L1Lla7CBl+1EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlRteGNvz1fxqXhMlgd+bJOtvpJyMDjFkWZ17IjolHkZdOUbd+TMzY2IzRK1PM3zC5RI/iRyp0bR9E7DT0w99R1BGiNInA4ynU7Z5devN+LjsfKllCPbsN2pEK0gkj/SLUqThiDZIHLyiU9+1GpWjf4WI99K6cjCDOV60EWXnwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=au1encha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47672C4AF0B;
	Sat, 22 Jun 2024 01:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719019463;
	bh=BjQ5/tmBwgON0M53VKil/t5eyQrCC3L1Lla7CBl+1EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=au1enchaWfdwxhxfBZW2kHw/3+SMz/4o+4mVwI8/LkW/CRdbF3kKJRSxqWZAdjZbt
	 Laxj2iIncAj0/E5RBn0uJZiGCYjqXyduag56aKJ7/LtTOu+5o2fze2QWDu5M+s0zQE
	 ibi8M5QS0E6hcUJhfJ/xE4b7a8Yin+1IQ5vLIow6dvMUOZBRVqJHIG3LZEl9tk6HxW
	 hP/hIRgpDs5MbaBSn8waeCUpMcAVS/MyDAR/Cx84Feim/UVJ22yJ3O+rQTONC/cLDa
	 XQYY5+roYMcekquGHRgCe2iPLPKUNr7bRCEWZG5vHPhSR45pNDAYx6mZXZyK17TSNv
	 ftbj6lQ5v5CbQ==
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
Subject: [PATCH bpf-next v2 5/7] selftests/bpf: Use connect_to_addr in sk_lookup
Date: Sat, 22 Jun 2024 09:23:45 +0800
Message-ID: <bb4d6006afc3b26f082b96eab79e38e1d835d482.1719019125.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719019125.git.tanggeliang@kylinos.cn>
References: <cover.1719019125.git.tanggeliang@kylinos.cn>
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


