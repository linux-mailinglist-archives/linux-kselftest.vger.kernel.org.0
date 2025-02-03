Return-Path: <linux-kselftest+bounces-25597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E54A26347
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 20:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468201883271
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 19:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF22D1D61A2;
	Mon,  3 Feb 2025 19:04:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9C31552FA;
	Mon,  3 Feb 2025 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609469; cv=none; b=Y+D+01OFFFHIkLAE6+WjeaFTZq4GLdbEvJ0uRbjmUziF5F5BiDSbBsg63tGVsAtf09vAtL0LARyPg+/PISTcJsmuowGQdU86/p6+0Q1AllwNIvAR2tAN59bJ+r11Fc2h0hzKSNxux3b+jvTJXHpI8l43wK6TlghxiWqt9lP3dQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609469; c=relaxed/simple;
	bh=9TyOHTPopbhR1FIEPISRYJ1tSPB5Xv7M18R5IBwc6BU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rXmQGTEAudsC5TxfYI66DKPnczbNs5PJYlGG1Rizu8wCmhOAMAcTYhOu96yTAR9tYTlSYydW7inTOV6NvI+IlmB8eiiweLZCK2TUDNwpgGqLI0eYho2bGClf9wowoVGJMV1I54AZpfaY+hinulIQxqw+KJZ4j6Ao9TaJJhG+018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so6385512a12.1;
        Mon, 03 Feb 2025 11:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738609466; x=1739214266;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdgTVEkL21P1dCV/QSRL4KH/N5z3s6ompZ19YyT1RLk=;
        b=NGMcE/n0P5Lp4AhQYC5vz4JCWTVlGZukdoBTC6kfME2gAElRwoI/OLxLJD29tfJ7GM
         fAYwtP9k8eySR46vtCJUXPXaqlsfkb42y2KiM1zoLEKohQQVmuCY31c50Kl+mJkPUo6u
         6wDFS9tAB7f485FUidxghiF6tEX8yCKilI/toOKTaJCwhlKNmNp6ZhvhxSHYOOlpnB9M
         /52zz/c+nu6Pc2iXT0F7ZfA/9TmU59Fli9ext7lHXlK5ZBxPqQUKE/O7Yog4et4wvnec
         eKLp4SNktHnDUKNwyjrnYMMkuOeNh9viuvBXlW8EoI+Wkl3bAtOyiG2sICQSCO4As4GV
         Re9A==
X-Forwarded-Encrypted: i=1; AJvYcCVS1mQadk6sb4/G5E92V0qsESl6mK+1IkG3AOJZ2bfxH8g4ea5VpkQ2HH8bAGYAIkSOvKSYGXiR@vger.kernel.org, AJvYcCWRHatv0uXESYg+Di8RxXdGP/hR4MxWraIRKET6HxNrLwHsBXtp8OHGNHSB3KGiC9jNdaKfFpszKCKpCMTGkNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpY6dk8O48Rn7IUaXE6+kSJzq3s4pxKJ/PKLe+qNlnjDQt+B1B
	aXjBMdMboffpaRwwpfkjfih78PMYjEWf9xWYXl1JlhUy7TIcnMPukcDb/Q==
X-Gm-Gg: ASbGnctSdRpFrvNejmtK3ttdyXv1SHuKYIx/y2y53AyyDjSB/eguZrnmALBu5FhcOyK
	1yol1v4wAuZnmf+99hqbr2S01vlGfJ0QFSLNz4DJgWuvkBw3rrl0ZopAhRwox33g+oMjnVSX5+1
	AsRd4z2Rk4+F4F9kH0ygo1TfCDwhlZnL87KOnvLSvII09DuVSIh4GvUG97OnMr1dM8s279oQz/L
	4MMGcmaVrmz+ZjGsEObGga9CgowrwK+UgkVkvUm5uUE/j29I3l7oZk2sdwzlRkc+7gMEXmXOiZC
	r4DEWXc=
X-Google-Smtp-Source: AGHT+IFZulild2aMgwYbtTFLSHZH1Je+SAKGjcc3nWSrgzwbd2d6jpKjBtj1VK9Gs9Dn/XpWW/Qhlw==
X-Received: by 2002:a05:6402:268d:b0:5dc:740b:3cdb with SMTP id 4fb4d7f45d1cf-5dc740b3efcmr49850124a12.29.1738609465518;
        Mon, 03 Feb 2025 11:04:25 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e49ffd42sm811083366b.95.2025.02.03.11.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 11:04:24 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 03 Feb 2025 11:04:15 -0800
