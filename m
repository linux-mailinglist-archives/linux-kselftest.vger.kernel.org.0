Return-Path: <linux-kselftest+bounces-28731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC87DA5C056
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE601678EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 12:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E1D25E806;
	Tue, 11 Mar 2025 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WrCpLdFW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FCB25DB16
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694621; cv=none; b=ey4ugTD4250oNz9VoIutHMDeNaV2+MPSvuf1C40GNHwZrUpI7A+4lSRYH3u/xcl9kxasDrTDDCgAYJ0P2TBSFvZbkKrTLa4h1YTF1jgz/ZrvZqwuKIfqm0Fla9EX/lMbOXR7Mud/i1gBnUI30WmbPScKl9ktGO+nz4uj007HhEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694621; c=relaxed/simple;
	bh=Dpo86dcLuQHi+/ffLApLvGiDvMqBLBDHjZmNUI8Fgv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rPGLLon8eh2UJ9jFyJnMpRgtYSsmGoGxyHLY76+x96JnD1l0DSaXfFE05Ol8teH6MhIgmeAyx1lsZxBISij+GTW19JVYJC3+0+IpWmmGMHmEsBdFNfUqEsZmvFh+NETNDsS/1XsmATon8JYxE2AV8Drq4yakT8zkHPF8T1KWn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WrCpLdFW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cef0f03cfso16354205e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741694615; x=1742299415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7513MgPTWzlFUV4A94AszGTBKoC1WXOdZLnItud/+rw=;
        b=WrCpLdFWBB9YB2n55gPleyWijfvLWomlEGhlOom4kVCz2CgSajLelpV+fu8WgmZXEY
         r2tPF23bEBaohTPdy6JNUWnDnEDDtwm5UCrk5sRogrMkx7Ni69XwtGGMy9EkNcBHnwry
         eHC8mUVY2tuZmMKoJvIc10r4xS6Ra9Sd/CH0y9WfiN/+/WFGBN7dP9tviBBDA+AZGJU6
         MbLj23x5dgO5GGu7yQH2QlMMOTKZquZfvaKrnNOFHtXR6zeUxmENKXKLuebC8Zgrhu6U
         aFt7MBqGmx1uA1RZGQx9D+LMoxAEdS+pI3/54jjnuLS2WW7fiDAmhLf8eDCznhWCaVbH
         Np/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694616; x=1742299416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7513MgPTWzlFUV4A94AszGTBKoC1WXOdZLnItud/+rw=;
        b=If/cmDd5sBiWc7sH2TK/lx7NocdZgujEa9ljWJRiBOc6HVpx+nIO1irsx/dv/kyPyE
         L95b323+dqipmCoZTCsEO5vpxVNZppNN3IjimlfJkf8dSa/oRwaRscTT0vapoyc/RXBj
         5hy9rZVv3iI7SkOvLi9E4a90lJsNNQkLraws+5I23cF0tQJdGFIZ/zpO12RVvWAwqvdo
         lrYwz2Kei9wtomNY/+wCnCRk7Fpwzh6RFc09kmzqVUjy1RTWA2NE3pSjVjWAdhTzwPbY
         60YXbAxyElrKRwmXDCH+xZ6zlQGxEPTr2r057gpGbeUEfeg8a8+hMQ56t15NPKozdocs
         Xz/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyaL52tU9Z3HDlecniJsoyPOF/vNydBKpYvnc26DQOoEfS653AWZWj0c6bcIrXmYJKecbhWVvDoIj5Y+kTXtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+6E7FiIE99ljnWcGNlIPsgJPtl3tZuMSMEMXMQqoufL/DBwwC
	FEoB9xeMxBjiQXHqqt5c23zVrg6jUqvBf8pq1rQf1w6USzkOdE/TUJ97Oc/uALk=
X-Gm-Gg: ASbGnct8b5To4XCsQSl8zVlY7lXp/o8YichEUVqJ7pM5SH6sURGmKvgt+IG7zQuQRJ9
	dT2gFBbVeCd8JevZ4sflG/XyqTzWkDk1xVCpXKc1bUHfMfMDpO1DTY33AiymZfnsdwyAZnO7wCZ
	LC4MHWzFHnx2LKTZePhXMgnrJ+hDAj9GZoyIHDA/fBbeDtDb1fsSeuexKS6A6Kn9KAC3nzm6oDf
	3wEVlscU6SwflpQpLSbOzbU2NSuduG2VqogL5vHNsQuawWWFx4INAVts4CmR+68vZOJf0FImpXF
	CRHYIyFEBdJSt6ZJvG0HAZMz0C0KNXlbZjLSH2ey5A==
X-Google-Smtp-Source: AGHT+IGREqbuyoImnYbgFjJhW/d0v9jo08ssGpVpZNRtricqNFqqL69IN1VockK0XBdDiOURgseunQ==
X-Received: by 2002:a05:600c:4316:b0:43d:35b:9a74 with SMTP id 5b1f17b1804b1-43d035b9d3fmr29016675e9.6.1741694615460;
        Tue, 11 Mar 2025 05:03:35 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:52de:66e8:f2da:9714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceafc09d5sm110537605e9.31.2025.03.11.05.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:03:35 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Mar 2025 13:02:23 +0100
Subject: [PATCH net-next v22 22/23] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-ovpn-v22-22-2b7b02155412@openvpn.net>
References: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
In-Reply-To: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
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
 b=kA0DAAgBC3DlOqA41YcByyZiAGfQJnGgkRGfCkARtacCijCtX2FKUpqIfOp3qofnFhiZT/zJL
 IkBMwQAAQgAHRYhBJmr3Gz41BLk3l/A/Atw5TqgONWHBQJn0CZxAAoJEAtw5TqgONWHiNoH/3Pc
 rT7PvhT7gULcb6mztxX7KGJ0SDYr1EO+n20tCgscmoo4f2ltEo/vx9OJhEI/VAZuFL7qiP8Mhz8
 hQO3l0KfkHEEIeK7WCWUwl1psJpjfl0hqyZvX8TVconxgqNg44H9KMpo7fGKmI6CPsjhZESm/BL
 +sTxNW2zXF10+VxmIsh/2+kGsgbCiSRJUGwz+Eed/2Tk2NaHXWUGfpip+rTfZYeJ841hrUKoHMJ
 /XsnWJ8JrWV183PK03P1OPYVgKbTKEEDmIDaz5Mz/LmvQaooB7HVVKHb4a9oLDFOxwbF9+FquAI
 HTo7vmab5rF8md0C3a6fYNQna0Bb7yfaU86boBE=
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


