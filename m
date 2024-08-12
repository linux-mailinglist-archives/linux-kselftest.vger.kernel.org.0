Return-Path: <linux-kselftest+bounces-15142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E2694E673
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 08:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1679B1C21678
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 06:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F167214D435;
	Mon, 12 Aug 2024 06:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="YDW8AKyK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C681843;
	Mon, 12 Aug 2024 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723443361; cv=pass; b=IesX6QGnoKJ2nlTPtqpvrupf1+Nrer/IKqtmYB+SdXVKQSzrTgvZ1djjBrZWZ/xKlQ1umB9VnFSuer0DRrBrRis/OvXdtvopLWfav5c6ov0ISkD3oggMfuOzdFd2N+SBotZtqL9xGlHhg4ji6PKzNI9ZHZuQ/ZEvNcoz1jVDwN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723443361; c=relaxed/simple;
	bh=f/eYtRVlvtArZufnNLipBAYpBhT9L1xyeL7LqObEKNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=syJAO1pSV/otsPwHl7gI1cwyuO77Fc057p4TMkESFH/YTnJzYFaCkx7FBV1RGPqBIMBjtfeyOcyazNip8+16oLZuJZZxQHUxUcc19IB+11xhxK3mIbcMtOTZpGQQ57rP3ssx35THRrkhmoQvxARqv4p5qYE9kV84CEaeYzAGEUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=YDW8AKyK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: usama.anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723443340; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SHyNfYppBl/+V0ObUII2nRZCKWvu6876axI196r1vH8Jbb5OLLXK3OgOY68BU6XSpeE9mhEsBytXDQZUEkIbZ8ruL5RtqnWlxFjL9I/K/FVnKHI0/69T2FI/5aunQWfS7P6/TZ4lgU/WVFGeuQddUmESRRV+nBONHByqIiv0Wmk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723443340; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LBR+TP/pJVKC9tpDa3zweS1u2fInPYeCnYBagTK31PI=; 
	b=bQS0HSDAotKeUXo1MhYtwkqxkDSVEdU/QKiPZS387fKDohKJl3mbluKnKh3RR5FWL+lVeZXG1ks+MB1FuV/ZAvkRIY5LFANMWRUrqiYhRidBsC3TUisxkh6/bCG2LtB2kxviV1gRCGBPd6LCsatd6SzCWWtZqEorL8CE6cOFSIc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723443340;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=LBR+TP/pJVKC9tpDa3zweS1u2fInPYeCnYBagTK31PI=;
	b=YDW8AKyKZ5UF/sQ7Ty/MR2YXXNUzW0al3MnD3Rg72PRa4RiMnQBU73N7xRlTIkSb
	7Gfm3WC2UhQNwyXPUhV+jEE9+an7z5xo7iGXZyAOsI8mr1zlFaIeLt+X7k1n3+/xDyW
	9jUv9PrQKoXs1+sZkCGLKcMFyHlO+CMB17k9nSI4=
Received: by mx.zohomail.com with SMTPS id 1723443338838423.1852483816655;
	Sun, 11 Aug 2024 23:15:38 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Mike Rapoport <rppt@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	stable@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2] selftests: memfd_secret: don't build memfd_secret test on unsupported arches
Date: Mon, 12 Aug 2024 11:15:22 +0500
Message-Id: <20240812061522.1933054-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

[1] mentions that memfd_secret is only supported on arm64, riscv, x86
and x86_64 for now. It doesn't support other architectures. I found the
build error on arm and decided to send the fix as it was creating noise
on KernelCI:

memfd_secret.c: In function 'memfd_secret':
memfd_secret.c:42:24: error: '__NR_memfd_secret' undeclared (first use in this function);
did you mean 'memfd_secret'?
   42 |         return syscall(__NR_memfd_secret, flags);
      |                        ^~~~~~~~~~~~~~~~~
      |                        memfd_secret

Hence I'm adding condition that memfd_secret should only be compiled on
supported architectures.

Also check in run_vmtests script if memfd_secret binary is present
before executing it.

[1] https://lore.kernel.org/all/20210518072034.31572-7-rppt@kernel.org/
Cc: stable@vger.kernel.org
Fixes: 76fe17ef588a ("secretmem: test: add basic selftest for memfd_secret(2)")
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Add error message to the patch and reviewed-by tags
---
 tools/testing/selftests/mm/Makefile       | 2 ++
 tools/testing/selftests/mm/run_vmtests.sh | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 1a83b70e84535..4ea188be0588a 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -53,7 +53,9 @@ TEST_GEN_FILES += madv_populate
 TEST_GEN_FILES += map_fixed_noreplace
 TEST_GEN_FILES += map_hugetlb
 TEST_GEN_FILES += map_populate
+ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64))
 TEST_GEN_FILES += memfd_secret
+endif
 TEST_GEN_FILES += migration
 TEST_GEN_FILES += mkdirty
 TEST_GEN_FILES += mlock-random-test
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 03ac4f2e1cce6..36045edb10dea 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -374,8 +374,11 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
 CATEGORY="madv_populate" run_test ./madv_populate
 
+if [ -x ./memfd_secret ]
+then
 (echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
 CATEGORY="memfd_secret" run_test ./memfd_secret
+fi
 
 # KSM KSM_MERGE_TIME_HUGE_PAGES test with size of 100
 CATEGORY="ksm" run_test ./ksm_tests -H -s 100
-- 
2.39.2


