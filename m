Return-Path: <linux-kselftest+bounces-8688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EAC8AE259
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 12:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37A52836BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEEB537E7;
	Tue, 23 Apr 2024 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T25OxCB9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635A50279;
	Tue, 23 Apr 2024 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868568; cv=none; b=FlOZpg3pDms49XRgrlXmQzEeBVwgtpqIQW34ZmRbiz/qoHlWJFWEFWi7NJCXJBV7aKZvpiIBMSdTz3VwGMg39SjS1IYzSxvu8IJB8Q2QPG3vfcdBRgqc+Zy7cPyjevOdFVDHkPBF054iKYZfs5Qv3Jh4m5dcalu5pmPAM1vxVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868568; c=relaxed/simple;
	bh=jrl1Q8k60ciLPsX20sgnJKGF7MqpxZTGU0gS0o+suss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UsI0LyrZo70TuVV1EBVk3+Hb0HtIZdbbcL7y1JmCvL9NuSIz+fMlvDDA+03H0ousrUo7coIgI5rwUTLd5Pak7JAULf457uJmhAq9C5XKxeUyTbc5MOMTPdORxr2b+DHGDBIOeJn6d8v+8srr0oNrelodQCGGgyBJ51T651Kw3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T25OxCB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FC6C32783;
	Tue, 23 Apr 2024 10:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713868568;
	bh=jrl1Q8k60ciLPsX20sgnJKGF7MqpxZTGU0gS0o+suss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T25OxCB9CxLb7+ZMZtYK3/qSBkLuuvBGQAzHqKdCU/RDQNG5VCag1gjjILOOX8STA
	 lYy6G9SxLXZ+aUYqgVEtFVFtzGITX58JaXyD+iYoMGlwPZxjerhsb7QIUs+H7cijui
	 a6k2VZqzKNS0gNPCtRh6LHSzlPEJdrn3xOSBu7qgQwqLnn4tPx6rQyEPcCv8UB33Sb
	 NXg7IkTuleb3mtW+A3vPy28Aid2+rsG1AAT9Kpe3qcLYUh6Yho3pK9URBgKxObjH8w
	 ZEc40xdAh1nJwpevn1IxuysmplRdapkJ07M1LlHwlVFO8wxJosbEY4glvoCmeZAs1v
	 z4wYKwpp5aKhg==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: Use connect_to_addr in test_sock_addr
Date: Tue, 23 Apr 2024 18:35:30 +0800
Message-Id: <f263797712d93fdfaf2943585c5dfae56714a00b.1713868264.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713868264.git.tanggeliang@kylinos.cn>
References: <cover.1713868264.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public network helper connect_to_addr() exported in
network_helpers.h instead of the local defined function connect_to_server()
in test_sock_addr.c. This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sock_addr.c | 36 ++------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index ca4fb142b7b7..2e29dd9d8fc3 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -940,38 +940,6 @@ static int cmp_peer_addr(int sock1, const struct sockaddr_storage *addr2)
 	return cmp_sock_addr(getpeername, sock1, addr2, /*cmp_port*/ 1);
 }
 
-static int connect_to_server(int type, const struct sockaddr_storage *addr,
-			     socklen_t addr_len)
-{
-	int domain;
-	int fd = -1;
-
-	domain = addr->ss_family;
-
-	if (domain != AF_INET && domain != AF_INET6) {
-		log_err("Unsupported address family");
-		goto err;
-	}
-
-	fd = socket(domain, type, 0);
-	if (fd == -1) {
-		log_err("Failed to create client socket");
-		goto err;
-	}
-
-	if (connect(fd, (const struct sockaddr *)addr, addr_len) == -1) {
-		log_err("Fail to connect to server");
-		goto err;
-	}
-
-	goto out;
-err:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
-
 int init_pktinfo(int domain, struct cmsghdr *cmsg)
 {
 	struct in6_pktinfo *pktinfo6;
@@ -1156,7 +1124,7 @@ static int run_bind_test_case(const struct sock_addr_test *test)
 		goto err;
 
 	/* Try to connect to server just in case */
-	clientfd = connect_to_server(test->type, &expected_addr, addr_len);
+	clientfd = connect_to_addr(test->type, &expected_addr, addr_len, NULL);
 	if (clientfd == -1)
 		goto err;
 
@@ -1188,7 +1156,7 @@ static int run_connect_test_case(const struct sock_addr_test *test)
 	if (servfd == -1)
 		goto err;
 
-	clientfd = connect_to_server(test->type, &requested_addr, addr_len);
+	clientfd = connect_to_addr(test->type, &requested_addr, addr_len, NULL);
 	if (clientfd == -1)
 		goto err;
 
-- 
2.40.1


