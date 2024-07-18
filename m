Return-Path: <linux-kselftest+bounces-13869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24E6934804
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 08:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475111F21A63
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 06:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4F76CDCC;
	Thu, 18 Jul 2024 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihaiFb8F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1428B6BB4B;
	Thu, 18 Jul 2024 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721283810; cv=none; b=D6mQ4HRnrdCx/T3159w8vks2qAzGwYzsTv2h7+y29e79V7D5j0KcHj/66ja3svjrXujORx9+cWhyGer6tbWitCred+h2Rco98WQuBjNvh3eLZk6U1JKNu2Q6jp0T3N+/ZPs+/e+XiX1ICE4utCRHe7jhxKQxOIzKC+WwJvvMuEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721283810; c=relaxed/simple;
	bh=5fMCJ0BD5aW4CguVh1SsSPVVZwwEweUrXtzIxCkROzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFsZDso0anLTj5UmJ8gNN6RRt7qNEkDULSOZyOGtwSBqdh2v8zowqxqWRGhrGzN8QTwnEMuVGfmc6knSmqZF4gchK8bbiDNx87jIkKvejh7/yHoXRy4VMhN0SuhP2hkr8e5fQmNKMhIQ/A7GwQiYn/XXIqoguHdy192iAulo6oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihaiFb8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EC3C4AF0D;
	Thu, 18 Jul 2024 06:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721283809;
	bh=5fMCJ0BD5aW4CguVh1SsSPVVZwwEweUrXtzIxCkROzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ihaiFb8FP2K7vg+BeTqZSySGU/994m/7rxD+mYaIhGVSqt6YcRVMgsmLwWTM5gjqP
	 JK6QJYhDf2IuI4JFJdkXny1djAOL8REAY0KGdcakKWnkmp4IWC1vQBYXrMNBPgFJy7
	 xkTs2KSnYYCWocWqCnpRtJ4apwJvOhsUZYeTR6zxiDdvsR/EyfSQ1ablPQANtCsn6g
	 Pc0+430/CIwnF+icG/s5dT7/brAqfMB4bPU18xaApeMz4TNgxYsdNFCdIg4XoYbbNK
	 eGHCd3RmkNPsCMjXplAyw2uN+UTIpL2gQJKW5CfU5BLwGnouevWP5cpwTFlfcNJYnv
	 Iv3YJLe4iBOSQ==
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
	linux-kselftest@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 3/5] selftests/bpf: Add connect_to_addr_str helper
Date: Thu, 18 Jul 2024 14:22:31 +0800
Message-ID: <647e82170831558dbde132a7a3d86df660dba2c4.1721282219.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721282219.git.tanggeliang@kylinos.cn>
References: <cover.1721282219.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to connect_to_addr() helper for connecting to a server with the
given sockaddr_storage type address, this patch adds a new helper named
connect_to_addr_str() for connecting to a server with the given string
type address "addr_str", together with its "family" and "port" as other
parameters of connect_to_addr_str().

In connect_to_addr_str(), the parameters "family", "addr_str" and "port"
are used to create a sockaddr_storage type address "addr" by invoking
make_sockaddr(). Then pass this "addr" together with "addrlen", "type"
and "opts" to connect_to_addr().

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 15 +++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 48c27c810db7..a71af637bcbc 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -301,6 +301,21 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	return -1;
 }
 
+int connect_to_addr_str(int family, int type, const char *addr_str, __u16 port,
+			const struct network_helper_opts *opts)
+{
+	struct sockaddr_storage addr;
+	socklen_t addrlen;
+
+	if (!opts)
+		opts = &default_opts;
+
+	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
+		return -1;
+
+	return connect_to_addr(type, &addr, addrlen, opts);
+}
+
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index f39eeb5a4594..cce56955371f 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -69,6 +69,8 @@ int client_socket(int family, int type,
 		  const struct network_helper_opts *opts);
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
 		    const struct network_helper_opts *opts);
+int connect_to_addr_str(int family, int type, const char *addr_str, __u16 port,
+			const struct network_helper_opts *opts);
 int connect_to_fd(int server_fd, int timeout_ms);
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
-- 
2.43.0


