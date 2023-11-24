Return-Path: <linux-kselftest+bounces-503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 553E97F6F86
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1FA8B211D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65543FBEA;
	Fri, 24 Nov 2023 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NthqsxM7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98423D46;
	Fri, 24 Nov 2023 01:27:57 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1276083a12.3;
        Fri, 24 Nov 2023 01:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818076; x=1701422876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzRb3ZuXImOqXYgiw+Uj29ubtM7yPA76TIuVl1zE3yM=;
        b=NthqsxM7SWJuCO8si8C4M6f8o0h3MA2CtUXnFhVio2ri/tJANF++koztCPa3NA87kZ
         pgDYJf8ulDAWFUhH0YUohe7QLQOx0LIlBJ/EtW93/BFUI3WSYZYz9hOXgkZCIdVWOcAb
         aJ8ff8mxjLH/gVy0UXkcJomjmzFpcrVPDth5zJP7dkc4Tv/+fQ5SzZrWw3p0+bx444P0
         RMYnK400cslbONJ5R6lZs7rsHbdZUJhKn2d0AqVgSTvVIAcyQC5nFUc7o0l9WVZOMJGv
         S0xzE0/FgzH45LNwcRfklqDQ0tvelBzJD1FgHxSLgeV7Lpq6igr0welE3NAViBG3HX0G
         T5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818076; x=1701422876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzRb3ZuXImOqXYgiw+Uj29ubtM7yPA76TIuVl1zE3yM=;
        b=bWHr/sIJbiMQoboOJeEzEr4nRm9f9hy+gBWo0LRLZo2XOeB/1hEklkW4j1FM6xmUNn
         ZiLka3Y3D2tu0lGOJV1gPxPntp1TRdf0n8B1tbrizBReovRmmigusydB1BXy+Fit6aZ6
         ldTS1W+Ecq+U9zT21/m/sR++JX8sZr1/5dGE+j47nPCjcw7fQlGiueR3Zu8cLhYhHN8m
         azxyyPg6hRmJVYzBZS3Mi1HMl+xUP1j/E3G1fLQe6vaFub4aMfmBP93iE5tBE7Me0ndD
         PiF0/y1ZUWsl8fcunFZZ0QsZg8VT4BDkOSNHOvP4lkK12ycKzzxTnwXyhAJQpDeCLqFi
         ksqA==
X-Gm-Message-State: AOJu0YwqbzEw3mLFZHICW5uUFIkFXZ7glZ9PEiP/PGJysmEm1H2SKXq4
	0+cIrtUizfWPj9/1yazIWh5zgDY8wqUrf6Tu
X-Google-Smtp-Source: AGHT+IFfq75FZ73zLhsUyO4C7DFsN7EreRz25hwY5JU6exXPoczwRQjv/a+dOwy9ZkvRNOG4GDchVg==
X-Received: by 2002:a05:6a20:3e03:b0:18b:d229:1310 with SMTP id m3-20020a056a203e0300b0018bd2291310mr1985041pzc.35.1700818076605;
        Fri, 24 Nov 2023 01:27:56 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:27:55 -0800 (PST)
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 01/38] selftests/net: add lib.sh
Date: Fri, 24 Nov 2023 17:26:59 +0800
Message-ID: <20231124092736.3673263-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124092736.3673263-1-liuhangbin@gmail.com>
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a lib.sh for net selftests. This file can be used to define commonly
used variables and functions.

Add function setup_ns() for user to create unique namespaces with given
prefix name.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/Makefile |  2 +-
 tools/testing/selftests/net/lib.sh   | 98 ++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 1 deletion(-)
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
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
new file mode 100644
index 000000000000..239ab2beb438
--- /dev/null
+++ b/tools/testing/selftests/net/lib.sh
@@ -0,0 +1,98 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+##############################################################################
+# Defines
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+# namespace list created by setup_ns
+NS_LIST=""
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
+		out=$($@)
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
+
+	# disable errexit temporary
+	if [[ $- =~ "e" ]]; then
+		errexit=1
+		set +e
+	fi
+
+	for ns in "$@"; do
+		ip netns delete "${ns}" &> /dev/null
+		busywait 2 "ip netns list | grep -vq $1" &> /dev/null
+		if ip netns list | grep -q $1; then
+			echo "Failed to remove namespace $1"
+			return $ksft_skip
+		fi
+	done
+
+	[ $errexit -eq 1 ] && set -e
+	return 0
+}
+
+# By default, remove all netns before EXIT.
+cleanup_all_ns()
+{
+	cleanup_ns $NS_LIST
+}
+trap cleanup_all_ns EXIT
+
+# setup netns with given names as prefix. e.g
+# setup_ns local remote
+setup_ns()
+{
+	local ns=""
+	# the ns list we created in this call
+	local ns_list=""
+	while [ -n "$1" ]; do
+		# Some test may setup/remove same netns multi times
+		if unset $1 2> /dev/null; then
+			ns="${1,,}-$(mktemp -u XXXXXX)"
+			eval readonly $1=$ns
+		else
+			eval ns='$'$1
+			cleanup_ns $ns
+
+		fi
+
+		ip netns add $ns
+		if ! ip netns list | grep -q $ns; then
+			echo "Failed to create namespace $1"
+			cleanup_ns $ns_list
+			return $ksft_skip
+		fi
+		ip -n $ns link set lo up
+		ns_list="$ns_list $ns"
+
+		shift
+	done
+	NS_LIST="$NS_LIST $ns_list"
+}
-- 
2.41.0


