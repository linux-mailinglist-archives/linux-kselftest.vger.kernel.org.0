Return-Path: <linux-kselftest+bounces-47462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D985FCB7951
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 02:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 854FE303C828
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 01:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5E5289358;
	Fri, 12 Dec 2025 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QaxuaJ6F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965C52874E9
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 01:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765504423; cv=pass; b=kPOQAnRtA/5y1WSvmf6qoftIVA5kX7O9vy1odpOuPBYfX2A6lApI084COjBPj/mhZVZ4eF7V4GC4UaZ17B/KMrWmVcaIGg5srf2akkU6lTD0J9E1y2eKh8MJ06L4IRZ5TpucnKVTjqqP8oV6tSc6LKd4x/cvai053xmDvi4akrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765504423; c=relaxed/simple;
	bh=CtnrD2J63dCxI3UoL3AtPmDSp/FjRGF6ovFEvF9WcKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6W7ywYMuNOMIsHyfWPgdlSTjfncCj37zveo/MUCQYzCAsZ6b0nThl4U4VU6HnaHpR+hcnBE2rRdELuIa9k2GefiEuhxsQiDv89ZGokz6dw4r+r3DfWhMj1VxPILzJY/zoaNjVgZ3U/+0c0Fuxj4XQmSmwRpRJZP7IPn8nJqqIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QaxuaJ6F; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477a1c8cc47so128545e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 17:53:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765504418; cv=none;
        d=google.com; s=arc-20240605;
        b=aafFSIw237GtAa6GEkLDndWoOWLx12U6luo1cr7nqrYNM2DU6YzzCCu4JOJBYK/UOB
         /hho7pwU8RSl4n0t5tTLDPFY5lhi/KW2hn/6FFCIdIWQCOcdfa5A4NUXiXSETjVP43NY
         r95bwdcdLUL8FQysic/VhZkccvhMf2ooF2ZVjHWsQamebjz9KWWNFInCaiQzx80Vm9f5
         dplpFMljKqDfhe5NFs3YpZxIYIHXTXtvUx64PrvR3ZLTNqxMGYRe3ZepvT/ARFoHJ/Ue
         OzXZAk+fb00GxRSrG/SECfIBQ/DVoquGg0SvOIGIq6F4UeiUPxZjsQOdCdDM+v9kP2R6
         ZmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rd1kWl+e0QkfeVDmjwKDiRL6KWrbfO8Cm6aCDNo3pTc=;
        fh=V1gsSfuonNnL7DVKYWgYlWWRyOVUUQLdEipggCC5wEI=;
        b=bN0w2DnGNeoMZQ3zgREy4pifwatjS00vxmewzky2hoLhSiEf546nWiyIuPUg+thbZ1
         tBy6AekBUbRF1N0svWZ4UKDRrsed57KB2irsALAVOPdcnZIzlZWHdIYfIxjiDQqjrb6g
         K0eKJEYcyRKREEqfwXnQN8QD/gyYeHE2H2Sv0PdfFicCG36vaSANKprv38iOLjlqWBPp
         I0QbBjGl1HoQGFl3yiZ2wytVe1525MjTMO0BkTVjWwknSjjrpajxoLlWrrP1+s7YGLkM
         GfEKIJmidq/PuSt9MAByx01+4PqFk9Zrq8RdVZ4exxPTeCy2wuJpQ6kU8ZWCAnC5Z7Th
         P4UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765504418; x=1766109218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rd1kWl+e0QkfeVDmjwKDiRL6KWrbfO8Cm6aCDNo3pTc=;
        b=QaxuaJ6FY+mMHgyUMmOhGCr6Yy753r5bsyXEhR014PgVhSLNgPmtkCPCGtsAh+bd5L
         6bPfi2j8hh80vsf4ZoqxN2SK2WOhCS80nJW8Sosk8IAl/a59bmYwILUiXSCEmkLeLPvA
         o+xSmgZloqwcL11rprgIzZ8cWlr0bzXpJDQB22hSUSCeLSrp7s5Y+mxFR+Qb7hJY4nfl
         Wxhp404brUG1OlaxOHpcyLdhabhtduIGCRNgJK2/3rty7UMHr+O7PhxicHWHd5PSO2Ij
         9joSHArlEQXROdkHSw3VmGVtlOscRd2UM1f5PgcLITT50zkQaa6uEx4YkkckYVqaQSVF
         i0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765504418; x=1766109218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rd1kWl+e0QkfeVDmjwKDiRL6KWrbfO8Cm6aCDNo3pTc=;
        b=rHH+KEB9pJX81/7yNMsX13GT8RcQO9n6M5RQY5c70xTlmkGUnvAXElQyBRBCR0U8Ue
         eLT/8kx7LOov/mzYYU5j4HBANyH0wE4JYJeSDJwGw/hKDzFeykLmj2g/i4VJ+72beqng
         rfEM5rY7jXEA6YXB/0NWHsvTMBThmlWvZLIslhU2nEVz41Cuu7ksL+/yvFy+j5HstDON
         Bn5xpOhWaTNO9DC3M2JOo820AbbRupwvttS8Y76T5opmNhZUUOgKdtpL17qej3g/hwaR
         U1yvy1TuZ5qwPWYpC9Mfxk80mxOxU9/y8wMnf47RMZSlgzU4HlrYANY4hZUUP1TJk1xo
         wiZA==
