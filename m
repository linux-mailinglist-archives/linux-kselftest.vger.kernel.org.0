Return-Path: <linux-kselftest+bounces-45445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC95C541C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 20:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F7E54E752F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 19:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6E34F246;
	Wed, 12 Nov 2025 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FCQe8GP0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1334BA44
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975372; cv=none; b=p8GoZGNOZNZUtVTVLQMk0/LxwglG0hCd8ncY7R7AV5yDLFrlStm8Cl9meDYrHUzb7Iny/l964Cjr1XyXoqnpka1fBAr/q5BhCORfcmr8Dl61s9o9aaAsRJlt5oFlfFlnIVq4Ie6Y0Q/4n+5gDrvZ7NVV7C1dMFPe/M7AV3Har68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975372; c=relaxed/simple;
	bh=jeuliBeHLcpyumWj/lzH00ZpBgTEtU6Uh+nasXsIs8w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=caPSV6VVKRKOphfHqcXOXjmIaBYjmwdjytpK+J2JE63Vils1/zm3zKaJ7AGSOe9JGMUkvBmMec+0ZjjUB6Px+DHMEvQGVGlLBWx4UAhasqwXReejndd1w2ECW+3LXqyPPYG9/6uVrdKK7Uy+I/2QlOXZ8bk977bMm8xeb0hfVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FCQe8GP0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b8ed43cd00so138082b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975370; x=1763580170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vePzcNAPw6XtIm0Mfoqs8jy8WsyiUI2nOmzMjhNQ5jo=;
        b=FCQe8GP0wnkBDZe7l2Cbz/LImVFD1K1uFr+4p33t7jbmjXHnquwLRLUs8bq4Ju+XAR
         avzwxRaZPkb98Rk6egeNhpzQGogMcpVnPY3F7gKTsAtSwjRS/o6zcvF59aefreWIaRwz
         /PNW4WXsJj6UUXXbDp+BvkNlFkl5zq4cTqJUc83jOm1wgM+Vqv3Z3gNX9xd6nE5pUG7w
         LBjFhoz8i4GR389DVduQY9cvbky0A3XTsa1a3qF4MAmMjyeyqsddhp7o3CdyT8umkMaI
         B6kjvqhohH66KOwOPG40KDyixSny0wRTxksPH7ebJG/J0P5MYpFuyWPw+liEhV4g9J9D
         5Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975370; x=1763580170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vePzcNAPw6XtIm0Mfoqs8jy8WsyiUI2nOmzMjhNQ5jo=;
        b=PixCueg96qosXI7UcueDSGziZ/2UnU7nQS/2m+g0KWuZICAYqVLUfr/wc3QcuR7cN6
         f1oGe87iTLAn3s3AdYVuR/r3GbNQrCRJTIJpjEP5t0l0hZCv6S5LD2W198GRK26q5ZDC
         PW0RcDWbqExrsnzk4/EdVzmz71sO08HN2+9t7qm4rOuPV8V8g3H44GpX/99eF5iFHzmD
         axCKHoYNixIeO+4acvFRsknY+9Sadw2fgOCdLwyH8V3AFEu45+jpo6oJ8zaqL65rAUc5
         u8/QGs9t2k0OhU3rS9Z7wpkFe2GBV6k6Y4W2Trtad/xKKm3nS3mka8dN1gZeN/jkMR4o
         gIUA==
X-Forwarded-Encrypted: i=1; AJvYcCX1GrTAo9sPT64RBSBoJ3BoLKz7K4Q3AQOxMH0sqd9HFvdkq2G4bAl/JzXxbQV8uKx9UwswBq7C1p4zBtvQlyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZje7GHSSsnh76P5ZQTWUdkd0EVqsAi6DFmrR2p2fj2VS1KXxv
	z6YepW8IzkUlgp0RG4k3CyXc6+DKRKds1CbV1oUodDRxfKanrUa5DQn1EUHtX1jOTgRBq9W4bzV
	Ne8v6mYQ5KIoSig==
X-Google-Smtp-Source: AGHT+IHgN7CdCgSwD+T6DKsSw/WTcqqtgfIj5GPUg8wxWmMi3fkSdz9zc8oj2o6BP1GGWku6085y8OWdclvulQ==
X-Received: from pfbkr8.prod.google.com ([2002:a05:6a00:4b48:b0:7a4:fb59:8199])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:14c9:b0:7ac:69cd:ea0d with SMTP id d2e1a72fcca58-7b7a4afa078mr4267073b3a.19.1762975370068;
 Wed, 12 Nov 2025 11:22:50 -0800 (PST)
Date: Wed, 12 Nov 2025 19:22:18 +0000
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112192232.442761-5-dmatlack@google.com>
Subject: [PATCH v2 04/18] vfio: selftests: Rename struct vfio_iommu_mode to iommu_mode
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename struct vfio_iommu_mode to struct iommu_mode since the mode can
include iommufd. This also prepares for splitting out all the IOMMU code
into its own structs/helpers/files which are independent from the
vfio_pci_device code.

No function change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/include/vfio_util.h | 4 ++--
 tools/testing/selftests/vfio/lib/vfio_pci_device.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 0b9a5628d23e..2f5555138d7f 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -50,7 +50,7 @@
 	VFIO_LOG_AND_EXIT(_fmt, ##__VA_ARGS__);			\
 } while (0)
 
-struct vfio_iommu_mode {
+struct iommu_mode {
 	const char *name;
 	const char *container_path;
 	unsigned long iommu_type;
@@ -166,7 +166,7 @@ struct vfio_pci_driver {
 struct vfio_pci_device {
 	int fd;
 
-	const struct vfio_iommu_mode *iommu_mode;
+	const struct iommu_mode *iommu_mode;
 	int group_fd;
 	int container_fd;
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index eda8f14de797..4a021ff4fc40 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -713,7 +713,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 }
 
 /* Reminder: Keep in sync with FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(). */
-static const struct vfio_iommu_mode iommu_modes[] = {
+static const struct iommu_mode iommu_modes[] = {
 	{
 		.name = "vfio_type1_iommu",
 		.container_path = "/dev/vfio/vfio",
@@ -741,7 +741,7 @@ static const struct vfio_iommu_mode iommu_modes[] = {
 
 const char *default_iommu_mode = "iommufd";
 
-static const struct vfio_iommu_mode *lookup_iommu_mode(const char *iommu_mode)
+static const struct iommu_mode *lookup_iommu_mode(const char *iommu_mode)
 {
 	int i;
 
-- 
2.52.0.rc1.455.g30608eb744-goog


