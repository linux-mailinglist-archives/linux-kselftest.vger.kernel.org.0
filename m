Return-Path: <linux-kselftest+bounces-14365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C198393F075
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 10:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2212829D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 08:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CF813E021;
	Mon, 29 Jul 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDXDxZyQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA35013DDC0;
	Mon, 29 Jul 2024 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243566; cv=none; b=fwLif+IAueQ3F6UgJVAD5FhlyzzxCpGWK9CM2bm8WrxQ9JerQHFmoBB7RCbML4iMJHZD5jcJZj+MXvU2WHrekcqtuNyWTtwigA86XcL7xkvzfOhcW9ErNVaBfbSefG8WebP/98yNl8JMYSWPNf+GOldOUnHQ6mu1K7ScJgv4Rs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243566; c=relaxed/simple;
	bh=kCOkijbVZPA0bTMuA0k1KDGDNjW/CTFQMRFUMcaI3Yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FLYvDf7ykmU3qab9/EPUhmYssIDPyprLp4CoYSbapRgQO1dNfvoEPVNT5WFgUQ2mhFWB4P4GLKtV/fmuSFS1LkMLRWOYqRDivjaXpHWPF68Y8ORAu4ZGBCuwys4zYtYTyC8/4MbG5e3P4INFMsuYnxskCBLgoj78kbYnGArJnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDXDxZyQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3684c05f7afso309499f8f.2;
        Mon, 29 Jul 2024 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722243563; x=1722848363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYI54NILj5XrVQ9i1xhNNwdpH346o8zj3Rv7bwR6cIw=;
        b=YDXDxZyQBczSwtM5+4kB171fFT9EPn80xDKCIStzMgviL9BfwtIZ5wKbyiPkv8kikK
         IYGs7pcg8TbxmVWWjo8C7UxdaZIPtEUjrDS85qJpBjdhYFWMAj7ZplWAAfV6Xo6ROv9H
         78ETknw1XpHMJ4lD8wtWEPifHO4jcprsur/9mTFfrQ2TuJS0Rhg+VC7tD7W/5gfmFuj/
         OKoEXBFNpOabTBitQdwImAu+U4p1TYY7PcGYUFSpUBluexDBNpgZWlWYnUPORO6Se3W/
         ecjqxcfeV4yq2QLIt3VQ3bMwrvdbr0xo/Y3PE0OwV2Tm/MVM7Rwvz7LYeDu3+8ns5IXH
         rIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722243563; x=1722848363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYI54NILj5XrVQ9i1xhNNwdpH346o8zj3Rv7bwR6cIw=;
        b=uWGhbnqAKYVPxpssYs47x0VI0EixsV72YediDui3DGaEyMCDMLMFWFleCWyBwJ8Rqd
         7rwRkZVh7YXqJJtqGROPZPsgrPrKqWIDUK2S6R/bxss/apkajC3aN0e0YF11tFaMt7dv
         vVwdD3oJr+a3Qy4cT7WGxNdmPXmSaGiewK8hratScemUvm2LnL3sS3C2uZZVEewJefeM
         4gclAl6KB5bGzREdG6KNWMpGfnqYV6QrN7PWcALfTxWdpvLr8rNcA4KeKdhsZuSu7YcG
         NU4joSMMW0/FO8YhW8m4y1jAsLjjK2wvQMIKYhEPBnBvGMeqneWjiHdPpA9EHaletPXz
         70sw==
X-Forwarded-Encrypted: i=1; AJvYcCUARVSWnnDPsG8hvbAoDL0Jp9LaMttYGwjTLJl4Zvjxee/PVG8DvIoxhSR+7ftNvi11ULFUOKIrOfAhRt5oqBCx@vger.kernel.org, AJvYcCVnro7RI5apEqOyeJgrT891O6zM6rZf5vn+REqquDOhwY926IbOqEL/FFvA7Icvf0fuWxR00p8K5X0AujW4@vger.kernel.org, AJvYcCWP8AEAOeii7MQj/6tDieq8HOjS6dV25lf0Yu1099WXuxnCfNBsGuayHbq1Pzm/J2Z1O4t5MO1g6Dk=@vger.kernel.org, AJvYcCXikcLLyAxKrCM8Hf3mwKZiQrDov6sVM5q7sEBxRw48wzbbUnAGdv7/R7uFR97L60U+3Nj5l6y6osjO+oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9zwXRmHtGELcNDPdsb5gz8+3d6lJDyBJm2/fYTkRjki2xDLQ/
	Z0ZzKQRnBtN41wWu1gJPMpdyO0KMSdZo3hyOBCsteUDrTtfRHPTl
X-Google-Smtp-Source: AGHT+IEOjhLMNFawjY53IvOv0Vx656pm5RPkGE2DaZZQ7OJcqlXcOn55xPiiETw2mHN3nuSxdCbN4g==
X-Received: by 2002:a05:6000:1849:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-36b34d183b9mr5958093f8f.2.1722243563129;
        Mon, 29 Jul 2024 01:59:23 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([31.94.28.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857e46sm11715337f8f.67.2024.07.29.01.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:59:22 -0700 (PDT)
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
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v2 1/4] ALSA: aloop: Allow using global timers
Date: Mon, 29 Jul 2024 09:59:02 +0100
Message-Id: <20240729085905.6602-2-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729085905.6602-1-ivan.orlov0322@gmail.com>
References: <20240729085905.6602-1-ivan.orlov0322@gmail.com>
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


