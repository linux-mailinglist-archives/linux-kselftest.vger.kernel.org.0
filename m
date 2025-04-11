Return-Path: <linux-kselftest+bounces-30590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B865A85BE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209911BA1F37
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E55C29CB5A;
	Fri, 11 Apr 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="haOQxP3F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2308B29C35C;
	Fri, 11 Apr 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371244; cv=none; b=D3B8mqn9P+4bzSrPCI7HTaxkpUvsKdMScbgdNjJtboHBpPltzhVEJwv+yeU3xPaWpwB8QEamrQ85949/D37CgjJkkX5kB/BS4bs/hIzYL6wnfZFwzPOaCmMVFz+z1uqNZyo8vGdfidHwJKhK+Bae0bSORnXykGIGoif1VK3FWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371244; c=relaxed/simple;
	bh=upPBkG3yoFZwVA4URP7qTh+OsWBDhK6KqADiJlaBu88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZWtRQrIzdSu9EHrTsxc47GhnP47Rbn62MyOmG+WWIqj0pSsLPQmiVEPNpq9CMT1yCFFVr+znh/IbdtM8tGYZjQoZTCjdh2QlbhBqP+iHcYgT4uFmiY1p5O/qd5dMqdId705tQUKawLu6ydZ/Ctrt6ifJ4f8cRD66CYtdex/Njc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=haOQxP3F; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdz-005wzZ-Ki; Fri, 11 Apr 2025 13:33:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=v7qdJfbklaDWSxs/ZBsUd7RL8jaPPIXxjgb+UVgEEXU=; b=haOQxP3FToyrgSkhvrnsF2MKBP
	Z1k9MHrtJyB4vNODRs9X2ZanYyoF7W/ODl6nNZKXP4hVY4z3ZJP7D32nTeWdBYR2nzKNReEPFkjBJ
	qC0EesUmDSoIvBrwbglN0UEf/lNQy/R9DsodJToiZXB9eLdlA4P+dVnQwH+8TS2nKzxWjRyrmIeuh
	53vqaAgFTNgeLC8zx3NPlhwmH5c0tZ+8kdHeT+xAQQmG3mOYjyKumH/iKy/RTR3i6TtbTpLHxYdtv
	Aa+VQfGU5WFkm7pGBxHWOTzVwHLNYCD4qFlWKz20hgXjevhgTvKcKyr3+jtUKnowpONJzcWfCH0Xp
	ipB1iJWg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cde-0005ou-L5; Fri, 11 Apr 2025 13:33:39 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u3CdT-00D5Ut-7q; Fri, 11 Apr 2025 13:33:27 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 11 Apr 2025 13:32:37 +0200
Subject: [PATCH bpf-next v2 1/9] selftests/bpf: Support af_unix SOCK_DGRAM
 socket pair creation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-selftests-sockmap-redir-v2-1-5f9b018d6704@rbox.co>
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

Handle af_unix in init_addr_loopback(). For pair creation, bind() the peer
socket to make SOCK_DGRAM connect() happy.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/socket_helpers.h      | 29 ++++++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
index 1bdfb79ef009b16e329a80eab8598ed97dae9119..e505c2f2595a24be9dd5b534deef4793f9a02f77 100644
--- a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
@@ -3,6 +3,7 @@
 #ifndef __SOCKET_HELPERS__
 #define __SOCKET_HELPERS__
 
+#include <sys/un.h>
 #include <linux/vm_sockets.h>
 
 /* include/linux/net.h */
@@ -169,6 +170,15 @@ static inline void init_addr_loopback6(struct sockaddr_storage *ss,
 	*len = sizeof(*addr6);
 }
 
+static inline void init_addr_loopback_unix(struct sockaddr_storage *ss,
+					   socklen_t *len)
+{
+	struct sockaddr_un *addr = memset(ss, 0, sizeof(*ss));
+
+	addr->sun_family = AF_UNIX;
+	*len = sizeof(sa_family_t);
+}
+
 static inline void init_addr_loopback_vsock(struct sockaddr_storage *ss,
 					    socklen_t *len)
 {
@@ -190,6 +200,9 @@ static inline void init_addr_loopback(int family, struct sockaddr_storage *ss,
 	case AF_INET6:
 		init_addr_loopback6(ss, len);
 		return;
+	case AF_UNIX:
+		init_addr_loopback_unix(ss, len);
+		return;
 	case AF_VSOCK:
 		init_addr_loopback_vsock(ss, len);
 		return;
@@ -315,21 +328,27 @@ static inline int create_pair(int family, int sotype, int *p0, int *p1)
 {
 	__close_fd int s, c = -1, p = -1;
 	struct sockaddr_storage addr;
-	socklen_t len = sizeof(addr);
+	socklen_t len;
 	int err;
 
 	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return s;
 
-	err = xgetsockname(s, sockaddr(&addr), &len);
-	if (err)
-		return err;
-
 	c = xsocket(family, sotype, 0);
 	if (c < 0)
 		return c;
 
+	init_addr_loopback(family, &addr, &len);
+	err = xbind(c, sockaddr(&addr), len);
+	if (err)
+		return err;
+
+	len = sizeof(addr);
+	err = xgetsockname(s, sockaddr(&addr), &len);
+	if (err)
+		return err;
+
 	err = connect(c, sockaddr(&addr), len);
 	if (err) {
 		if (errno != EINPROGRESS) {

-- 
2.49.0


