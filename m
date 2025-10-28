Return-Path: <linux-kselftest+bounces-44216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8623C16F01
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE879189094A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2333557EB;
	Tue, 28 Oct 2025 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BT0Vg4bY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07A354AE4
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686463; cv=none; b=Ukh/CUGuYLS2vt+abVd7UGEJ6N19LuNM/Uac+kCyAZSIpuOTpjpKoxPU+L7K7WRmWV6erPrdGBE8WnafXpXGldAApfO7iMuvL8duKy6QweUf6Q5mq2yCQ6B1a8h8dw1LfwmJkLYYvxAqrk6tg6Ivh+tULmWIdv6Zn2UJA3I6p74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686463; c=relaxed/simple;
	bh=EJICXa/yniV4LFyjrDgYiN24uZol6pdpsvo9d5t1gtc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o1/n8GNJTFNeJbFS61kwLrx0HMlEokJzpWwx6ygAhcrB/cmZ3dvmrF8bATLmWVwPAK07qJ5sLBs3QUP92yoGxyOqa9W1YRNlwSYHbvL0M4v+zc8KH+EFJiLhl3ziujWu89tZiSp0vcmqnylKHq7fOS6xr/t+TEFFD3nT71nrpss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BT0Vg4bY; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-940d88b8c15so616313239f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686460; x=1762291260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJrNVIag5TCnvbKa/N0Y0euKb8NaHrULGif/OSObmig=;
        b=BT0Vg4bYZGBWSXHbuFwcZrV5ooC2CsTLeLzwo4/ZIVK2xd5bfLJGgGYuVaX3YFb4FW
         ULVOH3AgT0Gor0JOZm1BUhnEBxWofes7wVJ59DbEsN781F5hxiqFiWvTz01oDVwF7WTv
         B87lgLT0sLJ2WgMJtcslKrpZkVl5cQkcY8SfvmK4aihsaL9OoCYbyfSRjn/xmqsAE1JU
         gp7ysGgVuAyiueUQ9gWOLhP4x0eE4QWoBIEjAqh5BdoaMiMMPujUIJ7MTBtAT0aOAqub
         /ruuRMzbZTeUJ99EHqmpgGWEtDZRXArXkICAl+ekEo7Uo42oKHAp4ZCN/IVWFc9oxtGO
         LCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686460; x=1762291260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJrNVIag5TCnvbKa/N0Y0euKb8NaHrULGif/OSObmig=;
        b=ih8L9ju/8cZtvXdIauGfniG5L5+3uG6ZmUEPynvymeGuwRYsGqJytwDF98U7OZZsCf
         wP7/meIEayVjaroexwsdISWpxSjhC2zOAIALAgbbmJBhVCmG+Pr4rSl5cOLEgjNYUCuW
         J1qHmfCNfh4pugvzmIz7r+sxAjldKAt7tajNzP/UwmYfwfiQ4Ek/xpbFXaRAJGiFLiME
         GRzG1+0HhJvAhlyGi+92LQh9WxwgUWO23+YjDTCEJdhCq/6QLUsl55zsF+M59i6Vo/rg
         Vjz3xHCVSg3cgqCLJlGu7iIHwMQdhYFi2CbMyoBXBacfzVEjxP49C7G5F0eAtDJmMUer
         vicg==
X-Gm-Message-State: AOJu0YwcSTLiND5J7O51RzkRZnnTW0d6BoTjNGQ03X3pe2o3ni500RSF
	MJsJ795aZiLoWCGHr4UnCNoF61A71LTVv5sK89Y3PV4hzFyubPX+FLB2ZSfgWFWWoBfXBo2gska
	GSn3u//DPMnNVV1pcXKu17nU02Lr6ryQG8BklC8rJmf72SEHtaKYu9/BS3p/F8fVJuqKx75/jld
	v3QQIKTeYLYeRXHBm0YLyamZsly2pGmvLlSE2KCd5w6vE=
X-Google-Smtp-Source: AGHT+IEFDrPZWGFBr5+mejr0DLlrxzW412Y0+IuWkkXjbawypFaXM37gBgvb80RrvB50OENuGh7DZHijvw==
X-Received: from iobid12.prod.google.com ([2002:a05:6602:6a8c:b0:944:5708:3425])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:3fcd:b0:945:a7ce:646c
 with SMTP id ca18e2360f4ac-945c97ea328mr148145439f.10.1761686460371; Tue, 28
 Oct 2025 14:21:00 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:31 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-6-sagis@google.com>
Subject: [PATCH v12 05/23] KVM: selftests: Update kvm_init_vm_address_properties()
 for TDX
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
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Isaku Yamahata <isaku.yamahata@intel.com>

Let kvm_init_vm_address_properties() initialize vm->arch.{s_bit, tag_mask}
similar to SEV.

TDX sets the shared bit based on the guest physical address width and
currently supports 48 and 52 widths.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h       | 14 ++++++++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c    | 12 ++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
new file mode 100644
index 000000000000..286d5e3c24b1
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_TDX_TDX_UTIL_H
+#define SELFTESTS_TDX_TDX_UTIL_H
+
+#include <stdbool.h>
+
+#include "kvm_util.h"
+
+static inline bool is_tdx_vm(struct kvm_vm *vm)
+{
+	return vm->type == KVM_X86_TDX_VM;
+}
+
+#endif // SELFTESTS_TDX_TDX_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 2898fe4f6de4..519d60a3827c 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -9,6 +9,7 @@
 #include "pmu.h"
 #include "processor.h"
 #include "sev.h"
+#include "tdx/tdx_util.h"
 
 #ifndef NUM_INTERRUPTS
 #define NUM_INTERRUPTS 256
@@ -1195,12 +1196,19 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 
 void kvm_init_vm_address_properties(struct kvm_vm *vm)
 {
+	uint32_t gpa_bits = kvm_cpu_property(X86_PROPERTY_GUEST_MAX_PHY_ADDR);
+
+	vm->arch.sev_fd = -1;
+
 	if (is_sev_vm(vm)) {
 		vm->arch.sev_fd = open_sev_dev_path_or_exit();
 		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
 		vm->gpa_tag_mask = vm->arch.c_bit;
-	} else {
-		vm->arch.sev_fd = -1;
+	} else if (is_tdx_vm(vm)) {
+		TEST_ASSERT(gpa_bits == 48 || gpa_bits == 52,
+			    "TDX: bad X86_PROPERTY_GUEST_MAX_PHY_ADDR value: %u", gpa_bits);
+		vm->arch.s_bit = BIT_ULL(gpa_bits - 1);
+		vm->gpa_tag_mask = vm->arch.s_bit;
 	}
 }
 
-- 
2.51.1.851.g4ebd6896fd-goog


