Return-Path: <linux-kselftest+bounces-34961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44208AD9650
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 22:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B2017C060
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 20:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9342224676D;
	Fri, 13 Jun 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9rLcgov"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0441D21C176;
	Fri, 13 Jun 2025 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846809; cv=none; b=mQtjbQ9ZNRGJErRQlu4s/zBkfSVW1psjgHxjsD0bYB2yOG5PyhL6f0lyrrDVQ0q5/+hlGYDx5+i5hNP+JMP4fJRg2RwkiYzSJ34FSV0JccC2+45M/y3d2K42wyHaQgozo9xqiNja2bVeQEZPR1pNwOfAkLDWlcSCY1ivgRiB6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846809; c=relaxed/simple;
	bh=UovT/ZB9FyESr0A8ZCouEz1hivRGNty4iTls1N5CnYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TgBEwJyEZ/yetTUxu4XMU1Gr4br/U/LnE4DP3Yh5JpddPsmn/LukfhrfSCwztm0JtFOdbaTUOSkA/ilCyZJ33lFW3XbR5y0pRbiXvnM8kXaYkZJs86qJhtMyeKjNqyv54SFrdEmfM71RojYjslF23mHmSqvWlV60danLEERLtQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9rLcgov; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2c4476d381so2307025a12.0;
        Fri, 13 Jun 2025 13:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749846807; x=1750451607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwRAnCMRMy4NI04BUJ5xATTCrVm8zFet775Y9+JU/To=;
        b=Q9rLcgovjWMiyH3hvqvLsJH9iLk3EzGnne8DV8ZXEZL0JUsjwUqCitE5h1XoOB8Lp+
         H8GHC9rUfBjXhhj5lQX/9bLpIyJ77/MAehO2q6ggMR+QQx9JGzk5Zcoe8TGUIk8m5/G0
         H6tmU7xtO6A0sZT/Or6PL08wvoFYr63jSbqpmIFbeyBi5LLDu/+pFsWx92/0joE/CPD6
         8B8k64HvhhgZ129JGOkUvDMaTF19oi8I58gJeIn0X1BK5gDywAYumwBp8b2h5KqSpU6N
         xkhO5CpDEY000vQLRAi8juhiSrhCZ/G5yEnCqRuQ7YbXa+GWKFI2ArV+iyjfgTy6k1R1
         w3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846807; x=1750451607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwRAnCMRMy4NI04BUJ5xATTCrVm8zFet775Y9+JU/To=;
        b=v53sdNRCw8VI71i2abX8vmXxaLENTgohvN/sZx7P4Ns5mq5CfWIoppeODKYB8FDNvm
         oK+iO+WiFTQFvEwUcoWL9lWFTr3+AHZHXv3X8WmS5LcxacJxO6okPJOP4/na5aaDTcWS
         PX6PUAPekx9S0R6X7MiWfUB9jqQa+lyokjIvpCAHhu+C1hXcGfo3lnV+V+OmC/iJK0KZ
         xIXyYrWGEbTHKhuhrueGiq3ovJBgtD+VOhUgZ/MRRItf8PKSRkPhnqMhzyL9gPdzH6pu
         uiGKX9oF0/HorhNQ8Y8BNC5lfRpSp6o21bUdE2HwNTudSMgrmAC0xNVFpZvIYUxTNxEj
         O/8A==
X-Forwarded-Encrypted: i=1; AJvYcCV65bNMh5U2wXESK7ARiP27P7AnlHNboiWB2j8wZnpAARVysWUOMdfYJWP7pyknhFkacONMDIVL4YSTDg==@vger.kernel.org, AJvYcCVCtWproQYl2ER1V9baeMGfIK5+throSH+A4C14Ae3f3neCtIilKgnW54voVpJ8lVoO72mfunY2+HvqnmDyb82j@vger.kernel.org, AJvYcCWph8sgZFVd2xhy5qqKHoxXy3RwojHLQ2nDgawvM5WodyaHOHeP+mFnm41cc6a1E6oepK4k7tlWrRry2Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoi5t6qUuqthERfsvJabQh2DIHLyzmqsO9NUdTKLFG5gxe952A
	z9A39D5MaMLs1S0leuJxd/bx4hwfFNtCZICFV0isHyeGFHV0KSVUgcICWm38
