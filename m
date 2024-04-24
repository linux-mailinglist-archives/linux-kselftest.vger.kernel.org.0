Return-Path: <linux-kselftest+bounces-8772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E68B0BA8
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 15:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298A71C21A23
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADB915FA62;
	Wed, 24 Apr 2024 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Je8uenkB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B754715F40A
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966900; cv=none; b=rNmvvB9ad4EK6uz1+YPhagmVzIxC0N0LH5Go2OwNrJHDFrhrNsLgMmB+LC76nHqsH2s0tGbGBN9fOx0Kn+Zoo8bdIL3V4hEkQallL20AgIB06QQg0ETo4k/dg+Lda3F2r9Dt+NinGkp678xayrz482O8A7HYKLDUiERoCBcbMcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966900; c=relaxed/simple;
	bh=mCBdU1/Y+iR5BPM7dVWuIGMSVDs5uBgokHyUvZNcpYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWMW4G5nBGuTDQqyScYMUTkszKjz7j4uEdbDblELYRgEjd1+3bom4xZ8OoIzhLyumYO8HPNHT1dS4ucG4Ii8GFtk00HXK8iyTQLrVq4ajEUpPRGm+Bw6z/0jbkY/kp7rPO9IV1YnZz4lE1uGX2r5OOkH1H4XhpUYM3d/+KNT5L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Je8uenkB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713966897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8Yzpk3KTnFdMHRu4agPz/+OCowB+XjwxhNrbJUlANE=;
	b=Je8uenkBT/1lxDYl3GRx0Q82aXUMwiYo41v8StN2qNrpq7S8YFpmKFfUy0QNwhWcaPScuv
	eQo3bSgZir5GmhEB0B/+lnqe637AudijjYafODMLJ9xccix+jWJXkJGn+CikuUaURabssp
	49QsQg1L0JoThWyUhAfMOgTkZpWltnc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-gVewJ_sWPXmhNDPqLA0nCg-1; Wed,
 24 Apr 2024 09:54:54 -0400
X-MC-Unique: gVewJ_sWPXmhNDPqLA0nCg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC6F43C02B49;
	Wed, 24 Apr 2024 13:54:53 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ACE0E1C060D0;
	Wed, 24 Apr 2024 13:54:51 +0000 (UTC)
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
Subject: [PATCH net-next 7/8] selftests: openvswitch: add sample action.
Date: Wed, 24 Apr 2024 15:50:54 +0200
Message-ID: <20240424135109.3524355-8-amorenoz@redhat.com>
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

Add sample action support to ovs-dpctl.py.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 96 ++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 1dd057afd3fb..3a2dddc57e42 100644
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
@@ -285,7 +287,7 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_SET", "none"),
         ("OVS_ACTION_ATTR_PUSH_VLAN", "none"),
         ("OVS_ACTION_ATTR_POP_VLAN", "flag"),
-        ("OVS_ACTION_ATTR_SAMPLE", "none"),
+        ("OVS_ACTION_ATTR_SAMPLE", "sample"),
         ("OVS_ACTION_ATTR_RECIRC", "uint32"),
         ("OVS_ACTION_ATTR_HASH", "none"),
         ("OVS_ACTION_ATTR_PUSH_MPLS", "none"),
@@ -306,6 +308,91 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_DROP", "uint32"),
     )
 
+    class sample(nla):
+        nla_flags = NLA_F_NESTED
+
+        nla_map = (
+            ("OVS_SAMPLE_ATTR_UNSPEC", "none"),
+            ("OVS_SAMPLE_ATTR_PROBABILITY", "uint32"),
+            ("OVS_SAMPLE_ATTR_ACTIONS", "ovsactions"),
+            ("OVS_SAMPLE_ATTR_PSAMPLE_GROUP", "uint32"),
+            ("OVS_SAMPLE_ATTR_PSAMPLE_COOKIE", "array(uint8)"),
+        )
+
+        def dpstr(self, more=False):
+            args = []
+
+            args.append("sample={:.2f}%".format(
+                100 * self.get_attr("OVS_SAMPLE_ATTR_PROBABILITY") /
+                UINT32_MAX))
+
+            group = self.get_attr("OVS_SAMPLE_ATTR_PSAMPLE_GROUP")
+            cookie = self.get_attr("OVS_SAMPLE_ATTR_PSAMPLE_COOKIE")
+            actions = self.get_attr("OVS_SAMPLE_ATTR_ACTIONS")
+
+            if group:
+                args.append("group_id=%d" % group)
+            if cookie:
+                args.append("cookie=%s" %
+                            "".join(format(x, "02x") for x in cookie))
+            if actions:
+                args.append("actions(%s)" % actions.dpstr(more))
+
+            return "sample(%s)" % ",".join(args)
+
+        def parse(self, actstr):
+            """ Parses the input action string and populates the internal
+            attributes. The input string must start with "sample("
+
+            Returns the remaining action string.
+            Raises ValueError if the action string has invalid content.
+            """
+
+            def parse_nested_actions(actstr):
+                subacts = ovsactions()
+                parsed_len = subacts.parse(actstr)
+                return subacts, parsed_len
+
+            def percent_to_rate(percent):
+                percent = float(percent.strip('%'))
+                return int(math.floor(UINT32_MAX * (percent / 100.0) + .5))
+
+            for (key, attr, func) in (
+                ("sample", "OVS_SAMPLE_ATTR_PROBABILITY", percent_to_rate),
+                ("group_id", "OVS_SAMPLE_ATTR_PSAMPLE_GROUP", int),
+                ("cookie", "OVS_SAMPLE_ATTR_PSAMPLE_COOKIE",
+                    lambda x: list(bytearray.fromhex(x))),
+                ("actions", "OVS_SAMPLE_ATTR_ACTIONS", parse_nested_actions),
+            ):
+                if not actstr.startswith(key):
+                    continue
+
+                actstr = actstr[len(key) :]
+
+                if not func:
+                    self["attrs"].append([attr, None])
+                    continue
+
+                # The length of complex attributes cannot be determined
+                # beforehand and must be reported by the parsing func.
+                delim = actstr[0]
+                actstr = actstr[1:]
+                if delim == "=":
+                    pos = strcspn(actstr, ",)")
+                    datum = func(actstr[:pos])
+                elif delim == "(":
+                    datum, pos = func(actstr)
+
+                self["attrs"].append([attr, datum])
+                actstr = actstr[pos:]
+                actstr = actstr[strspn(actstr, ", ") :]
+
+            if actstr[0] != ")":
+                raise ValueError("Action str: '%s' unbalanced" % actstr)
+
+            return actstr[1:]
+
+
     class ctact(nla):
         nla_flags = NLA_F_NESTED
 
@@ -637,6 +724,13 @@ class ovsactions(nla):
                 self["attrs"].append(["OVS_ACTION_ATTR_CT", ctact])
                 parsed = True
 
+            elif parse_starts_block(actstr, "sample(", False):
+                sampleact = self.sample()
+                actstr = sampleact.parse(actstr[len("sample(") : ])
+                self["attrs"].append(["OVS_ACTION_ATTR_SAMPLE", sampleact])
+                parsed = True
+
+
             actstr = actstr[strspn(actstr, ", ") :]
             while parencount > 0:
                 parencount -= 1
-- 
2.44.0


