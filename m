Return-Path: <linux-kselftest+bounces-46709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B18CC93402
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 23:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE3A3A856C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 22:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29202E8B7C;
	Fri, 28 Nov 2025 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Az7JIzPG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BEE2E266E;
	Fri, 28 Nov 2025 22:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764368856; cv=none; b=ddmTj+VChz6eQEZRB2XGvKwzt5EUfVrGvVPeagtoLX07cx7hkA9WU+Sw1zmt7W9nkmeCDVM52hM8awp63ql39QRQ0PCbCbynkRnRGzrCIZO+AsaUiJhj/q8qOX3mxw+lVMGQC+SHSr9+40+sy78CPDIOkFS99b9xlNM5thbNbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764368856; c=relaxed/simple;
	bh=UOA0t60khVSN/bMn4uhfnWLuRj8VxHon/feXSwRNaGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=unvS8dPeWeM26JU6gGBHjqfasQBt2izRXSAFFKeWGKOPPrKQ79F9udfcg3oha+UxxWYsL6cLTu5+R4sVJdwkVmwDGL5jZC689wJWwxlkK0oKYNxhunZ8u1KvKcm6hpEgu21xUpjYxwLCSSUjumpdZyXA77GJzsis/l8oEXu48lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Az7JIzPG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F043D1A1E10;
	Fri, 28 Nov 2025 22:27:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C571F60706;
	Fri, 28 Nov 2025 22:27:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BDF8410B02592;
	Fri, 28 Nov 2025 23:27:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764368851; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TtWlNHZ6iWxqj8l3sDu9iENK/pI3nl8z2yfzqiYCxMw=;
	b=Az7JIzPGJANARDfSoooF2hXl/gpoWptxbqm6k1popnsHg9fVxK+caZSBDQFM2VEOcpN+q9
	OVLVPbID78gqvKgUt6VWfnOyBlZGJWPbv6yOF2FsrELCxTSR533ZREg9xhOQy/jtb9MKDs
	ur7d/x7vkHxfQ8aX0PpVHOxmfUBbU5KoKvqwE2PEVnJcRseuI+IfPvwjtWZ//KuGSULuPX
	F/OigEhFUqvXlYahMv5aTdM4U2VCwRJyi4dl8sR8Q9L4A0jagrw99N0EkPe3frNfCbHf+S
	LNA7mrYxwosL7IgNLJs1v4+fo5xbTPYH89NswUi0t/pES1J5C/+ysfseFRRxKQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 28 Nov 2025 23:27:18 +0100
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: rename test_tc_edt.bpf.c
 section to expose program type
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251128-tc_edt-v2-1-26db48373e73@bootlin.com>
References: <20251128-tc_edt-v2-0-26db48373e73@bootlin.com>
In-Reply-To: <20251128-tc_edt-v2-0-26db48373e73@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The test_tc_edt BPF program uses a custom section name, which works fine
when manually loading it with tc, but prevents it from being loaded with
libbpf.

Update the program section name to "tc" to be able to manipulate it with
a libbpf-based C test.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/progs/test_tc_edt.c | 3 ++-
 tools/testing/selftests/bpf/test_tc_edt.sh      | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tc_edt.c b/tools/testing/selftests/bpf/progs/test_tc_edt.c
index 950a70b61e74..9b80109d5c3d 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_edt.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_edt.c
@@ -99,7 +99,8 @@ static inline int handle_ipv4(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("cls_test") int tc_prog(struct __sk_buff *skb)
+SEC("tc")
+int tc_prog(struct __sk_buff *skb)
 {
 	if (skb->protocol == bpf_htons(ETH_P_IP))
 		return handle_ipv4(skb);
diff --git a/tools/testing/selftests/bpf/test_tc_edt.sh b/tools/testing/selftests/bpf/test_tc_edt.sh
index 76f0bd17061f..8db8e146a431 100755
--- a/tools/testing/selftests/bpf/test_tc_edt.sh
+++ b/tools/testing/selftests/bpf/test_tc_edt.sh
@@ -55,7 +55,7 @@ ip -netns ${NS_DST} route add ${IP_SRC}/32  dev veth_dst
 ip netns exec ${NS_SRC} tc qdisc add dev veth_src root fq
 ip netns exec ${NS_SRC} tc qdisc add dev veth_src clsact
 ip netns exec ${NS_SRC} tc filter add dev veth_src egress \
-	bpf da obj ${BPF_FILE} sec cls_test
+	bpf da obj ${BPF_FILE} sec tc
 
 
 # start the listener

-- 
2.51.2


