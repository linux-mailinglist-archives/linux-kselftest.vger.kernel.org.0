Return-Path: <linux-kselftest+bounces-29989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A026A77E2F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 16:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6885D3A72E3
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 14:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E8B204851;
	Tue,  1 Apr 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="geUaY8gt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B56202F71
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Apr 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743518962; cv=none; b=IKkPyEG0prfwDGeJFBrlTyCA/65vcMds7gM5Ob2Iqbwau4NT/IvELjyDAnm/Jiy5mJDISf+6q1BgxoDTm+4A9U59atH6Rlj+PL7PDaJGFSNVMDsCm3OoqZMXDqDIAcxRIntoC6NJJe3CWf7RapY807HOu5AiQquqzsYSCEXlBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743518962; c=relaxed/simple;
	bh=zfvY5ilblRz1ZETzZCRpmPJmoOETggjCXhq2caObBnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQurHZS2Ob+9NZKx6EWPFutG0U6ynlJtWzLhdIs5PoRCNzY29zTuNoTJQY8KQKzmzT8KIEnyhYa9vyKOp7eEdflVTDxdiqZfew+SN/t4wYhXJ+k6/YqM/y78qyn5AHkxzyDZmU5TC8W0qEuoTjjw1BkJLL1R2SgqB0UFAAcZPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=geUaY8gt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224171d6826so84508865ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Apr 2025 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743518960; x=1744123760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nvvg2/Gk/l5x3IN/jgeamuut3HGiVttHMqWOPVL9kGk=;
        b=geUaY8gtEfkK8vIofpS8xtOziY1xAGnsN0IAXQXhP0gfytWpdaM5uFUPWvlpyeQmza
         wSsYGM/ag72ngXM2UmJc1mMLXOWotA/+snZ+SzhSJNti8aq/nSH6LaV+7+EI0KsbvDxj
         OFF/ySyfLkNfYbe5rQewNsffdiKFo3CNUQDCUnedsmvtc1Tin0KaPSMEOaOLjPnyUhVZ
         5qdRgrEHk1FIOubQ1pEThLjwMI9Rbsy6cbGiy9eCoYDql790JpkJWnFHbz4TMJei325t
         Twc6moafz7GnSf4ph3zKbMjZknB73uzb4eoFGUXOmDHU1PRW27cGPHUkiDkD/F2gkAEv
         CcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743518960; x=1744123760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvvg2/Gk/l5x3IN/jgeamuut3HGiVttHMqWOPVL9kGk=;
        b=QsScwT86Od1SPPWr24OMhHUu0PnbD2OsNx3Yu1X0rW5DYitjHhSN0C+dzY/TrmdGPH
         CcW1zRXcOfmjn60NsDzj9IFUT6smnzUlG5w+M062r4XodSs3dbv0tUDEEPVeMOdB5kd6
         Wmf54g1dzFB1kyAFAVS3l0eFk6ls2tXMGw2s9Xw1fP3cpHuCkNFtSYbr0bMfGqs7Nx0D
         nFg8nEZgeEJ1SO4xHK5eiUVGP/BUKDIdDjzYuQ0VOhX74c4OQpJgJ4PEgGc5etzvXMGU
         9rvLYMZ1N33OIDmjHtufz6ybcm4abXdSFI5kEDbWHR7g4S9oSEbdDWTrR/aKTZWKG4kH
         RvzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4NUFcu1A+PtMVM9Oc/lixEsEDvbF1rVbTcPeCml5ZxJeIQIZRu2++jWW4EbCfY6ytad85Q9yC0erQB35ZFzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJieIY74oKt6EPKXtt0FocQG/1+wc5kTdqUi/PQiMC6iy3+OZ
	s7dhVAganBbnN3tfLMU7GNBXqAgFTahyxUn7VV6oaEgkajSwLAX1MtcDG0ER3Q==
X-Gm-Gg: ASbGncuisVfw3CsKWEg8hSbMjCqvximJPsOd9TQdJ/4YHgDRcU7MJKu67NFTnT4Hfg2
	elERTdLsAzNMhj5WENgbA80I7PO4qRNTuqtNmqeARrzj0GLwmtKQQNd7nyPj3ct5Lrrx6/dMdLI
	6WxnyT+HAvvZOq8QPWpAIEENN8Dxkv9twT5Cq7JLfAZVtjBzbtLgx0q8tacgk2QZTsCwsQOHDAu
	OHMb4a30KNGtnYZDLxusFHlc3Yyp5nAvqK8B1hLnxBqwG2smSwd0nSj844SN8vbOFnSxQjvvHQv
	930rVmenuZr4Uv2CpdKD/VJgUKxzH0VUeXYL2vspnVuxpO+CY0B6rbY/le1Hg9xsSagT
