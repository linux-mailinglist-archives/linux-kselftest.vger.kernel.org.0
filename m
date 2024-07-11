Return-Path: <linux-kselftest+bounces-13556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A61DF92E1A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 10:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259F61F21E28
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C03157A59;
	Thu, 11 Jul 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QIJLiP4R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B915535A;
	Thu, 11 Jul 2024 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685428; cv=none; b=Fx3+FXjKgc22cROccJLVPN+MtAsQ9H9dvr9nnYyzixFo8xbfn9A0Zm19CUnX9AaIdHAaTqowT8PvTrUuWqL7saSxqS6/9+eN9h4D4L56XR4DjvTrIovPViX686HXJGo2dzmO5/QjQFzs5R7eR7+UpzKkAZl5nV6t7TVkgCDwjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685428; c=relaxed/simple;
	bh=9RrJWWmP2IrswlBZALTGcJrG+6Rxv3BOqNslc7GLW4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p5tFr8hWNh0YnJKqE1mZ1uI8b9JGVen4zNzNleTMlqky0XCoVm7s1bvcufi05kh/3c5sKX4mqOn71UUjKFWTSBh4E6iBH3LZZh/T1GvT0OKn/gIHijqrkOa66zM0gOHDegJJ5HWnp29IANXGU3m8L7zcGX/q3az40Fr5SFYmLwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QIJLiP4R; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1C470E0011;
	Thu, 11 Jul 2024 08:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720685417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7uTBIIQVTbxWNe2nlqR9HLW+SjTbNPx/80zo9ML1758=;
	b=QIJLiP4RaDAtm68SOlTnimTWrJIGaYKQyarn2UklU1EhNrqAOoyfJ5k/SkFiovKok9hvNo
	fqFkqyOUSHliZwQyAEnTOB3DDRrRnX5j0g0yzUpWV1tV+GeMzW3hb0RXTc1Ii3SB9t/kCG
	So5ypt/ecwLBG0xBMVxanXC9q4V2O9ibg75znVJeWB6evcnPyMRTVtJyKyWuzIeHw9uMdx
	McytlX0GWKN21elg2lAojQ33UZbCf1TUYg99Em0RVp2TL/GgkfOqLaI8q85Fm9xUsqggo5
	U+cQfOC8a6q4Y8nOEZ3ZudKPHgIZJEpbHCNtU6p3w5ylwKJDhMovR5aCTUhU/w==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 11 Jul 2024 10:09:36 +0200
Subject: [PATCH 3/3] bpf/selftests: drop old version of test_xdp_veth.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240711-convert_test_xdp_veth-v1-3-868accb0a727@bootlin.com>
References: <20240711-convert_test_xdp_veth-v1-0-868accb0a727@bootlin.com>
In-Reply-To: <20240711-convert_test_xdp_veth-v1-0-868accb0a727@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

Now that test_xdp_veth has been rewritten to fit in the test_progs runner,
drop the shell script version

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile         |   1 -
 tools/testing/selftests/bpf/test_xdp_veth.sh | 121 ---------------------------
 2 files changed, 122 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a7932bead77d..2864a0dc04d5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -117,7 +117,6 @@ TEST_PROGS := test_kmod.sh \
 	test_xdp_redirect.sh \
 	test_xdp_redirect_multi.sh \
 	test_xdp_meta.sh \
-	test_xdp_veth.sh \
 	test_tunnel.sh \
 	test_lwt_seg6local.sh \
 	test_lirc_mode2.sh \
