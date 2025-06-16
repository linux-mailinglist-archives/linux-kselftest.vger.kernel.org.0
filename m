Return-Path: <linux-kselftest+bounces-35068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7141ADB020
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 14:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EE2170575
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 12:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758292737F9;
	Mon, 16 Jun 2025 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPtU/4bD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8912230D0E
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750076677; cv=none; b=QTw8PzmmYJXZ7KhutIWJOlf8V8NujC4YxqGtKAyS0bpaJOhVoTvNFGno3o3+ebObD+nF0lNJssxA3DG+gTNV28te0Ik/g1Fbx+UMFOkvn9Zuy/oIcqGvrFwuGAOsD4GICWLtWEduqLqZo0x/cMeqE+Ly09O5AJM60L2SQ6n7FM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750076677; c=relaxed/simple;
	bh=3LM6snJi0Ce6lDe6ldJrcKzmUuCla9s2UvqqkVW2BFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Cm3ma9vxerW5zhBuGZh1mae8Ndh1XYWQFzFgQruXW21pavGEMrI/pfNnDsc141oMx8GA9iL0epERHMe1Ua8XX+EK7KWLuWqTQeu5B7yOCuzsyamSQDPf8Aadc2c2u9dwnZhkGSAtkv36OroiWBDOGhrqpam6yvra6Da+Er/i5wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPtU/4bD; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-607b59b447bso7819144a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 05:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750076674; x=1750681474; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AD7KRRpHNhU5Uz1jz5NAfruDi90TK1Z6YNXGVHBZ780=;
        b=VPtU/4bDa4k4qfor4p/V9t8YRi4l4rMFBk7srTvehb8cNxXl7OXc+CCiQrCKsBIzpu
         yobEskWpsvUh9K7s7lCWLia00bwTqAuyka+Y/oKUfirOdvIm7Jvgnsu3saAvpcwDzcfi
         jOanvN3m/HtDTkBXGYAC2Op+6NhNuTKAVysXXmxJzfCeUIOakdCcMhzKV4FVdgwmzXWP
         UGEuQrO0NTUcMA0hTe/iOpoN+CjzD5/NK/eOP8OzYKHUoqxmY0z6mMX89iKMHf29iKqQ
         KKzKj40MmlpgnTad+DUwB2HWrtZHR/E1mEyUiolyvNyIZnfWNCcRd6uuF2nOIzOS80lu
         2npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750076674; x=1750681474;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AD7KRRpHNhU5Uz1jz5NAfruDi90TK1Z6YNXGVHBZ780=;
        b=TiWuw1Nywz6zrXuyOF4bWcTgEgsRDEWspOnhnzFUYSbyV5a+gNWrihuQcxe3G/uipv
         xBD/7f0bZV8h29CFcMY1QUjwQm9tGVgVtloDRWgGz6o5hqHiD+tdkpnIfbV9HFAiTVJq
         kHD0mbPzTXxl6pF4TFCLk2lNTDH1HFR09FKZGix1k1vo/sWB6lWcBYib61HJ0/XlnEKu
         llSsqsm7qKZOnOUzpENdo8ZwGkSzrGdSwpFh03VEcQVqEt209avmLdEt1mIwJdB+Z1Nd
         2NAjJ4W7cG27ST23r3R/TLDBPbMqM+3xJFGcqj8Y59CW8+bo1EfT7k4fpZnGibHR6FZX
         oNvg==
X-Gm-Message-State: AOJu0YzTw/PRCM4o5YpUz54bUZIWgzcjcITk+QBTNRTIvgbYloGNDgBJ
	pQclNbecd2JdKdp/ElLNKvRoiQsTOjCZs2dboL9JaqlNGt6d4yTO1oOp
X-Gm-Gg: ASbGnctQCc57EIaophUrlMK9FVaTCDLwjngkVXEeX5pOWmfPydNqkiNhXRVeFZoxWfr
	JRdJGbt7vRUbXplhOU1YmjsodbTnvMjIXOyw9zuCLuQvMLymPCXhN9An9SpXYzKNlafEtcnwPgw
	IFU/OltxRac+EidDzkNrOVyt1REI8LEFlV4x1fb+t0sQdzZH/+OF3teJC6GptnJ47B0UhtkzwmP
	udi84ITwgw9SySwgf/j3HUTEXGGcjJJTVDi5Jv+4ziD+tbX5UqCaeUc1Y12IpX+JARW6fSyTPkk
	+9r/lDz/Qh3CIC5S+WOUs11Q135hOlPWAA5p/uTWvhruAqlla58iM7f5+mVAuKaBzl7e9Qyv
