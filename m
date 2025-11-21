Return-Path: <linux-kselftest+bounces-46176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C9C77360
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 05:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B96F235C2E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 04:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E81285C8D;
	Fri, 21 Nov 2025 04:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0g7SbeB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6977260B;
	Fri, 21 Nov 2025 04:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763697790; cv=none; b=WRNChOrmb33lOhWZOih7DlIhsd/kkH+ZCQIGcsJ5lLldv71PmLr+PzFhgWSWR/52AfFmKu5sV9uI9cch7MTK6cHRzE8pmGWR+fcwrXJtRavEdyjp1myLJ5iVYfhqJOU53eXWY4pgmQ2ICTVn3hUKR8/PuWFBISvWrry6n/6eej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763697790; c=relaxed/simple;
	bh=dv2NoLFKmysVhLXjx2N7OSU+4rrWRhoTM8KC+rJGpo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDpvWGjjCwL+sZq3VgZboPvEJbEDqe8nsckWewldHGrK+coIzVsR4Ke0CAIjNnfnutKT03QAKCbd8QfkmiMPq2JGs3By8Fkel6pNRyZ6NlWAnHlkhGNtM/Gc3as7tFG2CFyO/YD6yBIaD3+AWB+gXc6+wfLGa+QYFyHNUWR99Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0g7SbeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BDDC19421;
	Fri, 21 Nov 2025 04:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763697789;
	bh=dv2NoLFKmysVhLXjx2N7OSU+4rrWRhoTM8KC+rJGpo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0g7SbeB8LGBolDHCp5mzBR+z8YH83u1VPbsRG6vfh44EfSihbqsFPiteJ4QLpjUw
	 akgt+8BnS0iMtoDcCe0Mc3Y6PQWaH9XQbL6T51r+5PS75HOz8UENR12YtyLDIRU7zN
	 tdT3LSvkZZl4nk2Jcf2NNQ35Yb1LOzPO804qocU/2NCbVCT5UjKbgCrIOl8/mafUy7
	 g2Pd/tm/nm1xWyxVJo2rmUaINAH9NRyMF3OO5T/mW613je8ic4EE122BH7UpeNR39w
	 Rt9Gc2w1TuSsyEcu4FfpufrqfMs69DBbOM1iQgpClEvGkuwzF2afNR4IuDT3kDbHCG
	 918D+/t27ZckA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	dw@davidwei.uk,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/5] selftests: hw-net: auto-disable building the iouring C code
Date: Thu, 20 Nov 2025 20:02:55 -0800
Message-ID: <20251121040259.3647749-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251121040259.3647749-1-kuba@kernel.org>
References: <20251121040259.3647749-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looks like the liburing is not updated by distros very aggressively.
Presumably because a lot of packages depend on it. I just updated
to Fedora 43 and it's still on liburing 2.9. The test is 9mo old,
at this stage I think this warrants handling the build failure
more gracefully.

Detect if iouring is recent enough and if not print a warning
and exclude the C prog from build. The Python test will just
fail since the binary won't exist. But it removes the major
annoyance of having to update liburing from sources when
developing other tests.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/Makefile | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 1760238e9d4f..949aeeeb357d 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -1,7 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
+# Check if io_uring supports zero-copy receive
+HAS_IOURING_ZCRX := $(shell \
+	echo -e '#include <liburing.h>\n' \
+	     'void *func = (void *)io_uring_register_ifq;\n' \
+	     'int main() {return 0;}' | \
+	$(CC) -luring -x c - -o /dev/null 2>&1 && echo y)
+
+ifeq ($(HAS_IOURING_ZCRX),y)
+COND_GEN_FILES += iou-zcrx
+else
+$(warning excluding iouring tests, liburing not installed or too old)
+endif
+
 TEST_GEN_FILES := \
-	iou-zcrx \
+	$(COND_GEN_FILES) \
 	toeplitz \
 # end of TEST_GEN_FILES
 
@@ -58,4 +71,6 @@ include ../../../net/ynl.mk
 
 include ../../../net/bpf.mk
 
+ifeq ($(HAS_IOURING_ZCRX),y)
 $(OUTPUT)/iou-zcrx: LDLIBS += -luring
+endif
-- 
2.51.1


