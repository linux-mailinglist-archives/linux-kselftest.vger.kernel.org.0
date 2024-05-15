Return-Path: <linux-kselftest+bounces-10245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2B28C63CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 11:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC689B22514
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 09:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A57258ADD;
	Wed, 15 May 2024 09:37:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A7A2744C;
	Wed, 15 May 2024 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765822; cv=none; b=o03TjexphOKe/QJlZrahOPishue19oOOgFFLrj4Y2ZFW5U/Tme5vkpwFfmBvDxspQxhWfO/YGUTNb7rNTaB9ttGnWL7UJr0VI+YTUCjEPrH+g+gbp2/sm8J8P6xgtufqP1846+vy/CtINGAiyAztkDNqxRPCKRGrGkvxVWwqsfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765822; c=relaxed/simple;
	bh=6lYJ7+avvs8sN6tr0U2vFGdDZ0rZ2/OE+Hj/WS2n9+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YivJiDDbI93lxSxobPFhzRj9hWletRMzC402HMSa5XvS2eOc9yPtvQrTaE4X16ySzJ47J52Cjzj+J0UVyOqNJmr9iNPb2upJAsXEZsJnu4nvXpbNnu9+DFBMVkaYzRitl/ioADudsNJqEgyN715HUSxkaFDaZwIT5Ed+OQeXy7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 168861007;
	Wed, 15 May 2024 02:37:19 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 70ADD3F7A6;
	Wed, 15 May 2024 02:36:51 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com,
	sjayaram@akamai.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 0/2] Fixes for compaction_test
Date: Wed, 15 May 2024 15:06:31 +0530
Message-Id: <20240515093633.54814-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compaction_test memory selftest introduces fragmentation in memory
and then tries to allocate as many hugepages as possible. This series
addresses some problems.

First off, correctly set the number of hugepages to zero before trying
to set a large number of them.

Now, consider a situation in which, at the start of the test, a non-zero
number of hugepages have been already set (while running the entire
selftests/mm suite, or manually by the admin). The test operates on 80%
of memory to avoid OOM-killer invocation, and because some memory is
already blocked by hugepages, it would increase the chance of OOM-killing.
Also, since mem_free used in check_compaction() is the value before we
set nr_hugepages to zero, the chance that the compaction_index will
be small is very high if the preset nr_hugepages was high, leading to a
bogus test success.

This series applies on top of the stable 6.9 kernel.
 
Dev Jain (2):
  selftests/mm: compaction_test: Fix incorrect write of zero to
    nr_hugepages
  selftests/mm: compaction_test: Fix trivial test success and reduce
    probability of OOM-killer invocation

 tools/testing/selftests/mm/compaction_test.c | 70 ++++++++++++++------
 1 file changed, 50 insertions(+), 20 deletions(-)

-- 
2.30.2


