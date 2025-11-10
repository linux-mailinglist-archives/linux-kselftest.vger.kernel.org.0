Return-Path: <linux-kselftest+bounces-45254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27652C495E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B96188207C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 21:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EA62F83BC;
	Mon, 10 Nov 2025 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="vSF+kPoP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705742DECAA;
	Mon, 10 Nov 2025 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809095; cv=none; b=UOL2D5k0AHr8GQsGXyfIzbdU3nJnR7/ipewAZ/6nDVSw17YFWx9MOpVA8IUSnB70L+jdwGHFBtFX5fZcz0wIQ76nba62hPvFoSrk5bUCbEwPwF5m72Cj9sZD1YDEKonaMs0Xve1DkgGwg17B7oLLekw7cY6+cZeivRgOYt6XeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809095; c=relaxed/simple;
	bh=CvNCzClS3F9CeS6NlOXQoYzHdFP2wQlqK609RvrY0lE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HpPFSa/qG+YT2CwNrHQBKmZgsebJewcacFALn2yJwRPTPcCjlCohUlDFb5yWVER99y6NkGRCo4K83wuRcEFp/3Sex9ty6wbnUu3BC+8uH23eMA+W62rDnaiDWc2eMyBpvSSOvoyufrIaai2GZSLBcpSfdQ9iYDlAJ33K0eboqq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=vSF+kPoP; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5AAL4UPe3887404;
	Mon, 10 Nov 2025 13:11:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=XZrTORv8/MEDMS/mIwjcBCcw44J2F1zST6nf6nBGOFA=; b=vSF+kPoPiErQ
	ej8d1JA84k8znzm708wHaE5nf0tsLPz5XGCaGir/P/8KelY8GGCJPzeBP9fqsIxq
	aFK53979nZYPzN1i0zDAUzVTJNTYAteaqfgzbNEMlM+B1n2HWekN1VhlI3i9Cq/w
	1DIs8UyYZ23T5atSMlD1cC1LYE6APEMO7GfHhZ1zGUGqhfvuKFemLStynGdhzlX/
	OJMNVbSdLzixgGxIqLx9ixdUkZyV5zZcjceg9iRyqwiCjKGwG5hvEAGoqm3Cls+m
	oUOfPa37nFbNfwQI0CezQkGiQKk+lq5anhnWlW4pezfcC4T1s8D7mdn2CVTHbJkx
	kWGN78q+Tw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4abqn6r1sm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Nov 2025 13:11:27 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 10 Nov 2025 21:11:25 +0000
From: Alex Mastro <amastro@fb.com>
Date: Mon, 10 Nov 2025 13:10:41 -0800
Subject: [PATCH 1/4] vfio: selftests: add iova range query helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251110-iova-ranges-v1-1-4d441cf5bf6d@fb.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
In-Reply-To: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro <amastro@fb.com>,
        Jason Gunthorpe
	<jgg@ziepe.ca>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: sC6y3rFXGFCzIc6DgSpnuzMGAHA-Upyx
X-Proofpoint-ORIG-GUID: sC6y3rFXGFCzIc6DgSpnuzMGAHA-Upyx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3OSBTYWx0ZWRfXxtql15zP4Akx
 HKYqXNE2AtiF0yKwcJRLfugSgNTfA6a2dihdd3ulDC9F8o91uTZw8c5KzmhoZ8s9EiH9Eaf4Fxu
 3TUQVXoDQStS6ph4yS5ivIj02+rRecIB5A83mWGJM9jnGMDHcVUSbV9xBfeqcsWhF8c7bx0xyly
 L0HRBiMtjkwJipCQz/vrRWYkBNwUvrrqUZrS1y12SV2PJgsq7y2LJtXRq7rMkj2yMTmMNS4Hxyv
 g888kmXkEyam8qnfMxiwy15wu3tE3I1W6NBChc0ahrfeHjlaS+d6KVStTA5McrRpHoWMeWh74mY
 wbcfzGSi5mdxaTK/V293lZPmvTCpf81lhNaSs690YD89xvNNZIcLnFo/fMldogft9OKRH8aag0S
 3zyQou3ZLHy8JbJbgZmdCVyh5kl2YQ==
