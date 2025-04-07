Return-Path: <linux-kselftest+bounces-30282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7638A7EDD1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCE717609E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EDF221735;
	Mon,  7 Apr 2025 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fC/6xS+r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505BA21B9E5
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055231; cv=none; b=jD74ueGYJ48Td4HDHwZbCgXhymUSZvNJm9c3f44Ehwre7AjK5YxcbnCEt/IDoYfSTPRhyoZS1gIjnRze8vY8P1oUAMz2isGX7zl2lxW3wpj0RL1vnC2bq8Yu3WWGlc4/aO43GztyC8chXiZKovuesmhy6pzMKdyKtZEz8aVlo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055231; c=relaxed/simple;
	bh=BJVi4krZLnnUdNBkB0U772zfLW7TZYc8ZmCzV58OGUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsXa8IKqC1IvXmynN2h7WuGcVF+E8HvWBGbWhkNcXtfl0Ql3lcoRjt/WohwD8Bn+KXaS75hXkhievMzQ6xFQ63TFMnKojFlRsav7BEFN1pBlT9zf1vVeaCkdtnqzhekfIDPG+26MpSiSb3VMQpKPHlqQvvyxe10xlCQyKBIFbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fC/6xS+r; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf848528aso39015135e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 12:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744055226; x=1744660026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cv2Uud6GREaC48/xmnTnsDCB4b9TFrFV+lvlIaxowaI=;
        b=fC/6xS+rXPFJLy99Tiq5rqJqX4e0CUSBS5j5116TKmBRtDJFGZ5vQhzHSc9mzLnwnX
         4YMQ706q6iTCp2Uw0KaQIhTcHIgy35myQSrEiyEeoZLcblYiy37gi0lnVXu/oT7QGNO4
         HpsrLTZTroF0MMO3XBwZRNhmn94pIAecMbujhf7R/Pj5eJLKZSIpPejU7xIKF1nEWm0r
         12k7kh8+SIbixyjsGW01d7sV1c3VG+BiKtTcV7Zv+cLz6foth00y7jrRurxFMC9vHZQk
         k7jHLOlOQpuk90Bx7mXMV/xVy0PhV1RmzZ0nbg9wY0+3YGey7UcszQHwUiMdlbthtTSI
         +lTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055226; x=1744660026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cv2Uud6GREaC48/xmnTnsDCB4b9TFrFV+lvlIaxowaI=;
        b=M1RnhSq07Hmu3gMCA2B+BOUi2UWEegaV0U1TdK8QV2cUJI0zIrYNxrVNKLDAtqhqn+
         hk85hug1XryO27/s7rVgumaulgt/3rOq0MchoWNEPYqiDLhJE/GQRmAfdcW241ijBbDV
         URb3XHndtYP1P8XrcaXm1M71ZbUrG4K/V+FTivWbAbuWMQss02YH6I0/KiCoQhhaW67E
         clBZ1BVmt+2O+p65b+uXOt2SZo0QkudE6JOAxapSrxstC3NV7lJxCutBaY1LiXC7ZOZH
         +RWWZgRkw9ZgGfkBkcEqwop76CsL5tlG2lqobHjPMmEplmLaiuAJlOu3SkeqqnG39nN+
         wNTg==
X-Forwarded-Encrypted: i=1; AJvYcCXGz7vbRegkBljYFOAZT8ljC8AWqURBMmXmpQNbwY50cfk2vc7TZjjmB8dNBzVQ4EDcBUww5V/CvfypE1dfUBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSFg4/e66dbEs4krufjmnSenYXjBLU953rbrxTJhZZM4GeViRv
	5cUpJesDjhLMAB1dfxrlBot/SrJ9/a6jPz9i1O4co9B/tzfmxlZwrgoJA6NvCSdmGZIlk4spB64
	aDeJRzvJ4lNL9+sl5P/zEwBbQ2dm0Gzj8s9sZ2WR0EcbMGysXqigRWUq6B5w=
X-Gm-Gg: ASbGncvR8X7hSQ65O6HETSen6tqg2qFIUc5SLxXf9s57YMuNuktMH3AUBk280ITpQRo
	bvZn+c6zeuGqv8wlM0pOICvHOtbSsOU1L8Bjhak3+q6mCUeF4h3/7+bbSWp2q/WkbWVfQyemW7H
	GWTzjB+Y9MstoS7u/w/QDBYndVU9DNHJFi2MpzVTv2aulVAdCJrNDVBCdh0mlrhD03Z4BxsVvEr
	YyaSrF8rt8qqzZ3cY8qdHZjktm+vB0umKDp+r83J4GvIML9W9jreOjAPDEM+Z5U9D9MkLED+D49
	DC/+14DPPpN9PsSvrdHcjTt/tixJJjMg4ArHgc7UyYdGCJb5q7Vc
