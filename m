Return-Path: <linux-kselftest+bounces-506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0B37F6F8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748F3281D61
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5D7F9C4;
	Fri, 24 Nov 2023 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1Qo96lf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51738D72;
	Fri, 24 Nov 2023 01:28:11 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cf6a67e290so13030285ad.1;
        Fri, 24 Nov 2023 01:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818090; x=1701422890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tHrBKQwDCBtq97JwzbfKivUyT18wtXUTxsIBh9TE5Y=;
        b=d1Qo96lfIjjA13CJ7z4VLfW0pdEk3LV7Yp63iYKA+H6v/5LXgZkIgtPMo8PcEE+1/N
         cXjfibKA81mQdIhDrUw5pGoVFIYlgyPILkG0Gu0S8nnReWOLKbc/QorSZktqSkzJy4QP
         VjEWKvQwvO5G+cKOTPDuGyVrkpD3PLfV8PygNVOBiRH0ENJJ9N3qkwQSj5xZNs35NsjX
         y/NROZMoABYRXF4WcG0DblTE34z1Td9jnZLjBxmvUnx5AikUjElxziKEnDsoMCr7CDr8
         GLh1U7e11it9IWzz7YjPuB4Lv+2d+vf42q9gSQxEjMrEniez+UufJR67IJ11lkj3cu7e
         fbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818090; x=1701422890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tHrBKQwDCBtq97JwzbfKivUyT18wtXUTxsIBh9TE5Y=;
        b=KA0IO6VkdrvZ9fncdoEUnR13PrxH5fuX4eByFKWiOABWZ+RqNe557/rjAFRDl6llta
         FDsIEO8aw65u7vKQNt1JPJ+61U5k6K39zXHtCg+T/2qsyXuJO+tDT5QWGf7C/twaTJV9
         7dV2mA7261uXebpgovi0jtyF2eUydGMgkJARGIR8ElrIFsq0ylB7zV3XW/CkPm1uH16D
         /nJBbj/zPgSbq5BPUvZZzB8xYmkLHise7V94ZHavvxKunvQqT1TPgTHMacTpsYuVGQIj
         9lC62YDSo+9Fsr8BPbnUt7ATYO3wbuJIYb7yufksJh8om84DOhtRtWg1TJ83iORKtZxW
         4NRA==
X-Gm-Message-State: AOJu0YybdTdooCERO0JaUBnmDCIBZGeuW7a3t1Xykxy3S8rNYghRc4w+
	ZLaEmWhw6hKZjkda8n1pRQilRAaMp/jrKlqx
X-Google-Smtp-Source: AGHT+IHvXxpCPzY1aLVjoPuROtBP/WytHaTYnBk914+0IrgU2L0X44uQf810eTzhivAkNnUzBUsvYg==
X-Received: by 2002:a17:903:18f:b0:1cf:591c:a8b1 with SMTP id z15-20020a170903018f00b001cf591ca8b1mr2319355plg.15.1700818090126;
        Fri, 24 Nov 2023 01:28:10 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:28:09 -0800 (PST)
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
Subject: [PATCH net-next 04/38] selftests/net: convert cmsg tests to make them run in unique namespace
Date: Fri, 24 Nov 2023 17:27:02 +0800
Message-ID: <20231124092736.3673263-5-liuhangbin@gmail.com>
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

Here is the test result after conversion.

]# ./cmsg_ipv6.sh
OK
]# ./cmsg_so_mark.sh
OK
]# ./cmsg_time.sh
OK

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


