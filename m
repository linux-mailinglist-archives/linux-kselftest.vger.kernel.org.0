Return-Path: <linux-kselftest+bounces-35507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490ECAE262D
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBC517FE87
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6288024DD02;
	Fri, 20 Jun 2025 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wfisIqAR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AD324CEE8
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461684; cv=none; b=SU+nFRNZWfDOUDHyHr5UHERPJrCzvj2QrHaguHyxHuYREo4KTy4IKBZSBcqsBBcEyNRzFnyxG0vEpOVW0erkIzLOCdxZdgQ2VjUietCjSVbdz7oTVj0yDwYD4afos1JOHYwy69rcZn/k4u0GKaBNam6Fiz6ORqWfxuVShB6kszs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461684; c=relaxed/simple;
	bh=jUQ6fblZyP5yrrrhW782/ks/4TQNFKMKqxLplCvvRtc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YzP20JBD0CWfOLlXIwOnfwUNYE3XL9dUpUZDg9OWiZts6y62lljA/AR4N6CExXFLoMYh+6GoR9YRgOwE0V0TIg5EWJ7dNYcODWB+ihPujogkOoFxr9/zoUejGIBR546Aez5cK4qbLpp0ZYsPbITwTgq5FRN5dguUl0PRSy0Ekq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wfisIqAR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23494a515e3so18675755ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461682; x=1751066482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=flq+a2mRznxpGsau0vYK6FlLjSN1oZpPrKPuy1/kqkI=;
        b=wfisIqARdneSAKP+JLeV4IEBVNEzkMLzFUTUn076zrFk4hZIW3gAGjhrCLjnuVfftA
         3K5I28RRROLisqRzIEWI+E21hXLKZAkjratNxoIGSragOfQFWv1scyTktsHpNV1EkQBy
         wIv0UYEAe4u1Ajm71W4sRzpkgO9FWbW3CcNxjkYqZnJ97oYsCXOG1M71cRLX3Mqgf8LX
         ccuzamGQ8rrcN2QAREzOQ4CWldYT8qahYq8DKxTHTKkU4c5J1uit5YdiCp9TpI61yd/I
         l4Z6darsmw2Be4CMQiqQDtFDQ/Znw5qPAAbNgd5pDGFfypl6uI5WlB5Ky4NJthp9aazk
         ylQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461682; x=1751066482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flq+a2mRznxpGsau0vYK6FlLjSN1oZpPrKPuy1/kqkI=;
        b=m2zVMsVqD8CDACVFjNzIyAbUa2f8g0FhEm4a17QmUiIlfBXmZIAjS8rxnGeo8actyo
         kxUEX2Xc8Jge3UFcwMp62vt5rSGPvkjd7ykSWhMej0nv2IhKlOESkmZ2EWG5qkqchBTu
         g/XbvqxNCFrHai+NCU967h9Z1SWb7y9P6N+NHSB4oMnvYwvEqxi4euEsjU9Edl7VIvxM
         lRJbKQS2kE/lZs7bl7TUmKTxpXkHUqg/uIHmpgsSl0iYMRtcarWH/7rUDeKsZynkT3Ej
         UE+J3OwJPB4HspnbCwSmy8L8wkYN+9uCTTP5cO+ImY7thtjqMAcuMVz1K0JWuI1EEy4m
         Yp3A==
X-Forwarded-Encrypted: i=1; AJvYcCVPjueobgwvJMaMMFyNWmV+nGaZC0C4bUB/Cji+Fc1cGWzRMNbqeKDNNtFG5LaWjUuehKwBH2lmfRiJE0nOpZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYlRvAamQRdOf4VQEyxJHazNqcNqZ2dhRTl3xlFUep3zBM2cYO
	Rp1kqUn8qo9vajREId9i0IbNTdWqZsMBm8dKdT3JmE0Qi4XvL3nikDNzV21iamWa4oQtkNMLDEF
	WnDBEnhBCFXL6Bg==
X-Google-Smtp-Source: AGHT+IHOLjlrK7lX9N2K1i718IX2QfCKQsbF5mBCFBku2Lgi1zmJpXeBMuXAfM3LxPN/gVHQwaFLDnwR20MVhw==
X-Received: from pjbpv1.prod.google.com ([2002:a17:90b:3c81:b0:313:2d44:397b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:22d2:b0:235:e309:7dec with SMTP id d9443c01a7336-237d9991770mr73767115ad.26.1750461682303;
 Fri, 20 Jun 2025 16:21:22 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:11 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-14-dmatlack@google.com>
Subject: [PATCH 13/33] tools headers: Add symlink to linux/pci_ids.h
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

Add a symlink to include/linux/pci_ids.h to tools/include/. This will be
used by VFIO selftests in subsequent commits to match device and vendor
IDs.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 tools/include/linux/pci_ids.h

diff --git a/tools/include/linux/pci_ids.h b/tools/include/linux/pci_ids.h
new file mode 120000
index 000000000000..1c9e88f41261
--- /dev/null
+++ b/tools/include/linux/pci_ids.h
@@ -0,0 +1 @@
+../../../include/linux/pci_ids.h
\ No newline at end of file
-- 
2.50.0.rc2.701.gf1e915cc24-goog