X-Forwarded-Encrypted: i=1; AJvYcCX02xB5x64r+HW5+78nmUiCi/hUAT/P0k/DXttemgKpUrNzPeP3BJTs5sDc2E6vR3L06+E9cjICJdn8xkQoEZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy05WVuFd2Qam4gjmQIcoxCBZdvEleFxF2wgT/foHlFUdPS/bw4
	4ioInWBmOMtB6vWZL623uWKPNByVQUlFx2stZOwqWA/8furvj0lNfSm3wpS7SlRn/7AqfksaPRy
	KAidhdofmpHjsAxJ0Cl3SJrRZq/S9E/1hKv5H6j9w
X-Gm-Gg: AY/fxX65uLFheOzfNJEcLCfgKc5s0qyAZSaRJ44hc7xZxbJKzn/aLQKhrIGbf4+mRDJ
	ziW+x6T15Q4kviRBc5WmdqBFccvQVeqEdLzPfpLA9vSta4beEUDHrPXnINH6z+PFduXnAVnFl0I
	LFcCvbS5DjqKN87F0smeuC/RWnRzV6WIYyvaX7xM/ek45unC5iK0Q9+/Rnh9Atp35ehFr4QzZAX
	O1MlztXqFWe/9sVrMk36nZ6Piho4B5ZzEtP4IInVNVmfN2hDgdf2zKOZSovDHGnXKlVDJqAfKBF
	itsbXvtUVrkRKXQ6mC3HlPYnC20i
X-Google-Smtp-Source: AGHT+IELyZ67Mh/WAPeTceCN8jbRYqNn7LfXokCBfkoubbVjvqqfzZOlYxJtEOZmuwbdnCZhp2hA4fTZEV/raHqViWM=
X-Received: by 2002:a05:600d:3:b0:477:86fd:fb49 with SMTP id
 5b1f17b1804b1-47a88c5c13dmr1386955e9.10.1765504417716; Thu, 11 Dec 2025
 17:53:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013185903.1372553-1-jiaqiyan@google.com> <20251013185903.1372553-3-jiaqiyan@google.com>
 <3061f5f8-cef0-b7b1-c4de-f2ceea29af9a@huawei.com>
In-Reply-To: <3061f5f8-cef0-b7b1-c4de-f2ceea29af9a@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 11 Dec 2025 17:53:26 -0800
X-Gm-Features: AQt7F2rTGmuQE0DHKTuWqG307odD2vjHJLASzh2BvequPFTSz6j2Q6CLsqIFn98
Message-ID: <CACw3F51mRXCDz7Hd4Vve98NoskhB2cSc88zAGfd6Hwr4uCBxPA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] KVM: selftests: Test for KVM_EXIT_ARM_SEA
To: Zenghui Yu <yuzenghui@huawei.com>, maz@kernel.org, oliver.upton@linux.dev
Cc: duenwen@google.com, rananta@google.com, jthoughton@google.com, 
	vsethi@nvidia.com, jgg@nvidia.com, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 5:02=E2=80=AFAM Zenghui Yu <yuzenghui@huawei.com> w=
rote:
>
> Hi Jiaqi,
>
> I had run into several problems when testing it on different servers. I
> haven't figured them out yet but post it early for discussion.

