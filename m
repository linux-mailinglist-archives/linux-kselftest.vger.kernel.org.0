Return-Path: <linux-kselftest+bounces-34130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DD6ACACA1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 12:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DE73BF4CF
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 10:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E591A21423C;
	Mon,  2 Jun 2025 10:36:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDC420F063;
	Mon,  2 Jun 2025 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860618; cv=none; b=ldkdcwz0j/jECoxgKB1kHC2p0U/gbORDSlUvLX/7hLEztmfd/LyL6rc3kF+oRr/RzHj8PCXp0QsfHWJL34KskJ2BcWSqKVfPyGx95zcczwSd9yFY1AyUfQA4ToaLAMrwpunsw3o9KaTeZtUeJQs+6JWhGgf3FE2Vq0lzLohkx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860618; c=relaxed/simple;
	bh=U1HRi5BPIfFqWuEI1MGDrOmrCChwD+M8uPEKP9QFZug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qspQAFoXTYTXjn5VVUozxc9f3QgKn5uTtj16Yp0rS6eXPP2+v/7sWZCKw9HeX4eaZKeSexCA1DaNE9a3yN/xPcGkXezFWhKHijCYCn+KH9JWzj7ZzvYEDvDpk4i4lyuLITJEtTjqark9LJ57fLpNQXq85RPqS6bFoU4qlLZ4uAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad89d8a270fso1101750866b.1;
        Mon, 02 Jun 2025 03:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748860615; x=1749465415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXeB4IhrYE0giS9euV0gxoGa7fI1ChwrCarbpGdkqKU=;
        b=W2X2D6rzLiZRoHgJwfocMwwmfheTloiorS8VUTjWa2/+URCX5mvATbT+toEUTLdAxW
         a/SR4VruU/Wa2g5x61zNfaqi1zH4m0HBMYYuj2i+lTVdRHQqLeBAo9jnnE33Kp9YACZu
         QwJEAGWqeYD0SeApreWNRhdKp4SmRjpYoxHx1CIKwQY/kJdfI2/bjxAIeuQBH4NiK4YT
         iiI9g1EIbVZVONdix1NwrU6zUI6I9qRqkLw6mr6oFe/c6GSvZrbtYHuR6v9fftiJ33al
         oS2PwmCES4b7gXJmf+MZUKudKbn7xzFYNXuWE8FpFIoKx1O7omHlEZ8Yn/tfCJhP9QnP
         MskQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvrMkqqijH1tSQs9eem9juxL4zgJshAb8dHmR5pno4PtK2RCJWzGPq1VbZFD54FDtLp5jMqBIgnko7/micCtEL@vger.kernel.org, AJvYcCW9QfmqbY4csKjyUVRkjWBIuTruoGM5pvzHxSC/yFNOjXj1VvRLizebYRIwokwbqQ9zBLkhUGEEjn675jE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+tMxvgOb3cA5CDj+wsK6Y6CWYm33pzhh/zvO/MAtlCj+exJHE
	VJqDynjscoixzLRkiuA4SoOwHqmCkAn3cdj5bC15K0AzW3xMftmBc8Np
X-Gm-Gg: ASbGnctQq+leNlJJySR27f2jiCv+9gk1PA1WbyKtyjhEr4/uPbYZXTk5uuLjqyaiElY
	hmnVIVipk5dkN78h/Zd6FjVbV37dFi4quW0EFQfRmKmSh7Op5V4j3ALvAbnqmyuIolflhQ+bjTp
	x08cDFAcBRUidB9s2j1RgnCPcqAs0cGjIpC1zQyCtYLUiNJj8GOemTITIdURTQK9lYYEqt78Aki
	UI4YPSYD59ntj+VPzzZxIX1TKcLQznSNvXjtelCkO5LSTHjzVXApEUeyZZuMGscOSrX5mEl87HS
	p4hYf6/9QtDtspuAtPjVxGZcwlib+a0fP8p7p8YFY9E6Bl7d8dXh
