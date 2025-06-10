Return-Path: <linux-kselftest+bounces-34617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6711AD4040
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 19:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70D118943F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C83247295;
	Tue, 10 Jun 2025 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+rsxyU8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229E24677E;
	Tue, 10 Jun 2025 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575732; cv=none; b=AnqE3zgV/PxWWCdqpJTDcL2IBTFq9zwQq1kP15DVJmejIzbyslItyCCqRkDAdt9oVBEsINolOcpt8CycMEQvFC4D5r3JLOZ2GVz4w03vlnqWfo4GHKnT0AMvcG3uFhsSZhldgFV3TNxYpvv7nJdIgEfrOgyYVGbomVojfANVjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575732; c=relaxed/simple;
	bh=u8r2Q+UtHJ4Nd9Z2cHIyBuA8VSeH+waJg4MzAJzv7o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWP20+q1aV/VxoSd2G2CUNJJeLjc5FM9GxCtIN8WcXoaZvd1CAYrKWHrLM6UT9gycSxM4bnrgr7Z3sLF3/DFQ2bIM3Zn811PLar7TSsMzCcDrcF1TOgnk7sudx3LK+rLIWcUglRFnHfwGnZ8fjdY+Z4CCane0i+CGAnSimwv2NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+rsxyU8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2363e973db1so608435ad.0;
        Tue, 10 Jun 2025 10:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749575730; x=1750180530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIrnh6Y6z0RsAszSzJMckGXGP+N0IS1GPSV62LbBz1M=;
        b=k+rsxyU88u8RUD8fJhtZv3d6ytR4Cv00By8tOCzvdHICVKiWOn27CbjQT9BQwDlLv7
         mNwGjLCJVqVA7KGpiwcE6miAgvueOvvGqD8gWXurN2RmKlZVIugINTMrP6sco2u33ivX
         VlGBzyoL83UA2BFa7j1cL58fhp24i3oIcHAqNHR7tgiajKuqXbrjgKQuRDQQ0c6dz11v
         acZRJkYg0J4luEW/Ll6F4hyDlF7vgvpqLrf6FN5EZ/4b11cp7ZsRhqkYj7B+XECUaiPc
         8FsQS8MNKz3alLt4bII9mfsYrajVKSX7+TqF2PeVv4P8w2xrD8AkDrkv8Cg15Y6iIbzv
         cL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749575730; x=1750180530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIrnh6Y6z0RsAszSzJMckGXGP+N0IS1GPSV62LbBz1M=;
        b=K+a7IHA43DMtX0BEnvN41xA8D+Lfvkv08JgYrXvXVmUzm3YXSaTbV1hSELub61YhIJ
         BBznb/2/w1H056ztfXa3HD/VT5RdItPEgH4x4IBrMUuNuluGzLjYvxwPSN4veP/8tQms
         XbY0QIke4BxysiOEpulQW4ZZUiRdT5gy87pAfxfGl4DkrKZ/eGWoRupLG6eIt1kAGcid
         HgvhsHE6tjxw6K1xiKJWAl+vXka9IZEcoTL9FLVRbeGilwdyfybQ0YUug2YNPJb7E8yL
         s1inTe0QJMoOyPCLSx9yDW+Sx9NUS72/8+R/DX6cdQ8K2A8xmAXLafUKTui0X8mOzpCD
         oJJA==
X-Forwarded-Encrypted: i=1; AJvYcCVTUcdhGVHgug0Az4QlX/FyIkYFmPMW2dyvF0d1PLRtAgvLjXh2PHuljZRPib5/UJxjHr59qx92VYHydG6RzPNB@vger.kernel.org, AJvYcCVpK+gsEUvv0AeoJDP9iuwzxmCOH5uOLWLMuNPd70PfA6XUJRMldFbU/Na/fCnLs0Yv/4BcMX4h6MJBXw==@vger.kernel.org, AJvYcCWlUhYryU237ogrn0UoTY/VBkXCNZ9q/dNu04ec5JJYxN0Gjxiobh1XtujSmMRUw4IkYjN5t8tNUj9IMvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTNjJMCaK3k3X4D/URxFM84dKG9HrliLl/BK5egW+jpstO+1ed
	RKJXX3NAWnkcYrMyZ74QIFEo9rQLd+CNOUpDLZK3sXFtxvOx5kmwMEY002YU
X-Gm-Gg: ASbGncuViBFSeX2lFttoKjsk9zp0g6JDC+m3TNZHABJsmXdOcg4xNgLlLfu4pZkfUxm
	9JcQNKboyZAbbY+v7PxnuCaozpHEfowwTci7LOeIvo9DqpH9rPKIT4APZaeTcHn3cWXNZY2Mjjx
	jFzq76D0zDLi2Dy3xdWs/KPPijDvoPW50FgOTkdaeOplx8pzN7HzMFjhvh/5jXSb/Nhyw5KFAwg
	dh5U0fw2ZfuCS/cBnLdEp+d3Z1M526IUVopYJ31v+PPE18ewhSVPEbKdoJ8ka2/QDWs8Ff9X+KZ
	RwYADLp8a+/8OKhjQ3lKjId6Wk77S74+3x5T+ffqMaFz16VLon9rI5g3NAwGS6T5kpEPuGPx+e5
	uMqvnJ4WM6Go+L0OyQfQVIHQ=
X-Google-Smtp-Source: AGHT+IGjKW9uxJxECrtSXh89niGE9d1wlACS6WP7qG1lr3n7ec7MLI9AA185gIqYfLOWUsY3utuoDQ==
X-Received: by 2002:a17:903:1b44:b0:231:d0da:5e1f with SMTP id d9443c01a7336-2364183445fmr2280735ad.21.1749575729503;
        Tue, 10 Jun 2025 10:15:29 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-236032fccd6sm73703615ad.134.2025.06.10.10.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:15:29 -0700 (PDT)
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
	leon@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v3 4/4] Revert "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"
Date: Tue, 10 Jun 2025 10:15:22 -0700
Message-ID: <20250610171522.2119030-5-stfomichev@gmail.com>
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


