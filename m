Return-Path: <linux-kselftest+bounces-30583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE827A85BC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC56E4456FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E03238C34;
	Fri, 11 Apr 2025 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="G4E2swKG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A606920F063;
	Fri, 11 Apr 2025 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371237; cv=none; b=n3UPREHMKux/DK47qI6blv29s0uGu4GU6NM5+61MK0cFHpzOVEWzDlvvISN6g93jBhPFVGIJNZkD9LhOJm1QV0O9daZYRi4qb9ymvynPqHvIp5GOYPtMySpBMYeKaWeV9lifhrQsdwgoVeXfeqhwZZ2y7LOg7GwJkLVwbWhI/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371237; c=relaxed/simple;
	bh=5HjaKrb4OSnZq4HKsJZh48cCqPwW7cyhlHLZdAr8QI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vzfv0bdFtWBr469bUYzzsxxmaZHByw1lMwSa+46OINfE6ZoHKXoOIuGq3gGpduWdglu5P0IxQIddsBEr5NB2NsofwpPbrLw5K5+z++8JDJt9yjQMdVBostuIQhlnYuCLwZwLBUmn/xMzNBIjhCzomx4mJRTd7z4gU4HY2SXw9LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=G4E2swKG; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdm-005qKu-MX; Fri, 11 Apr 2025 13:33:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=bRBtGUHo2mfXsbLumHd/r9ed2RVyNnk36YPXlBUTUBI=; b=G4E2swKGpA+n2ZhxtF2l0a13Ak
	ucO3c4GWByMiOa9f6x7tgkQ+j7wp+VrYrbCMVonnJfe+wTlwf+J4VRG2vuFL6RBZTV/eSpe3NXWi2
	qSgHfYCxkKNBDZ/xnVLyXgnCZ3pgCy4ntTdSMd2wJ/Gr2D/7c/dkJmmSFEOcvrbiSDBxPvl2hHnlM
	m3F+SidVtDRfy2+MoGE+CeodfIJgpeoJcfih6X4kmx/d50N1MfmQ3gMUzOqgW3PhJcFMhzcpiVRwV
	ikgvs9kJmeyeM6tXzqWJ99M5IZcO+Fc4WM01Yomiuf1ued1aSC7JsCoj1WgjiPMuD0H0X3cEPq429
	dK/la4pg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdg-0005qc-1Q; Fri, 11 Apr 2025 13:33:40 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u3CdW-00D5Ut-8V; Fri, 11 Apr 2025 13:33:30 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 11 Apr 2025 13:32:40 +0200
Subject: [PATCH bpf-next v2 4/9] selftests/bpf: Allow setting BPF_F_INGRESS
 in prog_msg_verdict()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-selftests-sockmap-redir-v2-4-5f9b018d6704@rbox.co>
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

Let a selftest set BPF_F_INGRESS for map/hash redirect.

In run_tests(), explicitly reset skel->bss->test_ingress to false. Earlier
tests might have left it flipped.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 2 ++
 tools/testing/selftests/bpf/progs/test_sockmap_listen.c | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 4ee1148d22be3d7f26a5c899542e6a29ca5e7d6c..c8b736f96503829cba51da0f08c545028b48b8c6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1858,6 +1858,8 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
 static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
 		      int family)
 {
+	skel->bss->test_ingress = false;
+
 	test_ops(skel, map, family, SOCK_STREAM);
 	test_ops(skel, map, family, SOCK_DGRAM);
 	test_redir(skel, map, family, SOCK_STREAM);
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
index b7250eb9c30cca8f77675e56529e6b780d76ab2e..5a3504d5dfc32f75f49f969b4935b1c1f3f7c773 100644
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
2.49.0


