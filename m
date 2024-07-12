Return-Path: <linux-kselftest+bounces-13645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C71F92F5E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 09:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B901F22D34
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 07:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BCE13D62F;
	Fri, 12 Jul 2024 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHwNezvX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E913D52C;
	Fri, 12 Jul 2024 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767925; cv=none; b=JpN5EzJxm4mqRarGqxoGNJudfVi2y8Kc+EOj2yDUInoX+JU4BpW7VT/me7eV8ydotCX9aV+L/wyaRsZjZFM2gQIH2e61VK8awwreY51XhiTkEbXBaqdjtrlWQVBeaM0MzmtfzEhb8J1EgrQEA/YXzTaK88k2elGVpxh48ra34hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767925; c=relaxed/simple;
	bh=G/kYxYFWs0qBeHTh0gTZHoYfINM1UJRGucawo5aL0oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2HbH8FiwDW1aEEvDLEms/XlahFelOiliUwPw2wCPKiSwCRhwexv8VLT0YsyGtiBwTXWHh3w5CZsKWDpVE6lpnwzaj/u4OEproKFMHq6nwlTAfnjdrMGUc5qY9bWxsFsudqGCTG76KFapKElr9pCnCxI84pV0ThZu6JljnqY5/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHwNezvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E57AC3277B;
	Fri, 12 Jul 2024 07:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720767924;
	bh=G/kYxYFWs0qBeHTh0gTZHoYfINM1UJRGucawo5aL0oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qHwNezvXIYJGgRB6ALUNaMeYyBG6VzWLDnxFyom2Jj9zKDpiQ1DKIbMB23oqKYizQ
	 Hg53QeTm1+55F4jwvxlbRiriezS83YSdIvIluipeFs6jdI8a8rJ/WULfX2BF1KLfS5
	 R/NJvfdnkeA8cJrBJtaDtcqLKqB0oF29EllNfA5Mx/mzcDDNhVVmgZw3MecLZEqr0o
	 9djFewd1ZRGrBwjz4b4liXmg2k5xBoGb41dkbn1TR/wz86Iq+CLKEsCW168eeZWjTQ
	 h0DsnJqc3M+6oU5wrNZeFzykypXqeJ2V+jRudhGI1wyBhR9zuCDRO+iwpN4tc/cUnm
	 fBlg2eCeC/khg==
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
Subject: [PATCH bpf-next v2 3/5] selftests/bpf: Add connect_to_addr_str helper
Date: Fri, 12 Jul 2024 15:04:50 +0800
Message-ID: <e344b1588177b6a827145da4294bf21f96011f45.1720767414.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720767414.git.tanggeliang@kylinos.cn>
References: <cover.1720767414.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/network_helpers.c | 17 +++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 48c27c810db7..139fac70de00 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -301,6 +301,23 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	return -1;
 }
 
+int connect_to_addr_str(int family, int type, const char *addr_str, __u16 port,
+			const struct network_helper_opts *opts)
+{
+	struct sockaddr_storage addr;
+	socklen_t addrlen;
+	int err;
+
+	if (!opts)
+		opts = &default_opts;
+
+	err = make_sockaddr(family, addr_str, port, &addr, &addrlen);
+	if (err)
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


