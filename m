Return-Path: <linux-kselftest+bounces-46560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A99C8BAC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6677D3BD8C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6C034886F;
	Wed, 26 Nov 2025 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BEI2UU2O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB9234C81F
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185802; cv=none; b=cGZGkwTYfx5Lz8GwKAOiNeDt2mq7HTzcUAW981AZYChiueMmgYx1YPJAEdfHHsDEtDRT96McTJ3W1Ej4tQEqvXKRz2HvGDU4uCrNlc0YqMjKXeLwQ+epCHYq5/xlbXqasOnRO5LIqtVf7g24Xm6EmjJN7b9Z8fPwkaRRM0AzRU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185802; c=relaxed/simple;
	bh=K+uixgzOmOQZujrzd9MR8iSY8J1cEIiUFF0kkwJVoPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tOp96hFjVJKLrBDRl45qD3z10j5mk0xBuDUnQyIOIFIeZnGUCIkWvExAIbfH2DXeTRhQthBJ8dRRKmkzWMi0u6omCIwCZhN1bCfSTfpEAWybHryllS2aL7JPUAzlJLpswKp6gUWy6W0V0QcHPxKi14cwcAWGzocgeLyHog4i8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BEI2UU2O; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b89ee2c1a4so76968b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185799; x=1764790599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ivqiOtkW8ET2HoL0E9M1Cs+J6gVjRV1eIqgG0sXk3/w=;
        b=BEI2UU2OlIZagsPVOGiJKKZrxCWK0uxCEzo9to9wwrLweYys2rEICxP3Y7ngBxO+fm
         f3QiVKJQEGGCyV/CysV7TtFVrGvWx6EMLKH6BKaIlMc3VGZoHNbtZrflwoV88DynHYSF
         9V4gXbQ/x3jjURWe3eFZZVYnYb/hB8LM8pjdPM6aAhEViE/jNk/QvL3CnuFtMRJvgD83
         S/EyGFBq+7jIKn/OGlmLuZ8FOwper2QPtGWRZElYDV3YtwYXXOB7Vq9A4U/AV9YgTN3R
         nmBvVC0gHG8Y8cI0oles7TB2kdVuuuN9OJ/V4GhIpNDjPeKepyPcRA2gvZcv6RgU7cWU
         4H1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185799; x=1764790599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivqiOtkW8ET2HoL0E9M1Cs+J6gVjRV1eIqgG0sXk3/w=;
        b=BsYvSradPOyXkYlgHm2GMfUKk5K2yVgNnN503S6razsuyco9vO7WYPYRUS3ToOyFeq
         vEi/qdMRy4VDYwd7WkfRTyDRI+kHWxr3jf2sVIvE7SUzIuwOH1IbmbzVzTUbg7ZM00Zq
         Ksz6VEXBfZpdM8lkXpeglVoC95MN1CJSzaiHUbLLdUpg1Sv0LSLjGjRg9XBGcnfUlmwM
         VePacaDvcwyWhHi5f+Iup8z/VsYBwcb3fzU4AJE8eggm2gReY8fG3x7upWonOF5imy2N
         8VFUl8qtiNFVS2SJ7ZWeOos9DyhG4OSdB/q9rJaFb9DIzR256wSC7JluFKMrtNyWUwrn
         g+2g==
X-Forwarded-Encrypted: i=1; AJvYcCWpoDTECEQImZzghqf73IFTx8blfXWppFq+6OQgcHzVYfRgxxY3rTmlDxh4ekKPwuFLUBR2uzXOSlbMKhJLIXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR80vQWC1qd31sM97dNoDJWm5whJeUQNlUCHXHIsKPCHkBcWtq
	UVCVe7Kc7LWLHFzpzjbx2y3WZ8N2KysBWgGiGNvgKvH/vFsDGJkp5GoCr154UWhZHahoYM/ua8W
	5tE1CmGZtLMD7Xw==
X-Google-Smtp-Source: AGHT+IE3jtexGsrRDjIT0Tyf8nE5Fmimh71e5TPCAkGjiZc+TJVpvLRXUcY5i8nAhMcct73UaVxxGUfD8Z9rpw==
X-Received: from pfblc3.prod.google.com ([2002:a05:6a00:4f43:b0:77f:1f29:5399])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:23cb:b0:7ad:f6e8:d013 with SMTP id d2e1a72fcca58-7c58eaf4174mr21909766b3a.32.1764185799181;
 Wed, 26 Nov 2025 11:36:39 -0800 (PST)
Date: Wed, 26 Nov 2025 19:36:05 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-19-dmatlack@google.com>
Subject: [PATCH 18/21] vfio: selftests: Expose iommu_modes to tests
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Expose the list of iommu_modes to enable tests that want to iterate
through all possible iommu modes.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/include/libvfio/iommu.h | 2 ++
 tools/testing/selftests/vfio/lib/iommu.c                 | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index 5c9b9dc6d993..a03ff2281f11 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -15,6 +15,8 @@ struct iommu_mode {
 	unsigned long iommu_type;
 };
 
+extern const struct iommu_mode iommu_modes[];
+extern const int nr_iommu_modes;
 extern const char *default_iommu_mode;
 
 struct dma_region {
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 8079d43523f3..bf54f95ec833 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -24,7 +24,7 @@
 const char *default_iommu_mode = "iommufd";
 
 /* Reminder: Keep in sync with FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(). */
-static const struct iommu_mode iommu_modes[] = {
+const struct iommu_mode iommu_modes[] = {
 	{
 		.name = "vfio_type1_iommu",
 		.container_path = "/dev/vfio/vfio",
@@ -50,6 +50,8 @@ static const struct iommu_mode iommu_modes[] = {
 	},
 };
 
+const int nr_iommu_modes = ARRAY_SIZE(iommu_modes);
+
 static const struct iommu_mode *lookup_iommu_mode(const char *iommu_mode)
 {
 	int i;
-- 
2.52.0.487.g5c8c507ade-goog


