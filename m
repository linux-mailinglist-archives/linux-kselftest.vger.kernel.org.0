Return-Path: <linux-kselftest+bounces-22050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FAF9C94B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 22:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1E428335C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 21:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D078B1B0F0C;
	Thu, 14 Nov 2024 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="enXEuR2z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9048A18C018;
	Thu, 14 Nov 2024 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731621076; cv=none; b=O9f5ROqxgKYXrbWdVTjMTN3SL/63vgjLXsBmHilNTAW9pkpMT96uWKLUWqGAvIfI+RiOsr+s3jmNbkNPauZikw7kJH4BTT4ItLps3gfMSt8ZTRUkyhd0BMDtHeUUOqA2FkADiS0Dl5pIjafncHKaBIynRvzp7CGFZNcr8piEAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731621076; c=relaxed/simple;
	bh=1t1L2fnVkHEpBKMvQjhX3AMa3i/cLMZbS5Onl55h1cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=No14qKxtL7vlgxP3orkYtMYwEeyE6Ap4p1JCpIDMD6qZIKqgqcFMglTYvu2qmvcPNwKCwJb2izpRFARktbekSjA9Wf3LOsFsrRtVSw94onrAIp8CEngOLZvcaiyiYzYzW/jPx5Mdm1ngZMQEupu7fk8i0uutV+OzNoFyYg5nGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=enXEuR2z; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6FCD020005;
	Thu, 14 Nov 2024 21:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731621071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwz6RETh+fhCt/zj4uR0f8EdtVk3n3gmgQD8Cbkbcp8=;
	b=enXEuR2zIPsMCS8yCGwj1v9+VC2+mtsk4YYMQ9wWGe2k7Ucj2gQgz0Li3HUqepq2acJt3y
	MTKMLHuFraO09SnYRMtiq+jBYQcx6tMpLfU39IQvgwiAtPdkeYzFvN7bbslyuiW4L7BJL4
	NBUY5+Z1kqNcqBEJPABdtljxLWoKN5tqNKJP6rISI4TRVFN34ErqhtZi88wpsvlQCspcrm
	bdzXH4/6LL5uLdmU0mWU68P+fTocyURNwtAaUu/tluXoE7lz6I3mAfvt9Eb/+UYPxl4pMk
	SnzzFFNU53uQMVBcOKfZgCqj86PICU20giV7zYXQNsMlWjr2fwnENVUNsV00/w==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 14 Nov 2024 22:50:32 +0100
Subject: [PATCH bpf-next v2 01/13] selftests/bpf: add a macro to compare
 raw memory
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241114-flow_dissector-v2-1-ee4a3be3de65@bootlin.com>
References: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
In-Reply-To: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
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

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
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


