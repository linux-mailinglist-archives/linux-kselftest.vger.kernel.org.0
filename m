Return-Path: <linux-kselftest+bounces-22318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CBB9D3447
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 08:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE5728488A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 07:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320DC165EED;
	Wed, 20 Nov 2024 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="naIQ+pK/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F4158D79;
	Wed, 20 Nov 2024 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088613; cv=none; b=SeGoKzGuuhrl95/iim75EV7SCdfj89AuVcqglUPBxDbFtCG69wybcvIMiqVIbSRohnqH1+V5S89wrYqu68R5TG1/QA961dhjlGPEbCm823+HxvjjYshDvassGHJ4wVFovDGWkE6Gvn22gOHOSbzaCa4rNxLv3ILa2pcmVuH6BMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088613; c=relaxed/simple;
	bh=nY1ABuW5bsvP34Tc/ZBG35W0W3ziUMfwf8JaBTNVBqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rlzjx/ICyaGribqKE85iJTTTMDhkKCG/+LCINyvsR7SiCTWnvnyap0d+93CltQddcicxS2WvV6uJnS62syzKyEiEiAI7YDcCajQIDRQwKHTsedY0RZT3SDNefZGNmwaisjNYbs9Yv6y0/Vu8duRrjiGDQ6lcNKRG4HE3EzYXLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=naIQ+pK/; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8985240004;
	Wed, 20 Nov 2024 07:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732088608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5t7U3zj6C7oj9CfjNAnX9OzAUYLiCf7cJ4qumLlNgoU=;
	b=naIQ+pK/3LTilZec2zX0pGsX2qvwxnaa64/kdqYJCatna3EHlSlx3QDHeIqz6OPKGOMgDZ
	JMqAX4sO2ITAhgHlROSgDMgH0SI4Dhb/9Pxhs3BAkb/VaIzyvy5BrC5JXqEvoY8x09gB4x
	Xp9qvnUzi5olJRhbU9y80e/raN5hKDThm0BltWZ3Q68LyiUg58ZeFhcZ5shtoAyEQ8X3mt
	5MKPRrfrZ4q5lqUnB7BxmTi0VSR1/Y+y3N8TpdeVBh3V5BHW/V3Bxxd41rLdBHXIdn91XQ
	XMB4S4ZUgYHfRIx0vIisqM7FTOmbkedewBH9DKpbe6+zknyAb11eS5Zy2nBMIQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 20 Nov 2024 08:43:11 +0100
Subject: [PATCH bpf-next v3 01/14] selftests/bpf: add a macro to compare
 raw memory
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-flow_dissector-v3-1-45b46494f937@bootlin.com>
References: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
In-Reply-To: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

We sometimes need to compare whole structures in an assert. It is
possible to use the existing macros on each field, but when the whole
structure has to be checked, it is more convenient to simply compare the
whole structure memory

Add a dedicated assert macro, ASSERT_MEMEQ, to allow bare memory
comparision
The output generated by this new macro looks like the following:
[...]
run_tests_skb_less:FAIL:returned flow keys unexpected memory mismatch
actual:
	00 00 00 00 00 00 00 00 	00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 	00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 	00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00
expected:
	0E 00 3E 00 DD 86 01 01 	00 06 86 DD 50 00 90 1F
	00 00 00 00 00 00 00 00 	00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 	00 00 00 00 00 00 00 00
	01 00 00 00 00 00 00 00
[...]

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- none

Changes in v2:
- replace DUMP_BUFFER with a real function
- make this function take a prefix
- add formatting example in the commit message
---
 tools/testing/selftests/bpf/test_progs.c | 15 +++++++++++++++
 tools/testing/selftests/bpf/test_progs.h | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 6088d8222d5905c3df6e6ebfb095c6bc5bf22399..c9e745d49493e594b55d79ac26061b0466f9a039 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1282,6 +1282,21 @@ void crash_handler(int signum)
 	backtrace_symbols_fd(bt, sz, STDERR_FILENO);
 }
 
+void hexdump(const char *prefix, const void *buf, size_t len)
+{
+	for (int i = 0; i < len; i++) {
+		if (!(i % 16)) {
+			if (i)
+				fprintf(stdout, "\n");
+			fprintf(stdout, "%s", prefix);
+		}
+		if (i && !(i % 8) && (i % 16))
+			fprintf(stdout, "\t");
+		fprintf(stdout, "%02X ", ((uint8_t *)(buf))[i]);
+	}
+	fprintf(stdout, "\n");
+}
+
 static void sigint_handler(int signum)
 {
 	int i;
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 74de33ae37e56c90646cd1e0bb58ed7e3f345ec0..404d0d4915d54fe15f6c33dbabdb58cccc3b2781 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -185,6 +185,7 @@ void test__end_subtest(void);
 void test__skip(void);
 void test__fail(void);
 int test__join_cgroup(const char *path);
+void hexdump(const char *prefix, const void *buf, size_t len);
 
 #define PRINT_FAIL(format...)                                                  \
 	({                                                                     \
@@ -344,6 +345,20 @@ int test__join_cgroup(const char *path);
 	___ok;								\
 })
 
+#define ASSERT_MEMEQ(actual, expected, len, name) ({			\
+	static int duration = 0;					\
+	const void *__act = actual;					\
+	const void *__exp = expected;					\
+	int __len = len;						\
+	bool ___ok = memcmp(__act, __exp, __len) == 0;			\
+	CHECK(!___ok, (name), "unexpected memory mismatch\n");		\
+	fprintf(stdout, "actual:\n");					\
+	hexdump("\t", __act, __len);					\
+	fprintf(stdout, "expected:\n");					\
+	hexdump("\t", __exp, __len);					\
+	___ok;								\
+})
+
 #define ASSERT_OK(res, name) ({						\
 	static int duration = 0;					\
 	long long ___res = (res);					\

-- 
2.47.0


