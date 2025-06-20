Return-Path: <linux-kselftest+bounces-35399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6368FAE11CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 05:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF874A21E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 03:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4631C84DC;
	Fri, 20 Jun 2025 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTGvix4d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61CD19CC28
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750390107; cv=none; b=Mf0eYFgl+imUSxP98/umGcQRhgy/d6lLdBJOnflJ1EqtXkzbQTKsyZCm2bzw0FJGlXnefxnqHKMeCjB6ZeSTGywb9Zxotjqvi6u+ySkM+xPtwJ+Ur/XJDR5Ahuxm1SLf66204iSsfiFx/+EptXej2ZwF+pGZQ5QqhiBuoqePRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750390107; c=relaxed/simple;
	bh=lbC6ohzGPdOjtiAdPlDbAIyMZ/j6eb8i+OrccQQMClw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Inj5JFrS7wAj+X5rvvOuL0O9exmwBRYD9vA29HkA9yQd8k9zPspM5F7aBBRSkKge0Tb/D3DkctmB0t6R+D3osqEphoANJNVY3gS7rX6ImCo39Wg5Pihn2ftsbHPONpDcp9NiApknxrPMGpWfWr3wwO0KKHAo5OuSMxxURewL84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTGvix4d; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-adb2e9fd208so272474766b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 20:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750390104; x=1750994904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi0II4QoC0wt7PqfQjue2Nnicj9y/5LQ3IfBrlsuEOs=;
        b=QTGvix4d9hHILBuG66dYx4ubOkXpbdH2AAAPp5aYKpC3CsdsOkVxi7fRHsROQE4jmz
         0gbLh/wWIL4kpytPLYHpaxTMCZ8n8FSA1WRNf8kX4/h9GDSc7wjIIFmvppNjv+UKj2iy
         fkDWW2F9Np48obMDfGrEuC6LIOj2AZ8HdQfiQs2MnNN1nzNGdR2Hn3xKmCYlriCiwRps
         uyldKi+8H6bBIsAyIvX2UJT7jeHc6kGQLnlR9uOVFhGJcbMAM9a7i1YYSafZiYyeilMZ
         7GI2qve4pU7RLhMgY0BamkHje2pAWlapslrKouXeW+CzpLAhorM6DYeXZV/eAZG11qLO
         bikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750390104; x=1750994904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xi0II4QoC0wt7PqfQjue2Nnicj9y/5LQ3IfBrlsuEOs=;
        b=P40gUQeqVdKDyCyR9d6Cz+LM7l5AeW9c1l/umf4Zy14w6RKgKnZoAISHhA9Sq1TGWe
         s3Ab6sp4gcSVwfiOzXMXAN2lYJ5NQ7cxrcNhYeBjjIq+/5l7TE2oUM5lgfVgmS21ijiv
         vmqObohX6L38MFcuppHKlch9sPeKmcOvN7xS1p8pnrvge7K4AvqWESslpX1bSzJ11l85
         tpvmW0rqEZx8tU4gDJZu11E7w/ee59KjzqqLakqIDY4C7SzLG676OygNdqBdnDn3iKzh
         6wM1tCx1aqbESDMdEnvTndXK4tftlG40YmIRyd+exhmfCrlQDwy39izEe673qokSMzkb
         s4XA==
X-Gm-Message-State: AOJu0YyxBhzWYVlbApmSMZhtVwf0AgFkYim116EMBjwPNYMgnUqJXo01
	NSp/eikXdXXCdM0JjAbuojqPFJx2IEn/hwpX0+AdViNLGO6NOzFD7ghB
