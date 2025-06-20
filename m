Return-Path: <linux-kselftest+bounces-35510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1808FAE2636
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B79D17F78A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A2724DFE6;
	Fri, 20 Jun 2025 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xY5zO5Q+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8324EABD
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461688; cv=none; b=pAZpJ8ddGGn7ef8uf/NeJ2S1jm6f+diwoIbjc4eebI6vyQcL6+yLFqVZkiNwEzSkNMi0t4Tc1riD5tbkSTskMcW895rniyV0mmFSm16+aQI9HNbbliF6YZDJrESDC5v7SialFkgVytxZarX2V/NxdmpX4A9oOC0h06enA9mDkdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461688; c=relaxed/simple;
	bh=K6mcWD2WXxUj7Z4zMoKUQvLV5IvgnJyccviFbc8ux/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FNsL4/Cs3zpLZkHS2NjMEjs5+E1R0qlxBARwS0mB+RTvEzc8oavTYpb3MIphS0DXCqegk3Hj9tOHeSJ10cbmwxFOxrYI7rCHoKVEZn5Iv8NXhSE8ohBN9yncIxfwxoeXTrVSHycPHPQXYC4VHLMwYSNAf89UL1uIzWPJUuSBU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xY5zO5Q+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313ff01d2a6so2158535a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461687; x=1751066487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r33gHDqmJivGfk3+XBLv5GnSUyatLK5Xap1YlmbGbh8=;
        b=xY5zO5Q+Xi+L7Y1Z7VZ2RNwF0VYPqOYU8kLCw9ITEYBsjlotfj/F+YvhnzMUUyKJaC
         xLBNUfYhvTloasF1QlVkihByM+kTHEG169jTE2R83iYN9OBWnOs8H4i0SZr1RtQcJsCU
         +GywXxHUHTRTCK0wAdQAfSUwmwhiVR8d1FkSwhqFG2eFB3QcEjzTgYjXBQ3zGLLW4XKd
         wzr5+2wC/EkE4hHfUHGmCloAu4SUZf9FQzTDhZzFTgEZOqXQZvYjdYsEh0dZWMitjzka
         EG1WlqFaaoiFWnlmGDuGX3xEFoP66B11MKCC9TLmyQpUmE+6t6NDc2qm2Jg+/rAoNWE2
         o5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461687; x=1751066487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r33gHDqmJivGfk3+XBLv5GnSUyatLK5Xap1YlmbGbh8=;
        b=dPYYU1aUbjhvsdpfHtkm2E6aHM8baDl99OKruwskJ2soHWPKmC4C6Z2FI04QNOrVyS
         QJ/JGtDliUucahCpqZDuEBkdnN54Z89AAc6Kk59O9q9PJ7pJEQCx7/xuseFCANbs73Xw
         wN/fX6BKAGW7b/yBLmMYhicYLWKs5d+g8LTyATZbNL27Jbkx2mDsHoF6qD2ibUhlk5ns
         FphzQqN31UwdA+yIBQluJPZNzEMGcSLk4V5JLRjUwM4Dw3r95D8AJRuQgOomArxTbrqg
         M9pcmUJAQCYheag1ny6rHZoT/rfR2glJsKULhtv1Oo9n015ic3BAcQ/Da9ik8DOGrof9
         s+NA==
X-Forwarded-Encrypted: i=1; AJvYcCVOlyk21Ni2WOdjFoHNL2GfARqMN86p9oXCq7DiGVf3F9ORBzIXxuKREntv9das1lTKfO0GFFY1bwFBXsSJY3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVp7AriOn/Ydl0GwZ3lPRbSyEkTaWQwlF0Q8uxlOFjihx2cRYz
	r0LIuI1vzjr7aD1H0l6fXSlEU962/1Zyw+ZpFrR8kZbxdGTViZBAU90xtdmASJPd0tzYFE/pS3c
	Dp14SQXhM7XdzjA==
X-Google-Smtp-Source: AGHT+IH3gg4VRy6e2tzRQjegCE2l3HuXUmS4+mzNtAb0PupDOI59b0hV0jk5SzKKr6VyOu4NTIFmIK8m+9Sk0g==
X-Received: from pjbsr13.prod.google.com ([2002:a17:90b:4e8d:b0:311:8076:14f1])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:538d:b0:313:283e:e87c with SMTP id 98e67ed59e1d1-3159d6347famr6930491a91.3.1750461686860;
 Fri, 20 Jun 2025 16:21:26 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:14 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-17-dmatlack@google.com>
Subject: [PATCH 16/33] vfio: selftests: Add a helper for matching
 vendor+device IDs
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

Add a helper function for matching a device against a given vendor and
device ID. This will be used in a subsequent commit to match devices
against drivers.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/include/vfio_util.h | 7 +++++++
 tools/testing/selftests/vfio/vfio_pci_device_test.c  | 4 +---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 9c928fcc00e2..a51c971004cd 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -167,4 +167,11 @@ static inline void vfio_pci_msix_disable(struct vfio_pci_device *device)
 iova_t __to_iova(struct vfio_pci_device *device, void *vaddr);
 iova_t to_iova(struct vfio_pci_device *device, void *vaddr);
 
+static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
+					 u16 vendor_id, u16 device_id)
+{
+	return (vendor_id == vfio_pci_config_readw(device, PCI_VENDOR_ID)) &&
+		(device_id == vfio_pci_config_readw(device, PCI_DEVICE_ID));
+}
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H */
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 1b5c2ff77e3f..8856205d52a6 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -56,9 +56,7 @@ TEST_F(vfio_pci_device_test, config_space_read_write)
 	/* Check that Vendor and Device match what the kernel reports. */
 	vendor = read_pci_id_from_sysfs("vendor");
 	device = read_pci_id_from_sysfs("device");
-
-	ASSERT_EQ(vendor, vfio_pci_config_readw(self->device, PCI_VENDOR_ID));
-	ASSERT_EQ(device, vfio_pci_config_readw(self->device, PCI_DEVICE_ID));
+	ASSERT_TRUE(vfio_pci_device_match(self->device, vendor, device));
 
 	printf("Vendor: %04x, Device: %04x\n", vendor, device);
 
-- 
2.50.0.rc2.701.gf1e915cc24-goog


