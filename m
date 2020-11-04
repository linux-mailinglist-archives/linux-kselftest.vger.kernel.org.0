Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA2E2A6113
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 11:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgKDKDO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 05:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgKDKDO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 05:03:14 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79B8C0613D3;
        Wed,  4 Nov 2020 02:03:13 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CR2KB2hxfz9sTK; Wed,  4 Nov 2020 21:03:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1604484190;
        bh=L1GBv73QytYJI/5pzM+dKFeWgUQ+ltUjUa2+CVaFVAA=;
        h=From:To:Cc:Subject:Date:From;
        b=X9jZQphOB1UPN3HBNOr0E3kt5wR++jemdLWJg+ewe+oEr6OA27EsdygKIZZ4an8ip
         qvc8NMnPjQ1M0WbWPctZ1iZqB7ZCR3GAzos4hEsiAHbVrhH/J5HFtlWoL6nUtoB23e
         e23UkDJuvP8sNXMemw+ePXNweNlhiYuTTP1AOiEfVRb5cfKzJzln2tzY5Z5b5s+zmN
         73voxdlh++o3QcVz0MjjVRXBnBV+ApGDu1TSTXj9KrfGb/t3lhoTRXdxHpNALQlxSq
         PfyfBbLUEIg5HskJf/kXi67V+foEjw4XsAAEK6CqYf4ebF9Kp5s3messxHZInhThtm
         EqrJZJE8WZL+Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/memfd: Fix implicit declaration warnings
Date:   Wed,  4 Nov 2020 21:03:05 +1100
Message-Id: <20201104100305.655720-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The memfd tests emit several warnings:

  fuse_test.c:261:7: warning: implicit declaration of function 'open'
  fuse_test.c:67:6: warning: implicit declaration of function 'fcntl'
  memfd_test.c:397:6: warning: implicit declaration of function 'fallocate'
  memfd_test.c:64:7: warning: implicit declaration of function 'open'
  memfd_test.c:90:6: warning: implicit declaration of function 'fcntl'

These are all caused by the test not including fcntl.h.

Instead of including linux/fcntl.h, include fcntl.h, which should
eventually cause the former to be included as well.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/memfd/fuse_test.c  | 2 +-
 tools/testing/selftests/memfd/memfd_test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index b018e835737d..be675002f918 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -20,7 +20,7 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <linux/falloc.h>
-#include <linux/fcntl.h>
+#include <fcntl.h>
 #include <linux/memfd.h>
 #include <sched.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 334a7eea2004..74baab83fec3 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -6,7 +6,7 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <linux/falloc.h>
-#include <linux/fcntl.h>
+#include <fcntl.h>
 #include <linux/memfd.h>
 #include <sched.h>
 #include <stdio.h>

base-commit: cf7cd542d1b538f6e9e83490bc090dd773f4266d
-- 
2.25.1

