Return-Path: <linux-kselftest+bounces-28015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 753DEA4B92D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 09:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A825D16FC61
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 08:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC581F152C;
	Mon,  3 Mar 2025 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ktplhEhk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF61F1300;
	Mon,  3 Mar 2025 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990188; cv=none; b=lXbOmUc4e/v0jOwmF+5Xsq34JY6EBqlCm4IA0+/pnDmcRAvkbNwz3WN+hck5zLSo6IGxiX68MSf0VxyXsrNqyxgj9rIHKs/K+ZqewESP7u6AZuxY/sQlr5KOOtuW8nMDUcLHZOdjhJRcrgNMk1cWwmP5jN74P27CpYznQ23wvIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990188; c=relaxed/simple;
	bh=PNQT/TdzEKeBs4ga6wj60LtMRdFDUhLf93JENvY4hkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n+fybA6Q+/3v+5RgW7IuoNy7YCTX4zG74RAsSqo55QaBNeKgOX5si2IABOFgIOZ04RddMWxGlo6MxsFRHxlwHGFyLFsIa3sQNR1a16UOP+2cXzDufS+rHmgYzW9OBqOaymZQeZ6UaDVEIffF5ygmqdC6RunDmzRl0xKm4sCJagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ktplhEhk; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A5BE44366;
	Mon,  3 Mar 2025 08:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740990184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8EwIp1y1ozH01xKDabxlXrmhQNZTkeQ+aEodnaMfQso=;
	b=ktplhEhkHGIGfZr45Nvx+hnh/+cA5tZpbR+Z/I6lKr0S2BhzkzFY4uKoKfacZtl1ylLbnv
	FZDPrTJbMAJ+DIwakyr1bdDNqm6d/Gvktsvg00FSVpdNqZhfZDc/BhXSO8Df599fzEGcXi
	ADQXtVTvIIIVRn75xxfwmvqGjwnUqFc4sJwJRRq2npfdpsh03cwaFcE/DdG5VKGNbVInXn
	5vedWqUQ4KDtbbx/+6Y9aLdjHYoZrXdik4mqEUMALjR2Qwe71ssVFeKvFLBXKj9ynOF3fk
	ta5I33vA6//5AjHCTNM8zGf2WcV4God32sRUfu9Uhm2o3CI/qCc0dxIc/ZOu2A==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Mon, 03 Mar 2025 09:22:58 +0100
Subject: [PATCH bpf-next v2 10/10] selftests/bpf: test_tunnel: Remove
 test_tunnel.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-tunnels-v2-10-8329f38f0678@bootlin.com>
References: <20250303-tunnels-v2-0-8329f38f0678@bootlin.com>
In-Reply-To: <20250303-tunnels-v2-0-8329f38f0678@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguugihiiekjeesghhmr
 ghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

All tests from test_tunnel.sh have been migrated into test test_progs.
The last test remaining in the script is the test_ipip() that is already
covered in the test_prog framework by the NONE case of test_ipip_tunnel().

Remove the test_tunnel.sh script and its Makefile entry

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile       |   1 -
 tools/testing/selftests/bpf/test_tunnel.sh | 179 -----------------------------
 2 files changed, 180 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index abfb450c26bb360ad23ff1201fb113557d3eced1..e6a02d5b87d123cef7e6b41bfbc96d34083f38e1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -100,7 +100,6 @@ TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
