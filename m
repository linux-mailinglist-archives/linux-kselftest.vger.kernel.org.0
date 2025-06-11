Return-Path: <linux-kselftest+bounces-34696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C5AAD5516
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64563174502
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0C027780B;
	Wed, 11 Jun 2025 12:10:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42638226D03
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643825; cv=none; b=Q+gywjp4xIMcrHfFsesU6GD2CmxUScN1URHtIrEa32RPxuDvS2CDK9FA2S+NsXMuINBixo8fA5Zbr3/AYysY23asP+3ccv02hIggHn8gR0KpFfOh4dTIMz4n/CzXmKEvABO9rCUMvwSfNkJ6df0EZk0l+DtlunVhcAdceQEYH9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643825; c=relaxed/simple;
	bh=hUH5cic0hNUIY3CNfng0h2+1pdjeEEpeS/vc4NhJnN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aaJvRrAX/eszjt+yPwPDFIiOFWARXle9a5Xojxf8ojuNVbm42cW+NvxpMfDzIosEmdel5PHm7JPO4JxmiLIcdvMVgzrO8dUfwq1O8Klip6WSDZMWTKRgOr+l2bdtRge+QbHCJq680aGt42byi5M7565wnxIyBhkLDb6Xnoh5eeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6F4C15A1;
	Wed, 11 Jun 2025 05:10:02 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (MacBook-Pro.blr.arm.com [10.164.18.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A4733F673;
	Wed, 11 Jun 2025 05:10:18 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	pfalcato@suse.de
Cc: vbabka@suse.cz,
	jannh@google.com,
	pulehui@huawei.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	aishwarya.tcv@arm.com,
	broonie@kernel.org,
	ryan.roberts@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] selftests/mm: Add CONFIG_FTRACE to config
Date: Wed, 11 Jun 2025 17:40:11 +0530
Message-Id: <20250611121011.23888-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_UPROBES is not set, a merge subtest fails:

Failure log:

  7151 12:46:54.627936  # # #  RUN           merge.handle_uprobe_upon_merged_vma ...
  7152 12:46:54.639014  # # f /sys/bus/event_source/devices/uprobe/type
  7153 12:46:54.639306  # # fopen: No such file or directory
  7154 12:46:54.650451  # # # merge.c:473:handle_uprobe_upon_merged_vma:Expected read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) (1) == 0 (0)
  7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test terminated by assertion
  7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_merged_vma
  7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vma

CONFIG_UPROBES is enabled by CONFIG_UPROBE_EVENTS, which gets enabled by
CONFIG_FTRACE. Therefore add this config to selftests/mm/config so that
CI systems can include this config in the kernel build.

Fixes: efe99fabeb11b ("selftests/mm: add test about uprobe pte be orphan during vma merge")
Reported-by: Aishwarya <aishwarya.tcv@arm.com>
Closes: https://lore.kernel.org/all/20250610103729.72440-1-aishwarya.tcv@arm.com/
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests/mm/config
index a28baa536332..e600b41030c1 100644
--- a/tools/testing/selftests/mm/config
+++ b/tools/testing/selftests/mm/config
@@ -8,3 +8,4 @@ CONFIG_GUP_TEST=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_MEM_SOFT_DIRTY=y
 CONFIG_ANON_VMA_NAME=y
+CONFIG_FTRACE=y
-- 
2.30.2


