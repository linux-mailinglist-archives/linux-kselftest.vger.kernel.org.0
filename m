Return-Path: <linux-kselftest+bounces-4237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F60B84CB82
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 14:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019DB28F5B8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D5977F0A;
	Wed,  7 Feb 2024 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWCUJRTv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2911776C9F
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312268; cv=none; b=R0+GfLpdnZNbbSVMtUt05kEONDYh1szRfG1yVMawTr3ZhKYEDEhoCgkmLW+jVjZGTjzoUUN5pn+oyXOw5zCR6GcapIoSiwCOAHrjAqFuEdDaMXxqjrvx4ijNx1MNIqiIVjASQZhAUBgEtsB6VIz+pRLs8YuPdR00q47D5iWbt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312268; c=relaxed/simple;
	bh=FeMpcn8QBPEFQV4wy1pLHbUGi4q1Dj3J0PPgQc8WLUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=To1L7KuiTms4lW3cmUfZjEMfbx1ZIBeYNZrbLlHmOV0AN6ND3JdXIRsARxiESP/HXa0iqumyYtmFBsfu049fdKhdb9xO+QMJqMPKgDziZWllC6hNAIeXVDYNS4bc9M2aByLqPzw5nJVmkxPsXCI3LjFi8glfAgK7nofjZsGZBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWCUJRTv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707312265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OxSYX4PAe9pxNkqRj3ppoPwfVbj8rfraFlr2ccR+INA=;
	b=gWCUJRTvLcMPiVq8jCg+Qlgx2RQGRfwdcZk1fGuyAIeB+/OeHKakEYKRSOWW0Xh39sTkek
	4uA1GvNmhBh8Nx46+12KuyMMyUPRRJM3uXSHO+OHKofl9w9FU+B9k3QCBF6Ej/J/DCV3qt
	iVJOg/dCrxg0mXMrfw6yC+6RrDHmnjo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-oznH7XgcM-mQR9M1esVUSg-1; Wed, 07 Feb 2024 08:24:19 -0500
X-MC-Unique: oznH7XgcM-mQR9M1esVUSg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2BDF84AEF8;
	Wed,  7 Feb 2024 13:24:18 +0000 (UTC)
Received: from RHTPC1VM0NT.bos.redhat.com (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 20616AC18;
	Wed,  7 Feb 2024 13:24:18 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	dev@openvswitch.org,
	Ilya Maximets <i.maximets@ovn.org>,
	Simon Horman <horms@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	andy zhou <azhou@ovn.org>
Subject: [PATCH net v2 2/2] selftests: openvswitch: Add validation for the recursion test
Date: Wed,  7 Feb 2024 08:24:16 -0500
Message-ID: <20240207132416.1488485-3-aconole@redhat.com>
In-Reply-To: <20240207132416.1488485-1-aconole@redhat.com>
References: <20240207132416.1488485-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Add a test case into the netlink checks that will show the number of
nested action recursions won't exceed 16.  Going to 17 on a small
clone call isn't enough to exhaust the stack on (most) systems, so
it should be safe to run even on systems that don't have the fix
applied.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
v1->v2: Used a slightly more portable io redirection semantic for the
        clone() flow test case.

 .../selftests/net/openvswitch/openvswitch.sh  | 13 ++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 71 +++++++++++++++----
 2 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index f8499d4c87f3..36e40256ab92 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -502,7 +502,20 @@ test_netlink_checks () {
 	    wc -l) == 2 ] || \
 	      return 1
 
+	info "Checking clone depth"
 	ERR_MSG="Flow actions may not be safe on all matching packets"
+	PRE_TEST=$(dmesg | grep -c "${ERR_MSG}")
+	ovs_add_flow "test_netlink_checks" nv0 \
+		'in_port(1),eth(),eth_type(0x800),ipv4()' \
+		'clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(drop)))))))))))))))))' \
+		>/dev/null 2>&1 && return 1
+	POST_TEST=$(dmesg | grep -c "${ERR_MSG}")
+
+	if [ "$PRE_TEST" == "$POST_TEST" ]; then
+		info "failed - clone depth too large"
+		return 1
+	fi
+
 	PRE_TEST=$(dmesg | grep -c "${ERR_MSG}")
 	ovs_add_flow "test_netlink_checks" nv0 \
 		'in_port(1),eth(),eth_type(0x0806),arp()' 'drop(0),2' \
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index b97e621face9..5e0e539a323d 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -299,7 +299,7 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_PUSH_NSH", "none"),
         ("OVS_ACTION_ATTR_POP_NSH", "flag"),
         ("OVS_ACTION_ATTR_METER", "none"),
-        ("OVS_ACTION_ATTR_CLONE", "none"),
+        ("OVS_ACTION_ATTR_CLONE", "recursive"),
         ("OVS_ACTION_ATTR_CHECK_PKT_LEN", "none"),
         ("OVS_ACTION_ATTR_ADD_MPLS", "none"),
         ("OVS_ACTION_ATTR_DEC_TTL", "none"),
