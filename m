Return-Path: <linux-kselftest+bounces-44862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D918EC387A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 01:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BCC3AA878
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 00:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA9A18DF9D;
	Thu,  6 Nov 2025 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3d4viBJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6C1C862D
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388777; cv=none; b=f7RM2u83MY0+uJy5DJpEEHrRkHuu9A7bDBqByJW5DVppuzBFKc4q8xK0vBIXhVh4geDr9VgFLtBsJIAFwngexFAgIMeZOZE6vx8pMZyPbqP6uoEXrMEbp/fd6XIgSMwiLeQzaIKNklvCwhfs3EY83ZXnMdO58IZgtyK/BpoMeJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388777; c=relaxed/simple;
	bh=za45gZn58io3q7G6R6uiLs/BWVajHmLqJcwZnfN5KLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQXHBybpuO3zOg3HDMuy0acsZgKoPAoUwRiJpMdWTBj/AOVJ7qE3M3dymmuPRTugX4Tip1eKhuvxBccKjR2N79gPReLWtt/UuscJFEvOGtZYoTTzSQSassVzohftdknrHSY7bssLAadGGMojVx0/ZvuMHLMiD2WbxRwSNoWhMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3d4viBJ; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63e2cc1ac4aso445457d50.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 16:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762388774; x=1762993574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2wQ5QxA+Nt4F/G4CAuMI2bjmJWmfwgXVieJdAcKAY0=;
        b=T3d4viBJTbj43qAWpPl1nIc2bz7A6+sGBSIQUqg9mWEY6aqqYjoXYgEkUPubCMaq5J
         2e7bH2ZwOsusIs7iFum/YzOM1J3N2xxP+Qde6kjH64rtFJUHTX18Q+ODqipJ1ThFyagF
         BUuvY+xmNdIAGcNXtf4jQWdyo3/jnb3MJRMLTL02jLII0xtnJifJshkX8xrJN14V4tKi
         qRtFLhPoT0pQZoCuYzF+5EedCQJ3RBa350apbld/lungBaG5643m7m5Fq/fje5lRSYJz
         GuES+P5k1rIixYmSJvM43ipWOL+nGKydenU8MW9ReI0OZ3Vfnr53RfnBiB4CePwekx1u
         P12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762388774; x=1762993574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2wQ5QxA+Nt4F/G4CAuMI2bjmJWmfwgXVieJdAcKAY0=;
        b=xNCyBxjdW+DCl2UB8zjGJiYuJ29NC6AB3xI6JVeQI3bkzrJ29sujn29hSlMIBdp0sA
         W9DO66sWcyrAtUadG+GVVrQ6q/5nG60lXTTguB4kDf9wq2C0QJYT8W0eo5Dr6gZmYYn8
         WhF+F7slms6b9F3iquzxfmouzc/NfNw9DOxgfYXGOBluURwG/q+RQa9CPqzyChSypYw5
         dR/KThXHYP8Y6WycNCtT2UQ383offsx/d5pOBLfv4JeR5F5u68kKuGROStddrHroWznx
         CrkOUV/Lp1jd9JrIQTP0QXlICJhJ/AkIOAL26of1irsZYjr7feMz3gGtIdDb63fUEfdH
         4Ung==
X-Forwarded-Encrypted: i=1; AJvYcCUYY1ahfktVxC/iCCy2jSMD44OWSjI7G7peNDXfWJh1R/DhYX9g7xwRcq7DDKvCWJRE6QOUyGwh/w20zZDV/8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIEqu5UEg8sPQXdHIT/iARreUwpzj7oWVFjpupPWtUYTuOBYNi
	L95I4Z6eBNEPuiDHZqWpLMnLde7oxWkp92kkCD2NIZ141QMaLj2C0T7E
X-Gm-Gg: ASbGnctkhPR+7wVKFwmkiXczHfYFiAb32e/4u03/6oGSCGWhVg8xhfNTwMpyqPhY4fr
	mVK8gwPXLHYnr/A4JyGcAsgpZKbra2QmUJeBYSE5d4XtWBvOEqZcTrWNZxyOZ2ufAJdgi8z0J+x
	My+RJEXtmcVHQbP8G4zVXJQ6OfujzSeA48yhqEJfIu92TzcUkTfa8p4DZEKtAJsE+4QXcHIt9Y+
	sAzfZ4cNDAn4e6qN5P6o4RVfCHPZBw8704vV/6fuyF8nLJ0mE+F6xhYQ9ZgPt+Ab71Ts0xboHSw
	5q0fqRKI2yBhNZef8x9+kadqx0JvQ5XMn14+E4POxhAUIYfr/7fYNeSX1e+s9J66RV4GoRjbi33
	Hh/icxWPlF3NQFrbvz6rD6AKTwWQWhJ6Rtwcn0caFB38wwxJUI2aDSiudCWsYhbX8P2NXCjYxip
	OhEBYN366dvg==
