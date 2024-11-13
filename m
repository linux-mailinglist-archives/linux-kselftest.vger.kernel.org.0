Return-Path: <linux-kselftest+bounces-21932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C61A9C7302
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 15:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9870B24706
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE53A1DF978;
	Wed, 13 Nov 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="No6i8T17"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5541D88C4;
	Wed, 13 Nov 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506038; cv=none; b=Cs59WinD6O/kpyv3u4F89+nkitg42KHXPwzR/uol6EkaIJeYG+neNmGlUaKMmNutGv4+gSBKl7f7OHDf3exvyEZMFv+tEuvAAsQ8Fcp4FvrvZwGHUoRGVxb6XRfAp/XAMOKpSQ2ik0xvv7Tk06C/LEM8ZTVwrhB/mwBqQS9yiLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506038; c=relaxed/simple;
	bh=/HUWGsxkdIsxfJ7EzIyVHvdpufTGZWFZ4X+DZQ5bl/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sjn6M+XIP+R+WFx1JQmPi942du7HrL80H8Ftmav+iHWWT7v1JZdQ9qx4dyFGPRZ9PRzxb2J8KwZe4G+HQF50o3w1CO097GQjQNxX8OCz0fik9woqih0fNL6LU3gzhb4LzJ7UZvpYNIxgQBqqZiSEGnpe0kI+ZYfK8tBq00D+mfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=No6i8T17; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E86120005;
	Wed, 13 Nov 2024 13:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731506034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aYiFKvTK5rWFG/UdHeix0aT9loXjRZeDSaCLkDrIvnM=;
	b=No6i8T17/mTGxEeKeLdrwxmTfae/NGHC/LBaPNFl1mBXFGErRvUdNNcT6bOW/6Q3bDWE0E
	84VtMbBQ8vpLcvEITrO9Qn3mAJveGoYE+5rjAuV0jL5V7iHEuylLoE8Gv1JBWzEYovgG09
	yoDcfYxTiU7ZjdO26z4hEHlNJTt+egn/zR/JI59XvYl3NNl8hW4HaiRtx6lxX7yA8KIRtK
	YZ40d/EqMCYMNFWMRJ+DVv5S6dq41QK3Jlnlz2itBQWGaon2lhk4drdwd0u8HmJbQXAXno
	PY0TJBSQVT1MPKv6kOOuYg5y1IY2T5OEVwadkK8AHEF4O74na76hWBCyr1HgsA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 13 Nov 2024 14:53:24 +0100
Subject: [PATCH bpf-next 01/10] selftests/bpf: add a macro to compare raw
 memory
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241113-flow_dissector-v1-1-27c4df0592dc@bootlin.com>
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
In-Reply-To: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

We sometimes need to compare whole structures in an assert. It is
possible to use the existing macros on each field, but when the whole
structure has to be checked, it is more convenient to simply compare the
whole structure memory

Add a dedicated assert macro, ASSERT_MEMEQ, to allow bare memory
comparision

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/test_progs.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 74de33ae37e56c90646cd1e0bb58ed7e3f345ec0..bdde741543836991398daacfe5423e6af8ef9151 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -186,6 +186,19 @@ void test__skip(void);
 void test__fail(void);
 int test__join_cgroup(const char *path);
 
+#define DUMP_BUFFER(name, buf, len)						\
+	({									\
+		fprintf(stdout, "%s:\n", name);					\
+		for (int i = 0; i < len; i++) {					\
+			if (i && !(i % 16))					\
+				fprintf(stdout, "\n");				\
+			if (i && !(i % 8) && (i % 16))				\
+				fprintf(stdout, "\t");				\
+			fprintf(stdout, "%02X ", ((uint8_t *)(buf))[i]);	\
+		}								\
+		fprintf(stdout, "\n");						\
+	})
+
 #define PRINT_FAIL(format...)                                                  \
 	({                                                                     \
 		test__fail();                                                  \
@@ -344,6 +357,18 @@ int test__join_cgroup(const char *path);
 	___ok;								\
 })
 
+#define ASSERT_MEMEQ(actual, expected, len, name) ({			\
+	static int duration = 0;					\
+	const void *__act = actual;					\
+	const void *__exp = expected;					\
+	int __len = len;						\
+	bool ___ok = memcmp(__act, __exp, __len) == 0;			\
+	CHECK(!___ok, (name), "unexpected memory mismatch\n");		\
+	DUMP_BUFFER("actual", __act, __len);				\
+	DUMP_BUFFER("expected:", __exp, __len);				\
+	___ok;								\
+})
+
 #define ASSERT_OK(res, name) ({						\
 	static int duration = 0;					\
 	long long ___res = (res);					\

-- 
2.47.0


