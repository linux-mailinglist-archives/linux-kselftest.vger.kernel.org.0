Return-Path: <linux-kselftest+bounces-39739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E112EB3244D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B686237C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A79345726;
	Fri, 22 Aug 2025 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dy5kY7zb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D52334393
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897982; cv=none; b=aWM9MjkBN/kzHujtJrXDRsF6J1OkIyysEYotq5+WjuaJ2TkZ78udOh7o4wpEyHYSdnSDQT1QDn6r92GqstZJKkIWxMmct0VA9ZNmrQN3udcCkiiXtgef/B2XIP2vbaFbWAAWXcrS4WaauN8f9ZJ5L6IKxU12j45ISp74tM2IwoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897982; c=relaxed/simple;
	bh=qwCN+NCfHRr2s2GW48RoBCnOO33j9Z5s6nuoCfSnXHw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AwKL+UcDDKnbhg3l3p9EN91X7TBikTkIXsV1wZwiSsAhVdtvjVXWmNdUAS8ew6VsvjrYqKgQs4bxc6/tN0zq14bBhw4PSAbq4ThStUtFybsihSweIODfndrQ11WUMRzdc5vUgiKJSyxQ4qYs0W+ScdSCToa3J6BCQ2HmFsKZeEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dy5kY7zb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266c83f6so2595584a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897980; x=1756502780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+vWjEIeqTnM0DqsExHiXyvi47g6vcsA+a6I0DS8fnA=;
        b=Dy5kY7zbDYQ/WIV1tCPSQjTDBMEWedNeZOurNezqKNiUzbDsy3JB1fIrNUwa5czWKS
         +Z7Ok13wGYY8DgFSfs+zchgjYkBtWK7WN+xBREHzEJktHUl1/lBatZbMCXZbOYgXB81r
         JwKvWiy8h0Sa1JObrApsbxH/hW3+fDt5TBOHD5XB/b/NEtSEvqtwU6pGSze7LuGG+2Tc
         lF43FHZdshbtTSyESsfhRBbHqXxlcXdnV61lAH3qYZOFksLVCLPOLYQDo3ESf3zXt/Xw
         g/UTDR4EkQLJNNF23EoO1wOl24iyOieWJdfHCo3Lai7YIX7jnvfHsyuntXU4/6vpRU+o
         plCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897980; x=1756502780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+vWjEIeqTnM0DqsExHiXyvi47g6vcsA+a6I0DS8fnA=;
        b=IVOlkSTbLHrGYx1atshN0ae8LSxwCMU8vlDqveYEqfTwft7dmN2i5CGYabwhEr6zJc
         nvQowUxLiAiDdXaLPO5YdCCrI6ImW1lRgnnesKooe4DOQsfadr9Ww+mg6On73o2ovw4T
         OZGIcUW5PXamC7SnL4JQ3e+ui8U51Va4/8V5zwAUTdoD+89Okis2hck3kwdtphOlO8IU
         iBZcHBpPWJxVxpSvXytW/7rcpOP+MfIh5XLTvrIo+801sjwey7HiV4YtAl6QGtxHIZvw
         haZCtCcfAfKlix8uHQ1RWwuwqzlwGJ+l8RIBM71j4gi4NJYTNXE3GQy8BSitNSqLNGWM
         tE/g==
X-Forwarded-Encrypted: i=1; AJvYcCUujqEH2oFkxefz0+Dx0c+1fyzvZcsXpp1kGcdk+qTrEb65LtGzsvf60U5R2JZO4KsuG6Cnnqyyj95D1b8QvNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9SdOZMhYQums1qcv+UCAXqBIo3tIUhdZU8c+V74cE4/viq825
	nKLsNLc650/yZP61hj/kCiq7yn5aB6pqE4VSdJvzQOaZai2Mv/Hp59dN0j9QbRJx0H+JHH7VUeI
	Oys/VKL01pK6vkQ==
X-Google-Smtp-Source: AGHT+IGW9Cij2GgRSyX/WjEEgO8KKPMDp35eSlbPfv6cEvbbvCoFMDgiB070cPy0jDwpxX7NZSDiK/KtXzKvQg==
X-Received: from pjn5.prod.google.com ([2002:a17:90b:5705:b0:321:78e7:57fb])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:52c3:b0:2fa:17e4:b1cf with SMTP id 98e67ed59e1d1-3251d471af8mr5225049a91.2.1755897980455;
 Fri, 22 Aug 2025 14:26:20 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:24:55 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-9-dmatlack@google.com>
Subject: [PATCH v2 08/30] vfio: selftests: Validate 2M/1G HugeTLB are mapped
 as 2M/1G in IOMMU
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
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
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/vfio_dma_mapping_test.c    | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 8f8e6e9e8197..2612f0cabea5 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -14,6 +14,83 @@
 
 static const char *device_bdf;
 
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
+	if (!access("/sys/kernel/debug/iommu/intel", F_OK))
+		return intel_iommu_mapping_get(bdf, iova, mapping);
+
+	return -EOPNOTSUPP;
+}
+
 FIXTURE(vfio_dma_mapping_test) {
 	struct vfio_pci_device *device;
 };
@@ -51,8 +128,10 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 {
 	const u64 size = variant->size ?: getpagesize();
 	const int flags = variant->mmap_flags;
+	struct iommu_mapping mapping;
 	void *mem;
 	u64 iova;
+	int rc;
 
 	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
 
@@ -67,7 +146,39 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	vfio_pci_dma_map(self->device, iova, size, mem);
 	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
 
+	rc = iommu_mapping_get(device_bdf, iova, &mapping);
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
+
+unmap:
 	vfio_pci_dma_unmap(self->device, iova, size);
+	printf("Unmapped IOVA 0x%lx\n", iova);
+	ASSERT_NE(0, iommu_mapping_get(device_bdf, iova, &mapping));
 
 	ASSERT_TRUE(!munmap(mem, size));
 }
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


