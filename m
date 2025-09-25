Return-Path: <linux-kselftest+bounces-42287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D55B9E6A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 11:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B5F3B121A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2E92EBB9B;
	Thu, 25 Sep 2025 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6KNxREy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842A92EAD0B
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792983; cv=none; b=oJYQbSkObMaGI9IIyHG0PmY3YL56ga9r6yPFGnhFlLopaiRzhNnwcq2HKJheJBu+FmGF9OlR8JA6BRu3GbJ88Y7TqrT9vYa6lGA3GXKVIjcb47e3Hec5vI4WiRpEnHH5cHEKi5mq9jaZ+B7uahdJYxpy3hESKMa51YZfJBrBarE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792983; c=relaxed/simple;
	bh=2mG7qJ2Y78I9Q0KSuXQ2NjcyY7f58p+CSBWSScj2RH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sy3zivm84WxKDOSEMN4ZiA6ouuGa8Z+TKYP4PrEzxWUCOP4w9fpgC7nBP7HzJpr6MvSQYXAmubXkYijHuLJGFU0lLV5bsIzX4lXcUdUupfVQND5lIA+1VqaobUYwUZEVftIQ65s1YSID05LK75EVI9in0oUm7L3Sy8HY+IPgzRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6KNxREy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f973b37c5so77692a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 02:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758792979; x=1759397779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NO0ayIYXnbf5RnG1Y4914ZaMA9kHmb//RoVl9SUlrOU=;
        b=j6KNxREyMD8jgzCVnL9PKxtXNUoWmncVUm76EFpWXaG32nckHrtxz3m6xuSbk6fkkD
         hucsFgRGyTXolm2Hnav8Gs523rbSpS9gyBlowyEHEES96x8SdTSHInLVneIHpagZ1PTn
         s4N/RFvii8T3zGhKE9awD+xepd5kzdzILfMSLmRLDFmNyJmTKENjvqbPg68NqHX/orn+
         xecPtz/IyUDuwTO3TRNtOeDmlHx5+2gMAkRr8TSEqWy1ZW4NIa9OHFo8HG6Nw0laH1pA
         3lEcwLe3JBqln8rYJ4y4KtrH02Cgb/2ktpEo+5+FcDIxRcrloWVufhxJsDuwx0vy+fvB
         WKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792979; x=1759397779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NO0ayIYXnbf5RnG1Y4914ZaMA9kHmb//RoVl9SUlrOU=;
        b=J+dY4Pm7gydxvMYUub8iroAa/9m1nZpnUM2bBGkd2Z/+bbshxJXj/JV42wnrj8foTg
         sOIt6PsV5MFwIy6pbuPee2zv52hhXtSxN9ZU6w7OkXIYmoCNPA7M3ES/jAdEr0r55IAv
         txR4r5yn6RXxRbfDO/vzTezgnkacxsEEfrc40rYu9ZmE2408RsubJHgK8mkFwdUEHebT
         V97FVwF5/Z+hQnVnr22mcSoqZ/NOqN4hSFcmH0m4N5feptB/GyCSCjUUkmDyL+r1tfy7
         R/knlt2q8ylvBgzMZNK3CQCnANtPrO0WchKHAHUhUgwwH+u+GMwhV0k0IfbaomflJRQ8
         uRqw==
X-Forwarded-Encrypted: i=1; AJvYcCUzmU5wsDeCfXihyzD19T5dbgLtqoE504o87YrErTy2QetqqN9ae6nPUGgngOxLnBAM3G8zaRuLtEnDo87IB1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YztxXjdVq1mrhzMDO4w2Bzc+j2UWr17RR8pmBPNO/3foqO4gnOy
	mp7zKJsrefOjbQEyX+pMQ0lPvUyL9F247WffzL5BcogJYmfbRCTfN5ce
X-Gm-Gg: ASbGncuvORoYPwCO/CtLdYvOuRTN4eCzSl9AQlUMyUhFGplwJbNbEDeuTp5GrImN5L3
	az1bEDdrqhnnr3DhiESRHMxmqL0wMKawJHAhacAvp73ChMa4BN4k+wmkrWJf90bpLkDx6etE0fU
	eyYI4wDe3BijWs8mRmiA0qqQTOcaaxV5z2rcpBN5U3A3ZJLV6NQf8kvf3iFonIVbPwAGkxfKB2A
	170CSl3bHKex5SX70LQvURyWLgla19uXWhoSoZdbQakyUqMDuxR5GyPPEYmJT5ohY3ughCUV1nK
	Xt5iguBzsRpA1WU38COMmVfqGiMgxroodp8EJAazGNttgD4B9G42eFgE2OBmxCcZ518Q/GcUxlg
	rXE1TQxIhzWOJ6ANHak00CDtirQ4=
