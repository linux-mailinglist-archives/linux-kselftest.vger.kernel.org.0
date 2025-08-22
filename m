Return-Path: <linux-kselftest+bounces-39737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA71B32449
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551B36232FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F692343D62;
	Fri, 22 Aug 2025 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3DGJJQks"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE6E3431EC
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897980; cv=none; b=SCB6PdUAJtGGkRafDaAaYuP1GhC+whcGmKO+NnB4ZGSW6D9dTwUJr2BwIIHxmNyPRAgITphbeXBg2r3ykccCA/xqaORdMIC5d4WwmbOpSYmmbZk1UJwk8s4KK7k912b5m6+0OfQgQ12Uu4enPXpMYSmDdEVngdy4lk2JOiqQULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897980; c=relaxed/simple;
	bh=rTedQTx7eploZdzRSeYzRhrwcXGIFjc9zqT/oqADDoM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eiSYeFZYnXh6uk3DosWYmz71Y5GFOawykhd3qH0Snj0HBoyMOyCXaoLFqq1PuN4ZVsCcOTjxLYqm/ml2ph3o4TPpXt2mUmsF45BDcy5XcgOyYW/MDcJS06gXmauZh6pB2cnmqK57tiXw5MaLdiDarvxywIJ0FklPKH+wMCl8gio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3DGJJQks; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e09c5fso2564340a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897977; x=1756502777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5POFsslZ3cS9lDcKk5vxlnt8J7p4Kctxo7cJXLtCsc=;
        b=3DGJJQks/Z5dry5uxl5t4mjQMZH5B1d9qdbO74Xu1raUSjCE1DWgNK1SuPqJbRtj4l
         KZHq86OL2vFksGhC8PwLmIhbPKUxhxOqi2qEWcL2wfcvX0DdPTzsKam4VEjiHS01cTTv
         kh/ZFZ+WvFe9uUUHR9ko34UUyVquKXoLOS4T07kKSjWIx/gxuGsrc4J1nOXET5GsU6tV
         lEUxu+OUvMnPuzeHRnasIqqOJzsdbrxY/Gl+Rdcv4rYO3qYDee6p/d9zTdPDBq5LL4Rn
         MjfHt2ayHd8CaAFAIzCgfQ7eQIigxceBEE97LmIqH7rErpLP/VmAD/8sr1q5mrYaUMK+
         Hl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897977; x=1756502777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5POFsslZ3cS9lDcKk5vxlnt8J7p4Kctxo7cJXLtCsc=;
        b=Fa21VGB3vwQhwsMtjG/O2s0kdavo9iUX/DIP5sCvltaB1qxjbgZYlsxuuP1PTuH1t2
         7EBtjFceWHEfjYpDaepj1Rne4FI1S5uFMTdJvLTylBtgMckqnNLDuLWHSWOVD5I6cuwM
         vo9sIw/zNqYpuWfENvLYZjl32SNztlp9H9hArPCaJJhU5hnClElu5tODVFJt0bmF7XY9
         TAU02LPwpHCzdQ/tLRquC9VtkitAc8IYEpsyxSPoKg4FfmpgME6XmKsMlz1MD5p1I+29
         pBTJKYBjet4GZMiLyspobA7vSLBGOO1w9QR4PGW9RfTZQ/ozLrgpLOJlpgmS4qmfP4aA
         m7vg==
X-Forwarded-Encrypted: i=1; AJvYcCXa2YLJdb2o333UIfAAQlMgrujJc12zlXutHy0+8zMCBgbA5GK9nSa3jcfUDMmG3uSYhJIGP9bdSZvkT2WMmGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFDBoR1eGskqlXrmFsBtyzw+Tmza4cldNcuEyxbIN/bdN0/tFp
	PriVc8nwYpX6g3wN6e9lpacO/YiypjRn1/n1F7jOR9ckIB7iB0axO/KZK7KvavqO6ymatfheOnH
	MeGJZClDMZEYfGg==
X-Google-Smtp-Source: AGHT+IF7wFxJCdujaonVKDe1BfckHqzrcOR99YLcQfrNtopL72z0UcvegQI8wQkaI+RMy+BubUkyEFbMtJLsTw==
X-Received: from pjh3.prod.google.com ([2002:a17:90b:3f83:b0:314:d44:4108])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17c4:b0:31e:6f0a:6a1a with SMTP id 98e67ed59e1d1-32515e12e55mr5914007a91.3.1755897977220;
 Fri, 22 Aug 2025 14:26:17 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:24:53 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-7-dmatlack@google.com>
Subject: [PATCH v2 06/30] vfio: selftests: Add test to reset vfio device.
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

From: Josh Hilke <jrhilke@google.com>

Add a test to vfio_pci_device_test which resets the device. If reset is
not supported by the device, the test is skipped.

Signed-off-by: Josh Hilke <jrhilke@google.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
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
2.51.0.rc2.233.g662b1ed5c5-goog


