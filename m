Return-Path: <linux-kselftest+bounces-2954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D377A82D23D
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jan 2024 23:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D38728175A
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jan 2024 22:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D642C1B5;
	Sun, 14 Jan 2024 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7QEr0gE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10B72C1B0;
	Sun, 14 Jan 2024 22:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36B6C433F1;
	Sun, 14 Jan 2024 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705272449;
	bh=gi+LYVmplxeXPZ4evmqykWvbTTqx6pxC0m8XJiqeW7o=;
	h=From:To:Cc:Subject:Date:From;
	b=C7QEr0gEm8Enkui+/RM3UrJO479ODPLOmVBCwoeCECVToOf7Ur5oLVWyEP1U04cuA
	 GRCL+8FSFDMw8qIjftgwyHPyz6Y/DVaWn8ZyRSywlOc1ZRYff+OcXhwFtFIZ5tjKzP
	 DwA9bDVGEItpxkzXOL6frvhJ3tMtfxipGaVhiCn4PmKkJzp7zO+aaH+AGzyn3oQ/kS
	 LVuxhhzlVWGShg7ZJGLm8zWxf85TkfEbCFpomrhkdxBzUzX+MlRpOZVFg07WYFshNT
	 2CosVT+i9uf5ECDSu4+cqE/hxoMhdYtz0VkK2GQTqCBajbKfacLFyMVyjeZ3H6tlv8
	 dmEFSlZUaHdJg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	saeedm@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: netdevsim: sprinkle more udevadm settle
Date: Sun, 14 Jan 2024 14:47:26 -0800
Message-ID: <20240114224726.1210532-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Number of tests are failing when netdev renaming is active
on the system. Add udevadm settle in logic determining
the names.

Fixes: 242aaf03dc9b ("selftests: add a test for ethtool pause stats")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: saeedm@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh | 1 +
 tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh
index 922744059aaa..80160579e0cc 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh
@@ -51,6 +51,7 @@ function make_netdev {
     fi
 
     echo $NSIM_ID $@ > /sys/bus/netdevsim/new_device
+    udevadm settle
     # get new device name
     ls /sys/bus/netdevsim/devices/netdevsim${NSIM_ID}/net/
 }
diff --git a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
index 1b08e042cf94..4855ef597a15 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
@@ -233,6 +233,7 @@ function print_tables {
 function get_netdev_name {
     local -n old=$1
 
+    udevadm settle
     new=$(ls /sys/class/net)
 
     for netdev in $new; do
-- 
2.43.0


