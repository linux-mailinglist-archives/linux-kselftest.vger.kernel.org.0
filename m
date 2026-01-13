Return-Path: <linux-kselftest+bounces-48894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FABD1BA79
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 00:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FB7A3007496
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 23:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD41036A036;
	Tue, 13 Jan 2026 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="WfaiFmEl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028534F461;
	Tue, 13 Jan 2026 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768345766; cv=none; b=XSNKk3y+S1MhSXpmCuSttTej7NOQ5Cftr2J6ob+4hKJLSLRzoy8BJgBtOf65Zh5P5ZlrXHbq0ZgxqIrQdP6KEPeg1sv/WJ7tt6yhjki2IPhZ/vORH4qYycKFAH13UJPCNvvhUw8DHDs9w1kg5OSb3r9uR38ZLawLQwgFKtZlba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768345766; c=relaxed/simple;
	bh=B9pNp3j1Dj9Gcf7HZDzPCg5yLaHt4JAmlo7rzTbtwQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ce9MbY5bKrJDrhdrfGSbyCiDdr00VnYu56b+CpyKG01O/lF5t4jlkhSHXO5XSJbuN303+QWQ6dBXMY3poKztBKDcULM5kwiv53E0MLYb3vs5HwPmT21QUjH9Cf1TS24Q0RkOv6ICWZPKfBkO40nWB1Kvsue+J4otfqt9+96MaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=WfaiFmEl; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DN6m654099591;
	Tue, 13 Jan 2026 15:09:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=eZHIvPhwIUYdWzpFoeqwcw1qyPbDppq6+l09hYcGKV8=; b=WfaiFmElJc/B
	oajvlVP8x5nP2S/sOX85dhnBnqTajPjPzvz8yJ9T66kXsJgRfLcLt5ZedQTeIZiR
	nUGGKjLrbF3F79/3JHKwR0C6G/VxGs7m6c9rzNvzM8/vk3uEgHSAcOX0Ei5DXCt/
	U5vftRcVrRWBcIfBgQpPs50vXP3AKFb7O4F7M3zU3X7k+xAB+INoHAn1CqEMZiX8
	Dj5sVGId3AappPrq5B37tbk4ulzDAIQcxtLoaZXOGc00fxgH4YayQ2qOrQaCVKA3
	qtILW16cbAr4fflwG9uUa7tScaQYbAA8JxE4Te9OoJlKpFj4rs+wzuSB1WpWLNEt
	21CTan8FJw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bnyeh80r2-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Jan 2026 15:09:17 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 13 Jan 2026 23:09:03 +0000
From: Alex Mastro <amastro@fb.com>
Date: Tue, 13 Jan 2026 15:08:37 -0800
Subject: [PATCH v2 2/3] vfio: selftests: Align BAR mmaps for efficient
 IOMMU mapping
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260113-map-mmio-test-v2-2-e6d34f09c0bb@fb.com>
References: <20260113-map-mmio-test-v2-0-e6d34f09c0bb@fb.com>
In-Reply-To: <20260113-map-mmio-test-v2-0-e6d34f09c0bb@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>
CC: Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: Xk8r-uT5EcmcNacGhrw8qbwpOAc8frUU
X-Authority-Analysis: v=2.4 cv=brZBxUai c=1 sm=1 tr=0 ts=6966d09d cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=TV4XJVjupk0IgnZMQ3QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE4NyBTYWx0ZWRfX/i/BgLaftROT
 Kr6NB1Qp8uCSWgPidx/OdDmqoZGhxXIUq0u3WAM7YeK4lg72WLRkWKdEs4/5YrtH+Px84y6kAWJ
 G8kv9mRhwW2SD0q88ruMhKbDdyy4duEO9bz2bJwW8XMp7Wiyk10JYtfWP/qRnK0nClRabU9j9Nr
 ObBhbsu9lStG+dviv8PbPX1Isc9HiKwCgqrdNyJm0tf/r702IbA02v4oFyiIELTau4K+3qg7ftr
 F7XKgOCL9N+6Cq7zFZVN26EH9whANSiIj444ZmFZWj2QDZh65R1JkbvrGCwnFnNXbq0KebsktmL
 2Pb4PWIwDv1a5Ko0nyTiUJybYpfhR33sBXNMuzdpC+xeO0NkejPg4JXdFWcBTc/KhBsCX0TixQJ
 Mgc2u0UZUa5adG2WXmZKkUfDl0Pqu8mxp7ox7oC8vwrv9z1WuxGyFg61Cu/ECedwRLNaMRWiDZA
 /ncr9ApzgKSaVGNkt9A==
X-Proofpoint-GUID: Xk8r-uT5EcmcNacGhrw8qbwpOAc8frUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01

