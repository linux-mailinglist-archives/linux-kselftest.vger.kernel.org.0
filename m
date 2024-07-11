Return-Path: <linux-kselftest+bounces-13554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B4C92E19B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 10:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B6FB213AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 08:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B584154449;
	Thu, 11 Jul 2024 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DSScV/HK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29A14F9EA;
	Thu, 11 Jul 2024 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685424; cv=none; b=FZPt9KgYUopGeKFPLc2kVbItSO3HeZVZDmW1aeAzMpPyVs+NQpCnQpr6oeWihAE7OhVjz0pEy4EFSuohDGTBZWO+9mRTSMP0+n4MBUWbgune3XMtKhCZ3uAOUOfkXIqAl86pT1Y2fyqmaKNxM0KO3st6rsqARJib7YvNjgs7Ukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685424; c=relaxed/simple;
	bh=mPMPaJ6NYfMmkWphAj5c1fFz2osmjYrh6VBnh5A4vaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fV8yFp5Pr6W+LlU4Augkvw+im5ekXZRev88a+EHIvoOAkakArmZtxbgBBmecrdeKL9F+oovrvCv/vBytRetO1TJar+Gyy6Rezd0F3Dn30eLAzVYgy3BvHCUcY8hSZbOiMlgEpPcM3J3vh80DEntEsV/2JT64mgTz/FdiHGB/Bfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DSScV/HK; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 841FDE000A;
	Thu, 11 Jul 2024 08:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720685414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0P6tXzN3Sz5qeahHtMUGfew6mwqB6sS+9QsEJKqfUOw=;
	b=DSScV/HKeEQ8mt46ZEiHHmLUH2nQGNXvETvlqTqrXhgpARnkF08xTPJqxZa6W7sSO0yW29
	GlrjoqqRKAgGCpvax3Q+BUZiCAt6LDSc8QfhJMg4PF263lIRQDWDXDrtyoZ/CJQMNTlEhQ
	C/kIa7g/GSArm4VEbSfHMC74JII1USYBx+ArtF43OXfYVSn5qJWuK+/st5Eo84lcTJoOCD
	S2Q+eCOyo2MpLormold2Of1MyRDj20fO8L6FmFCqErhb7ZS8QThZEthNwMk5aLEyOtwYOf
	4QqniksEKP28Hnxtz8s8lUPukDtAhDpzE30Brd70nSi441CkK61DPfjSi55ExQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 11 Jul 2024 10:09:34 +0200
Subject: [PATCH 1/3] selftests/bpf: update xdp_redirect_map prog sections
 for libbpf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240711-convert_test_xdp_veth-v1-1-868accb0a727@bootlin.com>
References: <20240711-convert_test_xdp_veth-v1-0-868accb0a727@bootlin.com>
In-Reply-To: <20240711-convert_test_xdp_veth-v1-0-868accb0a727@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

xdp_redirect_map.c is a bpf program used by test_xdp_veth.sh, which is not
handled by the generic test runner (test_progs). To allow converting this
test to test_progs, the corresponding program must be updated to allow
handling it through skeletons generated by bpftool and libbpf.

Update programs section names to allow to manipulate those with libbpf.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/progs/xdp_redirect_map.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
index d037262c8937..682dda8dabbc 100644
--- a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
+++ b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
@@ -10,19 +10,19 @@ struct {
 	__uint(value_size, sizeof(int));
 } tx_port SEC(".maps");
 
-SEC("redirect_map_0")
+SEC("xdp")
 int xdp_redirect_map_0(struct xdp_md *xdp)
 {
 	return bpf_redirect_map(&tx_port, 0, 0);
 }
 
-SEC("redirect_map_1")
+SEC("xdp")
 int xdp_redirect_map_1(struct xdp_md *xdp)
 {
 	return bpf_redirect_map(&tx_port, 1, 0);
 }
 
-SEC("redirect_map_2")
+SEC("xdp")
 int xdp_redirect_map_2(struct xdp_md *xdp)
 {
 	return bpf_redirect_map(&tx_port, 2, 0);

-- 
2.45.2


