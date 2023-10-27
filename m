Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945B17D9F83
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 20:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346186AbjJ0SJt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 14:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346270AbjJ0SJs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 14:09:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2122F4;
        Fri, 27 Oct 2023 11:09:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 570A0143D;
        Fri, 27 Oct 2023 11:10:27 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88EF03F64C;
        Fri, 27 Oct 2023 11:09:43 -0700 (PDT)
From:   Joey Gouly <joey.gouly@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        broonie@kernel.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, joey.gouly@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, shuah@kernel.org, will@kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 17/24] arm64: enable POE and PIE to coexist
Date:   Fri, 27 Oct 2023 19:08:43 +0100
Message-Id: <20231027180850.1068089-18-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027180850.1068089-1-joey.gouly@arm.com>
References: <20231027180850.1068089-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Set the EL0/userspace indirection encodings to be the overlay enabled
variants of the permissions.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/pgtable-prot.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index eed814b00a38..06fb944ef252 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -141,10 +141,10 @@ extern bool arm64_use_ng_mappings;
 
 #define PIE_E0	( \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_X_O) | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_RX)  | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RWX) | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY),      PIE_R)   | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED),        PIE_RW))
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_RX_O)  | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RWX_O) | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY),      PIE_R_O)   | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED),        PIE_RW_O))
 
 #define PIE_E1	( \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_NONE_O) | \
-- 
2.25.1

