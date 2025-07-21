Return-Path: <linux-kselftest+bounces-37763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C119EB0C921
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 18:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3B41C21C60
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF2F2E0B6C;
	Mon, 21 Jul 2025 16:54:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5AB2E092A;
	Mon, 21 Jul 2025 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753116867; cv=none; b=KKlLKlMQeCieubDPamFEsac0szpaToYNyO2GxruM9yyFO5U3zMHn80m6pE/f/VL59cP0Q1RCAz94zSIpqyhiMfJXAgs/vwOidm0OmM6LB67xsWvsdb42sYu4VCBg0WUGj83eE9kwRkYVlBfJDa2+RQLgZB3kWTk36UcKJDVjVdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753116867; c=relaxed/simple;
	bh=9zScX5PNe0+7/FgZals5GcxzDyjHrEVpWnihwf3NZ3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJziPqhc9LHsYecBE9CRf/hMheT6dVOhUVPKm3QyNEKsJnp1wWiSxVudaupPBAS5gGUpOi2nuO7+pPy2gCyRg32Svl8WeGxKH9Q45xZPDinpSs2qq/12fcggixoPwDA6P0+vSwYnaLmreqvkHlx+K5alyPkNLt6JPiTrJ5kxQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234d3261631so36192645ad.1;
        Mon, 21 Jul 2025 09:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753116864; x=1753721664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0iZETPpNVIspnegsemsZ7mwLpZ1Y/g9GMuYWlB+K90=;
        b=dylWwJGoCSEXUSaBf2+iV1wH0M9j6OYK/8c+MdgirwTT/5xWU+0SPze6RYtzw3SDC7
         tgVeEO0/lyCDg4Ohy1xwsUE8oguS0G8TfAAmmVVDQc6Ozr4gosNJ5XZJrt3dpdjcQFoQ
         IxmAQmnI9PQiUU2gZGqGrFIRiKIK+mPk4F0V7VssHqFNWa/ZtuqPVi7OZWuFEEOwsjtP
         zCRejMtz3XedWmBZJjV5o0TStIkkBOn+MbUJbeWodjAbyyAXyLvZEHMNtmZPO3uJliqr
         uAf0n8PPBwGdiGpQxep/n0Bzci9GXVcwVc+e/6YaGB1BXnVt9eM2hY1MsE0OnQ2HVP2i
         eGbw==
X-Forwarded-Encrypted: i=1; AJvYcCUhND4mFEFu11YK8SQwt/Wzi3Im9RGIL/Kdau3c0mL/yiqUCi3BuFd365haUPTthHThvDS9p8n+VsAe4usZ1KmJ@vger.kernel.org, AJvYcCXkQ9k7HtglUEJysqRp/bkynvWpXGIvpz38Url7LM/nA1WxQ4THZRbP/0i3xgoorQ0JWO5aFxNxtenjoHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxvegPJVjawXPxU3R1S6upDHVWHavUhggwufjTxG0I5Txz0/5s
	i+cLGmjN37q1ol/VKzGwVdPzlwqKNCXnhP5yOAZIaLqhm8LgCJn3bWKhHjss
X-Gm-Gg: ASbGncv6Ro2GED4BaQzOR9Aj7pCsvjlhwrKs7z2DUFh9evQ5YgZou2cYIsK34Rpm9RN
	3L6gBdMWO4A9qniI5iKpCvjDPeAc3cRvh3KcrNLb3CQ+y+g2BXtETBvn3V9tfy1NRNkARIKEboy
	k+2f2cY80oizLb1+aj63y7bjUQiV6liKamCU1x0cFBwa7WnvIb1dbAurWWvDlsDwTU9hruaBHRJ
	MBDLnmw9A1xtpqN0zlMhaNCm9j07OYJSK7YshlYcgMR1wz7NSHQt/iX8C+e3MVI3Hjcm0fL2nUz
	g2gBdrlT6lx4JJtWfiR1q8yxlYbXMUkOWw9jEVN7WEG/ea4G+WxCKenI2sBCnuWGLxpkS6HsXG8
	qzeMSxoXWqIUVQ4gnTLKj8vohnZkfJEnW5jhBW+JXhekRmGyxFtIeGPtZI0g=
X-Google-Smtp-Source: AGHT+IG4I834Pck48TSvkbY8IpDj4iVjmIr8H73mP5ZcsJhvdJqECZS2+m8rFtqDwo0CMscLP0VA8w==
X-Received: by 2002:a17:902:f906:b0:234:d1f2:da31 with SMTP id d9443c01a7336-23e3b766079mr140974035ad.2.1753116864398;
        Mon, 21 Jul 2025 09:54:24 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b6b6032sm60833035ad.86.2025.07.21.09.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 09:54:24 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net 1/2] macsec: set IFF_UNICAST_FLT priv flag
Date: Mon, 21 Jul 2025 09:54:22 -0700
Message-ID: <20250721165423.990313-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cosmin reports the following locking issue:

  # BUG: sleeping function called from invalid context at
  kernel/locking/mutex.c:275
  #   dump_stack_lvl+0x4f/0x60
  #   __might_resched+0xeb/0x140
  #   mutex_lock+0x1a/0x40
  #   dev_set_promiscuity+0x26/0x90
  #   __dev_set_promiscuity+0x85/0x170
  #   __dev_set_rx_mode+0x69/0xa0
  #   dev_uc_add+0x6d/0x80
  #   vlan_dev_open+0x5f/0x120 [8021q]
  #  __dev_open+0x10c/0x2a0
  #  __dev_change_flags+0x1a4/0x210
  #  netif_change_flags+0x22/0x60
  #  do_setlink.isra.0+0xdb0/0x10f0
  #  rtnl_newlink+0x797/0xb00
  #  rtnetlink_rcv_msg+0x1cb/0x3f0
  #  netlink_rcv_skb+0x53/0x100
  #  netlink_unicast+0x273/0x3b0
  #  netlink_sendmsg+0x1f2/0x430

Which is similar to recent syzkaller reports in [0] and [1] and triggers
because macsec does not advertise IFF_UNICAST_FLT although it has proper
ndo_set_rx_mode callback that takes care of pushing uc/mc addresses
down to the real device.

In general, dev_uc_add call path is problematic for stacking
non-IFF_UNICAST_FLT because we might grab netdev instance lock under
addr_list_lock spinlock, so this is not a systemic fix.

0: https://lore.kernel.org/netdev/686d55b4.050a0220.1ffab7.0014.GAE@google.com
1: https://lore.kernel.org/netdev/68712acf.a00a0220.26a83e.0051.GAE@google.com/
Link: 2aff4342b0f5b1539c02ffd8df4c7e58dd9746e7.camel@nvidia.com
Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
Reported-by: Cosmin Ratiu <cratiu@nvidia.com>
Tested-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/macsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 7edbe76b5455..4c75d1fea552 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3868,7 +3868,7 @@ static void macsec_setup(struct net_device *dev)
 	ether_setup(dev);
 	dev->min_mtu = 0;
 	dev->max_mtu = ETH_MAX_MTU;
-	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_NO_QUEUE | IFF_UNICAST_FLT;
 	dev->netdev_ops = &macsec_netdev_ops;
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = macsec_free_netdev;
-- 
2.50.1