diff --git a/tools/testing/selftests/bpf/test_xdp_veth.sh b/tools/testing/selftests/bpf/test_xdp_veth.sh
deleted file mode 100755
index 5211ca9a0239..000000000000
--- a/tools/testing/selftests/bpf/test_xdp_veth.sh
+++ /dev/null
@@ -1,121 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Create 3 namespaces with 3 veth peers, and
-# forward packets in-between using native XDP
-#
-#                      XDP_TX
-# NS1(veth11)        NS2(veth22)        NS3(veth33)
-#      |                  |                  |
-#      |                  |                  |
-#   (veth1,            (veth2,            (veth3,
-#   id:111)            id:122)            id:133)
-#     ^ |                ^ |                ^ |
-#     | |  XDP_REDIRECT  | |  XDP_REDIRECT  | |
-#     | ------------------ ------------------ |
-#     -----------------------------------------
-#                    XDP_REDIRECT
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-TESTNAME=xdp_veth
-BPF_FS=$(awk '$3 == "bpf" {print $2; exit}' /proc/mounts)
-BPF_DIR=$BPF_FS/test_$TESTNAME
-readonly NS1="ns1-$(mktemp -u XXXXXX)"
-readonly NS2="ns2-$(mktemp -u XXXXXX)"
-readonly NS3="ns3-$(mktemp -u XXXXXX)"
-
-_cleanup()
-{
-	set +e
-	ip link del veth1 2> /dev/null
-	ip link del veth2 2> /dev/null
-	ip link del veth3 2> /dev/null
-	ip netns del ${NS1} 2> /dev/null
-	ip netns del ${NS2} 2> /dev/null
-	ip netns del ${NS3} 2> /dev/null
-	rm -rf $BPF_DIR 2> /dev/null
-}
-
-cleanup_skip()
-{
-	echo "selftests: $TESTNAME [SKIP]"
-	_cleanup
-
-	exit $ksft_skip
-}
-
-cleanup()
-{
-	if [ "$?" = 0 ]; then
-		echo "selftests: $TESTNAME [PASS]"
-	else
-		echo "selftests: $TESTNAME [FAILED]"
-	fi
-	_cleanup
-}
-
-if [ $(id -u) -ne 0 ]; then
-	echo "selftests: $TESTNAME [SKIP] Need root privileges"
-	exit $ksft_skip
-fi
-
-if ! ip link set dev lo xdp off > /dev/null 2>&1; then
-	echo "selftests: $TESTNAME [SKIP] Could not run test without the ip xdp support"
-	exit $ksft_skip
-fi
-
-if [ -z "$BPF_FS" ]; then
-	echo "selftests: $TESTNAME [SKIP] Could not run test without bpffs mounted"
-	exit $ksft_skip
-fi
-
-if ! bpftool version > /dev/null 2>&1; then
-	echo "selftests: $TESTNAME [SKIP] Could not run test without bpftool"
-	exit $ksft_skip
-fi
-
-set -e
-
-trap cleanup_skip EXIT
-
-ip netns add ${NS1}
-ip netns add ${NS2}
-ip netns add ${NS3}
-
-ip link add veth1 index 111 type veth peer name veth11 netns ${NS1}
-ip link add veth2 index 122 type veth peer name veth22 netns ${NS2}
-ip link add veth3 index 133 type veth peer name veth33 netns ${NS3}
-
-ip link set veth1 up
-ip link set veth2 up
-ip link set veth3 up
-
-ip -n ${NS1} addr add 10.1.1.11/24 dev veth11
-ip -n ${NS3} addr add 10.1.1.33/24 dev veth33
-
-ip -n ${NS1} link set dev veth11 up
-ip -n ${NS2} link set dev veth22 up
-ip -n ${NS3} link set dev veth33 up
-
-mkdir $BPF_DIR
-bpftool prog loadall \
-	xdp_redirect_map.bpf.o $BPF_DIR/progs type xdp \
-	pinmaps $BPF_DIR/maps
-bpftool map update pinned $BPF_DIR/maps/tx_port key 0 0 0 0 value 122 0 0 0
-bpftool map update pinned $BPF_DIR/maps/tx_port key 1 0 0 0 value 133 0 0 0
-bpftool map update pinned $BPF_DIR/maps/tx_port key 2 0 0 0 value 111 0 0 0
-ip link set dev veth1 xdp pinned $BPF_DIR/progs/xdp_redirect_map_0
-ip link set dev veth2 xdp pinned $BPF_DIR/progs/xdp_redirect_map_1
-ip link set dev veth3 xdp pinned $BPF_DIR/progs/xdp_redirect_map_2
-
-ip -n ${NS1} link set dev veth11 xdp obj xdp_dummy.bpf.o sec xdp
-ip -n ${NS2} link set dev veth22 xdp obj xdp_tx.bpf.o sec xdp
-ip -n ${NS3} link set dev veth33 xdp obj xdp_dummy.bpf.o sec xdp
-
-trap cleanup EXIT
-
-ip netns exec ${NS1} ping -c 1 -W 1 10.1.1.33
-
-exit 0

-- 
2.45.2


