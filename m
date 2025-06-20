Return-Path: <linux-kselftest+bounces-35515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AEEAE2643
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A0416DB13
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627A5253B47;
	Fri, 20 Jun 2025 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="glyG40Sz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113A25393E
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461696; cv=none; b=Ag4pXmvWMRw9cH0oNupQfMFVNQFZgGB3i1XJecENc4fojw/9IFwOXOEoCzV3pUFY4g4C6AahCvhSeYlwNMzPb9xIAV2aqxlQ6jpe9TICBrYB4IAPwtheuvsdaFnj5rOsPsBS/alYP81ki3tG5srm8ggGxT7DU8WMMGFV7KCAM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461696; c=relaxed/simple;
	bh=4my9kGNDaIRvNshSNCgth62mZeVt9b+HZl4POywfaYM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d8Uu4UxWsgM+Npq70CiO4OsI8b/Cp3MzAGTzBnHRhpLqi3fq4IjsL+fYyBUaRSdJitNXl8sQX8jyxLmaLQyaYpGp3OqxbjcdKfA7mk21l+pw8YpdUbA5wb7QFJCQWIemJhkLPm0eOCMgwUWvV7ZFbMuUM7Slc/Ja+f+7gbX88rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=glyG40Sz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311ae2b6647so1588976a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461694; x=1751066494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a26AFvVQwIJ3xnBB6BEYvQTKqg+s5f+blmXZfQUylD0=;
        b=glyG40SziOLpaZmfTFfAaCpwzeKw4fm3vtI8wetE4AEjovdJMZMRwbfeUK8FQ2wfQN
         68OC2qRt91f1UaY3HoOO0eWRuOo4NbhBcxlsnSBywkgPCga3YzjaPkRF6Egen+7ETRUl
         XZx0uOBz2GD4vnvEDmn/lq3hgHW/LmW6UkTK9Pnh4YPZRs5BM07UBR+GUOMcqRsG9zQn
         lEs96PDsUTkFVO6cXd0Si4wi2eDimFjGljka+TlI9owNdbvfQHAYcaQ6Z+uF8/ormO6/
         mMQd/2RX+PhsqIy3PeAvu+x5RXz4KEV1Yjhs3HvqCUmdjZCthYCLJvNRuHsqxVer+Plq
         yNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461694; x=1751066494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a26AFvVQwIJ3xnBB6BEYvQTKqg+s5f+blmXZfQUylD0=;
        b=U6+NzeW20MzWnJdTFj/lO5qDYJO+QIL9NxXLQ8VfKI/RxKU6f7aKrsNZfcHkIPXD+6
         cj4BRttNZgHHaDljVroTSB46txdcniVfGwK1i1XoqD8+8reMSu8aOwx6TAGXPt+rWRBl
         nMcAe6eaWoeUtNyPoTQa2N07oRLB+vK+cQNY2JA78F0W/ucemdiIgPwT796INHJdnVmC
         FTVljoDcl8zdfJ+JsXpzriHYYWwRszC06ffWr2Knm5S5PKpeAMHLMUDTQIyJ2LJMv8rK
         Op5PsJBWDOGZduHvjXMdJTTY5Zaexx3cOfx5OgH6BWUBFxA7kFjXdCScq+RVHRRkUTl9
         ezzA==
X-Forwarded-Encrypted: i=1; AJvYcCWBP/3NJxR9M7k9ZUXmPd89PObCCxIC4yLtyhNYGLTZd/+IIj/L6mCftNqE3+gP0HDm5dHSID40HSP60hM5oSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqhjuoo3aS/zKGEH+3bmg/ypVWxZzvaz8DZaOnKpSMbG2CrsND
	5u9EmX/8EuXSt1HiDO4AMVFxyCuk2APoG2cLkurTuI2AixbF7yqbvgjT02coF+7MWWTlRJCuOTW
	sgaWBeXIFnP6jsg==
X-Google-Smtp-Source: AGHT+IFbSk3gzLX5to4epPJYrrC5cd3onFmukq/icOgjUScVa3hlQUBR0UqmtZ4ZeOQ9yMbX6GwmrsHs1LVkhw==
X-Received: from pjm11.prod.google.com ([2002:a17:90b:2fcb:b0:312:ea08:fa64])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3f8c:b0:313:2adc:b4c4 with SMTP id 98e67ed59e1d1-3159d8ded87mr8048321a91.24.1750461694457;
 Fri, 20 Jun 2025 16:21:34 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:19 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-22-dmatlack@google.com>
Subject: [PATCH 21/33] dmaengine: idxd: Allow registers.h to be included from tools/
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

Allow drivers/dma/idxd/registers.h to be included from userspace in
tools/ by adjusting the include path to uapi/linux/idxd.h if __KERNEL__
is not defined.

A subsequent commit will use registers.h to implement a userspace driver
for Intel DSA devices in tools/testing/selftests/vfio.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/dma/idxd/registers.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 006ba206ab1b..bf79bc39a5f3 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -3,7 +3,11 @@
 #ifndef _IDXD_REGISTERS_H_
 #define _IDXD_REGISTERS_H_
 
+#ifdef __KERNEL__
 #include <uapi/linux/idxd.h>
+#else
+#include <linux/idxd.h>
+#endif
 
 /* PCI Config */
 #define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
-- 
2.50.0.rc2.701.gf1e915cc24-goog


