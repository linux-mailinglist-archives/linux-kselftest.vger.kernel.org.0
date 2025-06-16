Return-Path: <linux-kselftest+bounces-35108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B91FADB6A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1111B3B9994
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A48288C25;
	Mon, 16 Jun 2025 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io8qAyRx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB95F288525;
	Mon, 16 Jun 2025 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090889; cv=none; b=kHa1a13y+PSEFGJOQkqI+ab/9HmczkCJ3K91lnRukqRQK10aIDmGDB3vsBQAHJjqD7/5OBYaYAesWwHvXt7YgG7kbHHGBlbHFjBTx2XbRSmztS3O4kpITMg6HyKI0IRzQFSQUwSliyLCX+wyunJmfo4W9NMq/97ypNXnovU3ReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090889; c=relaxed/simple;
	bh=aV4hNI8aqhzy9bbbQZ0vNyWIkwogBSS8SXPlSQfiUPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fqktylo0mM5kH9MO6Fb+v8i3fxZcF7ADoUbEu7MDWpWNAg5UjQqXamEcbK9ZAlxU22xLUzkVwJA4oKxMzXg1OmN3+HppeLg/GVAdS8wJ9O9nSyo4FEB8bQewfj2jIc0xcWsucgcEBj/SBcvnC75g/1WAAFT9J2V2othHZUT7iRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io8qAyRx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2350b1b9129so32509915ad.0;
        Mon, 16 Jun 2025 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750090887; x=1750695687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vf7ea9OeOxjFZqaN2n/DTUZpfsQZsze4A6wO+u7qE8A=;
        b=Io8qAyRxspHUtE0PBSlhmmK4rj45RhXmbbjJUqW2JyrnFMiTmI/NDgbtO5l4BJa+6I
         HsO1vi90Mn1uXWECLavQNpxCPCiJViq545tmh8f8Hjk2KIrsgSgZ+QXO5qnH3zHyKUGn
         RbwC+remeQcRJyaR2F6NybhXWBk5TqYAmr0XXmENbLcrrcQFLIXGNWQH1XW4B1HiufFE
         hSaDUDkbe80dorztymlJJ6fQAWaqvoCZl7osgISeSI860YcWV8TmP73fZTLA9gojGlda
         evkEioiIYEs1NblHs6zCNmmoBgdtQMnWwRQo67yTg4KL2VYPgtGnnI5NO6akLmcTM0AF
         NuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090887; x=1750695687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vf7ea9OeOxjFZqaN2n/DTUZpfsQZsze4A6wO+u7qE8A=;
        b=gdK5ZSXH5HszWWx7ONP7V4Y+mB6tgLMbiQQfLhJ8u4sppUHN7issthMs2m2POUz8PE
         755MPTjvm9mL2AupRx31x3UNNEaO5TF+5tgynevL5ecXSPdlCbbKH8FZ7lZtuRpdF5De
         xnCbEBbCfzDf4oeeBYfTB1gwQz9lMMVBHwQEnEetlnUvtesbco5gWqG8XrPomj77JsMv
         o5Tf6u6qcnFP6NvPsnd1ilXddukaUA8L6+IBwBSsuwEP4rNWJeXz4pErKFxE33wpLC/3
         aHbVQwiNssrt2edtdnslKK2iLQ7IHvW37vOnHTfsi+5AJT651roZbLCuI6KXX8kksk7N
         KN7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYVK9NHICVYLZyGTwrqDp60e+luzqa/2TCGhTZQTaTMLmLLZIDHKfUFuFzR6HqpmjneF5rqo6mxOzirsY=@vger.kernel.org, AJvYcCV4+bPf5tzD8BI3GK6TFzwyuOhStwst1cWQzyKbNlJ291KCh/8Rrc3390WRhkTAxy6LBpSUyTH69bSx2/j18D7Q@vger.kernel.org, AJvYcCX5HfgTj9Ncnb2ysD9ogInXKED8vKQMUyMEHyB5xraapi930JQRVmM3sBZVhFMj5lyjVz7Qz0AkHM7JVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTuT0aG6255cEiKe7v4Pjn3sLnIB8Of1Cyuqs1qm5ln0KCho9i
	WsTQngGyWANGJKILj5waZCaQRLmp6fdd7TpI8JHt0V58EG2BC9Oix5XNxxGA
X-Gm-Gg: ASbGncuz1FvvtmE9onBfMfKycqsXgboa70u+adYxuS06zwKeebAFriwRW1tRF6XCp08
	uWBcaXK4BO2xAbdPYfISUpna5vifdVr/1i0MP8cRGM2VT7Nc3c7c2gsyeYykbXcX7ADRIyLB9EE
	tfLXN1OIYMYTtRZ96NIol6flrv3s5AipL13NIz2ar83OSYv3osGdUD8r7C+SFHw6F+OdpnmEQIW
	EklqssOMDroBdJAq0p+uHx25hKOzqMOCpo2D9SkNUkFCwlIBE+AflNtXEyxqTd0JAcFbvBNBTe7
	5m10+mi/gQx7xxteisRxaJK0veyRV3CHnxKxSQiT9Otq1rVGx4RUSGpGKG7ppZoPEKO+Vpl1aoS
	OFPwuN9ShNU685k5uVOxFov4=
