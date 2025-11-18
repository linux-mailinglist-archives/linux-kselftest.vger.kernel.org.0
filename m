Return-Path: <linux-kselftest+bounces-45923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C166BC6BC6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 22:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 234304E9F52
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 21:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E403101DB;
	Tue, 18 Nov 2025 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0n2Pv1B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A802FABEE;
	Tue, 18 Nov 2025 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502723; cv=none; b=qWP0zk4AgSqVd/3Rr7idR02BbtaxTDlhIU16E+NLlkYCLbfGG6jGfaeZX5q+QdvIuuWfZH/35v8Req7Fru7M4Tz80JI6oBIZxvNo6aU3Sz7pMCB4sL/6pKyuiXKZwIUfdyJB3E7fuDE8Pqxe9MhlJxacsSvO/auHioDVVrAWcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502723; c=relaxed/simple;
	bh=IhSndVL/bjANP/FXqj477vn7tPmRXDZwVcT6eQKgW3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmRct+vHY+B7f8lRi603Zp7MkZ9rHWBEj+vPVVZwC7ZFMRQ0TmALSImu8h+A9lR2T5d5l+55zyH4u1cMh02cyeJKQUS26SFwNk9EgWgPrwUZ/k2SNZzHYhcFHOgT7Kewshaq/8IjTBOuEyYkphQ7kr3GdxlHZ96xRg8r5FutSWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0n2Pv1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612A4C2BCB1;
	Tue, 18 Nov 2025 21:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763502722;
	bh=IhSndVL/bjANP/FXqj477vn7tPmRXDZwVcT6eQKgW3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0n2Pv1Bxs/wQIbaDZzZw/dZr7kA01EWMxenDZrudu3954BcNhlWPr3mZ5Uq4qh9m
	 JcNcDNvma0aVlPqM4nbgNJWouUPAOZ+U3LwszFBLxdhLo9VAR3zZhxd4TJr9dRg3ne
	 ghuV5N+VroqNjXwTOEuE5hBmWsFofPfORj+JFBlwBkAWLZStgcL2eRtSFRcNnaM7+k
	 nZ3evaC4Rc+jnEbiCtotTF/8FXlhxTuRXm0K/qNNc5EX1OzYXUAs+y9UtsZwjVMK46
	 fRmxH3LtvPC5xfRdZknb91YrAF9r5T4nafB+IPUxDuJ5mRnmi4TA5wYeQlkDYTfQ7n
	 +gkFfXVDOrzJA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	krakauer@google.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 05/12] selftests: net: relocate gro and toeplitz tests to drivers/net
Date: Tue, 18 Nov 2025 13:51:19 -0800
Message-ID: <20251118215126.2225826-6-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118215126.2225826-1-kuba@kernel.org>
References: <20251118215126.2225826-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GRO test can run on a real device or a veth.
The Toeplitz hash test can only run on a real device.
Move them from net/ to drivers/net/ and drivers/net/hw/ respectively.

There are two scripts which set up the environment for these tests
setup_loopback.sh and setup_veth.sh. Move those scripts to net/lib.
The paths to the setup files are a little ugly but they will be
deleted shortly.

