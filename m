Return-Path: <linux-kselftest+bounces-30587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B26CA85BD1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4501188FB1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D302A29AB0D;
	Fri, 11 Apr 2025 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="N04LsJAY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4E2980A8
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371240; cv=none; b=M1l2vdwDLMF4jHYahZNk+frbm/ddJMo/QsHFHL0443oxtB5roZRvj0ZZiW/A6JAMtTU9f34Fpt2VM17yicNuauZBI8k6g73xobweooGTauDNZ9aNgkO8bmDUxal7BzgegL8oSVDRcyxmoya5175xkLlyfNENuPEXTW9JHsd+ABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371240; c=relaxed/simple;
	bh=g+wVQ6QK1MDXvmQ64BoN7dPxYfC6Qal1FuFidbTXn/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHqFMuCOXD9E8vZJo8+0TTaJnCAlk1zznls9OpAb8uEmVJY4wUBMjwRNWl9VWdEqu07aGCBLyqeO8dKuqFupCBSpQaXQ16fQFqAPXbeNSFzKJENZbD+zgKYtSIHbl7kp9RU1/in5sa8b/Ceit6Fe2IJH4RZyksmu4XxiXbBlB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=N04LsJAY; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdx-005qNS-4J; Fri, 11 Apr 2025 13:33:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=WMhYf5YUMM3A2S2PCNIRkWp2Q1Juv+CrKBca/XjHFjA=; b=N04LsJAYhRyJIu+KbeniZT6QYV
	vJiEIKekZYycVG4G1xFIC5KqoIq4JBc7xNU/w9ahwq72DippKcgHnR9d8qPx/Ul7IG3l4A4ePFTYz
	SHd2yr6ypUakKxzDxiNmstReNKM9FddoKt1blND860fWsORk+2r27DJ56bZQedxkeeKZJOYfbQRrA
	RzsbpaQWo3TTGdu2Cm+CACgDHVTeRVIGj6i1PJtLHhu1ZbGbupjo5fTXrE9Td9UfQvZAi7qRn5+PM
	8elcAu1OkVLgPEAq1Ht0OvjCQY7FctLEEyIJqXHLSyTifgDLja/FCQ4YoASJ44AyDpUKndKa6n+CE
	g8QfGC4Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdr-0005tY-E3; Fri, 11 Apr 2025 13:33:51 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u3Cdb-00D5Ut-CT; Fri, 11 Apr 2025 13:33:35 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 11 Apr 2025 13:32:45 +0200
Subject: [PATCH bpf-next v2 9/9] docs/bpf: sockmap: Add a missing comma
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-selftests-sockmap-redir-v2-9-5f9b018d6704@rbox.co>
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

Fix bpf_sk_redirect_map() prototype.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 Documentation/bpf/map_sockmap.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/map_sockmap.rst b/Documentation/bpf/map_sockmap.rst
index 2d630686a00baa141bb7557098117f0eb236455b..deda98e55fbcc3ad2972889406967942b4b40e66 100644
--- a/Documentation/bpf/map_sockmap.rst
+++ b/Documentation/bpf/map_sockmap.rst
@@ -100,7 +100,7 @@ bpf_sk_redirect_map()
 ^^^^^^^^^^^^^^^^^^^^^
 .. code-block:: c
 
-    long bpf_sk_redirect_map(struct sk_buff *skb, struct bpf_map *map, u32 key u64 flags)
+    long bpf_sk_redirect_map(struct sk_buff *skb, struct bpf_map *map, u32 key, u64 flags)
 
 Redirect the packet to the socket referenced by ``map`` (of type
 ``BPF_MAP_TYPE_SOCKMAP``) at index ``key``. Both ingress and egress interfaces

-- 
2.49.0


