Return-Path: <linux-kselftest+bounces-33701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3577FAC2C30
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CFF1C06B96
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5033021CC49;
	Fri, 23 May 2025 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yNsRdA3g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2620E018
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043039; cv=none; b=LfT8M8K9NgDt3qbmRwYzWScW5idPnfoiKS5nxpestV89TlhYWOtO17AdyROol4bWZw3cM1o+55ay0fGfyRDh1yUmINZJ3A11Z/QDNBN1Tbq+RVRAGUxZGbWz6Fos89IwvUgNO8hcKTh2RWn+xpzOiUSPCQOmoYFlSFtySY+rDgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043039; c=relaxed/simple;
	bh=X2Q/4hRDpEBvs54i597g9K5m0E/Y7qI7BQaNJVZy0mQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QdJPht8vdmA0TXDBmENhJ0p7Py4hSVmoIdv4S2ysa1OnM2HsVfA8uBxwNRPjYZ9cEKoonMcMubHKRQubwkdsN5WtexpIzRByn7jmZH94N0KLZI+Zi2/6hOf2JE1tAb9C7XItBPnG0IVv44d6CgZLeXPfXSSEWeDSUmYHhfO0SIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yNsRdA3g; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-310fc5f1228so439457a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043037; x=1748647837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5BddX5h2seJGVFLKxUvOVgdfrmuDHoDFR6OXUWB0DE=;
        b=yNsRdA3gyeaa+sKIq6DhJl3jrPetAjhEQ2FsTnZNLn+rmrXbHmjAQVxtJ5vGRrLL43
         lR+SOOZ1r/OoxEMKdISKJ6ajzs5Dp8OSZS4xNNZwo8hdrIGf3rvZwkZnNaPloFLrP8vC
         wASKJQ7K776ix3pYl8pDU0iGy0g9Rc/rpVSFn/9IFaYrNYrqK7GRmbMHXK3Kq8D27Zro
         hRfc/2lf77Y90dgZQaHMl0naaLdNL63LN333cVy7wZ3+GaaA6/mDX6uA67BrXQCl6RYg
         0vAWAGA2zsSNoWjkpJSlZIbWGwhYAd2fkJiR9Vj8VGLNtJ/l+KrYF1/9bgw0OCcPHPMU
         Pzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043037; x=1748647837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5BddX5h2seJGVFLKxUvOVgdfrmuDHoDFR6OXUWB0DE=;
        b=Mv2s0AYA0WZgvLxPK1jMJjNDHDcTgKTJsATvS4Mn54UOITa5TaDViHRP7XMClvM6JQ
         bPzQI6RjSR9NGKswmGZiEZadSQo87qtg238JGfj2Y3QpYv9KuO0dr1CHHVKYzvTNhqNB
         YVnzNxuPjU6DlnWzH678uQiEA4Nag2wWzbj9P5Ju5QDJZydiRQBfZwUT7TUp5aXZ0Gui
         LdIVerMeWJ/eH+SUD5ar1Xe55tUn92UrTylSl+gGWCbrku5T790hu5cFeSVyiLr5eb/N
         amXblNc+sqxGZDJ0xbHsRF+dK1BcVJJ/jzMN8Ux6TrRdj8E1+eN64dzde7z3i1OlUY3u
         +Eiw==
X-Forwarded-Encrypted: i=1; AJvYcCUZR8N3Uf/YR9/m9dd/7TwwGapjtvvjoctunJV573CaMZw2CTp/RzJu3YFor4d5Sy12ETx6WKuz42LT5IujCAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh21U6/3lpxw0FpCHLPdwjSR+qIBdXIbSBDQ+mwKQdrdnBW3Wq
	EoZ3P7ADfyrgk7SU8bF6nNkAbSOF5MNeyuLQPn9j6yVPCP99gNaby9CX/mqLIo5II0cJbOgWjz8
	7W3g4fHh0RN7bRQ==
X-Google-Smtp-Source: AGHT+IFkK3VgPQnNVks6PCgS9aJ9H2WKtaxTRpfoyVn7kL8RtsojLWb88SB9hp1rqs2kMf/saQicsQO/zPOzrw==
X-Received: from pjm11.prod.google.com ([2002:a17:90b:2fcb:b0:2fa:1fac:269c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d44d:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-3110f20c1efmr1556155a91.11.1748043037210;
 Fri, 23 May 2025 16:30:37 -0700 (PDT)
Date: Fri, 23 May 2025 23:29:50 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-6-dmatlack@google.com>
Subject: [RFC PATCH 05/33] vfio: selftests: Move vfio dma mapping test to
 their own file
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

Move the dma_map_unmap test from vfio_pci_device_test to a new test:
vfio_dma_mapping_test. We are going to add more complex dma mapping
tests, so it makes sense to separate this from the vfio pci device
test which is more of a sanity check for vfio pci functionality.

Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  1 +
 .../selftests/vfio/vfio_dma_mapping_test.c    | 57 +++++++++++++++++++
 .../selftests/vfio/vfio_pci_device_test.c     | 16 ------
 3 files changed, 58 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/vfio_dma_mapping_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 175d6ed9ba6e..2cc97176c6be 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,4 +1,5 @@
 CFLAGS = $(KHDR_INCLUDES)
+TEST_GEN_PROGS_EXTENDED += vfio_dma_mapping_test
 TEST_GEN_PROGS_EXTENDED += vfio_iommufd_setup_test
 TEST_GEN_PROGS_EXTENDED += vfio_pci_device_test
 include ../lib.mk
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
new file mode 100644
index 000000000000..e020f3eb6910
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <fcntl.h>
+
+#include <sys/mman.h>
+
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+
+#include <vfio_util.h>
+
+#include "../kselftest_harness.h"
+
+const char *device_bdf;
+
+FIXTURE(vfio_dma_mapping_test)
+{
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_SETUP(vfio_dma_mapping_test)
+{
+	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+}
+
+FIXTURE_TEARDOWN(vfio_dma_mapping_test)
+{
+	vfio_pci_device_cleanup(self->device);
+}
+
+TEST_F(vfio_dma_mapping_test, dma_map_unmap)
+{
+	const u64 size = SZ_2M;
+	const u64 iova = SZ_4G;
+	void *mem;
+
+	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(mem, MAP_FAILED);
+
+	vfio_pci_dma_map(self->device, iova, size, mem);
+	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
+	vfio_pci_dma_unmap(self->device, iova, size);
+
+	ASSERT_TRUE(!munmap(mem, size));
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s segment:bus:device.function\n",
+			argv[0]);
+		return KSFT_FAIL;
+	}
+
+	device_bdf = argv[1];
+
+	return test_harness_run(1, argv);
+}
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 7906b2684dd3..41166f4e9468 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -34,22 +34,6 @@ FIXTURE_TEARDOWN(vfio_pci_device_test) {
 	vfio_pci_device_cleanup(self->device);
 }
 
-TEST_F(vfio_pci_device_test, dma_map_unmap)
-{
-	const u64 size = SZ_2M;
-	const u64 iova = SZ_4G;
-	void *mem;
-
-	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
-	ASSERT_NE(mem, MAP_FAILED);
-
-	vfio_pci_dma_map(self->device, iova, size, mem);
-	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
-	vfio_pci_dma_unmap(self->device, iova, size);
-
-	ASSERT_TRUE(!munmap(mem, SZ_2M));
-}
-
 #define read_pci_id_from_sysfs(_file) ({							\
 	char __sysfs_path[PATH_MAX];								\
 	char __buf[32];										\
-- 
2.49.0.1151.ga128411c76-goog


