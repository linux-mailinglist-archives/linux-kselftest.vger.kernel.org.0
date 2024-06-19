Return-Path: <linux-kselftest+bounces-12269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C9B90F806
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 23:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133D11C21E9C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 21:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0983315B106;
	Wed, 19 Jun 2024 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRYmaQFd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522DA15B111
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830873; cv=none; b=C2WSoPuPRMxjR5nto3q8oXTlk6j2zQwmc6dF3FOy7NdX0Se/i0AOTXnNSZ5f8VraphzCbOrN9k+XosqeSc7jy860f4oFQjFceSQo4KRGd1MCYUUelynjjPxyo+6qMh62YNZSa/B0FPyHzXUMqgHLHu477f2A0Wa80RUwCWO/vcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830873; c=relaxed/simple;
	bh=bZJzFlWdq5tOtSuEnluAcwCs3WkVItltB8uWupLS0TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DN6UBpfmpkQ0PE2vI/LVikQ2eih4qe/UK3i4mmBotVP+UXYTpRbkskgOyqu1+Xq/TplwPu+onjNWtxLV9cO152ITtoF+5o9DIm1gDAumQ1TcFgKP+nKLz8msjQxEt1rYgaBlccJZp5chEThkwlPzIkt4mxckxpv4esPW+V8M/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRYmaQFd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718830871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nt6EMOIKSwMdU1Up5vcgl1cAO7/Q9VkkafvHEpfjgCA=;
	b=IRYmaQFdkkGfwG5awrcQUUT/ssGsgGrlk6P2n1ogfFutNU/pg/wPvi++MYEUIbSmt2A+qf
	TvnBFls7fjTkDDp0+sn1/fkCnNNRWIV7a1ym6GXXWLyAccP3nnKn7QVLOeDq+vvaLDdw2x
	JnokGKOI/jpOCy8KcruZxSr6dYPpc9w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-ASAh7qqSPMyQXsSs8Pc4IA-1; Wed,
 19 Jun 2024 17:01:07 -0400
X-MC-Unique: ASAh7qqSPMyQXsSs8Pc4IA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67F9D19560AE;
	Wed, 19 Jun 2024 21:01:05 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.189])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2567F19560AE;
	Wed, 19 Jun 2024 21:01:00 +0000 (UTC)
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
Subject: [PATCH net-next v3 07/10] selftests: openvswitch: add emit_sample action
Date: Wed, 19 Jun 2024 23:00:08 +0200
Message-ID: <20240619210023.982698-8-amorenoz@redhat.com>
In-Reply-To: <20240619210023.982698-1-amorenoz@redhat.com>
References: <20240619210023.982698-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add sample and emit_sample action support to ovs-dpctl.py.

Refactor common attribute parsing logic into an external function.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 162 +++++++++++++++++-
 1 file changed, 161 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 1dd057afd3fb..beb2499b7126 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -8,6 +8,7 @@ import argparse
 import errno
 import ipaddress
 import logging
+import math
 import multiprocessing
 import re
 import struct
@@ -58,6 +59,7 @@ OVS_FLOW_CMD_DEL = 2
 OVS_FLOW_CMD_GET = 3
 OVS_FLOW_CMD_SET = 4
 
+UINT32_MAX = 0xFFFFFFFF
 
 def macstr(mac):
     outstr = ":".join(["%02X" % i for i in mac])
@@ -267,6 +269,75 @@ def parse_extract_field(
     return str_skipped, data
 
 
+def parse_attrs(actstr, attr_desc):
+    """Parses the given action string and returns a list of netlink
+    attributes based on a list of attribute descriptions.
+
+    Each element in the attribute description list is a tuple such as:
+        (name, attr_name, parse_func)
+    where:
+        name: is the string representing the attribute
+        attr_name: is the name of the attribute as defined in the uAPI.
+        parse_func: is a callable accepting a string and returning either
+            a single object (the parsed attribute value) or a tuple of
+            two values (the parsed attribute value and the remaining string)
+
+    Returns a list of attributes and the remaining string.
+    """
+    def parse_attr(actstr, key, func):
+        actstr = actstr[len(key) :]
+
+        if not func:
+            return None, actstr
+
+        delim = actstr[0]
+        actstr = actstr[1:]
+
+        if delim == "=":
+            pos = strcspn(actstr, ",)")
+            ret = func(actstr[:pos])
+        else:
+            ret = func(actstr)
+
+        if isinstance(ret, tuple):
+            (datum, actstr) = ret
+        else:
+            datum = ret
+            actstr = actstr[strcspn(actstr, ",)"):]
+
+        if delim == "(":
+            if not actstr or actstr[0] != ")":
+                raise ValueError("Action contains unbalanced parentheses")
+
+            actstr = actstr[1:]
+
+        actstr = actstr[strspn(actstr, ", ") :]
+
+        return datum, actstr
+
+    attrs = []
+    attr_desc = list(attr_desc)
+    while actstr and actstr[0] != ")" and attr_desc:
+        found = False
+        for i, (key, attr, func) in enumerate(attr_desc):
+            if actstr.startswith(key):
+                datum, actstr = parse_attr(actstr, key, func)
+                attrs.append([attr, datum])
+                found = True
+                del attr_desc[i]
+
+        if not found:
+            raise ValueError("Unknown attribute: '%s'" % actstr)
+
+        actstr = actstr[strspn(actstr, ", ") :]
+
+    if actstr[0] != ")":
+        raise ValueError("Action string contains extra garbage or has "
+                         "unbalanced parenthesis: '%s'" % actstr)
+
+    return attrs, actstr[1:]
+
+
 class ovs_dp_msg(genlmsg):
     # include the OVS version
     # We need a custom header rather than just being able to rely on
@@ -285,7 +356,7 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_SET", "none"),
         ("OVS_ACTION_ATTR_PUSH_VLAN", "none"),
         ("OVS_ACTION_ATTR_POP_VLAN", "flag"),
-        ("OVS_ACTION_ATTR_SAMPLE", "none"),
+        ("OVS_ACTION_ATTR_SAMPLE", "sample"),
         ("OVS_ACTION_ATTR_RECIRC", "uint32"),
         ("OVS_ACTION_ATTR_HASH", "none"),
         ("OVS_ACTION_ATTR_PUSH_MPLS", "none"),
@@ -304,8 +375,85 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_ADD_MPLS", "none"),
         ("OVS_ACTION_ATTR_DEC_TTL", "none"),
         ("OVS_ACTION_ATTR_DROP", "uint32"),
+        ("OVS_ACTION_ATTR_EMIT_SAMPLE", "emit_sample"),
     )
 
