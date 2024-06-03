Return-Path: <linux-kselftest+bounces-11124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6823A8D889F
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 20:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991931C225D1
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 18:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1A3136E3A;
	Mon,  3 Jun 2024 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6ZvJLsO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870011CD38
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Jun 2024 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439490; cv=none; b=BlEvjKvJjuhf8/TBlH5F7JCGvcVTiCJvAHzXyZXiq8AvqE8dWOdWRA2QNWYrSqZ/lY5ghh5fY7Q7TDWWfQUli59ooQTwB1O03/eZeqgCWClucON8fckTRzqLwau5StAhEST7C3+wj5nTVU3mYLBzfYHJtZoOqMRJ0T7oVKKiXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439490; c=relaxed/simple;
	bh=qsya4nkJf9ItcPXlY7BN+r2obn6IM42sPgazzJIezz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EULorrA49/AnnvbD4yitr2wdMPTl0T61IbhCJnhCMEec2ax320UHKsanHYXFcNNb4P3pALywOc4PDgU/eyJYpGU7196gzZkX1/JmccTsqIVshSYeIUVEe2tQUU5dc3ydv3HuHVwN1RAPvhfwitdWVqLolHc4mTgHtUWUOS9aqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6ZvJLsO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717439487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yl8vr4y8a6U6pmG4DWdxKYXNybm3u7Z5la/ggzjv+O4=;
	b=J6ZvJLsO3i0nU6wtI1PqTTVjOvhFmlOJf4B/oDRDvL8oovn1mdZ+KtsmSwF3PmgzY48GyI
	EQO5EyBMps2qGNjpzQA2QNaZXMQ2EjkgPJsfIA91VsI2dhNtyYxCaqhAiDMoNIiSseLxMp
	CxgWT3ncKTWWpUIfsdWAp85FiAHjgOk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-ggZ-nkC7PtaeEckWHU-_Fg-1; Mon, 03 Jun 2024 14:31:25 -0400
X-MC-Unique: ggZ-nkC7PtaeEckWHU-_Fg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19C038058D7;
	Mon,  3 Jun 2024 18:31:25 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.112])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 93EC2105017A;
	Mon,  3 Jun 2024 18:31:22 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
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
Subject: [PATCH net-next 1/2] selftests: openvswitch: fix action formatting
Date: Mon,  3 Jun 2024 20:31:19 +0200
Message-ID: <20240603183121.2305013-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

In the action formatting function ("dpstr"), the iteration is made over
the nla_map, so if there are more than one attribute from the same type
we only print the first one.

Fix this by iterating over the actual attributes.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 48 +++++++++++--------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 1dd057afd3fb..b76907ac0092 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -437,40 +437,46 @@ class ovsactions(nla):
     def dpstr(self, more=False):
         print_str = ""
 
-        for field in self.nla_map:
-            if field[1] == "none" or self.get_attr(field[0]) is None:
+        for attr_name, value in self["attrs"]:
+            attr_desc = next(filter(lambda x: x[0] == attr_name, self.nla_map),
+                             None)
+            if not attr_desc:
+                raise ValueError("Unknown attribute: %s" % attr)
+
+            attr_type = attr_desc[1]
+
+            if attr_type == "none":
                 continue
             if print_str != "":
                 print_str += ","
 
-            if field[1] == "uint32":
-                if field[0] == "OVS_ACTION_ATTR_OUTPUT":
-                    print_str += "%d" % int(self.get_attr(field[0]))
-                elif field[0] == "OVS_ACTION_ATTR_RECIRC":
-                    print_str += "recirc(0x%x)" % int(self.get_attr(field[0]))
-                elif field[0] == "OVS_ACTION_ATTR_TRUNC":
-                    print_str += "trunc(%d)" % int(self.get_attr(field[0]))
-                elif field[0] == "OVS_ACTION_ATTR_DROP":
-                    print_str += "drop(%d)" % int(self.get_attr(field[0]))
-            elif field[1] == "flag":
-                if field[0] == "OVS_ACTION_ATTR_CT_CLEAR":
+            if attr_type == "uint32":
+                if attr_name == "OVS_ACTION_ATTR_OUTPUT":
+                    print_str += "%d" % int(value)
+                elif attr_name == "OVS_ACTION_ATTR_RECIRC":
+                    print_str += "recirc(0x%x)" % int(value)
+                elif attr_name == "OVS_ACTION_ATTR_TRUNC":
+                    print_str += "trunc(%d)" % int(value)
+                elif attr_name == "OVS_ACTION_ATTR_DROP":
+                    print_str += "drop(%d)" % int(value)
+            elif attr_type == "flag":
+                if attr_name == "OVS_ACTION_ATTR_CT_CLEAR":
                     print_str += "ct_clear"
-                elif field[0] == "OVS_ACTION_ATTR_POP_VLAN":
+                elif attr_name == "OVS_ACTION_ATTR_POP_VLAN":
                     print_str += "pop_vlan"
-                elif field[0] == "OVS_ACTION_ATTR_POP_ETH":
+                elif attr_name == "OVS_ACTION_ATTR_POP_ETH":
                     print_str += "pop_eth"
-                elif field[0] == "OVS_ACTION_ATTR_POP_NSH":
+                elif attr_name == "OVS_ACTION_ATTR_POP_NSH":
                     print_str += "pop_nsh"
-                elif field[0] == "OVS_ACTION_ATTR_POP_MPLS":
+                elif attr_name == "OVS_ACTION_ATTR_POP_MPLS":
                     print_str += "pop_mpls"
             else:
-                datum = self.get_attr(field[0])
-                if field[0] == "OVS_ACTION_ATTR_CLONE":
+                if attr_name == "OVS_ACTION_ATTR_CLONE":
                     print_str += "clone("
-                    print_str += datum.dpstr(more)
+                    print_str += value.dpstr(more)
                     print_str += ")"
                 else:
-                    print_str += datum.dpstr(more)
+                    print_str += value.dpstr(more)
 
         return print_str
 
-- 
2.45.1


