Return-Path: <linux-kselftest+bounces-24269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB95EA09E0A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 23:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6A3188ED4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12F0224AFA;
	Fri, 10 Jan 2025 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CeYPtxEL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393121CA04
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736548005; cv=none; b=aORqhnDQzl56fM35TQyyG6vb0W8sRUp/7g5Z8P+AmOJdIZ2ed71Zdt9X/cQApSxx7H40Y9AuaA1JFn1ini5f/fjsVqGr78ftdT7iMS8w0YaIFu518mFaUhXqaKmh9l1aOaBEwpDpMmUK7xwgZmsx5DsQ/Sl7Oge8brEimIR5Kek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736548005; c=relaxed/simple;
	bh=lH+70+vbb8mzsnWhRaq1p07+gp3g/U0ZT6i44uGNdws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JCKZvcAcV6nCIzKNdWVce3DWMLnHElG4jdE4niQqAOhjFFuYhySG+ROV5Jj5p2DR1XjIJFI14Hb9MED/GgChuA1KQxtBA8Qw9nRB8JeB/1BJb5OFKzqbPSjEmCKW6tPSlTL3stkrYbIWELoUvcg19AcnHVMo9444HNlJjIgajcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CeYPtxEL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso2558535f8f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 14:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736548001; x=1737152801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6fd/nqlYwcpFBbPM1ixmIIbdfkkly/YsiIhiew+A3k=;
        b=CeYPtxEL9t1rG1ckO6/bjYcuqcA54BWGyVDQNnuyjBTG9JC91EM9jLTdnD8aaiz0Oe
         TMBIElBKJ08eanwb1E7furn+T/Bq8DFGtg6WjRHDFE8GMH3vuLasNQNGipN7Zzzey1As
         rvibcS8CrhIsXPRrW20Mwn6v5Aecw3QLXs/J+t5tz/8jXI9fh533bV71CliRO0FU6xa8
         KZ9LZt9PwEqEfDp16CL8mjKNXe3waZG5NWxiPE2S7yAXcSN4dfPTP71amEtjqjyLISTq
         oVEvDTSVUc62bxDvNlI+MBsIbpLGPds28w298esYrpxk9moSilxf6WwaSkBMxE6Kr+vt
         e/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736548001; x=1737152801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6fd/nqlYwcpFBbPM1ixmIIbdfkkly/YsiIhiew+A3k=;
        b=g5dVOarOxgxlyKVTL8vC9NO1P9PJcDjO9+DsvmUKs0KPSJqYq1KgHxb5hQs6KaaIXI
         lxsfVYdigVmkn42i+jm53bONMG1cnulrrkGLCHln87zGGpph8dog3eOYsriavuM9Yfxz
         iWT14L6HI55lFJ932Jla3bE0GEd39hWTEb1unPK90Ct0LNML9A/YxTBKdHKnGcoNe154
         szG3YYiAJz/qoOJuI8FUtcRz0jsEUAzvVBu1ezdq4O0KfRAPEJcnzQZUPnFpgNIwwnDP
         Jv3/9WwU7yGEIGekRFRImJW2qN8sVNOcO6lY/+sJwBr6o+CSSuaTfPIAuKCLyLUKtWFE
         UXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+CzdqRAZH1JRHqr33aQpJNOTbG8ddn55XKPVymo84m+Gj5ELmcC1PilHONV8iNoUtatDsjABkOe8GSiR5GfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWlRdPWGYILOMN/ApX4CtYYX7NTjpOd00R59jj9lwZWxpqhNm3
	+4h9F4tGt8FCGk39OUof9YegG9O+YFS8oSzicez0sUFQd5B/Yz4PP8ObyMaslhw=
X-Gm-Gg: ASbGncu/smE2tnNS4NptSupLKISw4uJ7BPJLizwo33ss07h3Rq4vzTE1O3O2N2uczOI
	9Bo4VtG5zYaY3YmUJak9YDWnW+fVXlhxu5dmyV+pFxG9U42d5zexJ7sRtgwuv91rv5+L0J86x2w
	6k4LirAFj7S6eGwG6pPYyW4nNfkV+uaPCYIieUJ7hEtKUDlEYKuBidsDUEBmPQ3dw6OVwvF40mu
	AYvf8rjZ84z88itpfwHeEKJmNbmtL7hJNoNdcrQEuOwQjn/aOWVNlx8axwcjty3dH9X
X-Google-Smtp-Source: AGHT+IHqa/7JGn/m9APxxIoy53kkIeu7Pb8WX3tkyRvzFZLU+Gf4LkSd//hZTw7zvM8QiSHTJ5uWXA==
X-Received: by 2002:a5d:64c9:0:b0:385:e88a:7037 with SMTP id ffacd0b85a97d-38a872fc182mr11452802f8f.6.1736548001094;
        Fri, 10 Jan 2025 14:26:41 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:ef5f:9500:40ad:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm5704340f8f.19.2025.01.10.14.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:26:40 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 10 Jan 2025 23:26:40 +0100
Subject: [PATCH net-next v17 24/25] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-ovpn-v17-24-47b2377e5613@openvpn.net>
References: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
In-Reply-To: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
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
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBngZ6y6Tlo2BOkxzvRedTUtQWToLe/UbozWuQwt
 nlWwFOhPsCJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4GesgAKCRALcOU6oDjV
 h90mCAC4iXmIx+mslj5WrhvOZs4tB0P+s8gkPMJhHoEznpc00YjU5OCUYZv2Ool6ZCNVqddiFUK
 uZPuPicvp5V39iPOpI0M8CT/o9s4AX3uQhRFUBUet/Pw0aGche4TfSheODi59meMzpMobBKedRB
 vYzQSxgT5ueMxqhjT9rNXjM6tv5OuYUbUTK7M21G5v2j/s3RJkhgg9AuEhXXriERwFC8KcbY8aD
 iyuLT67xUNv7gCxys/MMi6jT38v6pkcqJO957LT1W4WNAvsOYrUvCu/wzwu7tuCAhWMbeP4ryfe
 zT8M1876AWKWAzoPIJkaC2YPge+F0jluZKKgaXZ4RmYbdQgT
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


