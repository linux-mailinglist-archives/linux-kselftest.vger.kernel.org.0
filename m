Return-Path: <linux-kselftest+bounces-2186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E9A8184CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 10:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04AF2858B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 09:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA79714A81;
	Tue, 19 Dec 2023 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lx5V3Tgc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749CF1426B;
	Tue, 19 Dec 2023 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cda24a77e0so941226a12.2;
        Tue, 19 Dec 2023 01:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702979372; x=1703584172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2X8UVuUbchpztlNlu1B9MVgkZAm0pyuW2tgoQGv3vwg=;
        b=lx5V3TgcSfpcQP25yUX8fM0aG/xxFWuCVZgjEzpd8pw1Ptb/WO30KwdQfvcJlkHAuf
         FVlmW5jJpnaI5FZGT1AbTAGG2QUFxpSOWbpaGpHYShPCjSwlGqeMuvXfi1DgiwfeJ2om
         ZEoyUUDwoVAMZc+gLv3lKMC1hyvxWHTWOaUhmzGIPidfCTg/JRJC85136byT6aVIiADW
         KJ+zDtLw6Pi1S3ZPwpgiFxUIwgx5pxMHWxfN0nKiSHHwOcVANf6BctyKybQma9f5xfsB
         WvVotbqtKKqxb3CzHivBXjWfd5ZsLz7FM3+1GEVLd3QA9u+528qTgKBKNQcmjyZdObZo
         i2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702979372; x=1703584172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2X8UVuUbchpztlNlu1B9MVgkZAm0pyuW2tgoQGv3vwg=;
        b=v0vL9GL8SV5M1kVLqI28x+bDcVdWro4GPeQ41zC4+Vu4URWXnzXqxBjbTEAhkL8pCx
         IL1py+83fAIH+b/VWpwZSLookGNTRBvoE32rx60WkEj2fkc1Vl3yz6i152Yx6rjCqrbK
         StfoNXNahLDj4ZeX3R00Ga91iTevzAGXLOz/LA5fIdVFlKCNvgpeJpJ0SJlyCUhXCT2V
         +WyBho5PZfIpxyslmwB9Bmj3Tpa44ySWM/FeOXVNfosvBs6opioTl6A+JC0XeWVG55rb
         mStzIcHIqmf9LA2AQPHQuTshpDsvI2m1Xwv0qUm0uLAG2TgwEi7M76Df5qBDVyTkZzut
         mgNw==
X-Gm-Message-State: AOJu0Yx2Fgr336w84nEAJxbFa0a9OZbgyk5tY/FpAGxz0D5BwMLjtBeH
	ZeRcuuJ1Tzk9eY6WnaYMztf8jE8A163o3x3rh5Q=
X-Google-Smtp-Source: AGHT+IHiAFRjisOy85FpbWoav45DgfkGtP/uqSxHeu5/9UcEFALuZkEFqzvbdSi5DiO66svEXSBCoA==
X-Received: by 2002:a05:6a21:1a8:b0:194:b79c:9960 with SMTP id le40-20020a056a2101a800b00194b79c9960mr107496pzb.50.1702979372279;
        Tue, 19 Dec 2023 01:49:32 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ds17-20020a17090b08d100b0028b21d24ba6sm1076276pjb.15.2023.12.19.01.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:49:31 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Florian Westphal <fw@strlen.de>,
	Martin KaFai Lau <kafai@fb.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 6/8] selftests/net: use unique netns name for setup_loopback.sh setup_veth.sh
