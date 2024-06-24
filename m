Return-Path: <linux-kselftest+bounces-12552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD38F914770
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 12:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD851C233FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 10:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E897C13BAFE;
	Mon, 24 Jun 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyZ9islg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E513BAC3;
	Mon, 24 Jun 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224671; cv=none; b=r0MhsXi/BMusNKspCF2ckMkTHi7OgQIJ+Q5sSulrUSvUh/li9fkflia3wGPl9xJ9Jzlb9HU8umT0vY62qaQfB+zR4/WcNuyAHsdsD0+XSleFh++ZLbQ50dnKesX/yqaKAoSV7A3yJEd1uWpa1FiCLXqHOKFLkERjcWHWXeCIZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224671; c=relaxed/simple;
	bh=FxNKrE8jcwE4rIT+PnGILKZCGFn+N9HPzKAqEQC1pzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oXPnOoqJmO/6P0hxTR6Dd0hANSSHmllLRQOL7lae53c4bQAxuFk+RtkJ4bppCZuslF3GB4rUQBfE60j8eRCxdI+I7YbsyAVV3CM9j+/PazSYFUJ/7Ci1lr+Yrtp3FeJPE9lHG1nLo5a7DgFWbHqtvnlIwhDteUK+ZopKq3luKIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyZ9islg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3651ee582cfso2250496f8f.2;
        Mon, 24 Jun 2024 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719224668; x=1719829468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHdI+h5DqWakYO4MXCjstj5TeeRaVKzxo+aLIe7ivLw=;
        b=PyZ9islgn97IM6kIJZUzouncSHS3ZYsptPvO+sWYoRpgLBmJ9hMB30V+UkBbXsDkGG
         UH9V/AXIycZu98PI+d1HnN8GJm4NS1vg40UwhI8V6TNECShIRPEX15MVzsJCbnSWL9Ws
         4QK0ALcIQ58ehOWDFIgdoJMOcVRJfTWLTsV7GAHoVn83F0PC0hnxELZdCmn5LY6f6Dk2
         5RHkxylHZ/PhXkg4E62VMmKgD6Pa0bEiTMEZK7Ew2gKDoumRK0puizbKHgmW+bMTBLVi
         wX2rYxre9lamdIrNbbu2e+pDJh1GVTT6Nsb+boiQzzK3Fpi4X0jEUW6xkrGz99PqleHe
         71sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719224668; x=1719829468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHdI+h5DqWakYO4MXCjstj5TeeRaVKzxo+aLIe7ivLw=;
        b=WKLrjbLU0GgkBP5PD1FyGdCX2QSwdaIGRBWEIChN8e7YgqHlrkA40xo9kt1batROf4
         rSLQdliQmwpWVnUPskzv4V6GLe1Ur1zXqS3/KPgFXkRePgQX2PPHLy4/78B4zNpc5DhQ
         45uqkdAnwuAUE2o+RMRxYNZVosp9qNGrQ0WIlrQ3e1CSrEMoFNF/N9PixAx1kFEBr/lp
         ANOs1JP9UB4fYPxmjOseu4RmmlJg1Wud4d0sfT5dN5SQbXR7UCovUWNJmAIEmH4rWatV
         eoAZRaRbgAipKf8vUYw2TDLqaz4aDqChdhC3IlnkgKBrTitNDdcj99iH5Ot4aLsiHJDo
         7snQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbbqlmYuutcWPDwyKCcRU6eaIn/WrNguKokZy5TFee/zYGF3XY9lHFVsLDt4XvxgFeKix1W9NUZ3HUe5b29ZuyUAxV98E9UnM179UH0nDTNhbiRmfudBxS/ZApMiudAgaMt14dJfjMU28uJxTEK2ZmyFfiQmHAzBCo7PEj8Qwvxcttt9NB6hok
X-Gm-Message-State: AOJu0YzJCzCQK3djhpZRuLH5syaAHBiTqzo3zJo8bnEcmQ7+fFQ8stAm
	/c+8y7M1tPISu52+5zVizfcW5V7JfczTJvnuI/mdwX7tmEdYV2GC
X-Google-Smtp-Source: AGHT+IHIv6eTVUjcCSv5PALPamjZJ2P7b67H8kH7mtEoHBRhV3vZ5HrlkaE6y1SHgknz6Et0SHWPCA==
X-Received: by 2002:a5d:448c:0:b0:364:aafb:5fd7 with SMTP id ffacd0b85a97d-366e95d2968mr2825122f8f.45.1719224668366;
        Mon, 24 Jun 2024 03:24:28 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:6ec5:53d3:2412:2d96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6af9sm9685315f8f.73.2024.06.24.03.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 03:24:27 -0700 (PDT)
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
Subject: [PATCH v1 2/2] selftests: rtc: rtctest: skip alarm test if alarm resolution is one minute
Date: Mon, 24 Jun 2024 12:23:54 +0200
Message-Id: <20240624102354.894871-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624102354.894871-1-ghidoliemanuele@gmail.com>
References: <20240624102354.894871-1-ghidoliemanuele@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

There are two types of alarm tests: one that tests alarms on minute boundaries
and another that tests alarms on second boundaries. For RTCs with one-minute
resolution, only the minute boundary test should be run. Skip the second boundary
alarm test for these RTCs.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 tools/testing/selftests/rtc/rtctest.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 63ce02d1d5cc..d741a548ef76 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -82,6 +82,22 @@ static void nanosleep_with_retries(long ns)
 	}
 }
 
+static int rtc_get_features(int fd, uint64_t *features)
+{
+	struct rtc_param param = { 0 };
+	int rc;
+
+	param.param = RTC_PARAM_FEATURES;
+	param.index = 0;
+	rc = ioctl(fd, RTC_PARAM_GET, &param);
+	if (rc < 0)
+		return rc;
+
+	*features = param.uvalue;
+
+	return 0;
+}
+
 TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
 	int rc;
 	long iter_count = 0;
@@ -197,6 +213,13 @@ TEST_F(rtc, alarm_alm_set) {
 	fd_set readfds;
 	time_t secs, new;
 	int rc;
+	int rc_feat;
+	uint64_t rtc_feat;
+
+	rc_feat = rtc_get_features(self->fd, &rtc_feat);
+
+	if (!rc_feat && (rtc_feat & _BITUL(RTC_FEATURE_ALARM_RES_MINUTE)))
+		SKIP(return, "Skipping test since only one minute resolution alarms are supported.");
 
 	if (self->fd == -1 && errno == ENOENT)
 		SKIP(return, "Skipping test since %s does not exist", rtc_file);
@@ -255,6 +278,13 @@ TEST_F(rtc, alarm_wkalm_set) {
 	fd_set readfds;
 	time_t secs, new;
 	int rc;
+	int rc_feat;
+	uint64_t rtc_feat;
+
+	rc_feat = rtc_get_features(self->fd, &rtc_feat);
+
+	if (!rc_feat && (rtc_feat & _BITUL(RTC_FEATURE_ALARM_RES_MINUTE)))
+		SKIP(return, "Skipping test since only one minute resolution alarms are supported.");
 
 	if (self->fd == -1 && errno == ENOENT)
 		SKIP(return, "Skipping test since %s does not exist", rtc_file);
-- 
2.34.1


