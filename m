Return-Path: <linux-kselftest+bounces-863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435F87FE7F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 05:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BE828234E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 04:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412501429A;
	Thu, 30 Nov 2023 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrQkdLBe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A0898;
	Wed, 29 Nov 2023 20:01:20 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35aa6107e9fso1338335ab.0;
        Wed, 29 Nov 2023 20:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701316879; x=1701921679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gjk7iuV8A+tyeFYWlo3kf68GzFjjU4BPv1o4618L2Aw=;
        b=VrQkdLBeAMsRJcRz6f4TS09vZrymfyTJmeXBnJufy55IdaFT7TAYM59DxOAd9FAe+l
         Rqjyez3FvTlarifIfkpzfQ7xbgd427frkCt6IamL64fMby7vxLruy+kA/Sb9f59fo14P
         k3+vP5rac+hL2u1qrp8dbSgK0FFylvoiR6gr4sJF/VILdUF9SiovtWXx8XGXmaFMfyZC
         lCyVLC3ZmnS2hdDLwQtPksP5Mf76UbMcGx/Y88cE9qGRcwQt1Zo4ebp9JZ2xYXQzRg0y
         ZZ2g4ge0+eySraJUZAb6tpWOv39jTwOOhwHoH6Iy8EENKdi4KSXG0zAikFFd1u2oKn5X
         2kPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316879; x=1701921679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gjk7iuV8A+tyeFYWlo3kf68GzFjjU4BPv1o4618L2Aw=;
        b=KzdyhswEmun/KTwXqsd9ClWqu8DKs9P7Sb44U8yH/FRklSMBKXdW2+v75QDDrC5meE
         JHFXLjUm3AMU3RWcJIO5THu3sWJPBh15KEBfq1yb1V+C6TYPWxYdsN20pb1xLj7oV30e
         v/GZvVEtU3AqRVV58surjOvDIlHjd3zju6RgPj3cQ3x1AT3wVjDkFMexDbkooISx8duC
         OSQX9Pe8qcdCSt15B5yB1UQJqs3QZGAsSA0VUhq5elyN2EC98s+2okM9lkVNgDVJGu98
         o43eeF6R7lgRrzzYw5TOsJXCkid1YHm+elLSmKsgT4Kt25ey37cJuJYyBxDiSxvN1YeY
         v2+w==
X-Gm-Message-State: AOJu0YxPquRr4bcJYULZPwPtA6IrTYy0fd596s5dG9LnjTExSinOnMg+
	ivBBgKLenRR/pgJRbDIK6tQbMd/NTQ41rA==
X-Google-Smtp-Source: AGHT+IEl1zoszRax/cXnv2qz7N9/Np/DS94MuLbjw6q7oSpfgosU4PE+pee0G7WEN6xsJr8V+p2buA==
X-Received: by 2002:a05:6e02:218b:b0:359:d6e4:cfb7 with SMTP id j11-20020a056e02218b00b00359d6e4cfb7mr27553173ila.11.1701316878781;
        Wed, 29 Nov 2023 20:01:18 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm187975pfn.61.2023.11.29.20.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:01:18 -0800 (PST)
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
	Francesco Ruggeri <fruggeri@arista.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 01/14] selftests/net: add lib.sh
Date: Thu, 30 Nov 2023 12:00:52 +0800
Message-ID: <20231130040105.1265779-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130040105.1265779-1-liuhangbin@gmail.com>
References: <20231130040105.1265779-1-liuhangbin@gmail.com>
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
2.41.0


