Return-Path: <linux-kselftest+bounces-40822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F17B455EE
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 13:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51F47C7FAC
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 11:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1653D3469FC;
	Fri,  5 Sep 2025 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="VDDUzwc5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAED8342CBB;
	Fri,  5 Sep 2025 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070729; cv=none; b=EPKNHEUQBc8lnd9hRcrpf8i/2CPrBrO7h6cRjUQmyEEN+bVvHYe6aOdwiPbc1/aIOjMHlrr7emUu1cJsHiIvGGzSnuOr3J+EP4WlYzwNUm1x1WXzoYYKh45legHOlbSkl0D54mrnpVJJC+klDMMiVUSjixDrKRFtXNH+ow9lel8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070729; c=relaxed/simple;
	bh=Dp9qrhweroc3zKnQINaoYc9xx4s5tbRN5FpOMFLYIe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ExQcf1zTR04TnH7Yyw+1AdUjeFUKRIIT3TjVBf1FsTtp/hnFayVxDERXiH/0vSMnx4sph6+uDoZwuy73mA2WxLMcxfOKiDNff2XJc/WHTIzGPEGieJD3zPXGl2QgKXC2URgRiYidv5xzynFIv+c6IWpAosMH++YuzrrXRTI0Wwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=VDDUzwc5; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uuUMO-003UQh-KZ; Fri, 05 Sep 2025 13:12:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=rVsHhBOsXNiF0cE1EN8PVJpEUHIXi3i0lXd+CCf7ckk=; b=VDDUzwc5WEdL4k2SWHKgpkMWQk
	Hq9+AFZy7IU5yAgP+Kks7dxRKbVc1k2koyTjzh4INf50UR8IA+m3XSQqzh2odgbIyl/xll4K+EckN
	6snWGSijYVEMeygL/u8uuUO0h8wIhjKd/ufKcY4ucp5/mmxPCyY7a0ThrUXu2Ysmg9ShYG7Fpm3mw
	dIvc3eY8Y+UBbWxyMjRvvXal6i8jkqQ2acWdVLkqT7cUoQhewG7kTspPo+yJoQfKktOkOSPpDaZ/k
	yPYy2tc2YLZrKZu5V/kxIg/WcOA0vNe4KqBmAVcrDSzJE62+hsL3r14lY73Nx4WJ8O6TQ+wyqkGkG
	PaAMsHxw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uuUMN-0002Ie-Aw; Fri, 05 Sep 2025 13:12:04 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uuUMC-002yZ1-Ur; Fri, 05 Sep 2025 13:11:53 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 05 Sep 2025 13:11:44 +0200
Subject: [PATCH bpf-next 4/5] selftests/bpf: sockmap_redir: Let test
 specify skel's redirect_type
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-redir-test-pass-drop-v1-4-9d9e43ff40df@rbox.co>
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
In-Reply-To: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Preparatory patch before adding SK_PASS/SK_DROP support: allow to
dynamically switch BPF program's redirect_type. This way, after setting up
for a redirection, test can make the BPF program skip the actual
bpf_{sk,msg}_redirect_{map,hash} part and return a specified verdict.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_redir.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
index 9fc5b4dd323d8554e6dc89d06be9054612e41020..f89df1ca1174800d801f221a819b099abf911450 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
@@ -371,7 +371,7 @@ static void test_redir(enum bpf_map_type type, struct redir_spec *redir,
 }
 
 static void test_sockets(enum bpf_map_type type, struct redir_spec *redir,
-			 struct maps *maps)
+			 struct maps *maps, int *skel_redir_type)
 {
 	struct socket_spec *s, sockets[] = {
 		{ AF_INET, SOCK_STREAM },
@@ -392,6 +392,8 @@ static void test_sockets(enum bpf_map_type type, struct redir_spec *redir,
 		if (socket_spec_pairs(s))
 			goto out;
 
+	*skel_redir_type = type;
+
 	/* Intra-proto */
 	for (s = sockets; s < sockets + ARRAY_SIZE(sockets); s++)
 		test_redir(type, redir, maps, s, s);
@@ -451,7 +453,6 @@ static void test_map(enum bpf_map_type type)
 			return;
 		}
 
-		skel->bss->redirect_type = type;
 		maps.verd = bpf_map__fd(skel->maps.verdict_map);
 		get_redir_params(r, skel, &prog_fd, &attach_type,
 				 &skel->bss->redirect_flags);
@@ -459,7 +460,7 @@ static void test_map(enum bpf_map_type type)
 		if (xbpf_prog_attach(prog_fd, maps.in, attach_type, 0))
 			return;
 
-		test_sockets(type, r, &maps);
+		test_sockets(type, r, &maps, &skel->bss->redirect_type);
 
 		if (xbpf_prog_detach2(prog_fd, maps.in, attach_type))
 			return;

-- 
2.50.1


