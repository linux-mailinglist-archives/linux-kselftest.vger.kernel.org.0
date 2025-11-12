Return-Path: <linux-kselftest+bounces-45458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF2AC54279
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 20:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C33E3BE287
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FA23557FD;
	Wed, 12 Nov 2025 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCyBYo9f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D734DCE9
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975393; cv=none; b=PwixsdKN2gDiNbIj85egPbI8AaPVBewHUzuJsDB+aBbhleZYS1yUM1+d2jeuSsNiY7a8up0fUklu0HfQmUgiQE3/xugxjPjogLE8VLCsRiAd4ALBMpCUXggXBAh17v/Do6t5QlWC8xIE6KToAmkKSG6veayYQY0ujq0Dnqz0czc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975393; c=relaxed/simple;
	bh=dOViFrR5MBkt+N4V7muo97D+cowN+ArWgG3W7dZSZa4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k5m/uKDdXiHAX0wM58Ebq03lfnzR0uER3ciNEYg9geHkkpAu4vKVDfpF3nyPm2MoqoaKy/ftBDCIJ3ftAOrWpdq3D7c8dJPu+dy1YZZgB+Z/8LWf85HOIKprjTaVLpd6v7wXvloUi6TrOzvNusj+hj2nS4ERFhOEW+vvjlxMlrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PCyBYo9f; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29848363458so28112505ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975389; x=1763580189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUbpJ5H6wYCbysm7/JHQOr1wPR/woklk+zZYwvBWqvI=;
        b=PCyBYo9fN2ziaIFaU7OkzbbEGUJ6AyarVlWNVs/qDuBN0s5eL8LGikRjqG33tbHKQR
         edknTnRo/oz2TS/sxvV2hk/xy0vwhQNFjb0q6Fr5gol/BDWWMlWbFD11/drPxC1SQxBT
         eU0LIOsPqDE4xHX8NTV6m2BC77N5miqe9XUgHz46Lmon2cGcybGRq5qF4YVXqbP9vuwS
         Pg48Rj9kpqNXzDUDpyH7aVVwQNqONYfmhp112wKtfQTOdJZMHlD5+L+43bzJHwbQ95nv
         3dnU847/42JTEKhMgojOvd2nLb37aQq0gVxjSb5l/EHBTrEGoy2ZJu2BTBhWqCPm5rEn
         ZFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975389; x=1763580189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUbpJ5H6wYCbysm7/JHQOr1wPR/woklk+zZYwvBWqvI=;
        b=KQOdyGc3w3Q8dyUmkLhXF6FaOJJtSLKt3CTfzev4oKGdVUjpcELgyC/FjbuXlzkVzi
         ru3mEhoYKvtZQ5eZy4m4bGUKl0gIK/j+BaQHCu3pM2dHN0CWl5179FvYYULxRc7taJub
         zioZ0vVKeE7kuRQpa5csgK2LkRi8yMpl+Vg7BAEwAQuUkq70NvSfJbOURZ7q3vNpqsui
         xfjj39s7D7Gw8VIoFf1ogs1qOy3GR7JPZfmB5Hk3Ciw5jp8f8bH9w8cGhcqfUSSwf254
         L/B63vsFMRlRsRDNgwc8nqyDtKY93XuERstfDuH/HIjYzZzlCX38mAVDFt7vtrFrgc4R
         g8aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGkoY/Akn9zVrjfVjT1b6a0OqIvVVjoIe/6RLjwtIp3GFg37qpZj1hwrJi572u415MEbQUQLtMJtJmsHi6kFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyModMnn6nqdKK/Oi1bbXQY1T2C/KrINlLny253v3kh3EFMYoGk
	1VX/o3tghrEJggvnFmDo5yaCISgtaO8BLWMYN5Z1vBa8MoOII++TgsjRdKD07e4ZrKKS6kGQbXS
	RwoL3zaHr4PDsuw==