X-Authority-Analysis: v=2.4 cv=Qdprf8bv c=1 sm=1 tr=0 ts=691254ff cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=Xs3x4vty3K2JW6oWMr8A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01

VFIO selftests need to map IOVAs from legally accessible ranges, which
could vary between hardware. Tests in vfio_dma_mapping_test.c are making
excessively strong assumptions about which IOVAs can be mapped.

Add vfio_iommu_iova_ranges(), which queries IOVA ranges from the
IOMMUFD or VFIO container associated with the device. The queried ranges
are normalized to IOMMUFD's iommu_iova_range representation so that
handling of IOVA ranges up the stack can be implementation-agnostic.
iommu_iova_range and vfio_iova_range are equivalent, so bias to using the
new interface's struct.

Query IOMMUFD's ranges with IOMMU_IOAS_IOVA_RANGES.
Query VFIO container's ranges with VFIO_IOMMU_GET_INFO and
VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE.

The underlying vfio_iommu_type1_info buffer-related functionality has
been kept generic so the same helpers can be used to query other
capability chain information, if needed.

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 .../testing/selftests/vfio/lib/include/vfio_util.h |   8 +-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 161 +++++++++++++++++++++
 2 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 240409bf5f8a..fb5efec52316 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -4,9 +4,12 @@
 
 #include <fcntl.h>
 #include <string.h>
-#include <linux/vfio.h>
+
+#include <uapi/linux/types.h>
+#include <linux/iommufd.h>
 #include <linux/list.h>
 #include <linux/pci_regs.h>
+#include <linux/vfio.h>
 
 #include "../../../kselftest.h"
 
@@ -206,6 +209,9 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 void vfio_pci_device_reset(struct vfio_pci_device *device);
 
+struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
+					      size_t *nranges);
+
 int __vfio_pci_dma_map(struct vfio_pci_device *device,
 		       struct vfio_dma_region *region);
 int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index a381fd253aa7..6bedbe65f0a1 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -29,6 +29,167 @@
 	VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
 } while (0)
 
