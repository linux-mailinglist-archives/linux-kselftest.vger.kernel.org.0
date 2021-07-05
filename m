Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB403BB615
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jul 2021 06:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhGEEMP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jul 2021 00:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhGEEMO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jul 2021 00:12:14 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8508C061765
        for <linux-kselftest@vger.kernel.org>; Sun,  4 Jul 2021 21:09:37 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6D539891B1;
        Mon,  5 Jul 2021 16:09:36 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1625458176;
        bh=HxE3k3Q7rK1M8FKN7n8VhONE/OSStYYa06MgZVq1ndc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=X4E19cObisqgIVK5pSSzTMqHUgkXctEQW1E1OWyLgsrtKdpIuOrK4BRuC4Z9eG+oF
         96M4KljwDLW8lFa+dnqI9AgdMf6PxTn7lclKMLf5NX24LvLDZWoWMJcebMKJVHFVxt
         VptsR6YzWn00ygjzE0nhXLPgNpqEwser91K8yjTMbJrAH8red3t8mE4fS4xIt59nyE
         vgkMgPi6cZzsBczPoFpb37UvZPNMbgM9CBVVyMMJQudtPZb1a46ggE2LcKxiwzv+fo
         aznnXHX16TV/7npzJmwbKejRSBij5B2vziTG3t/3psrIe1RPNqh/gjLlsjiq8IJLmm
         CXfMWHV5kV/QQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B60e286000000>; Mon, 05 Jul 2021 16:09:36 +1200
Received: from coled-dl.ws.atlnz.lc (coled-dl.ws.atlnz.lc [10.33.25.26])
        by pat.atlnz.lc (Postfix) with ESMTP id 475A813EE8E;
        Mon,  5 Jul 2021 16:09:36 +1200 (NZST)
Received: by coled-dl.ws.atlnz.lc (Postfix, from userid 1801)
        id 442DF240C05; Mon,  5 Jul 2021 16:09:36 +1200 (NZST)
From:   Cole Dishington <Cole.Dishington@alliedtelesis.co.nz>
To:     pablo@netfilter.org
Cc:     Cole Dishington <Cole.Dishington@alliedtelesis.co.nz>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: netfilter: Add RFC-7597 Section 5.1 PSID selftests
Date:   Mon,  5 Jul 2021 16:08:56 +1200
Message-Id: <20210705040856.25191-4-Cole.Dishington@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705040856.25191-1-Cole.Dishington@alliedtelesis.co.nz>
References: <20210630142049.GC18022@breakpoint.cc>
 <20210705040856.25191-1-Cole.Dishington@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=IOh89TnG c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=e_q4qTt1xDgA:10 a=sF_rvDO487Xu6NHlfHgA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add selftests for masquerading into a smaller subset of ports defined by
PSID.

Signed-off-by: Cole Dishington <Cole.Dishington@alliedtelesis.co.nz>
---
 .../netfilter/nat_masquerade_psid.sh          | 158 ++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 tools/testing/selftests/netfilter/nat_masquerade_psid=
.sh

