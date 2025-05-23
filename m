Return-Path: <linux-kselftest+bounces-33704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F302CAC2C36
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F5DA7B8A11
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D368021D599;
	Fri, 23 May 2025 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dtsay5Hs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139B21D3E2
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043043; cv=none; b=cXw98bu8lnaO+yqMmqnTPzbZdjJtDULR/5g+EB8LwVQWrrTt13bVj2Ffi05Zs1qj2gL5UW4+RsAQHdavX6zHw8yuihPPpcJik2Diyky7dYCChloPbgkSXXFpizSXYSRkwea31K1uU9wEnrzGRJAz3GjNGBPBwjGS9m91IA8HAaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043043; c=relaxed/simple;
	bh=Aqyq0W+hAHBspl+ajt8stjwvubegV6/J/Df6q3br1nc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jiEGzYWxJCct7l8xN6DPb3i0sW9BP9LS4uBrEnHJB9fWxBXxwP3UnsZCxvwujxiUhGDj177YV0TzpzM+rORKTyMTObKPuvHk/AU953St4i6JFeh7Q9aK0CkraG0VDYB0TEkXWJxoOCjBr2C+y/5fUzV8ytzagA7bHnP/w6TboQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dtsay5Hs; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3111814d7cbso16199a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043041; x=1748647841; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cwOUKrqDnrShBJxmHxDTVTcPqWKQE/hfpajQGZaZKZM=;
        b=Dtsay5HsEypcResYKXJIGHh9vKh7yHVrd7DEP4Eia87Y474UzOcU8YOdf2YO0rQIvB
         GiPslEkM/BcMFfXPuywNUyT1dGDU0nZr1VlOk69WSfu6J5fUd+mRNoRk8Hy493PwMEoP
         tO/g8SyJFscn14XSionls1yH0np+DsRddV0yX3JtLUQI7Rljs0u3eI1m3/2j4t6goPxC
         Kn/Yxu+xrbu9FEaxtcw/APg1NDXP/pj7l3XXl6rSZFHHVRWoVF8CQy7IUsx4K6CqCVRI
         dV+cMQspbNpfmcO0momEZ2jCqD/q9a6OI/Rj7d/fvy6Qou5PJ/io2aTQkZVCz6eqMihZ
         dBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043041; x=1748647841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwOUKrqDnrShBJxmHxDTVTcPqWKQE/hfpajQGZaZKZM=;
        b=rCG4oXVoBHnxP3HDqlpO39quB+osXTBO6QH0gDrMNw1g3f2d6xzwEMMn2SqHbRBEbW
         +4gmnY6nJvrWqWvKp5jKPf02MfE0J8P4cWT+fZL5ckPmjakzrrRQGItPN9inPXl695yr
         mQu5b6ttwvdQtwlKRIlIVG3plmPLBbm5A+3wM7ZQejCn1VJxUt0wK+c3XvS7NVI1XjwB
         /IzJRln/JDMNzOdFTNTMwgcZKbAix0IudpDpeO6cvM/7oj/bT8eqIHrDKE4k7ZryS/iS
         U+xg7/2k/FDXFNDzbzJXFF+74gmqgvDwEMdORZFVIEA00d6o3CExc7pHqeR9HCrFiiCL
         5FFA==
X-Forwarded-Encrypted: i=1; AJvYcCV6CW8k2EWoQAoVap00CntZBq8YULVopAxVpUlvIIeXkPvjDRGat16s5UKJEgqsgYOmpIYY7WtCGMH6UhzGl4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRCRwCLIyxyXF3nZipCYMvRg+b15399IMI2IQIWKWR1kPHVImC
	cCqKrVsIG5vHQfmVB/1mmTqMLgDrn3SLpfp0l+a5USqUP3uoa2+ZvOIoMcyiLRZwiIqejvOGz24
	cI6lXaxciDYMwLw==
X-Google-Smtp-Source: AGHT+IG9T6H5Zl9+1iefukPvRNFWkP3vCYFpO3lRHedONnpo0g986Nw4dw8SwgkH7GKWFeY+Z8nBvattkxALcw==
X-Received: from pjuw7.prod.google.com ([2002:a17:90a:d607:b0:308:867e:1ced])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1c05:b0:30a:3e8e:ea30 with SMTP id 98e67ed59e1d1-310e8900934mr8344911a91.11.1748043041433;
 Fri, 23 May 2025 16:30:41 -0700 (PDT)
Date: Fri, 23 May 2025 23:29:53 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-9-dmatlack@google.com>
Subject: [RFC PATCH 08/33] vfio: selftests: Validate 2M/1G HugeTLB are mapped
 as 2M/1G in IOMMU
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Josh Hilke <jrhilke@google.com>

Update vfio dma mapping test to verify that the IOMMU uses 2M and 1G
mappings when 2M and 1G HugeTLB pages are mapped into a device
respectively.

This validation is done by inspecting the contents of the I/O page
tables via /sys/kernel/debug/iommu/intel/. This validation is skipped if
that directory is not available (i.e. non-Intel IOMMUs).

Signed-off-by: Josh Hilke <jrhilke@google.com>
[reword commit message, refactor code]
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/vfio_dma_mapping_test.c    | 126 +++++++++++++++++-
 1 file changed, 119 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 4b838a06a5fe..c4920267ae42 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -20,6 +20,83 @@ static struct {
 	const char *bdf;
 } test_config;
 
