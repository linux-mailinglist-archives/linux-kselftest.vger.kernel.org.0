Return-Path: <linux-kselftest+bounces-40837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6820FB45929
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24B5A6322B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1071935A2BD;
	Fri,  5 Sep 2025 13:31:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB2D352FED;
	Fri,  5 Sep 2025 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079084; cv=none; b=KZYI/UxVyzdfzM3OAzSz9P4hHvrHXRfn8Ni2GDmzD0cfAMHe3OuBdYh4jDA+iN1/aOCBReYuHCJP6SxBAw6Cu+GWnbi6bcQrMAUjQQoH92OSVqy1sElAVJ6vp32lieKaNqylK+VuhxhgXi5vaaKwjbACVKJNN2IH+HZCW2XCgHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079084; c=relaxed/simple;
	bh=DODS33Mlp6wYUMyfzXPoShyB43edY282MDJD5w4fBXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gO6+X0XYq2j1VTre8x4Tgl54SaPciHjwGxouuJ5Bn6uiHjeOFEnWiFSnhR3JBnhL25KRS5nE5e9sASYOM9KYIN8QOvGuPQrhhd3fFPR07/sNwuQ3ISIdTPixP5VKZReSL0HSuH5Zevko6uQrJFWFljMrbZs+lG9HvkSntAFYviU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b04163fe08dso368296166b.3;
        Fri, 05 Sep 2025 06:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079081; x=1757683881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nu9bR6astpfVuE3kjXZ+NEagS2PXhylWiWkQoswor8=;
        b=JTVYjKZgV9nK69DCb14Pw6MgazpXkkHQSLSfdkq/iT1cnanaEflHBLuja9xvzOGmDF
         zN5fDe587tSlWLqDO6YrKB7hyavY6RfCf9TcYVMWVJ4dxA85hKHteBJbb5h5c1AmqUyp
         LaPjYqSBZGqfmxrxnIZCjeLhjgpV+ixB/H0T/iYtFH2RIVRdj4gJ/L0RgybE23PGncdc
         I923KqmeiHDxZf7p2PPbPFIYBWUVi2yRDfiL39s9Eos5KNHkIJxwP3DglhfvzOe+kGnr
         F+sZ6o/ugm5dAXspvGVcAZc6nk9XYoIC1XjJ1fhgBIiQfHdjmhRkrUXSFAnHJj7/IA+0
         ZqTw==
X-Forwarded-Encrypted: i=1; AJvYcCUgkmm/VeiEA8PIp5izUR1TvQe2AJv/4qGQmqgUxoff5WQaxkRCzrdc7D3TFm2BeRaD2q8HUKEKb+Uh0ZM=@vger.kernel.org, AJvYcCW+hvlQB+PFXRzFOGE/zwoFSs9HKUu0BIVOL+owVWVwhWjoerH4tJZoCh4nsyFHTFtfUU0N99gUrp47wliTKK6T@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3TT7knoxjIT2PrgtFdpW4MSbXjN6ha4ZpFzT5G76lSB2bCuba
	IU4rI1EXn/Ld9NW7jb8bn0qkQvgMcj11Xnkigkk/Mm+chHrCWOUYz73r76EIP9NY
X-Gm-Gg: ASbGncvBpAiMl0Wfb687Gp5b3ttHhQWnD3sAR54e6jKRwnLQ0srJ0wgKArsdYsJtfKM
	t+lC1LN6/sEW7DNwaaAch7L6wp3nVaWcpOu18Gx0HDhxYzIplaFsj2YVYoxeznLb3mJfOM8ybjy
	tnu3SZ/PJxjkf3N0o1q4BPyBo74Zz/WIBNin+XRgVVKu1ur5agxkdTQTPYn9vG386x+J91TVyIB
	Uh1Z2eEKC1CNVgOmHhE3yjTzC7XeJjkENZNqRLEhR4mAUwB9b4vPFJzjjwITd7mFPojcLUXaGO+
	teqr9CvbBk4izZUPKoUFPmG8/YlPDDKkH00c/tG3s6fv8c4iWEdRulB471CdFRAQF735kdOk1wR
	yiBQAj/XPrM8MIv2/l1aCz1MLURw2vILkibzLtiMz1HdA27N/P2ncAYtRSboxK5H9FOUmJw==
