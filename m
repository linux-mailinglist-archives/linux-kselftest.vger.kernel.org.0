Return-Path: <linux-kselftest+bounces-512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655FB7F6F99
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974641C20FB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9990B11735;
	Fri, 24 Nov 2023 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZO0+D55m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB652130;
	Fri, 24 Nov 2023 01:28:37 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cf897c8de1so11798775ad.0;
        Fri, 24 Nov 2023 01:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818116; x=1701422916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rDIyIjW7InYsnd3Wg+5oPFz4x95H0ItdlKnmaVR4J8=;
        b=ZO0+D55m0AOiH+mHQBdiEFr+pHsrg8j1FBiJitxfIV0p8RB+AsNJnnzjfLtChdlJEO
         9EW2X8NJAQyvI0qJv2F+bMCUrwFSoQAzBw/cq/PgTn6pK1vDfR8vksXTZQUgH6xuUBlL
         UF615u9sbw2vcrImgwHkKhsQ07vGJZN+zuYtpx8XYGbBMyC9wcK27j8v9jsNCaLj6ny3
         P24Lhu3hlSeEjVyRBPYtrwQffTg4F20TrmdDLLJU9ZMYnszCDy541MZ/SA+jzcRo4rmU
         Zazz8sUFxbp/rLv+2pStbNQ3mD5o9m6jddBwT6Tw3gMvJwhEkUObdTNcN/0hhwfnX3Pg
         nkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818116; x=1701422916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rDIyIjW7InYsnd3Wg+5oPFz4x95H0ItdlKnmaVR4J8=;
        b=Bsm4ftUl/jtspsXhmh7t+H1XgBlk0+ivC8QfKs2hd1qMZnE/XG/7c0JfKYg6Qo+SJn
         x5hqa2a+9U55ekET5Zz8bcpKZw3fq6Nx6SZv9YD7TQIuSWRAZLKyJYpDGxXx3pgynf+x
         gja2Uf6Np6AZPxABBQFxOhwBzZk8YppsiJbISnsdUJuEeFKwd8Sj4me6lZ4JZp9xGCij
         qbTQUdLGNKkGhkSS+949+XxZnJV2WM9aeDK+CZCMM80a6oCeeJdabzYeEbzbW6cRQJRw
         ignQ29Oe9GHc5uW5fKi230XK1p3SsTreBSmkr6X4qtMk+MrppuRvqGz9OVNiFeCkqS18
         KBYA==
X-Gm-Message-State: AOJu0YxH5kiFGjhbRV2b5TVzjxiQbmTtIOZRSLrZHPC/xU6tUrAhDcrj
	QDhw7Sst9JgE2O/EGRn/JM5sQAbKc1HlIM0/
X-Google-Smtp-Source: AGHT+IFYr3xhBbVEzUnP2+2taUxozgqIB/nLk0w/UekEpqoPH70jQNdF09ThDb3tK6gwcirRNTmP6g==
X-Received: by 2002:a17:902:ea07:b0:1c9:e0f9:a676 with SMTP id s7-20020a170902ea0700b001c9e0f9a676mr1894882plg.6.1700818116625;
        Fri, 24 Nov 2023 01:28:36 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:28:36 -0800 (PST)
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
Subject: [PATCH net-next 10/38] selftests/net: convert fib-onlink-tests.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:08 +0800
Message-ID: <20231124092736.3673263-11-liuhangbin@gmail.com>
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

Remove PEER_CMD, which is not used in this test

Here is the test result after conversion.

 ]# ./fib-onlink-tests.sh
 Error: ipv4: FIB table does not exist.
 Flush terminated
 Error: ipv6: FIB table does not exist.
 Flush terminated

 ########################################
 Configuring interfaces

   ...

     TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]

 Tests passed:  38
 Tests failed:   0

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/fib-onlink-tests.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/fib-onlink-tests.sh b/tools/testing/selftests/net/fib-onlink-tests.sh
index c287b90b8af8..8b04f8282480 100755
--- a/tools/testing/selftests/net/fib-onlink-tests.sh
+++ b/tools/testing/selftests/net/fib-onlink-tests.sh
@@ -3,6 +3,7 @@
 
 # IPv4 and IPv6 onlink tests
 
+source lib.sh
 PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
 VERBOSE=0
 
@@ -74,9 +75,6 @@ TEST_NET4IN6[2]=10.2.1.254
 # mcast address
 MCAST6=ff02::1
 
-
-PEER_NS=bart
-PEER_CMD="ip netns exec ${PEER_NS}"
 VRF=lisa
 VRF_TABLE=1101
 PBR_TABLE=101
@@ -176,8 +174,7 @@ setup()
 	set -e
 
 	# create namespace
-	ip netns add ${PEER_NS}
-	ip -netns ${PEER_NS} li set lo up
+	setup_ns PEER_NS
 
 	# add vrf table
 	ip li add ${VRF} type vrf table ${VRF_TABLE}
-- 
2.41.0


