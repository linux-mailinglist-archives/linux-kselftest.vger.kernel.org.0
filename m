Return-Path: <linux-kselftest+bounces-25811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE73A28541
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 09:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FD11887FB7
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 08:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA8922A1CA;
	Wed,  5 Feb 2025 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Erus177P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E71229B1D;
	Wed,  5 Feb 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742634; cv=none; b=l814n+liRtnuRm2ffj023uT3rrAi3bWQk4P0ec/IsK7B3xQsyosq0TVM7dZHjDukXYHt/7e+Gc6coBMDCvfZxv47RBGFC483iivxpryL4762up7GB/whnen4i3+pZHPDByO6wKuawTYgLVfWp5OKXnDcF1oQ5XGnjC9d+EyHZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742634; c=relaxed/simple;
	bh=+YZ5hhbqsSdoHkrQKc9crEZAzX+V2vF2+KZyYqfVZ2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSHsotL9lfVums549symiZgpSPwwKKm7KNWSCP480Thndnbw44AWYxOXwL07FI5OTvRZZK4Qu2MFsN1RCWTPrFqaUo6k17/JcepYSCNvxT1AV0P20HHp1pPEQYocYtKzqBSu90B/iRVwSem3ZNu+4jeZud7a7A3rN04aF1AOsLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Erus177P; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2163dc5155fso114189705ad.0;
        Wed, 05 Feb 2025 00:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738742632; x=1739347432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oohsKtUUwnGGKkjPZNb8l1gsWj2Cd3htAnL2IY+fk9c=;
        b=Erus177PG/yREpGHH+k+5oOOb7jeO35MatkSW45SFNJepkdzRMAm0E9dI7+NWo7TlX
         3tfa6gn5KzuomwSuYMShJMsdJALUJHNrHPKGV5rS7YeyUdtf4gH6eu19OrUXOSTiFj+/
         POc4O+Mcq5OoCBU0FJfuKwBLk+3PGJvVUJd8ivYZp0tssdm9V1G9UP8zH0b9tIAuzQCD
         8WBvX68vMxA44/2yfkTB6n2xUgmW+M1KOHeN8JpdjcN9lgIO5TkUv9I2xYVkW8ccK1OL
         qqzba7JK2sMYldl64RNTMEWNoVzcUf8VElcrcC6JLYHtXGv0iz5zUKEHNyxqVLBf7qAv
         4IKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738742632; x=1739347432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oohsKtUUwnGGKkjPZNb8l1gsWj2Cd3htAnL2IY+fk9c=;
        b=pLLObhrCjeW86Dbt4KsnhXZ3hSWnvlufSEvcO/GP8TMgJkaVlnNflV0xdoMmUDniuY
         oWG9B3985Z3RsaZmYQT3S6YTvt4RISj5csMNjOPvEQJiIOfBs5gMb2LNxZ6nfh81qBXv
         KpJCXWgz9XWp3REDxdR9UCu0fSB6BTOH7dpTVGjkcm2N1J2OLiE2koRQWY+cZtXXpxvY
         BkGhOrCjF8i0IxXqU68JL7QZ9kM3vl5N3GSRTvFTGCfICwv0SZmMfTiml0F6vcHUV5l2
         sXu/QLGkFnaUdvYAKldkRJFsv+bT5U9g0o4XNFJ52TpFTQ2J0zUZeJKTB8btS6cCUsly
         TnfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkrHPWy6yGk/8cBzJrAu380PaKoJNmt5bL2KHWm2bQzFZFHzjbFsLe8wHwzN7rf7uN5RAwPdvnYRGI1tY=@vger.kernel.org, AJvYcCXwV445q8lv1gi6gHrTBKXMa/FCZKhsE0e3o8585REpJRTKebG7+8OrxoQhg388STmZ0dly+pLIFwds097AXz7l@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZCHQnpuPHRssQEqvsHyBsugjRlkS/Pmb+gNRRCk4rUzaV3Y9
	zWmBEyg0qsgE3Qqi6M2DzZLCPyZgKGzMP3xQ1gqVC0aTGDhWh/6mW8NsPhoqbEo=
X-Gm-Gg: ASbGncsrz2znHIs5uJ+ZNWUjhOh6V5n+wqH394xWkmE3RZTNooLvdUb4yzFTjmOFtwx
	IdU8F8nzfXFF09TAan9U76bfTA4Muvc2fdQMOEb9AD2CjY0qrigPKAdgBb4e3aZ1qJcxTNCem8a
	cmMEtzXsyfBBvt6vCV+qNPPDB4ciYTy3m6dAP//lIzKL+7Z3TxxXek1426SxYdG+kDFy7H+Jb3Y
	4AHg4xdMwHGp1J2YGLQzM9+Sq1uOWTnS/JLEJl3wc0sg5CHUld4pI2OADelG67zl/MHh6g2c0jk
	GqfI8tRSj4oLA9Qg2jr88nFtPeh0iW8c0E0=
X-Google-Smtp-Source: AGHT+IEdqhALOH2hwD5KHjpMFyik5doNogT7GDGuWNyAXQnaPAXH9lpRhB6vj3aLVJU3GarMH6MuuA==
X-Received: by 2002:a05:6a20:c887:b0:1e1:ba54:ffee with SMTP id adf61e73a8af0-1ede8845e50mr3804495637.21.1738742632240;
        Wed, 05 Feb 2025 00:03:52 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a18ae1sm11807039b3a.163.2025.02.05.00.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 00:03:51 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 1/2] bonding: fix incorrect MAC address setting to receive NA messages
Date: Wed,  5 Feb 2025 08:03:35 +0000
Message-ID: <20250205080336.2197369-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250205080336.2197369-1-liuhangbin@gmail.com>
References: <20250205080336.2197369-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to receive the neighbor solicitation messages on the backup slave,
we should add the NS target's corresponding MAC address. But the target in
bonding is a unicast addresses. We can't use it directly. Instead, we should
convert it to a Solicited-Node Multicast Address first and then convert
the multicast address to the right MAC address.

Fixes: 8eb36164d1a6 ("bonding: add ns target multicast address to slave device")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_options.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 327b6ecdc77e..63cf209dcdc9 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1246,6 +1246,7 @@ static void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool
 {
 	struct in6_addr *targets = bond->params.ns_targets;
 	char slot_maddr[MAX_ADDR_LEN];
+	struct in6_addr mcaddr;
 	int i;
 
 	if (!slave_can_set_ns_maddr(bond, slave))
@@ -1255,7 +1256,8 @@ static void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool
 		if (ipv6_addr_any(&targets[i]))
 			break;
 
-		if (!ndisc_mc_map(&targets[i], slot_maddr, slave->dev, 0)) {
+		addrconf_addr_solict_mult(&targets[i], &mcaddr);
+		if (!ndisc_mc_map(&mcaddr, slot_maddr, slave->dev, 0)) {
 			if (add)
 				dev_mc_add(slave->dev, slot_maddr);
 			else
-- 
2.39.5 (Apple Git-154)


