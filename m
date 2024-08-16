Return-Path: <linux-kselftest+bounces-15521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE6954DD4
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FEC2831A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E33C1A76B2;
	Fri, 16 Aug 2024 15:33:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B77B1BD4F9
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822381; cv=none; b=ZlZ9fgun7Stbd98T5C0My1rk6i+otsUyA2Ejq2Q0SuPhyMXTwzkRQvS0y0DzrNQVOqZW0qEvfssSU4RT5nwuDREif37W3d14poqIVxrTg+RXMQbJ3sjMKsSzEPyZIPQ4zRp8FknHIvr+dMq0ikro2K/UNtba9IIHS9hoTcxaBHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822381; c=relaxed/simple;
	bh=rMKhgmOBM/mQA/PIvWbVkU+AbrKSfVM6TmJPb6OHLbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L0EjCt4NZHcd4iTN5uiNdPtu5WmqzBL0zKLJ4496r0Z7mYeVN47FtKlKQjAG+NhE2hP4puaQcVlvDutKygy46M/k//RW7VtnbjLDm9Y73hAgkeEQquu2b7zEHo2QqYebm3NHRSXCFz+GwspPeBBDAQ0LdieBN55bD4vhmyQEuuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD31D13D5;
	Fri, 16 Aug 2024 08:33:24 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 885323F6A8;
	Fri, 16 Aug 2024 08:32:57 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/8] kselftest/arm64: various compilation fixes
Date: Fri, 16 Aug 2024 16:32:43 +0100
Message-Id: <20240816153251.2833702-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes several smaller issues I faced when compiling the arm64
kselftests on my machine.
Patch 1 avoids a warning about the double definition of GNU_SOURCE,
for the arm64/signal tests. Patch 2 fixes a typo, where the f8dp2 hwcap
feature test was looking at the f8dp*4* cpuinfo name. Patch 3 adjusts
the output of the MTE tests when MTE is not available, so that tools
parsing the TAP output don't get confused and report errors.
The remaining patches are about wrong printf format specifiers. I grouped
them by type of error, in patch 4-8.

Please have a look!

Cheers,
Andre

Andre Przywara (8):
  kselftest/arm64: signal: drop now redundant GNU_SOURCE definition
  kselftest/arm64: hwcap: fix f8dp2 cpuinfo name
  kselftest/arm64: mte: use proper SKIP syntax
  kselftest/arm64: mte: use string literal for printf-style functions
  kselftest/arm64: mte: fix printf type warning about mask
  kselftest/arm64: mte: fix printf type warnings about __u64
  kselftest/arm64: mte: fix printf type warnings about pointers
  kselftest/arm64: mte: fix printf type warnings about longs

 tools/testing/selftests/arm64/abi/hwcap.c         |  2 +-
 .../selftests/arm64/mte/check_buffer_fill.c       |  4 ++--
 tools/testing/selftests/arm64/mte/check_prctl.c   |  4 ++--
 .../selftests/arm64/mte/check_tags_inclusion.c    |  4 ++--
 .../testing/selftests/arm64/mte/mte_common_util.c | 15 +++++++--------
 .../testing/selftests/arm64/mte/mte_common_util.h |  6 +++---
 tools/testing/selftests/arm64/signal/Makefile     |  2 +-
 7 files changed, 18 insertions(+), 19 deletions(-)

-- 
2.25.1


