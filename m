Return-Path: <linux-kselftest+bounces-22937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F5A9E7A9D
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 22:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0A728706C
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 21:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A140C215710;
	Fri,  6 Dec 2024 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LBA3MTRP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE2213E9D
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519930; cv=none; b=rzw15miQnrlVoaMqwBiejT//Nq8hVhL0vTuJCzMqkn/jvBoMXTqkj6qDYXJhWtpXAbZTLPRRhqCW+MyhomnBopZU6gEeBTASgSA6Yl3EQHeZgJ1BfY8IU9sYITJ/zzp1DNuF4cDbGwiWKUD3vW13Gpm4Qc7/63KF2s2+4XL5cmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519930; c=relaxed/simple;
	bh=GchxL43RZVWbeeTak50ypiKEh4su8ul45OjPZ601Tf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G+K5eZD9r/Bdd4+hrz/lhbr/TL3ffLFcnsm8cxX0xi9gd2GwwpAv6FCOBvbiWmtPZOGjr4XonfR8x1jJIk2/eLcXuUYQgskd26sCp6YqyGWu1J6HuGqqi9YHLmi69fYJg3BnyexYUw9CK5CD3PKWzWXDnBXbofHi7I8uf6/sW78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LBA3MTRP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862b364538so706040f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 13:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733519926; x=1734124726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFk85mO/CYRQjFZfRXq+/JqMZn31zCiBs+VMv6XbtEo=;
        b=LBA3MTRP2A1mba9yzx7Aavbgg2wl+XDGDXQtPkEks7cCQTdvqqQp24zHgEoGrsJZcJ
         +ELwSgV5wiy2i8JvgnT9lpYsNY1IJNKJ/EVcpUq22ULvdePW32suo2K07/CV149tZNkc
         itBaIopwxHPxLIGJm6oCscpjSsWmy7QznTDVhwq9uTZ7I03xcJm6u1Qw9VFAlxfpogy6
         WByJZTUk6wP/DrFPgFmNYWvPthSmguJJZbZwED5Jvj9k3a48RB2hPMAXAs60mTQFWZ1/
         sn9EP4BSkHYrimCcLOuJis3FgLJSfhlhIpcDG3tzUnwBJt/p2tbrp1HglQQHSQP8f2Rm
         u17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519926; x=1734124726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFk85mO/CYRQjFZfRXq+/JqMZn31zCiBs+VMv6XbtEo=;
        b=CMSjPdra0LIT3UUKpABtQgfNrH36SFn0JBgr72EJmJkB00MktYhcbVdIhX0j60rTd+
         iBJ2hM74aLO80IDAGvkfGL8zAeM4u0GF8lLym7icik/wzQpJ7HXSYIu1j7vrV90i4w7b
         9perx75bsvVrcjgp/6LrJ7qBWb9frJQ+LbAVvcG6n9uaHwGkkuqhJgdsuktIPGoi2CJi
         8N3oqiKYQwVcNlhZNwwcPnubaTqEg6TYwu6FLT9RO01CWF8ya6FbIEhwG9djQv0SBTFE
         Wtl1tRnbRzHqnU7UJ6jyvWmSm6WF5H8FxAT5MieJPOqcIf4Xg6yAPOq7b7Uyr/ufxNtP
         FSNA==
X-Forwarded-Encrypted: i=1; AJvYcCVXMHU5Or5s9KI3RWvfqypMJJMm+cuMLzGVFlkKhL13z3uZpFPSCY1PeQSyN6xanh1oSYlWdNfrK2h0kN5zIgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVO8wkrg7rpvc/D1poaEdk6L4NjzczGtBlEEYeMXy32fZX8Kld
	d2EvkM2cfkw2tW5v8rkD/Jp2KYnIteBNgm96j1VjU6qiQMKAPGpYrVUghxnZEIo=
X-Gm-Gg: ASbGncsxifgMU9lqcAspqefhRcJVEujTbmEa4YLtLpQF0TthtwTfCRCHcr+J0xZ8OIq
	r360ZPt9vXm9sYmg0U+FHbzsJpS5+FOD+QECQcN0WXEBu2zM3bPUvgYaBl9y4sXh44bY4V/DDJL
	/qFMkRrawQCWdmrcWfRWhVDYgiQOVZAlOyXzvU9E+BF7/+NzrO7YHxv47Ujx96ETTWTJYLZ7N6S
	eDXFZGVz3/XkxJztQvFW4imnaypdSuE01tg7sqRCy6k8Yrl1iVjgC3Yw5Ry/w==
X-Google-Smtp-Source: AGHT+IHUsdvAyWqJPVAKl7jOs5TzBkWGH6KtGirLq8aqrQ7ZAG20cdsCB30PaaxnoMvPwl9sd/fq3A==
X-Received: by 2002:a5d:64e7:0:b0:385:ee85:f1bf with SMTP id ffacd0b85a97d-3862a8b530bmr3599570f8f.18.1733519926532;
        Fri, 06 Dec 2024 13:18:46 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3cee:9adf:5d38:601e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46839sm5441302f8f.52.2024.12.06.13.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:18:46 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 06 Dec 2024 22:18:29 +0100
Subject: [PATCH net-next v13 04/22] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-b4-ovpn-v13-4-67fb4be666e2@openvpn.net>
References: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
In-Reply-To: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=GchxL43RZVWbeeTak50ypiKEh4su8ul45OjPZ601Tf0=;
 b=kA0DAAgBC3DlOqA41YcByyZiAGdTalai8Q+QlxElg0MhOKCgGmWt1aDjjnegsIK2Usyi9ZbmX
 IkBMwQAAQgAHRYhBJmr3Gz41BLk3l/A/Atw5TqgONWHBQJnU2pWAAoJEAtw5TqgONWHrFQH/jrY
 9qJ6rPDV4RBTeJEUqV5dO2d5Zp5iWJ7nZ8F28EojqxTwTIj+zSuYdI8flXg+CnVCoXqXXD7Soq0
 eKmvNNEPhr1gaMSc8ZAL70n0VijdDqIlevOrQkTtP7Y3gybUKauvO6+WUrV8hF7XypvQT5Pe+Hz
 3d2itjfNO62PH2VjNRK5iMwbXNg2AdduRC5NDaXKgNsq6FPyW4//RVloRsJvxL8lEdFC8qKD6i3
 OP403lW3dNva5TToKo9pMERO5JU9AzvhBzd3nIavSE8PkQaloyViIEnce7t1ZxoOvjWXj0q38WP
 4sgmb+uA6NH83xlpcsmEnZNmmN88vP2Ejd9a5EY=
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 60954c5b2b9254db1d24d01ac383935765c7ce5b..274d6166741ef2d6275a252d0c042bc66f8f41f7 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -23,6 +23,15 @@
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	/* carrier for P2P interfaces is switched on and off when
+	 * the peer is added or deleted.
+	 *
+	 * in case of P2MP interfaces we just keep the carrier always on
+	 */
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }

-- 
2.45.2