X-Google-Smtp-Source: AGHT+IFTpneJMscp64JsQsBTZDsdXWWWprF9evpsvYcOGwB/ozwI/DF68CMRCP+T0+BlojYTo1Hn1A==
X-Received: by 2002:a17:90b:1c04:b0:312:f2ee:a895 with SMTP id 98e67ed59e1d1-313f1e1a908mr13632801a91.31.1750090886699;
        Mon, 16 Jun 2025 09:21:26 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365deb87bfsm62925985ad.190.2025.06.16.09.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:21:26 -0700 (PDT)
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
	leon@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v5 6/6] Revert "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"
Date: Mon, 16 Jun 2025 09:21:17 -0700
Message-ID: <20250616162117.287806-7-stfomichev@gmail.com>
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

This reverts commit 325eb217e41fa14f307c7cc702bd18d0bb38fe84.

udp_tunnel infra doesn't need RTNL, should be safe to get back
to only netdev instance lock.

Cc: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 +++++------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7946586802af..b359ef4b78a9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14055,28 +14055,13 @@ static void bnxt_unlock_sp(struct bnxt *bp)
 	netdev_unlock(bp->dev);
 }
 
-/* Same as bnxt_lock_sp() with additional rtnl_lock */
-static void bnxt_rtnl_lock_sp(struct bnxt *bp)
-{
-	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
-	rtnl_lock();
-	netdev_lock(bp->dev);
-}
-
-static void bnxt_rtnl_unlock_sp(struct bnxt *bp)
-{
-	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
-	netdev_unlock(bp->dev);
-	rtnl_unlock();
-}
-
 /* Only called from bnxt_sp_task() */
 static void bnxt_reset(struct bnxt *bp, bool silent)
 {
-	bnxt_rtnl_lock_sp(bp);
+	bnxt_lock_sp(bp);
 	if (test_bit(BNXT_STATE_OPEN, &bp->state))
 		bnxt_reset_task(bp, silent);
-	bnxt_rtnl_unlock_sp(bp);
+	bnxt_unlock_sp(bp);
 }
 
 /* Only called from bnxt_sp_task() */
@@ -14084,9 +14069,9 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 {
 	int i;
 
-	bnxt_rtnl_lock_sp(bp);
+	bnxt_lock_sp(bp);
 	if (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
-		bnxt_rtnl_unlock_sp(bp);
+		bnxt_unlock_sp(bp);
 		return;
 	}
 	/* Disable and flush TPA before resetting the RX ring */
@@ -14125,7 +14110,7 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 	}
 	if (bp->flags & BNXT_FLAG_TPA)
 		bnxt_set_tpa(bp, true);
-	bnxt_rtnl_unlock_sp(bp);
+	bnxt_unlock_sp(bp);
 }
 
 static void bnxt_fw_fatal_close(struct bnxt *bp)
@@ -15017,17 +15002,15 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		bp->fw_reset_state = BNXT_FW_RESET_STATE_OPENING;
 		fallthrough;
 	case BNXT_FW_RESET_STATE_OPENING:
-		while (!rtnl_trylock()) {
+		while (!netdev_trylock(bp->dev)) {
 			bnxt_queue_fw_reset_work(bp, HZ / 10);
 			return;
 		}
-		netdev_lock(bp->dev);
 		rc = bnxt_open(bp->dev);
 		if (rc) {
 			netdev_err(bp->dev, "bnxt_open() failed during FW reset\n");
 			bnxt_fw_reset_abort(bp, rc);
 			netdev_unlock(bp->dev);
-			rtnl_unlock();
 			goto ulp_start;
 		}
 
@@ -15047,7 +15030,6 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 			bnxt_dl_health_fw_status_update(bp, true);
 		}
 		netdev_unlock(bp->dev);
-		rtnl_unlock();
 		bnxt_ulp_start(bp, 0);
 		bnxt_reenable_sriov(bp);
 		netdev_lock(bp->dev);
@@ -15996,7 +15978,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 		   rc);
 	napi_enable_locked(&bnapi->napi);
 	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
-	netif_close(dev);
+	bnxt_reset_task(bp, true);
 	return rc;
 }
 
@@ -16812,7 +16794,6 @@ static int bnxt_resume(struct device *device)
 	struct bnxt *bp = netdev_priv(dev);
 	int rc = 0;
 
-	rtnl_lock();
 	netdev_lock(dev);
 	rc = pci_enable_device(bp->pdev);
 	if (rc) {
@@ -16857,7 +16838,6 @@ static int bnxt_resume(struct device *device)
 
 resume_exit:
 	netdev_unlock(bp->dev);
-	rtnl_unlock();
 	bnxt_ulp_start(bp, rc);
 	if (!rc)
 		bnxt_reenable_sriov(bp);
@@ -17023,7 +17003,6 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 	int err;
 
 	netdev_info(bp->dev, "PCI Slot Resume\n");
-	rtnl_lock();
 	netdev_lock(netdev);
 
 	err = bnxt_hwrm_func_qcaps(bp);
@@ -17041,7 +17020,6 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 		netif_device_attach(netdev);
 
 	netdev_unlock(netdev);
-	rtnl_unlock();
 	bnxt_ulp_start(bp, err);
 	if (!err)
 		bnxt_reenable_sriov(bp);
-- 
2.49.0


