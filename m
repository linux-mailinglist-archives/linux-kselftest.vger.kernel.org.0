Return-Path: <linux-kselftest+bounces-38498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B89B1DDD6
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148B558206D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B86A273D7F;
	Thu,  7 Aug 2025 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hMmx0oYs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5D7242D88
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597804; cv=none; b=KiFQtC6JGRRkbNHID01YSQR/dpydR1RRqA/T3p57wukbDbbBdoc8HISgNdo9sI7oQPuOPw4BZT1vbYf6xxGBIPd9HsaYZD6BeXN7fdGfhsASs2NH9U8hDZIfi4iAiAEVfGoySIf7BZ6UP8o++DZAcSAtE2e5OS9ZFpyjNQCO7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597804; c=relaxed/simple;
	bh=KOoCqu20ck1nvt78qXS9AASI1nzd75am6SWO6mncJgo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gSOGXyeVYKZtHJj4tzyFRqctMXSwjNiPiDhHAGZOkqTrhV1WaZayuZZxASIRJhPNETmnHNhCBzda2kp7i/0UucPSecV81/45AsVlkxQIximWMMEDCtkBOdeO4aWS+VPDxHihyEoegO1W41NPryGvnmON0R3TiFIgBH9XkET+9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hMmx0oYs; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2400a0ad246so10940375ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597802; x=1755202602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SY1063A3eM4jRKn9Lwg/S7WLjF7eZucmIixEhnmKPCk=;
        b=hMmx0oYsdjn7KlMNcJTZeUkYVJbkfVI5BM4olXFkYdlYoCIyV/n6Wa11ABEHQlKlfO
         p+cntW22meeHlU9gZriYiRXwVWG3F8J6XFYriehk7rHoe4X8kafK0ATuXWwMbChgczt2
         1iCoEjOwiW6qSAxZwb/3xy4Fok3b2HsyjKMNu9c0kvK3pgf3b+9nGNTmJddJZ6+50GGJ
         uiWn6WWZQINbRSW+VaqU/UI3XYbk3ngh/M5bVSC6VJPEvDhu/q+0ZsYeBPrsRQ9Qtsek
         pHbQMikiEfZodnP5Q49oOQcZeS282ZyDL5b5JFSRHVa/mts5Jrx24MH11E8n08nzJCvR
         2m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597802; x=1755202602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SY1063A3eM4jRKn9Lwg/S7WLjF7eZucmIixEhnmKPCk=;
        b=AhjIlgg7go2gRz0LM83afxDA0G7XXPvYFJNkQ+SHo/1/sGvg9VadpohNSJkHcUqv8S
         QGPMNiAXrzygkpd5R9D5oX9FKy0NFZmMyiYYL4+FvR3VgEOrA39Xwv6k1yzcarY5DZIZ
         x/knZu1rYVmBsSHRdmYmqkwL13ErLiUPap9Fb7fO4DcZ6ayr/qLM5nLsf1f8kyAIGDc4
         AC3Vxg/OkLNE2aG3cuLkfMSz/CiMpgFDHhZZk8kZ9V7DkJdx8NZvL3TWAne4BDCDEM1C
         ijLgGz+ODId8pt4cXSQBpYmfZ7cYsfHZ41zvtbzhUsSe79i5ipKsCSB43htx5fTE5ibR
         C81A==
X-Gm-Message-State: AOJu0YyBMOLLkBnkne3axV6JsAzKZiitVfBSrGfPO26CzVzYrtxoAvss
	xMgHScVnxdIDk7xhvlbMBMbg8bGoVSi8w2kzSkP19ehwqj+1NuxagClN7pv05uUF58Sjbo2ijkf
	WS1rfzv3jBscZLxZiKrBYoLSR+nBT53RCxzo2a3OK6Rep+HVT32I8qONsxFTFgwZ+tcuxYnKczU
	RpLzfUZOjRYnwYdu7+ITPNkbdjeF/q06fGS8MMDNuqE/4=
X-Google-Smtp-Source: AGHT+IHr+KQP67F9tu5jX/oDeI0DglRUP8n3J9QXbxBj/BZFmCvo1Gke3fbBZ35nerS00VBumho8cM4uag==
X-Received: from pldy12.prod.google.com ([2002:a17:902:cacc:b0:240:2d28:e064])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b26:b0:240:41a3:8e0d
 with SMTP id d9443c01a7336-242c221775bmr4503185ad.36.1754597801923; Thu, 07
 Aug 2025 13:16:41 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:15:59 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-4-sagis@google.com>
Subject: [PATCH v8 03/30] KVM: selftests: Store initial stack address in
 struct kvm_vcpu
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
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
index 9994861d2acb..5c4ca25803ac 100644
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
index 002303e2a572..da6e9315ebe2 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -694,6 +694,8 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	vcpu_init_sregs(vm, vcpu);
 	vcpu_init_xcrs(vm, vcpu);
 
+	vcpu->initial_stack_addr = stack_vaddr;
+
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
-- 
2.51.0.rc0.155.g4a0f42376b-goog


