Return-Path: <linux-kselftest+bounces-46159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEACC76C32
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1E704E758A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 00:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E239A272801;
	Fri, 21 Nov 2025 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Rh5ORHk8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6124236453
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 00:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684475; cv=none; b=I1wdvOpPMIoGRvw0Rf7KEQfBlxwvThl7reogmMrGkRkk6E267hrdjPLaia16WhUcA/sgVu/E+78BjKAZ4pHFzcp1rEPEmPBWqCnMQRRFZLd1bKA2tHGXrlrrIvaPFHbDdjtBxo+7twcxx3u4D5534g2PeNuOS0xzFYM/AOkPH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684475; c=relaxed/simple;
	bh=Z+75JxhIayB2QDvUMkri+7f/852+SalPIhPb00SKhKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPMHuxW/gaUTlhQbueZTYR9mlMSuT+TsPaw95zopEdOBhIhja9cSc1wI9s5VWQ2rD7DwdW6ksd1E83H+w+9vb/GbMJ8gURzpiveAY11oNMzKRR1hLPhqc6cLZdzp6PeF3kFuci4GsoeKPhMKkI3+w71BmuFRIpkQfvT6No1mpqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Rh5ORHk8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso14258655e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 16:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684472; x=1764289272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxPi8+qAmmslD+H99ZF2plxkvdD2p2sBI/iOvixsuCI=;
        b=Rh5ORHk8781dgLqbSWwX+y9xIqhY2cMquJGA439SAmyd+q2LgYfVUrCchgD3hfDV8b
         kr5aiCY2DiPHN9W4HaIxMNZVAQw82vwj61Dj6GtBs4aXNMJH7XITGGxyVahjFjSQtO5i
         UxlHOekoCkDB0NvBxv9HEi1TaMqquULXq+c7SFN++yH4bJ7tseDNMhHBh1OOXw5lzMil
         Dfd24eOni1bItLNosp88AAkyYxOrbwqdB1tNE/Mw5dn1yKDXzJg7FiDk4cFP9VxoEyXQ
         1sFcn180f7YJZA5fSLI3RSM8Pnspvw7u4xnrXdJeJVNXzltYtFVpNZN4zTntFC5Dt7Nx
         iFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684472; x=1764289272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NxPi8+qAmmslD+H99ZF2plxkvdD2p2sBI/iOvixsuCI=;
        b=dHG94LPXIoBKeFbG+3qP0J7JdVi9SnOyuJvv0dVZc6H4VKCOCsCK7oKPxjPoXfSKZr
         ypGpwXDiCSaGGvBbrfxGoYNEJOsM/htClHGAJWq63NG3zOI9PPRk/5T/JSbTWLi2TYJi
         Sifn8cVnBdAlPUqnqLJmoKiJ9D2jho1fL5S36XP2u0SBkHjUywG+ppi3vRqBZjpRBndQ
         dRvFzi+r77EJIG7xl5zTgTziGg6/DI/t+mtwmuHSP/8zIniaChrKGCxifp/Oiq4EB/X2
         71Q32y0Pt2OGSKFIJ4XlQDPz8SetQR+YGLCFpAjNTeLvnpPbuSSI81hYLy8QnKSUiMq3
         KmyA==
X-Forwarded-Encrypted: i=1; AJvYcCXv4MzZRbqAlBVJggs0SLl14fvIDjwJrmh9n5jXRfYtYAAGGdDwujEKKPP7w5uzTUMVRtrmUD/4VGNvORP4jWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxQdvZd8y6UoaClAGotFgQIQkakE8E6zjUztxLZxrOMuRCKlXY
	PsO0lnMABRW8+6pwcc8bq7Gqsw+wy2srf7tpQrFXK/+Kvl00qYHdQoxSsw03r6PFAnfclZ1rn1x
	lzbaZfiADzeldwXVGYfiAAB+BHY3geliaiU2Kf/6uAhsV3NG0rEMybZ0b/ewMtwk=
X-Gm-Gg: ASbGncsmD7kVmuhsE8gEWc8qAfcda7UCL4CYWM0p4vmOBsH2wnWth30FcfOUxCZB4gb
	irK6cYZi41X6oL6luPTAfbR2e3CV/eY8NM43OkLfW0oUuq5Ll6XjjLYOjpicbOj5naCxlIn8iSp
	yzbSTABdfmTPd/H2SZo2luYKRIfgLcgLLpZzPosd8emiHEGDvSiSV88fQfoHB99HINLAaVR3gq0
	XXilvn8FinBomEXFsrPhlqvqHcnj9nkM9qKBg7IaVh77Dd1os3IqHXr7+lJhljK98ErnJWcjTdM
	dkIr6TT5Y8yqNkog7HALwQKJOjA35HXq95zlTMNUfEC2B7TJH+WWRAoZwPMwTcX1u386VpaGZ+D
	oUiqJOp/Z4o2iQx8Z5Y8Ar7m0906WTi+DGupHfdhSIClVoknpFaG897cjr1edCkvC6vLJJz9g3J
	iIRgjY/Ht4btNr2wNHjjxCu7XDREOKcyYp/4Y=
X-Google-Smtp-Source: AGHT+IGPCAfzGDpSi+6j1/8RLPhpb+xFzZ1QrfahgeQ65WX/PHh6/ColYCdlVsnAZvBQSQUg3Azy4A==
X-Received: by 2002:a05:600c:1c82:b0:477:73cc:82c3 with SMTP id 5b1f17b1804b1-477c01ee405mr4247765e9.26.1763684472032;
        Thu, 20 Nov 2025 16:21:12 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:21:11 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [RFC net-next 12/13] ovpn: use bound address in UDP when available
Date: Fri, 21 Nov 2025 01:20:43 +0100
Message-ID: <20251121002044.16071-13-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251121002044.16071-1-antonio@openvpn.net>
References: <20251121002044.16071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

Use the socket's locally bound address if it's explicitly specified via
the --local option in openvpn.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 328819f27e1e..42798aca7bce 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -148,7 +148,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 {
 	struct rtable *rt;
 	struct flowi4 fl = {
-		.saddr = bind->local.ipv4.s_addr,
+		.saddr = inet_sk(sk)->inet_rcv_saddr ?: bind->local.ipv4.s_addr,
 		.daddr = bind->remote.in4.sin_addr.s_addr,
 		.fl4_sport = inet_sk(sk)->inet_sport,
 		.fl4_dport = bind->remote.in4.sin_port,
@@ -226,7 +226,9 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	int ret;
 
 	struct flowi6 fl = {
-		.saddr = bind->local.ipv6,
+		.saddr = ipv6_addr_any(&sk->sk_v6_rcv_saddr) ?
+				 bind->local.ipv6 :
+				 sk->sk_v6_rcv_saddr,
 		.daddr = bind->remote.in6.sin6_addr,
 		.fl6_sport = inet_sk(sk)->inet_sport,
 		.fl6_dport = bind->remote.in6.sin6_port,
-- 
2.51.2


