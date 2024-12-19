Return-Path: <linux-kselftest+bounces-23565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DEF9F7237
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 02:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9111893020
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 01:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FA91D5ADC;
	Thu, 19 Dec 2024 01:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IDdy66/v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEE21C1F00
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572570; cv=none; b=H1sqGsq31oZC4Q4Txpfapxa0UPpA2XwfN3aaUHcyE/EWP4qalKY11ii9v1Mk6ZemV5s7zsZsUxeg3paCms9bFyrUd/OZ10LAVkWKuDsyDxDlyol592vvL54/1VR4ztmv3mHQHIi2eNsxzOUK97D0lR6KV/MSwJ6WCDXXBnvaG+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572570; c=relaxed/simple;
	bh=lH+70+vbb8mzsnWhRaq1p07+gp3g/U0ZT6i44uGNdws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pYNRNYrk41pYHCOP43Gb4Ir6FR6QBU4ttB+OjXhb281bD9v1usS0U5lLHrRhs/bxZsU3ZXaBhUJDbtatB5J3Vm9cKihNDASfhIldVfdUROhg0Jb6IlGETOANRAet8HTKvx599GV62l0cFAuV0egng7b+NsKzRGGQAPpP+B99x7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IDdy66/v; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385deda28b3so211788f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 17:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572566; x=1735177366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6fd/nqlYwcpFBbPM1ixmIIbdfkkly/YsiIhiew+A3k=;
        b=IDdy66/vS1TpwfNTgP0h8awzeezvLooxqvus3aGDtt/Ohzf1cy+OOu45r4QMwDes8p
         6bMnxSeapCDFXk7PxYU2Vborm+FMswIYrvUosmJnvrr+Jfgilmnum9uv42n2/jlJGnos
         I7TIJhJ08Ls4yADjh/TizeWaXWydhobiC5/af7IxoIvg5/zRfJQJ6SqBqB1uKh1OD22f
         M32/Ks0YbvWtUJDiOwuijbxAZHZBkj9dGRgyrZkYni0lQr08wad4ENwtVxgIp10Ambaj
         /prrkcLvwJmPBxAgrcU4IiBXR/bEhyzXY36PaASvnn8w6AFH2CFChsc5peuxQKnal5IE
         zfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572566; x=1735177366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6fd/nqlYwcpFBbPM1ixmIIbdfkkly/YsiIhiew+A3k=;
        b=AJPzRMuThkzBQnAadivUYd9gor9MXktAdmWOYSzRw4LABKVMKW5OWwZNkGhkjD9jyE
         pwgaWHeAWppsttdDKoZnAGxpBfJ7uz2oELztZq+nZ8/2rPJc9fsxNpO36u1OLZfUvhAU
         TJmIRqvDr6GraZeKTxUgs5SVJCWeLcY+yq7Lg2DvF8kUSGSezBrhlaEZ7LKVmF3Z28La
         GEYo0oE+t9mtS1piIsR1mIJPScvDyKJ1WuHyxiEV/xhL6zz68nnmPnlb0ZWoT2c63aVW
         TsRQkYA7JIsdjMwQ1XKgL7ZQCi4T8+E1Uf2MAJYB+H3uSzJ6c6Qu9dMRzMhS1wNZskkk
         50NA==
X-Forwarded-Encrypted: i=1; AJvYcCVy6/7Z1/deTL8fawbSUBsGFOZA+xYa3h+DI0Kp3hZt6vqV4b5FP+/eODacIvpIcfA1tgt2cGr1XHDx4+uMV7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjSyK/L6WU2gAzPdvsZ1pto3ryU/8x+BaVC468cdNufSOXhCEr
	EWLkpz5qs2RwHqJGq1WGJCBrXUcLFZpO2Xo8yqbtdpAZVHaccQhv1dZyCQHK4Dk=
X-Gm-Gg: ASbGncsnxSntolieq3uyBZ7FuIK40LMnvWE8zvwjTKebWZ6ZEgz3Flv1k+c4XoMqMZn
	nGZPl6x12GzSPvTd8BYJa3LNwSgzAPBHY4kPOC5jEQepsDA4rq/f34o7pcyUZhd3tQClPeuz/CT
	EnD3PunciroJRsnLYW/TIZ6ED27PeCEN0e0tmRhDmkD66Rj6ASEdS2i/mYThAaiDuJFAizmdgd1
	ONUcIKoow9AhkRkctT+gZItRi0kBggIoRb8epUfVo+IybneKcDFTPuupXsyj2QWWd90
X-Google-Smtp-Source: AGHT+IG5N4suecAtq5lUtoaXqjEZAqAJ6Ib41P2DunbR+ADeWed9H6rDTmAZx9jOMhm1ceWGiaIHGQ==
X-Received: by 2002:a5d:6487:0:b0:385:e394:37ea with SMTP id ffacd0b85a97d-388e4d575dbmr4031044f8f.22.1734572566448;
        Wed, 18 Dec 2024 17:42:46 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:45 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:42:19 +0100
Subject: [PATCH net-next v16 25/26] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-25-3e3001153683@openvpn.net>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
In-Reply-To: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=lH+70+vbb8mzsnWhRaq1p07+gp3g/U0ZT6i44uGNdws=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oXhIz1AGiA+6UKf5HJZ9//rpOpYrKTyPJ+n
 FdbYe3Hs5eJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FwAKCRALcOU6oDjV
 hxW4B/9l7s9Qj9GkpLFs+NKKLpSovwuVWPFw5Eoq4y9lQvV7B+gseK8TQeKliBIe0gvMjtvL7Gr
 s54GnWkEDGnpq+93aBea+oiqPCMq5XOM5Lmi1usVVWO/r0whFv2v6BubJoYoGQHLuU1FzUBo6Gz
 TES9p+xMstNUTqBH8oSBxuls33xUmNJcI98hs5Oql4t0gN93Z5zaTvVhMGYiJHNWxD77/d/xBPc
 1frTTS3onjn3s6Ekp2Qw34+Ddj3Tv2HU+H+ORjoB0T3wthfDnquV925WqpGnvtViiHhbO+ygTii
 GGSGOCPfytb4W9GjXqwB/UeBMX3lEilGbPmxJejoCa1jXZ3B
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
index c7299a4334b6d50fb1596bab0af41323ed09edd0..2de1070f0188078418c14f332dba35d98bb1dbb0 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -94,6 +95,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
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
@@ -104,6 +118,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 
 	dev->priv_destructor = ovpn_priv_free;

-- 
2.45.2


