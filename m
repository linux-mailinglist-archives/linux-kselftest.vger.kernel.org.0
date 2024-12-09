Return-Path: <linux-kselftest+bounces-22975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1529E8DEA
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4ADE28138F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 08:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A3421571C;
	Mon,  9 Dec 2024 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EOYT8OZu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBF321639D
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734389; cv=none; b=EuyCA8O8km2Yo7y/PUj3/oKDM+3tEXlTWxcNshKjvCgz8tqvSL7uFL/gbWGEv9BNnjC9uwktcgBhVFbCrGFA1zN7pZcOAqNXan9FJ4D4PAvy6MsplsMfwOD6LEwrlACibSKJI40Pl7v05Xwb/gtLSwcv49xtvF2Ygjd4zfEy85M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734389; c=relaxed/simple;
	bh=GchxL43RZVWbeeTak50ypiKEh4su8ul45OjPZ601Tf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WlEdFTzv3SpGDbRwKzhDFlhwu6Jac3BrvTUDSN/W5OvKlHQICtb5rmg9kRnVd2tlFDBadN87GDDDYpEAdt0Re5llX7yw/yGf5QGSddN8OIqS+H8k+9Z0fLOwxQFWJQVTjHh0JRChmCPJnwsKkqNMFqKPHpDq9s/J75/vi+fi8Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EOYT8OZu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385d7f19f20so1777029f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 00:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734384; x=1734339184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFk85mO/CYRQjFZfRXq+/JqMZn31zCiBs+VMv6XbtEo=;
        b=EOYT8OZuMBsgMsJ05yWKFXBld0TvrR7CjRZJiTyoREtbroMl2Cn+z5k4JYAKKoynvy
         luINcZkGjJRBJSjdE4AeRKLSDzkGStvCHHasCtTqvLBWqAMMV/+FBC6n356rjVA92+yj
         WtGMTIcXT72eQCfjKqSZfpx4zhHe66Qd7Ay36En+lNH1ik9cdgbuA73ePJV/zKds8A7S
         z/fR2NrQCIqaXHECOfoUs//HgnLoSXrq31V1TuX7X8hSTgjIV1GOhEoclqvDURZCYDjX
         rruiSDEpBToSK9BAyB7Jayus9h0A+U43An2DNeeG+Lt2SRFMwNL77l+zWu2GdhkasZcG
         uPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734384; x=1734339184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFk85mO/CYRQjFZfRXq+/JqMZn31zCiBs+VMv6XbtEo=;
        b=AMphSoKsnK/EvuWPNXGRstlJm3WM8NeHz8TwE+h2kFRYXnNwfW97V+WrF7owGQdv8V
         1zlOpIlORmzasVm7CFZ3Q9zwLNxhrHxK3n/MKeGxkSUKO2UcJG2UuX+/6FfNQjdSJfrs
         US0oCdVgHFWKpkRz8dxEaC+p6yEepxPBrkRdbF7m6hVV/Ig0FNyNp3zQH3lVY0Ch3Br9
         Fe/Gh4cwwaslgq9equm8z8GPLJo9GJ8TwKvnTv3Bsr+kR0WXxK1CSt91sQnyx8Ouq9wk
         6Ch6oSV1a9ii9czrN0cRsrkNqetwvk0NqaXaKQc0S/0RjFskEpoOCT6PWOljgR2NezBB
         u4uw==
X-Forwarded-Encrypted: i=1; AJvYcCWPmyr10YJL/ZZo/xgamVK5zYZqVitPk4srvGb0NSEdkhc2f/KQHCcvjRCdvlrW+6m06CXqaB5+7KIr89+y/68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCWqMug1rHvwRyXMql9tm+h/HnpxbKMEUmPQGhfnV6seCK+Xhf
	Hg+Otz/9J+CgV7ITWpzXtBD+9PXZGOXM1oowYvmCDrQ3RllDe5LNpjzmNj1P0ZpUFPwkamEo7pm
	P
X-Gm-Gg: ASbGncu9zodbvJa6FWcJfHkrgxcpeQomKyLSnlOmEjJWPZQT1Z943NNOh3ClBW7GI2H
	vjkmT0ALSiSwpA8wNvtNgArddADwlz8mYfOKENk6SF5MyKGLEEJSZCgDmJ9lW9DG/aPzhLv7QAi
	4wbzlFTGA3WJ/Jz/dJ5gcSHu75n6VxNkTD1oKdyxvuns3hDf6sR7QwGu8fsUtIfsNusAh54/chd
	Cha9FGnnDyUcK88exi4/b2gR9iplzioxERRxPcKk8Cb8Iu7hkkegBHPkYBA
X-Google-Smtp-Source: AGHT+IEOo8lJu6ltoloAZKaIKq8yD7VNGVZMekepTQg9gVI4jPg2IADyotdzduN6daaNkU7mBVSWNw==
X-Received: by 2002:a5d:6c69:0:b0:385:e0d6:fb48 with SMTP id ffacd0b85a97d-3862b33f30fmr7387491f8f.7.1733734383645;
        Mon, 09 Dec 2024 00:53:03 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:53:03 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 09 Dec 2024 09:53:13 +0100
Subject: [PATCH net-next v14 04/22] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-b4-ovpn-v14-4-ea243cf16417@openvpn.net>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
In-Reply-To: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
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
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnVrASuhJ8SomcRw/Bzmzr2Y19hlA+33/f0cqS/
 GKIlPy9JieJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1awEgAKCRALcOU6oDjV
 h1QQB/40+Wah9gEJn6mPhTzYiTdwQIjnvBWxFDS8MIvjoF7o4G7K1E+NXhKKaSTIkrJ6qEhnfGi
 ESnpi8UQCPf8jqbzXXqxeY//DHM0uTJU/oDzUIDEgBozH60h+lTkDHxL3Nyrcey8NluK60C+h0R
 CSSQbE84dyB51WkbHToLg06AcBo2b4r8cBEA26lZW9MQ/l5oqEfotrA8g/xiFxjfnAfbGQ31G7l
 TsYhJbFfosxAI0ggWGunwvPUaYgk03YF8j/DS3q5l/YK+QYqFm9SdW/wQQmDTUIA9j0/Q2RWoCf
 G5yQh/78yKCqpp/q/vjaAadZ9/wOvex72nYI/cIeo1hgJKH8
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