X-Google-Smtp-Source: AGHT+IFRoyfRjpj2ypIJeacRkpuzmigIRbGGpUfFVuVkeHHePN1/B92eV2AUslffLwHY+8sbiTcM0A==
X-Received: by 2002:a05:6a00:4b0d:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-7398041fd44mr20622359b3a.16.1743518960182;
        Tue, 01 Apr 2025 07:49:20 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710d6a08sm9270954b3a.170.2025.04.01.07.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 07:49:19 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	linux-kselftest@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] selftests: tc-testing: fix nat regex matching
Date: Tue,  1 Apr 2025 11:49:08 -0300
Message-ID: <20250401144908.568140-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In iproute 6.14, the nat ip mask logic was fixed to remove an undefined
behaviour[1]. So now instead of reporting '0.0.0.0/32' on x86 and potentially
'0.0.0.0/0' in other platforms, it reports '0.0.0.0/0' in all platforms.

[1] https://lore.kernel.org/netdev/20250306112520.188728-1-torben.nielsen@prevas.dk/

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
v2: Add reference to iproute2 commit and collect Simon's reviewed-by
---
 .../selftests/tc-testing/tc-tests/actions/nat.json | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/nat.json b/tools/testing/selftests/tc-testing/tc-tests/actions/nat.json
index ee2792998c89..4f21aeb8a3fb 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/nat.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/nat.json
@@ -305,7 +305,7 @@
         "cmdUnderTest": "$TC actions add action nat ingress default 10.10.10.1 index 12",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action nat index 12",
-        "matchPattern": "action order [0-9]+:  nat ingress 0.0.0.0/32 10.10.10.1 pass.*index 12 ref",
+        "matchPattern": "action order [0-9]+:  nat ingress 0.0.0.0/0 10.10.10.1 pass.*index 12 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action nat"
@@ -332,7 +332,7 @@
         "cmdUnderTest": "$TC actions add action nat ingress any 10.10.10.1 index 12",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action nat index 12",
-        "matchPattern": "action order [0-9]+:  nat ingress 0.0.0.0/32 10.10.10.1 pass.*index 12 ref",
+        "matchPattern": "action order [0-9]+:  nat ingress 0.0.0.0/0 10.10.10.1 pass.*index 12 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action nat"
@@ -359,7 +359,7 @@
         "cmdUnderTest": "$TC actions add action nat ingress all 10.10.10.1 index 12",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action nat index 12",
-        "matchPattern": "action order [0-9]+:  nat ingress 0.0.0.0/32 10.10.10.1 pass.*index 12 ref",
+        "matchPattern": "action order [0-9]+:  nat ingress 0.0.0.0/0 10.10.10.1 pass.*index 12 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action nat"
@@ -548,7 +548,7 @@
         "cmdUnderTest": "$TC actions add action nat egress default 20.20.20.1 pipe index 10",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action nat index 10",
-        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/32 20.20.20.1 pipe.*index 10 ref",
+        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/0 20.20.20.1 pipe.*index 10 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action nat"
@@ -575,7 +575,7 @@
         "cmdUnderTest": "$TC actions add action nat egress any 20.20.20.1 pipe index 10",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action nat index 10",
-        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/32 20.20.20.1 pipe.*index 10 ref",
+        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/0 20.20.20.1 pipe.*index 10 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action nat"
@@ -602,7 +602,7 @@
         "cmdUnderTest": "$TC actions add action nat egress all 20.20.20.1 pipe index 10",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action nat index 10",
-        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/32 20.20.20.1 pipe.*index 10 ref",
+        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/0 20.20.20.1 pipe.*index 10 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action nat"
@@ -629,7 +629,7 @@
         "cmdUnderTest": "$TC actions add action nat egress all 20.20.20.1 pipe index 10 cookie aa1bc2d3eeff112233445566778800a1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action nat index 10",
-        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/32 20.20.20.1 pipe.*index 10 ref.*cookie aa1bc2d3eeff112233445566778800a1",
+        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/0 20.20.20.1 pipe.*index 10 ref.*cookie aa1bc2d3eeff112233445566778800a1",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action nat"
-- 
2.43.0


