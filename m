Return-Path: <linux-kselftest+bounces-30588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61CCA85BF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EAD3B4380
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F7629B20B;
	Fri, 11 Apr 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="An7mSEKg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE7296173;
	Fri, 11 Apr 2025 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371241; cv=none; b=p/F9li9qO6CZnn9doya18MoDjEXdE7ZKvx1oV6Uxm+PaXsFzZanU/m5TnOadnbhuZ5FIPySrb4QCuvBOeNXFvRik8+29uO3ZSplZphNr1iBOxZEF/pVQ3kBi46mUur3yI+XGqiLTHbXgljKpmX/HYC16jsgfYTyZvSPlUhMZV8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371241; c=relaxed/simple;
	bh=f4KpgmCqOigkBjPwzV16BC/e9Qc4m4O2EWw+5lMtBGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2OyvWXQyIVGYN51vM6oRhe+MLYjxdRwjq+irPZBJfWvrXca+Gvl420MnI9nGa0TaiPIBw+dMXVYYmYUpsBpxRed4d5pkyz46I4ufSdjest7TgqEsha0YhcGweufonO3nsJ3VACNajU/zTBBJoKszQgjelLSr5RUOJm+c1Qzp8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=An7mSEKg; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdu-005qNA-TJ; Fri, 11 Apr 2025 13:33:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=BshLwRbnRgKmAKUdavGcdRLsg9XdubR2FSewY8nY1kA=; b=An7mSEKgHL91s6iZ6n+w1Fg2St
	17SAieI9jdTm4fDQxvASj67rscZHZiazxccKv7+z7bIVq0Cfl36F+k1h6ZbBB9FHzFMD0+R5kXO8/
	WgxbTijnoMaCPJn1GEuwpltIqS9O2F2FUqy8nG5kgJWexTzrjZLzPAo2yItt/B8U02bT8ulgYthwe
	MACobSmVBHjXqxa6HH/tiC/k9rKTrDeZx6xSqen48RK//5Gy+u+WEOMaCXOVfNU9IGCpnh6GQWfDd
	W4zDOpkJ3PGzhITiHt3OzhT6aoTwE9eSMu8HLS9QsMIGxSSUTiz/JanLoHzWzX3M4kZUvV4w5KFdw
	tzS+9/ZQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdp-0005tQ-16; Fri, 11 Apr 2025 13:33:49 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u3CdV-00D5Ut-8R; Fri, 11 Apr 2025 13:33:29 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 11 Apr 2025 13:32:39 +0200
Subject: [PATCH bpf-next v2 3/9] selftests/bpf: Add u32()/u64() to
 sockmap_helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-selftests-sockmap-redir-v2-3-5f9b018d6704@rbox.co>
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

Add integer wrappers for convenient sockmap usage.

While there, fix misaligned trailing slashes.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_helpers.h     | 25 ++++++++++------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index 3e5571dd578d12a6f8195bf3d25e069a1e477416..d815efac52fda9592274bb8606c8698fa4baf9c6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -5,12 +5,15 @@
 
 #define MAX_TEST_NAME 80
 
+#define u32(v) ((u32){(v)})
+#define u64(v) ((u64){(v)})
+
 #define __always_unused	__attribute__((__unused__))
 
 #define xbpf_map_delete_elem(fd, key)                                          \
 	({                                                                     \
 		int __ret = bpf_map_delete_elem((fd), (key));                  \
-		if (__ret < 0)                                               \
+		if (__ret < 0)                                                 \
 			FAIL_ERRNO("map_delete");                              \
 		__ret;                                                         \
 	})
@@ -18,7 +21,7 @@
 #define xbpf_map_lookup_elem(fd, key, val)                                     \
 	({                                                                     \
 		int __ret = bpf_map_lookup_elem((fd), (key), (val));           \
-		if (__ret < 0)                                               \
+		if (__ret < 0)                                                 \
 			FAIL_ERRNO("map_lookup");                              \
 		__ret;                                                         \
 	})
@@ -26,7 +29,7 @@
 #define xbpf_map_update_elem(fd, key, val, flags)                              \
 	({                                                                     \
 		int __ret = bpf_map_update_elem((fd), (key), (val), (flags));  \
-		if (__ret < 0)                                               \
+		if (__ret < 0)                                                 \
 			FAIL_ERRNO("map_update");                              \
 		__ret;                                                         \
 	})
@@ -35,7 +38,7 @@
 	({                                                                     \
 		int __ret =                                                    \
 			bpf_prog_attach((prog), (target), (type), (flags));    \
-		if (__ret < 0)                                               \
+		if (__ret < 0)                                                 \
 			FAIL_ERRNO("prog_attach(" #type ")");                  \
 		__ret;                                                         \
 	})
@@ -43,7 +46,7 @@
 #define xbpf_prog_detach2(prog, target, type)                                  \
 	({                                                                     \
 		int __ret = bpf_prog_detach2((prog), (target), (type));        \
-		if (__ret < 0)                                               \
+		if (__ret < 0)                                                 \
 			FAIL_ERRNO("prog_detach2(" #type ")");                 \
 		__ret;                                                         \
 	})
@@ -66,21 +69,15 @@
 		__ret;                                                         \
 	})
 
-static inline int add_to_sockmap(int sock_mapfd, int fd1, int fd2)
+static inline int add_to_sockmap(int mapfd, int fd1, int fd2)
 {
-	u64 value;
-	u32 key;
 	int err;
 
-	key = 0;
-	value = fd1;
-	err = xbpf_map_update_elem(sock_mapfd, &key, &value, BPF_NOEXIST);
+	err = xbpf_map_update_elem(mapfd, &u32(0), &u64(fd1), BPF_NOEXIST);
 	if (err)
 		return err;
 
-	key = 1;
-	value = fd2;
-	return xbpf_map_update_elem(sock_mapfd, &key, &value, BPF_NOEXIST);
+	return xbpf_map_update_elem(mapfd, &u32(1), &u64(fd2), BPF_NOEXIST);
 }
 
 #endif // __SOCKMAP_HELPERS__

-- 
2.49.0


