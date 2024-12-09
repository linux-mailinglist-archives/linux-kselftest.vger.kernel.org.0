Return-Path: <linux-kselftest+bounces-22992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CD99E8E2A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E110281E3C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439F621D00F;
	Mon,  9 Dec 2024 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MebMzUEP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6D21B1B4
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734410; cv=none; b=tYPU9TbYCwuEbY/aDxHi6Z/Qvynkf69wWJcCar8LxKEhyGXeQH2tgctiQJb4BRmLHTh6c1ECy2C+KJJi80909xiCoM6LXq1HzfXBGj5Wi+Txt74uTb86f5fFP8T0V5lcSEsqmb0MF1ehRBqNt+f44/9gQm9tY6ZV2AjUpkCOwgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734410; c=relaxed/simple;
	bh=W5T+iVYKaPmO/gOfKB0RnKXCUMfDvh3g/zI0cvgMIlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cn2GmNvmQa9LGhILpwKvQWAa1pmeZrtBjnBw/ia/67XmiGnqBu0E4ZHjFAUOWYi+VXYp3sNamtO3hmUOfNmmwvGkpuBAPGOlIxRX2yTE9hDSEu5bma0rUnkcIUEt9fZReFswVO0Kr5q/4qbB/73cQL29z9jczVRo0FPBDZMfJOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MebMzUEP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434f0432089so13147495e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 00:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734404; x=1734339204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jb7KHSQUPGhy5o0HEst1Kbqk3ULde1AaGrsUDUj2wbI=;
        b=MebMzUEP/A5z1l4aKsmrs85+rnhNLfub0ejeWL5gIliX5MRsB0Yv0HHU/7qpEWXTwC
         hVEbmwHu0xf9ZfFtSYdl489ry2qB9F0C9UV7R5Nkmwk95X4Li+NabCRM+dTt/iv3KPu7
         eflU+GrU2Zd1PlsBLWqbbxo7vLcI2RVZ0tBj4Zb6BVvRXgUcE7FIPOY8A6OoL49mfysK
         h0GDzpv3xxy6ygso9fqwWGhcO2yIEKPizvI36XwR271XgURqcpuag38jvARR1iEwVVsJ
         mssCussGI9JJrwW1gZ7qJ+99HGli1wjZaZF6rv/5Eu/oPA2ZEBjV5Pbsz+lJz0X47wge
         Yuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734404; x=1734339204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb7KHSQUPGhy5o0HEst1Kbqk3ULde1AaGrsUDUj2wbI=;
        b=vkZqvZR1L6HctXqMc+qA3F+mGPTrQjGpJoEy/+unJzIU6Bz8Jo8oj+GDYpllqqn626
         M3gJOr6Xdu6ctTzUJhdPI1u78I7L5LJ22QtXbALmTOwV+bRZ2lc1lwbd9QuTm7Z7RMby
         adxxPvF5f0wnunBjNfLSGWe7A8o4NQaC5lXvGfr+Y9MumEY+6nu1AnowuZ3lbklOBDZX
         PHLuhA61YDMo6ReivBc+6TwqqqgruPa4ViJl85bVfxafmebAm3T1pLzhwOdYd/UAtFz9
         ts1dIHCGmnUi8jFBVYAjvOHNyHuS5ChMwspN+EvNE79bLAb6ZYmA9IDU6LWcQam56cRi
         0Vmw==
X-Forwarded-Encrypted: i=1; AJvYcCXEfB8IQTDoY/MNgMY84NWO59MJhVPo1EJ3xUHOXPJDaASmueSrdbIOzzSjEOwrcln4mDHJ2RNcp94ShHejH00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx5NwX/R79QjYV6e2gYqapXkVqVCcU2EMfTWnMlCXRaLe5PJrX
	DOGq14C6l+z4jZtx5/9PoMLD3TjtUyvHjFoCe4WOfQ2ZmEtuKgdmfy98mEU2mbAk55loE+a4agV
	q
X-Gm-Gg: ASbGncte8+a5wEiTav+1RXUViz7Ow3mF2mWYjb13cLuPYYMApTP0+zs3PMWOigq1TXp
	Qm2RILzq8Pl3iczQT3Um6mkU+WXHMGPbMae0uGEKzfvrmTouPtYqLfV6CyMSJxFD4EYrJv5Ind0
	PZDyeyxyRveKTFGH+W/4Wgr3PriEVitpEhobpQvyHGSGgUPr6WzbfDa7vgj1oDaTOsRoGyg9LqW
	UYS7VB0Js2g5GzwW7sjgzLZgg+EmuULv00ZsKYWkXG5FK7BG0ekJI1ClmJO
X-Google-Smtp-Source: AGHT+IH9p2YXjKh9qdWSHXE+iUtKj8MI/pG4r7tSRsmfsK1vGrxYN+BzekS1qChz2l9T3F27QrGHtA==
X-Received: by 2002:a5d:588f:0:b0:385:f9db:3c4c with SMTP id ffacd0b85a97d-3862b33e5c1mr8913576f8f.9.1733734403812;
        Mon, 09 Dec 2024 00:53:23 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:53:23 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 09 Dec 2024 09:53:30 +0100
Subject: [PATCH net-next v14 21/22] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-b4-ovpn-v14-21-ea243cf16417@openvpn.net>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
In-Reply-To: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=W5T+iVYKaPmO/gOfKB0RnKXCUMfDvh3g/zI0cvgMIlg=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnVrAUmSZWsTZrSHxW0eF9nx/U37XlgjUXw/O11
 cLF156aAUaJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1awFAAKCRALcOU6oDjV
 h11/B/9DpBcicI3nmOt/Q4ST0qkqmgNt37hc/xvXzhZzFoXkc49s6vE5vGO+NaPlbg4zf9jo8OG
 Au983v1naB7Md4Fe8IUTRmtQAeb2ZW7TuzWG/8tSuPo3IRuO6hCE+OOt+y+WbCRMgoiQb4y2BkF
 eOWe/KJoijDEtKQM7oO/3v7wHC3JHYXTtoajy5NVvTTKB7XK3o6QmGZcFBPp5Re/17WVIp8e4A2
 0ReidfRFgqpuGx5+n6uZrNsg9vZnlrq4NqNB3Z01mOVbKojp8Dvj+qMqTJ58mydne0tEWplT7bS
 w9HhiaWHS48At6cRCyaen0x1gSMBQm0M5cOCX2GgHg2NaGW3
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


