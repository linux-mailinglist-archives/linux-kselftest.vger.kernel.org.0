Return-Path: <linux-kselftest+bounces-1516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654C180C615
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 11:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E7A1C20BE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B32E2D63D;
	Mon, 11 Dec 2023 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW5TJsPi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC20E8;
	Mon, 11 Dec 2023 02:10:24 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d9d0d0e083so3411118a34.2;
        Mon, 11 Dec 2023 02:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702289423; x=1702894223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMa41XF+hwSqPxO7tGAD0COLCNlUqX7ebtlUkJcEZus=;
        b=aW5TJsPiKtHapUqYbfqJKGm+XDD17F5A7l+lQX/bKA9fB9QKB0TCNuUAU9eZWmPDYL
         A86i8PlyYUj2niUXv3ZexH/TpbXoCymrS+Vx4QCremumJUeeMWIjc8jb1qZISUbSJllx
         +7lWDEvoKRcNSBIqiYfAII6Vo3+DXc9BmMDoFHWVnBAn9JTHhJ0zW3KEf6AsbuG21zi0
         49UBTmL7offUnhZgWL+pk9dnSifKuQtRoUn+UpH//AyOdcaSSEwWH/2wcKsAnDUOey1D
         U+twj1pD/a7q8PKvGNFCfkRh4GuogtaDHKRDqWz2dubqD36DdKXDqtuMYx6oF8MrH39R
         bq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289423; x=1702894223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMa41XF+hwSqPxO7tGAD0COLCNlUqX7ebtlUkJcEZus=;
        b=vBf3/y/ks7gEJoE1C9q6a6uNKKXlFpaafAVWg80CmmNruyW5hXk+3ivRsWErD6CKUf
         GSEMNfJ8KV+QevNOEDPo793CgPv8VbyrzYDvkzyopSw8f0yseJT6ttVMYRtg29DOG12V
         OYLWltLdI8kwF55fxp5wQr5z4T9kZKoDscKXMv0QR51hTKiY6PLM2ekmJbKvuD8HBErE
         f3CamofhW605rKzpDQTNiD/mtZI6EYlUSbL4D/b8C5bEY0F62frSLuSVA45L/AhYIifZ
         09nv3CQ4vPCpEq4G7lh3ycCcbRtFKFQBh9vvilSWQSCa1msbfsQ8Ct5nl9a8g1QoLrwd
         XVHQ==
X-Gm-Message-State: AOJu0YxJzOK4QxabTscT/7+ia/Q4TxoyWn/kcN6JOXsof9Jd6F8fFDL9
	piPBGyJ/f1pcroNKxg0B2hVEa8bJT3O7JdIn
X-Google-Smtp-Source: AGHT+IGNwz6Ri5YdJZWQ7k5JV2hte+Ad5Nvgw0lSu5rj9IzMjD118mwcN9SHQ4/hM3hF8aigD4orPg==
X-Received: by 2002:a05:6830:1e83:b0:6d9:a60e:e3e5 with SMTP id n3-20020a0568301e8300b006d9a60ee3e5mr3494242otr.35.1702289423510;
        Mon, 11 Dec 2023 02:10:23 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b005c2420fb198sm5151733pgv.37.2023.12.11.02.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:10:23 -0800 (PST)
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
Subject: [PATCH net-next 13/13] selftests/net: convert fdb_flush.sh to run it in unique namespace
Date: Mon, 11 Dec 2023 18:09:25 +0800
Message-ID: <20231211100925.3249265-14-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211100925.3249265-1-liuhangbin@gmail.com>
References: <20231211100925.3249265-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.
]# ./fdb_flush.sh
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


