Return-Path: <linux-kselftest+bounces-14520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBC5942B7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3CD21C20DC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C561AE865;
	Wed, 31 Jul 2024 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="hq4ReaKp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3381AE841;
	Wed, 31 Jul 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420124; cv=none; b=BHJ0hZd0VJ6SaN2Q77AkAA2WoukyNBPdC/MQojZq6qz7rJJx0xS6dVjbnZ++1uq7lGJKcRJsRPQMylWrHie5y1G3JLixHdJN1ndWPeX1BeHHWuq1JvjGWYXcgfZK6WHU54OVcN4tnL6uyt1F3qaLe63giQ0BXLv+RTrnzTMUWDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420124; c=relaxed/simple;
	bh=YtKGjVmznTaP+uG+xNnwv2w/Omxd9HhwCtFydYbreGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mSpbZoxxb8HjiaJSSAZlZQYLP4865fduNm4/99DlWFi2/24mVDF5eMkV42k53UEctz+1irhkdYnvjdyHDNzYvLSdKwaYlONs5s3HDFc7hVljDPMNNgyGqSQDHQLsCg0bGn/CLbvPJh4m5OTsrihKQyDi4p6H1+T60SkecOmg+30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=hq4ReaKp; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sZ69S-009FBm-Is; Wed, 31 Jul 2024 12:01:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=li0JujrPpPpO/xAc8QiZ65BoP8NJpRd+3obwcRQIRXc=; b=hq4ReaKpol8TfZMlYO2sx0as2T
	4/HM+rolpTYA0hM5S+Omf8YK59fi5SKD4Au51wAVINCKsUNeBDZe9IDC/H2cTgxJQYx8wXBT/ndnR
	1kkqe94684FVC62clYfi58QhlnxT3HYbUyNDKYR5ufktz0pETW9xxHhYa/rCUyVQNgPH2+u36R0Up
	VPLalKu48r5UtHWk1QmxNWjNa5Y+dT8b4QWITHAHv8hNWEPexraY4Gwdu0dr3xW9H3vL6hzR957ER
	JVMaw4oAJWtyzmg05KQR5b2Egy3dF/qz/vBnlMLwOHAPZdQQUzV9LIywwuvVBd8RWuVLYv8w4evRB
	BnEDcL7Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sZ69R-00020n-OL; Wed, 31 Jul 2024 12:01:46 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sZ69H-006dO6-W6; Wed, 31 Jul 2024 12:01:36 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 31 Jul 2024 12:01:29 +0200
Subject: [PATCH bpf-next v2 4/6] selftests/bpf: Honour the sotype of
 af_unix redir tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-selftest-sockmap-fixes-v2-4-08a0c73abed2@rbox.co>
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
In-Reply-To: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.1

Do actually test the sotype as specified by the caller.

This picks up after commit 75e0e27db6cf ("selftest/bpf: Change udp to inet
in some function names").

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index ea2faacd146d..7ed223df5f12 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1706,11 +1706,11 @@ static void inet_unix_redir_to_connected(int family, int type, int sock_mapfd,
 	int sfd[2];
 	int err;
 
-	if (socketpair(AF_UNIX, SOCK_DGRAM | SOCK_NONBLOCK, 0, sfd))
+	if (socketpair(AF_UNIX, type | SOCK_NONBLOCK, 0, sfd))
 		return;
 	c0 = sfd[0], p0 = sfd[1];
 
-	err = inet_socketpair(family, SOCK_DGRAM, &p1, &c1);
+	err = inet_socketpair(family, type, &p1, &c1);
 	if (err)
 		goto close;
 
@@ -1758,7 +1758,7 @@ static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
 	int sfd[2];
 	int err;
 
-	err = inet_socketpair(family, SOCK_DGRAM, &p0, &c0);
+	err = inet_socketpair(family, type, &p0, &c0);
 	if (err)
 		return;
 

-- 
2.45.2


