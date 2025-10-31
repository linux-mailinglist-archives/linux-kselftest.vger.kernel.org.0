Return-Path: <linux-kselftest+bounces-44529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A6FC25EC1
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6329E3BE5AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9762EE5F4;
	Fri, 31 Oct 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tJ177pes"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45CA2E8E00;
	Fri, 31 Oct 2025 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926129; cv=none; b=es79UgZ6amLCI8F0ZMDI1huwcGaMnT5mMkjiYXnar3kx1/LOk7VX6wWWiMHo/GtiHVg032Z5sYguu7/mMBHy7H4pSUoC1TgSf8SMzhWvzkpCO6j1UjCTxXoRrAmatI/oSeXkyIWm0EF3akWkPDvkShJdidZ9CT+2HOAiFNAtYpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926129; c=relaxed/simple;
	bh=y2YwLjlXI824LBCVKOlkoBk28o/Z3o0tUlA3oxiFcls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g40EZ/DX7Z63i4FInl3JollxA3GlP6WrybhChKjpYWMRnRA7WTahLTGycx3RGphmXA9e/Aiwu6rLr4YRqFHY7BBNhBdwHtahayF9cqEwQ2v6KqCh/f9Ir984dOUvnxRzX3gGrZ1xXbyQ82/89FiwrvpPvWhov6W6KgbU6K+yNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tJ177pes; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 24A904E41443;
	Fri, 31 Oct 2025 15:55:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F070360704;
	Fri, 31 Oct 2025 15:55:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1900311818066;
	Fri, 31 Oct 2025 16:55:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761926124; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/YT+5ajEU6aJJ0lNTYWkpsrNNaSWfDxnF665EcKg6Ps=;
	b=tJ177pesqVpr6TGY/EWGhD8qeHlt7oyipPaVrVN6xBon/QwqHvdv4gEVBVoA6OkNJJYDs0
	6w3MJPrKuRALBFAcwICxNt9IukAWROCNss1J4WgTfu/b+t/0yiC1rtkFC5opV/kupQ+8Az
	zq82gHlANAxaqYdWeVVSRMiD5QqYozhkQGMp8UjlT0ZaSci5WBsunosZPFsza/9GXovJJm
	LUJCXjjxZlJndvw0M2LGjUoxe1h6ctXZOrEAvXwKCpBn880ZQ9/2d6YVo0l1tdOnVM6XXy
	LdOB9Q3mz2qTQCn3ohle4wCTmT2wxHpjNZG8NfkF3tBPa1ewVYH28HyZO96OJg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 31 Oct 2025 16:55:13 +0100
Subject: [PATCH bpf-next 1/4] selftests/bpf: rename test_tc_edt.bpf.c
 section to expose program type
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-tc_edt-v1-1-5d34a5823144@bootlin.com>
References: <20251031-tc_edt-v1-0-5d34a5823144@bootlin.com>
In-Reply-To: <20251031-tc_edt-v1-0-5d34a5823144@bootlin.com>
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
2.51.1.dirty