X-Google-Smtp-Source: AGHT+IHn7vU+rBvLSZJm7s0hF8MXiLY+JAT6UWKfMBWvYyDb9oZWYaTqMmosPAzqCMBa+OTNp6ZXiw==
X-Received: by 2002:a17:907:da5:b0:ac7:81b0:62c9 with SMTP id a640c23a62f3a-adb32ca4d4fmr1263874766b.20.1748860614976;
        Mon, 02 Jun 2025 03:36:54 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb35af4456sm573655066b.182.2025.06.02.03.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 03:36:54 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 02 Jun 2025 03:34:44 -0700
Subject: [PATCH net-next v2 4/4] selftests: netconsole: Add support for
 basic netconsole target format
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-netcons_ext-v2-4-ef88d999326d@debian.org>
References: <20250602-netcons_ext-v2-0-ef88d999326d@debian.org>
In-Reply-To: <20250602-netcons_ext-v2-0-ef88d999326d@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, Usama Arif <usamaarif642@gmail.com>, 
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4802; i=leitao@debian.org;
 h=from:subject:message-id; bh=U1HRi5BPIfFqWuEI1MGDrOmrCChwD+M8uPEKP9QFZug=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoPX6/0lNBDPzKUPIPKW+fhdJYu2fn3q4XyfN/P
 6rgj/GrqOGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaD1+vwAKCRA1o5Of/Hh3
 bSZUEACuQNdin2wZExk20BPJGCtDxGDmtAuRzo0y/3B1t9xkNJMgHegTXA+/azHZ1Gf/4tZv68i
 r/m+bMJkJolGLB9jeZMwwJ2kZ5IdqXgmwRGySmsx80+uYVRJnkyrLbGoZ2o4bPKwJTa1Uf2aXGR
 IHZBsZ/2vNfiQo5LxojMBRur5GgveJ85NHj/hl+MBoaOQBpna7nLdYlUHmvS9ISe8bBB8NiOssE
 bGsQaEbAumFtK8utoa79js0qAWVwswCktUi7rRBVDUOtg/Huq+m5HxmjUhyXBUDwsIzITa/xWbk
 hrppjyvGMY6Zb/vCwfw9k+37ObWvtHo8xZ/uPeMLAt97hjgRCyMSQ2g0lTzeurpVX8izavHKVau
 FaS8FHROtKOHELyAbfP54G/cSyOICIl/VBuSH5fCILOKcpq5rY9DDgq61OZ0n0fUgVo5TfZuKI8
 QeyAHwM6NQcRsKTnsI3kxXE7e6dqfBu8ec9XZK0gaKJCvU/WxYRoFyK/MOB3vI7717z5QIqzNzX
 RPT8MTiUL2jUM1qjJDdjPvkQizX4GB5/z6dPkBNZo49bTICMlFSc+550maPxWbkiKE7D2UVh+5v
 vIQn332CwwjowQWGNznfpakZS/O65tZdlOb8DO26JVeehTs7L2SeAWmkr7pnR88v57sox5Fl2LT
 p6qlzl7i+6mthQA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extend the netconsole selftest to validate both basic and extended
target formats. The basic format is a simpler variant that doesn't
support userdata or release functionality.

