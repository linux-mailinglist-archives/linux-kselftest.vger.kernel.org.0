Return-Path: <linux-kselftest+bounces-523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA8C7F6FAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C023F1C21024
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0BF156E4;
	Fri, 24 Nov 2023 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ14cyv9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5743410C8;
	Fri, 24 Nov 2023 01:29:24 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cf8c462766so10470605ad.1;
        Fri, 24 Nov 2023 01:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818163; x=1701422963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+W+vuIBapZ0u99PcM8Q/dHByTqso+aElvhaTFhqOgwE=;
        b=XQ14cyv9e20k4n/4VovUUF/f/xevcXSw2wGbbZG1ChOCsdlqAdhFqRyEu0aZ/VTPyW
         tmRDi3zJIF8d34XweDM5ZvO4D//L/ME38l0k2Qx4046aE6vpgyRj1Xv6jLJP2fKxmrln
         iRMlqreB8JGTd1kc0X4DTDiDTkbAhWSBze8YQPoecVjX6yGluSUNe+zYo9+xhp/fA52d
         kg+llSUJoJKdmsYPZqlW691e/QK37z/9OJJQlL4wI+zI+jsl6Wq8KzfJwPtPSD26jtX8
         WmxfDoC+9hcxlCzE4ezC1L9fa5PMErjwO+XejGYhD+DAfOJIS5eZkhs3A+OW6EZeH2gX
         qp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818163; x=1701422963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+W+vuIBapZ0u99PcM8Q/dHByTqso+aElvhaTFhqOgwE=;
        b=Co8IpC5igZP2tz16FHXdGjg3jLqNQf5W0OLAjjMhq5i0ufd1DUHjg6DHjvpIb6J+AS
         AxnPXbfB+JoCN9heIWN5IL6CcxQmOLkrBfNbgu0kWXBS/V2rpVrMwEkr6nIoA9RMduLQ
         LWofbnJzxSYscmOwv1jF7o+G5ThZxaUaX4zfurqTP6pUEqa6tiHz6SDTUfZluB5FHUzh
         GL44Sfa/YzgjcV+KE0w6pO6KgMVZ+xGLBuvyQyF9Lzz824Emf9NYh8fkrhSsi3cEOFhr
         Xwlotnf5aWpPBwpEBpvyf85Jec0ruLvRHciXPxYJjbziRpLHNtwbFOOasvcNt5irZw7E
         /FBg==
X-Gm-Message-State: AOJu0YxgtnecMCAX5yM8pffB+q6/w8dYTPpC/Ckrtr7DkF4uo0lMGknp
	5gW0L3F9eta0Oq4ZHnr8BqxVKN4cqexoDYAa
X-Google-Smtp-Source: AGHT+IHzlJYSeXdptbp6PpP4mTf5UaIin0JHGEZTs5rIVv+LzLVDjUxuqN+47tTtQNJ19H0Rfv2iTA==
X-Received: by 2002:a17:902:b608:b0:1cf:8cca:4f62 with SMTP id b8-20020a170902b60800b001cf8cca4f62mr2005418pls.46.1700818163389;
        Fri, 24 Nov 2023 01:29:23 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:29:22 -0800 (PST)
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
Subject: [PATCH net-next 21/38] selftests/net: convert rtnetlink.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:19 +0800
Message-ID: <20231124092736.3673263-22-liuhangbin@gmail.com>
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

]# ./rtnetlink.sh
PASS: address proto IPv4
PASS: address proto IPv6

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 38be9706c45f..3c94faf735a8 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -517,9 +517,8 @@ kci_test_encap_fou()
 # test various encap methods, use netns to avoid unwanted interference
 kci_test_encap()
 {
-	testns="testns"
 	local ret=0
-	run_cmd ip netns add "$testns"
+	run_cmd setup_ns testns
 	if [ $? -ne 0 ]; then
 		end_test "SKIP encap tests: cannot add net namespace $testns"
 		return $ksft_skip
@@ -836,11 +835,10 @@ EOF
 
 kci_test_gretap()
 {
-	testns="testns"
 	DEV_NS=gretap00
 	local ret=0
 
-	run_cmd ip netns add "$testns"
+	run_cmd setup_ns testns
 	if [ $? -ne 0 ]; then
 		end_test "SKIP gretap tests: cannot add net namespace $testns"
 		return $ksft_skip
@@ -878,11 +876,10 @@ kci_test_gretap()
 
 kci_test_ip6gretap()
 {
-	testns="testns"
 	DEV_NS=ip6gretap00
 	local ret=0
 
-	run_cmd ip netns add "$testns"
+	run_cmd setup_ns testns
 	if [ $? -ne 0 ]; then
 		end_test "SKIP ip6gretap tests: cannot add net namespace $testns"
 		return $ksft_skip
@@ -920,7 +917,6 @@ kci_test_ip6gretap()
 
 kci_test_erspan()
 {
-	testns="testns"
 	DEV_NS=erspan00
 	local ret=0
 	run_cmd_grep "^Usage:" ip link help erspan
@@ -928,7 +924,7 @@ kci_test_erspan()
 		end_test "SKIP: erspan: iproute2 too old"
 		return $ksft_skip
 	fi
-	run_cmd ip netns add "$testns"
+	run_cmd setup_ns testns
 	if [ $? -ne 0 ]; then
 		end_test "SKIP erspan tests: cannot add net namespace $testns"
 		return $ksft_skip
@@ -970,7 +966,6 @@ kci_test_erspan()
 
 kci_test_ip6erspan()
 {
-	testns="testns"
 	DEV_NS=ip6erspan00
 	local ret=0
 	run_cmd_grep "^Usage:" ip link help ip6erspan
@@ -978,7 +973,7 @@ kci_test_ip6erspan()
 		end_test "SKIP: ip6erspan: iproute2 too old"
 		return $ksft_skip
 	fi
-	run_cmd ip netns add "$testns"
+	run_cmd setup_ns testns
 	if [ $? -ne 0 ]; then
 		end_test "SKIP ip6erspan tests: cannot add net namespace $testns"
 		return $ksft_skip
@@ -1022,8 +1017,6 @@ kci_test_ip6erspan()
 
 kci_test_fdb_get()
 {
-	IP="ip -netns testns"
-	BRIDGE="bridge -netns testns"
 	brdev="test-br0"
 	vxlandev="vxlan10"
 	test_mac=de:ad:be:ef:13:37
@@ -1037,11 +1030,13 @@ kci_test_fdb_get()
 		return $ksft_skip
 	fi
 
-	run_cmd ip netns add testns
+	run_cmd setup_ns testns
 	if [ $? -ne 0 ]; then
 		end_test "SKIP fdb get tests: cannot add net namespace $testns"
 		return $ksft_skip
 	fi
+	IP="ip -netns $testns"
+	BRIDGE="bridge -netns $testns"
 	run_cmd $IP link add "$vxlandev" type vxlan id 10 local $localip \
                 dstport 4789
 	run_cmd $IP link add name "$brdev" type bridge
-- 
2.41.0


