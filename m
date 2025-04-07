Return-Path: <linux-kselftest+bounces-30284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6129A7EDEF
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F6D3AA6C9
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE7622258F;
	Mon,  7 Apr 2025 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RXzXb6QN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811022172D
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055234; cv=none; b=hrxYTeeVxPTwxguR0KNZhJGIkQlsp7kJiBQZ+h65B/zfD/MfMBZyyxhRZPQVH3bJVoAOfxfZ/AfLK4KCs8jCEIjDUmVdhfYZS4bqjbAkZOspOufYmmRL/rJFe0Bit5ygOOwEii628o7E0lFTg5Ba77sOxjZC5kHdY56rYxPlecA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055234; c=relaxed/simple;
	bh=HYQVkKLDFS6ZhRYZCyfXaaD2XhQID0AqorjlTUWAk7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U65zePbGI9xZMyWBb8v484rwVFOQtSAONGVqhwqPzfZ+hRJcyOhe2C+dqZNYCTBbeg0DI30uaefa0M0aNqX2x34enlnrs+mjmYBnLNVvczwjLaQnPFalWcRLCevUIsSHSLJjdQEDLSVMJo58CX4o2dcCQ/fXWaiK8BuXsLPEzOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RXzXb6QN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso32314865e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744055230; x=1744660030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOQgBVRGZZnoJaMDdwTp3tH6v0mrDf2JLRZw4IaOnFM=;
        b=RXzXb6QN9EQsV6NaVQC5M969gcs2EkufdBE8eoXnNANX9s3e+V306M0qhORswPxZd5
         UXKel926PWlEa+jh5KAVnZTAOOZh2YbJWD88k3iexmfu0LMY76FTw+FW2SseHgHd3p9k
         zpHdoz0hdmGEmVK5F/O2WHwMOk3vBXJ0pB0tR9BLLtVM/epTIOvYY8rxBYnkcYfJb9LE
         zkbw6u/hY1F3RTSo6+8xxJ6AIzERGU9b/o64yiDjxxlfRfEMz0bMex5HEerUxz+PWfme
         2zwMifCVEgfDY/qiH0s94mOwy6JCuZl6PTSPpIFTJxcP3U7zouYPoGutKSM+H5OF5gfU
         GYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055230; x=1744660030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOQgBVRGZZnoJaMDdwTp3tH6v0mrDf2JLRZw4IaOnFM=;
        b=Op/bqmdVARxOH1Ka8oniMU3QuIf2sEw4ulv637LBFtnWJGokyjekzgnex4IzJgAb0x
         vr9iHnJY+FcC5Pn9QgZHsyxC2V1MNUOfx6Kyhfet3/EIVkI9oqiR/HUN7DdXRDhXhroe
         qAQS4JaWjF5MqwOXfK7dOmlhax3YhZ5eZGvYh+d8HL/sFbSl9iLVIjbGi5MmmsKU1plq
         /n7yWXiZOi++UEPWtArnkxpgypPFP5AeOH4ycArn32Fuza4MbtResfKX9kOLC8ggmBqV
         PxSAGgDYsns+Us+8CsYJKPcrJCfja4C0/X5sGyIrb+YWH8oCT5xlgpLxcaL9X+uwfItG
         OO3w==
X-Forwarded-Encrypted: i=1; AJvYcCUH5hF2vUhtpBKwPusKlaH6QUZKwi+3o/uMW7EHjklQ0vOARfXJKCmV48yoP+ZVKspKuM76IADA2ZZ1pl66Fcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhb0vyB9jUezFCSot5ByhdZ+mjz8LsXuJhSFZ1O4z+TywH5oGK
	h3vfhUW/BZ5lE4aqCPvGcx6fnXdoR13uc2DXlmSRVY64MAUOKmX6RRFLAr/j6Gz6dI0y0kl7sEO
	FrnGtj3OD/W7V95QOCDdV9xIJndAkFhFgaXugjiCTl5XyOFYBZrew11K5cvs=
X-Gm-Gg: ASbGnct+1nSEoIfZYGIZf7BUj18OuRlWsPyMVMp4olG3fCtIeL+OD3zpXU41C56PpUZ
	B/ekguJXbbo4/JhQOPE4qmWb8vQou1ecJ0bjjIwHdmYReO/1QVQg1wEJlYmgfKGHXr7kdvs8jy2
	XxH+FZ5CbS8LJrJDa9iz4JkCPUPtEGA3jNundqMFd6NjzY4WUVk00e+qUkPW7rneVVzwFrGx7nl
	KltfaqvaIP70mFKmmLwAoerfyVYO+RKvTqLC4fhE9G3Xy76cyxXllP6jah6Zy4Ku5hbh5yj9b+c
	OkULpTS4bwmwvroYeJOmitJqM2ZkEYjFEL4E1X7wag==
X-Google-Smtp-Source: AGHT+IH7K/Tlr0afB/YVJjvYVZD1E9BMMpbFJRVzYZ2AJ0Otgp/R+8NHmsxmYmrUdlTrNBZMsz48Uw==
X-Received: by 2002:a05:600c:224c:b0:43c:f61e:6ea8 with SMTP id 5b1f17b1804b1-43ed382b5d7mr81964505e9.2.1744055229934;
        Mon, 07 Apr 2025 12:47:09 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:fb98:cd95:3ed6:f7c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm141433545e9.4.2025.04.07.12.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:47:08 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 07 Apr 2025 21:46:12 +0200
Subject: [PATCH net-next v25 04/23] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-b4-ovpn-v25-4-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
In-Reply-To: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=HYQVkKLDFS6ZhRYZCyfXaaD2XhQID0AqorjlTUWAk7Y=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn9Cu0FvOEKMZVtzfbyq5bW8/fm9vO3C7TcKS0b
 MiFlermb0yJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/QrtAAKCRALcOU6oDjV
 h38pCACCFPtQsZaKwjmUaTeZvKo8tiuE4keb8L9Jphoa3KooqeyiNozOGm5FOB/sfTNtObtuptM
 vC/vNKx5wZ38c7M7BX5BN131buo2nCPrnz8HyOKR5bSITkbRALDGNwMBIMbPr1N4pFLMmAWeeEF
 ElzPaVC/t+vKgDXmfLkcvV5hrfABLYjxRvuTFvXs3s9WsDnjrhPY4ixSyOL0Mk7uCfZkuSx5JRi
 42xHfgJkL+JDzOrUo0TMan4C4rPJE3OCId7umQXNbwN+HOBsYoLgFdYXtjjKKxeZVSwwvMAfaWQ
 wEcAZ9FYr821XXeZWMhVwUYV5qJO8NcFn9GBpW7Atr6/T44/
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index b19f1406d87d5a1ed45b00133d642b1ad9f4f6f7..15802dfd26fcbcad42c387d42f665b8b47604e8a 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -21,7 +21,22 @@
 #include "io.h"
 #include "proto.h"
 
+static int ovpn_net_open(struct net_device *dev)
+{
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	/* carrier for P2P interfaces is switched on and off when
+	 * the peer is added or deleted.
+	 *
+	 * in case of P2MP interfaces we just keep the carrier always on
+	 */
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
+	return 0;
+}
+
 static const struct net_device_ops ovpn_netdev_ops = {
+	.ndo_open		= ovpn_net_open,
 	.ndo_start_xmit		= ovpn_net_xmit,
 };
 

-- 
2.49.0


