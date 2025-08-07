Return-Path: <linux-kselftest+bounces-38525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495C8B1DE2B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BF51624E0
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF8D273D6E;
	Thu,  7 Aug 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FCepqIPc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF6283FDE
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597845; cv=none; b=YFrk3l1m1FiSF2sl2gUoIMZfQWf2dn5f4ZTL7elDHVVL57uWe2E3NblSVd+BP/I4uYn6yPuOymG9fHuCNpDGuSo86+UHhIqO8CTpEfB43NKmUOVLxOYcKKclCEODZKKEo1Gu1Lgr+bqfx21JSovu/ifa8kYyoNQDJHYd9xnsDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597845; c=relaxed/simple;
	bh=KtQGB5hdsruK0bKKPNTRCRaeujSBA7S7BYfY9UZQvic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h2HmIQUZDHsv6COIp3UarpeFIl4Z8zLOCKch0QYdfAw7BPlAEZ4onr4yB3+aHjQMJiUm5Ee6Rbp0dr3MWYjWg2Uy3TAAzaWuvV94Kh3z5G+rg9FbAu95iGCo7Lt/o/H3mcJMK9o/l/li60PASmDyLDKYn7cy+anaGnwNn+CBbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FCepqIPc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f74a64da9so1615640a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597843; x=1755202643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M0suFohlUZGBEGCM79JG64gwQy4zWTa1/ANBR7d4wLU=;
        b=FCepqIPcGNmF3uU3qppEbg4klpL8ohYpCI1WJO/JX2W5YiHg7CM96fsTWjUj0VfaKQ
         I9K2XLSIReZn3cvb/0EIFUewrAavZmZR3RYWJiKnUVtNoj8J6b+M36TLgy3VM5Wyqvn6
         WHdYfwOqh3GnIcHDrxhJNDW4N+J9kjPNzlN7dQV23lc0UuISzMsEFDrG2TjYiDxyfcMC
         MrJ/2T+WGxJ4xNdUjsTR5gr/05VFtUqHtMhXmnpK+I/GA/nAjFAk4tRtg3QZTjB/QbOI
         c8KseObeJjLsp+PmLOncrQ8q4n6T3n1lzbk+yfFTjnR/7QLjUQrhGpCX8yrkN4fhXOXV
         7Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597843; x=1755202643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0suFohlUZGBEGCM79JG64gwQy4zWTa1/ANBR7d4wLU=;
        b=grFmEqe4/XD6sTZC+jgWqdWm12Kw9tOCPZgd+h+yHFPzomjtaU2dITWmpEGuRVyflX
         EPTqick9Ybpu4znWFR3NcmzA6aOnDAO0h22bOdHTiSWtMeqF6HxdcsYYN1ba4kcXPSta
         Dyk+SOby8QqJEOSvFp8Dpn7t/4cygmI2ZAHw/kuMA0LUP/yjU1+CIFxrgB3ycukKI3XX
         agLkESveFshZEwYzTMrPRA+2XQ+YbPrYNDa6F3xt+2+gsv7ilmdyPpbrmr2A17rVVIlk
         Au+py0GgvVDPy4v2UWhDB30C0i4K1if8c7PzS09K62zKbpDeve3I6E0ISPQGB0ZgD/5C
         W9Rw==
X-Gm-Message-State: AOJu0YyzvCw38Dl/yGYo7fBARRsDb+QizMU3K2SPxsrrAKG+qd6/pxP9
	CiGUCDhnZu8uzTqHM/vt92tBQgbBpSsCy0PRsnL/REgHtOMdh267LhrcNRumTFFeZgy6HUGTHYz
	heS504sXUrOQgOVlBA3F++9wdmj1DMC38rGX4+FeMpQs6IEq6kXnoE2VHuOwT/CRSOhEncSjmXB
	pHjx8UkF8OjVpuWsTW49q15oHmuZo85+Bc1qoZxUX/JXY=
X-Google-Smtp-Source: AGHT+IGuwnBgHT00Pa47b7PWARfkX6jqZRvjGaZTcLQlg02HegQiirvTj6AbnOkdTgp8ehpde97Ui17D4A==
X-Received: from pjv4.prod.google.com ([2002:a17:90b:5644:b0:313:245:8921])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c5:b0:31a:ab75:6e45
 with SMTP id 98e67ed59e1d1-32183c42d6dmr441878a91.28.1754597843391; Thu, 07
 Aug 2025 13:17:23 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:26 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-31-sagis@google.com>
Subject: [PATCH v8 30/30] KVM: selftests: TDX: Test LOG_DIRTY_PAGES flag to a
 non-GUEST_MEMFD memslot
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
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Yan Zhao <yan.y.zhao@intel.com>

Add a selftest to verify that adding flag KVM_MEM_LOG_DIRTY_PAGES to a
!KVM_MEM_GUEST_MEMFD memslot does not produce host errors in TDX.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 45 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index 82acc17a66ab..410d814dd39a 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -1167,6 +1167,47 @@ void verify_tdcall_vp_info(void)
 	printf("\t ... PASSED\n");
 }
 
+#define TDX_LOG_DIRTY_PAGES_FLAG_TEST_GPA (0xc0000000)
+#define TDX_LOG_DIRTY_PAGES_FLAG_TEST_GVA_SHARED (0x90000000)
+#define TDX_LOG_DIRTY_PAGES_FLAG_REGION_SLOT 10
+#define TDX_LOG_DIRTY_PAGES_FLAG_REGION_NR_PAGES (0x1000 / getpagesize())
+
+void guest_code_log_dirty_flag(void)
+{
+	memset((void *)TDX_LOG_DIRTY_PAGES_FLAG_TEST_GVA_SHARED, 1, 8);
+	tdx_test_success();
+}
+
+/*
+ * Verify adding flag KVM_MEM_LOG_DIRTY_PAGES to a !KVM_MEM_GUEST_MEMFD memslot
+ * in a TD does not produce host errors.
+ */
+void verify_log_dirty_pages_flag_on_non_gmemfd_slot(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_code_log_dirty_flag);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    TDX_LOG_DIRTY_PAGES_FLAG_TEST_GPA,
+				    TDX_LOG_DIRTY_PAGES_FLAG_REGION_SLOT,
+				    TDX_LOG_DIRTY_PAGES_FLAG_REGION_NR_PAGES,
+				    KVM_MEM_LOG_DIRTY_PAGES);
+	virt_map_shared(vm, TDX_LOG_DIRTY_PAGES_FLAG_TEST_GVA_SHARED,
+			(uint64_t)TDX_LOG_DIRTY_PAGES_FLAG_TEST_GPA,
+			TDX_LOG_DIRTY_PAGES_FLAG_REGION_NR_PAGES);
+	td_finalize(vm);
+
+	printf("Verifying Log dirty flag:\n");
+	vcpu_run(vcpu);
+	tdx_test_assert_success(vcpu);
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
@@ -1174,7 +1215,7 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(15);
+	ksft_set_plan(16);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
 	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
@@ -1205,6 +1246,8 @@ int main(int argc, char **argv)
 			 "verify_host_reading_private_mem\n");
 	ksft_test_result(!run_in_new_process(&verify_tdcall_vp_info),
 			 "verify_tdcall_vp_info\n");
+	ksft_test_result(!run_in_new_process(&verify_log_dirty_pages_flag_on_non_gmemfd_slot),
+			 "verify_log_dirty_pages_flag_on_non_gmemfd_slot\n");
 
 	ksft_finished();
 	return 0;
-- 
2.51.0.rc0.155.g4a0f42376b-goog


