Return-Path: <linux-kselftest+bounces-46267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AA8C7B45D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E12A4EF6FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC59334DB5C;
	Fri, 21 Nov 2025 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCQdLYwT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6782D6624
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748887; cv=none; b=TT/UZcWbQcrKd5hojBP0xlGpPvnhfSovISz6eIQT/G2iMQvWHSWoss0Ktn9IBIsCvmWQ7Ts72bOg6ATQZZgb6W4c9jOk8A2sHzdOONgvO8+RRwLf0+xRVy0qq+C+xST2re1HyNcN+ArhGvBGjDxjMAQQNUrj7JtTrZ/wWIl7o/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748887; c=relaxed/simple;
	bh=0mpt9DrK2EH+/nszyWzaz56fSuMqVTW+MCo2D/grwGY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ab03fy9o5QKkIC91Hr64Ivkr5UcJCHchx8c7+RxloPuSqLcVMVcGgfL9sT02sPiEwGT4K+Uo11cy4YVTffPGObH5iNYNBa74fWYbprCdfu38VFsbRTDjONC8NPq4qvuCHHAh70W7lVyYeKLQk6h7OeN+UNGj4ZU8XaeorWBoll8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fCQdLYwT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29809acd049so47184205ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748885; x=1764353685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxeIo10ZephNiFDx/n6CiZynZejR6x/fiOnvLqPApOE=;
        b=fCQdLYwTUHNraYZFyFT7SgERnZENyfiIY5r6nUNnn53rGLt9of1C/nVbKFBg2V+v22
         zu9njHADo7KN3ROjSimIsKfFw7ra392HSTLbzhyMlKYQ/TIFENQ6AVivl2ysIkYt9Zl5
         ynLoGmHWVzEczJY5Zt09jZzC/ticrP9+Fy9eV0ST6v2yUnPxlrpIFQHMsmdtdu7Yty1k
         ssdKSLdFJW0UHCFPGP9WNubAWeLf0i+zexcEZlr3b49u+FtYtwAHROOVuUMC0j/jTs5w
         fMsrhAK22hQpTActx2t2v2i09w6RE13bH5de1GryYUtPUBe5oaGKns4Fnqww+UnqCYYc
         1wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748885; x=1764353685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxeIo10ZephNiFDx/n6CiZynZejR6x/fiOnvLqPApOE=;
        b=ZxdpWHNYUv6uOijMVrtj/HR0gp/yjoQDBIGLkyQvJbL8jcaZDzvtWRKH1oKi1ZY2rT
         +k4QtLFZ+9FsZa9ToFOXodr5U9SGENj2GAZR5NmS+c+AMwySjDo+mm/V4ZLr28VBgqdZ
         dQJ4tBI32Yempx0AzsLRu80nCCunWI9bDDgtSVnccdd0OJx6vd9Jf2nnge8tRT4oWlOi
         pwooxyloWhElqHMdJ2wO8xtcxArujQiNLzdUHqskZfhgLmd7ZkW1DZKrdgbm8EtFWf1y
         5o/vLCxeidd8G4/oo76HjbIJQmDIM6kpl+xEl+MAhSjygePB8bF/c6Lk2FXu+X7Pj7uu
         ETdw==
X-Forwarded-Encrypted: i=1; AJvYcCW4yK6K0Dr/Sw3OFIK4hh6lPAWxPOB9ZjANMkY3obbQBVbnHrN/7G3llr6vPQjEfH66hyo9JlOcfNd7elehbQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwouZV5bZhZIGiTWsTuPqUu7l7WqJknBVBhCf2RPEJ9SKbSXjGA
	mOTtpDB1CfVhD9jISTCedgCg/h++l12he80lDZtdBynaUkfuI7b+C+I4GXQc1VClCmFK22uJiWV
	f1oHBU8mz8FQiIA==
X-Google-Smtp-Source: AGHT+IFbLTbWF39tJajkynXW4HbedSaaqh39StKC8XEAGbSVy0Ikmggms+4ZG3tLpOCRvQQJzPyHg6COHAgOQA==
X-Received: from plbkt13.prod.google.com ([2002:a17:903:88d:b0:292:3da1:8ea8])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:440c:b0:297:d697:41e with SMTP id d9443c01a7336-29b6bf3b588mr42912705ad.37.1763748884880;
 Fri, 21 Nov 2025 10:14:44 -0800 (PST)
Date: Fri, 21 Nov 2025 18:14:15 +0000
In-Reply-To: <20251121181429.1421717-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121181429.1421717-5-dmatlack@google.com>
Subject: [PATCH v3 04/18] vfio: selftests: Rename struct vfio_iommu_mode to iommu_mode
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
2.52.0.rc2.455.g230fcf2819-goog


