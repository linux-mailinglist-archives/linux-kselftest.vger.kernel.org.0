Return-Path: <linux-kselftest+bounces-22936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A57D9E7A9C
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 22:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7F8286FF4
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 21:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639482156FF;
	Fri,  6 Dec 2024 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Bs7TRuWJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B93212FA6
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519930; cv=none; b=KefodG1nqm20Q4llmaxlbq9ejgP85r0F/UYskE251fxVgT+qo9ElaIbG0UAkzxJRewvCzdVqiWPtX2DB/jyRai7UJ0KALu+nvX9yrShdl1puWUV04PyGVExGbjWOsJFfNq5b7d/K55TFcjcAgMLHq/eHRQZuLx9awmMvKdC78SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519930; c=relaxed/simple;
	bh=35rR6BxWiaqQLrkOwzSeMjod5LvXDiiOd1tUaFDw33w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tHNNTUVN2BjzveGcWDXUH6P4dQrsAeD8ujKMJEztnuqw3VpDnqqADKiuOgZPNeaRo/sqkyzVHjbkN5tqltYmDuxTpvAxtBIJEgCVu6uwYyImnuUW5Q47EyO4jJx4eMzemLlu2G/hcG9XxVRDeXr/lcqBNdRGnvwrLCcBEC1JNlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Bs7TRuWJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a766b475so24446535e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 13:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733519924; x=1734124724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yqSGRd2x0XCn8o0DHYhNZRjWsTUVn1h5+n6wvi8VHk=;
        b=Bs7TRuWJqDFjgGi77TzKP1ynQsGbZeDLZQfsbNTOOWwI591CsC6PKM58uxGYj/wHLx
         p9X2liSkYcgqhp/5EvqqPtkxrjmq9bwzE/K9KU8H9oAObUbbo4v7zSfqjhnuXyi0FV/p
         VZkOzqFrhG6PDxVE6TpIOPCb6QTHSS2Aq1ptIrwWbMshrq4ZJ1gU+KO/ErK5QuWmzWwS
         J85rXbyv+Z/p5OJKjbcUgBh4x8BnMW4ADTy2yxf+KSIxZDi4BlmWSLwAIvimRWcHjMWP
         XNjl8c8G6LO8SjIRYYVuWcuzr6AmYNIgDsDTiKgVeH/GmfENh511dUh2HPR305CSz+c9
         WAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519924; x=1734124724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yqSGRd2x0XCn8o0DHYhNZRjWsTUVn1h5+n6wvi8VHk=;
        b=S8q9t0aQlAEhXHn6VK4Z6yy4NP9UUcCxY0Bya0k+bk3jBq5HtZ4U8oZIitvJ18BKTg
         Dk0TBVl8HnZVJtSDhSvdaMw52ucinsYA9AtALIG2JTwT9oTIN7yAN34RY/I2iQBTbEK+
         w+HrQlWL1gOHsEyi4oyrtsv3dybcR2G32EKqcecQ0u8/zkZINK/5uken64X6EUkwlr+f
         ZiHnLEaYomKveYFysatnzhj5X2m8nQ/k1sWmEl9FgLbtFWIzMulkPTl+HpvlAbtXEEXy
         N0bFyF8x2rLkqs4SmYyJk9CqllHO4J5VQiGVHI/+ZfbooeSdvkIchDcfJMzwyMZ6b5r+
         lHug==
X-Forwarded-Encrypted: i=1; AJvYcCV5npjI5NgwrUUm4LmI7Z+yqSNh7lxqXHxwPN7eZUTKk+XMoJz+s/B5yw+RmpCzLyf9JTjWgs6XK3sXFTavs9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kNH3D6KeFbr5Mjlt3WNKfSxtznKp8lFVZ4aCIKlmcXv0GbL9
	8x+npt1Rt0sccXLcVN8qfVJPqG0WZoiKaFKd8XmKC+P/YEqSLpnSuiTN4iGBGRU=
X-Gm-Gg: ASbGnct4spIP1fXVh4SNDfM+82M/PnjodPj76gmCXiTVWDUMzytktkvFz5IEJp4Rdno
	asg2YAv/sNHeJYyyptEQUHDJ6z6HSEj0AUxcT+sGKvShvPDojrkfZTaAdxpErQKwoY6TzpXk84L
	JsTdh+f+GHrL7mJRg7RJyFch4ikl8YqccI4V5HjmFigOcHUEzvAh/Tc312Fj4LbGKzdPOtPyd6+
	sMJc7pQOaL5c3hFL8VwBuwL4dSWqCaI2xj/sO33bygtVrIVrdiUJrAVeffMPw==
