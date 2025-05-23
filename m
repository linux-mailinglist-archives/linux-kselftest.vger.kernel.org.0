Return-Path: <linux-kselftest+bounces-33703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED095AC2C34
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461441C06B90
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3259821D3E4;
	Fri, 23 May 2025 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSDYfbJM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FD521CC5F
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043042; cv=none; b=gLNF73x/Am6623t//tL1hpmnSozf2o5/DI0HrhJHlkXhtLueQhLO56ys1m1+MOJFKPoOry5MkTZ8Eml+iWy1qaI3CpzkmvEoJwaOCalFZOmUiXsFhqc0ZfaYWG0NdaMpkLTAybPkbfTPw8yP2BAu9jcI6QopiPsgTjK6HSKqMxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043042; c=relaxed/simple;
	bh=IzuLQmiIOcmlnIlxel9tJml4UIa6GrCJnimAO3OFTME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dDKCqfHkFBoeszll0cDegyVXnpXBk/L3tLvAEZOEYHOH/olVNoNI3sRwIz9GrmsIUb0i+4R/4T83Y1dwf2sXp14mBFVZlouEbyVlXEDMWVfsqdZvinXu7JGh+oKCn65MwZ52Ge3l7ypa0rTPonuS+e//BOS2xX4C0HO/O+WlqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lSDYfbJM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e5c14b49cso1300201a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043040; x=1748647840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rVTZVtqNxcuX42vct69u5eehsOcGovY407w8xhozRe4=;
        b=lSDYfbJM8U831XPwiiAgI0QtjF2wNpMtF0FmrGByS9AF3lKQX0qqsw6ohuix1DXtTI
         De1TsGKtCmXfa/bQSthsLNmpXedGQIE2BgrTnULb70mZ6pldupEPKP1JL6BldO5Y27Ds
         A/9xbkRKbX2RjDYGk4g19ytG7gS5aSdrUUY8GJeDvYVwQNqk/9wPeCaV+J9Y7tRnOvu3
         OwUwz+HqqHLg5WVkKm2z3dTmt7/WsEfNwLEunByfRauzYlCNBOGeZStAWKLpF5QQQaqw
         zzAP9vL+uOq7wDSTicXaIj2mnw78+GaF/P01VkmFXThO2Ib/6gvye/A30jhIZGh1qJtf
         El/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043040; x=1748647840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVTZVtqNxcuX42vct69u5eehsOcGovY407w8xhozRe4=;
        b=qno5EyoLwVt24S0J00tTQSnZn8zlvHM1bl0VI4jznppUp3SJpjmFfZNsUgsOq+IY0a
         nL9HXgvROm7FkCFsMSqvpW3LlwIGv7ddesulwP5Im5RQ8GJXRUn1u04ecTStg3BYhsl2
         cI0SotUt8mh1x/FcDhszyff0laRIFmndNb6dRSwaE1vZN5h5N7wQqv2YDLVyMykdMO1D
         WALvuGtqVHv94sBO0dc2PrGykRc5R7iJob/27QcjqaXmDeadK9PlTiq4wxZ79InDq/DE
         nQzGz3Vd72QJzb7mvunbmxi5RwWmKIM+pnQL3H45wIu+jyWu3CCZpG8F3WIy+ptls8O+
         0tuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdCBTfVaFTruRnpikCoXVbyQU3YlhNR7BRZbVWN48I2rKybZ83SCpY3i/+DHQYjy2zmqNwqZ8prVblJwvMjAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYi5nJdiGGiYUlxOaSRotL3RdKKOnUyQ/upJcAiNN/5jG+4tea
	MHTzkZhgYdHq2J7GRtPCLhCcjcoCzC1Q79+XUpb2KLXUvtUYEfPxPGcch09V5hUaxHKqq8ybvYk
	fl/HkfzU4Dvfcyg==
X-Google-Smtp-Source: AGHT+IFxdSgMaKFH0rZVHZaLW/lijOp1+J0YYUXhwJS8TQIB/a9tedSfbrxlmDrwgTJcRsdr4P44+erjDePUzw==
X-Received: from pjm14.prod.google.com ([2002:a17:90b:2fce:b0:301:2679:9d9])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4fcd:b0:2fa:17e4:b1cf with SMTP id 98e67ed59e1d1-3110aab1d02mr2287301a91.2.1748043039897;
 Fri, 23 May 2025 16:30:39 -0700 (PDT)
