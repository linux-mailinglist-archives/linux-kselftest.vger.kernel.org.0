Return-Path: <linux-kselftest+bounces-35102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D96BADB68A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36041188C5F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F26B286437;
	Mon, 16 Jun 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxE4ZsKv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88413259C9F;
	Mon, 16 Jun 2025 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090881; cv=none; b=WduYWnOFXP6QwsITeo/woMPKGi3wC3AF5AJB6nr/QcWQThCqXuPjYCCh7NFkRk3jpeXwTgV/NafVKdtoV4cmcdq7a+Bc0iW1cnbfp33ozoUOT0ZZigqcq3oP87DtYHXJ0dSIdK+nAtpcN2E6tiZyvLslMKD1m8skVTm3OT+ZT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090881; c=relaxed/simple;
	bh=k7/WisMXKbWlUR77eX7NtSJyTLCBVVNGedGYzI96uRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jx/k5CIhtspKAWKIMcVVUPa4z/VLOcOFfoXa2M9e9fnY9ZbaaB5oKfUpue+DbqNm3XM93lFLsjhtPYb0YLJCQ0IrmjC7Tch1IIrNdVe+APm5/3VKa0GRERgjzXYuBOEMf47MN6xZzPSqHhWdl7gvCt3IjQzDM9JCHAP7AisBxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxE4ZsKv; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so4908178a12.0;
        Mon, 16 Jun 2025 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750090878; x=1750695678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VpBWNqe15V8+KavYjcJ0yYawZufKK5c9dNkPp38Ln4Y=;
        b=HxE4ZsKvEhIWz2axYUgC5vfebpG70DD9Lsgbvqpm9DHmE8LXEVvoh64mrysnu1n5T5
         6ew7G35UqwQ47rPXhmoU48H7RjN7gmHeLpYnaJjdZeMHtYrCcQQ2cq4xgumG7BoX/LQs
         LyH04YhDJSAos34ojCupIhLrfIjzOnlZbA5IKxUc3n3wPCXL06gydGF1TQjx68u0QN0j
         /cYX1uYiO6W3X1jshm81WBsUf9yGzQ/Wcx5NQU7jgKjzkOl6rc6nqiSPiwRdmrBQ4grf
         XIvduLiWQLNrJAYBrPPYyOJT58GsHOK9XIMdm9GaA0dRKL7baDwZGMa2z90Lq61rVNKm
         Stdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090878; x=1750695678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpBWNqe15V8+KavYjcJ0yYawZufKK5c9dNkPp38Ln4Y=;
        b=bAiIHfS4ErirhuzsWuTTQQJRy9xnOMB9758yAl09cokrTC0kOq8tVOgCqJHwRgur3w
         e8950zQy+dsiM8pIwJzJvS0IqeHnhvrgFoX9MrdnC2YtHvaSmkB04WuNP/RLRiR8WhV6
         gx1SZMjIJQivFEHVYt9YEH65eJ0nwMf/dLhtsVmAcxSpqTMqvSd2LCwkjkWq7ppa/bsW
         4/6ImzaQoEeqlNr2R86vzzfrJZycuZxOg3kf2/HnqWXCrJ53vr+rEpF3MTpWbPwogiup
         ghgOc5nD1e+1GYTBJWArxLXNdCTwQLysZBEDPTtCeME2742Ln8KJkhW8sZVK4g+Qw8mi
         fjUg==
X-Forwarded-Encrypted: i=1; AJvYcCVQAPLauNpzjOl0LWob1c7368RtGy7YZgks+dOhffdcbD2L+EHmbFWJvpNw2xH2/cF8IKi3vBaS2AbLIwo=@vger.kernel.org, AJvYcCVuK/YeExAPWGzSZCFi3uh5LyXa9ow/xJlrA8CBTa1jYnCxw+QR++fGBzG9PvA1s4ghPP0HkhmTlNzRksvG6bxE@vger.kernel.org, AJvYcCVwHrImk4qotmg7PIXkQaUMx4qyh1ULJnEPJ7Mixgs2UfVUATeZXkQDXk8YLYYfrnBqNXU8y+lpdR/4sw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1fAV3FwSB0uLhmYbVKuiikuykfZd9orNIKaTZ3pwXVUdfoiGa
	URNrNSDDC+0TNfPGG53oCSjxo599CwFEnj5U5fKt6y/H4ApD2US516r3MJLO
X-Gm-Gg: ASbGncsNgS0P1U8pwxFpNBuM5jazigdFeR2P7Rueo7nZaw2YwaDYjGH5Sbwz7KEjaRy
	xSU6EA2eNkmVgPpslKhL1BQwEsWxwD9e+aeT7o2/Q2xcQ6xZ3GoP0UJ+bRHd+A59TcAjRj2Dq9K
	FqARDUZZduN1WxCHngZ0ZmjTQnm7uG76Sz7Mg9Ha4ehZsWuSyWi5ZXK+8zTJs5ZnX7wrrshDYeq
	PxVKtXI2P53QuG3dM1WefzVoCSrJ/TN47lbFUZMijYAA1BV3Z0a0MOJNTsYO+wJFIfU/XncBcD6
	wTwanBeELANQojnNIvQwdNiF2OFPWCEEVTD21AFGIyATcEF+A713sDbxnuYpy2qFyKugWJvfogL
	d/Cp73Aa5KOywMoGp/Oi4Yq0=
X-Google-Smtp-Source: AGHT+IH5DqWr8tn3eyoLjnJaVFTvxrJy9DsLY+LkxxLU5h/ESvqg52ldyexR7aG8aD+QL/ZCJHTmfw==
X-Received: by 2002:a05:6a00:1989:b0:746:24c9:c92e with SMTP id d2e1a72fcca58-7489cfdaf27mr15181815b3a.8.1750090878424;
        Mon, 16 Jun 2025 09:21:18 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7488ffee55bsm6989549b3a.1.2025.06.16.09.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:21:17 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/6] udp_tunnel: remove rtnl_lock dependency
Date: Mon, 16 Jun 2025 09:21:11 -0700
Message-ID: <20250616162117.287806-1-stfomichev@gmail.com>
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

v5:
- remove unused variable (lkp@intel.com)

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
 drivers/net/vxlan/vxlan_core.c                | 35 +++-----
 drivers/net/vxlan/vxlan_private.h             |  2 +-
 drivers/net/vxlan/vxlan_vnifilter.c           | 18 ++--
 include/net/udp_tunnel.h                      | 87 ++++++++++++++-----
 net/core/dev.c                                |  4 +-
 net/ipv4/udp_tunnel_core.c                    | 16 ++--
 net/ipv4/udp_tunnel_nic.c                     | 78 +++++++++++++----
 .../drivers/net/netdevsim/udp_tunnel_nic.sh   | 23 +----
 22 files changed, 176 insertions(+), 172 deletions(-)

-- 
2.49.0


