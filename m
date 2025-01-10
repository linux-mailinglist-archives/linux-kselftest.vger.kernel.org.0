Return-Path: <linux-kselftest+bounces-24247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FE8A09DC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 23:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F2F168EA5
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731D121C9FA;
	Fri, 10 Jan 2025 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ww5jnSg8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E5A215F46
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547979; cv=none; b=mN7EuvQBfylr2lpKe8A3DaOcAKJw3A350xJRI6Y9vSPbD1Xrv56udHf8v5XOmo8QAtroZ55f1U0FuSYpefBDY7rjuRMq5F3H8FMhTAF+4j1odCTpppyIdq3rOUDL+rjcaQBFzLcqQjCWZgAT1mUnLg0qEjvCA1fZwlzCd/aE/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547979; c=relaxed/simple;
	bh=oers48oAIEFz57KkLiHNLy6deMYhfQs1ZxGqLTxfnJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gS1t0xUXnlaX5N3L+jOfh6+OkufkOR0UZDR9SMTjuT0vIr8oSwnPoQNexHqcsJTc/T1GCD8T3tZceyn/Zp8D+zhVZfu7S8yI9iXaRRDKsUQ8KrZLqQ3S9yRu0YSznVKRb+p/jiC7ykVKGqQ+U1LQXrZoApZUbf3GBMXsReG7Dc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ww5jnSg8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385de59c1a0so1334402f8f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736547974; x=1737152774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LctbaGrZg48RX6XfK0iIx+lKwgdPNgod7KT9wnmG0gI=;
        b=Ww5jnSg8hnAnvul30yYi9EixffvBvo7GE7yrQEQmDFlroB05zL0jYoAZpl+5DhIXuc
         77T1yiy7YX59qHREJBQQ+FGHxO9ReOoSpdJCE0dHTtAOoKgtYE+r2gblOjZNrM+ZoIGc
         8Syj+5fgZ52MXOpJ0I+qIuxDP+zzrHIMtUNFtEAZKcBEyopm0dnNSwbPkUQWaCD12VmY
         LDCVr3qK5TY9A68YXrp/2KstAgmxihGrNOuXMgO5nSazQq+fiUzQhnlvjD3c1Q1C4h6i
         0qYxvd7sQa7DN+LYt3gPIecIvVKUni2D1S5t0oVsWfNqcIEcJicbXLmP022T4TwYDbDK
         6iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736547974; x=1737152774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LctbaGrZg48RX6XfK0iIx+lKwgdPNgod7KT9wnmG0gI=;
        b=WPjmNDgtOIFsIcpvmcXFrsiQg7nJ91YtXo7qMwnuegJXBCO6cGAZ0x38aKYAKq6bRw
         E6VL83IUu/F68e9covOlUgZ1q9TPQiwBNDnGrBkvgFNQqtEs/ccUfzVWc7f0FK2dYKzQ
         tHnvuwKKG2b7R1c2sVu57TfQFlvz9CLHY++srqbwotXCEUwx1zREc044ALMwT+ofNkbN
         6utpGv6eLcq53n/t65FiCi6ndMmwwPq0L7QPUfKxLPylOccEJLHBt7/cBQktgAG9zfeO
         SckDn/xvvoUClLzdA9tuWGXRY60uEvhl1m8IEiLBw8EOOhnSfLO0Y1fso3F9mPfgXsDq
         pH9g==
X-Forwarded-Encrypted: i=1; AJvYcCVPKH9mtkbvxFlCN8N6QmqyBskyS4+U3AcuLwbirKg1NATaNCeSr5MbqM5Ewc/q6js8S1Fu99PVrUZ3JVJ+Whw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/prHhCWcihWqzT7xFeWdiuh4zlnuD5TIXXnQK3pyiixGm7NoT
	4vD6jCpSnhrmqcTIT0551+IWdHXNDuJUqcvZtLXBKTwdUzC+DLSGiU9DUefyyM4=
X-Gm-Gg: ASbGncu2BGpoNyXBqyUm3agbxbFMI6XDBEvOH/KMEokeN49vqsYj/GgMfolRn/3JuXS
	G/FBz5zOXosGc51BXsc6cKgeLItQFNTYZZSO0OcVExMfNthkMuT/Mq+9l1QYo5iH2V9x1gAqRhM
	KKfMBojGKzFD7MtS3mdjvwdqOGvgWMUPhlXw+tCVK8URoCN2v1XMt21yshk8vLTw2/lDFsEGH3h
	xXzeLfAXysHoFJIrhiEeSDX2MAdEC3GsUh13WQuQ7T/GpRud+ps5uhlCDuwKK5Cdyj6
