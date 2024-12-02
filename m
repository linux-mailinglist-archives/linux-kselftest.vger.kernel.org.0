Return-Path: <linux-kselftest+bounces-22703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E01459E068F
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 16:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B93A28E9E0
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C7820E309;
	Mon,  2 Dec 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IQ46Rd2t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2C620E008
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152146; cv=none; b=eGpded7szBMwRHDOlpQcEWv+gVEujxy5DG4Xeo6Lj1W2azW46FYkVWnL93KucqlDK2ZxhjeLk79UU6+iyZZSilMxtR2vM0LxMcikQ7bySJDZ+kN7iwY9Ci96RvsyBHU5n4o1t7JyTl2ZKBGIab19MIruVowOLwbTUUyGep/+G9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152146; c=relaxed/simple;
	bh=5fmQvV8y5yjqh6VUrGv8z4ojBA1LzhLUYwe64YRpDb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzIDpNSlOe/lQIQReTQHRKvtcar1jBEzfoXNrHZBUy35mhzkDueKuxu4zGYUO/OvRCbie0nu84JZFTkKYibHLhKLHZOqFjGr3uPmaVmBpHqY8QVkIzcRbvElOcqfAhR1BTTRFHXJ4HA5Vusk0HF41d+wKYszK+9LZaANAmGUhrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IQ46Rd2t; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e5db74d3so1453264f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2024 07:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152138; x=1733756938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmlbumR8I1ZI3ZKadQ656kFHYLu0z34AB8AlIbwa+W8=;
        b=IQ46Rd2tscjaEj9XkjokXehvqnI4c8Rkeb99C93G5fuZhEmMsfYcmB2oT7SspfZSRL
         JtGY8rGDkSrK0QRrflLkv9w8zEV8nosiLB8y64Lo3rOHVmKCEm2RyyXr5jhyJAvVmf6k
         SM0VpdQsr5eytgF/YlLyb7ETy/qASDOEaRbTYGbOLMyJjoHdd9TP95ZgDeoAj+5GAXko
         GiJ6Z6HWT3I6ZMZB5serdbQ9xCfZI+qRjS4h6qwq9lych0Ypr+0TMQAAwBPz6Fb+t4CV
         E3lVU+a4SPjTM85M9opvybLTG+GHaWdZWQTPLIbe4jBEtltpnqK1TAGjYTlB1Hvi+R+I
         c37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152138; x=1733756938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmlbumR8I1ZI3ZKadQ656kFHYLu0z34AB8AlIbwa+W8=;
        b=jVwJafWLtNxPy3X4LVbJKZ810T0lBr7uB6nOH7f1G9QQdGzCP7KCFafHEQXH4uv7O3
         o9qFH1iyyXt4L9/OL9T8K0c2McNrbpCQf0bQPmaOgFformoTf9ayZ5pBQkovTqmkgvwQ
         uMdCvrqBT58ATjc46RJaQ/AQlAW74J9nhEd4xxJrliQuZx6m5e3Uoc/dJnkOJmjY9WX9
         c6H4O+PBsFdoIKSBVJcagSuPqaIkGx6BJhr2a1YmxTNR1WDuyDz1k4cHvjbgjYRM8VWc
         3VytxtRMli7nH4FA+uYW7ufxTYY2tQ/zian6z+Z8xQmCaiqKF7QeQynmM4VBJQauWbvX
         rbjw==
X-Forwarded-Encrypted: i=1; AJvYcCUjjjjM9zhd0EC6p25zaRn4xKlVnY54jl5d28IN/IWfdojcSOLyGeJIBZcDzGiG2CF7JmHY3ICObqHKMEunOMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlqFmB/LZGq2PyPtXul1Z1BFlZcDKgZ6j1srBCn8ptwp4ZZ2du
	gly44T1KubltC576yUCueV/OILeqob9xWdwwORxGCcoENxJAyXyvd7HhvKccbAk=
X-Gm-Gg: ASbGnct3/XjEjm4YGsIpQ1DvRNJYt0j889SAwV+iNACYQoTBkaMhBgcOY7R8Q8yg3df
	sVnGpLDXKkX++E9XVkfzX79Eu95tc8WVJ9JgcEVGKhxQpecXZupGrG6TFar5xmWHcz6oND74XtI
	9aKOnod542Ci1tuTg7IpqNuTcMpNmIJvHF37Lqj8iiLt+M+Ch/j7fPbeNhJfka8lAaLRm74aIvX
	QrhWGLu1Kr6aVUzKdzetP0O+167lKrefLRh98X2OA85AbSw3wyIXa0qE8cr
X-Google-Smtp-Source: AGHT+IGtsvEtTzTW2vDLhK2ZAePnpot0FjoChnp05VUgfjPqge9KOkSEf7ysAvWOvPkQyNSZZsYqzg==
X-Received: by 2002:a05:6000:1547:b0:385:f280:d55 with SMTP id ffacd0b85a97d-385f280101fmr3815208f8f.37.1733152134555;
        Mon, 02 Dec 2024 07:08:54 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:08:53 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 02 Dec 2024 16:07:40 +0100
Subject: [PATCH net-next v12 22/22] testing/selftests: add test tool and
 scripts for ovpn module
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-ovpn-v12-22-239ff733bf97@openvpn.net>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
In-Reply-To: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=72161; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=5fmQvV8y5yjqh6VUrGv8z4ojBA1LzhLUYwe64YRpDb4=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1oGkuRgfopWE3oFzbIbJGM/K77MyBITsh9m
 VGyofkOA1KJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NaAAKCRALcOU6oDjV
 h3tAB/4ksRgLbuYHVpHSpMOS1CaqozXdxGYPRsOQQ4AH7OWSaG/X8hWTIBMzJ2ablGWAfzDkPoV
 gU6GnfAunxrf1oMHZsL+fX5LLEaXNMN2w9TWc7PR02O8vbBHI2rkbF3DGX4tAvQDLn4T8Xqaedg
 02cI/ahv5fomu6yV8dND4Rk4u5PTCcUu10JEgUPe5oyui8wbou4YPMSvHKVkcSKc+cS8fxmvKxG
 wVl7N94Gx5QIYqdcMCAzpS9HGuDOyfW0rE4TXrRhAsP+cRj1o3O2bAtqxZaV0x2und0Ukwg1Q1V
 yIlaxRamnR+dSQXz0a+7Tu+I/BbsuYZbb6XZAoVhiP62TOjB
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

The ovpn-cli tool can be compiled and used as selftest for the ovpn
kernel module.

