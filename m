Return-Path: <linux-kselftest+bounces-33236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB259ABA784
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 03:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CA74C2378
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 01:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3BA7261E;
	Sat, 17 May 2025 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcWuqE15"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B196427470;
	Sat, 17 May 2025 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747444801; cv=none; b=AmSIpqHfIS/NWAzPMxbG0iicW33Znt6z0xCX1ygVn0vlTXzPtR4fWg5N2hZq2qGIwALv9poXl9jmhMpAkJ0jLNVsjOlQQ5q5vi3dHbKMg2WAdOqaKywX6MW+6DyRa1VBTOxOJioiu4yqaPVlwxvqxzVYZV2Il41vegkftlXLSi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747444801; c=relaxed/simple;
	bh=YsKePZvqTWlFr6OhKrqVUpzRgw0bdJvrf5A8NoOOoKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZxS/LjbSaJ55PWkd4+E9WyQACnvxKTTbc/17wjKQKeLtak0yz8c3G8BV83JBjDT19u0O2Ck6jFLYKm70bcW5LQXkVZ5neN1nqPCk+KkHOA4xvX8SN2/z21Bu2OkLnHcwwe6VLphfjGqTKcqfAYT1zqVKvlpC3hZgmpHvSj5kZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcWuqE15; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c546334bdeso223875485a.2;
        Fri, 16 May 2025 18:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747444798; x=1748049598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w5B2LV4vwIzx30sEcS8DzEw+CgYVXQvdv+JneouFlZM=;
        b=RcWuqE15k9bMZYBFKZf5C7VIc7j6zB7PDCofa71DHj0q+Q4ABI1FdzJPsTJYAHrOXb
         BpcRDVNYY2dMEifONaSRqOlXu5uvFvVcjJAkH4uQFvrJXaAlKyhL0XfBIbMh4fColC3U
         9YtoDKKSkIBHLFdbY2l5Ya54ytlRz0A5UFAwxihgK+xOfRdglZolC+Dt3Uufu6/LAThG
         IZ0lg6SBxM5KGc/LHkQlcvJpAaiNDeBXj2Kkkpy+z5DxuByqqXT/UsDHqBaWAkz+reRa
         tNB4x6G4JofN0qoBSIn+57ls+QOy4kOs5QeWECEF97GYycHaIN1a6EE4Mzs6osrn90ZL
         jJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747444798; x=1748049598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5B2LV4vwIzx30sEcS8DzEw+CgYVXQvdv+JneouFlZM=;
        b=AnJsMXRguAmWitNSuDBx11S7lTWCr9C81GrfsNnAutwjjHEAm8wPkBgwuP7sRlh7le
         kwYUPHZ5lpCpX0AVgbY/v20KUWwQ5BEOsIJ8A3tyN306Esp6yPcuo3x1MhqHi9Za6FFv
         taLZLe2on74DigI7iI3eJ1KWxiNEB2OWa+TABHyC/BYyLvfHZR4A1VUJBfKMm+qBRbQJ
         Q1TFCe4XqiykdK8z3VYCFNc8ncUZWZqwyr0UMzmU7EiBnijlDdERGKlR7DBB4uXJB8fb
         OXtoKdNK5Kv+wgLThOD+qT+AABQpiAXwvZlrJ5yw8ljHv9wGASIqlYjHOcjifOszzaO7
         tcgA==
X-Forwarded-Encrypted: i=1; AJvYcCVetDr6iqyEU1QwozUz+0CS9mNEco2sZGez4HE4XoFoRcid6UoddTyCjPtgubVHCImAQEbqQ3EtrPySPBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsaBMa6ign5ph67t4nElFlVrmf9dB8O3OmTA8+PsKE8dPE9gFD
	54NVST6BCRHSx9QVXjwCnG4KLoxm4gsEdHYpsMWfQ7Xcsl28idXlrw8=
X-Gm-Gg: ASbGnctOkjyB7/hiusO41cI0C2H2F5zJZ/CpV/qZ6Z3uJitoesBRRHvlvNcAUI7w4Vy
	Zjx68EYNZPIQxrVrEPCW2bFEQGsKvaF0++pWGe38wU2Oluh/l2Vc/cVxk18CIXiFXJoPm1d10cK
	zhz2SUuHJaNMxjDZZo4y0sr4SeXLlAt2Q5AAziOaQ96QOiohJKHpl9+S6Dxgr0t9JuIC5v8R1lZ
	ClB7XnzFcXZkLFF6rxrygMg27zHeo5UcR1kT9/z89IyUXnLuV2mEV5YgprGDRLGYGzMlngCh48s
	L0dR0mZH0zLpRW+VBWYEQNeMeXK7oMUDP0A9YvwE3EvyzUyarWEyUfpbkxp6MK6eFNO5kkrRi0g
	oskY9JDLyORU=
X-Google-Smtp-Source: AGHT+IFt20saecnFbFsogWIYjVcuzAeRTdiKaetLRfG3JsrhwZZoQ7Zn+HfpuPK+p1/FbmaM+ZtRzA==
X-Received: by 2002:a05:620a:1794:b0:7ca:dac1:a2d9 with SMTP id af79cd13be357-7cd47f63fbbmr635936685a.28.1747444798604;
        Fri, 16 May 2025 18:19:58 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:224f:4011:50ae:ea20:4b60:8f04])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468cc89fsm186790385a.105.2025.05.16.18.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 18:19:58 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: skhan@linuxfoundation.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH 1/1] Fix typo in cpu-on-off-test selftest script:
Date: Sat, 17 May 2025 03:19:28 +0200
Message-Id: <20250517011928.673585-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo in hotplaggable_offline_cpus function name:

"hotplaggable" is replaced by "hotpluggable"

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
index d5dc7e0dc..6232a46ca 100755
--- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
@@ -67,7 +67,7 @@ hotpluggable_cpus()
 	done
 }
 
-hotplaggable_offline_cpus()
+hotpluggable_offline_cpus()
 {
 	hotpluggable_cpus 0
 }
@@ -151,7 +151,7 @@ offline_cpu_expect_fail()
 
 online_all_hot_pluggable_cpus()
 {
-	for cpu in `hotplaggable_offline_cpus`; do
+	for cpu in `hotpluggable_offline_cpus`; do
 		online_cpu_expect_success $cpu
 	done
 }
-- 
2.39.5


