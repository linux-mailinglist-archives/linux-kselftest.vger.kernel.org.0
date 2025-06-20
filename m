Return-Path: <linux-kselftest+bounces-35509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99199AE2634
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1397F189E8A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647A524EAAB;
	Fri, 20 Jun 2025 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MP/+35Zt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3624C669
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461687; cv=none; b=Rtpqq0d72vF/wxebv84sEYxkqYUVPAB1Q92GCs21Bm9PCjwQ65QCQvHg2Fkn5LJMTPJHvYPNJvr0dyutdi8lfs8yqpPIvdTfk9GKdMhXU2Wv7prWbah8VDfUSIdvbYFiHlTM4HzLSg3S2uJKT8IsyG3HIQctEXMo/PJE1OpBkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461687; c=relaxed/simple;
	bh=bQdZ28IjEALRU+tEqULvx9bwWA/p6t04xwS2TqTejzw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T/uz9Suz2gVONpikm8ExFfVZJ3pdd5eBhurIvy55xmy9S9b4/PAmRVFW/40eKZUVXdE3RY57a6YuRU3zblpAI3JvouvAUMkTBL8Sx26UvviP4Eepnxp4BglHmUqHjVHdDIkNIKTSZYgLpt6d3edjrynwhqg5in8IVQ9ivnoAyWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MP/+35Zt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311d670ad35so2057479a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461685; x=1751066485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMvcpC3EvAnEMNg38C2H0qABbPYvewT8mfGeCZ8DDSg=;
        b=MP/+35ZthcZkTy6fsCdAfKiV0cwehZMXniloqul4C0J52Cu3QyXN1pEk9QLIgMRjvf
         TURPlSFn1XM21rjzqTSr6gv746IcF1OZE5cAA2Oh9FKe0zV2U/c40O0+LidYcPg2s8AY
         ldGPoshOvDtEKxzn0nG+rLc92NyKTI6+VvCCbxYi/8cMyqFKnMvCiEvaxXdMnarv7lqg
         7w65Weh8GzhTNRiOqYxLzca+InB/o46s+J902cSKi9yZ+QmBrJFpLwFf3czXogaUadyv
         Tfuur9x5JoFaokFnZE3CoqnpqrLRcaZrucHtyohG/HmoRwPZJ7VaMgsc26nW9LEp1jNZ
         y8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461685; x=1751066485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMvcpC3EvAnEMNg38C2H0qABbPYvewT8mfGeCZ8DDSg=;
        b=orqHvILu/RyOyfEkcRZXta4PTgCTRJUobRfFI0llYv1T4fRPIzyBD3LW5DmlB3PIRs
         povvg7Lh9kC6SXQieZQxYuRqlCS8Cqf9Tz+6g/HBjJ7jD7yl4bFXm/kFms5g92FuqBNX
         6eHKDGFDzoTYP+n64lIBW6UV/V0fRuE1WR53d2/7r8URKYSLmUeTGcnKzmxxS+rlcwEs
         yyWqMwx7RaROrSJJmJ+cOA0Y1x7U7+I731RH2+5M6qn6Qldlo6donouce7bSqDT9ssOk
         qQWs4r/lurmpZWD/5zimcoayP04XqVM3ptvafFQSGbqgD+BnXEARRD4VcsYsMU4FmNa8
         zd8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtRIGElqBno9xKzqCILW6anvS11LI1ropA1oHIdcdapCC1j9QEoWEKbImhR6U9M5L/ub4Ehpan4XE7qvOA7Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLO8ZNCGFMlJVoKBNh/IYrWxWT35Wz2bCrDC1GkeqMqF5SuZtc
	InDIia4L/TH8ac0SK84K0q/GJmEMwGn3VSgA62VH7G98uqi70MJbskbik2l6gqFjmS4HqiS7qO1
	Itl9XZkwnFAJVCQ==
X-Google-Smtp-Source: AGHT+IHQ/fqY4NAKfIDGIIYtWiOhd4/6AqBKYQuzyt85lfMMgVtUVonQZz7vV+JVTtCgyhmyVytPOdy+jJF7xw==
X-Received: from pjbpd13.prod.google.com ([2002:a17:90b:1dcd:b0:313:221f:6571])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c4f:b0:313:1e9d:404b with SMTP id 98e67ed59e1d1-3159d62ac81mr7496524a91.2.1750461685328;
 Fri, 20 Jun 2025 16:21:25 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:13 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-16-dmatlack@google.com>
Subject: [PATCH 15/33] vfio: selftests: Enable asserting MSI eventfds not firing
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Make it possible to assert that a given MSI eventfd did _not_ fire by
adding a helper to mark an eventfd non-blocking. Demonstrate this in
vfio_pci_device_test by asserting the MSI eventfd did not fire before
vfio_pci_irq_trigger().

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/include/vfio_util.h | 12 ++++++++++++
 tools/testing/selftests/vfio/vfio_pci_device_test.c  | 10 +++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index db08646c2819..9c928fcc00e2 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -2,6 +2,7 @@
 #ifndef SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H
 #define SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H
 
+#include <fcntl.h>
 #include <string.h>
 #include <linux/vfio.h>
 #include <linux/list.h>
@@ -130,6 +131,17 @@ void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
 void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
 void vfio_pci_irq_trigger(struct vfio_pci_device *device, u32 index, u32 vector);
 
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
 static inline void vfio_pci_msi_enable(struct vfio_pci_device *device,
 				       u32 vector, int count)
 {
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 82e3c947f45d..1b5c2ff77e3f 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -129,6 +129,7 @@ FIXTURE_TEARDOWN(vfio_pci_irq_test)
 TEST_F(vfio_pci_irq_test, enable_trigger_disable)
 {
 	bool msix = variant->irq_index == VFIO_PCI_MSIX_IRQ_INDEX;
+	int msi_eventfd;
 	u32 count;
 	u64 value;
 	int i;
@@ -147,8 +148,15 @@ TEST_F(vfio_pci_irq_test, enable_trigger_disable)
 	printf("MSI%s: enabled %d interrupts\n", msix ? "-x" : "", count);
 
 	for (i = 0; i < count; i++) {
+		msi_eventfd = self->device->msi_eventfds[i];
+
+		fcntl_set_nonblock(msi_eventfd);
+		ASSERT_EQ(-1, read(msi_eventfd, &value, 8));
+		ASSERT_EQ(EAGAIN, errno);
+
 		vfio_pci_irq_trigger(self->device, variant->irq_index, i);
-		ASSERT_EQ(8, read(self->device->msi_eventfds[i], &value, 8));
+
+		ASSERT_EQ(8, read(msi_eventfd, &value, 8));
 		ASSERT_EQ(1, value);
 	}
 
-- 
2.50.0.rc2.701.gf1e915cc24-goog


