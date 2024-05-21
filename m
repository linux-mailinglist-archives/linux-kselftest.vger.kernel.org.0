Return-Path: <linux-kselftest+bounces-10463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6F28CA934
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 09:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9E82825EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500BA51C43;
	Tue, 21 May 2024 07:44:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEFC5466C;
	Tue, 21 May 2024 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277463; cv=none; b=Z/9Fj3E3ekhV/8zSlzcb+zNbTx1p6iFx9AkwzdVxkQoa3n8esOIFJuuZBrqhZ9zWqa4aqZUFplvDtZKpMK+E3qLPzcvEtiDTs7/205vyw2395h22LX76YEQMXx4sqYiVbSHtJ4LnqMPQNXG7F/NSjgK1dDTDWW1TaGvO36kov7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277463; c=relaxed/simple;
	bh=12ORrgVkQoBujtx3I4EyW1vH6oJF0P0A90rYX72bXiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WqMb5k0OUZrRaeC/BlTu/wRnrCPZqtSEfgjMrBugdlm7WO3KOE+qMyzUQzE0COigqa79a1bmUJOvlgAhCIjT+cL6lw46WGWoa7PLZYv7x8PW78cuYKsFNtQSGqxDqLjuQVCJSjlmw6imwDOkLAFEoxCto2N1BCxUpaoc+0fV/Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B37CDA7;
	Tue, 21 May 2024 00:44:43 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 73AD63F641;
	Tue, 21 May 2024 00:44:16 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com,
	sjayaram@akamai.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v2 0/3] Fixes for compaction_test
Date: Tue, 21 May 2024 13:13:55 +0530
Message-Id: <20240521074358.675031-1-dev.jain@arm.com>
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

On Aarch64, if nr_hugepages == 0, then the test trivially succeeds since
compaction_index becomes 0, which is less than 3, due to no division by
zero exception being raised. We fix that by checking for division by
zero.

Secondly, correctly set the number of hugepages to zero before trying
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

Changes in v2:
- Handle an unsigned long number of hugepages
- Combine the first patch (previously standalone) with this series

Link to v1:
https://lore.kernel.org/all/20240513082842.4117782-1-dev.jain@arm.com/
https://lore.kernel.org/all/20240515093633.54814-1-dev.jain@arm.com/

Dev Jain (3):
  selftests/mm: compaction_test: Fix bogus test success on Aarch64
  selftests/mm: compaction_test: Fix incorrect write of zero to
    nr_hugepages
  selftests/mm: compaction_test: Fix bogus test success and reduce
    probability of OOM-killer invocation

 tools/testing/selftests/mm/compaction_test.c | 85 ++++++++++++++------
 1 file changed, 60 insertions(+), 25 deletions(-)

-- 
2.34.1