X-Google-Smtp-Source: AGHT+IHvr4xeGBs3N9yc3odYnOITFBdbF5NHM8S+tF7FX7XYvrKLzcqmgWJ+02BM5szXFPOUoTmCIQ==
X-Received: by 2002:a17:906:3990:b0:b04:9a8:1645 with SMTP id a640c23a62f3a-b0409a817a5mr1768378366b.60.1757079080267;
        Fri, 05 Sep 2025 06:31:20 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-56-72.nat.epc.tmcz.cz. [89.24.56.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0409bf055esm1547277666b.85.2025.09.05.06.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:31:19 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dev@openvswitch.org,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net 2/2] selftests: openvswitch: add a simple test for tunnel metadata
Date: Fri,  5 Sep 2025 15:30:56 +0200
Message-ID: <20250905133105.3940420-3-i.maximets@ovn.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905133105.3940420-1-i.maximets@ovn.org>
References: <20250905133105.3940420-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test ensures that upon receiving decapsulated packets from a
tunnel interface in openvswitch, the tunnel metadata fields are
properly populated.  This partially covers interoperability of the
kernel tunnel ports and openvswitch tunnels (LWT) and parsing and
formatting of the tunnel metadata fields of the openvswitch netlink
uAPI.  Doing so, this test also ensures that fields and flags are
properly extracted during decapsulation by the tunnel core code,
serving as a regression test for the previously fixed issue with the
DF bit not being extracted from the outer IP header.

The ovs-dpctl.py script already supports all that is necessary for
the tunnel ports for this test, so we only need to adjust the
ovs_add_if() function to pass the '-t' port type argument in order
to be able to create tunnel ports in the openvswitch datapath.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 88 +++++++++++++++++--
 1 file changed, 81 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 3c8d3455d8e7..b327d3061ed5 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -25,6 +25,7 @@ tests="
 	nat_related_v4				ip4-nat-related: ICMP related matches work with SNAT
 	netlink_checks				ovsnl: validate netlink attrs and settings
 	upcall_interfaces			ovs: test the upcall interfaces
+	tunnel_metadata				ovs: test extraction of tunnel metadata
 	drop_reason				drop: test drop reasons are emitted
 	psample					psample: Sampling packets with psample"
 