Subject: [PATCH net-next] netconsole: selftest: Add test for fragmented
 messages
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-netcons_frag_msgs-v1-1-5bc6bedf2ac0@debian.org>
X-B4-Tracking: v=1; b=H4sIAC4ToWcC/23NQQqDMBBA0auEWZuSiWirq96jiEQziVk0kUwQi
 3j3gt12/eH9A5hyIIZeHJBpCxxShF5gJWBeTPQkg4VegFa6Uag7GanMKfLosvHjmz3LDhvVWqx
 b1yioBKyZXNgv8wWRioy0FxgqAUvgkvLnmm149Z9b4x93Q4lSWXrUk9PmTu3T0hRMvKXsYTjP8
 wuKb6UZvQAAAA==
X-Change-ID: 20250129-netcons_frag_msgs-91506d136f50
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7266; i=leitao@debian.org;
 h=from:subject:message-id; bh=9TyOHTPopbhR1FIEPISRYJ1tSPB5Xv7M18R5IBwc6BU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnoRM3WoR2TosEPCO4m+X4Tg+goahbiqLrgVpGb
 MiVkpG1vDWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6ETNwAKCRA1o5Of/Hh3
 bULbD/9BZ40u+Nq4zcxUuQsn2cDL12XRqTO0pvn+AtQOwsjOf8mHBMHdjq1GILm5y4DKgs8iTkH
 msv91salNU9A2u25yQSvdnHXQbtULFbcl9oY/Qw6j8NNfgQ57vJMT8uVeJJ5uLEMEvQZRqoPFBf
 oKbNaukdOK54BmlzZ4myVJ4ayxKKjyQImlYZe8a5Mv4r6c8yKlZdB9P565For+9gKy73Qa3b1Iz
 caJjav6rOYYVlTAYUx87Tw2eUlJcYr5vcmPhnby1vIbk0y+Ax0M8u4CZmuPEGgCSzOBfAn9ukL0
 HGt+Le1Yn3RiY9IUPu7ppTBPW1dUFXctsOkYrqhb36f3DhwQGf45B5Hq6PCJ9sT8FPPOMNuFtf1
 pU1tgRbieiFBTs/4ubflu1SYqgiQuqbJegk/ArWNvasAK/0MzbHWbP5Qr0zZkRpyc6QrXQDThMZ
 ktz/eYFNprKi7X9plXmzrieQSYPluAENaH3pgz/laWiOwyZ8rGUqw0LKMJpYVWYrieJdo1KT/jZ
 coUaUhf698phfUvwyepU8/CBdM+XsmMn/BAS9WC9WFcan9DIsHthpGVpvXK9jCjoA8ZPjO47Xj3
 oBM6BVzNWIcZr/louoV7hUujvnVALw0FEzq6yTFr6ChEC5Hn3T1VI3MfdSrghEWyqJDf97m9+Y4
 NRD44SwPp+hHJ7w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new selftest to verify netconsole's handling of messages that
exceed the packet size limit and require fragmentation. The test sends
messages with varying sizes and userdata, validating that:

1. Large messages are correctly fragmented and reassembled
2. Userdata fields are properly preserved across fragments
3. Messages work correctly with and without kernel release version
   appending

The test creates a networking environment using netdevsim, sends
messages through /dev/kmsg, and verifies the received fragments maintain
message integrity.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changes compared to RFC
- Removed the long-line comment (Simon)
- Added Simon's reviwed-by tag.
- Link to v1: https://lore.kernel.org/r/20250131-netcons_frag_msgs-v1-1-0de83bf2a7e6@debian.org
---
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |   7 ++
 .../drivers/net/netcons_fragmented_msg.sh          | 122 +++++++++++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 137470bdee0c7fd2517bd1baafc12d575de4b4ac..c7f1c443f2af091aa13f67dd1df9ae05d7a43f40 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -7,6 +7,7 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 
 TEST_PROGS := \
 	netcons_basic.sh \
+	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
 	ping.py \
 	queues.py \
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 3acaba41ac7b21aa2fd8457ed640a5ac8a41bc12..0c262b123fdd3082c40b2bd899ec626d223226ed 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -110,6 +110,13 @@ function create_dynamic_target() {
 	echo 1 > "${NETCONS_PATH}"/enabled
 }
 
