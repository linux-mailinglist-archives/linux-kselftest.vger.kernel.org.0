Return-Path: <linux-kselftest+bounces-6916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D744E892C24
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 18:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7049A1F21DDE
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 17:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5979B3BBDB;
	Sat, 30 Mar 2024 17:37:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ED21E4AD;
	Sat, 30 Mar 2024 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711820264; cv=none; b=C1xDCyVW4JG+aTJN3aKtQWL0D/9BFIk/jyidcQOk1x5SB3sClzQaEJQUhFQslDoi1RcXfXx6OaEn8Zmo+xLtfYPKRwF8GHgKB1MN8QgzNcPEEBYbi9brPHhLcB1svx1ORttW4XXykjC04VfBMXt0M47DsKvpCbtC31moYUevsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711820264; c=relaxed/simple;
	bh=Agd9tHPOVuUGntVv/3ujuMtedDEHLrcwbyBg+ueui/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pDpz7QO0kWUwwwDWbgk5Dn0maIrDmBc+Tz/91Ptvmmzwid8MgUvyuuBN2GOG2IPRKn61QqYHd7AZiz3yawyeBioOJaOGeR1ZqGSl5Zq3B71FYt7Zf+scfcn0uzbk2nLq2vmjL/dAkJv+MIVbGi7HDoptzXHfgsnmqeMfI3znqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52ADF106F;
	Sat, 30 Mar 2024 10:38:08 -0700 (PDT)
Received: from e116581.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 23DC23F7B4;
	Sat, 30 Mar 2024 10:37:30 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org
Cc: shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kaleshsingh@google.com,
	jhubbard@nvidia.com,
	Anshuman.Khandual@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 0/3] selftests/mm: mremap_test: Optimizations and style fixes
Date: Sat, 30 Mar 2024 23:05:54 +0530
Message-Id: <20240330173557.2697684-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mremap_test, in a worst case controlled by the -t flag, does a for loop
iteration in orders of GB. Without compromising on the stdout report, the aim
is to reduce this time.

A pre-filled random buffer is allocated based on the seed, replacing repetitive
rand() calls. The byte pattern in the memory locations is set through memcpy()
from the random buffer.

Replacing the loop for printing the mismatch index to stdout, employ an
efficient algorithm by breaking the comparison into chunks, use the highly
optimized memcmp() library function, and when a mismatch does occur, only
then do a brute force iteration.

Also, use sscanf() to parse /proc/self/maps for consistency across files.

Execution time results (x86 system):
./mremap_test
Original: 3 seconds
After change: 0.8 seconds

./mremap_test -t100
Original: 17 seconds
After change: 2 seconds

./mremap_test -t0 (worst case):
Original: 9:40 minutes
After change: 45 seconds

Dev Jain (3):
  selftests/mm: mremap_test: Optimize using pre-filled random array and
    memcpy
  selftests/mm: mremap_test: Optimize execution time from minutes to
    seconds using chunkwise memcmp
  selftests/mm: mremap_test: Use sscanf to parse /proc/self/maps

 tools/testing/selftests/mm/mremap_test.c | 204 +++++++++++++++++------
 1 file changed, 153 insertions(+), 51 deletions(-)

-- 
2.34.1


