Return-Path: <linux-kselftest+bounces-10247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266078C63D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 11:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD101F24549
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 09:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D769D5CDF2;
	Wed, 15 May 2024 09:37:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668902744C;
	Wed, 15 May 2024 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765825; cv=none; b=kdK33Jpco9ziaviqSwsvmk5vd/aTxSp04YoNCRQPxi/oc62ozkXquwLz7uf4FOyyvq8RdkPumgIJYl0eCzIc7CDN/oFISwlrIB7lPQ6WwUL4vc7UaKWScesOpXk6vlSpJid4D3pfNn/ney9XT/MxsNOnkO2GU2i3IJ7Kf9lGI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765825; c=relaxed/simple;
	bh=zNQ2NzOouLlV78Yiedaiqaes0qVGsXsk8gwCDZjyNSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WWZT9P3kuWD/er1KLIoqh2msVVIlcGHgnTDc/JSLGm8sbJd1rgZq6zEK4c3cXq8MrIRIeFz9lgOEOl2eCEbM0KXpw1QbVhh90YEsK0KxknlqtW+l8hoPakSM1XFHRwUEoKADlR1/1hwlHxBOPjeHecsfkCsJYrko5BKdByOt0zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD0F51042;
	Wed, 15 May 2024 02:37:22 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0AE0F3F7A6;
	Wed, 15 May 2024 02:36:54 -0700 (PDT)
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
Subject: [PATCH 1/2] selftests/mm: compaction_test: Fix incorrect write of zero to nr_hugepages
Date: Wed, 15 May 2024 15:06:32 +0530
Message-Id: <20240515093633.54814-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515093633.54814-1-dev.jain@arm.com>
References: <20240515093633.54814-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_hugepages is not set to zero because the file offset has not been reset
after read(). Fix that using lseek().

Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
Cc: stable@vger.kernel.org 
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
Merge dependency: https://lore.kernel.org/all/20240513082842.4117782-1-dev.jain@arm.com/
Andrew, does it sound reasonable to have the fixes tag in the above
patch too, along with this series?

 tools/testing/selftests/mm/compaction_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 533999b6c284..c5be395f8363 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -107,6 +107,8 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 		goto close_fd;
 	}
 
+	lseek(fd, 0, SEEK_SET);
+
 	/* Start with the initial condition of 0 huge pages*/
 	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
 		ksft_print_msg("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
-- 
2.30.2


