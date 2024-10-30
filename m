Return-Path: <linux-kselftest+bounces-21119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C169B65E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B9D1F24D87
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3851FA252;
	Wed, 30 Oct 2024 14:27:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C431F9A9D;
	Wed, 30 Oct 2024 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298461; cv=none; b=MplyaZUdUUQe+m6Djl4GKlVTcvln9HqHtAWTRI/8PFuRy6cM7GAFSUROnbSInkxSSRZa1bhjq9DMsgpkd/ytkmvEVr017i7D1p2G2AWt4/3cZhpCctx27JJIPA2jLfXXdEGz9pflM0Kv4PVlSsWsFAVPpLLL++edmuI0pfa6bs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298461; c=relaxed/simple;
	bh=QNIVoaUG6HoJ02+8aCHTzhZtbDvKJFEGC7k27W7G0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMUJH52Pfk3wavjmY7FYaqgFdLYRE7/qEAMBtmTMTbQ9j3tEN33PRhfp8DAUGP/E7AjnIA/Vz919KTdsYKBns67F/A9FWku29fkJrFpbiSUnvuMkOdSnWcrxLXt+a38lQ2vSreoXqXbfo1U1cx99bD9Kq5NEfIZsF0yKhhx+uPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-72097a5ca74so1469947b3a.3;
        Wed, 30 Oct 2024 07:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298458; x=1730903258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLuAo808h43hPUqDZon7CMUoTgxLTq7GJOn3Y6RziyQ=;
        b=WUBl51PIWHVHrmbGViOSBnJ9z0IujCuJ9Z1aWio0q0UuNzKDfXc00grDf1UJe489LD
         1814p3zqrgzNRjp2u+41JtM8/rPnjkrjOY/QREjwDbtKX+laYZu1XRzqxvPRDHEic24L
         SqPpRXyrKE5jlND+65hXUkKKkdaPSCA60cQut0DSvuB9mwwutV98bbLPM3qAgLEBhXla
         W2qU4fE7uZuHrr5zkOuvWMFnBs7w3GcI3qrCsgn5CNHK2/KUYUZPBeDHyFWkTos1gTWy
         D6DlH+WeYbTXX3QnSvJ0nSAeaVbUpQJ3Zrk2TuUlmd1fBlC8Efrari3jH4gDz+xTZTx6
         MOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNg7WRUd0la24Ikte/RXOD86+k1y/P7E9vWlCtCUo2a3tNtxdd1qhhiwLTlB/UqxZgEurHdY8GpjA3344=@vger.kernel.org, AJvYcCVlZPIEtRQG7nfpNgbJLIl8piBriAyU2iJDDW/J4fE2QKoGevdfR7JG8HqzNnF7x+iYpcXMofcBFPLkToebWRmu@vger.kernel.org
X-Gm-Message-State: AOJu0YzGaFA3nvpmNtcFJonnbwiO89dqrhAJxaW6tq86tzo3f7Pn7Ni/
	+2cm/HMfbVyv4arGfIbotsJ7JQcgok9etkw1/HsFGavmdG0him+DGa/nc1Y=
X-Google-Smtp-Source: AGHT+IGESpx2DY1HGdcUopbjIVIaRxqP0Rfsk2Qrsm0ApMsyz45s7oVrRnqsp+St8+IrdHSqrYtw1w==
X-Received: by 2002:a05:6a00:1884:b0:71d:fe19:83ee with SMTP id d2e1a72fcca58-72062f8f29bmr21410627b3a.10.1730298458200;
        Wed, 30 Oct 2024 07:27:38 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1eec0sm9596351b3a.143.2024.10.30.07.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:27:37 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	horms@kernel.org,
	sdf@fomichev.me,
	almasrymina@google.com,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v6 11/12] selftests: ncdevmem: Move ncdevmem under drivers/net/hw
Date: Wed, 30 Oct 2024 07:27:21 -0700
Message-ID: <20241030142722.2901744-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030142722.2901744-1-sdf@fomichev.me>
References: <20241030142722.2901744-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is where all the tests that depend on the HW functionality live in
and this is where the automated test is gonna be added in the next
patch.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/hw/.gitignore         | 1 +
 tools/testing/selftests/drivers/net/hw/Makefile           | 8 ++++++++
 .../testing/selftests/{net => drivers/net/hw}/ncdevmem.c  | 0
 tools/testing/selftests/net/.gitignore                    | 1 -
 tools/testing/selftests/net/Makefile                      | 8 --------
 5 files changed, 9 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/.gitignore
 rename tools/testing/selftests/{net => drivers/net/hw}/ncdevmem.c (100%)

diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
new file mode 100644
index 000000000000..e9fe6ede681a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/.gitignore
@@ -0,0 +1 @@
+ncdevmem
diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index c9f2f48fc30f..182348f4bd40 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -26,4 +26,12 @@ TEST_INCLUDES := \
 	../../../net/forwarding/tc_common.sh \
 	#
 
+# YNL files, must be before "include ..lib.mk"
+YNL_GEN_FILES := ncdevmem
+TEST_GEN_FILES += $(YNL_GEN_FILES)
+
 include ../../../lib.mk
+
+# YNL build
+YNL_GENS := ethtool netdev
+include ../../../net/ynl.mk
diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
similarity index 100%
rename from tools/testing/selftests/net/ncdevmem.c
rename to tools/testing/selftests/drivers/net/hw/ncdevmem.c
diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 217d8b7a7365..a78debbd1fe7 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -18,7 +18,6 @@ ipv6_flowlabel_mgr
 log.txt
 msg_oob
 msg_zerocopy
-ncdevmem
 nettest
 psock_fanout
 psock_snd
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 759b1d2dc8b4..22a5d6a7c3f3 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -97,10 +97,6 @@ TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
 TEST_PROGS += bpf_offload.py
 
-# YNL files, must be before "include ..lib.mk"
-YNL_GEN_FILES := ncdevmem
-TEST_GEN_FILES += $(YNL_GEN_FILES)
-
 TEST_FILES := settings
 TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
 
@@ -110,10 +106,6 @@ TEST_INCLUDES := forwarding/lib.sh
 
 include ../lib.mk
 
-# YNL build
-YNL_GENS := ethtool netdev
-include ynl.mk
-
 $(OUTPUT)/epoll_busy_poll: LDLIBS += -lcap
 $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
-- 
2.47.0


