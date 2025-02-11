Return-Path: <linux-kselftest+bounces-26284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20007A2FF51
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883643A3616
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BD31D5AB8;
	Tue, 11 Feb 2025 00:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="czHZe98X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA01CEEB2
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234462; cv=none; b=mXWeWp+UBdG5S/8UMtJ1r7+GiUZrR/bH9gAutE+DXCMSY5C1zgWrckPlIXjYXrtGs6yJbXle9KV8szMXpfvlISEWPRuFyNV2AUTtXaVYbUWUMXd/lILsYavEdD3qecCbevJX4w10t989rpbVij2lL00ymRthpDrjZFki9ArLgnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234462; c=relaxed/simple;
	bh=eJ3PNxxAZekah9naKbbW6jo7KQBN+FSwk2ZBYWG0nks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pRXqrxTBz1hxhl67eJWl7RtOlebEi7YJMQBAiQWIJtgWAxX7ZhoDV69UGGS2S1g4NayKJTwcR++8FiWvQ0CRwiaYJLzAcAKFe8LQEkEjL9J4LAPYzU+XoqsFBGyOLP2OwpjqeJsS36l7ZeBOlC/P585Q1lytCvjvK4Y9TGoUBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=czHZe98X; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43624b2d453so58047855e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 16:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234459; x=1739839259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qk5TLUGwG4S7neZ5Y4DGrjf9AZmKaXK3mVQ9uModc5A=;
        b=czHZe98XzgfGZp9xrXYLOX5+8WB1C2zI7Dwwdnk/Ttzc4HrV2Wn7ech/wUk4ig/Jd1
         lZW4/w7gPzzg3LelvyMjpnqi7hcJrkIM1qpN/GUCK5U1GBDAERxR65Mq9JiLCk2MisEZ
         5AiuCy7SSttxhweZqvIhPC1lWt95xYrtS8Gc4nEVfX2G1+FJGiVpQUm7lBNB8uP2F1lE
         Ipv/KPRClkXTlCbc/ZRxcj2B89008ZD2dtoMbqjcjfTkKggovAMKwWM+0Qg2L6HGp7+G
         PL2V5UCHVwLm8f8o3KYqsanQq2pQeifF7+7u5R9Y8tqHNr3opeCpqz4Y4jAOLL7O4GCK
         6pHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234459; x=1739839259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qk5TLUGwG4S7neZ5Y4DGrjf9AZmKaXK3mVQ9uModc5A=;
        b=on8mt4XLG2svCIq1sisV6St8bUqwVqvttHljuF/TNqvHREdp0lx7TsJKNl41qlbPSX
         YonKYzB51oDC2OK3bXHOZN0s9yMe6WCJPSVVTbtcJZ7Jcy3mXji+YODPH3uy6P4VKdgg
         QklzaraGj2e9IEoPDrnhhbCISctCPL4thhgcVfqu3wuzqU/iMGYpzE6JaIMPylBpQOB1
         ZNgjwhAgvgeC6E3zSFN4w4ymxBhPcGocK15niDCXj1AZtvlAYvA76JIneZUD8pfKqd5g
         4HsiyeI+V+doiVeISLIEWyeZt1bjJCELKSqaTdCBxktq05RgQdokHsG3QCQeNIAGJ4KB
         o56g==
X-Forwarded-Encrypted: i=1; AJvYcCVE6MIqEm0aKid0npu45WBys6HsSuRr6LNBV8dzK2ihx9qQqS+W21Z62VKDweT0b/+zumovlUScxNdyZJWAf5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbS/PULmv4KIgx/s30+xPasWYgs/zIXu20ogbCPAiE/Xmyk6sr
	LNM9A0qefhTF3HWXbcVo00zwckHHEkbAvNY3JiV8uZeZIUPwjdu5nWipx3xX4gc=
X-Gm-Gg: ASbGnctTHy3RNBVGQpknWte+MehCcGyJ842g76svrsg22iOz5PnC/vVVG8ejMKEANo/
	OvaFFTMuRzAppvoiRT4mNa7cmsxhcJC01KPegY7/AfUbcZy2PWHCEu8Y7fzDIVKoJ4hoVd9TRn6
	kHE36jSam4x/Pmry1sHdrpv0GmN6gVN7wR6Zl4q+YqYuGpZj++rkGO1h1HjUaLrz0JSefdUcxAq
	ITX2S73RPilPFvSdBd3iVQE7bHUJiOHj6VznH+NERyaIkPhyyfVNzUtPA1TqDILIdhKQNvmmPiZ
	QOXeeuqzQ0scUbMtV+lXLDAjOd4=
X-Google-Smtp-Source: AGHT+IFHTVTdhnuWvsyarx1fk8vQKzVR+MOeqKMzewrWzFS/51onsH3Hi3ms5ltzeoDOgdEKLsoAzg==
X-Received: by 2002:a5d:6d83:0:b0:38d:e1ab:d785 with SMTP id ffacd0b85a97d-38de1abda3fmr3946799f8f.14.1739234458707;
        Mon, 10 Feb 2025 16:40:58 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:40:58 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:39:57 +0100
Subject: [PATCH net-next v19 04/26] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-4-86d5daf2a47a@openvpn.net>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
In-Reply-To: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
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
 h=from:subject:message-id; bh=eJ3PNxxAZekah9naKbbW6jo7KQBN+FSwk2ZBYWG0nks=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyMbarSd0v9dnPumrFpHvLneCBvSTs1uT2kB
 DGs/lLRmuyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjAAKCRALcOU6oDjV
 h8suB/4zYo0OMt1oCwNOO/TVGCvLlJXAH9XlYWTV+H7t+iYAIBavrbN8Yj6XF2L4KvVtNrYdi3Y
 ky6Jsy4u2Zdk+gBSSYM4slnuhBSfK1nLiuhv1nZnZV+78X5vvUNdiRHoUr+nui1iUZtNdBDPmG2
 wcYAz83oHiy8+uBD4EwydXSahppBvX96615RqRt/V/UEKI0YShrbJtM1LjDrzIH1IC3pnypgE2R
 XM5KQ+/FjWxOqjGLvCR5OiTI++0k5obU0yBJ2I9AG/V1BUMRVLPY3j1+5Pau+ABpdDtwcNBnzGy
 KIqDvk7C+bga7PPtZDcgWqi7l6KVBuFpcHJU+q4gKT0JhRgn
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
index 14dad1732f31445d53cb2dbd5c592e8c3f11ef94..64f845ec13499a72a8586fe6af035aabd6884505 100644
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
2.45.3


