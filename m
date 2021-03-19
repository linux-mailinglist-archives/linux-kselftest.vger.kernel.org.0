Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7F734228C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhCSQyG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 12:54:06 -0400
Received: from foss.arm.com ([217.140.110.172]:56814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230055AbhCSQxr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 12:53:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2D351063;
        Fri, 19 Mar 2021 09:53:45 -0700 (PDT)
Received: from e104803-lin.cambridge.arm.com (e104803-lin.cambridge.arm.com [10.1.197.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B0743F70D;
        Fri, 19 Mar 2021 09:53:44 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 02/11] kselftest/arm64: mte: Fix pthread linking
Date:   Fri, 19 Mar 2021 16:53:25 +0000
Message-Id: <20210319165334.29213-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20210319165334.29213-1-andre.przywara@arm.com>
References: <20210319165334.29213-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The GCC manual suggests to use -pthread, when linking with the PThread
library, also to add this switch to both the compilation and linking
stages.

Do as the manual says, to fix compilation with Ubuntu's 20.04 toolchain,
which was getting -lpthread too early on the command line:
------------
/usr/bin/ld: /tmp/cc5zbo2A.o: in function `execute_test':
tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c:86:
	undefined reference to `pthread_create'
/usr/bin/ld: tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c:90:
	undefined reference to `pthread_join'
------------

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/mte/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/mte/Makefile b/tools/testing/selftests/arm64/mte/Makefile
index df15d44aeb8d..90aadd86fa0d 100644
--- a/tools/testing/selftests/arm64/mte/Makefile
+++ b/tools/testing/selftests/arm64/mte/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2020 ARM Limited
 
-CFLAGS += -std=gnu99 -I. -lpthread
+CFLAGS += -std=gnu99 -I. -pthread
+LDFLAGS += -pthread
 SRCS := $(filter-out mte_common_util.c,$(wildcard *.c))
 PROGS := $(patsubst %.c,%,$(SRCS))
 
-- 
2.17.5

