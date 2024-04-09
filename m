Return-Path: <linux-kselftest+bounces-7505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E119589E58F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 00:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57DF1C2204A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 22:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94E9158D74;
	Tue,  9 Apr 2024 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RhnzFJav"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87156158D6D
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712700711; cv=none; b=AcynTWB4l5A8i2auXs0KMTUkm+6vtXmTT3756Mn54NkutDpSMUUSVcMNHeRnbSNlr3uHP/DU0En7E/ctIlSNj6O1R5HAnQWTiy9M9MKdPwiybCI1PDx1L6StIR2/qJrbzpr0SGY2XMYHZCo9vLBK68DkDoyPOpoTCGlAvUYK+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712700711; c=relaxed/simple;
	bh=uMpfpNZT/JircILPCLdeo5TrXY5VRv3On2Rb7xVenag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCv/6W06ZJsQce5zROg5hbXjGoNU+K1coiap3/EUj3AmqqlzcQA5Qp9u5eOU2ykDVe4Pxp8WlDOI7kHKA1h0tt1vnvUEkZ/iKEa16WXvdMuqjcGfOXTGCuYdim+0dRLJQiyfUOYhv+23W763fg49RStktzweWF44OImfydSB7Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RhnzFJav; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516c97ddcd1so7242873e87.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Apr 2024 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712700707; x=1713305507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cl1aEg9ZkKTDAHIndPvHsR0jY5Vb252ppSopDvYPPc0=;
        b=RhnzFJavAW22HzyhcV/Gy4v2dytOK6WXyYGaaavpe4bm1F3DBPuUVWEl9YyJDglq02
         hz20n5XkmPKvl64MrlD07li95V5W7X4keJtztYRcKbcZIOYocJG9230XSzaLgKiMPT/m
         qvwgolJ2761GdbMaRrVRoD0NEfiNqQxXFsle/Wn3P+BSBiPv0smTZfNileY6pKzKwdY8
         3TMcJhI+lTjd42dIcPZJ3PMHloCzp0Qt5nT0+g8anlfZvUpvnD+G9PgwlaEHKtc91uXg
         6limkaC8xel9vjq9BNB6qVct2X/s+fTSY26SxwXoGXU0+59t1evcss6Xx3+rh39Lz6GI
         xGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712700707; x=1713305507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cl1aEg9ZkKTDAHIndPvHsR0jY5Vb252ppSopDvYPPc0=;
        b=FCmr6bSfCdZIQXH35HortgX3HW6tPcFEyRFicQhYAMjhA0bxxSr9FJ1Dm1fGZCHjZh
         ujBGO5daHZKd8sCdrzH9ZAWE5Dw2kGYlpq33ZpgrRJ+545YASuBP2KmtMgQzKoDrHlbr
         pqqfT5GWguUpmeRcum948XPFAGeAxhOENPplWwFBpQgAxBUAN8QLfzpxY8jCrV/1wBFW
         mlSBobcwP1rYs6K8WJ1AKzKW9SZWcmL9ZnpZilRU8XfHTyyVPuWDg6dzqZfKGOjuvLJQ
         P5xDtdhBkWIAJhqcFbh0fxn4SdoMx0kMzLFyGIc1sTgWd7EdFkTrC82Q7ATV7a29n39s
         0M2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlD84XzgV3IDUfvTZWM+TmygWV2dxJ1vIOzRC0h4GvKhLEHuvJs0jgUFghwk3SmmaL/mQb737YZ0dBwfR68hLNZ5nNhtZ/mgVwy6gEVP7G
X-Gm-Message-State: AOJu0Yxsf0iQDagf5D3f2wGX+vFRineIE+acwP6l/O6aE7u0cZ015RXJ
	0y9Utlv/CX6FF/Cf2LUm4/HmOzTq1VGywidHtheAzavmRAbJe6tD62jlOEwN0DSOpOEQeigbZ9e
	VUdwMfGCJnUP2o+HSJzVy4rCVIxlqsz8wWl2J4Q==
X-Google-Smtp-Source: AGHT+IFTUPK3REgvGdMgOwGApDJXWXHwEqfkXjMrnKsgvS0JKy+X2AS1/dTWFN/mLB8J3aVxZ0Rh0sVUHLgSm3wYrPg=
X-Received: by 2002:a19:f70b:0:b0:513:b90f:f4dd with SMTP id
 z11-20020a19f70b000000b00513b90ff4ddmr352775lfe.49.1712700707477; Tue, 09 Apr
 2024 15:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403080452.1007601-1-atishp@rivosinc.com> <20240403080452.1007601-21-atishp@rivosinc.com>
 <20240405-d1a4cb9a441a05a9d2f8b1c8@orel> <976411ab-6ddf-4b10-8e13-1575928415ce@rivosinc.com>
 <20240409-dd055c3d08e027cf2a5cb4dc@orel>
