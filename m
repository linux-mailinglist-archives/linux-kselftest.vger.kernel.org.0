Return-Path: <linux-kselftest+bounces-34900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0476AD8A91
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47EA1E3747
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 11:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD152E7655;
	Fri, 13 Jun 2025 11:32:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A62E7625;
	Fri, 13 Jun 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814326; cv=none; b=HlRDCT581ALV5+Bmh5bPKZsEiuc/wmLu4IXlsxAKxgVTECLu0VRpc3r55dmAxelqguTPgIpypyAN9x9XGAicEHk/hHsfClWKrVK1rmSHMwMlwHQPCJ85PkU3jxR/x40F4+2IioUDMS3ThVDOt1jtgR292TY4+e8vBC8rqcGokZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814326; c=relaxed/simple;
	bh=5v/1hL/ALMXFWvwHghT7FERfuc6HtTVh0PFSKcLiZac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmIOJ2lCFgK51olmTdEGv9TFwh+aRt+LCmArx3YGheC0NETQUa8LQ7qDkCNMFQwNNaCG1jGSg2kKg2cIgak29MEI6yWAE594GTncIQyBDqTfMxSGvzH339juDZMwI0MdPzEFLH+X+SL6ZynFSGHmvmQ+0cEjYA8xt86LEPKTU9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-acb5ec407b1so328390866b.1;
        Fri, 13 Jun 2025 04:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814323; x=1750419123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFyrorJHtIadhR2WZLtoMNadK7UpAA+1kioSAElIigY=;
        b=WRnIjvB3Nv1R7Up6O3NhJxPrZigKvM2BS5L/oY5DH/2p6i4tlOzmTFRy0QkjPFpPzx
         Jgc5q+sfaBIFX3tgfXUA/xedYFu8nRG/ZncqZLZnGO7J1Khccf34W2m3CrVHEj9ge/gf
         ViHpMJU8iM6YyLH+G29v/OgROvrNJhij4nJxxtP65m5CDtkZSHTHLOOJzfh6Dr2rGWmf
         2MgRczmAJ8T7nbdV2RGaviZgP3M7AT81w50ZME3sIywd7w2tqzvLjLJgG0DKNAcLeGiY
         lnAZ2jNmXAeTUC5XdeDd8HUMWi4N54j4rpa4eBNh49LkF3dF8x3YZi7k8p5wuSBuJDTb
         Y/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW5UDWFRmxD/7HlAjwDcB0XuRvlipkDraz0HPdUsLalD98jhzK6iP5YQkM4UukkTCES7RKAUjYZCvCfNhk=@vger.kernel.org, AJvYcCXIifHh4fyNx9FaZRZ5wwwyCcOsfSFRHXQhuVfKaAaJfRhMnOaLMK7KSI+gc4IzEZnXs6+P4i7ibWTXSTU1Fs+Z@vger.kernel.org
X-Gm-Message-State: AOJu0YznfkqO8qkNEjSWw8pQ11qcVgEkBYbDQl/916ZryjXXwYDmTmyW
	86jrHMJeTThNBwD8n0aKsUXybjl4hkwT+6I4A1rn5Z9cvvtMnre8u8HsInlK5A==
X-Gm-Gg: ASbGncvVXq4HB9+4h0Pgqa21mVV4BGE61H3vEU/bfsdQrXO7x5BJ3R5tINJUEXJK9z0
	fcLNmhVtUTL/Q6MFcR1Aj6/RU0two6NBYEAC0amwBWw6DxyTEGOPUMFgYcsZGmGKykOI/FXguXc
	jG2crlKfEW67bIDR9F2+JiUz8b0JQ0OaLhyqqDUtzueGJvIE4ODy93YWKCgxrBMGIS9YKBeU170
	P9GN/sxMw+Eu5AjtN8V5DRgR9cYhl+ChIp6yc6zryD3VGn813BiW6VdClh4LaeW9Q1VKw9Hjjw7
	+ByiHnptLumWmYqVUAbqfSxKnoxc5L2LZY2VTjVQGxZ2RrXr7EnC4QHreJowuvwq
