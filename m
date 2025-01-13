Return-Path: <linux-kselftest+bounces-24334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A02A0B2E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 10:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1450A3A5208
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA3223ED74;
	Mon, 13 Jan 2025 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ql5keZY+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BA123DEBE
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760673; cv=none; b=qZCJgEtI4YGxzmKILIc5FAFC7m0gRQ2cJNrm6koNzqH3y5YgtsilZ7z/aD5lJSZN/xPe020DeSQ3Ehkn4BIwGc4yIXUVBxoTmo0pr6lB+/2TEAwZ3B6fbrdoF17/S4UJX/0ci0VJknW/nMrgK/SH+ezw5+NZ1AiF9ECS5qs+qBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760673; c=relaxed/simple;
	bh=RY/Tuspo1DCFRvpCKqQYIvf8w9XDMBN0DkDSzZ4QpY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q6tEUY/b8juPAPCZ/HmPUd9z40vhlKcDl88fNLUFJHlNssCouuaJe7CQxPe0uVUgRnzFBKNJhrhYVg6RasdufcXkNlUWhwI9kVYIBR+h2BHzyirrU6b2QLuf1ZmsVba8LBfQRW38QqP6RUd4excUyZyzpr9GaHpzt1KKFPKrD7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ql5keZY+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436345cc17bso28617895e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 01:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736760670; x=1737365470; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1Fm2KD7luUDhEb4Vs1/jF2TESvp7j4CV8OblpLPfSM=;
        b=Ql5keZY+SzHcsFa8R1qjFe+TEQ4K0gweioMkxoOStsB2CipITF56Umt/fE0I74o+Ql
         d4iFy6a0JuwqjUENlK1JB2GBAqR7pRtx87ofanYYisilPPsNLcBk5MVia+INQkz2h0UY
         l1ibwX1KyRkWVkLBu24j9NoCK+aELziBct44CMPZt2YVjP30QP3dLGhd10Nt0rgsX6zg
         FXlXReXeQoc5CJhxFPaNOY0FdCe6q2PgU+HwxoKfELwKC2x7L4jkSz4F/utap58pyoXx
         Ifo/aqdhwIkCsHF3kngJRSNUQKTMYV/nmIBldOw0QE+KxSrAbjFQ53/tjXc4MWYxaj/i
         4Q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760670; x=1737365470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1Fm2KD7luUDhEb4Vs1/jF2TESvp7j4CV8OblpLPfSM=;
        b=wEZECZp69wJ25CoC56HyYxDc9Tb7iXpyasXlUFD/tCfKbnn5Bklv8o1nY26XtkAGbM
         kCkzRICDGK7eP2AAyvV5zFAJtafpfSsItikYpyaya3BgMPk6PNrbj+Aev3Y/but/B82r
         ky84evAN/f6bNhAlvYsxIUT+cY79OszfwnfWlUsTuGVvHvU7PlWmtMTMD/XXhSx9H33I
         qxVIvDtOdcaAZNt//IbMF14eIP1LzatoNCzMgs3xO6me1lWKppaN80TmV2BSbsE92fc/
         ZYkzVG0fh8StA4G4ZkIYPcrByqmkWN92+83gsZ9MFK+P5JTnYjaMbJKy6kSXLRKBBrSb
         RWyg==
X-Forwarded-Encrypted: i=1; AJvYcCVDCSdZ53p0Ybht4HP4vESEvcQED+GUIcOKga1OfZIcs4ZGEVLxL4rlMexVZ+5m89jeVGIia5J0Aey3Uevf5p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLU8GGGBTlE7t9FFleBqdN3gkNo3+xrW7d32zMHgPQ8yPm9dFM
	YtnTL0DGGGWlHwAk0J9BhEAkXd7s/by5OxblD8zcoCSDI38K4q5hF1JN3Bdcnkc=
X-Gm-Gg: ASbGncvy1G5EvR4IMxrDvimIFzCyGIlYc5kH5jys8R6Yi99DlHFYhaIYZSoxQI/0nG7
	r2u16e8z/zmkEI/w/5Xie2f269JFiPFKsj5Sy1oH3PL6yFP/RsXV+o+TqtYpBsTLZAzZkan8V7H
	ympAnZPnh3neF21P0F/hmCy08exn1XlU4SfkNDEhaCJo+fp9h3Cdf5F9mxA4XzVj3b6+VV31gEm
	jIreWVRbkwiOgM4GSf5z/9cv8A4WBvX+A1LWmw998MRVhXrH5QcJz4oBDPJu1S+wjjV
X-Google-Smtp-Source: AGHT+IHaZNNWdfXzEkINU3Ay61NEmNgkluy5Uj/9ks3EwF8JkI4JxwA65gJEofvmzjC0OPPLttkV8g==
X-Received: by 2002:a05:600c:3584:b0:434:f871:1b96 with SMTP id 5b1f17b1804b1-436e26f4ef4mr179523445e9.29.1736760668343;
        Mon, 13 Jan 2025 01:31:08 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:8305:bf37:3bbd:ed1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm11528446f8f.81.2025.01.13.01.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:31:07 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 13 Jan 2025 10:31:23 +0100
Subject: [PATCH net-next v18 04/25] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-ovpn-v18-4-1f00db9c2bd6@openvpn.net>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
In-Reply-To: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
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
 h=from:subject:message-id; bh=RY/Tuspo1DCFRvpCKqQYIvf8w9XDMBN0DkDSzZ4QpY8=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnhN2GHbREMM6Paj4kn0ckQZmn8B5a/BY30U8yc
 BenOWGxE72JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4TdhgAKCRALcOU6oDjV
 h3ytB/wIBB7z8zn4vrFXyxvL6cymX4oy9APrdm4rDzwS4rbigDGJyPTkiLtsK8EEDqarQQGo2zs
 F/kugBLuBKQA6p0ANT2B/QF/1xY71TSrOoCnEKcs7z+OJM4vJkv2fRLpuZH/iyjqg/Dd4M+gJZn
 tkkSlOwYb2Y1Hy8pBXhj4AxGhguCMLF81GNi+dKdI2pdtnwzn5j57HVCPGg/iwKDN9IAnJvGnIe
 i0iC6AipVsi4ZK0BqUbIqB4Ln0o2OOQHQxzBhHrxiLSzkvKLu8U4GYgoWVFkXfVdEgcjS+EgK67
 8HC+2MVwQz77F2oWl42b0bmA5LGaUjfY8cdK6TM7AboPDBbW
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
index d3eebab7fa528cb648141021ab513c3ed687e698..97fcf284c06654a6581be592e45f77f0f78f566f 100644
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


