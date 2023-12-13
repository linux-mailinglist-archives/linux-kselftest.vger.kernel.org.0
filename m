Return-Path: <linux-kselftest+bounces-1807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09788109EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 07:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B721C20AD9
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 06:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82895FBE5;
	Wed, 13 Dec 2023 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL7yxTHA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1DA83;
	Tue, 12 Dec 2023 22:10:04 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b9f8c9307dso3595060b6e.0;
        Tue, 12 Dec 2023 22:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702447803; x=1703052603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buvPtnR8AFIJn0EUsyN8HoYPJLQ+S82rOr7SY6NXD9c=;
        b=XL7yxTHAb9cD4JKL5hdA5ForCajTSkH1LwXELdWXFOHzjFWz4UkakXbthw1gtmi9os
         vDMmdKVO6jtE/k3mCTHz5JzqrGUxLF+dW18RqcH1zSpX7DN4rULeXtsu+49GNkJeV6xI
         pCLJRZqDVTTaKkPvPCpoMdjROykAAPopeM2V4t6Qt+WpmnYziy0xH0jwZcpyNyxA4a/W
         FUuzasqllv3W+dhKMRVaZQn3VbReUblypXKxZZtNSLvEVefFBYatWnwFyTmqkbUiVIvF
         o/Ed3FuSfKAocBE3UatWQ68P476f27ilLTKGrlVNe54ix/iTfNHKzsP29a7EWB/jaUGd
         SrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702447803; x=1703052603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buvPtnR8AFIJn0EUsyN8HoYPJLQ+S82rOr7SY6NXD9c=;
        b=j1uWyyG+sOeD5KUJ0tW8VVMv+mqvnK7dWaDklvE/IsXoQ/uE6GdTD5m5m1eHKDyJWF
         BBP7QVWJg9kFrfONSwjCyj5mjBmbPzCv6+1Xsi9pDge27kk4ZwJ137VpeIUokBpfO+JD
         llqkCcjgT0xROnj/MThClVGED67/eBM8+c7rsNbWHzxV0UtzBWSRFUj6Xqwkd/6AAn0x
         wJQ7ZVyg6MmbqB53YxUvzFCxq7mIPWlf8XiReSP+BGCmzU6UmCQTRfJLoWwWN60F2TZp
         c9jUGOBi3nXBihGFq82FV9w7N+y/D4pL3xsBd/KgKhEi0S4btQhCa7m1wFQWlalv2agx
         icxw==
X-Gm-Message-State: AOJu0YwcDB+97d8aWDDrva8fIJx51CHCjgAZx0JCXssaS8GF9vnXlbS0
	fW4kolvsgFpKKpdFPLbTX3iy8K6BZqZzrMsERFA=
X-Google-Smtp-Source: AGHT+IEI3tJ63gjoAa2Tv5qGQDk9xL2QsrUWkLRykC1IXf15yDvdj+S62FE668jMrIBmvWIdKWbcjA==
X-Received: by 2002:a05:6808:f09:b0:3b9:d5e3:8f28 with SMTP id m9-20020a0568080f0900b003b9d5e38f28mr10049000oiw.57.1702447803217;
        Tue, 12 Dec 2023 22:10:03 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kq9-20020a056a004b0900b006cef5e5a968sm6890084pfb.201.2023.12.12.22.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:10:02 -0800 (PST)
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
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Amit Cohen <amcohen@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 13/13] selftests/net: convert fdb_flush.sh to run it in unique namespace
Date: Wed, 13 Dec 2023 14:08:56 +0800
Message-ID: <20231213060856.4030084-14-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213060856.4030084-1-liuhangbin@gmail.com>
References: <20231213060856.4030084-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.
 # ./fdb_flush.sh
 TEST: vx10: Expected 5 FDB entries, got 5                           [ OK ]
 TEST: vx20: Expected 5 FDB entries, got 5                           [ OK ]
 ...
 TEST: vx10: Expected 5 FDB entries, got 5                           [ OK ]
 TEST: Test entries with dst 192.0.2.1                               [ OK ]

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/fdb_flush.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/fdb_flush.sh b/tools/testing/selftests/net/fdb_flush.sh
index 90e7a29e0476..d5e3abb8658c 100755
--- a/tools/testing/selftests/net/fdb_flush.sh
+++ b/tools/testing/selftests/net/fdb_flush.sh
@@ -5,6 +5,8 @@
 # Check that flush works as expected with all the supported arguments and verify
 # some combinations of arguments.
 
+source lib.sh
+
 FLUSH_BY_STATE_TESTS="
 	vxlan_test_flush_by_permanent
 	vxlan_test_flush_by_nopermanent
@@ -739,10 +741,9 @@ bridge_vxlan_test_flush()
 
 setup()
 {
-	IP="ip -netns ns1"
-	BRIDGE="bridge -netns ns1"
-
-	ip netns add ns1
+	setup_ns NS
+	IP="ip -netns ${NS}"
+	BRIDGE="bridge -netns ${NS}"
 
 	$IP link add name vx10 type vxlan id 1000 dstport "$VXPORT"
 	$IP link add name vx20 type vxlan id 2000 dstport "$VXPORT"
@@ -759,7 +760,7 @@ cleanup()
 	$IP link del dev vx20
 	$IP link del dev vx10
 
-	ip netns del ns1
+	cleanup_ns ${NS}
 }
 
 ################################################################################
-- 
2.43.0


