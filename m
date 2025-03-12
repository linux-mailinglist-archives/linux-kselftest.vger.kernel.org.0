Return-Path: <linux-kselftest+bounces-28846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1369EA5E5B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6FBC7AD9F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 20:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470961F0E3C;
	Wed, 12 Mar 2025 20:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OX0/8abk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2B1EFFBF
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812875; cv=none; b=Up7QuK8T0wXm742PUcpnNsjtfBcx4WqxNIuOOcsV+3YK7gNylVLDNnYysGlH5TT3OsoucCl03pvGlQ5PYoQ5hx0CasZ0p/HuRLSSCNy7Ew8qCQ2zQ1TV5bEQExmmYIjLvuQBE6FCYS7VTiC4SF39iMHN8MPhVEFiR3Y1cWXZ24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812875; c=relaxed/simple;
	bh=nC6lwDPb3zbItVdYhexRf+7PoutRMPw8aLJAIMgqJRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k1/D3fzd5gTbNfRrD7lHMHfLPfabeXGmrMzslRLfBMAu6sT4uELfHSN1qW86UzaDlylydzhVlZT8UeICx+CC1l9g7lW2i2iFdjYTw17Jvmv8ARC1A26rR/zarLodgGV+FaeOG+XTk9j7s18QQ1k+R1jO2RlTdfbJBZryRJ7+Smw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OX0/8abk; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390cf7458f5so194747f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741812870; x=1742417670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1eyDA70luy030ManbvwItVlUHe7jfQdxQkjt6FQ5RE=;
        b=OX0/8abk5VtgJx0xIfEdTviBefsTGMegjClgoLwv12W3LfNnM5kJrTr6fARygOvFcv
         G8asesORvHdz2BIqVquqQ5s/AbCJN3dbtRzDGmwDPVRX0Cy9MLSRPhIjmGd4wKjqFUza
         XQFhlGtmhnkMvDKWzdgfvm+6qmSOBDGdxMGH1JFwymfbA15WQOTqk6eVvETEstYahWvf
         pJq4lxl1SyIc2J2bJnzw2hSbxajE5D4NO1XWWgeIblAczqzeQ/Fc9CVOHfgl7v4NMCxn
         FbHfedlNSitS0+kYJqET7hCNajUeNF1/touXqN2YjnA7CR9hNzYy9R2u+atBC28vNJtr
         0eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812870; x=1742417670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1eyDA70luy030ManbvwItVlUHe7jfQdxQkjt6FQ5RE=;
        b=MbvNtzjKWIwFFjfl8fcyM7xGzm1htHTXlP+XiJAvfJ6oJnNjrJ5ELELfG5eb4xh68c
         tGIzap/MiP9p7zgEazq5rudT5kUo/hevGNEBdOIF3v9CqzDMUd5dXoOjIc8oVbjTSJ+R
         iT23rDbsr03fA6lvC4QyF+4ffBuWdg58GY0ZUhW3G4cNpvsB09FW8zVODpRFiYs0wilY
         CmI5mP+Hig4qwcEA8LSOym+Mo5P4EXSh1U5VTF6YrBBlfQt/pZCksGuTy2waQCnptH2P
         91lBD8aIXs9GMgmkcB8aGJL6rGr54JZdL2fpxWrlEfJ0Tt8XYaXsLhxV97V6rNv8I7ZL
         4T0A==
X-Forwarded-Encrypted: i=1; AJvYcCXI/faQTHbn6GsahTDnu7Meu+f2juEGXjAvdtXePyEkmSLmRMjSPnc0wYAayORw98SaQZw6+Qs0S+8mcVJNTdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgoPl9Uv0qrgik5C9rLaaV+FB1ijQThk9Wb98ZeNyjf6g8xhh
	lCHUOIuasyOJI2UVAEvw6SRFxEBWMFFrtCFZbca7xUhEewgLa0bLqj+jkYEJLQE=
X-Gm-Gg: ASbGnctHd1s5ecX95bFVcIyxnuVg5Rcj9W/h4xZeY4d1lwFMOE6YKdgeJZtZRopGDSE
	t9TFzgzJRM0lnYplmqTiLBsA3jqhqTDDrB3a9wVgPPhNGor13ZldNb1dD8v1V35nv4zAcpQmuQa
	kB7QaDhXG2wfSdX2Q7+rvqKPFctyNP6Ss282iGTHrzara1EHznVzWACgDfwIN9TLppEfCNjnjAK
	aSTWsRBFBowEiymEcGEOkV9rqBMyAJ7AByyiJSHwemyiaLAU1keUJbwZVunI3cN9yOk4x+b5jaq
	OMXcu9NqAWA/AJyyGla/cU+1W1cEMv237Gn4cOVv9MAnrBYTU6zv
X-Google-Smtp-Source: AGHT+IFn9XKbA93e7BiCzXzwzWgDYS06r1RE5lYZJPnFo1YWffmvHTw8AB8U2H1zm2LIhUons2recA==
X-Received: by 2002:a5d:6d83:0:b0:390:e9b5:d69c with SMTP id ffacd0b85a97d-39132d5670bmr24432111f8f.25.1741812869668;
        Wed, 12 Mar 2025 13:54:29 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:a42b:bae6:6f7d:117f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm22481393f8f.99.2025.03.12.13.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:54:29 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 12 Mar 2025 21:54:13 +0100
Subject: [PATCH net-next v23 04/23] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-ovpn-v23-4-76066bc0a30c@openvpn.net>
References: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
In-Reply-To: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=nC6lwDPb3zbItVdYhexRf+7PoutRMPw8aLJAIMgqJRQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0fR7TuAOuQwpbA7wiXPSYho5YDAWVs5A6/djU
 GMLf/ub1MmJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9H0ewAKCRALcOU6oDjV
 h6/AB/9PEEz/xZPMposrtUqAnifKhJ4ydKe03q5K2SVgk0vgiwoihZwmZCAUzHXiVZQLwRdmzA7
 ksixxTC3HMCbSRZuqIiT8sw4zhIEZmU/xSgPLrRKjXBS4+vMMJsDR7ZSFdAq2NnQoSLY3ClWbtL
 mMwW10nLZE6CaQPFhTdEeTWnwV3OmFaG5+pV2ExP7BBqsjU5IBndmnSB3UdOn8ONH6hmfrgZiG+
 sF+b6brsibQHzCoEw3CzqDZGvh2thjZBIEI8DgkQqy+LOoh8pHOzvp5kFg294/rZIKL4mMLGnEp
 8Z/mQp6CFHwvUSyBjlTqmlliiDSoF82eFqsIhjL4PRNnkr1S
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
index e71183e6f42cd801861caaec9eb0f6828b64cda9..c5e75108b8da5eabde25426c6d6668fb14491986 100644
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
2.48.1


