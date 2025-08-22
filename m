Return-Path: <linux-kselftest+bounces-39742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65869B32474
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294963AE185
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C45634AAE8;
	Fri, 22 Aug 2025 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clrbh3aS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3834A314
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897986; cv=none; b=t9EpcLjMXe/gvK1o2egqfWUqWjdiovzKasFPEHRg/ZC/7Zvo5QQ8fluG2eChWligRkkEfMHuZ800V+znaQnJc+9YB/O1Ecbr2CZT0RdNYyFY0xRhVpX5YXsyzq9wgamO1rjANEVkYtBWAPYw1LZeZj7M+1g1SAAtFA795XA+hfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897986; c=relaxed/simple;
	bh=TQ1KjdwjO73wEviQRyY9T1nIZ8oPzyzQhoXUyBRVcN8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fMBHteSS1lUl0sI9+q7p/cGUGsAAPLnWsSwB21YGlnWADJLn6vAT+0JhSU89m8REhySn/nW/cH2UumpCSrlhTM9eOxzjOP5pTpkN4qayZvm4KnQOat/Yf+eRVeGJxmhfvv0Ww9oHYTUPNp3jpLNezQxJ/MrREH1Z6Izv5FTf3Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=clrbh3aS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e349ef5fso2819801a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897985; x=1756502785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxgjnR/mmZ3HsP9pSRnYFNy1E6x4AZLI9uHNS2mBsBw=;
        b=clrbh3aSCZzm4fNx3aI98NGWhRcNkAjjHo9JZQCFg1eUvjoyG+hwQJaXS8UbAZHVuJ
         7jMum73LmXhRl9V32By3QZqOYTRxTZAirvYuRlFKJvk5Gm0hlhgzwupq/4nUmNOplB6n
         Fhtu1vZ0QbqeAoU4x3KtO28w277G/WI3+gBdDUPVgm7oULA83YSyO9IfrUrkeJPTu9ll
         cHobknqNjfFjubYIZIlT+36LNfChcmTn09RAJL8odU/dj4yxUN5MHWT4cRMGre0Z62uQ
         ByfxpaTep+wsRn2u8W5xrZOHfjAdxYxQEPzo0BqIY/X1InU8u45f9KhnCXUxTX5F6NDV
         bfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897985; x=1756502785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxgjnR/mmZ3HsP9pSRnYFNy1E6x4AZLI9uHNS2mBsBw=;
        b=bx20XFOocOKBcl3r4XwzGSnm6t89fKFmqPJfP9hANzkS7OF9eJUo6Tbxb4JtT/p+EV
         YMapWPYklf56xmSImSTV8+eoLWYhHoViQVBOoBjKW1oGQgnAqPWDjPVbZa6FxAg30CkD
         KyQ8KflUq5lO/OPPTmIdzJ4HLzbwX4jzzpgk9LhgbFD27YXGpa7XMpeWJRZNixVlRMKE
         nyq+zdZcQl/p0ICGBLQRTufNgWB7nWXBINkEHKOjWrMPYAa83BzZ9oTGQnF6TjROEBPp
         XyqYBaQPcV0VhAzpuJPuKhLcfSFCPDnkx5G6Xf96QQ8aEVE38RA2qq31tQe2+xkBeWEl
         jtMw==
X-Forwarded-Encrypted: i=1; AJvYcCU4OR8Fy9SHlYHhWzWebkjRrTyvn3ZvGDvdSogkBE0BjNGyjXLGjujtFtncAMc/eyGZVmsVikALUBfpOBh8Obo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKTjfah4hIlVwudhZQzoJWP6M3erePLAooJh0zrYPJHxT1imt0
	Uh2pSXAMoi5b9PKs2kpTf943HOhfr1pfHigk8xPC7GPrxZx9EbRf/CUg3NO3k6geE8NplHtERB+
	J/0/+DerRsGEgKA==
X-Google-Smtp-Source: AGHT+IF7yhhlyVuariIcDyAcZdKcG11P/OaxWFAOXJ+dEJjnCfNOz/CtvNlx69DjI4NQ5GkMZIgqV9vhzaPWxw==
X-Received: from pjbqo15.prod.google.com ([2002:a17:90b:3dcf:b0:321:76a2:947c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5547:b0:31f:4272:c30a with SMTP id 98e67ed59e1d1-32515ebffcfmr5741867a91.30.1755897984730;
 Fri, 22 Aug 2025 14:26:24 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:24:58 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-12-dmatlack@google.com>
Subject: [PATCH v2 11/30] vfio: selftests: Add a helper for matching
 vendor+device IDs
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

Add a helper function for matching a device against a given vendor and
device ID. This will be used in a subsequent commit to match devices
against drivers.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
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
2.51.0.rc2.233.g662b1ed5c5-goog