X-Google-Smtp-Source: AGHT+IE0UeIxcvW4sWEmR/bkmgByJwNW8P+A8YevEQyTyTugANoVv2ucJWTtbkx80tloETCejfPW0UGB4/cL2Q==
X-Received: from plbmg8.prod.google.com ([2002:a17:903:3488:b0:297:e597:f35b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2c04:b0:297:f8dd:4d8e with SMTP id d9443c01a7336-2984ede9532mr49845505ad.30.1762975388905;
 Wed, 12 Nov 2025 11:23:08 -0800 (PST)
Date: Wed, 12 Nov 2025 19:22:30 +0000
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112192232.442761-17-dmatlack@google.com>
Subject: [PATCH v2 16/18] vfio: selftests: Split libvfio.h into separate
 header files
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Split out the contents of libvfio.h into separate header files, but keep
libvfio.h as the top-level include that all tests can use.

Put all new header files into a libvfio/ subdirectory to avoid future
name conflicts in include paths when libvfio is used by other selftests
like KVM.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/libvfio.h      | 339 +-----------------
 .../vfio/lib/include/libvfio/assert.h         |  54 +++
 .../vfio/lib/include/libvfio/iommu.h          |  77 ++++
 .../vfio/lib/include/libvfio/iova_allocator.h |  23 ++
 .../lib/include/libvfio/vfio_pci_device.h     | 125 +++++++
 .../lib/include/libvfio/vfio_pci_driver.h     |  97 +++++
 6 files changed, 381 insertions(+), 334 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/assert.h
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/iova_allocator.h
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
index 3027af15e316..279ddcd70194 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
@@ -2,210 +2,11 @@
 #ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_H
 #define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_H
 
-#include <fcntl.h>
-#include <string.h>
-
-#include <uapi/linux/types.h>
-#include <linux/iommufd.h>
-#include <linux/list.h>
-#include <linux/pci_regs.h>
-#include <linux/vfio.h>
-
-#include "../../../kselftest.h"
-
-#define VFIO_LOG_AND_EXIT(...) do {		\
-	fprintf(stderr, "  " __VA_ARGS__);	\
-	fprintf(stderr, "\n");			\
-	exit(KSFT_FAIL);			\
-} while (0)
-
-#define VFIO_ASSERT_OP(_lhs, _rhs, _op, ...) do {				\
-	typeof(_lhs) __lhs = (_lhs);						\
-	typeof(_rhs) __rhs = (_rhs);						\
-										\
-	if (__lhs _op __rhs)							\
-		break;								\
-										\
-	fprintf(stderr, "%s:%u: Assertion Failure\n\n", __FILE__, __LINE__);	\
-	fprintf(stderr, "  Expression: " #_lhs " " #_op " " #_rhs "\n");	\
-	fprintf(stderr, "  Observed: %#lx %s %#lx\n",				\
-			(u64)__lhs, #_op, (u64)__rhs);				\
-	fprintf(stderr, "  [errno: %d - %s]\n", errno, strerror(errno));	\
-	VFIO_LOG_AND_EXIT(__VA_ARGS__);						\
-} while (0)
-
-#define VFIO_ASSERT_EQ(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, ==, ##__VA_ARGS__)
-#define VFIO_ASSERT_NE(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, !=, ##__VA_ARGS__)
-#define VFIO_ASSERT_LT(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, <, ##__VA_ARGS__)
-#define VFIO_ASSERT_LE(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, <=, ##__VA_ARGS__)
-#define VFIO_ASSERT_GT(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, >, ##__VA_ARGS__)
-#define VFIO_ASSERT_GE(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, >=, ##__VA_ARGS__)
-#define VFIO_ASSERT_TRUE(_a, ...) VFIO_ASSERT_NE(false, (_a), ##__VA_ARGS__)
-#define VFIO_ASSERT_FALSE(_a, ...) VFIO_ASSERT_EQ(false, (_a), ##__VA_ARGS__)
-#define VFIO_ASSERT_NULL(_a, ...) VFIO_ASSERT_EQ(NULL, _a, ##__VA_ARGS__)
-#define VFIO_ASSERT_NOT_NULL(_a, ...) VFIO_ASSERT_NE(NULL, _a, ##__VA_ARGS__)
-
-#define VFIO_FAIL(_fmt, ...) do {				\
-	fprintf(stderr, "%s:%u: FAIL\n\n", __FILE__, __LINE__);	\
-	VFIO_LOG_AND_EXIT(_fmt, ##__VA_ARGS__);			\
-} while (0)
-
-#define ioctl_assert(_fd, _op, _arg) do {						       \
-	void *__arg = (_arg);								       \
-	int __ret = ioctl((_fd), (_op), (__arg));					       \
-	VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
-} while (0)
-
-#define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
-#define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
-
-struct iommu_mode {
-	const char *name;
-	const char *container_path;
-	unsigned long iommu_type;
-};
-
-/*
- * Generator for VFIO selftests fixture variants that replicate across all
- * possible IOMMU modes. Tests must define FIXTURE_VARIANT_ADD_IOMMU_MODE()
- * which should then use FIXTURE_VARIANT_ADD() to create the variant.
- */
-#define FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(...) \
-FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1_iommu, ##__VA_ARGS__); \
-FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1v2_iommu, ##__VA_ARGS__); \
-FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1, ##__VA_ARGS__); \
-FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1v2, ##__VA_ARGS__); \
-FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd, ##__VA_ARGS__)
-
-struct vfio_pci_bar {
-	struct vfio_region_info info;
-	void *vaddr;
-};
-
-typedef u64 iova_t;
-
-#define INVALID_IOVA UINT64_MAX
-
-struct dma_region {
-	struct list_head link;
-	void *vaddr;
-	iova_t iova;
-	u64 size;
-};
-
-struct vfio_pci_device;
-
-struct vfio_pci_driver_ops {
-	const char *name;
-
-	/**
-	 * @probe() - Check if the driver supports the given device.
-	 *
-	 * Return: 0 on success, non-0 on failure.
-	 */
-	int (*probe)(struct vfio_pci_device *device);
-
-	/**
-	 * @init() - Initialize the driver for @device.
-	 *
-	 * Must be called after device->driver.region has been initialized.
-	 */
-	void (*init)(struct vfio_pci_device *device);
-
-	/**
-	 * remove() - Deinitialize the driver for @device.
-	 */
-	void (*remove)(struct vfio_pci_device *device);
-
-	/**
-	 * memcpy_start() - Kick off @count repeated memcpy operations from
-	 * [@src, @src + @size) to [@dst, @dst + @size).
-	 *
-	 * Guarantees:
-	 *  - The device will attempt DMA reads on [src, src + size).
-	 *  - The device will attempt DMA writes on [dst, dst + size).
-	 *  - The device will not generate any interrupts.
-	 *
-	 * memcpy_start() returns immediately, it does not wait for the
-	 * copies to complete.
-	 */
-	void (*memcpy_start)(struct vfio_pci_device *device,
-			     iova_t src, iova_t dst, u64 size, u64 count);
-
-	/**
-	 * memcpy_wait() - Wait until the memcpy operations started by
-	 * memcpy_start() have finished.
-	 *
-	 * Guarantees:
-	 *  - All in-flight DMAs initiated by memcpy_start() are fully complete
-	 *    before memcpy_wait() returns.
-	 *
-	 * Returns non-0 if the driver detects that an error occurred during the
-	 * memcpy, 0 otherwise.
-	 */
-	int (*memcpy_wait)(struct vfio_pci_device *device);
-
-	/**
-	 * send_msi() - Make the device send the MSI device->driver.msi.
-	 *
-	 * Guarantees:
-	 *  - The device will send the MSI once.
-	 */
-	void (*send_msi)(struct vfio_pci_device *device);
-};
-
-struct vfio_pci_driver {
-	const struct vfio_pci_driver_ops *ops;
-	bool initialized;
-	bool memcpy_in_progress;
-
-	/* Region to be used by the driver (e.g. for in-memory descriptors) */
-	struct dma_region region;
-
-	/* The maximum size that can be passed to memcpy_start(). */
-	u64 max_memcpy_size;
-
-	/* The maximum count that can be passed to memcpy_start(). */
-	u64 max_memcpy_count;
-
-	/* The MSI vector the device will signal in ops->send_msi(). */
-	int msi;
-};
-
-struct iommu {
-	const struct iommu_mode *mode;
-	int container_fd;
-	int iommufd;
-	u32 ioas_id;
-	struct list_head dma_regions;
-};
-
-struct vfio_pci_device {
-	const char *bdf;
-	int fd;
-	int group_fd;
-
-	struct iommu *iommu;
-
-	struct vfio_device_info info;
-	struct vfio_region_info config_space;
-	struct vfio_pci_bar bars[PCI_STD_NUM_BARS];
-
-	struct vfio_irq_info msi_info;
-	struct vfio_irq_info msix_info;
-
-	/* eventfds for MSI and MSI-x interrupts */
-	int msi_eventfds[PCI_MSIX_FLAGS_QSIZE + 1];
-
-	struct vfio_pci_driver driver;
-};
-
-struct iova_allocator {
-	struct iommu_iova_range *ranges;
-	u32 nranges;
-	u32 range_idx;
-	u64 range_offset;
-};
+#include <libvfio/assert.h>
+#include <libvfio/iommu.h>
+#include <libvfio/iova_allocator.h>
+#include <libvfio/vfio_pci_device.h>
+#include <libvfio/vfio_pci_driver.h>
 
 /*
  * Return the BDF string of the device that the test should use.
@@ -222,134 +23,4 @@ struct iova_allocator {
 const char *vfio_selftests_get_bdf(int *argc, char *argv[]);
 char **vfio_selftests_get_bdfs(int *argc, char *argv[], int *nr_bdfs);
 
-const char *vfio_pci_get_cdev_path(const char *bdf);
-
-extern const char *default_iommu_mode;
-
-struct iommu *iommu_init(const char *iommu_mode);
-void iommu_cleanup(struct iommu *iommu);
-
-int __iommu_map(struct iommu *iommu, struct dma_region *region);
-
-static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
-{
-	VFIO_ASSERT_EQ(__iommu_map(iommu, region), 0);
-}
-
-int __iommu_unmap(struct iommu *iommu, struct dma_region *region, u64 *unmapped);
-
-static inline void iommu_unmap(struct iommu *iommu, struct dma_region *region)
-{
-	VFIO_ASSERT_EQ(__iommu_unmap(iommu, region, NULL), 0);
-}
-
-int __iommu_unmap_all(struct iommu *iommu, u64 *unmapped);
-
-static inline void iommu_unmap_all(struct iommu *iommu)
-{
-	VFIO_ASSERT_EQ(__iommu_unmap_all(iommu, NULL), 0);
-}
-
-iova_t __iommu_hva2iova(struct iommu *iommu, void *vaddr);
-iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr);
-
-struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges);
-
-struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
-void vfio_pci_device_cleanup(struct vfio_pci_device *device);
-
-void vfio_pci_device_reset(struct vfio_pci_device *device);
-
-struct iova_allocator *iova_allocator_init(struct iommu *iommu);
-void iova_allocator_cleanup(struct iova_allocator *allocator);
-iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size);
-
-void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
-			    size_t config, size_t size, void *data);
-
-#define vfio_pci_config_read(_device, _offset, _type) ({			    \
-	_type __data;								    \
-	vfio_pci_config_access((_device), false, _offset, sizeof(__data), &__data); \
-	__data;									    \
-})
-
-#define vfio_pci_config_readb(_d, _o) vfio_pci_config_read(_d, _o, u8)
-#define vfio_pci_config_readw(_d, _o) vfio_pci_config_read(_d, _o, u16)
-#define vfio_pci_config_readl(_d, _o) vfio_pci_config_read(_d, _o, u32)
-
-#define vfio_pci_config_write(_device, _offset, _value, _type) do {		  \
-	_type __data = (_value);						  \
-	vfio_pci_config_access((_device), true, _offset, sizeof(_type), &__data); \
-} while (0)
-
-#define vfio_pci_config_writeb(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u8)
-#define vfio_pci_config_writew(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u16)
-#define vfio_pci_config_writel(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u32)
-
-void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
-			 u32 vector, int count);
-void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
-void vfio_pci_irq_trigger(struct vfio_pci_device *device, u32 index, u32 vector);
-
-static inline void fcntl_set_nonblock(int fd)
-{
-	int r;
-
-	r = fcntl(fd, F_GETFL, 0);
-	VFIO_ASSERT_NE(r, -1, "F_GETFL failed for fd %d\n", fd);
-
-	r = fcntl(fd, F_SETFL, r | O_NONBLOCK);
-	VFIO_ASSERT_NE(r, -1, "F_SETFL O_NONBLOCK failed for fd %d\n", fd);
-}
-
-static inline void vfio_pci_msi_enable(struct vfio_pci_device *device,
-				       u32 vector, int count)
-{
-	vfio_pci_irq_enable(device, VFIO_PCI_MSI_IRQ_INDEX, vector, count);
-}
-
-static inline void vfio_pci_msi_disable(struct vfio_pci_device *device)
-{
-	vfio_pci_irq_disable(device, VFIO_PCI_MSI_IRQ_INDEX);
-}
-
-static inline void vfio_pci_msix_enable(struct vfio_pci_device *device,
-					u32 vector, int count)
-{
-	vfio_pci_irq_enable(device, VFIO_PCI_MSIX_IRQ_INDEX, vector, count);
-}
-
-static inline void vfio_pci_msix_disable(struct vfio_pci_device *device)
-{
-	vfio_pci_irq_disable(device, VFIO_PCI_MSIX_IRQ_INDEX);
-}
-
-static inline iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
-{
-	return __iommu_hva2iova(device->iommu, vaddr);
-}
-
-static inline iova_t to_iova(struct vfio_pci_device *device, void *vaddr)
-{
-	return iommu_hva2iova(device->iommu, vaddr);
-}
-
-static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
-					 u16 vendor_id, u16 device_id)
-{
-	return (vendor_id == vfio_pci_config_readw(device, PCI_VENDOR_ID)) &&
-		(device_id == vfio_pci_config_readw(device, PCI_DEVICE_ID));
-}
-
-void vfio_pci_driver_probe(struct vfio_pci_device *device);
-void vfio_pci_driver_init(struct vfio_pci_device *device);
-void vfio_pci_driver_remove(struct vfio_pci_device *device);
-int vfio_pci_driver_memcpy(struct vfio_pci_device *device,
-			   iova_t src, iova_t dst, u64 size);
-void vfio_pci_driver_memcpy_start(struct vfio_pci_device *device,
-				  iova_t src, iova_t dst, u64 size,
-				  u64 count);
-int vfio_pci_driver_memcpy_wait(struct vfio_pci_device *device);
-void vfio_pci_driver_send_msi(struct vfio_pci_device *device);
-
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_H */
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
new file mode 100644
index 000000000000..f4ebd122d9b6
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_ASSERT_H
+#define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_ASSERT_H
+
+#include <stdio.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "../../../../kselftest.h"
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
+#define ioctl_assert(_fd, _op, _arg) do {						       \
+	void *__arg = (_arg);								       \
+	int __ret = ioctl((_fd), (_op), (__arg));					       \
+	VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
+} while (0)
+
+#endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_ASSERT_H */
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
new file mode 100644
index 000000000000..e35f13ed3f3c
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_IOMMU_H
+#define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_IOMMU_H
+
+#include <linux/list.h>
+#include <linux/types.h>
+
+#include <libvfio/assert.h>
+
+typedef u64 iova_t;
+#define INVALID_IOVA UINT64_MAX
+
+struct iommu_mode {
+	const char *name;
+	const char *container_path;
+	unsigned long iommu_type;
+};
+
+extern const char *default_iommu_mode;
+
+struct dma_region {
+	struct list_head link;
+	void *vaddr;
+	iova_t iova;
+	u64 size;
+};
+
+struct iommu {
+	const struct iommu_mode *mode;
+	int container_fd;
+	int iommufd;
+	u32 ioas_id;
+	struct list_head dma_regions;
+};
+
+struct iommu *iommu_init(const char *iommu_mode);
+void iommu_cleanup(struct iommu *iommu);
+
+int __iommu_map(struct iommu *iommu, struct dma_region *region);
+
+static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
+{
+	VFIO_ASSERT_EQ(__iommu_map(iommu, region), 0);
+}
+
+int __iommu_unmap(struct iommu *iommu, struct dma_region *region, u64 *unmapped);
+
+static inline void iommu_unmap(struct iommu *iommu, struct dma_region *region)
+{
+	VFIO_ASSERT_EQ(__iommu_unmap(iommu, region, NULL), 0);
+}
+
+int __iommu_unmap_all(struct iommu *iommu, u64 *unmapped);
+
+static inline void iommu_unmap_all(struct iommu *iommu)
+{
+	VFIO_ASSERT_EQ(__iommu_unmap_all(iommu, NULL), 0);
+}
+
+iova_t __iommu_hva2iova(struct iommu *iommu, void *vaddr);
+iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr);
+
+struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges);
+
+/*
+ * Generator for VFIO selftests fixture variants that replicate across all
+ * possible IOMMU modes. Tests must define FIXTURE_VARIANT_ADD_IOMMU_MODE()
+ * which should then use FIXTURE_VARIANT_ADD() to create the variant.
+ */
+#define FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(...) \
+FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1_iommu, ##__VA_ARGS__); \
+FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1v2_iommu, ##__VA_ARGS__); \
+FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1, ##__VA_ARGS__); \
+FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1v2, ##__VA_ARGS__); \
+FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd, ##__VA_ARGS__)
+
+#endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_IOMMU_H */
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iova_allocator.h b/tools/testing/selftests/vfio/lib/include/libvfio/iova_allocator.h
new file mode 100644
index 000000000000..8f1d994e9ea2
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iova_allocator.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_IOVA_ALLOCATOR_H
+#define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_IOVA_ALLOCATOR_H
+
+#include <uapi/linux/types.h>
+#include <linux/list.h>
+#include <linux/types.h>
+#include <linux/iommufd.h>
+
+#include <libvfio/iommu.h>
+
+struct iova_allocator {
+	struct iommu_iova_range *ranges;
+	u32 nranges;
+	u32 range_idx;
+	u64 range_offset;
+};
+
+struct iova_allocator *iova_allocator_init(struct iommu *iommu);
+void iova_allocator_cleanup(struct iova_allocator *allocator);
+iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size);
+
+#endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_IOVA_ALLOCATOR_H */
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
new file mode 100644
index 000000000000..160e003131d6
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DEVICE_H
+#define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DEVICE_H
+
+#include <fcntl.h>
+#include <linux/vfio.h>
+#include <linux/pci_regs.h>
+
+#include <libvfio/assert.h>
+#include <libvfio/iommu.h>
+#include <libvfio/vfio_pci_driver.h>
+
+struct vfio_pci_bar {
+	struct vfio_region_info info;
+	void *vaddr;
+};
+
+struct vfio_pci_device {
+	const char *bdf;
+	int fd;
+	int group_fd;
+
+	struct iommu *iommu;
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
+
+	struct vfio_pci_driver driver;
+};
+
+#define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
+#define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
+
+struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
+void vfio_pci_device_cleanup(struct vfio_pci_device *device);
+
+void vfio_pci_device_reset(struct vfio_pci_device *device);
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
+static inline void fcntl_set_nonblock(int fd)
+{
+	int r;
+
+	r = fcntl(fd, F_GETFL, 0);
+	VFIO_ASSERT_NE(r, -1, "F_GETFL failed for fd %d\n", fd);
+
+	r = fcntl(fd, F_SETFL, r | O_NONBLOCK);
+	VFIO_ASSERT_NE(r, -1, "F_SETFL O_NONBLOCK failed for fd %d\n", fd);
+}
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
+static inline iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
+{
+	return __iommu_hva2iova(device->iommu, vaddr);
+}
+
+static inline iova_t to_iova(struct vfio_pci_device *device, void *vaddr)
+{
+	return iommu_hva2iova(device->iommu, vaddr);
+}
+
+static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
+					 u16 vendor_id, u16 device_id)
+{
+	return (vendor_id == vfio_pci_config_readw(device, PCI_VENDOR_ID)) &&
+		(device_id == vfio_pci_config_readw(device, PCI_DEVICE_ID));
+}
+
+const char *vfio_pci_get_cdev_path(const char *bdf);
+
+#endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DEVICE_H */
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
new file mode 100644
index 000000000000..e5ada209b1d1
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DRIVER_H
+#define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DRIVER_H
+
+#include <libvfio/iommu.h>
+
+struct vfio_pci_device;
+
+struct vfio_pci_driver_ops {
+	const char *name;
+
+	/**
+	 * @probe() - Check if the driver supports the given device.
+	 *
+	 * Return: 0 on success, non-0 on failure.
+	 */
+	int (*probe)(struct vfio_pci_device *device);
+
+	/**
+	 * @init() - Initialize the driver for @device.
+	 *
+	 * Must be called after device->driver.region has been initialized.
+	 */
+	void (*init)(struct vfio_pci_device *device);
+
+	/**
+	 * remove() - Deinitialize the driver for @device.
+	 */
+	void (*remove)(struct vfio_pci_device *device);
+
+	/**
+	 * memcpy_start() - Kick off @count repeated memcpy operations from
+	 * [@src, @src + @size) to [@dst, @dst + @size).
+	 *
+	 * Guarantees:
+	 *  - The device will attempt DMA reads on [src, src + size).
+	 *  - The device will attempt DMA writes on [dst, dst + size).
+	 *  - The device will not generate any interrupts.
+	 *
+	 * memcpy_start() returns immediately, it does not wait for the
+	 * copies to complete.
+	 */
+	void (*memcpy_start)(struct vfio_pci_device *device,
+			     iova_t src, iova_t dst, u64 size, u64 count);
+
+	/**
+	 * memcpy_wait() - Wait until the memcpy operations started by
+	 * memcpy_start() have finished.
+	 *
+	 * Guarantees:
+	 *  - All in-flight DMAs initiated by memcpy_start() are fully complete
+	 *    before memcpy_wait() returns.
+	 *
+	 * Returns non-0 if the driver detects that an error occurred during the
+	 * memcpy, 0 otherwise.
+	 */
+	int (*memcpy_wait)(struct vfio_pci_device *device);
+
+	/**
+	 * send_msi() - Make the device send the MSI device->driver.msi.
+	 *
+	 * Guarantees:
+	 *  - The device will send the MSI once.
+	 */
+	void (*send_msi)(struct vfio_pci_device *device);
+};
+
+struct vfio_pci_driver {
+	const struct vfio_pci_driver_ops *ops;
+	bool initialized;
+	bool memcpy_in_progress;
+
+	/* Region to be used by the driver (e.g. for in-memory descriptors) */
+	struct dma_region region;
+
+	/* The maximum size that can be passed to memcpy_start(). */
+	u64 max_memcpy_size;
+
+	/* The maximum count that can be passed to memcpy_start(). */
+	u64 max_memcpy_count;
+
+	/* The MSI vector the device will signal in ops->send_msi(). */
+	int msi;
+};
+
+void vfio_pci_driver_probe(struct vfio_pci_device *device);
+void vfio_pci_driver_init(struct vfio_pci_device *device);
+void vfio_pci_driver_remove(struct vfio_pci_device *device);
+int vfio_pci_driver_memcpy(struct vfio_pci_device *device,
+			   iova_t src, iova_t dst, u64 size);
+void vfio_pci_driver_memcpy_start(struct vfio_pci_device *device,
+				  iova_t src, iova_t dst, u64 size,
+				  u64 count);
+int vfio_pci_driver_memcpy_wait(struct vfio_pci_device *device);
+void vfio_pci_driver_send_msi(struct vfio_pci_device *device);
+
+#endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DRIVER_H */
-- 
2.52.0.rc1.455.g30608eb744-goog


