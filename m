Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1450298CC2
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 13:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774858AbgJZMN6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 08:13:58 -0400
Received: from foss.arm.com ([217.140.110.172]:37146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1774784AbgJZMNM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 08:13:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0223D1480;
        Mon, 26 Oct 2020 05:13:12 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDBE73F719;
        Mon, 26 Oct 2020 05:13:10 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gabor Kertesz <gabor.kertesz@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH 4/6] kselftest/arm64: Fix check_mmap_options test
Date:   Mon, 26 Oct 2020 12:12:46 +0000
Message-Id: <20201026121248.2340-5-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026121248.2340-1-vincenzo.frascino@arm.com>
References: <20201026121248.2340-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The check_mmap_options test reports the error below because the test
plan is not declared correctly:

  # Planned tests != run tests (0 != 22)

Fix the test adding the correct test plan declaration.

Fixes: 53ec81d23213 ("kselftest/arm64: Verify all different mmap MTE options")
Cc: Shuah Khan <shuah@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Gabor Kertesz <gabor.kertesz@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 tools/testing/selftests/arm64/mte/check_mmap_options.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/arm64/mte/check_mmap_options.c b/tools/testing/selftests/arm64/mte/check_mmap_options.c
index 33b13b86199b..a04b12c21ac9 100644
--- a/tools/testing/selftests/arm64/mte/check_mmap_options.c
+++ b/tools/testing/selftests/arm64/mte/check_mmap_options.c
@@ -205,7 +205,11 @@ int main(int argc, char *argv[])
 	mte_register_signal(SIGBUS, mte_default_handler);
 	mte_register_signal(SIGSEGV, mte_default_handler);
 
+	/* Set test plan */
+	ksft_set_plan(22);
+
 	mte_enable_pstate_tco();
+
 	evaluate_test(check_anonymous_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE, TAG_CHECK_OFF),
 	"Check anonymous memory with private mapping, sync error mode, mmap memory and tag check off\n");
 	evaluate_test(check_file_memory_mapping(USE_MPROTECT, MTE_SYNC_ERR, MAP_PRIVATE, TAG_CHECK_OFF),
-- 
2.28.0

