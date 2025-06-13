Return-Path: <linux-kselftest+bounces-34956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1242BAD955D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 660B77B1E4F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF8E24DD16;
	Fri, 13 Jun 2025 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yCRHOpyD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F224C08D
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842096; cv=none; b=GVJzdIQHPM4mKUJwg16gcXG7OCir2GSKybFksIJxladEohnrj6O0NBT7vorT54pQ5Fi7TX54PqAU9Czu2mbpsmYfOSNqborCsUL2vrdU1zAHWTL9zAq8xfozuO8boDgyYvhpz//TaRuwaQBBzq+l982u+UMPfop2BYbOyQll6nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842096; c=relaxed/simple;
	bh=hUSC6q/u5XglC1U4gOPTanfZQQlW+0KgRtgJCMI3QJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oupVJLKaHmV1akNsTXfY4yUqTo8fqWVA3DjnHz5xBaC1wQOFPTTiUAvCTTewOtjkyHuLc3ILhzWC61G6W0hFc4swrauIA+ph97Htl1ikw89jER5Pyl1Zpc9CevIRIAb/jcmWf2vDWYUKGu9fzyeOoAHpiDuFWPSMt8x9kxC8eUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yCRHOpyD; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74858256d38so1851880b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842093; x=1750446893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wkd+oSBsV61vY+nLf2ZlPchh7IouawdO+jqDmSL0Z5Y=;
        b=yCRHOpyDzyRwIjRhnCofAUxGE1oJK8bjkFT8YmgaeiiU2f1aw4ZYywts/vQLKS7cwu
         +w38BhgA7BiILlyk4+DFo0JmeiIbE0RqjGq3YpJDCS6H3y91HU1D4PY/eoFRc63N4WmW
         FCJbUw+8cRSh7KrUAqu7Nid2aTBwN8zo1vHGR/r/TrdIkFUUA/2B5woYilOPiw2DJTmJ
         1MDWAN8ExnFvidDL27eBBgh9tY21I6NiG1zK307eJNl01E96eWxggtcy4sW1ehFhDZ5C
         UdncJwQC0dVg3hvf42MncLA4ug9jXhRamUHVVX/xDG6XozCJsvwaZLcT4MVQ+fCcJQn3
         AXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842093; x=1750446893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wkd+oSBsV61vY+nLf2ZlPchh7IouawdO+jqDmSL0Z5Y=;
        b=oeBEgnrIo0ad+U8NfCujKF7rRUf8iob2vvyGcJyLB3FYGRFuamaAmNkK9DXfnezRKq
         +rpzNLJ4mgd5zWTV2nyez0CyHMxCFAxvH0x9bk7tBcTY1vL6gL928lDr6G6PR8q4KJga
         LYipcxAAKtVeWjduTBFUSJXx2+QJjQW7hSDidmTLRDn4mzTAS7esXCponN3VpTboUW6u
         NDgEiRGThgbV5GlWHgMVuH7Mxs6Z3zzcQraOJU9VbpMdmFfzatFTsyXaqTfiIpfcD43S
         5UlWEEA7tvyWxNT34bSFvdHHk1n9g2WqfR2uLiIcCZq6ajGY4ZqHzTwbiTLehlxj2FdV
         R86A==
X-Gm-Message-State: AOJu0YywoS2DVGDkZ6HoNEaaDwMsPRU+6yMgFQaKoiWkpeiLfKn7VBqI
	HQUmNjGJkqrcZdKB6h8a7YhnE2FykeNg9bOC6ukewa5c1I3FR9KKBO3GBDqXasfko3yuiSTzaa5
	Nsvkn7BGvWm25NL02j6t6IcafC1u5FDHTKP9KSmxRf/3gbzXuYEWKl80fGd5731V/gAbwKcShsJ
	EN4C/Z33IuhkKX3ebwX4EYb96g8ODyl/N3EnzyjsZGpGQ=
X-Google-Smtp-Source: AGHT+IEdGLNaT/g5MhxH3XF9cuZPDfuAeWyjHSU8EzljbNMvFxWw7iQfHx3fRbY0rVLIvruilLj4TmF/3w==
X-Received: from pfbft7.prod.google.com ([2002:a05:6a00:81c7:b0:747:7188:c30])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a86:b0:732:2923:b70f
 with SMTP id d2e1a72fcca58-7489d00631fmr571690b3a.11.1749842092790; Fri, 13
 Jun 2025 12:14:52 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:54 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-28-sagis@google.com>
Subject: [PATCH v7 27/30] KVM: selftests: TDX: Add support for TDG.VP.VEINFO.GET
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

Support TDG.VP.VEINFO.GET that the guest uses to obtain the
virtualization exception information of the recent #VE
exception.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx.h       | 21 +++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 19 +++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
index 53637159fa12..55e52ad3de55 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -7,6 +7,7 @@
 #include "kvm_util.h"
 
 #define TDG_VP_INFO 1
+#define TDG_VP_VEINFO_GET 3
 #define TDG_MEM_PAGE_ACCEPT 6
 
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
@@ -43,4 +44,24 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out);
 uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level);
 
+/*
+ * Used by the #VE exception handler to gather the #VE exception
+ * info from the TDX module. This is a software only structure
+ * and not part of the TDX module/VMM ABI.
+ *
+ * Adapted from arch/x86/include/asm/tdx.h
+ */
+struct ve_info {
+	uint64_t exit_reason;
+	uint64_t exit_qual;
+	/* Guest Linear (virtual) Address */
+	uint64_t gla;
+	/* Guest Physical Address */
+	uint64_t gpa;
+	uint32_t instr_len;
+	uint32_t instr_info;
+};
+
+uint64_t tdg_vp_veinfo_get(struct ve_info *ve);
+
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
index a51ab7511936..e42b586808a1 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -222,3 +222,22 @@ uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level)
 	return __tdx_module_call(TDG_MEM_PAGE_ACCEPT, (gpa & PAGE_MASK) | level,
 				 0, 0, 0, NULL);
 }
+
+uint64_t tdg_vp_veinfo_get(struct ve_info *ve)
+{
+	struct tdx_module_output out;
+	uint64_t ret;
+
+	memset(&out, 0, sizeof(struct tdx_module_output));
+
+	ret = __tdx_module_call(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
+
+	ve->exit_reason = out.rcx;
+	ve->exit_qual   = out.rdx;
+	ve->gla         = out.r8;
+	ve->gpa         = out.r9;
+	ve->instr_len   = out.r10 & 0xffffffff;
+	ve->instr_info  = out.r10 >> 32;
+
+	return ret;
+}
-- 
2.50.0.rc2.692.g299adb8693-goog


