Return-Path: <linux-kselftest+bounces-28134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAEAA4D03A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 01:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782C81892AC2
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 00:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F281FA272;
	Tue,  4 Mar 2025 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fdJRy+bm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC081F8BCD
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 00:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048501; cv=none; b=a64SaZasb5VVA/C8QNa6C9LhyQozRLZGKvJR0BJCg0V5yDfjSOHHXKwYU+y3Z+dLGexLvwQh49uU5u2P6y+Z/MQ9bh9QwgHJhOA3+wUDCPdgRihPZUj5YRuoy0cESWzr4+i64oHSENaFAj9zDjnpNyMXf75dvjtTt34xGsIc06A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048501; c=relaxed/simple;
	bh=BYLORm4A7rlyB0uoL8wRITWNqD/++CVET8EMPQpW32U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CC6KMqIqYwj2lx5Yh3y7jRKIqy547QYuW47McuaXTXLHwi1ZXohsRCwMvNpQ3DbzsUzxmiuWcqFm46Z+l6UG9QRtXJvDHgFAzly2763WwNkvik20gge/SjqQn/87DR3UPit1KFEOFn2jddiFlRSNB4VMsomG/whiJc88aKew39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fdJRy+bm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so17793465e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 16:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048498; x=1741653298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JsGlr6Iur8i/UJC3VdCm/PIJhARIB9iZF0up1yoAd8=;
        b=fdJRy+bm+HZbsuBjgtVuAqgoiS90sO8tkw2NzvJ9+nptEtes1iUKdid2ytJE3Vpnqs
         oI5OcKV6Dlp8ujHxbKsIuo5UjlvkRSBB55Y7HzzL6/2Fy8bvBW9dW09SfLRQqY4C7CGq
         b2d1xD8A4xHp7LsJij5OumsAkMPOid2uKPqe5Xzn5s3OOhSh5SQfJpvvevhV8jZnrgpV
         1GSCVxlvhr3wyO4Gho7khHcaoXud4Zl0QJmvAX6HubYzisikZ0nmA9021rP9YVyBmOcI
         a+etQ6IaD2qReWVJj4jzqZ4GyrcpPbehYRMYEgwRIqYskxuibBs34L91GIuqb+qMgDuu
         fCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048498; x=1741653298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JsGlr6Iur8i/UJC3VdCm/PIJhARIB9iZF0up1yoAd8=;
        b=evRae81oJAmlnUOn0oklHV5acVviFnbTKIXPsxLitLD8ZDlSnIC5nvYMko0IdjK+nD
         o6ouvVJZRT2/saja9IXSQVjsbMXZkAOiNFHC5LIxK3PTt7ZlJ0O0UfJ/9TRJPtEOSxHg
         n8gCjVRvoiJcXf5ipLH/cL/+F0vgeZCQeaV9eNCnS3rzi5A837OHCj8CNcfeE+6cXHjy
         Janf1V386YQaaRhCLiYa8SDUVwqUqJH5YMwkEA84bpCsuZbqihnbpmfrk3icqaa9HT1I
         2tCts0u3So1d4KVDzdcU4vEboF0vAKuVvJxii471aXwg86M9HwO8/nCo7zqb4wmC2wiR
         +lXg==
X-Forwarded-Encrypted: i=1; AJvYcCVsYGXG/Kz5+4a7kfh+bB0tsGO6yHqgwtpyBPuzaFGVWMiFfZOqxxgqC4l9DN6rpS05CWbMXNj2if2s/mcd0tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU9W5b3B0QbdVVUQhTns5T8vl/pTPtfIVg0FWPgPMAS6sph+52
	m+odmhwW4K/GVaSICAI1CkkgFnQl7pkhjpXLnvN3Emn1115dv5v3xBcH3g8owRQ=
X-Gm-Gg: ASbGncuVj0YjF6ctqg8ARlRi4Z7LnFkbK8bUjUrSaecKQbbXs13jnboz1/TGFROJWee
	rON89RYHj5VJqKj64YIHav4EYMtN2hVO9XTbLfbfaNFq1e8rkRk1oKvVbRmvsjz9aVzhxiWsxSa
	G20fJA1QrllRgkQ+FQoZFNPdF9Ol8fqmRTFzCfYhQ42N7Cj0qIrmROiumKsUGx1a7XVePrskzpc
	bQedi/qzXU5pN2EJsiqV7omI+7YxKYf0EqsFN5XMr7z74WhXDtcJPmQu2w5bCyIx58B2KgAW1Xd
	6jWMB9OhgbspITIBIKG77/2qn2yojy1B70192N+r1Q==
X-Google-Smtp-Source: AGHT+IF4hh9Veg+IIk58qFi6pjlWS2ZAX5o58ECRQ/L7f6BiUykUti8fmy0ZCXSRrfO7W5yaNMkpjA==
X-Received: by 2002:a05:6000:4027:b0:38f:28dc:ec23 with SMTP id ffacd0b85a97d-390ec7cc23cmr11200866f8f.19.1741048498138;
        Mon, 03 Mar 2025 16:34:58 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:57 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:53 +0100
Subject: [PATCH v21 23/24] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-23-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
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
 h=from:subject:message-id; bh=BYLORm4A7rlyB0uoL8wRITWNqD/++CVET8EMPQpW32U=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqQcek6cbeoSIsg03A+MkCeLuwVCiWKLWHmX
 Mt/2KkXxsWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKkAAKCRALcOU6oDjV
 h9GICACjbEYzDHhE0aU6kVbqHnsl8XwqNSHG3ta2xZwGubqlb/z7LvUiu5+oSLaD3dEO4qFjhWA
 erCkkUXciN5JgMZ9f5mykiLvMtZN7+9/Z6bRRGnuX9QlO1cH9tm9x1VNVuvkCO708E2UX09y8fN
 /x0tOMBlkR/t999IxgxzSVKXrKHqjvX3jAoYo8X50JEI5r4x0DkYJ1p8BLyXArOhNuknWwkiOwU
 OPtuVW+hC80a7VT0I18A8dDiiSixvwHF7NmXt2aueicsRasb8ttQtSUdKJkyltECZdUIGSTGZma
 I2Q+cqT8aYiRpwT3a7niQroNki2XF/j4GUJKB2HLMuKXquBz
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
index dd05d0fe7a2d139bda55ebd68b9e1d78f5c00af9..886601ddaf7bdee4761691d293274a61da204f2b 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -143,6 +144,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
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
@@ -153,6 +167,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 
 	dev->priv_destructor = ovpn_priv_free;

-- 
2.45.3


