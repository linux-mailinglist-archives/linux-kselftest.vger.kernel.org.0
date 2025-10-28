Return-Path: <linux-kselftest+bounces-44224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A69FAC16EE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FBC6355167
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B23357A50;
	Tue, 28 Oct 2025 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEpEtK42"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B65350A2F
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686471; cv=none; b=ZxoU3A593DE9X8M0T+a37we52MCJjjDb4P6j5NCQ39mCSkIzXDw1UHCPjTezL1a8WjWnMYg6/xSaK/j2OxwH8KnMpvnxYg/IZhQr9Z5nPDc+XJM39gTx9cJlOsNERNkvSFQVMrN5ta02yzfgi1Mo6pLma1jOwWuaV3mQw3vGbz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686471; c=relaxed/simple;
	bh=Beg5l5GnzctCJzgamlm3q3eIKOOQS9dc/q2TB/QjYmQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FmK0LvhPs/sxDCy/9QjvJ7TimXxOtvPsLUrMdjEzoEuRohnKtyAHUlqhtZRV7RCv5jcKrrIiil3rd3UyF8o4+MP0DUXP6I2qSdKBW0x3eTXb0lgVLt68Ye6exu1/wwrFrOUeTHhyCVokrsWPpUeRMM7dinevEDiekBX0zMLgUoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEpEtK42; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-940f5d522efso1891316339f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686468; x=1762291268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqk3ap2s1j8LuUHJMTA+8RH7bEkzoQ7jFIzEsK1w1ok=;
        b=DEpEtK42Arm29HypAab/BnkUq0Xs+bs6W3zLUJwz8FkooJI5FKswlGWpl2LQh0cZcy
         Yg4hF1Rph6E43CAZ58WMVCQ3RwOJU/qZpqP9+a3nu3+/2PLPAZ9+keDqwpPyIu0dGtKh
         +JO/RYvjQ3SIuVLYk6rlGLWtTa0rFJVsClxOskeYGwt4bjG+CgbIrzbpGhn+6MH4f25Q
         +bq/d0oVrVvafJXdSjCIJ+qurrwJFvk3o3LFOvTmuQB6uMgVmJRsLDwOgBpQcbZqlX9M
         NxyrFGFWTPeUZif27tzpNGNbb5SveymPo9saH/+ZThvJDExbOQ7rbZhFYrWUBWtQtbBn
         oA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686468; x=1762291268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqk3ap2s1j8LuUHJMTA+8RH7bEkzoQ7jFIzEsK1w1ok=;
        b=WKyw5EORBqHkFgRzQ5pHnf/CLSLmWFZvtuJEbyd8YVK8j9UYIX8FKprzBDp8QqZHx8
         6xnPCNr4xB6ndS+87Xc724CZrqR/hZuF051FgVbCc0NXNYo3REU28/FLTX7GUyfly+y5
         LbHVRaRmEX56gJ7nUOqea7qSyYo5G8Zpxko4wr3RDcRvuLViPCwdaFAIOB7hDzynFE61
         uZcBUbSWM77bBhD9QyVmQTok/2sHSQiP04W7L6HLvE53Z76Vh4QDjZTywBXOwh2noSDb
         zvtnJEJaT45CUqO6SK8B3bYdSwCv/D2IKbpGJsCZ+dXGsRv6rXfZCy12ov7J46I4su/J
         ryIA==
X-Gm-Message-State: AOJu0YwnmsZjlBvyfaczrVVf8rkazzOlRwUxTb2rCK5ggdoiW1sdbZda
	asLOFSzxwDpyyVV2z+K09K/r7sCIWTcCgVHBSRqY6YtkgYpr+bYHeQkATvKVmbcDUjaudWLhyPd
	MHDwxiGgvLgh7lFciVyBCCatZEMWapVWtmwNULFcdll1AhTf6xCXFhZgACWfGzsQVAQn8EZ0liK
	jL8TXAiVKlfaAcweV2sewbwDs4sLr9G5YC+NLZIgIxPRQ=
X-Google-Smtp-Source: AGHT+IGP1JAiIsh896FE5wlZg5zutyX7tNi20B033WUKmmsMam0fKRXd2ZWfh/OEDsGDBnIKNMeiTc5PvQ==
X-Received: from iov16.prod.google.com ([2002:a05:6602:7510:b0:8d2:d755:be95])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:3f85:b0:945:a27c:ab2a
 with SMTP id ca18e2360f4ac-945c986cc06mr128542839f.13.1761686467984; Tue, 28
 Oct 2025 14:21:07 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:39 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-14-sagis@google.com>
Subject: [PATCH v12 13/23] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
 validate TDs' attribute configuration
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

Make sure that all the attributes enabled by the test are reported as
supported by the TDX module.

This also exercises the KVM_TDX_CAPABILITIES ioctl.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 7a622b4810b1..2551b3eac8f8 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -231,6 +231,18 @@ static void vm_tdx_filter_cpuid(struct kvm_vm *vm,
 	free(tdx_cap);
 }
 
+static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attributes)
+{
+	struct kvm_tdx_capabilities *tdx_cap;
+
+	tdx_cap = tdx_read_capabilities(vm);
+
+	/* Make sure all the attributes are reported as supported */
+	TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes);
+
+	free(tdx_cap);
+}
+
 void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
 {
 	struct kvm_tdx_init_vm *init_vm;
@@ -250,6 +262,8 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
 	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
 	free(cpuid);
 
+	tdx_check_attributes(vm, attributes);
+
 	init_vm->attributes = attributes;
 
 	vm_tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
-- 
2.51.1.851.g4ebd6896fd-goog


