Return-Path: <linux-kselftest+bounces-12492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA8491315A
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 03:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1980A286548
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 01:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394E41FA5;
	Sat, 22 Jun 2024 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1PVbRhg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115F64404;
	Sat, 22 Jun 2024 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719019450; cv=none; b=qQR6eBuHrw6rakjYCq7lKFD+E+DxFj882vPsMKEsj2swkvG6IS0qajIxJOeBKLnnBwEb/z43rAd5Jqj8tb20uD/ytQFkqOFAnVADXX5ZQsQRXNlootzuIsCXeAMJTmxU8KiNMgudDL8+uh2g14w85A8okIxbsMt8ogPhky4Rdbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719019450; c=relaxed/simple;
	bh=rZ0OwJbHuOAuxHZEiv3dpoarwqBZUxrIq68bMu+v91Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNzo81ZRJJtYrgVa4eXes+oQra+Y/dn3hGAXWTU03WfMSqqYZPoBSTwbf5f7fMdS7Dny3slELRIPit4m7t+mewJckkIRPncfbHNJyNMXtk2zxz28Mdita6XoEbCvHCWpcc6hiJu91cisjwtMzq48qN2NDK6S6cz88N9bT5NikyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1PVbRhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F30C4AF07;
	Sat, 22 Jun 2024 01:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719019449;
	bh=rZ0OwJbHuOAuxHZEiv3dpoarwqBZUxrIq68bMu+v91Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a1PVbRhgLRrwtLRXr96acqK/3zoR1SsjSBLeWAm3r+fGEIPscTJoCOiARMA722o86
	 kr/glWF5LSGctMGS8481DXAt84WGcEMlPF1g+412/PoWxbsZcum1NDqL4Z6irsvwLJ
	 opUvvn3L+LOSQWgRTbbSPicxWEmAe3tCN9w09quFbQrximQ+2VJzvIzXTljcy+U5Zr
	 W12Bwa2T6tgYR4t3ew+Hsz4YEZMFmvGkaAOzir52J3KNLLkxhYqbpWEQUHP2epnad+
	 7V7OdN2UuWJkjefUxwNJJE5xv8kGX6unm7NPuiV0LyEOcjIERr03+LSqUXBypbIl55
	 LgAUfTQ7E4kPg==
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
Subject: [PATCH bpf-next v2 2/7] selftests/bpf: Use connect_to_fd in sockmap_ktls
Date: Sat, 22 Jun 2024 09:23:42 +0800
Message-ID: <1f6a05f89fe56725f42a4e4fba517b61067f2036.1719019125.git.tanggeliang@kylinos.cn>
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

Use public network helper connect_to_fd() instead of open-coding it in
prog_tests/sockmap_ktls.c. This can avoid duplicate code.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c        | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 9cc881b38669..68867028c432 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -21,26 +21,16 @@ static int disconnect(int fd)
 /* Disconnect (unhash) a kTLS socket after removing it from sockmap. */
 static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
 {
-	struct sockaddr_storage addr = {0};
-	socklen_t len = sizeof(addr);
 	int err, cli, srv, zero = 0;
 
 	srv = start_server(family, SOCK_STREAM, NULL, 0, 0);
 	if (srv == -1)
 		return;
 
-	err = getsockname(srv, (struct sockaddr *)&addr, &len);
-	if (!ASSERT_OK(err, "getsockopt"))
-		goto close_srv;
-
-	cli = socket(family, SOCK_STREAM, 0);
-	if (!ASSERT_GE(cli, 0, "socket"))
+	cli = connect_to_fd(srv, 0);
+	if (!ASSERT_GE(cli, 0, "connect_to_fd"))
 		goto close_srv;
 
-	err = connect(cli, (struct sockaddr *)&addr, len);
-	if (!ASSERT_OK(err, "connect"))
-		goto close_cli;
-
 	err = bpf_map_update_elem(map, &zero, &cli, 0);
 	if (!ASSERT_OK(err, "bpf_map_update_elem"))
 		goto close_cli;
-- 
2.43.0


