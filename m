Return-Path: <linux-kselftest+bounces-35725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0A0AE7492
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 04:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2827617B3DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 02:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82B61A08A6;
	Wed, 25 Jun 2025 02:01:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B136A31;
	Wed, 25 Jun 2025 02:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750816908; cv=none; b=J2nAc+nraPRygN/3pFNiZhuPCDEyeFzyDOnw71JL2iNIsr6biqB9JqQHYtkEG3Y0hT5zX4LSLsp7Vl08m6Ig/tEiYr6re422LvAMeDiPSvzafeTxAPhdLGEHQHAnjo8r6dP8K4pjUAy98ZEhJXC7h6CSLZnGX5PPt8rtjO9W9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750816908; c=relaxed/simple;
	bh=7MNcrqbYvIa9uEV1WjnYKRjw0yth5N9qeip8ghL2oks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LGjuoRPKNDUWWKqca0yDFRJucasD5cEUYxvOuhzQAn/QjWQg+/iyp6qqZkD04ooDxxdmvMB/SF557ZvjuAyQl1GZED6FM4gFm5C42fwqYPDG/667jMKTF/PNC/YDdTOB52cKdCQgYoeroriJKMZl4dKYXrA3E1zAcYxDaYq301Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 513E0113E;
	Tue, 24 Jun 2025 19:01:27 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 30DA33F63F;
	Tue, 24 Jun 2025 19:01:44 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/arm64: Prevent build warnings from -Wmaybe-uninitialized
Date: Wed, 25 Jun 2025 03:01:38 +0100
Message-Id: <20250625020138.3777454-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Arguments passed into WEXITSTATUS() should have been initialized earlier.
Otherwise following warning show up while building platform selftests on
arm64. Hence just zero out all the relevant local variables to avoid the
build warning.

Warning: ‘status’ may be used uninitialized in this function [-Wmaybe-uninitialized]

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.16-rc3

 tools/testing/selftests/arm64/abi/tpidr2.c    | 2 +-
 tools/testing/selftests/arm64/fp/za-fork.c    | 2 +-
 tools/testing/selftests/arm64/gcs/basic-gcs.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/tpidr2.c b/tools/testing/selftests/arm64/abi/tpidr2.c
index eb19dcc37a755..389a60e5feabf 100644
--- a/tools/testing/selftests/arm64/abi/tpidr2.c
+++ b/tools/testing/selftests/arm64/abi/tpidr2.c
@@ -96,7 +96,7 @@ static int write_sleep_read(void)
 static int write_fork_read(void)
 {
 	pid_t newpid, waiting, oldpid;
-	int status;
+	int status = 0;
 
 	set_tpidr2(getpid());
 
diff --git a/tools/testing/selftests/arm64/fp/za-fork.c b/tools/testing/selftests/arm64/fp/za-fork.c
index 587b946482226..6098beb3515a0 100644
--- a/tools/testing/selftests/arm64/fp/za-fork.c
+++ b/tools/testing/selftests/arm64/fp/za-fork.c
@@ -24,7 +24,7 @@ int verify_fork(void);
 int fork_test_c(void)
 {
 	pid_t newpid, waiting;
-	int child_status, parent_result;
+	int child_status = 0, parent_result;
 
 	newpid = fork();
 	if (newpid == 0) {
diff --git a/tools/testing/selftests/arm64/gcs/basic-gcs.c b/tools/testing/selftests/arm64/gcs/basic-gcs.c
index 3fb9742342a34..2b350b6b7e12c 100644
--- a/tools/testing/selftests/arm64/gcs/basic-gcs.c
+++ b/tools/testing/selftests/arm64/gcs/basic-gcs.c
@@ -240,7 +240,7 @@ static bool map_guarded_stack(void)
 static bool test_fork(void)
 {
 	unsigned long child_mode;
-	int ret, status;
+	int ret, status = 0;
 	pid_t pid;
 	bool pass = true;
 
-- 
2.30.2


