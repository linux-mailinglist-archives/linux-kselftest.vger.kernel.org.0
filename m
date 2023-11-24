Return-Path: <linux-kselftest+bounces-522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0017F6FAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97F3281D5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7893D156EB;
	Fri, 24 Nov 2023 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKEFEO0Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C62D46;
	Fri, 24 Nov 2023 01:29:20 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cf69f1163aso13006745ad.3;
        Fri, 24 Nov 2023 01:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818159; x=1701422959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8qy5d6vX1oFzokIRswxWxFO1Dk2aaDmxe7cNhFefY4=;
        b=FKEFEO0ZxQTwCodnwzhK5ta7oQLo4gBIG3k6xneDHz1bUimHt4c+NAQE/FqqC/naTe
         Sd+L85CbI9j0gZjGd/xgl/sNzxg8K9/3vj8/+rf5D2djvofTYFe/VnNbbdTB8QJZcEa+
         DkwPCJ7Jf+u1MY/kupx0CqnuBjQI57oNCqriXuBeWCwKcfWx1gDiZ+Xqa7vJDFVayjEh
         qI3HPZy9W0v6mr1Ht2UvkBXtu2J5jFWjZCV8Rp/9VbKdj+OY9zv9p4YsqY06L9nykLYX
         EXLbTZOEjS0WtNxHsaTtks0pzOsuTnpH5HKK5XVY5DT2t5E4CPPraLe7XL8M+TMqbsZm
         gIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818159; x=1701422959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8qy5d6vX1oFzokIRswxWxFO1Dk2aaDmxe7cNhFefY4=;
        b=ejH7saurppCVvhQrh6yPS0Tf3kxvQFpQplbyoljDKcb+EMfTTc3SUVE2aAR6jRa9ra
         C4ULEH9cE5d04HsSUktaAzfHNdQ8p2qellxIetT2cs31zol9OsAJ8MF7kvvGai7A7Pa6
         kFrEvzFLZ5rr3bv6hWBSPFLGXQFr07SsuyoJAuUfZoh84/EfZqXiA2r/7uL5iK7hXC4T
         oC2PkqHRxCrfbtVnzrIjhSAzZ+sGbvwT4VxMKH6hvfQUYe+Mb/hE7p7Mb/uR3lri5yaL
         UJvtXwMLvNmiyrYPU9jV25YQQNDMPdZAF93Y9BlKA3pVQrk9OBK/IH/kcvWOeecSnZ0s
         bHmg==
X-Gm-Message-State: AOJu0YyVPyZUaYmz48t+oPujFn7RuU64TRgp2lF4lnorQzyCm6/iAlyR
	8b+nlXWCvk+RFAQkENcYI1DslKgJhMM0DYy8
X-Google-Smtp-Source: AGHT+IGP8yQGzR4CfSMeurXWxnurwQ3+EXgo2k1vd6m3HWtuBsatffLxOcmWeZS/SJ1tIkD4v9bsrQ==
X-Received: by 2002:a17:902:ac87:b0:1cc:5a1c:3da0 with SMTP id h7-20020a170902ac8700b001cc5a1c3da0mr1855710plr.63.1700818159191;
        Fri, 24 Nov 2023 01:29:19 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:29:18 -0800 (PST)
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
Subject: [PATCH net-next 20/38] selftests/net: convert fdb_flush.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:18 +0800
Message-ID: <20231124092736.3673263-21-liuhangbin@gmail.com>
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
]# ./fdb_flush.sh
TEST: vx10: Expected 5 FDB entries, got 5                           [ OK ]
TEST: vx20: Expected 5 FDB entries, got 5                           [ OK ]
...
TEST: vx10: Expected 5 FDB entries, got 5                           [ OK ]
TEST: Test entries with dst 192.0.2.1                               [ OK ]

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
2.41.0


