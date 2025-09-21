Return-Path: <linux-kselftest+bounces-42041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB9CB8E7D8
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 23:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18BF47A66EC
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 21:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2332DC798;
	Sun, 21 Sep 2025 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0zEYnZW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633582DAFC8
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491789; cv=none; b=X8A/fDieeQJuidv9DcLOebyr2eqS/zI+Am5HLKrLA4qcpt33GuEwOA+UPNUcVKsZ8DdrXT5ZAhp5gd5Gr96FUytD1gWYkJ8fSXrdT8eGpnzkQ0Hx5FhChZPbNx2UXJT9JlLoVm99IoydK04hOOyzpTyN6efW1w1vJuq58SC2Hrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491789; c=relaxed/simple;
	bh=R3yengxGAdZ6SfJjU1VD10z3t2Uj/t+EUXjBtn9XPhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SWiOmb96oSU8r9VfaXv3tktivHXSfpzrRm8XqWFLs9DIgRfuqDbhzIDESgd7H/55W/sRjEYQQn1Bow+cDoY9DtX/CCj6cMXF1ir17+OEGRmktkPg7XdpKso/YqElOC504Mm2WVtPqGXcUnA+N/gCkJeAI2cxfa70NY9TstKq1lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0zEYnZW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee1317b1f7so1830988f8f.2
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 14:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758491786; x=1759096586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzkTk9ZGVrUO/YmVyv5ISDrea/09V1eF2f8GeR25nUE=;
        b=b0zEYnZWKWRkQOO0VYuUu0sfFnADqfeuXWFwzMLtTQZem6AChdmJoivcMwnlFUqmS4
         ekz1ituRA96vRKJfNv0TfWoBx06LQkyupoppEBn4kFdi5mS67sqi9urqSDnDVAqpAsCQ
         qpJLYK853Gt9RJAvKAdCe1tHvRlOt6T2mVcCntCyREwPq68XeTcWVH4z7f44HxpUPrWw
         7KHnsPYH5BoPi28Lj393LLXv8mZGn9GmzGJEYA0vtwETGwdLMDoXsNTBMWbFnyTVMnVy
         Yrxg5r47Y5CxUgQxiwlpJR1FS2KUfwpW3QeplsKR+bYsn5U68cgejrKA58Fc+SjqCW53
         N4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758491786; x=1759096586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzkTk9ZGVrUO/YmVyv5ISDrea/09V1eF2f8GeR25nUE=;
        b=ogFbe5/Rfylv33SStQVkfX7VAjEAFB4EkhGEZjl1EpVWfgL18+XQExb+8w4zXODd3e
         pZVlVebjZI21NY3/RsL5Zi4yVAH83iM8UhvYH2p1LlQ3r3Eh9MW+eQm1usZzdzwjkJ7V
         bFB9BWiaHxPkIxt6mTd5achndQSe4cK+3VPGjRrWdmykkBjPLLyLq+ceW40HpqR2+vtF
         7Z2fFk5lSfrhviepHNldHA1aBvApXV/698GCdxgzCJKeMKf5fErOB6hb9VeZNG3PSXiq
         xLpLMBHSdJxUgzU90iTCHil7gbHqaSx9Ljv0Yz3TC5VUievOyLDko2OAAQEZW90t4yGZ
         Crsg==
X-Forwarded-Encrypted: i=1; AJvYcCUBGJdT4MMdOp6G2qDFpyBkhLGkSkpbwJ4bFHh/MscqYasAVNWwOlFh0dmxeuw5NOzDRn9+nNr7oaachDNFQF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW/RB6uZCr/153LicJVJGM5RukSKCsRwMCFtuUOTX57d6pWEAQ
	8MM6h3T3cNQWc9G+OVbAiT6ctgPQDKARq4yJ4v7lZY4fG6XT7VPcyZ6B
