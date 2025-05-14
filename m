Return-Path: <linux-kselftest+bounces-32975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19073AB78EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 00:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5141A16E709
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 22:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F24224AFE;
	Wed, 14 May 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Fu8gYC92"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147822259B;
	Wed, 14 May 2025 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260989; cv=none; b=SSbWnbeNWuoz1iUJ+Dw4rj/PHVB/g39gjiL8/JtnVFz2Y69gokO7D59mFLXSa6Pn+DoT/zd7MPwJFQ4yutzknS9n8RxcMn4EfeyT8ZgItoOKm0UlEhdVM7QBgrzzK5cKfFxPGJHN+r8eTD4wg++lOTptsckIm0hC9LMTQ8PltbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260989; c=relaxed/simple;
	bh=QaLq3SL5OMyc+7AJ0LFBdLmC+RjvCwNSMZ9ekuidqGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nyzWAwyXfwszpi3T3kPQ3bY1Q+drsLPp4z1fWoXEpKdtMCe9CAzSn8qlpKb/86hquq1FE7WsDaiAtJo+Q8CN0DNCqpY9vvCau8y6MW6n9OZ17F1tGxUCy8rO+G6IBNDiIIYVzXZbXMYnRiJuCvUaUIs9D5+7WZFvHktrkQU1nzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Fu8gYC92; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOi-001k8b-Uu; Thu, 15 May 2025 00:16:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=YG06fwNA91GgAgl0iabbu4fCCpsHoTGuufLEYHdsOVQ=; b=Fu8gYC92Gc4FYsuJmGaB3Vwd6T
	rThnDcs+ZCtJlOcVhBbC2b/gHkYSlbQfV2lWzK6zkBSKT20rjoaM6eJ4D2b752oRCEyfzAeq1+BTk
	Akr4mOhl0Sc0S4m8D0oFqLeUx2kPfQYhn+WTnYgOe/oT4h9L3l7rESvGkD57m9huIKd8osIx8WAra
	eMq00unNsAmAmFFZO989oMwca5PZXevX+AnjAglQ1N+6LzTVUMr3k4/GNXiyWMA4uXsL9mPAQonXI
	HFOBi+dGkw7KoLOqiyx7Xnn+FiqZhdc9lT3N1Z5g2/GFYkqizWTTqEwmBTVqyyaWv5+uB2oOX0GGs
	b7Z7uN+A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOi-0008AG-J3; Thu, 15 May 2025 00:16:20 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uFKOL-005bJ3-Mr; Thu, 15 May 2025 00:15:57 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 15 May 2025 00:15:26 +0200
Subject: [PATCH bpf-next v3 3/8] selftests/bpf: Add u32()/u64() to
 sockmap_helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-selftests-sockmap-redir-v3-3-a1ea723f7e7e@rbox.co>
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

Add integer wrappers for convenient sockmap usage.

While there, fix misaligned trailing slashes.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
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


