Return-Path: <linux-kselftest+bounces-40743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C897B43316
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 08:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E561C25A63
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 06:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F4929B8EF;
	Thu,  4 Sep 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qoK4JPIR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F829AB13
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968926; cv=none; b=JkUOjniqBww9WoXy8qoWUU2oj5aeeJGRtWnj9X6Zcvpwcd+tZFDZpKVZ0Y2SgCsUvpOxyAzg5lIuQJngv0WpKRAEx0dMmCuVDyCToe4bhxskGa1QbY4JmH3ODKnUIsFZsCWtvyXTJiWIiLsWyYWtnFgt/DcOhM9mvDogemck1TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968926; c=relaxed/simple;
	bh=kdmXN70NkCarKlPiM7rjh7lKLuyNoeGTY57Ar9pmI1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r59OcCecozr3rNc91tULyRU1cdomlIggSs3DaQyQHQKmlWJ7AWbBtH6cTxTTZRY+oshn/TMP98A/KWRH9F5m1Hdzo5w9JGLFEaeNfS7L34COXhQ5HK2Np8T24csN5SkhhnV8qvlAjwRg9QyNSFfCExQ+WPDQ+iSuG6WU0sw5jZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qoK4JPIR; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47174c65b0so875686a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 23:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968925; x=1757573725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YqMpdEsUV2fviIjFSLurfARDNWwMLyzNa0D38zVRRV4=;
        b=qoK4JPIRmt+yEJTtCID6upCsj+6gteBnzv5982fRGZWZciObsPEMGDjHKZZMjleJwz
         2XDhzB46v5sTRr9CFI8G1cLUNM2Q3o/LsPooOU08fg2jrfqyPQUSj+0ndg5Tet5UnS+S
         U/HsSY1znopfz2bRp5kkNepVAD2t9l/oXw9pJekREmIqfbIN+rV6Ubvx8lkg8+MMLjt/
         AOu/Po2ZfMvIV/JWUTfiujFDESYO5uTCsGqLDdwyaCNjgznUOgba6S5sjmatqoET31Qx
         rpjkHiEgQwrPGl7ZZwNUY6nTJyUcswpjKdM9TJDlMPB8On9WfptdTyWUiT8PdVO2R0VU
         LXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968925; x=1757573725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqMpdEsUV2fviIjFSLurfARDNWwMLyzNa0D38zVRRV4=;
        b=mBlrQdNxTj+Ma+Telcr/qoxdW6WT+ebT99RrL18OBO/HeUTp4DBGS1bNA9PxMGg5vo
         kzjiP1ytHJEBI9wtVk0mG9ogl4CArXDL4Q2OM9+4eucjvbisljX+sND6t1d2pmly4zzp
         Lab65zDf/0BcirCtowq2D5RBXRetLXMCeWYsOkKis3NDXwAguAiO+agb/drtpSMK28Qq
         kkuEzatmONQ13PDJ7KsYMEqNE+d8AgLF9QgfgJ7aLKcTlJk53z2IAp2OUp99qxeBJyw2
         x+2F4gWxTtM5TEuCF/QHtNR1CsduIFsFlXsKhwIiRXk65ogNJFnfXc7+Mn14ZIbGFI5/
         +7KA==
X-Gm-Message-State: AOJu0YxxnY9haXpR3v7w4InzDBhjeHqmGRGmM+0Ttt7n0W7RNmWiDobV
	Tk4YjDDg6yMFoxVNhIU5HRAdUKkSyYv22U7bUOXuCeS+vSHzVomr1MyuazN+xBgFUW+L0bsOyT4
	sNWsIeSqZIg+o8m8I8ij3VRbPddv8OK0Rr68/LKZkQKx422WFInB2X8+I39ptIMScRpRe0NFA2v
	yF+qIHR7eEsbOkTkKJYOlA2tyJzQKW5sWW9kncxxyaSxE=
X-Google-Smtp-Source: AGHT+IHU8aE69lKsl42MpOIXvrUGk5nPmd3Q6iw3H5xSke4+EKRTEKinRjrjK+lfCvuFoVBO6ts+bPx8dA==
X-Received: from pfch21.prod.google.com ([2002:a05:6a00:1715:b0:76e:396a:e2dd])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9997:b0:243:c76d:ac8c
 with SMTP id adf61e73a8af0-243d6f051cdmr28758575637.32.1756968924573; Wed, 03
 Sep 2025 23:55:24 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:44 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-15-sagis@google.com>
Subject: [PATCH v10 14/21] KVM: selftests: Call TDX init when creating a new
 TDX vm
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

TDX VMs need to issue the KVM_TDX_INIT_VM ioctl after VM creation to
initialize the TD. This ioctl also sets the cpuids and attributes for
the VM.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 623168ea9a44..c255fe1951be 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -641,6 +641,9 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
 	}
 
+	if (is_tdx_vm(vm))
+		vm_tdx_init_vm(vm, 0);
+
 	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
 	TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ did not provide a valid TSC frequency.");
 	guest_tsc_khz = r;
-- 
2.51.0.338.gd7d06c2dae-goog