X-Google-Smtp-Source: AGHT+IE86EKMksqdrSTrjdwcwtxQBLt3kKhK3FPtOHFNpO6HlR6OunsYgQr09TKPN0G8jkm2FfYzRQ==
X-Received: by 2002:a17:907:60d6:b0:ade:7512:d9ba with SMTP id a640c23a62f3a-adec56499bdmr274510066b.26.1749814322614;
        Fri, 13 Jun 2025 04:32:02 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec815992bsm116199566b.13.2025.06.13.04.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:32:02 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Jun 2025 04:31:37 -0700
Subject: [PATCH net-next v3 8/8] selftests: net: add netconsole test for
 cmdline configuration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-rework-v3-8-0752bf2e6912@debian.org>
References: <20250613-rework-v3-0-0752bf2e6912@debian.org>
In-Reply-To: <20250613-rework-v3-0-0752bf2e6912@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=5920; i=leitao@debian.org;
 h=from:subject:message-id; bh=5v/1hL/ALMXFWvwHghT7FERfuc6HtTVh0PFSKcLiZac=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoTAwl9aFDYw33vVuP4gISRyabn1e94uoNoqrLK
 mHPhWbPNQ6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEwMJQAKCRA1o5Of/Hh3
 bZgAD/9vTsG+hAxU5w8AYPcmQleIqYKpT8hxQWBTTMlYIP5YkqTKI5qF+6wX3a912fK/RG9F4rS
 nNnVItg8wauR6g1ryk/juX1MaD87Yj7QSTZ5JN34Bep23rR2KCwbRDQUpI1t8cZ98d4TbQnLyRo
 fIUakeG+tJs8MaDBEQaGEsMIk4B5EHE2CoCtJQbPIfOrf684V9G3uWhHuxnPxGZwFWOt8esC5OF
 5GXdXdHS+yn2Wv0pKYHG5MV/9KHWbhuvdJx+RRp6+V0p4JaK3MTHh5A3KyWr/NjFn36h/rpjloc
 kKw6mWJGoIUtkF8OlO9fGROrMtcWV9gJ7yw4VQu0qR0b4MlYQXecsNmLRtyVpj5tNwzJuurvjeG
 dwfhTiASM2tlzllOawlCEYMs3modrThP4T3JjDZ/RLqIvt+WWIuevKilIj2RHl5kmCzOYQCioGb
 haW2PUZXinGnhTHnESt5cDB4fh4Dwnge2mME7xV3peBkRuJxckJkTCAnbeUCtEJEK45VdY3BWJ9
 qhbJzel0eOQ5NZ8e6AYXCrbdjGE3CYlDrpbO6khjVLANi459/a/Slt+6tmdg0JYmGcDAmdkRm16
 gJVcXFedLBXGcCu9NwtSOSbbDxtHelBnSdhrnUV9A7bweUGqZqBWkjc7FINRS5XWr6DlZPFsFY/
 jUry8x3ymSymRhg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new selftest to verify netconsole module loading with command
line arguments. This test exercises the init_netconsole() path and
validates proper parsing of the netconsole= parameter format.

The test:
- Loads netconsole module with cmdline configuration instead of
  dynamic reconfiguration
- Validates message transmission through the configured target
- Adds helper functions for cmdline string generation and module
  validation

This complements existing netconsole selftests by covering the
module initialization code path that processes boot-time parameters.
This test is useful to test issues like the one described in [1].

Link: https://lore.kernel.org/netdev/Z36TlACdNMwFD7wv@dev-ushankar.dev.purestorage.com/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/drivers/net/Makefile       |  1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 39 +++++++++++++---
 .../selftests/drivers/net/netcons_cmdline.sh       | 52 ++++++++++++++++++++++
 3 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index be780bcb73a3b..bd309b2d39095 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -12,6 +12,7 @@ TEST_GEN_FILES := \
 TEST_PROGS := \
 	napi_id.py \
 	netcons_basic.sh \
+	netcons_cmdline.sh \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
 	netcons_sysdata.sh \
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 598279139a6e5..3fcf85a345969 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -121,6 +121,17 @@ function create_dynamic_target() {
 	echo 1 > "${NETCONS_PATH}"/enabled
 }
 