+static struct vfio_info_cap_header *next_cap_hdr(void *buf, size_t bufsz,
+						 size_t *cap_offset)
+{
+	struct vfio_info_cap_header *hdr;
+
+	if (!*cap_offset)
+		return NULL;
+
+	/* Cap offset must be in bounds */
+	VFIO_ASSERT_LT(*cap_offset, bufsz);
+	/* There must be enough remaining space to contain the header */
+	VFIO_ASSERT_GE(bufsz - *cap_offset, sizeof(*hdr));
+
+	hdr = (struct vfio_info_cap_header *)((u8 *)buf + *cap_offset);
+
+	/* If there is a next, offset must increase by at least the header size */
+	if (hdr->next) {
+		VFIO_ASSERT_GT(hdr->next, *cap_offset);
+		VFIO_ASSERT_GE(hdr->next - *cap_offset, sizeof(*hdr));
+	}
+
+	*cap_offset = hdr->next;
+
+	return hdr;
+}
+
+static struct vfio_info_cap_header *vfio_iommu_info_cap_hdr(struct vfio_iommu_type1_info *buf,
+							    u16 cap_id)
+{
+	struct vfio_info_cap_header *hdr;
+	size_t cap_offset = buf->cap_offset;
+
+	if (!(buf->flags & VFIO_IOMMU_INFO_CAPS))
+		return NULL;
+
+	if (cap_offset)
+		VFIO_ASSERT_GE(cap_offset, sizeof(struct vfio_iommu_type1_info));
+
+	while ((hdr = next_cap_hdr(buf, buf->argsz, &cap_offset))) {
+		if (hdr->id == cap_id)
+			return hdr;
+	}
+
+	return NULL;
+}
+
+/* Return buffer including capability chain, if present. Free with free() */
+static struct vfio_iommu_type1_info *vfio_iommu_info_buf(struct vfio_pci_device *device)
+{
+	struct vfio_iommu_type1_info *buf;
+
+	buf = malloc(sizeof(*buf));
+	VFIO_ASSERT_NOT_NULL(buf);
+
+	*buf = (struct vfio_iommu_type1_info) {
+		.argsz = sizeof(*buf),
+	};
+
+	ioctl_assert(device->container_fd, VFIO_IOMMU_GET_INFO, buf);
+
+	buf = realloc(buf, buf->argsz);
+	VFIO_ASSERT_NOT_NULL(buf);
+
+	ioctl_assert(device->container_fd, VFIO_IOMMU_GET_INFO, buf);
+
+	return buf;
+}
+
+/*
+ * Return iova ranges for the device's container. Normalize vfio_iommu_type1 to
+ * report iommufd's iommu_iova_range. Free with free().
+ */
+static struct iommu_iova_range *vfio_iommu_iova_ranges(struct vfio_pci_device *device,
+						       size_t *nranges)
+{
+	struct vfio_iommu_type1_info_cap_iova_range *cap_range;
+	struct vfio_iommu_type1_info *buf;
+	struct vfio_info_cap_header *hdr;
+	struct iommu_iova_range *ranges = NULL;
+
+	buf = vfio_iommu_info_buf(device);
+	VFIO_ASSERT_NOT_NULL(buf);
+
+	hdr = vfio_iommu_info_cap_hdr(buf, VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
+	if (!hdr)
+		goto free_buf;
+
+	cap_range = container_of(hdr, struct vfio_iommu_type1_info_cap_iova_range, header);
+	if (!cap_range->nr_iovas)
+		goto free_buf;
+
+	ranges = malloc(cap_range->nr_iovas * sizeof(*ranges));
+	VFIO_ASSERT_NOT_NULL(ranges);
+
+	for (u32 i = 0; i < cap_range->nr_iovas; i++) {
+		ranges[i] = (struct iommu_iova_range){
+			.start = cap_range->iova_ranges[i].start,
+			.last = cap_range->iova_ranges[i].end,
+		};
+	}
+
+	*nranges = cap_range->nr_iovas;
+
+free_buf:
+	free(buf);
+	return ranges;
+}
+
+/* Return iova ranges of the device's IOAS. Free with free() */
+struct iommu_iova_range *iommufd_iova_ranges(struct vfio_pci_device *device,
+					     size_t *nranges)
+{
+	struct iommu_iova_range *ranges;
+	int ret;
+
+	struct iommu_ioas_iova_ranges query = {
+		.size = sizeof(query),
+		.ioas_id = device->ioas_id,
+	};
+
+	ret = ioctl(device->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
+	VFIO_ASSERT_EQ(ret, -1);
+	VFIO_ASSERT_EQ(errno, EMSGSIZE);
+	VFIO_ASSERT_GT(query.num_iovas, 0);
+
+	ranges = malloc(query.num_iovas * sizeof(*ranges));
+	VFIO_ASSERT_NOT_NULL(ranges);
+
+	query.allowed_iovas = (uintptr_t)ranges;
+
+	ioctl_assert(device->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
+	*nranges = query.num_iovas;
+
+	return ranges;
+}
+
+struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
+					      size_t *nranges)
+{
+	struct iommu_iova_range *ranges;
+
+	if (device->iommufd)
+		ranges = iommufd_iova_ranges(device, nranges);
+	else
+		ranges = vfio_iommu_iova_ranges(device, nranges);
+
+	if (!ranges)
+		return NULL;
+
+	/* ranges should be valid, ascending, and non-overlapping */
+	VFIO_ASSERT_GT(*nranges, 0);
+	VFIO_ASSERT_LT(ranges[0].start, ranges[0].last);
+
+	for (size_t i = 1; i < *nranges; i++) {
+		VFIO_ASSERT_LT(ranges[i].start, ranges[i].last);
+		VFIO_ASSERT_LT(ranges[i - 1].last, ranges[i].start);
+	}
+
+	return ranges;
+}
+
 iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
 {
 	struct vfio_dma_region *region;

-- 
2.47.3