Update vfio_pci_bar_map() to align BAR mmaps for efficient huge page
mappings. The manual mmap alignment can be removed once mmap(!MAP_FIXED)
on vfio device fds improves to automatically return well-aligned
addresses.

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 tools/testing/selftests/vfio/lib/include/libvfio.h |  9 ++++++++
 tools/testing/selftests/vfio/lib/libvfio.c         | 25 ++++++++++++++++++++++
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 24 ++++++++++++++++++++-
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
index 279ddcd70194..5ebf8503586e 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
@@ -23,4 +23,13 @@
 const char *vfio_selftests_get_bdf(int *argc, char *argv[]);
 char **vfio_selftests_get_bdfs(int *argc, char *argv[], int *nr_bdfs);
 
+/*
+ * Reserve virtual address space of size at an address satisfying
+ * (vaddr % align) == offset.
+ *
+ * Returns the reserved vaddr. The caller is responsible for unmapping
+ * the returned region.
+ */
+void *mmap_aligned(size_t size, size_t align, size_t offset);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_H */
diff --git a/tools/testing/selftests/vfio/lib/libvfio.c b/tools/testing/selftests/vfio/lib/libvfio.c
index a23a3cc5be69..4529bb1e69d1 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.c
+++ b/tools/testing/selftests/vfio/lib/libvfio.c
@@ -2,6 +2,9 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/mman.h>
+
+#include <linux/align.h>
 
 #include "../../../kselftest.h"
 #include <libvfio.h>
@@ -76,3 +79,25 @@ const char *vfio_selftests_get_bdf(int *argc, char *argv[])
 
 	return vfio_selftests_get_bdfs(argc, argv, &nr_bdfs)[0];
 }
+
+void *mmap_aligned(size_t size, size_t align, size_t offset)
+{
+	void *map_base, *map_align;
+	size_t delta;
+
+	VFIO_ASSERT_GT(align, offset);
+	delta = align - offset;
+
+	map_base = mmap(NULL, size + align, PROT_NONE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	VFIO_ASSERT_NE(map_base, MAP_FAILED);
+
+	map_align = (void *)(ALIGN((uintptr_t)map_base + delta, align) - delta);
+
+	if (map_align > map_base)
+		VFIO_ASSERT_EQ(munmap(map_base, map_align - map_base), 0);
+
+	VFIO_ASSERT_EQ(munmap(map_align + size, map_base + align - map_align), 0);
+
+	return map_align;
+}
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 13fdb4b0b10f..03f35011b5f7 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -12,10 +12,14 @@
 #include <sys/mman.h>
 
 #include <uapi/linux/types.h>
+#include <linux/align.h>
 #include <linux/iommufd.h>
+#include <linux/kernel.h>
 #include <linux/limits.h>
+#include <linux/log2.h>
 #include <linux/mman.h>
 #include <linux/overflow.h>
+#include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/vfio.h>
 
@@ -124,20 +128,38 @@ static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
 static void vfio_pci_bar_map(struct vfio_pci_device *device, int index)
 {
 	struct vfio_pci_bar *bar = &device->bars[index];
+	size_t align, size;
+	void *vaddr;
 	int prot = 0;
 
 	VFIO_ASSERT_LT(index, PCI_STD_NUM_BARS);
 	VFIO_ASSERT_NULL(bar->vaddr);
 	VFIO_ASSERT_TRUE(bar->info.flags & VFIO_REGION_INFO_FLAG_MMAP);
+	VFIO_ASSERT_TRUE(is_power_of_2(bar->info.size));
 
 	if (bar->info.flags & VFIO_REGION_INFO_FLAG_READ)
 		prot |= PROT_READ;
 	if (bar->info.flags & VFIO_REGION_INFO_FLAG_WRITE)
 		prot |= PROT_WRITE;
 
-	bar->vaddr = mmap(NULL, bar->info.size, prot, MAP_FILE | MAP_SHARED,
+	size = bar->info.size;
+
+	/*
+	 * Align BAR mmaps to improve page fault granularity during potential
+	 * subsequent IOMMU mapping of these BAR vaddr. 1G for x86 is the
+	 * largest hugepage size across any architecture, so no benefit from
+	 * larger alignment. BARs smaller than 1G will be aligned by their
+	 * power-of-two size, guaranteeing sufficient alignment for smaller
+	 * hugepages, if present.
+	 */
+	align = min_t(size_t, size, SZ_1G);
+
+	vaddr = mmap_aligned(size, align, 0);
+	bar->vaddr = mmap(vaddr, size, prot, MAP_SHARED | MAP_FIXED,
 			  device->fd, bar->info.offset);
 	VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
+
+	madvise(bar->vaddr, size, MADV_HUGEPAGE);
 }
 
 static void vfio_pci_bar_unmap(struct vfio_pci_device *device, int index)

-- 
2.47.3


