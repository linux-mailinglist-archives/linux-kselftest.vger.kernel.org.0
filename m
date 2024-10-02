Return-Path: <linux-kselftest+bounces-18891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE8298CFBE
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87DD1F24FE2
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 09:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED661E1A13;
	Wed,  2 Oct 2024 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PCtecr3E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790F1CF5C4
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859833; cv=none; b=CJ5VDrEURpxGGSfRi0DlyAquUu34UY6O4dRF1fgDDH8ieswWOC7ZcVw0Y+WUdCFypiANzR2Hturlcrzg7qPqZma80sdYIyOYVyHIaWdrBPWSLktxZ1J4uGP3HGxRjQ3LP+4zP3p+qladqNzEUH8maD8Ww13veiTORAoTFIaPU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859833; c=relaxed/simple;
	bh=XY92qSgOIdH22mvRIBRtD0CCzqOqptN+eSBqR7qzpDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gn48CxBZA+lIGNiFs0vXrBtBPfMIfYWpsFiH691j42JFefuI7a5HGjAER7Ppq91jYd6lJzvAnipH1jrQcIPLJbxIqzxkR97v/PQsTr+awqEYDUd2wI5qKvg5puaBMDIrVBvhAMje1U2Seg+2Iqw+ivnnjkmE6rjEM7tRqaseBc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PCtecr3E; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cae102702so48475545e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 02:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859825; x=1728464625; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAZ+fglH7j9NatQp7S1CjF6CSDpmHMs6b4RbuiTSjtk=;
        b=PCtecr3EGsbbytC6tcvSlepFKedO2kt3yTGcre1nccqFHUiLhUDC3f/E9iTu6b5boK
         9tk7x96H6VCx4qraVtPAmwA6yqIvWTyWstVnqCjmi1BU5304yWSDoAoaYl3TcW9IECks
         tG4Pte0hw179J5n2B9UATCA7qHXRQAYhu8Osj7lbcKIQ//osFfKr/m6I0HOkF7LBk+Hr
         34gZJ9zKsk72T4pxjcoqomCkt6W8SR+vKLtq5A/HgOUVydOfhmFMmWt1kul7CJFq5RTY
         P6lMZN1TJ/pQu421SsjXZvP7QEdlTF3fbKvYQEHjJ7lKuviwoOdXfVTg02rkjj4uByLi
         bfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859825; x=1728464625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAZ+fglH7j9NatQp7S1CjF6CSDpmHMs6b4RbuiTSjtk=;
        b=OTOSo2KrFugK1Nw8L7IKcoT8n9lRVK7b1oQNbQZSnr52WNIQim4jlzZnBLtLBWMKBv
         e5nMjdzghaN3ycWJFX0ZpTSNAw2YCczG1/SVaJ9amxtZby8ccSGjL5T4cVuESVP0H1l4
         +K5a7yjgDK/h+Z3UdEM21qKtllVBat+dQCnnlZXUFkrJP9CsSc07TVM7AHX5PkFuboM3
         FGCO0NwPTCk15B0CBL6ibLxUwUjK5n/bX8auCHgbwLMQ1AhbxFMDf1ssT/HX6TDjQTek
         DxcLa2VqcZHRj9cVJdGcVongnD09ZjkdSj61RIfuzOTtwtit5VRyg4dlEGJ0OUygDV2t
         pxsg==
X-Forwarded-Encrypted: i=1; AJvYcCUDkmrcOe4ZPL0v5lXIcEBa6XWfFBoGQ1oVdOCBmDYoSdjhmLjX8WeUFbOyWpXRUNY74Av8i9T4u2nYOQMpJCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLOUl8kqtFfSWJEP7mXZN6/ZI2qo/AIiOqd1L2szdExojnIvhR
	48Alc2x9Gww1CjE/VsnW7zj/k/OK6mm0SmhyCGzrGZcAq61THbZjcxgkLfBqFBo=
X-Google-Smtp-Source: AGHT+IGY1GMDpiIBcjI0eLupe5dPpQlyjULFWV/nyy0zNRTXWjCrI8MZaQz7h4n0XQkNhM+Gr3utbQ==
X-Received: by 2002:a05:600c:4714:b0:425:5ec3:570b with SMTP id 5b1f17b1804b1-42f778ffa8cmr13450435e9.35.1727859824715;
        Wed, 02 Oct 2024 02:03:44 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:44 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:38 +0200
Subject: [PATCH net-next v8 24/24] testing/selftest: add test tool and
 scripts for ovpn module
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-24-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=59505; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=XY92qSgOIdH22mvRIBRtD0CCzqOqptN+eSBqR7qzpDE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxT3xHrgIsBeaGxy/XQ1IJlBpQQljNhIrjMR
 X8oZ+T70eaJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUwAKCRALcOU6oDjV
 h4McB/9ubVry9weXJwjlSvJNhP3CKpJA/gkjMhvVPDwzNktaGxnsTY3Wn2/VI1Jg1SAdoPUefF6
 8neXyDA/kFl1Qsidk8OE1uNnQh/ddcQOJgLqW2VSvSc6pvc9QYuaCiBAY+NWq/3igx8t92aXuj+
 3Q+h+4DQWYAQE4xaxvYe0ORg+8YP3wDe9Te4+yzK+JAxxpCD/J3mJG8xEwiqpYzV6RjrIzXK5KB
 LLxmpQ8vgrXGmGZlgh9QTZCJqUZOHkwzulnt9Fyh+yv7DR4i3PjLMYG7JYWCj35EzoDzv7tlL1j
 nyesnCkeEiQ0LJHTiUaDUbme1VBhvR3E1bOmjG0fgMehw8gC
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

The ovpn-cli tool can be compiled and used as selftest for the ovpn
kernel module.

It implementes the netlink API and can thus be integrated in any
script for more automated testing.

Along with the tool, 2 scripts are added that perform basic
functionality tests by means of network namespaces.

The scripts can be performed in sequence by running run.sh

Cc: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 MAINTAINERS                                       |    1 +
 tools/testing/selftests/Makefile                  |    1 +
 tools/testing/selftests/net/ovpn/.gitignore       |    2 +
 tools/testing/selftests/net/ovpn/Makefile         |   18 +
 tools/testing/selftests/net/ovpn/config           |    8 +
 tools/testing/selftests/net/ovpn/data-test-tcp.sh |    9 +
 tools/testing/selftests/net/ovpn/data-test.sh     |  153 ++
 tools/testing/selftests/net/ovpn/data64.key       |    5 +
 tools/testing/selftests/net/ovpn/float-test.sh    |  118 ++
 tools/testing/selftests/net/ovpn/ovpn-cli.c       | 1822 +++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt    |    5 +
 tools/testing/selftests/net/ovpn/udp_peers.txt    |    5 +
 12 files changed, 2147 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f753060d4e2467a786778ddd4f835861a603ce02..ffd997cc6a1f1fbc5bc954b585bc15ef7bf2486a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17457,6 +17457,7 @@ T:	git https://github.com/OpenVPN/linux-kernel-ovpn.git
 F:	drivers/net/ovpn/
 F:	include/uapi/linux/ovpn.h
 F:	Documentation/netlink/spec/ovpn.yaml
+F:	tools/testing/selftests/net/ovpn/
 
 P54 WIRELESS DRIVER
 M:	Christian Lamparter <chunkeey@googlemail.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b38199965f99014f3e2636fe8d705972f2c0d148..3ae2dd6492ca70d5e317c6e5b4e2560b060e3214 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -68,6 +68,7 @@ TARGETS += net/hsr
 TARGETS += net/mptcp
 TARGETS += net/netfilter
 TARGETS += net/openvswitch
+TARGETS += net/ovpn
 TARGETS += net/packetdrill
 TARGETS += net/rds
 TARGETS += net/tcp_ao