X-Gm-Gg: ASbGncuK70C+frYqEQWQehRpreWhVxQqTJ07nNi8eEWpEWHteBV5qDIWAb0gDmIgKBg
	qLqzhooKk9ERppfFeb4DculLHmL3QJjBrbC1pg/oW/2AQgxdf/uqrK4nLDQhX4EOA103fS13ARm
	K49mwIhI9ge2BOVtnVyCFMbAW1q2/SQqOac+A8P8G4TEB9WVhkAMnGEWkuL95snsI+BCLbc8DZM
	+JvQLAvoW9/8uUkw07l7zNwRWGZWcQ5GeC63SkqKthUaEacATzCANdRYijeCIOMTD8Gp8PPvJVw
	IK/YUiaO8suHOih0oBfYcciYzGRFVBui0Hvo6PW6AmrP4flDbxsBIqstg3pa8gAsN8voFvBdc6i
	fzrdYfWAPxSxI7NlbIwUKFzshsIY=
X-Google-Smtp-Source: AGHT+IHEVkHeQQ75LjAl5tNj6JF2glhGPryv/AOyhtjgb89bmwUVUWqWMyYTbYI571pla3OfRIwgCA==
X-Received: by 2002:a05:6000:18a9:b0:3e9:ee54:af54 with SMTP id ffacd0b85a97d-3ee7d0c8beamr8120070f8f.21.1758491785512;
        Sun, 21 Sep 2025 14:56:25 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm5873427f8f.57.2025.09.21.14.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:56:24 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 21 Sep 2025 22:55:46 +0100
Subject: [PATCH net-next v2 6/6] selftests: netconsole: validate target
 reactivation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-netcons-retrigger-v2-6-a0e84006237f@gmail.com>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
In-Reply-To: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758491774; l=6229;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=R3yengxGAdZ6SfJjU1VD10z3t2Uj/t+EUXjBtn9XPhs=;
 b=al6+LfV3Wlpo5KSptSKWJZhAtKi1BpcVuCY06ZSn8isevIQwvKwFczYQb13AWK+IPIlFZMmtW
 /heGcq1URIjCxvgBtq+/Cf/fPihGb4Kl5yZ4g5f43E4vg3oN+57AMMt
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Introduce a new netconsole selftest to validate that netconsole is able
to resume a deactivated target when the low level interface comes back.

The test setups the network using netdevsim, creates a netconsole target
and then remove/add netdevsim in order to bring the same interfaces
back. Afterwards, the test validates that the target works as expected.

Targets are created via cmdline parameters to the module to ensure that
resuming works for targets bound by interface name and mac address.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 tools/testing/selftests/drivers/net/Makefile       |  1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 30 ++++++-
 .../selftests/drivers/net/netcons_resume.sh        | 92 ++++++++++++++++++++++
 3 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 984ece05f7f92e836592107ba4c692da6d8ce1b3..a40b50c66d530b3fcbeaf93ca46f79380b3a1949 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -16,6 +16,7 @@ TEST_PROGS := \
 	netcons_cmdline.sh \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
+	netcons_resume.sh \
 	netcons_sysdata.sh \
 	netpoll_basic.py \
 	ping.py \
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 8e1085e896472d5c87ec8b236240878a5b2d00d2..88b4bdfa84cf4ab67ff0e04c3ed88e5ae9df49d2 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -186,12 +186,13 @@ function do_cleanup() {
 }
 
 function cleanup() {
+	local TARGETPATH=${1:-${NETCONS_PATH}}
 	# delete netconsole dynamic reconfiguration
-	echo 0 > "${NETCONS_PATH}"/enabled
+	echo 0 > "${TARGETPATH}"/enabled
 	# Remove all the keys that got created during the selftest
-	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
+	find "${TARGETPATH}/userdata/" -mindepth 1 -type d -delete
 	# Remove the configfs entry
-	rmdir "${NETCONS_PATH}"
+	rmdir "${TARGETPATH}"
 
 	do_cleanup
 }
@@ -350,6 +351,29 @@ function check_netconsole_module() {
 	fi
 }
 
