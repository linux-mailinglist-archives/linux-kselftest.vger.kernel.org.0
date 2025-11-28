Return-Path: <linux-kselftest+bounces-46712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C420C9341D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 23:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A6DB34226E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 22:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6352F60C1;
	Fri, 28 Nov 2025 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0UuSSr2/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9AB2F12D3;
	Fri, 28 Nov 2025 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764368862; cv=none; b=g4yXJe/8a2XHCDBfrfasv4ms+oYEUSaEJz6BeYZTuz4Qhm68zeucOH5tgWEhVoTCKjojMomGs8C9I31q0/fhzFB8JWrgxAqZrGDqdDpVt2XsjDyBefnLU3JuW6+Kc+bETNDWbN8M0M2nADC3cqIKsijzk+vfed7+mLpx9CPKw+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764368862; c=relaxed/simple;
	bh=kmh6ENzofXIt4PAXZH0Z7jfrbDrhfbIKRSttu04afiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=igDRf3tFW+432sw+f5IvhIUPHlQmOKPcFeZsniQ+ZT3FDaKLiFm5NVzk1dSeWDaT+8upsEz4BOCZWLrDg8wQYl7dPjWfSo4Latyexxwm7usNKwplnh6YWj1noR3tS7852bu8RBvnQoGAD0evwyc6Xwa06iQ8Uxh4/gUqkmOwTA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0UuSSr2/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DB72F1A1E11;
	Fri, 28 Nov 2025 22:27:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AFE8E60706;
	Fri, 28 Nov 2025 22:27:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 064D810B02592;
	Fri, 28 Nov 2025 23:27:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764368858; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NbJJlFsehdI9InaPGxFPtlAMd7ghBkNRbJp1O6wK1xY=;
	b=0UuSSr2/hkGVdCZldRlsE+zz8BwXcaukxPw1hFaOfFV5kGckmpBvvzS5m/o9T4do33b/UZ
	eWCtdktbpcJojSoLLtPwyz4bOPsyIi52X1Zyss6/OThTBX/mhWW/hIl6t+pRU2gO4cUfCT
	qUmapUjwNx9Y1RKIrSmSxFUEBtXp2MwnsqKMPSegPpkbIdYtRmArXCUWHN/lDMi8J3OsZe
	ZdETLYrSvAhr5oGHWf9Z5cnRTU+7OCM+E6IEJgM0Cl7F64MyMGu22u7DNqBfRMIp4BDV8J
	JVHXnSH1XQY6tIqQKDdg4tO/wPFjXIoGUWPuRWv5KSQyZEbt4YPpx/tY+d1O5g==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 28 Nov 2025 23:27:21 +0100
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: do not hardcode target rate
 in test_tc_edt BPF program
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251128-tc_edt-v2-4-26db48373e73@bootlin.com>
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
index 9ba69398eec4..462512fb191f 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
@@ -66,6 +66,7 @@ static int setup(struct test_tc_edt *skel)
 	ret = tc_prog_attach("veth2", -1, bpf_program__fd(skel->progs.tc_prog));
 	if (!ASSERT_OK(ret, "attach bpf prog"))
 		goto fail_close_server_ns;
+	skel->bss->target_rate = TARGET_RATE_MBPS * 1000 * 1000;
 	close_netns(nstoken_server);
 	close_netns(nstoken_client);
 
diff --git a/tools/testing/selftests/bpf/progs/test_tc_edt.c b/tools/testing/selftests/bpf/progs/test_tc_edt.c
index d31058cf4eca..4f6f03122d61 100644
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
2.51.2


