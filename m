Return-Path: <linux-kselftest+bounces-38699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFA2B21473
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBBF171C4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9076A2E11D1;
	Mon, 11 Aug 2025 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBOPaasY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69526FDA3;
	Mon, 11 Aug 2025 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937147; cv=none; b=XSeXoR/96N3kNcrM3YpAOo5nroe/zXk5DlJkdVW9No9ItWRQsV6rZyMnHHOBgJXVt93QPHL6+lmWkwf0kOkXDj0gdo5xyjrmFoVVWpfZwDpC7ED8vbL/eV5oyZvb0vKM0u72I128RnwdqTZE4ODGUIB/TXfOWQMi36kHZScrqa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937147; c=relaxed/simple;
	bh=TYkPnUhq0q9Pu1cc3u+bphgk0Q8Pv+aHmUvtQ2rYVsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mvsdPA85Rts5ze0UypZKoL8H8HoIVWr4JJqgR5p6cQOK297dkDBMEQsqSBNkSQ2qz3ieqHX5igKIvoAU6F5xmsPdBBG4UvZQbTjJgv+YFFMeONLJxQBsedjDEiclwZ24FZCab1IO1BRvWpupN30TokvK03UU41NPaJjEwlFF5v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBOPaasY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459e72abdd2so27639145e9.2;
        Mon, 11 Aug 2025 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754937144; x=1755541944; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+38aHWatwJZcPjV77AnirM8d2+c+qtW/JJxgUgdCUEQ=;
        b=XBOPaasYdTe1y/lNqX8qfeiKEKaKGXoqidiuX0eSIbNAtfysr2MGQ1bjDXriEUuidD
         zJWXFYRiDXv9a8LPTtSuex//4SexIMfHGKvXa55f1QmZ5AEtBy3YqHyG6j7wDdZReaaj
         XrgwuCmi2iw9dBvjVp1t6h3/qdeB0RNT0oY/A4119PYmagMlBAZuorRTn/chn64RXK+G
         UOdTDU4T1GaTj+u08HlF/SI9BMlxSiUsCyPokjxv4rWQaVN3E0QMoKAsWrHOj4ZxX+rM
         4UlTZJfTG+th+3aLGXwcHHdl8SzfC1H2bqdAecn4MbHfNoq1/ufGF7Gm9ad54sGzkcgk
         JP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754937144; x=1755541944;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+38aHWatwJZcPjV77AnirM8d2+c+qtW/JJxgUgdCUEQ=;
        b=Y5+VcFPoBob01AkzdKJB9Rf7G4s0NgzIb68TE2ui3xMU/SjiXCLzt6tA0sUu4iugr8
         /uOduIAd7ekTzEJMx/nKI7MQHM3aIBNwTwTMV7Y5MQ7iZ4h2ORxy8fmWjuM0LIXZFI/9
         SqRQgP21s/wEcRvso2LAz7EkqZPp3uJecJtyoe0aSOLKilynxQjsm2gqklZqt9bmgeZi
         X5dpydrn63k0BJGjkoVF9bUfELs/XcDVOU84RDZt437TJ7A3X8j/07oo0TJmesxiq3BL
         u1j5fBaVOwV5H5ugJK/fMJmTSBBWS6XGdXtjGDsTZLrog/uCxPIGwdtNgGrO6CvUWbX0
         LZMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSC+/SwgGJI8+2Xu5mpc6MvZGUOyJKDUxvRq9q29sjP6dz8RnlLelJnzZGeyZPrDIKdqQjAfWbTS6+IQ8=@vger.kernel.org, AJvYcCWGjDMd/PskNN9l6RzDjsZifvfaQcHSRxefCjtS4YBVHtId6G++H3kwVeQQnvclGTtG4zmSpKD6W3GSQ3FquIJf@vger.kernel.org
X-Gm-Message-State: AOJu0YxBEeXeRCwjKvPceb1kjo1sfU6M99Xq5FUWkEKeQIa5Iy7BU+GS
	TM8YFEAx79Qsj1qy4OGTpxn0fgsuxUw9rLVrJFsXmFTx0qFYCPd7060o960bhQ3ykcg=
