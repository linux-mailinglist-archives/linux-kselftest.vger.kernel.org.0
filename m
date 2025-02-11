Return-Path: <linux-kselftest+bounces-26304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90096A2FF8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AED188AD2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609341F0E5D;
	Tue, 11 Feb 2025 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ahGmL7j5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F93D1D514B
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234501; cv=none; b=gmNwjtha9SP1Jl0bR3WN/BjBpp/UG7cpewVJRu/L7gxGzNrlbuj+KkDEmArrvRPIJLnpzXDS6nQibRNoaXLEyT/EBK49LM64x16Vdddqv67e1+o394o6fuJjnAkzHPxiLxf2DE2zTAOeUW2rjIfYMm8yjRd2tayjdbqlZLz1S+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234501; c=relaxed/simple;
	bh=t9go/X+DjRrOvyBGhvmYx8gry+RZBj9ONKGlRFoyukY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HfmJX2x+js1C/z/Id4DizmPUZKhzc4iPX058nYk1H3CitVuq0+KEiRXPdF/CUyaRyocDinaeOdOK0aIXIvoDy/kajeZrTWnMHevF3Has1t26bPhbfIDvI7RbT8Tmse2R7uwsOVmBKd6Qg7RD9AfzjGcfSKbG+k7K+U/Nylj5GHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ahGmL7j5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dcae0d6dcso2071097f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 16:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234496; x=1739839296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMmL1XdpWp8bWGtfaVtGeJtwHAhwgGInZM8+xT9Fcfo=;
        b=ahGmL7j5DBG4T4ZDnjMoY7dw1vDe683VqEQ2gk8YanuR64fe7BXihK7lt7OSKGamEN
         Gv7eLLKbaeDstaJz0JN6OH86XFju6lIQ4RZYT/SDAFjIoZ3P5osdhx8/IdhZFaGchhHp
         AD9rSfCi0zJiUIiPopPc9/UUP3bvl+aEKzeGfxwLjR56Li7MvcO9Z50oXFuAgiqksvSt
         HQKBSEHX60a/a9Z7dmalXhcGUVJQA6aHYbuSy3cWeFqjNdMeYUruiN5BUaqMthXR1YIj
         Y0V/xbNn8mzvtBQq3TNTJssbzSZSW0P4mAhZ3EjBYKJEanC5/cAjZUhP2nNzB50KsmRP
         0rOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234496; x=1739839296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMmL1XdpWp8bWGtfaVtGeJtwHAhwgGInZM8+xT9Fcfo=;
        b=s8kfABDOYiOHOrAv3qVZYLvoARY8Xbcjr0huyUMUs1RZDyxQn1Fospzph08kcrgIq+
         j3JZa199aO2iNHYVptan97K4z6YknNeErKDJ31wcBa/K4YkcTw/tqmQrL0G0Do1WPyFS
         MCS9GR2eCYtcZeObqA/QoL6ebxysqlZoWSmNrbNKFPDMnbahwH03029Ke3JURP+5PIDl
         U1h0YVvN8UMDvKRa1eafn1OBekSlErE8tEvJ52yR/vfGqCI0B+kfC6w2DZVO8iCWw0ip
         bGkWFedS28+uAXNy1no4XLApqPhEzkajUwQz8Io815bKxxhe3UUGacY/9yJLtrS4LNJ9
         abLg==
X-Forwarded-Encrypted: i=1; AJvYcCXSeASbeELPUNs/Y9SNqivGYDEgK9XLv+RgOQ5FrwVCLwUIby2Ia4rVJ/+aCqAkHlnSiEZM7+R75K4OsUxqgCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9KQD5WncwWUCxg4kRY9DYQ4ADClR3onYuwMoeeW208CSwHS+5
	Equ7D/d/4oKdjjVSSFy2ehAHkfVgNe4R96XEHwBxtJ8w+y0PBAwwMevha6ov81U=
X-Gm-Gg: ASbGncvfFQABB6tFUaPTOWEGH4gmViximq2DaSBPVvjNWE+pK9wYRvfYZCVdKdZqlFK
	fxAo2d3nhng6K0brWmWV5BdKhfoo6Bk5uAihD2ZS/0fIAs3tmWk1x0qdoHEXxA3jZiXzUtEY/7N
	s/Eof/940rANHWPQISyQwVKOVVfK7Ii5T4TaosWk5KWBzS5SvqE9KJP85eNBA8UqGsZWWbhMExv
	x0PSJ+bInm4zWzJgnVmljDHekMKJN6TdujjOKeFFue0aIJwB7LRXxC2hfoeKAGosB0jOcWAuCKT
	dhDNSlCQRdbKAl3Dj7awLxTGQlQ=
X-Google-Smtp-Source: AGHT+IET0A/pQsSzvGSItJIKx9o2/+rn8QwlMyL7XBg1Isq492vibQkvsqK2ckyJJKTRztGcpI4R8A==
X-Received: by 2002:a05:6000:18af:b0:38d:cbc2:29c3 with SMTP id ffacd0b85a97d-38dcbc2310fmr12173016f8f.33.1739234496427;
        Mon, 10 Feb 2025 16:41:36 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:41:35 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:40:17 +0100
Subject: [PATCH net-next v19 24/26] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-24-86d5daf2a47a@openvpn.net>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
In-Reply-To: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=t9go/X+DjRrOvyBGhvmYx8gry+RZBj9ONKGlRFoyukY=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyOp1Y/mEQ9QiTKsW4bmwKuJ2pKrAI7cQdPF
 mLLCHnGCViJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjgAKCRALcOU6oDjV
 h12yB/9R91hNevzhBIkXLNi3Xy2XVZvGoKjRM8TvkpDV99uf7PVv4U5XtS5vy2zDxtc8FE5PZTi
 vCQqVq4LQ+Hay7o76lYahkX7uukM4J+kkCgI4mZ/aBPLtah+JM5Ll2oN1rss1HeXsY1w/TjKJt/
 EbeGSjdo4RcR9aWFylDxkc3+hBF6M5vMFGfWSwH56S4KOc6x+fyZSzAcrFX3V4tzV1w2UQOlsa/
 GoH84DcsR0rCIbD5WU0LOIhIjX03vTkHFjfZIkK2UdKY2QERNkHjGw10WiOH6a/Q8uzu8wv21+I
 RLs7SElmo0pWSQQt3xghjyyQfnNpNvXhdL/5OWLMR401C63y
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Implement support for basic ethtool functionality.

Note that ovpn is a virtual device driver, therefore
various ethtool APIs are just not meaningful and thus
not implemented.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ovpn/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 38114c5482e3ba283937fdafce62056096ff9c2d..20625a2293ab0e55e26a4d700fb6a3d4915b466c 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -142,6 +143,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
 	return dev->netdev_ops == &ovpn_netdev_ops;
 }
 
+static void ovpn_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, "ovpn", sizeof(info->driver));
+	strscpy(info->bus_info, "ovpn", sizeof(info->bus_info));
+}
+
+static const struct ethtool_ops ovpn_ethtool_ops = {
+	.get_drvinfo		= ovpn_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_ts_info		= ethtool_op_get_ts_info,
+};
+
 static void ovpn_setup(struct net_device *dev)
 {
 	netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
@@ -152,6 +166,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 
 	dev->priv_destructor = ovpn_priv_free;

-- 
2.45.3


