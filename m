Return-Path: <linux-kselftest+bounces-12436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7C19121F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 12:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67DE282086
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC76D17A934;
	Fri, 21 Jun 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAU6ESyu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CF217A93D
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964748; cv=none; b=Gm4hynmV+6W+nCX9GwJiYnbQ2GqfjP9u5eQH8D8wye6U/xdohzW+OFxnNjR86lUP6lE0f5j9uzjeZZh3y3BN+Rt77Gf9cez2Bij0W0FfCt91gBu3H//yZlW7d9jye6sHvu8WNclAOl8NS1HxhUNz2yxYqEuGPVsM59OUv6I0ttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964748; c=relaxed/simple;
	bh=lrQmBWHEgRZGt3qqWfvkr5wwYpPfCkU6W0Xy+X29MQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtkljrngEvK0vZWa1tZfBrEn3Ia1zACWdWJgIiKnS5XQ+0pvq5TZyTHjHu5qzNNDPldajoEZqRsRD2/+gXx2XhHZ3oiI06oDlRATUvzD1VB0ONzIWvs1gP9FqN/kCP2KoJwr8F91Thd5iDETPj9WAEYDzzUCibgUsjs4CxCc2qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iAU6ESyu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718964746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTJUxCKffkBrzqCPEFK7LRAjyE3x2giL24jMT6+yDtE=;
	b=iAU6ESyuiWk2aLheOXoQ0LelwPXYN4yG1x5ZtGtqBOZi1gbVe9CZdrSQmAfQyKF3oIXIRN
	gEu5528WRbvhbhy81vAQSV4oIu6RnEkrdTXWG8SK9u7YzzRJGDZaCqa/Jv170OXa+As1Xb
	u5an0UxhSxp60fxidEClTSXJXRSWvD4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-bGiFjcPUNM-D6UlEUelAIQ-1; Fri,
 21 Jun 2024 06:12:23 -0400
X-MC-Unique: bGiFjcPUNM-D6UlEUelAIQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 514241956051;
	Fri, 21 Jun 2024 10:12:21 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54C551956048;
	Fri, 21 Jun 2024 10:12:17 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 10/10] selftests: openvswitch: add emit_sample test
Date: Fri, 21 Jun 2024 12:11:02 +0200
Message-ID: <20240621101113.2185308-11-amorenoz@redhat.com>
In-Reply-To: <20240621101113.2185308-1-amorenoz@redhat.com>
References: <20240621101113.2185308-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add a test to verify sampling packets via psample works.

In order to do that, create a subcommand in ovs-dpctl.py to listen to
on the psample multicast group and print samples.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 110 +++++++++++++++++-
 .../selftests/net/openvswitch/ovs-dpctl.py    |  73 +++++++++++-
 2 files changed, 177 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 15bca0708717..a07530ff13ca 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -20,7 +20,8 @@ tests="
 	nat_related_v4				ip4-nat-related: ICMP related matches work with SNAT
 	netlink_checks				ovsnl: validate netlink attrs and settings
 	upcall_interfaces			ovs: test the upcall interfaces
