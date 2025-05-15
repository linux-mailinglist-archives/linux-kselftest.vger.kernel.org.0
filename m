Return-Path: <linux-kselftest+bounces-33074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD68AB8305
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 11:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE68B16C3CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 09:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E32D297A7A;
	Thu, 15 May 2025 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkSkCvv/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073951B043A;
	Thu, 15 May 2025 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301792; cv=none; b=i/WvCMXreIPshV6piwdJbg2F6c2dw+y2RMlKKMH/2N0NA741qurkJ0U0Ibpu26yBL0/adi/o2uu0WlGdieA2FgItoPi46rRhU6nDZBvUjTG0swzHTxGu6YFNqooypJcKTp7RY2rYPkR/VVGHTCdaKRNnrSgd8aurzn4IvMrEaFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301792; c=relaxed/simple;
	bh=RNbOB4JssaWHI9LRCsaHw4fkLJsTr5HaZucQ0Gj185E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Mkc2vXloNNH6nfRIJ3CM+9bf3M/ctToo6EJpql8URnjM3Uxc1sYqs/hdIJvOaT7bj/sle6Kt8Ii+VJW2/DPEfen/0y+aBYT5vGcErBCXIAsYjH5DZc1ObvUlzHE0jrUZqHGoMfbWM2Qktqjb7wM3I1pqZHfJ6suVWp9H0GXntbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkSkCvv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8F8C4CEED;
	Thu, 15 May 2025 09:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747301791;
	bh=RNbOB4JssaWHI9LRCsaHw4fkLJsTr5HaZucQ0Gj185E=;
	h=From:Date:Subject:To:Cc:From;
	b=MkSkCvv//G0bHIZ/pvx/W2loDBZtzmQB3ShRugy4ISTGqlHAmv/y+ri6AmYdxjz1+
	 uuRtyO/jNbZOQtMpP8AfUYlQREHF7TeAlWwFjKCpUS7RolPif66sujI675DWdodO3U
	 wcnWMCHPYuNpp2sq8DLeDWkA3TRkDgIqEcI8d5qokGAjIuaaMq+RgFWrSGjmIrSyDO
	 bNWBLksEJzy5Utqdkl8qHQPOpP6fB1CgHJCl9/D+kfrW2V2MnFnSWBsowhkrh/YgyY
	 zIytmKALyhfhzG1UcyIlGGlk/+OzoNLWhFrFer9PViKZ6MFC0O+Z0xV/L9Ki5FQiVb
	 nkL56OvrUl88g==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 15 May 2025 11:36:14 +0200
Subject: [PATCH] selftests/mm: Deduplicate default page size test results
 in thuge-gen
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-selfests-mm-thuge-gen-dup-v1-1-057d2836553f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAI21JWgC/x2MwQqEMAwFf0Vy3kAjuqK/InsQfWpgrdKoCMV/t
 3gcmJlIhqAwarJIAaearj6BfDLq585PYB0SU+7y0pVSsOE/wnbjZeF9PpIwwfNwbFxB+sJV8nW
 1UOq3gFGv993+7vsBjUNIs2sAAAA=
X-Change-ID: 20250514-selfests-mm-thuge-gen-dup-7e1c40716091
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RNbOB4JssaWHI9LRCsaHw4fkLJsTr5HaZucQ0Gj185E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoJbWbwn6i0obh2WWDI5f8olJqBS4gtUHQKPSiX
 fToM2oZTlKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaCW1mwAKCRAk1otyXVSH
 0GUXB/9JSb3quOlK8ePYtzQPVfMLMa8CQqWcFy/79iTsgLUtwboO0Q/raM2DX//eysClDbMKREz
 8L6XmJV1kOtFN+RAJjAXTWZaUmSekleVHvxe6dqFW9xHrumKAA0dBEUNRiPhhK4D9sQuW9/GjsQ
 H90yjRlYibmIYQM7WMKNGuzmJaqc5mOZsJ57XwYCicfMuJsfH0lV131Oi7hA7cf4RO0WA06L0uY
 G+mCC9bLwqlXSqOIhAUphnEWcbR/fVHfN/9NQ2vVNdrP9TP+jM9iULRLNp4Ng/s9/SzYkq4j5ko
 EI64CBoRv4GicBlmj+aAlC5pmOzN6SY58rti7IIzVvahjgHP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The thuge-gen test program runs mmap() and shmget() tests for both every
available page size and the default page size, resulting in two tests for
the default size. These tests are distinct since the flags in the default
case do not specify an explicit size, add the flags to the test name that
is logged to deduplicate.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/thuge-gen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index cd5174d735be..a41bc1234b37 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -127,7 +127,7 @@ void test_mmap(unsigned long size, unsigned flags)
 
 	show(size);
 	ksft_test_result(size == getpagesize() || (before - after) == NUM_PAGES,
-			 "%s mmap %lu\n", __func__, size);
+			 "%s mmap %lu %x\n", __func__, size, flags);
 
 	if (munmap(map, size * NUM_PAGES))
 		ksft_exit_fail_msg("%s: unmap %s\n", __func__, strerror(errno));
@@ -165,7 +165,7 @@ void test_shmget(unsigned long size, unsigned flags)
 
 	show(size);
 	ksft_test_result(size == getpagesize() || (before - after) == NUM_PAGES,
-			 "%s: mmap %lu\n", __func__, size);
+			 "%s: mmap %lu %x\n", __func__, size, flags);
 	if (shmdt(map))
 		ksft_exit_fail_msg("%s: shmdt: %s\n", __func__, strerror(errno));
 }

---
base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
change-id: 20250514-selfests-mm-thuge-gen-dup-7e1c40716091

Best regards,
-- 
Mark Brown <broonie@kernel.org>


