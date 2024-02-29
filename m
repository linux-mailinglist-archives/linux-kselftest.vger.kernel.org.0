Return-Path: <linux-kselftest+bounces-5648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FB686CDE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 16:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDF81F22D88
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CF313C9D4;
	Thu, 29 Feb 2024 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWQ+0V0w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37313C9CB;
	Thu, 29 Feb 2024 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221805; cv=none; b=hFLl+DEMrAu3O6kKAqFJTH+h9iefO9+xPr39vP90OxgDvyG84tiaxFnI5PRjNnYJjvHU3XjTOiE9U9qZPnc2t+WG1KmM8JiUTxieNyl/uvtDtTTmXwKqesowuxwca/RrIcViMGqhu1maxL5MGZA57+fYf2zOt8k1iW4ofXmVaHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221805; c=relaxed/simple;
	bh=fAometgkYT+8afRTn5I8qtc/WQf0RndWwBfG1rn1ejA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMtZ3gyAwsT3Sq6rlZQ4HEQNT2R04hjwQIINKrAveRROJyA3JCNHCX8oUKQkXiHSkHDJzvYaVZPS9J/pCapbQmoDCASKQevCfSH0vmWT7YThlYsUvJMRSW0Dm+812eOtXTowwW93lblQJM20oo96jKHZpbc9wfbzes9tcn4Ar+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWQ+0V0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC38C43390;
	Thu, 29 Feb 2024 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221804;
	bh=fAometgkYT+8afRTn5I8qtc/WQf0RndWwBfG1rn1ejA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FWQ+0V0wD+vMs7qysCKkpz9tJSVtcp4jI2ptVY8Nd10g8BXm8W+rHOkLJN1SpoeK4
	 Jod/oM1yGlye8Mu0dcweZjdBJV34c6fSVrHfLNowFQu4eWLJN0yH8NfmHWYADPML20
	 bcK8A3LkQIJ7Bn3IbdD7WaKl0CeQx68hOYl1CmpQfuAorFleYCTW3R7AzV74e5v2qy
	 qfjapjRh2zTXAszIDwYkLQBOA78YBeNSvI8NxI81kCu4eRVXfsKNQs+I2z98hJNZei
	 lgTXfjN/sj6wOT8wzTb7LW0wLnp/PO4HYsLzfDi9R+fcJjYQVt7gGUql/E8fY042be
	 IJvqP0BqPdxEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pshelar@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/21] selftests: openvswitch: Add validation for the recursion test
Date: Thu, 29 Feb 2024 10:49:29 -0500
Message-ID: <20240229154946.2850012-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
Content-Transfer-Encoding: 8bit

From: Aaron Conole <aconole@redhat.com>

[ Upstream commit bd128f62c365504e1268dc09fcccdfb1f091e93a ]

Add a test case into the netlink checks that will show the number of
nested action recursions won't exceed 16.  Going to 17 on a small
clone call isn't enough to exhaust the stack on (most) systems, so
it should be safe to run even on systems that don't have the fix
applied.

Signed-off-by: Aaron Conole <aconole@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240207132416.1488485-3-aconole@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 13 ++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 71 +++++++++++++++----
 2 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index f8499d4c87f3f..36e40256ab92a 100755
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
index b97e621face95..5e0e539a323d5 100644
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
2.43.0