X-Google-Smtp-Source: AGHT+IFhDXSW6bmbOXo7kkzSqIn8kkSlTxqECeMqo7xyBQDAaK5Axxg/SA/kkKhlggAvdxMbCGpiKw==
X-Received: by 2002:a05:6000:480d:b0:385:e034:8d47 with SMTP id ffacd0b85a97d-3862b3e76a5mr3585157f8f.46.1733519924309;
        Fri, 06 Dec 2024 13:18:44 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3cee:9adf:5d38:601e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46839sm5441302f8f.52.2024.12.06.13.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:18:43 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 06 Dec 2024 22:18:27 +0100
Subject: [PATCH net-next v13 02/22] ovpn: add basic netlink support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-b4-ovpn-v13-2-67fb4be666e2@openvpn.net>
References: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
In-Reply-To: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=31935; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=35rR6BxWiaqQLrkOwzSeMjod5LvXDiiOd1tUaFDw33w=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnU2pW9aJmzDaL18mC8X2OsM8QFYm5qcvAd/eCn
 YA8b/BbVLyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1NqVgAKCRALcOU6oDjV
 h+JiCACK9GWffZCyNXfT/e+/JkvqcROhQhd0JGEM6Vb5A03Bf1c//fb3h7CxCgDkn2HruqOhUmA
 9iLGL9QrkXJ5lFtj0N+LZ3WEPfP7pjwCxvF1vepNJeyjdXY6rQLRIaSHrhnK04yzIkbpAzgVcbc
 Bk0nvqDzQ3ZoPCCY6R4PHdO5Z3lPBe2+/lIOPRvfWpom89+3RPw/hlDWlx/HLPmfY0fJI9Z5l/i
 9a+n/LlMY95yp+VPrFRouzXF0lyL3KgIV1qosHulqhHrzgeuc8o12/QgoJFBnMIKUzAehI6D83q
 aKsajPF/JtYb/VPGTETtB/DtafZWEZsNVtYvkrDJ22ShT162
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This commit introduces basic netlink support with family
registration/unregistration functionalities and stub pre/post-doit.

More importantly it introduces the YAML uAPI description along
with its auto-generated files:
- include/uapi/linux/ovpn.h
- drivers/net/ovpn/netlink-gen.c
- drivers/net/ovpn/netlink-gen.h

Cc: donald.hunter@gmail.com
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 Documentation/netlink/specs/ovpn.yaml | 368 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                           |   2 +
 drivers/net/ovpn/Makefile             |   2 +
 drivers/net/ovpn/main.c               |  17 +-
 drivers/net/ovpn/main.h               |  14 ++
 drivers/net/ovpn/netlink-gen.c        | 212 ++++++++++++++++++++
 drivers/net/ovpn/netlink-gen.h        |  41 ++++
 drivers/net/ovpn/netlink.c            | 156 ++++++++++++++
 drivers/net/ovpn/netlink.h            |  15 ++
 drivers/net/ovpn/ovpnstruct.h         |  25 +++
 include/uapi/linux/ovpn.h             | 110 ++++++++++
 11 files changed, 961 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..96fe3c913f4fb77ecdfcb1de64983eceb81a2d02
