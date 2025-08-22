Return-Path: <linux-kselftest+bounces-39757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C089B3248F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E841CE19E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B07350D7F;
	Fri, 22 Aug 2025 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPc1bKan"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A333CE84
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898009; cv=none; b=dgWdnL6sLTFPPnoFc8KZ24aa25/k8oxUZwiO4SPB8FZsDNuO2IQfTHrjOrhW+t0/o98Ag/oeARoV1uT5598zjGYj440fAea4DV/07Hu+7coR9BUjUoVLFNJ5ABZCFrexf3yyzf8wT50VYgYSa7R3nFDzaTi9kJaB2+4eQrBg+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898009; c=relaxed/simple;
	bh=sh7MfRrAOZij7IDH3NzvhcBuoP2zKJwxaJk8P3oeD/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B3OYfo7ENNxaoLdfkpc5xZRrwwkSd6puNlEfkOOxfAOZmtbXxWUrMZxZwihjGE7RtSVgGNydN6runW0AAHDp9aJ7dLmkd0qqFumDDkw9EKn15NKB0rDVFMBioN7vqqX5JNPgRjIGzBWKGAayd/Z/WeBatCyxlclk7ZPnFqUNhLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aPc1bKan; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3253c517fecso576880a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755898007; x=1756502807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=onZhjFNbqDI2Cp2ViRPMMzVX/q4pjThkfMtadERhvF4=;
        b=aPc1bKanVOq62l/fQH5toQmhdo4QMxQ+LV0Ca583o6H/3McAsYGaqDQKxAwxwlZMrN
         w9R+1lWp0KkRpkm3VOi/Yr8OxUoqdtNthbNH8OFYMbu6SEuJVKjuVyn1S67VgJRkcyex
         mh4IhCT/k6zknVw83cJb6RXimKETYMuGdgzbJq3yg9s1OXRh1gwzUN6Gz5JNAI6y2KDX
         cfmYV+0YFmU8B+gxgb+2JcvotCOWLzPTpC2xTnqnsNCvkgcSprwZaS1YUrC2Ya1/uzLF
         MusmUM4rSVB6jzn70Js1JYEZ1Rr8tSzLzkRh7z5wthP0h60GLd5V5jG+Jtlo8DlyFcJv
         Uznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898007; x=1756502807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onZhjFNbqDI2Cp2ViRPMMzVX/q4pjThkfMtadERhvF4=;
        b=DplfxEXuwNnrvRypZLI9VzxaAl08iG/jHDffH8Pqr5x+K7F1RFOgZi55oG/iY15jrc
         cuxgnPJxyYEegvkAjUSE0hAFXOQ8VQ82TOVX44EJ8FrhhlWS3R3RcLBXY0IrEAJd5Tax
         O8YpYsR9x9WN+28KwxgVQPwfct8kaF6l2qs3qhoPDRPPPyoMCbRHMgy1GQ8ocpLPYFfu
         MUmE5Q5/fPtQo1cJEL4tkwxOVwv1h52tX0bexUgj8DoCYH1QPJdzGV+5j4wN7GOHEbIS
         D7iamza+tSG4Vtzgqb3t460b+feSFyTxGstBvsqYvVUgWxVwsnGXinUKk5cDks3iJNYO
         kkXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6tj8qcEMUWbC7vQ5odzSHBYSIYyROkHRupRpJvCXYq0RMFBijXlBaLzyTkPeZuak9GmCd3dv2oLoOwfq7FtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2dXicoqh4oAWukVsXmKyJ9NviLzTyv04ySX4YgauS4zR43fZh
	uPLIv48EtWmTltn8cTgcTcM+F99FOSlq8itEX8TAmLh7FAiadxxfpeD76XWS35GFU3vvsN1idXe
	Njd9ROJObIkkLVg==
X-Google-Smtp-Source: AGHT+IG2yRIP4wJNDx+3ZhqjNdAXW3cdcOyWtXJFKmvuNvY8aZ9mLND9WX45Kkk+KjItBOJZMK/HD/nxpKXidA==
X-Received: from pjbpl15.prod.google.com ([2002:a17:90b:268f:b0:325:220a:dd41])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3f88:b0:31c:36f5:d95 with SMTP id 98e67ed59e1d1-32515e2b881mr5213233a91.2.1755898007294;
 Fri, 22 Aug 2025 14:26:47 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:13 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-27-dmatlack@google.com>
Subject: [PATCH v2 26/30] vfio: selftests: Add vfio_type1v2_mode
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

Add a new IOMMU mode for using VFIO_TYPE1v2_IOMMU.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/include/vfio_util.h | 3 ++-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c   | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index bf0b636a9c0c..981ddc9a52a9 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -59,7 +59,8 @@ struct vfio_iommu_mode {
  * which should then use FIXTURE_VARIANT_ADD() to create the variant.
  */
 #define FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(...) \
-FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1_iommu, ##__VA_ARGS__)
+FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1_iommu, ##__VA_ARGS__); \
+FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1v2_iommu, ##__VA_ARGS__)
 
 struct vfio_pci_bar {
 	struct vfio_region_info info;
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 5c4d008f2a25..cc1b732dd8ba 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -371,6 +371,11 @@ static const struct vfio_iommu_mode iommu_modes[] = {
 		.container_path = "/dev/vfio/vfio",
 		.iommu_type = VFIO_TYPE1_IOMMU,
 	},
+	{
+		.name = "vfio_type1v2_iommu",
+		.container_path = "/dev/vfio/vfio",
+		.iommu_type = VFIO_TYPE1v2_IOMMU,
+	},
 };
 
 const char *default_iommu_mode = "vfio_type1_iommu";
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


