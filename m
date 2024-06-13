Return-Path: <linux-kselftest+bounces-11888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BD4907AC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 20:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDA11C22D10
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E7214D6E6;
	Thu, 13 Jun 2024 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jq06gSyn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95DA14C585
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302435; cv=none; b=mx2pI637OOmxSiRQa44NG1faDlKRRbVWKA2UtjUFpOe5RUYJ8Mpy+WNqN78k/yd9d1gQ40PxGcget4HrNuGpWSIZ9YvBG8y8HGZLvmLtDnakoMp2BT8bA32HVMrcYgsW0ove64siB4wies43mZLKK17hQWDUJlvXOPv1rGLWoIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302435; c=relaxed/simple;
	bh=Qd5u1VNEmmAUNWYDzyFe1yeh0le3RfrFKG3DD/XMoV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWvtacaCWIU1oB7l4ZU/FTmhUsVQ5UHInbBDEV9t3Dlg7wNJI6OS4g1djru8HVWkmHMz8AYvz/kmmzdtpSXF+vh4u9yXOZGcRf19N27wy7GGeF8zfdFxf5QOi8YakkR0xlZc+KjNYI21yVwIZspAKBTZ0ZBm8SadWBB7fB/lG54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jq06gSyn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718302432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1DTCC+VeXSrnYKaDnRa/SwzX4CVCWfv53BM9LOymus=;
	b=Jq06gSyn3tLUas+aYdBxQRCrf66JsYRgBHl0vvL2+ZPxtk2EBOd2GcJ1wGrY8OsxBqj4bD
	1rUFlGrCK2QYXQfsShnAbFfS7wTSt4oIU5wO+KI71zpKbaUyhWOanuruX1TAibSWU2ca37
	NXwt3lMi2x+quPIKvi+SuLlrQLMXVdo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-Dgva154XMx6Pw-xFcVdugw-1; Thu,
 13 Jun 2024 14:13:49 -0400
X-MC-Unique: Dgva154XMx6Pw-xFcVdugw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B73E2195609F;
	Thu, 13 Jun 2024 18:13:47 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.16.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACDEC19560BF;
	Thu, 13 Jun 2024 18:13:44 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Adrian Moreno <amorenoz@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [RFC net-next 3/7] selftests: openvswitch: Add set() and set_masked() support.
Date: Thu, 13 Jun 2024 14:13:29 -0400
Message-ID: <20240613181333.984810-4-aconole@redhat.com>
In-Reply-To: <20240613181333.984810-1-aconole@redhat.com>
References: <20240613181333.984810-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

These will be used in upcoming commits to set specific attributes for
interacting with tunnels.  Since set() will use the key parsing routine, we
also make sure to prepend it with an open paren, for the action parsing to
properly understand it.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 39 +++++++++++++++++--
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 73768f3af6e5..fee64c31d4d4 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -284,7 +284,7 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_UNSPEC", "none"),
         ("OVS_ACTION_ATTR_OUTPUT", "uint32"),
         ("OVS_ACTION_ATTR_USERSPACE", "userspace"),
-        ("OVS_ACTION_ATTR_SET", "none"),
+        ("OVS_ACTION_ATTR_SET", "ovskey"),
         ("OVS_ACTION_ATTR_PUSH_VLAN", "none"),
         ("OVS_ACTION_ATTR_POP_VLAN", "flag"),
         ("OVS_ACTION_ATTR_SAMPLE", "none"),
@@ -292,7 +292,7 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_HASH", "none"),
         ("OVS_ACTION_ATTR_PUSH_MPLS", "none"),
         ("OVS_ACTION_ATTR_POP_MPLS", "flag"),
-        ("OVS_ACTION_ATTR_SET_MASKED", "none"),
+        ("OVS_ACTION_ATTR_SET_MASKED", "ovskey"),
         ("OVS_ACTION_ATTR_CT", "ctact"),
         ("OVS_ACTION_ATTR_TRUNC", "uint32"),
         ("OVS_ACTION_ATTR_PUSH_ETH", "none"),
@@ -469,6 +469,14 @@ class ovsactions(nla):
                     print_str += "clone("
                     print_str += datum.dpstr(more)
                     print_str += ")"
+                elif field[0] == "OVS_ACTION_ATTR_SET" or \
+                     field[0] == "OVS_ACTION_ATTR_SET_MASKED":
+                    print_str += "set"
+                    if field[0] == "OVS_ACTION_ATTR_SET_MASKED":
+                        print_str += "_masked"
+                    print_str += "("
+                    print_str += datum.dpstr(more)
+                    print_str += ")"
                 else:
                     try:
                         print_str += datum.dpstr(more)
@@ -547,6 +555,25 @@ class ovsactions(nla):
                 self["attrs"].append(("OVS_ACTION_ATTR_CLONE", subacts))
                 actstr = actstr[parsedLen:]
                 parsed = True
+            elif parse_starts_block(actstr, "set(", False):
+                parencount += 1
+                k = ovskey()
+                actstr = actstr[len("set("):]
+                actstr = k.parse(actstr, None)
+                self["attrs"].append(("OVS_ACTION_ATTR_SET", k))
+                if not actstr.startswith(")"):
+                    actstr = ")" + actstr
+                parsed = True
+            elif parse_starts_block(actstr, "set_masked(", False):
+                parencount += 1
+                k = ovskey()
+                m = ovskey()
+                actstr = actstr[len("set_masked("):]
+                actstr = k.parse(actstr, m)
+                self["attrs"].append(("OVS_ACTION_ATTR_SET_MASKED", [k, m]))
+                if not actstr.startswith(")"):
+                    actstr = ")" + actstr
+                parsed = True
             elif parse_starts_block(actstr, "ct(", False):
                 parencount += 1
                 actstr = actstr[len("ct(") :]
@@ -1312,7 +1339,7 @@ class ovskey(nla):
                 mask["attrs"].append([field[0], m])
             self["attrs"].append([field[0], k])
 
-            flowstr = flowstr[strspn(flowstr, "),") :]
+            flowstr = flowstr[strspn(flowstr, "), ") :]
 
         return flowstr
 
@@ -1898,7 +1925,11 @@ class OvsFlow(GenericNetlinkSocket):
             ):
                 print_str += "drop"
             else:
-                print_str += actsmsg.dpstr(more)
+                if type(actsmsg) == "list":
+                    for act in actsmsg:
+                        print_str += act.dpstr(more)
+                else:
+                    print_str += actsmsg.dpstr(more)
 
             return print_str
 
-- 
2.45.1


