Return-Path: <linux-kselftest+bounces-12551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8990791476D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 12:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45491286948
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BDF13B7A1;
	Mon, 24 Jun 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqL08QmP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3054013B2B8;
	Mon, 24 Jun 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224669; cv=none; b=MdfAH0CrfClXPaL/YKu5cNSysRp9gql2QxY0BN5d4jw/Gr/fmTlWnQA8vXKXyQ1IHZhj037W0nX1bW63g3totQGBdqjb8Xqc75Bm5zdVmnBItF/mglKlW6W4sic+EhcB2GEh+QHcuct5NuaBHGca86OK36MGoCONiGr4UTZBLgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224669; c=relaxed/simple;
	bh=KdIGeyWdRKZzO8NP9ZkQ5U+ppGVbhZBCX2qqL5ZjDNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BYQfg6fntKQ8skOY07nIjaNzq8siD6MptglkJo65+HYS7TCRtTk823yBbNBPSJ4DROwF8H19blK7aj8w4TJiQTUGbkNQ7nh15d8bjm6vsLw2N5PoQzRp939DzBsUYSEvl2Uk38SiGuigpAROQ9ZFaUZH5WpJMh1HYcyh/Pd19S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqL08QmP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42278f3aea4so34482975e9.1;
        Mon, 24 Jun 2024 03:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719224666; x=1719829466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFxwAQjS1MtSOpGwk1XEKmlAhT8y2ybUUwre8SCcIKY=;
        b=nqL08QmPZ2Z8LdNDDoP0yDgcvB8A/L4b8T7B15393xlXaqC/aKjx8+9dhbFFx/LEo8
         8+s3f7+YWeP8uCaTgjWG7AEKptDy2QG6w4q7iiua3uQwiw2iVSv+Cm8EcBmM7YWw8NQC
         LcdLPPy41tZvQheADrnb7wS5In4cB4ObTz6Th45Rkq64aW9gpKNBOfCHhuOGA6KF/Vtz
         kl44FlQhsN/h4AzUwJySlfvy5BJW8ivZ55MmG7k2y8Klsl/rqhUR86Ym5ZMR3IByYkqd
         /8zTusnKgJivyu7zwzDXq8it6vZX62tErGjKXT4tHTEbhiYjDr+m8289OsYx17rME893
         Qz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719224666; x=1719829466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFxwAQjS1MtSOpGwk1XEKmlAhT8y2ybUUwre8SCcIKY=;
        b=srznzUg+J1QKMlgT50lb9ZzErEDyR+b2qXt0f6yy9DQIPXu5tGWdgMvm625K/oXRqM
         vztApnZRU7TvZeC8Sgwd22lSHnkut937V13Ej/ommnDEtskHYaSqohrUDr29uWB7jdj1
         SZbcJldW6XCgokg5LuBXw8oK0Qi56bKhShQLWqZ7TT0hUYQKC00AyfwLlSNIeRisvfvz
         tkQzuqiIr8dQ/agQZVebcZE6BWPeQAfFwkKTwZ1ICgc2AQbzUJrEK2HfPEKa8wfh08nF
         u32n2gRJx+ahjEZFYC5ZsUS7AmfMVs3/1slSuPMtUyhlOD1yHY9VeHBl6KvLpXv1RQps
         MEww==
X-Forwarded-Encrypted: i=1; AJvYcCXRdKILDhxcX3k6iPMrgkcmNMb1CqwxLmKPXWIYqRtqCBkQXQUyb23jh9jPcwKd1SeVZdyxVsbr4ZJmYOR18P05cTtAy7BJ4ycmLrNx64r1Yq95dgoXRY4etQYPfTJ4UYdG/21SYtAAn0lxxpZ0LweVI0EQyO8Bk3yKmLV0odNP9PlkODyFwaBs
X-Gm-Message-State: AOJu0Yw/fZrDrqaNM7W4r7K+jb5O6X7eRn5iu0M/VVRKLEa7ap9Q8y08
	NQ6JoOQP2eMTR+4+/GKB8ILwuwQvRCAMdxvELi32UuY/Er28Jui6ZxlWdxl/
X-Google-Smtp-Source: AGHT+IFjukPDfaUNJnc18ZZK0odySizFOwxw8N5zekxjkntxnPupdFk0N892gbNLhvE1f5YZP4hZYw==
X-Received: by 2002:a5d:59a4:0:b0:366:f6bd:a544 with SMTP id ffacd0b85a97d-366f6bda67cmr1334669f8f.71.1719224666236;
        Mon, 24 Jun 2024 03:24:26 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:6ec5:53d3:2412:2d96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6af9sm9685315f8f.73.2024.06.24.03.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 03:24:25 -0700 (PDT)
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
Subject: [PATCH v1 1/2] rtc: ds1307: set one-minute alarm resolution for rx_8130
Date: Mon, 24 Jun 2024 12:23:53 +0200
Message-Id: <20240624102354.894871-2-ghidoliemanuele@gmail.com>
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

Set one-minute alarm resolution for the rx_8130 by setting the
RTC_FEATURE_ALARM_RES_MINUTE flag according to the hw capabilities.

Additionally, set the no_upd_irq flag to disable update interrupts,
as it is not possible to generate update IRQs.
hwclock fails reading the date and time if the no update irq flag
is not set and IRQs is defined in DT.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/rtc/rtc-ds1307.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 506b7d1c2397..96e4d82ad915 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -181,6 +181,8 @@ struct ds1307 {
 
 struct chip_desc {
 	unsigned		alarm:1;
+	unsigned		alarm_res_min:1;
+	unsigned		no_upd_irq:1;
 	u16			nvram_offset;
 	u16			nvram_size;
 	u8			offset; /* register's offset */
@@ -1015,6 +1017,8 @@ static const struct chip_desc chips[last_ds_type] = {
 	},
 	[rx_8130] = {
 		.alarm		= 1,
+		.alarm_res_min  = 1,
+		.no_upd_irq     = 1,
 		/* this is battery backed SRAM */
 		.nvram_offset	= 0x20,
 		.nvram_size	= 4,	/* 32bit (4 word x 8 bit) */
@@ -1946,10 +1950,16 @@ static int ds1307_probe(struct i2c_client *client)
 	if (IS_ERR(ds1307->rtc))
 		return PTR_ERR(ds1307->rtc);
 
-	if (want_irq || ds1307_can_wakeup_device)
+	if (want_irq || ds1307_can_wakeup_device) {
 		device_set_wakeup_capable(ds1307->dev, true);
-	else
+		if (chip->alarm_res_min)
+			set_bit(RTC_FEATURE_ALARM_RES_MINUTE, ds1307->rtc->features);
+	} else {
 		clear_bit(RTC_FEATURE_ALARM, ds1307->rtc->features);
+	}
+
+	if (chip->no_upd_irq)
+		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, ds1307->rtc->features);
 
 	if (ds1307_can_wakeup_device && !want_irq) {
 		dev_info(ds1307->dev,
-- 
2.34.1


