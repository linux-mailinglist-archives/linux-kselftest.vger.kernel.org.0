Return-Path: <linux-kselftest+bounces-42382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC59ABA0DFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4098A1C24141
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7440A31FEE2;
	Thu, 25 Sep 2025 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kiPEiI36"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537F31E111
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821366; cv=none; b=jApTwT57BS0qAJvFjY86YZuhtX3JPpk7o1+kz15pypWx3C+TOibIJAtkitkFGPx3O7Wi/XQTFnv1JZaPOHUla6tPQ0bEQqafOnhNR+tyw796aHPFxL8m+t6mt3JsrRkaKfzt3nZLV9XE25hIeQgbmIefyMEHIZ8R38DD2Tv8k0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821366; c=relaxed/simple;
	bh=N5r2pH7Jwn+UxzmPgmfntcD0GoTvHLPDa8gfUCDrUac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kPc5abT7dKZyObEoyhZxPGnVF89eh/C8rCdgXgEWEhwMT8hkOQtXLvsWbZxGPWP/aX1UdS5+XIli9me7wJhfvvAi4828K37gOa/9s0DMJfR2zokZMiQprL7JT5uACUiplscMB7Q6oikCc4JdEhdiGdESWa3wNLyspOSugBQcBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kiPEiI36; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ecab3865dso1755683a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821364; x=1759426164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyCKgWtQwcGiOpMFoEKR3neFUGnY7KbKUl9IgIuxfzM=;
        b=kiPEiI36knB8QTJ3KHIYCWiPvvsocQ5DEHDaXsm/x1eDDfhaOGfeoGdpa1kUx8uVso
         qgQj6Lo/q7NG4Ozh4G3ArfTAZiwByd87LlUzsb0P3ZOPXCxyyi6O0sZd70S/AaVjr4pg
         wNIOSERXGWbRpbZaaO1LSAv1aSFK4rIck/ErEXO1Lm1iTuryL8+N7JKVQVJXHqPRtMyG
         Kq+HOxeC6HXQ0nM41yy6UqlUVE4lPa/oeZVxQ4udJ6QsRNm+RU32VmA+CoNdWyXX3WrQ
         mjF4ueVfSY8xqKTdiZgipl/e3x/LIiR2g61iDBHFc2QF7oLyI3mfnOJMr0SHlWl3Xbu9
         +b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821364; x=1759426164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyCKgWtQwcGiOpMFoEKR3neFUGnY7KbKUl9IgIuxfzM=;
        b=WkAdJRj22zyZpYqWtuu6Vd0nHYuChrriSIIB1RGFy8dyUc5HDfR77Aryh7zCHhw4va
         pNN5FGsqHv5oD/FLig5KMdmTIEpi5egwZshYqAashT+wYeZpvL19dNEjsyZO8rT+JCDx
         e2ind8OqszgA1wC7/9W0GrhfL5CtWccCx+rItYsLJmUiPYDTHEPMNsb16anvmHFh6QuQ
         ePIPvnHNQq72nUFQm4p9p1sRFSeQ+KtAHpmUraU7w+15DgjjWII/hs1QyWdDOTTjANCI
         1+6z5YRQRj6WsNho4lpXLJMhSRXVypp7bKmtaNak+93q7toPefDww9c1Mc0Y/6r9+GOy
         wGSg==
X-Gm-Message-State: AOJu0YxFdoKc0KFdNne4/frH3bZf5ZdrlXiyB3mkK4OQa5ACZm0vh2zD
	JkFH7Tl+GW1Ip/Oj1wo+O7XGLCn3/4Wv1xf0WopoWGw2YTSMH3n1GQfMn4MwFWqZFnkxetDNPS9
	kRUoxjdpaOuL4npuy3HfRy5yEkipPLSP9n8DlRzSpuEQehCujtBaMMoTpQjX5FEThjjdmpXvHQN
	f9hCgOSa/tmFJ0D9/uOdgll4v5NUynckAt2Mti5hfqI2Q=
X-Google-Smtp-Source: AGHT+IGtkbqPWYz7tRWeWPbzX217uH2zZdaR1bIpo6u/9uGJ75IYJo3XP4QrWpILMFrCsKY1/OpEkVcpXw==
X-Received: from pjbon17.prod.google.com ([2002:a17:90b:1d11:b0:32e:e06a:4668])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e05:b0:330:6d2f:1b53
 with SMTP id 98e67ed59e1d1-3342a2e3f06mr4714551a91.35.1758821363780; Thu, 25
 Sep 2025 10:29:23 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:43 -0700
In-Reply-To: <20250925172851.606193-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-16-sagis@google.com>
Subject: [PATCH v11 15/21] KVM: selftests: Setup memory regions for TDX on vm creation
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Guest registers are inaccessible to kvm for TDX VMs. In order to set
register values for TDX we use a special boot code which loads the
register values from memory and write them into the appropriate
registers.

This patch sets up the memory regions used for the boot code and the
boot parameters for TDX.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b4c8702ba4bd..d8a944b5ada3 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2018, Google LLC.
  */
+#include "tdx/tdx_util.h"
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
@@ -465,7 +466,7 @@ void kvm_set_files_rlimit(uint32_t nr_vcpus)
 static bool is_guest_memfd_required(struct vm_shape shape)
 {
 #ifdef __x86_64__
-	return shape.type == KVM_X86_SNP_VM;
+	return (shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM);
 #else
 	return false;
 #endif
@@ -499,6 +500,12 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 	for (i = 0; i < NR_MEM_REGIONS; i++)
 		vm->memslots[i] = 0;
 
+	if (is_tdx_vm(vm)) {
+		/* Setup additional mem regions for TDX. */
+		vm_tdx_setup_boot_code_region(vm);
+		vm_tdx_setup_boot_parameters_region(vm, nr_runnable_vcpus);
+	}
+
 	kvm_vm_elf_load(vm, program_invocation_name);
 
 	/*
-- 
2.51.0.536.g15c5d4f767-goog


