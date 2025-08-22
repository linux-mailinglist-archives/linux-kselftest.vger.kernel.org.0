Return-Path: <linux-kselftest+bounces-39738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A2EB32444
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0451D63DC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E57A343D9B;
	Fri, 22 Aug 2025 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBHeBFx5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA4343D76
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897982; cv=none; b=EYBplu4rmG6uLo8ReGXXJq7S88ow4fQngOKtnMCc+twazEJTvD93fQkdqaTBVbfJGyjPThNbrCePTZH252QuWcCue9ekTJDWEppwr3s9NZ0lLjW90qzVcuos2jHDgPokxUJODnMWT+IwPAD49mLd0UEO8Ttj3DCNcEwDsE3bzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897982; c=relaxed/simple;
	bh=sMBil33kEP0p72RsUquWHWpa11BvknJzVAjPDsLGcAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SD97uffCa9ofKALViNmRqrS8FO3OrccnSPGo7sLPZCdBAKHEjCUpGExpnb9ZZu4xNTEsZ80ZXIr00N1/LM70txgZN57EC6SC/KE6E2gheoOnLbP4OZ5VXX0InZx3NQaAsIsozHylR7WzH0sfcshG0QJl0YuoBiUlfbffF8yK98w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBHeBFx5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e5fde8fso2476560b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897979; x=1756502779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNSc8pwOi0iqwicPsbzu5iOCe1/x4uOTBWnOJx+bas0=;
        b=FBHeBFx5T6lPciEChT04zssWZ6raAERhr0LCkYQBwrsAiIjQm5v6HmAOgM7+XVwDkD
         t9vhEKig3a4xBM6v1pdGfXwFNAyiBC5KFnpmgwIvYCQWN/wzy9FEuET3b6DDOwiyFzhV
         m8P/xaOpdWCMiLQ86c+8r9slmIVAWlOcEUAtnT4WR8SRfhHuB2yZxMqxPl5lGHbKMKLl
         2iLLUw3DckIifJm+d/M2EtUn59djTmwh8IXx3A2VBCGG4t5L9XLv59hVGcePVNsMaJB4
         cMDm1ha8RL3/3QQvkaDQo1jA1zH04QUIYEItGBRW4Gez52SL4AxTmMySX5POZTbHQ0fr
         2nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897979; x=1756502779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNSc8pwOi0iqwicPsbzu5iOCe1/x4uOTBWnOJx+bas0=;
        b=AUuOAKJCCbTTm/yzBKlrTausWYUTRdMK0cubCNDpb5FmP1VyoB+BDMj0dYI3PfHkRx
         EzF81U80u6JVZi+HmyUTLwsXLwhnzL9a0+YYDUkxKUzMpD36eyIqkbgWxMAZR4KM2Vkg
         vu25XkHfhO3DW5XUNY5Fgy7VsCEn4rInDwsQR2zOpxb3oCmm18s9LNAvDgjyq1UPFbbS
         pa2CHuAIsatBm/ke0axrKDorT1Y0+YbbGbFBHc+/ZOaoNNmIjZNzpsmqEWqBWq/2o1Ep
         Hz09++1/SKOmXpQu3u0X984/w4J14LkeXKMHrGdyGil8R6ySFktU7snaHq23303BWOB4
         GgAw==
X-Forwarded-Encrypted: i=1; AJvYcCUFYpDv1kuM1760dgYtDoYfgIr5Dj3589J8s4lO7/JKyRALiES0QdpCMeNqKUpDJxzcwaHaHirDR0cukv06kk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym4o1klelENLqGXaMRqyuLg4aNHEg86/KI/2sNOGqD/WSi8tOd
	XRTzFjPqdh3kUEez7T2AuOYoufujoDpOUqleRFI3imdpyCRrGOMixmXocH6aXgXduxUx7FoTBk5
	Htl/8doXlYtYUYw==
X-Google-Smtp-Source: AGHT+IFn/CDahDRmuxUdDN7e34jUojyZdA5OMHuul/gVBglae1u1FQW/KHvUA6Y4zqwKNx7L4oUVRZKvWUqifw==
X-Received: from pfxa28.prod.google.com ([2002:a05:6a00:1d1c:b0:748:f98a:d97b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:420d:b0:770:34eb:1d38 with SMTP id d2e1a72fcca58-77034eb2007mr4306407b3a.3.1755897978799;
 Fri, 22 Aug 2025 14:26:18 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:24:54 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-8-dmatlack@google.com>
Subject: [PATCH v2 07/30] vfio: selftests: Add DMA mapping tests for 2M and 1G HugeTLB
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

Add test coverage of mapping 2M and 1G HugeTLB to vfio_dma_mapping_test
using a fixture variant. If there isn't enough HugeTLB memory available
for the test, just skip them.

Signed-off-by: Josh Hilke <jrhilke@google.com>
[switch from command line option to fixture variant]
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/vfio_dma_mapping_test.c    | 38 ++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index b56cebbf97eb..8f8e6e9e8197 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <fcntl.h>
-
+#include <stdio.h>
 #include <sys/mman.h>
+#include <unistd.h>
 
+#include <linux/limits.h>
+#include <linux/mman.h>
 #include <linux/sizes.h>
 #include <linux/vfio.h>
 
@@ -16,6 +18,25 @@ FIXTURE(vfio_dma_mapping_test) {
 	struct vfio_pci_device *device;
 };
 
+FIXTURE_VARIANT(vfio_dma_mapping_test) {
+	u64 size;
+	int mmap_flags;
+};
+
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous) {
+	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE,
+};
+
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous_hugetlb_2mb) {
+	.size = SZ_2M,
+	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_HUGETLB | MAP_HUGE_2MB,
+};
+
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous_hugetlb_1gb) {
+	.size = SZ_1G,
+	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_HUGETLB | MAP_HUGE_1GB,
+};
+
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
 	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
@@ -28,17 +49,24 @@ FIXTURE_TEARDOWN(vfio_dma_mapping_test)
 
 TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 {
-	const u64 size = SZ_2M;
+	const u64 size = variant->size ?: getpagesize();
+	const int flags = variant->mmap_flags;
 	void *mem;
 	u64 iova;
 
-	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
-	ASSERT_NE(mem, MAP_FAILED);
+	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
+
+	/* Skip the test if there aren't enough HugeTLB pages available. */
+	if (flags & MAP_HUGETLB && mem == MAP_FAILED)
+		SKIP(return, "mmap() failed: %s (%d)\n", strerror(errno), errno);
+	else
+		ASSERT_NE(mem, MAP_FAILED);
 
 	iova = (u64)mem;
 
 	vfio_pci_dma_map(self->device, iova, size, mem);
 	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
+
 	vfio_pci_dma_unmap(self->device, iova, size);
 
 	ASSERT_TRUE(!munmap(mem, size));
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


