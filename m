Return-Path: <linux-kselftest+bounces-13355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BFB92B380
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 11:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7F6282EC2
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 09:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE3D154433;
	Tue,  9 Jul 2024 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skYe6Szd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347BD15383C;
	Tue,  9 Jul 2024 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516648; cv=none; b=aHnAKXEXGtNQ9SULC2UJyTol8mRd5xsK1nhOMBSYP5ja4+QwJeXZLlGDXemPwiDyAulpQxKeUhIbY5eo+4W/cOzQ0htjX2i/5ZdI9iKG8SFPrUoHsNWJLVIRnpnM655RaFys8tnWh4mKVRObSKPcw6qFxWVHKFjPUsNgK9K72Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516648; c=relaxed/simple;
	bh=6OiEDsf7O33EMz4IPGSykQE7yUi/sOdP2yVB48lXWLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6QFGuH+ZyJbJss5BRNGo5tDBfg4WHtGEfqu3lG7w9Qifhk8n3zgU0NuMFXdqNXWYkyEjakA4MdGepXQsE/k3QLj6CC7QoT8WcCDu9kQOq9Ifqx8ki/XdNS8L0ulYfBHFO1Ue51qz1aSsmBVcbFiznFxRgzKtDRafgal+a01Kp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skYe6Szd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B67C4AF0B;
	Tue,  9 Jul 2024 09:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720516648;
	bh=6OiEDsf7O33EMz4IPGSykQE7yUi/sOdP2yVB48lXWLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skYe6SzdnGQ9zt1iEXR9AbIB8DgBdr+j09iCucGo4nTBQq77plxTr91dATnr+Vem5
	 rbPNgT49qmAAMCZ8mvGHDJX7BHKWMp2Kbfc2Xu7WKXj9DO76ia5W5AUvJtvVtCm1K1
	 WxqdCKa4Uat94mTWbko+O8rx9AtTsF/XtPaH0gxNbbp/l9XfcBwkSF+sf1cqoBgvn6
	 SPrXw7H4ijRfRZA41+7fFt+kCEeiWtlqnLDY+lkYT138K7IWlXc9xzGAiRsvHn+enw
	 hfyNhkcP5ULnl6tjzSTn30IRaWfDgpwqLoCR+WMx8lTk6tcEqz7HyoJoJcPSKTZIUq
	 gUo8GVyk0unHw==
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
Subject: [PATCH bpf-next v11 7/9] selftests/bpf: Add connect_fd_to_addr_str helper
Date: Tue,  9 Jul 2024 17:16:23 +0800
Message-ID: <96f04aa5677d628ad5eae1981565b24bf94c9d77.1720515893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720515893.git.tanggeliang@kylinos.cn>
References: <cover.1720515893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to connect_fd_to_fd() helper to connect from a client fd to a
server fd, this patch adds a new helper connect_fd_to_addr_str() to connect
from a client fd to a server address. It accepts the server address string
"addr_str", together with the server family, type and port, as parameters
instead of using a "server_fd" like connect_fd_to_fd().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 21 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index e0cba4178e41..9758e707b859 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -388,6 +388,27 @@ int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
 	return 0;
 }
 
+int connect_fd_to_addr_str(int client_fd, int family, int type,
+			   const char *addr_str, __u16 port,
+			   const struct network_helper_opts *opts)
+{
+	struct sockaddr_storage addr;
+	socklen_t len;
+
+	if (!opts)
+		opts = &default_opts;
+
+	if (settimeo(client_fd, opts->timeout_ms))
+		return -1;
+
+	if (make_sockaddr(family, addr_str, port, &addr, &len)) {
+		log_err("Failed to make server addr");
+		return -1;
+	}
+
+	return connect_fd_to_addr(client_fd, &addr, len, false);
+}
+
 int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len)
 {
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 4f26bfc2dbf5..43526271366f 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -67,6 +67,9 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len
 int connect_to_fd(int server_fd, int timeout_ms);
 int connect_to_fd_opts(int server_fd, int type, const struct network_helper_opts *opts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
+int connect_fd_to_addr_str(int client_fd, int family, int type,
+			   const char *addr_str, __u16 port,
+			   const struct network_helper_opts *opts);
 int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
 		     int timeout_ms);
 int make_sockaddr(int family, const char *addr_str, __u16 port,
-- 
2.43.0