Thanks for testing, and I will be happy to work with you to improve
this test code.

>
> On 2025/10/14 2:59, Jiaqi Yan wrote:
> > Test how KVM handles guest SEA when APEI is unable to claim it, and
> > KVM_CAP_ARM_SEA_TO_USER is enabled.
> >
> > The behavior is triggered by consuming recoverable memory error (UER)
> > injected via EINJ. The test asserts two major things:
> > 1. KVM returns to userspace with KVM_EXIT_ARM_SEA exit reason, and
> >    has provided expected fault information, e.g. esr, flags, gva, gpa.
> > 2. Userspace is able to handle KVM_EXIT_ARM_SEA by injecting SEA to
> >    guest and KVM injects expected SEA into the VCPU.
> >
> > Tested on a data center server running Siryn AmpereOne processor
> > that has RAS support.
> >
> > Several things to notice before attempting to run this selftest:
> > - The test relies on EINJ support in both firmware and kernel to
> >   inject UER. Otherwise the test will be skipped.
> > - The under-test platform's APEI should be unable to claim the SEA.
> >   Otherwise the test will be skipped.
> > - Some platform doesn't support notrigger in EINJ, which may cause
> >   APEI and GHES to offline the memory before guest can consume
> >   injected UER, and making test unable to trigger SEA.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
>
> [...]
>
> > +static void inject_uer(uint64_t paddr)
> > +{
> > +     if (access("/sys/firmware/acpi/tables/EINJ", R_OK) =3D=3D -1)
> > +             ksft_test_result_skip("EINJ table no available in firmwar=
e");
>
> Missing '\n'.

Thanks.

>
> We should return early (to actually skip the test) if the file can not
> be accessed, right?

Oh you mean I missed exit(KSFT_SKIP), right? Agreed.

>
> > +
> > +     if (access(EINJ_ETYPE, R_OK | W_OK) =3D=3D -1)
> > +             ksft_test_result_skip("EINJ module probably not loaded?")=
;
> > +
> > +     write_einj_entry(EINJ_ETYPE, ERROR_TYPE_MEMORY_UER);
> > +     write_einj_entry(EINJ_FLAGS, MASK_MEMORY_UER);
> > +     write_einj_entry(EINJ_ADDR, paddr);
> > +     write_einj_entry(EINJ_MASK, ~0x0UL);
> > +     write_einj_entry(EINJ_NOTRIGGER, 1);
> > +     write_einj_entry(EINJ_DOIT, 1);
> > +}
> > +
> > +/*
> > + * When host APEI successfully claims the SEA caused by guest_code, ke=
rnel
> > + * will send SIGBUS signal with BUS_MCEERR_AR to test thread.
> > + *
> > + * We set up this SIGBUS handler to skip the test for that case.
> > + */
> > +static void sigbus_signal_handler(int sig, siginfo_t *si, void *v)
> > +{
> > +     ksft_print_msg("SIGBUS (%d) received, dumping siginfo...\n", sig)=
;
> > +     ksft_print_msg("si_signo=3D%d, si_errno=3D%d, si_code=3D%d, si_ad=
dr=3D%p\n",
> > +                    si->si_signo, si->si_errno, si->si_code, si->si_ad=
dr);
> > +     if (si->si_code =3D=3D BUS_MCEERR_AR)
> > +             ksft_test_result_skip("SEA is claimed by host APEI\n");
> > +     else
> > +             ksft_test_result_fail("Exit with signal unhandled\n");
> > +
> > +     exit(0);
> > +}
> > +
> > +static void setup_sigbus_handler(void)
> > +{
> > +     struct sigaction act;
> > +
> > +     memset(&act, 0, sizeof(act));
> > +     sigemptyset(&act.sa_mask);
> > +     act.sa_sigaction =3D sigbus_signal_handler;
> > +     act.sa_flags =3D SA_SIGINFO;
> > +     TEST_ASSERT(sigaction(SIGBUS, &act, NULL) =3D=3D 0,
> > +                 "Failed to setup SIGBUS handler");
> > +}
> > +
> > +static void guest_code(void)
> > +{
> > +     uint64_t guest_data;
> > +
> > +     /* Consumes error will cause a SEA. */
> > +     guest_data =3D *(uint64_t *)EINJ_GVA;
> > +
> > +     GUEST_FAIL("Poison not protected by SEA: gva=3D%#lx, guest_data=
=3D%#lx\n",
> > +                EINJ_GVA, guest_data);
> > +}
> > +
> > +static void expect_sea_handler(struct ex_regs *regs)
> > +{
> > +     u64 esr =3D read_sysreg(esr_el1);
> > +     u64 far =3D read_sysreg(far_el1);
> > +     bool expect_far_invalid =3D far_invalid;
> > +
> > +     GUEST_PRINTF("Handling Guest SEA\n");
> > +     GUEST_PRINTF("ESR_EL1=3D%#lx, FAR_EL1=3D%#lx\n", esr, far);
> > +
> > +     GUEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_DABT_CUR);
> > +     GUEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
> > +
> > +     if (expect_far_invalid) {
> > +             GUEST_ASSERT_EQ(esr & ESR_ELx_FnV, ESR_ELx_FnV);
>
> I hit this ASSERT with:
>
> # Mapped 0x40000 pages: gva=3D0x80000000 to gpa=3D0xff80000000
> # Before EINJect: data=3D0xbaadcafe
> # EINJ_GVA=3D0x81234bad, einj_gpa=3D0xff81234bad, einj_hva=3D0xffff41234b=
ad,
> einj_hpa=3D0x202841234bad
> # echo 0x10 > /sys/kernel/debug/apei/einj/error_type - done
> # echo 0x2 > /sys/kernel/debug/apei/einj/flags - done
> # echo 0x202841234bad > /sys/kernel/debug/apei/einj/param1 - done
> # echo 0xffffffffffffffff > /sys/kernel/debug/apei/einj/param2 - done
> # echo 0x1 > /sys/kernel/debug/apei/einj/notrigger - done
> # echo 0x1 > /sys/kernel/debug/apei/einj/error_inject - done
> # Memory UER EINJected
> # Dump kvm_run info about KVM_EXIT_ARM_SEA
> # kvm_run.arm_sea: esr=3D0x92000610, flags=3D0
> # kvm_run.arm_sea: gva=3D0, gpa=3D0
> # From guest: Handling Guest SEA
> # From guest: ESR_EL1=3D0x96000010, FAR_EL1=3D0xaaaadf254828
> # Guest aborted!
> =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
>   arm64/sea_to_user.c:172: esr & ESR_ELx_FnV =3D=3D ESR_ELx_FnV
>   pid=3D38112 tid=3D38112 errno=3D4 - Interrupted system call
>      1  0x0000000000402f9b: run_vm at sea_to_user.c:246
>      2  0x0000000000402467: main at sea_to_user.c:330
>      3  0x0000ffff8e22b03f: ?? ??:0
>      4  0x0000ffff8e22b117: ?? ??:0
>      5  0x00000000004026ef: _start at ??:?
>   0x0 !=3D 0x400 (esr & ESR_ELx_FnV !=3D ESR_ELx_FnV)
>
> It seems that KVM doesn't emulate FnV when injecting an abort.

I believe so; this happened to me when I tested on an architecture
that doesn't provide valid FAR. I tried to fix this in [1] in the
past, but didn't get any traction and somehow escaped my attention...

Oliver and Marc, what do you think about [1]? If it sounds like a
valid fix, I can re-send it out as an individual patch.

[1] https://lore.kernel.org/kvmarm/20250604050902.3944054-3-jiaqiyan@google=
.com


>
> > +             GUEST_PRINTF("Guest observed garbage value in FAR\n");
> > +     } else {
> > +             GUEST_ASSERT_EQ(esr & ESR_ELx_FnV, 0);
> > +             GUEST_ASSERT_EQ(far, EINJ_GVA);
> > +     }
> > +
> > +     GUEST_DONE();
> > +}
> > +
> > +static void vcpu_inject_sea(struct kvm_vcpu *vcpu)
> > +{
> > +     struct kvm_vcpu_events events =3D {};
> > +
> > +     events.exception.ext_dabt_pending =3D true;
> > +     vcpu_events_set(vcpu, &events);
> > +}
> > +
> > +static void run_vm(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> > +{
> > +     struct ucall uc;
> > +     bool guest_done =3D false;
> > +     struct kvm_run *run =3D vcpu->run;
> > +     u64 esr;
> > +
> > +     /* Resume the vCPU after error injection to consume the error. */
> > +     vcpu_run(vcpu);
> > +
> > +     ksft_print_msg("Dump kvm_run info about KVM_EXIT_%s\n",
> > +                    exit_reason_str(run->exit_reason));
> > +     ksft_print_msg("kvm_run.arm_sea: esr=3D%#llx, flags=3D%#llx\n",
> > +                    run->arm_sea.esr, run->arm_sea.flags);
> > +     ksft_print_msg("kvm_run.arm_sea: gva=3D%#llx, gpa=3D%#llx\n",
> > +                    run->arm_sea.gva, run->arm_sea.gpa);
> > +
> > +     TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_ARM_SEA);
>
> I can also hit this ASSERT with:
>
> Random seed: 0x6b8b4567
> # Mapped 0x40000 pages: gva=3D0x80000000 to gpa=3D0xff80000000
> # Before EINJect: data=3D0xbaadcafe
> # EINJ_GVA=3D0x81234bad, einj_gpa=3D0xff81234bad, einj_hva=3D0xffff41234b=
ad,
> einj_hpa=3D0x2841234bad
> # echo 0x10 > /sys/kernel/debug/apei/einj/error_type - done
> # echo 0x2 > /sys/kernel/debug/apei/einj/flags - done
> # echo 0x2841234bad > /sys/kernel/debug/apei/einj/param1 - done
> # echo 0xffffffffffffffff > /sys/kernel/debug/apei/einj/param2 - done
> # echo 0x1 > /sys/kernel/debug/apei/einj/notrigger - done
> # echo 0x1 > /sys/kernel/debug/apei/einj/error_inject - done
> # Memory UER EINJected
> # Dump kvm_run info about KVM_EXIT_MMIO
> # kvm_run.arm_sea: esr=3D0xffff90ba0040, flags=3D0x691000
> # kvm_run.arm_sea: gva=3D0x100000008, gpa=3D0
> =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
>   arm64/sea_to_user.c:207: exit_reason =3D=3D (41)
>   pid=3D38023 tid=3D38023 errno=3D4 - Interrupted system call
>      1  0x0000000000402d1b: run_vm at sea_to_user.c:207
>      2  0x0000000000402467: main at sea_to_user.c:330
>      3  0x0000ffff9122b03f: ?? ??:0
>      4  0x0000ffff9122b117: ?? ??:0
>      5  0x00000000004026ef: _start at ??:?
>   Wanted KVM exit reason: 41 (ARM_SEA), got: 6 (MMIO)
>
> Not sure what's wrong it..

Does your test machine have SDEI or SCI enabled for host APEI? Do you
see any kernel log from "Memory failure:" saying hugetlb page
recovered, and recovered significant earlier than the KVM exit here.
It maybe the kernel has already unmapped hugepage in response to SDEI
or SCI before this test actually consumes memory error, so no SEA is
actually triggered.

>
> > +
> > +     esr =3D run->arm_sea.esr;
> > +     TEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_DABT_LOW);
> > +     TEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
> > +     TEST_ASSERT_EQ(ESR_ELx_ISS2(esr), 0);
> > +     TEST_ASSERT_EQ((esr & ESR_ELx_INST_SYNDROME), 0);
> > +     TEST_ASSERT_EQ(esr & ESR_ELx_VNCR, 0);
> > +
> > +     if (!(esr & ESR_ELx_FnV)) {
> > +             ksft_print_msg("Expect gva to match given FnV bit is 0\n"=
);
> > +             TEST_ASSERT_EQ(run->arm_sea.gva, EINJ_GVA);
> > +     }
> > +
> > +     if (run->arm_sea.flags & KVM_EXIT_ARM_SEA_FLAG_GPA_VALID) {
> > +             ksft_print_msg("Expect gpa to match given KVM_EXIT_ARM_SE=
A_FLAG_GPA_VALID is set\n");
> > +             TEST_ASSERT_EQ(run->arm_sea.gpa, einj_gpa & PAGE_ADDR_MAS=
K);
> > +     }
> > +
> > +     far_invalid =3D esr & ESR_ELx_FnV;
>
> Missing sync_global_to_guest()?

Ah, yes, and I can add sync_global_to_guest and get rid of
expect_far_invalid in expect_sea_handler.

>
> Thanks,
> Zenghui

