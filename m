Return-Path: <linux-kselftest+bounces-1726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCC780F81A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD0AEB20F15
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FAE64143;
	Tue, 12 Dec 2023 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mKnVKtaL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48709CD
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:04 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5df9f98994bso22942267b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414023; x=1703018823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ir7Qh8CW4lvS6Nb/8/FOXimO+77Lwly2G5VfmqeIAwU=;
        b=mKnVKtaLzz92jCYRp6EPap2lEuR2Ltznu7AUYXOTqHFp9r+93Xb4LgOrqRZ2hs9cvE
         fu1w5OKc4nSSrms2nsLNDKTSccJD1EG0YS0Gz7hvMVpoyT9EqEK3pfplUcBqrey37+7I
         F6gpHgP1kJ6dcFyyJkGReiIGh7OM9BkQTtuNVRW9JbUiZgcFGsyluFwRzgDJ/zWL4ku0
         x6unFUGGqXruJzLPPQHZUwa5gfgNAL4YFO6scmoPySYy9BIiqmrxx3A3XeookSYFiK4a
         yXhB7w2+8vdydEh7ocG7Tkk7Qpz2nBlp653rUwZYRNBJbKTxmZBObdRBKm8hVv+UJXaB
         hdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414023; x=1703018823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ir7Qh8CW4lvS6Nb/8/FOXimO+77Lwly2G5VfmqeIAwU=;
        b=W6nYW0F+fR88sKsCafvqLE9ApoM5BmrDvLqRztivJ2OytJ7Inb4yjQvImBg43Yk/hm
         UtEtB9jIof3JVm0uiuDlxqyrjxKrqUeiHAuCCP3y966upAcgfFrxe+oT3pgfrE4OxypD
         TW+2DlYM1VFcWFdMQf62NgdHOQzYp4GVVH4FQ7r5lh+YJwLf9P4Z6vr3ajiieXUwcht2
         NaErM7UZZ3I/LOVM8ZvLWoWTxjDw0PxEba/9m48fhRDWZI10vi7pkAkILex85QaAOCjv
         Xj1+bABJeYWD4nqsfKojwsjP9tizQnO9dwULQRgxcBNZTqN3oyCRUxmpBi9tcjGsnM7j
         vjSw==
X-Gm-Message-State: AOJu0YxYPNmabhX8TXf+1wxWSjMcD+OIfu6HwnpG+q42uPDZ+RleA27T
	y8P9F5E31ViNsQE/zCKpkCM4nnzL/rrS9nDkcoMe/voflja51lsZIMwHh/tNzDKHcS833KAL4OP
	YM4XhuV4ZdGB0nx6ZWNqt5/jGI//QgA7XAdF6EOUNxnMFiF1l7TABY7srSFUU//Ao90+vk2Y=
X-Google-Smtp-Source: AGHT+IFD5ajTV8O858cXODhPLGEEFN7xEKYfb0cjWPaPFQbSpbsFud7FYSS4rJTN/cV8ArjTn5X1GoxmxA==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a25:cb55:0:b0:dbc:b2d4:4793 with SMTP id
 b82-20020a25cb55000000b00dbcb2d44793mr34903ybg.6.1702414023009; Tue, 12 Dec
 2023 12:47:03 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:18 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-4-sagis@google.com>
Subject: [RFC PATCH v5 03/29] KVM: selftests: Store initial stack address in
 struct kvm_vcpu
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Sagi Shahar <sagis@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>, jmattson@google.com, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

TDX guests' registers cannot be initialized directly using
vcpu_regs_set(), hence the stack pointer needs to be initialized by
the guest itself, running boot code beginning at the reset vector.

We store the stack address as part of struct kvm_vcpu so that it can
be accessible later to be passed to the boot code for rsp
initialization.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 1 +
 tools/testing/selftests/kvm/lib/x86_64/processor.c  | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index c2e5c5f25dfc..b353617fcdd1 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -68,6 +68,7 @@ struct kvm_vcpu {
 	int fd;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
+	vm_vaddr_t initial_stack_addr;
 #ifdef __x86_64__
 	struct kvm_cpuid2 *cpuid;
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index f130f78a4974..b6b9438e0a33 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -621,10 +621,12 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
 	vcpu_setup(vm, vcpu);
 
+	vcpu->initial_stack_addr = stack_vaddr;
+
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
-	regs.rsp = stack_vaddr;
+	regs.rsp = vcpu->initial_stack_addr;
 	regs.rip = (unsigned long) guest_code;
 	vcpu_regs_set(vcpu, &regs);
 
-- 
2.43.0.472.g3155946c3a-goog


