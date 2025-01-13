Return-Path: <linux-kselftest+bounces-24354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37751A0B315
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 10:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFA01881D61
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E75422F14C;
	Mon, 13 Jan 2025 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QSUlFATt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05822C359
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760700; cv=none; b=PHklsJ3FTRFOjJKtD52kAxGr4Lx0SsX/DmrzuRDXaQIQ41nREyfrts+AmZSVw6LYMgIfvBiR1xgl6Vfp1xF0Cuu2Mxmp2403kbtD/745aIyp9YGFO0agRTvGDVPWfonhCFa3YG44kPfTPxtDwjS/NicQPcwxBFidvgGqAbtuOWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760700; c=relaxed/simple;
	bh=lH+70+vbb8mzsnWhRaq1p07+gp3g/U0ZT6i44uGNdws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=icuifSTBmDIsqrNa3F6PSD4pzYNjpJeY4xcnZxOTul1ih7Ve1PxeB+eWje8nRFyuJZ+HU2VKdJbl+RnEDLs46tdLLyx3DYPRaU4JJmAjxSta9VwdkTkS1hxA/S63iirsUjA/WaFmQiwhX06S17HiWASVb8RJsljCkGiYt69FBoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QSUlFATt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385eed29d17so1979735f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 01:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736760695; x=1737365495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6fd/nqlYwcpFBbPM1ixmIIbdfkkly/YsiIhiew+A3k=;
        b=QSUlFATtDuFS01k50TzXy/2VcOAohtTD9JJuhcyHKGNhMR9k4wObQb1jE/+n409qnq
         TVaPSu64zXws756g4q6Kcjy20UBqDItA2XLkx2ulB8bQZWn/qwyU0SY4UMahFjXLTHzT
         5JWAxJrIaWygTFFcgmsk2yi7TV+kpa729tlIUTjiAm122iyaI6G58YuvsXyuBfzvorGC
         LnMU+mGNve7EYA1nGNFhmVG5ijtYrwSylWQnI8kkZ2s/FMIpnY4HXEJ+WKp22HT7x+6q
         UNuGjpGw8tJOKx6XwKGbL7ogxb8Zw+u/FS23FQMVXeMa5hWOVIzj/JixHRKbsxEC/pws
         rwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760695; x=1737365495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6fd/nqlYwcpFBbPM1ixmIIbdfkkly/YsiIhiew+A3k=;
        b=cuDlhkyDLBcBLhIjdgqBREy6AIn3IkdFVke+lHOlV33SSEqgjRKQXNp8qZ2w/7XYmc
         E+7S0zVgQPeezaLDNPQAEgkSxzyErjpG8uVpKrXBmoJRoke/4pVuAOsGKisv4tMghOM+
         mZo4Lbiirbc9KVcUoEtjzKBlQDbIHxfRv6RWIgF1dBGHCZEoVNeVtWKqM3XLBVbUTZAf
         3V9aSYrCg8tJ34aLToyWHhW6p/Nj26YWhfD0wg5oqKlSP07Q/BMH65UtQmnF8nJPXxn9
         VsZgQ0EL80PqEMTNVYMdV7KVrkuSuaopALOMvRDgBDkuhVX6vGzGIEZtj87dQyaxYk5/
         N0Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWOA326KlThrbUodwpKm4KP7U+gdl6AD47yAp8Yt4CeQ5hDsHqx5u55PaBe0DZxCZWbtHpoPcR6HYbNxIeCIBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfiyCz+rlO5aD6IucmVW9G9Zj+xWQ9LGj0cwgDy2RIAgjefI6/
	oSlFDYasp8gyE/FfvSGmt5ZfNhOYFTUZIYSVUInq0lAMXkQnFO7kykQ2wmhb89g=
X-Gm-Gg: ASbGncsem6IgMEi7feLCspI86pQQWE0LaDVpTXRLhJUILDD1Zl2MR7Pb6TBbMBswo8L
	qYcsU6CA2sUeXCEc2GSiC+oRuSAgodRrb13vmQxkYCcUzrt0NNMZ7upFOCHHrbQq6n4RPy5wl7a
	RTQ/IS8GSjaf5TczNBRNLiVcW/gc4zVmJ9cCENErbYoh140QOiW0ryGpDjTOJ8n5c8ZEpOEYgf0
	2/KouGTjTuDOQTuMf7LQwmBu+F29+WSDmLk9vsPZCejy0F7kNkMXCaTh+g7ShAlLgSq
X-Google-Smtp-Source: AGHT+IFnYuKATGDzk/g0tVvJCIp+jLG0KysffWvfrovAEC12PuWQhJ6r4TjXquD8tk0L7eso3bk3Jg==
X-Received: by 2002:a5d:6c68:0:b0:385:f9db:3c4c with SMTP id ffacd0b85a97d-38a872f6cf9mr13568917f8f.9.1736760695459;
        Mon, 13 Jan 2025 01:31:35 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:8305:bf37:3bbd:ed1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm11528446f8f.81.2025.01.13.01.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:31:35 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 13 Jan 2025 10:31:43 +0100
Subject: [PATCH net-next v18 24/25] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-ovpn-v18-24-1f00db9c2bd6@openvpn.net>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
In-Reply-To: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
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
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnhN2IMz2/OcAGDKnr4nEpPW364OOcoWb8fP9aM
 viBw0xdiqWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4TdiAAKCRALcOU6oDjV
 hw6aB/953d61YEoandxz7mwYMWzGnSzy7mFQ1nJFYqVidQs2YGfYAi3KlCATiXrzfiPRoUSfGEv
 P5Gb5Yx5rpcz4YcOrbdKBiEMQuS8Yq7XatELtwfRYOONvjxSN1e2NDahneAzpdgey42T2PFrGD/
 un8gL05jFE74zqY1DtV0m/9uSTp58OA7OeFiRQMUDmY6Y8pzwcAuOMGx0BkLKPagKnQBhCJpYxZ
 8Zr/hiM3CD6MuE5mjclbT/nNHCoIgosCr8hegYMky016EUXchllMMBcqwhvif2UiD184KpE9jJE
 bTkB2tB1QP1sSdZcK8oH1xGuFEET54Tw8smJ/AFPgpT36ILk
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


