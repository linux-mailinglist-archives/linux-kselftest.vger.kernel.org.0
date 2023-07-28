Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C2F766C55
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 14:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbjG1MAq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 08:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbjG1MAk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 08:00:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6EB1B8
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 04:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690545588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pjPStuiWzD4abw7fhhhYg8bUcmpIOXeytka45p9JxS4=;
        b=DkP5UYbwrt0MzmVPgclBujvi9y/W0FlsIEMSazkseAPXK6nIv8ss+gegn3Ils3SCvIwpIA
        bsooIN4FF8vFxaPWYF7xYHzN4vvuaOn5nmaZh8xFqqv9tQH0uKVm2Bp/17BmroFS8BlGIE
        02ozXR57G0ccs7xCYov0ajeRU3YQ+6Y=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-Cyxks6VtNWGdydHB6LvT7A-1; Fri, 28 Jul 2023 07:59:43 -0400
X-MC-Unique: Cyxks6VtNWGdydHB6LvT7A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96F023806634;
        Fri, 28 Jul 2023 11:59:42 +0000 (UTC)
Received: from RHTPC1VM0NT.redhat.com (unknown [10.22.8.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 296F52017F3E;
        Fri, 28 Jul 2023 11:59:42 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dev@openvswitch.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Pravin B Shelar <pshelar@ovn.org>,
        Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v2 net-next 2/5] selftests: openvswitch: support key masks
Date:   Fri, 28 Jul 2023 07:59:37 -0400
Message-Id: <20230728115940.578658-3-aconole@redhat.com>
In-Reply-To: <20230728115940.578658-1-aconole@redhat.com>
References: <20230728115940.578658-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Adrian Moreno <amorenoz@redhat.com>

From: Adrian Moreno <amorenoz@redhat.com>

The default value for the mask actually depends on the value (e.g: if
the value is non-null, the default is full-mask), so change the convert
functions to accept the full, possibly masked string and let them figure
out how to parse the differnt values.

Also, implement size-aware int parsing.

With this patch we can now express flows such as the following:
"eth(src=0a:ca:fe:ca:fe:0a/ff:ff:00:00:ff:00)"
"eth(src=0a:ca:fe:ca:fe:0a)" -> mask = ff:ff:ff:ff:ff:ff
"ipv4(src=192.168.1.1)" -> mask = 255.255.255.255
"ipv4(src=192.168.1.1/24)"
"ipv4(src=192.168.1.1/255.255.255.0)"
"tcp(src=8080)" -> mask = 0xffff
"tcp(src=8080/0xf0f0)"

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
Acked-by: Aaron Conole <aconole@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 96 ++++++++++++-------
 1 file changed, 64 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index a11ba9f7ea6e..2b869e89c51d 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -160,25 +160,45 @@ def parse_ct_state(statestr):
     return parse_flags(statestr, ct_flags)
 
 
-def convert_mac(mac_str, mask=False):
-    if mac_str is None or mac_str == "":
-        mac_str = "00:00:00:00:00:00"
-    if mask is True and mac_str != "00:00:00:00:00:00":
-        mac_str = "FF:FF:FF:FF:FF:FF"
-    mac_split = mac_str.split(":")
-    ret = bytearray([int(i, 16) for i in mac_split])
-    return bytes(ret)
+def convert_mac(data):
+    def to_bytes(mac):
+        mac_split = mac.split(":")
+        ret = bytearray([int(i, 16) for i in mac_split])
+        return bytes(ret)
 
+    mac_str, _, mask_str = data.partition('/')
 
-def convert_ipv4(ip, mask=False):
-    if ip is None:
-        ip = 0
-    if mask is True:
-        if ip != 0:
-            ip = int(ipaddress.IPv4Address(ip)) & 0xFFFFFFFF
+    if not mac_str:
+        mac_str = mask_str = "00:00:00:00:00:00"
+    elif not mask_str:
+        mask_str = "FF:FF:FF:FF:FF:FF"
 
-    return int(ipaddress.IPv4Address(ip))
+    return to_bytes(mac_str), to_bytes(mask_str)
 
+def convert_ipv4(data):
+    ip, _, mask = data.partition('/')
+
+    if not ip:
+        ip = mask = 0
+    elif not mask:
+        mask = 0xFFFFFFFF
+    elif mask.isdigit():
+        mask = (0xFFFFFFFF << (32 - int(mask))) & 0xFFFFFFFF
+
+    return int(ipaddress.IPv4Address(ip)), int(ipaddress.IPv4Address(mask))
+
+def convert_int(size):
+    def convert_int_sized(data):
+        value, _, mask = data.partition('/')
+
+        if not value:
+            return 0, 0
+        elif not mask:
+            return int(value, 0), pow(2, size) - 1
+        else:
+            return int(value, 0), int(mask, 0)
+
+    return convert_int_sized
 
 def parse_starts_block(block_str, scanstr, returnskipped, scanregex=False):
     if scanregex:
@@ -525,8 +545,10 @@ class ovskey(nla):
         )
 
         fields_map = (
-            ("src", "src", "%d", lambda x: int(x) if x is not None else 0),
-            ("dst", "dst", "%d", lambda x: int(x) if x is not None else 0),
+            ("src", "src", "%d", lambda x: int(x) if x else 0,
+                convert_int(16)),
+            ("dst", "dst", "%d", lambda x: int(x) if x else 0,
+                convert_int(16)),
         )
 
         def __init__(
@@ -575,17 +597,13 @@ class ovskey(nla):
                     data = flowstr[:splitchar]
                     flowstr = flowstr[splitchar:]
                 else:
-                    data = None
+                    data = ""
 
                 if len(f) > 4:
-                    func = f[4]
-                else:
-                    func = f[3]
-                k[f[0]] = func(data)
-                if len(f) > 4:
-                    m[f[0]] = func(data, True)
+                    k[f[0]], m[f[0]] = f[4](data)
                 else:
-                    m[f[0]] = func(data)
+                    k[f[0]] = f[3](data)
+                    m[f[0]] = f[3](data)
 
                 flowstr = flowstr[strspn(flowstr, ", ") :]
                 if len(flowstr) == 0:
@@ -689,10 +707,14 @@ class ovskey(nla):
                 int,
                 convert_ipv4,
             ),
