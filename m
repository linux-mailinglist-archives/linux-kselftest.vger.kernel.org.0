Return-Path: <linux-kselftest+bounces-28418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B95A5529C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 18:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C0B1761A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF6E25C705;
	Thu,  6 Mar 2025 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYqLkaj7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB50E25C6EF;
	Thu,  6 Mar 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281125; cv=none; b=FnV0t58Ji2g+KPCuQ/ILT2ed0lFFi/CLiPWNiTgbWSEA7Rwg7WueNaLBo7uw2Y2Nl7HaHtMxzXG/rgsR+8l9nmaVn8MzVXov724U4d0lwmMhqlRNKbc8w7Y9t5YBg7IjJ9/Rwx60xoQ0mnLMPZpNODFoSBi8a4Evhp0p4tf29D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281125; c=relaxed/simple;
	bh=mZaaHmxzKtFTrqLSEyIuz4NQdokwcpZv8Vp1oFKHrxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfDKBiRTxCWQ7UoP3UgBdNYGaJa4VR4qN1/Sq8/sLO3COTDxaidTz3zzN0csBq5HDJMMaUuWuQsO/kfQKQU3muh1zyaE7i4hGu90ljjIkUKYwWaeNvoeKIYZLkHegwAeZvdca3DFU3c+RVjaQOvgHOceILMS7GakSFk/mA1wKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYqLkaj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BB4C4CEE8;
	Thu,  6 Mar 2025 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741281124;
	bh=mZaaHmxzKtFTrqLSEyIuz4NQdokwcpZv8Vp1oFKHrxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYqLkaj7X5/K72ORO2jA0DzfbmWpbCHO3vJosw9rtp7KW9UOCh/tv65nHO+8aCOz8
	 HUacEu6Key6+kg7EYu/s7ki4z93/DaMO9ivG8f7Jt67QrmqK3CFJULCNdquT+k5D1k
	 AKcjzFpgDIQuUl8n69konQyztxAsLD+k81oLAKKyz6LgFo0L7KGj7MsUpSjJMDU7g1
	 Z3Jy1gFxTSR5b288IOmOm2JMRg+4fMwJco9vCbVk0tJhfZl+hXJdFe0C4WDxw15IMk
	 zRBrJyccKUcg4mcbUYpkldb7gy61Y7z9fkxpUnILL28gxlAOZK9w5xaN6JljUcv65o
	 RzMRKUDwSIjCw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/2] selftests: net: use the dummy bpf from net/lib
Date: Thu,  6 Mar 2025 09:11:58 -0800
Message-ID: <20250306171158.1836674-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306171158.1836674-1-kuba@kernel.org>
References: <20250306171158.1836674-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 29b036be1b0b ("selftests: drv-net: test XDP, HDS auto and
the ioctl path") added an sample XDP_PASS prog in net/lib, so
that we can reuse it in various sub-directories. Delete the old
sample and use the one from the lib in existing tests.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - also remove the one in drivers/net/hw/
v1: https://lore.kernel.org/20250228212956.25399-2-kuba@kernel.org
---
 .../selftests/drivers/net/hw/xdp_dummy.bpf.c        | 13 -------------
 tools/testing/selftests/net/xdp_dummy.bpf.c         | 13 -------------
 tools/testing/selftests/drivers/net/hw/irq.py       |  2 +-
 tools/testing/selftests/net/udpgro_bench.sh         |  2 +-
 tools/testing/selftests/net/udpgro_frglist.sh       |  2 +-
 tools/testing/selftests/net/udpgro_fwd.sh           |  2 +-
 tools/testing/selftests/net/veth.sh                 |  2 +-
 7 files changed, 5 insertions(+), 31 deletions(-)
 delete mode 100644 tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c
 delete mode 100644 tools/testing/selftests/net/xdp_dummy.bpf.c

diff --git a/tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c b/tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c
deleted file mode 100644
index d988b2e0cee8..000000000000
--- a/tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#define KBUILD_MODNAME "xdp_dummy"
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-SEC("xdp")
-int xdp_dummy_prog(struct xdp_md *ctx)
-{
-	return XDP_PASS;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/net/xdp_dummy.bpf.c b/tools/testing/selftests/net/xdp_dummy.bpf.c
deleted file mode 100644
index d988b2e0cee8..000000000000
--- a/tools/testing/selftests/net/xdp_dummy.bpf.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#define KBUILD_MODNAME "xdp_dummy"
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-SEC("xdp")
-int xdp_dummy_prog(struct xdp_md *ctx)
-{
-	return XDP_PASS;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/drivers/net/hw/irq.py b/tools/testing/selftests/drivers/net/hw/irq.py
index 42ab98370245..e3c2201bb58b 100755
--- a/tools/testing/selftests/drivers/net/hw/irq.py
+++ b/tools/testing/selftests/drivers/net/hw/irq.py
@@ -69,7 +69,7 @@ from lib.py import cmd, ip, defer
 def check_reconfig_xdp(cfg) -> None:
     def reconfig(cfg) -> None:
         ip(f"link set dev %s xdp obj %s sec xdp" %
-            (cfg.ifname, cfg.rpath("xdp_dummy.bpf.o")))
+            (cfg.ifname, cfg.lpath("xdp_dummy.bpf.o")))
         ip(f"link set dev %s xdp off" % cfg.ifname)
 
     _check_reconfig(cfg, reconfig)
diff --git a/tools/testing/selftests/net/udpgro_bench.sh b/tools/testing/selftests/net/udpgro_bench.sh
index c51ea90a1395..815fad8c53a8 100755
--- a/tools/testing/selftests/net/udpgro_bench.sh
+++ b/tools/testing/selftests/net/udpgro_bench.sh
@@ -7,7 +7,7 @@ source net_helper.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
-BPF_FILE="xdp_dummy.bpf.o"
+BPF_FILE="lib/xdp_dummy.bpf.o"
 
 cleanup() {
 	local -r jobs="$(jobs -p)"
diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index 17404f49cdb6..5f3d1a110d11 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -7,7 +7,7 @@ source net_helper.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
-BPF_FILE="xdp_dummy.bpf.o"
+BPF_FILE="lib/xdp_dummy.bpf.o"
 
 cleanup() {
 	local -r jobs="$(jobs -p)"
diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index 550d8eb3e224..f22f6c66997e 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -3,7 +3,7 @@
 
 source net_helper.sh
 
-BPF_FILE="xdp_dummy.bpf.o"
+BPF_FILE="lib/xdp_dummy.bpf.o"
 readonly BASE="ns-$(mktemp -u XXXXXX)"
 readonly SRC=2
 readonly DST=1
diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 6bb7dfaa30b6..9709dd067c72 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-BPF_FILE="xdp_dummy.bpf.o"
+BPF_FILE="lib/xdp_dummy.bpf.o"
 readonly STATS="$(mktemp -p /tmp ns-XXXXXX)"
 readonly BASE=`basename $STATS`
 readonly SRC=2
-- 
2.48.1