diff --git a/tools/testing/selftests/net/ovpn/.gitignore b/tools/testing/selftests/net/ovpn/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..ee44c081ca7c089933659689303c303a9fa9713b
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0+
+ovpn-cli
diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..65e23eb0ba86d31aa365b08a8c3468dc56a0d1a4
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020-2024 OpenVPN, Inc.
+#
+CFLAGS = -Wall -I../../../../../usr/include
+CFLAGS += $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0)
+
+LDFLAGS = -lmbedtls -lmbedcrypto
+LDFLAGS += $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0)
+
+ovpn-cli: ovpn-cli.c
+	$(CC) -o ovpn-cli ovpn-cli.c $(CFLAGS) $(LDFLAGS)
+
+TEST_PROGS = data-test.sh \
+	data-test-tcp.sh \
+	float-test.sh
+TEST_GEN_FILES = ovpn-cli
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/ovpn/config b/tools/testing/selftests/net/ovpn/config
new file mode 100644
index 0000000000000000000000000000000000000000..5ff47de23c1297a310f0fe39a1ebad16ad014d2c
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/config
@@ -0,0 +1,8 @@
+CONFIG_NET=y
+CONFIG_INET=y
+CONFIG_NET_UDP_TUNNEL=y
+CONFIG_DST_CACHE=y
+CONFIG_CRYPTO_AES=y
+CONFIG_CRYPTO_GCM=y
+CONFIG_CRYPTO_CHACHA20POLY1305=y
+CONFIG_OVPN=y
diff --git a/tools/testing/selftests/net/ovpn/data-test-tcp.sh b/tools/testing/selftests/net/ovpn/data-test-tcp.sh
new file mode 100755
index 0000000000000000000000000000000000000000..65f05659b5fd8f05d216f2c22898e7f89a6ea4de
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/data-test-tcp.sh
@@ -0,0 +1,9 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 OpenVPN, Inc.
+#
+#  Author:	Antonio Quartulli <antonio@openvpn.net>
+
+PROTO="TCP"
+
+source data-test.sh
diff --git a/tools/testing/selftests/net/ovpn/data-test.sh b/tools/testing/selftests/net/ovpn/data-test.sh
new file mode 100755
index 0000000000000000000000000000000000000000..e3401481440165141993767cc94fd6df7a37a52e
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/data-test.sh
@@ -0,0 +1,153 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020-2024 OpenVPN, Inc.
+#
+#  Author:	Antonio Quartulli <antonio@openvpn.net>
+
+#set -x
+set -e
+
+UDP_PEERS_FILE=${UDP_PEERS_FILE:-udp_peers.txt}
+TCP_PEERS_FILE=${TCP_PEERS_FILE:-tcp_peers.txt}
+OVPN_CLI=${OVPN_CLI:-./ovpn-cli}
+ALG=${ALG:-aes}
+PROTO=${PROTO:-UDP}
+
+create_ns() {
+	ip netns add peer${1}
+}
+
+setup_ns() {
+	MODE="P2P"
+
+	if [ ${1} -eq 0 ]; then
+		MODE="MP"
+		for p in $(seq 1 ${NUM_PEERS}); do
+			ip link add veth${p} netns peer0 type veth peer name veth${p} netns peer${p}
+
+			ip -n peer0 addr add 10.10.${p}.1/24 dev veth${p}
+			ip -n peer0 link set veth${p} up
+
+			ip -n peer${p} addr add 10.10.${p}.2/24 dev veth${p}
+			ip -n peer${p} link set veth${p} up
+		done
+	fi
+
+	ip netns exec peer${1} ${OVPN_CLI} new_iface tun${1} $MODE
+	ip -n peer${1} addr add ${2} dev tun${1}
+	ip -n peer${1} link set tun${1} up
+}
+
+add_peer() {
+	if [ "${PROTO}" == "UDP" ]; then
+		if [ ${1} -eq 0 ]; then
+			ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 1 ${UDP_PEERS_FILE}
+
+			for p in $(seq 1 ${NUM_PEERS}); do
+				ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 ${ALG} 0 \
+					data64.key
+			done
+		else
+			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} 1 ${1} 10.10.${1}.1 1
+			ip netns exec peer${1} ${OVPN_CLI} new_key tun${1} ${1} 1 0 ${ALG} 1
+				data64.key
+		fi
+	else
+		if [ ${1} -eq 0 ]; then
+			(ip netns exec peer0 ${OVPN_CLI} listen tun0 1 ${TCP_PEERS_FILE} && {
+				for p in $(seq 1 ${NUM_PEERS}); do
+					ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 \
+						${ALG} 0 data64.key
+				done
+			}) &
+			sleep 5
+		else
+			ip netns exec peer${1} ${OVPN_CLI} connect tun${1} ${1} 10.10.${1}.1 1 \
+				data64.key
+		fi
+	fi
+}
+
+cleanup() {
+	for p in $(seq 1 10); do
+		ip -n peer0 link del veth${p} 2>/dev/null || true
+	done
+	for p in $(seq 0 10); do
+		ip netns exec peer${p} ${OVPN_CLI} del_iface tun${p} 2>/dev/null || true
+		ip netns del peer${p} 2>/dev/null || true
+	done
+}
+
+if [ "${PROTO}" == "UDP" ]; then
+	NUM_PEERS=${NUM_PEERS:-$(wc -l ${UDP_PEERS_FILE} | awk '{print $1}')}
+else
+	NUM_PEERS=${NUM_PEERS:-$(wc -l ${TCP_PEERS_FILE} | awk '{print $1}')}
+fi
+
+cleanup
+
+for p in $(seq 0 ${NUM_PEERS}); do
+	create_ns ${p}
+done
+
+for p in $(seq 0 ${NUM_PEERS}); do
+	setup_ns ${p} 5.5.5.$((${p} + 1))/24
+done
+
+for p in $(seq 0 ${NUM_PEERS}); do
+	add_peer ${p}
+done
+
+for p in $(seq 1 ${NUM_PEERS}); do
+	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} ${p} 60 120
+done
+
+for p in $(seq 1 ${NUM_PEERS}); do
+	ip netns exec peer0 ping -qfc 1000 -w 5 5.5.5.$((${p} + 1))
+done
+
+ip netns exec peer0 iperf3 -1 -s &
+sleep 1
+ip netns exec peer1 iperf3 -Z -t 3 -c 5.5.5.1
+
+for p in $(seq 1 ${NUM_PEERS}); do
+	ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 2 1 ${ALG} 0 data64.key
+	ip netns exec peer${p} ${OVPN_CLI} new_key tun${p} ${p} 2 1 ${ALG} 1 data64.key
+	ip netns exec peer${p} ${OVPN_CLI} swap_keys tun${p} ${p}
+done
+
+sleep 1
+echo "Querying all peers:"
+ip netns exec peer0 ${OVPN_CLI} get_peer tun0
+ip netns exec peer1 ${OVPN_CLI} get_peer tun1
+
+echo "Querying peer 1:"
+ip netns exec peer0 ${OVPN_CLI} get_peer tun0 1
+
+echo "Querying non-existent peer 10:"
+ip netns exec peer0 ${OVPN_CLI} get_peer tun0 10 || true
+
+ip netns exec peer0 ${OVPN_CLI} del_peer tun0 1
+ip netns exec peer1 ${OVPN_CLI} del_peer tun1 1
+
+echo "Setting timeout to 10s MP:"
+# bring ifaces down to prevent traffic being sent
+for p in $(seq 0 ${NUM_PEERS}); do
+	ip -n peer${p} link set tun${p} down
+done
+# set short timeout
+for p in $(seq 2 ${NUM_PEERS}); do
+	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 10 10 || true
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} ${p} 0 0
+done
+# wait for peers to timeout
+sleep 15
+
+echo "Setting timeout to 10s P2P:"
+for p in $(seq 1 ${NUM_PEERS}); do
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} ${p} 10 10
+done
+sleep 15
+
+cleanup
diff --git a/tools/testing/selftests/net/ovpn/data64.key b/tools/testing/selftests/net/ovpn/data64.key
new file mode 100644
index 0000000000000000000000000000000000000000..a99e88c4e290f58b12f399b857b873f308d9ba09
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/data64.key
@@ -0,0 +1,5 @@
+jRqMACN7d7/aFQNT8S7jkrBD8uwrgHbG5OQZP2eu4R1Y7tfpS2bf5RHv06Vi163CGoaIiTX99R3B
+ia9ycAH8Wz1+9PWv51dnBLur9jbShlgZ2QHLtUc4a/gfT7zZwULXuuxdLnvR21DDeMBaTbkgbai9
+uvAa7ne1liIgGFzbv+Bas4HDVrygxIxuAnP5Qgc3648IJkZ0QEXPF+O9f0n5+QIvGCxkAUVx+5K6
+KIs+SoeWXnAopELmoGSjUpFtJbagXK82HfdqpuUxT2Tnuef0/14SzVE/vNleBNu2ZbyrSAaah8tE
+BofkPJUBFY+YQcfZNM5Dgrw3i+Bpmpq/gpdg5w==
diff --git a/tools/testing/selftests/net/ovpn/float-test.sh b/tools/testing/selftests/net/ovpn/float-test.sh
new file mode 100755
index 0000000000000000000000000000000000000000..f370dbe8d40bcd40407a795829289c139cd3740a
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/float-test.sh
@@ -0,0 +1,118 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020-2024 OpenVPN, Inc.
+#
+#  Author:	Antonio Quartulli <antonio@openvpn.net>
+
+#set -x
+set -e
+
+UDP_PEERS_FILE=${UDP_PEERS_FILE:-udp_peers.txt}
+TCP_PEERS_FILE=${TCP_PEERS_FILE:-tcp_peers.txt}
+OVPN_CLI=${OVPN_CLI:-./ovpn-cli}
+ALG=${ALG:-aes}
+PROTO=${PROTO:-UDP}
+
+create_ns() {
+	ip netns add peer${1}
+}
+
+setup_ns() {
+	MODE="P2P"
+
+	if [ ${1} -eq 0 ]; then
+		MODE="MP"
+		for p in $(seq 1 ${NUM_PEERS}); do
+			ip link add veth${p} netns peer0 type veth peer name veth${p} netns peer${p}
+
+			ip -n peer0 addr add 10.10.${p}.1/24 dev veth${p}
+			ip -n peer0 link set veth${p} up
+
+			ip -n peer${p} addr add 10.10.${p}.2/24 dev veth${p}
+			ip -n peer${p} link set veth${p} up
+		done
+	fi
+
+	ip netns exec peer${1} ${OVPN_CLI} new_iface tun${1} $MODE
+	ip -n peer${1} addr add ${2} dev tun${1}
+	ip -n peer${1} link set tun${1} up
+}
+
+add_peer() {
+	if [ "${PROTO}" == "UDP" ]; then
+		if [ ${1} -eq 0 ]; then
+			ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 1 ${UDP_PEERS_FILE}
+
+			for p in $(seq 1 ${NUM_PEERS}); do
+				ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 ${ALG} 0 \
+					data64.key
+			done
+		else
+			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} 1 ${1} 10.10.${1}.1 1
+			ip netns exec peer${1} ${OVPN_CLI} new_key tun${1} ${1} 1 0 ${ALG} 1 \
+				data64.key
+		fi
+	else
+		if [ ${1} -eq 0 ]; then
+			(ip netns exec peer0 ${OVPN_CLI} listen tun0 1 ${TCP_PEERS_FILE} && {
+				for p in $(seq 1 ${NUM_PEERS}); do
+					ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 \
+						${ALG} 0 data64.key
+				done
+			}) &
+			sleep 5
+		else
+			ip netns exec peer${1} ${OVPN_CLI} connect tun${1} ${1} 10.10.${1}.1 1 \
+				5.5.5.1 data64.key
+		fi
+	fi
+}
+
+cleanup() {
+	for p in $(seq 1 10); do
+		ip -n peer0 link del veth${p} 2>/dev/null || true
+	done
+	for p in $(seq 0 10); do
+		ip netns exec peer${p} ${OVPN_CLI} del_iface tun${p} 2>/dev/null || true
+		ip netns del peer${p} 2>/dev/null || true
+	done
+}
+
+if [ "${PROTO}" == "UDP" ]; then
+	NUM_PEERS=${NUM_PEERS:-$(wc -l ${UDP_PEERS_FILE} | awk '{print $1}')}
+else
+	NUM_PEERS=${NUM_PEERS:-$(wc -l ${TCP_PEERS_FILE} | awk '{print $1}')}
+fi
+
+cleanup
+
+for p in $(seq 0 ${NUM_PEERS}); do
+	create_ns ${p}
+done
+
+for p in $(seq 0 ${NUM_PEERS}); do
+	setup_ns ${p} 5.5.5.$((${p} + 1))/24
+done
+
+for p in $(seq 0 ${NUM_PEERS}); do
+	add_peer ${p}
+done
+
+for p in $(seq 1 ${NUM_PEERS}); do
+	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} ${p} 60 120
+done
+
+for p in $(seq 1 ${NUM_PEERS}); do
+	ip netns exec peer0 ping -qfc 1000 -w 5 5.5.5.$((${p} + 1))
+done
+# make clients float..
+for p in $(seq 1 ${NUM_PEERS}); do
+	ip -n peer${p} addr del 10.10.${p}.2/24 dev veth${p}
+	ip -n peer${p} addr add 10.10.${p}.3/24 dev veth${p}
+done
+for p in $(seq 1 ${NUM_PEERS}); do
+	ip netns exec peer${p} ping -qfc 1000 -w 5 5.5.5.1
+done
+
+cleanup
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
new file mode 100644
index 0000000000000000000000000000000000000000..9736e78a92e580ec64db9a96fd45b27c1d457e1c
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -0,0 +1,1822 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel accelerator
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <arpa/inet.h>
+#include <net/if.h>
+#include <netinet/in.h>
+
+#include <linux/ovpn.h>
+#include <linux/types.h>
+#include <linux/netlink.h>
+
+#include <netlink/socket.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+
+#include <mbedtls/base64.h>
+#include <mbedtls/error.h>
+
+#include <sys/socket.h>
+
+/* we use strscpy to make checkpatch happy */
+#define strscpy strncpy
+
+/* libnl < 3.5.0 does not set the NLA_F_NESTED on its own, therefore we
+ * have to explicitly do it to prevent the kernel from failing upon
+ * parsing of the message
+ */
+#define nla_nest_start(_msg, _type) \
+	nla_nest_start(_msg, (_type) | NLA_F_NESTED)
+
+uint64_t nla_get_uint(struct nlattr *attr)
+{
+	if (nla_len(attr) == sizeof(uint32_t))
+		return nla_get_u32(attr);
+	else
+		return nla_get_u64(attr);
+}
+
+typedef int (*ovpn_nl_cb)(struct nl_msg *msg, void *arg);
+
+enum ovpn_key_direction {
+	KEY_DIR_IN = 0,
+	KEY_DIR_OUT,
+};
+
+#define KEY_LEN (256 / 8)
+#define NONCE_LEN 8
+
+#define PEER_ID_UNDEF 0x00FFFFFF
+
+struct nl_ctx {
+	struct nl_sock *nl_sock;
+	struct nl_msg *nl_msg;
+	struct nl_cb *nl_cb;
+
+	int ovpn_dco_id;
+};
+
+struct ovpn_ctx {
+	__u8 key_enc[KEY_LEN];
+	__u8 key_dec[KEY_LEN];
+	__u8 nonce[NONCE_LEN];
+
+	enum ovpn_cipher_alg cipher;
+
+	sa_family_t sa_family;
+
+	__u32 peer_id;
+	__u16 lport;
+
+	union {
+		struct sockaddr_in in4;
+		struct sockaddr_in6 in6;
+	} remote;
+
+	union {
+		struct sockaddr_in in4;
+		struct sockaddr_in6 in6;
+	} peer_ip;
+
+	bool peer_ip_set;
+
+	unsigned int ifindex;
+	char ifname[IFNAMSIZ];
+	enum ovpn_mode mode;
+	bool mode_set;
+
+	int socket;
+	int cli_socket;
+
+	__u32 keepalive_interval;
+	__u32 keepalive_timeout;
+
+	enum ovpn_key_direction key_dir;
+	enum ovpn_key_slot key_slot;
+	int key_id;
+};
+
+static int ovpn_nl_recvmsgs(struct nl_ctx *ctx)
+{
+	int ret;
+
+	ret = nl_recvmsgs(ctx->nl_sock, ctx->nl_cb);
+
+	switch (ret) {
+	case -NLE_INTR:
+		fprintf(stderr,
+			"netlink received interrupt due to signal - ignoring\n");
+		break;
+	case -NLE_NOMEM:
+		fprintf(stderr, "netlink out of memory error\n");
+		break;
+	case -NLE_AGAIN:
+		fprintf(stderr,
+			"netlink reports blocking read - aborting wait\n");
+		break;
+	default:
+		if (ret)
+			fprintf(stderr, "netlink reports error (%d): %s\n",
+				ret, nl_geterror(-ret));
+		break;
+	}
+
+	return ret;
+}
+
+static struct nl_ctx *nl_ctx_alloc_flags(struct ovpn_ctx *ovpn, int cmd,
+					 int flags)
+{
+	struct nl_ctx *ctx;
+	int err, ret;
+
+	ctx = calloc(1, sizeof(*ctx));
+	if (!ctx)
+		return NULL;
+
+	ctx->nl_sock = nl_socket_alloc();
+	if (!ctx->nl_sock) {
+		fprintf(stderr, "cannot allocate netlink socket\n");
+		goto err_free;
+	}
+
+	nl_socket_set_buffer_size(ctx->nl_sock, 8192, 8192);
+
+	ret = genl_connect(ctx->nl_sock);
+	if (ret) {
+		fprintf(stderr, "cannot connect to generic netlink: %s\n",
+			nl_geterror(ret));
+		goto err_sock;
+	}
+
+	/* enable Extended ACK for detailed error reporting */
+	err = 1;
+	setsockopt(nl_socket_get_fd(ctx->nl_sock), SOL_NETLINK, NETLINK_EXT_ACK,
+		   &err, sizeof(err));
+
+	ctx->ovpn_dco_id = genl_ctrl_resolve(ctx->nl_sock, OVPN_FAMILY_NAME);
+	if (ctx->ovpn_dco_id < 0) {
+		fprintf(stderr, "cannot find ovpn_dco netlink component: %d\n",
+			ctx->ovpn_dco_id);
+		goto err_free;
+	}
+
+	ctx->nl_msg = nlmsg_alloc();
+	if (!ctx->nl_msg) {
+		fprintf(stderr, "cannot allocate netlink message\n");
+		goto err_sock;
+	}
+
+	ctx->nl_cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!ctx->nl_cb) {
+		fprintf(stderr, "failed to allocate netlink callback\n");
+		goto err_msg;
+	}
+
+	nl_socket_set_cb(ctx->nl_sock, ctx->nl_cb);
+
+	genlmsg_put(ctx->nl_msg, 0, 0, ctx->ovpn_dco_id, 0, flags, cmd, 0);
+
+	if (ovpn->ifindex > 0)
+		NLA_PUT_U32(ctx->nl_msg, OVPN_A_IFINDEX, ovpn->ifindex);
+
+	return ctx;
+nla_put_failure:
+err_msg:
+	nlmsg_free(ctx->nl_msg);
+err_sock:
+	nl_socket_free(ctx->nl_sock);
+err_free:
+	free(ctx);
+	return NULL;
+}
+
+static struct nl_ctx *nl_ctx_alloc(struct ovpn_ctx *ovpn, int cmd)
+{
+	return nl_ctx_alloc_flags(ovpn, cmd, 0);
+}
+
+static void nl_ctx_free(struct nl_ctx *ctx)
+{
+	if (!ctx)
+		return;
+
+	nl_socket_free(ctx->nl_sock);
+	nlmsg_free(ctx->nl_msg);
+	nl_cb_put(ctx->nl_cb);
+	free(ctx);
+}
+
+static int ovpn_nl_cb_error(struct sockaddr_nl (*nla)__always_unused,
+			    struct nlmsgerr *err, void *arg)
+{
+	struct nlmsghdr *nlh = (struct nlmsghdr *)err - 1;
+	struct nlattr *tb_msg[NLMSGERR_ATTR_MAX + 1];
+	int len = nlh->nlmsg_len;
+	struct nlattr *attrs;
+	int *ret = arg;
+	int ack_len = sizeof(*nlh) + sizeof(int) + sizeof(*nlh);
+
+	*ret = err->error;
+
+	if (!(nlh->nlmsg_flags & NLM_F_ACK_TLVS))
+		return NL_STOP;
+
+	if (!(nlh->nlmsg_flags & NLM_F_CAPPED))
+		ack_len += err->msg.nlmsg_len - sizeof(*nlh);
+
+	if (len <= ack_len)
+		return NL_STOP;
+
+	attrs = (void *)((unsigned char *)nlh + ack_len);
+	len -= ack_len;
+
+	nla_parse(tb_msg, NLMSGERR_ATTR_MAX, attrs, len, NULL);
+	if (tb_msg[NLMSGERR_ATTR_MSG]) {
+		len = strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),
+			      nla_len(tb_msg[NLMSGERR_ATTR_MSG]));
+		fprintf(stderr, "kernel error: %*s\n", len,
+			(char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]));
+	}
+
+	if (tb_msg[NLMSGERR_ATTR_MISS_NEST]) {
+		fprintf(stderr, "missing required nesting type %u\n",
+			nla_get_u32(tb_msg[NLMSGERR_ATTR_MISS_NEST]));
+	}
+
+	if (tb_msg[NLMSGERR_ATTR_MISS_TYPE]) {
+		fprintf(stderr, "missing required attribute type %u\n",
+			nla_get_u32(tb_msg[NLMSGERR_ATTR_MISS_TYPE]));
+	}
+
+	return NL_STOP;
+}
+
+static int ovpn_nl_cb_finish(struct nl_msg (*msg)__always_unused,
+			     void *arg)
+{
+	int *status = arg;
+
+	*status = 0;
+	return NL_SKIP;
+}
+
+static int ovpn_nl_cb_ack(struct nl_msg (*msg)__always_unused,
+			  void *arg)
+{
+	int *status = arg;
+
+	*status = 0;
+	return NL_STOP;
+}
+
+static int ovpn_nl_msg_send(struct nl_ctx *ctx, ovpn_nl_cb cb)
+{
+	int status = 1;
+
+	nl_cb_err(ctx->nl_cb, NL_CB_CUSTOM, ovpn_nl_cb_error, &status);
+	nl_cb_set(ctx->nl_cb, NL_CB_FINISH, NL_CB_CUSTOM, ovpn_nl_cb_finish,
+		  &status);
+	nl_cb_set(ctx->nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_ack, &status);
+
+	if (cb)
+		nl_cb_set(ctx->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, cb, ctx);
+
+	nl_send_auto_complete(ctx->nl_sock, ctx->nl_msg);
+
+	while (status == 1)
+		ovpn_nl_recvmsgs(ctx);
+
+	if (status < 0)
+		fprintf(stderr, "failed to send netlink message: %s (%d)\n",
+			strerror(-status), status);
+
+	return status;
+}
+
+static int ovpn_read_key(const char *file, struct ovpn_ctx *ctx)
+{
+	int idx_enc, idx_dec, ret = -1;
+	unsigned char *ckey = NULL;
+	__u8 *bkey = NULL;
+	size_t olen = 0;
+	long ckey_len;
+	FILE *fp;
+
+	fp = fopen(file, "r");
+	if (!fp) {
+		fprintf(stderr, "cannot open: %s\n", file);
+		return -1;
+	}
+
+	/* get file size */
+	fseek(fp, 0L, SEEK_END);
+	ckey_len = ftell(fp);
+	rewind(fp);
+
+	/* if the file is longer, let's just read a portion */
+	if (ckey_len > 256)
+		ckey_len = 256;
+
+	ckey = malloc(ckey_len);
+	if (!ckey)
+		goto err;
+
+	ret = fread(ckey, 1, ckey_len, fp);
+	if (ret != ckey_len) {
+		fprintf(stderr,
+			"couldn't read enough data from key file: %dbytes read\n",
+			ret);
+		goto err;
+	}
+
+	olen = 0;
+	ret = mbedtls_base64_decode(NULL, 0, &olen, ckey, ckey_len);
+	if (ret != MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL) {
+		char buf[256];
+
+		mbedtls_strerror(ret, buf, sizeof(buf));
+		fprintf(stderr, "unexpected base64 error1: %s (%d)\n", buf,
+			ret);
+
+		goto err;
+	}
+
+	bkey = malloc(olen);
+	if (!bkey) {
+		fprintf(stderr, "cannot allocate binary key buffer\n");
+		goto err;
+	}
+
+	ret = mbedtls_base64_decode(bkey, olen, &olen, ckey, ckey_len);
+	if (ret) {
+		char buf[256];
+
+		mbedtls_strerror(ret, buf, sizeof(buf));
+		fprintf(stderr, "unexpected base64 error2: %s (%d)\n", buf,
+			ret);
+
+		goto err;
+	}
+
+	if (olen < 2 * KEY_LEN + NONCE_LEN) {
+		fprintf(stderr,
+			"not enough data in key file, found %zdB but needs %dB\n",
+			olen, 2 * KEY_LEN + NONCE_LEN);
+		goto err;
+	}
+
+	switch (ctx->key_dir) {
+	case KEY_DIR_IN:
+		idx_enc = 0;
+		idx_dec = 1;
+		break;
+	case KEY_DIR_OUT:
+		idx_enc = 1;
+		idx_dec = 0;
+		break;
+	}
+
+	memcpy(ctx->key_enc, bkey + KEY_LEN * idx_enc, KEY_LEN);
+	memcpy(ctx->key_dec, bkey + KEY_LEN * idx_dec, KEY_LEN);
+	memcpy(ctx->nonce, bkey + 2 * KEY_LEN, NONCE_LEN);
+
+	ret = 0;
+
+err:
+	fclose(fp);
+	free(bkey);
+	free(ckey);
+
+	return ret;
+}
+
+static int ovpn_read_cipher(const char *cipher, struct ovpn_ctx *ctx)
+{
+	if (strcmp(cipher, "aes") == 0)
+		ctx->cipher = OVPN_CIPHER_ALG_AES_GCM;
+	else if (strcmp(cipher, "chachapoly") == 0)
+		ctx->cipher = OVPN_CIPHER_ALG_CHACHA20_POLY1305;
+	else if (strcmp(cipher, "none") == 0)
+		ctx->cipher = OVPN_CIPHER_ALG_NONE;
+	else
+		return -ENOTSUP;
+
+	return 0;
+}
+
+static int ovpn_read_key_direction(const char *dir, struct ovpn_ctx *ctx)
+{
+	int in_dir;
+
+	in_dir = strtoll(dir, NULL, 10);
+	switch (in_dir) {
+	case KEY_DIR_IN:
+	case KEY_DIR_OUT:
+		ctx->key_dir = in_dir;
+		break;
+	default:
+		fprintf(stderr,
+			"invalid key direction provided. Can be 0 or 1 only\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
+{
+	struct sockaddr_storage local_sock;
+	struct sockaddr_in6 *in6;
+	struct sockaddr_in *in;
+	int ret, s, sock_type;
+	size_t sock_len;
+
+	if (proto == IPPROTO_UDP)
+		sock_type = SOCK_DGRAM;
+	else if (proto == IPPROTO_TCP)
+		sock_type = SOCK_STREAM;
+	else
+		return -EINVAL;
+
+	s = socket(family, sock_type, 0);
+	if (s < 0) {
+		perror("cannot create socket");
+		return -1;
+	}
+
+	memset((char *)&local_sock, 0, sizeof(local_sock));
+
+	switch (family) {
+	case AF_INET:
+		in = (struct sockaddr_in *)&local_sock;
+		in->sin_family = family;
+		in->sin_port = htons(ctx->lport);
+		in->sin_addr.s_addr = htonl(INADDR_ANY);
+		sock_len = sizeof(*in);
+		break;
+	case AF_INET6:
+		in6 = (struct sockaddr_in6 *)&local_sock;
+		in6->sin6_family = family;
+		in6->sin6_port = htons(ctx->lport);
+		in6->sin6_addr = in6addr_any;
+		sock_len = sizeof(*in6);
+		break;
+	default:
+		return -1;
+	}
+
+	int opt = 1;
+
+	ret = setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
+
+	if (ret < 0) {
+		perror("setsockopt for SO_REUSEADDR");
+		return ret;
+	}
+
+	ret = setsockopt(s, SOL_SOCKET, SO_REUSEPORT, &opt, sizeof(opt));
+	if (ret < 0) {
+		perror("setsockopt for SO_REUSEPORT");
+		return ret;
+	}
+
+	if (family == AF_INET6) {
+		opt = 0;
+		if (setsockopt(s, IPPROTO_IPV6, IPV6_V6ONLY, &opt,
+			       sizeof(opt))) {
+			perror("failed to set IPV6_V6ONLY");
+			return -1;
+		}
+	}
+
+	ret = bind(s, (struct sockaddr *)&local_sock, sock_len);
+	if (ret < 0) {
+		perror("cannot bind socket");
+		goto err_socket;
+	}
+
+	ctx->socket = s;
+	ctx->sa_family = family;
+	return 0;
+
+err_socket:
+	close(s);
+	return -1;
+}
+
+static int ovpn_udp_socket(struct ovpn_ctx *ctx, sa_family_t family)
+{
+	return ovpn_socket(ctx, family, IPPROTO_UDP);
+}
+
+static int ovpn_listen(struct ovpn_ctx *ctx, sa_family_t family)
+{
+	int ret;
+
+	ret = ovpn_socket(ctx, family, IPPROTO_TCP);
+	if (ret < 0)
+		return ret;
+
+	ret = listen(ctx->socket, 10);
+	if (ret < 0) {
+		perror("listen");
+		close(ctx->socket);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int ovpn_accept(struct ovpn_ctx *ctx)
+{
+	socklen_t socklen;
+	int ret;
+
+	socklen = sizeof(ctx->remote);
+	ret = accept(ctx->socket, (struct sockaddr *)&ctx->remote, &socklen);
+	if (ret < 0) {
+		perror("accept");
+		goto err;
+	}
+
+	fprintf(stderr, "Connection received!\n");
+
+	switch (socklen) {
+	case sizeof(struct sockaddr_in):
+	case sizeof(struct sockaddr_in6):
+		break;
+	default:
+		fprintf(stderr, "error: expecting IPv4 or IPv6 connection\n");
+		close(ret);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	return ret;
+err:
+	close(ctx->socket);
+	return ret;
+}
+
+static int ovpn_connect(struct ovpn_ctx *ovpn)
+{
+	socklen_t socklen;
+	int s, ret;
+
+	s = socket(ovpn->remote.in4.sin_family, SOCK_STREAM, 0);
+	if (s < 0) {
+		perror("cannot create socket");
+		return -1;
+	}
+
+	switch (ovpn->remote.in4.sin_family) {
+	case AF_INET:
+		socklen = sizeof(struct sockaddr_in);
+		break;
+	case AF_INET6:
+		socklen = sizeof(struct sockaddr_in6);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ret = connect(s, (struct sockaddr *)&ovpn->remote, socklen);
+	if (ret < 0) {
+		perror("connect");
+		goto err;
+	}
+
+	fprintf(stderr, "connected\n");
+
+	ovpn->socket = s;
+
+	return 0;
+err:
+	close(s);
+	return ret;
+}
+
+static int ovpn_new_peer(struct ovpn_ctx *ovpn, bool is_tcp)
+{
+	struct nlattr *attr;
+	struct nl_ctx *ctx;
+	int ret = -1;
+
+	ctx = nl_ctx_alloc(ovpn, OVPN_CMD_PEER_NEW);
+	if (!ctx)
+		return -ENOMEM;
+
+	attr = nla_nest_start(ctx->nl_msg, OVPN_A_PEER);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_ID, ovpn->peer_id);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_SOCKET, ovpn->socket);
+
+	if (!is_tcp) {
+		switch (ovpn->remote.in4.sin_family) {
+		case AF_INET:
+			NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_REMOTE_IPV4,
+				    ovpn->remote.in4.sin_addr.s_addr);
+			NLA_PUT_U16(ctx->nl_msg, OVPN_A_PEER_REMOTE_PORT,
+				    ovpn->remote.in4.sin_port);
+			break;
+		case AF_INET6:
+			NLA_PUT(ctx->nl_msg, OVPN_A_PEER_REMOTE_IPV6,
+				sizeof(ovpn->remote.in6.sin6_addr),
+				&ovpn->remote.in6.sin6_addr);
+			NLA_PUT_U32(ctx->nl_msg,
+				    OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
+				    ovpn->remote.in6.sin6_scope_id);
+			NLA_PUT_U16(ctx->nl_msg, OVPN_A_PEER_REMOTE_PORT,
+				    ovpn->remote.in6.sin6_port);
+			break;
+		default:
+			fprintf(stderr,
+				"Invalid family for remote socket address\n");
+			goto nla_put_failure;
+		}
+	}
+
+	if (ovpn->peer_ip_set) {
+		switch (ovpn->peer_ip.in4.sin_family) {
+		case AF_INET:
+			NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_VPN_IPV4,
+				    ovpn->peer_ip.in4.sin_addr.s_addr);
+			break;
+		case AF_INET6:
+			NLA_PUT(ctx->nl_msg, OVPN_A_PEER_VPN_IPV6,
+				sizeof(struct in6_addr),
+				&ovpn->peer_ip.in6.sin6_addr);
+			break;
+		default:
+			fprintf(stderr, "Invalid family for peer address\n");
+			goto nla_put_failure;
+		}
+	}
+
+	nla_nest_end(ctx->nl_msg, attr);
+
+	ret = ovpn_nl_msg_send(ctx, NULL);
+nla_put_failure:
+	nl_ctx_free(ctx);
+	return ret;
+}
+
+static int ovpn_set_peer(struct ovpn_ctx *ovpn)
+{
+	struct nlattr *attr;
+	struct nl_ctx *ctx;
+	int ret = -1;
+
+	ctx = nl_ctx_alloc(ovpn, OVPN_CMD_PEER_SET);
+	if (!ctx)
+		return -ENOMEM;
+
+	attr = nla_nest_start(ctx->nl_msg, OVPN_A_PEER);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_ID, ovpn->peer_id);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_KEEPALIVE_INTERVAL,
+		    ovpn->keepalive_interval);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_KEEPALIVE_TIMEOUT,
+		    ovpn->keepalive_timeout);
+	nla_nest_end(ctx->nl_msg, attr);
+
+	ret = ovpn_nl_msg_send(ctx, NULL);
+nla_put_failure:
+	nl_ctx_free(ctx);
+	return ret;
+}
+
+static int ovpn_del_peer(struct ovpn_ctx *ovpn)
+{
+	struct nlattr *attr;
+	struct nl_ctx *ctx;
+	int ret = -1;
+
+	ctx = nl_ctx_alloc(ovpn, OVPN_CMD_PEER_DEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	attr = nla_nest_start(ctx->nl_msg, OVPN_A_PEER);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_ID, ovpn->peer_id);
+	nla_nest_end(ctx->nl_msg, attr);
+
+	ret = ovpn_nl_msg_send(ctx, NULL);
+nla_put_failure:
+	nl_ctx_free(ctx);
+	return ret;
+}
+
+static int ovpn_handle_peer(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *pattrs[OVPN_A_PEER_MAX + 1];
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *attrs[OVPN_A_MAX + 1];
+	__u16 rport = 0, lport = 0;
+
+	nla_parse(attrs, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),
+		  genlmsg_attrlen(gnlh, 0), NULL);
+
+	if (!attrs[OVPN_A_PEER]) {
+		fprintf(stderr, "no packet content in netlink message\n");
+		return NL_SKIP;
+	}
+
+	nla_parse(pattrs, OVPN_A_PEER_MAX, nla_data(attrs[OVPN_A_PEER]),
+		  nla_len(attrs[OVPN_A_PEER]), NULL);
+
+	if (pattrs[OVPN_A_PEER_ID])
+		fprintf(stderr, "* Peer %u\n",
+			nla_get_u32(pattrs[OVPN_A_PEER_ID]));
+
+	if (pattrs[OVPN_A_PEER_VPN_IPV4]) {
+		char buf[INET_ADDRSTRLEN];
+
+		inet_ntop(AF_INET, nla_data(pattrs[OVPN_A_PEER_VPN_IPV4]),
+			  buf, sizeof(buf));
+		fprintf(stderr, "\tVPN IPv4: %s\n", buf);
+	}
+
+	if (pattrs[OVPN_A_PEER_VPN_IPV6]) {
+		char buf[INET6_ADDRSTRLEN];
+
+		inet_ntop(AF_INET6, nla_data(pattrs[OVPN_A_PEER_VPN_IPV6]),
+			  buf, sizeof(buf));
+		fprintf(stderr, "\tVPN IPv6: %s\n", buf);
+	}
+
+	if (pattrs[OVPN_A_PEER_LOCAL_PORT])
+		lport = ntohs(nla_get_u16(pattrs[OVPN_A_PEER_LOCAL_PORT]));
+
+	if (pattrs[OVPN_A_PEER_REMOTE_PORT])
+		rport = ntohs(nla_get_u16(pattrs[OVPN_A_PEER_REMOTE_PORT]));
+
+	if (pattrs[OVPN_A_PEER_REMOTE_IPV6]) {
+		void *ip = pattrs[OVPN_A_PEER_REMOTE_IPV6];
+		char buf[INET6_ADDRSTRLEN];
+		int scope_id = -1;
+
+		if (pattrs[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID]) {
+			void *p = pattrs[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID];
+
+			scope_id = nla_get_u32(p);
+		}
+
+		inet_ntop(AF_INET6, nla_data(ip), buf, sizeof(buf));
+		fprintf(stderr, "\tRemote: %s:%hu (scope-id: %u)\n", buf, rport,
+			scope_id);
+
+		if (pattrs[OVPN_A_PEER_LOCAL_IPV6]) {
+			void *ip = pattrs[OVPN_A_PEER_LOCAL_IPV6];
+
+			inet_ntop(AF_INET6, nla_data(ip), buf, sizeof(buf));
+			fprintf(stderr, "\tLocal: %s:%hu\n", buf, lport);
+		}
+	}
+
+	if (pattrs[OVPN_A_PEER_REMOTE_IPV4]) {
+		void *ip = pattrs[OVPN_A_PEER_REMOTE_IPV4];
+		char buf[INET_ADDRSTRLEN];
+
+		inet_ntop(AF_INET, nla_data(ip), buf, sizeof(buf));
+		fprintf(stderr, "\tRemote: %s:%hu\n", buf, rport);
+
+		if (pattrs[OVPN_A_PEER_LOCAL_IPV4]) {
+			void *p = pattrs[OVPN_A_PEER_LOCAL_IPV4];
+
+			inet_ntop(AF_INET, nla_data(p), buf, sizeof(buf));
+			fprintf(stderr, "\tLocal: %s:%hu\n", buf, lport);
+		}
+	}
+
+	if (pattrs[OVPN_A_PEER_KEEPALIVE_INTERVAL]) {
+		void *p = pattrs[OVPN_A_PEER_KEEPALIVE_INTERVAL];
+
+		fprintf(stderr, "\tKeepalive interval: %u sec\n",
+			nla_get_u32(p));
+	}
+
+	if (pattrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT])
+		fprintf(stderr, "\tKeepalive timeout: %u sec\n",
+			nla_get_u32(pattrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]));
+
+	if (pattrs[OVPN_A_PEER_VPN_RX_BYTES])
+		fprintf(stderr, "\tVPN RX bytes: %" PRIu64 "\n",
+			nla_get_uint(pattrs[OVPN_A_PEER_VPN_RX_BYTES]));
+
+	if (pattrs[OVPN_A_PEER_VPN_TX_BYTES])
+		fprintf(stderr, "\tVPN TX bytes: %" PRIu64 "\n",
+			nla_get_uint(pattrs[OVPN_A_PEER_VPN_TX_BYTES]));
+
+	if (pattrs[OVPN_A_PEER_VPN_RX_PACKETS])
+		fprintf(stderr, "\tVPN RX packets: %" PRIu64 "\n",
+			nla_get_uint(pattrs[OVPN_A_PEER_VPN_RX_PACKETS]));
+
+	if (pattrs[OVPN_A_PEER_VPN_TX_PACKETS])
+		fprintf(stderr, "\tVPN TX packets: %" PRIu64 "\n",
+			nla_get_uint(pattrs[OVPN_A_PEER_VPN_TX_PACKETS]));
+
+	if (pattrs[OVPN_A_PEER_LINK_RX_BYTES])
+		fprintf(stderr, "\tLINK RX bytes: %" PRIu64 "\n",
+			nla_get_uint(pattrs[OVPN_A_PEER_LINK_RX_BYTES]));
+
+	if (pattrs[OVPN_A_PEER_LINK_TX_BYTES])
+		fprintf(stderr, "\tLINK TX bytes: %" PRIu64 "\n",
+			nla_get_uint(pattrs[OVPN_A_PEER_LINK_TX_BYTES]));
+
+	if (pattrs[OVPN_A_PEER_LINK_RX_PACKETS])
+		fprintf(stderr, "\tLINK RX packets: %" PRIu64 "\n",
+			nla_get_uint(pattrs[OVPN_A_PEER_LINK_RX_PACKETS]));
+
+	if (pattrs[OVPN_A_PEER_LINK_TX_PACKETS])
+		fprintf(stderr, "\tLINK TX packets: %" PRIu64 "\n",
+			nla_get_uint(pattrs[OVPN_A_PEER_LINK_TX_PACKETS]));
+
+	return NL_SKIP;
+}
+
+static int ovpn_get_peer(struct ovpn_ctx *ovpn)
+{
+	int flags = 0, ret = -1;
+	struct nlattr *attr;
+	struct nl_ctx *ctx;
+
+	if (ovpn->peer_id == PEER_ID_UNDEF)
+		flags = NLM_F_DUMP;
+
+	ctx = nl_ctx_alloc_flags(ovpn, OVPN_CMD_PEER_GET, flags);
+	if (!ctx)
+		return -ENOMEM;
+
+	if (ovpn->peer_id != PEER_ID_UNDEF) {
+		attr = nla_nest_start(ctx->nl_msg, OVPN_A_PEER);
+		NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_ID, ovpn->peer_id);
+		nla_nest_end(ctx->nl_msg, attr);
+	}
+
+	ret = ovpn_nl_msg_send(ctx, ovpn_handle_peer);
+nla_put_failure:
+	nl_ctx_free(ctx);
+	return ret;
+}
+
+static int ovpn_new_key(struct ovpn_ctx *ovpn)
+{
+	struct nlattr *keyconf, *key_dir;
+	struct nl_ctx *ctx;
+	int ret = -1;
+
+	ctx = nl_ctx_alloc(ovpn, OVPN_CMD_KEY_NEW);
+	if (!ctx)
+		return -ENOMEM;
+
+	keyconf = nla_nest_start(ctx->nl_msg, OVPN_A_KEYCONF);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_KEYCONF_PEER_ID, ovpn->peer_id);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_KEYCONF_SLOT, ovpn->key_slot);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_KEYCONF_KEY_ID, ovpn->key_id);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_KEYCONF_CIPHER_ALG, ovpn->cipher);
+
+	key_dir = nla_nest_start(ctx->nl_msg, OVPN_A_KEYCONF_ENCRYPT_DIR);
+	NLA_PUT(ctx->nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, KEY_LEN, ovpn->key_enc);
+	NLA_PUT(ctx->nl_msg, OVPN_A_KEYDIR_NONCE_TAIL, NONCE_LEN, ovpn->nonce);
+	nla_nest_end(ctx->nl_msg, key_dir);
+
+	key_dir = nla_nest_start(ctx->nl_msg, OVPN_A_KEYCONF_DECRYPT_DIR);
+	NLA_PUT(ctx->nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, KEY_LEN, ovpn->key_dec);
+	NLA_PUT(ctx->nl_msg, OVPN_A_KEYDIR_NONCE_TAIL, NONCE_LEN, ovpn->nonce);
+	nla_nest_end(ctx->nl_msg, key_dir);
+
+	nla_nest_end(ctx->nl_msg, keyconf);
+
+	ret = ovpn_nl_msg_send(ctx, NULL);
+nla_put_failure:
+	nl_ctx_free(ctx);
+	return ret;
+}
+
+static int ovpn_del_key(struct ovpn_ctx *ovpn)
+{
+	struct nlattr *keyconf;
+	struct nl_ctx *ctx;
+	int ret = -1;
+
+	ctx = nl_ctx_alloc(ovpn, OVPN_CMD_KEY_DEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	keyconf = nla_nest_start(ctx->nl_msg, OVPN_A_KEYCONF);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_KEYCONF_PEER_ID, ovpn->peer_id);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_KEYCONF_SLOT, OVPN_KEY_SLOT_PRIMARY);
+	nla_nest_end(ctx->nl_msg, keyconf);
+
+	ret = ovpn_nl_msg_send(ctx, NULL);
+nla_put_failure:
+	nl_ctx_free(ctx);
+	return ret;
+}
+
+static int ovpn_swap_keys(struct ovpn_ctx *ovpn)
+{
+	struct nl_ctx *ctx;
+	struct nlattr *kc;
+	int ret = -1;
+
+	ctx = nl_ctx_alloc(ovpn, OVPN_CMD_KEY_SWAP);
+	if (!ctx)
+		return -ENOMEM;
+
+	kc = nla_nest_start(ctx->nl_msg, OVPN_A_KEYCONF);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_KEYCONF_PEER_ID, ovpn->peer_id);
+	nla_nest_end(ctx->nl_msg, kc);
+
+	ret = ovpn_nl_msg_send(ctx, NULL);
+nla_put_failure:
+	nl_ctx_free(ctx);
+	return ret;
+}
+
+static int ovpn_handle_iface(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *attrs[OVPN_A_MAX + 1];
+
+	nla_parse(attrs, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),
+		  genlmsg_attrlen(gnlh, 0), NULL);
+
+	if (!attrs[OVPN_A_IFNAME]) {
+		fprintf(stderr, "no ifname in netlink message\n");
+		return NL_SKIP;
+	}
+
+	fprintf(stderr, "Created ifname: %s\n",
+		(char *)nla_data(attrs[OVPN_A_IFNAME]));
+
+	return NL_SKIP;
+}
+
+static int ovpn_new_iface(struct ovpn_ctx *ovpn)
+{
+	struct nl_ctx *ctx;
+	int ret = -1;
+
+	ctx = nl_ctx_alloc(ovpn, OVPN_CMD_DEV_NEW);
+	if (!ctx)
+		return -ENOMEM;
+
+	NLA_PUT(ctx->nl_msg, OVPN_A_IFNAME, strlen(ovpn->ifname) + 1,
+		ovpn->ifname);
+
+	if (ovpn->mode_set)
+		NLA_PUT_U32(ctx->nl_msg, OVPN_A_MODE, ovpn->mode);
+
+	fprintf(stdout, "Creating interface %s with mode %u\n", ovpn->ifname,
+		ovpn->mode);
+
+	ret = ovpn_nl_msg_send(ctx, ovpn_handle_iface);
+nla_put_failure:
+	nl_ctx_free(ctx);
+	return ret;
+}
+
+static int ovpn_del_iface(struct ovpn_ctx *ovpn)
+{
+	struct nl_ctx *ctx;
+	int ret = -1;
+
+	ctx = nl_ctx_alloc(ovpn, OVPN_CMD_DEV_DEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ret = ovpn_nl_msg_send(ctx, NULL);
+	nl_ctx_free(ctx);
+	return ret;
+}
+
+static int nl_seq_check(struct nl_msg *msg, void *arg)
+{
+	return NL_OK;
+}
+
+struct mcast_handler_args {
+	const char *group;
+	int id;
+};
+
+static int mcast_family_handler(struct nl_msg *msg, void *arg)
+{
+	struct mcast_handler_args *grp = arg;
+	struct nlattr *tb[CTRL_ATTR_MAX + 1];
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *mcgrp;
+	int rem_mcgrp;
+
+	nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+		  genlmsg_attrlen(gnlh, 0), NULL);
+
+	if (!tb[CTRL_ATTR_MCAST_GROUPS])
+		return NL_SKIP;
+
+	nla_for_each_nested(mcgrp, tb[CTRL_ATTR_MCAST_GROUPS], rem_mcgrp) {
+		struct nlattr *tb_mcgrp[CTRL_ATTR_MCAST_GRP_MAX + 1];
+
+		nla_parse(tb_mcgrp, CTRL_ATTR_MCAST_GRP_MAX,
+			  nla_data(mcgrp), nla_len(mcgrp), NULL);
+
+		if (!tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME] ||
+		    !tb_mcgrp[CTRL_ATTR_MCAST_GRP_ID])
+			continue;
+		if (strncmp(nla_data(tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME]),
+			    grp->group, nla_len(tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME])))
+			continue;
+		grp->id = nla_get_u32(tb_mcgrp[CTRL_ATTR_MCAST_GRP_ID]);
+		break;
+	}
+
+	return NL_SKIP;
+}
+
+static int mcast_error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err,
+			       void *arg)
+{
+	int *ret = arg;
+
+	*ret = err->error;
+	return NL_STOP;
+}
+
+static int mcast_ack_handler(struct nl_msg *msg, void *arg)
+{
+	int *ret = arg;
+
+	*ret = 0;
+	return NL_STOP;
+}
+
+static int ovpn_handle_msg(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *attrs[OVPN_A_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	//enum ovpn_del_peer_reason reason;
+	char ifname[IF_NAMESIZE];
+	__u32 ifindex;
+
+	fprintf(stderr, "received message from ovpn-dco\n");
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fprintf(stderr, "invalid header\n");
+		return NL_STOP;
+	}
+
+	if (nla_parse(attrs, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),
+		      genlmsg_attrlen(gnlh, 0), NULL)) {
+		fprintf(stderr, "received bogus data from ovpn-dco\n");
+		return NL_STOP;
+	}
+
+	if (!attrs[OVPN_A_IFINDEX]) {
+		fprintf(stderr, "no ifindex in this message\n");
+		return NL_STOP;
+	}
+
+	ifindex = nla_get_u32(attrs[OVPN_A_IFINDEX]);
+	if (!if_indextoname(ifindex, ifname)) {
+		fprintf(stderr, "cannot resolve ifname for ifindex: %u\n",
+			ifindex);
+		return NL_STOP;
+	}
+
+	switch (gnlh->cmd) {
+	case OVPN_CMD_PEER_DEL_NTF:
+		/*if (!attrs[OVPN_A_DEL_PEER_REASON]) {
+		 *	fprintf(stderr, "no reason in DEL_PEER message\n");
+		 *	return NL_STOP;
+		 *}
+		 *
+		 *reason = nla_get_u8(attrs[OVPN_A_DEL_PEER_REASON]);
+		 *fprintf(stderr,
+		 *	"received CMD_DEL_PEER, ifname: %s reason: %d\n",
+		 *	ifname, reason);
+		 */
+		fprintf(stdout, "received CMD_PEER_DEL_NTF\n");
+		break;
+	case OVPN_CMD_KEY_SWAP_NTF:
+		fprintf(stdout, "received CMD_KEY_SWAP_NTF\n");
+		break;
+	default:
+		fprintf(stderr, "received unknown command: %d\n", gnlh->cmd);
+		return NL_STOP;
+	}
+
+	return NL_OK;
+}
+
+static int ovpn_get_mcast_id(struct nl_sock *sock, const char *family,
+			     const char *group)
+{
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int ret, ctrlid;
+	struct mcast_handler_args grp = {
+		.group = group,
+		.id = -ENOENT,
+	};
+
+	msg = nlmsg_alloc();
+	if (!msg)
+		return -ENOMEM;
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb) {
+		ret = -ENOMEM;
+		goto out_fail_cb;
+	}
+
+	ctrlid = genl_ctrl_resolve(sock, "nlctrl");
+
+	genlmsg_put(msg, 0, 0, ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);
+
+	ret = -ENOBUFS;
+	NLA_PUT_STRING(msg, CTRL_ATTR_FAMILY_NAME, family);
+
+	ret = nl_send_auto_complete(sock, msg);
+	if (ret < 0)
+		goto nla_put_failure;
+
+	ret = 1;
+
+	nl_cb_err(cb, NL_CB_CUSTOM, mcast_error_handler, &ret);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, mcast_ack_handler, &ret);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, mcast_family_handler, &grp);
+
+	while (ret > 0)
+		nl_recvmsgs(sock, cb);
+
+	if (ret == 0)
+		ret = grp.id;
+ nla_put_failure:
+	nl_cb_put(cb);
+ out_fail_cb:
+	nlmsg_free(msg);
+	return ret;
+}
+
+static void ovpn_listen_mcast(void)
+{
+	struct nl_sock *sock;
+	struct nl_cb *cb;
+	int mcid, ret;
+
+	sock = nl_socket_alloc();
+	if (!sock) {
+		fprintf(stderr, "cannot allocate netlink socket\n");
+		goto err_free;
+	}
+
+	nl_socket_set_buffer_size(sock, 8192, 8192);
+
+	ret = genl_connect(sock);
+	if (ret < 0) {
+		fprintf(stderr, "cannot connect to generic netlink: %s\n",
+			nl_geterror(ret));
+		goto err_free;
+	}
+
+	mcid = ovpn_get_mcast_id(sock, OVPN_FAMILY_NAME, OVPN_MCGRP_PEERS);
+	if (mcid < 0) {
+		fprintf(stderr, "cannot get mcast group: %s\n",
+			nl_geterror(mcid));
+		goto err_free;
+	}
+
+	ret = nl_socket_add_membership(sock, mcid);
+	if (ret) {
+		fprintf(stderr, "failed to join mcast group: %d\n", ret);
+		goto err_free;
+	}
+
+	ret = 0;
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	nl_cb_set(cb, NL_CB_SEQ_CHECK, NL_CB_CUSTOM, nl_seq_check, NULL);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, &ret);
+	nl_cb_err(cb, NL_CB_CUSTOM, ovpn_nl_cb_error, &ret);
+
+	while (ret != -EINTR)
+		ret = nl_recvmsgs(sock, cb);
+
+	nl_cb_put(cb);
+err_free:
+	nl_socket_free(sock);
+}
+
+static void usage(const char *cmd)
+{
+	fprintf(stderr, "Error: invalid arguments.\n\n");
+	fprintf(stderr,
+		"Usage %s <iface> <connect|listen|new_peer|new_multi_peer|set_peer|del_peer|new_key|del_key|recv|send|listen_mcast> [arguments..]\n",
+		cmd);
+	fprintf(stderr, "\tiface: tun interface name\n\n");
+
+	fprintf(stderr,
+		"* connect <peer_id> <raddr> <rport> <key file>: start connecting peer of TCP-based VPN session\n");
+	fprintf(stderr, "\tpeer-id: peer ID of the connecting peer\n");
+	fprintf(stderr, "\tremote-addr: peer IP address\n");
+	fprintf(stderr, "\tremote-port: peer TCP port\n");
+
+	fprintf(stderr,
+		"* listen <lport> <peers_file>: listen for incoming peer TCP connections\n");
+	fprintf(stderr, "\tlport: src TCP port\n");
+	fprintf(stderr,
+		"\tpeers_file: file containing one peer per line: Line format:\n");
+	fprintf(stderr, "\t\t<peer_id> <vpnaddr>\n\n");
+
+	fprintf(stderr,
+		"* new_peer <lport> <peer-id> <raddr> <rport> [vpnaddr]: add new peer\n");
+	fprintf(stderr,
+		"\tpeer-id: peer ID to be used in data packets to/from this peer\n");
+	fprintf(stderr, "\tlocal-port: local UDP port\n");
+	fprintf(stderr, "\tremote-addr: peer IP address\n");
+	fprintf(stderr, "\tremote-port: peer UDP port\n");
+	fprintf(stderr, "\tvpnaddr: peer VPN IP\n\n");
+
+	fprintf(stderr,
+		"* new_multi_peer <lport> <file>: add multiple peers as listed in the file\n");
+	fprintf(stderr, "\tlport: local UDP port to bind to\n");
+	fprintf(stderr,
+		"\tfile: text file containing one peer per line. Line format:\n");
+	fprintf(stderr, "\t\t<peer-id> <raddr> <rport> <vpnaddr>\n\n");
+
+	fprintf(stderr,
+		"* set_peer <peer-id> <keepalive_interval> <keepalive_timeout>: set peer attributes\n");
+	fprintf(stderr, "\tpeer-id: peer ID of the peer to modify\n");
+	fprintf(stderr,
+		"\tkeepalive_interval: interval for sending ping messages\n");
+	fprintf(stderr,
+		"\tkeepalive_timeout: time after which a peer is timed out\n\n");
+
+	fprintf(stderr, "* del_peer <peer-id>: delete peer\n");
+	fprintf(stderr, "\tpeer-id: peer ID of the peer to delete\n\n");
+
+	fprintf(stderr,
+		"* new_key <peer-id> <slot> <key_id> <cipher> <key_dir> <key_file>: set data channel key\n");
+	fprintf(stderr,
+		"\tpeer-id: peer ID of the peer to configure the key for\n");
+	fprintf(stderr,
+		"\tcipher: cipher to use, supported: aes (AES-GCM), chachapoly (CHACHA20POLY1305), none\n");
+	fprintf(stderr,
+		"\tkey_dir: key direction, must 0 on one host and 1 on the other\n");
+	fprintf(stderr, "\tkey_file: file containing the pre-shared key\n\n");
+
+	fprintf(stderr,
+		"* del_key <peer-id>: erase existing data channel key\n");
+	fprintf(stderr, "\tpeer-id: peer ID of the peer to modify\n\n");
+
+	fprintf(stderr,
+		"* swap_keys <peer-id>: swap primary and seconday key slots\n");
+	fprintf(stderr, "\tpeer-id: peer ID of the peer to modify\n\n");
+
+	fprintf(stderr,
+		"* listen_mcast: listen to ovpn-dco netlink multicast messages\n");
+}
+
+static int ovpn_parse_remote(struct ovpn_ctx *ovpn, const char *host,
+			     const char *service, const char *vpnip)
+{
+	int ret;
+	struct addrinfo *result;
+	struct addrinfo hints = {
+		.ai_family = ovpn->sa_family,
+		.ai_socktype = SOCK_DGRAM,
+		.ai_protocol = IPPROTO_UDP
+	};
+
+	if (host) {
+		ret = getaddrinfo(host, service, &hints, &result);
+		if (ret == EAI_NONAME || ret == EAI_FAIL)
+			return -1;
+
+		if (!(result->ai_family == AF_INET &&
+		      result->ai_addrlen == sizeof(struct sockaddr_in)) &&
+		    !(result->ai_family == AF_INET6 &&
+		      result->ai_addrlen == sizeof(struct sockaddr_in6))) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		memcpy(&ovpn->remote, result->ai_addr, result->ai_addrlen);
+	}
+
+	if (vpnip) {
+		ret = getaddrinfo(vpnip, NULL, &hints, &result);
+		if (ret == EAI_NONAME || ret == EAI_FAIL)
+			return -1;
+
+		if (!(result->ai_family == AF_INET &&
+		      result->ai_addrlen == sizeof(struct sockaddr_in)) &&
+		    !(result->ai_family == AF_INET6 &&
+		      result->ai_addrlen == sizeof(struct sockaddr_in6))) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		memcpy(&ovpn->peer_ip, result->ai_addr, result->ai_addrlen);
+		ovpn->sa_family = result->ai_family;
+
+		ovpn->peer_ip_set = true;
+	}
+
+	ret = 0;
+out:
+	freeaddrinfo(result);
+	return ret;
+}
+
+static int ovpn_parse_new_peer(struct ovpn_ctx *ovpn, const char *peer_id,
+			       const char *raddr, const char *rport,
+			       const char *vpnip)
+{
+	ovpn->peer_id = strtoul(peer_id, NULL, 10);
+	if (errno == ERANGE) {
+		fprintf(stderr, "peer ID value out of range\n");
+		return -1;
+	}
+
+	return ovpn_parse_remote(ovpn, raddr, rport, vpnip);
+}
+
+static void ovpn_send_tcp_data(int socket)
+{
+	uint16_t len = htons(1000);
+	uint8_t buf[1002];
+	int ret;
+
+	memcpy(buf, &len, sizeof(len));
+	memset(buf + sizeof(len), 0x86, sizeof(buf) - sizeof(len));
+
+	ret = send(socket, buf, sizeof(buf), 0);
+
+	fprintf(stdout, "Sent %u bytes over TCP socket\n", ret);
+}
+
+static void ovpn_recv_tcp_data(int socket)
+{
+	uint8_t buf[1002];
+	uint16_t len;
+	int ret;
+
+	ret = recv(socket, buf, sizeof(buf), 0);
+
+	if (ret < 2) {
+		fprintf(stderr, ">>>> Error while reading TCP data: %d\n", ret);
+		return;
+	}
+
+	memcpy(&len, buf, sizeof(len));
+	len = ntohs(len);
+
+	fprintf(stdout, ">>>> Received %u bytes over TCP socket, header: %u\n",
+		ret, len);
+
+/*	int i;
+ *	for (i = 2; i < ret; i++) {
+ *		fprintf(stdout, "0x%.2x ", buf[i]);
+ *		if (i && !((i - 2) % 16))
+ *			fprintf(stdout, "\n");
+ *	}
+ *	fprintf(stdout, "\n");
+ */
+}
+
+static int ovpn_parse_set_peer(struct ovpn_ctx *ovpn, int argc, char *argv[])
+{
+	if (argc < 5) {
+		usage(argv[0]);
+		return -1;
+	}
+
+	ovpn->keepalive_interval = strtoul(argv[3], NULL, 10);
+	if (errno == ERANGE) {
+		fprintf(stderr, "keepalive interval value out of range\n");
+		return -1;
+	}
+
+	ovpn->keepalive_timeout = strtoul(argv[4], NULL, 10);
+	if (errno == ERANGE) {
+		fprintf(stderr, "keepalive interval value out of range\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	struct ovpn_ctx ovpn;
+//	struct nl_ctx *ctx;
+	int ret;
+
+	if (argc < 2) {
+		usage(argv[0]);
+		return -1;
+	}
+
+	memset(&ovpn, 0, sizeof(ovpn));
+	ovpn.sa_family = AF_INET;
+	ovpn.cli_socket = -1;
+
+	if (argc > 2) {
+		strscpy(ovpn.ifname, argv[2], IFNAMSIZ - 1);
+		ovpn.ifname[IFNAMSIZ - 1] = '\0';
+	}
+
+	/* all commands except new_iface expect a valid ifindex */
+	if (strcmp(argv[1], "new_iface")) {
+		/* in this case a ifname MUST be defined */
+		if (argc < 3) {
+			usage(argv[0]);
+			return -1;
+		}
+
+		ovpn.ifindex = if_nametoindex(ovpn.ifname);
+		if (!ovpn.ifindex) {
+			fprintf(stderr, "cannot find interface: %s\n",
+				strerror(errno));
+			return -1;
+		}
+	}
+
+	if (!strcmp(argv[1], "new_iface")) {
+		if (argc > 3) {
+			if (!strcmp(argv[3], "P2P")) {
+				ovpn.mode = OVPN_MODE_P2P;
+			} else if (!strcmp(argv[3], "MP")) {
+				ovpn.mode = OVPN_MODE_MP;
+			} else {
+				fprintf(stderr, "Cannot parse iface mode: %s\n",
+					argv[3]);
+				return -1;
+			}
+			ovpn.mode_set = true;
+		}
+
+		ret = ovpn_new_iface(&ovpn);
+		if (ret < 0) {
+			fprintf(stderr, "Cannot create interface %s: %d\n",
+				ovpn.ifname, ret);
+			return -1;
+		}
+	} else if (!strcmp(argv[1], "del_iface")) {
+		ret = ovpn_del_iface(&ovpn);
+		if (ret < 0) {
+			fprintf(stderr, "Cannot delete interface %s: %d\n",
+				ovpn.ifname, ret);
+			return -1;
+		}
+	} else if (!strcmp(argv[1], "listen")) {
+		char peer_id[10], vpnip[100];
+		int n;
+		FILE *fp;
+
+		if (argc < 4) {
+			usage(argv[0]);
+			return -1;
+		}
+
+		ovpn.lport = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE || ovpn.lport > 65535) {
+			fprintf(stderr, "lport value out of range\n");
+			return -1;
+		}
+
+		if (argc > 4 && !strcmp(argv[4], "ipv6"))
+			ovpn.sa_family = AF_INET6;
+
+		ret = ovpn_listen(&ovpn, ovpn.sa_family);
+		if (ret < 0) {
+			fprintf(stderr, "cannot listen on TCP socket\n");
+			return ret;
+		}
+
+		fp = fopen(argv[4], "r");
+		if (!fp) {
+			fprintf(stderr, "cannot open file: %s\n", argv[4]);
+			return -1;
+		}
+
+		while ((n = fscanf(fp, "%s %s\n", peer_id, vpnip)) == 2) {
+			struct ovpn_ctx peer_ctx = { 0 };
+
+			peer_ctx.ifindex = ovpn.ifindex;
+			peer_ctx.sa_family = ovpn.sa_family;
+
+			peer_ctx.socket = ovpn_accept(&ovpn);
+			if (peer_ctx.socket < 0) {
+				fprintf(stderr, "cannot accept connection!\n");
+				return -1;
+			}
+
+			/* store the socket of the first peer to test TCP I/O */
+			if (ovpn.cli_socket < 0)
+				ovpn.cli_socket = peer_ctx.socket;
+
+			ret = ovpn_parse_new_peer(&peer_ctx, peer_id, NULL,
+						  NULL, vpnip);
+			if (ret < 0) {
+				fprintf(stderr, "error while parsing line\n");
+				return -1;
+			}
+
+			ret = ovpn_new_peer(&peer_ctx, true);
+			if (ret < 0) {
+				fprintf(stderr,
+					"cannot add peer to VPN: %s %s\n",
+					peer_id, vpnip);
+				return ret;
+			}
+		}
+
+		if (ovpn.cli_socket >= 0)
+			ovpn_recv_tcp_data(ovpn.cli_socket);
+	} else if (!strcmp(argv[1], "connect")) {
+		if (argc < 5) {
+			usage(argv[0]);
+			return -1;
+		}
+
+		ovpn.sa_family = AF_INET;
+
+		ret = ovpn_parse_new_peer(&ovpn, argv[3], argv[4], argv[5],
+					  NULL);
+		if (ret < 0) {
+			fprintf(stderr, "Cannot parse remote peer data\n");
+			return ret;
+		}
+
+		ret = ovpn_connect(&ovpn);
+		if (ret < 0) {
+			fprintf(stderr, "cannot connect TCP socket\n");
+			return ret;
+		}
+
+		ret = ovpn_new_peer(&ovpn, true);
+		if (ret < 0) {
+			fprintf(stderr, "cannot add peer to VPN\n");
+			close(ovpn.socket);
+			return ret;
+		}
+
+		if (argc > 6) {
+			ovpn.key_slot = OVPN_KEY_SLOT_PRIMARY;
+			ovpn.key_id = 0;
+			ovpn.cipher = OVPN_CIPHER_ALG_AES_GCM;
+			ovpn.key_dir = KEY_DIR_OUT;
+
+			ret = ovpn_read_key(argv[6], &ovpn);
+			if (ret)
+				return ret;
+
+			ret = ovpn_new_key(&ovpn);
+			if (ret < 0) {
+				fprintf(stderr, "cannot set key\n");
+				return ret;
+			}
+
+			ovpn_send_tcp_data(ovpn.socket);
+		}
+	} else if (!strcmp(argv[1], "new_peer")) {
+		if (argc < 7) {
+			usage(argv[0]);
+			return -1;
+		}
+
+		ovpn.lport = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE || ovpn.lport > 65535) {
+			fprintf(stderr, "lport value out of range\n");
+			return -1;
+		}
+
+		const char *vpnip = (argc > 7) ? argv[7] : NULL;
+
+		ret = ovpn_parse_new_peer(&ovpn, argv[4], argv[5], argv[6],
+					  vpnip);
+		if (ret < 0)
+			return ret;
+
+		ret = ovpn_udp_socket(&ovpn, AF_INET6); //ovpn.sa_family ?
+		if (ret < 0)
+			return ret;
+
+		ret = ovpn_new_peer(&ovpn, false);
+		if (ret < 0) {
+			fprintf(stderr, "cannot add peer to VPN\n");
+			return ret;
+		}
+	} else if (!strcmp(argv[1], "new_multi_peer")) {
+		char peer_id[10], raddr[128], rport[10], vpnip[100];
+		FILE *fp;
+		int n;
+
+		if (argc < 5) {
+			usage(argv[0]);
+			return -1;
+		}
+
+		ovpn.lport = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE || ovpn.lport > 65535) {
+			fprintf(stderr, "lport value out of range\n");
+			return -1;
+		}
+
+		fp = fopen(argv[4], "r");
+		if (!fp) {
+			fprintf(stderr, "cannot open file: %s\n", argv[4]);
+			return -1;
+		}
+
+		ret = ovpn_udp_socket(&ovpn, AF_INET6);
+		if (ret < 0)
+			return ret;
+
+		while ((n = fscanf(fp, "%s %s %s %s\n", peer_id, raddr, rport,
+				   vpnip)) == 4) {
+			struct ovpn_ctx peer_ctx = { 0 };
+
+			peer_ctx.ifindex = ovpn.ifindex;
+			peer_ctx.socket = ovpn.socket;
+			peer_ctx.sa_family = AF_UNSPEC;
+
+			ret = ovpn_parse_new_peer(&peer_ctx, peer_id, raddr,
+						  rport, vpnip);
+			if (ret < 0) {
+				fprintf(stderr, "error while parsing line\n");
+				return -1;
+			}
+
+			ret = ovpn_new_peer(&peer_ctx, false);
+			if (ret < 0) {
+				fprintf(stderr,
+					"cannot add peer to VPN: %s %s %s %s\n",
+					peer_id, raddr, rport, vpnip);
+				return ret;
+			}
+		}
+	} else if (!strcmp(argv[1], "set_peer")) {
+		ovpn.peer_id = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE) {
+			fprintf(stderr, "peer ID value out of range\n");
+			return -1;
+		}
+
+		argv++;
+		argc--;
+
+		ret = ovpn_parse_set_peer(&ovpn, argc, argv);
+		if (ret < 0)
+			return ret;
+
+		ret = ovpn_set_peer(&ovpn);
+		if (ret < 0) {
+			fprintf(stderr, "cannot set peer to VPN\n");
+			return ret;
+		}
+	} else if (!strcmp(argv[1], "del_peer")) {
+		if (argc < 4) {
+			usage(argv[0]);
+			return -1;
+		}
+
+		ovpn.peer_id = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE) {
+			fprintf(stderr, "peer ID value out of range\n");
+			return -1;
+		}
+
+		ret = ovpn_del_peer(&ovpn);
+		if (ret < 0) {
+			fprintf(stderr, "cannot delete peer to VPN\n");
+			return ret;
+		}
+	} else if (!strcmp(argv[1], "get_peer")) {
+		ovpn.peer_id = PEER_ID_UNDEF;
+		if (argc > 3)
+			ovpn.peer_id = strtoul(argv[3], NULL, 10);
+
+		fprintf(stderr, "List of peers connected to: %s\n",
+			ovpn.ifname);
+
+		ret = ovpn_get_peer(&ovpn);
+		if (ret < 0) {
+			fprintf(stderr, "cannot get peer(s): %d\n", ret);
+			return ret;
+		}
+	} else if (!strcmp(argv[1], "new_key")) {
+		if (argc < 8) {
+			usage(argv[0]);
+			return -1;
+		}
+
+		ovpn.peer_id = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE) {
+			fprintf(stderr, "peer ID value out of range\n");
+			return -1;
+		}
+
+		int slot = strtoul(argv[4], NULL, 10);
+
+		if (errno == ERANGE || slot < 1 || slot > 2) {
+			fprintf(stderr, "ket slot out of range\n");
+			return -1;
+		}
+
+		switch (slot) {
+		case 1:
+			ovpn.key_slot = OVPN_KEY_SLOT_PRIMARY;
+			break;
+		case 2:
+			ovpn.key_slot = OVPN_KEY_SLOT_SECONDARY;
+			break;
+		}
+
+		ovpn.key_id = strtoul(argv[5], NULL, 10);
+		if (errno == ERANGE || ovpn.key_id > 2) {
+			fprintf(stderr, "ket ID out of range\n");
+			return -1;
+		}
+
+		ret = ovpn_read_cipher(argv[6], &ovpn);
+		if (ret < 0)
+			return ret;
+
+		ret = ovpn_read_key_direction(argv[7], &ovpn);
+		if (ret < 0)
+			return ret;
+
+		ret = ovpn_read_key(argv[8], &ovpn);
+		if (ret)
+			return ret;
+
+		ret = ovpn_new_key(&ovpn);
+		if (ret < 0) {
+			fprintf(stderr, "cannot set key\n");
+			return ret;
+		}
+	} else if (!strcmp(argv[1], "del_key")) {
+		if (argc < 3) {
+			usage(argv[0]);
+			return -1;
+		}
+
+		ovpn.peer_id = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE) {
+			fprintf(stderr, "peer ID value out of range\n");
+			return -1;
+		}
+
+		argv++;
+		argc--;
+
+		ret = ovpn_del_key(&ovpn);
+		if (ret < 0) {
+			fprintf(stderr, "cannot delete key\n");
+			return ret;
+		}
+	} else if (!strcmp(argv[1], "swap_keys")) {
+		if (argc < 3) {
+			usage(argv[0]);
+			return -1;
+		}
+
+		ovpn.peer_id = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE) {
+			fprintf(stderr, "peer ID value out of range\n");
+			return -1;
+		}
+
+		argv++;
+		argc--;
+
+		ret = ovpn_swap_keys(&ovpn);
+		if (ret < 0) {
+			fprintf(stderr, "cannot swap keys\n");
+			return ret;
+		}
+	} else if (!strcmp(argv[1], "listen_mcast")) {
+		ovpn_listen_mcast();
+	} else {
+		usage(argv[0]);
+		return -1;
+	}
+
+	return ret;
+}
diff --git a/tools/testing/selftests/net/ovpn/tcp_peers.txt b/tools/testing/selftests/net/ovpn/tcp_peers.txt
new file mode 100644
index 0000000000000000000000000000000000000000..d753eebe8716ed3588334ad766981e883ed2469a
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/tcp_peers.txt
@@ -0,0 +1,5 @@
+1 5.5.5.2
+2 5.5.5.3
+3 5.5.5.4
+4 5.5.5.5
+5 5.5.5.6
diff --git a/tools/testing/selftests/net/ovpn/udp_peers.txt b/tools/testing/selftests/net/ovpn/udp_peers.txt
new file mode 100644
index 0000000000000000000000000000000000000000..32f14bd9347a63e58438311b6d880b9fef768aa2
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/udp_peers.txt
@@ -0,0 +1,5 @@
+1 10.10.1.2 1 5.5.5.2
+2 10.10.2.2 1 5.5.5.3
+3 10.10.3.2 1 5.5.5.4
+4 10.10.4.2 1 5.5.5.5
+5 10.10.5.2 1 5.5.5.6

-- 
2.45.2


