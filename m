Return-Path: <linux-kselftest+bounces-49152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D91D1D328A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 15:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40BC030049F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43856335095;
	Fri, 16 Jan 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RoLlknGm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536A2334C2D
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573276; cv=none; b=omJW8bZDnmq2Aw4dMygjdCvJfqXIOMTHRfcauwg/hUC4byrsm2rzUUkLvx938GnA0ZCpg8d3himuBKz6MN0YZGjb2C/wltvei1uyAORzy91uEIux8PNf8bbCZSKnCgaT00JsXdSmsSwkjnMM405EeItDdkcAgqLx8noWD6qiuMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573276; c=relaxed/simple;
	bh=PEF0iq+9AC6WICfwCHd0f3JYtjyW/TLvhqlElcHB9i4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b7c4osIkkR9Sgt3sVVYRSmjKf2RpEcBx6yW67z7nkrYjhazrR+CceATKERGSEvNwM2xobdsxR5GBWEYr/+HGDKFBkOf+kJwWz0/VB+BjVgSrnUYvnRt848kJpv1RxRaKdYwXPsDONz/4RYnyrcbtTD4TBlSIXGShZru3dHHp3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RoLlknGm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801c1ad878so12786975e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 06:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768573270; x=1769178070; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R8uKmYgJ3Qq/PKlelXVpwg8n23aMvRRMH747RmsDWbI=;
        b=RoLlknGm8u7CEygybA739AirkfTssM8y9G/krpnDzzOx3G1ALzNAV/SplIZuzhkYbh
         F/awv77tXDDlSHHhvgfAuD1XUbTYDgDKsnOfNTGQ1OvPftzqqVFOdUNem44rBUWcesyP
         KQPAXt3Ge5sbE8p56dJhAmzIQfKIDrgjESKzS+jF2gxj9uwTTgoAzzB3cTQJY+bsHMPG
         GF9sgpCEjTV3drmhjS025xerVJuTm3s7q2MFunInhnN7Qo95cmyQWbwdw5vVq4CqQksk
         wbqKlNJjAnG7PQHtW7rHCp+t6eOd6FaDN5ZRG7/hjE4IE+wPhjG9D76Uhf8D/Q0E03k1
         /i2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768573270; x=1769178070;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8uKmYgJ3Qq/PKlelXVpwg8n23aMvRRMH747RmsDWbI=;
        b=U/y6bjzkzhlFbU5QpQkfBI1MmJe5ky0e6m/3NNn3tmIHjRVrHIR/W4pPSe/i7QXKIt
         66b6kuSuLl4S3ae5t8563YIGAUJHmNfQ8iJ71L42Rpi7KK2epGecMKmkfXPMlUt13bFj
         OZ2e5LkcV5dmp2aOQLUumxBywwW9TxD/Z5J+aUXJWdDQRUOLvS91UerEymzQ4Ymw/NGg
         nHg6ARSXxB9LiVML5wtjJLMQocmERg2nYQlXNvUbjU4E0i9XtC/zRAIqBUy5r9AfAbtU
         j8yXlmZg682BxyKF3m6quu0OBFD6a/lO64zHY42vndPW+DAkDVkdqRaLwb+RCF7LBvCC
         Lezg==
X-Gm-Message-State: AOJu0Yxu0SvKKnvJz96/b8YjDes1WgnVJ7d3pNRbTWRvvEpaAkbmeiF+
	bFdb7/z3o0KdU/mieUMVDFXNMol3bxlhIAl+/wFJQY9NUsRu9cAxG3AoTaQyXC1dVGkbKxrVoAi
	QZGWyNW4=
