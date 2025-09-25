Return-Path: <linux-kselftest+bounces-42381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA65BA0DF1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878381C21BC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E8231E8BE;
	Thu, 25 Sep 2025 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVnR4uT8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0717031D365
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821365; cv=none; b=sVpk0ECK1ftieLKUWeXCgnex3sPviLBBilTmKMLyGOjkb0VBlSkNwajU1pOm/QrVB7R0RP8Y/y7ObO+TJl6zuaMJhVb5Yz7eaz2m6vY+WWWFW7Uj+4OL81tiqMYr8+WhgDYQiKg/YtQ3uIXPAA6lbp0gH+RWvKV4M3HEspf7n4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821365; c=relaxed/simple;
	bh=zHc45FNunudgpxBR4JWuEiZa0w9yuYjewmkAKB9HjsY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q59HQXFgt/UyepdyPKoyVvFpcteHPZQtrdORo/c4pfbS+rVEriegllsRF0rW6k31jRUY99fjHe90+qvhq+MpOEtoqwslIKCkH5By4aNEKPxI9LX29ZAEJ/MSFr5ae8H77FDWrq2JiFKWZ5IbNL3l/4j2Mo5BhCjiWADqwQwdB3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVnR4uT8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-330a4d5c4efso1256381a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821362; x=1759426162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cDfoEeJQNzVJqyItlC9ynzGaEr3okFQ1wEjDJ/9WZc=;
        b=FVnR4uT8FWWcn7eZ6eEsRPeYqtWpdH1gzgaA3ex1yC0Nt9Q0xdTL6XFkdwoVs5brMG
         oneohsu3L8tz50JWFpGCYrdA2qf+ODixy+rm4sjt++4dHOKqt+5IFIGcNWO4V1sull9f
         cpCKhujK8GuqLKyO+rUMvmyULwkfRNOeXR9n7H6j09wyA2s0Vs+PKQfqdIUmU0g8le+Z
         uo9p3akKLtqMZsRHGkS2OjvrTbS/HDqkSZT4GQ/RATwyObGg3o+nNWnJ+MXZE58J8oZT
         NAUwBT1GMBLlIyQnVPVm535TVSuzeTLr9Bx4XgA0z0NBMj2NeIqpuX3InWPA+skTdUFV
         OilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821362; x=1759426162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cDfoEeJQNzVJqyItlC9ynzGaEr3okFQ1wEjDJ/9WZc=;
        b=alt9/ghu1BTLr/HAH6avULvzsbt/8KJFx69nobIL+ELWqEwgnDU8NDPt2LoaZztGib
         ZgfUWX14bj3wsLcIZQ7Xi7ElOG3cSmbZ1HZ0MPAQkTuhvKylWh4N2s8w0SKk2xJCn2Is
         C1twSjAzaxtFc88IlpNcumK79G97ba3hZV2S2QiKrpa+T74qucJGj1H2PH3NlVFWFMxf
         IRkSVTobarvVkBnA+Kr0hpkC+IrDyCtQOgs29xLipVFy8IQ8Lo9DxK1Ck1O9DddZSKlO
         me6IzPRp3O4dUjBt0TPoi/dpqeavJS12pAPXAfBcbH7GBlzuDzrp7I0dS+GLDCRwhBfv
         IRJg==
X-Gm-Message-State: AOJu0YxIZWXylLrSh3Q48Wc7ujb9ebT4Z57pwuySW5ME0xuRiSlvN75a
	O3Q1Zh5HvmiphPmawxvq81xyUcf7Zb4F0U8b75/DVXRNVhkU+qb8qGTSEjDBffFoWTqfVwPRC90
	CbNlgqS2bomzDhQmNlQM7Rx8fkofk0UkYWMLXd+N2oGwzxkaLYHr16c2W9YAomOBoTjE56P4sqC
	IqDhq5b0LN0yOqNdPkBSBzNj4xdt1uSz8FJS8/Xhh52/4=
X-Google-Smtp-Source: AGHT+IFiX5yq/423ZwdRIOB/VoKEpIBcTMitBDLAXUyebQio6K4Ks9LdhVWtAAfHLvX8WQ69wO2GK0ei+Q==
X-Received: from pjbqo15.prod.google.com ([2002:a17:90b:3dcf:b0:332:a4e1:42ec])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a8b:b0:32e:38b0:1600
 with SMTP id 98e67ed59e1d1-3342a22d164mr4911146a91.6.1758821362103; Thu, 25
 Sep 2025 10:29:22 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:42 -0700
In-Reply-To: <20250925172851.606193-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-15-sagis@google.com>
Subject: [PATCH v11 14/21] KVM: selftests: Call TDX init when creating a new
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

At this point we can also set the common boot parameters such as CR3,
CR4, etc. These parameters will get copied to the relevant registers by
the TD boot code trampoline.

Signed-off-by: Sagi Shahar <sagis@google.com>

---------------------------------------------

Changes from v10:
 * The call to vm_tdx_load_common_boot_parameters() was accidently
   dropped as part of the refactor from v9 to v10. I re-added it here.
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 623168ea9a44..63b751253d1b 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -641,6 +641,11 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
 	}
 
+	if (is_tdx_vm(vm)) {
+		vm_tdx_init_vm(vm, 0);
+		vm_tdx_load_common_boot_parameters(vm);
+	}
+
 	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
 	TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ did not provide a valid TSC frequency.");
 	guest_tsc_khz = r;
-- 
2.51.0.536.g15c5d4f767-goog