toeplitz_client.sh is not a test in itself, but rather a helper
to send traffic, so add it to TEST_FILES rather than TEST_PROGS.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix accidental modification of gitignore
v1: https://lore.kernel.org/20251117205810.1617533-6-kuba@kernel.org
---
 tools/testing/selftests/drivers/net/Makefile               | 2 ++
 tools/testing/selftests/drivers/net/hw/Makefile            | 7 ++++++-
 tools/testing/selftests/net/Makefile                       | 7 -------
 tools/testing/selftests/net/lib/Makefile                   | 2 ++
 tools/testing/selftests/{ => drivers}/net/gro.c            | 2 +-
 tools/testing/selftests/{net => drivers/net/hw}/toeplitz.c | 2 +-
 tools/testing/selftests/drivers/net/.gitignore             | 1 +
 tools/testing/selftests/{ => drivers}/net/gro.sh           | 4 ++--
 tools/testing/selftests/drivers/net/hw/.gitignore          | 1 +
 .../testing/selftests/{net => drivers/net/hw}/toeplitz.sh  | 2 +-
 .../selftests/{net => drivers/net/hw}/toeplitz_client.sh   | 0
 tools/testing/selftests/net/.gitignore                     | 2 --
 tools/testing/selftests/net/{ => lib}/setup_loopback.sh    | 0
 tools/testing/selftests/net/{ => lib}/setup_veth.sh        | 0
 14 files changed, 17 insertions(+), 15 deletions(-)
 rename tools/testing/selftests/{ => drivers}/net/gro.c (99%)
 rename tools/testing/selftests/{net => drivers/net/hw}/toeplitz.c (99%)
 rename tools/testing/selftests/{ => drivers}/net/gro.sh (95%)
 rename tools/testing/selftests/{net => drivers/net/hw}/toeplitz.sh (98%)
 rename tools/testing/selftests/{net => drivers/net/hw}/toeplitz_client.sh (100%)
 rename tools/testing/selftests/net/{ => lib}/setup_loopback.sh (100%)
 rename tools/testing/selftests/net/{ => lib}/setup_veth.sh (100%)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 33f4816216ec..7083a8707c4e 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -6,10 +6,12 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 		 ../../net/lib.sh \
 
 TEST_GEN_FILES := \
+	gro \
 	napi_id_helper \
 # end of TEST_GEN_FILES
 
 TEST_PROGS := \
+	gro.sh \
 	hds.py \
 	napi_id.py \
 	napi_threaded.py \
diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 8133d1a0051c..c9dced8c934a 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
-TEST_GEN_FILES = iou-zcrx
+TEST_GEN_FILES := \
+	iou-zcrx \
+	toeplitz \
+# end of TEST_GEN_FILES
 
 TEST_PROGS = \
 	csum.py \
@@ -21,12 +24,14 @@ TEST_PROGS = \
 	rss_ctx.py \
 	rss_flow_label.py \
 	rss_input_xfrm.py \
+	toeplitz.sh \
 	tso.py \
 	xsk_reconfig.py \
 	#
 
 TEST_FILES := \
 	ethtool_lib.sh \
+	toeplitz_client.sh \
 	#
 
 TEST_INCLUDES := \
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b5127e968108..b66ba04f19d9 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -38,7 +38,6 @@ TEST_PROGS := \
 	fq_band_pktlimit.sh \
 	gre_gso.sh \
 	gre_ipv6_lladdr.sh \
-	gro.sh \
 	icmp.sh \
 	icmp_redirect.sh \
 	io_uring_zerocopy_tx.sh \
@@ -121,8 +120,6 @@ TEST_PROGS := \
 # end of TEST_PROGS
 
 TEST_PROGS_EXTENDED := \
-	toeplitz.sh \
-	toeplitz_client.sh \
 	xfrm_policy_add_speed.sh \
 # end of TEST_PROGS_EXTENDED
 
@@ -130,7 +127,6 @@ TEST_GEN_FILES := \
 	bind_bhash \
 	cmsg_sender \
 	fin_ack_lat \
-	gro \
 	hwtstamp_config \
 	io_uring_zerocopy_tx \
 	ioam6_parser \
@@ -159,7 +155,6 @@ TEST_GEN_FILES := \
 	tcp_mmap \
 	tfo \
 	timestamping \
-	toeplitz \
 	txring_overwrite \
 	txtimestamp \
 	udpgso \
@@ -193,8 +188,6 @@ TEST_FILES := \
 	in_netns.sh \
 	lib.sh \
 	settings \
-	setup_loopback.sh \
-	setup_veth.sh \
 # end of TEST_FILES
 
 # YNL files, must be before "include ..lib.mk"
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index ce795bc0a1af..c10796933d42 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -8,6 +8,8 @@ CFLAGS += -I../../
 TEST_FILES := \
 	../../../../net/ynl \
 	../../../../../Documentation/netlink/specs \
+	setup_loopback.sh \
+	setup_veth.sh \
 # end of TEST_FILES
 
 TEST_GEN_FILES := \
diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/drivers/net/gro.c
similarity index 99%
rename from tools/testing/selftests/net/gro.c
rename to tools/testing/selftests/drivers/net/gro.c
index cfc39f70635d..9b9be0cf8f7f 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/drivers/net/gro.c
@@ -57,7 +57,7 @@
 #include <string.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "../../kselftest.h"
 
 #define DPORT 8000
 #define SPORT 1500