+function wait_target_state() {
+	local TARGET=${1}
+	local STATE=${2}
+	local FILE="${NETCONS_CONFIGFS}"/"${TARGET}"/"enabled"
+
+	if [ "${STATE}" == "enabled" ]
+	then
+		ENABLED=1
+	else
+		ENABLED=0
+	fi
+
+	if [ ! -f "$FILE" ]; then
+		echo "FAIL: Target does not exist." >&2
+		exit "${ksft_fail}"
+	fi
+
+	slowwait 2 sh -c "test -n \"\$(grep \"${ENABLED}\" \"${FILE}\")\"" || {
+		echo "FAIL: ${TARGET} is not ${STATE}." >&2
+		exit "${ksft_fail}"
+	}
+}
+
 # A wrapper to translate protocol version to udp version
 function wait_for_port() {
 	local NAMESPACE=${1}
diff --git a/tools/testing/selftests/drivers/net/netcons_resume.sh b/tools/testing/selftests/drivers/net/netcons_resume.sh
new file mode 100755
index 0000000000000000000000000000000000000000..404df7abef1bcdbd29a128c304ac9b39f19fc82d
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
@@ -0,0 +1,92 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test validates that netconsole is able to resume a target that was
+# deactivated when its interface was removed when the interface is brought
+# back up.
+#
+# The test configures a netconsole target and then removes netdevsim module to
+# cause the interface to disappear. Targets are configured via cmdline to ensure
+# targets bound by interface name and mac address can be resumed.
+# The test verifies that the target moved to disabled state before adding
+# netdevsim and the interface back.
+#
+# Finally, the test verifies that the target is re-enabled automatically and
+# the message is received on the destination interface.
+#
+# Author: Andre Carvalho <asantostc@gmail.com>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+modprobe netdevsim 2> /dev/null || true
+rmmod netconsole 2> /dev/null || true
+
+check_netconsole_module
+
+# Run the test twice, with different cmdline parameters
+for BINDMODE in "ifname" "mac"
+do
+	echo "Running with bind mode: ${BINDMODE}" >&2
+	# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+	echo "6 5" > /proc/sys/kernel/printk
+
+	# Create one namespace and two interfaces
+	set_network
+	trap do_cleanup EXIT
+
+	# Create the command line for netconsole, with the configuration from
+	# the function above
+	CMDLINE=$(create_cmdline_str "${BINDMODE}")
+
+	# The content of kmsg will be save to the following file
+	OUTPUT_FILE="/tmp/${TARGET}-${BINDMODE}"
+
+	# Load the module, with the cmdline set
+	modprobe netconsole "${CMDLINE}"
+	# Expose cmdline target in configfs
+	mkdir ${NETCONS_CONFIGFS}"/cmdline0"
+	trap 'cleanup "${NETCONS_CONFIGFS}"/cmdline0' EXIT
+
+	# Target should be enabled
+	wait_target_state "cmdline0" "enabled"
+
+	# Remove low level module
+	rmmod netdevsim
+	# Target should be disabled
+	wait_target_state "cmdline0" "disabled"
+
+	# Add back low level module
+	modprobe netdevsim
+	# Recreate namespace and two interfaces
+	set_network
+	# Target should be enabled again
+	wait_target_state "cmdline0" "enabled"
+
+	# Listen for netconsole port inside the namespace and destination
+	# interface
+	listen_port_and_save_to "${OUTPUT_FILE}" &
+	# Wait for socat to start and listen to the port.
+	wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
+	# Send the message
+	echo "${MSG}: ${TARGET}" > /dev/kmsg
+	# Wait until socat saves the file to disk
+	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+	# Make sure the message was received in the dst part
+	# and exit
+	validate_msg "${OUTPUT_FILE}"
+
+	# kill socat in case it is still running
+	pkill_socat
+	# Cleanup & unload the module
+	cleanup "${NETCONS_CONFIGFS}/cmdline0"
+	rmmod netconsole
+	trap - EXIT
+
+	echo "${BINDMODE} : Test passed" >&2
+done
+
+exit "${ksft_pass}"

-- 
2.51.0


