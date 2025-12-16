Return-Path: <linux-kselftest+bounces-47606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20409CC39C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 15:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9485C30844BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147334CFBB;
	Tue, 16 Dec 2025 14:26:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2817634B187;
	Tue, 16 Dec 2025 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895204; cv=none; b=S8o1DwD3w2np+Ha1pcTZ7Ln5IwoE4/P+knVnhYbRnwa1EqKxGtEO2kTcG7pjqZt+mocOGvANSJnBCurYIOz6aN0lXgw3Yc2+GaPHCHTR/v+OiXCodOQGVDSGUTcY36phjuxIfkVDkHyeBGWoQ4Mg6RPwhZXwf+1CKCPa9paOxMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895204; c=relaxed/simple;
	bh=kWOdOMiuEsHbT79j14W+pKROOAryjTa6wIbdQSq4xJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M244H7EiAQv5EVj8OG126thoFLgZkLBFvq+WiLacbVrTJ7qGI43cdYDv+ldWgQ08FSCRcxWbzEDFJLljjopexhQ64JK7KJfdDUOQEd3zWlljxq8WDDC0udPApmzWEonObrkFU44YOyB1cXkjq7Q6vBpBQx73DBaFPJcSy8BdnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56658FEC;
	Tue, 16 Dec 2025 06:26:34 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3AF13F694;
	Tue, 16 Dec 2025 06:26:39 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH 0/4] Various mm kselftests improvements/fixes
Date: Tue, 16 Dec 2025 14:26:29 +0000
Message-ID: <20251216142633.2401447-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few improvements/fixes for the mm kselftests:

- Patch 1-2 extend support for more build configurations: out-of-tree
  $KDIR, cross-compilation, etc.

- Patch 3-4 fix issues in the pagemap_ioctl tests, most importantly that
  it does not report failures: ./run_kselftests.sh would report OK
  even if some pagemap_ioctl tests fail. That's probably why the issue
  in patch 3 went unnoticed.

---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
---
Kevin Brodsky (4):
  selftests/mm: remove flaky header check
  selftests/mm: pass down full CC and CFLAGS to check_config.sh
  selftests/mm: fix faulting-in code in pagemap_ioctl test
  selftests/mm: fix exit code in pagemap_ioctl

 tools/testing/selftests/mm/Makefile        |  6 +-----
 tools/testing/selftests/mm/check_config.sh |  3 +--
 tools/testing/selftests/mm/pagemap_ioctl.c | 12 ++++++------
 3 files changed, 8 insertions(+), 13 deletions(-)


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.51.2


