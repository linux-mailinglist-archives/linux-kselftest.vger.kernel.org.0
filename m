Return-Path: <linux-kselftest+bounces-21673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D49C1E71
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 14:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59085B254B6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 13:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E95D1EF0B9;
	Fri,  8 Nov 2024 13:49:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FB1EF0AE
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073764; cv=none; b=KWxTOASETT1uOuWAmjMzCT9DRua6IZTgdSlG8YdHaMLXL28IRxMbmc5hwohbvPH7qUrZV4SJl4k+70xWvOXbT8R8utpz2o3veIXrV94cMvpFi3wAaXNP9inocoXYgiC3m5Ai1FET1PGYydHj5T5IgEVCZ0ls2O2Bpi0a6tI3APc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073764; c=relaxed/simple;
	bh=5zEx9wmCEZegQ6utQ/uqd1PY52ZhWUw46TphYJP4okk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V541MM71neULJ0kkC3Tm7BJJc+zuVku6O+JJHoTPDCvCszaf+mhuh1oARF5/oNZ2jJ6jTvzJOmm6Xdj7zMwYdZdheZu5N7oqXBVnJOt1WxFZ3xG+ux/O1jlxRz52d/TeKK/IE4u2BAupN/8XYj7JTHm/kd4lpuTbfdjP62caM1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA956C4CECD;
	Fri,  8 Nov 2024 13:49:22 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/4] kselftest/arm64: Fix compilation warnings/errors in the arm64 tests
Date: Fri,  8 Nov 2024 13:49:16 +0000
Message-Id: <20241108134920.1233992-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It looks like people started ignoring the compiler warnings (or even
errors) when building the arm64-specific kselftests. The first three
patches are printf() arguments adjustment. The last one adds
".arch_extension sme", otherwise they fail to build (with my toolchain
versions at least).

Note for future kselftest contributors - try to keep them warning-free.

Catalin Marinas (4):
  kselftest/arm64: Fix printf() compiler warnings in the arm64 fp tests
  kselftest/arm64: Fix printf() warning in the arm64 MTE prctl() test
  kselftest/arm64: Fix printf() compiler warnings in the arm64
    syscall-abi.c tests
  kselftest/arm64: Fix compilation of SME instructions in the arm64 fp
    tests

 tools/testing/selftests/arm64/abi/syscall-abi.c |  8 ++++----
 tools/testing/selftests/arm64/fp/sve-ptrace.c   | 16 +++++++++-------
 tools/testing/selftests/arm64/fp/za-ptrace.c    |  8 +++++---
 tools/testing/selftests/arm64/fp/za-test.S      |  1 +
 tools/testing/selftests/arm64/fp/zt-ptrace.c    |  8 +++++---
 tools/testing/selftests/arm64/fp/zt-test.S      |  1 +
 tools/testing/selftests/arm64/mte/check_prctl.c |  2 +-
 7 files changed, 26 insertions(+), 18 deletions(-)


