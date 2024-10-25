Return-Path: <linux-kselftest+bounces-20650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E8F9AFE05
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77174286281
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E9C206E6D;
	Fri, 25 Oct 2024 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DTsUcWbK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57DB206950
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847731; cv=none; b=m+zhr8p2Ma2AjbKMskOTCP17b6EMhFlr02wiaqR4PywYugefldYPfuLMRRXM0E8SNDAH5cI/WzqpHPUfNxiChgBEx1RwLHdl0rNhbMAWnS6hctQXhVW/aIwW7yb0Wh20DTpTgMnVqivxfl/raDto2E+3L38V3/aawKKWh21S7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847731; c=relaxed/simple;
	bh=aDlod1jXavu2K8KnusK1u2l7VsBsilN0fz8PvjNKPQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F5pfikn9XIOrN2eHdIb76ZCwGnM0ap40iwaqJYgdNOYCfk2DMBkkQpavpMwe/BkmMMV2ZOtrcD08bdXbggj4Cxjznrye8W+A8c2OBHps/rKxJYMtC4XVtdUhUlMSnYQ2a1CdwVzoq6ql2i1POO5bd1kM+AXaMfRFL4NPh0iDXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DTsUcWbK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so18311595e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 02:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729847726; x=1730452526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFaxyOK2oGzKEK+1blmMTfwvFfOfF/h23u+ELvVQAZo=;
        b=DTsUcWbK8GITfmPgtNZwnTKPzBiemYBGybGbjl8Ev3Wb+GH/pDEeh1DP1mbwUdtwjJ
         OVjrchAOv58aRMc0Wq5WZFSEmhruHOQkTaQW2WfOPN2dP+ky9sjnCaHO7n25ZRDMT7Wu
         Z/cMm0oz7gYumKLBc0dlGaUmnx3A6z37sa9niNe1yhcgBshWj9a1TVz+IOgpQqriX5Il
         7vkKXEwAOjbavHtzGKF/hVRPpGxNidyxE76oeJWjj599/PeZKCG8c5Sr+uljx/yPYnmj
         11JOODQuiCckKG/pkaO7AoOcfv6rDwuYO8mvBu/1mfpWGtFJlhQXrwvI/+wvvqljUeYb
         RlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847726; x=1730452526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFaxyOK2oGzKEK+1blmMTfwvFfOfF/h23u+ELvVQAZo=;
        b=H9HeLdyyA2bZ40B30VGklZVxQxR+ey1BP7OgwqmNGsHpMg/kHh2fOnWHelp+Bm7sta
         Wxb0UFJjI4IA84K8M1RFMAIFMmPhF1DqOoh2DeY2ocijgUotPZicrRZzFkFUudUSkJUF
         1angQXJulXd6wnY3OIKMjKHLmBKW0jgEEc9L64GVC78jA1pYvBvVufv2xbL1RLFTn6UY
         7s9B5U9MPghxSrPJGpsfykO6qb39AK5JOq1R6fZldqHEeSVH24tRFyM+bRTuaDD6MoL4
         kmk1ug6YIe+oZ1gkjkKgzCyKBg7/vB7P/ExqqmEadhHQNKmORLxeeJHftbOaLivZ71fS
         fp4w==
X-Forwarded-Encrypted: i=1; AJvYcCVwvfR1DDo4dmLcBUWe5P5GUePXm0zKBUnSDp5Wg+s4Jfh47tG2VejOcpmmgwMcdUokjmOS8ApjZLL/8xX7iPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiShTXbM7KNysY5ky4i+/0Mr25M1wL5Dc2a1JyBZ9/FjybQV9p
	58rxHe3haHDBBMqAhjy/K02c5ywkpBQ2sHZFVsYgcsydC0yn7mBePGJrl16dO6c=
X-Google-Smtp-Source: AGHT+IHdZtUJpbG6/D6BbBuUi9ffcO8PRYN2TCxsvYQIEaXjaIyVonX5TtVJ0mNoV/lY2gLvd5YaSw==
X-Received: by 2002:a05:600c:3586:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-431841442acmr81999675e9.10.1729847725939;
        Fri, 25 Oct 2024 02:15:25 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:676b:7d84:55a4:bea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f484sm41981485e9.13.2024.10.25.02.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:15:25 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 25 Oct 2024 11:14:21 +0200
Subject: [PATCH net-next v10 22/23] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-ovpn-v10-22-b87530777be7@openvpn.net>
References: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
In-Reply-To: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1706; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=aDlod1jXavu2K8KnusK1u2l7VsBsilN0fz8PvjNKPQ0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnG2GbmBVzq6muocWMzSMc47zZXT7dX1O3Oe05h
 o958FVl6lqJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZxthmwAKCRALcOU6oDjV
 h2GzB/0Zk8m7YtfDOkyVEiLgleokTe4+p9IXU4buuL7L1YR76/Zr8zTNJnRq0bgYo7uMNMEYE7r
 jFDCP/3/SloBFkX1p7qPgnuaK65x1ru067hDuphpATt7ZDBQ9CPSKNYyy2cIHWWy8rbUi3wzQwe
 vFjwHvWRbPE7A97akN7FJ+o6qkaU19XDguL1y63NM+bjjD/7YTa41TQPOCQ0O7qKJkJyZ50B2J7
 fhFhEIjlgUVmHAyOHnKdq0MjqssVDrvHeKxH6kaozkznVYd/hnchD/Kgq++KU0JkEZcS5QRBceY
 HN8GnFrq/AGrdDtl2OLi8TePt/+h3JZKcZ3ayoxTv5q+W1W+
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
index 1bd563e3f16f49dd01c897fbe79cbd90f4b8e9aa..9dcf51ae1497dda17d418b762011b04bfd0521df 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -96,6 +97,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
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
 static void ovpn_setup(struct net_device *dev)
 {
 	/* compute the overhead considering AEAD encryption */
@@ -111,6 +125,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 
 	dev->priv_destructor = ovpn_struct_free;

-- 
2.45.2