-	test_tunnel.sh \
 	test_lwt_seg6local.sh \
 	test_lirc_mode2.sh \
 	test_xdp_vlan_mode_generic.sh \
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
deleted file mode 100755
index 165023d1b5f70fd48ff05f0a53a332ef50e175da..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ /dev/null
@@ -1,179 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-# End-to-end eBPF tunnel test suite
-#   The script tests BPF network tunnel implementation.
-#
-# Topology:
-# ---------
-#     root namespace   |     at_ns0 namespace
-#                      |
-#      -----------     |     -----------
-#      | tnl dev |     |     | tnl dev |  (overlay network)
-#      -----------     |     -----------
-#      metadata-mode   |     native-mode
-#       with bpf       |
-#                      |
-#      ----------      |     ----------
-#      |  veth1  | --------- |  veth0  |  (underlay network)
-#      ----------    peer    ----------
-#
-#
-# Device Configuration
-# --------------------
-# Root namespace with metadata-mode tunnel + BPF
-# Device names and addresses:
-# 	veth1 IP: 172.16.1.200, IPv6: 00::22 (underlay)
-# 	tunnel dev <type>11, ex: gre11, IPv4: 10.1.1.200, IPv6: 1::22 (overlay)
-#
-# Namespace at_ns0 with native tunnel
-# Device names and addresses:
-# 	veth0 IPv4: 172.16.1.100, IPv6: 00::11 (underlay)
-# 	tunnel dev <type>00, ex: gre00, IPv4: 10.1.1.100, IPv6: 1::11 (overlay)
-#
-#
-# End-to-end ping packet flow
-# ---------------------------
-# Most of the tests start by namespace creation, device configuration,
-# then ping the underlay and overlay network.  When doing 'ping 10.1.1.100'
-# from root namespace, the following operations happen:
-# 1) Route lookup shows 10.1.1.100/24 belongs to tnl dev, fwd to tnl dev.
-# 2) Tnl device's egress BPF program is triggered and set the tunnel metadata,
-#    with remote_ip=172.16.1.100 and others.
-# 3) Outer tunnel header is prepended and route the packet to veth1's egress
-# 4) veth0's ingress queue receive the tunneled packet at namespace at_ns0
-# 5) Tunnel protocol handler, ex: vxlan_rcv, decap the packet
-# 6) Forward the packet to the overlay tnl dev
-
-BPF_FILE="test_tunnel_kern.bpf.o"
-BPF_PIN_TUNNEL_DIR="/sys/fs/bpf/tc/tunnel"
-PING_ARG="-c 3 -w 10 -q"
-ret=0
-GREEN='\033[0;92m'
-RED='\033[0;31m'
-NC='\033[0m' # No Color
-
-config_device()
-{
-	ip netns add at_ns0
-	ip link add veth0 type veth peer name veth1
-	ip link set veth0 netns at_ns0
-	ip netns exec at_ns0 ip addr add 172.16.1.100/24 dev veth0
-	ip netns exec at_ns0 ip link set dev veth0 up
-	ip link set dev veth1 up mtu 1500
-	ip addr add dev veth1 172.16.1.200/24
-}
-
-add_ipip_tunnel()
-{
-	# at_ns0 namespace
-	ip netns exec at_ns0 \
-		ip link add dev $DEV_NS type $TYPE \
-		local 172.16.1.100 remote 172.16.1.200
-	ip netns exec at_ns0 ip link set dev $DEV_NS up
-	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
-
-	# root namespace
-	ip link add dev $DEV type $TYPE external
-	ip link set dev $DEV up
-	ip addr add dev $DEV 10.1.1.200/24
-}
-
-test_ipip()
-{
-	TYPE=ipip
-	DEV_NS=ipip00
-	DEV=ipip11
-	ret=0
-
-	check $TYPE
-	config_device
-	add_ipip_tunnel
-	ip link set dev veth1 mtu 1500
-	attach_bpf $DEV ipip_set_tunnel ipip_get_tunnel
-	ping $PING_ARG 10.1.1.100
-	check_err $?
-	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
-	check_err $?
-	cleanup
-
-	if [ $ret -ne 0 ]; then
-                echo -e ${RED}"FAIL: $TYPE"${NC}
-                return 1
-        fi
-        echo -e ${GREEN}"PASS: $TYPE"${NC}
-}
-
-attach_bpf()
-{
-	DEV=$1
-	SET=$2
-	GET=$3
-	mkdir -p ${BPF_PIN_TUNNEL_DIR}
-	bpftool prog loadall ${BPF_FILE} ${BPF_PIN_TUNNEL_DIR}/
-	tc qdisc add dev $DEV clsact
-	tc filter add dev $DEV egress bpf da object-pinned ${BPF_PIN_TUNNEL_DIR}/$SET
-	tc filter add dev $DEV ingress bpf da object-pinned ${BPF_PIN_TUNNEL_DIR}/$GET
-}
-
-cleanup()
-{
-        rm -rf ${BPF_PIN_TUNNEL_DIR}
-
-	ip netns delete at_ns0 2> /dev/null
-	ip link del veth1 2> /dev/null
-	ip link del ipip11 2> /dev/null
-}
-
-cleanup_exit()
-{
-	echo "CATCH SIGKILL or SIGINT, cleanup and exit"
-	cleanup
-	exit 0
-}
-
-check()
-{
-	ip link help 2>&1 | grep -q "\s$1\s"
-	if [ $? -ne 0 ];then
-		echo "SKIP $1: iproute2 not support"
-	cleanup
-	return 1
-	fi
-}
-
-enable_debug()
-{
-	echo 'file ipip.c +p' > /sys/kernel/debug/dynamic_debug/control
-}
-
-check_err()
-{
-	if [ $ret -eq 0 ]; then
-		ret=$1
-	fi
-}
-
-bpf_tunnel_test()
-{
-	local errors=0
-
-	echo "Testing IPIP tunnel..."
-	test_ipip
-	errors=$(( $errors + $? ))
-
-	return $errors
-}
-
-trap cleanup 0 3 6
-trap cleanup_exit 2 9
-
-cleanup
-bpf_tunnel_test
-
-if [ $? -ne 0 ]; then
-	echo -e "$(basename $0): ${RED}FAIL${NC}"
-	exit 1
-fi
-echo -e "$(basename $0): ${GREEN}PASS${NC}"
-exit 0

-- 
2.48.1


