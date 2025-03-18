Return-Path: <linux-kselftest+bounces-29310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF1DA66552
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 02:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D43189E916
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC495192D8A;
	Tue, 18 Mar 2025 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ihrb2a48"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D15B176ADE
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262069; cv=none; b=CzLmvRaHncTFZdhab9wIZNyGkqvvuG8Hsm8FQTO0TR1cjY7nk4O+JM2ZZ+bHLWMt530/wnqfqUJkrxSzPgLchAC/5CWjKKubjnEWGhuRUJS0NdG0wxd2pTv+pK80B+t/uj/y/o2xHSfmHuWKhjO343EWJwszfSt1LSP8W/pX/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262069; c=relaxed/simple;
	bh=F7vNJswYuDrJOUluc+iKV+B1IKtUBw6UmYPNXP+K7Ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqXLEpScis7v/VRFvmcGi5Lk5pLRdJFNVIVnuB+G5P0OnCAF3O3juJEsUogZhKP7Jogc2JxuCD5Q5l7IaemZN37VYBJ4W7x6ud0VqhiTYY4OBGpyBzoYudZVQHBvvabVMuMVzXc3+OPK3kIOsTu4qz7+8UqDgFvl1zhrfKehcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ihrb2a48; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390cf7458f5so4366851f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 18:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262065; x=1742866865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXngeC+tXo23/X0d6ycLIiWXJIi25bwb8m4uszQOeoc=;
        b=Ihrb2a48NGteG0Of2cXK80V0THfsDrqwQ8S7TgnA6Qd7FqCq/L0RwX4EJmT2n3Me9Y
         xPY31qkruLVLojFQL1y1vS5IVqo6OnboWfmiozcREwK7CeuiRceUQa1GIxg1yX26za9p
         YqNvDBHQ/Bl/KDfsxLkOLDtbHz6Y7xkyU5llIHOJ/rPu75LsIKc+v/MZyLw9eBG1X/JL
         7z4+sZGWQJlUlld8p+mUmHSEoQZrB1+Hq/P2toW6WkXv+hkXniPyIhNi9sZjXSwjKB6O
         v2MwiptLQvb3Dh3Tk/IYg8xKg3+5mTwdLWx0yjoyxxkwFUcHizADeMgaISjsBDP3Hq1b
         Xkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262065; x=1742866865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXngeC+tXo23/X0d6ycLIiWXJIi25bwb8m4uszQOeoc=;
        b=YYJ8dwBYk1awFXcKUL+WpMCnuJDi1rNin2s3qFkr9hfStolo5r/bV1PmJmEImzkD20
         aFaIVOLWoeaKOK2SvSDACjBV4nMWVfCIqlCKefF639KeZ/3n5LLE4VFKL8j8O05li3zc
         b6zuzcxkOmk3JnKbVZAjWIhN68UhKZFHlcTUsYbsbk0zejSXZJMcliKWxbOTUuU4gRD1
         xo8a6QkPtoK1PhATYYeXVlZbHoOB4PdLhP0tcnf1zmnWEiyoK31KesYcDbBGzRx2bL1v
         JaCW1PJSIRn16o1o+hLj5UeHtQqQcPEt8a9CiehfJZjcWb3MZSKQ28kuBtv0uRePx/24
         R0kw==
X-Forwarded-Encrypted: i=1; AJvYcCWch3h56p8z2un0XGeBlLdPRDOoV8YgqN3LA9UZWX1z3mn6mjMYirDDTM9BPNVjRwVyuaLqAUMHtznmCFeLd/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwIKDgT0gxH/51LVE7OBWRMRkRhCO4lae0Htd+EBaK7dZlfuOH
	hag25cQeOEGBdZgk7i0r/gJ0Q7MXJhja8K7m/z02w6LG4H6M5Uyrgy3YT4zliyfuUvTE0B0b6b6
	pR23uD4cWMtUuLpn3KBBbSVNPpCN9qa4F1czSsOLvpGYb9pC3FWWV422L5uE=
X-Gm-Gg: ASbGncuf6mTnFukaFCZ0tTVrtW38YiSdjw+wpTfW19D6LafRo8oSaKUeySSs6aYVXqD
	ftxapL7n8x4JDX/cSI7jm5wGGYjJZriaVWd8qAVlM98LEk3OAEUNVMLB+Wo3/TzRHg7mZzR05ot
	TkiO8uLv58hXi7Xsv/OJVL3V6zmyAynZhMT9yoMvInXxzl3sN4HloOASFy1mi5OE0O+5nslNhuK
	T2unJppCgMqB/psLema7qNJ0sYKiT4NAaKoEF5/oPQyGnQvwXAXE6Fh/JqyV5T8qm+NvrYlNF3F
	7RG189jHmrhCqP9KqRCNyrctFAFtIFZL78B8D6cO1A==
X-Google-Smtp-Source: AGHT+IGPV96tVaakTrMyHpMtxyYA5qx1H34HcVZaOckFeaODwHUP6905nL8TnMaH8rYevbGhVEGPTA==
X-Received: by 2002:a5d:584b:0:b0:38f:577f:2f6d with SMTP id ffacd0b85a97d-3971ddd4b07mr16061612f8f.2.1742262065663;
        Mon, 17 Mar 2025 18:41:05 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:05 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 18 Mar 2025 02:40:39 +0100
Subject: [PATCH net-next v24 04/23] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-ovpn-v24-4-3ec4ab5c4a77@openvpn.net>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
In-Reply-To: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
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
 h=from:subject:message-id; bh=F7vNJswYuDrJOUluc+iKV+B1IKtUBw6UmYPNXP+K7Ko=;
 b=kA0DAAgBC3DlOqA41YcByyZiAGfYzymirIzQuk8H74N4mh1CgwsPz8MeddaklCb468hrTOUt4
 4kBMwQAAQgAHRYhBJmr3Gz41BLk3l/A/Atw5TqgONWHBQJn2M8pAAoJEAtw5TqgONWHc2QH/j+y
 zNppsiM7jdqhypjIPvZ7xdfmivRXMpc3lLTcFv3pwZvxrmbxvGgtGF+C3JdCaKINm1RGQRblsEq
 qrMmJanRAyEtc6twQMKtnKdZljzXyuNkeVxKPXiMeVSa6NPosHEROHIk5WxgvnLctN/XDeRIrjU
 zikbJIQfUX36ILsq6TuMOkVD0cLzvghbjQlPd9n4MBN9WuhdjdjSePnQSG/h/PDic6EGfqkBeCN
 H4uL4ykVMoVlY+BTiW7WSdxMlHTbwfEf6h+lo6LJyYKmyGo3SzfdaBraU8vNwghqQQt/rVQ14r8
 u08z/5vTQ7GGTdEiH79WJMJ50mVaZWi+bJqUBfM=
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
2.48.1


