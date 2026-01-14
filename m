Return-Path: <linux-kselftest+bounces-48970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E82A3D20EDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 19:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52638300E4E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4B833CE81;
	Wed, 14 Jan 2026 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="xrXzEiHR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658053358B5;
	Wed, 14 Jan 2026 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417052; cv=none; b=NYhpCVtMcZ4jl33teb4lLsZIXMEfPqytDPPJ/1lxL1SUyJl+CiE/5pQfJgCMs6kRHoIPRNKyGFqJiuENpVGIifKoKp8I608BAgyvrOcYmYJniIeQITTK89+8hu6cVYPnNEyJi9XhIPNxA2rQgaeL0teSXNqufTOWTXQoZWcE7U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417052; c=relaxed/simple;
	bh=P+ylyyobdRfpqyKGD4M7CxJZEK93xTbybC+YMGYjj08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=M6qnHpDDC18tRYl3N6bYs2Ld8vQeIeI+KKAq4qsOtaDe7IZadAPE1S6M6sF86canrLbpFQIf7o/PLou6+aNv/RRPL4lhtZfF0Kism4VlFJy/hgrF+NHSyYX0HI4Kso6G4Fe45XnpljkPbATW2k/OF7bs+krCR7nseTTH/OJsasM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=xrXzEiHR; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EHQReI2373504;
	Wed, 14 Jan 2026 10:57:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=kPgcrMq0L8Gnl5U3jocAvSuj28CbtC+KeunoTaPsmDc=; b=xrXzEiHRZhXk
	Rla8WQal/Y53GTcUzWOOF4+B1elkz7eVVxw64LnkfUpCbWOsr/+bxbx7P6QHgIH3
	rjpngutidc/Np4oqN8o2IwWV54wee+SAOtTw69Kj3CZ08tpi5S4WF57M7Lkm3xBN
	j5f+4LjwTINaWkFmT8KM9st2q0idVNYerkaKA59AHRYWWD9EPfXSa0EmYt+E+K5p
	IMi99EX15WN1Aft2S/585XqUUREraF5s0HBcCcQ6r4kfa9dkHfStdYOEVwvxdFc5
	/xzH7trk3M23IHNej1UJ3nyAXYj7/C+TjhVtEKeI9ezuJwTtfmC5+Nb3oQ0slAiC
	JXJ7p8HXww==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bpactbmre-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Jan 2026 10:57:23 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 14 Jan 2026 18:57:22 +0000
From: Alex Mastro <amastro@fb.com>
Date: Wed, 14 Jan 2026 10:57:17 -0800
Subject: [PATCH v3 2/3] vfio: selftests: Align BAR mmaps for efficient
 IOMMU mapping
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260114-map-mmio-test-v3-2-44e036d95e64@fb.com>
References: <20260114-map-mmio-test-v3-0-44e036d95e64@fb.com>
In-Reply-To: <20260114-map-mmio-test-v3-0-44e036d95e64@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>
CC: Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: TPP7iQMnzfIvC12AA245AjY7hERbzSFB
X-Authority-Analysis: v=2.4 cv=d5f4CBjE c=1 sm=1 tr=0 ts=6967e713 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=TV4XJVjupk0IgnZMQ3QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TPP7iQMnzfIvC12AA245AjY7hERbzSFB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE1NiBTYWx0ZWRfXyA6sn1ky1TnX
 fXF5tQj642WLXuG7d9OAVubJ3zcqrVXkc1RPC86aaLdvZnfWUphksnWE75xz4Dv0397lNsvalDd
 cb54vOxWy2LVef1MhgmXdbSjRw8dDm8so9+yIlA60IvDyhv/HyJeiWgT6qmdKc9C5pQl+Ny4Kv6
 bFgt2slyONvPORoNQE9H9qlRxbpd5l1jPnQST4+QzkoDG2azML6jsB3LbUp1k1cV6Cypy0VQuBe
 f6C1QiJWYJG6jQGWSjcX92CdcPDvF/OV7aJ7ouJpjp7OY3i2ae01ApT4NyIjmjm7lYlgHBqLTLq
 o3Yq/wyF+fjBXQTnfykDm6yBxcHN0strYnNPhIGtGJxXWQfGGKXo5RLTOEsSAOGY6FzrtPP06ZV
 VvxqLupSfeFXAf1jRfKpINuV+1pQOKQcdjtqboQ3ljZ570tWWt2T4tURznpbRl9KzWCUo9TPjl2
 oiJEFj1Ql0623mZb5Lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_06,2026-01-14_01,2025-10-01_01

Update vfio_pci_bar_map() to align BAR mmaps for efficient huge page
mappings. The manual mmap alignment can be removed once mmap(!MAP_FIXED)
on vfio device fds improves to automatically return well-aligned
addresses.

Also add MADV_HUGEPAGE, which encourages the kernel to use huge pages
(e.g. when /sys/kernel/mm/transparent_hugepage/enabled is set to "madvise").

Drop MAP_FILE from mmap(). It is an ignored compatibility flag.

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 tools/testing/selftests/vfio/lib/include/libvfio.h |  9 ++++++++
 tools/testing/selftests/vfio/lib/libvfio.c         | 25 ++++++++++++++++++++++
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 24 ++++++++++++++++++++-
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
index 279ddcd70194..1b6da54cc2cb 100644
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
+void *mmap_reserve(size_t size, size_t align, size_t offset);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_H */
diff --git a/tools/testing/selftests/vfio/lib/libvfio.c b/tools/testing/selftests/vfio/lib/libvfio.c
index a23a3cc5be69..3a3d1ed635c1 100644
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
+void *mmap_reserve(size_t size, size_t align, size_t offset)
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
index 13fdb4b0b10f..2e0721d58078 100644
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
 	int prot = 0;
+	void *vaddr;
 
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
+	vaddr = mmap_reserve(size, align, 0);
+	bar->vaddr = mmap(vaddr, size, prot, MAP_SHARED | MAP_FIXED,
 			  device->fd, bar->info.offset);
 	VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
+
+	madvise(bar->vaddr, size, MADV_HUGEPAGE);
 }
 
 static void vfio_pci_bar_unmap(struct vfio_pci_device *device, int index)

-- 
2.47.3