[NOTE: it depends on libmedtls for decoding base64-encoded keys]

ovpn-cli implements the netlink and RTNL APIs and can thus be integrated
in any script for more automated testing.

Along with the tool, 4 scripts are provided that perform basic
functionality tests by means of network namespaces.
These scripts take part to the kselftest automation.

The output of the scripts, which will appear in the kselftest
reports, is a list of steps performed by the scripts plus some
output coming from the execution of `ping`, `iperf` and `ovpn-cli`
itself.
In general it is useful only in case of failure, in order to
understand which step has failed and why.

Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 MAINTAINERS                                        |    1 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/net/ovpn/.gitignore        |    2 +
 tools/testing/selftests/net/ovpn/Makefile          |   17 +
 tools/testing/selftests/net/ovpn/config            |   10 +
 tools/testing/selftests/net/ovpn/data64.key        |    5 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2370 ++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
 tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
 tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
 tools/testing/selftests/net/ovpn/test.sh           |  182 ++
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
 13 files changed, 2625 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 848538c52a01d18e0031ab34dca24c1151de4b8b..76b4c8f1e4a12bbbb8bc6c9344a0950656072571 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17481,6 +17481,7 @@ T:	git https://github.com/OpenVPN/linux-kernel-ovpn.git
 F:	Documentation/netlink/specs/ovpn.yaml
 F:	drivers/net/ovpn/
 F:	include/uapi/linux/ovpn.h
