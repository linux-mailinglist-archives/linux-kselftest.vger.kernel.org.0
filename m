Return-Path: <linux-kselftest+bounces-1008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383668019CF
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 03:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8F81C20BFE
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 02:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1202F184C;
	Sat,  2 Dec 2023 02:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3h/tvaz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90703D5;
	Fri,  1 Dec 2023 18:01:44 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d3d0f862f7so20206327b3.0;
        Fri, 01 Dec 2023 18:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701482503; x=1702087303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGqQWu7PQdA+GXS1NCkG0Hrv8bmQZ7GFfMytHHVX0oE=;
        b=g3h/tvazD4ACSO+y/CoznXDjJTi4O7soNtK2v1lBW7JI3+OzqMk5ia7saopBQ2uXpg
         +lRZThWV0oYoc9DFtpJvATJ9fIGIDGWVyPCb//k3PhOqTHF4LftRhset78bcYGa6sZ2K
         SwPdVFvUjwcgXJJU9SpsyMom7e2/sFtFclraWrw1XiBxhLgK5uYBMiOEsoAc3LDkkMxN
         93xBVPeRGz53cxrwLeTWFX2U48RUCYf0okKFc0vQrD45ROqEMtMkIY3aorOaIOYY2+Eo
         buieRm6YqGW3UTHmhoAZBztSpPaEzlHSTxl2o4SenEkQ0RB0MPVd7gzmADtvYPf0Uxmd
         BK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482503; x=1702087303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGqQWu7PQdA+GXS1NCkG0Hrv8bmQZ7GFfMytHHVX0oE=;
        b=rdBXHsylEWwG5+TcNtVxr0lZ9dyI20xzHZlrao2vvxHn3BuouFtNFMHJvBBIvkcV8t
         dFu1vKYo8OHcCzJM+XlWN4wacuYxRJWgeGz/d7GMNLfxlHtUIEc/jtiSNBpsL29mVtRe
         WljTlcvE0fx0GZZGtHEoSOJuRLTLjDNaFLBOLuLykjsrWEAC6bhRWZvh3QK/QrhL+GGC
         ooDPX/AsfNFgIczIpdXPVqqfQtJOr5uSY+V2VFs7ClBFCLFnju5FUUn5P0UjhDcRNDb3
         SQaynw6QA6bL3MPxomOItUBJOg8zxOz+fe0BT2VBGEdPqsMgEykkj3JnJpvs/SG6LZLx
         WteA==
X-Gm-Message-State: AOJu0Yzp23T58P6JNR2biu8Nsy3kxmalDOzJGcex+KkgsUNeK5Z1q62/
	9qiSghsOsPbBprbMYceulexGoHA52fMmaN5C
X-Google-Smtp-Source: AGHT+IHySo71X+odJULOj2P6h3vn9JfZwX4OamqEg3TqnPH1Lh5cflOedv9bmuFRHEpLEZAzcjtInw==
X-Received: by 2002:a0d:eaca:0:b0:5d7:1940:b371 with SMTP id t193-20020a0deaca000000b005d71940b371mr481514ywe.61.1701482503072;
        Fri, 01 Dec 2023 18:01:43 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001b3bf8001a9sm3993034plf.48.2023.12.01.18.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 18:01:42 -0800 (PST)
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
Subject: [PATCHv3 net-next 05/14] selftests/net: convert cmsg tests to make them run in unique namespace
Date: Sat,  2 Dec 2023 10:01:01 +0800
Message-ID: <20231202020110.362433-6-liuhangbin@gmail.com>
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
2.43.0


