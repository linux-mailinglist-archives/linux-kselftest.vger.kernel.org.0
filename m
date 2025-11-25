Return-Path: <linux-kselftest+bounces-46429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DBAC84DAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 13:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D04235064F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804CC31BCA3;
	Tue, 25 Nov 2025 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BbmaBT+x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506CC3191A5
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071893; cv=none; b=pU68siCTnG9yj4m1a/69ZEr8XAhekRoBorp8NnYlrnTdIqiaPS8k0NlRl0HkBAW7rZM3XvGB7+adA9k5OdowuokVrqwBBNYHbujwURqKD2jb1ncdnrBFEuH6VK18myqqrIQSgkfD4/YWZNL4H26kx6J2lwlWTVjHiUoyNSKg1AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071893; c=relaxed/simple;
	bh=h5BOWVyx+/bFPAVcTfC2857KKspsNMfrpKCfWzWnOv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NCCRTh8VCLP5gkft5c2NGoJ+QSJ5tSUSOG9UaMboaC8CRCOY3zsuQJYnSmtxDPns5aaSDIarqYYkLqZa/eHA9BI9hKjITNHTiw5gHQYjJbqJfPg5UvDLMJqSi67qrgFUzdkuMkNrz4wcizCFbyjfwNQybJzUbRrfUPkpNSyO4UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BbmaBT+x; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b725ead5800so687645366b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 03:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764071888; x=1764676688; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/xNXqkEL9BPOQ74SKa1/Qs/G0spKNPUafByBS3vgWo=;
        b=BbmaBT+xMRye9SIS0X00BraxVF4n38cVgN4bSMCnANFnkyHjB9dudGMHSEWgehEJcA
         98ShKuL1+lgFHzAJkJslziztSoycAhFWiUKVFCNzdP0cIkLREmBJ4LRYVurYE4ium8Ks
         iMKBtYQ2Pjv9OWpFjtCkPYVdYGcDE/8AlXjsME9i+9nCK02AbEaE2/iWGXtg45Hd3Jdf
         IJfhpXuaXLAKOVlwoEVY5GYYfNEtDZT1hFtCG+gor1qKzYGlTFyKamC3FOdE7kuMZ8fV
         OONX4V8GM6cRy35eZmk2xhcWvNsAht164ZbyVF5mSAeGjMZJ3cRzsrz6IaXyvQatMeJQ
         NGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764071888; x=1764676688;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/xNXqkEL9BPOQ74SKa1/Qs/G0spKNPUafByBS3vgWo=;
        b=Tj8MiDTPzRqYSCPHyY8SuQGZ9KUQf0lbqNOH09jTWmCiTDjszaFkStPlKowkuoihi3
         S6iG+Ij3UswEaEfga35FJ58/eSrVdOUlNu0MZ8YlSzLTDqY6uTBXNaGnb7auB+kCh+oG
         Bnt0Pp2aaoSUpPWWXS7u8bJNNrpCUKaxtJkL/0fIgloQNTPN93gNy1vXpP0Zd+nSJa1a
         kXcxajjIrZkRT1sDBQuGUe85jjtBft2ChCm+x5vnj7EH5uRSbr5iDdIlVy7yrOl2ByvK
         jd8gUpLjTpVMOy69Qpw/pWoGnK8v8apgvgZdCnNzOnPBP5CUw0OWiaHvMh47ok7vZ6jQ
         ANIQ==
X-Gm-Message-State: AOJu0YzmD+JERQgRf4xjPOsvlsxHhLZE+WknD/6tnp45tGuj6saiAA/8
	yV0LqtlSyqFLCyLzkKFRnYfKbMEyy+L7BLLns+RMaf4rbW5ViScSWYUE9E1Qj7XrZbU=
X-Gm-Gg: ASbGnctUWDkZbQJ6q6kO76OAKwN15IzaZulLvNQjCnIKu+/SJH/BrkPVcPvjUGkcBeB
	JHehGPXLmCblLyqZp17xznUqXJGNJDtnasE/yS/B56lA99YgNDs8YdeHU7UVaxETgYXg7ekFG6W
	nheMlZpdiD/pscHqxLvLq/ahEyJFYuEqEetA51OZ7sSFbvgyyD6s5NRMqTYi1OnHomq4eIpUp0K
	6UM47eZTvQIu4Ttvoh7FNofzr60gPhEtwwvg5pIdLad9IwxPJRJUhfqFh1VoUKyo+84bSgDMk/G
	xx35sCFlrTLAC/d9viUfCBTcvM9NGyh6q08E6vIYDXdbw4YZV1bO9yriwcxKVi1zW3GWf1fUTII
	qkJHxCL+J+8GBBR7TeCc5Qfx/WsQXQx8fNoTRLhLlDPjdN+tOYvlqCsB4nUTPW9+0GcQYjmqKyB
	0=
