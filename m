Return-Path: <linux-kselftest+bounces-1973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D67813DF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 00:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBED1F227DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 23:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268EE6DCF2;
	Thu, 14 Dec 2023 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Ylob5p1y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z8QNha96"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7749266AA4;
	Thu, 14 Dec 2023 23:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 3FEE73200B6C;
	Thu, 14 Dec 2023 17:56:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 14 Dec 2023 17:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1702594609; x=
	1702681009; bh=L/0CxpH+ItkIN3jpcTP0mXpLYvcBH1FSKHM4RQL+UFM=; b=Y
	lob5p1y1K4j5mjBFalFycAkqaKaqz1FROzRP7NWkpEROFzy1e6SUuDGfMro/YXW7
	FhjzgdFCa70PDXuds5aDqFaw53gjddDbSraAF+MhTKm+OBFDkEqWZYP1r6c891Eu
	FJWJVU5C7/K2myRzOSiegHkravmvJMcDxiaXJ6CkUOmpjIBvUWg+7vPkUaNfMEKM
	FuKCwOHLdM13dBAyjrwKm8RnC2fZ1umgcmm8JCbTaVGb3pocHmib/cVoNatQ+/Vz
	vXFOKXun5v8LjJFAJfq/UncZ12je4stK9I/h1Nmdxj7tnM88vWM/U1eLll66IDan
	9utJ5oH21kB+ke8oFAjbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702594609; x=
	1702681009; bh=L/0CxpH+ItkIN3jpcTP0mXpLYvcBH1FSKHM4RQL+UFM=; b=Z
	8QNha96yOnxWRQSSo1nDSWCFHxIJmkn9MYYFdco3NpHSKLe7MimAxTTHpGymneOn
	6MLJI4IF8TJ8zEAsdWP2cfpFR/ZM0Ylfphy0HLodutXTIGujX395+upYWsL81wjN
	x4X1XBmlD06f2OGrC8XYdP/an6b2s7OxfZT2O0Tb4tc+slGTmn1JDgj3YXKCMSes
	MmZy09onNnLpBo7i0Ymd/NPcL3o/jfSlfa/sSXXYhk5lntMpOwlYrHqd/HDTcvj2
	dfV8Vt2frgzhmGOpTJc64fq1jV/Yfp5O90iOOTlcLZKNa3ErJgfCC8YgNbjUJNea
	G6x1YfFa1llnZqwqWOQ9g==
X-ME-Sender: <xms:MYh7ZQqLDB2aFxr89_HkEd6e3cq0Wq3s2oYc23imxhwnSxJyufausA>
    <xme:MYh7ZWpLcMT2FG8HKhZtzDOZOnwTfYJ-Ehk5ypqMJDsLju30yDxuOsGtgvo3ZMp6N
    XFyB7PHxhwllgh3NA>
X-ME-Received: <xmr:MYh7ZVOwqfCC0ikk9qKO-0kxnNZA5yPPKhDlUlAElT3Ee86lUD1XZcLAvClPnryRyHO4dnSsmnLJkgIsBqJajer8jqxaEJFORjaY3chb12XbUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddttddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:MYh7ZX4RErih6CpEIXgwZdIR6kbw54fNJlOzLCY5goNPZdi2WZ2IeQ>
    <xmx:MYh7Zf5q1Dtpd4DySwptq0vLjSXnv8SgsYGel5GxGz75mF5mrsOnyw>
    <xmx:MYh7ZXheoLhmCso0xSoVNLdNqLXG-udhneYFW3JI2FM7EUIQuD9X1w>
    <xmx:MYh7Zequa_MbO1bt_NrTOInc1lRx5EOcjMrxGTC9VeeL3mk--b8QXA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 17:56:48 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org,
	memxor@gmail.com
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/3] bpf: selftests: Test bpf_assert_if() and bpf_assert_with_if()
Date: Thu, 14 Dec 2023 15:56:27 -0700
Message-ID: <b94a4280fb281f13cba3cc314f4c20a34138e6a6.1702594357.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702594357.git.dxu@dxuuu.xyz>
References: <cover.1702594357.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some positive and negative test cases that exercise the "callback"
semantics.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/prog_tests/exceptions.c     |  5 ++
 .../testing/selftests/bpf/progs/exceptions.c  | 61 +++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
index 516f4a13013c..a41113d72d0d 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -83,6 +83,11 @@ static void test_exceptions_success(void)
 	RUN_SUCCESS(exception_assert_range_with, 1);
 	RUN_SUCCESS(exception_bad_assert_range, 0);
 	RUN_SUCCESS(exception_bad_assert_range_with, 10);
+	RUN_SUCCESS(exception_assert_if_body_not_executed, 2);
+	RUN_SUCCESS(exception_bad_assert_if_body_executed, 1);
+	RUN_SUCCESS(exception_bad_assert_if_throws, 0);
+	RUN_SUCCESS(exception_assert_with_if_body_not_executed, 3);
+	RUN_SUCCESS(exception_bad_assert_with_if_body_executed, 2);
 
 #define RUN_EXT(load_ret, attach_err, expr, msg, after_link)			  \
 	{									  \
diff --git a/tools/testing/selftests/bpf/progs/exceptions.c b/tools/testing/selftests/bpf/progs/exceptions.c
index 2811ee842b01..e61cb794a305 100644
--- a/tools/testing/selftests/bpf/progs/exceptions.c
+++ b/tools/testing/selftests/bpf/progs/exceptions.c
@@ -365,4 +365,65 @@ int exception_bad_assert_range_with(struct __sk_buff *ctx)
 	return 1;
 }
 
+SEC("tc")
+int exception_assert_if_body_not_executed(struct __sk_buff *ctx)
+{
+	u64 time = bpf_ktime_get_ns();
+
+	bpf_assert_if(time != 0) {
+		return 1;
+	}
+
+	return 2;
+}
+
+SEC("tc")
+int exception_bad_assert_if_body_executed(struct __sk_buff *ctx)
+{
+	u64 time = bpf_ktime_get_ns();
+
+	bpf_assert_if(time == 0) {
+		return 1;
+	}
+
+	return 2;
+}
+
+SEC("tc")
+int exception_bad_assert_if_throws(struct __sk_buff *ctx)
+{
+	u64 time = bpf_ktime_get_ns();
+
+	bpf_assert_if(time == 0) {
+	}
+
+	return 2;
+}
+
+SEC("tc")
+int exception_assert_with_if_body_not_executed(struct __sk_buff *ctx)
+{
+	u64 time = bpf_ktime_get_ns();
+	int ret = 1;
+
+	bpf_assert_with_if(time != 0, ret) {
+		ret = 2;
+	}
+
+	return 3;
+}
+
+SEC("tc")
+int exception_bad_assert_with_if_body_executed(struct __sk_buff *ctx)
+{
+	u64 time = bpf_ktime_get_ns();
+	int ret = 1;
+
+	bpf_assert_with_if(time == 0, ret) {
+		ret = 2;
+	}
+
+	return 3;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.42.1


