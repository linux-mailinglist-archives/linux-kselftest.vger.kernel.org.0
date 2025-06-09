Return-Path: <linux-kselftest+bounces-34491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBC0AD23D2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4DF188FF40
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6F721A434;
	Mon,  9 Jun 2025 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ydz8h5jt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168220A5C4;
	Mon,  9 Jun 2025 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486345; cv=none; b=mCB1sdpSdTuUPBvO3Q5yL/xLWZAbznREi0ruIOrZlAtpmSG3h30hzk69AsX9gjXQUWDUrWUcB9ViYME84geEtelL2ktN6Qn8ZaCMyxukdYWRMZjDpJjUnRbjTouANZgRwGY4H5Lw1cIlECnHs4hNsPLJ15cts9CezErErgxMmPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486345; c=relaxed/simple;
	bh=5ke2rwDYEJ1dSR5wthRWmE4KjObtmi12gQgU4P+EElo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZTHjWwjyxBhSLfS3+Pzdez4NrIf6oT3u4d08Z8WH+mdgB7XZNXxFtxLWVhKXiwUJaof12kFDbhAijC6l1zdtb/rFZoStTFa1ubkB4opHd04GY7ZSAf40lPt4me71bnF9QZdVCxcrMjxDf1Ykuv7ekOHm09R+V0U5m/WcSPiKpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ydz8h5jt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235e1d710d8so54897965ad.1;
        Mon, 09 Jun 2025 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749486343; x=1750091143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4kOKITQRITLOt58CZKljNXLISgdMuGvM6LUD4e7M+A=;
        b=Ydz8h5jtprF9ncvTPC2p/MeMgoA6dOi1eduUwvtXJaok3DE6v4/SxhcmpQJrdNvUp7
         I//5BoqruuWf6QlrbxciZs8Z0LCa2NuC7MYhXIU1ynVAdaveN+PI9OSvyLijG5KUQ5/Z
         4e9XAUpeEVTG1MHsk0BTiTEitj4TErAYj0gpe5xUmQcrmaaxxAT3VsyU8N7WcyeWYVft
         Iwuis2HHoHSbZKBTucewrEAmPwmDCQRo2c/mIb/dxqBUTH8tFNyN4nT18KvojWY2ohOY
         mkSKFsxb/P2JAPKEe9742ObWJxJmyZFNWmHMja5Xl4XVYm/kq7tWc92FMfMMoMvGriMW
         zfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749486343; x=1750091143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4kOKITQRITLOt58CZKljNXLISgdMuGvM6LUD4e7M+A=;
        b=GM00hRSTVC2QSpGdGsReOgAGZ3v8RXEi4XRSOQCZFu7MNde+1oUrp351hKMo/vXSWT
         JONcjWVPeejaehaKwOB+Sdke1JwkKLlbR2znfjlS7+ifIlQA7XAMY0XQ4R4Vxjc5Ojdz
         On9JFawD7xtume/U68oq3UYOcD6pFYX3DTiziXYuPYGtl/13KYwIX2aBTxdQKaUaqog0
         YPo+5sizsQfU+Dsz5bFpNpHrjXO3CXF/SzMKf4cIcnF8pBRh/IlzoKbN+qafKlH1j0gO
         lzMM7SFww2cjd2Y4/rvWX/p+mQ3vTiQx5ERTnLWBWJd7T0IBrMAubNImhbQ0qxiJMtEu
         GPeg==