X-Google-Smtp-Source: AGHT+IE59zLZZYyAmzryk94tw8TktRRSTJ6JnEVpxnemBG5Bk+jMcvGOFztXLqAXDxrgMv9zYV/INA==
X-Received: by 2002:a05:690e:4082:b0:63d:bfad:6c7 with SMTP id 956f58d0204a3-63fd35b4528mr3942831d50.58.1762388773845;
        Wed, 05 Nov 2025 16:26:13 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:13::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b1400351sm3511567b3.20.2025.11.05.16.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:26:13 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 4/5] net/mlx5e: Add PSP stats support for Rx/Tx flows
Date: Wed,  5 Nov 2025 16:26:05 -0800
Message-ID: <20251106002608.1578518-5-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106002608.1578518-1-daniel.zahka@gmail.com>
References: <20251106002608.1578518-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Add all statistics described under the "Implementation Requirements"
section of the PSP Architecture Specification:

Rx successfully decrypted PSP packets:
psp_rx_pkts  : Number of packets decrypted successfully
psp_rx_bytes : Number of bytes decrypted successfully

Rx PSP authentication failure statistics:
psp_rx_pkts_auth_fail  : Number of PSP packets that failed authentication
psp_rx_bytes_auth_fail : Number of PSP bytes that failed authentication

Rx PSP bad frame error statistics:
psp_rx_pkts_frame_err;
psp_rx_bytes_frame_err;

Rx PSP drop statistics:
psp_rx_pkts_drop  : Number of PSP packets dropped
psp_rx_bytes_drop : Number of PSP bytes dropped

Tx successfully encrypted PSP packets:
psp_tx_pkts  : Number of packets encrypted successfully
psp_tx_bytes : Number of bytes encrypted successfully

Tx drops:
tx_drop : Number of misc psp related drops

The above can be seen using the ynl cli:
./pyynl/cli.py  --spec netlink/specs/psp.yaml --dump get-stats

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v3:
    - simplify error path in accel_psp_fs_init_tx()
    - avoid casting argument in mlx5e_accel_psp_fs_get_stats_fill()
    - delete unused member stats member in mlx5e_psp
    v2:
    - use %pe to print PTR_ERR()

 .../mellanox/mlx5/core/en_accel/psp.c         | 233 ++++++++++++++++--
 .../mellanox/mlx5/core/en_accel/psp.h         |  16 ++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   5 +
 4 files changed, 240 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 8565cfe8d7dc..38e7c77cc851 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -28,12 +28,15 @@ struct mlx5e_psp_tx {
 	struct mlx5_flow_handle *rule;
 	struct mutex mutex; /* Protect PSP TX steering */
 	u32 refcnt;
+	struct mlx5_fc *tx_counter;
 };
 
 struct mlx5e_psp_rx_err {
 	struct mlx5_flow_table *ft;
 	struct mlx5_flow_handle *rule;
-	struct mlx5_flow_handle *drop_rule;
+	struct mlx5_flow_handle *auth_fail_rule;
+	struct mlx5_flow_handle *err_rule;
+	struct mlx5_flow_handle *bad_rule;
 	struct mlx5_modify_hdr *copy_modify_hdr;
 };
 
