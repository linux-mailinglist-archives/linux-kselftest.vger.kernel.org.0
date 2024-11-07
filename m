Return-Path: <linux-kselftest+bounces-21639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9729C0D9E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D716B286354
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFBA21A4B1;
	Thu,  7 Nov 2024 18:12:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15241219C9A;
	Thu,  7 Nov 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003150; cv=none; b=Iqp1jvkQ0ayRmopIx5EKxeE5IKcpq9WVne8Dfaajlo8uU64sk/TtClaWJq4LBKlWfLmx4kfslHXIdCOhyGLlYIntU94aZDNnR2zK0tTuu9fdiRTnO/OLLUNktiVzojmDw3qLywA8U2H1pxDpY/CAnmn2UJmcDZFWfG+a9CXSFjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003150; c=relaxed/simple;
	bh=QNIVoaUG6HoJ02+8aCHTzhZtbDvKJFEGC7k27W7G0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqdaVlJNdiWvkKbpq2CD/tCtAwfNOKsFd3NAFYbNZhug/xnl5UJAnZs8PPStyjRnsQcyO1hoXdGLKYtGCgEG6zmX7jm7EpoTFF/SUZv44aNt64sKz6tn0pRfm66pefxqIyut8wc1bBsNLn0Fyu33iKMexdq3WyCM4UeUfMcXmrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71ec997ad06so1007038b3a.3;
        Thu, 07 Nov 2024 10:12:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731003148; x=1731607948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLuAo808h43hPUqDZon7CMUoTgxLTq7GJOn3Y6RziyQ=;
        b=qNhE4YRfShJkdt2GI/0tkrKLcEcEwniPhDcX9YpyZao5z7jpq5++XE+Pfymxr9X+a2
         jpuDUhJH2Wjhe7OXw5fGWFUZjIGRtFXIOmZLrRnSyetTk+sQIN6k2sK+OSfNHV9M+KNa
         DpUKlbO2Z8ldpNREdAR9E1/fjajEfM1HlJcVEZVeF2ImYjRPZbvhUn+dhNTpBJjUR4Vn
         CHeZlOMyfX8LCV1y64pjkYYWBhh7pQ9Lpg4iG9SLDZntX7Y+gYfd1MrOJofFjScF+g3B
         z5Cil8GsnfGXiISD9+SHKCV9roDV6r50WYNdoihsk+S1FW1+PNG+s2/yh0xMWYQgSzgn
         xBlg==
X-Forwarded-Encrypted: i=1; AJvYcCW5+UjBUVPbxxn3f/9XuQU6dKw1C5oEpyj6QNAXbjhlK1N7ZkRfERrg4IcYqzpVtK4nHZGq4E6Vtw9NMhw=@vger.kernel.org, AJvYcCXZJ8WHvh9YiGe8NcMSper6mD8gYBlyJWEnyG07nW84amCxcvt476RvgbkAN1EwmhUF5jCt1JzRNSyZeRT5oLLg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Qwtf1+1PsQL3To8D12eSYEyPVH8LdU6RkmEKhDYM591xq7xG
	Z7MEc8XjN3RDTOf55DWR5kM8g0pYoGu8bP94GF/59tbPpEaLdJjBhnr9
X-Google-Smtp-Source: AGHT+IESI5ADNbsaRUr7r3ros762SVgz2pZbG8VO9M6J7g7TP8uIBZYhDBr0hDVOk+2GV2slkwIgQA==
X-Received: by 2002:a05:6a20:a913:b0:1d9:29ab:9b49 with SMTP id adf61e73a8af0-1dc1e4d388amr898810637.32.1731003146542;
        Thu, 07 Nov 2024 10:12:26 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407860a4dsm1940874b3a.29.2024.11.07.10.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:12:26 -0800 (PST)
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
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com,
	jdamato@fastly.com
Subject: [PATCH net-next v8 11/12] selftests: ncdevmem: Move ncdevmem under drivers/net/hw
Date: Thu,  7 Nov 2024 10:12:10 -0800
Message-ID: <20241107181211.3934153-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107181211.3934153-1-sdf@fomichev.me>
References: <20241107181211.3934153-1-sdf@fomichev.me>
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