+    class emit_sample(nla):
+        nla_flags = NLA_F_NESTED
+
+        nla_map = (
+            ("OVS_EMIT_SAMPLE_ATTR_UNSPEC", "none"),
+            ("OVS_EMIT_SAMPLE_ATTR_GROUP", "uint32"),
+            ("OVS_EMIT_SAMPLE_ATTR_COOKIE", "array(uint8)"),
+        )
+
+        def dpstr(self, more=False):
+            args = "group=%d" % self.get_attr("OVS_EMIT_SAMPLE_ATTR_GROUP")
+
+            cookie = self.get_attr("OVS_EMIT_SAMPLE_ATTR_COOKIE")
+            if cookie:
+                args += ",cookie(%s)" % \
+                        "".join(format(x, "02x") for x in cookie)
+
+            return "emit_sample(%s)" % args
+
+        def parse(self, actstr):
+            desc = (
+                ("group", "OVS_EMIT_SAMPLE_ATTR_GROUP", int),
+                ("cookie", "OVS_EMIT_SAMPLE_ATTR_COOKIE",
+                    lambda x: list(bytearray.fromhex(x)))
+            )
+
+            attrs, actstr = parse_attrs(actstr, desc)
+
+            for attr in attrs:
+                self["attrs"].append(attr)
+
+            return actstr
+
+    class sample(nla):
+        nla_flags = NLA_F_NESTED
+
+        nla_map = (
+            ("OVS_SAMPLE_ATTR_UNSPEC", "none"),
+            ("OVS_SAMPLE_ATTR_PROBABILITY", "uint32"),
+            ("OVS_SAMPLE_ATTR_ACTIONS", "ovsactions"),
+        )
+
+        def dpstr(self, more=False):
+            args = []
+
+            args.append("sample={:.2f}%".format(
+                100 * self.get_attr("OVS_SAMPLE_ATTR_PROBABILITY") /
+                UINT32_MAX))
+
+            actions = self.get_attr("OVS_SAMPLE_ATTR_ACTIONS")
+            if actions:
+                args.append("actions(%s)" % actions.dpstr(more))
+
+            return "sample(%s)" % ",".join(args)
+
+        def parse(self, actstr):
+            def parse_nested_actions(actstr):
+                subacts = ovsactions()
+                parsed_len = subacts.parse(actstr)
+                return subacts, actstr[parsed_len :]
+
+            def percent_to_rate(percent):
+                percent = float(percent.strip('%'))
+                return int(math.floor(UINT32_MAX * (percent / 100.0) + .5))
+
+            desc = (
+                ("sample", "OVS_SAMPLE_ATTR_PROBABILITY", percent_to_rate),
+                ("actions", "OVS_SAMPLE_ATTR_ACTIONS", parse_nested_actions),
+            )
+            attrs, actstr = parse_attrs(actstr, desc)
+
+            for attr in attrs:
+                self["attrs"].append(attr)
+
+            return actstr
+
     class ctact(nla):
         nla_flags = NLA_F_NESTED
 
@@ -637,6 +785,18 @@ class ovsactions(nla):
                 self["attrs"].append(["OVS_ACTION_ATTR_CT", ctact])
                 parsed = True
 
+            elif parse_starts_block(actstr, "sample(", False):
+                sampleact = self.sample()
+                actstr = sampleact.parse(actstr[len("sample(") : ])
+                self["attrs"].append(["OVS_ACTION_ATTR_SAMPLE", sampleact])
+                parsed = True
+
+            elif parse_starts_block(actstr, "emit_sample(", False):
+                emitact = self.emit_sample()
+                actstr = emitact.parse(actstr[len("emit_sample(") : ])
+                self["attrs"].append(["OVS_ACTION_ATTR_EMIT_SAMPLE", emitact])
+                parsed = True
+
             actstr = actstr[strspn(actstr, ", ") :]
             while parencount > 0:
                 parencount -= 1
-- 
2.45.1


