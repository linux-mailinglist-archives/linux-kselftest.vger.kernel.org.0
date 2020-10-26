Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED804298CB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 13:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774795AbgJZMNQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 08:13:16 -0400
Received: from foss.arm.com ([217.140.110.172]:37128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1774777AbgJZMNJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 08:13:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E17914BF;
        Mon, 26 Oct 2020 05:13:09 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDEF93F719;
        Mon, 26 Oct 2020 05:13:07 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gabor Kertesz <gabor.kertesz@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH 2/6] kselftest/arm64: Fix check_tags_inclusion test
Date:   Mon, 26 Oct 2020 12:12:44 +0000
Message-Id: <20201026121248.2340-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026121248.2340-1-vincenzo.frascino@arm.com>
References: <20201026121248.2340-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The check_tags_inclusion test reports the error below because the test
plan is not declared correctly:

  # Planned tests != run tests (0 != 4)

Fix the test adding the correct test plan declaration.

Fixes: f3b2a26ca78d ("kselftest/arm64: Verify mte tag inclusion via prctl")
Cc: Shuah Khan <shuah@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Gabor Kertesz <gabor.kertesz@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 tools/testing/selftests/arm64/mte/check_tags_inclusion.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
index 94d245a0ed56..deaef1f61076 100644
--- a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
+++ b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
@@ -170,6 +170,9 @@ int main(int argc, char *argv[])
 	/* Register SIGSEGV handler */
 	mte_register_signal(SIGSEGV, mte_default_handler);
 
+	/* Set test plan */
+	ksft_set_plan(4);
+
 	evaluate_test(check_single_included_tags(USE_MMAP, MTE_SYNC_ERR),
 		      "Check an included tag value with sync mode\n");
 	evaluate_test(check_multiple_included_tags(USE_MMAP, MTE_SYNC_ERR),
-- 
2.28.0

