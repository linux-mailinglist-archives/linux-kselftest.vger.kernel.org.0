Return-Path: <linux-kselftest+bounces-44159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91139C12217
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 01:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E01A1890381
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012A22EBDF0;
	Tue, 28 Oct 2025 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yz/QIiZW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D8227599
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609629; cv=none; b=OqCNgu0mLCNXYOMC/0LuFfwNSrKyVyChWctntNRwNwIOY9KCXe8U3SU4zujfub42fXw7AOmmIhyapaCZYRoWg3YYogp89OXp4fPmZAHTgz9vjygIpi0U5xYUWrQs1XmarHgIomk/Yq4BVSXP/r46yci1R7l1D4p532FH5p0O4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609629; c=relaxed/simple;
	bh=QR2dtsbS7UwluGoSZW4mLmSa/tnfkqCojkKtoHA71rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJVq2OBA5WwyPoJJq1Sasf+7Abnt3FIc+PX5K4RvGSXvXKRQit+gDdf/TP504jvtKK72NaDVxVItYCUG0dKOl0Hb3IU5O2SKtrYxSaF5C+VoLJ2Pr32ElqUqt8m/ysE5q2npK7Js9BLI6NNVsEhljmBvGralXPFv1ZXwF2OGitI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yz/QIiZW; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63d0692136bso6249153d50.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 17:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761609627; x=1762214427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMiDZHWOUNK2yHGSlay4OKVr5nHbaNPUDwYp1k2lS6U=;
        b=Yz/QIiZWGNc8zZlN7kool5axIpfZgG/weDQIYGf6ilgaZgJ++IbpDXKCXiKCVXgKK2
         oEomLjNQkYroF+u39jE2veVpfiT0aKLplM/8wMUwgop1JHkelsNoHrKuYMo80+L/W5Hn
         7I3jekg3qRQVtgALHU80gaRQfZe8CN5XWOzMfIduAmR48FmM8ag59CWhHYc0Yol3/Gnr
         BnGQ8ZSW32jCzvoj2ajUQUb8RdsaaXAZAMcVHX/q2Ym9BVMFaUEY4B5l4xfYHuw6NDnQ
         N5M8XDWO32449i9D07YxxDkdIQvMl6LOh2ehHcK89Ln10Z2svF6ob/JroSVc2m8ly5EN
         /Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609627; x=1762214427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMiDZHWOUNK2yHGSlay4OKVr5nHbaNPUDwYp1k2lS6U=;
        b=M3yeucMTBrA6hw8Ee/Awpxq1zunpMB/+cSyxcxUnAQXm+5NWQdkhlPLAQcqrcb79mv
         vPxvLuoBvRgyZ0t+trj+Ul9kl7mNNJ9qgsfejqXVWHbKcR4NwgEzi5G4w9PrIV5tKKXF
         /wdEVBwyjbix0zI9U9JvjmmyO2bw4NZlqlcYoGhPInGySwAl5tvbIdJoOmu7vCJqb0Sy
         08AgTexnxpQA9IF6l+J1HmxNkI9/CD54rktezg189r6r8fP3Sm5NCZm5r1o9NC5o+ojn
         MFkXkxTxMEskJcqp2AAAYNk76TEcCIkqBwryRyRNzyQyr4MsqWeIIR0HijjZb8yt/Iq5
         BHRA==
X-Forwarded-Encrypted: i=1; AJvYcCUCZ3ZqJ4lZunXOLOchaKfUBY2xZc3PgfzGXF8PA6vFG6GHDloCiBLjOoNlbdSnEH6yU17hcBl7bVy65EJEkMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgPFe2UO0dKWLY1lC7cgoEM2PsrVX7jiZNYcud9lFqldU4/3S9
	diXAe021Dfx/CPEg75iVZNBrC4ZTYeode5KYfYqORdNXQgvwMITTN83e
