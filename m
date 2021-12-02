Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77A8466832
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 17:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359746AbhLBQbG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 11:31:06 -0500
Received: from foss.arm.com ([217.140.110.172]:37478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359596AbhLBQam (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 11:30:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 507711435;
        Thu,  2 Dec 2021 08:27:19 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2652C3F73B;
        Thu,  2 Dec 2021 08:27:18 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cyphar@cyphar.com, shuah@kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 2/3] selftests: openat2: Add missing dependency in Makefile
Date:   Thu,  2 Dec 2021 16:26:53 +0000
Message-Id: <20211202162654.29704-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211202162654.29704-1-cristian.marussi@arm.com>
References: <20211202162654.29704-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a dependency on header helpers.h to the main target; while at that add
to helpers.h also a missing include for bool types.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 tools/testing/selftests/openat2/Makefile  | 2 +-
 tools/testing/selftests/openat2/helpers.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
index 4b93b1417b86..843ba56d8e49 100644
--- a/tools/testing/selftests/openat2/Makefile
+++ b/tools/testing/selftests/openat2/Makefile
@@ -5,4 +5,4 @@ TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
 
 include ../lib.mk
 
-$(TEST_GEN_PROGS): helpers.c
+$(TEST_GEN_PROGS): helpers.c helpers.h
diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
index ad5d0ba5b6ce..7056340b9339 100644
--- a/tools/testing/selftests/openat2/helpers.h
+++ b/tools/testing/selftests/openat2/helpers.h
@@ -9,6 +9,7 @@
 
 #define _GNU_SOURCE
 #include <stdint.h>
+#include <stdbool.h>
 #include <errno.h>
 #include <linux/types.h>
 #include "../kselftest.h"
-- 
2.17.1

