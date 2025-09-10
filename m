Return-Path: <linux-kselftest+bounces-41101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1731B50C42
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 05:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E763A264D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 03:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E2D2571C7;
	Wed, 10 Sep 2025 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwUGvzXh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87DB137750;
	Wed, 10 Sep 2025 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757474403; cv=none; b=hwl0cGZvPXCA8f+7Wr9StnCt38lJfrRgP3t0XXH5M++1W297ORfrWFQlflKworrQgQ/b23dc6BEqAmiFsRb9ILRgRpsjE4OacpRWVbvpZAP/TQTQrtHXarb271OZWxAzMvjFEGFYN/LkljoS2OBX+2AdrzXQpg8C/AmE5Ef/UYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757474403; c=relaxed/simple;
	bh=edMboBqpV+c/SWWCaYM/Emlr2efUoLGPbtc76VqsCKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K5xlRuCJF2ERP+wx4O3sFTnnf6VmqR5zGqHsXP4aV2WepTlypkq07TLQCtG5fWILu+Cjn3Z9MczZf6IDtS9sgTYcQqAk+ysdstJRvRT48Bdw1VFp5oLHCXfpQ7bGnwUATUV7S8pL6ABCg0gTtH3pGOYDZrpVJ6k9cNccQ3ijzJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwUGvzXh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77269d19280so5813295b3a.3;
        Tue, 09 Sep 2025 20:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757474401; x=1758079201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rsl93Xqa2i9RSlCPVdYRuHUPMJ3D0CyaFu//J8FzEaE=;
        b=JwUGvzXh91dCulyb6YXvZIIKcOsozPFE0nUaLzKgt4SLi+G5vn+URAx90SRPbc0Tns
         zNHJiBc7D5x4q73H114hZfYo0R2dyEh+UjUWq+75cFXzeeBQCKlqy3CmMxoPsJPlnKc8
         0yfQAZk404fS9XRVpMbF8gxnmPLBNgKRDWuOv3WhCOR9xalzLDr+2KWc79EGEWZrSFeO
         +igF7NXK88TrZNOdQtUDwHcAln1WSUtmkwNeg1XcYD0kIfP4RFN1d+p3Xu4/4BHOqkDk
         d394h7xkmBg7VK20p4BL7IFgoz/oq7DqcKZwaRr8tAsggHYcdD/DPXEIsd3dOTl/bt2k
         ffsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757474401; x=1758079201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rsl93Xqa2i9RSlCPVdYRuHUPMJ3D0CyaFu//J8FzEaE=;
        b=ghRgjCGXdZe77hQuDHD6G5Yra6CbPaVRtBWXOgjc1ZRpsFP15h+mrQlL8wzlpaqbEC
         v7VW6Pwgwz6yMPjWUh5bHMZjfsYIrAW/bbtxp6FhlXAvhVTMDPV+DXS/pAv+ixGQi+Po
         xC0tdaHO6NcZfea/HqI9/T9LfauY0dJaAg5x9Tzp6SrbXtU8I9ygWFXgBA+UTP7b9UV8
         fMwxOZukUYKdPDXahOlauhmMDJAOHW5/i3ChcW7ht8aUrDdLlpcaFw7v/FIsFBP7sUu7
         9irn2V6ZiiCLlhz8bOcbON9rY6GXiFwL0ToPKSiQnyMdgqBiWujcsZguMcOz/jobl8wJ
         46ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDzb7CTD3tidqnnsWhSsrbu43fMCGkmMiPbJjDQkN1a62pqBrxp59opgwDq8iXHMVgPw4nDwzoFDcwGLIkUsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAu4hwNtStnLUDknjYD/LfEqPiWKD5SKIJ+EsMXcWFnSkgzmBC
	skrmZdd5IKb3/j3yi0oeBnV0JHe5HZC96QyljOqHvHOKrvr0cU9nx6kn1e2AAmGT
X-Gm-Gg: ASbGncsl9DCN8oHvbuaAT/+3NjQxsky07G5N7GOGPO3ipAnK7QK1oX0rJ1yN0bhE8XY
	TxZ6JDGUC3BRU81Bt3Q76sWu1flgtsLEN0KSgtAU6CRhuTF1AZnG6/YCkU4kR5y5pk3bqMSb3hp
	oSLvvZJJfAI8NQIPymw3c7PBEVzgU9BjZSsuILOY15mt7hTxM2ywrKp0jX0QM6ymw4geRAEFynJ
	YlnxpBEaZTunY4nG2wYpdF8kPAtK1xkP2xeMnCdehZcl0Gjg0KV4Wg0QaktYyJBBU0AgALv5UpA
	00zP00uMF8O4HeYM18simPF4GCwKO01pdwUGlpVUv7dZg1MkF1m2rceeHHWp395ZQfHmSmbEsDz
	AVZlGRy5cA1Y00LmnkMT9oW7ueihmFfua/elsW+INBDxbnfop4Qu/
X-Google-Smtp-Source: AGHT+IHW0yfu3nzMddMIzQMkH08njRI+DCPb2Ocmq8LbcfMJx2wcEy9Bn/hFiC6/CRYxEOUmVjwudA==
X-Received: by 2002:a05:6a00:3cc9:b0:772:a5c:6eea with SMTP id d2e1a72fcca58-7742ddf0f44mr19112441b3a.17.1757474400986;
        Tue, 09 Sep 2025 20:20:00 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774661247cdsm3554308b3a.33.2025.09.09.20.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 20:20:00 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	David Wilder <wilder@us.ibm.com>
Subject: [PATCHv3 net 1/2] bonding: don't set oif to bond dev when getting NS target destination
Date: Wed, 10 Sep 2025 03:19:45 +0000
Message-ID: <20250910031946.400430-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike IPv4, IPv6 routing strictly requires the source address to be valid
on the outgoing interface. If the NS target is set to a remote VLAN interface,
and the source address is also configured on a VLAN over a bond interface,
setting the oif to the bond device will fail to retrieve the correct
destination route.

Fix this by not setting the oif to the bond device when retrieving the NS
target destination. This allows the correct destination device (the VLAN
interface) to be determined, so that bond_verify_device_path can return the
proper VLAN tags for sending NS messages.

Reported-by: David Wilder <wilder@us.ibm.com>
Closes: https://lore.kernel.org/netdev/aGOKggdfjv0cApTO@fedora/
Suggested-by: Jay Vosburgh <jv@jvosburgh.net>
Tested-by: David Wilder <wilder@us.ibm.com>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

v3: no update
v2: split the patch into 2 parts, the kernel change and test update (Jay Vosburgh)

---
 drivers/net/bonding/bond_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 257333c88710..30cf97f4e814 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3355,7 +3355,6 @@ static void bond_ns_send_all(struct bonding *bond, struct slave *slave)
 		/* Find out through which dev should the packet go */
 		memset(&fl6, 0, sizeof(struct flowi6));
 		fl6.daddr = targets[i];
-		fl6.flowi6_oif = bond->dev->ifindex;
 
 		dst = ip6_route_output(dev_net(bond->dev), NULL, &fl6);
 		if (dst->error) {
-- 
2.50.1


