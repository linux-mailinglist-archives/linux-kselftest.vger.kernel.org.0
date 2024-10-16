Return-Path: <linux-kselftest+bounces-19793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC5399FDCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 03:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE861C27CA4
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 01:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1615E17B425;
	Wed, 16 Oct 2024 01:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cD7u8pBM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F93101E2
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040630; cv=none; b=rpQ0cgQKMjxzpdSQuT0VI1vZjzPHto3f6LAaaPBxZqTC9UNR9P/WTw8vqaVSUiXQFaxrWEmF1vJznfDVnzOHV8Q+DV+7pw63rkXJo6YLGEksp4UHSKmA502Y+FsuqFOhTHzAro39HS7P9Svn0EHuMKS1JNNx75g6xWJQXj2pS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040630; c=relaxed/simple;
	bh=8TTedho64WVkf+etjwImM6a/MyXEXF8wEct03KN93no=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rnGX2SF/tPb2XsXz5H6Z3rSx5Dcy9uEBpfiJpfAAZAi3LQEYCHf60gmnx1Yi7VXol/rXz4W40oS3vt0R0X3pp2o68gYr8+9e8ON1NWJXr2q1Eb7Lq3inoAyrzaeQ2d0pd+CKNF2OgIlkvqA9xGhhRYanJeogMlUf7w3EkUPsfk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cD7u8pBM; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d325beee2so3603056f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 18:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729040624; x=1729645424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvpwrZueA0V7UBaspnWyx2IRZiwNQrFfUiCVzP6Ifbo=;
        b=cD7u8pBM8AuW7o/86twSBSvXPcPNhM/rXF0w+xe8svrRS3G9a3sbK8qagGpr6uavnX
         xqlL/wUZbJzuyqRc12LJ7kzQlMHTj6KfS8LvaAaIxI1PmeW8rfhPlZ0kI1opxL7ubJ7q
         ETj6Zp0D+wgmqL0o1iwsh8c45ttkWhVS54yqO/vWRk/0/wPJkslhu2iFazJ/HDxMusfh
         53PTjEoq2isUjcDHwIrNmHSQOkdUWCmIRZmniTJ8MWgB9PYxTtP7aUckRLFGl4Qvn7qo
         LdCkMxHATdmkBgQ4zzbTfCdkz5TvWvuBNq+479LYUb8q6ZFGIETSnNALqK76o2Q59I+P
         N/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729040624; x=1729645424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvpwrZueA0V7UBaspnWyx2IRZiwNQrFfUiCVzP6Ifbo=;
        b=sBd7UdoXiqCjbVYUNmuLNoC6twaxUjA7mKJTx6V04rfVf+OQ4bS2iufQYqYWonEE+1
         Wts2Y+bGBS9zFp/j74zgimtUhDZ5EKNzNEFd7dRt0h6/G98xydAVEMds8kGr5oiyDHoP
         eBqyqIFJUHPjBaIst/SEfMA7MUfmG6oGcg26DR/tIvz6FvIPqS09V3qOyeGaYOW1Z+RS
         VjRrk9yMM7RzG1t/2yrSd6d8PWpHCf5xo6jkNMxrHOtxjxZmXmdFtgotcU3KTTYOtJkU
         IdDffeOSrBaPqKEmdpiG34TpII/Uxw1XIzdTLvY8teaQCZgp09dt2nCIC4p3IxCZMetw
         F9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVac4XQfbkrA10YEvAgZ79NrxL2SeaxQKmoXIDG+n2D3uOG2PeId5++KPDD1sowBYcmPO4ThEdy+Cb6FnBqL5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/7L5c4+VKs9jZDKnCxAES4xHkmjB6uR+RunKZ1/wvaOnuyQXn
	TCTICwwdw1eKYLqit9o6xen1/6TUYau48S38ukkT+pEjf2oekjUnAPfZ+Be3s/g=
X-Google-Smtp-Source: AGHT+IER0T/MWTXb3YWPXZE7l9kF722L2gl6K3tr05C1tIWpbubDE/GA9Jkbo9KHB8MXmmV6NYueiQ==
X-Received: by 2002:adf:e504:0:b0:37d:5338:872c with SMTP id ffacd0b85a97d-37d5fec8e0emr7935490f8f.1.1729040624355;
        Tue, 15 Oct 2024 18:03:44 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:4c1a:a7c8:72f5:4282])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm2886765f8f.25.2024.10.15.18.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 18:03:42 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 16 Oct 2024 03:03:03 +0200
Subject: [PATCH net-next v9 03/23] ovpn: add basic netlink support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-b4-ovpn-v9-3-aabe9d225ad5@openvpn.net>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
In-Reply-To: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openvpn-devel@lists.sourceforge.net, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=31145; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=8TTedho64WVkf+etjwImM6a/MyXEXF8wEct03KN93no=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnDxDuvGQnKVPk+V0Fyy+WcNcdXzSNRyRydQ/Od
 aVa54XFCAeJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZw8Q7gAKCRALcOU6oDjV
 h1kVB/9Uo1VNwzYVXh4pP00ByTQ2JZbXVQn3GiSwXNSeaDgPewzGzszuYJIO3SSl9OUyaSw4PSn
 OlH4Y5LplJlJdEKG9qQqDmfs8ZdEbhnKl08fknAgO8SRb8hC6vgstPgaQyN9qftJMj3s3/86v2c
 fA0ZRtDYUOMERUXtM76HHwZnRCtmoy3R2eJKSlF58AuACoRUBO+r23yTM5YrSgs75NgXxoduoJ2
 cqHkn4dWOz0PwjGMqE0kYdD1dirHFhOZRjmky+/744YCsIbYm2EiE9ynOckzG2fQFR32OEplRXl
 DCvRUjygiMdruF2vGlIGiEI5f7XWH86K36aqr0a1Iqk2+zjY
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
 Documentation/netlink/specs/ovpn.yaml | 362 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                           |   2 +
 drivers/net/ovpn/Makefile             |   2 +
 drivers/net/ovpn/main.c               |  15 +-
 drivers/net/ovpn/netlink-gen.c        | 212 ++++++++++++++++++++
 drivers/net/ovpn/netlink-gen.h        |  41 ++++
 drivers/net/ovpn/netlink.c            | 157 +++++++++++++++
 drivers/net/ovpn/netlink.h            |  15 ++
 drivers/net/ovpn/ovpnstruct.h         |  25 +++
 include/uapi/linux/ovpn.h             | 109 ++++++++++
 10 files changed, 939 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..79339c25d607f1b5d15a0a973f6fc23637e158a2
