Return-Path: <linux-kselftest+bounces-30768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F51A88E36
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C3E3B05F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2881FBEBD;
	Mon, 14 Apr 2025 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+n8qRFr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4621F5826
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667326; cv=none; b=MBMKJpOKsjwDl2Pnsg2fKxIsdZ2dXVQKAngSNquJkaTLMa3dr7P38R2KMnsBmQwC367w6rEeGFt+ig5lkQdqUmE4bG8NVlSfYPaSi6DvqyflbgSIG3NSWL3HVJwr614MW0VrLXdxXF+2Qzthc/V2vCiDW8KqARE+gJaxWMfE38g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667326; c=relaxed/simple;
	bh=v1vU9w9fOgcK6mGNYSWomneT3Jf2m20NWhjo4CsN6RM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FSxzI9rrzD6FB92CVqylnHJatKD7qWSuMzM0z4aL2+h1LpUr8q4rz1uCAvYl6yyHXbhG3+3F2JJ0p3A56NoVbTKFLzHv/y8FAC6uPSPLetQA0GYngyY3RdK7BqOKF3j4wytYlr9N/Vtw3b5c8rL+E2aG9NjyFy5ZI+fKgNU44jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+n8qRFr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736a7d0b82fso5568278b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667323; x=1745272123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+s/qVOGbhuO+H0U9xUGKtlbnlzqsD0JwzNjS6nutT0=;
        b=I+n8qRFrCHi6VakdA5yhBhJxBGNM5jktot7DwwA0uDVm8pwP+bUK6lGtrgiztITxPf
         HVy/yYbG/qdnsMc+09uJ4QyUSwBfqqBJ3eE4mPeHr+qWCDhoFSjpXM3AVKwRoI8VZ+l7
         fYuDLG5X3ys5uZYzd6WVVutuDRDP05Ra1pvUgM6GoTmRKq8iK0D74xDtojkAObnt8fto
         4zxVaBr2uJaOTgxCCN/2qiboS62DfduDtdrWMc6fuYzcOb9x/wcQKub737pNluu7o8tP
         uKg/v5kaNdeGwvbk9SdkKhYkK6uztq7mAkE9EdhKPboM5E16TO66nIfA7zw90tQnCD6J
         KZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667323; x=1745272123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+s/qVOGbhuO+H0U9xUGKtlbnlzqsD0JwzNjS6nutT0=;
        b=TA6O31U8aatrR4MUqASfJvd4ldEEuKAIrK09zBywl8yXT1UKHBYmnhu/JeH0Zertql
         xdATWrVzxXHq2D3piEUJ7ZIesukhrXkFr2TtWbVULm1Ncr4IIwQR/2mmRbKrmCeXMNl9
         bTvyITeRToZlQEhs7/onIyTWsH9I1rOdp+9ahIMiIaMifYJ/r/iH4NLkSXaBLLeRGAh4
         bHaOAOHP17zBmyqj0Xhpnse17UQHvpbLpTGZXDYsSWB35seX8PmvuyuKNbOSSQ6qjKOb
         LGKNcpcfsQozB3NuSIgJMrD9V5Ibc1ccOEJ2LbbLwwgighmcqoKtDRi8O8HDKDXKleJd
         pWBA==
X-Gm-Message-State: AOJu0YzhX7sAwH1UEVtxM19TGNg2SwXeqGcmdIxKEl6cg/r1aMh0pdDs
	sDNKH3FYL1HyfnWiprsCW6UZkbRSHSL+aioB1ivV6Lpn7xlX1HU4jfh4FZr7TiRb+2ZRTitVG58
	co5Vhf572l2k9O4KIctc5ewJg9No6c1sMOhruEbftdwhjq/1jZAGSz7whSHX0RolZzBuHS8MfM/
	jb8Vb+DMnjqYR7vb1ruD1Kknod0O7lmB8VHFht0GM=
X-Google-Smtp-Source: AGHT+IFXjDd5QaCkjEQM0TvRDAQzKGrw46opDPglY5+CRyoXMxnqy73jYYR6rm5eLj+towNyrRWPQ/Gjxg==
X-Received: from pfbgh6.prod.google.com ([2002:a05:6a00:6386:b0:730:76c4:7144])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:80b:b0:736:326a:bb3e
 with SMTP id d2e1a72fcca58-73bd12b37afmr15068525b3a.15.1744667322971; Mon, 14
 Apr 2025 14:48:42 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:32 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-4-sagis@google.com>
Subject: [PATCH v6 03/30] KVM: selftests: Store initial stack address in
 struct kvm_vcpu
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

TDX guests' registers cannot be initialized directly using
vcpu_regs_set(), hence the stack pointer needs to be initialized by
the guest itself, running boot code beginning at the reset vector.

Store the stack address as part of struct kvm_vcpu so that it can
be accessible later to be passed to the boot code for rsp
initialization.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h  | 1 +
 tools/testing/selftests/kvm/lib/x86/processor.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 1bc0b44e78de..74ecfd8d7ae0 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -58,6 +58,7 @@ struct kvm_vcpu {
 	int fd;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
+	vm_vaddr_t initial_stack_addr;
 #ifdef __x86_64__
 	struct kvm_cpuid2 *cpuid;
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 1d6ae28aa398..7c0fe3b138a1 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -695,6 +695,8 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	vcpu_init_sregs(vm, vcpu);
 	vcpu_init_xcrs(vm, vcpu);
 
+	vcpu->initial_stack_addr = stack_vaddr;
+
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
-- 
2.49.0.504.g3bcea36a83-goog


