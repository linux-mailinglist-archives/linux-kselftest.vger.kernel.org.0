Return-Path: <linux-kselftest+bounces-47749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 927D3CD232D
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 00:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF194307316E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 23:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83BB2F1FE7;
	Fri, 19 Dec 2025 23:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlfNE4gW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC6C2EDD40
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 23:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766187511; cv=none; b=j07btadrpGNJlhvJZTbIhwZETIL97ozKCJBQymSaa+0GDdTzw7DMnrwI6Mh7JjDKIJTa8pdFSkf/O4nxoEw3OVgqpWHtoeeDQcQKkht/w4wP6aD3/JWI6ycmVkvKmZJqqgosL9AhGhxpXtISkGaf6dQE/6afSN+gMVIcW/0F7+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766187511; c=relaxed/simple;
	bh=JyC9eo530M5ljalMP8uuCAafPZED6nTNfGN1kJNfXdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rncBP4Z+OzYuKeHSKnwGppSaXalbiy4l0tBJP2r/I3HI5sl+UXhJDQhd3B6GCQ1SyggH0H1f+hofTMfK4Q4ricLJ/a8gabUwp/HbaiOwNcmY+kooPiR7EbjCc+VZlIiXg9ibixrM+JCMf2OGifKMf0et1NJDdRlPsjnuuRkyCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlfNE4gW; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a99a5f77e0so3545181b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 15:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766187509; x=1766792309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kYrEUFHHSrWSjApG9MRx026qZB/VzRtJqC7WAFxS0uY=;
        b=mlfNE4gWkMVLCavOHNJvzXBoNZqjNweEDxlHLW//oNNSLlw8B170gL71o4v4WbROYt
         DbrxwA4b0PFsqPXmc7q8j4IP9/pXoBoDwENSgboW3gyfa5dWXCa+kEITM20M/irBGkIP
         RsnqPKI+5cDzOPsQUi56ZEj8U8mRPfTNz9Qwc4FDFJsPcxurJFnsrGCK441xZEe6W4dP
         WxI9p5c+fzwslqR7e9gFAkDQZHV8DUSuOD4OlpRVC+dGyCzLhZ7CHhagnZWQZKLtq/XW
         kLnsJCS79qe3uyO/60kFSaA2u5hjGIGDM1BCeVDF22VOvLCChNDrR5ZqGv+o/nF5hICQ
         FhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766187509; x=1766792309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYrEUFHHSrWSjApG9MRx026qZB/VzRtJqC7WAFxS0uY=;
        b=lUf0C8iSrx7v/DyB3w/AAFod6P9TeopGCl1w6eOdg0tta9bYLD5cHO8ssbrS5odMVW
         LAmV0SOumSVFysUx4GuVY8y/cnIdv30CnyBlacz9wAxsiQkHfB8VKg4E97iDEiCN4OGI
         ueTw6YkE0GE54aiMs2Rk7zFvPXzvkxk8p1qqBAF3KDp/BphBbw0qNdU5//r2dZrP2IvG
         1tx11uk1BaWkWshy04IirMiIw3S9h6+seYaDnTZoZz5XFv4e+2EhmYy06Da8pe4PnKyM
         TLm+jRCBntDXHonGk9Cy7pDoPptPJ3LX5Dh51TABXF8BIW0OEO/IDj3jwWgaQmFVw2Ta
         wKsA==
X-Forwarded-Encrypted: i=1; AJvYcCVGCxEPVg+WtzBCsHAZyH6KwULBbGOZYEMQNaR0L4v0CqkH6nh4BcRqjimQxqh5MsQem9AcTrL/KfvYM2G/J8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvFNGaipQ505rrceum2molSdyWQyo4V3Nsa6aOXLrVZ3spBvLl
	EjQB8ZvByczuFwkyq75IUhjn3RvBUCBpEl/bhaQT2EEAa8SoSFEkdelosD2zjStZxmwHPdtCnr6
	3ex9voGOwvWa7jg==
