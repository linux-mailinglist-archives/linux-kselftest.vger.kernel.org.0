Return-Path: <linux-kselftest+bounces-38803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D16FEB23923
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 21:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EA03B2B5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 19:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EDF2FE586;
	Tue, 12 Aug 2025 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm+JyeNK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A43FE7;
	Tue, 12 Aug 2025 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755027519; cv=none; b=urZbRqCM51zE/W0cT0Fz9moyqDdv2JTVtdtUhbYcn3SQVYOezGhYey5qdiHuFiu9gCsbMmIR0jHviVCILdV7jI22TsBDqw4wWwX3y5ABvz/0XcGu5qPfgNuYNRXjFBOWMyqle6S4YEk1HSt3+Ng6bgP/wQgfh2dZpjMEmkuBSBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755027519; c=relaxed/simple;
	bh=k0bcjssrJUD/KpgVbW06mRiBvNKVIgvAUj3fNEd199Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ecO+hXIGyJ54N1FfXkpEEKMypZk4DXYy3I1Ddf+9hsb4/40FG1IyB4y8tQpHIRat7AcfRRlUfdU6/xg/Mf2geCHBecgyCIT42ul10pAYBaHcwb7TGrIAfXmk78ULNcupEaesLoI+1yRbmYC0QruSfusLzeO+koR0+OFnqxwjG5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dm+JyeNK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so29882945e9.2;
        Tue, 12 Aug 2025 12:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755027516; x=1755632316; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aRjJ2YZSkmssRTylvZmzxN9jsmpLOOeNPx4zXyP1f1o=;
        b=dm+JyeNKSjdr7i6ZiqHF2dPe+RL/lmz0DvqxbH2xLjxN/KyBczLufX92aeng53/+hz
         btyGbnyW492LhgICUm1A2tkzkyRXDE6u3IhNMbw6k0OWXKngF2mxGXhUAv/I/X1jIBS0
         2Rk/8jWjceHHQk4WesvJ1WEXp6roXe8YLlA4J+fhwjCliYN11t5VWNLGr0NGll12tDHA
         uw39k9BBgK0bS7FMyT8n4Q2DrqusBvCVPEPLCHZ0OruqjB7aIpG3lTiJg0znTF4m2a8P
         cDwxb5iIqadXXLOP0DUhHS52E1gqBpbHgojsZSxeSGotCm5ZVTDlNSJtH1kk0A/jdKUb
         q2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755027516; x=1755632316;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRjJ2YZSkmssRTylvZmzxN9jsmpLOOeNPx4zXyP1f1o=;
        b=APkUd1UBFUJREFe8yYkbFDg0XFR6KZ+q7fMLe+eBt5vt4+8dS2JWD4DzH30tTA+J6u
         K5jYaSpGGOu6DFmVMW7TnHeSqaFxqeUNtdZ+tePPQqouVLg8fQ5S8HVMZXYzmvr/eK7Z
         og+otuOVvYdW9gGpPXpHY4eIJint6xktK93H5OFmhVys1+DKNmdYlzaeXCHeWIxt6X2a
         4YjINF2KWdEi7zeNf7GbevJtJeXwWqkzou/RZCtNRVj5Lj+BtKKhDs5ePBEgyJyhzY9Q
         gPzYmt3KIAxEmY/UwykOV411ARqymnbYY0OyO06TSDjV+phTUCbe2vJZ6tU1l9RK8t65
         ZlNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1+pkU7Bb3JLMg5VybXxhGk4EG4bcxhEUgllInVpX7Sa/a6IAdzMCV9+URPWlwyNxL4CELoyjOIf7DW78=@vger.kernel.org, AJvYcCXgykpkyQxiXsxSQrQK+zgtmaUjcTCysjemA6IM9ledU31WWhd78MYXlO1b2SP6GW/NLlKJolIrH26QmCRtWoGC@vger.kernel.org
X-Gm-Message-State: AOJu0YyBXP1X07d/rhq+1tt3G6fdyT9xHA1tpHrH7MWiCbURZAE/ZyQe
	6LAYi00wktKR1lIc7oXhL2J8vFk4bARviw/5azhOH5XS0S6Rhxo2t5OK
X-Gm-Gg: ASbGnctpz+ypr7T4Iopn+W1smdTW97bPMXt4kr0cyqSEuiYWflUTmFeKiZI6CD2vxRp
	T1m/4hY768qUfV+4Hhe8oUZOLZ6fa8Pbpbqzpa9o3nM/zEMq0kDPJ6s/O1u3Nz6EGfW9rP756Yg
	iM+xl2FEM78TnFzg2xgtLBjLIfzM1UD3Q2RKR0GpUQ5qDGalZw2sMlEvlj37R7yMrt9C7uucJwV
	ipnCh5qjiWZGqphAAMZEwZt0BreoVqGFihnVIk1/ElYPPlL2uSkSZI+DnOyeY40Q98TvccH+MR6
	lsU3P9+RQ9GIwL8xyExuw8xbtlUgGCFN4Yuwcwp++nSLrLzlVb69jJDkKMwjsyTEWsfwD1Q1iQi
	4rfRwSLyMIStFFV+Jm5+zd8Ty2Fy/eHCYjkEj
X-Google-Smtp-Source: AGHT+IEHq18jRo1NL097VskWhWmn+36nKMQHAFIlsAu9cmHnsNETDByYaq7CUpo72HYUl/5qcEKCrQ==
X-Received: by 2002:a05:600c:8b22:b0:459:aa0a:db2d with SMTP id 5b1f17b1804b1-45a165f896emr2247985e9.28.1755027515647;
        Tue, 12 Aug 2025 12:38:35 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dc900606sm373579395e9.15.2025.08.12.12.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 12:38:35 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Tue, 12 Aug 2025 20:38:23 +0100
