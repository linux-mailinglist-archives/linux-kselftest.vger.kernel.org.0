Return-Path: <linux-kselftest+bounces-39733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33182B32438
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516AF6221D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199EE2F618E;
	Fri, 22 Aug 2025 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0or8enV1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D899F33A01B
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897974; cv=none; b=WEbA8hW1Bztt3I73w0gvIzfB4b6h1icarRbAlLNNp83cEm9Qz2010Om/IHrYzvxbDUxLrwVXwNkOfI/jyRweqU+aDYdbqbsNgVkVJQiRx2DLDaubgCSzhKFQBxDMGx0oFRE1fWmNJQFk8W+iCcrf6ptxocSfd+KNFPYYVCq2xpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897974; c=relaxed/simple;
	bh=tJAYvPHlqevs1xPARy/h12s8dHlC+Kg2zy7pa7DmLtI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ETBbA9hgLvLRWPj7rU8ZKhbVrKiWazAKQKKJq9o3zOB3fuSDXOtbXekT53gHSOapgr4r3Z3PcjRiYwC8ZegH3npRagZHkJfp08hS0xP6DhAkfm+zBmPbfbppMbvxzm7cOXfTiL/Ngb20F/pyINbld4tcaanGgWuXGVcIz7oAwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0or8enV1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e614e73so2358033b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897971; x=1756502771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKRU8q6r2YLTqceoY9HjQ4rZVRUAf8IcBgtu/Jox7M0=;
        b=0or8enV1wluipgIwXtveqmbBI7sjioHJIOC0ECj4GVgBiLGRb/yx2QH6vQ4p6xHpuJ
         281eEKI3ZZG37BJ0FQmrAUps9U3OVNGGURYBqu+qvN4067AXQ+k9WbKPu2Uj/3IAw/OB
         wbquMKDuLAHHpZTtZ63B8w5nQyFU1fNR53X0wsDitUohth1Qx8MPhVd8aOm2Xh5SZt5V
         tUzc/G9TEc+MMnhFfuidAH31WpxQ5nZ5pg1q//1z4jf3A1ljh/3a5cOooScE3sjMxweu
         K1/CfKCl1I5ZdzHdsdAhpw/ycKqfwOSMY8ycSYtqY8b3mTPQWyrgjjWN5H8lewjR5F5e
         ZckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897971; x=1756502771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKRU8q6r2YLTqceoY9HjQ4rZVRUAf8IcBgtu/Jox7M0=;
        b=cW4WG0iog+AaBsmzvpW1EoNa0560FbgWpHPHWYDxcduKIumkWYdcUqgynR6ioVq1o9
         1UZ59W/fOigLvFwJ0BrfLUIfPAGlurpEE9XCBKtMKKpJUdFcpn9bJMwdEH2aYZKZZ2c6
         kyZaEcW3tY3W9v5zoZL42KXUbfV/+k4/KrWA4Oqh2LMAnMkFZ1CWHt7aAAB/2lLbiHyE
         /AbfGFu/oE+NmmVMqsNRDZADFeJIt/mdgDnCxQjHKTpwE3z0FFCbXYPsBk9I9JXntoQQ
         Oi2mW2L87l/sgrJk8Mq0y0orrIt5KHRTt+8ZdewkXsSeENNbFqPGICDBeWzYNO8w8qzK
         sKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDN7HJIwAQbj5nvUCj/vgGLzAxihF88SjAmjSh+llwBGFet+H/czQeykayFw4rJFbXketr0BDzG7NpM1uc1HM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy36SZ25J7qHfCagQHSw0RlExiWP/U3U0J74ZIEJTfEGOUSSsHD
	x8KUfYmG8msJTF8Aze+oSBnyJzGJod9SCOaywJEMbbmiGgsk7w/hVH346grWA/V7NdRY6t7HErw
	pGJnh5NPVnxA+SQ==
X-Google-Smtp-Source: AGHT+IHTXaWoT8cMkHUSRVVjF8FPwBMwg/zu7uTMYmlz/6b0Gycd0aMvCUadmQXlLF4x2Qts11SgAI7OX6bXGw==
X-Received: from pjbsp15.prod.google.com ([2002:a17:90b:52cf:b0:30a:7da4:f075])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a0b:b0:240:101c:4428 with SMTP id adf61e73a8af0-24340acc2b1mr7293904637.10.1755897971232;
 Fri, 22 Aug 2025 14:26:11 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:24:49 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-3-dmatlack@google.com>