--- /dev/null
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -0,0 +1,368 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+# Author: Antonio Quartulli <antonio@openvpn.net>
+#
+# Copyright (c) 2024, OpenVPN Inc.
+#
+
+name: ovpn
+
+protocol: genetlink
+
+doc: Netlink protocol to control OpenVPN network devices
+
+definitions:
+  -
+    type: const
+    name: nonce-tail-size
+    value: 8
+  -
+    type: enum
+    name: cipher-alg
+    entries: [ none, aes-gcm, chacha20-poly1305 ]
+  -
+    type: enum
+    name: del-peer-reason
+    entries:
+      - teardown
+      - admindown
+      - userspace
+      - expired
+      - transport-error
+      - transport-disconnect
+  -
+    type: enum
+    name: key-slot
+    entries: [ primary, secondary ]
+
+attribute-sets:
+  -
+    name: peer
+    attributes:
+      -
+        name: id
+        type: u32
+        doc: |
+          The unique ID of the peer in the device context. To be used to identify
+          peers during operations for a specific device
+        checks:
+          max: 0xFFFFFF
+      -
+        name: remote-ipv4
+        type: u32
+        doc: The remote IPv4 address of the peer
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: remote-ipv6
+        type: binary
+        doc: The remote IPv6 address of the peer
+        display-hint: ipv6
+        checks:
+          exact-len: 16
+      -
+        name: remote-ipv6-scope-id
+        type: u32
+        doc: The scope id of the remote IPv6 address of the peer (RFC2553)
+      -
+        name: remote-port
+        type: u16
+        doc: The remote port of the peer
+        byte-order: big-endian
+        checks:
+          min: 1
+      -
+        name: socket
+        type: u32
+        doc: The socket to be used to communicate with the peer
+      -
+        name: vpn-ipv4
+        type: u32
+        doc: The IPv4 address assigned to the peer by the server
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: vpn-ipv6
+        type: binary
+        doc: The IPv6 address assigned to the peer by the server
+        display-hint: ipv6
+        checks:
+          exact-len: 16
+      -
+        name: local-ipv4
+        type: u32
+        doc: The local IPv4 to be used to send packets to the peer (UDP only)
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: local-ipv6
+        type: binary
+        doc: The local IPv6 to be used to send packets to the peer (UDP only)
+        display-hint: ipv6
+        checks:
+          exact-len: 16
+      -
+        name: local-port
+        type: u16
+        doc: The local port to be used to send packets to the peer (UDP only)
+        byte-order: big-endian
+        checks:
+          min: 1
+      -
+        name: keepalive-interval
+        type: u32
+        doc: |
+          The number of seconds after which a keep alive message is sent to the
+          peer
+      -
+        name: keepalive-timeout
+        type: u32
+        doc: |
+          The number of seconds from the last activity after which the peer is
+          assumed dead
+      -
+        name: del-reason
+        type: u32
+        doc: The reason why a peer was deleted
+        enum: del-peer-reason
+      -
+        name: vpn-rx-bytes
+        type: uint
+        doc: Number of bytes received over the tunnel
+      -
+        name: vpn-tx-bytes
+        type: uint
+        doc: Number of bytes transmitted over the tunnel
+      -
+        name: vpn-rx-packets
+        type: uint
+        doc: Number of packets received over the tunnel
+      -
+        name: vpn-tx-packets
+        type: uint
+        doc: Number of packets transmitted over the tunnel
+      -
+        name: link-rx-bytes
+        type: uint
+        doc: Number of bytes received at the transport level
+      -
+        name: link-tx-bytes
+        type: uint
+        doc: Number of bytes transmitted at the transport level
+      -
+        name: link-rx-packets
+        type: u32
+        doc: Number of packets received at the transport level
+      -
+        name: link-tx-packets
+        type: u32
+        doc: Number of packets transmitted at the transport level
+  -
+    name: keyconf
+    attributes:
+      -
+        name: peer-id
+        type: u32
+        doc: |
+          The unique ID of the peer in the device context. To be used to
+          identify peers during key operations
+        checks:
+          max: 0xFFFFFF
+      -
+        name: slot
+        type: u32
+        doc: The slot where the key should be stored
+        enum: key-slot
+      -
+        name: key-id
+        doc: |
+          The unique ID of the key in the peer context. Used to fetch the
+          correct key upon decryption
+        type: u32
+        checks:
+          max: 7
+      -
+        name: cipher-alg
+        type: u32
+        doc: The cipher to be used when communicating with the peer
+        enum: cipher-alg
+      -
+        name: encrypt-dir
+        type: nest
+        doc: Key material for encrypt direction
+        nested-attributes: keydir
+      -
+        name: decrypt-dir
+        type: nest
+        doc: Key material for decrypt direction
+        nested-attributes: keydir
+  -
+    name: keydir
+    attributes:
+      -
+        name: cipher-key
+        type: binary
+        doc: The actual key to be used by the cipher
+        checks:
+         max-len: 256
+      -
+        name: nonce-tail
+        type: binary
+        doc: |
+          Random nonce to be concatenated to the packet ID, in order to
+          obtain the actual cipher IV
+        checks:
+         exact-len: nonce-tail-size
+  -
+    name: ovpn
+    attributes:
+      -
+        name: ifindex
+        type: u32
+        doc: Index of the ovpn interface to operate on
+      -
+        name: ifname
+        type: string
+        doc: Name of the ovpn interface
+      -
+        name: peer
+        type: nest
+        doc: |
+          The peer object containing the attributed of interest for the specific
+          operation
+        nested-attributes: peer
+      -
+        name: keyconf
+        type: nest
+        doc: Peer specific cipher configuration
+        nested-attributes: keyconf
+
+operations:
+  list:
+    -
+      name: peer-new
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: Add a remote peer
+      do:
+        pre: ovpn-nl-pre-doit
+        post: ovpn-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - peer
+    -
+      name: peer-set
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: modify a remote peer
+      do:
+        pre: ovpn-nl-pre-doit
+        post: ovpn-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - peer
+    -
+      name: peer-get
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: Retrieve data about existing remote peers (or a specific one)
+      do:
+        pre: ovpn-nl-pre-doit
+        post: ovpn-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - peer
+        reply:
+          attributes:
+            - peer
+      dump:
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes:
+            - peer
+    -
+      name: peer-del
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: Delete existing remote peer
+      do:
+        pre: ovpn-nl-pre-doit
+        post: ovpn-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - peer
+    -
+      name: peer-del-ntf
+      doc: Notification about a peer being deleted
+      notify: peer-get
+      mcgrp: peers
+
+    -
+      name: key-new
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: Add a cipher key for a specific peer
+      do:
+        pre: ovpn-nl-pre-doit
+        post: ovpn-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - keyconf
+    -
+      name: key-get
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: Retrieve non-sensitive data about peer key and cipher
+      do:
+        pre: ovpn-nl-pre-doit
+        post: ovpn-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - keyconf
+        reply:
+          attributes:
+            - keyconf
+    -
+      name: key-swap
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: Swap primary and secondary session keys for a specific peer
+      do:
+        pre: ovpn-nl-pre-doit
+        post: ovpn-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - keyconf
+    -
+      name: key-swap-ntf
+      notify: key-get
+      doc: |
+        Notification about key having exhausted its IV space and requiring
+        renegotiation
+      mcgrp: peers
+    -
+      name: key-del
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: Delete cipher key for a specific peer
+      do:
+        pre: ovpn-nl-pre-doit
+        post: ovpn-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - keyconf
+
+mcast-groups:
+  list:
+    -
+      name: peers
diff --git a/MAINTAINERS b/MAINTAINERS
index 6de1767f7cc80a571e0ab6e9f4dfe5650eb704d4..848538c52a01d18e0031ab34dca24c1151de4b8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17478,7 +17478,9 @@ L:	openvpn-devel@lists.sourceforge.net (subscribers-only)
 L:	netdev@vger.kernel.org
 S:	Supported
 T:	git https://github.com/OpenVPN/linux-kernel-ovpn.git