Subject: [PATCH net-next v2] selftests: netconsole: Validate interface
 selection by MAC address
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-netcons-cmdline-selftest-v2-1-8099fb7afa9e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAC6Ym2gC/3WNwQqDMBBEf0X23JQkrbX01P8oHmLc6IImJRvEI
 v57F3sucxqG92YDxkzI8Kg2yLgQU4pS7KkCP7o4oKJeOlhta33XjYpYfIqs/NxPFFExTqEgF9V
 dLNrGXbve3EDwd8ZA66F+gVBCrgVaWUbikvLn+FzMsf/0xvzXL0ZJQmNr12mrg3sOs6Pp7NMM7
 b7vXwFI+wbKAAAA
X-Change-ID: 20250807-netcons-cmdline-selftest-b32e27a4bd16
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755027515; l=4959;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=k0bcjssrJUD/KpgVbW06mRiBvNKVIgvAUj3fNEd199Q=;
 b=pgbd3qOQd5BDA5FfaDqIysrfZxaKvjm2QzOT8kaNIgKcbDb73bdYIt6slbmfn3GTneCjofxYp
 jDc/agZMbNOD6VB4sDSIyNTTtz++QzNGK/bmpYzL5dFgPLW8B96auwm
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Extend the existing netconsole cmdline selftest to also validate that
interface selection can be performed via MAC address.

The test now validates that netconsole works with both interface name
and MAC address, improving test coverage.

Suggested-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
Changes in v2:
- Redirect log line to stderr
- Do not ignore error unloading the module between test cases
- Remove nested quotes when building cmdline for module
- Format comments to avoid exceeding 80 columns
- Link to v1: https://lore.kernel.org/r/20250811-netcons-cmdline-selftest-v1-1-1f725ab020fa@gmail.com
---
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 10 +++-
 .../selftests/drivers/net/netcons_cmdline.sh       | 55 +++++++++++++---------
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index b6071e80ebbb6a33283ab6cd6bcb7b925aefdb43..8e1085e896472d5c87ec8b236240878a5b2d00d2 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -148,12 +148,20 @@ function create_dynamic_target() {
 # Generate the command line argument for netconsole following:
 #  netconsole=[+][src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]
 function create_cmdline_str() {
+	local BINDMODE=${1:-"ifname"}
+	if [ "${BINDMODE}" == "ifname" ]
+	then
+		SRCDEV=${SRCIF}
+	else
+		SRCDEV=$(mac_get "${SRCIF}")
+	fi
+
 	DSTMAC=$(ip netns exec "${NAMESPACE}" \
 		 ip link show "${DSTIF}" | awk '/ether/ {print $2}')
 	SRCPORT="1514"
 	TGTPORT="6666"
 
-	echo "netconsole=\"+${SRCPORT}@${SRCIP}/${SRCIF},${TGTPORT}@${DSTIP}/${DSTMAC}\""
+	echo "netconsole=\"+${SRCPORT}@${SRCIP}/${SRCDEV},${TGTPORT}@${DSTIP}/${DSTMAC}\""
 }
 
 # Do not append the release to the header of the message
diff --git a/tools/testing/selftests/drivers/net/netcons_cmdline.sh b/tools/testing/selftests/drivers/net/netcons_cmdline.sh
index ad2fb8b1c46326c69af20f2c9d68e80fa8eb894f..d1d23dc67f99aa357041b71718550ed94292e57a 100755
--- a/tools/testing/selftests/drivers/net/netcons_cmdline.sh
+++ b/tools/testing/selftests/drivers/net/netcons_cmdline.sh
@@ -19,9 +19,6 @@ check_netconsole_module
 modprobe netdevsim 2> /dev/null || true
 rmmod netconsole 2> /dev/null || true
 
-# The content of kmsg will be save to the following file
-OUTPUT_FILE="/tmp/${TARGET}"
-
 # Check for basic system dependency and exit if not found
 # check_for_dependencies
 # Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
@@ -30,23 +27,39 @@ echo "6 5" > /proc/sys/kernel/printk
 trap do_cleanup EXIT
 # Create one namespace and two interfaces
 set_network
-# Create the command line for netconsole, with the configuration from the
-# function above
-CMDLINE="$(create_cmdline_str)"
-
-# Load the module, with the cmdline set
-modprobe netconsole "${CMDLINE}"
-
-# Listed for netconsole port inside the namespace and destination interface
-listen_port_and_save_to "${OUTPUT_FILE}" &
-# Wait for socat to start and listen to the port.
-wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
-# Send the message
-echo "${MSG}: ${TARGET}" > /dev/kmsg
-# Wait until socat saves the file to disk
-busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
-# Make sure the message was received in the dst part
-# and exit
-validate_msg "${OUTPUT_FILE}"
+
+# Run the test twice, with different cmdline parameters
+for BINDMODE in "ifname" "mac"
+do
+	echo "Running with bind mode: ${BINDMODE}" >&2
+	# Create the command line for netconsole, with the configuration from
+	# the function above
+	CMDLINE=$(create_cmdline_str "${BINDMODE}")
+
+	# The content of kmsg will be save to the following file
+	OUTPUT_FILE="/tmp/${TARGET}-${BINDMODE}"
+
+	# Load the module, with the cmdline set
+	modprobe netconsole "${CMDLINE}"
+
+	# Listed for netconsole port inside the namespace and destination
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
+	# Unload the module
+	rmmod netconsole
+	echo "${BINDMODE} : Test passed" >&2
+done
 
 exit "${ksft_pass}"

---
base-commit: 37816488247ddddbc3de113c78c83572274b1e2e
change-id: 20250807-netcons-cmdline-selftest-b32e27a4bd16

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


