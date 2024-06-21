Return-Path: <linux-kselftest+bounces-12440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC0E912288
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 12:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD4B28C7EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46719171E6A;
	Fri, 21 Jun 2024 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4aLu2ZV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B40E171676;
	Fri, 21 Jun 2024 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966154; cv=none; b=q1LjnG7vVDP7ec3xYC/7xmmE0JrOYudw4SQQA0X8CpOv87hvPynNBMCG35kIiGF3j15T0HDjbBaIaUebMFIxELTTNqdaXMcwc85eHSTuOqMYrAMEJwetdAzDqAnMOeUN6ghcpC9StpfcKr9qLBlHPl0CGT6U6tAic7weWGxwCEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966154; c=relaxed/simple;
	bh=7CMKoJFRAWlWFOBTWpSXqbxq7VKgG6yr7QvPcXK6Enk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLi4aFrtQ1ceIjEStj8jlzc1j+M90pEBXEBMfrzvNMsCLviHL6vYL2xUT/CD5xIvwVt9cQyPTMIfKLqIluCdE0uk4+c7CppDsYk0I+DbBQVIX9UjnxeKbLT6XHt3cHNY8/+FKGL2aPLTItN8gsqX+0PT4vNFrE53LewWEoFmz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4aLu2ZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B95CC4AF0A;
	Fri, 21 Jun 2024 10:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718966153;
	bh=7CMKoJFRAWlWFOBTWpSXqbxq7VKgG6yr7QvPcXK6Enk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T4aLu2ZVqsdbqYYhFcgNUrrF3a6I+w/d6vtFjYTvBs7SSd5s1kE0XV4AMHBiCAmqW
	 MR+f1uHGpro5cViBopAy+nf81Ivjja7SX5s05CDi1lkj4cnR9j9YRqTt7CzoKx0NWX
	 8y3lo1QO7LNz3rGZfIm0+C1GY3IwGujglQCdv6bAOx5q0rUp8d8x+LJnUzXt9st+y/
	 Rg/4X/sEND55D59BS1LPL8EgCuuiWDy2lOylpAjdFUMaxmi2iv8RJFYId51EYfCKgM
	 n1AwNHMRmvAl5uedBN4zKUogux2Jf8WfhJLepqeKhW/r9CQ91ADp8oQJXpaaE9bJYQ
	 uC1OjsBmkUmIw==
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
Subject: [PATCH bpf-next 2/6] selftests/bpf: Use connect_to_fd in sockmap_ktls
Date: Fri, 21 Jun 2024 18:35:25 +0800
Message-ID: <86e6562a9bad3c44ce80c1c38ff27940f177651f.1718965270.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718965270.git.tanggeliang@kylinos.cn>
References: <cover.1718965270.git.tanggeliang@kylinos.cn>
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


