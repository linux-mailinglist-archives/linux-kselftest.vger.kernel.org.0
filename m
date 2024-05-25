Return-Path: <linux-kselftest+bounces-10692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB828CEED2
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 14:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87BF0B210D4
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 12:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07023F9E8;
	Sat, 25 May 2024 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7a71Kfy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FD018044;
	Sat, 25 May 2024 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638920; cv=none; b=TNIcEcsvdZSOOy2yAFEFDAN+B5qwlUsor5VE8pXvedc5Exga5/n//f8f2su1YhjvZ3ZLMUGspUSGwpgLDl4IQZQCXu4zyW3gqKPKoWXrr4FtlQragGEtunK8h4fsRTmhhRYKBHdn9acwHQrVkBU4f0XKzp8/pLQxz4+5wBT/X4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638920; c=relaxed/simple;
	bh=394h3Q9cvyh41rfbfaAmL8bMBRnTOy6D4vSWMspn9Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uxg8w+eoOM7F0lEt8uOwA4B38PZC1Vq6Eafkt5EroZNEGrXhkJQb5fVa0axBy3j6L0Q7GLNYeiWd/CiWgZY4C80b3GZiqt9nv2MfDzeAgmlPH1xAZ4HZzQCzQup5v3UxyhxASYNM1fqL6gojgmGEB2iZECMDH5vTk19oJ2NtysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7a71Kfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545A0C2BD11;
	Sat, 25 May 2024 12:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716638920;
	bh=394h3Q9cvyh41rfbfaAmL8bMBRnTOy6D4vSWMspn9Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7a71KfyXHUfGl4iufL+H+I/CM4W6R0KfusBc1vf6GvDbfT/z3f8+Y4zxNlU7Z3on
	 YawKeS6ZpK4iF67+Al9SpIbD6WXNHBJ+V+79jDPktXihDUYrKXIKE+HXSaKBFEVWPw
	 mAYUMu8zaXbQVFz55jSGzxWJdHjOGB7vup4aoQl7I28Hlf65UqQ1Gm0HLgncLRp5eE
	 L/Y9nAbofmBxeOdlROBktgM4WWFQTehwBJWumo0WVGYivaiSE/1G2AagLIZSubyUJq
	 AowUb/myi2ygiYfixnhCWvKuzWh9AW9qkxNikh3/EtcTFF97g9Vw7qq/GQ4K9nl+uk
	 g0XVQKiNIyq2Q==
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
Subject: [PATCH bpf-next v5 2/7] selftests/bpf: Add start_server_str helper
Date: Sat, 25 May 2024 20:08:16 +0800
Message-ID: <606e6cfd7e1aff8bc51ede49862eed0802e52170.1716638248.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716638248.git.tanggeliang@kylinos.cn>
References: <cover.1716638248.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

It's a tech debt that start_server() does not take the "opts" argument.
It's pretty handy to have start_server() as a helper that takes string
address.

So this patch creates a new helper start_server_str(). Then start_server()
can be a wrapper of it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 22 ++++++++++++++-----
 tools/testing/selftests/bpf/network_helpers.h |  2 ++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 4d776b78929c..0e8266f439e4 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -118,19 +118,29 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
 	return -1;
 }
 
-int start_server(int family, int type, const char *addr_str, __u16 port,
-		 int timeout_ms)
+int start_server_str(int family, int type, const char *addr_str, __u16 port,
+		     const struct network_helper_opts *opts)
 {
-	struct network_helper_opts opts = {
-		.timeout_ms	= timeout_ms,
-	};
 	struct sockaddr_storage addr;
 	socklen_t addrlen;
 
+	if (!opts)
+		opts = &default_opts;
+
 	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
 		return -1;
 
-	return __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
+	return __start_server(type, (struct sockaddr *)&addr, addrlen, opts);
+}
+
+int start_server(int family, int type, const char *addr_str, __u16 port,
+		 int timeout_ms)
+{
+	struct network_helper_opts opts = {
+		.timeout_ms	= timeout_ms,
+	};
+
+	return start_server_str(family, type, addr_str, port, &opts);
 }
 
 static int reuseport_cb(int fd, void *opts)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 40011e0f584b..4e3e6afe7d3a 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -48,6 +48,8 @@ struct ipv6_packet {
 extern struct ipv6_packet pkt_v6;
 
 int settimeo(int fd, int timeout_ms);
+int start_server_str(int family, int type, const char *addr_str, __u16 port,
+		     const struct network_helper_opts *opts);
 int start_server(int family, int type, const char *addr, __u16 port,
 		 int timeout_ms);
 int *start_reuseport_server(int family, int type, const char *addr_str,
-- 
2.43.0