@@ -113,13 +114,13 @@ ovs_add_dp () {
 }
 
 ovs_add_if () {
-	info "Adding IF to DP: br:$2 if:$3"
-	if [ "$4" != "-u" ]; then
-		ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py add-if "$2" "$3" \
-		    || return 1
+	info "Adding IF to DP: br:$3 if:$4 ($2)"
+	if [ "$5" != "-u" ]; then
+		ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py add-if \
+		    -t "$2" "$3" "$4" || return 1
 	else
 		python3 $ovs_base/ovs-dpctl.py add-if \
-		    -u "$2" "$3" >$ovs_dir/$3.out 2>$ovs_dir/$3.err &
+		    -u -t "$2" "$3" "$4" >$ovs_dir/$4.out 2>$ovs_dir/$4.err &
 		pid=$!
 		on_exit "ovs_sbx $1 kill -TERM $pid 2>/dev/null"
 	fi
@@ -166,9 +167,9 @@ ovs_add_netns_and_veths () {
 	fi
 
 	if [ "$7" != "-u" ]; then
-		ovs_add_if "$1" "$2" "$4" || return 1
+		ovs_add_if "$1" "netdev" "$2" "$4" || return 1
 	else
-		ovs_add_if "$1" "$2" "$4" -u || return 1
+		ovs_add_if "$1" "netdev" "$2" "$4" -u || return 1
 	fi
 
 	if [ $TRACING -eq 1 ]; then
@@ -756,6 +757,79 @@ test_upcall_interfaces() {
 	return 0
 }
 
+ovs_add_kernel_tunnel() {
+	local sbxname=$1; shift
+	local ns=$1; shift
+	local tnl_type=$1; shift
+	local name=$1; shift
+	local addr=$1; shift
+
+	info "setting up kernel ${tnl_type} tunnel ${name}"
+	ovs_sbx "${sbxname}" ip -netns ${ns} link add dev ${name} type ${tnl_type} $* || return 1
+	on_exit "ovs_sbx ${sbxname} ip -netns ${ns} link del ${name} >/dev/null 2>&1"
+	ovs_sbx "${sbxname}" ip -netns ${ns} addr add dev ${name} ${addr} || return 1
+	ovs_sbx "${sbxname}" ip -netns ${ns} link set dev ${name} mtu 1450 up || return 1
+}
+
+test_tunnel_metadata() {
+	which arping >/dev/null 2>&1 || return $ksft_skip
+
+	sbxname="test_tunnel_metadata"
+	sbx_add "${sbxname}" || return 1
+
+	info "setting up new DP"
+	ovs_add_dp "${sbxname}" tdp0 -V 2:1 || return 1
+
+	ovs_add_netns_and_veths "${sbxname}" tdp0 tns left0 l0 \
+		172.31.110.1/24 || return 1
+
+	info "removing veth interface from openvswitch and setting IP"
+	ovs_del_if "${sbxname}" tdp0 left0 || return 1
+	ovs_sbx "${sbxname}" ip addr add 172.31.110.2/24 dev left0 || return 1
+	ovs_sbx "${sbxname}" ip link set left0 up || return 1
+
+	info "setting up tunnel port in openvswitch"
+	ovs_add_if "${sbxname}" "vxlan" tdp0 ovs-vxlan0 -u || return 1
+	on_exit "ovs_sbx ${sbxname} ip link del ovs-vxlan0"
+	ovs_wait ip link show ovs-vxlan0 &>/dev/null || return 1
+	ovs_sbx "${sbxname}" ip link set ovs-vxlan0 up || return 1
+
+	configs=$(echo '
+	    1 172.31.221.1/24 1155332 32   set   udpcsum flags\(df\|csum\)
+	    2 172.31.222.1/24 1234567 45   set noudpcsum flags\(df\)
+	    3 172.31.223.1/24 1020304 23 unset   udpcsum flags\(csum\)
+	    4 172.31.224.1/24 1357986 15 unset noudpcsum' | sed '/^$/d')
+
+	while read -r i addr id ttl df csum flags; do
+		ovs_add_kernel_tunnel "${sbxname}" tns vxlan vxlan${i} ${addr} \
+			remote 172.31.110.2 id ${id} dstport 4789 \
+			ttl ${ttl} df ${df} ${csum} || return 1
+	done <<< "${configs}"
+
+	ovs_wait grep -q 'listening on upcall packet handler' \
+		${ovs_dir}/ovs-vxlan0.out || return 1
+
+	info "sending arping"
+	for i in 1 2 3 4; do
+		ovs_sbx "${sbxname}" ip netns exec tns \
+			arping -I vxlan${i} 172.31.22${i}.2 -c 1 \
+			>${ovs_dir}/arping.stdout 2>${ovs_dir}/arping.stderr
+	done
+
+	info "checking that received decapsulated packets carry correct metadata"
+	while read -r i addr id ttl df csum flags; do
+		arp_hdr="arp\\(sip=172.31.22${i}.1,tip=172.31.22${i}.2,op=1,sha="
+		addrs="src=172.31.110.1,dst=172.31.110.2"
+		ports="tp_src=[0-9]*,tp_dst=4789"
+		tnl_md="tunnel\\(tun_id=${id},${addrs},ttl=${ttl},${ports},${flags}\\)"
+
+		ovs_sbx "${sbxname}" grep -qE "MISS upcall.*${tnl_md}.*${arp_hdr}" \
+			${ovs_dir}/ovs-vxlan0.out || return 1
+	done <<< "${configs}"
+
+	return 0
+}
+
 run_test() {
 	(
 	tname="$1"
-- 
2.50.1


