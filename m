Return-Path: <linux-kselftest+bounces-46594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFA8C8C598
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 00:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A503B6D63
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 23:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F8A34C815;
	Wed, 26 Nov 2025 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QT8nFuzK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600AC34B40F
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199092; cv=none; b=oTOi8kuYl7yvvcVs3j6kTwuA9cdfmy/QVHnetRVcC39ZMJX5ntj4rS4F9zo2BTKrIm8+n7aptoxg7sxYZL6ATmhznbk+vfd5SZb8vPI+nbxAZn2yiEH4Vxp2EpcZRF5hf+JAfCiX0yINNqGCXZB48L9U0eYIoYrG8AZ3feojPY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199092; c=relaxed/simple;
	bh=M6/7abdf2MC2Xy1le80ucuSHzCbihEHYWHlnyVXgAu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mM2F8lkoH6NxK8aGgUmeHTYvdN7C3k8+AVxtbfb3yAK+6mldLD+cXvWBhkqSwHUcP8G/zoO4osaEfDxU6FR2EKrE8CpVCqHuCwzfp8NxpVFq2JodZcsSOor5Pc27nfSI1kWwUVM8jfy2W6uPS5rwfCfx7ul1VH0lux1YoacmXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QT8nFuzK; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7ba92341f38so224983b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 15:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764199090; x=1764803890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s516YdCf56L10Nf5ouIlScriBpKh0xtdZsdOxgkhbv8=;
        b=QT8nFuzKcMuaIzUCnzdN6GYSGGiVDfFkxhVXxTaJXN6l1yVtL4q3UZDg++7VgE8Qvd
         /VgHIV5P5kIVOSBwxrygBO0KW9UlI2xtJgwKpuubdF2QQ3IHjl7FdWupqEnd1Hi3OQlo
         NCOWui6wuV5nhsPK3SdUFxyeKA/5AFKxUHswTMOIYreNsz4hypiDLTTxiZ8HfpYr0o4U
         u2N+1CXK1Kz6zBtW7LgEOs4cbF0FTeaYkbqqRbDdV4RlcHGidsFHTDdGOcXmehUWHzvF
         wv8ZL6tfU/KlaTp9B3mElV44rnJiJr8Mab+14QYp+iM1kn21p2UjGR119VqNpkFpN6L1
         Lavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199090; x=1764803890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s516YdCf56L10Nf5ouIlScriBpKh0xtdZsdOxgkhbv8=;
        b=daBIfTAK37SPhRJl5wuqS8PzzNUYtnnAraDk9Aq1RczFwIRB0GB1u/geJIRqH/X1dl
         nUQ0x9Z3NbjVKgNGMKuFUtuYT/odz3eGwyHoL3gLzJTbm2v6cEzulYArohqsiVZF/dC9
         LiS/IXiS6YkpStBShGJM68GAMXCf77rZG/OuxTyDJxLClG+QSR3raBGLj/qZJb0Al3Tk
         tsIbQ4vtuhFj9Quoff/CqwzphEBb/P8EDJ99rtDbWZ61U3ujkesnN7SN6k2P/p4Q+GLK
         RcTMttg93BSzmwjxtcxOk3Szr/i9/exjyPPnqnM7QNUCwAl1B66nNfuIvS2/xNmIUnMu
         yWSw==
X-Forwarded-Encrypted: i=1; AJvYcCUn/oyQXKiUybdllNCJVVtLAhlhM0csArGF2ZQY8Eq5lZWK7l0erO3LrBYC3RH+sHRbl9bYO67CkvmLFtXjwG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyVUnyOk+IP2Dx9e/+nw2MJKp5xGvaZeZjFwA7w9zcsCUb6tqU
	jWSJauwUfumcTRU149a3lM31pN4Bs6IVOg1TfeZj6qc7DbM+EgEUVZCTtqtwmoOpdjNlrl4ZR4y
	RKEfpScpk8eZ5Zg==
