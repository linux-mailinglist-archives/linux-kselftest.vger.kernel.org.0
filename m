Return-Path: <linux-kselftest+bounces-46150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA774C76BE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E10BE35E718
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 00:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179D223ABA0;
	Fri, 21 Nov 2025 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Bd6RLsgQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7F225415
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684459; cv=none; b=ix/KueeDMP+c8xn++IWv4LFNZvuCZkt5mfj2upD//kPKdZ7xGD5ghYkbXSVQL8A2DOUNy1k3m7/TjMM0VvYOY8n5d/WdLQhlPItwNR/R3KWxrf61++kHSIYd6s+CovDvGn8ZPG+PTLIrBKIo35QcKk9KOgdwRqhLD56mrI+mJmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684459; c=relaxed/simple;
	bh=53VXLoOvdPtY7k2oENUGFGgWNzEuZsEc5ZQh2CGHwH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FV0tzWiSO2/3bFJNsc7zLxLEH4OIbdeg9Z7CVbJxp5pbx8aMlV2chMSLGXLX/7Jz2noHwDnWr41qgOJPoZxZ62+LfuIeViafINifNLUhlUr4wmQph8WUkx2cwitdo51ub8BEB4chCLLtfLHMCIlF3YO68szIBKwWlaAffohX+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Bd6RLsgQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso6845125e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 16:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684455; x=1764289255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OioY6zxd25aFaY9ZQxPP7QjER9MSTqkKCg/WdIxgGK0=;
        b=Bd6RLsgQJVXP5fNPDHptWu5pYI1FS3FU9CZc2Ma8W8m5PqKqS8SXeHYyu4AQUctAuz
         pZyMJ98i1r/Dm08zBm3TCYfACclezNnEZmuBV46EQ4GLFgYDm+nQZFeUpUf3HnbiqeWQ
         kQark37vLhA5/e4mXhH3LV73tTLWFfWsku+AOuGVf16FI2H3PRrqKsbjUymemUq0MRBB
         Q4OHA+P7+Si5UYoqDR8z7bnnUQE/iH3ih7GgVBHCwDAAmCHUv0H8Lhgc9Jvpz0L9lypc
         e+qJHjteL4eK72BKHHzWpR9xm7vvT+WqgKVzIoELo+9oP23yXCEgd3/rWkwlG/3jz4a6
         Ej4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684455; x=1764289255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OioY6zxd25aFaY9ZQxPP7QjER9MSTqkKCg/WdIxgGK0=;
        b=NpuGcTVul4KhlxIas2iVVu4SQB5JHDjhH+rDgCaP2yjQGS1uRFRlWHoYwhUKnt0eYk
         vDnX2trmUh4F10/GrsjhmUn/toXrcQbGOJttk7rLCopWAnoFTrIqSZOe+a+Ki+ap9jLW
         CCq1Fxxl3DgxMHnotkYmVsLTQUO0O70le9W2wwQ8zcu/ZQXBzoSzW/55GPU5ifu9elax
         nge0TGLKmH2W8fiLJU1ltkxZcVkIlgRRGWxQ6Y1A6Q9aPYIR8IKrSzbV+YmnlU4BNJw+
         DG4ruYM9g1wce3NFPX8EobIyOIvNXe1OYa9rlXPRlp8D2IbPk+fQFa8gB3XZ6hJSFlhE
         fmoA==
X-Forwarded-Encrypted: i=1; AJvYcCWo5HkG0fcLmpl2nJOlsOTx9QSHTZOJfhz+oQEflssiFl0/5uJPScXwQbHuZX8Q6/7a8kORwgAguMAUGK1JkbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT1Yz8heb6F/MmCHrcf4auCpPop5uHB+Xh1lDmQdme1kTs+v5w
	AW9hpGd/11edJ2UqGU7rTuN4Gdjlo1CnbfKAY3dwhBOHIbMFqBQNnCYFLV0h/HJBo+nHdy9AM5R
	gsB6CAaJntvQq96my7wHqDztCldNT9P1tkITPQpfvDyXMHW5rowuvOSVvyJln3Yg=
X-Gm-Gg: ASbGncvHDuZKSdjQbGdfhsyWAJ4RBZwlkbEghZ98W+WKBPa8mvX/11d+nx408kle1bQ
	IHJhhjpi/PNZnrsSGlJT6Nk9pnCgVR8RmBZIAIFeb/1SW45m5shVuK5g7MZpNMqADJt2hjlLoRi
	ro3CfHqPGerx0rrXxrbbIs0ORGPlOsnxvn4WCTTPkheyE700GlHzq+4QWcf2Yz1OalyR942KgI6
	rK3bat1CdeEyjTbJ0MZrVkJkxSKIsK6Nx9CS741+hk1QBEBtsfOUSrdcFzR81MfwRHf1CEGOSAk
	Nd6CRx9xtbv0pn4kpWrPifIdEPta3XBpPJnaH4zLXNIdJumtLGusFsSlRAHGNFzMqKi53wWA0pM
	m7X5zUQCakzmSSYs/dtgeF4J2W9+c4GI2yFK4GayZJpD34LLZZUqH4hL8VThJwN3gqEMiJT5M1G
	ASxuYiylc8RnMTl7AQkkeO7ixodtxzwpSIkIM=
X-Google-Smtp-Source: AGHT+IENO8kKJmFBvT6JaVKbI9aoW+Fm63UySKCq67MmXauU6jsjjjhIvId6gcTBcrtZhx4M5gg5mA==
X-Received: by 2002:a05:600c:1c25:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-477c114ed70mr1966775e9.24.1763684455321;
        Thu, 20 Nov 2025 16:20:55 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:20:53 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Ralf Lici <ralf@mandelbit.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [RFC net-next 03/13] ovpn: use correct array size to parse nested attributes in ovpn_nl_key_swap_doit
Date: Fri, 21 Nov 2025 01:20:34 +0100
Message-ID: <20251121002044.16071-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251121002044.16071-1-antonio@openvpn.net>
References: <20251121002044.16071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sabrina Dubroca <sd@queasysnail.net>

In ovpn_nl_key_swap_doit, the attributes array used to parse the
OVPN_A_KEYCONF uses OVPN_A_PEER_MAX instead of
OVPN_A_KEYCONF_MAX. Note that this does not cause any bug, since
currently OVPN_A_KEYCONF_MAX < OVPN_A_PEER_MAX.

The wrong constant was introduced by 203e2bf55990
("ovpn: implement key add/get/del/swap via netlink")

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index c7f382437630..fed0e46b32a3 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1061,8 +1061,8 @@ int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 int ovpn_nl_key_swap_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
 	struct ovpn_priv *ovpn = info->user_ptr[0];
-	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
 	struct ovpn_peer *peer;
 	u32 peer_id;
 	int ret;
-- 
2.51.2