X-Gm-Gg: ASbGncsjGS3F7RLDZf8o4NB0OIrZWHKSHu2kAPE2TeKkpjVaHgpVKhZyaflv3dKgk//
	ZmwEIbqf9I2FIfkKsblPklQY4B0hTT5NUzUQdLsu7MuJrlkaHm+MaIp0/wVdE7t3ZIT6zBsEsXT
	9e/GxvFT49Mji2LltVnWqHwdPav6CVDTAhQEXrZL3bMrdKL+agnMq64jCZ+UH/ihOm6UZLpE9JQ
	eyr5N+C2ciONVQWdKYjnHOoYkz6/mE4BRKfFdd+BLyelqDlKLgLipaSqrx7FOeouRV/xxU+jCzC
	NBiTZC1TSa9mDGhLRC846l9qDspS/DEvwaYMBi/UxuffhQZniGuu2x3aDMLNrOhWQ8o7ZS7b4pM
	zhIG0ktv4nQc5oID9/wKylPQ=
X-Google-Smtp-Source: AGHT+IFofoxaBBjnJtXHhezT3t2Miq2Uz35b+y2fjwYckYFssZ1+zOwtoBfHJPoJcIM6hLG+m6recw==
X-Received: by 2002:a05:6a20:7346:b0:21f:54e0:b0a3 with SMTP id adf61e73a8af0-21fbc62cb6bmr1432515637.2.1749846806751;
        Fri, 13 Jun 2025 13:33:26 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74890084af3sm2135347b3a.97.2025.06.13.13.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 13:33:26 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/6] udp_tunnel: remove rtnl_lock dependency
Date: Fri, 13 Jun 2025 13:33:19 -0700
Message-ID: <20250613203325.1127217-1-stfomichev@gmail.com>
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

v4:
- grab lock in more places, specifically netlink and notifiers (Jakub)
- convert geneve and vxlan notifiers to (sleepable) rtnl lock

v3:
- fix 2 test failures (Jakub NIPA)

v2:
- move the lock into udp_tunnel_nic (Jakub)
- reorder the lock ordering (Jakub)
- move udp_ports_sleep removal into separate patch and update the test
(Jakub)

Cc: Michael Chan <michael.chan@broadcom.com>

Stanislav Fomichev (6):
  geneve: rely on rtnl lock in geneve_offload_rx_ports
  vxlan: drop sock_lock
  udp_tunnel: remove rtnl_lock dependency
  net: remove redundant ASSERT_RTNL() in queue setup functions
  netdevsim: remove udp_ports_sleep
  Revert "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"

 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 42 ++-------
 drivers/net/ethernet/emulex/benet/be_main.c   |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  1 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  1 -
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  3 +-
 .../ethernet/netronome/nfp/nfp_net_common.c   |  3 +-
 .../net/ethernet/qlogic/qede/qede_filter.c    |  3 -
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  1 -
 drivers/net/ethernet/sfc/ef10.c               |  1 -
 drivers/net/geneve.c                          |  7 +-
 drivers/net/netdevsim/netdevsim.h             |  2 -
 drivers/net/netdevsim/udp_tunnels.c           | 12 ---
 drivers/net/vxlan/vxlan_core.c                | 34 ++++----
 drivers/net/vxlan/vxlan_private.h             |  2 +-
 drivers/net/vxlan/vxlan_vnifilter.c           | 18 ++--
 include/net/udp_tunnel.h                      | 87 ++++++++++++++-----
 net/core/dev.c                                |  4 +-
 net/ipv4/udp_tunnel_core.c                    | 16 ++--
 net/ipv4/udp_tunnel_nic.c                     | 78 +++++++++++++----
 .../drivers/net/netdevsim/udp_tunnel_nic.sh   | 23 +----
 22 files changed, 177 insertions(+), 170 deletions(-)

-- 
2.49.0