@@ -465,29 +465,42 @@ class ovsactions(nla):
                     print_str += "pop_mpls"
             else:
                 datum = self.get_attr(field[0])
-                print_str += datum.dpstr(more)
+                if field[0] == "OVS_ACTION_ATTR_CLONE":
+                    print_str += "clone("
+                    print_str += datum.dpstr(more)
+                    print_str += ")"
+                else:
+                    print_str += datum.dpstr(more)
 
         return print_str
 
     def parse(self, actstr):
+        totallen = len(actstr)
         while len(actstr) != 0:
             parsed = False
+            parencount = 0
             if actstr.startswith("drop"):
                 # If no reason is provided, the implicit drop is used (i.e no
                 # action). If some reason is given, an explicit action is used.
-                actstr, reason = parse_extract_field(
-                    actstr,
-                    "drop(",
-                    "([0-9]+)",
-                    lambda x: int(x, 0),
-                    False,
-                    None,
-                )
+                reason = None
+                if actstr.startswith("drop("):
+                    parencount += 1
+
+                    actstr, reason = parse_extract_field(
+                        actstr,
+                        "drop(",
+                        "([0-9]+)",
+                        lambda x: int(x, 0),
+                        False,
+                        None,
+                    )
+
                 if reason is not None:
                     self["attrs"].append(["OVS_ACTION_ATTR_DROP", reason])
                     parsed = True
                 else:
-                    return
+                    actstr = actstr[len("drop"): ]
+                    return (totallen - len(actstr))
 
             elif parse_starts_block(actstr, "^(\d+)", False, True):
                 actstr, output = parse_extract_field(
@@ -504,6 +517,7 @@ class ovsactions(nla):
                     False,
                     0,
                 )
+                parencount += 1
                 self["attrs"].append(["OVS_ACTION_ATTR_RECIRC", recircid])
                 parsed = True
 
@@ -516,12 +530,22 @@ class ovsactions(nla):
 
             for flat_act in parse_flat_map:
                 if parse_starts_block(actstr, flat_act[0], False):
-                    actstr += len(flat_act[0])
+                    actstr = actstr[len(flat_act[0]):]
                     self["attrs"].append([flat_act[1]])
                     actstr = actstr[strspn(actstr, ", ") :]
                     parsed = True
 
-            if parse_starts_block(actstr, "ct(", False):
+            if parse_starts_block(actstr, "clone(", False):
+                parencount += 1
+                subacts = ovsactions()
+                actstr = actstr[len("clone("):]
+                parsedLen = subacts.parse(actstr)
+                lst = []
+                self["attrs"].append(("OVS_ACTION_ATTR_CLONE", subacts))
+                actstr = actstr[parsedLen:]
+                parsed = True
+            elif parse_starts_block(actstr, "ct(", False):
+                parencount += 1
                 actstr = actstr[len("ct(") :]
                 ctact = ovsactions.ctact()
 
@@ -553,6 +577,7 @@ class ovsactions(nla):
                         natact = ovsactions.ctact.natattr()
 
                         if actstr.startswith("("):
+                            parencount += 1
                             t = None
                             actstr = actstr[1:]
                             if actstr.startswith("src"):
@@ -607,15 +632,29 @@ class ovsactions(nla):
                                     actstr = actstr[strspn(actstr, ", ") :]
 
                         ctact["attrs"].append(["OVS_CT_ATTR_NAT", natact])
-                        actstr = actstr[strspn(actstr, ",) ") :]
+                        actstr = actstr[strspn(actstr, ", ") :]
 
                 self["attrs"].append(["OVS_ACTION_ATTR_CT", ctact])
                 parsed = True
 
-            actstr = actstr[strspn(actstr, "), ") :]
+            actstr = actstr[strspn(actstr, ", ") :]
+            while parencount > 0:
+                parencount -= 1
+                actstr = actstr[strspn(actstr, " "):]
+                if len(actstr) and actstr[0] != ")":
+                    raise ValueError("Action str: '%s' unbalanced" % actstr)
+                actstr = actstr[1:]
+
+            if len(actstr) and actstr[0] == ")":
+                return (totallen - len(actstr))
+
+            actstr = actstr[strspn(actstr, ", ") :]
+
             if not parsed:
                 raise ValueError("Action str: '%s' not supported" % actstr)
 
+        return (totallen - len(actstr))
+
 
 class ovskey(nla):
     nla_flags = NLA_F_NESTED
@@ -2111,6 +2150,8 @@ def main(argv):
     ovsflow = OvsFlow()
     ndb = NDB()
 
+    sys.setrecursionlimit(100000)
+
     if hasattr(args, "showdp"):
         found = False
         for iface in ndb.interfaces:
-- 
2.41.0


