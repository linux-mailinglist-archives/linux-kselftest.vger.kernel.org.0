Return-Path: <linux-kselftest+bounces-7656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89FC8A0540
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3341BB23C5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79988604CE;
	Thu, 11 Apr 2024 01:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCGlJ73o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC3EEB5;
	Thu, 11 Apr 2024 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797478; cv=none; b=q6M5n5mtcO9RZIbzdnxl7Jf6oZkZdY08RCvMKlYcxcbZBPkcokyTuXdOuvC1iwLqqePq5kU7iw3a+q+zxSsjR7TC+Ht37Opg+acnlFn8INmesizd4XR1xl0WCeQEFhxazx46DbiF4XbYiii7w6lOQqsYFhRamnfdUcUrnimUds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797478; c=relaxed/simple;
	bh=Pz4ujWmcp2brvLUaNw44/Jpxi7AGSx14STq9+IUuYNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KKj3EdwX4pHlYFJDq2rBJcforacG4I/8CzxbQnuEbTFnlNUxpaWfTxXapYFRVsDhYPzojdPFy+gp+wgJXNDWGYJhKSmHwwrC/KeaVWI6g5AkQetLckKmoAMo5QsDiM1eJwg/+u5wLWH+We6p9ozJ9jFjS8kfpA3FAWe4WZUDpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCGlJ73o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B2DC43399;
	Thu, 11 Apr 2024 01:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712797477;
	bh=Pz4ujWmcp2brvLUaNw44/Jpxi7AGSx14STq9+IUuYNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZCGlJ73oHRuLypSwtlMZoeg2hl9Qrdb1gaEo4gDhAHiGj2KbYC525K655ZPBsx1IR
	 rG9Tcm4tXvhMs8/qT7qs4HbaxYt2DUkbC6DyOKqp7Cj7Kqp5cxH8wt9PdURQyuwVnj
	 oDaH6ig5ZgwT9TKlledWRA/VcyorumRlacm0Tx8ZrBoq/NT5UO7sgqE3tXu4phPg6C
	 upVTta2ru6+JHKvIv5GZELCveV0wVuWNwXyI6dOmX8aSrpy/GhjUff9SxYFJzkTHDc
	 O6EO/sf/aaKvuR3uLUDjEdd28p0i0b7Av5DvvU5BOAu64RHyy7vUIwNb20HbTsIwYp
	 0Ao8kJf5E5o5A==
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
Subject: [PATCH bpf-next v2 10/14] selftests/bpf: Add start_server_setsockopt helper
Date: Thu, 11 Apr 2024 09:03:18 +0800
Message-Id: <3285ff8422870c291a4d20d2f1e79fe0bc8d9557.1712796967.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712796967.git.tanggeliang@kylinos.cn>
References: <cover.1712796967.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper start_server_setsockopt(), which is a wrapper
of __start_server(), and accepts a function pointer setsockopt as a
parameter.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 6 ++++++
 tools/testing/selftests/bpf/network_helpers.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 2a389e8c2503..227ed132b84a 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -194,6 +194,12 @@ int start_server_addr(const struct sockaddr *addr, socklen_t addrlen, int type)
 	return __start_server(type, 0, addr, addrlen, 0, NULL, 0);
 }
 
+int start_server_setsockopt(const struct sockaddr *addr, socklen_t addrlen, int type,
+			    int *(*setsockopt)(int fd, int val), int val)
+{
+	return __start_server(type, 0, addr, addrlen, 0, setsockopt, val);
+}
+
 void free_fds(int *fds, unsigned int nr_close_fds)
 {
 	if (fds) {
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 738b1764f562..543295230062 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -55,6 +55,8 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms,
 			    unsigned int nr_listens);
 int start_server_addr(const struct sockaddr *addr, socklen_t addrlen, int type);
+int start_server_setsockopt(const struct sockaddr *addr, socklen_t addrlen, int type,
+			    int *(*setsockopt)(int fd, int val), int val);
 void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_addr(const struct sockaddr_storage *addr, socklen_t len, int type);
 int connect_to_fd(int server_fd, int timeout_ms);
-- 
2.40.1


