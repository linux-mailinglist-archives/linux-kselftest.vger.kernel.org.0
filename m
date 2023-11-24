Return-Path: <linux-kselftest+bounces-525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BB77F6FB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22FB1C210B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24AD15AE4;
	Fri, 24 Nov 2023 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2dxgjxZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F8B130;
	Fri, 24 Nov 2023 01:29:32 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cf8b6eb13bso10330235ad.1;
        Fri, 24 Nov 2023 01:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818172; x=1701422972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxEV5FzRvRX1x0hhKZITJJ95Qa82xmwC9iIgqcYm5hA=;
        b=Z2dxgjxZ289wqv9A+jE1LQOneeYRDpd4JLDkpl37Gh9vp7sbkBdKqYTb2+F3HuDOuL
         aWN5NdnTHS18H9oEMiTtejRkppozD/1FghWa2zBiKYhcO87k3MR6P5GdEvKW8IRM8/uA
         cw8tcQiDcVlBWt8/nAeOp+ATY2FGygtKrghKSQJYGwsSF0FD6L/I4RHLORGYOqmNgtpv
         q39gN0N5O7+X6WEEV0yuqYCrRohJguezHfqa6vbaJ/Krr5WA2ImSa9448Z40KPHQuRem
         VBCRwxx7AY0QCw8lPJWJCHhYxA674YmEwEYhwZCRUXlEn3RcEw4pzVmlC1qesE2S2qxt
         iIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818172; x=1701422972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxEV5FzRvRX1x0hhKZITJJ95Qa82xmwC9iIgqcYm5hA=;
        b=DuAoRA9dsg0ushGUmJhA3SHVpXsWV/Q5oDa/xZ8s+HaJmKyHDssJKgMPRanflJHYxA
         i8qd9ye4WejZmM+/1bWqzNdZXDL7yNaZN+Tw5qyxma9wy3p9CALi1TN8IxIOnqnaWwuv
         I+rHSc+NLTbktoTzyEZ3ngS4AY20j7OTO1k6yzM4DL4l24XO+S48b3ggGX4LDYxi8Alk
         h8xMmvZHxlsoduLtkHMA8BqImnGX9IMUlqAKZvwkmsQxTjXQej4OiwIELYCh+/b3C8QV
         17ANdkTTztW/z5vSPyynXPF6sS51rsKQ4m00AHckbzEdENb4+Y5HJ6WdsBloXNpih+zk
         uOOw==
X-Gm-Message-State: AOJu0YzN11j62jrqS9Ftr+gqyH4UxSROpjLHFmcmLDTFSACV2z//bGTq
	f4Pfew+oNQaDGLkpoD3mQEatFYWXYXatiK0w
X-Google-Smtp-Source: AGHT+IH3NNo9PU5JTBMjibw6zFpLBlWH5RpJsY3pg3QlPgcfCVVqILizsu/oZeRc3nvxyiVcq6Ob0w==
X-Received: by 2002:a17:902:efd4:b0:1cf:9756:e9fb with SMTP id ja20-20020a170902efd400b001cf9756e9fbmr2038300plb.30.1700818171857;
        Fri, 24 Nov 2023 01:29:31 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:29:31 -0800 (PST)
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
Subject: [PATCH net-next 23/38] selftests/net: use unique netns name for setup_loopback.sh setup_veth.sh
Date: Fri, 24 Nov 2023 17:27:21 +0800
Message-ID: <20231124092736.3673263-24-liuhangbin@gmail.com>
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

rename server_ns/client_ns to unique name so we can run the tests in
parallel.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/setup_loopback.sh | 8 +++++---
 tools/testing/selftests/net/setup_veth.sh     | 9 ++++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/setup_loopback.sh b/tools/testing/selftests/net/setup_loopback.sh
index e57bbfbc5208..6b1150bf3995 100755
--- a/tools/testing/selftests/net/setup_loopback.sh
+++ b/tools/testing/selftests/net/setup_loopback.sh
@@ -5,6 +5,8 @@ readonly FLUSH_PATH="/sys/class/net/${dev}/gro_flush_timeout"
 readonly IRQ_PATH="/sys/class/net/${dev}/napi_defer_hard_irqs"
 readonly FLUSH_TIMEOUT="$(< ${FLUSH_PATH})"
 readonly HARD_IRQS="$(< ${IRQ_PATH})"
+readonly server_ns=$(mktemp -u server-XXXXXXXX)
+readonly client_ns=$(mktemp -u client-XXXXXXXX)
 
 netdev_check_for_carrier() {
 	local -r dev="$1"
@@ -97,12 +99,12 @@ setup_interrupt() {
 
 setup_ns() {
 	# Set up server_ns namespace and client_ns namespace
-	setup_macvlan_ns "${dev}" server_ns server "${SERVER_MAC}"
-	setup_macvlan_ns "${dev}" client_ns client "${CLIENT_MAC}"
+	setup_macvlan_ns "${dev}" ${server_ns} server "${SERVER_MAC}"
+	setup_macvlan_ns "${dev}" ${client_ns} client "${CLIENT_MAC}"
 }
 
 cleanup_ns() {
-	cleanup_macvlan_ns server_ns server client_ns client
+	cleanup_macvlan_ns ${server} server ${client_ns} client
 }
 
 setup() {
diff --git a/tools/testing/selftests/net/setup_veth.sh b/tools/testing/selftests/net/setup_veth.sh
index 1003ddf7b3b2..a9a1759e035c 100644
--- a/tools/testing/selftests/net/setup_veth.sh
+++ b/tools/testing/selftests/net/setup_veth.sh
@@ -1,6 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+readonly server_ns=$(mktemp -u server-XXXXXXXX)
+readonly client_ns=$(mktemp -u client-XXXXXXXX)
+
 setup_veth_ns() {
 	local -r link_dev="$1"
 	local -r ns_name="$2"
@@ -19,14 +22,14 @@ setup_ns() {
 	# Set up server_ns namespace and client_ns namespace
 	ip link add name server type veth peer name client
 
-	setup_veth_ns "${dev}" server_ns server "${SERVER_MAC}"
-	setup_veth_ns "${dev}" client_ns client "${CLIENT_MAC}"
+	setup_veth_ns "${dev}" ${server_ns} server "${SERVER_MAC}"
+	setup_veth_ns "${dev}" ${client_ns} client "${CLIENT_MAC}"
 }
 
 cleanup_ns() {
 	local ns_name
 
-	for ns_name in client_ns server_ns; do
+	for ns_name in ${client_ns} ${server_ns}; do
 		[[ -e /var/run/netns/"${ns_name}" ]] && ip netns del "${ns_name}"
 	done
 }
-- 
2.41.0


