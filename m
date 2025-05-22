Return-Path: <linux-kselftest+bounces-33511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EACBAC123D
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 19:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C373B1D40
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D6418FDBE;
	Thu, 22 May 2025 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYuIKn4m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5063917C21B;
	Thu, 22 May 2025 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935553; cv=none; b=dmM5i1wRgoyM1PtG6U4faJVHAiN+qI7P9fYsNI0IcZVqCP/wMl0n0YM2lJ82cLb2nmplK2jLWF/iQliX90asxpoYpa31rg9gCjhb3YY41d1eeaD26Ikn0gMDm/igDYRG5DfGY1ODkmhEoSprsdypDmiHgR53LcebYLKMnBoRThs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935553; c=relaxed/simple;
	bh=kgbWheyQMuJdECLUgmaNHFbrRwfObFbfUl+lWV3YBo4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dyV9wsvjnsPrtrhbGmOaNPSHXPEY4kfhwYplRamr9dorTI5C10Tf7TV84EmU/xgDqBC/wIUZYNgliI6xHAoHbkDInCTjlmQYmA6gTzKD6uzdSI5wsIGjwgb9msirhUbodtF3T+RgvGbBHz4UnN1k8OE08D1m3qCX0R+sD9xRwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYuIKn4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FAAC4CEE4;
	Thu, 22 May 2025 17:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747935553;
	bh=kgbWheyQMuJdECLUgmaNHFbrRwfObFbfUl+lWV3YBo4=;
	h=From:Subject:Date:To:Cc:From;
	b=aYuIKn4mtf1fpV7WvGnx/HJmg/2WKqAr/0U7KQcQKm4RxzzaolB9seDctEAhLnvfr
	 7P9+P/DqZNvCBdfQz3CvhW7eA6Owgj0Coha0wE5YrVsxoKgjaihMpx+mY487hZwRPe
	 ScPIABFfNTABaLQrzNmAvufhblHy+ogfYBSTC5mzKMX5NWw7CQ0eKN1/Mnm8fiTOIx
	 qxcbc6vhng8o9Y5iTDUBhRkVC1nMYqtQXNkKmpnqeFqbNj0Tj0NvbR1cV2o0ITBFul
	 jKiZRNH1Sn9Ajj8rR0tppqGjQoFcPIRNAeHPoViHmoe6yMwnJ38M/jBEdfmfBURdQR
	 dugCROI5PRmFQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/4] selftests/mm: cow and gup_longterm cleanups
Date: Thu, 22 May 2025 18:38:49 +0100
Message-Id: <20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACphL2gC/x3MywqDMBBG4VeRWTsQkwaKryIuNPnVgXohY6sgv
 ruhy29xzkWKJFCqi4sSfqKyLhlVWVCYumUES8wma6w33las+Aw7dFeeZw7rwRHxu4Gdi6HrjXt
 5/6ZcbwmDnP9z0973A8zuE2BpAAAA
X-Change-ID: 20250521-selftests-mm-cow-dedupe-33dcab034558
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=broonie@kernel.org;
 h=from:subject:message-id; bh=kgbWheyQMuJdECLUgmaNHFbrRwfObFbfUl+lWV3YBo4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoL2E6OWupulF9lD6yYXCHNGs8KxX0yaolE8vQ+6V3
 MzYpkGWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaC9hOgAKCRAk1otyXVSH0FStB/
 wMfgXECNR3OUpnWUaJlKD7VWfSCaTRZHUBrfH68PkAOg17xts0cDjhd3YqSj8heoy0WrziPPomUEaG
 FUtj6BX/iL05Lu5TbdbELcF3hi6EQ+9fBPo5nGCt180qvITB7huCQImgOvZ/AZGijotRYdDENvWsGE
 2HVb7k9SC7eCGeDtMSnBn4Hu21cpimqIWTVmeQINnpAQlyIaTspUx/I8bWfH0Eon1Ctu67+a06KHRI
 GQsmDyDCTAThcbo0jXQSFhf7CzAz3DqcM2/OYST4yLSbT9l0E8llTk4LVaG4UpzCCOoXiEwJBRylTX
 tT4ro9CYlww+33FPORNzSz9o7S/j2h
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The bulk of these changes modify the cow and gup_longterm tests to
report unique and stable names for each test, bringing them into line
with the expectations of tooling that works with kselftest.  The string
reported as a test result is used by tooling to both deduplicate tests
and track tests between test runs, using the same string for multiple
tests or changing the string depending on test result causes problems
for user interfaces and automation such as bisection.

It was suggested that converting to use kselftest_harness.h would be a
good way of addressing this, however that really wants the set of tests
to run to be known at compile time but both test programs dynamically
enumarate the set of huge page sizes the system supports and test each.
Refactoring to handle this would be even more invasive than these
changes which are large but straightforward and repetitive.

A version of the main gup_longterm cleanup was previously sent
separately, this version factors out the helpers for logging the start
of the test since the cow test looks very similar.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (4):
      selftests/mm: Use standard ksft_finished() in cow and gup_longterm
      selftest/mm: Add helper for logging test start and results
      selftests/mm: Report unique test names for each cow test
      selftests/mm: Fix test result reporting in gup_longterm

 tools/testing/selftests/mm/cow.c          | 340 +++++++++++++++++++-----------
 tools/testing/selftests/mm/gup_longterm.c | 158 ++++++++------
 tools/testing/selftests/mm/vm_util.h      |  20 ++
 3 files changed, 334 insertions(+), 184 deletions(-)
---
base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
change-id: 20250521-selftests-mm-cow-dedupe-33dcab034558

Best regards,
-- 
Mark Brown <broonie@kernel.org>


