Return-Path: <linux-kselftest+bounces-12092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E990B8F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 20:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B981C23C47
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 18:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D05C19A2A0;
	Mon, 17 Jun 2024 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pa5cVVae"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1E19A286
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647368; cv=none; b=SRyIPKY/C4mZBUyZLFvccv42KU8s4XrvKp/YiiJ7fgmluKYC1GemYgesq68HuqDLGwZRYmbu5JfHdpg1e1B27PgIY5ZjdP/qieQ3eoqPRfXW4An5HpkQ3rQPSXY10BCqlwVcpJFPwCHehgHOPldspjKqvNl+lSnBO/MOQrOAIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647368; c=relaxed/simple;
	bh=u8jUL6VVSfi7eztkwLZLXRHCyQFK3VlYFh2LaicIUpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnJuqGuFhnbV2cYp+s7yIz4nXaVHmLkFdkTboay7rI+mD5VsiEmVF2nC0v9cIPSo1eV9NpFjh28oiD4BkH8KmoSOwVYD0I4uEikJjwuYxr8I0mmzZ7M8gj2phuCQQ42HwWMw/VHUJTBYmu+jG3FjmTCPvzGXNeW0/qtRJYOXMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pa5cVVae; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718647364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YMmaYlctkV6tj5ef+RbUlq797h5VANyp6My1DBi1cE=;
	b=Pa5cVVaen39rcLBnLh6/BwXcPQQ8P3JKf6wnPRWKYEipcxTSsjotswkZeJ3uLXV/mHNQ63
	zOCUmA8zQ3SbLFg8mTlIjPqZrWhbdCQ95GV6LmzixehfzqcMISZnwH6XSRF/TeTsU5OAFs
	MFfiRcpfzTZKBqZZj2dppeWhX3vIcXM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-6KapvFWtMXqN7Su_WdqFPQ-1; Mon,
 17 Jun 2024 14:02:42 -0400
X-MC-Unique: 6KapvFWtMXqN7Su_WdqFPQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AECFC1955DB8;
	Mon, 17 Jun 2024 18:02:38 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.16.41])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8AA51956087;
	Mon, 17 Jun 2024 18:02:35 +0000 (UTC)
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
Subject: [PATCH net-next 5/7] selftests: openvswitch: Support implicit ipv6 arguments.
Date: Mon, 17 Jun 2024 14:02:16 -0400
Message-ID: <20240617180218.1154326-6-aconole@redhat.com>
In-Reply-To: <20240617180218.1154326-1-aconole@redhat.com>
References: <20240617180218.1154326-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The current iteration of IPv6 support requires explicit fields to be set
in addition to not properly support the actual IPv6 addresses properly.
With this change, make it so that the ipv6() bare option is usable to
create wildcarded flows to match broad swaths of ipv6 traffic.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 42 ++++++++++++-------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 2f16df2fb16b..2062e7e6e99e 100644
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
@@ -1152,8 +1164,8 @@ class ovskey(nla):
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
@@ -1237,14 +1249,14 @@ class ovskey(nla):
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


