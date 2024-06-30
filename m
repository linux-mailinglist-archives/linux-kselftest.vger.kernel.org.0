Return-Path: <linux-kselftest+bounces-12976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8236E91D3A9
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jun 2024 22:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14D81C20B8F
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jun 2024 20:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B6C159217;
	Sun, 30 Jun 2024 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHj9GnpE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0E1591EA
	for <linux-kselftest@vger.kernel.org>; Sun, 30 Jun 2024 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719777521; cv=none; b=Pg+Dj/jx5K1adY+S4H5wBce4Cs9zkfAf3fq3kTzIgBlMcaoJbkVx0OZzWEXEpQua7siRNgpgR0DRS8NcbAHerRjqiq0eAWOjJFIPd/3S9dVC9mU0ZPHarMkglAyn6W28FGkAgNiliJkHItcBDazQVd9LpALBOHYF4Zf+YItgMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719777521; c=relaxed/simple;
	bh=63bBIccLav1z63Ib7vKoFDX/loI9AtZLjy4hLLc51nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSeqZqxCLelNQUt5YJoKATRTxAcg07UWkjvWuzCjS8wXqDxpY8SFJxT+ZMFdCccmlnGs0vo6Ny9eCrdi+Dzoh7QeF1orUEQqnWU2XIHP37vdGqi7xXgrbMjdezlB+Nap/dEXwNkAEl8kppyYMXyBZ/oX1HkRZNfVy/ds++5f8IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHj9GnpE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719777519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WpWRlpWOQEz5GwCiuhA7IPEi++X+GWbNEgbY/muXf2k=;
	b=cHj9GnpEqAe8xPtrG++5RBM9p8l4Iqi9rx15eMd7PRZ7dTSVDEcHaaZJRTZ/h+al2DuX+u
	7J6YJnnMpbtOYCZXrVYWt7HsGMLwlW90HzD+CjIfKDJ94iIdrzqqnSxaxyeQ3931G+XwKk
	OM8RyCrQhMrhufUveye51nvWSeNkraY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659--hfuzMuUOKmxVqluimJG3g-1; Sun,
 30 Jun 2024 15:58:36 -0400
X-MC-Unique: -hfuzMuUOKmxVqluimJG3g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A46A195608F;
	Sun, 30 Jun 2024 19:58:34 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.78])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6E2A19560AA;
	Sun, 30 Jun 2024 19:58:28 +0000 (UTC)
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
Subject: [PATCH net-next v7 08/10] selftests: openvswitch: add userspace parsing
Date: Sun, 30 Jun 2024 21:57:29 +0200
Message-ID: <20240630195740.1469727-9-amorenoz@redhat.com>
In-Reply-To: <20240630195740.1469727-1-amorenoz@redhat.com>
References: <20240630195740.1469727-1-amorenoz@redhat.com>
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

Reviewed-by: Aaron Conole <aconole@redhat.com>
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index dcc400a21a22..4ccf26f96327 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -589,13 +589,27 @@ class ovsactions(nla):
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
 
@@ -843,6 +857,12 @@ class ovsactions(nla):
                 self["attrs"].append(["OVS_ACTION_ATTR_PSAMPLE", psampleact])
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
2.45.2