diff --git a/tools/testing/selftests/net/toeplitz.c b/tools/testing/selftests/drivers/net/hw/toeplitz.c
similarity index 99%
rename from tools/testing/selftests/net/toeplitz.c
rename to tools/testing/selftests/drivers/net/hw/toeplitz.c
index 9ba03164d73a..bf74aa25345d 100644
--- a/tools/testing/selftests/net/toeplitz.c
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.c
@@ -52,7 +52,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "../../../kselftest.h"
 
 #define TOEPLITZ_KEY_MIN_LEN	40
 #define TOEPLITZ_KEY_MAX_LEN	60
diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
index 585ecb4d5dc4..3633c7a3ed65 100644
--- a/tools/testing/selftests/drivers/net/.gitignore
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
+gro
 napi_id_helper
 psp_responder
diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/drivers/net/gro.sh
similarity index 95%
rename from tools/testing/selftests/net/gro.sh
rename to tools/testing/selftests/drivers/net/gro.sh
index 4c5144c6f652..bd3cf6d02eda 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/drivers/net/gro.sh
@@ -90,9 +90,9 @@ while getopts "i:t:p:" opt; do
 done
 
 if [ -n "$dev" ]; then
-	source setup_loopback.sh
+	source $(dirname $0)/../../net/lib/setup_loopback.sh
 else
-	source setup_veth.sh
+	source $(dirname $0)/../../net/lib/setup_veth.sh
 fi
 
 setup
diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
index 6942bf575497..46540468a775 100644
--- a/tools/testing/selftests/drivers/net/hw/.gitignore
+++ b/tools/testing/selftests/drivers/net/hw/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iou-zcrx
 ncdevmem
+toeplitz
diff --git a/tools/testing/selftests/net/toeplitz.sh b/tools/testing/selftests/drivers/net/hw/toeplitz.sh
similarity index 98%
rename from tools/testing/selftests/net/toeplitz.sh
rename to tools/testing/selftests/drivers/net/hw/toeplitz.sh
index 8ff172f7bb1b..d236b666dd3b 100755
--- a/tools/testing/selftests/net/toeplitz.sh
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.sh
@@ -11,7 +11,7 @@
 # invoke as ./toeplitz.sh (-i <iface>) -u|-t -4|-6 \
 # [(-rss -irq_prefix <irq-pattern-prefix>)|(-rps <rps_map>)]
 
-source setup_loopback.sh
+source $(dirname $0)/../../../net/lib/setup_loopback.sh
 readonly SERVER_IP4="192.168.1.200/24"
 readonly SERVER_IP6="fda8::1/64"
 readonly SERVER_MAC="aa:00:00:00:00:02"
diff --git a/tools/testing/selftests/net/toeplitz_client.sh b/tools/testing/selftests/drivers/net/hw/toeplitz_client.sh
similarity index 100%
rename from tools/testing/selftests/net/toeplitz_client.sh
rename to tools/testing/selftests/drivers/net/hw/toeplitz_client.sh
diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index e89a60581a13..e139b7186c6c 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -7,7 +7,6 @@ cmsg_sender
 diag_uid
 epoll_busy_poll
 fin_ack_lat
-gro
 hwtstamp_config
 io_uring_zerocopy_tx
 ioam6_parser
@@ -56,7 +55,6 @@ tcp_port_share
 tfo
 timestamping
 tls
-toeplitz
 tools
 tun
 txring_overwrite
diff --git a/tools/testing/selftests/net/setup_loopback.sh b/tools/testing/selftests/net/lib/setup_loopback.sh
similarity index 100%
rename from tools/testing/selftests/net/setup_loopback.sh
rename to tools/testing/selftests/net/lib/setup_loopback.sh
diff --git a/tools/testing/selftests/net/setup_veth.sh b/tools/testing/selftests/net/lib/setup_veth.sh
similarity index 100%
rename from tools/testing/selftests/net/setup_veth.sh
rename to tools/testing/selftests/net/lib/setup_veth.sh
-- 
2.51.1


