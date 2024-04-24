Return-Path: <linux-kselftest+bounces-8773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC0C8B0BAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 15:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10D01C2302F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83FB1607AD;
	Wed, 24 Apr 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjIo36PE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE615FA97
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966903; cv=none; b=tBUqF76gVvrtSLJUiJG/RrGPJ8gDP/rStP7d3ot8Zd57++hU8gtDOhqETINs853wKhgY44SHXQL9rS1OOEXCiLTPBw+i3iAEIB5Ce/OOHyFkmqkhCfitBFyPLOFtILCw1AUsrYMj1aF/4aHaD0x+07H3TaOAZlPf63iA1FoIeCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966903; c=relaxed/simple;
	bh=XeNqMhdDvrQ3e9k2Sc71pAHggkwcCI7HMO1vYqq4+y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2r3gsZKlV4foMT7iP6Vxr1yO02LEjz6BapuDTQ7mRVNesiX8fQEyzTWZ/APwCosQq8U5GU4ciDvMtDlH5LcpZgL7HcJ/mTvWj+dNoGRy3Z1wwn96W5TJzNsdepjZwOiw4zxumh18yTu9xznwuUXXEK1r2vlEqb7JSzYXx9oUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjIo36PE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713966900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRfG44Ph4wnW5G/uRG2RMT/4P6AMh9CGQOP3sRR/P0s=;
	b=DjIo36PEbE1vQn2JArJLWOkvAqv78Ke+ox4jvpZV93feDSuBqD6bEL/0oDgpt/KUp80DA4
	nefmyY4SyLrU0eaZl+GzSO3x0Ji8vLjqUiMtq768PyH+6Vw5JAu8SXhAfp7jVXfrnbTrxo
	zPIWFql3T7rf3xEMu/5Sh9oDB9NDlnA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-aHlfTTb1N_y3PKS5ssXMKg-1; Wed, 24 Apr 2024 09:54:57 -0400
X-MC-Unique: aHlfTTb1N_y3PKS5ssXMKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFC47823F1D;
	Wed, 24 Apr 2024 13:54:56 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8AB1C1C060D0;
	Wed, 24 Apr 2024 13:54:54 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 8/8] selftests: openvswitch: add psample test
Date: Wed, 24 Apr 2024 15:50:55 +0200
Message-ID: <20240424135109.3524355-9-amorenoz@redhat.com>
In-Reply-To: <20240424135109.3524355-1-amorenoz@redhat.com>
References: <20240424135109.3524355-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Add a test to verify sampling packets via psample works.

In order to do that, create a subcommand in ovs-dpctl.py to listen to
on the psample multicast group and print samples.

In order to also test simultaneous sFlow and psample actions, add
missing parsing support for "userspace" action (via refactoring the one
in sample).

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  |  97 +++++++++-
 .../selftests/net/openvswitch/ovs-dpctl.py    | 167 ++++++++++++++----
 2 files changed, 231 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 5cae53543849..7a2307a384a9 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -20,7 +20,8 @@ tests="
 	nat_related_v4				ip4-nat-related: ICMP related matches work with SNAT
 	netlink_checks				ovsnl: validate netlink attrs and settings
 	upcall_interfaces			ovs: test the upcall interfaces
-	drop_reason				drop: test drop reasons are emitted"
+	drop_reason				drop: test drop reasons are emitted
+	psample					psample: Sampling packets with psample"
 
 info() {
     [ $VERBOSE = 0 ] || echo $*
@@ -170,6 +171,19 @@ ovs_drop_reason_count()
 	return `echo "$perf_output" | grep "$pattern" | wc -l`
 }
 