X-Google-Smtp-Source: AGHT+IHJFUMO90dxYJNvWbn5XWHwgcnRxM1I/vUaRD08xPTks/28rh0fqCzU2MXgU56xibU+qt/b6A==
X-Received: by 2002:a5d:5f52:0:b0:385:d852:29ed with SMTP id ffacd0b85a97d-38a8732c126mr1501111f8f.36.1736547974046;
        Fri, 10 Jan 2025 14:26:14 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:ef5f:9500:40ad:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm5704340f8f.19.2025.01.10.14.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:26:13 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 10 Jan 2025 23:26:18 +0100
Subject: [PATCH net-next v17 02/25] ovpn: add basic netlink support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-ovpn-v17-2-47b2377e5613@openvpn.net>
References: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
In-Reply-To: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=32289; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=oers48oAIEFz57KkLiHNLy6deMYhfQs1ZxGqLTxfnJI=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBngZ6wmlHlEO1RamE1CjHe/dxu3AsclzLn1fdBl
 W7aI+em+xSJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4GesAAKCRALcOU6oDjV
 h3WPB/4o+Yt8hHBR1B+dYwsL+RN+/E2y+umdeR5GZ2Kug7NcEo3x88cdw6UyguaAV+5J7eANt7n
 vQfX847puP7A9JpAnTd8yHDbAnJ7rDrrWGMJ/dyiutyT+9NKiaq4Zw8ILw4Xa4520YoCol7UGlR
 Oy2Rvjz/lis/CMKlwRGLO2Bz9JXS797Yec6h9n9mQQblHAUpYHJ1HwhHq0jh9VL5EHTKJWSPdHd
 Awd9/cDpUEfgXQMAPLbFRYlDPbv4p+Pe3/3yjWhhaRW2I/BKOaStOEHjQGmadk5WyJtg1gkmrvM
 cX8sTqbBNJ25xcVgJjkaIVPhMVXdqpQ4KXpkC9UOVIqU20Et
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
 Documentation/netlink/specs/ovpn.yaml | 372 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                           |   2 +
 drivers/net/ovpn/Makefile             |   2 +
 drivers/net/ovpn/main.c               |  17 +-
 drivers/net/ovpn/main.h               |  14 ++
 drivers/net/ovpn/netlink-gen.c        | 213 +++++++++++++++++++
 drivers/net/ovpn/netlink-gen.h        |  41 ++++
 drivers/net/ovpn/netlink.c            | 160 +++++++++++++++
 drivers/net/ovpn/netlink.h            |  15 ++
 drivers/net/ovpn/ovpnstruct.h         |  21 ++
 include/uapi/linux/ovpn.h             | 111 ++++++++++
 11 files changed, 967 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a12e741310c275ae8b354c48dbeb67c0e5f7ce66
--- /dev/null
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -0,0 +1,372 @@
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
+        name: ifname
+        type: string
+        doc: Name of the ovpn interface
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
index ddb53e7915ddf71459ca249fd8ac0edea2d571ca..433987a814b36900b1e364598e0edb2d5550dae6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17562,7 +17562,9 @@ L:	openvpn-devel@lists.sourceforge.net (subscribers-only)
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
index 0000000000000000000000000000000000000000..d0e150bbd5cc4a6f43856a58c845af159acda49c
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
index 0000000000000000000000000000000000000000..753af16948684524a9f5de09cf5d0a5e032a3942
--- /dev/null
+++ b/drivers/net/ovpn/netlink.c
@@ -0,0 +1,160 @@
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
+	netdevice_tracker tracker = info->user_ptr[1];
+	struct ovpn_priv *ovpn = info->user_ptr[0];
+
+	if (ovpn)
+		netdev_put(ovpn->dev, &tracker);
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
index 0000000000000000000000000000000000000000..1ac4ab512624c6f9907176f3e546448437a8f07f
--- /dev/null
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -0,0 +1,21 @@
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
index 0000000000000000000000000000000000000000..8ee54aa2f6ebcc949ce9094746c03c1577ea0ea7
--- /dev/null
+++ b/include/uapi/linux/ovpn.h
@@ -0,0 +1,111 @@
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


