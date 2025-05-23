Return-Path: <linux-kselftest+bounces-33702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCD0AC2C32
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0349E6923
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93D021CFEC;
	Fri, 23 May 2025 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zjpQKzJm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CCB21CA0E
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043040; cv=none; b=C2lp3D1tRga2K7/+dL0nqc18NqBtb9qfT1XuFDrWrM/ae3zmz2JxzRYBP+JKrT1NgBPIXI66n3a8q5TIMsn9uj1ff/1vz0S9ruJ4WPNDq+40acLGgNqCHlQSA8+rke5CFRrSkb+6GET367bnAW0/zyZQM9ZrKYMN0w3dBAkVHYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043040; c=relaxed/simple;
	bh=NbC3Gy2pqWtgey+3O9IG00ewxeDzSbfBhVZ5C90sNgo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m2OQ8oNk+JRbx5D+S20SMI5YdDMPnvFdqZoC+WVFA6r27XSJh9rL0JcQizI8xExtY41jT7OH4rxwi9T0X/IbFFJc/BmJ2a99J9YMvgdxLVDRoghKjQQMtag5WbX56lIM7jN/l92SmQOScFJiSncfflPDzVzfVXIKtwPe7RT3awI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zjpQKzJm; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b0e0c573531so187449a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043038; x=1748647838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cbAxH64zJQ7XuCM5Qh5UqlFsfskF+VRsqkRwmkj2Vhc=;
        b=zjpQKzJmkHB/hqnc6EBBYIMumBjOq6GQc5ZNBHrR/XuDyEaUHLPUo8f7QrSxN+L7Ob
         xPQO5/rDPmqcPVIRosUtc6tDj1u8tjzREyM1sJMjKLXf7DDKNEX50iZNO/gQiPu6IWRb
         IDTGx71nmzYzagEG8bUH6lhKKdW0VvEBlEmcZ8hl0mA7JKMqSY/ZQ2rubDZEaIb9a5NX
         AeBWeJNMn+WsvE83nE2gB61QWALdcIgdmeD6TBsCuzWUYh7jlt3tAQ8bRMkpxc12UYb7
         Gvu4azV3VXWLvu8W0ml3mL8R4UmDO4iNcVG8W98tG/CSYQj3fGRrB5xGFPavymnHK3CU
         9gJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043038; x=1748647838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbAxH64zJQ7XuCM5Qh5UqlFsfskF+VRsqkRwmkj2Vhc=;
        b=qmGfbYTAh1kTuivLkT0NVpMzvG+3mRAI7bTZ6o7pKlmWT93lKGYLl227EIkyN8397U
         Vxg9xUeV4DV1JRkLvK36OgTZAvoIs1wti4qv1ixmQhoyJE1S++DXrXwB7KpUihUeHYom
         I4Zak7lo7/JfYuY5lZwFiuuKt6d5ScE16VfAmLn6L3euLqZCw9oIejWEQ90QCVzbDfzc
         O5rm8gb/EoiGmq2CKZPgQidh4VjKKu54biV1B36/Jnr4ocRJ9Edp/lBxGyIVj1+NZ/hN
         ANiw8ZLZttnQsgxHqgIyCgAp4zJgK50M/pkFJtmiiLaHBE3ZdtapdJ6U5rfEkBLbVh7+
         n/GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyNssZo8LxlW3Rw1fu56xTD17brp7VIyd9FhFLzC7biMdeVeVu3Xmqh/gVvjdSrvimZ9XwHYeQv1MTKkiw2jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFA2rTgQLZWVxOlJifTSUGKAcTRZ3d/w7NUDWCHaJ05/wRPp5T
	2GWFhk3bwhT1+nz/BIsGRahorXaGEe4pxWd5GFdadwqOahGS8MykHbYJZj8w9PXRmQKOZ/lpl8+
	94JpQJ42YI2UacQ==
X-Google-Smtp-Source: AGHT+IE2aOrVpVCw27z69/FRVKkbenhjUTs5vrIc9bCLYARJhT47hfLOjtzYAfqrgWFszyhrlRR8aTkUmnN9EA==
X-Received: from pjbhl12.prod.google.com ([2002:a17:90b:134c:b0:30a:7da4:f075])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:338b:b0:1f5:8a1d:38f3 with SMTP id adf61e73a8af0-2188c1924dbmr1698294637.2.1748043038416;
 Fri, 23 May 2025 16:30:38 -0700 (PDT)
Date: Fri, 23 May 2025 23:29:51 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-7-dmatlack@google.com>
Subject: [RFC PATCH 06/33] vfio: selftests: Add test to reset vfio device.
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
index ea54754a8b16..4e5c6d395a12 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -69,6 +69,7 @@ struct vfio_pci_device {
 
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
+void vfio_pci_device_reset(struct vfio_pci_device *device);
 
 void vfio_pci_dma_map(struct vfio_pci_device *device, u64 iova, u64 size,
 		      void *vaddr);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 922f21138532..a2747de9ad69 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -328,3 +328,8 @@ void vfio_pci_device_cleanup(struct vfio_pci_device *device)
 
 	free(device);
 }
+
+void vfio_pci_device_reset(struct vfio_pci_device *device)
+{
+	ioctl_assert(device->fd, VFIO_DEVICE_RESET, NULL);
+}
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 41166f4e9468..b969ecdfb042 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -151,6 +151,14 @@ TEST_F(vfio_pci_irq_test, enable_trigger_disable)
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
 	if (argc != 2) {
-- 
2.49.0.1151.ga128411c76-goog


