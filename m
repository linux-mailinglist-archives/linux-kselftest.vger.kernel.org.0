Return-Path: <linux-kselftest+bounces-7487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 624F689DADD
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 15:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC59B24524
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 13:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50766137935;
	Tue,  9 Apr 2024 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mc/ebmw5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6F137910
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670023; cv=none; b=H0AXa/Z/njK8niBpgKkMo8xlMrmB1fIDZKKnkTUZ9hNwlwYViBf10nw1G5ys5r6rrak6Og3A/yAxlUDCOsiW6vAmiR7C4WBbjOUEfWyk0iwam7LaqAI+wMbXgtvo4Cog3vqAkkquLMHiYAk8V2selmeLRXQ7qH34bUQQLMkbeqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670023; c=relaxed/simple;
	bh=2b6eHcNeVCvRQQmzK59zV5ppiACnwweiRuejIQXgMnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zqg/H0XfS7sTaHkyqLAA/L0xYzPeWziSKf0TLzz5Uyj+1JWuKAN53Qe2ph/uH5zEdCcqj7b/BCaOIYJYLjfXZUFMT8NRuT5M2eUzquitW2lt/648gmRwpGcJLHlYO5JLiTgVh+UwERd3AcdiTZIH727ohRk2G1FWMC0bfvpVeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mc/ebmw5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e42b701219so16519125ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Apr 2024 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712670021; x=1713274821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HllfViT2e8TXryeK76KgmwtGw8czHt6x3mYMpA66Ylc=;
        b=Mc/ebmw5QwCFbFerzqw7cejbL0lwdDA7fSC2BZvlhls7rvjTZ4SLSauoYiu54ij8Rm
         /ORgTR/qG92ceW8VIENw3XuR6LmDQmVXa40/nrVNq61rZ7P5m7wN+bijjZdwP1DVobwB
         ErDwKsHqDO/jhSNn1GFbEDVoEsgnFMxus4R3E6nj1SRY2/sbNSt9KKXp0YxPVZMJwSsf
         y3NSQ1DdrQ+wl/RQR5gPkp5rfQkrFS4tC5ceZ6TqkjFrFOdWC/mtHiCsOI15Zl4zs4Zz
         MVgjslVCdmuvYrG8M8b5Z+K5clTeFPajpV4FGKyYkytz6bCN9WheeHfWEoVLSL6J7HFf
         k0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670021; x=1713274821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HllfViT2e8TXryeK76KgmwtGw8czHt6x3mYMpA66Ylc=;
        b=TpIBRTb7nYGVlLww8GrcocqSjn7PYGTeFyGkxShup6YMVDiJHPfONXNr8G6NgD5c/o
         EC00YCmEYSFCEf9V5KXiB7fLOOHCs/BUJ3Fk8fGZmIRfNYjvkX10Mv6700/v+hpcDfyC
         wLWQWl5YGWRw3PgTvVn/ngE1StiCWtkLP3Su8BI9MN+e4+QoD7He4drG2dt3B624axCo
         caSfGpwPugRuA0PTfB1CjziAlbMLetfS789rGk/BpQEXf3sHJS1aujT//GMC79YKzQ7c
         ySb0ll5GtC61KMCT00zFzZY6sbU05oPkDAhb9FbMjCXwjDjxFNDeVuX+qWBHlN/47Tnp
         RMQg==
X-Forwarded-Encrypted: i=1; AJvYcCXtkrsc9VaT+dAmvpQSEpn98IG29WEwkeos93QOr5Cht+BI6fbjmgqZXR2MoGGOwOoshJR5gDwM52RKvfEQARuK0UYh6ECD2tWdqruCauAL
X-Gm-Message-State: AOJu0Yw3PkpjjqIJbBilUwD/x0JtUPsemQehj4JmSVdXyXd2al2qPAet
	MHIpuNVWrtBqXyWyXzKXha+75E92qxsI4GYXRoJOqeyzUY2wVV5DE4tDBVw7HDMzbmjuudrdIkK
	q2Q==
X-Google-Smtp-Source: AGHT+IFUlHD44CMr0s3dItKfwn5nJum6+Wr/A9eo8rpMn4QdcJTDRhsQ0s4mkbKU2oe6MlLChSVcm/arxSM=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:15:661d:897e:ea86:704d])
 (user=pgonda job=sendgmr) by 2002:a17:903:41d0:b0:1e2:ba13:ab90 with SMTP id
 u16-20020a17090341d000b001e2ba13ab90mr1125518ple.1.1712670021179; Tue, 09 Apr
 2024 06:40:21 -0700 (PDT)
Date: Tue,  9 Apr 2024 06:39:56 -0700
In-Reply-To: <20240409133959.2888018-1-pgonda@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409133959.2888018-1-pgonda@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409133959.2888018-4-pgonda@google.com>
Subject: [PATCH 3/6] Add vm_vaddr_alloc_pages_shared()
From: Peter Gonda <pgonda@google.com>
To: pgonda@google.com, seanjc@google.com
Cc: linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a shared page allocation. To be used for SEV-ES GHCBs.

Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Peter Gonda <pgonda@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 1 +
 tools/testing/selftests/kvm/lib/kvm_util.c          | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 9a26afd2e82a..8fa6e55e0039 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -595,6 +595,7 @@ vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz,
 				 vm_vaddr_t vaddr_min,
 				 enum kvm_mem_region_type type);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
+vm_vaddr_t vm_vaddr_alloc_pages_shared(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm,
 				 enum kvm_mem_region_type type);
 vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 2a7b2709eb8d..bce60ff749ea 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1470,6 +1470,12 @@ vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages)
 	return vm_vaddr_alloc(vm, nr_pages * getpagesize(), KVM_UTIL_MIN_VADDR);
 }
 
+vm_vaddr_t vm_vaddr_alloc_pages_shared(struct kvm_vm *vm, int nr_pages)
+{
+	return vm_vaddr_alloc_shared(vm, nr_pages * getpagesize(),
+				     KVM_UTIL_MIN_VADDR, MEM_REGION_TEST_DATA);
+}
+
 vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm, enum kvm_mem_region_type type)
 {
 	return __vm_vaddr_alloc(vm, getpagesize(), KVM_UTIL_MIN_VADDR, type);
-- 
2.44.0.478.gd926399ef9-goog