X-Gm-Gg: ASbGncsx1QoH2ZZtGuOAT+GxjIPoUvz2INtBz6dCnkaYr5iRbVeHL+E2X4lwLDzNVKb
	pgWWIJIGH6WjdMLJ44wNzduoXouJj5EPmocjBRvRItkgPNNlQYbbBIDexwfuQ34KhhU0XHP8f8x
	9IMKYMD0UaCLsQ+J4vSaFFXJFeQXHO7tzxHKVh1+AKMloWZgEfqCCWOHc32igx65GRM29Ch/qeh
	aecZRGoJ6xYOmnYbsTY2gV0fmQ4P0L6ETKZJyRvBXnw/gBWpuCLDEmHoe/USXawrn0qwVSmBLU+
	tY46Kuvu5GxHyFPBluskXVvWO6ajhQad1VfQ1NUwx/E7sz64I2c+/T+kxxP+Rw==
X-Google-Smtp-Source: AGHT+IHVK2/TFBZ3rsfjj9PHKocVrGXaGRkrvpgI240p+sR9w3yQbF25BHjbQCEVGXdLXQ2h6G7SMg==
X-Received: by 2002:a17:907:2d87:b0:ad5:3055:784d with SMTP id a640c23a62f3a-ae057acdb1amr90131066b.34.1750390103950;
        Thu, 19 Jun 2025 20:28:23 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e8082fsm88375566b.8.2025.06.19.20.28.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jun 2025 20:28:23 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	usama.anjum@collabora.com,
	thomas.weissschuh@linutronix.de,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 2/2] selftests: harness: Add kselftest harness selftest with variant
Date: Fri, 20 Jun 2025 03:28:15 +0000
Message-Id: <20250620032815.14543-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250620032815.14543-1-richard.weiyang@gmail.com>
References: <20250620032815.14543-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Each fixture could support variant. Add fixture with variant to verify
the behavior, so we can validate for further change.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
v2:
  * remove testpid
  * print value in teardown and test itself
---
 .../kselftest_harness/harness-selftest.c      | 30 +++++++++++++++++++
 .../harness-selftest.expected                 | 20 ++++++++++---
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.c b/tools/testing/selftests/kselftest_harness/harness-selftest.c
index b555493bdb4d..2a2a91717fce 100644
--- a/tools/testing/selftests/kselftest_harness/harness-selftest.c
+++ b/tools/testing/selftests/kselftest_harness/harness-selftest.c
@@ -118,6 +118,36 @@ TEST_F(fixture_setup_failure, pass) {
 	TH_LOG("after");
 }
 
+FIXTURE(fixture_variant) {
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
+}
+
+FIXTURE_TEARDOWN(fixture_variant) {
+	TH_LOG("teardown %d", variant->value);
+}
+
+TEST_F(fixture_variant, pass) {
+	TH_LOG("test function %d", variant->value);
+}
+
 int main(int argc, char **argv)
 {
 	/*
diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.expected b/tools/testing/selftests/kselftest_harness/harness-selftest.expected
index 97e1418c1c7e..0c19794e018d 100644
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
@@ -60,5 +60,17 @@ ok 8 fixture_parent.pass
 # pass: Test terminated by assertion
 #          FAIL  fixture_setup_failure.pass
 not ok 9 fixture_setup_failure.pass
-# FAILED: 4 / 9 tests passed.
-# Totals: pass:4 fail:5 xfail:0 xpass:0 skip:0 error:0
+#  RUN           fixture_variant.v32.pass ...
+# harness-selftest.c:140:pass:setup 32
+# harness-selftest.c:148:pass:test function 32
+# harness-selftest.c:144:pass:teardown 32
+#            OK  fixture_variant.v32.pass
+ok 10 fixture_variant.v32.pass
+#  RUN           fixture_variant.v64.pass ...
+# harness-selftest.c:140:pass:setup 64
+# harness-selftest.c:148:pass:test function 64
+# harness-selftest.c:144:pass:teardown 64
+#            OK  fixture_variant.v64.pass
+ok 11 fixture_variant.v64.pass
+# FAILED: 6 / 11 tests passed.
+# Totals: pass:6 fail:5 xfail:0 xpass:0 skip:0 error:0
-- 
2.34.1


