Return-Path: <linux-kselftest+bounces-12320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 780FA91051E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 15:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042241F24E14
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60B41B47A3;
	Thu, 20 Jun 2024 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMpGVGp+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293771B3F23
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888190; cv=none; b=UurjINOGIoWJHb1j8Fvqyt9kAfODqy7gRBAjxOqM78T/WsbVOFC7JM7O70XzXWM0FxE8Rn5BpUby7LKkLzN3araKAly7V1ivrZ3ay9ztJs2VSb5n1V3ZJbA3f7I8EFWRKvEwDkgbouNqa3xwWle6oddKdfXYt3SE5Woryimeul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888190; c=relaxed/simple;
	bh=ehCFD70yeZmgvGeU+oACRU5BVPCK64DlPCzSd2L448g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N77YltnLSJZ2K10tpaMBzCnTmGRPeLWI/HmZ4WWzeHusdcHdh8zGjqEGm46rdNQqZxkKq2/gxvLjXbKPfyPFF6pYmjL0+izA9VEO7T/R6ZerlnhKSCPGV0lqXjWW6n73bGWYjL0tOTy13EpyK109HyZIko9wK3WG+CXhmoWazSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMpGVGp+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718888188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KQWKZuB8nVeihbMwq4LfjJggXovEXIPvEKjuzYu6Ag=;
	b=XMpGVGp+JxCJEegHZX2Ys/kPsljJiaz/fYAXMfgxG+NrNs7ARxy815bCvyrREJwKctYfVi
	Wb34z9KmtwYgpxjtrt1jOBSjvs5jYRHCjVS5RKGPRpB/jMppZ4m6puO4z5y43HfU5ujq5k
	oc4bZDxQG4CqXL+ydgdhnCICeGf8JOw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-zmsjOGBsOGmNNJnzfPRfAg-1; Thu,
 20 Jun 2024 08:56:24 -0400
X-MC-Unique: zmsjOGBsOGmNNJnzfPRfAg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8F521955EAC;
	Thu, 20 Jun 2024 12:56:22 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.9.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE37D1955E80;
	Thu, 20 Jun 2024 12:56:19 +0000 (UTC)
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
	Stefano Brivio <sbrivio@redhat.com>,
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 net-next 5/7] selftests: openvswitch: Support implicit ipv6 arguments.
Date: Thu, 20 Jun 2024 08:55:59 -0400
Message-ID: <20240620125601.15755-6-aconole@redhat.com>
In-Reply-To: <20240620125601.15755-1-aconole@redhat.com>
References: <20240620125601.15755-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The current iteration of IPv6 support requires explicit fields to be set
in addition to not properly support the actual IPv6 addresses properly.
With this change, make it so that the ipv6() bare option is usable to
create wildcarded flows to match broad swaths of ipv6 traffic.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
v2: Drop the change in the v6 key class that removed the
    str() conversion

 .../selftests/net/openvswitch/ovs-dpctl.py    | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 2f16df2fb16b..0ea7286a491e 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -200,6 +200,18 @@ def convert_ipv4(data):
 
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
 def convert_int(size):
     def convert_int_sized(data):
         value, _, mask = data.partition('/')
@@ -941,21 +953,21 @@ class ovskey(nla):
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
@@ -1153,7 +1165,7 @@ class ovskey(nla):
                 "target",
                 "target",
                 lambda x: str(ipaddress.IPv6Address(x)),
-                lambda x: int.from_bytes(x, "big"),
+                convert_ipv6,
             ),
             ("sll", "sll", macstr, lambda x: int.from_bytes(x, "big")),
             ("tll", "tll", macstr, lambda x: int.from_bytes(x, "big")),
@@ -1238,13 +1250,13 @@ class ovskey(nla):
                 "src",
                 "src",
                 lambda x: str(ipaddress.IPv6Address(x)),
-                lambda x: int.from_bytes(x, "big", convertmac),
+                convert_ipv6,
             ),
             (
                 "dst",
                 "dst",
                 lambda x: str(ipaddress.IPv6Address(x)),
-                lambda x: int.from_bytes(x, "big"),
+                convert_ipv6,
             ),
             ("tp_src", "tp_src", "%d", int),
             ("tp_dst", "tp_dst", "%d", int),
-- 
2.45.1


