Return-Path: <linux-kselftest+bounces-34495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F41EAD23E0
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83ED41883533
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EA021CC6A;
	Mon,  9 Jun 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcG75G4N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74121C19C;
	Mon,  9 Jun 2025 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486351; cv=none; b=jtr0VRmbm9niXowKbT2RwQVzSKynxpNUu15wsuuDZMCE7Qc8vPuoHvpIfEZMi7tHMwq717EdG2YrHuhE85wvUYrwhfec/eyX+UOsKIxDTOEKTfWRK2KAwCvg1Rh6Q/sfZhYQEw8RVwyVkBX8776hOJX/tiWkbGVdGq2mmyVRmAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486351; c=relaxed/simple;
	bh=u8r2Q+UtHJ4Nd9Z2cHIyBuA8VSeH+waJg4MzAJzv7o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpsANtuBtOeQr3FO5gvppNRwzr+YtytZBe+99a7z5U+zTsjVoM3xPaxSieJFTaL3WjEjEs6MI22J6up99WWEpWJFXLVz9b0EUX/1ztc06MiFRSuNTQv5eoOxzfkzlXg1bhQnMNISc+tFnoFJcwcySxe9C33Kd1UCMDpxKTb4F5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcG75G4N; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso3474288b3a.3;
        Mon, 09 Jun 2025 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749486349; x=1750091149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIrnh6Y6z0RsAszSzJMckGXGP+N0IS1GPSV62LbBz1M=;
        b=gcG75G4Nf09QWzPIdG32NyX6gnNqq18Mq9ifc+BIYuEZD5S7gNNDohTp2ui4V7YPT0
         Hi7/Iqo/YRy1Y9cLS+QOqeo7+dA1PtJTWFQNAqf4Y+VTJczxwaccTddx9rijDB2xWcWd
         NcIRR2tnSXOgJsNUjUYB4Odlo5X4d0l42EjnR2Fl21SLidQI5joiPe1T2XsfA+e9E9mQ
         oUaka6lm9TyY93wI0XC0IEwx6Jp3dPMFq+YQdE4Nz7eU0oxbMMsELA5LyrokvDOBJlwH
         xsi7Z94wh0rC7aKnGabngIqcAcPnPXuP0XDYDbVWLJDx6PSlwqMneMo3sMJhOfW71utF
         8l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749486349; x=1750091149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIrnh6Y6z0RsAszSzJMckGXGP+N0IS1GPSV62LbBz1M=;
        b=gzlYJoPbNKirj3JNf1CKoU62/Y4vv8+NdkfVhglHCprIQhPFPKRxwnIl0KY7szUvnJ
         PsnwHQbzvf5i4bYFA84Lm8i7pBx8lfmYzWcCHdpgT1qz3RjeQc/4sf8z1wcBMwCxpvqf
         OasTmlzwT9NR2t1KEEdyLUNjWGnHvNN0y1F7vmWTQqE+lXktP2v9lmkCVm5gJfmQYO7l
         iIu6dxWJ4oO13JezuW9xnHavsfu2e9em4c477BjeETf0hGLkjZUANHFBHOd6GTPI8j53
         Z0jSZ0Rims4NmTj2bey/BEB30CaNvlgk/Uo4WWKwEDEkNe/UoTRYsbaojR5qg8wjW5AB
         gFsg==
X-Forwarded-Encrypted: i=1; AJvYcCU62juxx5aIL8F8YIGIqSietfW5dOl5PhMYMn5GeajL0PyibLKcQCAw4tVeiImJj3iZvEMtqZjYkV9j1H2qv5Yc@vger.kernel.org, AJvYcCUDuvl8fey9387k8Jmedki9WHszDSEYKR/blwd/Tffgms6d8jwsUJGoV/+PeSERTyTLUxG7Ez8bkvBaiA==@vger.kernel.org, AJvYcCVvWo2lqQRwZqfAXjZy4ILqNA3ryt6pc6jLccBkf4sihJU8dFAHEuNKz4YQKCTBEOETFBRVQ/g3bmrS8NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCL0q/MuCxwRHPv9l3XX8IhYlzOXJuHQ1v2RbC6u5RdVZWGCop
	8ZzL2gfI2lCwacC4ph8O9bkMu1BPjcK6A0D7yIMVX+M55w3VSaMyWWHsZS5Y
X-Gm-Gg: ASbGncuf3eDyb+eTdZbphAZ/YihpI0mTYmWQDlPh897nCnbmmgypSzNTEp7JZaJpYb1
	wkCdtSvL5ANRQLKWnJhlUBJ5JjSgTEH+bJUFjWmmZhTDOhNZuXpIENU/B6+Ou27/ky/qLRHZSEQ
	lAdgWShzJOomwyaouWumGI9SrnosvLhGlyZw7rs//c3pODhnO6BF/K+U6m2KCH9guueIejBKmKo
	bK6FYlffnQtFIuR+UPeky5iKujEYdoaik9t9V3R/MhvTBPeSMaSPTFD322JsoHAO7VivQ0qV3or
	naJ4WNF90uonBW1EpILY2rLgxnssD7zvoo8hi9+JKgxYpamZaavONcNhoJkcuK7eUjRCgYTGWm/
	Osk47Dnh6oevK
X-Google-Smtp-Source: AGHT+IHWJwEpttKcOYtxUVS3ky2ehdeYMgNt9I8XWQyiwY2W97FEQfM0AyDBiEXIyrcRZ6JMgZ6g5w==
X-Received: by 2002:a05:6a21:1fc5:b0:1f5:7ba7:69d8 with SMTP id adf61e73a8af0-21ee25321f3mr19247516637.15.1749486349275;
        Mon, 09 Jun 2025 09:25:49 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7482b0ea2b2sm5915308b3a.161.2025.06.09.09.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 09:25:48 -0700 (PDT)
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
	mheib@redhat.com,
	ruanjinjie@huawei.com,
	stfomichev@gmail.com,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v2 4/4] Revert "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"
Date: Mon,  9 Jun 2025 09:25:41 -0700
Message-ID: <20250609162541.1230022-5-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609162541.1230022-1-stfomichev@gmail.com>
References: <20250609162541.1230022-1-stfomichev@gmail.com>
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
index a3dadde65b8d..1da208c36572 100644
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


