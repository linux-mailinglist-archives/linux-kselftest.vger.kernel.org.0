Return-Path: <linux-kselftest+bounces-44229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C0DC16F91
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91CEE506D15
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04F3590CC;
	Tue, 28 Oct 2025 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Il+8Y5gG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C54358D0A
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686475; cv=none; b=rsn43nKh9j96MU93ENh4qMQUpVo33t1SJ1nRNInRcfMyiKCXlwZkwJNcL1F8UNUQu5rlngO41x5BJ/ILxE1ddfppWoXNFvpQKwbsXVZctBE8eNqYHwroL/TzWJVeLN8Yp02wMe+wguW8baclihmQnBq3LMHJMebFIv+/AcWqFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686475; c=relaxed/simple;
	bh=XHCbxfrzoGdDsdrcY2rTVu1R1r7Is2Kmr5rE68Lc/fc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L7Y7L23bpWwOh3c3UIbvUqyFgvgX8k84bv65T1FL/tsRrDs/Vp9vBAdHs3JN4tzbJPDh/5s1fhh9O88GP1wZ9hoEf+ERG37tNSO6iDR8TiX4kiS0T9LZ8RgPlFaRW0vQ5A/gjPT7zQzpNRXJAvrK7xp4j+GHiuMT875k8A9hg2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Il+8Y5gG; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-93e7ece2ff4so2022110739f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686472; x=1762291272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2hQEt8uzmZFMchmgXgqAe6OBZ69jvpk9KGj1/+J4M4=;
        b=Il+8Y5gG/63HMieFE4hhar35qiZkm375xu95AStbjxnRwj20fpdwMmbq2i+rTmhwf5
         yg8dMG3fCxj+wV4OvuJGF15mTnKHmNO48F7OFNp9y0BmMuRJI1Enhpn2kvdCpvg3vuFD
         xLRAXSSy6AogyiAE4f3cVt1OdJoKlPs8fhqv3fAjnsqTvvH7JBBiKKMYH98/N3nFDfdB
         ws0MsBpmZjJo3ZqlxL1QQAPTWL8lmZv/wsjoJSOzkKDv0TuTV0yxn+9aLI96FD5F9lwd
         3x3EWYD2AXUQ/kgsHjRBo3nF41Zotsb5p0NJPvFx3za2C09ncIOD7Xr1kA0yY9PclyYI
         OsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686472; x=1762291272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2hQEt8uzmZFMchmgXgqAe6OBZ69jvpk9KGj1/+J4M4=;
        b=pfp4K5sI3bswRAZRUBZOCrG0MdRleav4uJRZODCBUPKklGLW8Mun4RIOuvlgZVrKUT
         ISB37KYQzlwF8HWFr1O0QbBY1maHrerwRPAm4PGZkmcZnp58ZfYIq75jBiphZ2E3nllj
         I5JATBUtEp31CKNRc86UfNcUSNXfiAKh70xV/o/fHDnqp5OyuiwVD2+iOFOOm4YJl6mQ
         1uy99d3qGIZt2xHwEIt++BaYwIF/mh+HtqRNrptP1HTS+GtJwQScrVGke+8VPNijFf4n
         Gltq7LNsGVhgT9GuR2+Htu4gr6/Zesq0JLautzBTJI/8xiku9rIPCdpi9XI6tBsTxRsg
         ojBg==
X-Gm-Message-State: AOJu0Yx3fTDb9ZnlMynDiHD8Vs/5+VVfgQWgCmprsQxnVQ+fhAdzDsBE
	Vps27Ki99tJgxzG6C5v20a4XyLIGuxw8B/3RYiMHwDIhDhLLvUQPY9illv7MeQtoE50F1mC4swU
	tVec4oEsePubouA9mOej1h0VzV69GHCU/q/Qn0ggOqVW92RBpBKtackY5rwWae9lRTFOYEPeDGU
	iUlzAspMW6x0+muICPuXWAELJ5Fou6tOLEQjlcE33opAo=
X-Google-Smtp-Source: AGHT+IEOzmUxUr4Uek5ji2MKUZMUl92l7uF6agNUuaj4Psn+yNrqz6lfoiUMCy7WVJje2ATcgzv8NsTpag==
X-Received: from ios4.prod.google.com ([2002:a05:6602:7404:b0:945:a5b1:e0e6])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:621a:b0:93e:7d6d:e0d0
 with SMTP id ca18e2360f4ac-945c9764ec3mr137130539f.6.1761686472375; Tue, 28
 Oct 2025 14:21:12 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:44 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-19-sagis@google.com>
Subject: [PATCH v12 18/23] KVM: selftests: Set entry point for TDX guest code
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

Since the rip register is inaccessible for TDX VMs, we need a different
way to set the guest entry point for TDX VMs. This is done by writing
the guest code address to a predefined location in the guest memory and
loading it into rip as part of the TDX boot code.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 036875fe140f..17f5a381fe43 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -691,9 +691,13 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 {
 	struct kvm_regs regs;
 
-	vcpu_regs_get(vcpu, &regs);
-	regs.rip = (unsigned long) guest_code;
-	vcpu_regs_set(vcpu, &regs);
+	if (is_tdx_vm(vcpu->vm))
+		vm_tdx_set_vcpu_entry_point(vcpu, guest_code);
+	else {
+		vcpu_regs_get(vcpu, &regs);
+		regs.rip = (unsigned long) guest_code;
+		vcpu_regs_set(vcpu, &regs);
+	}
 }
 
 vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
-- 
2.51.1.851.g4ebd6896fd-goog