+# Do not append the release to the header of the message
+function disable_release_append() {
+	echo 0 > "${NETCONS_PATH}"/enabled
+	echo 0 > "${NETCONS_PATH}"/release
+	echo 1 > "${NETCONS_PATH}"/enabled
+}
+
 function cleanup() {
 	local NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
 
diff --git a/tools/testing/selftests/drivers/net/netcons_fragmented_msg.sh b/tools/testing/selftests/drivers/net/netcons_fragmented_msg.sh
new file mode 100755
index 0000000000000000000000000000000000000000..4a71e01a230c75c14147a9937920fe0b68a0926a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_fragmented_msg.sh
@@ -0,0 +1,122 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Test netconsole's message fragmentation functionality.
+#
+# When a message exceeds the maximum packet size, netconsole splits it into
+# multiple fragments for transmission. This test verifies:
+#  - Correct fragmentation of large messages
+#  - Proper reassembly of fragments at the receiver
+#  - Preservation of userdata across fragments
+#  - Behavior with and without kernel release version appending
+#
+# Author: Breno Leitao <leitao@debian.org>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+modprobe netdevsim 2> /dev/null || true
+modprobe netconsole 2> /dev/null || true
+
+# The content of kmsg will be save to the following file
+OUTPUT_FILE="/tmp/${TARGET}"
+
+# set userdata to a long value. In this case, it is "1-2-3-4...50-"
+USERDATA_VALUE=$(printf -- '%.2s-' {1..60})
+
+# Convert the header string in a regexp, so, we can remove
+# the second header as well.
+# A header looks like "13,468,514729715,-,ncfrag=0/1135;". If
+# release is appended, you might find something like:L
+# "6.13.0-04048-g4f561a87745a,13,468,514729715,-,ncfrag=0/1135;"
+function header_to_regex() {
+	# header is everything before ;
+	local HEADER="${1}"
+	REGEX=$(echo "${HEADER}" | cut -d'=' -f1)
+	echo "${REGEX}=[0-9]*\/[0-9]*;"
+}
+
+# We have two headers in the message. Remove both to get the full message,
+# and extract the full message.
+function extract_msg() {
+	local MSGFILE="${1}"
+	# Extract the header, which is the very first thing that arrives in the
+	# first list.
+	HEADER=$(sed -n '1p' "${MSGFILE}" | cut -d';' -f1)
+	HEADER_REGEX=$(header_to_regex "${HEADER}")
+
+	# Remove the two headers from the received message
+	# This will return the message without any header, similarly to what
+	# was sent.
+	sed "s/""${HEADER_REGEX}""//g" "${MSGFILE}"
+}
+
+# Validate the message, which has two messages glued together.
+# unwrap them to make sure all the characters were transmitted.
+# File will look like the following:
+#  13,468,514729715,-,ncfrag=0/1135;<message>
+#   key=<part of key>-13,468,514729715,-,ncfrag=967/1135;<rest of the key>
+function validate_fragmented_result() {
+	# Discard the netconsole headers, and assemble the full message
+	RCVMSG=$(extract_msg "${1}")
+
+	# check for the main message
+	if ! echo "${RCVMSG}" | grep -q "${MSG}"; then
+		echo "Message body doesn't match." >&2
+		echo "msg received=" "${RCVMSG}" >&2
+		exit "${ksft_fail}"
+	fi
+
+	# check userdata
+	if ! echo "${RCVMSG}" | grep -q "${USERDATA_VALUE}"; then
+		echo "message userdata doesn't match" >&2
+		echo "msg received=" "${RCVMSG}" >&2
+		exit "${ksft_fail}"
+	fi
+	# test passed. hooray
+}
+
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+echo "6 5" > /proc/sys/kernel/printk
+# Remove the namespace, interfaces and netconsole target on exit
+trap cleanup EXIT
+# Create one namespace and two interfaces
+set_network
+# Create a dynamic target for netconsole
+create_dynamic_target
+# Set userdata "key" with the "value" value
+set_user_data
+
+
+# TEST 1: Send message and userdata. They will fragment
+# =======
+MSG=$(printf -- 'MSG%.3s=' {1..150})
+
+# Listen for netconsole port inside the namespace and destination interface
+listen_port_and_save_to "${OUTPUT_FILE}" &
+# Wait for socat to start and listen to the port.
+wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
+# Send the message
+echo "${MSG}: ${TARGET}" > /dev/kmsg
+# Wait until socat saves the file to disk
+busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+# Check if the message was not corrupted
+validate_fragmented_result "${OUTPUT_FILE}"
+
+# TEST 2: Test with smaller message, and without release appended
+# =======
+MSG=$(printf -- 'FOOBAR%.3s=' {1..100})
+# Let's disable release and test again.
+disable_release_append
+
+listen_port_and_save_to "${OUTPUT_FILE}" &
+wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
+echo "${MSG}: ${TARGET}" > /dev/kmsg
+busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+validate_fragmented_result "${OUTPUT_FILE}"
+exit "${ksft_pass}"

---
base-commit: 0ad9617c78acbc71373fb341a6f75d4012b01d69
change-id: 20250129-netcons_frag_msgs-91506d136f50

Best regards,
-- 
Breno Leitao <leitao@debian.org>


