Return-Path: <linux-kselftest+bounces-13536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0971392DE98
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 04:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF011C215F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 02:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6661EBE49;
	Thu, 11 Jul 2024 02:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieiiNMo4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C0101E4;
	Thu, 11 Jul 2024 02:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720666408; cv=none; b=cC5ow5thgZ88h9o7BOTZWwoKBsw4gQbq8sG1Nh9pAjWloIxapbd1tin6Rq6hGd0b6jWAFAbPpiYeTgplgwh3t5i0UOTcsBXVoshyIpPPrBjLkLt3LngjdjsgJfDIiP17Kw7F7OEn6FboEZNXPYiBs8LGzDx0nSpXyiR2twpVJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720666408; c=relaxed/simple;
	bh=G/kYxYFWs0qBeHTh0gTZHoYfINM1UJRGucawo5aL0oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSQSTqofH6g38rPgVeaqlQ0AjC8jWtCpwtHl4XwxgbyZAT7T99+Vg2yV1MuLQc6RYziTmyAgloaUeyHVLUTiKxNkMuJFaT31rqQ6HTcq2dFD+LR27pgSIWc/9RfyJ6Oil6ORHMCId8xejALg04w+rzy8Fp7mz4GuUp+dVsL4F5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieiiNMo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B4FC4AF13;
	Thu, 11 Jul 2024 02:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720666407;
	bh=G/kYxYFWs0qBeHTh0gTZHoYfINM1UJRGucawo5aL0oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ieiiNMo4ZstNEAwMGbBlQpPF1UWjfrgjYJVRQzP0nYePHg+jDRxFs5aRMrn1Ga5q9
	 K8CbIeu4t0YG6lziq78DtI8AE7Nug498aYN4/qoaZ37by5ppHJm5n0gGRGOTtmpQWR
	 NARRPoY2/dHf2TNFchdr7MDZz8fIS3uuweK2ETorhweZrbAVCm5ZdjDmQFq9J5GMl0
	 0H+6H58T0AkqEotXu8ePS/tj8hdqK6Fu5xs1LugloyhWGUgq7n0XAl/zB5N0a1WuK1
	 10LnU8akKVmXrlXfT3XglkU9T+SP5fYgtCRPBW3q2T8W4yGsBMp1CqOa7dYluR8mnW
	 GjDdG8iNiGo5w==
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
Subject: [PATCH bpf-next 3/5] selftests/bpf: Add connect_to_addr_str helper
Date: Thu, 11 Jul 2024 10:52:50 +0800
Message-ID: <7c0e4fc4cf00c54cf42c127fa37d47dc39290f4f.1720664658.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720664658.git.tanggeliang@kylinos.cn>
References: <cover.1720664658.git.tanggeliang@kylinos.cn>
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