--- /dev/null
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -0,0 +1,362 @@
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
+    entries: [ teardown, userspace, expired, transport-error, transport-disconnect ]
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
+          The unique ID of the peer. To be used to identify peers during
+          operations
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
+          The unique ID of the peer. To be used to identify peers during
+          key operations
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
+          The unique ID of the key. Used to fetch the correct key upon
+          decryption
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
index b6fc8cb11a574caf5589a7d77ab8e90c780fccfa..8edccdabd96ab4a4e8e9ed24d18ecbcd6d33ecec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17473,7 +17473,9 @@ L:	openvpn-devel@lists.sourceforge.net (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
 T:	git https://github.com/OpenVPN/linux-kernel-ovpn.git
+F:	Documentation/netlink/specs/ovpn.yaml
 F:	drivers/net/ovpn/
+F:	include/uapi/linux/ovpn.h
 
 P54 WIRELESS DRIVER
 M:	Christian Lamparter <chunkeey@googlemail.com>
diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 53fb197027d787d6683e9056d3d341abf6ed38e4..201dc001419f1d99ae95c0ee0f96e68f8a4eac16 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -9,3 +9,5 @@
 obj-$(CONFIG_OVPN) := ovpn.o
 ovpn-y += main.o
 ovpn-y += io.o
+ovpn-y += netlink.o
+ovpn-y += netlink-gen.o
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 369a5a2b2fc1a497c8444e59f9b058eb40e49524..d5bdb0055f4dd3a6e32dc6e792bed1e7fd59e101 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,11 +7,15 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <net/rtnetlink.h>
+#include <uapi/linux/ovpn.h>
 
+#include "ovpnstruct.h"
 #include "main.h"
+#include "netlink.h"
 #include "io.h"
 
 /* Driver info */
@@ -37,7 +41,7 @@ static int ovpn_newlink(struct net *src_net, struct net_device *dev,
 }
 
 static struct rtnl_link_ops ovpn_link_ops = {
-	.kind = "ovpn",
+	.kind = OVPN_FAMILY_NAME,
 	.netns_refund = false,
 	.newlink = ovpn_newlink,
 	.dellink = unregister_netdevice_queue,
@@ -93,8 +97,16 @@ static int __init ovpn_init(void)
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
@@ -102,6 +114,7 @@ static int __init ovpn_init(void)
 
 static __exit void ovpn_cleanup(void)
 {
+	ovpn_nl_unregister();
 	rtnl_link_unregister(&ovpn_link_ops);
 	unregister_netdevice_notifier(&ovpn_netdev_notifier);
 
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
new file mode 100644
index 0000000000000000000000000000000000000000..6a43eab9a136cf0d739b9674080d1254a43cf5d0
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
+	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_U32, },
+	[OVPN_A_PEER_REMOTE_IPV6] = NLA_POLICY_EXACT_LEN(16),
+	[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID] = { .type = NLA_U32, },
+	[OVPN_A_PEER_REMOTE_PORT] = NLA_POLICY_MIN(NLA_U16, 1),
+	[OVPN_A_PEER_SOCKET] = { .type = NLA_U32, },
+	[OVPN_A_PEER_VPN_IPV4] = { .type = NLA_U32, },
+	[OVPN_A_PEER_VPN_IPV6] = NLA_POLICY_EXACT_LEN(16),
+	[OVPN_A_PEER_LOCAL_IPV4] = { .type = NLA_U32, },
+	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
+	[OVPN_A_PEER_LOCAL_PORT] = NLA_POLICY_MIN(NLA_U16, 1),
+	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
+	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+	[OVPN_A_PEER_DEL_REASON] = NLA_POLICY_MAX(NLA_U32, 4),
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
index 0000000000000000000000000000000000000000..2cc34eb1d1d870c6705714cb971c3c5dfb04afda
--- /dev/null
+++ b/drivers/net/ovpn/netlink.c
@@ -0,0 +1,157 @@
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
+#include "io.h"
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
+static struct ovpn_struct *
+ovpn_get_dev_from_attrs(struct net *net, const struct genl_info *info)
+{
+	struct ovpn_struct *ovpn;
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
+	struct ovpn_struct *ovpn = ovpn_get_dev_from_attrs(genl_info_net(info),
+							   info);
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
+	struct ovpn_struct *ovpn = info->user_ptr[0];
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
index 0000000000000000000000000000000000000000..e3e4df6418b081436378fc51d98db5bd7b5d1fbe
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
+ * struct ovpn_struct - per ovpn interface state
+ * @dev: the actual netdev representing the tunnel
+ * @dev_tracker: reference tracker for associated dev
+ */
+struct ovpn_struct {
+	struct net_device *dev;
+	netdevice_tracker dev_tracker;
+};
+
+#endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
new file mode 100644
index 0000000000000000000000000000000000000000..7bac0803cd9fd0dde13f4db74acce8d9df5316d8
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


