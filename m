Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4036B898E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 05:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCNEYT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 00:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCNEYP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 00:24:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BE281F5CC;
        Mon, 13 Mar 2023 21:24:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D35724B3;
        Mon, 13 Mar 2023 21:24:57 -0700 (PDT)
Received: from a077209.blr.arm.com (a077209.arm.com [10.162.42.149])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AAC733F71A;
        Mon, 13 Mar 2023 21:24:11 -0700 (PDT)
From:   Chaitanya S Prakash <chaitanyas.prakash@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 3/3] selftests: Set overcommit_policy as OVERCOMMIT_ALWAYS
Date:   Tue, 14 Mar 2023 09:53:51 +0530
Message-Id: <20230314042351.13134-4-chaitanyas.prakash@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314042351.13134-1-chaitanyas.prakash@arm.com>
References: <20230314042351.13134-1-chaitanyas.prakash@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kernel's default behaviour is to obstruct the allocation of high
virtual address as it handles memory overcommit in a heuristic manner.
Setting the parameter as OVERCOMMIT_ALWAYS, ensures kernel isn't
susceptible to the availability of a platform's physical memory when
denying a memory allocation request.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 8984e0bb58c7..c0f93b668c0c 100644
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -220,7 +220,15 @@ CATEGORY="mremap" run_test ./mremap_test
 CATEGORY="hugetlb" run_test ./thuge-gen
 
 if [ $VADDR64 -ne 0 ]; then
+
+	# set overcommit_policy as OVERCOMMIT_ALWAYS so that kernel
+	# allows high virtual address allocation requests independent
+	# of platform's physical memory.
+
+	prev_policy=$(cat /proc/sys/vm/overcommit_memory)
+	echo 1 > /proc/sys/vm/overcommit_memory
 	CATEGORY="hugevm" run_test ./virtual_address_range
+	echo $prev_policy > /proc/sys/vm/overcommit_memory
 
 	# virtual address 128TB switch test
 	CATEGORY="hugevm" run_test ./va_128TBswitch.sh
-- 
2.30.2

