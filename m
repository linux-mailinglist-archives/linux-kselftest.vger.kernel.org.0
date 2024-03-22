Return-Path: <linux-kselftest+bounces-6487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDCF886BD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 13:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279E128649F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC153FB8E;
	Fri, 22 Mar 2024 12:07:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DD03FB04;
	Fri, 22 Mar 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109221; cv=none; b=tSNf612exYox8HGXR6i1uLsrUDcR98zA/igDVfNHGMF2AuQ0i3nAUroRg1kjQ7Ff/IrP0liSIkM6BlV7k1eBQHR6i/D5tK18unUmKeJ+7Rmod2GV8nSKB1khjuRUCAiowUOX0rH16vddY3RbBm0Rr8+NxXL4JBXAxgy2nK0QVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109221; c=relaxed/simple;
	bh=bthc13dk1gLvIK9FTpWxxjgtBBe4ubu8K3uAhfkPPkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EAcAiaMUzqWltf2Ejmjby6Lb2q8Zz58v1/AZ/7ZMR2h08RgvrDY4YcpBoENLzxdhla59T0yKsSd9sTTX0ahNLl9GvbBBqUIwkPC7AknCDY/CLqoEOCovlqlW/01ZODIl5fDEMp+xRJTIP7UxGcImgqeDvPy5rn5PSqQG+J200u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 816911007;
	Fri, 22 Mar 2024 05:07:29 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.40.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A8D813F67D;
	Fri, 22 Mar 2024 05:06:52 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] selftests/mm: Parse VMA range in one go
Date: Fri, 22 Mar 2024 17:35:51 +0530
Message-Id: <20240322120551.818764-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use sscanf() to directly parse the VMA range. No functional change is intended.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/mlock2-tests.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
index 26f744188ad0..7f0d50fa361d 100644
--- a/tools/testing/selftests/mm/mlock2-tests.c
+++ b/tools/testing/selftests/mm/mlock2-tests.c
@@ -20,8 +20,6 @@ static int get_vm_area(unsigned long addr, struct vm_boundaries *area)
 	FILE *file;
 	int ret = 1;
 	char line[1024] = {0};
-	char *end_addr;
-	char *stop;
 	unsigned long start;
 	unsigned long end;
 
@@ -37,21 +35,10 @@ static int get_vm_area(unsigned long addr, struct vm_boundaries *area)
 	memset(area, 0, sizeof(struct vm_boundaries));
 
 	while(fgets(line, 1024, file)) {
-		end_addr = strchr(line, '-');
-		if (!end_addr) {
+		if (sscanf(line, "%lx-%lx", &start, &end) != 2) {
 			ksft_print_msg("cannot parse /proc/self/maps\n");
 			goto out;
 		}
-		*end_addr = '\0';
-		end_addr++;
-		stop = strchr(end_addr, ' ');
-		if (!stop) {
-			ksft_print_msg("cannot parse /proc/self/maps\n");
-			goto out;
-		}
-
-		sscanf(line, "%lx", &start);
-		sscanf(end_addr, "%lx", &end);
 
 		if (start <= addr && end > addr) {
 			area->start = start;
-- 
2.34.1