+ovs_test_flow_fails () {
+	ERR_MSG="Flow actions may not be safe on all matching packets"
+
+	PRE_TEST=$(dmesg | grep -c "${ERR_MSG}")
+    ovs_add_flow $@ &> /dev/null $@ && return 1
+	POST_TEST=$(dmesg | grep -c "${ERR_MSG}")
+
+	if [ "$PRE_TEST" == "$POST_TEST" ]; then
+		return 1
+	fi
+    return 0
+}
+
 usage() {
 	echo
 	echo "$0 [OPTIONS] [TEST]..."
@@ -184,6 +198,87 @@ usage() {
 	exit 1
 }
 
+
+# psample test
+# - samples packets with psample
+test_psample() {
+	sbx_add "test_psample" || return $?
+
+	# Add a datapath with per-vport dispatching.
+	ovs_add_dp "test_psample" psample -V 2:1 || return 1
+
+	info "create namespaces"
+	ovs_add_netns_and_veths "test_psample" "psample" \
+		client c0 c1 172.31.110.10/24 -u || return 1
+	ovs_add_netns_and_veths "test_psample" "psample" \
+		server s0 s1 172.31.110.20/24 -u || return 1
+
+	# Check if psample actions can be configured.
+	ovs_add_flow "test_psample" psample \
+	'in_port(1),eth(),eth_type(0x0806),arp()' 'sample(sample=100%,group_id=1,cookie=0102)'
+	if [ $? == 1 ]; then
+		info "no support for psample - skipping"
+		ovs_exit_sig
+		return $ksft_skip
+	fi
+
+	ovs_del_flows "test_psample" psample
+
+	# Allow ARP
+	ovs_add_flow "test_psample" psample \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_psample" psample \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+
+    # Test action verification.
+	OLDIFS=$IFS
+	IFS='*'
+	min_key='in_port(1),eth(),eth_type(0x800),ipv4()'
+	for testcase in \
+		"cookie to large"*"sample(sample=100%,group_id=1,cookie=1615141312111009080706050403020100)" \
+		"no group or action"*"sample(sample=100%)" \
+		"no group or action with cookie"*"sample(sample=100%,cookie=deadbeef)";
+	do
+		set -- $testcase;
+		ovs_test_flow_fails "test_psample" psample $min_key $2
+		if [ $? == 1 ]; then
+			info "failed - $1"
+			return 1
+		fi
+	done
+	IFS=$OLDIFS
+
+	# Sample all traffic. In this case the sample action only has psample
+	# arguments.
+	ovs_add_flow "test_psample" psample \
+	"in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10,proto=1),icmp()" "sample(sample=100%,group_id=1,cookie=c0ffee),2"
+
+	# Sample all traffic. In this case the sample action has both psample
+	# arguments and an upcall emulating simultaneous psample and
+	# sFlow / IPFIX.
+	nlpid=$(grep -E "listening on upcall packet handler" $ovs_dir/s0.out | cut -d ":" -f 2 | tr -d ' ')
+	ovs_add_flow "test_psample" psample \
+	"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" "sample(sample=100%,group_id=2,cookie=eeff0c,actions(userspace(pid=${nlpid},userdata=eeff0c))),1"
+
+	# Record psample data.
+	python3 $ovs_base/ovs-dpctl.py psample  >$ovs_dir/psample.out 2>$ovs_dir/psample.err &
+	pid=$!
+	on_exit "ovs_sbx test_psample kill -TERM $pid 2>/dev/null"
+
+	# Send a single ping.
+	sleep 1
+	ovs_sbx "test_psample" ip netns exec client ping -I c1 172.31.110.20 -c 1 || return 1
+	sleep 1
+
+	# We should have received one userspace action upcall and 2 psample packets.
+	grep -E "userspace action command" $ovs_dir/s0.out >/dev/null 2>&1 || return 1
+
+	grep -E "rate:1,group:1,cookie:c0ffee" $ovs_dir/psample.out >/dev/null 2>&1 || return 1
+	grep -E "rate:1,group:2,cookie:eeff0c" $ovs_dir/psample.out >/dev/null 2>&1 || return 1
+
+	return 0
+}
+
 # drop_reason test
 # - drop packets and verify the right drop reason is reported
 test_drop_reason() {
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 3a2dddc57e42..2fb5bcfe9c36 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -27,8 +27,10 @@ try:
     from pyroute2.netlink import genlmsg
     from pyroute2.netlink import nla
     from pyroute2.netlink import nlmsg_atoms
-    from pyroute2.netlink.exceptions import NetlinkError
+    from pyroute2.netlink.event import EventSocket
     from pyroute2.netlink.generic import GenericNetlinkSocket
+    from pyroute2.netlink.nlsocket import Marshal
+    from pyroute2.netlink.exceptions import NetlinkError
     import pyroute2
 
 except ModuleNotFoundError:
@@ -269,6 +271,47 @@ def parse_extract_field(
     return str_skipped, data
 
 
+def parse_attributes(actstr, attributes):
+    """Parses actstr according to attribute description. attributes must be
+    a list of tuples (name, attribute, parse_func), e.g:
+        ("pid", OVS_USERSPACE_ATTR_PID, int)
+
+    Returns a list of parsed attributes followed by the remaining string.
+    """
+    attrs = []
+    for (key, attr, func) in attributes:
+        if not actstr.startswith(key):
+            continue
+
+        actstr = actstr[len(key) :]
+
+        if not func:
+            attrs.append([attr])
+            continue
+
+        # The length of complex attributes cannot be determined
+        # beforehand and must be reported by the parsing func.
+        delim = actstr[0]
+        actstr = actstr[1:]
+        if delim == "=":
+            pos = strcspn(actstr, ",)")
+            datum = func(actstr[:pos])
+        elif delim == "(":
+            datum, pos = func(actstr)
+
+        attrs.append([attr, datum])
+        actstr = actstr[pos:]
+
+        if delim == "(":
+            actstr = actstr[1:]
+
+        actstr = actstr[strspn(actstr, ", ") :]
+
+    if actstr[0] != ")":
+        raise ValueError("Action str: '%s' unbalanced" % actstr)
+
+    return attrs, actstr[1:]
+
 class ovs_dp_msg(genlmsg):
     # include the OVS version
     # We need a custom header rather than just being able to rely on
@@ -357,41 +400,19 @@ class ovsactions(nla):
                 percent = float(percent.strip('%'))
                 return int(math.floor(UINT32_MAX * (percent / 100.0) + .5))
 
-            for (key, attr, func) in (
+            attrs_desc = (
                 ("sample", "OVS_SAMPLE_ATTR_PROBABILITY", percent_to_rate),
                 ("group_id", "OVS_SAMPLE_ATTR_PSAMPLE_GROUP", int),
                 ("cookie", "OVS_SAMPLE_ATTR_PSAMPLE_COOKIE",
                     lambda x: list(bytearray.fromhex(x))),
                 ("actions", "OVS_SAMPLE_ATTR_ACTIONS", parse_nested_actions),
-            ):
-                if not actstr.startswith(key):
-                    continue
-
-                actstr = actstr[len(key) :]
-
-                if not func:
-                    self["attrs"].append([attr, None])
-                    continue
-
-                # The length of complex attributes cannot be determined
-                # beforehand and must be reported by the parsing func.
-                delim = actstr[0]
-                actstr = actstr[1:]
-                if delim == "=":
-                    pos = strcspn(actstr, ",)")
-                    datum = func(actstr[:pos])
-                elif delim == "(":
-                    datum, pos = func(actstr)
-
-                self["attrs"].append([attr, datum])
-                actstr = actstr[pos:]
-                actstr = actstr[strspn(actstr, ", ") :]
-
-            if actstr[0] != ")":
-                raise ValueError("Action str: '%s' unbalanced" % actstr)
+            )
 
-            return actstr[1:]
+            attrs, actstr = parse_attributes(actstr, attrs_desc)
+            for attr in attrs:
+                self["attrs"].append(attr)
 
+            return actstr
 
     class ctact(nla):
         nla_flags = NLA_F_NESTED
@@ -521,6 +542,18 @@ class ovsactions(nla):
             print_str += ")"
             return print_str
 
+        def parse(self, actstr):
+            attrs_desc = (
+                ("pid", "OVS_USERSPACE_ATTR_PID", int),
+                ("userdata", "OVS_USERSPACE_ATTR_USERDATA",
+                    lambda x: list(bytearray.fromhex(x))),
+                ("egress_tun_port", "OVS_USERSPACE_ATTR_EGRESS_TUN_PORT", int)
+            )
+            attrs, actstr = parse_attributes(actstr, attrs_desc)
+            for attr in attrs:
+                self["attrs"].append(attr)
+            return actstr
+
     def dpstr(self, more=False):
         print_str = ""
 
@@ -730,6 +763,11 @@ class ovsactions(nla):
                 self["attrs"].append(["OVS_ACTION_ATTR_SAMPLE", sampleact])
                 parsed = True
 
+            elif parse_starts_block(actstr, "userspace(", False):
+                uact = self.userspace()
+                actstr = uact.parse(actstr[len("userpsace(") : ])
+                self["attrs"].append(["OVS_ACTION_ATTR_USERSPACE", uact])
+                parsed = True
 
             actstr = actstr[strspn(actstr, ", ") :]
             while parencount > 0:
@@ -2112,10 +2150,70 @@ class OvsFlow(GenericNetlinkSocket):
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
@@ -2175,7 +2273,7 @@ def main(argv):
         help="Increment 'verbose' output counter.",
         default=0,
     )
-    subparsers = parser.add_subparsers()
+    subparsers = parser.add_subparsers(dest="subcommand")
 
     showdpcmd = subparsers.add_parser("show")
     showdpcmd.add_argument(
@@ -2232,6 +2330,8 @@ def main(argv):
     delfscmd = subparsers.add_parser("del-flows")
     delfscmd.add_argument("flsbr", help="Datapath name")
 
+    subparsers.add_parser("psample")
+
     args = parser.parse_args()
 
     if args.verbose > 0:
@@ -2246,6 +2346,9 @@ def main(argv):
 
     sys.setrecursionlimit(100000)
 
+    if args.subcommand == "psample":
+        Psample().read_samples()
+
     if hasattr(args, "showdp"):
         found = False
         for iface in ndb.interfaces:
-- 
2.44.0


