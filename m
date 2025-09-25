Return-Path: <linux-kselftest+bounces-42379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2A6BA0DE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CDE6C143D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E875631D72D;
	Thu, 25 Sep 2025 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phqyScAG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01538313286
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821361; cv=none; b=M4BVyUwsfUXVVgx5IjxSStan0kaDztzGotpB4IBG6CADvFLu1+S99Jdb+bWOjeahqvJsEpoB0+ljMCJZpGqVPI40yMGbKHoeIslCOuL2BZ+E17X/9EViIci1savOtyUAYCNE3quHWC3ndD1ZNhoFwKR4wti7XRBp67exEHxBB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821361; c=relaxed/simple;
	bh=kyNUo03VHcUtqgem5Ure2zDndq9TR63HAvb7v0MESQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uz1M2Cyc93/gV8ZtJhsahfQFFcmR772TghLSH59fx+KrZX0ABSz6cIOJKxi8l9kbVZ4Pr59uUsfCuryeZ8dA5fWSSvbl9O/HhX3/glb3GYy6oJSzcRl4/2X7rT7oYkw+jsjK6NpN1LP1OksDdnxN6oZuWBjJSP8IA+B6KtdoBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phqyScAG; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso824958b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 10:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821359; x=1759426159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MAW67C+26Du9WD+afvdTUdsrfWFPaXzJwetR1H+pT8=;
        b=phqyScAGkUBL9wXzNie4OEXIrmTcV42jIoB6IEB0Sq1H+T0wUvuThPoMB6GJYM5Tab
         x+dvPcOT7vIGFdraHA2cylqsnLeCORas9YDvcC57qDiSVl/WXRFfky5yup6rT4vAmuzD
         u23tLucbiGZQKi9e+eDw2tjKh1BCzxHU754xw6Fr9Cmv20LAFlMCh76mu+VxA30USd4n
         PXx1PtblsY2rHhVGKkjRUyf7w81o9/j05AWMXQZltuxd65DuJQ8z/aG27SLBVA0zgMSx
         Mizz/VALe6ZbjB1WxImhRP8QJ/E3J0ay86Indn/NGTov7RgoSi9UgNdWe6jELyRY0yXu
         cHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821359; x=1759426159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MAW67C+26Du9WD+afvdTUdsrfWFPaXzJwetR1H+pT8=;
        b=woogqHHl6U23MtuYdsAT8iRR651MV+lGQ1o6r5vIldFywgpB4kuyJajwaEi13oA79h
         1eCqkrv2frh0PQSooz05TWuA8caaM3keDlnx5E8mLd3CS05viliwkMQVjr3cl69KQcVQ
         bzTsdw0NlSaP9tvzB+j940z7OsJYYO8ZZ0p2wfCr+86CT9+tptn9V6ZOUBEkj51vBpkd
         d+EJDgefdqwZ4WUprxrZyP+uOL3gd7gf7SpXFrfM57knjeWDvJLKSEBqfPYL5d+gMGDX
         L2oiRqtLIKbW3iDepQdI25gSNcFB5SBogSvnOUsx3AVgMHQiDjySX2pcdQM8kou7RQPs
         9WhQ==
X-Gm-Message-State: AOJu0YzAB+93leMfytmxx9kENIdCiTvYJDkRkkbN7GgA8NybroJjekyU
	/w6srGOGFS9jM7I3u0iyUd4qth5rEDQ6jtneVQibpxE40gaj9Rl9joK246Cm8Xyu3OPPUcUBYwu
	Q/p3c25cwWxxziWSQholGTTVvhKej6CbbsUjsF2Q6MeYAGPFOiFrmwYrTDWSeJoztFmVYovi3e/
	0RiYQJ99KYxZbrMN4KALCg/AEvefIEzws6ywFpDUF5NBs=
X-Google-Smtp-Source: AGHT+IGwUeh3R66fQdhA9+GehJSHKHpxVELu+AiwXNl9uAO8pVVzXP1LD+WHAVUHsIgABaveFX8UT5GZaw==
X-Received: from pfbk26.prod.google.com ([2002:a05:6a00:b01a:b0:77f:5efe:2d71])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8895:0:b0:77f:449f:66b0
 with SMTP id d2e1a72fcca58-780fcee0494mr5488295b3a.32.1758821359006; Thu, 25
 Sep 2025 10:29:19 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:40 -0700
In-Reply-To: <20250925172851.606193-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-13-sagis@google.com>
Subject: [PATCH v11 12/21] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
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
2.51.0.536.g15c5d4f767-goog