Date: Tue, 19 Dec 2023 17:48:54 +0800
Message-ID: <20231219094856.1740079-7-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219094856.1740079-1-liuhangbin@gmail.com>
References: <20231219094856.1740079-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The setup_loopback and setup_veth use their own way to create namespace.
So let's just re-define server_ns/client_ns to unique name.
At the same time update the namespace name in gro.sh and toeplitz.sh.
As I don't have env to run toeplitz.sh. Here is only the gro test result.

 # ./gro.sh
 running test ipv4 data
 Expected {200 }, Total 1 packets
 Received {200 }, Total 1 packets.
 ...
 Gro::large test passed.
 All Tests Succeeded!

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/gro.sh            |  4 ++--
 tools/testing/selftests/net/setup_loopback.sh |  8 +++++---
 tools/testing/selftests/net/setup_veth.sh     |  9 ++++++---
 tools/testing/selftests/net/toeplitz.sh       | 14 +++++++-------
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
index 342ad27f631b..19352f106c1d 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -23,11 +23,11 @@ run_test() {
   # on every try.
   for tries in {1..3}; do
     # Actual test starts here
-    ip netns exec server_ns ./gro "${ARGS[@]}" "--rx" "--iface" "server" \
+    ip netns exec $server_ns ./gro "${ARGS[@]}" "--rx" "--iface" "server" \
       1>>log.txt &
     server_pid=$!
     sleep 0.5  # to allow for socket init
-    ip netns exec client_ns ./gro "${ARGS[@]}" "--iface" "client" \
+    ip netns exec $client_ns ./gro "${ARGS[@]}" "--iface" "client" \
       1>>log.txt
     wait "${server_pid}"
     exit_code=$?
diff --git a/tools/testing/selftests/net/setup_loopback.sh b/tools/testing/selftests/net/setup_loopback.sh
index e57bbfbc5208..2070b57849de 100755
--- a/tools/testing/selftests/net/setup_loopback.sh
+++ b/tools/testing/selftests/net/setup_loopback.sh
@@ -5,6 +5,8 @@ readonly FLUSH_PATH="/sys/class/net/${dev}/gro_flush_timeout"
 readonly IRQ_PATH="/sys/class/net/${dev}/napi_defer_hard_irqs"
 readonly FLUSH_TIMEOUT="$(< ${FLUSH_PATH})"
 readonly HARD_IRQS="$(< ${IRQ_PATH})"
+readonly server_ns=$(mktemp -u server-XXXXXXXX)
+readonly client_ns=$(mktemp -u client-XXXXXXXX)
 
 netdev_check_for_carrier() {
 	local -r dev="$1"
@@ -97,12 +99,12 @@ setup_interrupt() {
 
 setup_ns() {
 	# Set up server_ns namespace and client_ns namespace
-	setup_macvlan_ns "${dev}" server_ns server "${SERVER_MAC}"
-	setup_macvlan_ns "${dev}" client_ns client "${CLIENT_MAC}"
+	setup_macvlan_ns "${dev}" ${server_ns} server "${SERVER_MAC}"
+	setup_macvlan_ns "${dev}" ${client_ns} client "${CLIENT_MAC}"
 }
 
 cleanup_ns() {
-	cleanup_macvlan_ns server_ns server client_ns client
+	cleanup_macvlan_ns ${server_ns} server ${client_ns} client
 }
 
 setup() {
diff --git a/tools/testing/selftests/net/setup_veth.sh b/tools/testing/selftests/net/setup_veth.sh
index 1003ddf7b3b2..a9a1759e035c 100644
--- a/tools/testing/selftests/net/setup_veth.sh
+++ b/tools/testing/selftests/net/setup_veth.sh
@@ -1,6 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+readonly server_ns=$(mktemp -u server-XXXXXXXX)
+readonly client_ns=$(mktemp -u client-XXXXXXXX)
+
 setup_veth_ns() {
 	local -r link_dev="$1"
 	local -r ns_name="$2"
@@ -19,14 +22,14 @@ setup_ns() {
 	# Set up server_ns namespace and client_ns namespace
 	ip link add name server type veth peer name client
 
-	setup_veth_ns "${dev}" server_ns server "${SERVER_MAC}"
-	setup_veth_ns "${dev}" client_ns client "${CLIENT_MAC}"
+	setup_veth_ns "${dev}" ${server_ns} server "${SERVER_MAC}"
+	setup_veth_ns "${dev}" ${client_ns} client "${CLIENT_MAC}"
 }
 
 cleanup_ns() {
 	local ns_name
 
-	for ns_name in client_ns server_ns; do
+	for ns_name in ${client_ns} ${server_ns}; do
 		[[ -e /var/run/netns/"${ns_name}" ]] && ip netns del "${ns_name}"
 	done
 }
diff --git a/tools/testing/selftests/net/toeplitz.sh b/tools/testing/selftests/net/toeplitz.sh
index da5bfd834eff..8ff172f7bb1b 100755
--- a/tools/testing/selftests/net/toeplitz.sh
+++ b/tools/testing/selftests/net/toeplitz.sh
@@ -147,14 +147,14 @@ setup() {
 	setup_loopback_environment "${DEV}"
 
 	# Set up server_ns namespace and client_ns namespace
-	setup_macvlan_ns "${DEV}" server_ns server \
+	setup_macvlan_ns "${DEV}" $server_ns server \
 	"${SERVER_MAC}" "${SERVER_IP}"
-	setup_macvlan_ns "${DEV}" client_ns client \
+	setup_macvlan_ns "${DEV}" $client_ns client \
 	"${CLIENT_MAC}" "${CLIENT_IP}"
 }
 
 cleanup() {
-	cleanup_macvlan_ns server_ns server client_ns client
+	cleanup_macvlan_ns $server_ns server $client_ns client
 	cleanup_loopback "${DEV}"
 }
 
@@ -170,22 +170,22 @@ if [[ "${TEST_RSS}" = true ]]; then
 	# RPS/RFS must be disabled because they move packets between cpus,
 	# which breaks the PACKET_FANOUT_CPU identification of RSS decisions.
 	eval "$(get_disable_rfs_cmd) $(get_disable_rps_cmd)" \
-	  ip netns exec server_ns ./toeplitz "${IP_FLAG}" "${PROTO_FLAG}" \
+	  ip netns exec $server_ns ./toeplitz "${IP_FLAG}" "${PROTO_FLAG}" \
 	  -d "${PORT}" -i "${DEV}" -k "${KEY}" -T 1000 \
 	  -C "$(get_rx_irq_cpus)" -s -v &
 elif [[ ! -z "${RPS_MAP}" ]]; then
 	eval "$(get_disable_rfs_cmd) $(get_set_rps_bitmaps_cmd ${RPS_MAP})" \
-	  ip netns exec server_ns ./toeplitz "${IP_FLAG}" "${PROTO_FLAG}" \
+	  ip netns exec $server_ns ./toeplitz "${IP_FLAG}" "${PROTO_FLAG}" \
 	  -d "${PORT}" -i "${DEV}" -k "${KEY}" -T 1000 \
 	  -r "0x${RPS_MAP}" -s -v &
 else
-	ip netns exec server_ns ./toeplitz "${IP_FLAG}" "${PROTO_FLAG}" \
+	ip netns exec $server_ns ./toeplitz "${IP_FLAG}" "${PROTO_FLAG}" \
 	  -d "${PORT}" -i "${DEV}" -k "${KEY}" -T 1000 -s -v &
 fi
 
 server_pid=$!
 
-ip netns exec client_ns ./toeplitz_client.sh "${PROTO_FLAG}" \
+ip netns exec $client_ns ./toeplitz_client.sh "${PROTO_FLAG}" \
   "${IP_FLAG}" "${SERVER_IP%%/*}" "${PORT}" &
 
 client_pid=$!
-- 
2.43.0


