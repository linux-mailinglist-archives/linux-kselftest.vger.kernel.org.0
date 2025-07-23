Return-Path: <linux-kselftest+bounces-37897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA59DB0FD15
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 00:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1763AF028
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 22:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EC32343C2;
	Wed, 23 Jul 2025 22:47:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F1D86340;
	Wed, 23 Jul 2025 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753310838; cv=none; b=Fp+AQG8w5n/r9EKYFWJCGPN0XZ3GOr86225Hb0diegoTqyMdaPxjPVExNgZJxJIPhcTxSECNZIeILJbM26Q2VK6UNuGenZwzEKnYFCfzdtIF3jlkuGve5419Z0aMELqYAMaa+yTeZnrLFTQan+NHRjRJtm12puCTuFdauyolmgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753310838; c=relaxed/simple;
	bh=qxud6TWTuT/i2xJTCPl+cb5qpmtrDGSXXC3RSF4ppNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ceevHpEupacjFGE05c+ZvjyGW5WUjUmK6VXkGaCvWv7iUKHpcgsOg9ECIT/yNT0E4PRw3scw1TgBRGhT78FqS+zuV2h/P58jFirnHmg4z/MaPuyiDnahaf6uckMf++raDBVxVpdgV2KmtLeBPzz2RCIc3PN4VOB3RFG+bVjVkf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so521487a12.3;
        Wed, 23 Jul 2025 15:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753310836; x=1753915636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZfbKihTA0SiaLa7tBR1egf/LlbjjRZjDe/A603Gvgk=;
        b=wvlOmKOPq7x2itPrVDH+OkRcrmDA1r+N5Ah4Fg5Kx12NNnklubTsCBpDqFyAQqlb4a
         8l5rCND4QnmncpcGWRQCsDK9JDtyCRC0aBfGX5OZr+WlbrO0hwJBMR/jl/Agq/97Rtsa
         dHuD9UqTeSxzxLcsOQkFH3pQRuJpLWfN0VP1q3dFPUDhC3LQj1DeDa4WDhN1blvtrc57
         UJWcWvc528zfnXtk/6WnjpG2F2ipT7C1h6hKm+oqS0qci8w4SrpWTwR5L8ULCS4LTgyh
         WR+klp8wnrGGTpZnPySELfn8AMNIql6fAYWgL7ZDNNl+thE3H9vSbrksLmOo4JzH2ao0
         bNMA==
X-Forwarded-Encrypted: i=1; AJvYcCVNqqrLHgC/SanYtbAICO6ofzfkVH/7bmHoRfaljy3lpthkXMuG05PibjDyqO2+fFNZskMdy+mA+xjsXD1ZxTqH@vger.kernel.org, AJvYcCVfEUKuALidpToVmo/zro+jyQxW0EGz8/gTGw8zmERa58aQY+UK9AcjfnLdwjqIBd4d5Ws8NSYZ0LYT6MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmbh/ilUcvf4xl0oDby+oiz7TyJsjeEs1X63zJ+89TC/akaIC
	mLjL+0CsnI85be+UPro6OnaZ36bIkrBo+WrUcJnp+InaYxYdfMCfoDk8A3nB
X-Gm-Gg: ASbGncvLEuIMMdJtoD/9KL/af8tdTMBrSF+sjd0amLqLOEyzNSeHPRS2+fs8sFm2xJN
	P3cq3ha9cit6EKKmtcuJzAk4w1zJ+IM9SiNqRBNxTIHYPAPDpOw2baKwYHkBP7rMCTIWtXOhU8p
	6a1u3zU7Pxy9WuObE2xwrpW4rnsBoPOjUck6Psn4d9cyzQR1hqaw7vNZ235tJpuZbjKQ4S6wgDT
	p0VA8Gb+inS1R8MVqno1J/Mypi4P6pMKZ/I11p7sm0vhbPfbBi7bgY7Hwvm5a9/bDjoRwbcpjdA
	3HWypIcAQVVMeeuqD/B7x7tmkX14SZCb73lqvBXCYZWdUnW2/+UN15YYOTOCvgraMpVTmbNY0/x
	F0pSzcnCN7u0oTkCQFkFWQ7cjbWVEKftNMv9W3shTTHo+MhGOySBx3jC7h98=
X-Google-Smtp-Source: AGHT+IG7wfbNYJEtHjTmClp6E4Cek1JDdZAHYrC1evfdW/3PsdkbT0HMCkBigx05bAeFOdf5kQgaYg==
X-Received: by 2002:a05:6a21:6f13:b0:220:a3de:a083 with SMTP id adf61e73a8af0-23d4903f5aemr6883847637.10.1753310835862;
        Wed, 23 Jul 2025 15:47:15 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-761ae158001sm184593b3a.31.2025.07.23.15.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:47:15 -0700 (PDT)
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
Subject: [PATCH net v2 1/2] macsec: set IFF_UNICAST_FLT priv flag
Date: Wed, 23 Jul 2025 15:47:14 -0700
Message-ID: <20250723224715.1341121-1-sdf@fomichev.me>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/netdev/2aff4342b0f5b1539c02ffd8df4c7e58dd9746e7.camel@nvidia.com
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