X-Google-Smtp-Source: AGHT+IEi84Bjv5YePVB3g0BHK06U3V22LypbW1WhGeA9CFHUeUE0c3qQKx1Wo7NVQJLE050xEcG35w==
X-Received: by 2002:a17:907:3f22:b0:b73:5693:4ec1 with SMTP id a640c23a62f3a-b76c558c34dmr261295266b.57.1764071888474;
        Tue, 25 Nov 2025 03:58:08 -0800 (PST)
Received: from localhost ([152.250.153.214])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450fffbd091sm4505448b6e.16.2025.11.25.03.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 03:58:06 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Date: Tue, 25 Nov 2025 08:58:03 -0300
Subject: [PATCH] selftests/run_kselftest.sh: Add `--skip` argument option
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251125-selftests-add_skip_opt-v1-1-85ef2ae2e035@suse.com>
X-B4-Tracking: v=1; b=H4sIAMqZJWkC/x3M0QrCMAxA0V8Zeba4Vofgr4iMbElsULrSVBmM/
 bvVx/Nw7wbGRdng2m1Q+KOmS2rwhw7miOnBTqkZQh8G78PgjF9S2ao5JBrtqXlccnW9nITCmS4
 oCC3OhUXX//h2b57Q2E0F0xx/O4tvjMfEa4V9/wK/ezkhhQAAAA==
X-Change-ID: 20251125-selftests-add_skip_opt-0f3fd24d7afa
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122; i=rbm@suse.com;
 h=from:subject:message-id; bh=h5BOWVyx+/bFPAVcTfC2857KKspsNMfrpKCfWzWnOv4=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBpJZnMPg8oa2FTesHLuseSPAhMM89toPphVzbI/
 BFti3AQvm+JAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaSWZzBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKYbjA/9GDKuqkubT5e3llLxvLvJ1qOq8rDd2rl
 33MZii3uEvZGNrVDVFowXK+afJRYMnvr/PSLdElyFDUwEGS7bnWsJtLpH4WPY0kVS4D+zqvedyb
 mz9Az+0Itn4BOAJWJIJPPGzzZWVojAKtWGI3BjiY6aS/ENxEjszFcHjpLwieQQM3qoCL7HrXjqc
 YfSADKdAbvCpIb9iUdpu13Ske1VCH7SxbhnsKNKOLblzhl3ggJB2pe/gfGmUpL+9dgXb0GnZFNz
 eCmRsoVAWYiYAPze6E9bgj8pw2OymwC8PS+AwCIGAzjSddpxjOKNNKEjJjIVAS37Bjtx9xyh+V3
 KgqTC9f+erKRT+I2Czff2pjfRVbwoyBM2TmjWLQUm+FFQCMqGt5CKFoXmxkHgNimFVl0WR2K8dn
 1cqRI8tN/nXKY2rbndaTGZyfyWUrfqtuL18rH+sSuOylU+5+qEuhS125j2ylRESMcocWKq088Kg
 34efe2sBhZyiY22aNrmaqGv8+e5vdNY6Vr+KztwulHy7mxW0/MdYQAvXIBKGeu7PrWqx4U9G64j
 t5hPC1rpgjKZFEI1ARlFdwDLI6iMXc0DsTYjzGb84Tx1wYdbeEgD/Hv0xyS2jB2tQisLGtL3E4a
 d9tSnEcGP7bDXlwY4A0eM3aTIDZ4S6g3mOtE7cvfi+Wl4bmptJXQ=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Currently the only way of excluding certain tests from a collection is by
passing all the other tests explicitly via `--test`. Therefore, if the user
wants to skip a single test the resulting command line might be too big,
depending on the collection. Add an option `--skip` that takes care of
that.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
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
base-commit: a2f7990d330937a204b86b9cafbfef82f87a8693
change-id: 20251125-selftests-add_skip_opt-0f3fd24d7afa

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>


