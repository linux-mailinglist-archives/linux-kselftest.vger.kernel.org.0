Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26ACE342289
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCSQyH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 12:54:07 -0400
Received: from foss.arm.com ([217.140.110.172]:56842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhCSQxu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 12:53:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 083C8142F;
        Fri, 19 Mar 2021 09:53:50 -0700 (PDT)
Received: from e104803-lin.cambridge.arm.com (e104803-lin.cambridge.arm.com [10.1.197.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C39203F70D;
        Fri, 19 Mar 2021 09:53:48 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 05/11] kselftest/arm64: mte: common: Fix write() warnings
Date:   Fri, 19 Mar 2021 16:53:28 +0000
Message-Id: <20210319165334.29213-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20210319165334.29213-1-andre.przywara@arm.com>
References: <20210319165334.29213-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Out of the box Ubuntu's 20.04 compiler warns about missing return value
checks for write() (sys)calls.

Make GCC happy by checking whether we actually managed to write out our
buffer.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../selftests/arm64/mte/mte_common_util.c     | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 39f8908988ea..4e887dad762d 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -181,10 +181,17 @@ void *mte_allocate_file_memory(size_t size, int mem_type, int mapping, bool tags
 	}
 	/* Initialize the file for mappable size */
 	lseek(fd, 0, SEEK_SET);
-	for (index = INIT_BUFFER_SIZE; index < size; index += INIT_BUFFER_SIZE)
-		write(fd, buffer, INIT_BUFFER_SIZE);
+	for (index = INIT_BUFFER_SIZE; index < size; index += INIT_BUFFER_SIZE) {
+		if (write(fd, buffer, INIT_BUFFER_SIZE) != INIT_BUFFER_SIZE) {
+			perror("initialising buffer");
+			return NULL;
+		}
+	}
 	index -= INIT_BUFFER_SIZE;
-	write(fd, buffer, size - index);
+	if (write(fd, buffer, size - index) != size - index) {
+		perror("initialising buffer");
+		return NULL;
+	}
 	return __mte_allocate_memory_range(size, mem_type, mapping, 0, 0, tags, fd);
 }
 
@@ -202,9 +209,15 @@ void *mte_allocate_file_memory_tag_range(size_t size, int mem_type, int mapping,
 	/* Initialize the file for mappable size */
 	lseek(fd, 0, SEEK_SET);
 	for (index = INIT_BUFFER_SIZE; index < map_size; index += INIT_BUFFER_SIZE)
-		write(fd, buffer, INIT_BUFFER_SIZE);
+		if (write(fd, buffer, INIT_BUFFER_SIZE) != INIT_BUFFER_SIZE) {
+			perror("initialising buffer");
+			return NULL;
+		}
 	index -= INIT_BUFFER_SIZE;
-	write(fd, buffer, map_size - index);
+	if (write(fd, buffer, map_size - index) != map_size - index) {
+		perror("initialising buffer");
+		return NULL;
+	}
 	return __mte_allocate_memory_range(size, mem_type, mapping, range_before,
 					   range_after, true, fd);
 }
-- 
2.17.5

