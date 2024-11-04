Return-Path: <linux-kselftest+bounces-21404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C139BBD26
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 19:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF133284447
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70DA1D357B;
	Mon,  4 Nov 2024 18:14:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217DF1D2F46;
	Mon,  4 Nov 2024 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744088; cv=none; b=OwL5ag2aE1r6oH1iXICr2xgSW2mxKFvyuABuGTe7/f2u5mA+FiG+4DzqRZn23uSKnE0OUIoGr0yzBsGrKIdrgWq1u4heJR4/JzuxUojJTC7n0g+LlOxmeR+FSUj20dxM4ERbSgUZfW8y16xANcYVXtevTYpdd/RWiSe8bL5062A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744088; c=relaxed/simple;
	bh=QNIVoaUG6HoJ02+8aCHTzhZtbDvKJFEGC7k27W7G0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKwA8nWgpvps6gu7KChu1NduMB0mlhTUjWBTAPAZcGUhpP+bpXDw3IVPaPrZVgPN3XuIfGA5FizM020Ito/hFx7LuNQvxsbxy/HcPSviZQjPxxo7g09VlkqkCQEopJGUzwarksNSnxsR0HNw97if0QyUpcqdgpXONcWtXz/Bnhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so906952a12.2;
        Mon, 04 Nov 2024 10:14:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744086; x=1731348886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLuAo808h43hPUqDZon7CMUoTgxLTq7GJOn3Y6RziyQ=;
        b=V7BUVwRCzrwoOUGuTr5iwj8TcOcBQuQ3hsS7eCzADNBxJ6bA0L7Lu2sAhquxhZo7dZ
         op8VE+ljfFunw/9DmqRBEail3/rR+8dbXhyk+4ExyG/Y00U5o2ZqHWtgyFHB1uxeo4no
         nd9ZmgmnnLJQdbaWcyr6SoRW5JLsrDrqFJnRYP7MFsY8potVbvcqEXuJLeV8ZhIcEC/y
         Tnsx2vXb4sNkWPgpE/bnvgh27ksazn6vav/IeZf13qObWLS2o/jvoWdoUhGBr1iLRZT1
         aPN595EoSnTBpOethLgi4GHgHBDotQJBObsH8pxa8U4Q7z+s6x7eBE71qxOKq3UY3/7/
         T1sg==
X-Forwarded-Encrypted: i=1; AJvYcCU86a1WO4smjiqezl/1h6cA/dmMDThOjnsaHtSQAPC4LkjxTzKr1oN81+LwL1NGEfowqQXjEJTDwhQpMwn8Al60@vger.kernel.org, AJvYcCUoZ7JfBjb89XITL/qs/V6uIJtydVE6Drj2uE3veVsisMMleC6ZjMV5OREyuWpI5EP27VHeMCZOuCsGlCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9U6aWhrl1Cr53DVpPvrXelXZPuo92PAe+hbZHBXC07UmAV+S9
	TggFu5aj0CpI2xUrsqXOiGIGt9A8VRySPME4tOKPLE/UEFBCgVya3YUV
X-Google-Smtp-Source: AGHT+IEoedDGOdcqJ0GvHtkAY26FM1JkHU82vYr/QOukdj6TBBejk+u81f/Qv1oikEz6Oh85UzH0zQ==
X-Received: by 2002:a17:90b:4c8d:b0:2e2:af53:9326 with SMTP id 98e67ed59e1d1-2e8f11b895dmr39147007a91.30.1730744086189;
        Mon, 04 Nov 2024 10:14:46 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbe114esm10116505a91.35.2024.11.04.10.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:14:45 -0800 (PST)
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
	petrm@nvidia.com
Subject: [PATCH net-next v7 11/12] selftests: ncdevmem: Move ncdevmem under drivers/net/hw
Date: Mon,  4 Nov 2024 10:14:29 -0800
Message-ID: <20241104181430.228682-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104181430.228682-1-sdf@fomichev.me>
References: <20241104181430.228682-1-sdf@fomichev.me>
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


