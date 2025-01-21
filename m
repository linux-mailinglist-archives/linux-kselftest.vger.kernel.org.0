Return-Path: <linux-kselftest+bounces-24828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80CBA179A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 09:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFA23A9B8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 08:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0087B1B87DF;
	Tue, 21 Jan 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZJCQnL0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEDD1B87C2;
	Tue, 21 Jan 2025 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449740; cv=none; b=fXeCtalgr5CBQvobHsG4wbx+i8soPPj9hmAixY4gYcoAdyxcOExuojSTmLp6Fps17GY1tlZ/sDNGQetgWDzuuPuuNA4FwvqclC6dhSrsCdsJlatmUoY5w7GWS+RZUbJ91mAdPHwGubMusiwnNRyhsFvU7Lph1CFI0sGRZYrTgG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449740; c=relaxed/simple;
	bh=BDKAnm03nCMql0XP9TjPeUam+/QucEI7RrkaEzsRqWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mgk7829hUF7xp0K35v1NnckKLV3VyjEKk2GclF90knfZuZ9a42po0SdITEUMuw/4pkZY6yWzMJgC++PPcJh32AIbEmnR+fj5qm5v3Y7+wcx8sdpoByuI95PxxEaZohKvCjBwbVJGkd36OYorSwehsD1E0EUqeAfwS+BHyuPMiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZJCQnL0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21661be2c2dso93867035ad.1;
        Tue, 21 Jan 2025 00:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737449738; x=1738054538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oa3MLh2GJnYf0RVvrJfYwNk4uvzIu7QZ3Q7ItLlQHkQ=;
        b=bZJCQnL09gSkxQOdi7ghraUKMQT9/eIopHVn45aZR+HWh86J83e5Y4IKVtzsXjESHU
         TR+FpJrgC58fMmuROlWg7hW/xcCVrsPhEZguBySW2Zr12g1A+rgonB8o49CN8peDJKKn
         t5OBkGoxaLcqWkMiBwgKxp3peHf5KRB/lbPmYIZZeWvJ0nSJvDTcEp3dpb29nnGDrr00
         8RJw7VXWNMQVvmM2314LvhgevOBFk3/iuWZd5YMtrkTRYb1QMH/oF+2sc9DilwnW0qRh
         DOyzyteVY/mBiO8LcI2GxqntAzF90BGHaEToC952rxstZt2RXmoAJX9Cc1Lg0AVtoUnb
         n24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737449738; x=1738054538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oa3MLh2GJnYf0RVvrJfYwNk4uvzIu7QZ3Q7ItLlQHkQ=;
        b=O7VoZIN0MBA5BMbHtSIOCcysLM8OTSuYV33UdkGpzNu++q5exH1xWb+qGl5vhA5/fC
         0HdHCddrAEaLaaLJo8WGt6PdMZLerWNTJVoIZ5I4yVHuvI8Goy7PYEuDDVi5mMAmYbNQ
         XPhETvFKlELjBc0BYDluvpVzaYP/bIVA5gQ8gQRjpezX5zOrHQebeo0M6tiMnEyqeC3O
         P/xdxBHZb9HLN/kSqUm1SmyQeObkVfIUoMBGSNpjr4eLo8JS04wpwE1YxcPMf6dkJcHM
         c38RMkAfkW8h0Qyfj+HYGwMRWRO7uglJCz1VWN95jd+DnhnpR2+5GWf86/NZYcmON6h/
         Mmzg==
X-Forwarded-Encrypted: i=1; AJvYcCUGIJAOnqjBuUVLLkaWCAlNF6UX3sMpIXeAGsYWUs1QlxyubM0Y1IwsR1usrFqP1pu0XJOKfX8L5vzq0DM=@vger.kernel.org, AJvYcCWx0fTvLN3lzUZQGD/Etuk29pwikCrq5/ZyZz1V9m1lCCG7CKOwIE67SpoaYotrJ0sLxgR2THyEXPzqmP90Nbxb@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZOmNkMac60nFdBOmOWVr5gfULJw9c4HMkNqiu77bH+l+J+ti
	nJZOdmB93Tk+8syF2Hq7lT3vU3bFxAUyTE3ae/AHE7E6ILKChsmvjJFqnTur3qM=
X-Gm-Gg: ASbGnctkkGlGrSlWxng/HjW3iSyWoerPnVBzPJfaOvYpDtBWBhAkPfn4MK1VKF0x+1U
	zEwX/audU7m6RHoQB7YmwygbNJ0qHnTyNLcT/63z8CRp1Rxq59rJHfEkRA9YzVSsw4aGMS7J1qN
	ivUBCsCimYVhIo1dwdBJWPh6FgypD2J7Cr5kxe3PGwKeZ/DhvlV1HCUOuknkbxJi+2tqE2DSdgd
	UAwRiuox77nVK1Mgmhy5PGhCkv0/oEvCNFC3+D+myKZgXBl+snsxai5HKMlrImtbRXjlzufbAhQ
	r+8m/DXFgKhm/A==
X-Google-Smtp-Source: AGHT+IGmlSM7Uu2JYDRHKidCaqG33ZWHKzpI3WyJVmLe4pQ6iLpSvb0FcRTtXgskve/ciKvHz6rt+Q==
X-Received: by 2002:a17:903:174c:b0:215:4394:40b5 with SMTP id d9443c01a7336-21c355dc59fmr239234925ad.43.1737449738403;
        Tue, 21 Jan 2025 00:55:38 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cebaebcsm73647475ad.99.2025.01.21.00.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 00:55:37 -0800 (PST)
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
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Liang Li <liali@redhat.com>
Subject: [PATCH net] Bonding: Fix support for gso_partial_features
Date: Tue, 21 Jan 2025 08:55:25 +0000
Message-ID: <20250121085525.176019-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fixed commit adds NETIF_F_GSO_ESP bit for bonding gso_partial_features.
However, if we don't set the dev NETIF_F_GSO_PARTIAL bit, the later
netdev_change_features() -> netdev_fix_features() will remove the
NETIF_F_GSO_ESP bit from the dev features. This causes ethtool to show
that the bond does not support tx-esp-segmentation. For example

 # ethtool -k bond0 | grep esp
 tx-esp-segmentation: off [requested on]
 esp-hw-offload: on
 esp-tx-csum-hw-offload: on

Add the NETIF_F_GSO_PARTIAL bit to bond dev features when set
gso_partial_features to fix this issue.

Fixes: 4861333b4217 ("bonding: add ESP offload features when slaves support")
Reported-by: Liang Li <liali@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7b78c2bada81..e1c054416d5e 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1598,10 +1598,12 @@ static void bond_compute_features(struct bonding *bond)
 	}
 	bond_dev->hard_header_len = max_hard_header_len;
 
-	if (gso_partial_features & NETIF_F_GSO_ESP)
+	if (gso_partial_features & NETIF_F_GSO_ESP) {
 		bond_dev->gso_partial_features |= NETIF_F_GSO_ESP;
-	else
+		bond_dev->features |= NETIF_F_GSO_PARTIAL;
+	} else {
 		bond_dev->gso_partial_features &= ~NETIF_F_GSO_ESP;
+	}
 
 done:
 	bond_dev->vlan_features = vlan_features;
-- 
2.39.5 (Apple Git-154)


