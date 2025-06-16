Return-Path: <linux-kselftest+bounces-35106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4350ADB69D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E9F18911EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA28E2882C0;
	Mon, 16 Jun 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K29VL5kC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274562877E3;
	Mon, 16 Jun 2025 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090886; cv=none; b=ZLetVBzDnXoT6TIb/Je/+b46HfxHPVIojIRTQGEX+EzNvzvC0IS+bCA59hB9/v5AsN1LylmiO47R7r9dd6/JWl3alDZv109plpEpRw61N5I9A5AUaFlgrG/rcafmeIxxfJqawac+/Ree53uiyPrCypJl+2Dzfh8J614oFzoANJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090886; c=relaxed/simple;
	bh=ctkVmqF3JrN4+M3Jq2BUDPgQr7j2TwSOV9URy1jJ6Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+I69QhFd7YX1B+I7iKl5ZnPhigaircVl7QwRFnI/dXJRbI1gpvJnu3n6/QXe+0o396YWvfSV8JPRq8ybd/Om7OLBR1qc7VXu2pnpeNgtJbPViUtXrDR7Jh0DBniI0bPWr3v/jsaQQ6suMfJ3CQGr0XwN5K87OqPz/DLLBQx7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K29VL5kC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so3791852a12.3;
        Mon, 16 Jun 2025 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750090884; x=1750695684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOzLGPoCr0MeSXGXJzKmOKNWDgmi51GcdPfztdwS3U8=;
        b=K29VL5kCf1d97eNsgrCfni2EnAhd5eumGHP+9fP4go8wXjj3U/g3YeCgvPfE3oQidS
         GkVvcKID4Wo39RSdgWtbrPIDawIFNomnZRUvfHUXUZ9wEZjjUJtSIJByDfeF+jxCketd
         Re9Xa43YijzrwWozj++u1VfSXPrjz5FcxS87LcXFMxxP6KdeggZQMln8uLpgXVlE2geU
         kBljNB+Kx2dCCQMfz0atz0PZa7Sx45XJuTcubzDoBtSJS+a+y8W/jni0fwMvv9r7ZKEt
         V00CAgDetfG3zEfsH5Tsvt41yAMyrYi//+NxAcRInE/N40KdtJgjIdSoXQZvpjDWoR8T
         8yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090884; x=1750695684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOzLGPoCr0MeSXGXJzKmOKNWDgmi51GcdPfztdwS3U8=;
        b=Kdz7pcpbWoMjm8Qrvg+23PVtOm2d7XLqTTKgPQRtCUqZaEZFRYNzdYl+Bxj+dIkV5r
         d1duNX5INGeUNyf75beTvHP+/8aNppMNWsnoP3GmzlJfcVRHiSJOIycnjlAUV/EfhQ6g
         aLrG5RcZPgobsIDd5983WBi3F/ZdMf9LQY/ULrnexlo/OpDvo1PnCc6pVUBgS6OruhwL
         eqYZsbadgvv3wjHOuLmVhx7z9NKMeD3As+pEuJfJJy9P7th2peb/0GCOI7Fa2G7eqJan
         isCjlem4ibCrR8/kNCWNy3ecwJ6owNmWNyqVAguGRcd+bu4KriZM5bSs/Tp7UvG5JXD5
         iQgw==
X-Forwarded-Encrypted: i=1; AJvYcCUU1UCmie0jqhgU/G6QL7hZRe1uKxPnPZIBEsSmh8d5Osach7fYXJZ93ssVtlZyCBsM00ztKt2PuQNmQLLx5p/L@vger.kernel.org, AJvYcCWvB8FpvcbRnCs7MdiH1DeCIr70pwNi8vXRnMsHzHOVGAV1RPWEJo6KUzrUwN8x+aFGBjJ8YdsPgGrH6w==@vger.kernel.org, AJvYcCXFQ56POjBbw8grHy+RsCU+5Z8JZXxiDk2UYxoiYibPqCASdT07fVZRuaiIU6X7TAxCRK4zRCInMVc62dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlhV5KxGpJ79SWe4M73/1IW94NEwNIe0nosFubKluOBFnKpY2D
	LY4pE2x91qXalg8Xa3FxA1pa0xcpGm4KQuQnaNsiVb3a7XyuC8GuNGz70lnM
X-Gm-Gg: ASbGncutWLQoSbqZNYWFcaD3QL05prhvWD0cWb0kFOc/tut3ZrHT2TXg6Bf6mZW78wK
	5fLmt8jAjFJsOSKaiPb+zgMkgwDmodzyEvOnjXBhuBOfSiomvkZRm2i/8cI1ivzjMSea/s9dQ4j
	XiuiZ/ZYx0DJtnWj5RrjowUM/V2Cb19G9J/dmno7Fk6RsuH2ZJBPD61WCqL7g6hzkUs+iAPd3Lr
	vKF9GAAAnQ8YHEu7fQa28Rk/zqbK9qMsjmFG3XMnl2xF49HpmTqtDWqc6DVcyKrwHQW4j/Q2iyn
	sPuP5lgcMhP73EEu2vYS6KzU5hl9Df/BCI3oPnXwqrJvKEd1FGeTKFfiem3s2TqxdyPLaxobzYa
	wku8n0mRVp8Ng9ZDin1vqtOM=
X-Google-Smtp-Source: AGHT+IGZvOQH3Qch7I0qSswC74QzMJM0k/uZMNM7l+NTLMMpD2tzor7yNnd4dIMkv3IMj/awGe4+rw==
X-Received: by 2002:a05:6a21:b8b:b0:1f3:33c2:29c5 with SMTP id adf61e73a8af0-21fbd559187mr15017168637.7.1750090883975;
        Mon, 16 Jun 2025 09:21:23 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74890084013sm7296033b3a.96.2025.06.16.09.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:21:23 -0700 (PDT)
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
Subject: [PATCH net-next v5 4/6] net: remove redundant ASSERT_RTNL() in queue setup functions
Date: Mon, 16 Jun 2025 09:21:15 -0700
Message-ID: <20250616162117.287806-5-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616162117.287806-1-stfomichev@gmail.com>
References: <20250616162117.287806-1-stfomichev@gmail.com>
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


