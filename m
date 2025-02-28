Return-Path: <linux-kselftest+bounces-27947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232E8A4A50F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 22:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246CE172A7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5CE1D90A9;
	Fri, 28 Feb 2025 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fomKJQVR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0E91D88AC;
	Fri, 28 Feb 2025 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778198; cv=none; b=KYL103KUajO8NAalJPjiWe2gLXn3b1FLP73430bod6LCLGrF1dF4AOiLB36x9YF/uqWJMl0W3R7V/46fO+zoQNyv/WFmwn4JdWytvj7O890UKi3W072Oe6nco2TdiqnSuzPMzMkkQAYBJwtQtgjf1ruBHdn6ooTF87GqqcNXltE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778198; c=relaxed/simple;
	bh=i+yZq5ChfJhwnmcYfNQxS0k8esgJ9UtledrEVvce07w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jA6NSSUYZdLyIJpMimOxFtX+6rk0JogXr0YqfXjE0wIcZqQ8IkTmIEF5aac4BAAf2IBM2SRhXsdyaPPWA39JtQzfgViSalpp5qQhAIyodhLRGY8sL5fRFES1jGHmg7cXL5nQMWEmzoLuy5szhac49vfczZBdbVlv68hWVz2sGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fomKJQVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26447C4CEE9;
	Fri, 28 Feb 2025 21:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740778198;
	bh=i+yZq5ChfJhwnmcYfNQxS0k8esgJ9UtledrEVvce07w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fomKJQVRh8xpKDeE43TqX5Sxi+95UjLm9Cze5Acn64w/VUZnxwmlZl7O8hACbACSc
	 RvyzcO+pVSt76SrA1GXSZgI7sNB/MFRtJ2fqzxKlZ1XeheLz0+7gW1qc8JlHrGhzbs
	 LCee/HcxTF7NM1eixlaE5ZlbDR4BGyKdg1ljpCw5UHO/7v8hYWV3veG924S+Yh04CW
	 btJOevpuR59bJgDHBbUX5G/7jL7iFrwmpQjd3gHKzHZNmckc2PXm2rbIfPEqsFhMEa
	 ElOT4j3XyQ66cEcVAhLh2vryEXRs70cHkvNasetn9zNVam9Xi+WI2Ks1S+YbPSRqzY
	 Tdf9aUYOJazPw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] selftests: net: use the dummy bpf from net/lib
Date: Fri, 28 Feb 2025 13:29:56 -0800
Message-ID: <20250228212956.25399-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228212956.25399-1-kuba@kernel.org>
References: <20250228212956.25399-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/xdp_dummy.bpf.c   | 13 -------------
 tools/testing/selftests/net/udpgro_bench.sh   |  2 +-
 tools/testing/selftests/net/udpgro_frglist.sh |  2 +-
 tools/testing/selftests/net/udpgro_fwd.sh     |  2 +-
 tools/testing/selftests/net/veth.sh           |  2 +-
 5 files changed, 4 insertions(+), 17 deletions(-)
 delete mode 100644 tools/testing/selftests/net/xdp_dummy.bpf.c

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


