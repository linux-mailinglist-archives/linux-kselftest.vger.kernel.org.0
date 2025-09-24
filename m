Return-Path: <linux-kselftest+bounces-42200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE378B9A5CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B887B3C33
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3206A31158D;
	Wed, 24 Sep 2025 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KMYvXsPe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5372330FF1E;
	Wed, 24 Sep 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725424; cv=none; b=k89vbRz5/s6iKBY/fFomWDZ+aQTiHaVi1vf49715MpYEgtUN80kKm3nVUsxDMfljkDSjsrzp7USTMLQxPNGKu2GZQUOdyOuag4dja4oiiXuUsIERSz0/EXQ6Hrt7ALbE5gEsf5EQ86s6l5mSozgMNugh2VvmyFrBaqz7kGJ8vRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725424; c=relaxed/simple;
	bh=UTdAvwzTJVJsJdRBIZqx8UYFILV84IUDYUjjD/LqFMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TyfGX7eVo2bxbsEuaVN8M1YKWxYYOtQ5usd0JzZTNARuVGvkxcs/tp93RJAu/lxBQ+kfmKuIyZu9hyy1B98tIxK+B7MNJ/Ju17m0U0Dp/ICchO/w7g72Z1QKibd7nliMy0tWlKOQT9MCjVMhvES6ihhV8OvrNT7w922q2F4tbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KMYvXsPe; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C8C074E40D42;
	Wed, 24 Sep 2025 14:50:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9880F60634;
	Wed, 24 Sep 2025 14:50:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 930A0102F18D8;
	Wed, 24 Sep 2025 16:50:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758725419; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Q1E9t3HMoWk9uJ51+vn11N7Peundo5w+fDZjVfqj1wI=;
	b=KMYvXsPexTAT3Zn+96Jc8Fmdd82VplypsaD0xAbHsUNycXNbBELH4z2k6j1pEUy7Eg+y8L
	e0NQN+cF46+E+bthAY2FbF8KaUaZruBOGb5mJz/LIbdkKVSG+mE1e9PJJl9mX3Dd/LYJul
	Tbo9InXRwx6XZofqiwL6HdFZOtAl0UeHugEryyMzRvXNLIvRDTcF3oP++D5mKCKzh9UqR0
	9f/HOpEavmKykYZTd6OR0Xyi4b+42SY0Fr+nqmj2kQXgILs/Uk1SPZd1oEGFypyVzgUaUQ
	k4Bw5yOS8Vj58+VCEMWaXXFEP2T9e57Z4EfHsQEzTBUWHzVQm6A56ES49prcjA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 24 Sep 2025 16:49:42 +0200
Subject: [PATCH bpf-next v4 07/15] selftests/bpf: test_xsk: Release
 resources when swap fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-xsk-v4-7-20e57537b876@bootlin.com>
References: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
In-Reply-To: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

testapp_validate_traffic() doesn't release the sockets and the umem
created by the threads if the test isn't currently in its last step.
Thus, if the swap_xsk_resources() fails before the last step, the
created resources aren't cleaned up.

Clean the sockets and the umem in case of swap_xsk_resources() failure.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 84b724731e26d0c7e67131ec1bd562e223d3d09d..8fe75845d7a6aa5342229fa419fcbaa411ae9e70 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1866,8 +1866,13 @@ int testapp_xdp_prog_cleanup(struct test_spec *test)
 	if (testapp_validate_traffic(test))
 		return TEST_FAILURE;
 
-	if (swap_xsk_resources(test))
+	if (swap_xsk_resources(test)) {
+		clean_sockets(test, test->ifobj_rx);
+		clean_sockets(test, test->ifobj_tx);
+		clean_umem(test, test->ifobj_rx, test->ifobj_tx);
 		return TEST_FAILURE;
+	}
+
 	return testapp_validate_traffic(test);
 }
 

-- 
2.51.0