+struct iommu_mapping {
+	u64 pgd;
+	u64 p4d;
+	u64 pud;
+	u64 pmd;
+	u64 pte;
+};
+
+static void parse_next_value(char **line, u64 *value)
+{
+	char *token;
+
+	token = strtok_r(*line, " \t|\n", line);
+	if (!token)
+		return;
+
+	/* Caller verifies `value`. No need to check return value. */
+	sscanf(token, "0x%lx", value);
+}
+
+static int intel_iommu_mapping_get(const char *bdf, u64 iova,
+				   struct iommu_mapping *mapping)
+{
+	char iommu_mapping_path[PATH_MAX], line[PATH_MAX];
+	u64 line_iova = -1;
+	int ret = -ENOENT;
+	FILE *file;
+	char *rest;
+
+	snprintf(iommu_mapping_path, sizeof(iommu_mapping_path),
+		 "/sys/kernel/debug/iommu/intel/%s/domain_translation_struct",
+		 bdf);
+
+	printf("Searching for IOVA 0x%lx in %s\n", iova, iommu_mapping_path);
+
+	file = fopen(iommu_mapping_path, "r");
+	VFIO_ASSERT_NOT_NULL(file, "fopen(%s) failed", iommu_mapping_path);
+
+	while (fgets(line, sizeof(line), file)) {
+		rest = line;
+
+		parse_next_value(&rest, &line_iova);
+		if (line_iova != (iova / getpagesize()))
+			continue;
+
+		/*
+		 * Ensure each struct field is initialized in case of empty
+		 * page table values.
+		 */
+		memset(mapping, 0, sizeof(*mapping));
+		parse_next_value(&rest, &mapping->pgd);
+		parse_next_value(&rest, &mapping->p4d);
+		parse_next_value(&rest, &mapping->pud);
+		parse_next_value(&rest, &mapping->pmd);
+		parse_next_value(&rest, &mapping->pte);
+
+		ret = 0;
+		break;
+	}
+
+	fclose(file);
+
+	if (ret)
+		printf("IOVA not found\n");
+
+	return ret;
+}
+
+static int iommu_mapping_get(const char *bdf, u64 iova,
+			     struct iommu_mapping *mapping)
+{
+	if (access("/sys/kernel/debug/iommu/intel", F_OK))
+		return intel_iommu_mapping_get(bdf, iova, mapping);
+
+	return -EOPNOTSUPP;
+}
+
 FIXTURE(vfio_dma_mapping_test)
 {
 	struct vfio_pci_device *device;
@@ -37,19 +114,54 @@ FIXTURE_TEARDOWN(vfio_dma_mapping_test)
 
 TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 {
+	const int prot = PROT_READ | PROT_WRITE;
+	const u64 iova = test_config.iova;
+	const u64 size = test_config.size;
+	struct iommu_mapping mapping;
 	void *mem;
+	int rc;
 
-	mem = mmap(NULL, test_config.size, PROT_READ | PROT_WRITE,
-		   test_config.mmap_flags, -1, 0);
+	mem = mmap(NULL, size, prot, test_config.mmap_flags, -1, 0);
 	ASSERT_NE(mem, MAP_FAILED);
 
-	vfio_pci_dma_map(self->device, test_config.iova, test_config.size, mem);
-	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem,
-	       test_config.size, test_config.iova);
+	vfio_pci_dma_map(self->device, iova, size, mem);
+	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
+
+	rc = iommu_mapping_get(test_config.bdf, iova, &mapping);
+	if (rc == -EOPNOTSUPP)
+		goto unmap;
+
+	ASSERT_EQ(0, rc);
+	printf("Found IOMMU mappings for IOVA 0x%lx:\n", iova);
+	printf("PGD: 0x%016lx\n", mapping.pgd);
+	printf("P4D: 0x%016lx\n", mapping.p4d);
+	printf("PUD: 0x%016lx\n", mapping.pud);
+	printf("PMD: 0x%016lx\n", mapping.pmd);
+	printf("PTE: 0x%016lx\n", mapping.pte);
+
+	switch (size) {
+	case SZ_4K:
+		ASSERT_NE(0, mapping.pte);
+		break;
+	case SZ_2M:
+		ASSERT_EQ(0, mapping.pte);
+		ASSERT_NE(0, mapping.pmd);
+		break;
+	case SZ_1G:
+		ASSERT_EQ(0, mapping.pte);
+		ASSERT_EQ(0, mapping.pmd);
+		ASSERT_NE(0, mapping.pud);
+		break;
+	default:
+		VFIO_FAIL("Unrecognized size: 0x%lx\n", size);
+	}
 
-	vfio_pci_dma_unmap(self->device, test_config.iova, test_config.size);
+unmap:
+	vfio_pci_dma_unmap(self->device, iova, size);
+	printf("Unmapped IOVA 0x%lx\n", iova);
+	ASSERT_NE(0, iommu_mapping_get(test_config.bdf, iova, &mapping));
 
-	ASSERT_TRUE(!munmap(mem, test_config.size));
+	ASSERT_TRUE(!munmap(mem, size));
 }
 
 static void help(const char *name)
-- 
2.49.0.1151.ga128411c76-goog


