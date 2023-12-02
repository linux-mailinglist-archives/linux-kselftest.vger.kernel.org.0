Return-Path: <linux-kselftest+bounces-1004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84A88019C7
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 03:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BF11C20BE3
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 02:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FFF3D79;
	Sat,  2 Dec 2023 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7Q5e69y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA679D;
	Fri,  1 Dec 2023 18:01:25 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c210e34088so946598a12.2;
        Fri, 01 Dec 2023 18:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701482484; x=1702087284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSbykfiu3R+ZacAsHVydx4ZeWOJedZWlX+jJ9iNhrX8=;
        b=A7Q5e69yldvbpvcYyPZlLQEwcr2vRMoC0TlPMxN8hzxwAYwjqCcrrRpw+XkgBjGlPw
         /028HTCc1IgAmkQU7pYGPicgolbMAoWn7VV2b0qnWVH4gwm7y3fAbfkHpcBiwdU7j0Db
         rGXX9Ly/dY0X2GLVKhkJNXz2U4zLe6ldoEAz+d0gBeaJNPbJTvcn9d4FG2YrscDUZy77
         oZxcHLTfMz2EBMbUbUcct1xpcFnSXmeW8Vt9q+Mx+ilUY1MMIFauNDtLJME/Ya9Sqyk0
         o+IPIngnplhp/S2ewJwLsVYortY3j808TGphkt9zFQVjOCk3ef8b4A1KYQ69d0w8dZoL
         Ywtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482484; x=1702087284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSbykfiu3R+ZacAsHVydx4ZeWOJedZWlX+jJ9iNhrX8=;
        b=qerZz9ghPfgOIPubo2Vlp534qJMrC4jdCYGe81uhEoAlCeOsv0Ui7hiEZ8N5rfTWm8
         78LdeJdMVSjrGujFs3Q7KdrR+ve9OPFYN/DyPZotwdrJN86dewQ2AJZqvo7vs1KC7Ch5
         khKs5xG8nyjSRG7Tk/AsWBXl9LM93ppbqyNN58vPaRwEiEOb482BEqa1k3orQ2+MfBus
         DAUThBdN4A4CjuEVBW4YhK4nxe0cvdl6SLO2Vmp+ODNahuQ2u7heCV4DbIXCu4CjEYQT
         Dygh2Mb3F92fm+5XWPCtbstXJLJ4Jhj7NHAujeEGWp4skrE21WX1WB35qqxIzWDmfyNs
         Eabg==
X-Gm-Message-State: AOJu0Yxt9Df5Bhm7cMxQKZdmVi5CRTclygZcnsuWyrdY7xYa7AMuHAxc
	y2juoWCzsnnHqpEmV+ozUigYuX1c46yQkWfZ
X-Google-Smtp-Source: AGHT+IEqQ6tW8+nn/KN3Qofe7RIRFgFJtMaxm/atZD0vh+l8UmzxzYhDnVpfWxZlTrDzib/U04x7Ig==
X-Received: by 2002:a17:902:db06:b0:1d0:7535:8bc2 with SMTP id m6-20020a170902db0600b001d075358bc2mr113968plx.105.1701482483988;
        Fri, 01 Dec 2023 18:01:23 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001b3bf8001a9sm3993034plf.48.2023.12.01.18.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 18:01:23 -0800 (PST)
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
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	James Prestwood <prestwoj@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	James Chapman <jchapman@katalix.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 01/14] selftests/net: add lib.sh
Date: Sat,  2 Dec 2023 10:00:57 +0800
Message-ID: <20231202020110.362433-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202020110.362433-1-liuhangbin@gmail.com>
References: <20231202020110.362433-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a lib.sh for net selftests. This file can be used to define commonly
used variables and functions. Some commonly used functions can be moved
from forwarding/lib.sh to this lib file. e.g. busywait().