X-Forwarded-Encrypted: i=1; AJvYcCWKi6cMMYogThI+0dmEvaaDfgzWYxJhjXJNVXO/KP4KVY1lll0arkmcgP89+Crt5KrEA7D2jJhOh2wyeQ==@vger.kernel.org, AJvYcCWhwV1NLXZSda675xp83OiD6IvWSl4tr6LLEKbyT8fOMBMaUJ46e1pwchtRjEwNfIrVLrcG61ixT5TiPCvAivx6@vger.kernel.org, AJvYcCXgWaOcOzVUo7fr0/GBT9dMW9jeslVprKVWtI4hbEzTnBefbTsUcQCkL0BwL5p+goQ0bHFxfg2TnTViqWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrRMCbg/Kx/0jj3XSnCIEIekhd+VqjlfFv3Kp3i3BnVK27+n0m
	0+g8GVN9A+mBqVP1JWmtwJ/y4GLisfQ8rMWFCei31aHbwsviBi1gYRW3nQb+
X-Gm-Gg: ASbGncuZC+WkC+XDXHwvxp1afFIv2qLoObfLCgMF3LlYWyiEjgnylFPi7yVXFrOxXPG
	NhYWGAhBAic2EadOg8D2jQzdHUldO9OTwlcl0VzQvq0iQlfdVBtka5tLn9cJ1X5gR47TCKLeAJN
	Kz2UA2u4aLtmHt6Qz5LEBMmzX1AhiK0ZEioesnxHHyXKLz6qGA6Xc4HGqY/cyrCF3KVqbovPBAf
	SrzJKvTfY1naJfhJeYK5gIaOUVcL3tvfo/L8dStV0kRRzuzQbyQHwMX7n6etd3YZgkabSy3pas8
	+3tLbnfl3GdQX9qfRewcrcSncD5J9fNoRdXIzuSiN+c1KhL0kB1/+KCNGTHr/VZcWP9fslNocV8
	3pq456zx6wRjWl5OqQ7C5yGdANE7KidxzVg==
X-Google-Smtp-Source: AGHT+IHPHlziNsak1LqRUNF3N7nomngCbHiW2pNrdccj9YyCAqRz24LVjTOtRhdyC+7j5Al+6L2/1w==
X-Received: by 2002:a17:903:41c8:b0:234:e3b7:5cd2 with SMTP id d9443c01a7336-23601da9abbmr211768695ad.46.1749486343206;
        Mon, 09 Jun 2025 09:25:43 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2360341097fsm56723385ad.214.2025.06.09.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 09:25:42 -0700 (PDT)
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
	leon@kernel.org
Subject: [PATCH net-next v2 0/4] udp_tunnel: remove rtnl_lock dependency
Date: Mon,  9 Jun 2025 09:25:37 -0700
Message-ID: <20250609162541.1230022-1-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently bnxt had to grow back a bunch of rtnl dependencies because
of udp_tunnel's infra. Add separate (global) mutext to protect
udp_tunnel state.

v2:
- move the lock into udp_tunnel_nic (Jakub)
- reorder the lock ordering (Jakub)
- move udp_ports_sleep removal into separate patch and update the test
  (Jakub)

Cc: Michael Chan <michael.chan@broadcom.com>

Stanislav Fomichev (4):
  udp_tunnel: remove rtnl_lock dependency
  net: remove redundant ASSERT_RTNL() in queue setup functions
  netdevsim: remove udp_ports_sleep
  Revert "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"

 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 42 ++++---------------
 drivers/net/ethernet/emulex/benet/be_main.c   |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  1 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  1 -
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  3 +-
 .../ethernet/netronome/nfp/nfp_net_common.c   |  3 +-
 .../net/ethernet/qlogic/qede/qede_filter.c    |  3 --
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  1 -
 drivers/net/ethernet/sfc/ef10.c               |  1 -
 drivers/net/netdevsim/netdevsim.h             |  2 -
 drivers/net/netdevsim/udp_tunnels.c           | 12 ------
 include/net/udp_tunnel.h                      |  8 ++--
 net/core/dev.c                                |  2 -
 net/ipv4/udp_tunnel_nic.c                     | 30 +++++++------
 .../drivers/net/netdevsim/udp_tunnel_nic.sh   | 10 -----
 17 files changed, 31 insertions(+), 97 deletions(-)

-- 
2.49.0