X-Google-Smtp-Source: AGHT+IFdwBcyxhazmcoTlALhwwLvbQZw8lpAuq+J+NHXrsmB1i51VsdgscFDGcvBfCw/ezW9ut9mRL7qW+KWSQ==
X-Received: from pfbcu6.prod.google.com ([2002:a05:6a00:4486:b0:7fb:bab5:e6e1])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:278b:b0:782:7052:5167 with SMTP id d2e1a72fcca58-7ff650c7fe1mr4234814b3a.6.1766187509445;
 Fri, 19 Dec 2025 15:38:29 -0800 (PST)
Date: Fri, 19 Dec 2025 23:38:18 +0000
In-Reply-To: <20251219233818.1965306-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219233818.1965306-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219233818.1965306-3-dmatlack@google.com>
Subject: [PATCH 2/2] vfio: selftests: Drop <uapi/linux/types.h> includes
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Matlack <dmatlack@google.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop the <uapi/linux/types.h> includes now that <linux/types.h>
(tools/include/linux/types.h) has a definition for __aligned_le64, which
is needed by <linux/iommufd.h>.

Including <uapi/linux/types.h> is harmless but causes benign typedef
redifitions. This is not a problem for VFIO selftests but be an issue
when the VFIO selftests library is built into KVM selftests, since they
are built with -std=gnu99 which does not allow typedef redifitions.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../testing/selftests/vfio/lib/include/libvfio/iova_allocator.h  | 1 -
 tools/testing/selftests/vfio/lib/iommu.c                         | 1 -
 tools/testing/selftests/vfio/lib/iova_allocator.c                | 1 -
 tools/testing/selftests/vfio/lib/vfio_pci_device.c               | 1 -
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c             | 1 -
 tools/testing/selftests/vfio/vfio_iommufd_setup_test.c           | 1 -
 6 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iova_allocator.h b/tools/testing/selftests/vfio/lib/include/libvfio/iova_allocator.h
index 8f1d994e9ea2..c7c0796a757f 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iova_allocator.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iova_allocator.h
@@ -2,7 +2,6 @@
 #ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_IOVA_ALLOCATOR_H
 #define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_IOVA_ALLOCATOR_H
 
-#include <uapi/linux/types.h>
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/iommufd.h>
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 8079d43523f3..58b7fb7430d4 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -11,7 +11,6 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 
-#include <uapi/linux/types.h>
 #include <linux/limits.h>
 #include <linux/mman.h>
 #include <linux/types.h>
diff --git a/tools/testing/selftests/vfio/lib/iova_allocator.c b/tools/testing/selftests/vfio/lib/iova_allocator.c
index a12b0a51e9e6..8c1cc86b70cd 100644
--- a/tools/testing/selftests/vfio/lib/iova_allocator.c
+++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
@@ -11,7 +11,6 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 
-#include <uapi/linux/types.h>
 #include <linux/iommufd.h>
 #include <linux/limits.h>
 #include <linux/mman.h>
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 13fdb4b0b10f..0b335e4e0435 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -11,7 +11,6 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 
-#include <uapi/linux/types.h>
 #include <linux/iommufd.h>
 #include <linux/limits.h>
 #include <linux/mman.h>
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 5397822c3dd4..41b8cae7a6ae 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -3,7 +3,6 @@
 #include <sys/mman.h>
 #include <unistd.h>
 
-#include <uapi/linux/types.h>
 #include <linux/iommufd.h>
 #include <linux/limits.h>
 #include <linux/mman.h>
diff --git a/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
index caf1c6291f3d..5d980b148d83 100644
--- a/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
+++ b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <uapi/linux/types.h>
 #include <linux/limits.h>
 #include <linux/sizes.h>
 #include <linux/vfio.h>
-- 
2.52.0.322.g1dd061c0dc-goog


