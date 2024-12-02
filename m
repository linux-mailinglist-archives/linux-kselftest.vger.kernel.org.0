Return-Path: <linux-kselftest+bounces-22702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B6C9E06D9
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 16:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1C116DBEC
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3951420DD40;
	Mon,  2 Dec 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="V+EgCLh7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ABE20C495
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152138; cv=none; b=RWk4pUt1OUgeK+wGjiriovK8oRONYkHW42cIH26p1tX71wZSHSWC+yBQwtXK/H9WbpzkxVhqbIflb9qXU4JvY9TUD2dYTwik3m8gWA7GrpB2zTtTsJZvMYFdhzgKNM2j+vBId2oqaC+DnwtUwJ7VUIND/MQypHWg2QtTQncGDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152138; c=relaxed/simple;
	bh=W5T+iVYKaPmO/gOfKB0RnKXCUMfDvh3g/zI0cvgMIlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I0EO+xfy61lnFTtFOKup0Ygwz7s4tkGCbvK0dWM4iF7xuHwlyNAPGZlr5D17lNFUwJPWIvUf3QhPKDYCr+1LCuDAoYO3cYDfjSXoxYTvNNtVuqZKfQwG+2no9ixQO7aK6LnFXb0p1v0OIxFjQa8Qjgc+14kkdZloHFDPMFssdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=V+EgCLh7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43497839b80so27896775e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2024 07:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152133; x=1733756933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jb7KHSQUPGhy5o0HEst1Kbqk3ULde1AaGrsUDUj2wbI=;
        b=V+EgCLh744ibV/CCYfd9yledFrf4TQgCQpIBBQ3ZQYemi39t9L+dACkdko1gGu3pV4
         7xzcX0wustZjlQjJYs6FVUjWUvolu5EjLpM+Mcgu0a31ktxJRyq9b1O6CVpHCF0Fs8+F
         Mm1qxps5tuJlQjCe/PYkMypPIAU8O35SxgMLyGEBHY+PkIz2htdrff97ePaFPdfc3Ixe
         llj8V7SG3DZ0D5dHmdcjxEd6PMBc16pW4culVcwDoG5zwcMRL5bi8FCNEudczZjm5kxr
         SMqjGHCZU07kbkHpCGpxxeexriSdF93TY6r/7BYza7BG3qsyZVyMejhuf8FIlxUVnNnx
         OQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152133; x=1733756933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb7KHSQUPGhy5o0HEst1Kbqk3ULde1AaGrsUDUj2wbI=;
        b=hf6mzLSMvE+IxWTqkl34kdDxZqKCIx0keO5/MKNCVz6Q7I3e43a4lRral5JEJp9m0S
         S4jg2KtB4F9NSFzCS6G105izQGpYutN5iGqWe9aUui/Yq1aEMmNo+Z3n+Rrj+7GaC9iX
         W14XUr0zXzsNHz6eHBGEMUOWzi8Dvpi74Xp6T6TQzyAm+ZqFpjaDiisUDySjfPCFt1Y3
         DK1ZK9/VV5ZMed2OpPkUA9w2VTCj3xZfMeuYLXPg9hGvIr9Wi0LpF2LlcdVeHNgqho78
         iO1VwCa4UtjkJfrTw802RbLe981vqGjt5dnX8mSI0zEcWPBkd9vI9MND4znyVIBDBazK
         2Sjg==
X-Forwarded-Encrypted: i=1; AJvYcCXO+sSXVwWDF+bOg736kt9Q7ySxh0MZiTMNLnz2992O0inym7Lz21sWONhLhvsu+KgnwCJWPeQhJt3OUg14Wrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvebkR39df2+9CI3BzZxPA4euUJ07Sx+jOiyF4TrgNxQdXD4Qf
	6qjmbi0De6Bkf1J4yKp8ce4R4/lS042TuZIayzRliETzam3Op73v8iIaJ+w7EHo=
X-Gm-Gg: ASbGncsBv+hoeGhtZHEFWqtS6FmzDIxvUrx8uX80Drr/uQZNnxW75koXpZZ+CHAXT9e
	cGKXya0bVM2XcoWg9VLhFjxJueQR55iZejRvE8WmRCC3rQWOH2HGkbXMBK43P5cm4MJVxTGriAK
	+oNcqpkldCnlabPMcTaJjjKRIsMPwEdfq2z1xH/tAHa9KCaHzwiFJGkkgNmDIbxlVFNO8HwVLMm
	jKCPq/3UTyjQc6BciTZpWLczeOMYjhOK7zNLwkbswplMJUX1fN1hCxwF5bE
X-Google-Smtp-Source: AGHT+IEn+KYaLgP1sl4kPtOglN8/sEshdXG03PjEYhnnt+7o+pRUaGL53PJCCS2kPdOoKnoFjeFW9g==
X-Received: by 2002:a05:6000:280b:b0:385:ef8e:a641 with SMTP id ffacd0b85a97d-385ef8ea683mr3213538f8f.28.1733152132886;
        Mon, 02 Dec 2024 07:08:52 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:08:52 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 02 Dec 2024 16:07:39 +0100
Subject: [PATCH net-next v12 21/22] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-ovpn-v12-21-239ff733bf97@openvpn.net>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
In-Reply-To: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=W5T+iVYKaPmO/gOfKB0RnKXCUMfDvh3g/zI0cvgMIlg=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1nnJJLVJJ7y0wCH14v4nZ2IqFXxcfBGNwR3
 FyraAQrRjuJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NZwAKCRALcOU6oDjV
 h5oAB/kBpJ8kCcDl6LLOf0pEsS0N7H4VbOZumG5shm+X4SiYmPmZfn4rWz03tokFQEIUU193l5/
 Z4m6Fx0MEB1YJnYZCVEnqFnTsUGnLbHlEtINFM+xVc5JEUCswZN8ABKUYxmdOhAVGZ2PxgNuTL3
 PDWsdlaiQNBVY8QTk+v0wjJeILE8AANEzZDVSXARHAjqhFjoMvcpriC5XWMawhKuNWhkJEy/4fQ
 g3yZapsV6JBok6SVe7Cr3rhHvAVE+rHykb3TUv3J5CPM5TqRL8dx9U+lPTaraFZ5qpl0MbiGP5b
 pOqQGnf4US9Bc3t805SfZGRpk1LxDQjAQCNerOH+YTiFDeSB
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
index 6b3a59e75e5aa918b28957c073990be9fb1d2124..6a828728d4f98f84e39ea429a8b76069c6d83e69 100644
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


