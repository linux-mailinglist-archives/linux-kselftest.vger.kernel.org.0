Return-Path: <linux-kselftest+bounces-34613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3034AD402C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 19:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59517188EF54
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96292405EC;
	Tue, 10 Jun 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxuQW/W2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAAB2B9BF;
	Tue, 10 Jun 2025 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575726; cv=none; b=OtJ6LOBPD+e81UpTMCaoYkHOizOao7V9A6hhuklF0JERi43OVKr7KF/wE18ZS+bXy3mehDp+1iTJrJUuFeJACHmsWLCQ7WN4vSCUBSeZ9Bt/BFMFnYJQkOA3wS+aOex3BqwRR2a73PmpiJIuxmWLoGMhWFZsDfyru83iYrbryQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575726; c=relaxed/simple;
	bh=UN0Hiqo7RA5+6NVe3K2fpW9RJZ2Ll/nJGDYiqbb4iH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LUpLAU89bu67yiV1glDU30y1J8oNYsxuyMduDu7JvdSnx27PoRXU3iFoDTu0KXhRJluhSA1FH6JWky9/5++a/K+B5noBeK6QgfcCVqwR6P6qd22pOzi/kmGHnUr4/uX3BFYrbwMIj9noFvP+ID2Y+Ja/7IhoFleKuxtXnd/ijsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxuQW/W2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235e1d710d8so70484195ad.1;
        Tue, 10 Jun 2025 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749575724; x=1750180524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XpoQDBnkJ85m3RkfJrVclHVsiYiR+siVaD2J76Ul8c=;
        b=JxuQW/W20jrJfiMMDQUW1bzQLREPQPHpu/qvSzj0/cTKEZsYhTpryfyiei5lEc5dtq
         L6lJwwuhel4ecV5R7fTHrS2btrr/fHWEfq8sWzfQ2+gpuJcaRvuItJqNrISXnb4ojTXk
         BmxCKKkMHSpeKTo5vuXZpv5lPBIWDEKdmySJt+/VyqEpE0zWax6vhxxqSu+yDtaa/j8h
         NCvBoUSXM+G3hZxmrwFpaHZOyfJ0WElMUJocFzuEQGaTE3XU3ZlyY/92es8gGFInbP3E
         5EvNZWKRoqB6BUa49rFKB1yeeyGgLN1GUhgztCUMXcK2t4lVRtWUsPNVhtzWQvk2wKfC
         xx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749575724; x=1750180524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XpoQDBnkJ85m3RkfJrVclHVsiYiR+siVaD2J76Ul8c=;
        b=SbuSqk1SQBtEtzfRWwDZXGT41kDMg7ygN7+3hyJJ33xMc4VQra211tlxXPyjgMsFFc
         IAp4YeoB1Ha00JeyOLKJn+/Yw1bjAOTGJUHsl/wYhdk72BPMjrfA8GAQ8CPdco0ng97W
         jtcS1vsZUZMH9NylFZBDd+t6itGCT0qyOpFptGKkafFfc17n0ch28/OPWeap1KZOEYPL
         DgUXiPljPLOw9EB/eRfjwD4boS8XVIPXPGpCRWHw+YZ0nYPdopL8sIPhCGKaWi8NWdnx
         /swCRL05nLvg16ebh3KojbQCr46i51ApYvHH3NsYXdDn2fdZweoydFQtcED06RD8yaa3
         oJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUre7WO+fdIfJKp/X5hHJJDAZr0VREMwDteoFa/BBMBzvHRO7DVmsxf1pQIHGSB/IpTXCtPMcjTJBC+qhvwxeS@vger.kernel.org, AJvYcCX/Lb1AvW4nd6himoJz+8AlfCrfq0MnHm2CG2gghMiq2Vw+Ivquwm8K6HDqPtJ4FDqYJKkFi+bUfz54rf0=@vger.kernel.org, AJvYcCXSFVDO9AXaA7HZ2MSyg0IjSVv2haFIWX08C8oVZvk+WkzoWfEY0EavbNTVfJ7V/R5WUXyAuDslalu90Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaPU6qio6mavt3WXQrvUcimk42curokFL0jVnXS7p5gDETxZn+
	PggGJ8oscpO3U/iimzpa9/rtrgvi+TTK9xjjRNGU4fXMEyKUccrdjCJluFUQ
X-Gm-Gg: ASbGnctDbosAgRj48YHYV8trAXsUszQ2701xJVeNbsFfxUrjNTHHUHfhJN69XJr1EK+
	uS6H8+1dZYsFb4qVSny0t5n1F4MP27dyXDWsjIhqXoh0kThfX6YcoN/iMZ4lZzFy2FnKrZHRPru
	ROjNRxvKqKzbvA0oPz44vXkWtnuUwr+VdbSh0f56lyeTecv6Ph3lYICuHHArLfQZCE7Pl55wFCP
	QH4bhFoY1whjboTndka20thBkRggFRYd+grsR8liike1wxG1RYlq+mQeoUKu9YdF/67eUZv7m5o
	Vqt4dnLMNIpqb/6fotzSckjdT6JfZtG59rvz+dJzNekUJq0Ni5OUTtbg+RPqciobJ77X98ddDOr
	G2xW8H2MfusbjiFUSMwZwmfo=
X-Google-Smtp-Source: AGHT+IEE1VyaEjF+SToiH2KCZZ8fObccPrLHHXbkTDAAnPtCNTBgNOACDl44GLw6Tjp2I7FIdab+6w==
X-Received: by 2002:a17:902:e5c6:b0:235:caa8:1a72 with SMTP id d9443c01a7336-23641b19943mr1127805ad.30.1749575724034;
        Tue, 10 Jun 2025 10:15:24 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23603504ed2sm73695875ad.219.2025.06.10.10.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:15:23 -0700 (PDT)
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
	leon@kernel.org
Subject: [PATCH net-next v3 0/4] udp_tunnel: remove rtnl_lock dependency
Date: Tue, 10 Jun 2025 10:15:18 -0700
Message-ID: <20250610171522.2119030-1-stfomichev@gmail.com>
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

v3:
- fix 2 test failures (Jakub NIPA)

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
 .../drivers/net/netdevsim/udp_tunnel_nic.sh   | 23 +---------
 17 files changed, 32 insertions(+), 109 deletions(-)

-- 
2.49.0


