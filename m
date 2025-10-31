Return-Path: <linux-kselftest+bounces-44532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281F3C25ED9
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25C0406880
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557A62F3615;
	Fri, 31 Oct 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NMVgH6ou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D92F28EB;
	Fri, 31 Oct 2025 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926136; cv=none; b=mV97t7kfWke//I00tCNRCTjY9UY8cfLvdgpfJsJeekrNGVQimpmdjkT+GHDkhyAVkeVJc049M2Z1/t1OdTKpNaLoN9xqE17lNCmZo5rIlC4SeeH3Jput0krIljtwOqHAzczfG+GTdYaThbKIqXpJJa/MWHNKO6gI5CK7vy8iCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926136; c=relaxed/simple;
	bh=DS7GdoyTSbp4Av0r2ONCH04vR0freNolpLYPdTzZ/dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lI4p2PwG4Azllp/tKIhZDrLbrNX0YvTA0tIhs5C98lVUPxA7A045sY1iFwKq9Bf07CJtXREmy7pG2VHK+M7edsC0q9c11Z0q1dP81/7KFMPGF/sqhaNgcnADu0P9izTesW9tBVj2P/hTnIIsVG8nvylAoLlA4z0lUG8zb5WZwac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NMVgH6ou; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1470AC0E95B;
	Fri, 31 Oct 2025 15:55:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 97A9A60704;
	Fri, 31 Oct 2025 15:55:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFAFB11818066;
	Fri, 31 Oct 2025 16:55:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761926131; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/TNq8Noeo82uL94tALlA2YUHtpAfFnqYiA1L+FN+m5w=;
	b=NMVgH6ourG6tGxcvYLakUnTebijMsJSQ16SZ9ctt+0ulVANK/wrAoz3XVv1Py78ujjDoCS
	+vIs22BCxK36OLqECqtYWmcxxs6tzODcJ7FY6EDqXoAC8fd0s70+Hp8VOK9yDg5opi3xZK
	vwY1sIIxbIcA/LOaQLn+u9gAqPbz3edShDiRSLGnt2z8GXYS5Sbyi9fHx/NPldk+hvRuww
	vssH2eUzE8qZ1GdPOk7TAwKDUGxdAXttbgqy0AKCxaLwN8snUXFmTQMANXrrLrBG4pw6Vo
	2bQhIpKGXfzJmos6i5gsMpc8tMRCiZ1ALgdm5wF5Ktvq5qYEZ8xjixfVH6JGtA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 31 Oct 2025 16:55:16 +0100
Subject: [PATCH bpf-next 4/4] selftests/bpf: do not hardcode target rate in
 test_tc_edt BPF program
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-tc_edt-v1-4-5d34a5823144@bootlin.com>
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

test_tc_edt currently defines the target rate in both the userspace and
BPF parts. This value could be defined once in the userspace part if we
make it able to configure the BPF program before starting the test.

Add a target_rate variable in the BPF part, and make the userspace part
set it to the desired rate before attaching the shaping program.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/test_tc_edt.c | 1 +
 tools/testing/selftests/bpf/progs/test_tc_edt.c      | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c b/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
index a77e48fdf4e4..72b51376df10 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
@@ -175,6 +175,7 @@ static int setup(struct test_tc_edt *skel)
 	SYS(fail_close_client_ns, "ip -4 addr add " IP4_ADDR_VETH1 "/24 dev veth1");
 	SYS(fail_close_client_ns, "ip link set veth1 up");
 	SYS(fail_close_client_ns, "tc qdisc add dev veth1 root fq");
+	skel->bss->target_rate = TARGET_RATE_MBPS * 1000 * 1000;
 	ret = tc_prog_attach("veth1", -1, bpf_program__fd(skel->progs.tc_prog));
 	if (!ASSERT_OK(ret, "attach bpf prog"))
 		goto fail_close_client_ns;
diff --git a/tools/testing/selftests/bpf/progs/test_tc_edt.c b/tools/testing/selftests/bpf/progs/test_tc_edt.c
index 9b80109d5c3d..99bae5e20685 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_edt.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_edt.c
@@ -14,7 +14,6 @@
 #define TIME_HORIZON_NS (2000 * 1000 * 1000)
 #define NS_PER_SEC 1000000000
 #define ECN_HORIZON_NS 5000000
-#define THROTTLE_RATE_BPS (5 * 1000 * 1000)
 
 /* flow_key => last_tstamp timestamp used */
 struct {
@@ -24,12 +23,13 @@ struct {
 	__uint(max_entries, 1);
 } flow_map SEC(".maps");
 
+__uint64_t target_rate;
+
 static inline int throttle_flow(struct __sk_buff *skb)
 {
 	int key = 0;
 	uint64_t *last_tstamp = bpf_map_lookup_elem(&flow_map, &key);
-	uint64_t delay_ns = ((uint64_t)skb->len) * NS_PER_SEC /
-			THROTTLE_RATE_BPS;
+	uint64_t delay_ns = ((uint64_t)skb->len) * NS_PER_SEC / target_rate;
 	uint64_t now = bpf_ktime_get_ns();
 	uint64_t tstamp, next_tstamp = 0;
 

-- 
2.51.1.dirty


