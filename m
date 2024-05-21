Return-Path: <linux-kselftest+bounces-10465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F26148CA93A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 09:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAFF28281A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 07:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0F51C4C;
	Tue, 21 May 2024 07:44:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0C054BF9;
	Tue, 21 May 2024 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277469; cv=none; b=CBqhMX12nRLjU00140O/MLRUdiHOOp9P55pnnfGjj8iM0mDPl0Zo3Mtn0ESYsmrrr/BALbVQwV35x0npmPLQnXOL8wFCYbNV+KNYsy+8S9j780rFM9LwtDbKbzeQu6Q5Wa9T7sKeuV32r7ZNMOHnGqqVW7p1NCUi1iD5fukASrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277469; c=relaxed/simple;
	bh=xKqQVYkhRL27RMTPPCwMLzIsuRzhGjGhpC6rViWWAso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SMPpS1XF4UrD6Yz/W3ej1xQw2ee8klxbx22aOxKSIeoBu4JHw6fTL+QgVJN58sq+9ddsO4AtBKrphZgilkYu/tvn8p4iqg7qaQqGqMU2B7pRwSbm4uDh+d9ksMGbua/wI0dqB2xiaAINCHNEcgcl6z1yGS/ROLzFSf6snoenZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D4CB1042;
	Tue, 21 May 2024 00:44:51 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9DDD3F641;
	Tue, 21 May 2024 00:44:23 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com,
	sjayaram@akamai.com,
	Dev Jain <dev.jain@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] selftests/mm: compaction_test: Fix incorrect write of zero to nr_hugepages
Date: Tue, 21 May 2024 13:13:57 +0530
Message-Id: <20240521074358.675031-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521074358.675031-1-dev.jain@arm.com>
References: <20240521074358.675031-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the test tries to set nr_hugepages to zero, but that is not
actually done because the file offset is not reset after read(). Fix that
using lseek().

Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
Cc: stable@vger.kernel.org
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/compaction_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 0b249a06a60b..5e9bd1da9370 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -108,6 +108,8 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 		goto close_fd;
 	}
 
+	lseek(fd, 0, SEEK_SET);
+
 	/* Start with the initial condition of 0 huge pages*/
 	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
 		ksft_print_msg("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
-- 
2.34.1


