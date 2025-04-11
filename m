Return-Path: <linux-kselftest+bounces-30582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E486A85BC1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7822A444BF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005DF238C26;
	Fri, 11 Apr 2025 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="JbK1GRZP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6B15855C;
	Fri, 11 Apr 2025 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371237; cv=none; b=kWX7BDbgmENfBBa7zxpEcaaaJlowAlD5/p4TWpHpPjpF8HFKiTH8SPG3IF5AaDFneJZkt28QxXlDiDE9NEB08uCpTHzIOBNrg4ILplYdI0SK390ixDIlL/xgeVrnkeyb4w0rrhGCUAo/18xHSLMaL4GE4Pkx74YQOtyIHIbP7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371237; c=relaxed/simple;
	bh=E3H3zS2asuRS3QQYBtL0a+seiix1UN0LZXZFWCTHeLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFwmnxycZbBlVzmSWO5OIFLGXzhxYt7Y8iu4NKKnboTwNLpaBVRSNgp7t+tZ8PaHcoYfo1eN9ImS68vUycr8Gv2BhDdSch554l/R1KFbzD332+XlXPNHptZYU7ltjPWaOG3VaB7TTAbe16kEcbVQaxYj8m4X15/CXQS8F76xsPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=JbK1GRZP; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdi-005wxV-GF; Fri, 11 Apr 2025 13:33:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=JJUVspd37HPmlTRI3GjkD10mpqCy6PqiwGnE0i9Yrm8=; b=JbK1GRZPF0xsnJzudrDRqfhcej
	C+GPUoxS9DPFtcuy42/hlroH2XIDnNqZCzqLoZZlkPI+SHIM2EKDcgVxVSHqmVIBoCmq+0Ur2vTps
	9d8JykNxxQmiuljknMshv8v5uXjlGaNcS4L5TpsDaJc6xr3c9o/AYaTz56skHM3CdKHqJ1uFgS9aW
	6x60s+nExYom6skpriYJehRzLtSwazn8XvumltittzDF783hBpvgmuvGNnovgiKLDEDq2I7JlSHyh
	eqVL5AOfS8LQ5A3Ivg6f0z4Tf8+lUryDoSO1hB1rTcZvtETtlKNuXhTC513SYm25RPZ3kPWMlE9Hy
	uAC4fTAQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdh-0007wg-Ld; Fri, 11 Apr 2025 13:33:42 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u3CdU-00D5Ut-8H; Fri, 11 Apr 2025 13:33:28 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 11 Apr 2025 13:32:38 +0200
Subject: [PATCH bpf-next v2 2/9] selftests/bpf: Add socket_kind_to_str() to
 socket_helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-selftests-sockmap-redir-v2-2-5f9b018d6704@rbox.co>
References: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
In-Reply-To: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Add function that returns string representation of socket's domain/type.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/socket_helpers.h      | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
index e505c2f2595a24be9dd5b534deef4793f9a02f77..e02cabcc814e9a6a11d61ad02cf38696fb0f27ff 100644
--- a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
@@ -410,4 +410,59 @@ static inline int create_socket_pairs(int family, int sotype, int *c0, int *c1,
 	return err;
 }
 
+static inline const char *socket_kind_to_str(int sock_fd)
+{
+	socklen_t opt_len;
+	int domain, type;
+
+	opt_len = sizeof(domain);
+	if (getsockopt(sock_fd, SOL_SOCKET, SO_DOMAIN, &domain, &opt_len))
+		FAIL_ERRNO("getsockopt(SO_DOMAIN)");
+
+	opt_len = sizeof(type);
+	if (getsockopt(sock_fd, SOL_SOCKET, SO_TYPE, &type, &opt_len))
+		FAIL_ERRNO("getsockopt(SO_TYPE)");
+
+	switch (domain) {
+	case AF_INET:
+		switch (type) {
+		case SOCK_STREAM:
+			return "tcp4";
+		case SOCK_DGRAM:
+			return "udp4";
+		}
+		break;
+	case AF_INET6:
+		switch (type) {
+		case SOCK_STREAM:
+			return "tcp6";
+		case SOCK_DGRAM:
+			return "udp6";
+		}
+		break;
+	case AF_UNIX:
+		switch (type) {
+		case SOCK_STREAM:
+			return "u_str";
+		case SOCK_DGRAM:
+			return "u_dgr";
+		case SOCK_SEQPACKET:
+			return "u_seq";
+		}
+		break;
+	case AF_VSOCK:
+		switch (type) {
+		case SOCK_STREAM:
+			return "v_str";
+		case SOCK_DGRAM:
+			return "v_dgr";
+		case SOCK_SEQPACKET:
+			return "v_seq";
+		}
+		break;
+	}
+
+	return "???";
+}
+
 #endif // __SOCKET_HELPERS__

-- 
2.49.0