X-Gm-Gg: ASbGncthrnfvPoreS3U1x+dlknRIYhRgVcYC5urr1/u4RgcX7GpmWzIBSGTeCZzrm9s
	m3rfkEt4asxPdviTW2SftQGGl09Z40oVof+Raq6qulpwt7+Jh0bxRhWBNw3NuiwuLFapUoWhHXL
	vpJu+W/zKtKA7/kzH4qWOWF/sZCpUuVmDNVeiFF511JHqwlGJEfek7A5n4wfUnrgNyUa9EA1g2/
	7p4+yYTJw9LR59VEMa2sFne0CNMQuUMXfWIIM8VJQKvvnFm4nAvVlkRyTYrFnMu+SRKWDA0EYRM
	2JRprvdW+M1qjAWieups+y/SMVf9A+s7siOZakeeNYJM+6PgfhyrzjEmnoZvC5sKvUMcCa9uYwE
	haaSzENX4/B10NC3gVvDw81Cmhw==
X-Google-Smtp-Source: AGHT+IFJVCSJUAri3JD7IN6+yxqqLmWwHtU+s4kqcMVKECA1wbIBdQaeUjeRuyDBqwRlx4uXjqHS5Q==
X-Received: by 2002:a05:600c:4fd1:b0:453:5c30:a1fd with SMTP id 5b1f17b1804b1-45a10ba7d10mr7182905e9.8.1754937143283;
        Mon, 11 Aug 2025 11:32:23 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c33fesm42131132f8f.29.2025.08.11.11.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:32:22 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Mon, 11 Aug 2025 19:32:09 +0100
Subject: [PATCH net-next] selftests: netconsole: Validate interface
 selection by MAC address
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-netcons-cmdline-selftest-v1-1-1f725ab020fa@gmail.com>
X-B4-Tracking: v=1; b=H4sIACg3mmgC/x3MQQrCQAxG4auUrA1Mx2rFq4iLduavBmoqk0EKp
 Xc3dPkW39vIUARG92ajgp+YLOrRnhpK70FfYMneFEO8hFvoWVHTosbpk2dRsGGeKqzyeI6I/dC
 Nub2S82/BJOuxfpArl2ul577/AdGPdYZ0AAAA
X-Change-ID: 20250807-netcons-cmdline-selftest-b32e27a4bd16
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754937142; l=4592;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=TYkPnUhq0q9Pu1cc3u+bphgk0Q8Pv+aHmUvtQ2rYVsI=;
 b=syUESDzmuOy1dox0z5Eymdea7Xg59jJCDD3zso8suc9OKxXnBEcBsZXV6rA3+s2uaFUcHafN8
 aR7o4MgmwunDLQRPerr/D65ItwWe15bSWwVI9wo3C6JrWoEk9FbIR62
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Extend the existing netconsole cmdline selftest to also validate that
interface selection can be performed via MAC address.

The test now validates that netconsole works with both interface name
and MAC address, improving test coverage.

Suggested-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 10 +++-
 .../selftests/drivers/net/netcons_cmdline.sh       | 55 +++++++++++++---------
 2 files changed, 42 insertions(+), 23 deletions(-)

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
index ad2fb8b1c46326c69af20f2c9d68e80fa8eb894f..a15149f3a905d7287258cd17f0e806fb50604cf4 100755
--- a/tools/testing/selftests/drivers/net/netcons_cmdline.sh
+++ b/tools/testing/selftests/drivers/net/netcons_cmdline.sh
@@ -17,10 +17,6 @@ source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
 check_netconsole_module
 
 modprobe netdevsim 2> /dev/null || true
-rmmod netconsole 2> /dev/null || true
-
-# The content of kmsg will be save to the following file
-OUTPUT_FILE="/tmp/${TARGET}"
 
 # Check for basic system dependency and exit if not found
 # check_for_dependencies
@@ -30,23 +26,38 @@ echo "6 5" > /proc/sys/kernel/printk
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
+	echo "Running with bind mode: ${BINDMODE}"
+	# Create the command line for netconsole, with the configuration from the
+	# function above
+	CMDLINE="$(create_cmdline_str "${BINDMODE}")"
+
+	# The content of kmsg will be save to the following file
+	OUTPUT_FILE="/tmp/${TARGET}-${BINDMODE}"
+
+	# Unload the module, if present
+	rmmod netconsole 2> /dev/null || true
+	# Load the module, with the cmdline set
+	modprobe netconsole "${CMDLINE}"
+
+	# Listed for netconsole port inside the namespace and destination interface
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
+	echo "${BINDMODE} : Test passed" >&2
+done
 
 exit "${ksft_pass}"

---
base-commit: 37816488247ddddbc3de113c78c83572274b1e2e
change-id: 20250807-netcons-cmdline-selftest-b32e27a4bd16

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


