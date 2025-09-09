Return-Path: <linux-kselftest+bounces-41058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45245B5034C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 18:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44A7540E36
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1875635FC3A;
	Tue,  9 Sep 2025 16:54:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E435FC32;
	Tue,  9 Sep 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436894; cv=none; b=TYbVL7FHbfoFJWsMC4JP9ag01a7W1UBZG5HZqrqAxbVNtJj3tnjv2MknsgUE9/Dps4AH7Sunh4mhTBHOVMmOTfDFlDmgyLvYnlsMgYtvfE7DnUAuXSRU2o8WDC7oDj32uNiLUckVGA4Ua/anNx+ZmBXfgAPhOdF3qICbY3xKrR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436894; c=relaxed/simple;
	bh=nRz6JK3TGon9dwCEfHreJkbmmrfCML1mWMrSbHTV6aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpcT9vEmBJPJ8xm6ns/cv/4nc2EhDy2a4936PpV8Wnm9bdx2kT0zWu8f5eyaODmB4fLt5fEQuWYz81uZQZ95n6lXuJiC4kGLqyi75Zcag1LzXbwDohNhkD4vT6L2exdOyrdk+ge08LC1qipnm01qObTx/HDST+B1iMRkXceEA/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so8772205a12.0;
        Tue, 09 Sep 2025 09:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436890; x=1758041690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDv4KH8jPHGSDUgmt5ktxwJjhGcORL8y42N6s1NDG7w=;
        b=v7L/BeKWTvIdoBQjJDVhka/RZUU891/GVoQYERnVlaYAvbUxC+8oA6t0ZKNLjmZ12L
         TPGSzuIt3q5snfZc04H0EtC8X0momO5MqeE/YLKRoc4ytAq9t33f35Fip2L+HNQVbSdR
         Q0ueWSV8ZiTfkInNR1FrJent+Bw2HCm/jiFXrLHpaEsyLYixETY1rXxc9bowgG+okWs4
         ckpQLOTKr3JNv0WLZ8m3j8CfA3bkPjWmpYkpssJky0Tlh1OFV/5i16BtLk8GkC/NX+cv
         AvBDG7gJAbvW4g7wsU+fCj4jx5aTBkVmFs16xiD2g3549qBskauQFoQFnyRUrJa+3HXq
         jntA==
X-Forwarded-Encrypted: i=1; AJvYcCUtI6uPQXfDcV99Hq6uqb0sveK+QzOb4fKDF0zTKa7D8OsN2x0etkeXLszu4AIqCHIeQpxfAys5LzVVqFFBIsbL@vger.kernel.org, AJvYcCXNi07KtKMsirJ4gNCDberI2TukW/7XbpEEDFv3D1+eZKPZYk1eCIZKLmjZeaJmhdrGaJn/7pjfrESSpGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySG6wwTe43eo44DOvtiJVBAqFM32XoLsPTwWTCfnPGD/wRugvG
	vno+Oop4mce7WQ59FpnTysEip0406UUsWR2f1U+0AmMjPVFbJN3wyXHWdlwjJlH+
X-Gm-Gg: ASbGncvvjml2GAYdxHf5DLRqN/UVw1XMcFXH1/Eyz9gNcIDUFLXlpFbvQXVnZeH0hse
	rI8zKWHddInZ0tcTelKq0WYTT53N52l0wIVN1z4KF0BJpLVd1RKC71/szbfVTx69qMDgn0iCO+G
	y1e4VfdgoOnP03z6AYjd4dyMVUBg4Vv8+4s++KFR6zFbkOHXMcT7UqP6DQYsA80o/ArgKxBOajy
	Y9N19VRB8RVRKU13c3mkTJncQK/D67AyJdCSUFU6YVbt42IfFKbsZXLfjl7IhrBmNq5SaPwzyCT
	NjSaxFUUoRl/IwSF4QWbcFhTH7Go6Yn80CI05o+kgewRXMs5NZktNvl/+QAVOkGBkxO2NH1K+H2
	v9TVuJiq8J9WJ/0ohyIDI6tB/XgY5VXFdYSON44/5dwXPQU8/QprH1RPcAu9W+A==
X-Google-Smtp-Source: AGHT+IHjBBi59dApkSXEMTE0JwWINS8IrghKjtG/hVSAeO9AlBwCCqtQiYBADFT1S3EMTBJawwaAgA==
X-Received: by 2002:a05:6402:358f:b0:628:bee2:b31d with SMTP id 4fb4d7f45d1cf-628bee2b6e7mr7584590a12.3.1757436890039;
        Tue, 09 Sep 2025 09:54:50 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-97-40.customers.tmcz.cz. [78.80.97.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018f90cesm1497326a12.44.2025.09.09.09.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:54:49 -0700 (PDT)
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
	Ido Schimmel <idosch@idosch.org>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net v2 2/2] selftests: openvswitch: add a simple test for tunnel metadata
Date: Tue,  9 Sep 2025 18:54:16 +0200
Message-ID: <20250909165440.229890-3-i.maximets@ovn.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250909165440.229890-1-i.maximets@ovn.org>
References: <20250909165440.229890-1-i.maximets@ovn.org>
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

Reviewed-by: Aaron Conole <aconole@redhat.com>
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


