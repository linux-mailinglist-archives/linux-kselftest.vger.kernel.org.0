Return-Path: <linux-kselftest+bounces-35523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C899AE265E
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249D717873F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69713256C9F;
	Fri, 20 Jun 2025 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="THhmOVSf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6DE256C7E
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461708; cv=none; b=OMzJyUS09WK0p0SGEYkZ9WEL1q0o08KrckYu4xWbscG+I08TiEpTxnNF/eKbS05J0m9VGIRLovjHYOfqDaZ6+0+1ja/WNIlPxjJ4OQtOCpJ4quOTe3nsDgVgx/GO1snx68aLyj4AULWGvrYP/UkpzqDHb3RYZOFRtlGFfpClZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461708; c=relaxed/simple;
	bh=JCQ5qUwXaozILLE69shDGV6q4nPCT5cZLpILZbN5ymw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kyjqSxykTE9bGFOtrgdQ/qHig5E+FFP7MZ8SSKrCc/vHAbxOQ0WjH/B0zoHqD2iXh/CiOJfhPjhkFeL0t91ZGD7ZjE5ccwNtfaW+qnd0gdkLkPdI/nhZNU4OrQPLj7iPjR6nfgg7hh0M4HqYLKY2el404JvW0E/Xnea2ttZAkTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=THhmOVSf; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747dd44048cso1898365b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461706; x=1751066506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KVUioh+bOQA2jQy6r+aa3so3jjPL/7B+mrK+Z3Qyf0M=;
        b=THhmOVSf70VwS9kVUHahdm+eb3iviAimVB0vlEgHibCV2KCsD8VlAtJtPAoYNIaU7G
         ozBvpDflVlRJ/rBoJd/Nstvmpw8gjuMOWW9DoMD389ONn1rSg5YIRnIciPv0xSbODt1V
         dut68MDb9MmCaE9uobfC4fDlQMqu8CNMLZVEE/b/Hmt4QXL8scVTRMcskFPnB11daHRC
         aV3U5crPhmTEvKcKVcuJp8w4b73ENbys6QagrJGc+opMfdwZ1N/UqOhRaPF4FgVUcJ50
         2jiGSHRohIJmGUcayPkVcSVbdUMW1s2j5NLts53lXk9Cbz3lwxKmOQlvwApMwKydrs24
         X2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461706; x=1751066506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVUioh+bOQA2jQy6r+aa3so3jjPL/7B+mrK+Z3Qyf0M=;
        b=UmMQ0epJ2YFdLvAXgrvN1EOmmBeDApMsjYAjTWXoI7UWd5NHO9JcF4ocDH940RhvfG
         d3wxOigTcrEG6xZr2V6yLkwQJLfeX3HEGIhAPReIHZyDFyLIjj/vTJTtcxZunliyIUbX
         SxdSnwTPLoUQs3QiRvUmeohMRViNJLXMg4PLYHMlifZZiHpiPLAbrjHMwH0jYnTo9SH2
         9ZhZ4oG+l4cla6Alc6RcAnc+Kcsf1VM1/O0AbIEK/Ql+6Xm/jLQZ7S+c1Lwl5/lVcz7c
         D6YdneKnIdgdbzWSS6gMBj/VhuMuIAkr9moJll1evOiCX2XH//j5eeXHHJFP5nbQJndr
         mQqA==
X-Forwarded-Encrypted: i=1; AJvYcCWxZTETiP5zSj6yqEkFRa9fSviZOCnG4Kx36UwwxxfCAJ+T3/YUF/AeIaYaFZHocor2ZsMGB4Qv2Xy8/j3ZnZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEeFmi1CnZSK9t5/4anBKE9kjaydzPTeZNP9u84w6cT65GTY24
	A2Op4PacPW9MH4OVkAhMJIcTRWyhaIVTr9P7Xlaj4PKUeZ+6WTWzl5E1uahPE2PP7i7ip7hFLit
	9c6V/YtUwDJLe/A==
X-Google-Smtp-Source: AGHT+IHmgFATEqQMRHKmZukQpBV8lJiUa5MoULZ69tTqJFMZWT86B6ShOvEbjD75ZYuYqoFgPxgCHj9JXN2tBQ==
X-Received: from pfblj6.prod.google.com ([2002:a05:6a00:71c6:b0:746:24d7:a6aa])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:13a6:b0:746:2591:e531 with SMTP id d2e1a72fcca58-7490da49974mr6225173b3a.12.1750461706315;
 Fri, 20 Jun 2025 16:21:46 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:27 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-30-dmatlack@google.com>
Subject: [PATCH 29/33] vfio: selftests: Make iommufd the default iommu_mode
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

Now that VFIO selftests support iommufd, make it the default mode.
IOMMUFD is the successor to VFIO_TYPE1{,v2}_IOMMU and all new features
are being added there, so it's a slightly better fit as the default
mode.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 5d8944a37982..0921b2451ba5 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -437,7 +437,7 @@ static const struct vfio_iommu_mode iommu_modes[] = {
 	},
 };
 
-const char *default_iommu_mode = "vfio_type1_iommu";
+const char *default_iommu_mode = "iommufd";
 
 static const struct vfio_iommu_mode *lookup_iommu_mode(const char *iommu_mode)
 {
-- 
2.50.0.rc2.701.gf1e915cc24-goog


