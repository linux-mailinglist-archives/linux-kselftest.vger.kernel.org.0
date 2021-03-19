Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD94034228D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCSQyI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 12:54:08 -0400
Received: from foss.arm.com ([217.140.110.172]:56898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhCSQx7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 12:53:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 499B5ED1;
        Fri, 19 Mar 2021 09:53:59 -0700 (PDT)
Received: from e104803-lin.cambridge.arm.com (e104803-lin.cambridge.arm.com [10.1.197.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BDA33F70D;
        Fri, 19 Mar 2021 09:53:57 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 11/11] kselftest/arm64: mte: Report filename on failing temp file creation
Date:   Fri, 19 Mar 2021 16:53:34 +0000
Message-Id: <20210319165334.29213-12-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20210319165334.29213-1-andre.przywara@arm.com>
References: <20210319165334.29213-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The MTE selftests create temporary files in /dev/shm, for later mmap-ing
them. When there is no tmpfs mounted on /dev/shm, or /dev/shm does not
exist in the first place (on minimal filesystems), the error message is
not giving good hints:
    # FAIL: Unable to open temporary file
    # FAIL: memory allocation
    not ok 17 Check initial tags with private mapping, ...

Add a perror() call, that gives both the filename and the actual error
reason, so that users get a chance of correcting that.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/mte/mte_common_util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 040abdca079d..f50ac31920d1 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -337,6 +337,7 @@ int create_temp_file(void)
 	/* Create a file in the tmpfs filesystem */
 	fd = mkstemp(&filename[0]);
 	if (fd == -1) {
+		perror(filename);
 		ksft_print_msg("FAIL: Unable to open temporary file\n");
 		return 0;
 	}
-- 
2.17.5

