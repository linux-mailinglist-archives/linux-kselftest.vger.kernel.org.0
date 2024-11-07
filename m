Return-Path: <linux-kselftest+bounces-21579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2859C9BFBD5
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7EE1C21DC2
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 01:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E91117C60;
	Thu,  7 Nov 2024 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhvhSiow"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA95B179BF;
	Thu,  7 Nov 2024 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943830; cv=none; b=gboibxfr1jgsO6LqD1Zz/tw8AQ3fT2abAoHDSGEF+6jfjJ8ekPVSuU2aiqxe8cKyhU3EYDZZLnpvvR6uunhd1xEuuPZmsPgaBmsl8W/iiufsEA7NDvZq+lcq6LFzunFH40s8RWaZNJxKJAeGGn3bZZp586lTRn7SuAGGt2SAk6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943830; c=relaxed/simple;
	bh=FhICeJvrCrMnhdIC0qbv97Akl1RvVJJpaEaD5gQEQkI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E/zUUXs6nNDCsdZne4qLpMxbrZhv4mIhXJybHwVl4BX4GOebyeoi9+vYcjSmVOS4SC7e6uN0EEUAH6/RA4CdX79n4xi2A1D0DUPUKBRw+V1+NZxa3rq0YuT+PcA1y5l1hGpFFD/BqP2nLTB54ZZUbpe4rQLkoy42VcHH5u1pxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhvhSiow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59F8C4CED2;
	Thu,  7 Nov 2024 01:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730943830;
	bh=FhICeJvrCrMnhdIC0qbv97Akl1RvVJJpaEaD5gQEQkI=;
	h=From:Subject:Date:To:Cc:From;
	b=nhvhSiowtMf8/jmGZFs5hS9PWKjCrMfrUBKFofjAdOsy7xW4rruML9GDvgRv3864C
	 cL/xowZYZdQt07JxJBXHUOeVrTdY+qTLLuCFwyuLgPq9ZNXWgdpn8yrmDpiITcZBBZ
	 PuDFJXPmoDEGDK+jA+KlgKkXRuyWVCmHnLWEDWIf7R6iDd28Svw7xa0E//AvGon9XB
	 bfOlahysdUQK7jjMvBKNXEm4zXhuKq8hgrYVF5ps82dDdWpY2EcF/9eJDpOdJjj6Ug
	 dasT1MrzMMbpWomAw02dpYx0xVdQy6ttfWx3EBs8HVi5waNWLRpLir6Qm9Jd8gd5Om
	 XbNIqGFAl6XOQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/6] kselftest/arm64: Test floating point signal context
 restore in fp-stress
Date: Thu, 07 Nov 2024 01:39:19 +0000
Message-Id: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEcaLGcC/42NQQ6CMBBFr0Jm7RhaWyOuuIdh0dgpTFQgMw3RE
 O5u5QQu38//76+gJEwK12oFoYWVp7GAPVRwH8LYE3IsDLa2ztT2hEFeZ4dpRs1CqsginEOeBL0
 zPlFjQ6QEZT8LJX7v7ltXeGAttc9+tZhf+o91MVhj8CYk21yic037IBnpeZykh27bti+YJFURw
 wAAAA==
X-Change-ID: 20241023-arm64-fp-stress-irritator-5415fe92adef
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2115; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FhICeJvrCrMnhdIC0qbv97Akl1RvVJJpaEaD5gQEQkI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnLBtPi1qDcL+XawjQAGXXQlcQzDYJjTrJcbT0hrdY
 f6lTU3mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZywbTwAKCRAk1otyXVSH0KqqB/
 94CvW0iwYt/m+SSaM1tOpg0sIMZGdjqX9W9LiI1I9s+MgwaQO6VWnL1ZmxWKVBh4wtuqgnl8iGwh2s
 QeHdfTFAKXd6j7rDgD14MgjEZsu42KjRuey45UBc8zEUVhN1GJxshOfBz9pxcTC0o4TFlymX6UJhiF
 39++v7nxzary5Z1hwOv/WnIb68f4SgBDjbGxWICR0mYwl66Op/AYbzRkbveCGQoC/ud7f1vCVRYF2j
 RPnv4gU+VhDtXq6VxDPLFMlAItqxN4QsdXssCiikt9Sle5Cz4dSsiR7TVq6hnckL8kMI6NvmFcBOam
 TNoaSZZeMLYY2GObPj5bVHUN7tyLKJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently we test signal delivery to the programs run by fp-stress but
our signal handlers simply count the number of signals seen and don't do
anything with the floating point state.  The original fpsimd-test and
sve-test programs had signal handlers called irritators which modify the
live register state, verifying that we restore the signal context on
return, but a combination of misleading comments and code resulted in
them never being used and the equivalent handlers in the other tests
being stubbed or omitted.

Clarify the code, implement effective irritator handlers for the test
programs that can have them and then switch the signals generated by the
fp-stress program over to use the irritators, ensuring that we validate
that we restore the saved signal context properly.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Change instruction and commit log for corruption of predicat
  registers.
- Link to v1: https://lore.kernel.org/r/20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org

---
Mark Brown (6):
      kselftest/arm64: Correct misleading comments on fp-stress irritators
      kselftest/arm64: Remove unused ADRs from irritator handlers
      kselftest/arm64: Corrupt P0 in the irritator when testing SSVE
      kselftest/arm64: Implement irritators for ZA and ZT
      kselftest/arm64: Provide a SIGUSR1 handler in the kernel mode FP stress test
      kselftest/arm64: Test signal handler state modification in fp-stress

 tools/testing/selftests/arm64/fp/fp-stress.c   |  2 +-
 tools/testing/selftests/arm64/fp/fpsimd-test.S |  4 +---
 tools/testing/selftests/arm64/fp/kernel-test.c |  4 ++++
 tools/testing/selftests/arm64/fp/sve-test.S    |  8 +++-----
 tools/testing/selftests/arm64/fp/za-test.S     | 13 ++++---------
 tools/testing/selftests/arm64/fp/zt-test.S     | 13 ++++---------
 6 files changed, 17 insertions(+), 27 deletions(-)
---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241023-arm64-fp-stress-irritator-5415fe92adef

Best regards,
-- 
Mark Brown <broonie@kernel.org>