-            ("proto", "proto", "%d", lambda x: int(x) if x is not None else 0),
-            ("tos", "tos", "%d", lambda x: int(x) if x is not None else 0),
-            ("ttl", "ttl", "%d", lambda x: int(x) if x is not None else 0),
-            ("frag", "frag", "%d", lambda x: int(x) if x is not None else 0),
+            ("proto", "proto", "%d", lambda x: int(x) if x else 0,
+                convert_int(8)),
+            ("tos", "tos", "%d", lambda x: int(x) if x else 0,
+                convert_int(8)),
+            ("ttl", "ttl", "%d", lambda x: int(x) if x else 0,
+                convert_int(8)),
+            ("frag", "frag", "%d", lambda x: int(x) if x else 0,
+                convert_int(8)),
         )
 
         def __init__(
@@ -828,8 +850,8 @@ class ovskey(nla):
         )
 
         fields_map = (
-            ("type", "type", "%d", int),
-            ("code", "code", "%d", int),
+            ("type", "type", "%d", lambda x: int(x) if x else 0),
+            ("code", "code", "%d", lambda x: int(x) if x else 0),
         )
 
         def __init__(
@@ -894,7 +916,7 @@ class ovskey(nla):
                 int,
                 convert_ipv4,
             ),
-            ("op", "op", "%d", lambda x: int(x) if x is not None else 0),
+            ("op", "op", "%d", lambda x: int(x) if x else 0),
             (
                 "sha",
                 "sha",
@@ -1098,6 +1120,16 @@ class ovskey(nla):
                 "tcp",
                 ovskey.ovs_key_tcp,
             ),
+            (
+                "OVS_KEY_ATTR_UDP",
+                "udp",
+                ovskey.ovs_key_udp,
+            ),
+            (
+                "OVS_KEY_ATTR_ICMP",
+                "icmp",
+                ovskey.ovs_key_icmp,
+            ),
             (
                 "OVS_KEY_ATTR_TCP_FLAGS",
                 "tcp_flags",
-- 
2.40.1

