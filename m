Return-Path: <linux-kselftest+bounces-48907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 666CCD1CB88
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 07:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A74DF3011EDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 06:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF34E36E482;
	Wed, 14 Jan 2026 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoQPAe4v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889162D877E
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373393; cv=none; b=GHxpSFDo+k+q/r1qaFCf0eVpnlThWBr0Q3BdLZgqhcqv0MEcNKswWtuuh2D6Mskn62b4t5XUQEJ8BuCxGYXzIFMxQDkxxzIK8nEKoS27ej7AOZDEpfLpkelJfflRCH9Nx952frybveLUEBUsXGPpcUuEcEWomzvUU1iJdeHyTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373393; c=relaxed/simple;
	bh=R83SnLC3hEHC9wZZDBppvcqZrdMQG+Fw3T4DHIz875Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AOwL578dxL7R0plFZBCqLjAb2dAhHHfbEjb86jMPTCUMdfH3Qisp1ARSr72/a1JS2OM4KJRnROVSYmyJ4PdhY+OBn7g1Smao50GnkytI7o0Z3vmFYmuXj5zZKUSISNYcubhzXOYWBm5cxK5mLw62MiHL2bnLQHRZL/rgrO9qvGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoQPAe4v; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0bae9aca3so52844385ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 22:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768373385; x=1768978185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSq5SKgkR03RwVwaqOkyPPbDCNJIaruy2ZKmaKvy1cM=;
        b=OoQPAe4vuKys/P9R2dcUqvba9QGhB3QLGHv7SKlE91MV2vbaqpWOSWVnZZ8uEXXxKH
         1mbphLdzzXOrq16wfXvkcLpAaccNHJtOGUgpMKyupxY0ibpvS3NLZbRZ4Tprznh08IAa
         TndruNaV/GYLq9mq1zTDL4xZcMxUdhP5loq+JIKW95uxoroXPsK+8byKOkNlwz/kaaXM
         jH/aXgLSqRehdFCsafNF7F0E4R/PmM88cZJhisbD5mzLyMYtSvse1ZJmRTJE2ZKag+X1
         qqVC/XKa/QdcQSeW5Vljekoqav3Q+XIG6d4WClyXNahbw8QGDpRTzQEHOafWzmBhG3GJ
         gb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768373385; x=1768978185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSq5SKgkR03RwVwaqOkyPPbDCNJIaruy2ZKmaKvy1cM=;
        b=k7kBNY44d9ZnsgHRvf79qBFb2boNIXwc4KM1kV50/hOQkZ6l7rRKyNzhnGoW1JBuri
         iiwLiLWFXj9GyDOyGzwitPfFQbJ9+/g3pTJU6dQQ/35lyhw7huhxRRi0CvWCW2Ji/7gb
         38eGR4wbjxA9+BezJZfl47QBqJCJYoXk+u+Ip2mOzDGJVRSjwtbPF2kVBQHDJ9YX1X4j
         TJe1e6V14uyP0RrnYo0REZ00mTmlb5eETZAINeN5sZZ0NCKRx3PdXWMKF2P3YGH14dlk
         pwfC2vjGHYp0s7LEQhSCoxvsT9tsgANKRDRY4v8GYvCv37J5GTAP7MTLjLPz/LTfFMnp
         mbsw==
X-Forwarded-Encrypted: i=1; AJvYcCVzOkab4FoqjL70oz1dc6C4nmZlVtfXPphueRaYHgXajC4Beh6NzghvvqPizxyviqF0+j+qyiqVDk1br4SWDuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPNyI8HJQpmQWXAPKsd13FTv46r4KsdSOUKgB0vklpNSBQFJUa
	+Cn56xX7OsMUf1TwkSKsnyTzmJ6PZf8xYIOwDtwJ+GW2zQBK9hrOt9IJ
X-Gm-Gg: AY/fxX50cK5H6k1H6cIkz7w6sSfRR0JOv/UFdqAvYkixRzK65TklZFjiGJJXrmdWNBu
	96NurKG6m/296HdhueOshJsSFArhSySQGgK5V/YOhgwVPFIHTer1kljhHm7oJ5locBOPKLpJJ1P
	JlYVw6ebY7g0IblWmdyZI2c1So0ZsPmbCi7mNr6k8VHf1oaDxey0NFt0pO76tcXKu6T+sbtmmSM
	rp+aUsv/E/DNLhgMBLP7Vmn2mhrd+39gP+Gw99Jop5zfNLAis+NJl+ypHAlor2OBh10bSrWjioP
	1qHvQXvlsJDFgUJsqM9onuss1fLxG/Hbd328O1CiWoHjxG/5RtR0mbtpGInTQVRIWvNN9eIymax
	nl9gMad034JF5dwoW+kVEc4p7ReekCfGT6pOPe60E6s5zfKuxkh6QLUPReENLN9k6yENyaZo0rG
	DkuwIDFEN+ST81Ffc=
X-Received: by 2002:a17:903:18a:b0:29d:6b8e:d565 with SMTP id d9443c01a7336-2a599e28a55mr16305815ad.38.1768373384983;
        Tue, 13 Jan 2026 22:49:44 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd492fsm96315525ad.98.2026.01.13.22.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 22:49:44 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 0/3] bonding: fix 802.3ad churn machine and port state issues
Date: Wed, 14 Jan 2026 06:49:18 +0000
Message-ID: <20260114064921.57686-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes two issues in the bonding 802.3ad implementation
related to port state management and churn detection:

1. When disabling a port, we need to set AD_RX_PORT_DISABLED to ensure
   proper state machine transitions, preventing ports from getting stuck
   in AD_RX_CURRENT state.

2. The ad_churn_machine implementation is restructured to follow IEEE
   802.1AX-2014 specifications correctly. The current implementation has
   several issues: it doesn't transition to "none" state immediately when
   synchronization is achieved, and can get stuck in churned state in
   multi-aggregator scenarios.

3. Selftests are enhanced to validate both mux state machine and churn
   state logic under aggregator selection and failover scenarios.

These changes ensure proper LACP state machine behavior and fix issues
where ports could remain in incorrect states during aggregator failover.


v2:
  * The changes are large and not urgent. Post to net-next as Paolo suggested
  * set AD_RX_PORT_DISABLED only in ad_agg_selection_logic to avoid side effect. (Paolo Abeni)
  * remove actor_churn as it can only be true when the state is ACTOR_CHURN (Paolo Abeni)
  * remove AD_PORT_CHURNED since we don't need it anywhere (Paolo Abeni)
  * I didn't add new helper for ad_churn_machine() as it looks not help much.

v1: https://lore.kernel.org/netdev/20251124043310.34073-1-liuhangbin@gmail.com

Hangbin Liu (3):
  bonding: set AD_RX_PORT_DISABLED when disabling a port
  bonding: restructure ad_churn_machine
  selftests: bonding: add mux and churn state testing

 drivers/net/bonding/bond_3ad.c                | 97 ++++++++++++++-----
 .../selftests/drivers/net/bonding/Makefile    |  2 +-
 ...nd_lacp_prio.sh => bond_lacp_ad_select.sh} | 73 ++++++++++++++
 3 files changed, 146 insertions(+), 26 deletions(-)
 rename tools/testing/selftests/drivers/net/bonding/{bond_lacp_prio.sh => bond_lacp_ad_select.sh} (64%)

-- 
2.50.1


