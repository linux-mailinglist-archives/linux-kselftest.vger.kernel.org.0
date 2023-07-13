Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85A3752450
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjGMNy5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjGMNyz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:54:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DFBD1992;
        Thu, 13 Jul 2023 06:54:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75C6C1595;
        Thu, 13 Jul 2023 06:55:36 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BABF3F73F;
        Thu, 13 Jul 2023 06:54:52 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 2/9] selftests/mm: Give scripts execute permission
Date:   Thu, 13 Jul 2023 14:54:33 +0100
Message-Id: <20230713135440.3651409-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230713135440.3651409-1-ryan.roberts@arm.com>
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When run under run_vmtests.sh, test scripts were failing to run with
"permission denied" due to the scripts not being executable.

It is also annoying not to be able to directly invoke run_vmtests.sh,
which is solved by giving also it the execute permission.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh  | 0
 tools/testing/selftests/mm/check_config.sh             | 0
 tools/testing/selftests/mm/hugetlb_reparenting_test.sh | 0
 tools/testing/selftests/mm/run_vmtests.sh              | 0
 tools/testing/selftests/mm/test_hmm.sh                 | 0
 tools/testing/selftests/mm/test_vmalloc.sh             | 0
 tools/testing/selftests/mm/va_high_addr_switch.sh      | 0
 tools/testing/selftests/mm/write_hugetlb_memory.sh     | 0
 8 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/mm/charge_reserved_hugetlb.sh
 mode change 100644 => 100755 tools/testing/selftests/mm/check_config.sh
 mode change 100644 => 100755 tools/testing/selftests/mm/hugetlb_reparenting_test.sh
 mode change 100644 => 100755 tools/testing/selftests/mm/run_vmtests.sh
 mode change 100644 => 100755 tools/testing/selftests/mm/test_hmm.sh
 mode change 100644 => 100755 tools/testing/selftests/mm/test_vmalloc.sh
 mode change 100644 => 100755 tools/testing/selftests/mm/va_high_addr_switch.sh
 mode change 100644 => 100755 tools/testing/selftests/mm/write_hugetlb_memory.sh

diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/mm/check_config.sh b/tools/testing/selftests/mm/check_config.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/mm/test_hmm.sh b/tools/testing/selftests/mm/test_hmm.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/mm/test_vmalloc.sh b/tools/testing/selftests/mm/test_vmalloc.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/mm/write_hugetlb_memory.sh b/tools/testing/selftests/mm/write_hugetlb_memory.sh
old mode 100644
new mode 100755
-- 
2.25.1

