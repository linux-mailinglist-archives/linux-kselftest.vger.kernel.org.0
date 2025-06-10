Return-Path: <linux-kselftest+bounces-34615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8F2AD4037
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 19:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA41418932AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7336C2459C6;
	Tue, 10 Jun 2025 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebGAu6xF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDEB24469D;
	Tue, 10 Jun 2025 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575729; cv=none; b=AjvRp3qrsFjMxGANIxL03H3y4LyjNJrFZV3f97+6qZV7GRQCtQEnhfLcU8YgmgNPlf9hvxvtW0e9/NHqUF6br3L7KdaNktXiauaAGzJOuYUMSu7u21o6Y0WJ0IkKrl0EvmYb/uhhjaUMXJkqoDsSGAJacZNpvh6OKEcNn/qgWuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575729; c=relaxed/simple;
	bh=gJFmnMD6We7T8CJJ9MqQYVPFTCjVQwwgiQcPRp9KYL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk8Z4Orh9gK5MCyUiVbx9XOS7PwnP81rUjuPnKksBCmsBxA7tc584jm/xd/psUI2YOLyW8ZIHZnLBrCWPWgZEkZKxDiIkg1BzgeZf8V/2RjyUhGNHKFh24iK6X2oyS79iWYSgLc3TLWAO0GX2Uswj+ihiqqOhD19R/oQDtK2q18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebGAu6xF; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b1fd59851baso3299891a12.0;
        Tue, 10 Jun 2025 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749575727; x=1750180527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIpCecH4yJO034nC1LHMnR1mqJnd63DXTBjtuXwa8mc=;
        b=ebGAu6xF11ojNi1SrLVi0IdX4MZClJznmhWTOMPfiU8vBp0V0UZP+XP8KjVXCPDRXa
         cBfV/1McSUcs1qWCV1izVl/zY2qHLyuC+hAiYojwtYEUtdhLI8me3C/SWykuZIHcLDCZ
         WlOc0Qq+EH9rFAFOenaCMHw7yKoqdQdHNydrQKLo+KkBbzJgwdyvuT4rlLovQg8ksxtn
         7cKICdhqMBI1tegTMZJ/Ng4Qs/3jltHjBU1TbY4gabUY+Rbej+iEqctgCY2bkcf5bnBX
         Tp5bo26KkoMmU7Zpv0x3DOWSJDwZ7ae5n+3bGNUAZATJGjCfZpWvirnyS+bTnHzm9oYJ
         APlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749575727; x=1750180527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIpCecH4yJO034nC1LHMnR1mqJnd63DXTBjtuXwa8mc=;
        b=nqeamJFpSDuMIlBilYqjtRR0Fjy4HBx1lQ+ybEXM/zFH2ylCzCb/zWRQQm9Je3iRLj
         hLBwhpFDrijycWNKYxAXnCYFzcju1P6+hb0cgmROb0l0rEoH7yk74oRBrqzaafkXtq8V
         zT6jFdLgveRHwahPpw1JKe3/gs7sZB3fxHb8EvoME+Hv46i1dvzHocQ3aXhraIPPnvmn
         NPt6Eh5aWKJvRVcSLM+Lq+8ezZwqCVWVp9S4Gsba+A9SCOOQCYcb7OWSirXk/qKccqjc
         hR/8cbKRRTDZVmLqvFfn53UMuzHv88XQIAQDqCMmkS8WfZnmzi1mXvGRVXUgShrum6Vp
         etWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi8PgeDaqBn7BANqu7QBM/ctQ+fv+VKEWY0wlC6ezCK+qOdXOaiXLegNk886IrkDfMS+cwc455RPQm8Q==@vger.kernel.org, AJvYcCWFSKs3l9JlfU+24kG98aEbuQ57MpxTfLlkKjikdb02GeSx7a7OZvDxS8cEWyWw3uIviQyCotFHmMNZtUqGv/WV@vger.kernel.org, AJvYcCXve1/CZFXH/VVzC6CnCeCUByrtBDZdxdAQPC9tT6qLleJUpoYzEZVxluDH+km980yGfyQNfk4jIj7om3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSz5aShLBXpCLJwc46xwNvH6aZ3fAN7yaF30HU4F6G593Hkxpr
	up3KM88REbAoaHsPPl1cho57JK7o8wsVHUP/qd5lGCtyJvJg+tt1AuZwa1CZ
X-Gm-Gg: ASbGnctfDuGAd5mTsfqeJDV9XkjHoqTRU8j9SlWXEo/UpP54zEGkjXM+lBi+m+Hs7mX
	qsd/AZfNLkpj31RhEKbbxoD5bS6fqMcQg9pH99kyXEjt4x0/zjY0GWqz12Z+ZbZqJp6YTCfT2V7
	NbVgWFLMLOyraEnUjSEFzbS8g4ySCrjZgBu+B3glsDoiZGMS3NlaPyuA8TOK7Qv00wPk/Rj+AAi
	GYiWVC+SMDw6sYmbKJxomJbrsmnlseqVdsEsf04GPZhrV9jrJ+z46L+m+eGfLbCmjPqUkVs0tZD
	4c6XwOug2v6XfjTsuliVEMEAbxUUJljxCqrwYSLSc7KaQn0vm+7cp2VEew8lfDxAbKJ4u4eKWQ1
	XtT6FuwnhX9WZXk3lG8i/oYM=
X-Google-Smtp-Source: AGHT+IFNn384M0APO9NR5szwd5Jx/eM8GcxVstTXNBBj5YHPeF57nNlZNzxLY41eKB4Udjdn0vnI0g==
X-Received: by 2002:a17:90b:390e:b0:311:e8cc:424c with SMTP id 98e67ed59e1d1-313af2603c8mr453324a91.25.1749575726795;
        Tue, 10 Jun 2025 10:15:26 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31349fc3e72sm7562065a91.31.2025.06.10.10.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:15:26 -0700 (PDT)
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
	ruanjinjie@huawei.com,
	mheib@redhat.com,
	stfomichev@gmail.com,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 2/4] net: remove redundant ASSERT_RTNL() in queue setup functions
Date: Tue, 10 Jun 2025 10:15:20 -0700
Message-ID: <20250610171522.2119030-3-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610171522.2119030-1-stfomichev@gmail.com>
References: <20250610171522.2119030-1-stfomichev@gmail.com>
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
index be97c440ecd5..72997636b8ec 100644
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


