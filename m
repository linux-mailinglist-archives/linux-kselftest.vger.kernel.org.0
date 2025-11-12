Return-Path: <linux-kselftest+bounces-45459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D850CC54285
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 20:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8293BF3BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 19:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F11C3559E6;
	Wed, 12 Nov 2025 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6NksHB8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61CF3557E1
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975395; cv=none; b=oyqYSG1pfEm9tV1iWuPypbLxvcT250YLihAx3wqrq0UahKU7HbxW/jl1cscjM0WZpYIW67HtHzqyyBrlWwdadkTBVK2S2kEfotcbvlEkraddiD0g2nT8upnFYSWFDmnGVaCT13ak7I4lNGXdOaObiqa1Yy3HCHrXDJsIbnaUm6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975395; c=relaxed/simple;
	bh=91BJdnU91RfIE/hJq59U7COO8d5lVht0pXvEtkmCCmc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mLpqAWV5r4k+TyRN8jXTix7x6+MA8jglBCl9+zJux3VYGYukmz2NbTinSIvxj1zoxVZAWBE54QcMUTONK0FQzssuzu5L5FVsawfmNkuSEYKT9KI06fyn28MwzcbwBAqu7XkRRysSZYeFxM+fkadHSFADv9AG9ZPtb+A+SjYW1ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j6NksHB8; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b5d4e1de6dso1314997b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975392; x=1763580192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2e+js0Qy7w6O0gL6/BZx4eVZarhnCcJq/+q0M3UtfI=;
        b=j6NksHB8XILDLfnhzIeKF/vc+U3FFRqipwTXzqQYFgNrgijzd0NVRMQraOJ1miZm3R
         mFt7M38YZS5OEOLKWiuXKSoaYi0u0aHel9bWSVjybgvnP8jnZzbXuhCZJdBytXjfnxlB
         c9Q8LSgL4psSu2K/tiera/35A4uTZRx02A3RGGwplfUhSYGFYgn4JN9j8ao6/yNLZ8iu
         PuT1E0ehsOtO2G5Z2WFOMS/IVKgKmy4W72JHe6b9SiYJXArqcrnQ6Nz4BPXVRuWmvhFp
         5qyEWfe482vI28Yt1HFE8L11ZqLpIzumQ+Z6nfkRkPDBoEyht14z3SDTZQO3jutgO0NO
         ycOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975392; x=1763580192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2e+js0Qy7w6O0gL6/BZx4eVZarhnCcJq/+q0M3UtfI=;
        b=v+WnnMM60gxEoSFVIiKsQXwgM0MjlJRzh9JQzN9sqVyfml9Y7rfZFtyOQnXldIE3HQ
         DMBXjNqisOBiHwKtyWJsvTE7pj7xFQf3ZhWGT2HejoMWgNLOK15pfQk7svvG9nIlg1Cv
         uJAa1ssFMooqg5VPQfLzdtjI+cjsNTmt9OhDyuBdYfa3xom07kosI4XlNh2+GCFDsqmY
         TfB05esnk4yQOAbuyDGTwIPp/ewXWmj6wZkmODUp0sxZNUzeL384vFVlLpg1xvExCQtF
         Yg6D6nwf5u3vbwVNWbYG9+cacsf2KTHdtugVXF1P4D/A21cQI6UA5edxh75WA9nxrMj1
         tgFw==
X-Forwarded-Encrypted: i=1; AJvYcCXhUXUtY0Mfm7e/Dyt0lvW8MMcdoI7u6PBYr7GqGtssa1F7XwSsRNNfElLJzsaRVLHwahFNozzhhrsC8MQhVQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZcy2OWLQze08Crj1ZEiV3wRA/Cxlkjl+VzGAAWNRKqaUW38ux
	YdGYFiT/A9cpAlQkyG4ZHBb9sA10KfHuVYwzLqMSHdHA0/WqQUYt3CJyeb2Kqj8XYQ4LKc7EFH1
	JopdEaWH1R7xCug==
X-Google-Smtp-Source: AGHT+IF8kvsYlmSEbjUQ/k2eUYglNUnLyK7Y7SQjAhLBmOM14SOm1bhd8hAnVvjd1DlYsknFTJKiG6sVMJVM+w==
X-Received: from pfrj16.prod.google.com ([2002:aa7:8dd0:0:b0:7af:2faf:c3af])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:88c8:0:b0:7ab:e007:deec with SMTP id d2e1a72fcca58-7b7a53c10cfmr5819330b3a.32.1762975392025;
 Wed, 12 Nov 2025 11:23:12 -0800 (PST)
Date: Wed, 12 Nov 2025 19:22:32 +0000
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112192232.442761-19-dmatlack@google.com>
Subject: [PATCH v2 18/18] vfio: selftests: Add vfio_pci_device_init_perf_test
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Aaron Lewis <aaronlewis@google.com>
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
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   3 +
 .../vfio/vfio_pci_device_init_perf_test.c     | 167 ++++++++++++++++++
 2 files changed, 170 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index e9e5c6dc63b6..8bb0b1e2d3a3 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -2,6 +2,7 @@ CFLAGS = $(KHDR_INCLUDES)
 TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
+TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
 
 TEST_PROGS_EXTENDED := scripts/cleanup.sh
@@ -15,6 +16,8 @@ CFLAGS += -I$(top_srcdir)/tools/include
 CFLAGS += -MD
 CFLAGS += $(EXTRA_CFLAGS)
 
+LDFLAGS += -pthread
+
 $(TEST_GEN_PROGS): %: %.o $(LIBVFIO_O)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c b/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
new file mode 100644
index 000000000000..54e327dadab4
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <pthread.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/sizes.h>
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
+	return (s64)ts.tv_nsec + 1000000000LL * (s64)ts.tv_sec;
+}
+
+static struct timespec to_timespec(s64 ns)
+{
+	struct timespec ts = {
+		.tv_nsec = ns % 1000000000LL,
+		.tv_sec = ns / 1000000000LL,
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
2.52.0.rc1.455.g30608eb744-goog


