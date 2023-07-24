Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3A075ED71
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 10:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGXIZl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 04:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjGXIZk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 04:25:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4C13134;
        Mon, 24 Jul 2023 01:25:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C54A715A1;
        Mon, 24 Jul 2023 01:26:21 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5F693F67D;
        Mon, 24 Jul 2023 01:25:36 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Mark Brown" <broonie@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Florent Revest" <revest@chromium.org>,
        "Peter Xu" <peterx@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 3/8] selftests/mm: Enable mrelease_test for arm64
Date:   Mon, 24 Jul 2023 09:25:17 +0100
Message-Id: <20230724082522.1202616-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724082522.1202616-1-ryan.roberts@arm.com>
References: <20230724082522.1202616-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

mrelease_test defaults to defining __NR_pidfd_open and
__NR_process_mrelease syscall numbers to -1, if they are not defined
anywhere else, and the suite would then be marked as skipped as a
result.

arm64 (at least the stock debian toolchain that I'm using) requires
including <sys/syscall.h> to pull in the defines for these syscalls. So
let's add this header. With this in place, the test is passing on arm64.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/mrelease_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/mrelease_test.c b/tools/testing/selftests/mm/mrelease_test.c
index dca21042b679..d822004a374e 100644
--- a/tools/testing/selftests/mm/mrelease_test.c
+++ b/tools/testing/selftests/mm/mrelease_test.c
@@ -7,6 +7,7 @@
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/syscall.h>
 #include <sys/wait.h>
 #include <unistd.h>
 #include <asm-generic/unistd.h>
-- 
2.25.1

