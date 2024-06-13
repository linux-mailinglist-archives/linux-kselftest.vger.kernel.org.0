Return-Path: <linux-kselftest+bounces-11890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC594907AC8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 20:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17181C21388
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A754915533C;
	Thu, 13 Jun 2024 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bK8pzOQI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B81155342
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302441; cv=none; b=GKuWiaijeKdXHmmX8xcGwylXMqYFQTvmK/0C8QxENO9tlMqC0pDsoanPfn7Zkuvh7BTruDMwYi26uHcwlO+eceUvf0mFFGJ/yaAFRPqnCC5eIcsdN0STE+1L7GQW8f2ipDx5UjfnD8JdEnSqPsSoUqJHJg1ab/u5ffs4Cg13yFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302441; c=relaxed/simple;
	bh=SUqg3Y2+jucLHiR9s5BdxzfEh5ARUVVH65pJoLq+00M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWj/uUmXvdB7SjUtiP2JwMzPeKIs6D+CGiQBfZVrzZzCUv31ZYNjGd74Jmo0+HX/xj4PUHgDdmClFbaf8hjMvKEFgshYfV2MTGPMG0VfQoRJm5oy3/fKWUjx0ZZih71+z97FnG/t4nbHCWWOgRhszDmGhFWb+BPW+ORsBa2pWZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bK8pzOQI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718302439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBn7Y/AGY6HbNkoDSXw9yPDY45ccM5JWbhy8cP5+0Oo=;
	b=bK8pzOQIpJRGXfAKw8b4HF36/cXPEa72aOuKGYZenojtVr5S/0kbUDyPm9BjJRhwrXae0e
	ObEdLSBDqY2exlsqhfnLa4shJjkI5Vn3bMAgBBDkKX874FwX32sMY0nHLivTZe4PsG2S7f
	/QfuLIuarqaNsqNczIEK/hZUymgIZmE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-A0OPjjXJOxu_TJBsGYm5fQ-1; Thu,
 13 Jun 2024 14:13:55 -0400
X-MC-Unique: A0OPjjXJOxu_TJBsGYm5fQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A5601956094;
	Thu, 13 Jun 2024 18:13:54 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.16.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2864619560BF;
	Thu, 13 Jun 2024 18:13:50 +0000 (UTC)
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
Subject: [RFC net-next 5/7] selftests: openvswitch: Support implicit ipv6 arguments.
Date: Thu, 13 Jun 2024 14:13:31 -0400
Message-ID: <20240613181333.984810-6-aconole@redhat.com>
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

The current iteration of IPv6 support requires explicit fields to be set
in addition to not properly support the actual IPv6 addresses properly.
With this change, make it so that the ipv6() bare option is usable to
create wildcarded flows to match broad swaths of ipv6 traffic.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 43 ++++++++++++-------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 5545e5cab1d6..2577a06c58cf 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -200,6 +200,19 @@ def convert_ipv4(data):
 
     return int(ipaddress.IPv4Address(ip)), int(ipaddress.IPv4Address(mask))
 
+def convert_ipv6(data):
+    ip, _, mask = data.partition('/')
+
+    if not ip:
+        ip = mask = 0
+    elif not mask:
+        mask = 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
+    elif mask.isdigit():
+        mask = ipaddress.IPv6Network("::/" + mask).hostmask
+
+    return ipaddress.IPv6Address(ip).packed, ipaddress.IPv6Address(mask).packed
+
+
 def convert_int(size):
     def convert_int_sized(data):
         value, _, mask = data.partition('/')
@@ -937,21 +950,21 @@ class ovskey(nla):
                 "src",
                 "src",
                 lambda x: str(ipaddress.IPv6Address(x)),
-                lambda x: int.from_bytes(x, "big"),
-                lambda x: ipaddress.IPv6Address(x),
+                lambda x: ipaddress.IPv6Address(x).packed if x else 0,
+                convert_ipv6,
             ),
             (
                 "dst",
                 "dst",
                 lambda x: str(ipaddress.IPv6Address(x)),
-                lambda x: int.from_bytes(x, "big"),
-                lambda x: ipaddress.IPv6Address(x),
+                lambda x: ipaddress.IPv6Address(x).packed if x else 0,
+                convert_ipv6,
             ),
-            ("label", "label", "%d", int),
-            ("proto", "proto", "%d", int),
-            ("tclass", "tclass", "%d", int),
-            ("hlimit", "hlimit", "%d", int),
-            ("frag", "frag", "%d", int),
+            ("label", "label", "%d", lambda x: int(x) if x else 0),
+            ("proto", "proto", "%d", lambda x: int(x) if x else 0),
+            ("tclass", "tclass", "%d", lambda x: int(x) if x else 0),
+            ("hlimit", "hlimit", "%d", lambda x: int(x) if x else 0),
+            ("frag", "frag", "%d", lambda x: int(x) if x else 0),
         )
 
         def __init__(
@@ -1148,8 +1161,8 @@ class ovskey(nla):
             (
                 "target",
                 "target",
-                lambda x: str(ipaddress.IPv6Address(x)),
-                lambda x: int.from_bytes(x, "big"),
+                lambda x: ipaddress.IPv6Address(x).packed,
+                convert_ipv6,
             ),
             ("sll", "sll", macstr, lambda x: int.from_bytes(x, "big")),
             ("tll", "tll", macstr, lambda x: int.from_bytes(x, "big")),
@@ -1233,14 +1246,14 @@ class ovskey(nla):
             (
                 "src",
                 "src",
-                lambda x: str(ipaddress.IPv6Address(x)),
-                lambda x: int.from_bytes(x, "big", convertmac),
+                lambda x: ipaddress.IPv6Address(x).packed,
+                convert_ipv6,
             ),
             (
                 "dst",
                 "dst",
-                lambda x: str(ipaddress.IPv6Address(x)),
-                lambda x: int.from_bytes(x, "big"),
+                lambda x: ipaddress.IPv6Address(x).packed,
+                convert_ipv6,
             ),
             ("tp_src", "tp_src", "%d", int),
             ("tp_dst", "tp_dst", "%d", int),
-- 
2.45.1


