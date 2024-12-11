Return-Path: <linux-kselftest+bounces-23204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6709ED897
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 22:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E115D282D75
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 21:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DC01F2362;
	Wed, 11 Dec 2024 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AvaPRk6X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C091F237B
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952773; cv=none; b=Ww1H1EWTdtI/8aqOpnHaApiY59T/7di2LjOE1NvLUWPCjBGRYRbYBbl/F69l541eqOLj7Nb85S4/Juq8t0QSxD58oT3ePzj6x5sULz73aUonKxwde9mYw4NBneYuXpekSERGjU2aVLKSwLAoGvCO2sQf3TgM3cE+V4CIGoSoWBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952773; c=relaxed/simple;
	bh=GchxL43RZVWbeeTak50ypiKEh4su8ul45OjPZ601Tf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CT/McypMfXQ9QKGtJ4X/lQ/M2nXVFXmjy0M/6182IY4v67cFQAwYBGhe50sAhClvJEjKXBcreQJI2+VemDMAGhaVBcr8ja7dbceFh8aqVh7znYak/VRhSREijeFrKKXKTeC+CPgW1Ae1xOdLrPkef+YN+T8JGxTyhBzBgJmSd/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AvaPRk6X; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so3091485f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 13:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733952770; x=1734557570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFk85mO/CYRQjFZfRXq+/JqMZn31zCiBs+VMv6XbtEo=;
        b=AvaPRk6XCPvY14z0tFqVl2Q8/8ys9l2FfLSVgrDnCZhOd8XDK0enTxJs1xPDI9mFDJ
         E8OiVVsCEkmMlzsovST01W24OJ/iOSRZJmu8jOc9FlLb9cTJWSvHeQm4BCSyOPuCakcj
         pfQi3rcufISWwlZzgQGfQW3s9MnfThLvppJ/rzELLF9LuIkSOufGdF+lVUCwwgRnkM5U
         AkKFJNFdYfFytuq10zaXkfxFmH50DOq9sgtX5w9UwLRRrynT6do3w8Gc+VLrQPsdbAXK
         hi4JclW5u/a+Dewyae02LZoHEA2uIFt6ZyvL5wdJm/lrgUk4NcvXDGBmrcH2D7zZMato
         g6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952770; x=1734557570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFk85mO/CYRQjFZfRXq+/JqMZn31zCiBs+VMv6XbtEo=;
        b=O+8dGfWnGchAoBtZMK/1HiKXdll5HGNqQQrsxGpVXtpZOfAaUc7ksMlq3jGHjFaZhP
         yClp9DDdZ/rE4ua14PDANStHUa46r5NYr4O6fgTLU+JglzVpo3IURzTRfe1ESzDSDhKV
         VeObtTSu0oV3JOGmG6xyfvoBC2s11aKqU3qv8/RkllV9iK6BKF/UKCn+UQHvsw1mSgW0
         9H4VIfZISwGW3/osMohXgDUDw6LP0Bia5RlbOL1DE4sgw+IPoVSqakjTyvjj4n4uShB+
         eR9jxkrUjIQA5prK5aemZZJV0CsLuy1UiUDus/9rs2/1xijWWulyrspNc5GkEExqz7tI
         GkUg==
X-Forwarded-Encrypted: i=1; AJvYcCVTt5MqDhmnchzdmNfD80SPfgQ4Ndbo/EVc0lUdbDGJqxvdPZ3mlPop9XHmENogvSLg6lWJbRGi61QdbsDJEDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUbn6BACoxG+Fzvh7NIFw9YIi8AS0Vy4i73ZdU469+rjZECixZ
	mULcPaoWdPUFa5q+XmfE3dV/P65XHhOLGlQ86P0BCtuKC23sy+fsUHadW6XSB5A=
X-Gm-Gg: ASbGncvB/5arkJdZSm+yXzHvmmYT7ecsBeIibISBW4cFsXHQadifI1fxKeYdgOq40E4
	69c3jjZG5wCB8oi2xy949xhD7bW9D5NsS15hEyNyl+FqqAF9p2w6OXTJfbW4g5yVuFFXXjOqdfk
	c0V0q6hrcGUw+yjCc49AawddjFQAPfFJIUgd2VIetYcL1dxYw27ygm2TgNfGxRDBvKm/nq+TdMJ
	drEAxkdJlHaMJ/Irj+77wGDKyYrQL6RAsIggL33DlgoEvwEg7T5LwAE+9Wj1KCymQ==
X-Google-Smtp-Source: AGHT+IHOLwkY5JO6rLcoMM3bjyhpEEBshYhAf3iFv+DgDiFwDrq4wvIyZMAmOhpA3SShXhXMaP5Eog==
X-Received: by 2002:a05:6000:2b03:b0:385:e3b8:f345 with SMTP id ffacd0b85a97d-3864ce5dc32mr2355693f8f.30.1733952770248;
        Wed, 11 Dec 2024 13:32:50 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3115:252a:3e6f:da41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f5a0sm2136252f8f.13.2024.12.11.13.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:32:49 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 11 Dec 2024 22:15:08 +0100
Subject: [PATCH net-next v15 04/22] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-ovpn-v15-4-314e2cad0618@openvpn.net>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
In-Reply-To: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=GchxL43RZVWbeeTak50ypiKEh4su8ul45OjPZ601Tf0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnWgUkj9iqYHMbkR8+3Qdt/A5EC+YC2cnfPHXmO
 Q8LGxxdk3+JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1oFJAAKCRALcOU6oDjV
 h8GzB/9+2y4h6VU2/h4mPAUS8HeoyZlmz1QBdbrD7cmh9GFr4rRXGoOYLmby2MDA92uYIw+mNgp
 blzCY1mvt9eSfBZwsM2TNqN8yoHM21vLYS73KeoTBruJdOVPyg30OmQroW1OfEtFbAp2dMlkkpX
 T1q/JQ6gbj+RPNzUmjI4TzuPtVw0tkL//gRcnemqm9t3uxG0P9J9+YfyG+Xp3azTP8Z4X0bvSYE
 d+wZHwikKLuq6JglVahxwiLG5is+x4EE2ObC/RLfnt9fYa5AoAo3E1bhIgwT8CrgpkvG1FMfcfu
 RRWZCtg441kaFJ5EXnmUrp6L+2dwq4zcaOn70um20uvSTKkG
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 60954c5b2b9254db1d24d01ac383935765c7ce5b..274d6166741ef2d6275a252d0c042bc66f8f41f7 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -23,6 +23,15 @@
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	/* carrier for P2P interfaces is switched on and off when
+	 * the peer is added or deleted.
+	 *
+	 * in case of P2MP interfaces we just keep the carrier always on
+	 */
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }

-- 
2.45.2


