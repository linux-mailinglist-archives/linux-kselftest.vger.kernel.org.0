Return-Path: <linux-kselftest+bounces-38620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18773B1F170
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 02:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A1D1C818A0
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 00:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933B6174EE4;
	Sat,  9 Aug 2025 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp6sbqrE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFBE158DD4;
	Sat,  9 Aug 2025 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754698330; cv=none; b=NUWACNi+4766sd7+j7yKNGbXVd2+wgPaTO6YPmaOtbZ9/NMvat0Z7rE/c4ex2ypD/rVlGR9ge12IMRV1v8N7wa0RuEh5GK2na1wESK0rxu/tjD+vtKP3VJmi1LeUN8qBHt2Q9hn9XCHYYbsA3Us8u3cPb0rVzAHWH6BHLBECJ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754698330; c=relaxed/simple;
	bh=/byPVV+VMNKmftJfebXwe65jG0gcjrDuEVrZbGQmN7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQi1RzkgkQz9yAaLll98a3EMFZ9OzA2NFDw6fCSIqxCPGQvpURDUKbUs6XQDu2OMPRdeTTFKl/8XowrM5ytNpYwx/0lhybL5LvRPFrxkYK1gvv0UwB1WzCkVxw4q7bKWTNMv8sBRqYl9Ht2KHC0y5xIEI62rHpqGRJ5LzkSTnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp6sbqrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43A8C4CEED;
	Sat,  9 Aug 2025 00:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754698330;
	bh=/byPVV+VMNKmftJfebXwe65jG0gcjrDuEVrZbGQmN7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lp6sbqrE6Ikk1u682+Th3WaZCdPvcNRJnb/qN2U2wSQh6aLpZmdA5kb8M/RulhFVT
	 UsyocrHcLPfxk5K7/BLc0JcexSlcD0tLKrtl7f+A0OLtWFv3Tm45lgZqxgVCJvFFss
	 XaUumyDOi07v2rrz+/N02iqo9f2hplBu1Rn3dPm+4HO6otAuJIewIySc5GOinhDUkl
	 mRUKO2l+iJg6uyHmTF3poz1mdJyBh1DRZqVsvuIU2DoLd1+Aa/Zr9B3sLt+Iix1MXA
	 OPDLPzmxz8tpKOQ+ORM5SYEn50/o/Gn4rMjKj8YypT8aIBr4N/K+8Vc90Hn60It2MZ
	 NozehqsS+ncdA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	joe@dama.to,
	sdf@fomichev.me,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 3/3] net: prevent deadlocks when enabling NAPIs with mixed kthread config
Date: Fri,  8 Aug 2025 17:12:05 -0700
Message-ID: <20250809001205.1147153-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250809001205.1147153-1-kuba@kernel.org>
References: <20250809001205.1147153-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following order of calls currently deadlocks if:
 - device has threaded=1; and
 - NAPI has persistent config with threaded=0.

  netif_napi_add_weight_config()
    dev->threaded == 1
      napi_kthread_create()

  napi_enable()
    napi_restore_config()
      napi_set_threaded(0)
        napi_stop_kthread()
	  while (NAPIF_STATE_SCHED)
	    msleep(20)

We deadlock because disabled NAPI has STATE_SCHED set.
Creating a thread in netif_napi_add() just to destroy it in
napi_disable() is fairly ugly in the first place. Let's read
both the device config and the NAPI config in netif_napi_add().

Fixes: e6d76268813d ("net: Update threaded state in napi config in netif_set_threaded")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.h | 8 ++++++++
 net/core/dev.c | 5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.h b/net/core/dev.h
index ab69edc0c3e3..d6b08d435479 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -323,6 +323,14 @@ static inline enum netdev_napi_threaded napi_get_threaded(struct napi_struct *n)
 	return NETDEV_NAPI_THREADED_DISABLED;
 }
 
+static inline enum netdev_napi_threaded
+napi_get_threaded_config(struct net_device *dev, struct napi_struct *n)
+{
+	if (n->config)
+		return n->config->threaded;
+	return dev->threaded;
+}
+
 int napi_set_threaded(struct napi_struct *n,
 		      enum netdev_napi_threaded threaded);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index f180746382a1..5a3c0f40a93f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7357,8 +7357,9 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	 * Clear dev->threaded if kthread creation failed so that
 	 * threaded mode will not be enabled in napi_enable().
 	 */
-	if (dev->threaded && napi_kthread_create(napi))
-		dev->threaded = NETDEV_NAPI_THREADED_DISABLED;
+	if (napi_get_threaded_config(dev, napi))
+		if (napi_kthread_create(napi))
+			dev->threaded = NETDEV_NAPI_THREADED_DISABLED;
 	netif_napi_set_irq_locked(napi, -1);
 }
 EXPORT_SYMBOL(netif_napi_add_weight_locked);
-- 
2.50.1