Add function setup_ns() for user to create unique namespaces with given
prefix name.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/Makefile          |  2 +-
 tools/testing/selftests/net/forwarding/lib.sh | 27 +-----
 tools/testing/selftests/net/lib.sh            | 85 +++++++++++++++++++
 3 files changed, 87 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 9274edfb76ff..14bd68da7466 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -54,7 +54,7 @@ TEST_PROGS += ip_local_port_range.sh
 TEST_PROGS += rps_default_mask.sh
 TEST_PROGS += big_tcp.sh
 TEST_PROGS_EXTENDED := in_netns.sh setup_loopback.sh setup_veth.sh
-TEST_PROGS_EXTENDED += toeplitz_client.sh toeplitz.sh
+TEST_PROGS_EXTENDED += toeplitz_client.sh toeplitz.sh lib.sh
 TEST_GEN_FILES =  socket nettest
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy reuseport_addr_any
 TEST_GEN_FILES += tcp_mmap tcp_inq psock_snd txring_overwrite
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index e37a15eda6c2..8f6ca458af9a 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -4,9 +4,6 @@
 ##############################################################################
 # Defines
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
 # Can be overridden by the configuration file.
 PING=${PING:=ping}
 PING6=${PING6:=ping6}
@@ -41,6 +38,7 @@ if [[ -f $relative_path/forwarding.config ]]; then
 	source "$relative_path/forwarding.config"
 fi
 
+source ../lib.sh
 ##############################################################################
 # Sanity checks
 
@@ -395,29 +393,6 @@ log_info()
 	echo "INFO: $msg"
 }
 
-busywait()
-{
-	local timeout=$1; shift
-
-	local start_time="$(date -u +%s%3N)"
-	while true
-	do
-		local out
-		out=$("$@")
-		local ret=$?
-		if ((!ret)); then
-			echo -n "$out"
-			return 0
-		fi
-
-		local current_time="$(date -u +%s%3N)"
-		if ((current_time - start_time > timeout)); then
-			echo -n "$out"
-			return 1
-		fi
-	done
-}
-
 not()
 {
 	"$@"
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
new file mode 100644
index 000000000000..518eca57b815
--- /dev/null
+++ b/tools/testing/selftests/net/lib.sh
@@ -0,0 +1,85 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+##############################################################################
+# Defines
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+##############################################################################
+# Helpers
+busywait()
+{
+	local timeout=$1; shift
+
+	local start_time="$(date -u +%s%3N)"
+	while true
+	do
+		local out
+		out=$("$@")
+		local ret=$?
+		if ((!ret)); then
+			echo -n "$out"
+			return 0
+		fi
+
+		local current_time="$(date -u +%s%3N)"
+		if ((current_time - start_time > timeout)); then
+			echo -n "$out"
+			return 1
+		fi
+	done
+}
+
+cleanup_ns()
+{
+	local ns=""
+	local errexit=0
+	local ret=0
+
+	# disable errexit temporary
+	if [[ $- =~ "e" ]]; then
+		errexit=1
+		set +e
+	fi
+
+	for ns in "$@"; do
+		ip netns delete "${ns}" &> /dev/null
+		if ! busywait 2 ip netns list \| grep -vq "^$ns$" &> /dev/null; then
+			echo "Warn: Failed to remove namespace $ns"
+			ret=1
+		fi
+	done
+
+	[ $errexit -eq 1 ] && set -e
+	return $ret
+}
+
+# setup netns with given names as prefix. e.g
+# setup_ns local remote
+setup_ns()
+{
+	local ns=""
+	local ns_name=""
+	local ns_list=""
+	for ns_name in "$@"; do
+		# Some test may setup/remove same netns multi times
+		if unset ${ns_name} 2> /dev/null; then
+			ns="${ns_name,,}-$(mktemp -u XXXXXX)"
+			eval readonly ${ns_name}="$ns"
+		else
+			eval ns='$'${ns_name}
+			cleanup_ns "$ns"
+
+		fi
+
+		if ! ip netns add "$ns"; then
+			echo "Failed to create namespace $ns_name"
+			cleanup_ns "$ns_list"
+			return $ksft_skip
+		fi
+		ip -n "$ns" link set lo up
+		ns_list="$ns_list $ns"
+	done
+}
-- 
2.43.0


