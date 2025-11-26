Return-Path: <linux-kselftest+bounces-46557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04589C8BAAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7073B5F45
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4FA34B1B0;
	Wed, 26 Nov 2025 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RvtO+qoB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C13B34A76D
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185797; cv=none; b=YjNd1FUTtqsB/GMlS7l1sikxJRr8ZNl8yS8kDrQ6UTmdxxTxH7XpEv74ESkRApMmHtPv1wimYfmaVKbQyd9UPAG0B2GdfemS273o7xXBTJccszEMGm3C6w4NvthpkNNDINGI33ypOAx1S+lLK4g8cfW5AcHcGPULT8Z/yQwFMVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185797; c=relaxed/simple;
	bh=vBI+BcPeBVK4GSwEmi25dYSa3GjI0+koQ6NIxM3yr7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RABaJuJupkEdQX0fFOd4lQlBNkHya8qLcDNOOz6eWVjdMJ9t1+yg3NmAV+/t0TddpjaUZB/uGTyJ0/DTkvlBUELN5beLZ9DvdUVow6offBrm1ZjYsQDZK8MGiEvIaY5+jlTtziHeInyvCaINUF9nBZaFSDsOibmkpzVp3ar5E3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RvtO+qoB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a4c4eeeef2so175758b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185794; x=1764790594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JlttO+kP+T+xZD5DVn0EpdpTFcNTZGOHePuSNnW/JoA=;
        b=RvtO+qoBrysg8qXH+T1HcibT/haYUCXdYRZzrf+VRexDeAoIGQoHBl1kMqo4HBnMG2
         8SDdxIj2SfP85X6DHNUYKI6NQ+HmELeu01y9/JjkS1kA0m4QxWam7p6OijuuSyTWmKX3
         +HPPTvwdNSUkWHjNCfyS5772Nm3pn0nHsEy4AiT1iIPOk++NOFy3QU21LtS53LcabZ0h
         WjLafKukrIFarSkIuAfS8qf3k0c0xy/rth2+7JWfML1Pw+A6WKXSfTRLz90Zbx2WUcLc
         szmooieqXrzroM7+C8PZyDGbcHa/Cx2ayhs86kGqK1Pi2lmDYLnrEIfciCa4gCt62IlO
         1fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185794; x=1764790594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JlttO+kP+T+xZD5DVn0EpdpTFcNTZGOHePuSNnW/JoA=;
        b=U1+atTKjmscchLeQ1CNAyJCUBLd1nk8YLgjlI9mfY9l1DX8Cr4MfEA1YbLxgi9rbS8
         02l/GUTspJvaxSAmIaXdld0opi+zMG+rB/+LbEIn4VEjPnz3jooHpYnfdHqOKtIpau6P
         mXsIvnXKwdn8IZkPYeUNq15xEWs+FYjTUrmhGZyuuNXb4hJ8R5fbD58loUndYot/1rnR
         VohChvmczJdIasUEcfzOC7TKJI7Kr4tpSU8qHJdj6PHz9HdmbC+LaYxFiCvoyU0aT4bn
         DRACJhBVsxPTHKZM3uaVvVP5Hvm5J5P8JH1AaPCkzw46OCja/OZimv6CpjiKg87i11Yf
         vRvA==
X-Forwarded-Encrypted: i=1; AJvYcCXdyKw3tLRdQ5Ghv2NIwgSyLx2YNLG1/xXevGVB+SsPiEJnXTKC/Z6ocptCh9iduFMZHeEETIcYsT6hzQO0iJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxsNrDPtOYy7oAGSAntcdwQ4Hwc0C1uy6eaOSkJ9GWt03PF2cT
	mUpNA5wTUcoXXBrzkTCSRt6R/IUahJUEBSyI9gtzL87y9V53FDvZ13LJFVSPMowPAke1LggCSUi
	1t+aSuhoJ1dCCvA==
X-Google-Smtp-Source: AGHT+IGfJFqnQcEqTjyto3NMliFrj7gIasa9HojRwUWAbHy3ogFhO2JBnuthvTdBNfMOSov8pJvPknTpGK+cJQ==
X-Received: from pfbfj40.prod.google.com ([2002:a05:6a00:3a28:b0:781:1659:e630])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:23d5:b0:7b8:758c:7e7f with SMTP id d2e1a72fcca58-7ca877f7eabmr8568252b3a.7.1764185794404;
 Wed, 26 Nov 2025 11:36:34 -0800 (PST)
Date: Wed, 26 Nov 2025 19:36:02 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-16-dmatlack@google.com>
Subject: [PATCH 15/21] vfio: selftests: Add vfio_pci_liveupdate_uapi_test
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Add a selftest to exercise preserving a various VFIO files through
/dev/liveupdate. Ensure that VFIO cdev device files can be preserved and
everything else (group-based device files, group files, and container
files) all fail.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  1 +
 .../vfio/vfio_pci_liveupdate_uapi_test.c      | 93 +++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 424649049d94..9b2a4f10c558 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -4,6 +4,7 @@ TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
+TEST_GEN_PROGS += vfio_pci_liveupdate_uapi_test
 
 TEST_PROGS_EXTENDED := scripts/cleanup.sh
 TEST_PROGS_EXTENDED := scripts/lib.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
new file mode 100644
index 000000000000..3b4276b2532c
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <libliveupdate.h>
+#include <libvfio.h>
+#include <kselftest_harness.h>
+
+static const char *device_bdf;
+
+FIXTURE(vfio_pci_liveupdate_uapi_test) {
+	int luo_fd;
+	int session_fd;
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_VARIANT(vfio_pci_liveupdate_uapi_test) {
+	const char *iommu_mode;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode)			\
+FIXTURE_VARIANT_ADD(vfio_pci_liveupdate_uapi_test, _iommu_mode) {	\
+	.iommu_mode = #_iommu_mode,					\
+}
+
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
+#undef FIXTURE_VARIANT_ADD_IOMMU_MODE
+
+FIXTURE_SETUP(vfio_pci_liveupdate_uapi_test)
+{
+	self->luo_fd = luo_open_device();
+	ASSERT_GE(self->luo_fd, 0);
+
+	self->session_fd = luo_create_session(self->luo_fd, "session");
+	ASSERT_GE(self->session_fd, 0);
+
+	self->iommu = iommu_init(variant->iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_liveupdate_uapi_test)
+{
+	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
+	close(self->session_fd);
+	close(self->luo_fd);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_device)
+{
+	int ret;
+
+	ret = luo_session_preserve_fd(self->session_fd, self->device->fd, 0);
+
+	/* Preservation should only be supported for VFIO cdev files. */
+	ASSERT_EQ(ret, self->iommu->iommufd ? 0 : -ENOENT);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_group_fails)
+{
+	int ret;
+
+	if (self->iommu->iommufd)
+		return;
+
+	ret = luo_session_preserve_fd(self->session_fd, self->device->group_fd, 0);
+	ASSERT_EQ(ret, -ENOENT);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_container_fails)
+{
+	int ret;
+
+	if (self->iommu->iommufd)
+		return;
+
+	ret = luo_session_preserve_fd(self->session_fd, self->iommu->container_fd, 0);
+	ASSERT_EQ(ret, -ENOENT);
+}
+
+int main(int argc, char *argv[])
+{
+	int fd;
+
+	fd = luo_open_device();
+	if (fd < 0) {
+		printf("open(%s) failed: %s, skipping\n", LUO_DEVICE, strerror(errno));
+		return KSFT_SKIP;
+	}
+	close(fd);
+
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.52.0.487.g5c8c507ade-goog