-	drop_reason				drop: test drop reasons are emitted"
+	drop_reason				drop: test drop reasons are emitted
+	emit_sample 				emit_sample: Sampling packets with psample"
 
 info() {
     [ $VERBOSE = 0 ] || echo $*
@@ -102,12 +103,21 @@ ovs_netns_spawn_daemon() {
 	shift
 	netns=$1
 	shift
-	info "spawning cmd: $*"
-	ip netns exec $netns $*  >> $ovs_dir/stdout  2>> $ovs_dir/stderr &
+	if [ "$netns" == "_default" ]; then
+		$*  >> $ovs_dir/stdout  2>> $ovs_dir/stderr &
+	else
+		ip netns exec $netns $*  >> $ovs_dir/stdout  2>> $ovs_dir/stderr &
+	fi
 	pid=$!
 	ovs_sbx "$sbx" on_exit "kill -TERM $pid 2>/dev/null"
 }
 
+ovs_spawn_daemon() {
+	sbx=$1
+	shift
+	ovs_netns_spawn_daemon $sbx "_default" $*
+}
+
 ovs_add_netns_and_veths () {
 	info "Adding netns attached: sbx:$1 dp:$2 {$3, $4, $5}"
 	ovs_sbx "$1" ip netns add "$3" || return 1
@@ -170,6 +180,19 @@ ovs_drop_reason_count()
 	return `echo "$perf_output" | grep "$pattern" | wc -l`
 }
 
+ovs_test_flow_fails () {
+	ERR_MSG="Flow actions may not be safe on all matching packets"
+
+	PRE_TEST=$(dmesg | grep -c "${ERR_MSG}")
+	ovs_add_flow $@ &> /dev/null $@ && return 1
+	POST_TEST=$(dmesg | grep -c "${ERR_MSG}")
+
+	if [ "$PRE_TEST" == "$POST_TEST" ]; then
+		return 1
+	fi
+	return 0
+}
+
 usage() {
 	echo
 	echo "$0 [OPTIONS] [TEST]..."
@@ -184,6 +207,87 @@ usage() {
 	exit 1
 }
 
+
+# emit_sample test
+# - use emit_sample to observe packets
+test_emit_sample() {
+	sbx_add "test_emit_sample" || return $?
+
+	# Add a datapath with per-vport dispatching.
+	ovs_add_dp "test_emit_sample" emit_sample -V 2:1 || return 1
+
+	info "create namespaces"
+	ovs_add_netns_and_veths "test_emit_sample" "emit_sample" \
+		client c0 c1 172.31.110.10/24 -u || return 1
+	ovs_add_netns_and_veths "test_emit_sample" "emit_sample" \
+		server s0 s1 172.31.110.20/24 -u || return 1
+
+	# Check if emit_sample actions can be configured.
+	ovs_add_flow "test_emit_sample" emit_sample \
+	'in_port(1),eth(),eth_type(0x0806),arp()' 'emit_sample(group=1)'
+	if [ $? == 1 ]; then
+		info "no support for emit_sample - skipping"
+		ovs_exit_sig
+		return $ksft_skip
+	fi
+
+	ovs_del_flows "test_emit_sample" emit_sample
+
+	# Allow ARP
+	ovs_add_flow "test_emit_sample" emit_sample \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_emit_sample" emit_sample \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+
+	# Test action verification.
+	OLDIFS=$IFS
+	IFS='*'
+	min_key='in_port(1),eth(),eth_type(0x0800),ipv4()'
+	for testcase in \
+		"cookie to large"*"emit_sample(group=1,cookie=1615141312111009080706050403020100)" \
+		"no group with cookie"*"emit_sample(cookie=abcd)" \
+		"no group"*"sample()";
+	do
+		set -- $testcase;
+		ovs_test_flow_fails "test_emit_sample" emit_sample $min_key $2
+		if [ $? == 1 ]; then
+			info "failed - $1"
+			return 1
+		fi
+	done
+	IFS=$OLDIFS
+
+	# Sample first 14 bytes of all traffic.
+	ovs_add_flow "test_emit_sample" emit_sample \
+	"in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10,proto=1),icmp()" "trunc(14),emit_sample(group=1,cookie=c0ffee),2"
+
+	# Sample all traffic. In this case, use a sample() action with both
+	# emit_sample and an upcall emulating simultaneous local sampling and
+	# sFlow / IPFIX.
+	nlpid=$(grep -E "listening on upcall packet handler" $ovs_dir/s0.out | cut -d ":" -f 2 | tr -d ' ')
+	ovs_add_flow "test_emit_sample" emit_sample \
+	"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" "sample(sample=100%,actions(emit_sample(group=2,cookie=eeff0c),userspace(pid=${nlpid},userdata=eeff0c))),1"
+
+	# Record emit_sample data.
+	ovs_spawn_daemon "test_emit_sample" python3 $ovs_base/ovs-dpctl.py psample
+
+	# Send a single ping.
+	sleep 1
+	ovs_sbx "test_emit_sample" ip netns exec client ping -I c1 172.31.110.20 -c 1 || return 1
+	sleep 1
+
+	# We should have received one userspace action upcall and 2 psample packets.
+	grep -E "userspace action command" $ovs_dir/s0.out >/dev/null 2>&1 || return 1
+
+	# client -> server samples should only contain the first 14 bytes of the packet.
+	grep -E "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{28}$" \
+			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
+	grep -E "rate:4294967295,group:2,cookie:eeff0c" \
+			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
+
+	return 0
+}
+
 # drop_reason test
 # - drop packets and verify the right drop reason is reported
 test_drop_reason() {
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index a3c26ddac42f..24e696d7371b 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -27,8 +27,10 @@ try:
     from pyroute2.netlink import genlmsg
     from pyroute2.netlink import nla
     from pyroute2.netlink import nlmsg_atoms
+    from pyroute2.netlink.event import EventSocket
     from pyroute2.netlink.exceptions import NetlinkError
     from pyroute2.netlink.generic import GenericNetlinkSocket
+    from pyroute2.netlink.nlsocket import Marshal
     import pyroute2
 
 except ModuleNotFoundError:
@@ -2211,10 +2213,70 @@ class OvsFlow(GenericNetlinkSocket):
         print("MISS upcall[%d/%s]: %s" % (seq, pktpres, keystr), flush=True)
 
     def execute(self, packetmsg):
-        print("userspace execute command")
+        print("userspace execute command", flush=True)
 
     def action(self, packetmsg):
-        print("userspace action command")
+        print("userspace action command", flush=True)
+
+
+class psample_sample(genlmsg):
+    nla_map = (
+        ("PSAMPLE_ATTR_IIFINDEX", "none"),
+        ("PSAMPLE_ATTR_OIFINDEX", "none"),
+        ("PSAMPLE_ATTR_ORIGSIZE", "none"),
+        ("PSAMPLE_ATTR_SAMPLE_GROUP", "uint32"),
+        ("PSAMPLE_ATTR_GROUP_SEQ", "none"),
+        ("PSAMPLE_ATTR_SAMPLE_RATE", "uint32"),
+        ("PSAMPLE_ATTR_DATA", "array(uint8)"),
+        ("PSAMPLE_ATTR_GROUP_REFCOUNT", "none"),
+        ("PSAMPLE_ATTR_TUNNEL", "none"),
+        ("PSAMPLE_ATTR_PAD", "none"),
+        ("PSAMPLE_ATTR_OUT_TC", "none"),
+        ("PSAMPLE_ATTR_OUT_TC_OCC", "none"),
+        ("PSAMPLE_ATTR_LATENCY", "none"),
+        ("PSAMPLE_ATTR_TIMESTAMP", "none"),
+        ("PSAMPLE_ATTR_PROTO", "none"),
+        ("PSAMPLE_ATTR_USER_COOKIE", "array(uint8)"),
+    )
+
+    def dpstr(self):
+        fields = []
+        data = ""
+        for (attr, value) in self["attrs"]:
+            if attr == "PSAMPLE_ATTR_SAMPLE_GROUP":
+                fields.append("group:%d" % value)
+            if attr == "PSAMPLE_ATTR_SAMPLE_RATE":
+                fields.append("rate:%d" % value)
+            if attr == "PSAMPLE_ATTR_USER_COOKIE":
+                value = "".join(format(x, "02x") for x in value)
+                fields.append("cookie:%s" % value)
+            if attr == "PSAMPLE_ATTR_DATA" and len(value) > 0:
+                data = "data:%s" % "".join(format(x, "02x") for x in value)
+
+        return ("%s %s" % (",".join(fields), data)).strip()
+
+
+class psample_msg(Marshal):
+    PSAMPLE_CMD_SAMPLE = 0
+    PSAMPLE_CMD_GET_GROUP = 1
+    PSAMPLE_CMD_NEW_GROUP = 2
+    PSAMPLE_CMD_DEL_GROUP = 3
+    PSAMPLE_CMD_SET_FILTER = 4
+    msg_map = {PSAMPLE_CMD_SAMPLE: psample_sample}
+
+
+class Psample(EventSocket):
+    genl_family = "psample"
+    mcast_groups = ["packets"]
+    marshal_class = psample_msg
+
+    def read_samples(self):
+        while True:
+            try:
+                for msg in self.get():
+                    print(msg.dpstr(), flush=True)
+            except NetlinkError as ne:
+                raise ne
 
 
 def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
@@ -2274,7 +2336,7 @@ def main(argv):
         help="Increment 'verbose' output counter.",
         default=0,
     )
-    subparsers = parser.add_subparsers()
+    subparsers = parser.add_subparsers(dest="subcommand")
 
     showdpcmd = subparsers.add_parser("show")
     showdpcmd.add_argument(
@@ -2331,6 +2393,8 @@ def main(argv):
     delfscmd = subparsers.add_parser("del-flows")
     delfscmd.add_argument("flsbr", help="Datapath name")
 
+    subparsers.add_parser("psample")
+
     args = parser.parse_args()
 
     if args.verbose > 0:
@@ -2345,6 +2409,9 @@ def main(argv):
 
     sys.setrecursionlimit(100000)
 
+    if args.subcommand == "psample":
+        Psample().read_samples()
+
     if hasattr(args, "showdp"):
         found = False
         for iface in ndb.interfaces:
-- 
2.45.1


