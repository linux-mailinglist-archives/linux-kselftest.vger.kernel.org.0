Return-Path: <linux-kselftest+bounces-46580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD595C8C50B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 00:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2A48344DE6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 23:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835FD3446BE;
	Wed, 26 Nov 2025 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4zGYOnn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6337343D69
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199071; cv=none; b=Drvocy60cH08SLQqPf0+1oocw4GCpr5Z+D/c7ox1YNW/TelMXhTh+vqyce4FF0FyV1nyiYYyp2b98Y4SGTdskZ31F3cgcpewmDWEfUcFUbU5NzpalI332rtraX0/6+hBBmCMuHuTGHvasefLn2p/t55ItYszrA+BwdsW9MM0EJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199071; c=relaxed/simple;
	bh=5C61XC0qEnL5WHxXy1SRysK/ERPDMiRaWEn4cSWUS30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bWt/+1xWWRZkzDN/EjX3COFzx87H+YoHafbvbrh8fl4smFTb0Hqs/TRqzs8qvVsDwNtZHbc8DhfXg/TjlgdfChKZ1zGU7hrflT5xYj7X29eOgYhee2Ue6L2aGnxWKVjVOS8dW6CYoayA6xLjDi3attYMsBxZe5q1xSdb22+BbxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4zGYOnn; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b80de683efso353776b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 15:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764199068; x=1764803868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+OCk24PhXU3C7aoKD1gVeOiWKi7xUeXg11i69m3P0wo=;
        b=Y4zGYOnnGhx8+siXK2IqhVVAVuPxgHzDLFLGhVWXQkK8aLh7MLuJJ8ziilFR0vYda+
         +mU8rGcfCuZWa3Hj0hxX0hfB0QWdlhwXB63f2F7jpwjAPgy46jkq9OinlWssIGKYVS0w
         yEzADmY9N63wm9wDQe0/7tFpN2DVAMGQBsJg8GriutIVgBM1UZRBonX3Q07hacJphDx/
         V4Zy71ZrLajqIz7DnPuAL8Hc04OczaylolGjSo4AwgULf+w0riTvED0Qx+KdzJttEcEK
         Y5FNpE8bHQ8/AkYhGbyUVeGavoZcGNQbYsCQnPW954GigGKjtcgGcdVQLTGyk1k5JPti
         HtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199068; x=1764803868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OCk24PhXU3C7aoKD1gVeOiWKi7xUeXg11i69m3P0wo=;
        b=ch9wKee/klo2gCGPGlDhdqmFbUhcrvr3u0qjQWnEzDBESofhIg2tqzESsfRyte6hA7
         u5nDLnSN2e0CTC6wBAq0DtCgNIN0JCSbEm++3d9TX9zB9uuJrkMkzKXGMD7WF1pH5loq
         hare02r2mCg209N0S9s/O2dDQpEqujIX3foJMLemj9+1/XHtY/+c2fvOrZA4RrZtB+iq
         WgY69gReuPTZdg481VIkTTa/ZcPSGzRAtn6GyRbo7vQP381/+XTqUezAA3i1OwI+8fXJ
         8OTsnGX5yoIvGzMtVAXs0DNcoZ23fZc2U7elv6JODtHKGdh4kRXTXe+gjeYQ3qm4DVFe
         Y+hg==
X-Forwarded-Encrypted: i=1; AJvYcCW4/2g3WitWJoRcZBLwbjT74NIP+7ZaMYlFfP/+/t/J094WVQFh1G9CA4pPt1LlINT5zV9lLg/GTz2ePSNqyIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWgBpsWKZLNiVy2QhOurgVfXfWwIUt3jI1XBfo55YIOy9y7Rzo
	KJ+B+7K51LBJqugqtRtiDgS0gn3us5F3tCnRO+G69xUXXe37+4hljsW02AEvz1CmQft9JW6Abya
	bmjMdBP+Qmph5xA==
X-Google-Smtp-Source: AGHT+IF+xlP7ilrt+htOcnUs4big4RY44y1Js5GB/kUN9mSS+cwiEmujjBuGxBoHOGncm0qXFKcnp96ynaItZQ==
X-Received: from pggr18.prod.google.com ([2002:a63:d912:0:b0:b98:d6e8:a405])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:729a:b0:34e:1009:4216 with SMTP id adf61e73a8af0-3614ecbf58cmr25661817637.24.1764199068139;
 Wed, 26 Nov 2025 15:17:48 -0800 (PST)
Date: Wed, 26 Nov 2025 23:17:19 +0000
In-Reply-To: <20251126231733.3302983-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126231733.3302983-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126231733.3302983-5-dmatlack@google.com>
Subject: [PATCH v4 04/18] vfio: selftests: Rename struct vfio_iommu_mode to iommu_mode
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename struct vfio_iommu_mode to struct iommu_mode since the mode can
include iommufd. This also prepares for splitting out all the IOMMU code
into its own structs/helpers/files which are independent from the
vfio_pci_device code.

No function change intended.

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>
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
2.52.0.487.g5c8c507ade-goog