Subject: [PATCH v2 02/30] vfio: selftests: Add a helper library for VFIO selftests
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

Add a basic helper library to be used by VFIO selftests.

The basic unit of the library is struct vfio_pci_device, which
represents a single PCI device that is bound to the vfio-pci driver. The
library currently only supports a single device per group and container,
and VFIO IOMMU types.

The code in this library was heavily based on prior work done by
Raghavendra Rao Ananta <rananta@google.com>, and the VFIO_ASSERT*()
macros were written by Vipin Sharma <vipinsh@google.com>.

Separate that Makefile rules for building the library into a separate
script so that the library can be built by and linked into KVM selftests
in a subsequent commit.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  14 +
 .../selftests/vfio/lib/include/vfio_util.h    | 140 +++++++
 tools/testing/selftests/vfio/lib/libvfio.mk   |  15 +
 .../selftests/vfio/lib/vfio_pci_device.c      | 365 ++++++++++++++++++
 4 files changed, 534 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/lib/include/vfio_util.h
 create mode 100644 tools/testing/selftests/vfio/lib/libvfio.mk
 create mode 100644 tools/testing/selftests/vfio/lib/vfio_pci_device.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2bba39aff5d9..db3e4db1a6dd 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,2 +1,16 @@
 CFLAGS = $(KHDR_INCLUDES)
 include ../lib.mk