+F:	Documentation/netlink/specs/ovpn.yaml
 F:	drivers/net/ovpn/
+F:	include/uapi/linux/ovpn.h
 
 OPENVSWITCH
 M:	Pravin B Shelar <pshelar@ovn.org>
diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index ae19cf445b29367da680e226f06a341c42c892c2..19305a39e57eede2dc391aa0423702c5321649a6 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -8,3 +8,5 @@
 
 obj-$(CONFIG_OVPN) := ovpn.o
 ovpn-y += main.o
+ovpn-y += netlink.o
+ovpn-y += netlink-gen.o
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 72c56e73771cdece22e50645b29c79962f06caf3..3475dab4b40f3edd882e05dbdf8badd03d7c78a3 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,9 +7,15 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <net/rtnetlink.h>
+#include <uapi/linux/ovpn.h>
+
+#include "ovpnstruct.h"
+#include "main.h"
+#include "netlink.h"
 
 static const struct net_device_ops ovpn_netdev_ops = {
 };
@@ -20,7 +26,7 @@ static const struct net_device_ops ovpn_netdev_ops = {
  *
  * Return: whether the netdevice is of type 'ovpn'
  */
-static bool ovpn_dev_is_valid(const struct net_device *dev)
+bool ovpn_dev_is_valid(const struct net_device *dev)
 {
 	return dev->netdev_ops == &ovpn_netdev_ops;
 }
@@ -89,8 +95,16 @@ static int __init ovpn_init(void)
 		goto unreg_netdev;
 	}
 
+	err = ovpn_nl_register();
+	if (err) {
+		pr_err("ovpn: can't register netlink family: %d\n", err);
+		goto unreg_rtnl;
+	}
+
 	return 0;
 
+unreg_rtnl:
+	rtnl_link_unregister(&ovpn_link_ops);
 unreg_netdev:
 	unregister_netdevice_notifier(&ovpn_netdev_notifier);
 	return err;
