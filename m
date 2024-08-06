Return-Path: <linux-kselftest+bounces-14850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96167948F87
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EF21C20B4A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C1F1C4634;
	Tue,  6 Aug 2024 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiQUGxvO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF281DFC7;
	Tue,  6 Aug 2024 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948772; cv=none; b=BbMUQi0tFwmt4NGyiundgwwykJ1p9bpYAibbiuB+QH0GSh5YY1CfB8foXFfyEVTRrhlU+Unpr2DtCFQXNlvZ5pQVhwgjfRdqwwdYO4KqTZ5UmnJI+0DDjgjxj3Hif/NC/2SLVbjbC/MlTFzJxri9OB+3EzuFpCPhrgt7/4qKr3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948772; c=relaxed/simple;
	bh=oHsucPMxdYbxpAwRnQO8U+6dli+bDmAiev5mUhaGzCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dXdiWHwfIjxQ39pwKm2YBSULBM05F7Ia8Pw6+EgITW3DTLdvhj3BeCdt4NPcB25pdzi1uzESeNStfxv7EnPDrC1CrrdOwzT3iTSZ6OqMhxkjNWgQjYep8CXr2uiccHhEovq0IOs1woHdBd5I2tGo9QTEio2ywa4c6NG8Mf4wwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiQUGxvO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280921baa2so297635e9.2;
        Tue, 06 Aug 2024 05:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722948769; x=1723553569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNsqINAtNbB/7aNiOKVrlsTW1P1GcvahhFjOdWwa67k=;
        b=RiQUGxvOGMabGUAYYqM+P1q7jywaAxddf5p02JcFcfxfeqbrwc1vy9bEveGWJ9fP32
         0RhGhawvLA6Bf7Loc8JmOMO3H900tcx7zDioCy61EUaGMZ9Ugc35WO7Ny/l1FLy5vtKt
         ICazL95NtYk8BqOHB49tNhah5n+k3Ej+JVRZejEBNtFT9i1RLrDN9ik81WNtx0GgKsuy
         vexPj9RCI7n11pCvW+WOezVrt9lN2DvD3lYR/WmYL24lUkZ5EaLNWXQuKH8kWdZD16Oz
         XP2+6jxQCeSR9QOXTsVHch0mVlW2zMPYo6OAjln8V2MFEufhWbvGupDjGXVrdPP1S7GR
         GJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948769; x=1723553569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNsqINAtNbB/7aNiOKVrlsTW1P1GcvahhFjOdWwa67k=;
        b=sC63hW9AUDrMZto/mQOy4TL/O2G6G2CWtHYRNCdfWyN8OAJYS2UQ65KOgr5ga+PL5r
         08VN52FdYedVG+mVb94sEZ6Va/5SIFkl49aGUZ2kJScsXY4vBtfL3hDgsdAvnVENRlKt
         tNh7s7F/hrIDqkEr/bGZNCJp7topXyEI98j7CZxZfJawVGNUvWqwlcPjenHhh1sd01td
         w1utco5odwGciFZTEYVi5N1Twv8Yrv2gyH6gihf4eCNEJYxByRddW7j9rjTiw8hRWIXM
         WBypRSDkvTrc6YQJXrd8+qen3Gua4+8g1rrVg2ixdkln41WAXIsh2V6Z7kW0D0qOSeD0
         UeUA==
X-Forwarded-Encrypted: i=1; AJvYcCW1P3cYlBaZzma1UQNR4p1R++CJnwqHNnCWZVwRGOqW47TQI0K4iqGuyaerkjsFX5HceeYofOg3OGo3AMvXMFEHuhtbyycN/qiwAxZecFP/K63XhBkxaIBQnKw8GXpEwWR6m83X6s+jZkNrVpYOCt8AHPgcdd/jxxOE5fWn1T5ORXGRvSCuxkVZwxaRvk+WKPRGIRoi6oYaYTIDvBm23Icd0LUcj80=
X-Gm-Message-State: AOJu0Yxq+5ilaHtgrLMcvUVfl+Kcnb9CnkAgAZ7Ba647O5RsmP26NvmU
	1LcSoqRoLjQGlKlCvv6RotqqzNrh/9hmHt4Wu+Cr5Av3TdZRNC7S
X-Google-Smtp-Source: AGHT+IHfG6l8sknkwJmvO1EpQVnCVeAbWu7CQd33ZI5ukBgYOkpaJK/1bDpUYyD/Iqhret4NBaOPXw==
X-Received: by 2002:a05:600c:3152:b0:427:9f6f:4913 with SMTP id 5b1f17b1804b1-428ea0fd688mr63195795e9.5.1722948768682;
        Tue, 06 Aug 2024 05:52:48 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:b50e:24fa:fd17:c835])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6d648a0sm179487255e9.10.2024.08.06.05.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:52:48 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net,
	broonie@kernel.org,
	shuah@kernel.org
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr,
	aholzinger@gmx.de
Subject: [PATCH v3 1/4] ALSA: aloop: Allow using global timers
Date: Tue,  6 Aug 2024 13:52:40 +0100
Message-Id: <20240806125243.449959-2-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125243.449959-1-ivan.orlov0322@gmail.com>
References: <20240806125243.449959-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow using global timers as a timer source when card id is equal to -1
in the timer_source parameter.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- No changes
V2 -> V3:
- No changes

 sound/drivers/aloop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index d6dd4b8c750a..a1e5e7fe9c72 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1130,6 +1130,8 @@ static int loopback_parse_timer_id(const char *str,
 			}
 		}
 	}
+	if (card_idx == -1)
+		tid->dev_class = SNDRV_TIMER_CLASS_GLOBAL;
 	if (!err && tid) {
 		tid->card = card_idx;
 		tid->device = dev;
-- 
2.34.1