X-Google-Smtp-Source: AGHT+IExT2hyCx/ABRiZGBH/ZPh6lmfNqDj7pyzpnnmcR8EGeKqBBtjsR5K8Vh7A3OLg1AxtSt+YgWER3wFxug==
X-Received: from pfbfu4.prod.google.com ([2002:a05:6a00:6104:b0:7ba:1df4:a383])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3a1c:b0:7ad:1082:fdf0 with SMTP id d2e1a72fcca58-7ca8b597625mr9836178b3a.31.1764199089757;
 Wed, 26 Nov 2025 15:18:09 -0800 (PST)
Date: Wed, 26 Nov 2025 23:17:33 +0000
In-Reply-To: <20251126231733.3302983-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126231733.3302983-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126231733.3302983-19-dmatlack@google.com>
Subject: [PATCH v4 18/18] vfio: selftests: Add vfio_pci_device_init_perf_test
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new VFIO selftest for measuring the time it takes to run
vfio_pci_device_init() in parallel for one or more devices.

This test serves as manual regression test for the performance
improvement of commit e908f58b6beb ("vfio/pci: Separate SR-IOV VF
dev_set"). For example, when running this test with 64 VFs under the
same PF:

Before:

  $ ./vfio_pci_device_init_perf_test -r vfio_pci_device_init_perf_test.iommufd.init 0000:1a:00.0 0000:1a:00.1 ...
  ...
  Wall time: 6.653234463s
  Min init time (per device): 0.101215344s
  Max init time (per device): 6.652755941s
  Avg init time (per device): 3.377609608s

After:

  $ ./vfio_pci_device_init_perf_test -r vfio_pci_device_init_perf_test.iommufd.init 0000:1a:00.0 0000:1a:00.1 ...
  ...
  Wall time: 0.122978332s
  Min init time (per device): 0.108121915s
  Max init time (per device): 0.122762761s
  Avg init time (per device): 0.113816748s

This test does not make any assertions about performance, since any such
assertion is likely to be flaky due to system differences and random
noise. However this test can be fed into automation to detect
regressions, and can be used by developers in the future to measure
performance optimizations.

Suggested-by: Aaron Lewis <aaronlewis@google.com>
Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   3 +
 .../vfio/vfio_pci_device_init_perf_test.c     | 168 ++++++++++++++++++
 2 files changed, 171 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index a29f99395206..3c796ca99a50 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -2,6 +2,7 @@ CFLAGS = $(KHDR_INCLUDES)
 TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
+TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
 
 TEST_FILES += scripts/cleanup.sh
@@ -16,6 +17,8 @@ CFLAGS += -I$(top_srcdir)/tools/include
 CFLAGS += -MD
 CFLAGS += $(EXTRA_CFLAGS)
 
+LDFLAGS += -pthread
+
 $(TEST_GEN_PROGS): %: %.o $(LIBVFIO_O)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c b/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
new file mode 100644
index 000000000000..33b0c31fe2ed
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <pthread.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/sizes.h>
+#include <linux/time64.h>
+#include <linux/vfio.h>
+
+#include <libvfio.h>
+
+#include "../kselftest_harness.h"
+
+static char **device_bdfs;
+static int nr_devices;
+
+struct thread_args {
+	struct iommu *iommu;
+	int device_index;
+	struct timespec start;
+	struct timespec end;
+	pthread_barrier_t *barrier;
+};
+
+FIXTURE(vfio_pci_device_init_perf_test) {
+	pthread_t *threads;
+	pthread_barrier_t barrier;
+	struct thread_args *thread_args;
+	struct iommu *iommu;
+};
+
+FIXTURE_VARIANT(vfio_pci_device_init_perf_test) {
+	const char *iommu_mode;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode)			\
+FIXTURE_VARIANT_ADD(vfio_pci_device_init_perf_test, _iommu_mode) {	\
+	.iommu_mode = #_iommu_mode,					\
+}
+
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
+
+FIXTURE_SETUP(vfio_pci_device_init_perf_test)
+{
+	int i;
+
+	self->iommu = iommu_init(variant->iommu_mode);
+	self->threads = calloc(nr_devices, sizeof(self->threads[0]));
+	self->thread_args = calloc(nr_devices, sizeof(self->thread_args[0]));
+
+	pthread_barrier_init(&self->barrier, NULL, nr_devices);
+
+	for (i = 0; i < nr_devices; i++) {
+		self->thread_args[i].iommu = self->iommu;
+		self->thread_args[i].barrier = &self->barrier;
+		self->thread_args[i].device_index = i;
+	}
+}
+
+FIXTURE_TEARDOWN(vfio_pci_device_init_perf_test)
+{
+	iommu_cleanup(self->iommu);
+	free(self->threads);
+	free(self->thread_args);
+}
+
+static s64 to_ns(struct timespec ts)
+{
+	return (s64)ts.tv_nsec + NSEC_PER_SEC * (s64)ts.tv_sec;
+}
+
+static struct timespec to_timespec(s64 ns)
+{
+	struct timespec ts = {
+		.tv_nsec = ns % NSEC_PER_SEC,
+		.tv_sec = ns / NSEC_PER_SEC,
+	};
+
+	return ts;
+}
+
+static struct timespec timespec_sub(struct timespec a, struct timespec b)
+{
+	return to_timespec(to_ns(a) - to_ns(b));
+}
+
+static struct timespec timespec_min(struct timespec a, struct timespec b)
+{
+	return to_ns(a) < to_ns(b) ? a : b;
+}
+
+static struct timespec timespec_max(struct timespec a, struct timespec b)
+{
+	return to_ns(a) > to_ns(b) ? a : b;
+}
+
+static void *thread_main(void *__args)
+{
+	struct thread_args *args = __args;
+	struct vfio_pci_device *device;
+
+	pthread_barrier_wait(args->barrier);
+
+	clock_gettime(CLOCK_MONOTONIC, &args->start);
+	device = vfio_pci_device_init(device_bdfs[args->device_index], args->iommu);
+	clock_gettime(CLOCK_MONOTONIC, &args->end);
+
+	pthread_barrier_wait(args->barrier);
+
+	vfio_pci_device_cleanup(device);
+	return NULL;
+}
+
+TEST_F(vfio_pci_device_init_perf_test, init)
+{
+	struct timespec start = to_timespec(INT64_MAX), end = {};
+	struct timespec min = to_timespec(INT64_MAX);
+	struct timespec max = {};
+	struct timespec avg = {};
+	struct timespec wall_time;
+	s64 thread_ns = 0;
+	int i;
+
+	for (i = 0; i < nr_devices; i++) {
+		pthread_create(&self->threads[i], NULL, thread_main,
+			       &self->thread_args[i]);
+	}
+
+	for (i = 0; i < nr_devices; i++) {
+		struct thread_args *args = &self->thread_args[i];
+		struct timespec init_time;
+
+		pthread_join(self->threads[i], NULL);
+
+		start = timespec_min(start, args->start);
+		end = timespec_max(end, args->end);
+
+		init_time = timespec_sub(args->end, args->start);
+		min = timespec_min(min, init_time);
+		max = timespec_max(max, init_time);
+		thread_ns += to_ns(init_time);
+	}
+
+	avg = to_timespec(thread_ns / nr_devices);
+	wall_time = timespec_sub(end, start);
+
+	printf("Wall time: %lu.%09lus\n",
+	       wall_time.tv_sec, wall_time.tv_nsec);
+	printf("Min init time (per device): %lu.%09lus\n",
+	       min.tv_sec, min.tv_nsec);
+	printf("Max init time (per device): %lu.%09lus\n",
+	       max.tv_sec, max.tv_nsec);
+	printf("Avg init time (per device): %lu.%09lus\n",
+	       avg.tv_sec, avg.tv_nsec);
+}
+
+int main(int argc, char *argv[])
+{
+	int i;
+
+	device_bdfs = vfio_selftests_get_bdfs(&argc, argv, &nr_devices);
+
+	printf("Testing parallel initialization of %d devices:\n", nr_devices);
+	for (i = 0; i < nr_devices; i++)
+		printf("    %s\n", device_bdfs[i]);
+
+	return test_harness_run(argc, argv);
+}
-- 
2.52.0.487.g5c8c507ade-goog


