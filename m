Return-Path: <linux-kselftest+bounces-29959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB96A76DCA
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 21:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF24F16A0FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 19:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3CA219A86;
	Mon, 31 Mar 2025 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wQfNtAoa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C048221772B
	for <linux-kselftest@vger.kernel.org>; Mon, 31 Mar 2025 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451005; cv=none; b=EljV063R/SbGP+alKQsx8HEeTIxVXvofqqxXwAU6su38+yIJceg8VpjkuP4REIUzMvxL86CPgWzaz7/Lo9NO0UNwoqMhRU74lc5jGXBq24+FB/XQXCnLKkmcIxtexeejD+XLK+t7O/HzPzqC/KrL3qGkf+UjWyGWFOFlFg/M3mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451005; c=relaxed/simple;
	bh=vAxCqO8D+zzqb/qZNB5/FCTsdHivJpMM4FMnnmj32U8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2l7Z0GCQT1S/fVfDKemburq6uyszUKBX6cIARXkV+LaNTxvHBIxNYFkLXz87c8Lr9QbUCwZFJE+loL1UlyFs5bwxsORhO/KeAoqODIzKo/Lz2O/rb6wQl4v6it0s1IUaIrzHdq/+Z8H3V3KJGpQIPKvWaaroaslWN98n/+8CiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wQfNtAoa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224191d92e4so88650935ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Mar 2025 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743451003; x=1744055803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AzqSa6qdLoYyh4MHGFR7tGBhWMYj3VcZWbyxOBNFEgk=;
        b=wQfNtAoaOTDHACeqKolF4hex7jcF2MtR0IXe8aOTrPmPKl+i4PZsYiY5ZiBCyPe0O8
         biyyGGStZ7YLhpArvX7dAPP2s6Vw4ol4yjVoBLmLMy8ZNBGcSje55I0ZYxJ0ADUBv/CR
         QZAkPBy2ZrSvZgIjMsRSW5CVFAONkd66D/U5/EKvVsju/36x2IXaD46GraGR+/HS3aKV
         2glsO1EFZo4uFjS4X41oq5uvivVRGxQ0LXiprr6I+3NwWtGdWMlyG5IyNV2pOOaTczj5
         ODs6Y+OXVosnLKksBj3XZNceha19Wr12Y8fZWp8XmIOA4IqdIoSw5MVaIiGwPdJlERqz
         JWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743451003; x=1744055803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzqSa6qdLoYyh4MHGFR7tGBhWMYj3VcZWbyxOBNFEgk=;
        b=pmP8vJCRdLBD8xf+MQxdEnynuOwxsgyWe/hL3jpDgMSuj49bCTU11pAA1UDKN8nzFZ
         Mqy6HPHaaaJ4nV/DRNza5bhDUiEtDf6VenLSk3kD2phGbDBRrK7PjM4R9SbbSmK8GpWz
         nRkz/62zgu/HLyw62Vn9rHKlVNGaCZZzVNggdOKD3XRK7mCTjhY3fdHvKXQA+THFYfhk
         sCSsuU5KkSxMUidbQfCi5Y3qihqXg5+V7sLklreaEWBk9jpZQ7GOz7IG9ppTtkhzfwNj
         lfvGx9dBvMvmzlyStoFKTvk4DIWeb0qCDHIdSlvUEe6+0YKLTo2eml604bWzJ7UY+et/
         c7aA==
X-Forwarded-Encrypted: i=1; AJvYcCUMo+/FFfB8j2+JUQdRSdbCFrPQxFkCJHwGSMmEBkPSyAuxxbjAQ53rLouf+adiIZKxrAElGzLCmstNAGQoNSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIqFTnP74uPV0eplJkfrqvloSrhiCYgJuyDJ73lLgdS1ADeIFZ
	elxql/ffvvcgh41BNZn+abY+E2uRypO1CmU9MCZJNCGwfVA20hKh9x5ovSLmkg==
X-Gm-Gg: ASbGnct+I63BpuWktU0O8cqQcLLq2sOtusOJ1lTo9JBz7nkkCf2AlXREDu5wLTGXf/B
	5ubeolIeCcS8xPeEVbXf+r0bLOENq3BR//eu4dnflmmQs/uF+b/OnzFr1wKfy8faA186U78qclz
	MXZNd03AsiwHXfmV11/76WCzqQxDTt9590orTTBzEq+V0pygSKDQVl7VWolr1eTY5iZVJPYFNrK
	FqB/94BzjI1WRr1yDQg70fB02AWp5osBs0xO1thT/MTqjfzP/ZqTgXK8QPOfG7qAZhjjSmirEXO
	HWj1qEXcBHVDNd89qVB9FMTsUZT0w7dSJJHTPXwBRx4mH5rya2gi8b9TU0cTSbJNU3FV
X-Google-Smtp-Source: AGHT+IEpEnY4rZKG+/LUO41TSZFdr+jiBWbL1y7GD4aLnGkKhbPHZ+UMnU43ZPvQuWmZC/hfP1zMgw==
X-Received: by 2002:a05:6a00:3901:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-73980415eafmr12174016b3a.15.1743451002841;
        Mon, 31 Mar 2025 12:56:42 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970deee97sm7313082b3a.25.2025.03.31.12.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 12:56:42 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: tc-testing: fix nat regex matching
Date: Mon, 31 Mar 2025 16:56:18 -0300
Message-ID: <20250331195618.535992-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In iproute 6.14, the nat ip mask logic was fixed to remove a undefined
behaviour. So now instead of reporting '0.0.0.0/32' on x86 and potentially
'0.0.0.0/0' in other platforms, it reports '0.0.0.0/0' in all platforms.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
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


