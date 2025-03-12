Return-Path: <linux-kselftest+bounces-28864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5671CA5E5EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 22:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CE717C92B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BEA212B1E;
	Wed, 12 Mar 2025 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="e1t+P6jG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D520F082
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812900; cv=none; b=ALGO9W+VlVRozfA4LeUNZ1si94jaZkRmeJzI+9RTkYwsdn+CH3gUSmNhoGLOZfqszqglsWF4KgO6QvU1If8sjdWri7kIK91uuUUTAxZY/wniJoh87rxoyRYqF0LdTNBqGUD+bzdTbJtKSoDJmWJZrjB9BtvVw4febMffG33Dxzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812900; c=relaxed/simple;
	bh=Dpo86dcLuQHi+/ffLApLvGiDvMqBLBDHjZmNUI8Fgv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUIYEkjBWRO6VOMnUadjvq76huunSbOt+xZiqtmkqPiG4J6z0C6E6vmK+haNBPQvc2z49bFfnAZPoCLTaOpvs6sJkt3C3QyD9K1eH4K5xytQ5nt7f0iE9FjqtChE/WrfqELGARog/E4KTcGqO713xKKoSjeQ2XTalXZ/5e9O/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=e1t+P6jG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so1757585e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 13:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741812895; x=1742417695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7513MgPTWzlFUV4A94AszGTBKoC1WXOdZLnItud/+rw=;
        b=e1t+P6jGl3wMF5FSlXvgvVF0Iss/Fc8mWhTMw15HmWXgDLwOhM+QcYDHI0i0KdmTDv
         SQYcBokGzwM8tJ7YVp1g1umE+IUZblWjzD8J3t+BnOZH5dr9MYgCkar+oRDuGIGe2X+B
         aSVhBMNTe2R7jSrQeMFM25r6jYcePuibOgXLMmZTslpjJa0oFb+Wz/XkPr2JsygTGPRA
         8YVgdN3ESySQH75pyfK04wlUuMh8D1Dr43WL/yxFn0hgmvE1NwEd8E4zy31CyThhEcPS
         6UvqAONpfryfjpO71kgsIYQfD0FWwUUhnLmf3784v1miVbmIbty5gGmeivVZjZQMXtlm
         XLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812895; x=1742417695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7513MgPTWzlFUV4A94AszGTBKoC1WXOdZLnItud/+rw=;
        b=tjkFEZd10Bq/zK5xq9kAVT7Ys0yC5FUIzbMGpYLmWNxp1sL2aaRZ2lwQEHrYO6TTuJ
         C8h/mpbH6Mx5RLa3yH/YHXxbJzHmPrq9ipf7zQZb9WkPeRk8xs9yACYFSxvwkvPB6/hC
         SxQ2QDASIW8FzPqOPRtZbsx4pPbAJ8lp113SAFpU7Tfixjl6r6lM3/ZHTzhXtzbKWXqv
         /Bfuc2BpZOT2cWzU1ULKBbQNy4SIrOfhniYiz4ZgHkxNwd9SqAIzqqo5FTtQ6GO4/9RD
         ijAXuSpXSJRYE77IDtPkEE65u3ZXPR+ZjNIw0YYc2UlneWBQnyDeRDS8o4QHj+wxxuF1
         SVHA==
X-Forwarded-Encrypted: i=1; AJvYcCUaCC3aQd0SQAEcDcENR7LfqHsl8litHVEcPVvPs8+mQ9l9ydu6YfsKZmprMKeCYmVjpzknJPlyxDgynJOBbg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDnEUIQWJ4H6/K/6brKhtu33fCcKwZ08kmFSC6MbGeERT6xVQ/
	9inhCQ8M64ZJJKDEsYVzkbn6DOTqvfDzUTtAmr3A+BS4C93cR6cl9bA+EPz8Ec4=
X-Gm-Gg: ASbGncu34GsNv8gl+tHG68U4ooNLvhtkyjobqosfoSoW4N5Bnzx78iSrcRIhdMDJh3V
	lsMJxkXlH7IkKaXmElFdi96GTzP5RHofv1Z82wm8lltr+PGHY75G3ahle0MqAxNN2auAH4nBLE/
	t2S8U1w6CfYixt7wnerXbWU5/S3jCZr37V0ihNhmB3+vyKAzGM6UOfYno6q1d/vl6K4ZiLHq6dd
	Mn/XlORugH6K4O6Z+7kjgPHlIWgyd7juFwP7rANp07VypI2JLaXlexlY6mQnUgx29zpajQJCMLb
	ENZpQGMjBodD6wFNrh/gU4Qh9VYGPpfjMG1B1e5DHg==
X-Google-Smtp-Source: AGHT+IH/kshgwzxglJPwKrAa1snS3ry8t4cWbkAAgcEd/xr0yk1+5VRw6rILu3zf7gRip6TZlWajDA==
X-Received: by 2002:a05:6000:1842:b0:391:2d61:4561 with SMTP id ffacd0b85a97d-39132d32074mr15972310f8f.6.1741812894759;
        Wed, 12 Mar 2025 13:54:54 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:a42b:bae6:6f7d:117f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm22481393f8f.99.2025.03.12.13.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:54:54 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 12 Mar 2025 21:54:31 +0100
Subject: [PATCH net-next v23 22/23] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-ovpn-v23-22-76066bc0a30c@openvpn.net>
References: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
In-Reply-To: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
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
 h=from:subject:message-id; bh=Dpo86dcLuQHi+/ffLApLvGiDvMqBLBDHjZmNUI8Fgv8=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0fR8aqSB7lx1HJwyJKqqQs2g7lFa+Z1BOkSus
 EuHYvqszTaJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9H0fAAKCRALcOU6oDjV
 hxKvCACkR93Kaizq6szy04ebmeFBuVC792qFUfBO/SrBK9k9STsuN79Rp5V9jCLB5wA+W0SEC8G
 zC1TWi0YYCW4MuRB++3yCv7IV3CAusX9vBondr6Hqtk3WlofpPGiS1ZViUGukDZAs87G/pME0VZ
 bWQVa7ZL1/7NEr6/LW+B3WEL8sBxCO+MEH5+6Zmes+voybxNntW1yeUlv1b6947ot5PATcc9xYS
 rLZrmbk72va0fCnzsut3avujRAEBXXF5gUnySFUNQK69Uj1eT31WRa9zxkcBRXoAkSvw/npDwCQ
 ZxTVEwY+b0vG7JlL9qK9qSXM1T2BIjKL42NY/aCgl0zzNHuf
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
2.48.1


