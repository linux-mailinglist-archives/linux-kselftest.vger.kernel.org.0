Return-Path: <linux-kselftest+bounces-12550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD9D91476A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 12:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C3B28621B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 10:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F6913B28D;
	Mon, 24 Jun 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Td2CIYn6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896613A876;
	Mon, 24 Jun 2024 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224667; cv=none; b=doCqSeRlsT0uktXCuQiAaVu2IznXxskAAVgzA8t8ewG2lgL2IC6gy/e1V7L93iKK9pT5+eyOErbYz+1C3fBMRTceTkYym6ieO7Izgq7F8rzxKXpO7D7jK4JgXswp9eK+Mp0hL8rV1pGqc8TFUIQbkrvCNAIiMOdbIPH2RN2YbBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224667; c=relaxed/simple;
	bh=GqowOhh1vlxjA/QwGrQ83PREXBqOcjdEHfHKOM6lF74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rci7qtX0LxTmxTyLa21APOo0sgJU4p0iRa+HDfYOIgEjmEDv0CzqL2wln0OXANmKhbbebk4p7Ajr+b1Dl/IzpqvyKSXRkyNGza92DBdQrHVb2glpXjvBcODaexKg/KOQHSB3KeC4+t9hSoz9zl4lJ3wGkT9utaXKYopvdsUAm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Td2CIYn6; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec50a5e230so26800531fa.0;
        Mon, 24 Jun 2024 03:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719224663; x=1719829463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ekKBi6MrHwfRYGceosqnDXbAlm4M9GA0bgX77upakCs=;
        b=Td2CIYn6msyy3gbqQQNmNsrnEQuKgFjRzaif9wJAh/hDSmygJzVap1EgaBC/SukfdP
         kdqydgW+8/xKB+Vj7oV7gRI3lpIjZp4AhOzD3aQv3zJ9U1AX+EtCMoqfjGdGkmVWqc/9
         oE+RyOexPcqIL0EZIbctLbHvaXvmVq9AgqaqzWz+fyb+YMyg25vSuMbIAzPfGFf58pLZ
         O5ZeHywQI9vN8GCR+hzxZjT3k6iwWUQ6/rg1IMS6VIWstGOuGfdLNUYpD+4qg8c3IY7y
         2zGDGbrpo6CuY0aol8Kyji1FY3M1vcQYtaoDD4o5ag7PhNcsMOHP6L/aBeWiW1Na3J8n
         Vfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719224663; x=1719829463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekKBi6MrHwfRYGceosqnDXbAlm4M9GA0bgX77upakCs=;
        b=uPv+Ar7e8DgOHIEQBcX5q6PGkwGl1OtYF422oyoMn3eNuSF20niPgve2qABbfhGqMS
         YKsW4LzXodeodOhknRXx1B5EnrRzhtY0oMNLnVI/YU7lKXZRcHLPeJrzynoi0bjlu7xZ
         wShtlcOVUGfnO2sBHPdVJnkcH/RJ1iNydiW5McLqE4uoMBvULPr6SU+r4zMFZugJ6bTn
         UeYnfGr3FBDC+5Yr1YEmAFln6uUt/tv8dcoS8HmimNais1wtL8XJ9AJiWIK8akrqWFCY
         WToX4Lxg17HXHi1sDmO1pcXWOpRvKIraHCr8SOv6IzCZkyCTrhtOjYQBo96NqtKAnr6G
         ScsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUabDH9wA1czsxawfqAKMDQh6EUYx5LAwvTH8obxH6Zv4WM3JoXpPQiGhChwmz8ppn/0kw8xrmsrckLoNLI6qMPdqjCyU0aKalGlEQcBAkhnVcQ993PmOGyvhbH2p3pAUYXTfXZeMtwJMSN0O0GABzgKgV5A19SW+6kYuRV4aHoS7G+Yy2Cmhf7
X-Gm-Message-State: AOJu0YxQWFJVDOM9ZmJh8z7P1XVKV5PG6RW5zL1ICBrTC6jZCf9at2wy
	ZE37v1XoFo08/EgN3fB4I3P5gtqr0OWNN/6zwXniGQc1MmQyxN2J
X-Google-Smtp-Source: AGHT+IFZ8/haf4Bf93CZhsSeLLOTGiJWOMu05M9dF1kj8eyRSGH952acck0+RJsGkPmxQjYKVgEDgQ==
X-Received: by 2002:ac2:5dd1:0:b0:52c:df86:68c6 with SMTP id 2adb3069b0e04-52ce183517dmr2260751e87.16.1719224662688;
        Mon, 24 Jun 2024 03:24:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:6ec5:53d3:2412:2d96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6af9sm9685315f8f.73.2024.06.24.03.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 03:24:21 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: alexandre.belloni@bootlin.com,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	jjang@nvidia.com,
	kobak@nvidia.com,
	mochs@nvidia.com
Subject: [PATCH v1 0/2] Fixes for RX8310 RTC Configuration and rtctest Alarm
Date: Mon, 24 Jun 2024 12:23:52 +0200
Message-Id: <20240624102354.894871-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Hi,

I am submitting two patches related to the RX8310 RTC configuration:

1. **Correct RX8310 RTC Features Configuration:**
   - Sets one-minute alarm resolution.
   - Disables update IRQ.
   
   Without this patch, if the interrupt is configured in the device tree, `hwclock` fails to read the RTC as it waits for the update IRQ.

2. **Avoid rtctest Alarm Test Failures:**
   - Ensures rtctest alarm tests do not fail on hardware that only supports one-minute alarm resolution.

I know the second patch creates conflict with this one: https://lore.kernel.org/all/20240524013807.154338-1-jjang@nvidia.com/.
I think that series can reuse the rtc_get_features function I implemented.

Best regards,
Emanuele Ghidoli

Emanuele Ghidoli (2):
  rtc: ds1307: set one-minute alarm resolution for rx_8130
  selftests: rtc: rtctest: skip alarm test if alarm resolution is one
    minute

 drivers/rtc/rtc-ds1307.c              | 14 +++++++++++--
 tools/testing/selftests/rtc/rtctest.c | 30 +++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.34.1


