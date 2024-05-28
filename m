Return-Path: <linux-kselftest+bounces-10770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD808D1872
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 12:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD231F25627
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 10:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA3916B724;
	Tue, 28 May 2024 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsGLn1Y7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49116ABFD
	for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891790; cv=none; b=HZGAhIlaYqx2cbZarHukX0TkAOD57wK4B316cocmr4bUZCs/hFWUE4CiWb5B3QNjdAoCMrxDkP0WHn0Yh4sBn6jokqjxlmSFpyBW6u1ci+cNC5LFUcTxpDUt6AQbarFoBwn162g2rYIupvAJ8ucadbdHRn1rOpFV8opEKm0FDWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891790; c=relaxed/simple;
	bh=6HygncVEzNRf7eiLycKCAN8lb4+Vt1or8KDjZEkYLIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4f/JkGbdnV+EsGQ14jDcTmzvmpHJDpWHW97Mw910ihPSzc4+Rqid7YBE9r3u6qWgRUa8w/6CeK/50cW4zPXDFmNluMOJWX8Km2pw0LvRVnyrUZ4woOrfQJXP9GegQoWc3az50ztBhDiOY3XyhuohWrKe9CtCdvkdC6eoe/Lw6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsGLn1Y7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716891787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4JlPtnJK4Wc+1UEGNtg5G4FKrqpfno/sxU9Ww+Z7CRE=;
	b=bsGLn1Y7VChbxvCwBt5ryY8B46Blj2qg+yj2FRNPy9XwOG0O9jsTwHF6DOhbyabwJLs2V9
	Fjn3e3/5iHl9iSAgyfPmSWNVpeI72tRWpqKD8izxJmVYl34oNOEYWHOdEFQRYW9z8t0lqM
	Akf3HwAadWwnbZ7uE1SMK307Up3rvhQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-cJBz8nOcOruZLDV859Olnw-1; Tue, 28 May 2024 06:23:05 -0400
X-MC-Unique: cJBz8nOcOruZLDV859Olnw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2e95a6565a8so5915521fa.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 03:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716891784; x=1717496584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JlPtnJK4Wc+1UEGNtg5G4FKrqpfno/sxU9Ww+Z7CRE=;
        b=aXg2MwqUI8WUguTDSLpAwheKgagkwr7bcrIgQrdHHVdoTa3f2jVOlSy5JH5pwjHJ+l
         8YaoGeo1pOFr+Vx6MxhxbKttPwohGL/aPAgOUDCMKE5PhXh9sP5ZM66UwDVqobfydsgn
         us6TalpucHT+z2zCaUHM7RUVuwaak7Pd4XZ0+F4wZEIzpvXyHhzaZi5YPvtOgt19unsv
         da1DLoDCLJmDo0AtpNbBzdO2CmV4wPRwV/gJY3M9xukJmQ7HDl1kfDbAIe4JHUYwjoeK
         faNSdB4hfkdHOoEoN0rMOA+SWHrrxRUQGvlKjrT60uMBt+BV/IjVnh2k5GAkZcP586Id
         AVXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM36OvtXkdIf2Jvss932n444KChhQNn9bUt+ow/md14HiVLMbTOGr9HegM+M8C2+BautEx0c/jn8zF0vBCwrtUoeT5bacdUHYd6J1y5Cwh
X-Gm-Message-State: AOJu0Yy13YzwbgoHDBSVSkWU3YV0pR2YZYFTt93D+1qcCkZLaU1u06GI
	xW+MPtTGnLAOAnbysYWG7uQyPjN9Zi8jb24+tiFm9LRM95r5yEy21zN89JNyQMOGqB9my644y8+
	TpmIzlnVC4smXNm9R6cqv8kLcfNYoaXLRvZG//rxfOze0Zu6ffpDAwkxeEupjcQHqWN3yKud8CN
	Q7gKYvfZB9baFmXOrQTfXUeqgjfemfA/9e20yxk5Ta
X-Received: by 2002:a2e:a289:0:b0:2e4:7996:f9f0 with SMTP id 38308e7fff4ca-2e95b0c0f7dmr66995681fa.17.1716891784417;
        Tue, 28 May 2024 03:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFagdU0lrm3adrwao69Qv89jjLARq8eA9baEqhKcOEZD1RrTFH9Zv4Avy23rRgqwTm4Dx2B6GF5Co/8Z/IaoUU=