+include lib/libvfio.mk
+
+CFLAGS += -I$(top_srcdir)/tools/include
+CFLAGS += -MD
+CFLAGS += $(EXTRA_CFLAGS)
+
+$(TEST_GEN_PROGS): %: %.o $(LIBVFIO_O)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
+
+TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
+TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBVFIO_O))
+-include $(TEST_DEP_FILES)
+
+EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
new file mode 100644
index 000000000000..b7d2bb8c18ba
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -0,0 +1,140 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H
+#define SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H
+
+#include <string.h>
+#include <linux/vfio.h>
+#include <linux/list.h>
+#include <linux/pci_regs.h>
+
+#include "../../../kselftest.h"
+
+#define VFIO_LOG_AND_EXIT(...) do {		\
+	fprintf(stderr, "  " __VA_ARGS__);	\
+	fprintf(stderr, "\n");			\
+	exit(KSFT_FAIL);			\
+} while (0)
+
+#define VFIO_ASSERT_OP(_lhs, _rhs, _op, ...) do {				\
+	typeof(_lhs) __lhs = (_lhs);						\
+	typeof(_rhs) __rhs = (_rhs);						\
+										\
+	if (__lhs _op __rhs)							\
+		break;								\
+										\
+	fprintf(stderr, "%s:%u: Assertion Failure\n\n", __FILE__, __LINE__);	\
+	fprintf(stderr, "  Expression: " #_lhs " " #_op " " #_rhs "\n");	\
+	fprintf(stderr, "  Observed: %#lx %s %#lx\n",				\
+			(u64)__lhs, #_op, (u64)__rhs);				\
+	fprintf(stderr, "  [errno: %d - %s]\n", errno, strerror(errno));	\
+	VFIO_LOG_AND_EXIT(__VA_ARGS__);						\
+} while (0)
+
+#define VFIO_ASSERT_EQ(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, ==, ##__VA_ARGS__)
+#define VFIO_ASSERT_NE(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, !=, ##__VA_ARGS__)
+#define VFIO_ASSERT_LT(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, <, ##__VA_ARGS__)
+#define VFIO_ASSERT_LE(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, <=, ##__VA_ARGS__)
+#define VFIO_ASSERT_GT(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, >, ##__VA_ARGS__)
+#define VFIO_ASSERT_GE(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, >=, ##__VA_ARGS__)
+#define VFIO_ASSERT_TRUE(_a, ...) VFIO_ASSERT_NE(false, (_a), ##__VA_ARGS__)
+#define VFIO_ASSERT_FALSE(_a, ...) VFIO_ASSERT_EQ(false, (_a), ##__VA_ARGS__)
+#define VFIO_ASSERT_NULL(_a, ...) VFIO_ASSERT_EQ(NULL, _a, ##__VA_ARGS__)
+#define VFIO_ASSERT_NOT_NULL(_a, ...) VFIO_ASSERT_NE(NULL, _a, ##__VA_ARGS__)
+
+#define VFIO_FAIL(_fmt, ...) do {				\
+	fprintf(stderr, "%s:%u: FAIL\n\n", __FILE__, __LINE__);	\
+	VFIO_LOG_AND_EXIT(_fmt, ##__VA_ARGS__);			\
+} while (0)
+
+struct vfio_pci_bar {
+	struct vfio_region_info info;
+	void *vaddr;
+};
+
+struct vfio_pci_device {
+	int fd;
+	int group_fd;
+	int container_fd;
+
+	struct vfio_device_info info;
+	struct vfio_region_info config_space;
+	struct vfio_pci_bar bars[PCI_STD_NUM_BARS];
+
+	struct vfio_irq_info msi_info;
+	struct vfio_irq_info msix_info;
+
+	/* eventfds for MSI and MSI-x interrupts */
+	int msi_eventfds[PCI_MSIX_FLAGS_QSIZE + 1];
+};
+
+/*
+ * Return the BDF string of the device that the test should use.
+ *
+ * If a BDF string is provided by the user on the command line (as the last
+ * element of argv[]), then this function will return that and decrement argc
+ * by 1.
+ *
+ * Otherwise this function will attempt to use the environment variable
+ * $VFIO_SELFTESTS_BDF.
+ *
+ * If BDF cannot be determined then the test will exit with KSFT_SKIP.
+ */
+const char *vfio_selftests_get_bdf(int *argc, char *argv[]);
+
+struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type);
+void vfio_pci_device_cleanup(struct vfio_pci_device *device);
+
+void vfio_pci_dma_map(struct vfio_pci_device *device, u64 iova, u64 size,
+		      void *vaddr);
+void vfio_pci_dma_unmap(struct vfio_pci_device *device, u64 iova, u64 size);
+
+void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
+			    size_t config, size_t size, void *data);
+
+#define vfio_pci_config_read(_device, _offset, _type) ({			    \
+	_type __data;								    \
+	vfio_pci_config_access((_device), false, _offset, sizeof(__data), &__data); \
+	__data;									    \
+})
+
+#define vfio_pci_config_readb(_d, _o) vfio_pci_config_read(_d, _o, u8)
+#define vfio_pci_config_readw(_d, _o) vfio_pci_config_read(_d, _o, u16)
+#define vfio_pci_config_readl(_d, _o) vfio_pci_config_read(_d, _o, u32)
+
+#define vfio_pci_config_write(_device, _offset, _value, _type) do {		  \
+	_type __data = (_value);						  \
+	vfio_pci_config_access((_device), true, _offset, sizeof(_type), &__data); \
+} while (0)
+
+#define vfio_pci_config_writeb(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u8)
+#define vfio_pci_config_writew(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u16)
+#define vfio_pci_config_writel(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u32)
+
+void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
+			 u32 vector, int count);
+void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
+void vfio_pci_irq_trigger(struct vfio_pci_device *device, u32 index, u32 vector);
+
+static inline void vfio_pci_msi_enable(struct vfio_pci_device *device,
+				       u32 vector, int count)
+{
+	vfio_pci_irq_enable(device, VFIO_PCI_MSI_IRQ_INDEX, vector, count);
+}
+
+static inline void vfio_pci_msi_disable(struct vfio_pci_device *device)
+{
+	vfio_pci_irq_disable(device, VFIO_PCI_MSI_IRQ_INDEX);
+}
+
+static inline void vfio_pci_msix_enable(struct vfio_pci_device *device,
+					u32 vector, int count)
+{
+	vfio_pci_irq_enable(device, VFIO_PCI_MSIX_IRQ_INDEX, vector, count);
+}
+
+static inline void vfio_pci_msix_disable(struct vfio_pci_device *device)
+{
+	vfio_pci_irq_disable(device, VFIO_PCI_MSIX_IRQ_INDEX);
+}
+
+#endif /* SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H */
diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
new file mode 100644
index 000000000000..72e55a560eeb
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -0,0 +1,15 @@
+VFIO_DIR := $(selfdir)/vfio
+
+LIBVFIO_C := lib/vfio_pci_device.c
+
+LIBVFIO_O := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBVFIO_C))
+
+LIBVFIO_O_DIRS := $(shell dirname $(LIBVFIO_O) | uniq)
+$(shell mkdir -p $(LIBVFIO_O_DIRS))
+
+CFLAGS += -I$(VFIO_DIR)/lib/include
+
+$(LIBVFIO_O): $(OUTPUT)/%.o : $(VFIO_DIR)/%.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
+
+EXTRA_CLEAN += $(LIBVFIO_O)
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
new file mode 100644
index 000000000000..76adb1841f16
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <fcntl.h>
+#include <libgen.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/eventfd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/limits.h>
+#include <linux/mman.h>
+#include <linux/types.h>
+#include <linux/vfio.h>
+
+#include "../../../kselftest.h"
+#include <vfio_util.h>
+
+#define VFIO_DEV_PATH	"/dev/vfio/vfio"
+#define PCI_SYSFS_PATH	"/sys/bus/pci/devices"
+
+#define ioctl_assert(_fd, _op, _arg) do {						       \
+	void *__arg = (_arg);								       \
+	int __ret = ioctl((_fd), (_op), (__arg));					       \
+	VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
+} while (0)
+
+static void vfio_pci_irq_set(struct vfio_pci_device *device,
+			     u32 index, u32 vector, u32 count, int *fds)
+{
+	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] = {};
+	struct vfio_irq_set *irq = (void *)&buf;
+	int *irq_fds = (void *)&irq->data;
+
+	irq->argsz = sizeof(buf);
+	irq->flags = VFIO_IRQ_SET_ACTION_TRIGGER;
+	irq->index = index;
+	irq->start = vector;
+	irq->count = count;
+
+	if (count) {
+		irq->flags |= VFIO_IRQ_SET_DATA_EVENTFD;
+		memcpy(irq_fds, fds, sizeof(int) * count);
+	} else {
+		irq->flags |= VFIO_IRQ_SET_DATA_NONE;
+	}
+
+	ioctl_assert(device->fd, VFIO_DEVICE_SET_IRQS, irq);
+}
+
+void vfio_pci_irq_trigger(struct vfio_pci_device *device, u32 index, u32 vector)
+{
+	struct vfio_irq_set irq = {
+		.argsz = sizeof(irq),
+		.flags = VFIO_IRQ_SET_ACTION_TRIGGER | VFIO_IRQ_SET_DATA_NONE,
+		.index = index,
+		.start = vector,
+		.count = 1,
+	};
+
+	ioctl_assert(device->fd, VFIO_DEVICE_SET_IRQS, &irq);
+}
+
+static void check_supported_irq_index(u32 index)
+{
+	/* VFIO selftests only supports MSI and MSI-x for now. */
+	VFIO_ASSERT_TRUE(index == VFIO_PCI_MSI_IRQ_INDEX ||
+			 index == VFIO_PCI_MSIX_IRQ_INDEX,
+			 "Unsupported IRQ index: %u\n", index);
+}
+
+void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index, u32 vector,
+			 int count)
+{
+	int i;
+
+	check_supported_irq_index(index);
+
+	for (i = vector; i < vector + count; i++) {
+		VFIO_ASSERT_LT(device->msi_eventfds[i], 0);
+		device->msi_eventfds[i] = eventfd(0, 0);
+		VFIO_ASSERT_GE(device->msi_eventfds[i], 0);
+	}
+
+	vfio_pci_irq_set(device, index, vector, count, device->msi_eventfds + vector);
+}
+
+void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index)
+{
+	int i;
+
+	check_supported_irq_index(index);
+
+	for (i = 0; i < ARRAY_SIZE(device->msi_eventfds); i++) {
+		if (device->msi_eventfds[i] < 0)
+			continue;
+
+		VFIO_ASSERT_EQ(close(device->msi_eventfds[i]), 0);
+		device->msi_eventfds[i] = -1;
+	}
+
+	vfio_pci_irq_set(device, index, 0, 0, NULL);
+}
+
+static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
+			     struct vfio_irq_info *irq_info)
+{
+	irq_info->argsz = sizeof(*irq_info);
+	irq_info->index = index;
+
+	ioctl_assert(device->fd, VFIO_DEVICE_GET_IRQ_INFO, irq_info);
+}
+
+void vfio_pci_dma_map(struct vfio_pci_device *device, u64 iova, u64 size, void *vaddr)
+{
+	struct vfio_iommu_type1_dma_map map = {
+		.argsz = sizeof(map),
+		.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
+		.vaddr = (u64)vaddr,
+		.iova = iova,
+		.size = size,
+	};
+
+	ioctl_assert(device->container_fd, VFIO_IOMMU_MAP_DMA, &map);
+}
+
+void vfio_pci_dma_unmap(struct vfio_pci_device *device, u64 iova, u64 size)
+{
+	struct vfio_iommu_type1_dma_unmap unmap = {
+		.argsz = sizeof(unmap),
+		.iova = iova,
+		.size = size,
+	};
+
+	ioctl_assert(device->container_fd, VFIO_IOMMU_UNMAP_DMA, &unmap);
+}
+
+static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
+				struct vfio_region_info *info)
+{
+	memset(info, 0, sizeof(*info));
+
+	info->argsz = sizeof(*info);
+	info->index = index;
+
+	ioctl_assert(device->fd, VFIO_DEVICE_GET_REGION_INFO, info);
+}
+
+static void vfio_pci_bar_map(struct vfio_pci_device *device, int index)
+{
+	struct vfio_pci_bar *bar = &device->bars[index];
+	int prot = 0;
+
+	VFIO_ASSERT_LT(index, PCI_STD_NUM_BARS);
+	VFIO_ASSERT_NULL(bar->vaddr);
+	VFIO_ASSERT_TRUE(bar->info.flags & VFIO_REGION_INFO_FLAG_MMAP);
+
+	if (bar->info.flags & VFIO_REGION_INFO_FLAG_READ)
+		prot |= PROT_READ;
+	if (bar->info.flags & VFIO_REGION_INFO_FLAG_WRITE)
+		prot |= PROT_WRITE;
+
+	bar->vaddr = mmap(NULL, bar->info.size, prot, MAP_FILE | MAP_SHARED,
+			  device->fd, bar->info.offset);
+	VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
+}
+
+static void vfio_pci_bar_unmap(struct vfio_pci_device *device, int index)
+{
+	struct vfio_pci_bar *bar = &device->bars[index];
+
+	VFIO_ASSERT_LT(index, PCI_STD_NUM_BARS);
+	VFIO_ASSERT_NOT_NULL(bar->vaddr);
+
+	VFIO_ASSERT_EQ(munmap(bar->vaddr, bar->info.size), 0);
+	bar->vaddr = NULL;
+}
+
+static void vfio_pci_bar_unmap_all(struct vfio_pci_device *device)
+{
+	int i;
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		if (device->bars[i].vaddr)
+			vfio_pci_bar_unmap(device, i);
+	}
+}
+
+void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
+			    size_t config, size_t size, void *data)
+{
+	struct vfio_region_info *config_space = &device->config_space;
+	int ret;
+
+	if (write)
+		ret = pwrite(device->fd, data, size, config_space->offset + config);
+	else
+		ret = pread(device->fd, data, size, config_space->offset + config);
+
+	VFIO_ASSERT_EQ(ret, size, "Failed to %s PCI config space: 0x%lx\n",
+		       write ? "write to" : "read from", config);
+}
+
+static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
+{
+	char dev_iommu_group_path[PATH_MAX] = {0};
+	char sysfs_path[PATH_MAX] = {0};
+	unsigned int group;
+	int ret;
+
+	snprintf(sysfs_path, PATH_MAX, "%s/%s/iommu_group", PCI_SYSFS_PATH, bdf);
+
+	ret = readlink(sysfs_path, dev_iommu_group_path, sizeof(dev_iommu_group_path));
+	VFIO_ASSERT_NE(ret, -1, "Failed to get the IOMMU group for device: %s\n", bdf);
+
+	ret = sscanf(basename(dev_iommu_group_path), "%u", &group);
+	VFIO_ASSERT_EQ(ret, 1, "Failed to get the IOMMU group for device: %s\n", bdf);
+
+	return group;
+}
+
+static void vfio_pci_container_setup(struct vfio_pci_device *device)
+{
+	int version;
+
+	device->container_fd = open(VFIO_DEV_PATH, O_RDWR);
+	VFIO_ASSERT_GE(device->container_fd, 0, "open(%s) failed\n", VFIO_DEV_PATH);
+
+	version = ioctl(device->container_fd, VFIO_GET_API_VERSION);
+	VFIO_ASSERT_EQ(version, VFIO_API_VERSION);
+}
+
+static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf)
+{
+	struct vfio_group_status group_status = {
+		.argsz = sizeof(group_status),
+	};
+	char group_path[32];
+	int group;
+
+	group = vfio_pci_get_group_from_dev(bdf);
+	snprintf(group_path, sizeof(group_path), "/dev/vfio/%d", group);
+
+	device->group_fd = open(group_path, O_RDWR);
+	VFIO_ASSERT_GE(device->group_fd, 0, "open(%s) failed\n", group_path);
+
+	ioctl_assert(device->group_fd, VFIO_GROUP_GET_STATUS, &group_status);
+	VFIO_ASSERT_TRUE(group_status.flags & VFIO_GROUP_FLAGS_VIABLE);
+
+	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->container_fd);
+}
+
+static void vfio_pci_iommu_setup(struct vfio_pci_device *device, unsigned long iommu_type)
+{
+	int ret;
+
+	ret = ioctl(device->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
+	VFIO_ASSERT_GT(ret, 0, "VFIO IOMMU type %lu not supported\n", iommu_type);
+
+	ioctl_assert(device->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
+}
+
+static void vfio_pci_device_setup(struct vfio_pci_device *device, const char *bdf)
+{
+	int i;
+
+	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, bdf);
+	VFIO_ASSERT_GE(device->fd, 0);
+
+	device->info.argsz = sizeof(device->info);
+	ioctl_assert(device->fd, VFIO_DEVICE_GET_INFO, &device->info);
+
+	vfio_pci_region_get(device, VFIO_PCI_CONFIG_REGION_INDEX, &device->config_space);
+
+	/* Sanity check VFIO does not advertise mmap for config space */
+	VFIO_ASSERT_TRUE(!(device->config_space.flags & VFIO_REGION_INFO_FLAG_MMAP),
+			 "PCI config space should not support mmap()\n");
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		struct vfio_pci_bar *bar = device->bars + i;
+
+		vfio_pci_region_get(device, i, &bar->info);
+		if (bar->info.flags & VFIO_REGION_INFO_FLAG_MMAP)
+			vfio_pci_bar_map(device, i);
+	}
+
+	vfio_pci_irq_get(device, VFIO_PCI_MSI_IRQ_INDEX, &device->msi_info);
+	vfio_pci_irq_get(device, VFIO_PCI_MSIX_IRQ_INDEX, &device->msix_info);
+
+	for (i = 0; i < ARRAY_SIZE(device->msi_eventfds); i++)
+		device->msi_eventfds[i] = -1;
+}
+
+struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type)
+{
+	struct vfio_pci_device *device;
+
+	device = calloc(1, sizeof(*device));
+	VFIO_ASSERT_NOT_NULL(device);
+
+	vfio_pci_container_setup(device);
+	vfio_pci_group_setup(device, bdf);
+	vfio_pci_iommu_setup(device, iommu_type);
+	vfio_pci_device_setup(device, bdf);
+
+	return device;
+}
+
+void vfio_pci_device_cleanup(struct vfio_pci_device *device)
+{
+	int i;
+
+	vfio_pci_bar_unmap_all(device);
+
+	VFIO_ASSERT_EQ(close(device->fd), 0);
+
+	for (i = 0; i < ARRAY_SIZE(device->msi_eventfds); i++) {
+		if (device->msi_eventfds[i] < 0)
+			continue;
+
+		VFIO_ASSERT_EQ(close(device->msi_eventfds[i]), 0);
+	}
+
+	VFIO_ASSERT_EQ(close(device->group_fd), 0);
+	VFIO_ASSERT_EQ(close(device->container_fd), 0);
+
+	free(device);
+}
+
+static bool is_bdf(const char *str)
+{
+	unsigned int s, b, d, f;
+	int length, count;
+
+	count = sscanf(str, "%4x:%2x:%2x.%2x%n", &s, &b, &d, &f, &length);
+	return count == 4 && length == strlen(str);
+}
+
+const char *vfio_selftests_get_bdf(int *argc, char *argv[])
+{
+	char *bdf;
+
+	if (*argc > 1 && is_bdf(argv[*argc - 1]))
+		return argv[--(*argc)];
+
+	bdf = getenv("VFIO_SELFTESTS_BDF");
+	if (bdf) {
+		VFIO_ASSERT_TRUE(is_bdf(bdf), "Invalid BDF: %s\n", bdf);
+		return bdf;
+	}
+
+	fprintf(stderr, "Unable to determine which device to use, skipping test.\n");
+	fprintf(stderr, "\n");
+	fprintf(stderr, "To pass the device address via environment variable:\n");
+	fprintf(stderr, "\n");
+	fprintf(stderr, "    export VFIO_SELFTESTS_BDF=segment:bus:device.function\n");
+	fprintf(stderr, "    %s [options]\n", argv[0]);
+	fprintf(stderr, "\n");
+	fprintf(stderr, "To pass the device address via argv:\n");
+	fprintf(stderr, "\n");
+	fprintf(stderr, "    %s [options] segment:bus:device.function\n", argv[0]);
+	fprintf(stderr, "\n");
+	exit(KSFT_SKIP);
+}
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


