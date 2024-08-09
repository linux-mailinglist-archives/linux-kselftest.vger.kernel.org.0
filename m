Return-Path: <linux-kselftest+bounces-15058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9523094CBC4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 09:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C668E1C2092A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 07:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAE018C345;
	Fri,  9 Aug 2024 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="baoEat06"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629DF148FF6;
	Fri,  9 Aug 2024 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190245; cv=pass; b=ApcK7SJfP/dRs22g4iDmSQ24q81oE9Oyxz7Zokeptrh/oDLmxD7lEijhbCeLZqfvGG+ITSlAa3WkxyKO3+ZIpprLCAl7LRuXsmxSHtVCICzZDgJDFmPlhRA4WXC73pnOMppu2CrFhs7GQ4zGIV23gmpBGE/bD/1oyfGG27I4CM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190245; c=relaxed/simple;
	bh=IgK/VjeXR/viGZbuKEHuWnGeds1bN+eUNFUWUYgr1Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dQlFjgvExkOEKNY2wwJhau/kpPII7LwMqpivnFHj6oJ4oK4kH+kVnqgEptqO/4+hOsV/fCrb1LghQEWU+r+Uf0Esx0pDG0F8piIPYyBfnG4RjPo1Apo7DeBjIEBwPahlf23QNl08YATQCCClP7WZd1zOdkCXOFrThemsY6rli6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=baoEat06; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: usama.anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723190225; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hc7RzBokHDN2N9oNmXMxZQ2W2gtcn4BfdhAo7EGb5VOW/IWpn5FKeke0G3JR3FfxuGc/GLuxIeuWp1mKevBXTQ0yoFe2a3zPSkk4IfDoQP2BBOb/X8Ai/p74KrUBb/mkUhitK0oBT9/ylttChDbd4jVtbdN09YT58hqqQivyvas=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723190225; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=icKPXt17t9Kx30jQW8DqzSUWcb+Xzik3rs56lRblVGo=; 
	b=S+rqzHnzIgpu9k8DyzqRY6iDpo22yYa5iGor6HDiruYIyTjdobZ2Ss7L20DnlrFjjZQKRQ9KrAQwxqrA8NZueRUT922z+kf2V44ZP1POeZgP7+rdvsJtDGSkJY/F4AjqomZBwl8EVzETE/LICgSEJCjNikVE/0Xklu6ipCKfzIc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723190225;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=icKPXt17t9Kx30jQW8DqzSUWcb+Xzik3rs56lRblVGo=;
	b=baoEat06HZ2Q4x+RKme432Zc7LrqBMAMUPE0jUd68CNpaX4vyylF3E5BbSbBCd78
	J3hjUfJbGvhCJtRM4e62TTgXeA9M9qfQRAQJRyqEO3Si3TsxoO6fb3Alsn8U+1LhW4O
	kG9VU8VXXd+Hhv3AjWM/56WC0h6yuPivTzf2tGt4=
Received: by mx.zohomail.com with SMTPS id 1723190224501788.7935482020652;
	Fri, 9 Aug 2024 00:57:04 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mike Rapoport <rppt@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	stable@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] selftests: memfd_secret: don't build memfd_secret test on unsupported arches
Date: Fri,  9 Aug 2024 12:56:42 +0500
Message-Id: <20240809075642.403247-1-usama.anjum@collabora.com>
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
on KernelCI. Hence I'm adding condition that memfd_secret should only be
compiled on supported architectures.

Also check in run_vmtests script if memfd_secret binary is present
before executing it.

[1] https://lore.kernel.org/all/20210518072034.31572-7-rppt@kernel.org/
Cc: stable@vger.kernel.org
Fixes: 76fe17ef588a ("secretmem: test: add basic selftest for memfd_secret(2)")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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


