Return-Path: <linux-kselftest+bounces-12746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989D59172C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 22:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C211C20FFC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 20:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5D7183063;
	Tue, 25 Jun 2024 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRaaw5QN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0835181D11
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348795; cv=none; b=im02cAwMwzhsOBZfjdYE6HDiSWFZctIpSi/9qb7kQwmX//mqX6/VCQfC3ePjvcSCrG51wrsqI88iafdDD2XjAOphSdyjbuiq73+X3Seh7419VK3K4lWFi8+Q+q9hORFWAZK1O+di6Vpgsc9VPG4fKeqLvqiqv91H9FGO3SVbW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348795; c=relaxed/simple;
	bh=mtBJ/V1IIRB4mNznMgJ2S7o2Tvjn+KPcNGhQmZODsJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLtZ/2AEEd3EOpMU2oidqreMjaxwyRlWbA2f6IRAesy6cW+1e0B7J/aW7ks0g+/DpPyO/dvLdVnRWRVsQS6AfrZYUnGF/Z5x2VLB3iPbfnpq0yJ0LzqgJ2UXFQvHyKVtnQq8ETccyFC/w1IpZf+kI34t+vGgSRw3cOPXRE3eE0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XRaaw5QN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719348792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcAs18J6BrHJ+tKKq/UE15hx5Fffl3E+01zCrNA89yQ=;
	b=XRaaw5QNiCGhNQh7oRcNPoagesI4u61FhO+z3RSsXqY48JyhPcXB7SA7+bYjCe61vzXprD
	rYhx3BjstuLHvF6aLV6IZgRpF6Mrd4amg6mWHUlkHSzzeLFLiymk3Cczua0BI8SL8tpDBB
	Esw2bsbuLuk9xhSojGx+EnEeJjV0eRY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-oHnlsvrwMg-zmpdW90uHJg-1; Tue,
 25 Jun 2024 16:53:09 -0400
X-MC-Unique: oHnlsvrwMg-zmpdW90uHJg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E47C1955E7E;
	Tue, 25 Jun 2024 20:53:07 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.93])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2870B19560BF;
	Tue, 25 Jun 2024 20:53:01 +0000 (UTC)
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
Subject: [PATCH net-next v5 08/10] selftests: openvswitch: add userspace parsing
Date: Tue, 25 Jun 2024 22:51:51 +0200
Message-ID: <20240625205204.3199050-9-amorenoz@redhat.com>
In-Reply-To: <20240625205204.3199050-1-amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The userspace action lacks parsing support plus it contains a bug in the
name of one of its attributes.

This patch makes userspace action work.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index ddf4d999317c..071309289cff 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -575,13 +575,27 @@ class ovsactions(nla):
                 print_str += "userdata="
                 for f in self.get_attr("OVS_USERSPACE_ATTR_USERDATA"):
                     print_str += "%x." % f
-            if self.get_attr("OVS_USERSPACE_ATTR_TUN_PORT") is not None:
+            if self.get_attr("OVS_USERSPACE_ATTR_EGRESS_TUN_PORT") is not None:
                 print_str += "egress_tun_port=%d" % self.get_attr(
-                    "OVS_USERSPACE_ATTR_TUN_PORT"
+                    "OVS_USERSPACE_ATTR_EGRESS_TUN_PORT"
                 )
             print_str += ")"
             return print_str
 
+        def parse(self, actstr):
+            attrs_desc = (
+                ("pid", "OVS_USERSPACE_ATTR_PID", int),
+                ("userdata", "OVS_USERSPACE_ATTR_USERDATA",
+                    lambda x: list(bytearray.fromhex(x))),
+                ("egress_tun_port", "OVS_USERSPACE_ATTR_EGRESS_TUN_PORT", int)
+            )
+
+            attrs, actstr = parse_attrs(actstr, attrs_desc)
+            for attr in attrs:
+                self["attrs"].append(attr)
+
+            return actstr
+
     def dpstr(self, more=False):
         print_str = ""
 
@@ -797,6 +811,12 @@ class ovsactions(nla):
                 self["attrs"].append(["OVS_ACTION_ATTR_EMIT_SAMPLE", emitact])
                 parsed = True
 
+            elif parse_starts_block(actstr, "userspace(", False):
+                uact = self.userspace()
+                actstr = uact.parse(actstr[len("userspace(") : ])
+                self["attrs"].append(["OVS_ACTION_ATTR_USERSPACE", uact])
+                parsed = True
+
             actstr = actstr[strspn(actstr, ", ") :]
             while parencount > 0:
                 parencount -= 1
-- 
2.45.1


