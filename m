Return-Path: <linux-kselftest+bounces-30791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7733AA88E7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5FE3AF674
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D72356BA;
	Mon, 14 Apr 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yNbNQ8E9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973DE23534D
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667362; cv=none; b=Olk//SJqdwaO8Cbczh/0a2d/NL/awFdGxfC78GUPb0GZDe0BdiH0a0LmD5OJBRjPJhDS9NmOUWrnw/dLbRph4AY4Az/VWcT8rDS4KDeRAZrLJpT7++XQTL1mQbFZGTmse60YT7paJgS4WnzOXwOp4XZKfsVSgn0m3BQXLJtIabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667362; c=relaxed/simple;
	bh=Mw9ngi2WIAwJubFbLZdotPitdqMiBA16Qp2W5R8dW9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hAoXxAllxpK5RubkkkdgT4NwR98hbiYDJDAaKxoaf8ptyDpQke39Nq9JWkpyofgABpWV1RE0KER3mpwN2LMoFew6IfFlouG9gMV5tRnn8wgzbhBgJ+uPWRsrAArsffU+D4RYejx2lo9NGo9CgJbNzZYF332s1yO3imZvwUc5HCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yNbNQ8E9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-739515de999so4014494b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667360; x=1745272160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aku4Yw7zO7OsZeH36NG5KN8j8EoVwWNrgcEFNKQCwsg=;
        b=yNbNQ8E9Ns5ELqavkK0DGUHz/TZC/+rLnFthFwDx91mI7mDvs7rp+CeauQ9JECncGu
         USrEXzpIQk3mx5StbmWDAlUWXWwZTYG6x8uxD3+U7ZUcRkOwZ1Kq5XIhf47p2HAvC4JQ
         hQnKNv8rDsJSfJMiE3Qe+uYIDMIrboGjPjzSFFSd3dt13rxZhwWHLMWPTVQs0QD5/KbV
         GsSqpa68z5rzg2IbIk0/r7OHEShV0paXaIi8n1Cxr2vQrJChhrAHXASGYiHhzRQC96jJ
         W/cXfrFGPIJ2uSioUa0TH/LvQNloiaVzdCRn20lu3nd8LtNtjxgvkjufTvJZDFlJKsNk
         LG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667360; x=1745272160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aku4Yw7zO7OsZeH36NG5KN8j8EoVwWNrgcEFNKQCwsg=;
        b=pO4WuOjUR8grzmRdMQQEI4V6Lo7TCZLJ/MdsE7PZTtLiAAEKrumaTLhp5VKtd1FnKR
         UeWQOw/RPS1KcGMp/zvsDRrpK9rYp3CXzVqELAhpg07539oC1q3o170T7/K5b5oQoA89
         XJlYwJJhIamFRIzTwlGPhl4byFFW1Euzo8di2eryzZSGKD4mVxgl2dcQUSLuv0XUoTQM
         V71KKAlXdIjjBwDhsG9FFM1XvUNPbCzLZht/9Ct/r6j50NFckr6VwxpOTaVGP7sascU4
         Jxv+XlKZchVjFNx5b2/Gr2TwVoaqRSDAIekdPmjZW1lDZQY2S4T+AwGRchoYPYyjpnzF
         fOnA==
X-Gm-Message-State: AOJu0YwuxMz/1TKVqq/B7g9/E67D2Qvq5rBNIvKoww7gkg5o0U6VijxN
	0MeuQyENMfC7QjY8+5S493VtQFpyGhKmSy2EAFxDcJjPOsvXRgLwpvNLhcyK3kFZLW3BKoQFdkD
	JfJwUIEbtu69dPkyuqQXPwT8Ha+aFb9XAb48azuFcxKdT36soeW35ly2lfj+jvMYJZ+2hjMqsr4
	OBOnHPYSYxG8R8BadFLciIhwKk2UnjxgdMMDIx310=
X-Google-Smtp-Source: AGHT+IG8xqLHZi9XsMuZB46ES92EkxgWjfBuR45ihAxM020eVGrPAm5wMGqwickd0mweff3imgDYEPLx8w==
X-Received: from pfbcm26.prod.google.com ([2002:a05:6a00:339a:b0:736:8727:67fd])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1945:b0:736:b9f5:47c6
 with SMTP id d2e1a72fcca58-73bd129b42cmr18027429b3a.16.1744667359490; Mon, 14
 Apr 2025 14:49:19 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:56 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-28-sagis@google.com>
Subject: [PATCH v6 27/30] KVM: selftests: TDX: Add support for TDG.VP.VEINFO.GET
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
2.49.0.504.g3bcea36a83-goog


