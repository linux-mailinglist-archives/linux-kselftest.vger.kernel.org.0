Return-Path: <linux-kselftest+bounces-18890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E9C98CFB9
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC171F21C47
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 09:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E669C1E00B9;
	Wed,  2 Oct 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BNRIXeeU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341A41990BA
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859827; cv=none; b=UV3/WGv1fdXh79psOgOG6tAhOB9Nmm5/BFBX6eteDB+CroNZsH25wn3VPnBYV6kuIIOZTUKYGjBhgFQDK69HmcwFf3FzQr/AB2hCQACVXk0wE08SWgMElFRcJA/jsbtL09Pe7BF3VdaQuixQhgOKzhYSi5Z7nwbGfLv3+aJLNp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859827; c=relaxed/simple;
	bh=0HczZybwcOvyDCXb/Fw0Kq345nQiLm5f4dZXh7KvAg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlxlnmBZgqxt7GN1kpBVf8gpgwG+ARupHd6Hxw3bFQNgWKy3S6DWfeStQHlgg1awOF6HO4jMpk28pVYChb8sfkLMOEp+0MgObR+CybtQSsugv2P9OYVmtnP/s/OIJNZskPVGXUZwJG0tq09zOhbW2eHpKRBabI9okif9La3Nmbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BNRIXeeU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cd8972738so3250987f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859824; x=1728464624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jtid/4Ggea81hP8xAarmxZwacDuX1oN1onp/X4GHPpc=;
        b=BNRIXeeUiKFWw0PuShIhM0vt8kJnlsZHwe24vpmp6S4QViLAXL3tBONMniNN/eEOFZ
         N6QopwbtJOmlfeuv3EnHUDv5JujinXaS5n/Ipe7VdBs1MBiXaosDQAR8qykFxvOkbwHo
         9l1V7b2NZD3JfocF96Jufnajr6ID4VSfEpyLr2XjHon776PAN84yB9mA4/+JdhRF4IH+
         3kTj0IXQOBuYeFbL3vqsKi4krvY0uKSPEC1CcwBdvLtymz8IbdXH7JY8KCM81UOsoLmX
         VY+OvMd54b09hufruFIMskQBaGoGcZiyw45WjosHUo2B6CDblPuWJYrP1oHR/EUnrKS3
         wDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859824; x=1728464624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jtid/4Ggea81hP8xAarmxZwacDuX1oN1onp/X4GHPpc=;
        b=SggIE+VER89eY5siocWafEZPmjr+WGbynJrTwF+o4F3t3CYB9dE9OsWA3STZEmbiCM
         lh8ZUQj4ePGfbCxv06QomxHeGUvH4mqg+mruCkta2QA011nWhMzOSrlLp+jtephb/lJE
         PjFAVyXVLmQsrlvFgZ92DyEB9Kpx8U2pR/QX68NVatHZ3eoo/yScXLhnWL5poHtxgXQR
         aaFbqv2kNPb4z8wu3PM8pnrFexrEdx4K5bDlO/EdSMR5fweACUFt2/Pf9KV8BCY8iQp9
         UfLNThLJF43bMIMlZhBg+bS1Br8ojQDrd1lDXnJW4ymUBJMXua/ywgF6RmsprhCRuqFu
         TADg==
X-Forwarded-Encrypted: i=1; AJvYcCXLC/lDMNzXfS6zZMmmJ+i8vMGRgi6yvxYtgQe8fDQwnflJAl2VggRYTuMSMHwQddyBp4VE9uk1iYHZR59mh8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3s7O4DvTHdf3twxX3Cx8RegPAegNVV+AjuLW+13gtfs67MsN9
	1dbGYFeYKNaS9jcqy3FxkgvoPkLK5wOcTUXsDliVonpD92owaAI0mCyx1Aj+qwo=
X-Google-Smtp-Source: AGHT+IHF+moQuogaubmFiV9fQExZlkakNdb2tJX5ZJm8bc81FDHr5npglK+ha3mscDcMX8g5JXpqFQ==
X-Received: by 2002:a5d:498e:0:b0:37c:c4b4:3396 with SMTP id ffacd0b85a97d-37cfb9d454cmr1409760f8f.29.1727859823678;
        Wed, 02 Oct 2024 02:03:43 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:43 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:37 +0200
Subject: [PATCH net-next v8 23/24] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-23-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=0HczZybwcOvyDCXb/Fw0Kq345nQiLm5f4dZXh7KvAg0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxTy21F+BrAC+0BHzA21YyFzTw73Iap1BeA4
 QiQ06zZYkaJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUwAKCRALcOU6oDjV
 hxhlB/0TB9PzRSCIcixOB4y3zYbwFDJCgJpMby3jkPceLt/4GRyPssjFpp1QvRt6sfyxB8Ziu1g
 2hTw0pKX8RiWiL2jFFVo5FLFbDhwvwMNMz9eN2MCTfedFMiA5gwsaXC4imQl1Vm5E/pOyTLSTWk
 uxbDvdTbGs8yYLpw0H9Xk+ZEowVBaV0+T+Vu+FFXhPk7n53ixreCGgtlpLNRa0W9Qr5WauUflbz
 2dUFL+63/+z0Hs0UcFJ3B0bn95TYVTEUkp+dCcOh9uvOVZ8R4dnEPkw/b4m08Bq430+ERb0uEOD
 v3c1k8Ix+/5ZTqpyC/1OUGvmYxFqYPXNS1+sfxe3AZGBkpUL
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
index 6048df5890c8fa46f3d91498903b4277a33f06db..a164b6ca2a4b8d69a76938fcd1b76d1f2e563dd8 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -137,6 +138,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
 	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
 }
 
+static void ovpn_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, OVPN_FAMILY_NAME, sizeof(info->driver));
+	strscpy(info->bus_info, "ovpn", sizeof(info->bus_info));
+}
+
+static const struct ethtool_ops ovpn_ethtool_ops = {
+	.get_drvinfo		= ovpn_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_ts_info		= ethtool_op_get_ts_info,
+};
+
 static struct rtnl_link_ops ovpn_link_ops = {
 	.kind = OVPN_FAMILY_NAME,
 	.netns_refund = false,
@@ -158,6 +172,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 	dev->rtnl_link_ops = &ovpn_link_ops;
 

-- 
2.45.2


