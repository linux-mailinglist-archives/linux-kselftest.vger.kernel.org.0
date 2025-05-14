Return-Path: <linux-kselftest+bounces-32984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3D4AB7951
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 01:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2848D3AD274
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 23:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F52248AE;
	Wed, 14 May 2025 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="VSqETHou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F3321D583;
	Wed, 14 May 2025 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747264153; cv=none; b=hJrrpY1/tcRAmrereKQGAvzeMdbvvI23NxdyXB04Q6P3FhlPXJrYFaaQ/rJwoek2KQfRBmDbjUJb3Jcrcmegyvdjf2NgjLjAMzH+3Pro9TxiPyrhWMjhQn83kjr0/J+W3KmH/tMbuZgRLxUS0ql3Eeocv+sL4AriQexmYSEYl9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747264153; c=relaxed/simple;
	bh=Iuzoe7DKzMD2kAfuDIP169BtqFJDXUA+gwo+3nrjFhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZyDSfisMnU3lQrivsw+AmEhbNlvnEZ6Vp8ox7Mw7/UqOkUkwAFZt3URaJsHjysLV+oWtLfVVOHEAyGzzBZnkemqEalSvw2ZMwM/zrgXbD+clGsg8aTMGdN7Y1vAVv/RznH/ziOw8VOmmVqDLz3t/KKtCSZss5ILm/aX8OXc46Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=VSqETHou; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOX-001vcm-U4; Thu, 15 May 2025 00:16:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=jWUYdUduK67slCNoez8gpDfTauScyXVzhPIoLCAsEKo=; b=VSqETHouk5UKAXnwg76AhdXkR4
	lJpWg0VG3vPKAdYyKI3kjtZzBXyVJXXZVU4LSCONrQTx1j67L1L3HLmjFAPxrFTtkTB4JpK0g3wOe
	os1qIJXFE/p0iLcOQfx4IygFJMwaCGh52srarYEcuxV0VkTR3ejyAf7B5+h9lq+RmXfiB+Cx98UHx
	dLJJmamPaIJH6DX3bxTTBxP7gsfgFEbRvUzA/zA75neg6jHiZTEQ5iX9buACRf7ajhWA0yEchjuIS
	oD1dh1ct1phBUVyfPyznJT53I9T2pLc9+quJ5dUj6OaGgewGsB5g6Xdv6bcOvrzM2knL3ZBCWxI3S
	H57O+dhQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOW-00088m-Vq; Thu, 15 May 2025 00:16:09 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uFKOK-005bJ3-QP; Thu, 15 May 2025 00:15:56 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 15 May 2025 00:15:25 +0200
Subject: [PATCH bpf-next v3 2/8] selftests/bpf: Add socket_kind_to_str() to
 socket_helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-selftests-sockmap-redir-v3-2-a1ea723f7e7e@rbox.co>
References: <20250515-selftests-sockmap-redir-v3-0-a1ea723f7e7e@rbox.co>
In-Reply-To: <20250515-selftests-sockmap-redir-v3-0-a1ea723f7e7e@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Add function that returns string representation of socket's domain/type.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
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


