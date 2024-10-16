Return-Path: <linux-kselftest+bounces-19812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A9499FE05
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 03:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E231F26D3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 01:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CB51D2F43;
	Wed, 16 Oct 2024 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Pdy7d+MB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1451D27A6
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040670; cv=none; b=LU+q9B6YXpxRveS99W7Viq++xuBiwEnKRviAjW7kBTNOCxFloiJfGmGR1QOzfeB8wLrtl/pZr/jz1iR/sUy/2Rd+naJe6CpDBxbcaBENwaWi72zGMLc8NptHfP8EXcJSrJ8If2glJ/Sz0Be1W4kh8LWIWh4J/5NsTasmNtbFt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040670; c=relaxed/simple;
	bh=aDlod1jXavu2K8KnusK1u2l7VsBsilN0fz8PvjNKPQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PlPMzTsfPvatAC9km6jALNiMq/VHsWhvkRp3rAvWFeyG2NUX0OyNbF5ZCyORs6klhTDo9rQrt/VZFDji5q8GJxf0wYIA7dZNMSEMrWj7Hc0Bwn3QYuMkssqbfnvdlikslBeICC1WvnQcZhTENSL32AQ0RmNkCVlWxqiNxB8mnD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Pdy7d+MB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d6756659eso2018742f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 18:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729040667; x=1729645467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFaxyOK2oGzKEK+1blmMTfwvFfOfF/h23u+ELvVQAZo=;
        b=Pdy7d+MBdHIzPm+Z85u9Nr2SLBnkGqZPEZjBpU8X7hIazMm1HESPBkks/pOb3xpu1R
         clmBJpW6HKeqHI1PyUoOoJt8XF/PW9PNNnlCOaLZXAgwGKg2xmVI0FDa+lxi4YqfZYAr
         ewQXk+ExKxZKkCwTpowNmCE7yENRXBYn6t+nuKKJw03Yqt88He8AOOzKqbfeyomLcwQN
         Rk5DS8XzGbK1d6VHR1g62aEzbj/iH0hVNSHHwach+FzcduAN6ikRyxSiOQtQAWq5uQrU
         G7m8PTPl+MrKADwU16n9sA0ePQPBLu+PJNFKehK1gNf3thgH3ZCF4mHql0S9ln4Vy2ll
         iKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729040667; x=1729645467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFaxyOK2oGzKEK+1blmMTfwvFfOfF/h23u+ELvVQAZo=;
        b=eLUc8kDCQKmIz9qUmRfAj1HArU2wzBwE+fVwFjxCs8SnTS7w6kebcJjZmGvnFUUISA
         ONXDy45p4ud89L+uPUSxaztdyiIZEY4WPmoUSuwAtTViM3MWR3TiAkUQ7PvCGiVfMi9O
         JyH8IeJm9kFoXozQ/Va7OKmXxXAlrjUqATOTNOUIzDzUJwp0FslsZUnQbBOy96SBFkl0
         c5F/StimxoC1UHpBcBDZciE5dsmUmMqGD+0pffBJzXqCIqmDhwb5TWJlrF3Z6FEMG2Ng
         1ESwZvOvS4Q/M5M93C6Tb895u3pfP3fEyc0EyE9dC8auX3zEmBVNXjxECxe8QV2dSFlH
         ptfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdAEHz1AjV2EdMKJq4dCsBY+Aol2VXs+LIb2rcd98kLEOaqbrdlRN4ZX0vcOu7ri4JDMfMfJ8qlxxree7lQq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyix9C3zVMmzNlgvDVE77GSmEAabLdscrnX/GgPJ+oQl6yBNwCc
	pCbmVV2DpxNpsaqjjNYG9CPtIsKOx+eAsFWdLUHM7UV9lMSJx4bPfdjD6kZmPzo=
X-Google-Smtp-Source: AGHT+IEeQrMz5VPvQXB8uM1sFWvNYzDnZgeneeGDqyLdXgZIJF9ZIbIUZhPKVCZBmiIUnHvJxWs3ag==
X-Received: by 2002:a5d:6584:0:b0:37c:d20d:447c with SMTP id ffacd0b85a97d-37d5fedbd1amr8390727f8f.29.1729040667008;
        Tue, 15 Oct 2024 18:04:27 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:4c1a:a7c8:72f5:4282])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm2886765f8f.25.2024.10.15.18.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 18:04:26 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 16 Oct 2024 03:03:22 +0200
Subject: [PATCH net-next v9 22/23] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-b4-ovpn-v9-22-aabe9d225ad5@openvpn.net>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
In-Reply-To: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openvpn-devel@lists.sourceforge.net, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1706; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=aDlod1jXavu2K8KnusK1u2l7VsBsilN0fz8PvjNKPQ0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnDxDxI4wc6zllOLyTeDufX0RnRgxkRZvYdET+M
 woNTxZVGZWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZw8Q8QAKCRALcOU6oDjV
 h2xjB/96RUwBLeg5dJNth5c5jJYkjMWBCotASXoVjETUDB8A0ShnK/xmgxHlQhL0viXIly76GfY
 6WbP4SXAdRmvPqME6hFk7qSGsbV2EJLrZwN68M7K1h9boR4EWTeFRm9dBAGiO6+Kc8gBnnmQNjH
 HY4ZzfMDO3+mKqiJSr7YJoLXDa82JnucF/b/KyEljJ7eE+UakfrTSNDFnq7Xw9zhL3B1+4ogL03
 f7k4oArC+EmE0cHbhhD6n2dwBiXQhfS55B48xJm7I2WVqHykGick4K+f+aqZ4ZNE0Ew0yt3qoSL
 tnnTp3JDXZmHPn7xRgLLkgwp3u6Wd9rO2MEvtHkqtOsvmEIy
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