The test now validates that netconsole works correctly in both
configurations, improving test coverage for different netconsole
deployment scenarios.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 26 +++++++++--
 .../testing/selftests/drivers/net/netcons_basic.sh | 52 +++++++++++++---------
 2 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 1b508131a6461..e0bc5927e83d5 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -96,6 +96,8 @@ function set_network() {
 }
 
 function create_dynamic_target() {
+	local FORMAT=${1:-"extended"}
+
 	DSTMAC=$(ip netns exec "${NAMESPACE}" \
 		 ip link show "${DSTIF}" | awk '/ether/ {print $2}')
 
@@ -107,6 +109,16 @@ function create_dynamic_target() {
 	echo "${DSTMAC}" > "${NETCONS_PATH}"/remote_mac
 	echo "${SRCIF}" > "${NETCONS_PATH}"/dev_name
 
+	if [ "${FORMAT}" == "basic" ]
+	then
+		# Basic target does not support release
+		echo 0 > "${NETCONS_PATH}"/release
+		echo 0 > "${NETCONS_PATH}"/extended
+	elif [ "${FORMAT}" == "extended" ]
+	then
+		echo 1 > "${NETCONS_PATH}"/extended
+	fi
+
 	echo 1 > "${NETCONS_PATH}"/enabled
 }
 
@@ -160,6 +172,7 @@ function listen_port_and_save_to() {
 
 function validate_result() {
 	local TMPFILENAME="$1"
+	local FORMAT=${2:-"extended"}
 
 	# TMPFILENAME will contain something like:
 	# 6.11.1-0_fbk0_rc13_509_g30d75cea12f7,13,1822,115075213798,-;netconsole selftest: netcons_gtJHM
@@ -177,10 +190,15 @@ function validate_result() {
 		exit "${ksft_fail}"
 	fi
 
-	if ! grep -q "${USERDATA_KEY}=${USERDATA_VALUE}" "${TMPFILENAME}"; then
-		echo "FAIL: ${USERDATA_KEY}=${USERDATA_VALUE} not found in ${TMPFILENAME}" >&2
-		cat "${TMPFILENAME}" >&2
-		exit "${ksft_fail}"
+	# userdata is not supported on basic format target,
+	# thus, do not validate it.
+	if [ "${FORMAT}" != "basic" ];
+	then
+		if ! grep -q "${USERDATA_KEY}=${USERDATA_VALUE}" "${TMPFILENAME}"; then
+			echo "FAIL: ${USERDATA_KEY}=${USERDATA_VALUE} not found in ${TMPFILENAME}" >&2
+			cat "${TMPFILENAME}" >&2
+			exit "${ksft_fail}"
+		fi
 	fi
 
 	# Delete the file once it is validated, otherwise keep it
diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
index ada6b899c5282..40a6ac6191b8b 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -32,23 +32,35 @@ check_for_dependencies
 echo "6 5" > /proc/sys/kernel/printk
 # Remove the namespace, interfaces and netconsole target on exit
 trap cleanup EXIT
-# Create one namespace and two interfaces
-set_network
-# Create a dynamic target for netconsole
-create_dynamic_target
-# Set userdata "key" with the "value" value
-set_user_data
-# Listed for netconsole port inside the namespace and destination interface
-listen_port_and_save_to "${OUTPUT_FILE}" &
-# Wait for socat to start and listen to the port.
-wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
-# Send the message
-echo "${MSG}: ${TARGET}" > /dev/kmsg
-# Wait until socat saves the file to disk
-busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
-
-# Make sure the message was received in the dst part
-# and exit
-validate_result "${OUTPUT_FILE}"
-
-exit "${ksft_pass}
+
+# Run the test twice, with different format modes
+for FORMAT in "basic" "extended"
+do
+	echo "Running with target mode: ${FORMAT}"
+	# Create one namespace and two interfaces
+	set_network
+	# Create a dynamic target for netconsole
+	create_dynamic_target "${FORMAT}"
+	# Only set userdata for extended format
+	if [ "$FORMAT" == "extended" ]
+	then
+		# Set userdata "key" with the "value" value
+		set_user_data
+	fi
+	# Listed for netconsole port inside the namespace and destination interface
+	listen_port_and_save_to "${OUTPUT_FILE}" &
+	# Wait for socat to start and listen to the port.
+	wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
+	# Send the message
+	echo "${MSG}: ${TARGET}" > /dev/kmsg
+	# Wait until socat saves the file to disk
+	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+
+	# Make sure the message was received in the dst part
+	# and exit
+	validate_result "${OUTPUT_FILE}" "${FORMAT}"
+	cleanup
+done
+
+trap - EXIT
+exit "${ksft_pass}"

-- 
2.47.1