X-Google-Smtp-Source: AGHT+IEXAvqj07nXcmL0p0ieqhk33z8LDMNFp/GB7gvPsJ21FZQymjjXinAEA6pMeVHzUpCxmay0YA==
X-Received: by 2002:a05:600c:548d:b0:43c:fa24:873e with SMTP id 5b1f17b1804b1-43ee0640f37mr98908365e9.13.1744055226353;
        Mon, 07 Apr 2025 12:47:06 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:fb98:cd95:3ed6:f7c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm141433545e9.4.2025.04.07.12.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:47:05 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 07 Apr 2025 21:46:10 +0200
Subject: [PATCH net-next v25 02/23] ovpn: add basic netlink support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-b4-ovpn-v25-2-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
In-Reply-To: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=32140; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=BJVi4krZLnnUdNBkB0U772zfLW7TZYc8ZmCzV58OGUQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn9Cu0FHUt47o5lhSe/7lXwnCf9Nmcua+pjJkvq
 x8OtIHyL86JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/QrtAAKCRALcOU6oDjV
 hzXtB/9+q8ofqj5ys+qrB5t1xymy1ral9bEc5GSN6VZoTSSilZSq6LE8VndKUEukI9Ib9UwiCbx
 w5ZN6E0wcB00H6M5Sbcu4qp8SJSLGYTrMTaE3Kxl0SEYYUhpVztcGSGLvLNAUjRmyNtjyJDry8a
 4sKyebyF7vKR+f3OPk3/kplAxjwUgEOd4B8lbz4SNRgvLeyt/n+8jcwJb8wQR5yvg0pcerRFBQb
 tMR7rZvTxmYO5Wdxk7VxUDFvLgmstUo3UGq7CWhrJUFXNoWofw+gwMCJy4uauEZMcASueWN/eSC
 Pi1wYvYwJKsjwr0uvPnWM8IaXpV39zu9Gcc21ixKUYzJCXxv
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This commit introduces basic netlink support with family
registration/unregistration functionalities and stub pre/post-doit.

More importantly it introduces the YAML uAPI description along
with its auto-generated files:
- include/uapi/linux/ovpn.h
- drivers/net/ovpn/netlink-gen.c
- drivers/net/ovpn/netlink-gen.h

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 Documentation/netlink/specs/ovpn.yaml | 367 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                           |   2 +
 drivers/net/ovpn/Makefile             |   2 +
 drivers/net/ovpn/main.c               |  17 +-
 drivers/net/ovpn/main.h               |  14 ++
 drivers/net/ovpn/netlink-gen.c        | 213 ++++++++++++++++++++
 drivers/net/ovpn/netlink-gen.h        |  41 ++++
 drivers/net/ovpn/netlink.c            | 160 +++++++++++++++
 drivers/net/ovpn/netlink.h            |  15 ++
 drivers/net/ovpn/ovpnpriv.h           |  21 ++
 include/uapi/linux/ovpn.h             | 109 ++++++++++
 11 files changed, 960 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..6f131bead88f83a9d5a957190001a815f76395be
--- /dev/null
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -0,0 +1,367 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+# Author: Antonio Quartulli <antonio@openvpn.net>
+#
+# Copyright (c) 2024-2025, OpenVPN Inc.
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
+        doc: >-
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
+        name: socket-netnsid
+        type: s32
+        doc: The ID of the netns the socket assigned to this peer lives in
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
+        doc: >-
+          The number of seconds after which a keep alive message is sent to the
+          peer
+      -
+        name: keepalive-timeout
+        type: u32
+        doc: >-
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
+        type: uint
+        doc: Number of packets received at the transport level
+      -
+        name: link-tx-packets
+        type: uint
+        doc: Number of packets transmitted at the transport level
+  -
+    name: keyconf
+    attributes:
+      -
+        name: peer-id
+        type: u32
+        doc: >-
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
+        doc: >-
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
+        doc: >-
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
+        name: peer
+        type: nest
+        doc: >-
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
+      doc: >-
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
index 599e821b64131e0b63f5f14be1a62e9ff570063a..871d41959e16d626d93156a149a886c492e13a9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18136,7 +18136,9 @@ L:	openvpn-devel@lists.sourceforge.net (subscribers-only)
 L:	netdev@vger.kernel.org
 S:	Supported
 T:	git https://github.com/OpenVPN/linux-kernel-ovpn.git