In-Reply-To: <20240409-dd055c3d08e027cf2a5cb4dc@orel>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Tue, 9 Apr 2024 15:11:36 -0700
Message-ID: <CAHBxVyEh0K5b0SdN-asrOuuggBztZ-mjCoOR=EC067pURRg3aA@mail.gmail.com>
Subject: Re: [PATCH v5 20/22] KVM: riscv: selftests: Add SBI PMU selftest
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:01=E2=80=AFAM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Mon, Apr 08, 2024 at 05:37:19PM -0700, Atish Patra wrote:
> > On 4/5/24 05:50, Andrew Jones wrote:
> > > On Wed, Apr 03, 2024 at 01:04:49AM -0700, Atish Patra wrote:
> > > ...
> > > > +static void test_pmu_basic_sanity(void)
> > > > +{
> > > > + long out_val =3D 0;
> > > > + bool probe;
> > > > + struct sbiret ret;
> > > > + int num_counters =3D 0, i;
> > > > + union sbi_pmu_ctr_info ctrinfo;
> > > > +
> > > > + probe =3D guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
> > > > + GUEST_ASSERT(probe && out_val =3D=3D 1);
> > > > +
> > > > + num_counters =3D get_num_counters();
> > > > +
> > > > + for (i =3D 0; i < num_counters; i++) {
> > > > +         ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_IN=
FO, i,
> > > > +                         0, 0, 0, 0, 0);
> > > > +
> > > > +         /* There can be gaps in logical counter indicies*/
> > > > +         if (ret.error)
> > > > +                 continue;
> > > > +         GUEST_ASSERT_NE(ret.value, 0);
> > > > +
> > > > +         ctrinfo.value =3D ret.value;
> > > > +
> > > > +         /**
> > > > +          * Accesibillity check of hardware and read capability of=
 firmware counters.
> > >
> > > Accessibility
> > >
> >
> > Fixed it.
> >
> > > > +          * The spec doesn't mandate any initial value. No need to=
 check any value.
> > > > +          */
> > > > +         read_counter(i, ctrinfo);
> > > > + }
> > > > +
> > > > + GUEST_DONE();
> > > > +}
> > > > +
> > > > +static void run_vcpu(struct kvm_vcpu *vcpu)
> > > > +{
> > > > + struct ucall uc;
> > > > +
> > > > + vcpu_run(vcpu);
> > > > + switch (get_ucall(vcpu, &uc)) {
> > > > + case UCALL_ABORT:
> > > > +         REPORT_GUEST_ASSERT(uc);
> > > > +         break;
> > > > + case UCALL_DONE:
> > > > + case UCALL_SYNC:
> > > > +         break;
> > > > + default:
> > > > +         TEST_FAIL("Unknown ucall %lu", uc.cmd);
> > > > +         break;
> > > > + }
> > > > +}
> > > > +
> > > > +void test_vm_destroy(struct kvm_vm *vm)
> > > > +{
> > > > + memset(ctrinfo_arr, 0, sizeof(union sbi_pmu_ctr_info) * RISCV_MAX=
_PMU_COUNTERS);
> > > > + counter_mask_available =3D 0;
> > > > + kvm_vm_free(vm);
> > > > +}
> > > > +
> > > > +static void test_vm_basic_test(void *guest_code)
> > > > +{
> > > > + struct kvm_vm *vm;
> > > > + struct kvm_vcpu *vcpu;
> > > > +
> > > > + vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> > > > + __TEST_REQUIRE(__vcpu_has_sbi_ext(vcpu, KVM_RISCV_SBI_EXT_PMU),
> > > > +                            "SBI PMU not available, skipping test"=
);
> > > > + vm_init_vector_tables(vm);
> > > > + /* Illegal instruction handler is required to verify read access =
without configuration */
> > > > + vm_install_exception_handler(vm, EXC_INST_ILLEGAL, guest_illegal_=
exception_handler);
> > >
> > > I still don't see where the "verify" part is. The handler doesn't rec=
ord
> > > that it had to handle anything.
> > >
> >
> > The objective of the test is to ensure that we get an illegal instructi=
on
> > without configuration.
>
> This part I guessed.
>
> > The presence of the registered exception handler is
> > sufficient for that.
>
> This part I disagree with. The handler may not be necessary and not run i=
f
> we don't get the ILL. Usually when I write tests like these I set a
> boolean in the handler and check it after the instruction which should
> have sent us there to make sure we did indeed go there.
>

Ahh I got your point now. That makes sense. Since it was just a sanity test=
,
I hadn't put the boolean check earlier. But you are correct about bugs
in kvm code which wouldn't
generate an expected ILL .

I have added it. Thanks for the suggestion :)

> >
> > The verify part is that the test doesn't end up in a illegal instructio=
n
> > exception when you try to access a counter without configuring.
> >
> > Let me know if you think we should more verbose comment to explain the
> > scenario.
> >
>
> With a boolean the test code will be mostly self documenting, but a short
> comment saying why we expect the boolean to be set would be good too.
>
> Thanks,
> drew
>
> >
> > > > +
> > > > + vcpu_init_vector_tables(vcpu);
> > > > + run_vcpu(vcpu);
> > > > +
> > > > + test_vm_destroy(vm);
> > > > +}
> > > > +
> > > > +static void test_vm_events_test(void *guest_code)
> > > > +{
> > > > + struct kvm_vm *vm =3D NULL;
> > > > + struct kvm_vcpu *vcpu =3D NULL;
> > > > +
> > > > + vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> > > > + __TEST_REQUIRE(__vcpu_has_sbi_ext(vcpu, KVM_RISCV_SBI_EXT_PMU),
> > > > +                            "SBI PMU not available, skipping test"=
);
> > > > + run_vcpu(vcpu);
> > > > +
> > > > + test_vm_destroy(vm);
> > > > +}
> > > > +
> > > > +int main(void)
> > > > +{
> > > > + test_vm_basic_test(test_pmu_basic_sanity);
> > > > + pr_info("SBI PMU basic test : PASS\n");
> > > > +
> > > > + test_vm_events_test(test_pmu_events);
> > > > + pr_info("SBI PMU event verification test : PASS\n");
> > > > +
> > > > + return 0;
> > > > +}
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > Thanks,
> > > drew
> >