+# Generate the command line argument for netconsole following:
+#  netconsole=[+][src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]
+function create_cmdline_str() {
+	DSTMAC=$(ip netns exec "${NAMESPACE}" \
+		 ip link show "${DSTIF}" | awk '/ether/ {print $2}')
+	SRCPORT="1514"
+	TGTPORT="6666"
+
+	echo "netconsole=\"+${SRCPORT}@${SRCIP}/${SRCIF},${TGTPORT}@${DSTIP}/${DSTMAC}\""
+}
+
 # Do not append the release to the header of the message
 function disable_release_append() {
 	echo 0 > "${NETCONS_PATH}"/enabled
@@ -173,13 +184,9 @@ function listen_port_and_save_to() {
 		socat UDP-LISTEN:"${PORT}",fork "${OUTPUT}"
 }
 
-function validate_result() {
+# Only validate that the message arrived properly
+function validate_msg() {
 	local TMPFILENAME="$1"
-	local FORMAT=${2:-"extended"}
-
-	# TMPFILENAME will contain something like:
-	# 6.11.1-0_fbk0_rc13_509_g30d75cea12f7,13,1822,115075213798,-;netconsole selftest: netcons_gtJHM
-	#  key=value
 
 	# Check if the file exists
 	if [ ! -f "$TMPFILENAME" ]; then
@@ -192,6 +199,17 @@ function validate_result() {
 		cat "${TMPFILENAME}" >&2
 		exit "${ksft_fail}"
 	fi
+}
+
+# Validate the message and userdata
+function validate_result() {
+	local TMPFILENAME="$1"
+
+	# TMPFILENAME will contain something like:
+	# 6.11.1-0_fbk0_rc13_509_g30d75cea12f7,13,1822,115075213798,-;netconsole selftest: netcons_gtJHM
+	#  key=value
+
+	validate_msg "${TMPFILENAME}"
 
 	# userdata is not supported on basic format target,
 	# thus, do not validate it.
@@ -267,3 +285,12 @@ function pkill_socat() {
 	pkill -f "${PROCESS_NAME}"
 	set -e
 }
+
+# Check if netconsole was compiled as a module, otherwise exit
+function check_netconsole_module() {
+	if modinfo netconsole | grep filename: | grep -q builtin
+	then
+		echo "SKIP: netconsole should be compiled as a module" >&2
+		exit "${ksft_skip}"
+	fi
+}
diff --git a/tools/testing/selftests/drivers/net/netcons_cmdline.sh b/tools/testing/selftests/drivers/net/netcons_cmdline.sh
new file mode 100755
index 0000000000000..ad2fb8b1c4632
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_cmdline.sh
@@ -0,0 +1,52 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This is a selftest to test cmdline arguments on netconsole.
+# It exercises loading of netconsole from cmdline instead of the dynamic
+# reconfiguration. This includes parsing the long netconsole= line and all the
+# flow through init_netconsole().
+#
+# Author: Breno Leitao <leitao@debian.org>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+check_netconsole_module
+
+modprobe netdevsim 2> /dev/null || true
+rmmod netconsole 2> /dev/null || true
+
+# The content of kmsg will be save to the following file
+OUTPUT_FILE="/tmp/${TARGET}"
+
+# Check for basic system dependency and exit if not found
+# check_for_dependencies
+# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+echo "6 5" > /proc/sys/kernel/printk
+# Remove the namespace and network interfaces
+trap do_cleanup EXIT
+# Create one namespace and two interfaces
+set_network
+# Create the command line for netconsole, with the configuration from the
+# function above
+CMDLINE="$(create_cmdline_str)"
+
+# Load the module, with the cmdline set
+modprobe netconsole "${CMDLINE}"
+
+# Listed for netconsole port inside the namespace and destination interface
+listen_port_and_save_to "${OUTPUT_FILE}" &
+# Wait for socat to start and listen to the port.
+wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
+# Send the message
+echo "${MSG}: ${TARGET}" > /dev/kmsg
+# Wait until socat saves the file to disk
+busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+# Make sure the message was received in the dst part
+# and exit
+validate_msg "${OUTPUT_FILE}"
+
+exit "${ksft_pass}"

-- 
2.47.1


