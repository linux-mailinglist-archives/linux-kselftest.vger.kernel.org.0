Return-Path: <linux-kselftest+bounces-12616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA767915E50
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 07:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85921283B28
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 05:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC05D145B22;
	Tue, 25 Jun 2024 05:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meJQzTuZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDE145B17;
	Tue, 25 Jun 2024 05:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294208; cv=none; b=EMLRA0USSyeK68G9/yW43vBdjUnylQPPXjDJqp/f+fAESQbNmmPhpe1JiUoUESQr6AC7M/SU2EQk94XmHWJpHNBxTUVbImnQLB24P0MwzZr5TGFhFK6j1DqhOO/xeII2IZdTrwXM6HfuWPAjoEyTJ5Ua/bjqvnB5QyYZLwzzwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294208; c=relaxed/simple;
	bh=PI14D7VZXKcZqKqwI2/KA1DL1Lba3ri2NiyiGdCKagk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpwYW3qydkslVbQ+UKxPMFHSW6BL//w4IQQ6jKKCu/V+3vlB0pr5trisi3+7xvdYWh6QhIJejKDFJ8FKzReni/Z3FgbX3sA+JsV+O191GrqnrJK3DKWo5sr5sL15gqnsqzZ9FiwP3kcsSWvB4KO9lfDts029L4tJe2I17+2aYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meJQzTuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2105C32782;
	Tue, 25 Jun 2024 05:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719294208;
	bh=PI14D7VZXKcZqKqwI2/KA1DL1Lba3ri2NiyiGdCKagk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meJQzTuZ7ZEuvF10bQENIFtOjWHpm9fEmu8IPIw3UnrLRQ3VwIsTHkMJjTROuKfTQ
	 mcFhJjDuJpSnRMqRc6vNXZvxafzqxGD0h1WfrfYl/czL8dmvywkb0LY7cjXhySFryI
	 /XA+vauD5n3rIRpTzrK2KEvqfDjORZPBlzUjpRjC5eeGsAZ2XOse461u6k3B7eYJ9S
	 9lcRMHD8ZaIhPPQz2lMmYQvUMllUWjQmGP3hn0/S0YY3yksTENkyUCQ8XAf5jLtdVw
	 ryhoSQV3j4z2cY8Ppu84cIZ9ik/uDpLN5GHav97tn4LYmscNzdr3LfQi+wM0CPFo+k
	 NG4fFxxH3uWXg==
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
Subject: [PATCH bpf-next v5 8/9] selftests/bpf: Use connect_to_addr in sk_lookup
Date: Tue, 25 Jun 2024 13:42:35 +0800
Message-ID: <8dd254c64f199027320cd752e5391d46ae8ea01f.1719293738.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719293738.git.tanggeliang@kylinos.cn>
References: <cover.1719293738.git.tanggeliang@kylinos.cn>
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
index 5a8b4ef876ef..5839ed25e94c 100644
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


