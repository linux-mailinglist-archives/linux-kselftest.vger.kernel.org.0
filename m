Return-Path: <linux-kselftest+bounces-25486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58B9A23DD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 13:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0653A91B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E561B87D0;
	Fri, 31 Jan 2025 12:39:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E138C4C7C;
	Fri, 31 Jan 2025 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738327195; cv=none; b=sh62HrbQXqj6GxLNORojtoKcwtC+Hrtl4tN2HIuBpIxk/H3AnBLmjZSS0PHqjon/pIVoK3zjub/5QNWl8YzsuqIueE+IuvFuCpSUlU5UXO7wpm64CoxizaSMt/hPuPG+vvg6eLiS0Nibto2pPCWJrnPIjsPRvJM86VfzXdg0EN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738327195; c=relaxed/simple;
	bh=WurhRTUteD8sGKFQNuEJYBz6ShWRfiWUQLthuX+tlXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NN91WNJlT4A9Jerr9vN+a2N/Sr0fwLHFCOMxpcJtE9RbcVb5DVl6VaQ0YUs57/leNty3bVZnL4G1PsYKZI16IR7MQEKmc94BD+prlLQSQ2X+0r8idXbKsiMW3CY/8aAxeFB6H6tTvT/F8i8gRk7gTAPrTzjxFE2gOvG19eFSERw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9e44654ae3so317049166b.1;
        Fri, 31 Jan 2025 04:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738327191; x=1738931991;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gG0BXuRRCC+KYWnxXLITESshYQ/auauU0ULNTK06oOg=;
        b=HqAARnd9Xz5GpVwejqgdrlNejI1yY7tHUCZMBYF1vZFxW9TNuaCgwvAMsMyQ3qPnFM
         +s44fAOGBReGK6pPfdtlS/4GP9kmp6ETRgLrcIbgzbNWGAQFaw6NoKxJqVc7m8i9GWl1
         K3iChCeC9FybYFSLGKjd8vd6kH99oLu1QD6Duv9eQ9DfpL0CL6qM5Ihbj02yWWPhbW+5
         FYC2zU2JRfUV0ONFSu5hE65NUICTvFe1ReeOMVSSAX7Mn4w876IXnAVVGfKlSpDi5irL
         JHF9QY5S/+3/r1RKEqOObkZOMSAXNiy7qz9Y0l+9ULiKP/Vrjo9lxplnhcemNgIF3wm8
         VTZg==
X-Forwarded-Encrypted: i=1; AJvYcCUO72bWCWLEEokO5dQtWKWUoXM73fDfAeHBPu7PkgDuSvO1ujmkzQYLiLXDj1Y+WpXKFVpbB9ol7q8LKlkEuQI=@vger.kernel.org, AJvYcCUbdH9AvhDVboGmW+T2oS5vCP38vNqNQQwZA/3F0ehaXraE1z29nANyoShJfPjheTxO/rk2FcjL@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNZgjNij+B+Pk+8eJLZy5xUiA/ZeKCeiySuRRluBRRXuUiGgJ
	Gqq1c29UPNySWG03Vb3JgFkjBN0Uqn3iJh8KbAXW1Tp3dru5aHsr
X-Gm-Gg: ASbGncvgTXqWlRc1LgYiOv+X4b+xBh7JvMJp49r5iq8dmOiHtvxphvvz7ocMc22l1+P
	0sRxNFNt1ng7LTHnvNOMeM8PiHxXLQDRoMhXycJVZO+afml+rLqNg09yUm4aAliDlfxfqN3/6KV
	4VpmGiEvHQvJDOLypabpj9rcgRA0mpClSb3e55VYy4Lqhc8uQx1vofW6cLCyQgSTpuT8shiTWWv
	cf2htjet8iOWjRgASvPwr0scs+wsqtzPHi37zvS85BBLGLhQm+jlW0ugzMC5bhSNWlibg+GkqFg
	gMBF/A==
X-Google-Smtp-Source: AGHT+IG+AMrHha429VFBPA+KD07+eUfMRNFPyA8voaBZVSFHnmadCc6/o3oi7PkP3uyOqgG3avYifQ==
X-Received: by 2002:a17:907:7f8d:b0:ab3:4b0c:ea44 with SMTP id a640c23a62f3a-ab6cfcb428emr1151623766b.9.1738327190726;
        Fri, 31 Jan 2025 04:39:50 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47cf48esm290881466b.50.2025.01.31.04.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 04:39:49 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 31 Jan 2025 04:39:38 -0800
Subject: [PATCH RFC net-next] netconsole: selftest: Add test for fragmented
 messages
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-netcons_frag_msgs-v1-1-0de83bf2a7e6@debian.org>
X-B4-Tracking: v=1; b=H4sIAInEnGcC/x3MQQqDMBAF0KuEvzaQpEQw20IP0K0UEZ2ks+hYM
 qEI4t1Lu32Ld0CpMimSOVDpw8qbIBnfGSzPWQpZXpEMggvR+TBYobZsolOuc5leWtQOPrp+9Zc
 +R4fO4F0p8/4/R9xv158JNSu0NzzO8wvE4Et0dAAAAA==
