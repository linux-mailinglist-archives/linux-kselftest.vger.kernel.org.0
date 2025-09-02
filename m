Return-Path: <linux-kselftest+bounces-40622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D1EB4096D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8643248526F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 15:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2F231AF2E;
	Tue,  2 Sep 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvvyrm+J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972E22FAFD
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827942; cv=none; b=P3+SJOb1uNPdLCO/7IA5CUZKdpXh6ZMr/XWJYRPwc9jy/xBf6PTMLR8UphPnv7Du6QciEMRetiR0esQUeDp6VZtuXAFKfpRSYlDFcZqDGnJ2hCwEscE7ymZGcfWyaVClzw6yTQr55p69QPfSoHsazjiX/ls8A3A7WfDXUU3YqQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827942; c=relaxed/simple;
	bh=fAiEOoWGsgZVWnQszf7mSNgrn30l+x24N176m36Ke1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ip7CXMVDP0JxxuKxiC7EuAnleHpccxMbY9Oe4Z5bqYSOJ474Zpt+t2XXIXWaCucT/md+btjSd614zVt63liTNt1xuqgcHIQPFLdDnyZviethMHKcyBhMM+HAkJdXGy4li5NnJ3xHzNI5vDv4ZrCCMo8yJVQ13d/wby2ss0HH5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hvvyrm+J; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329cb4c3f78so1482419a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756827940; x=1757432740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=idXQYsgK/aGLRgfjtmw1Ddlh5JY9tGyYsy/t9zcVDwU=;
        b=hvvyrm+J1TMO5zbc61g/N3cVDQtT/bB1etPMO7rZfKsbnGHXQxrGfj8Cu8uJpYbrxQ
         muLDOaPOMqvOgmrU6VrTw6REgEz4r/yygluu9dzgXCDbMdug0NTq9g+MwXOFXBOzQKEq
         IxXgNa4VeZYuGBMgnzmFrW4EEaYnVjk25KBkAdqzXrPi4izA3C53/ZN+OGiMvwkowx3/
         4vAf52QieYAQ+cJeNJhHd43g0YUshJ0kHz4I7UmkFr1CWzKmmjAObC7Sbn55ZihoDmqG
         E3ajNOcDvEmIj0KteCyGrH0EV7zqDAqKEUawZCnYvn9fbR1KZvtVr8OD1UwwioAbAtTS
         EbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827940; x=1757432740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idXQYsgK/aGLRgfjtmw1Ddlh5JY9tGyYsy/t9zcVDwU=;
        b=hreJL4hDA58ocB2dgiKXOyTqxMFzzRYRciBxjhnukGviEPm57b6gJv0u0wgvCjpPah
         t+ZZeMhcDDBj7By4eJ9YIJrtXiWAZimndq6/ZAlBdctj5Lgo02lUytLlJ+VkZy5csctk
         UE4Rx/G6z4JaPex2ChJuzS1ZQUB6JRqZ0EUvJbleKFEGLjNcbOCegc+wf7qNgpNJ7jv+
         uvESsm/FelKiCoZTG68QEVTBIGI6Ydv03HPEyPTU4ZdEoHb+mlsljB3jdUBLJCdewb1y
         zlnNGyTQsl2du18BsTiQxQQd6CrgV3hti60k0mSM37Lrpk3aWNalU+vH+Nu3H/1i6SbD
         W2Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWPUKAoCYkLXv8GLz0tHvbmF/5X9Jkt8iBjqu75zwt0ddA+Imyco+JYOpd+H7jj/RJxnN7wmI7fr+KVWTtGgY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx87ATVfoVaaaOujIMBg91TEy3uwXkF4vEk40gQzYJpkg8FLQK
	0RfkRWxJG7cwVzPjYFdpiiQ8TPemPzXSwHCGhIROYPpp4o24nE8aVZF2r2ZzP/gR9hqKRYdK7H9
	2k4YZVg==
X-Google-Smtp-Source: AGHT+IH0Sgo9kbsCPDPAvdw6SKo64i6IWn2JUynJKfEHeEJJqslJKt0/A4YOwdvbBZ9fik2siemSYLkR5vc=
X-Received: from pjbsn4.prod.google.com ([2002:a17:90b:2e84:b0:329:cb7d:8057])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:16d7:b0:328:192:b7a0
 with SMTP id 98e67ed59e1d1-328156b6395mr11717001a91.19.1756827940533; Tue, 02
 Sep 2025 08:45:40 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:45:38 -0700
In-Reply-To: <18bf858c-e135-4a9b-bda8-a70be3b3720e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-19-sagis@google.com>
 <18bf858c-e135-4a9b-bda8-a70be3b3720e@linux.intel.com>
Message-ID: <aLcRIn8ryB2kXWcD@google.com>
Subject: Re: [PATCH v9 18/19] KVM: selftests: Add ucall support for TDX
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 27, 2025, Binbin Wu wrote:
> On 8/21/2025 12:29 PM, Sagi Shahar wrote:
> > @@ -46,11 +69,23 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
> >   {
> >   	struct kvm_run *run = vcpu->run;
> > -	if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
> > -		struct kvm_regs regs;
> > +	switch (vm_type) {
> > +	case KVM_X86_TDX_VM:
> > +		if (vcpu->run->exit_reason == KVM_EXIT_MMIO &&
> > +		    vcpu->run->mmio.phys_addr == host_ucall_mmio_gpa &&
> > +		    vcpu->run->mmio.len == 8 && vcpu->run->mmio.is_write) {
> > +			uint64_t data = *(uint64_t *)vcpu->run->mmio.data;
> > +
> > +			return (void *)data;
> > +		}
> > +		return NULL;
> 
> My first thought was how did SEV_ES or SNP work for this since they are not
> able to get RDI neither.
> Then I had a check in sev_smoke_test.c, both guest_sev_es_code() and
> guest_snp_code() call GUEST_ASSERT(), which finally calls ucall_assert(), but
> in test_sev(), the code doesn't handle ucall for SEV_ES or SNP.
> Does it mean GUEST_ASSERT() is currently not working and ignored for SEV_ES
> and SNP? Or did I miss anything?

GUEST_ASSERT() "works" for -ES and -SNP in the sense that it generates as test
failure due to the #VC not being handled (leads to SHUTDOWN).  But you're correct
that ucall isn't functional yet.  x86/sev_smoke_test.c fudges around lack of ucall
by using the GHCB MSR protocol to signal "done".

        /*
         * TODO: Add GHCB and ucall support for SEV-ES guests.  For now, simply
         * force "termination" to signal "done" via the GHCB MSR protocol.
         */
        wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
        vmgexit();

