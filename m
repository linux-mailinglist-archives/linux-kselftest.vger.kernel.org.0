Return-Path: <linux-kselftest+bounces-45950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98680C6D3BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 08:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id F41BA2DDDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF713254A9;
	Wed, 19 Nov 2025 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlcu4qWo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7E2ED843
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538573; cv=none; b=Zj3T5tNDOryeRWBzo7QAy0Xt0Cg9LBXoea8k3HVsctOeWSqgUX07sgwmscM0wuFPA7QGjClc7rU11zzzNwPCCcgEEW7pG3ALe6+9OaeQTToQ3hiIqBbsA6leI4Z5UUz1wFtEVTdNazAXjrT2wdpaqBJLyy1r9yZOBlt4Ae9HEWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538573; c=relaxed/simple;
	bh=DBsnCb1RGhHIHvd3TVQ3alBA0j/c8nR/NiX31PKWaxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNHpAjRiDUjfxf0vRphhWNS8SBATJVeY+XWCuD4tiqY9MmMqhUmMyOz7kBkQ883MUeIiF0ONinaoYaxRvYOetof/Lf+YcMGbsscUCJe9r7yYX/YwaHXQ3+LdxXtWCc5amfuVp3Lh0UgXn81fsKRgGOT7osPeAU/8vizxLcwvMVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlcu4qWo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47118259fd8so46980825e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 23:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763538570; x=1764143370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yl2sz1LCBOShtnkb+B0Wje+D4lWWLrs7LZhjMxASCY=;
        b=jlcu4qWoBT9ZkNROsLtAQQgubD1j3UN8FfGdgHum0Uv2c/CHidj+6qZ2Ov9ePGOS+Y
         +CXKACv8OIBNrf6wIGQvc7TPHU+2dXo06tX/mZlniTHIFDIG8UkvqVwJXeIp/xKqUw1H
         TkB2eFqMtx4wjOgKY1hLytBEBm4uAp1grQkN7GN/05de8b7NrN0ISnBqP81A8Pac7ktf
         i3+N00TDhugTS+T+C09aBKurc/3kANIDYoIaFl1rpZUIxmeIthbUPa75uNK60AQGcrMF
         SKMa6dNkxHeSawDtCdMCd9UlJQe0AM+Afrojjo+JGtKbzcnRGz5Fv7+3MHCjM4FMnXJR
         QVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538570; x=1764143370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9yl2sz1LCBOShtnkb+B0Wje+D4lWWLrs7LZhjMxASCY=;
        b=RPcXQ1RJGXkm/O2csWdqBGY+p6mUKYAtg0s/4yS/NEUHtJ8jGN8PS1bm6lmHnEdtcG
         azdhsQ7w/+z/VaWi6cH0ke9pIvqgPD5N2sIp1v2wwOUteZZlpjB+J5oy965Z8WfHkoB0
         sqZ0G1lMw2CZZ5f5Sg2bZxbcY3IhDdDjvq9qqBLz9wzvNNN2PS5Z5E6AcXwB8AFFU1zN
         F7bL8hz/30jbnQnnJSvNYWY/Ybf5F4tSoCp/P0QDhOsYQY7iy4vuTDCFHSUNLrJ0Z5Y+
         qhkEeSER5udWPfDFx5FnyJrFPL7II5Je5NR7Rc4GN7i6koGkIc971AZ+Lz6M+MnkdCbL
         qs3w==
X-Forwarded-Encrypted: i=1; AJvYcCXEwiSk4fuawaZ2GnwoQc+5/tjeZauhVfni5hKnWaBQN32boe9+Ads+5B32e0iSeqWbNCFRKNrCVkFAYva3Vdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSScrtretP9hex6UrbgD6kXIAucd93Qk+ThezxvtX2hyl+jD2
	wTQkJHTDgLY3vTNp37ww+DPZ8c3scaE/+EUodyiCg1OlS3e1p6erlCHhhwQCelAEtBs=
X-Gm-Gg: ASbGncuK677nfY7SS9JPYRoAy3GRA/VU+YSL2TJPMaJ41c8snnstbfNa3sy830u2dZl
	+Ee2QTgBowkBaIysvMWghhM7juiEBonVtzaxvyaxGi3Vg+3Wbmqle99ir2gF4Cl8Quv3SL0ZDtE
	0+bN38j7lUHc4EM+5KOixOVg8mi7z0RQmylDvjQ/FluDkdMJzDwjelZ/CYYK0wJneQ1IY9bqr1r
	RR1IE/unvAhe+KicmF8Isac937jlcTMnVkr9BA9OgwzzGXMTC5hf4f21SEFnpnAsllYwhn76cw8
	tDMIzzk/dRL0A7i0IKsRpMGwvLz+Qm8LVUzfiaGADN+4+fqy1ua7ADkaEKIzrO6u5DmCFFyGFUK
	whmd0XAzdLaP6R4vwRivYoC5j3L/FkBp7oCudqcNN04kjs+Wypse9/zDn15bfszLKnpIddSuwju
	DQ5L3oUZXgU7t1NP1APxMjhCzFcg==
X-Google-Smtp-Source: AGHT+IGSnU9nBqcA4weQOAAZg3vUy9mdjD52QKfUOwY+oT+pWEQfLrnjUnPYigb7AGycMHO4iJWa1Q==
X-Received: by 2002:a05:600c:6287:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-4778fe68d7amr164382005e9.15.1763538569365;
        Tue, 18 Nov 2025 23:49:29 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e91f2dsm37461146f8f.19.2025.11.18.23.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:49:28 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Wed, 19 Nov 2025 07:49:19 +0000
Subject: [PATCH net-next v5 1/5] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-netcons-retrigger-v5-1-2c7dda6055d6@gmail.com>
References: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
In-Reply-To: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763538567; l=748;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=+ki/gSi1D4tq/a7wlghaz/ZnSK+KnYSdMinnxL+Akto=;
 b=PCuj2ZrbY6kRkAU9UYvmLEfFoDqdJhFwqW8/sGRWrgklEQpPJkwzdolyPLl1VUsnsNOh1Sbia
 18CtCBVvCvHA2/rVy550dTw13lIMWK9k4Nqt4anQ+zyoti2J408vfo2
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

Introduces a enum to track netconsole target state which is going to
replace the enabled boolean.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bb6e03a92956..7a7eba041e23 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -117,6 +117,11 @@ enum sysdata_feature {
 	SYSDATA_MSGID = BIT(3),
 };
 
+enum target_state {
+	STATE_DISABLED,
+	STATE_ENABLED,
+};
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.

-- 
2.52.0