@@ -50,6 +53,10 @@ struct mlx5e_accel_fs_psp_prot {
 
 struct mlx5e_accel_fs_psp {
 	struct mlx5e_accel_fs_psp_prot fs_prot[ACCEL_FS_PSP_NUM_TYPES];
+	struct mlx5_fc *rx_counter;
+	struct mlx5_fc *rx_auth_fail_counter;
+	struct mlx5_fc *rx_err_counter;
+	struct mlx5_fc *rx_bad_counter;
 };
 
 struct mlx5e_psp_fs {
@@ -72,9 +79,19 @@ static enum mlx5_traffic_types fs_psp2tt(enum accel_fs_psp_type i)
 static void accel_psp_fs_rx_err_del_rules(struct mlx5e_psp_fs *fs,
 					  struct mlx5e_psp_rx_err *rx_err)
 {
-	if (rx_err->drop_rule) {
-		mlx5_del_flow_rules(rx_err->drop_rule);
-		rx_err->drop_rule = NULL;
+	if (rx_err->bad_rule) {
+		mlx5_del_flow_rules(rx_err->bad_rule);
+		rx_err->bad_rule = NULL;
+	}
+
+	if (rx_err->err_rule) {
+		mlx5_del_flow_rules(rx_err->err_rule);
+		rx_err->err_rule = NULL;
+	}
+
+	if (rx_err->auth_fail_rule) {
+		mlx5_del_flow_rules(rx_err->auth_fail_rule);
+		rx_err->auth_fail_rule = NULL;
 	}
 
 	if (rx_err->rule) {
@@ -117,6 +134,7 @@ static int accel_psp_fs_rx_err_add_rule(struct mlx5e_psp_fs *fs,
 {
 	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
 	struct mlx5_core_dev *mdev = fs->mdev;
+	struct mlx5_flow_destination dest[2];
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_modify_hdr *modify_hdr;
 	struct mlx5_flow_handle *fte;
@@ -147,10 +165,14 @@ static int accel_psp_fs_rx_err_add_rule(struct mlx5e_psp_fs *fs,
 	accel_psp_setup_syndrome_match(spec, PSP_OK);
 	/* create fte */
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_MOD_HDR |
-		MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+			  MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
+			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
 	flow_act.modify_hdr = modify_hdr;
-	fte = mlx5_add_flow_rules(rx_err->ft, spec, &flow_act,
-				  &fs_prot->default_dest, 1);
+	dest[0].type = fs_prot->default_dest.type;
+	dest[0].ft = fs_prot->default_dest.ft;
+	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dest[1].counter = fs->rx_fs->rx_counter;
+	fte = mlx5_add_flow_rules(rx_err->ft, spec, &flow_act, dest, 2);
 	if (IS_ERR(fte)) {
 		err = PTR_ERR(fte);
 		mlx5_core_err(mdev, "fail to add psp rx err copy rule err=%d\n", err);
@@ -158,22 +180,69 @@ static int accel_psp_fs_rx_err_add_rule(struct mlx5e_psp_fs *fs,
 	}
 	rx_err->rule = fte;
 
-	/* add default drop rule */
+	/* add auth fail drop rule */
 	memset(spec, 0, sizeof(*spec));
 	memset(&flow_act, 0, sizeof(flow_act));
+	accel_psp_setup_syndrome_match(spec, PSP_ICV_FAIL);
 	/* create fte */
-	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP;
-	fte = mlx5_add_flow_rules(rx_err->ft, spec, &flow_act, NULL, 0);
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP |
+			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dest[0].counter = fs->rx_fs->rx_auth_fail_counter;
+	fte = mlx5_add_flow_rules(rx_err->ft, spec, &flow_act, dest, 1);
 	if (IS_ERR(fte)) {
 		err = PTR_ERR(fte);
-		mlx5_core_err(mdev, "fail to add psp rx err drop rule err=%d\n", err);
+		mlx5_core_err(mdev, "fail to add psp rx auth fail drop rule err=%d\n",
+			      err);
 		goto out_drop_rule;
 	}
-	rx_err->drop_rule = fte;
+	rx_err->auth_fail_rule = fte;
+
+	/* add framing drop rule */
+	memset(spec, 0, sizeof(*spec));
+	memset(&flow_act, 0, sizeof(flow_act));
+	accel_psp_setup_syndrome_match(spec, PSP_BAD_TRAILER);
+	/* create fte */
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP |
+			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dest[0].counter = fs->rx_fs->rx_err_counter;
+	fte = mlx5_add_flow_rules(rx_err->ft, spec, &flow_act, dest, 1);
+	if (IS_ERR(fte)) {
+		err = PTR_ERR(fte);
+		mlx5_core_err(mdev, "fail to add psp rx framing err drop rule err=%d\n",
+			      err);
+		goto out_drop_auth_fail_rule;
+	}
+	rx_err->err_rule = fte;
+
+	/* add misc. errors drop rule */
+	memset(spec, 0, sizeof(*spec));
+	memset(&flow_act, 0, sizeof(flow_act));
+	/* create fte */
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP |
+			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dest[0].counter = fs->rx_fs->rx_bad_counter;
+	fte = mlx5_add_flow_rules(rx_err->ft, spec, &flow_act, dest, 1);
+	if (IS_ERR(fte)) {
+		err = PTR_ERR(fte);
+		mlx5_core_err(mdev, "fail to add psp rx misc. err drop rule err=%d\n",
+			      err);
+		goto out_drop_error_rule;
+	}
+	rx_err->bad_rule = fte;
+
 	rx_err->copy_modify_hdr = modify_hdr;
 
 	goto out_spec;
 
+out_drop_error_rule:
+	mlx5_del_flow_rules(rx_err->err_rule);
+	rx_err->err_rule = NULL;
+out_drop_auth_fail_rule:
+	mlx5_del_flow_rules(rx_err->auth_fail_rule);
+	rx_err->auth_fail_rule = NULL;
 out_drop_rule:
 	mlx5_del_flow_rules(rx_err->rule);
 	rx_err->rule = NULL;
@@ -461,6 +530,10 @@ static void accel_psp_fs_cleanup_rx(struct mlx5e_psp_fs *fs)
 		return;
 
 	accel_psp = fs->rx_fs;
+	mlx5_fc_destroy(fs->mdev, accel_psp->rx_bad_counter);
+	mlx5_fc_destroy(fs->mdev, accel_psp->rx_err_counter);
+	mlx5_fc_destroy(fs->mdev, accel_psp->rx_auth_fail_counter);
+	mlx5_fc_destroy(fs->mdev, accel_psp->rx_counter);
 	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
 		fs_prot = &accel_psp->fs_prot[i];
 		mutex_destroy(&fs_prot->prot_mutex);
@@ -474,7 +547,10 @@ static int accel_psp_fs_init_rx(struct mlx5e_psp_fs *fs)
 {
 	struct mlx5e_accel_fs_psp_prot *fs_prot;
 	struct mlx5e_accel_fs_psp *accel_psp;
+	struct mlx5_core_dev *mdev = fs->mdev;
+	struct mlx5_fc *flow_counter;
 	enum accel_fs_psp_type i;
+	int err;
 
 	accel_psp = kzalloc(sizeof(*accel_psp), GFP_KERNEL);
 	if (!accel_psp)
@@ -485,9 +561,68 @@ static int accel_psp_fs_init_rx(struct mlx5e_psp_fs *fs)
 		mutex_init(&fs_prot->prot_mutex);
 	}
 
+	flow_counter = mlx5_fc_create(mdev, false);
+	if (IS_ERR(flow_counter)) {
+		mlx5_core_warn(mdev,
+			       "fail to create psp rx flow counter err=%pe\n",
+			       flow_counter);
+		err = PTR_ERR(flow_counter);
+		goto out_err;
+	}
+	accel_psp->rx_counter = flow_counter;
+
+	flow_counter = mlx5_fc_create(mdev, false);
+	if (IS_ERR(flow_counter)) {
+		mlx5_core_warn(mdev,
+			       "fail to create psp rx auth fail flow counter err=%pe\n",
+			       flow_counter);
+		err = PTR_ERR(flow_counter);
+		goto out_counter_err;
+	}
+	accel_psp->rx_auth_fail_counter = flow_counter;
+
+	flow_counter = mlx5_fc_create(mdev, false);
+	if (IS_ERR(flow_counter)) {
+		mlx5_core_warn(mdev,
+			       "fail to create psp rx error flow counter err=%pe\n",
+			       flow_counter);
+		err = PTR_ERR(flow_counter);
+		goto out_auth_fail_counter_err;
+	}
+	accel_psp->rx_err_counter = flow_counter;
+
+	flow_counter = mlx5_fc_create(mdev, false);
+	if (IS_ERR(flow_counter)) {
+		mlx5_core_warn(mdev,
+			       "fail to create psp rx bad flow counter err=%pe\n",
+			       flow_counter);
+		err = PTR_ERR(flow_counter);
+		goto out_err_counter_err;
+	}
+	accel_psp->rx_bad_counter = flow_counter;
+
 	fs->rx_fs = accel_psp;
 
 	return 0;
+
+out_err_counter_err:
+	mlx5_fc_destroy(mdev, accel_psp->rx_err_counter);
+	accel_psp->rx_err_counter = NULL;
+out_auth_fail_counter_err:
+	mlx5_fc_destroy(mdev, accel_psp->rx_auth_fail_counter);
+	accel_psp->rx_auth_fail_counter = NULL;
+out_counter_err:
+	mlx5_fc_destroy(mdev, accel_psp->rx_counter);
+	accel_psp->rx_counter = NULL;
+out_err:
+	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
+		fs_prot = &accel_psp->fs_prot[i];
+		mutex_destroy(&fs_prot->prot_mutex);
+	}
+	kfree(accel_psp);
+	fs->rx_fs = NULL;
+
+	return err;
 }
 
 void mlx5_accel_psp_fs_cleanup_rx_tables(struct mlx5e_priv *priv)
@@ -532,6 +667,7 @@ static int accel_psp_fs_tx_create_ft_table(struct mlx5e_psp_fs *fs)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_flow_destination dest = {};
 	struct mlx5_core_dev *mdev = fs->mdev;
 	struct mlx5_flow_act flow_act = {};
 	u32 *in, *mc, *outer_headers_c;
@@ -580,8 +716,11 @@ static int accel_psp_fs_tx_create_ft_table(struct mlx5e_psp_fs *fs)
 	flow_act.crypto.type = MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_PSP;
 	flow_act.flags |= FLOW_ACT_NO_APPEND;
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_ALLOW |
-			  MLX5_FLOW_CONTEXT_ACTION_CRYPTO_ENCRYPT;
-	rule = mlx5_add_flow_rules(ft, spec, &flow_act, NULL, 0);
+			  MLX5_FLOW_CONTEXT_ACTION_CRYPTO_ENCRYPT |
+			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dest.counter = tx_fs->tx_counter;
+	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
 		mlx5_core_err(mdev, "PSP: fail to add psp tx flow rule, err = %d\n", err);
@@ -650,6 +789,7 @@ static void accel_psp_fs_cleanup_tx(struct mlx5e_psp_fs *fs)
 	if (!tx_fs)
 		return;
 
+	mlx5_fc_destroy(fs->mdev, tx_fs->tx_counter);
 	mutex_destroy(&tx_fs->mutex);
 	WARN_ON(tx_fs->refcnt);
 	kfree(tx_fs);
@@ -658,10 +798,12 @@ static void accel_psp_fs_cleanup_tx(struct mlx5e_psp_fs *fs)
 
 static int accel_psp_fs_init_tx(struct mlx5e_psp_fs *fs)
 {
+	struct mlx5_core_dev *mdev = fs->mdev;
 	struct mlx5_flow_namespace *ns;
+	struct mlx5_fc *flow_counter;
 	struct mlx5e_psp_tx *tx_fs;
 
-	ns = mlx5_get_flow_namespace(fs->mdev, MLX5_FLOW_NAMESPACE_EGRESS_IPSEC);
+	ns = mlx5_get_flow_namespace(mdev, MLX5_FLOW_NAMESPACE_EGRESS_IPSEC);
 	if (!ns)
 		return -EOPNOTSUPP;
 
@@ -669,12 +811,55 @@ static int accel_psp_fs_init_tx(struct mlx5e_psp_fs *fs)
 	if (!tx_fs)
 		return -ENOMEM;
 
+	flow_counter = mlx5_fc_create(mdev, false);
+	if (IS_ERR(flow_counter)) {
+		mlx5_core_warn(mdev,
+			       "fail to create psp tx flow counter err=%pe\n",
+			       flow_counter);
+		kfree(tx_fs);
+		return PTR_ERR(flow_counter);
+	}
+	tx_fs->tx_counter = flow_counter;
 	mutex_init(&tx_fs->mutex);
 	tx_fs->ns = ns;
 	fs->tx_fs = tx_fs;
 	return 0;
 }
 
+static void
+mlx5e_accel_psp_fs_get_stats_fill(struct mlx5e_priv *priv,
+				  struct mlx5e_psp_stats *stats)
+{
+	struct mlx5e_psp_tx *tx_fs = priv->psp->fs->tx_fs;
+	struct mlx5_core_dev *mdev = priv->mdev;
+	struct mlx5e_accel_fs_psp *accel_psp;
+
+	accel_psp = (struct mlx5e_accel_fs_psp *)priv->psp->fs->rx_fs;
+
+	if (tx_fs->tx_counter)
+		mlx5_fc_query(mdev, tx_fs->tx_counter, &stats->psp_tx_pkts,
+			      &stats->psp_tx_bytes);
+
+	if (accel_psp->rx_counter)
+		mlx5_fc_query(mdev, accel_psp->rx_counter, &stats->psp_rx_pkts,
+			      &stats->psp_rx_bytes);
+
+	if (accel_psp->rx_auth_fail_counter)
+		mlx5_fc_query(mdev, accel_psp->rx_auth_fail_counter,
+			      &stats->psp_rx_pkts_auth_fail,
+			      &stats->psp_rx_bytes_auth_fail);
+
+	if (accel_psp->rx_err_counter)
+		mlx5_fc_query(mdev, accel_psp->rx_err_counter,
+			      &stats->psp_rx_pkts_frame_err,
+			      &stats->psp_rx_bytes_frame_err);
+
+	if (accel_psp->rx_bad_counter)
+		mlx5_fc_query(mdev, accel_psp->rx_bad_counter,
+			      &stats->psp_rx_pkts_drop,
+			      &stats->psp_rx_bytes_drop);
+}
+
 void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv)
 {
 	if (!priv->psp)
@@ -849,12 +1034,30 @@ mlx5e_psp_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *exack)
 	return mlx5e_psp_rotate_key(priv->mdev);
 }
 
+static void
+mlx5e_psp_get_stats(struct psp_dev *psd, struct psp_dev_stats *stats)
+{
+	struct mlx5e_priv *priv = netdev_priv(psd->main_netdev);
+	struct mlx5e_psp_stats nstats;
+
+	mlx5e_accel_psp_fs_get_stats_fill(priv, &nstats);
+	stats->rx_packets = nstats.psp_rx_pkts;
+	stats->rx_bytes = nstats.psp_rx_bytes;
+	stats->rx_auth_fail = nstats.psp_rx_pkts_auth_fail;
+	stats->rx_error = nstats.psp_rx_pkts_frame_err;
+	stats->rx_bad = nstats.psp_rx_pkts_drop;
+	stats->tx_packets = nstats.psp_tx_pkts;
+	stats->tx_bytes = nstats.psp_tx_bytes;
+	stats->tx_error = atomic_read(&priv->psp->tx_drop);
+}
+
 static struct psp_dev_ops mlx5_psp_ops = {
 	.set_config   = mlx5e_psp_set_config,
 	.rx_spi_alloc = mlx5e_psp_rx_spi_alloc,
 	.tx_key_add   = mlx5e_psp_assoc_add,
 	.tx_key_del   = mlx5e_psp_assoc_del,
 	.key_rotate   = mlx5e_psp_key_rotate,
+	.get_stats    = mlx5e_psp_get_stats,
 };
 
 void mlx5e_psp_unregister(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
index 42bb671fb2cb..6b62fef0d9a7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
@@ -7,11 +7,27 @@
 #include <net/psp/types.h>
 #include "en.h"
 
+struct mlx5e_psp_stats {
+	u64 psp_rx_pkts;
+	u64 psp_rx_bytes;
+	u64 psp_rx_pkts_auth_fail;
+	u64 psp_rx_bytes_auth_fail;
+	u64 psp_rx_pkts_frame_err;
+	u64 psp_rx_bytes_frame_err;
+	u64 psp_rx_pkts_drop;
+	u64 psp_rx_bytes_drop;
+	u64 psp_tx_pkts;
+	u64 psp_tx_bytes;
+	u64 psp_tx_pkts_drop;
+	u64 psp_tx_bytes_drop;
+};
+
 struct mlx5e_psp {
 	struct psp_dev *psp;
 	struct psp_dev_caps caps;
 	struct mlx5e_psp_fs *fs;
 	atomic_t tx_key_cnt;
+	atomic_t tx_drop;
 };
 
 static inline bool mlx5_is_psp_device(struct mlx5_core_dev *mdev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
index 828bff1137af..c17ea0fcd8ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
@@ -186,6 +186,7 @@ bool mlx5e_psp_handle_tx_skb(struct net_device *netdev,
 	/* psp_encap of the packet */
 	if (!psp_dev_encapsulate(net, skb, psp_st->spi, psp_st->ver, 0)) {
 		kfree_skb_reason(skb, SKB_DROP_REASON_PSP_OUTPUT);
+		atomic_inc(&priv->psp->tx_drop);
 		return false;
 	}
 	if (skb_is_gso(skb)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 7b7a0060979d..3fdb1de94c9b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4011,6 +4011,11 @@ void mlx5e_fold_sw_stats64(struct mlx5e_priv *priv, struct rtnl_link_stats64 *s)
 		s->rx_bytes     += rq_stats->bytes;
 		s->multicast    += rq_stats->mcast_packets;
 	}
+
+#ifdef CONFIG_MLX5_EN_PSP
+	if (priv->psp)
+		s->tx_dropped	+= atomic_read(&priv->psp->tx_drop);
+#endif
 }
 
 void
-- 
2.47.3