@@ -98,6 +112,7 @@ static int __init ovpn_init(void)
 
 static __exit void ovpn_cleanup(void)
 {
+	ovpn_nl_unregister();
 	rtnl_link_unregister(&ovpn_link_ops);
 	unregister_netdevice_notifier(&ovpn_netdev_notifier);
 
diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
new file mode 100644
index 0000000000000000000000000000000000000000..1a0e83fe1649459289ebec8184c45e757f055dc2
--- /dev/null
+++ b/drivers/net/ovpn/main.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_MAIN_H_
+#define _NET_OVPN_MAIN_H_
+
+bool ovpn_dev_is_valid(const struct net_device *dev);
+
+#endif /* _NET_OVPN_MAIN_H_ */
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
new file mode 100644
index 0000000000000000000000000000000000000000..e99d6487d116e7082293ccdd2f0a253b8769389c
--- /dev/null
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ovpn.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "netlink-gen.h"
+
+#include <uapi/linux/ovpn.h>
+
+/* Integer value ranges */
+static const struct netlink_range_validation ovpn_a_peer_id_range = {
+	.max	= 16777215ULL,
+};
+
+static const struct netlink_range_validation ovpn_a_keyconf_peer_id_range = {
+	.max	= 16777215ULL,
+};
+
+/* Common nested types */
+const struct nla_policy ovpn_keyconf_nl_policy[OVPN_A_KEYCONF_DECRYPT_DIR + 1] = {
+	[OVPN_A_KEYCONF_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_keyconf_peer_id_range),
+	[OVPN_A_KEYCONF_SLOT] = NLA_POLICY_MAX(NLA_U32, 1),
+	[OVPN_A_KEYCONF_KEY_ID] = NLA_POLICY_MAX(NLA_U32, 7),
+	[OVPN_A_KEYCONF_CIPHER_ALG] = NLA_POLICY_MAX(NLA_U32, 2),
+	[OVPN_A_KEYCONF_ENCRYPT_DIR] = NLA_POLICY_NESTED(ovpn_keydir_nl_policy),
+	[OVPN_A_KEYCONF_DECRYPT_DIR] = NLA_POLICY_NESTED(ovpn_keydir_nl_policy),
+};
+
+const struct nla_policy ovpn_keydir_nl_policy[OVPN_A_KEYDIR_NONCE_TAIL + 1] = {
+	[OVPN_A_KEYDIR_CIPHER_KEY] = NLA_POLICY_MAX_LEN(256),
+	[OVPN_A_KEYDIR_NONCE_TAIL] = NLA_POLICY_EXACT_LEN(OVPN_NONCE_TAIL_SIZE),
+};
+
+const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_LINK_TX_PACKETS + 1] = {
+	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
+	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_BE32, },
+	[OVPN_A_PEER_REMOTE_IPV6] = NLA_POLICY_EXACT_LEN(16),
+	[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID] = { .type = NLA_U32, },
+	[OVPN_A_PEER_REMOTE_PORT] = NLA_POLICY_MIN(NLA_BE16, 1),
+	[OVPN_A_PEER_SOCKET] = { .type = NLA_U32, },
+	[OVPN_A_PEER_VPN_IPV4] = { .type = NLA_BE32, },
+	[OVPN_A_PEER_VPN_IPV6] = NLA_POLICY_EXACT_LEN(16),
+	[OVPN_A_PEER_LOCAL_IPV4] = { .type = NLA_BE32, },
+	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
+	[OVPN_A_PEER_LOCAL_PORT] = NLA_POLICY_MIN(NLA_BE16, 1),
+	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
+	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+	[OVPN_A_PEER_DEL_REASON] = NLA_POLICY_MAX(NLA_U32, 5),
+	[OVPN_A_PEER_VPN_RX_BYTES] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_VPN_TX_BYTES] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_VPN_RX_PACKETS] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_VPN_TX_PACKETS] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_LINK_RX_BYTES] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_LINK_TX_BYTES] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_LINK_RX_PACKETS] = { .type = NLA_U32, },
+	[OVPN_A_PEER_LINK_TX_PACKETS] = { .type = NLA_U32, },
+};
+
+/* OVPN_CMD_PEER_NEW - do */
+static const struct nla_policy ovpn_peer_new_nl_policy[OVPN_A_PEER + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_nl_policy),
+};
+
+/* OVPN_CMD_PEER_SET - do */
+static const struct nla_policy ovpn_peer_set_nl_policy[OVPN_A_PEER + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_nl_policy),
+};
+
+/* OVPN_CMD_PEER_GET - do */
+static const struct nla_policy ovpn_peer_get_do_nl_policy[OVPN_A_PEER + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_nl_policy),
+};
+
+/* OVPN_CMD_PEER_GET - dump */
+static const struct nla_policy ovpn_peer_get_dump_nl_policy[OVPN_A_IFINDEX + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+};
+
+/* OVPN_CMD_PEER_DEL - do */
+static const struct nla_policy ovpn_peer_del_nl_policy[OVPN_A_PEER + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_nl_policy),
+};
+
+/* OVPN_CMD_KEY_NEW - do */
+static const struct nla_policy ovpn_key_new_nl_policy[OVPN_A_KEYCONF + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_nl_policy),
+};
+
+/* OVPN_CMD_KEY_GET - do */
+static const struct nla_policy ovpn_key_get_nl_policy[OVPN_A_KEYCONF + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_nl_policy),
+};
+
+/* OVPN_CMD_KEY_SWAP - do */
+static const struct nla_policy ovpn_key_swap_nl_policy[OVPN_A_KEYCONF + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_nl_policy),
+};
+
+/* OVPN_CMD_KEY_DEL - do */
+static const struct nla_policy ovpn_key_del_nl_policy[OVPN_A_KEYCONF + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_nl_policy),
+};
+
+/* Ops table for ovpn */
+static const struct genl_split_ops ovpn_nl_ops[] = {
+	{
+		.cmd		= OVPN_CMD_PEER_NEW,
+		.pre_doit	= ovpn_nl_pre_doit,
+		.doit		= ovpn_nl_peer_new_doit,
+		.post_doit	= ovpn_nl_post_doit,
+		.policy		= ovpn_peer_new_nl_policy,
+		.maxattr	= OVPN_A_PEER,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= OVPN_CMD_PEER_SET,
+		.pre_doit	= ovpn_nl_pre_doit,
+		.doit		= ovpn_nl_peer_set_doit,
+		.post_doit	= ovpn_nl_post_doit,
+		.policy		= ovpn_peer_set_nl_policy,
+		.maxattr	= OVPN_A_PEER,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= OVPN_CMD_PEER_GET,
+		.pre_doit	= ovpn_nl_pre_doit,
+		.doit		= ovpn_nl_peer_get_doit,
+		.post_doit	= ovpn_nl_post_doit,
+		.policy		= ovpn_peer_get_do_nl_policy,
+		.maxattr	= OVPN_A_PEER,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= OVPN_CMD_PEER_GET,
+		.dumpit		= ovpn_nl_peer_get_dumpit,
+		.policy		= ovpn_peer_get_dump_nl_policy,
+		.maxattr	= OVPN_A_IFINDEX,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= OVPN_CMD_PEER_DEL,
+		.pre_doit	= ovpn_nl_pre_doit,
+		.doit		= ovpn_nl_peer_del_doit,
+		.post_doit	= ovpn_nl_post_doit,
+		.policy		= ovpn_peer_del_nl_policy,
+		.maxattr	= OVPN_A_PEER,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= OVPN_CMD_KEY_NEW,
+		.pre_doit	= ovpn_nl_pre_doit,
+		.doit		= ovpn_nl_key_new_doit,
+		.post_doit	= ovpn_nl_post_doit,
+		.policy		= ovpn_key_new_nl_policy,
+		.maxattr	= OVPN_A_KEYCONF,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= OVPN_CMD_KEY_GET,
+		.pre_doit	= ovpn_nl_pre_doit,
+		.doit		= ovpn_nl_key_get_doit,
+		.post_doit	= ovpn_nl_post_doit,
+		.policy		= ovpn_key_get_nl_policy,
+		.maxattr	= OVPN_A_KEYCONF,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= OVPN_CMD_KEY_SWAP,
+		.pre_doit	= ovpn_nl_pre_doit,
+		.doit		= ovpn_nl_key_swap_doit,
+		.post_doit	= ovpn_nl_post_doit,
+		.policy		= ovpn_key_swap_nl_policy,
+		.maxattr	= OVPN_A_KEYCONF,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= OVPN_CMD_KEY_DEL,
+		.pre_doit	= ovpn_nl_pre_doit,
+		.doit		= ovpn_nl_key_del_doit,
+		.post_doit	= ovpn_nl_post_doit,
+		.policy		= ovpn_key_del_nl_policy,
+		.maxattr	= OVPN_A_KEYCONF,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+};
+
+static const struct genl_multicast_group ovpn_nl_mcgrps[] = {
+	[OVPN_NLGRP_PEERS] = { "peers", },
+};
+
+struct genl_family ovpn_nl_family __ro_after_init = {
+	.name		= OVPN_FAMILY_NAME,
+	.version	= OVPN_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= ovpn_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(ovpn_nl_ops),
+	.mcgrps		= ovpn_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(ovpn_nl_mcgrps),
+};
diff --git a/drivers/net/ovpn/netlink-gen.h b/drivers/net/ovpn/netlink-gen.h
new file mode 100644
index 0000000000000000000000000000000000000000..66a4e4a0a055b4477b67801ded825e9ec068b0e6
--- /dev/null
+++ b/drivers/net/ovpn/netlink-gen.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ovpn.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_OVPN_GEN_H
+#define _LINUX_OVPN_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/ovpn.h>
+
+/* Common nested types */
+extern const struct nla_policy ovpn_keyconf_nl_policy[OVPN_A_KEYCONF_DECRYPT_DIR + 1];
+extern const struct nla_policy ovpn_keydir_nl_policy[OVPN_A_KEYDIR_NONCE_TAIL + 1];
+extern const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_LINK_TX_PACKETS + 1];
+
+int ovpn_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		     struct genl_info *info);
+void
+ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		  struct genl_info *info);
+
+int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info);
+int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info);
+int ovpn_nl_peer_get_doit(struct sk_buff *skb, struct genl_info *info);
+int ovpn_nl_peer_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info);
+int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info);
+int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info);
+int ovpn_nl_key_swap_doit(struct sk_buff *skb, struct genl_info *info);
+int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info);
+
+enum {
+	OVPN_NLGRP_PEERS,
+};
+
+extern struct genl_family ovpn_nl_family;
+
+#endif /* _LINUX_OVPN_GEN_H */
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
new file mode 100644
index 0000000000000000000000000000000000000000..c91368408b805d2bf4f12d64d5c55f4ed6d81343
--- /dev/null
+++ b/drivers/net/ovpn/netlink.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/netdevice.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/ovpn.h>
+
+#include "ovpnstruct.h"
+#include "main.h"
+#include "netlink.h"
+#include "netlink-gen.h"
+
+MODULE_ALIAS_GENL_FAMILY(OVPN_FAMILY_NAME);
+
+/**
+ * ovpn_get_dev_from_attrs - retrieve the ovpn private data from the netdevice
+ *			     a netlink message is targeting
+ * @net: network namespace where to look for the interface
+ * @info: generic netlink info from the user request
+ *
+ * Return: the ovpn private data, if found, or an error otherwise
+ */
+static struct ovpn_priv *
+ovpn_get_dev_from_attrs(struct net *net, const struct genl_info *info)
+{
+	struct ovpn_priv *ovpn;
+	struct net_device *dev;
+	int ifindex;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_IFINDEX))
+		return ERR_PTR(-EINVAL);
+
+	ifindex = nla_get_u32(info->attrs[OVPN_A_IFINDEX]);
+
+	rcu_read_lock();
+	dev = dev_get_by_index_rcu(net, ifindex);
+	if (!dev) {
+		rcu_read_unlock();
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "ifindex does not match any interface");
+		return ERR_PTR(-ENODEV);
+	}
+
+	if (!ovpn_dev_is_valid(dev)) {
+		rcu_read_unlock();
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "specified interface is not ovpn");
+		NL_SET_BAD_ATTR(info->extack, info->attrs[OVPN_A_IFINDEX]);
+		return ERR_PTR(-EINVAL);
+	}
+
+	ovpn = netdev_priv(dev);
+	netdev_hold(dev, &ovpn->dev_tracker, GFP_KERNEL);
+	rcu_read_unlock();
+
+	return ovpn;
+}
+
+int ovpn_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		     struct genl_info *info)
+{
+	struct ovpn_priv *ovpn = ovpn_get_dev_from_attrs(genl_info_net(info),
+							 info);
+
+	if (IS_ERR(ovpn))
+		return PTR_ERR(ovpn);
+
+	info->user_ptr[0] = ovpn;
+
+	return 0;
+}
+
+void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		       struct genl_info *info)
+{
+	struct ovpn_priv *ovpn = info->user_ptr[0];
+
+	if (ovpn)
+		netdev_put(ovpn->dev, &ovpn->dev_tracker);
+}
+
+int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_peer_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_peer_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_key_swap_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * ovpn_nl_register - perform any needed registration in the NL subsustem
+ *
+ * Return: 0 on success, a negative error code otherwise
+ */
+int __init ovpn_nl_register(void)
+{
+	int ret = genl_register_family(&ovpn_nl_family);
+
+	if (ret) {
+		pr_err("ovpn: genl_register_family failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * ovpn_nl_unregister - undo any module wide netlink registration
+ */
+void ovpn_nl_unregister(void)
+{
+	genl_unregister_family(&ovpn_nl_family);
+}
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
new file mode 100644
index 0000000000000000000000000000000000000000..9e87cf11d1e9813b7a75ddf3705ab7d5fabe899f
--- /dev/null
+++ b/drivers/net/ovpn/netlink.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_NETLINK_H_
+#define _NET_OVPN_NETLINK_H_
+
+int ovpn_nl_register(void);
+void ovpn_nl_unregister(void);
+
+#endif /* _NET_OVPN_NETLINK_H_ */
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
new file mode 100644
index 0000000000000000000000000000000000000000..b4e37e922fe5a5659e030174f1e42b3935967ca0
--- /dev/null
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNSTRUCT_H_
+#define _NET_OVPN_OVPNSTRUCT_H_
+
+#include <net/net_trackers.h>
+
+/**
+ * struct ovpn_priv - per ovpn interface state
+ * @dev: the actual netdev representing the tunnel
+ * @dev_tracker: reference tracker for associated dev
+ */
+struct ovpn_priv {
+	struct net_device *dev;
+	netdevice_tracker dev_tracker;
+};
+
+#endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
new file mode 100644
index 0000000000000000000000000000000000000000..de0c6ff421871685a648dbee67070a89d9f3e53f
--- /dev/null
+++ b/include/uapi/linux/ovpn.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ovpn.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_OVPN_H
+#define _UAPI_LINUX_OVPN_H
+
+#define OVPN_FAMILY_NAME	"ovpn"
+#define OVPN_FAMILY_VERSION	1
+
+#define OVPN_NONCE_TAIL_SIZE	8
+
+enum ovpn_cipher_alg {
+	OVPN_CIPHER_ALG_NONE,
+	OVPN_CIPHER_ALG_AES_GCM,
+	OVPN_CIPHER_ALG_CHACHA20_POLY1305,
+};
+
+enum ovpn_del_peer_reason {
+	OVPN_DEL_PEER_REASON_TEARDOWN,
+	OVPN_DEL_PEER_REASON_ADMINDOWN,
+	OVPN_DEL_PEER_REASON_USERSPACE,
+	OVPN_DEL_PEER_REASON_EXPIRED,
+	OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,
+	OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
+};
+
+enum ovpn_key_slot {
+	OVPN_KEY_SLOT_PRIMARY,
+	OVPN_KEY_SLOT_SECONDARY,
+};
+
+enum {
+	OVPN_A_PEER_ID = 1,
+	OVPN_A_PEER_REMOTE_IPV4,
+	OVPN_A_PEER_REMOTE_IPV6,
+	OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
+	OVPN_A_PEER_REMOTE_PORT,
+	OVPN_A_PEER_SOCKET,
+	OVPN_A_PEER_VPN_IPV4,
+	OVPN_A_PEER_VPN_IPV6,
+	OVPN_A_PEER_LOCAL_IPV4,
+	OVPN_A_PEER_LOCAL_IPV6,
+	OVPN_A_PEER_LOCAL_PORT,
+	OVPN_A_PEER_KEEPALIVE_INTERVAL,
+	OVPN_A_PEER_KEEPALIVE_TIMEOUT,
+	OVPN_A_PEER_DEL_REASON,
+	OVPN_A_PEER_VPN_RX_BYTES,
+	OVPN_A_PEER_VPN_TX_BYTES,
+	OVPN_A_PEER_VPN_RX_PACKETS,
+	OVPN_A_PEER_VPN_TX_PACKETS,
+	OVPN_A_PEER_LINK_RX_BYTES,
+	OVPN_A_PEER_LINK_TX_BYTES,
+	OVPN_A_PEER_LINK_RX_PACKETS,
+	OVPN_A_PEER_LINK_TX_PACKETS,
+
+	__OVPN_A_PEER_MAX,
+	OVPN_A_PEER_MAX = (__OVPN_A_PEER_MAX - 1)
+};
+
+enum {
+	OVPN_A_KEYCONF_PEER_ID = 1,
+	OVPN_A_KEYCONF_SLOT,
+	OVPN_A_KEYCONF_KEY_ID,
+	OVPN_A_KEYCONF_CIPHER_ALG,
+	OVPN_A_KEYCONF_ENCRYPT_DIR,
+	OVPN_A_KEYCONF_DECRYPT_DIR,
+
+	__OVPN_A_KEYCONF_MAX,
+	OVPN_A_KEYCONF_MAX = (__OVPN_A_KEYCONF_MAX - 1)
+};
+
+enum {
+	OVPN_A_KEYDIR_CIPHER_KEY = 1,
+	OVPN_A_KEYDIR_NONCE_TAIL,
+
+	__OVPN_A_KEYDIR_MAX,
+	OVPN_A_KEYDIR_MAX = (__OVPN_A_KEYDIR_MAX - 1)
+};
+
+enum {
+	OVPN_A_IFINDEX = 1,
+	OVPN_A_IFNAME,
+	OVPN_A_PEER,
+	OVPN_A_KEYCONF,
+
+	__OVPN_A_MAX,
+	OVPN_A_MAX = (__OVPN_A_MAX - 1)
+};
+
+enum {
+	OVPN_CMD_PEER_NEW = 1,
+	OVPN_CMD_PEER_SET,
+	OVPN_CMD_PEER_GET,
+	OVPN_CMD_PEER_DEL,
+	OVPN_CMD_PEER_DEL_NTF,
+	OVPN_CMD_KEY_NEW,
+	OVPN_CMD_KEY_GET,
+	OVPN_CMD_KEY_SWAP,
+	OVPN_CMD_KEY_SWAP_NTF,
+	OVPN_CMD_KEY_DEL,
+
+	__OVPN_CMD_MAX,
+	OVPN_CMD_MAX = (__OVPN_CMD_MAX - 1)
+};
+
+#define OVPN_MCGRP_PEERS	"peers"
+
+#endif /* _UAPI_LINUX_OVPN_H */

-- 
2.45.2


