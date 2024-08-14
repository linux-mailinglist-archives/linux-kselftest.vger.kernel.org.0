Return-Path: <linux-kselftest+bounces-15333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C777B951FA7
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 18:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7941F2124C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146E61B9B21;
	Wed, 14 Aug 2024 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="QteaoSks"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCA71B8EB0;
	Wed, 14 Aug 2024 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652337; cv=none; b=rklbzYUyYDhrXw+CbDg+ispt87+oQVRRUUKC+QzqhKr7JQ2ye6PoamzxMbGG886isRhYInkaDP7pVwbsl0MfvmEwvFAvynkOhqzyj13HAfU4haNBEGR1U+G1tE1eRzugkxH3Dx5Di7akvBe/bPXUVACPlZqo7pgUlrrPNcWYLps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652337; c=relaxed/simple;
	bh=zNsgASF057wFi7VlnTNfAZFkCOhBpYb4cACDi4WyeMo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DvIerFkRP1OvJ4PTMFzVjRmQDfI1z61gXAOw95UEaVgCGLE00k15YRU1KPSJUsc1ITOw+CPG3LI6OPnk5TcXWTglza+P/ykMhLzoINxZi6d0hoXXMwqaYDUP4tn1X1WC2TXu1m+/nC4IvpyE0Zp6cBlxunYy7o6bDyTqHk8JiRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=QteaoSks; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1seGhz-00Gwg5-3y; Wed, 14 Aug 2024 18:18:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID;
	bh=c0KMUdttV/wxsl2RrtTC21pfQ1ygNN4cevwFVGM0qjg=; b=QteaoSksiufHwLg3pf+KM+JE5p
	0ZDOrShK+UOBanQgzqj3ENoiu/fkXlTQ1kvgSvDjokwmM9GS4rQPkSoOrdItmqf3qLRnRsIekjA4M
	NDAJDaiIBFe6G4DcQ2hGyUshmh1hcrNCVmNT5Kx6n5zBkDo271O2/Zd430XS+WlTWwYnssIRvejwF
	a2qEmMZEgnBNnxajvjKVMbKRhhkaCXZfkF7aGL6pVddH+idU0T3++A+6IwQIgeeDITqlrmXtgyuOa
	x4K9fv6d3HDTZ+XcKjfkiqdB/cYu97FKeWQ3lTXwSfmv0yhWVnNm1ZrdCL8fAA6KONuGgpCTuL4rJ
	UPH94oCw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1seGhy-0005dL-FF; Wed, 14 Aug 2024 18:18:46 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1seGhg-00EP3T-2v; Wed, 14 Aug 2024 18:18:28 +0200
Message-ID: <a2c8831b-68bf-4c6f-ad5e-3ac67de2d314@rbox.co>
Date: Wed, 14 Aug 2024 18:18:26 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/3] selftests/bpf: Allow setting BPF_F_INGRESS in
 prog_msg_verdict()
From: Michal Luczaj <mhal@rbox.co>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
 <87y159yi5m.fsf@cloudflare.com>
 <249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
 <87ttfxy28s.fsf@cloudflare.com>
 <42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Let a selftest set BPF_F_INGRESS for map/hash redirect.

In run_tests(), explicitly reset skel->bss->test_ingress to false. Earlier
tests might have left it flipped.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 2 ++
 tools/testing/selftests/bpf/progs/test_sockmap_listen.c | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index da5a6fb03b69..a5e7d27760cf 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1850,6 +1850,8 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
 static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
 		      int family)
 {
+	skel->bss->test_ingress = false;
+
 	test_ops(skel, map, family, SOCK_STREAM);
 	test_ops(skel, map, family, SOCK_DGRAM);
 	test_redir(skel, map, family, SOCK_STREAM);
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
index b7250eb9c30c..5a3504d5dfc3 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
@@ -106,9 +106,11 @@ int prog_msg_verdict(struct sk_msg_md *msg)
 	int verdict;
 
 	if (test_sockmap)
-		verdict = bpf_msg_redirect_map(msg, &sock_map, zero, 0);
+		verdict = bpf_msg_redirect_map(msg, &sock_map, zero,
+					       test_ingress ? BPF_F_INGRESS : 0);
 	else
-		verdict = bpf_msg_redirect_hash(msg, &sock_hash, &zero, 0);
+		verdict = bpf_msg_redirect_hash(msg, &sock_hash, &zero,
+						test_ingress ? BPF_F_INGRESS : 0);
 
 	count = bpf_map_lookup_elem(&verdict_map, &verdict);
 	if (count)
-- 
2.46.0