X-Google-Smtp-Source: AGHT+IFkTu6BAV9MTy9Y6rsh5K7Jn/6CmW5NkfDaEMgjEkpbreaY6/Rf17vMqmExro0hPJr0iXu7CA==
X-Received: by 2002:a50:cc47:0:b0:62f:a79a:f61f with SMTP id 4fb4d7f45d1cf-6349f6d3d08mr947935a12.0.1758792978630;
        Thu, 25 Sep 2025 02:36:18 -0700 (PDT)
Received: from bhk ([165.50.112.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae321csm941225a12.24.2025.09.25.02.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:36:17 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	linux@jordanrome.com,
	ameryhung@gmail.com,
	toke@redhat.com,
	houtao1@huawei.com,
	emil@etsalapatis.com,
	yatsenko@meta.com,
	isolodrai@meta.com,
	a.s.protopopov@gmail.com,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	vmalik@redhat.com,
	bigeasy@linutronix.de,
	tj@kernel.org,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	mrpre@163.com,
	jakub@cloudflare.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH v3 2/3] selftests/bpf: Prepare to add -Wsign-compare for bpf tests
Date: Thu, 25 Sep 2025 11:35:40 +0100
Message-ID: <20250925103559.14876-3-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-Change only variable types for correct sign comparisons

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 .../testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c | 2 +-
 tools/testing/selftests/bpf/progs/test_skb_ctx.c                | 2 +-
 tools/testing/selftests/bpf/progs/test_snprintf.c               | 2 +-
 tools/testing/selftests/bpf/progs/test_sockmap_strp.c           | 2 +-
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c              | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp.c                    | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c
index dc6e43bc6a62..bf3ac5c2938c 100644
--- a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c
@@ -100,7 +100,7 @@ int xdp_ingress_v6(struct xdp_md *xdp)
 	off += sizeof(struct tcphdr);
 
 	/* max number of bytes of options in tcp header is 40 bytes */
-	for (int i = 0; i < tcp_hdr_opt_max_opt_checks; i++) {
+	for (__u32 i = 0; i < tcp_hdr_opt_max_opt_checks; i++) {
 		err = parse_hdr_opt(&ptr, &off, &hdr_bytes_remaining, &server_id);
 
 		if (err || !hdr_bytes_remaining)
diff --git a/tools/testing/selftests/bpf/progs/test_skb_ctx.c b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
index a724a70c6700..7939a2edc414 100644
--- a/tools/testing/selftests/bpf/progs/test_skb_ctx.c
+++ b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
@@ -11,7 +11,7 @@ SEC("tc")
 int process(struct __sk_buff *skb)
 {
 	__pragma_loop_unroll_full
-	for (int i = 0; i < 5; i++) {
+	for (__u32 i = 0; i < 5; i++) {
 		if (skb->cb[i] != i + 1)
 			return 1;
 		skb->cb[i]++;
diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/testing/selftests/bpf/progs/test_snprintf.c
index 8fda07544023..1aa4835da71a 100644
--- a/tools/testing/selftests/bpf/progs/test_snprintf.c
+++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
@@ -4,7 +4,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
-__u32 pid = 0;
+int pid = 0;
 
 char num_out[64] = {};
 long num_ret = 0;
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
index dde3d5bec515..e9675c45d8ef 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
@@ -2,7 +2,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-int verdict_max_size = 10000;
+__u32 verdict_max_size = 10000;
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
 	__uint(max_entries, 20);
diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index 404124a93892..c7e2d4571a2b 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -80,7 +80,7 @@ static __always_inline void set_ipv4_csum(struct iphdr *iph)
 {
 	__u16 *iph16 = (__u16 *)iph;
 	__u32 csum;
-	int i;
+	size_t i;
 
 	iph->check = 0;
 
diff --git a/tools/testing/selftests/bpf/progs/test_xdp.c b/tools/testing/selftests/bpf/progs/test_xdp.c
index 8caf58be5818..ce2a9ae26088 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp.c
@@ -89,7 +89,7 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
 	struct vip vip = {};
 	int dport;
 	__u32 csum = 0;
-	int i;
+	size_t i;
 
 	if (iph + 1 > data_end)
 		return XDP_DROP;
-- 
2.51.0