+F:	tools/testing/selftests/net/ovpn/
 
 OPENVSWITCH
 M:	Pravin B Shelar <pshelar@ovn.org>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2401e973c35963c415c1041bc622f06c8a7ec251..e8363c21074c5f4f1cf4140369e7e1c15ec470bf 100644
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
index 0000000000000000000000000000000000000000..c76d8fd953c5674941c8c2787813063b1bce180f
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020-2024 OpenVPN, Inc.
+#
+CFLAGS = -pedantic -Wextra -Wall -Wl,--no-as-needed -g -O0 -ggdb $(KHDR_INCLUDES)
+CFLAGS += $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0)
+
+LDFLAGS = -lmbedtls -lmbedcrypto
+LDFLAGS += $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0)
+
+TEST_PROGS = test.sh \
+	test-chachapoly.sh \
+	test-tcp.sh \
+	test-float.sh
+
+TEST_GEN_FILES = ovpn-cli
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/ovpn/config b/tools/testing/selftests/net/ovpn/config
new file mode 100644
index 0000000000000000000000000000000000000000..71946ba9fa175c191725e369eb9b973503d9d9c4
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/config
@@ -0,0 +1,10 @@
+CONFIG_NET=y
+CONFIG_INET=y
+CONFIG_STREAM_PARSER=y
+CONFIG_NET_UDP_TUNNEL=y
+CONFIG_DST_CACHE=y
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_AES=y
+CONFIG_CRYPTO_GCM=y
+CONFIG_CRYPTO_CHACHA20POLY1305=y
+CONFIG_OVPN=m
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
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
new file mode 100644
index 0000000000000000000000000000000000000000..046dd069aaaf4e5b091947bd57ed79f8519a780f
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -0,0 +1,2370 @@
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
+#include <time.h>
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
+/* defines to make checkpatch happy */
+#define strscpy strncpy
+#define __always_unused __attribute__((__unused__))
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
+enum ovpn_cmd {
+	CMD_INVALID,
+	CMD_NEW_IFACE,
+	CMD_DEL_IFACE,
+	CMD_LISTEN,
+	CMD_CONNECT,
+	CMD_NEW_PEER,
+	CMD_NEW_MULTI_PEER,
+	CMD_SET_PEER,
+	CMD_DEL_PEER,
+	CMD_GET_PEER,
+	CMD_NEW_KEY,
+	CMD_DEL_KEY,
+	CMD_GET_KEY,
+	CMD_SWAP_KEYS,
+	CMD_LISTEN_MCAST,
+};
+
+struct ovpn_ctx {
+	enum ovpn_cmd cmd;
+
+	__u8 key_enc[KEY_LEN];
+	__u8 key_dec[KEY_LEN];
+	__u8 nonce[NONCE_LEN];
+
+	enum ovpn_cipher_alg cipher;
+
+	sa_family_t sa_family;
+
+	unsigned long peer_id;
+	unsigned long lport;
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
+
+	const char *peers_file;
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
+	attrs = (void *)((uint8_t *)nlh + ack_len);
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
+static int ovpn_parse_key(const char *file, struct ovpn_ctx *ctx)
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
+	default:
+		goto err;
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
+static int ovpn_parse_cipher(const char *cipher, struct ovpn_ctx *ctx)
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
+static int ovpn_parse_key_direction(const char *dir, struct ovpn_ctx *ctx)
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
+	struct sockaddr_storage local_sock = { 0 };
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
+static int ovpn_handle_peer(struct nl_msg *msg, void (*arg)__always_unused)
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
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_KEYCONF_SLOT, ovpn->key_slot);
+	nla_nest_end(ctx->nl_msg, keyconf);
+
+	ret = ovpn_nl_msg_send(ctx, NULL);
+nla_put_failure:
+	nl_ctx_free(ctx);
+	return ret;
+}
+
+static int ovpn_handle_key(struct nl_msg *msg, void (*arg)__always_unused)
+{
+	struct nlattr *kattrs[OVPN_A_KEYCONF_MAX + 1];
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *attrs[OVPN_A_MAX + 1];
+
+	nla_parse(attrs, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),
+		  genlmsg_attrlen(gnlh, 0), NULL);
+
+	if (!attrs[OVPN_A_KEYCONF]) {
+		fprintf(stderr, "no packet content in netlink message\n");
+		return NL_SKIP;
+	}
+
+	nla_parse(kattrs, OVPN_A_KEYCONF_MAX, nla_data(attrs[OVPN_A_KEYCONF]),
+		  nla_len(attrs[OVPN_A_KEYCONF]), NULL);
+
+	if (kattrs[OVPN_A_KEYCONF_PEER_ID])
+		fprintf(stderr, "* Peer %u\n",
+			nla_get_u32(kattrs[OVPN_A_KEYCONF_PEER_ID]));
+	if (kattrs[OVPN_A_KEYCONF_SLOT]) {
+		fprintf(stderr, "\t- Slot: ");
+		switch (nla_get_u32(kattrs[OVPN_A_KEYCONF_SLOT])) {
+		case OVPN_KEY_SLOT_PRIMARY:
+			fprintf(stderr, "primary\n");
+			break;
+		case OVPN_KEY_SLOT_SECONDARY:
+			fprintf(stderr, "secondary\n");
+			break;
+		default:
+			fprintf(stderr, "invalid (%u)\n",
+				nla_get_u32(kattrs[OVPN_A_KEYCONF_SLOT]));
+			break;
+		}
+	}
+	if (kattrs[OVPN_A_KEYCONF_KEY_ID])
+		fprintf(stderr, "\t- Key ID: %u\n",
+			nla_get_u32(kattrs[OVPN_A_KEYCONF_KEY_ID]));
+	if (kattrs[OVPN_A_KEYCONF_CIPHER_ALG]) {
+		fprintf(stderr, "\t- Cipher: ");
+		switch (nla_get_u32(kattrs[OVPN_A_KEYCONF_CIPHER_ALG])) {
+		case OVPN_CIPHER_ALG_NONE:
+			fprintf(stderr, "none\n");
+			break;
+		case OVPN_CIPHER_ALG_AES_GCM:
+			fprintf(stderr, "aes-gcm\n");
+			break;
+		case OVPN_CIPHER_ALG_CHACHA20_POLY1305:
+			fprintf(stderr, "chacha20poly1305\n");
+			break;
+		default:
+			fprintf(stderr, "invalid (%u)\n",
+				nla_get_u32(kattrs[OVPN_A_KEYCONF_CIPHER_ALG]));
+			break;
+		}
+	}
+
+	return NL_SKIP;
+}
+
+static int ovpn_get_key(struct ovpn_ctx *ovpn)
+{
+	struct nlattr *keyconf;
+	struct nl_ctx *ctx;
+	int ret = -1;
+
+	ctx = nl_ctx_alloc(ovpn, OVPN_CMD_KEY_GET);
+	if (!ctx)
+		return -ENOMEM;
+
+	keyconf = nla_nest_start(ctx->nl_msg, OVPN_A_KEYCONF);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_KEYCONF_PEER_ID, ovpn->peer_id);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_KEYCONF_SLOT, ovpn->key_slot);
+	nla_nest_end(ctx->nl_msg, keyconf);
+
+	ret = ovpn_nl_msg_send(ctx, ovpn_handle_key);
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
+/**
+ * Helper function used to easily add attributes to a rtnl message
+ */
+static int ovpn_addattr(struct nlmsghdr *n, int maxlen, int type,
+			const void *data, int alen)
+{
+	int len = RTA_LENGTH(alen);
+	struct rtattr *rta;
+
+	if ((int)(NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len)) > maxlen)	{
+		fprintf(stderr, "%s: rtnl: message exceeded bound of %d\n",
+			__func__, maxlen);
+		return -EMSGSIZE;
+	}
+
+	rta = nlmsg_tail(n);
+	rta->rta_type = type;
+	rta->rta_len = len;
+
+	if (!data)
+		memset(RTA_DATA(rta), 0, alen);
+	else
+		memcpy(RTA_DATA(rta), data, alen);
+
+	n->nlmsg_len = NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len);
+
+	return 0;
+}
+
+static struct rtattr *ovpn_nest_start(struct nlmsghdr *msg, size_t max_size,
+				      int attr)
+{
+	struct rtattr *nest = nlmsg_tail(msg);
+
+	if (ovpn_addattr(msg, max_size, attr, NULL, 0) < 0)
+		return NULL;
+
+	return nest;
+}
+
+static void ovpn_nest_end(struct nlmsghdr *msg, struct rtattr *nest)
+{
+	nest->rta_len = (uint8_t *)nlmsg_tail(msg) - (uint8_t *)nest;
+}
+
+#define RT_SNDBUF_SIZE (1024 * 2)
+#define RT_RCVBUF_SIZE (1024 * 4)
+
+/**
+ * Open RTNL socket
+ */
+static int ovpn_rt_socket(void)
+{
+	int sndbuf = RT_SNDBUF_SIZE, rcvbuf = RT_RCVBUF_SIZE, fd;
+
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+	if (fd < 0) {
+		fprintf(stderr, "%s: cannot open netlink socket\n", __func__);
+		return fd;
+	}
+
+	if (setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &sndbuf,
+		       sizeof(sndbuf)) < 0) {
+		fprintf(stderr, "%s: SO_SNDBUF\n", __func__);
+		close(fd);
+		return -1;
+	}
+
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf,
+		       sizeof(rcvbuf)) < 0) {
+		fprintf(stderr, "%s: SO_RCVBUF\n", __func__);
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+/**
+ * Bind socket to Netlink subsystem
+ */
+static int ovpn_rt_bind(int fd, uint32_t groups)
+{
+	struct sockaddr_nl local = { 0 };
+	socklen_t addr_len;
+
+	local.nl_family = AF_NETLINK;
+	local.nl_groups = groups;
+
+	if (bind(fd, (struct sockaddr *)&local, sizeof(local)) < 0) {
+		fprintf(stderr, "%s: cannot bind netlink socket: %d\n",
+			__func__, errno);
+		return -errno;
+	}
+
+	addr_len = sizeof(local);
+	if (getsockname(fd, (struct sockaddr *)&local, &addr_len) < 0) {
+		fprintf(stderr, "%s: cannot getsockname: %d\n", __func__,
+			errno);
+		return -errno;
+	}
+
+	if (addr_len != sizeof(local)) {
+		fprintf(stderr, "%s: wrong address length %d\n", __func__,
+			addr_len);
+		return -EINVAL;
+	}
+
+	if (local.nl_family != AF_NETLINK) {
+		fprintf(stderr, "%s: wrong address family %d\n", __func__,
+			local.nl_family);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+typedef int (*ovpn_parse_reply_cb)(struct nlmsghdr *msg, void *arg);
+
+/**
+ * Send Netlink message and run callback on reply (if specified)
+ */
+static int ovpn_rt_send(struct nlmsghdr *payload, pid_t peer,
+			unsigned int groups, ovpn_parse_reply_cb cb,
+			void *arg_cb)
+{
+	int len, rem_len, fd, ret, rcv_len;
+	struct sockaddr_nl nladdr = { 0 };
+	struct nlmsgerr *err;
+	struct nlmsghdr *h;
+	char buf[1024 * 16];
+	struct iovec iov = {
+		.iov_base = payload,
+		.iov_len = payload->nlmsg_len,
+	};
+	struct msghdr nlmsg = {
+		.msg_name = &nladdr,
+		.msg_namelen = sizeof(nladdr),
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+
+	nladdr.nl_family = AF_NETLINK;
+	nladdr.nl_pid = peer;
+	nladdr.nl_groups = groups;
+
+	payload->nlmsg_seq = time(NULL);
+
+	/* no need to send reply */
+	if (!cb)
+		payload->nlmsg_flags |= NLM_F_ACK;
+
+	fd = ovpn_rt_socket();
+	if (fd < 0) {
+		fprintf(stderr, "%s: can't open rtnl socket\n", __func__);
+		return -errno;
+	}
+
+	ret = ovpn_rt_bind(fd, 0);
+	if (ret < 0) {
+		fprintf(stderr, "%s: can't bind rtnl socket\n", __func__);
+		ret = -errno;
+		goto out;
+	}
+
+	ret = sendmsg(fd, &nlmsg, 0);
+	if (ret < 0) {
+		fprintf(stderr, "%s: rtnl: error on sendmsg()\n", __func__);
+		ret = -errno;
+		goto out;
+	}
+
+	/* prepare buffer to store RTNL replies */
+	memset(buf, 0, sizeof(buf));
+	iov.iov_base = buf;
+
+	while (1) {
+		/*
+		 * iov_len is modified by recvmsg(), therefore has to be initialized before
+		 * using it again
+		 */
+		iov.iov_len = sizeof(buf);
+		rcv_len = recvmsg(fd, &nlmsg, 0);
+		if (rcv_len < 0) {
+			if (errno == EINTR || errno == EAGAIN) {
+				fprintf(stderr, "%s: interrupted call\n",
+					__func__);
+				continue;
+			}
+			fprintf(stderr, "%s: rtnl: error on recvmsg()\n",
+				__func__);
+			ret = -errno;
+			goto out;
+		}
+
+		if (rcv_len == 0) {
+			fprintf(stderr,
+				"%s: rtnl: socket reached unexpected EOF\n",
+				__func__);
+			ret = -EIO;
+			goto out;
+		}
+
+		if (nlmsg.msg_namelen != sizeof(nladdr)) {
+			fprintf(stderr,
+				"%s: sender address length: %u (expected %zu)\n",
+				__func__, nlmsg.msg_namelen, sizeof(nladdr));
+			ret = -EIO;
+			goto out;
+		}
+
+		h = (struct nlmsghdr *)buf;
+		while (rcv_len >= (int)sizeof(*h)) {
+			len = h->nlmsg_len;
+			rem_len = len - sizeof(*h);
+
+			if (rem_len < 0 || len > rcv_len) {
+				if (nlmsg.msg_flags & MSG_TRUNC) {
+					fprintf(stderr, "%s: truncated message\n",
+						__func__);
+					ret = -EIO;
+					goto out;
+				}
+				fprintf(stderr, "%s: malformed message: len=%d\n",
+					__func__, len);
+				ret = -EIO;
+				goto out;
+			}
+
+			if (h->nlmsg_type == NLMSG_DONE) {
+				ret = 0;
+				goto out;
+			}
+
+			if (h->nlmsg_type == NLMSG_ERROR) {
+				err = (struct nlmsgerr *)NLMSG_DATA(h);
+				if (rem_len < (int)sizeof(struct nlmsgerr)) {
+					fprintf(stderr, "%s: ERROR truncated\n",
+						__func__);
+					ret = -EIO;
+					goto out;
+				}
+
+				if (err->error) {
+					fprintf(stderr, "%s: (%d) %s\n",
+						__func__, err->error,
+						strerror(-err->error));
+					ret = err->error;
+					goto out;
+				}
+
+				ret = 0;
+				if (cb)	{
+					int r = cb(h, arg_cb);
+
+					if (r <= 0)
+						ret = r;
+				}
+				goto out;
+			}
+
+			if (cb) {
+				int r = cb(h, arg_cb);
+
+				if (r <= 0) {
+					ret = r;
+					goto out;
+				}
+			} else {
+				fprintf(stderr, "%s: RTNL: unexpected reply\n",
+					__func__);
+			}
+
+			rcv_len -= NLMSG_ALIGN(len);
+			h = (struct nlmsghdr *)((uint8_t *)h +
+						NLMSG_ALIGN(len));
+		}
+
+		if (nlmsg.msg_flags & MSG_TRUNC) {
+			fprintf(stderr, "%s: message truncated\n", __func__);
+			continue;
+		}
+
+		if (rcv_len) {
+			fprintf(stderr, "%s: rtnl: %d not parsed bytes\n",
+				__func__, rcv_len);
+			ret = -1;
+			goto out;
+		}
+	}
+out:
+	close(fd);
+
+	return ret;
+}
+
+struct ovpn_link_req {
+	struct nlmsghdr n;
+	struct ifinfomsg i;
+	char buf[256];
+};
+
+static int ovpn_new_iface(struct ovpn_ctx *ovpn)
+{
+	struct rtattr *linkinfo, *data;
+	struct ovpn_link_req req = { 0 };
+	int ret = -1;
+
+	fprintf(stdout, "Creating interface %s with mode %u\n", ovpn->ifname,
+		ovpn->mode);
+
+	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+	req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
+	req.n.nlmsg_type = RTM_NEWLINK;
+
+	if (ovpn_addattr(&req.n, sizeof(req), IFLA_IFNAME, ovpn->ifname,
+			 strlen(ovpn->ifname) + 1) < 0)
+		goto err;
+
+	linkinfo = ovpn_nest_start(&req.n, sizeof(req), IFLA_LINKINFO);
+	if (!linkinfo)
+		goto err;
+
+	if (ovpn_addattr(&req.n, sizeof(req), IFLA_INFO_KIND, OVPN_FAMILY_NAME,
+			 strlen(OVPN_FAMILY_NAME) + 1) < 0)
+		goto err;
+
+	if (ovpn->mode_set) {
+		data = ovpn_nest_start(&req.n, sizeof(req), IFLA_INFO_DATA);
+		if (!data)
+			goto err;
+
+		if (ovpn_addattr(&req.n, sizeof(req), IFLA_OVPN_MODE,
+				 &ovpn->mode, sizeof(uint8_t)) < 0)
+			goto err;
+
+		ovpn_nest_end(&req.n, data);
+	}
+
+	ovpn_nest_end(&req.n, linkinfo);
+
+	req.i.ifi_family = AF_PACKET;
+
+	ret = ovpn_rt_send(&req.n, 0, 0, NULL, NULL);
+err:
+	return ret;
+}
+
+static int ovpn_del_iface(struct ovpn_ctx *ovpn)
+{
+	struct ovpn_link_req req = { 0 };
+
+	fprintf(stdout, "Deleting interface %s ifindex %u\n", ovpn->ifname,
+		ovpn->ifindex);
+
+	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+	req.n.nlmsg_flags = NLM_F_REQUEST;
+	req.n.nlmsg_type = RTM_DELLINK;
+
+	req.i.ifi_family = AF_PACKET;
+	req.i.ifi_index = ovpn->ifindex;
+
+	return ovpn_rt_send(&req.n, 0, 0, NULL, NULL);
+}
+
+static int nl_seq_check(struct nl_msg (*msg)__always_unused,
+			void (*arg)__always_unused)
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
+static int mcast_error_handler(struct sockaddr_nl (*nla)__always_unused,
+			       struct nlmsgerr *err, void *arg)
+{
+	int *ret = arg;
+
+	*ret = err->error;
+	return NL_STOP;
+}
+
+static int mcast_ack_handler(struct nl_msg (*msg)__always_unused, void *arg)
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
+	int *ret = arg;
+	__u32 ifindex;
+
+	fprintf(stderr, "received message from ovpn-dco\n");
+
+	*ret = -1;
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
+	*ret = 0;
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
+static int ovpn_listen_mcast(void)
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
+	ret = 1;
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	nl_cb_set(cb, NL_CB_SEQ_CHECK, NL_CB_CUSTOM, nl_seq_check, NULL);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, &ret);
+	nl_cb_err(cb, NL_CB_CUSTOM, ovpn_nl_cb_error, &ret);
+
+	while (ret == 1) {
+		int err = nl_recvmsgs(sock, cb);
+
+		if (err < 0) {
+			fprintf(stderr,
+				"cannot receive netlink message: (%d) %s\n",
+				err, nl_geterror(-err));
+			ret = -1;
+			break;
+		}
+	}
+
+	nl_cb_put(cb);
+err_free:
+	nl_socket_free(sock);
+	return ret;
+}
+
+static void usage(const char *cmd)
+{
+	fprintf(stderr,
+		"Usage %s <command> <iface> [arguments..]\n",
+		cmd);
+	fprintf(stderr, "where <command> can be one of the following\n\n");
+
+	fprintf(stderr, "* new_iface <iface> [mode]: create new ovpn interface\n");
+	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr, "\tmode:\n");
+	fprintf(stderr, "\t\t- P2P for peer-to-peer mode (i.e. client)\n");
+	fprintf(stderr, "\t\t- MP for multi-peer mode (i.e. server)\n");
+
+	fprintf(stderr, "* del_iface <iface>: delete ovpn interface\n");
+	fprintf(stderr, "\tiface: ovpn interface name\n");
+
+	fprintf(stderr,
+		"* listen <iface> <lport> <peers_file> [ipv6]: listen for incoming peer TCP connections\n");
+	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr, "\tlport: TCP port to listen to\n");
+	fprintf(stderr,
+		"\tpeers_file: file containing one peer per line: Line format:\n");
+	fprintf(stderr, "\t\t<peer_id> <vpnaddr>\n");
+	fprintf(stderr,
+		"\tipv6: whether the socket should listen to the IPv6 wildcard address\n");
+
+	fprintf(stderr,
+		"* connect <iface> <peer_id> <raddr> <rport> [key_file]: start connecting peer of TCP-based VPN session\n");
+	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr, "\tpeer_id: peer ID of the connecting peer\n");
+	fprintf(stderr, "\traddr: peer IP address to connect to\n");
+	fprintf(stderr, "\trport: peer TCP port to connect to\n");
+	fprintf(stderr,
+		"\tkey_file: file containing the symmetric key for encryption\n");
+
+	fprintf(stderr,
+		"* new_peer <iface> <peer_id> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
+	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr, "\tlport: local UDP port to bind to\n");
+	fprintf(stderr,
+		"\tpeer_id: peer ID to be used in data packets to/from this peer\n");
+	fprintf(stderr, "\traddr: peer IP address\n");
+	fprintf(stderr, "\trport: peer UDP port\n");
+	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
+
+	fprintf(stderr,
+		"* new_multi_peer <iface> <lport> <peers_file>: add multiple peers as listed in the file\n");
+	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr, "\tlport: local UDP port to bind to\n");
+	fprintf(stderr,
+		"\tpeers_file: text file containing one peer per line. Line format:\n");
+	fprintf(stderr, "\t\t<peer_id> <raddr> <rport> <vpnaddr>\n");
+
+	fprintf(stderr,
+		"* set_peer <iface> <peer_id> <keepalive_interval> <keepalive_timeout>: set peer attributes\n");
+	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
+	fprintf(stderr,
+		"\tkeepalive_interval: interval for sending ping messages\n");
+	fprintf(stderr,
+		"\tkeepalive_timeout: time after which a peer is timed out\n");
+
+	fprintf(stderr, "* del_peer <iface> <peer_id>: delete peer\n");
+	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr, "\tpeer_id: peer ID of the peer to delete\n");
+
+	fprintf(stderr, "* get_peer <iface> [peer_id]: retrieve peer(s) status\n");
+	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr,
+		"\tpeer_id: peer ID of the peer to query. All peers are returned if omitted\n");
+
+	fprintf(stderr,
+		"* new_key <iface> <peer_id> <slot> <key_id> <cipher> <key_dir> <key_file>: set data channel key\n");
+	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr,
+		"\tpeer_id: peer ID of the peer to configure the key for\n");
+	fprintf(stderr, "\tslot: either 1 (primary) or 2 (secondary)\n");
+	fprintf(stderr, "\tkey_id: an ID from 0 to 7\n");
+	fprintf(stderr,
+		"\tcipher: cipher to use, supported: aes (AES-GCM), chachapoly (CHACHA20POLY1305)\n");
+	fprintf(stderr,
+		"\tkey_dir: key direction, must 0 on one host and 1 on the other\n");
+	fprintf(stderr, "\tkey_file: file containing the pre-shared key\n");
+
+	fprintf(stderr,
+		"* del_key <iface> <peer_id> [slot]: erase existing data channel key\n");
+	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
+	fprintf(stderr, "\tslot: slot to erase. PRIMARY if omitted\n");
+
+	fprintf(stderr,
+		"* get_key <iface> <peer_id> <slot>: retrieve non sensible key data\n");
+	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr, "\tpeer_id: peer ID of the peer to query\n");
+	fprintf(stderr, "\tslot: either 1 (primary) or 2 (secondary)\n");
+
+	fprintf(stderr,
+		"* swap_keys <iface> <peer_id>: swap content of primary and secondary key slots\n");
+	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
+
+	fprintf(stderr,
+		"* listen_mcast: listen to ovpn netlink multicast messages\n");
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
+	if (errno == ERANGE || ovpn->peer_id > PEER_ID_UNDEF) {
+		fprintf(stderr, "peer ID value out of range\n");
+		return -1;
+	}
+
+	return ovpn_parse_remote(ovpn, raddr, rport, vpnip);
+}
+
+static int ovpn_parse_key_slot(const char *arg, struct ovpn_ctx *ovpn)
+{
+	int slot = strtoul(arg, NULL, 10);
+
+	if (errno == ERANGE || slot < 1 || slot > 2) {
+		fprintf(stderr, "key slot out of range\n");
+		return -1;
+	}
+
+	switch (slot) {
+	case 1:
+		ovpn->key_slot = OVPN_KEY_SLOT_PRIMARY;
+		break;
+	case 2:
+		ovpn->key_slot = OVPN_KEY_SLOT_SECONDARY;
+		break;
+	}
+
+	return 0;
+}
+
+static int ovpn_send_tcp_data(int socket)
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
+
+	return ret > 0 ? 0 : ret;
+}
+
+static int ovpn_recv_tcp_data(int socket)
+{
+	uint8_t buf[1002];
+	uint16_t len;
+	int ret;
+
+	ret = recv(socket, buf, sizeof(buf), 0);
+
+	if (ret < 2) {
+		fprintf(stderr, ">>>> Error while reading TCP data: %d\n", ret);
+		return ret;
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
+	return 0;
+}
+
+static enum ovpn_cmd ovpn_parse_cmd(const char *cmd)
+{
+	if (!strcmp(cmd, "new_iface"))
+		return CMD_NEW_IFACE;
+
+	if (!strcmp(cmd, "del_iface"))
+		return CMD_DEL_IFACE;
+
+	if (!strcmp(cmd, "listen"))
+		return CMD_LISTEN;
+
+	if (!strcmp(cmd, "connect"))
+		return CMD_CONNECT;
+
+	if (!strcmp(cmd, "new_peer"))
+		return CMD_NEW_PEER;
+
+	if (!strcmp(cmd, "new_multi_peer"))
+		return CMD_NEW_MULTI_PEER;
+
+	if (!strcmp(cmd, "set_peer"))
+		return CMD_SET_PEER;
+
+	if (!strcmp(cmd, "del_peer"))
+		return CMD_DEL_PEER;
+
+	if (!strcmp(cmd, "get_peer"))
+		return CMD_GET_PEER;
+
+	if (!strcmp(cmd, "new_key"))
+		return CMD_NEW_KEY;
+
+	if (!strcmp(cmd, "del_key"))
+		return CMD_DEL_KEY;
+
+	if (!strcmp(cmd, "get_key"))
+		return CMD_GET_KEY;
+
+	if (!strcmp(cmd, "swap_keys"))
+		return CMD_SWAP_KEYS;
+
+	if (!strcmp(cmd, "listen_mcast"))
+		return CMD_LISTEN_MCAST;
+
+	return CMD_INVALID;
+}
+
+static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
+{
+	char peer_id[10], vpnip[INET6_ADDRSTRLEN], raddr[128], rport[10];
+	int n, ret;
+	FILE *fp;
+
+	switch (ovpn->cmd) {
+	case CMD_NEW_IFACE:
+		ret = ovpn_new_iface(ovpn);
+		break;
+	case CMD_DEL_IFACE:
+		ret = ovpn_del_iface(ovpn);
+		break;
+	case CMD_LISTEN:
+		ret = ovpn_listen(ovpn, ovpn->sa_family);
+		if (ret < 0) {
+			fprintf(stderr, "cannot listen on TCP socket\n");
+			return ret;
+		}
+
+		fp = fopen(ovpn->peers_file, "r");
+		if (!fp) {
+			fprintf(stderr, "cannot open file: %s\n",
+				ovpn->peers_file);
+			return -1;
+		}
+
+		while ((n = fscanf(fp, "%s %s\n", peer_id, vpnip)) == 2) {
+			struct ovpn_ctx peer_ctx = { 0 };
+
+			peer_ctx.ifindex = ovpn->ifindex;
+			peer_ctx.sa_family = ovpn->sa_family;
+
+			peer_ctx.socket = ovpn_accept(ovpn);
+			if (peer_ctx.socket < 0) {
+				fprintf(stderr, "cannot accept connection!\n");
+				return -1;
+			}
+
+			/* store the socket of the first peer to test TCP I/O */
+			if (ovpn->cli_socket < 0)
+				ovpn->cli_socket = peer_ctx.socket;
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
+		if (ovpn->cli_socket >= 0)
+			ret = ovpn_recv_tcp_data(ovpn->cli_socket);
+
+		break;
+	case CMD_CONNECT:
+		ret = ovpn_connect(ovpn);
+		if (ret < 0) {
+			fprintf(stderr, "cannot connect TCP socket\n");
+			return ret;
+		}
+
+		ret = ovpn_new_peer(ovpn, true);
+		if (ret < 0) {
+			fprintf(stderr, "cannot add peer to VPN\n");
+			close(ovpn->socket);
+			return ret;
+		}
+
+		if (ovpn->cipher != OVPN_CIPHER_ALG_NONE) {
+			ret = ovpn_new_key(ovpn);
+			if (ret < 0) {
+				fprintf(stderr, "cannot set key\n");
+				return ret;
+			}
+		}
+
+		ret = ovpn_send_tcp_data(ovpn->socket);
+		break;
+	case CMD_NEW_PEER:
+		ret = ovpn_udp_socket(ovpn, AF_INET6); //ovpn->sa_family ?
+		if (ret < 0)
+			return ret;
+
+		ret = ovpn_new_peer(ovpn, false);
+		break;
+	case CMD_NEW_MULTI_PEER:
+		ret = ovpn_udp_socket(ovpn, AF_INET6);
+		if (ret < 0)
+			return ret;
+
+		fp = fopen(ovpn->peers_file, "r");
+		if (!fp) {
+			fprintf(stderr, "cannot open file: %s\n",
+				ovpn->peers_file);
+			return -1;
+		}
+
+		while ((n = fscanf(fp, "%s %s %s %s\n", peer_id, raddr, rport,
+				   vpnip)) == 4) {
+			struct ovpn_ctx peer_ctx = { 0 };
+
+			peer_ctx.ifindex = ovpn->ifindex;
+			peer_ctx.socket = ovpn->socket;
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
+		break;
+	case CMD_SET_PEER:
+		ret = ovpn_set_peer(ovpn);
+		break;
+	case CMD_DEL_PEER:
+		ret = ovpn_del_peer(ovpn);
+		break;
+	case CMD_GET_PEER:
+		if (ovpn->peer_id == PEER_ID_UNDEF)
+			fprintf(stderr, "List of peers connected to: %s\n",
+				ovpn->ifname);
+
+		ret = ovpn_get_peer(ovpn);
+		break;
+	case CMD_NEW_KEY:
+		ret = ovpn_new_key(ovpn);
+		break;
+	case CMD_DEL_KEY:
+		ret = ovpn_del_key(ovpn);
+		break;
+	case CMD_GET_KEY:
+		ret = ovpn_get_key(ovpn);
+		break;
+	case CMD_SWAP_KEYS:
+		ret = ovpn_swap_keys(ovpn);
+		break;
+	case CMD_LISTEN_MCAST:
+		ret = ovpn_listen_mcast();
+		break;
+	case CMD_INVALID:
+		break;
+	}
+
+	return ret;
+}
+
+static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
+{
+	int ret;
+
+	/* no args required for LISTEN_MCAST */
+	if (ovpn->cmd == CMD_LISTEN_MCAST)
+		return 0;
+
+	/* all commands need an ifname */
+	if (argc < 3)
+		return -EINVAL;
+
+	strscpy(ovpn->ifname, argv[2], IFNAMSIZ - 1);
+	ovpn->ifname[IFNAMSIZ - 1] = '\0';
+
+	/* all commands, except NEW_IFNAME, needs an ifindex */
+	if (ovpn->cmd != CMD_NEW_IFACE) {
+		ovpn->ifindex = if_nametoindex(ovpn->ifname);
+		if (!ovpn->ifindex) {
+			fprintf(stderr, "cannot find interface: %s\n",
+				strerror(errno));
+			return -1;
+		}
+	}
+
+	switch (ovpn->cmd) {
+	case CMD_NEW_IFACE:
+		if (argc < 4)
+			break;
+
+		if (!strcmp(argv[3], "P2P")) {
+			ovpn->mode = OVPN_MODE_P2P;
+		} else if (!strcmp(argv[3], "MP")) {
+			ovpn->mode = OVPN_MODE_MP;
+		} else {
+			fprintf(stderr, "Cannot parse iface mode: %s\n",
+				argv[3]);
+			return -1;
+		}
+		ovpn->mode_set = true;
+		break;
+	case CMD_DEL_IFACE:
+		break;
+	case CMD_LISTEN:
+		if (argc < 5)
+			return -EINVAL;
+
+		ovpn->lport = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE || ovpn->lport > 65535) {
+			fprintf(stderr, "lport value out of range\n");
+			return -1;
+		}
+
+		ovpn->peers_file = argv[4];
+
+		if (argc > 5 && !strcmp(argv[5], "ipv6"))
+			ovpn->sa_family = AF_INET6;
+		break;
+	case CMD_CONNECT:
+		if (argc < 6)
+			return -EINVAL;
+
+		ovpn->sa_family = AF_INET;
+
+		ret = ovpn_parse_new_peer(ovpn, argv[3], argv[4], argv[5],
+					  NULL);
+		if (ret < 0) {
+			fprintf(stderr, "Cannot parse remote peer data\n");
+			return -1;
+		}
+
+		if (argc > 6) {
+			ovpn->key_slot = OVPN_KEY_SLOT_PRIMARY;
+			ovpn->key_id = 0;
+			ovpn->cipher = OVPN_CIPHER_ALG_AES_GCM;
+			ovpn->key_dir = KEY_DIR_OUT;
+
+			ret = ovpn_parse_key(argv[6], ovpn);
+			if (ret)
+				return -1;
+		}
+		break;
+	case CMD_NEW_PEER:
+		if (argc < 7)
+			return -EINVAL;
+
+		ovpn->lport = strtoul(argv[4], NULL, 10);
+		if (errno == ERANGE || ovpn->lport > 65535) {
+			fprintf(stderr, "lport value out of range\n");
+			return -1;
+		}
+
+		const char *vpnip = (argc > 7) ? argv[7] : NULL;
+
+		ret = ovpn_parse_new_peer(ovpn, argv[3], argv[5], argv[6],
+					  vpnip);
+		if (ret < 0)
+			return -1;
+		break;
+	case CMD_NEW_MULTI_PEER:
+		if (argc < 5)
+			return -EINVAL;
+
+		ovpn->lport = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE || ovpn->lport > 65535) {
+			fprintf(stderr, "lport value out of range\n");
+			return -1;
+		}
+
+		ovpn->peers_file = argv[4];
+		break;
+	case CMD_SET_PEER:
+		if (argc < 6)
+			return -EINVAL;
+
+		ovpn->peer_id = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE || ovpn->peer_id > PEER_ID_UNDEF) {
+			fprintf(stderr, "peer ID value out of range\n");
+			return -1;
+		}
+
+		ovpn->keepalive_interval = strtoul(argv[4], NULL, 10);
+		if (errno == ERANGE) {
+			fprintf(stderr,
+				"keepalive interval value out of range\n");
+			return -1;
+		}
+
+		ovpn->keepalive_timeout = strtoul(argv[5], NULL, 10);
+		if (errno == ERANGE) {
+			fprintf(stderr,
+				"keepalive interval value out of range\n");
+			return -1;
+		}
+		break;
+	case CMD_DEL_PEER:
+		if (argc < 4)
+			return -EINVAL;
+
+		ovpn->peer_id = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE || ovpn->peer_id > PEER_ID_UNDEF) {
+			fprintf(stderr, "peer ID value out of range\n");
+			return -1;
+		}
+		break;
+	case CMD_GET_PEER:
+		ovpn->peer_id = PEER_ID_UNDEF;
+		if (argc > 3) {
+			ovpn->peer_id = strtoul(argv[3], NULL, 10);
+			if (errno == ERANGE || ovpn->peer_id > PEER_ID_UNDEF) {
+				fprintf(stderr, "peer ID value out of range\n");
+				return -1;
+			}
+		}
+		break;
+	case CMD_NEW_KEY:
+		if (argc < 9)
+			return -EINVAL;
+
+		ovpn->peer_id = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE) {
+			fprintf(stderr, "peer ID value out of range\n");
+			return -1;
+		}
+
+		ret = ovpn_parse_key_slot(argv[4], ovpn);
+		if (ret)
+			return -1;
+
+		ovpn->key_id = strtoul(argv[5], NULL, 10);
+		if (errno == ERANGE || ovpn->key_id > 2) {
+			fprintf(stderr, "key ID out of range\n");
+			return -1;
+		}
+
+		ret = ovpn_parse_cipher(argv[6], ovpn);
+		if (ret < 0)
+			return -1;
+
+		ret = ovpn_parse_key_direction(argv[7], ovpn);
+		if (ret < 0)
+			return -1;
+
+		ret = ovpn_parse_key(argv[8], ovpn);
+		if (ret)
+			return -1;
+		break;
+	case CMD_DEL_KEY:
+		if (argc < 4)
+			return -EINVAL;
+
+		ovpn->peer_id = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE) {
+			fprintf(stderr, "peer ID value out of range\n");
+			return -1;
+		}
+
+		ret = ovpn_parse_key_slot(argv[4], ovpn);
+		if (ret)
+			return ret;
+		break;
+	case CMD_GET_KEY:
+		if (argc < 5)
+			return -EINVAL;
+
+		ovpn->peer_id = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE) {
+			fprintf(stderr, "peer ID value out of range\n");
+			return -1;
+		}
+
+		ret = ovpn_parse_key_slot(argv[4], ovpn);
+		if (ret)
+			return ret;
+		break;
+	case CMD_SWAP_KEYS:
+		if (argc < 4)
+			return -EINVAL;
+
+		ovpn->peer_id = strtoul(argv[3], NULL, 10);
+		if (errno == ERANGE) {
+			fprintf(stderr, "peer ID value out of range\n");
+			return -1;
+		}
+		break;
+	case CMD_LISTEN_MCAST:
+		break;
+	case CMD_INVALID:
+		break;
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	struct ovpn_ctx ovpn;
+	int ret;
+
+	if (argc < 2) {
+		usage(argv[0]);
+		return -1;
+	}
+
+	memset(&ovpn, 0, sizeof(ovpn));
+	ovpn.sa_family = AF_INET;
+	ovpn.cipher = OVPN_CIPHER_ALG_NONE;
+	ovpn.cli_socket = -1;
+
+	ovpn.cmd = ovpn_parse_cmd(argv[1]);
+	if (ovpn.cmd == CMD_INVALID) {
+		fprintf(stderr, "Error: unknown command.\n\n");
+		usage(argv[0]);
+		return -1;
+	}
+
+	ret = ovpn_parse_cmd_args(&ovpn, argc, argv);
+	if (ret < 0) {
+		fprintf(stderr, "Error: invalid arguments.\n\n");
+		if (ret == -EINVAL)
+			usage(argv[0]);
+		return ret;
+	}
+
+	ret = ovpn_run_cmd(&ovpn);
+	if (ret)
+		fprintf(stderr, "Cannot execute command: %s (%d)\n",
+			strerror(-ret), ret);
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
diff --git a/tools/testing/selftests/net/ovpn/test-chachapoly.sh b/tools/testing/selftests/net/ovpn/test-chachapoly.sh
new file mode 100755
index 0000000000000000000000000000000000000000..79788f10d33b9682ed27590a48d136eb50b2202c
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-chachapoly.sh
@@ -0,0 +1,9 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 OpenVPN, Inc.
+#
+#  Author:	Antonio Quartulli <antonio@openvpn.net>
+
+ALG="chachapoly"
+
+source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test-float.sh b/tools/testing/selftests/net/ovpn/test-float.sh
new file mode 100755
index 0000000000000000000000000000000000000000..93e1b729861d6b3f9f3f2e19d84e524c293ee3cf
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-float.sh
@@ -0,0 +1,9 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 OpenVPN, Inc.
+#
+#  Author:	Antonio Quartulli <antonio@openvpn.net>
+
+FLOAT="1"
+
+source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test-tcp.sh b/tools/testing/selftests/net/ovpn/test-tcp.sh
new file mode 100755
index 0000000000000000000000000000000000000000..7542f595cc5696396513ed029cb96fe3b922d0e4
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-tcp.sh
@@ -0,0 +1,9 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 OpenVPN, Inc.
+#
+#  Author:	Antonio Quartulli <antonio@openvpn.net>
+
+PROTO="TCP"
+
+source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
new file mode 100755
index 0000000000000000000000000000000000000000..fd5a35b5bac0c021e0e17bddf4ed3bec6ef3a384
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -0,0 +1,182 @@
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
+FLOAT=${FLOAT:-0}
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
+			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} ${1} 1 10.10.${1}.1 1
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
+				data64.key
+		fi
+	fi
+}
+
+cleanup() {
+	# first test peers disconnect on down event
+	for p in $(seq 0 10); do
+		ip -n peer${p} link set tun${p} down 2>/dev/null || true
+	done
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
+modprobe -q ovpn || true
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
+if [ "$FLOAT" == "1" ]; then
+	# make clients float..
+	for p in $(seq 1 ${NUM_PEERS}); do
+		ip -n peer${p} addr del 10.10.${p}.2/24 dev veth${p}
+		ip -n peer${p} addr add 10.10.${p}.3/24 dev veth${p}
+	done
+	for p in $(seq 1 ${NUM_PEERS}); do
+		ip netns exec peer${p} ping -qfc 1000 -w 5 5.5.5.1
+	done
+fi
+
+ip netns exec peer0 iperf3 -1 -s &
+sleep 1
+ip netns exec peer1 iperf3 -Z -t 3 -c 5.5.5.1
+
+echo "Adding secondary key and then swap:"
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
+echo "Deleting peer 1:"
+ip netns exec peer0 ${OVPN_CLI} del_peer tun0 1
+ip netns exec peer1 ${OVPN_CLI} del_peer tun1 1
+
+echo "Querying keys:"
+for p in $(seq 2 ${NUM_PEERS}); do
+	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} ${p} 1
+	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} ${p} 2
+done
+
+echo "Deleting keys:"
+for p in $(seq 2 ${NUM_PEERS}); do
+	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} ${p} 1
+	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} ${p} 2
+done
+
+echo "Setting timeout to 10s MP:"
+for p in $(seq 2 ${NUM_PEERS}); do
+	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 10 10 || true
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} ${p} 0 0
+done
+# wait for peers to timeout
+sleep 15
+
+echo "Setting timeout to 10s P2P:"
+for p in $(seq 2 ${NUM_PEERS}); do
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} ${p} 10 10
+done
+sleep 15
+
+cleanup
+
+modprobe -r ovpn || true
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


