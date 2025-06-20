Return-Path: <linux-kselftest+bounces-35500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858EBAE2618
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A08117F7CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3D24728E;
	Fri, 20 Jun 2025 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5x7MJd9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFDE244686
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461674; cv=none; b=s8I20x7674NySubYz2mZcZ+z9cVHR86vE74bwY+3aaFDpsKyJ/Rxq43cxXD4sWiHfOJE1FRCWcXZyuFhk25lBYJ+9g7danbUDZAGoFyvS3TsqgWYQwZoqi72ItvQhQPOhPa+SShH6HB4XO12UCDDtTdD4SSh6sA/jFBre+W2Isg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461674; c=relaxed/simple;
	bh=Br9oZ92AqRwpStBcHw0hsfUUlaEqs7gpWr6swuIXrKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iC5w5RWhenF27sFLSKtoBP+q6+/MTANXyzjyiiqSlTIqIcTi68rheoma2KAqWkZvEF2niDe9AjJvKgSejg6/T/Va/LWVe6VFBwwjTN2yxGV1mn80zdOkn1JMVbHcwTn3WXMoDU76LL3QvJHWlixWA9DXQS9CUvgOgcVs7qgYZb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5x7MJd9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso2393371a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461672; x=1751066472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cIZ1He+EZyEea6j02tpvSij83AYsDLvv2nMpL5Kx9EI=;
        b=j5x7MJd9mv9zOtE6ckZA0lN74iLUK7zTK/mjKbxmV8HrtbsI3vlnXhLsMIbOInoU9u
         5AiQlvKf5DtRRq+HOhuXQUlmQC1QOtLRjJCRBT2ZXvri6kblGicebxVWJxwqtFDL0IWY
         hcgYgK2AZULS/OaYICrWW2xkjTfeXZQ27lh2JwsPv+4LdK1HCJAw8t8/1qFIbgn+9Ecd
         Kp/q4biP8OU0YX9b+W7q0A4YIT7z/FItnvjWwGYPqVepEUuF34/9U7vsdtxyBiY0Z7eE
         D4lTrFPHUFKvTZ4athjPNMLzXaS7xDuT5O7aLYx8+R4G0dFmwbaBx0uAChWPI+7Oykcw
         jaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461672; x=1751066472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIZ1He+EZyEea6j02tpvSij83AYsDLvv2nMpL5Kx9EI=;
        b=po4D5sMpQJfapUcaw7hXNX+cP+hy89S9yA2a8iiOuIl+T5YX5eY2XKOI/eT1bbG85W
         nSO2YpK9PvneQZrCRw70lgT17MGz0wuDojxWYiwJ0vcPj0ULUWAVo1PIJN3GJAU1uc1D
         EIzQXE5Oba/S/2ZL/sKXemfWPxqHgKdq2tnWlDnU4tX86hQi55Pq19isLnCVwG3CeFJL
         zyDFMEwK5FCIErMXAVv1ZZlWVv/OFOHAuf+XVsezbjezC0GK9ZRL5+MUzlZrIGTvjVZv
         bbCbOFHcgPCEeeJy6AUKHePvscd1CfFFwLgDt6ZQWt9hUXVTEZTpOxLOd8oZWxmKXb4L
         getg==
X-Forwarded-Encrypted: i=1; AJvYcCXwnzFikHaeToNSeTgzBaBOxZ8v9c/x5MsGPrsa18eBjS7SpaW1o+jowlauFjjttIm93wgINTaybcU1K0oS5e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQPy+lO+/kg3SW3/RW6eE/Jb3dcl8CA5Th7k0vfq0ikIqsQCOm
	A7yroFqkm6ddiK5MUAY6ur3NrrDnCHM4Hud8pJ3Y8DLz8r54ELuJ5GImRbR7T5yYLVTOSVhjHtB
	cvK1n5zp00dWnsA==
X-Google-Smtp-Source: AGHT+IHJ6Nk1xOBkE6hg0KllJZtmmcHASIyp83zjsk5MLbqCuVAd+TS3wbBWdpTTnoKc+F7WMICp1X8VsmQ8MQ==
X-Received: from pjbsr13.prod.google.com ([2002:a17:90b:4e8d:b0:311:8076:14f1])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4ccf:b0:311:df4b:4b7a with SMTP id 98e67ed59e1d1-3159d8d7893mr7757925a91.29.1750461672291;
 Fri, 20 Jun 2025 16:21:12 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:04 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-7-dmatlack@google.com>
Subject: [PATCH 06/33] vfio: selftests: Add test to reset vfio device.
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

From: Josh Hilke <jrhilke@google.com>

Add a test to vfio_pci_device_test which resets the device. If reset is
not supported by the device, the test is skipped.

Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/include/vfio_util.h | 1 +
 tools/testing/selftests/vfio/lib/vfio_pci_device.c   | 5 +++++
 tools/testing/selftests/vfio/vfio_pci_device_test.c  | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index b7d2bb8c18ba..234403b442af 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -83,6 +83,7 @@ const char *vfio_selftests_get_bdf(int *argc, char *argv[]);
 
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
+void vfio_pci_device_reset(struct vfio_pci_device *device);
 
 void vfio_pci_dma_map(struct vfio_pci_device *device, u64 iova, u64 size,
 		      void *vaddr);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 76adb1841f16..98cce0a6ecd7 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -202,6 +202,11 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 		       write ? "write to" : "read from", config);
 }
 
+void vfio_pci_device_reset(struct vfio_pci_device *device)
+{
+	ioctl_assert(device->fd, VFIO_DEVICE_RESET, NULL);
+}
+
 static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
 {
 	char dev_iommu_group_path[PATH_MAX] = {0};
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index a2e41398d184..82e3c947f45d 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -155,6 +155,14 @@ TEST_F(vfio_pci_irq_test, enable_trigger_disable)
 	vfio_pci_irq_disable(self->device, variant->irq_index);
 }
 
+TEST_F(vfio_pci_device_test, reset)
+{
+	if (!(self->device->info.flags & VFIO_DEVICE_FLAGS_RESET))
+		SKIP(return, "Device does not support reset\n");
+
+	vfio_pci_device_reset(self->device);
+}
+
 int main(int argc, char *argv[])
 {
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
-- 
2.50.0.rc2.701.gf1e915cc24-goog


