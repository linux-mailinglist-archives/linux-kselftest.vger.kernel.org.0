Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC936C65CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 11:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjCWKyS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 06:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCWKxl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 06:53:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 900F249F9;
        Thu, 23 Mar 2023 03:53:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C368AD7;
        Thu, 23 Mar 2023 03:53:52 -0700 (PDT)
Received: from a077209.blr.arm.com (a077209.arm.com [10.162.40.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9C3873F766;
        Thu, 23 Mar 2023 03:53:05 -0700 (PDT)
From:   Chaitanya S Prakash <chaitanyas.prakash@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 4/5] selftests/mm: Configure nr_hugepages for arm64
Date:   Thu, 23 Mar 2023 16:22:42 +0530
Message-Id: <20230323105243.2807166-5-chaitanyas.prakash@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323105243.2807166-1-chaitanyas.prakash@arm.com>
References: <20230323105243.2807166-1-chaitanyas.prakash@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Arm64 has a default hugepage size of 512MB when CONFIG_ARM64_64K_PAGES=y
is enabled. While testing on arm64 platforms having up to 4PB of virtual
address space, a minimum of 6 hugepages were required for all test cases
to pass. Support for this requirement has been added.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org 
Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index eb9823a6959a..7616b3e4a0f0 100644
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -222,8 +222,16 @@ CATEGORY="hugetlb" run_test ./thuge-gen
 if [ $VADDR64 -ne 0 ]; then
 	CATEGORY="hugevm" run_test ./virtual_address_range
 
-	# virtual address 128TB switch test
+	# va high address boundary switch test
+	ARCH_ARM64="arm64"
+	prev_nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
+	if [ "$ARCH" == "$ARCH_ARM64" ]; then
+		echo 6 > /proc/sys/vm/nr_hugepages
+	fi
 	CATEGORY="hugevm" run_test ./va_high_addr_switch.sh
+	if [ "$ARCH" == "$ARCH_ARM64" ]; then
+		echo $prev_nr_hugepages > /proc/sys/vm/nr_hugepages
+	fi
 fi # VADDR64
 
 # vmalloc stability smoke test
-- 
2.30.2

