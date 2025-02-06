Return-Path: <linux-kselftest+bounces-25899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6F9A2A4F4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 10:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE74116149C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12408226888;
	Thu,  6 Feb 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzLwHb2p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A1226195;
	Thu,  6 Feb 2025 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835179; cv=none; b=tyEPx+6Uobqv2cbV8WZFp3Y8Wg0TU4iRghZdDHWi5DR4y8lFo5oBDOkKxbgwpmie89CFGkBZfdT+FWObfRQj22VAHliMQHjW5u6iDckSQEKVFaD4HZVRzgHIuwjst6Etvetq5KrkPEJozv8QOT0BGw/hcCPWjdl92TV/u5oCYfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835179; c=relaxed/simple;
	bh=yHi42OoYXOYcDdfvKrierQhOyZCv7bVPZPo59KgjX4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiHN5XYQ7jygbYJ6Jn3t6AdUK7RqZh0/otEhd2T39/IgMVUP4IPZvB4QzFDw0r1j8D9ahK1iq0ba7Fjf2TFDsyDn0I8qTOJ8U13tAiUWzafOVnuaZ7SuPMuZgLHpRNRZivK/aNp81jfN1oZDlurzqzpFj09Btttbt/DxMv8dxX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzLwHb2p; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f833af7a09so936190a91.2;
        Thu, 06 Feb 2025 01:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738835176; x=1739439976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCPMC7StlyyKP7rDHpNBxbTd/AxRdGidh75hj0GUUPQ=;
        b=QzLwHb2pIAu0B+jxkT8486kkf/YMMwirq1iMR5Nc4dDnuU7dEPxfsFSz8TEZBfVAMR
         frQtcYGlzcx+MetF8WhnvBsFNJzp2N1WQ/F95eJw7Wtd50NNKWhVyuuWib71GTjHshK+
         3QjKkoabaWsjjENAllDTPlZmzuFtsUSRBgEp0ZohS52pGhznjFOuS1T6p7SD5SrUOZnO
         zr2jTt5m5e7qPmxeJROnwWcqyz3lyo+jIvjpL6A3zQIgggumICrrsbFELKVpf3BrSSdK
         6chv0pJXH2/IJuQEVAm5vCoIwMvgXO/79mWFiHm6GubDcEnUUQDVGbQ1yojrQpfqSdCa
         Y2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738835176; x=1739439976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCPMC7StlyyKP7rDHpNBxbTd/AxRdGidh75hj0GUUPQ=;
        b=J+3aIx+LdymrVr1eZvAboJsk9pgTfkEPFe8WtBdXtl8BOFFvwQrY4QYKrmZxft3EJI
         ua+2gjKU61Jdg3ZuHDiPF+JBoPm1VKDUU0Y7qFWhwoJGnNstk9Rj8sEdfhym0FRMjKkK
         2MjLqR11LNStXEb/LC0XGzBRmhNDbLo+jO/URc8NZJ6HObttfHjWdXkl2ADtAfItYhyp
         F0XYcoTurACBshsPWTZ+K1YQyScYPmRW/dGQAjU1PI5Wsf1/NzKS4SO8tFnwSTAi7Q9d
         2WKLEvHciyyjpl96OE4g0P06opuEM9WIDtQVRHIcjBiQyPdyQ+sL+srDu5WhRs6IJqq6
         wYQw==
X-Forwarded-Encrypted: i=1; AJvYcCXCtzfbA9Bk3H69XIIbDJX6Z/smjQ93bIP8dzpBduk+WKLSyeHRihCKoIvo3yRtiX3EkR2LHizDXfwl1xua0NGf@vger.kernel.org, AJvYcCXHN5TzhrGY4wTxF9xz0ZnWg2ZO3twbhSgw7hLp/DSrN/p6p7S11CabUvq1IKuPH04HITMz3076y99xoYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSqE+i0yWDBKZh2/ol2G1Ik/UJwgs96ZcBPVd/3B1QaIJM0jiX
	V9s6YQaXh59kwmgGlNM4oj7CnufANPzebAXGGi3b9kubes4nHWNtvN2WnVl6W0s=
X-Gm-Gg: ASbGncvwhjfSC9jmtb64KC8Y5lUpOz2JsQxYkPmuMpYx7iQSwqH70J6mHyK9Mbqw1If
	F03slIy+l7ozI/o2dGp6c04/kqG8Za6sTHL/ldpfwoCQ1IGDL/CFZFGgyzzBIDbkgwnRL+kshyS
	TkwlixDJxoFDB76czOEUhd4OygePAMnIR4nacawTH7I2mMo+HvNlwHVvZr3ttCC0vrM7E4Cj0Xi
	pO1JcdH3zO8THZpApCS0RtnkJPDtitzAuiT3FGM0kl417z7Ztr0LlbKBLNd2xy9+xUiPiA84zIN
	kKieFYNUbqKUdPluax7drXiDC8eRJSTve0Y=
X-Google-Smtp-Source: AGHT+IGUXIjSeh0EP5SREwFMbL/X/urQkGoF5NDe2OPP7UQ8Hibu24zP0GqYvQjbIBDu/waHpFddGA==
X-Received: by 2002:a17:90b:4aca:b0:2ee:3fa7:ef4d with SMTP id 98e67ed59e1d1-2f9e0834424mr10823831a91.24.1738835176423;
        Thu, 06 Feb 2025 01:46:16 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368da60bsm8394695ad.258.2025.02.06.01.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:46:16 -0800 (PST)
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
Subject: [PATCHv2 net 1/2] bonding: fix incorrect MAC address setting to receive NS messages
Date: Thu,  6 Feb 2025 09:45:59 +0000
Message-ID: <20250206094600.357420-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250206094600.357420-1-liuhangbin@gmail.com>
References: <20250206094600.357420-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When validation on the backup slave is enabled, we need to validate the
Neighbor Solicitation (NS) messages received on the backup slave. To
receive these messages, the correct destination MAC address must be added
to the slave. However, the target in bonding is a unicast address, which
we cannot use directly. Instead, we should first convert it to a
Solicited-Node Multicast Address and then derive the corresponding MAC
address.

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
2.46.0


