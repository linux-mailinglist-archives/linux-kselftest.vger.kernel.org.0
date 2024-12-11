Return-Path: <linux-kselftest+bounces-23221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7487D9ED8DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 22:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BF1188E0A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 21:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99051203D75;
	Wed, 11 Dec 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="M7mbb5+x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23631200114
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952796; cv=none; b=Hkn7jnJp1g24kIVaDVb2M/Zqkcmagb4a1G5Oo79THPlkQaxK9t7rmy759JMzetStZU3Z6KCg9fX0zUsD//Oad35QeJxJyWEyPLrl6wsM+r9V4qXTZMiyoqG/rtDRSHD78CpL0+dtfVYQdY2YyGnuraoJj4awUTvfZGB8DACIA30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952796; c=relaxed/simple;
	bh=W5T+iVYKaPmO/gOfKB0RnKXCUMfDvh3g/zI0cvgMIlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uc8+LD+MKeI6/dIYxIv1Iu7vWaSMecjhk8K2FJI3KLY93Zc5jdsYUO0rHrTT3iUwNgU7GMqmm9eyqlCRALrAOO9lW8PeH3CI75A/00ttkxZ4fAw2ak31tDdDqL68DSQsDuC9h7whcObLtp2WbeQzbTB+oppRRNiNE4Nfh+x7Vc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=M7mbb5+x; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434e3953b65so34272635e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 13:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733952792; x=1734557592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jb7KHSQUPGhy5o0HEst1Kbqk3ULde1AaGrsUDUj2wbI=;
        b=M7mbb5+xRt7lgrWvQoymuMAr0sAxHLDDlmTuGID82vdbXtLsILdhlbTDtgB59R2dvc
         UaJONjx/5ITIFISBXuXkBqjPydhL/SYoyeK0oW4rLzjDV8QwQ/tL1/t/gqFpszAj6Xij
         5alMFQSe0b1UbS6hphb3VMin6IExuHKX5yRG1as6KFEAwrAGSGpTShdeeM6EQivcLGvv
         CmNAen8croWJFXSg/sgM5NLdWRyfRChk5ZGhQCHVtV9wWPTrQ9MDTRJ1TrT7Uq944hxK
         DQ1ij/lSaTL+5hP5vDS7PmQuH9Yj5ATN4/ofYvOEC9eTTdZVShDAwCsjo/QsV2u9M1Zs
         Ns6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952792; x=1734557592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb7KHSQUPGhy5o0HEst1Kbqk3ULde1AaGrsUDUj2wbI=;
        b=juyedsNXc8kxEuavaHci1VcB1PwNyGBiTsEfdvr3E8U6gGnJRRMdZ/vVq13K6m+T5I
         VfyMQBPmeuz5k2UPCMG1ePfCL/Rn93bwWCFavQeb6HoYido3fe4qc9GMJ+qBdeZ7TyIq
         AJiPHD2JqpJ0t3sbmUmVK5ogJF1jmFfB+du9YwuZjk+13C52UbBdiXWaLlS3vHPOEJsh
         9k4krbbfp4V+UzlDUIZ/Ce2INV5pTzffERM3ydhqwfMMitBmfAxTLWeiZD2REX8PO5ey
         eC3Za++Bi/M5CjZs5cZNNb14ycU/67o1ba6FJD1E+HFnNS2a2PWXpYB04rWJ10MfNbnZ
         nEJw==
X-Forwarded-Encrypted: i=1; AJvYcCUL02s+6Kbym9ihjySUGmpRPdBKfpkJPAfXAE1LPGclr73Cvu52JP+2TVvr3XL7sW7X6tgG1B8bmfw9bBvAZhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGyFR3MqXb4X7kpVCmpTn7iEid+1lSuCBIrJhG/4M7GXWX9ZZS
	NjIzAEkVjlMF7tKL+KT3ss7Tx21GpdrFrBN8g5AQ8bXZ2wyJ7/+OHVVrt+OOZNI=
X-Gm-Gg: ASbGnct3RPYD6CrCj2OuRbDoFU2dOkez3bdxbuv9BUXgFs9WmEiimtuv3y3c88hP8vN
	9CAFdq2Wp+PG3vgRy/p0xMIv6SUzH/Fe/ENQJe7iJksseS7Ra+z39s6fi24LIIQwp1VziVeTJsf
	6YdogUiZ0rtk0Ln9Hio1cftIobErrzCdT/M9eoB7/f+s3fbECmxoPDWKZpvy2SGmS1777OFYLPD
	LJGEBr8J2hCLeBm2Y7NG08pL44JIMOrlA3f/hq0gGNRc9KitZdBTFwtyLes7dk5Tg==
X-Google-Smtp-Source: AGHT+IGJ7suUDj6Z1NJdGOjPyyYIc8vYELxukzBuQrivTkK/7/QboQsQXKwY9N9oaOGHmLD/Lihq5A==
X-Received: by 2002:a5d:64a1:0:b0:385:e105:d884 with SMTP id ffacd0b85a97d-3864cec583emr4039605f8f.46.1733952792431;
        Wed, 11 Dec 2024 13:33:12 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3115:252a:3e6f:da41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f5a0sm2136252f8f.13.2024.12.11.13.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:33:12 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 11 Dec 2024 22:15:25 +0100
Subject: [PATCH net-next v15 21/22] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-ovpn-v15-21-314e2cad0618@openvpn.net>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
In-Reply-To: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
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
 h=from:subject:message-id; bh=W5T+iVYKaPmO/gOfKB0RnKXCUMfDvh3g/zI0cvgMIlg=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnWgUnxlhYxePqNft3sn9hS8m+EGz+elik0rcEM
 ZGKsMwRQhuJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1oFJwAKCRALcOU6oDjV
 hydWB/94V95L/EN/+b/96zCxcdN/3V8wNf+Hh/MNun2+yxX0rW/71S2DK1QbVtSvqC00DhexXEb
 /vF8ORs7HKo/tGAoVimcvRilRfumegk/itHjoGVX283RXnxaNY/Kp0UoP+NX1zgUki5nivRJbFc
 S4jN5RmLz7GojPZSiBcd8Jy8KJslxzHXbjCLfWutzRSuQ6Kp5I9pkvhs3emMNPx3ZS2CD7Ihhpk
 pLXUgyj5lJaRHQjL4W4xBStgR0asf4xSr/IAZ7u3Ue+AxhtXgpkgznF7m/kdfwxAGnv90SA4ZVd
 OXZDrdg4ak8zeV1SsyakpW8T3SvfSJF3AzeKvU1bwYnJv8o/
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


