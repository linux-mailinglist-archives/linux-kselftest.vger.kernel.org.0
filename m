Return-Path: <linux-kselftest+bounces-34967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDC2AD966F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 22:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496853BECBB
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 20:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E063125D547;
	Fri, 13 Jun 2025 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRKNrWj7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D525C801;
	Fri, 13 Jun 2025 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846817; cv=none; b=Nfev5s8fs8UXVWAf5qLLouGv21rOMe+A7+478rSrActEKtWVbgJfG9OmgvQKATZ8Mr/z/mL1i0xwFgTKMyUVm2gjIxXeatVB3FP3HnycNXtgfo7rjEuZOf13wBVTPk+BdbFRIXquSSRWvtwcFov2OyHV/zwAf+wjjvxSnbG/d9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846817; c=relaxed/simple;
	bh=aV4hNI8aqhzy9bbbQZ0vNyWIkwogBSS8SXPlSQfiUPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sx0Qn8y1FxXSkcjGBqmVHFGoYX581/z6x8WBZyPlmBr9vwnHavzWz/pMntBcOnN+Ap9uLcqQs3CPc1vUtCnT/xI1snd9yRiS4m1s8s03pAJg86gcErTx/Is87AWpMRXcMdFv8zXip7enLdvaI0m3l6VmIHGtGO/uqB48us/z3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRKNrWj7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2f1032e1c4so2714128a12.3;
        Fri, 13 Jun 2025 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749846815; x=1750451615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vf7ea9OeOxjFZqaN2n/DTUZpfsQZsze4A6wO+u7qE8A=;
        b=TRKNrWj7PZ+w3dqOtIVDrR4bMtW7dwwlqpaOtu1BSXrx8JBeAUCW6mRjwMpWoMYG27
         ugSH3blilGn1AJCB1SPnulbt3EEkWuIdYOqDIXdfXyvxkx69L3Q2COFP56V0AjgSRdlL
         8ylEwkKk1NsFXlXXhz1Yo51rpX/JwIAMMFJR471FNA6BgByJ1DTONU/aSs2JMO2AePQG
         iK2T6RDaQGgKElhG0Hpdkz8+YnihaW5ptkKmNu1jZgEiZ2O+baeXErEiXIifrbwgMNlD
         aNwdoOsN3eosE6tj8iAcnnd0BNluQAPUMd1DYsXNSFF1HAxQooxildC5OiPvXrXD9ruY
         XmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846815; x=1750451615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vf7ea9OeOxjFZqaN2n/DTUZpfsQZsze4A6wO+u7qE8A=;
        b=We+gd3gJldYSGGXQ5Q6Rx3UBqfs2PwgSgr7Vap4roNzT7SbGeVWCzi3//RHyN9LhwA
         3xx2t9Kn7GaokgSQaGDDbA7lFqZm1MeXwQbfxmqu5asPOBkibXjwgPAt60fUQ0jqXB/I
         M3yQSJHx8jG0LT7Z7ejONieMusply/9obtB2LnKQ43ZGi0WkwUAnbvK38I8XvujJ/SkO
         XsNKrplUamGJgJajksIszRqEk864pjWMi9jKXHYdAlqPzIRj7M3s39vug8oGJ85rKLKS
         FBQCvjN8CyV6sJoqlF+2xZ/ZOAMw7E3CbufoEagIsAOPpB7o5ioLbybTcI8nkXGLf5mG
         3kLA==
X-Forwarded-Encrypted: i=1; AJvYcCVN23XVlJhArRVarkKHaTIrBjTiEeAq8eUesYRVMxBLHdS/s8h38rSbf3m3uQd7PeHM/GZO3xtpIR8/msABXpiy@vger.kernel.org, AJvYcCWc9nsAYX77nSj75WiKDDA1Cjq+AxsAptnL6akrEg7dJQq9mVfuQfHP7T555AYqMFCrSZVYgkQ8jqRdJ7E=@vger.kernel.org, AJvYcCXMTGpjPezeCveYkqKGywFQpyD7MDSsiQqRuq9LZ5Zb4oGWRzdRzw2ZJJuawyfFsmFo5x3BXp7nmANJ4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXCvRj/B9KwDjabiB56jUicQAd8yEVDZaKwqsckp1/2mlLbRv
	fkOE8bc29EgHA1K6gD6KmpzYoZX9XWPEnVVjBUZrSuamQPZSVfisItK0nfgs
X-Gm-Gg: ASbGncspqKJ4UU0Pphr3BeZy+LreqqT0WYjcSa/LISSjePo/YXuSP2aXkSqY5MaI0Z1
	qo5SeP6HDaq0wQ6qREw8DkGgy/FQzknfvnCki2Lkcw/01KMa+xn4H9ftdtDuR5+Gq8d/BeSEaPc
	Wy8J1yy7w0JPEByqImjcSabeoG7we8I5LG6ms8rjgREtkPdTAMQcCNwo8xE7n8ItFVWoBaysAiI
	xLsP/AUj35bkFgj63MovqRWGcksu33CHph+hN6MnPKzZ/MY+3UmTLDarlLcEDmPjLSqFYzRWuI2
	O0h9DSINhW/dN3GRCAOfXAvA/gE4JV0PAvEIMALGy/kYi0S0uzAjfWLNlU1UHEGEWySPoOYe/si
	+bFG0febhDEcacnHvtJyB2C8=
X-Google-Smtp-Source: AGHT+IFQorw9u2Oum4iWIl3+OfOv8aRF0XYDMBT3yjqF6imdB9HBBTYYcXJhmREswTV0eldeif4+ow==
X-Received: by 2002:a05:6a21:3298:b0:1f5:8fe3:4e29 with SMTP id adf61e73a8af0-21fbd4567demr1089944637.3.1749846814973;
        Fri, 13 Jun 2025 13:33:34 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2fe168ccafsm1859552a12.55.2025.06.13.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 13:33:34 -0700 (PDT)
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
Subject: [PATCH net-next v4 6/6] Revert "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"
Date: Fri, 13 Jun 2025 13:33:25 -0700
Message-ID: <20250613203325.1127217-7-stfomichev@gmail.com>
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