diff --git a/tools/testing/selftests/netfilter/nat_masquerade_psid.sh b/t=
ools/testing/selftests/netfilter/nat_masquerade_psid.sh
new file mode 100644
index 000000000000..90e2e5ca4d68
--- /dev/null
+++ b/tools/testing/selftests/netfilter/nat_masquerade_psid.sh
@@ -0,0 +1,158 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# <:copyright-gpl
+# Copyright (C) 2021 Allied Telesis Labs NZ
+#
+# check that NAT can masquerade using PSID defined ranges.
+#
+# Setup is:
+#
+# nsclient1(veth0) -> (veth1)nsrouter(veth2) -> (veth0)nsclient2
+# Setup a nat masquerade rule with psid defined ranges.
+#
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=3D4
+ret=3D0
+ns_all=3D"nsclient1 nsrouter nsclient2"
+
+readonly infile=3D"$(mktemp)"
+readonly outfile=3D"$(mktemp)"
+readonly datalen=3D32
+readonly server_port=3D8080
+
+conntrack -V > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run test without conntrack tool"
+	exit $ksft_skip
+fi
+
+iptables --version > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run test without iptables tool"
+	exit $ksft_skip
+fi
+
+ip -Version > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run test without ip tool"
+	exit $ksft_skip
+fi
+
+ipv4() {
+	echo -n 192.168.$1.$2
+}
+
+cleanup() {
+	for n in $ns_all; do ip netns del $n;done
+
+	if [ -f "${outfile}" ]; then
+		rm "$outfile"
+	fi
+	if [ -f "${infile}" ]; then
+		rm "$infile"
+	fi
+}
+
+server_listen() {
+	ip netns exec nsclient2 nc -l -p "$server_port" > "$outfile" &
+	server_pid=3D$!
+	sleep 0.2
+}
+
+client_connect() {
+	ip netns exec nsclient1 timeout 2 nc -w 1 -p "$port" $(ipv4 2 2) "$serv=
er_port" < $infile
+}
+
+verify_data() {
+	local _ret=3D0
+	wait "$server_pid"
+	cmp "$infile" "$outfile" 2>/dev/null
+	_ret=3D$?
+	rm "$outfile"
+	return $_ret
+}
+
+test_service() {
+	server_listen
+	client_connect
+	verify_data
+}
+
+check_connection() {
+	entry=3D$(ip netns exec nsrouter conntrack -p tcp --sport $port -L 2>&1=
)
+	entry=3D${entry##*sport=3D8080 dport=3D}
+	entry=3D${entry%% *}
+	[[ "x$(( ($entry & $psid_mask) / $two_power_j ))" =3D "x$psid" ]]
+}
+
+run_test() {
+	ip netns exec nsrouter iptables -A FORWARD -i veth1 -j ACCEPT
+	ip netns exec nsrouter iptables -P FORWARD DROP
+	ip netns exec nsrouter iptables -A FORWARD -m state --state ESTABLISHED=
,RELATED -j ACCEPT
+	ip netns exec nsrouter iptables -t nat --new psid
+	ip netns exec nsrouter iptables -t nat --insert psid -j MASQUERADE --ps=
id $offset:$psid:$psid_length
+	ip netns exec nsrouter iptables -t nat -I POSTROUTING -o veth2 -j psid
+
+	# calculate psid mask
+	two_power_j=3D$(( $offset / (1 << $psid_length) ))
+	psid_mask=3D$(( ( (1 << $psid_length) - 1) * $two_power_j ))
+
+	# Create file
+	dd if=3D/dev/urandom of=3D"${infile}" bs=3D"${datalen}" count=3D1 >/dev=
/null 2>&1
+
+	# Test multiple ports
+	for p in 1 2 3 4 5; do
+		port=3D1080$p
+
+		test_service
+		if [ $? -ne 0 ]; then
+			ret=3D1
+			break
+		fi
+
+		check_connection
+		if [ $? -ne 0 ]; then
+			ret=3D1
+			break
+		fi
+	done
+
+	# tidy up test rules
+	ip netns exec nsrouter iptables -F
+	ip netns exec nsrouter iptables -t nat -F
+	ip netns exec nsrouter iptables -t nat -X psid
+}
+
+for n in $ns_all; do
+	ip netns add $n
+	ip -net $n link set lo up
+done
+
+for i in 1 2; do
+	ip link add veth0 netns nsclient$i type veth peer name veth$i netns nsr=
outer
+
+	ip -net nsclient$i link set veth0 up
+	ip -net nsclient$i addr add $(ipv4 $i 2)/24 dev veth0
+
+	ip -net nsrouter link set veth$i up
+	ip -net nsrouter addr add $(ipv4 $i 1)/24 dev veth$i
+done
+
+ip -net nsclient1 route add default via $(ipv4 1 1)
+ip -net nsclient2 route add default via $(ipv4 2 1)
+
+ip netns exec nsrouter sysctl -q net.ipv4.conf.all.forwarding=3D1
+
+offset=3D1024
+psid_length=3D8
+for psid in 0 52; do
+	run_test
+	if [ $? -ne 0 ]; then
+		break
+	fi
+done
+
+cleanup
+exit $ret
--=20
2.32.0