+F:	Documentation/netlink/specs/ovpn.yaml
 F:	drivers/net/ovpn/
+F:	include/uapi/linux/ovpn.h
 
 OPENVSWITCH
 M:	Aaron Conole <aconole@redhat.com>
diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 876800ebaa21a5f758ddf60f637801710437f70e..75ac62bba02937bc49cb2a0dec5ca3cc31a8ee00 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -8,3 +8,5 @@
 
 obj-$(CONFIG_OVPN) := ovpn.o
 ovpn-y += main.o
+ovpn-y += netlink.o
+ovpn-y += netlink-gen.o
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index e816e8fbbfeff1086a55c858b1941b7d82d7aba6..28133e7e15e74b8a4a937ed03f70d9f83d7a14c8 100644
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
+#include "ovpnpriv.h"
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
index 0000000000000000000000000000000000000000..017cd0100765900181cb662319cf38c2d0b7dd2d
--- /dev/null
+++ b/drivers/net/ovpn/main.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
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
index 0000000000000000000000000000000000000000..58e1a4342378eacc67dec19de34fa4bb45f16fe2
--- /dev/null
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -0,0 +1,213 @@
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
+	[OVPN_A_PEER_SOCKET_NETNSID] = { .type = NLA_S32, },
+	[OVPN_A_PEER_VPN_IPV4] = { .type = NLA_BE32, },
+	[OVPN_A_PEER_VPN_IPV6] = NLA_POLICY_EXACT_LEN(16),
+	[OVPN_A_PEER_LOCAL_IPV4] = { .type = NLA_BE32, },
+	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
+	[OVPN_A_PEER_LOCAL_PORT] = NLA_POLICY_MIN(NLA_BE16, 1),
+	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
+	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+	[OVPN_A_PEER_DEL_REASON] = NLA_POLICY_MAX(NLA_U32, 4),
+	[OVPN_A_PEER_VPN_RX_BYTES] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_VPN_TX_BYTES] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_VPN_RX_PACKETS] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_VPN_TX_PACKETS] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_LINK_RX_BYTES] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_LINK_TX_BYTES] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_LINK_RX_PACKETS] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_LINK_TX_PACKETS] = { .type = NLA_UINT, },
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
index 0000000000000000000000000000000000000000..8d267d4c82283d9b5f989478102086ce385195d5
--- /dev/null
+++ b/drivers/net/ovpn/netlink.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/netdevice.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/ovpn.h>
+
+#include "ovpnpriv.h"
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
+ * @tracker: tracker object to be used for the netdev reference acquisition
+ *
+ * Return: the ovpn private data, if found, or an error otherwise
+ */
+static struct ovpn_priv *
+ovpn_get_dev_from_attrs(struct net *net, const struct genl_info *info,
+			netdevice_tracker *tracker)
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
+	netdev_hold(dev, tracker, GFP_ATOMIC);
+	rcu_read_unlock();
+
+	return ovpn;
+}
+
+int ovpn_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		     struct genl_info *info)
+{
+	netdevice_tracker *tracker = (netdevice_tracker *)&info->user_ptr[1];
+	struct ovpn_priv *ovpn = ovpn_get_dev_from_attrs(genl_info_net(info),
+							 info, tracker);
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
+	netdevice_tracker *tracker = (netdevice_tracker *)&info->user_ptr[1];
+	struct ovpn_priv *ovpn = info->user_ptr[0];
+
+	if (ovpn)
+		netdev_put(ovpn->dev, tracker);
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
index 0000000000000000000000000000000000000000..0d6c34e17082cc7c52dd9c5d5ed1e964925b3f4b
--- /dev/null
+++ b/drivers/net/ovpn/netlink.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
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
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
new file mode 100644
index 0000000000000000000000000000000000000000..f9322536b06d6baa5524de57cd7d69f5ecbbd194
--- /dev/null
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2025 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNSTRUCT_H_
+#define _NET_OVPN_OVPNSTRUCT_H_
+
+/**
+ * struct ovpn_priv - per ovpn interface state
+ * @dev: the actual netdev representing the tunnel
+ */
+struct ovpn_priv {
+	struct net_device *dev;
+};
+
+#endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
new file mode 100644
index 0000000000000000000000000000000000000000..680d1522dc87c222bddc33cbb7bcef290e2dab9a
--- /dev/null
+++ b/include/uapi/linux/ovpn.h
@@ -0,0 +1,109 @@
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
+	OVPN_A_PEER_SOCKET_NETNSID,
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
2.49.0