X-Change-ID: 20250129-netcons_frag_msgs-91506d136f50
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, horms@kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, matttbe@kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8109; i=leitao@debian.org;
 h=from:subject:message-id; bh=WurhRTUteD8sGKFQNuEJYBz6ShWRfiWUQLthuX+tlXM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnnMSU5QPHRRYwPvL1ncIl6viFFx9/IlMzmDYBc
 gWizlVqBSSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ5zElAAKCRA1o5Of/Hh3
 bUxnD/41AScj9X3utthKYI34D4s14u6KecKm3tbIXFlWPn/fs+mbN3do9BktHbg8thqM6uRHdF2
 pX1aoJradKqfqxlUkOhL0bqOLvLnTi9FxXhqvFlAeN4EhbWWrTFbqW+rvNJFP/z5N4vv00e6kWy
 vH9VwgPZ12cAiihB7+jiKv0poDDD2GxPdSSlAfWz3SfVXP2LiVmUqjIruY95CjEQ7RfxfX4sbfc
 YhNnpDxaoDr9Rw1gf4/hgeE8TgLWuQYLyqtgEL2XiMwB8yCsvw7gnxpCvcxi+naCXqf9mxtCAwr
 kM99MhOnbd9pNHE8cekIH4RjEvcvf2+0D9eXxfPJ25g1lFTPDmmAbpomKob5IURxpHL7dK9apRN
 Qnlm5DpEmMuByprbW2maFXy71KnTvanv14yTlxUJnc6Mk4I8pltXQkXMm3tmG0uWPKy3LjoHPui
 WjXCBcbKbxvPCOxtzWzoPVnj+/VBbjqalmTs8X0YGzom/Hedp7bfmVjNB1pn4Ie5b4KgANURdAk
 NpQ96e2y+q1gZyP6c2vfSSsuRJUsy0KZ/DrM2+U9VBfd1tXMaattmf6vV3ziH9hWKsv2PMxgxed
 SmtlIWcqGu89I47juFGQhbjTgnSHeSXWdD029QubgMoZ1zGCRLMqPMIfZbByTYoPDTLGhLmidWz
 5RzLxlEU+oJuOow==
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
index 0000000000000000000000000000000000000000..d175d5b9db662ab9a6ee203794569cc620801a4f
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
+#   13,468,514729715,-,ncfrag=0/1135;MSG1=MSG2=MSG3=MSG4=MSG5=MSG6=MSG7=MSG8=MSG9=MSG10=MSG11=MSG12=MSG13=MSG14=MSG15=MSG16=MSG17=MSG18=MSG19=MSG20=MSG21=MSG22=MSG23=MSG24=MSG25=MSG26=MSG27=MSG28=MSG29=MSG30=MSG31=MSG32=MSG33=MSG34=MSG35=MSG36=MSG37=MSG38=MSG39=MSG40=MSG41=MSG42=MSG43=MSG44=MSG45=MSG46=MSG47=MSG48=MSG49=MSG50=MSG51=MSG52=MSG53=MSG54=MSG55=MSG56=MSG57=MSG58=MSG59=MSG60=MSG61=MSG62=MSG63=MSG64=MSG65=MSG66=MSG67=MSG68=MSG69=MSG70=MSG71=MSG72=MSG73=MSG74=MSG75=MSG76=MSG77=MSG78=MSG79=MSG80=MSG81=MSG82=MSG83=MSG84=MSG85=MSG86=MSG87=MSG88=MSG89=MSG90=MSG91=MSG92=MSG93=MSG94=MSG95=MSG96=MSG97=MSG98=MSG99=MSG100=MSG101=MSG102=MSG103=MSG104=MSG105=MSG106=MSG107=MSG108=MSG109=MSG110=MSG111=MSG112=MSG113=MSG114=MSG115=MSG116=MSG117=MSG118=MSG119=MSG120=MSG121=MSG122=MSG123=MSG124=MSG125=MSG126=MSG127=MSG128=MSG129=MSG130=MSG131=MSG132=MSG133=MSG134=MSG135=MSG136=MSG137=MSG138=MSG139=MSG140=MSG141=MSG142=MSG143=MSG144=MSG145=MSG146=MSG147=MSG148=MSG149=MSG150=: netcons_nzmJQ
+#    key=1-2-13,468,514729715,-,ncfrag=967/1135;3-4-5-6-7-8-9-10-11-12-13-14-15-16-17-18-19-20-21-22-23-24-25-26-27-28-29-30-31-32-33-34-35-36-37-38-39-40-41-42-43-44-45-46-47-48-49-50-51-52-53-54-55-56-57-58-59-60-
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


