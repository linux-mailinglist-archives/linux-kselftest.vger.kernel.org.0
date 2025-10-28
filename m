Return-Path: <linux-kselftest+bounces-44230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D28C16FA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D32045076D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683023596EB;
	Tue, 28 Oct 2025 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RBgOfSXk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BF2358D2B
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686476; cv=none; b=I+TDuFnqbw6a/SFJU6nuB0rwO7OrYUMUVrS6bsWQiUToKyJcgVV4kf35Eui+rYLyZw0aMQ63KOtt9V92O/FP44tE2irP5m2URcHZApv+g/L6nvs30fJxpVd3exnwVEXW5TCAJ41luDwcZqCB68T6fwMv4Sc2nSFZ958UKISR5jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686476; c=relaxed/simple;
	bh=Z4cEH/EyFJtC+7YubXLF9stWj6X2tJBOoSAojvblL2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S3k7xvBj+zaF3FVb0r9azdv0fghopwPqD8b+tPvrZm3FKK5xWqTyGy/D4HTY7SyH/DK3fajkMsF8ntp5P5cTsAuK8joW0IC3GDXB7LzVH3NaEDVnsKk9+DLx70SQGdpLyFHeYqvqA6UYFOc6P/mI1eovUOHI9s4tOeazcsWsLVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RBgOfSXk; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-44dabe580ebso856233b6e.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686473; x=1762291273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tG66zI1+tyqk2y+i/GC8wCSgfETT28ZitF9FwVU9vh4=;
        b=RBgOfSXknObZks+7DWFnq7bbTk1tHiWSXMyvz62RxHxcmGnkY/FFM7JQogFf4JVWMT
         Dy8ko3kpnLlLw0wtKv6Q/23ZqYHAmQWqE1lIddp6VZ1lzposKCEy+j/7bK352AuplSzi
         Xv5mMpOP2VnFlTIeP0H8qRQz6v0inh5NkJm9dv9Hz4hmhTMwt1cJ+Ondm7RoOyX6g+23
         qZc7SQdxuJyeYm577Ryv+cnectIa6Zu8tcT+67bQOWYU2jmuYKGplYdpfsrAf2ggp2ot
         KV3N43Npc1m5WhmCGw4XcWL6pUhqEldDPIcuWoU5AbuqPFkbHD+wOt3CgHBfxdS/PtCG
         WpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686473; x=1762291273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tG66zI1+tyqk2y+i/GC8wCSgfETT28ZitF9FwVU9vh4=;
        b=gtMrJQgom75PBFkY9CDqUd8Wxhr/oGvGFpyQ3JbUxBz+UpcJBwUcX9I6/u2PUc2sQf
         Lyua5glumFV0Qk1p/VN9Yp5GlP4CI/j3hLbukF0+8Iph1P6KARSJLLckz2j0uTS6XgM2
         7Ukdrz6uSgZLW3hC6MX+eGNmVK+9Bn4rNFPWLt0RlTJkPd4WgNXmLgVaLROgi+A1Nrf4
         q+iDVnGa7wYWhuDuMFfumBCDVjzIOYNgPifO6TRC4Tyw2zdAvBPT7clQKvTKyuk21Ef5
         g55cB5RSn9lCef9zJx5treUMz8hzmXp1FLkvGRmQ7THJS94U+DtZDPGNO+eKrijzBtzn
         HNQw==
X-Gm-Message-State: AOJu0YzWGRg8EzT3scQ1QrxB8Mc/oC3LIWgsuecZ8M2jpdclW7NNz/Cs
	54zv71i9OOrKuar3v6Dh/B9OnorKL6S5g/eaTLyM9gt0LyPnh8aCENsTqJUWrSr3X66IhR2Pxw1
	L1VdRR8zMiHq55O9AYxmpwd3b5W/Jfe8ACRn8A1H6dD6G034LFpaHY5VK/M0nLRMw6C/QF2EsBo
	TNzC7XwDIPI0YXHWEHA1CCbpSqKU0me4xiAx2TjcSoaO0=
X-Google-Smtp-Source: AGHT+IEfjTcwiq0iGyeXz+L4N8OFRtJMWuG/A0eLPmPx9/8CzxaM1HhxaEpsbWAoy+R/iYIcBip4gWY4ZQ==
X-Received: from oibfc3.prod.google.com ([2002:a05:6808:2a83:b0:443:a4fe:d05c])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:2f1b:b0:44d:ad7e:384b
 with SMTP id 5614622812f47-44f7a458e56mr434238b6e.22.1761686473114; Tue, 28
 Oct 2025 14:21:13 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:45 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-20-sagis@google.com>
Subject: [PATCH v12 19/23] KVM: selftests: Finalize TD memory as part of kvm_arch_vm_finalize_vcpus
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

Call vm_tdx_finalize() as part of kvm_arch_vm_finalize_vcpus if this is
a TDX vm

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 17f5a381fe43..09cc75ae8d26 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -1360,3 +1360,9 @@ bool kvm_arch_has_default_irqchip(void)
 {
 	return true;
 }
+
+void kvm_arch_vm_finalize_vcpus(struct kvm_vm *vm)
+{
+	if (is_tdx_vm(vm))
+		vm_tdx_finalize(vm);
+}
-- 
2.51.1.851.g4ebd6896fd-goog