X-Received: by 2002:a2e:a289:0:b0:2e4:7996:f9f0 with SMTP id
 38308e7fff4ca-2e95b0c0f7dmr66995461fa.17.1716891783855; Tue, 28 May 2024
 03:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528041926.3989-1-manali.shukla@amd.com>
In-Reply-To: <20240528041926.3989-1-manali.shukla@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 May 2024 12:22:51 +0200
Message-ID: <CABgObfbz5kZZObu9dO=KPu8_mZvGmV1752SQzQckkrj5jPaTQg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add support for the Idle HLT intercept feature
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, seanjc@google.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 6:19=E2=80=AFAM Manali Shukla <manali.shukla@amd.co=
m> wrote:
>
> The upcoming new Idle HLT Intercept feature allows for the HLT
> instruction execution by a vCPU to be intercepted by the hypervisor
> only if there are no pending V_INTR and V_NMI events for the vCPU.
> When the vCPU is expected to service the pending V_INTR and V_NMI
> events, the Idle HLT intercept won=E2=80=99t trigger. The feature allows =
the
> hypervisor to determine if the vCPU is actually idle and reduces
> wasteful VMEXITs.

Does this have an effect on the number of vmexits for KVM, unless AVIC
is enabled? Can you write a testcase for kvm-unit-tests' vmexit.flat
that shows an improvement?

The reason I am wondering is because KVM does not really use V_INTR
injection. The "idle HLT" intercept basically differs from the basic
HLT trigger only in how it handles an STI;HLT sequence, as in that
case the interrupt can be injected directly and the HLT vmexit is
suppressed. But in that circumstance KVM would anyway use a V_INTR
intercept to detect the opening of the interrupt injection window (and
then the interrupt uses event injection rather than V_INTR). Again,
this is only true if AVIC is disabled, but that is the default.

So unless I'm wrong in my analysis above, I'm not sure this series,
albeit small, is really worth it. As things stand, it would be more
interesting to enable this for nested VMs, especially Hyper-V which
does use V_INTR and V_TPL; even better, _emulating_ it on older
processors would reduce the L2->L0->L1->L0->L2 path to a
less-expensive L2->L0->L2 vmexit.


Paolo

> Presence of the Idle HLT Intercept feature is indicated via CPUID
> function Fn8000_000A_EDX[30].
>
> Document for the Idle HLT intercept feature is available at [1].
>
> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
>      Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
>      https://bugzilla.kernel.org/attachment.cgi?id=3D306250
>
> Testing Done:
> - Added a selftest to test the Idle HLT intercept functionality.
> - Compile and functionality testing for the Idle HLT intercept selftest
>   are only done for x86_64.
> - Tested SEV and SEV-ES guest for the Idle HLT intercept functionality.
>
> v2 -> v3
> - Incorporated Andrew's suggestion to structure vcpu_stat_types in
>   a way that each architecture can share the generic types and also
>   provide its own.
>
> v1 -> v2
> - Done changes in svm_idle_hlt_test based on the review comments from Sea=
n.
> - Added an enum based approach to get binary stats in vcpu_get_stat() whi=
ch
>   doesn't use string to get stat data based on the comments from Sean.
> - Added self_halt() and cli() helpers based on the comments from Sean.
>
> Manali Shukla (5):
>   x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
>   KVM: SVM: Add Idle HLT intercept support
>   KVM: selftests: Add safe_halt() and cli() helpers to common code
>   KVM: selftests: Add an interface to read the data of named vcpu stat
>   KVM: selftests: KVM: SVM: Add Idle HLT intercept test
>
>  arch/x86/include/asm/cpufeatures.h            |  1 +
>  arch/x86/include/asm/svm.h                    |  1 +
>  arch/x86/include/uapi/asm/svm.h               |  2 +
>  arch/x86/kvm/svm/svm.c                        | 11 ++-
>  tools/testing/selftests/kvm/Makefile          |  1 +
>  .../testing/selftests/kvm/include/kvm_util.h  | 44 +++++++++
>  .../kvm/include/x86_64/kvm_util_arch.h        | 40 +++++++++
>  .../selftests/kvm/include/x86_64/processor.h  | 18 ++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 32 +++++++
>  .../selftests/kvm/x86_64/svm_idle_hlt_test.c  | 89 +++++++++++++++++++
>  10 files changed, 236 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.=
c
>
>
> base-commit: d91a9cc16417b8247213a0144a1f0fd61dc855dd
> --
> 2.34.1
>