Date: Fri, 23 May 2025 23:29:52 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-8-dmatlack@google.com>
Subject: [RFC PATCH 07/33] vfio: selftests: Use command line to set hugepage
 size for DMA mapping test
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

Add a command line arg to vfio_dma_mapping_test to choose the size of
page which is mapped in VFIO.

Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/vfio_dma_mapping_test.c    | 92 +++++++++++++++----
 1 file changed, 75 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index e020f3eb6910..4b838a06a5fe 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <fcntl.h>
-
+#include <stdio.h>
+#include <string.h>
 #include <sys/mman.h>
+#include <unistd.h>
 
+#include <linux/limits.h>
+#include <linux/mman.h>
 #include <linux/sizes.h>
 #include <linux/vfio.h>
 
@@ -10,7 +13,12 @@
 
 #include "../kselftest_harness.h"
 
-const char *device_bdf;
+static struct {
+	u64 size;
+	u64 iova;
+	int mmap_flags;
+	const char *bdf;
+} test_config;
 
 FIXTURE(vfio_dma_mapping_test)
 {
@@ -19,7 +27,7 @@ FIXTURE(vfio_dma_mapping_test)
 
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
-	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+	self->device = vfio_pci_device_init(test_config.bdf, VFIO_TYPE1_IOMMU);
 }
 
 FIXTURE_TEARDOWN(vfio_dma_mapping_test)
@@ -29,29 +37,79 @@ FIXTURE_TEARDOWN(vfio_dma_mapping_test)
 
 TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 {
-	const u64 size = SZ_2M;
-	const u64 iova = SZ_4G;
 	void *mem;
 
-	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	mem = mmap(NULL, test_config.size, PROT_READ | PROT_WRITE,
+		   test_config.mmap_flags, -1, 0);
 	ASSERT_NE(mem, MAP_FAILED);
 
-	vfio_pci_dma_map(self->device, iova, size, mem);
-	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
-	vfio_pci_dma_unmap(self->device, iova, size);
+	vfio_pci_dma_map(self->device, test_config.iova, test_config.size, mem);
+	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem,
+	       test_config.size, test_config.iova);
+
+	vfio_pci_dma_unmap(self->device, test_config.iova, test_config.size);
+
+	ASSERT_TRUE(!munmap(mem, test_config.size));
+}
 
-	ASSERT_TRUE(!munmap(mem, size));
+static void help(const char *name)
+{
+	printf("Usage: %s [-b backing_src] segment:bus:device.function\n"
+	       "  -b: Which backing memory to use (default: anonymous)\n"
+	       "\n"
+	       "      anonymous\n"
+	       "      anonymous_hugetlb_2mb\n"
+	       "      anonymous_hugetlb_1gb\n",
+	       name);
+	exit(1);
+}
+
+static int set_backing_src(const char *backing_src)
+{
+	if (!backing_src)
+		return 1;
+
+	test_config.mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS;
+
+	if (!strcmp(backing_src, "anonymous")) {
+		test_config.size = SZ_4K;
+		return 0;
+	} else if (!strcmp(backing_src, "anonymous_hugetlb_2mb")) {
+		test_config.size = SZ_2M;
+		test_config.mmap_flags |= MAP_HUGETLB | MAP_HUGE_2MB;
+		return 0;
+	} else if (!strcmp(backing_src, "anonymous_hugetlb_1gb")) {
+		test_config.size = SZ_1G;
+		test_config.mmap_flags |= MAP_HUGETLB | MAP_HUGE_1GB;
+		return 0;
+	}
+
+	fprintf(stderr, "Unrecognized value for -b: %s\n", backing_src);
+	return 1;
 }
 
 int main(int argc, char *argv[])
 {
-	if (argc != 2) {
-		fprintf(stderr, "usage: %s segment:bus:device.function\n",
-			argv[0]);
-		return KSFT_FAIL;
+	const char *backing_src = "anonymous";
+	int c;
+
+	while ((c = getopt(argc, argv, "b:")) != -1) {
+		switch (c) {
+		case 'b':
+			backing_src = optarg;
+			break;
+		default:
+			help(argv[0]);
+		}
 	}
 
-	device_bdf = argv[1];
+	if (set_backing_src(backing_src))
+		help(argv[0]);
+
+	if (optind >= argc)
+		help(argv[0]);
+
+	test_config.bdf = argv[optind];
 
-	return test_harness_run(1, argv);
+	return test_harness_run(0, NULL);
 }
-- 
2.49.0.1151.ga128411c76-goog


