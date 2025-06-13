Return-Path: <linux-kselftest+bounces-34965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8B0AD9663
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 22:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E600C188496F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D16125BEF0;
	Fri, 13 Jun 2025 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0AqIZUy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B8425B1FF;
	Fri, 13 Jun 2025 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846814; cv=none; b=MYNuT/oZ/zS8eDzF36hNYuxZjN26k592g47sG54Jxxh9vX5PBpF+5f2c/HYh3RrBbXkvMzOLtPDDZDCHS3uUVFxk0jwfc75OTPrABhQHL/78pkmdO8Y0X3ggha2viNweftVbEYGSVe1gzcSqE0WsUylFyOh944r8o4gpQ/A160E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846814; c=relaxed/simple;
	bh=ctkVmqF3JrN4+M3Jq2BUDPgQr7j2TwSOV9URy1jJ6Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTfCmS7a23p1PT+uotsUAaZyUzjwKIQAPIb5m8V5L69ShKmBm92xZSfQ7EmBftCkB6ZZb26hFq90gs4kvr6K5CKTunnHtI6Yxf170gOx9oxphyghIrNw3LWI7J3aRiwbsV50lUPpvmotcJwJvm4zchJ42FgBwWdxN6ZwxThgIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0AqIZUy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2fb8226e1cso3640425a12.0;
        Fri, 13 Jun 2025 13:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749846812; x=1750451612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOzLGPoCr0MeSXGXJzKmOKNWDgmi51GcdPfztdwS3U8=;
        b=H0AqIZUyH6kDbw2CPOFknZeAGIlhiSpQsNBD49ejYiwSPtBi8mMXes8Iu1xCgF8E2W
         SID74HnkXQGp9D+v4cviPWDkLm29O/mRLntFOlB+K4FgtrZzSgVRXJxrAmyqt80/vy2f
         dozGKOV6Qh2uVqJD7+hwR5vM5Z/rEHk6gGXKDi7JP9Xb+FudgTd6WPrujCHCksFj5xJ8
         EtTdZmfjrPADivfDDhThysEsjyohqVdosYoI7raZVhKc5/dupXR2gH614MNkuHyi5MzF
         IyT51o2OamJ48r941oNM6ie2xNazAkEDMc1f/rMpFXe2UV5lNheoPLpR11+rpXdNeojT
         kpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846812; x=1750451612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOzLGPoCr0MeSXGXJzKmOKNWDgmi51GcdPfztdwS3U8=;
        b=DjqzX5P56/6WWzgicUwF74cKsIytziNTRQdfduFjYz26IuZ93+bPJWE47Dv0jrGc+g
         Yij6jHMeWPsGKS80ZVg0NAu1av0gWtFmA0eq9txC91+68g0y9SR9LSgnVNPihoICYUFF
         cZ3m/olkQurf/0OAL0Gw/AUhHbA+UOwiopncEOR28l/kFDx04DfAorD54C3L0bfNAXlu
         Lwc5tdpEg/ueImOAJOIvZuD4LyezelSxmIXwhzV5bnfy/bGlE45kTRjYJ7xruAEn8oNE
         jm/2eepG8HWXzXVHL74+Ppo/2XEeD1B3mJv07+uG8W1wWnTb/saV38wWyWYoRaicGH02
         JC/A==
X-Forwarded-Encrypted: i=1; AJvYcCUSxx3b/BAaeZYR+Z9PUjkw/WZPVmu8pIsBBhoOJY7gz604rM1yUZGOsTVw0gDfW9gIppCy/ObbvHl3v4A=@vger.kernel.org, AJvYcCXKjWRx/UwTFsD2pUYj5k7yimOvCuGNi3ITp7nvFaqdJoEqEK0tv004w0ZjgDKQBUZ/Jh04tEHK1MHvYqRmPc4W@vger.kernel.org, AJvYcCXdIpDf9pryKU3L6Ae453SP9QbsI9uSGLYwD6cvhJ+ICQo2QuEvnURfKlr2XPkVeuc94064SuGWcuve2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwptcnamXQtHXCbXR7qU5ExiGSjAjbipvjSSpzjnzHCANLAvGad
	aaVWU91F9/y10XwppYWETc6kspNcnS0BLmyY/WRhzpqaihf5Uw+tdufjJF9Z
X-Gm-Gg: ASbGncvjuALa0cPNWmW0QTk3AuKuV65LUupezLGayRLyLxFe5s55eAiur4UppVmHOPX
	Ximyiq5KYB+dAfV/gio0UZbUYTI9YnK0UQrZD5TT9K2TtuHVWR+X9Nxh1FNm9xYyCxzc7ct3mRR
	+SYrgr2C6MUUFRGMeQ2PWQn+BGCcqH6My6+IxUDcSanL+SdyUrc6YPC+/0wx8dl8eM/GJZlFdmw
	BzTSSCjaTtQKOaQfc4fcIgHExftQoE1TkMltpZ5baY6qh9UNNw2jWxWK37OtdynQ4sExqI7jSof
	YE5jr8MdvgclWZ8eOAhcXMZCS8gQwrAAfo3tnkhrCkSjFnLdhqGewC0tNVGP9Al2C0Z7VpxNSaN
	f6B3os4GJZUxBKGIcQAYz5OE=
X-Google-Smtp-Source: AGHT+IFdoxaf/qef0o2ioeIc+/tRZ/Vc7PmUxDQDqlhqOdmXZN5WXtpb/JEBe/wd1BNecTa9vyrSGA==
X-Received: by 2002:a17:90b:35c9:b0:311:be43:f09a with SMTP id 98e67ed59e1d1-313f1cac7d7mr1317475a91.9.1749846812264;
        Fri, 13 Jun 2025 13:33:32 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365de783e6sm18861325ad.106.2025.06.13.13.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 13:33:31 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	skalluru@marvell.com,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	louis.peens@corigine.com,
	shshaikh@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	ecree.xilinx@gmail.com,
	horms@kernel.org,
	dsahern@kernel.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	mingo@kernel.org,
	ruanjinjie@huawei.com,
	idosch@nvidia.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	kuniyu@google.com,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v4 4/6] net: remove redundant ASSERT_RTNL() in queue setup functions
Date: Fri, 13 Jun 2025 13:33:23 -0700
Message-ID: <20250613203325.1127217-5-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613203325.1127217-1-stfomichev@gmail.com>
References: <20250613203325.1127217-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing netdev_ops_assert_locked() already asserts that either
the RTNL lock or the per-device lock is held, making the explicit
ASSERT_RTNL() redundant.

Cc: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 net/core/dev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 43f56b44f351..df1678b1fe24 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3179,7 +3179,6 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 
 	if (dev->reg_state == NETREG_REGISTERED ||
 	    dev->reg_state == NETREG_UNREGISTERING) {
-		ASSERT_RTNL();
 		netdev_ops_assert_locked(dev);
 
 		rc = netdev_queue_update_kobjects(dev, dev->real_num_tx_queues,
@@ -3229,7 +3228,6 @@ int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
 		return -EINVAL;
 
 	if (dev->reg_state == NETREG_REGISTERED) {
-		ASSERT_RTNL();
 		netdev_ops_assert_locked(dev);
 
 		rc = net_rx_queue_update_kobjects(dev, dev->real_num_rx_queues,
-- 
2.49.0


