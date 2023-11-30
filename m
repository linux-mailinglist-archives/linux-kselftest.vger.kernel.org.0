Return-Path: <linux-kselftest+bounces-867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632107FE7FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 05:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9565C1C20DC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 04:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FA01429E;
	Thu, 30 Nov 2023 04:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbna4VYq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BBE10CB;
	Wed, 29 Nov 2023 20:01:39 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cbbfdf72ecso526206b3a.2;
        Wed, 29 Nov 2023 20:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701316898; x=1701921698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUgUgtQbZLJGLZPHRX/WgbvxSFhdU1Uj0DPlUJEkXP8=;
        b=kbna4VYqYh53vuKqRtbYMxoipqYxOvQusSJY+5GsZiotTZIkWKCRSVa2ci+GBmPnrk
         WqEEszUDK9r0DHb82L/VS38L9OZE0fJZftIF3Y+e5bwzh8zRj0edMlI0dOgtK7sGjv5P
         ohnNWYGgEqxdg2R8/ISu2FRuussEsLs7VelyDttF8dWrixMuses/ROOwKVy1rwoZkg0q
         VkTESDEUdzz5Yzqd+sl9n6I0h3ZzoNnr+mJ+pHSjdw/rJi2P0WY6dLt7hk9vDbqAOuag
         3LPz2JTWJwzEbYBDXL+/qy24wFBg+xF51yeLyeN022VsytawcNDoPX19c7U3QLu+GqgU
         uB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316898; x=1701921698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUgUgtQbZLJGLZPHRX/WgbvxSFhdU1Uj0DPlUJEkXP8=;
        b=KgkWrFq3QYmRGppmunldDZF7q5eBUhHJbknhU2/nr9jMg6ZsxaBGz95SLufaRqoY+B
         x09I+TX8o2zEhxa4MRPcj0q+uaUFUesoE3Y0l1xncUu7CjakbB+kBZI5vS47+u25Htx0
         yHx+nZrWAIsaFapXN25b1KC8jUNvsm/AdPhjnTt0PDh/uCSWdMckNiuNwOYzoOKR7ZOU
         ulv2o61xobH8bG44ZL7GcA1cw75wGivkc6DNWNu5KwFSLnpNTe3+th5m3W060FLpXxHg
         pul3dj3PW83LFsD2G6ThgiaBkXHSnvoK+RIhCsjiDysLwOV5z9fW9Km0DB3XYjQ8p+2x
         PKpw==
X-Gm-Message-State: AOJu0YypZ56uScVDR1wn7IWjSJf1Gt8+8/OmctTt0cOPW6oQGezYyOOT
	gtVMnMtvE7l+Y0CGCr4ffrSTVzinEB7n0A==
X-Google-Smtp-Source: AGHT+IHNVwsAFf9yBGNX8pR96hkOXe+RZTCuCe7UPiUmeomRiA2Y0wSWnE2hrjBioJc5Vu7ZxInfAw==
X-Received: by 2002:a05:6a20:5651:b0:187:3709:80ae with SMTP id is17-20020a056a20565100b00187370980aemr19385461pzc.36.1701316898236;
        Wed, 29 Nov 2023 20:01:38 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm187975pfn.61.2023.11.29.20.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:01:37 -0800 (PST)
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
Subject: [PATCHv2 net-next 05/14] selftests/net: convert cmsg tests to make them run in unique namespace
Date: Thu, 30 Nov 2023 12:00:56 +0800
Message-ID: <20231130040105.1265779-6-liuhangbin@gmail.com>
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

Here is the test result after conversion.

]# ./cmsg_ipv6.sh
OK
]# ./cmsg_so_mark.sh
OK
]# ./cmsg_time.sh
OK

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/cmsg_ipv6.sh    | 10 ++++------
 tools/testing/selftests/net/cmsg_so_mark.sh |  7 ++++---
 tools/testing/selftests/net/cmsg_time.sh    |  7 ++++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/cmsg_ipv6.sh b/tools/testing/selftests/net/cmsg_ipv6.sh
index 330d0b1ceced..f30bd57d5e38 100755
--- a/tools/testing/selftests/net/cmsg_ipv6.sh
+++ b/tools/testing/selftests/net/cmsg_ipv6.sh
@@ -1,9 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ksft_skip=4
+source lib.sh
 
-NS=ns
 IP6=2001:db8:1::1/64
 TGT6=2001:db8:1::2
 TMPF=$(mktemp --suffix ".pcap")
@@ -11,13 +10,11 @@ TMPF=$(mktemp --suffix ".pcap")
 cleanup()
 {
     rm -f $TMPF
-    ip netns del $NS
+    cleanup_ns $NS
 }
 
 trap cleanup EXIT
 
-NSEXE="ip netns exec $NS"
-
 tcpdump -h | grep immediate-mode >> /dev/null
 if [ $? -ne 0 ]; then
     echo "SKIP - tcpdump with --immediate-mode option required"
@@ -25,7 +22,8 @@ if [ $? -ne 0 ]; then
 fi
 
 # Namespaces
-ip netns add $NS
+setup_ns NS
+NSEXE="ip netns exec $NS"
 
 $NSEXE sysctl -w net.ipv4.ping_group_range='0 2147483647' > /dev/null
 
diff --git a/tools/testing/selftests/net/cmsg_so_mark.sh b/tools/testing/selftests/net/cmsg_so_mark.sh
index 1650b8622f2f..772ad0cc2630 100755
--- a/tools/testing/selftests/net/cmsg_so_mark.sh
+++ b/tools/testing/selftests/net/cmsg_so_mark.sh
@@ -1,7 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-NS=ns
+source lib.sh
+
 IP4=172.16.0.1/24
 TGT4=172.16.0.2
 IP6=2001:db8:1::1/64
@@ -10,13 +11,13 @@ MARK=1000
 
 cleanup()
 {
-    ip netns del $NS
+    cleanup_ns $NS
 }
 
 trap cleanup EXIT
 
 # Namespaces
-ip netns add $NS
+setup_ns NS
 
 ip netns exec $NS sysctl -w net.ipv4.ping_group_range='0 2147483647' > /dev/null
 
diff --git a/tools/testing/selftests/net/cmsg_time.sh b/tools/testing/selftests/net/cmsg_time.sh
index 91161e1da734..af85267ad1e3 100755
--- a/tools/testing/selftests/net/cmsg_time.sh
+++ b/tools/testing/selftests/net/cmsg_time.sh
@@ -1,7 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-NS=ns
+source lib.sh
+
 IP4=172.16.0.1/24
 TGT4=172.16.0.2
 IP6=2001:db8:1::1/64
@@ -9,13 +10,13 @@ TGT6=2001:db8:1::2
 
 cleanup()
 {
-    ip netns del $NS
+    cleanup_ns $NS
 }
 
 trap cleanup EXIT
 
 # Namespaces
-ip netns add $NS
+setup_ns NS
 
 ip netns exec $NS sysctl -w net.ipv4.ping_group_range='0 2147483647' > /dev/null
 
-- 
2.41.0


