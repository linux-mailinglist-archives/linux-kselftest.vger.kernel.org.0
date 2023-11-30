Return-Path: <linux-kselftest+bounces-874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979627FE80C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 05:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53871282498
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 04:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585DD154A6;
	Thu, 30 Nov 2023 04:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afsamL9a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC61ED66;
	Wed, 29 Nov 2023 20:02:12 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cbe6d514cdso500642b3a.1;
        Wed, 29 Nov 2023 20:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701316932; x=1701921732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwXwo2bsHYodK5pAfM8XhKTV4VE362IGZ5TPU7zEaBg=;
        b=afsamL9aGKxt3dMHbNBTsh91ev3aLi4ioGUtMrnjeFvuxeIDW/JnyEq4vCWDcjVCRA
         mEM4TslHkMMjbUDPvjaibi2lWQhROfeL1gIc4xZvgRGzsapS8x3omZppYl01WIfLJGom
         eZbyiq6nvzpj5MXyHOxv5aZR4cIdgqIkva+l8l3xVaU2PesS5MrS+MtWIZJGpmobAGAc
         sgyCkthtdJfPqmNW+r4evW8DDwAw2TdRxbBWMrkYeiMup5HZs9s/dPAl2WdVuSK7xBT3
         dnq/vJNTj7ap89e4BfpIIlhwTeSkHJlH6lzfAOFU2jEbxLCM5akiTvcirOw6wJmG5kaI
         Dk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316932; x=1701921732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwXwo2bsHYodK5pAfM8XhKTV4VE362IGZ5TPU7zEaBg=;
        b=wr9nlTEBqFnx7BCRyt674F1JitRnWuTZif39zz8LvtZg5Hy3x0E03EyCgHD64l9JHg
         l8VQAkXMMQOgGdaKkIT2Dwfsv+ZSccE+gIIrGDShEasM3Oyh65OJ0DqbbI9IgLYWQQXy
         V8JYrWO6cQEVgCjyfO6rsRx855Vt3unfb3rN+RDu/KREIW2o9ZdMOc5zLFE/uvFOvnUv
         TJWZFyKDZ18WZWuqWbt8QgtdhRYqYEQQKhQG8r3FdOgCN9imtn5qg7m6oNw/FCepfm8X
         ORD3fw0M3Mc2e3ei2TzKBX4Z7t97lEAvu8ffq44crUyQQG+tL9V7huF9IaJJD3uk0wlH
         1+6w==
X-Gm-Message-State: AOJu0Yxb0z9/1ez3hM6W3z34j22jFOmiEdCIs7mIaA+i92FnxwfqPssF
	LLMrICKecl5Yc+zuiPbt4YnuqCtlCoFS6g==
X-Google-Smtp-Source: AGHT+IGD1O3KSFGSu1FTxWiamx7mVgdx0DzQMQRwFbOeuVLChPS3Zj0JcgZtC5yZ+YQzrZ5XBsvYGA==
X-Received: by 2002:a05:6a00:298d:b0:6cd:e1f3:19c1 with SMTP id cj13-20020a056a00298d00b006cde1f319c1mr2268677pfb.1.1701316931830;
        Wed, 29 Nov 2023 20:02:11 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm187975pfn.61.2023.11.29.20.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:02:11 -0800 (PST)
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
Subject: [PATCHv2 net-next 12/14] selftests/net: convert ndisc_unsolicited_na_test.sh to run it in unique namespace
Date: Thu, 30 Nov 2023 12:01:03 +0800
Message-ID: <20231130040105.1265779-13-liuhangbin@gmail.com>
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

]# ./ndisc_unsolicited_na_test.sh
    TEST: test_unsolicited_na:  drop_unsolicited_na=0  accept_untracked_na=1  forwarding=1  [ OK ]
    TEST: test_unsolicited_na:  drop_unsolicited_na=0  accept_untracked_na=0  forwarding=0  [ OK ]
    TEST: test_unsolicited_na:  drop_unsolicited_na=0  accept_untracked_na=0  forwarding=1  [ OK ]
    TEST: test_unsolicited_na:  drop_unsolicited_na=0  accept_untracked_na=1  forwarding=0  [ OK ]
    TEST: test_unsolicited_na:  drop_unsolicited_na=1  accept_untracked_na=0  forwarding=0  [ OK ]
    TEST: test_unsolicited_na:  drop_unsolicited_na=1  accept_untracked_na=0  forwarding=1  [ OK ]
    TEST: test_unsolicited_na:  drop_unsolicited_na=1  accept_untracked_na=1  forwarding=0  [ OK ]
    TEST: test_unsolicited_na:  drop_unsolicited_na=1  accept_untracked_na=1  forwarding=1  [ OK ]

Tests passed:   8
Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../net/ndisc_unsolicited_na_test.sh          | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh b/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh
index 86e621b7b9c7..5db69dad0cfc 100755
--- a/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh
+++ b/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh
@@ -10,16 +10,12 @@
 #    0        1       0  Don't update NC
 #    0        1       1  Add a STALE NC entry
 
+source lib.sh
 ret=0
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
 
 PAUSE_ON_FAIL=no
 PAUSE=no
 
-HOST_NS="ns-host"
-ROUTER_NS="ns-router"
-
 HOST_INTF="veth-host"
 ROUTER_INTF="veth-router"
 
@@ -29,11 +25,6 @@ SUBNET_WIDTH=64
 ROUTER_ADDR_WITH_MASK="${ROUTER_ADDR}/${SUBNET_WIDTH}"
 HOST_ADDR_WITH_MASK="${HOST_ADDR}/${SUBNET_WIDTH}"
 
-IP_HOST="ip -6 -netns ${HOST_NS}"
-IP_HOST_EXEC="ip netns exec ${HOST_NS}"
-IP_ROUTER="ip -6 -netns ${ROUTER_NS}"
-IP_ROUTER_EXEC="ip netns exec ${ROUTER_NS}"
-
 tcpdump_stdout=
 tcpdump_stderr=
 
@@ -76,8 +67,12 @@ setup()
 
 	# Setup two namespaces and a veth tunnel across them.
 	# On end of the tunnel is a router and the other end is a host.
-	ip netns add ${HOST_NS}
-	ip netns add ${ROUTER_NS}
+	setup_ns HOST_NS ROUTER_NS
+	IP_HOST="ip -6 -netns ${HOST_NS}"
+	IP_HOST_EXEC="ip netns exec ${HOST_NS}"
+	IP_ROUTER="ip -6 -netns ${ROUTER_NS}"
+	IP_ROUTER_EXEC="ip netns exec ${ROUTER_NS}"
+
 	${IP_ROUTER} link add ${ROUTER_INTF} type veth \
                 peer name ${HOST_INTF} netns ${HOST_NS}
 
-- 
2.41.0