X-Gm-Gg: ASbGncvtgmd91e+yueZZVMb92wYw3gnPW3ENUb5sbVcPR0O1iQtKQaYx4XEwH9jhwqF
	iG73KJIsTg7ulhxR7MxGNFh5fa7eniSNOCDeze9Xr8MnJSr95nmSywufXpS7NdAFYCW6DJhB0DT
	HGfakE8wARLTFbnts2fRV2bEPPJqczdKO+V01zawZNuZB8kVYsyf96RDvo0ElVzG9yGKX5mhlke
	D0EXYQOBhg56otEvulWvxa4AVp1A2cw1vXF9+YqEteulimYMoMbZPvlrvwQea+XWsjNNeEtYvfh
	+9pqAJJnW8C/ZZhNWsRZEvvMNlosWRMAq4FqtjsUnZZ2/ij6VKEbYgJ+gdgAtizqK8uyrplfyM/
	ja6nyX5c+JjLEGwmdNpKt+it9mvgmuzM15+tZJg5Q4hM9xRjILu8ZRALG6CQ+gER7BzF9s7FOuj
	/G+Xri5A7UeA==
X-Google-Smtp-Source: AGHT+IEzvoGO/9PCP63+vtMrinkWY9/WHwpDM4iVV3uWfF7XFeKpTw+b5i5D6o4Fr6kqDpK+dhVDzQ==
X-Received: by 2002:a05:690e:d08:b0:63c:e90c:a6dc with SMTP id 956f58d0204a3-63f6b9b17c4mr1840582d50.8.1761609626416;
        Mon, 27 Oct 2025 17:00:26 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1bf36dsm23135087b3.42.2025.10.27.17.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:00:25 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/5] net/mlx5e: Add PSP stats support for Rx/Tx flows
Date: Mon, 27 Oct 2025 17:00:15 -0700
Message-ID: <20251028000018.3869664-5-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028000018.3869664-1-daniel.zahka@gmail.com>
References: <20251028000018.3869664-1-daniel.zahka@gmail.com>
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
    v2:
    - use %pe to print PTR_ERR()

 .../mellanox/mlx5/core/en_accel/psp.c         | 239 ++++++++++++++++--
 .../mellanox/mlx5/core/en_accel/psp.h         |  18 ++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   5 +
 4 files changed, 248 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 8565cfe8d7dc..93a1ddfc7f8a 100644
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
@@ -658,10 +798,13 @@ static void accel_psp_fs_cleanup_tx(struct mlx5e_psp_fs *fs)
 
 static int accel_psp_fs_init_tx(struct mlx5e_psp_fs *fs)
 {
+	struct mlx5_core_dev *mdev = fs->mdev;
 	struct mlx5_flow_namespace *ns;
+	struct mlx5_fc *flow_counter;
 	struct mlx5e_psp_tx *tx_fs;
+	int err;
 
-	ns = mlx5_get_flow_namespace(fs->mdev, MLX5_FLOW_NAMESPACE_EGRESS_IPSEC);
+	ns = mlx5_get_flow_namespace(mdev, MLX5_FLOW_NAMESPACE_EGRESS_IPSEC);
 	if (!ns)
 		return -EOPNOTSUPP;
 
@@ -670,9 +813,57 @@ static int accel_psp_fs_init_tx(struct mlx5e_psp_fs *fs)
 		return -ENOMEM;
 
 	mutex_init(&tx_fs->mutex);
+	flow_counter = mlx5_fc_create(mdev, false);
+	if (IS_ERR(flow_counter)) {
+		mlx5_core_warn(mdev,
+			       "fail to create psp tx flow counter err=%pe\n",
+			       flow_counter);
+		err = PTR_ERR(flow_counter);
+		goto out_err;
+	}
+	tx_fs->tx_counter = flow_counter;
 	tx_fs->ns = ns;
 	fs->tx_fs = tx_fs;
 	return 0;
+
+out_err:
+	mutex_destroy(&tx_fs->mutex);
+	kfree(tx_fs);
+	return err;
+}
+
+static void
+mlx5e_accel_psp_fs_get_stats_fill(struct mlx5e_priv *priv, void *psp_stats)
+{
+	struct mlx5e_psp_stats *stats = (struct mlx5e_psp_stats *)psp_stats;
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
 }
 
 void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv)
@@ -849,12 +1040,30 @@ mlx5e_psp_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *exack)
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
index 42bb671fb2cb..b3284d00415f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
@@ -7,11 +7,29 @@
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
+	/* Stats manage */
+	struct mlx5e_psp_stats stats;
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
index 9c46511e7b43..7d2419fda70a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3999,6 +3999,11 @@ void mlx5e_fold_sw_stats64(struct mlx5e_priv *priv, struct rtnl_link_stats64 *s)
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