X-Gm-Gg: AY/fxX5AlfLm4sqebrGRLiDiH1+Fp2L65LgW6LEpu+EYsjVG5VKQykkTbeaIEp+vN97
	rSAwhHX323LSdaG7yHCUX0FY67f5lBW4SDZolPPbQZJSx/p/bHT6zHSBp0+EXcvaoQF4gmAmg7T
	mYrCUQs1i0mE8DCewoJ276S+KE7C74bKrRktkEaLSPqCMU2Uz26rbqGeXvCORIouZyvQ3Mzzczd
	94Fi9jLTirQSV/myCpiGFogRJdWsVhz1PdCCGXTqNUzibxo7ei9A+BL9AJxTE6A4tkAw8A3+KId
	MVy6NBdZR1x3yKwoOWULKHQWUoRKbVWBMRRXQ8Xoq2Bh+JJo8JwnQ04HnKsOG9RXh65FqHJ2fCj
	YaFpPbTExJkPJ+jdgpQ8XYEB/5/d01JwAEdWTnr2FNTzyVmQGq/4JGyEh95qYs13BmcoJRGTyIp
	l4be1auV7W
X-Received: by 2002:a05:600c:81c5:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4801e30df8bmr39820295e9.16.1768573270252;
        Fri, 16 Jan 2026 06:21:10 -0800 (PST)
Received: from localhost ([189.99.238.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11dasm2483868eec.2.2026.01.16.06.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 06:21:09 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Date: Fri, 16 Jan 2026 11:20:54 -0300
Subject: [RESEND PATCH] selftests/run_kselftest.sh: Add `--skip` argument
 option
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260116-selftests-add_skip_opt-v1-1-ab54afaae81b@suse.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1768573265; l=2432;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=PEF0iq+9AC6WICfwCHd0f3JYtjyW/TLvhqlElcHB9i4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIzs0OMS58cRQ+96A+x31fiYKo0xzkxanoIwJkjh7oJjXmT+xxraNTlak8ved6j3iME86yJNNAe
 G9s0byFXxewE=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Currently the only way of excluding certain tests from a collection is by
passing all the other tests explicitly via `--test`. Therefore, if the user
wants to skip a single test the resulting command line might be too big,
depending on the collection. Add an option `--skip` that takes care of
that.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
Currently the only way of excluding certain tests from a collection is by
passing all the other tests explicitly via `--test`. Therefore, if the user
wants to skip a single test the resulting command line might be too big,
depending on the collection. Add an option `--skip` that takes care of
that.
---
 tools/testing/selftests/run_kselftest.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
index d4be97498b32..84d45254675c 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -30,6 +30,7 @@ Usage: $0 [OPTIONS]
   -s | --summary		Print summary with detailed log in output.log (conflict with -p)
   -p | --per-test-log		Print test log in /tmp with each test name (conflict with -s)
   -t | --test COLLECTION:TEST	Run TEST from COLLECTION
+  -S | --skip COLLECTION:TEST	Skip TEST from COLLECTION
   -c | --collection COLLECTION	Run all tests from COLLECTION
   -l | --list			List the available collection:test entries
   -d | --dry-run		Don't actually run any tests
@@ -43,6 +44,7 @@ EOF
 
 COLLECTIONS=""
 TESTS=""
+SKIP=""
 dryrun=""
 kselftest_override_timeout=""
 ERROR_ON_FAIL=true
@@ -58,6 +60,9 @@ while true; do
 		-t | --test)
 			TESTS="$TESTS $2"
 			shift 2 ;;
+		-S | --skip)
+			SKIP="$SKIP $2"
+			shift 2 ;;
 		-c | --collection)
 			COLLECTIONS="$COLLECTIONS $2"
 			shift 2 ;;
@@ -109,6 +114,12 @@ if [ -n "$TESTS" ]; then
 	done
 	available="$(echo "$valid" | sed -e 's/ /\n/g')"
 fi
+# Remove tests to be skipped from available list
+if [ -n "$SKIP" ]; then
+	for skipped in $SKIP ; do
+		available="$(echo "$available" | grep -v "^${skipped}$")"
+	done
+fi
 
 kselftest_failures_file="$(mktemp --tmpdir kselftest-failures-XXXXXX)"
 export kselftest_failures_file

---
base-commit: 86063a2568b8f2eeb68da1411b320c0ff778f852
change-id: 20251125-selftests-add_skip_opt-0f3fd24d7afa

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>


