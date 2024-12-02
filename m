Return-Path: <linux-kselftest+bounces-22669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C689E00AE
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 12:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB3E164E1A
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1522F201270;
	Mon,  2 Dec 2024 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="GxhqaNat"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04861D95B3;
	Mon,  2 Dec 2024 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139046; cv=none; b=Gw8c0hU4afoIVMgBWuZ2loK6CJCeEFEa9BRNyhSQRdztA0UkZvmylFmOc5WBqhVngYELvZvyMKMSMV/6D25RvmMsSldLUOOo2CHUCR3sp8SYY4vSZujkkp/MsyOMbooIcwu63gX+qv+S6910RufHRAPvhCg+QjspaZbGBjzFW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139046; c=relaxed/simple;
	bh=F37a+aJF4UHUI7GpItd8VwrgkZ2RNvyYj+q1/TC6nB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KdDEKZ3XJKypdEISsOaD2/oR+obcOLIV1/Q67NaorfB5R+jH2ZAyN3ZObSYTUuyYd/FQwiV4SHB2sGnlYygOEtlXU2SKALcaZMOmIFI87r/D/qTVYBRFZKt4LgTyFTNIKGuaxI4OP+ckaxeGmplTbNicRixYAFFNtO86eEDyVV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=GxhqaNat; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tI4dG-0080pX-Lg; Mon, 02 Dec 2024 12:30:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=aeVGQb27H/arR0xVKUL8HLaWubKGPkvhn5GBphp8x+o=; b=GxhqaNatx1Yr9a6kzOk1Erkc1m
	FS7X4Cwn9waY3DHNN22u8tsZXfhuHIPkrK9p1+Wnf9RY1784QQyAZXx99BbskZZnvciiKesAvHy/D
	ILXbuR3ZKkr9Z1zwvmFQMqRa2QRvFTQYNvOUWM3TUMDZedEKOrFAd16qR+xAwLw1Bb/C1zkgy9Fc3
	vIQGgrlPMmr6bz5et9MDXOe/8+Q60LjSqMKsc9wCz8mcaBvK9Qi0MmPvVDWfvLu80p7l+2xS3vCu+
	TaR6heXlvirs4FkzNn215au+WIZXGM57ZBTO8+0P0tmsrC/yl+jQSMJ68QdNRBagHNVbkg618vcUF
	AEtL/0xA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tI4dG-0007Ed-75; Mon, 02 Dec 2024 12:30:26 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tI4d4-007H5a-5Q; Mon, 02 Dec 2024 12:30:14 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 02 Dec 2024 12:29:24 +0100
Subject: [PATCH bpf 2/3] selftest/bpf: Extend test for sockmap update with
 same
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-sockmap-replace-v1-2-1e88579e7bd5@rbox.co>
References: <20241202-sockmap-replace-v1-0-1e88579e7bd5@rbox.co>
In-Reply-To: <20241202-sockmap-replace-v1-0-1e88579e7bd5@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Verify that the sockmap link was not severed, and socket's entry is indeed
removed from the map when the corresponding descriptor gets closed.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index fdff0652d7ef5cdd4892af8c2c83cbf18cbf163f..248754296d972286e45d79331e95a8a6ae824590 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -934,8 +934,10 @@ static void test_sockmap_same_sock(void)
 
 	err = socketpair(AF_UNIX, SOCK_STREAM, 0, stream);
 	ASSERT_OK(err, "socketpair(af_unix, sock_stream)");
-	if (err)
+	if (err) {
+		close(tcp);
 		goto out;
+	}
 
 	for (i = 0; i < 2; i++) {
 		err = bpf_map_update_elem(map, &zero, &stream[0], BPF_ANY);
@@ -954,14 +956,14 @@ static void test_sockmap_same_sock(void)
 		ASSERT_OK(err, "bpf_map_update_elem(tcp)");
 	}
 
+	close(tcp);
 	err = bpf_map_delete_elem(map, &zero);
-	ASSERT_OK(err, "bpf_map_delete_elem(entry)");
+	ASSERT_ERR(err, "bpf_map_delete_elem(entry)");
 
 	close(stream[0]);
 	close(stream[1]);
 out:
 	close(dgram);
-	close(tcp);
 	close(udp);
 	test_sockmap_pass_prog__destroy(skel);
 }

-- 
2.46.2