X-Google-Smtp-Source: AGHT+IFpro3S1m+ppgFk3KTqqLAsH37FukX2KLMV7StaFdRjk3GXHVY6hJHAsVIR80btNB5N35a3og==
X-Received: by 2002:a17:907:1ca1:b0:ad8:9d9b:40f9 with SMTP id a640c23a62f3a-adfad451623mr870256066b.43.1750076673545;
        Mon, 16 Jun 2025 05:24:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adfb6c14386sm424839266b.87.2025.06.16.05.24.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jun 2025 05:24:32 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: shuah@kernel.org,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org
Cc: linux-kselftest@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	usama.anjum@collabora.com,
	skhan@linuxfoundation.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 3/3] selftests: harness: Add kselftest harness selftest with variant
Date: Mon, 16 Jun 2025 12:23:38 +0000
Message-Id: <20250616122338.32678-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250616122338.32678-1-richard.weiyang@gmail.com>
References: <20250616122338.32678-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Each fixture could support variant. Add fixture with variant to verify
the behavior, so we can validate for further change.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 .../kselftest_harness/harness-selftest.c      | 34 +++++++++++++++++++
 .../harness-selftest.expected                 | 22 +++++++++---
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.c b/tools/testing/selftests/kselftest_harness/harness-selftest.c
index b555493bdb4d..2fd5310b33c7 100644
--- a/tools/testing/selftests/kselftest_harness/harness-selftest.c
+++ b/tools/testing/selftests/kselftest_harness/harness-selftest.c
@@ -118,6 +118,40 @@ TEST_F(fixture_setup_failure, pass) {
 	TH_LOG("after");
 }
 
+FIXTURE(fixture_variant) {
+	pid_t testpid;
+};
+
+FIXTURE_VARIANT(fixture_variant)
+{
+	int value;
+};
+
+FIXTURE_VARIANT_ADD(fixture_variant, v32)
+{
+	.value = 32,
+};
+
+FIXTURE_VARIANT_ADD(fixture_variant, v64)
+{
+	.value = 64,
+};
+
+FIXTURE_SETUP(fixture_variant) {
+	TH_LOG("setup %d", variant->value);
+	self->testpid = getpid();
+}
+
+FIXTURE_TEARDOWN(fixture_variant) {
+	TH_LOG("teardown same-process=%d", self->testpid == getpid());
+}
+
+TEST_F(fixture_variant, pass) {
+	TH_LOG("before");
+	ASSERT_EQ(0, 0);
+	TH_LOG("after");
+}
+
 int main(int argc, char **argv)
 {
 	/*
diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.expected b/tools/testing/selftests/kselftest_harness/harness-selftest.expected
index 97e1418c1c7e..ab081c5aba05 100644
--- a/tools/testing/selftests/kselftest_harness/harness-selftest.expected
+++ b/tools/testing/selftests/kselftest_harness/harness-selftest.expected
@@ -1,6 +1,6 @@
 TAP version 13
-1..9
-# Starting 9 tests from 4 test cases.
+1..11
+# Starting 11 tests from 6 test cases.
 #  RUN           global.standalone_pass ...
 # harness-selftest.c:19:standalone_pass:before
 # harness-selftest.c:23:standalone_pass:after
@@ -60,5 +60,19 @@ ok 8 fixture_parent.pass
 # pass: Test terminated by assertion
 #          FAIL  fixture_setup_failure.pass
 not ok 9 fixture_setup_failure.pass
-# FAILED: 4 / 9 tests passed.
-# Totals: pass:4 fail:5 xfail:0 xpass:0 skip:0 error:0
+#  RUN           fixture_variant.v32.pass ...
+# harness-selftest.c:141:pass:setup 32
+# harness-selftest.c:150:pass:before
+# harness-selftest.c:152:pass:after
+# harness-selftest.c:146:pass:teardown same-process=1
+#            OK  fixture_variant.v32.pass
+ok 10 fixture_variant.v32.pass
+#  RUN           fixture_variant.v64.pass ...
+# harness-selftest.c:141:pass:setup 64
+# harness-selftest.c:150:pass:before
+# harness-selftest.c:152:pass:after
+# harness-selftest.c:146:pass:teardown same-process=1
+#            OK  fixture_variant.v64.pass
+ok 11 fixture_variant.v64.pass
+# FAILED: 6 / 11 tests passed.
+# Totals: pass:6 fail:5 xfail:0 xpass:0 skip:0 error:0
-- 
2.34.1


