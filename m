Return-Path: <linux-kselftest+bounces-15212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0D5950476
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 14:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD211C20F9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A13219925F;
	Tue, 13 Aug 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksfEx/t6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF9A2262B;
	Tue, 13 Aug 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550961; cv=none; b=nxRvszRe+JnPW22BbwKeu6NXdrpvKThdRxs6t02Ef+N4DRHIhhqLu2GrW+QIzBgJpXYl3P3kwLfrtoBVIXxiT7DODM7+smqLBYh3YT6coroCvfYpK1Nj+iSB87P3Oj7JUtF8AtLBauxGL4d8wANKYoAC4Q8cqzoLbC2A/uMw76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550961; c=relaxed/simple;
	bh=oBDUeHMgtvohGyjzhNghz3N/IOcsGxYMUFaK2bk6CyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1Ex2lMTgTr/K48FNADceSqk/rlfdyjj/HCGwEbLmW6LDcTqnOeCKhpM2bVR4tKkN0JRtFCaXbfblon+fNXuodkPz17n8AXKN6gaMmb9sEYggIxdshpVBjaMTQ12Uwl9FzleFpXZxYFx1CKmxlGUNYGf2iNIl6fuYgZDaI6FJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksfEx/t6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3681c30104bso204095f8f.1;
        Tue, 13 Aug 2024 05:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723550958; x=1724155758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goAw86tK8j5++NskGtJZwyegGQqFT3LAmPos4hfr+B4=;
        b=ksfEx/t6PO0EX3kgv5iai8ktSi2ZZOL45BktcJ/1wZGtflqe+Xvii98X1VUEj8SDNw
         4CfeuI0KOTFu86QAIOaHAct8qFO08nnfmIOCTIeLN9RJ/h+W0oP6MkKMeRhE7qYyZlzV
         ffkl5QfdKtvdtnodCiQ2G+ifc6ukI74SKynPge+JHSbJPeXUDPehumwcWe5Ia11GEjWW
         Fvy/QAtAMdenk+IP48VIvZ5ccEy1mqinFmWLrqPpUeGkaiZZxzmPMWmhzDL1MlTlSWTh
         aTNWXl2dSfY9U9pPF6BqyyznDgqAuNyUzuUvlDWpx7N36Qrvw16qiKqfO+9LNFJEFlD8
         w7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550958; x=1724155758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goAw86tK8j5++NskGtJZwyegGQqFT3LAmPos4hfr+B4=;
        b=Y7HsDZTpT1Y4TlKt+tChpyBXz6tVWeCRECTJIXfZlXlje95DLei9VSpa8NmTtPzWUp
         s6rBwRiy4I1aNI4+4bFrSbI6qI2LPHb00mQ93vIfvYGL8ZksVRwwOlgOCaA3bNcJ7A6c
         d0edJsgspj/Ef05/LYFdVdVqEek67rQZWyq9qiCeVZumqmAiOhxKauS4j4G3SZ+IOWXE
         pHqxIuGuouICwy2aKWAP0EmH9V3Ya84IwcADRHX18LJjE9g/UpCK/Jp6/33IGrp2+wqo
         q65joe4VETdKElqpcBL3izQ9i5fLv41mXkMWpTIdOe4UilunPM4eouX2HT48Zjo+Y5qs
         pBlA==
X-Forwarded-Encrypted: i=1; AJvYcCV6fwAElRtASmAgPdMBl2X/C1qKQLnJ2eu8vRAf5MvWr1huLu6LffE1KedUYs0wEsWgfGeRDxz9ujw+iC+h1luAXptQnZaOyp/kXSXnBDyc5DF3vS2JktchT+DClSDOl+3iAD/nuiHaOj1jApU2dbYJtQmwYw2TEGqaVOrR1c1c48LlPB2RmkSAX4hfRh6vIpj+LegRxUMUaRECKbjxsr8QM4NT6qc=
X-Gm-Message-State: AOJu0YzL7GSRKay33luvp/yf3eqvopeSjvCq3fPZvpvdWibu77LmUUw/
	wFlsbNa4k9SA5/++5SauJZ7ia+SIqCy7dxW0gZdSs1xrOO9pmSq0
X-Google-Smtp-Source: AGHT+IGWxajbXeuaUHJWMyPVVDuANrnqsUCddqXlieX02TiXzl4ws/OebrZ/xgTsOiqllkzm6q8x4Q==
X-Received: by 2002:a5d:598d:0:b0:367:90a8:4d3b with SMTP id ffacd0b85a97d-3716fbf2f1dmr970897f8f.3.1723550957633;
        Tue, 13 Aug 2024 05:09:17 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:6db6:f2bf:8865:5d31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb52sm10204590f8f.74.2024.08.13.05.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:09:17 -0700 (PDT)
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
Subject: [PATCH v5 1/4] ALSA: aloop: Allow using global timers
Date: Tue, 13 Aug 2024 13:06:58 +0100
Message-Id: <20240813120701.171743-2-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813120701.171743-1-ivan.orlov0322@gmail.com>
References: <20240813120701.171743-1-ivan.orlov0322@gmail.com>
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
V3 -> V4:
- No changes
V4 -> V5:
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


