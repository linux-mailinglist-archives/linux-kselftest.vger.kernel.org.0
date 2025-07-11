Return-Path: <linux-kselftest+bounces-37177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37706B02822
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 02:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF19189DDBC
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 00:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A9A22F76E;
	Sat, 12 Jul 2025 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DNFaI9qo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5A2248B5
	for <linux-kselftest@vger.kernel.org>; Sat, 12 Jul 2025 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278409; cv=none; b=BcnvBm+jlxl5p5yV8YoGPPTggmBxRbDKeemg3PR49IeESleQW9+H3RJQeTbBPjtXg6TsGt16+R0LQpCNPbqX/1aIKL4/aBL4CP3KNo4Vz0OWHh2euj3TbkyFJm4X+5sfweDtvtDZAA6WLbFo+2rddhaJGb/lp7+uU+/5jEMfZyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278409; c=relaxed/simple;
	bh=PtSvbvn1QcCg0DBk1whBIsA/eSOY+4nsci4fAX624Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PU41jcSIT9B0WvFdh8mmoI6o0dTWUWqkYYMEkRDipJCMKuYlT7kv0DxspKho/uBLPLaKizGaMw+OOx14Y+mHxzz8tZziu05eQwdXyuhbB9D6wZZWqANlcra8syWNrlHwLrtxbpQOs0hKdlfNIimwsrd+ADpKTNQmzyQYEWuC8n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DNFaI9qo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-453663b7bf1so27505e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 17:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752278406; x=1752883206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tx2qCtcW1iHm6LrN7B3tW80PWrDcUeBrILrqk51qr+0=;
        b=DNFaI9qoFRmtnnYAALZUbvHEFHNYRoSrGUoWqp1T8a1Q1nCBUSxZhl6ihq77plrDj0
         W8KWM0qfj/wRK33eiXRvcFrrWSRGhIAYSKeQSp7LQcDCNFMZfNXva+tVt6k3V4Fcg9cr
         XUat4MWNLOMJMgpy+2CJ9LrD3HZAmWjzJmGTrBkR7j8pdv8c0x4AGvYpenDT76dQQPQd
         7NnVUbK2F9jRmEyi05PuNybiC0PXyFPI8INQsDypjRySaKwfTBaKXTamJDv897zV0QT4
         Camg+4vcbKqPmRZIgpRFQp5EtScf9gYpLNbbRbDv2bgalgqz6g0A05VD2mKTi3PXzFYL
         inow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752278406; x=1752883206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tx2qCtcW1iHm6LrN7B3tW80PWrDcUeBrILrqk51qr+0=;
        b=KtP+1xGAgmndLNP/bxu3GaVz8mLF24NRXsFznz9XlUDB8YJ76eBnxDuC9/p+dDp8XQ
         +6yYSIqK7fUfK7Jf+XZS+0DLFokPCCpA99RRgFmhEqjMyprXTJVcZUB/Ew7UNeM+x/Rz
         iD5II4JwjUilAaXreKQEHZPiEL1uoUxZABI/qV+AfGW5S5mCnCrWrFeUjyyNWFkalgmC
         Inn9eu8TUNb8XrUjcZE0kndglXeK1QSC/acnHpHLLPo2LkKXd5dEHtjwJOcuGEdSSSQx
         z1Kvzahnci0aHXhs359vk8Y8chayddJyDhsf75aMMnxbxOGHp0oSYM/mPgUGBGv4y8Xx
         o0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWH7WvI8OSAI4qcAJJ/aHhsnfFlkYmnbbpZljtOrc5BClRnRjxwfs1wVi7LaIVhfkQwJIGBcPPy3xkJYqHkprk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTfm7HhZAUey61qGaxw39wvOIWCN3xs3oIuVsKsceiFhbT0vpe
	qRPgzW0VzGoMpEubzGcCesKHjGA3jqmYQoQHVauMUsZbmA8FwbMoOa9OmI/MSICFVKqq6QsnPf1
	Y3YhtnrUSY4/NBRI7QddZPCSixCQ+v9267mv1ummZ
X-Gm-Gg: ASbGncucMiQC1o2v86wiHzSc2yQw5eC5y18ei9fkzt09nl9gv2eAyMtqvgxc4mno+sM
	82XeManEJxsetY8ONWqD02NOhk2cDn707OYIo2Nb3VziCknW2cqCGeeIHMM//ZglcY7wo0B7pLb
	wJJwisbtzX+U3rblZ4xXNsuYpnnD2vheOEFrsmg9p1P3xxjJAmeiPeG8SHE9Si1O/zOFBLkLHYT
	J4boprxA8HCMPM0u944nwI+A0Q3qZjaK23suw==
X-Google-Smtp-Source: AGHT+IGm/4nykkyL/t8NH+t513GwsEYgWr6SSPjErflvI3eUGlmuciPanbhrR0B98Q027GSJ0c2DKA/l/x09XDzmWT0=
X-Received: by 2002:a05:600c:5023:b0:453:79c3:91d6 with SMTP id
 5b1f17b1804b1-45604733553mr315825e9.1.1752278405508; Fri, 11 Jul 2025
 17:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604050902.3944054-1-jiaqiyan@google.com> <20250604050902.3944054-6-jiaqiyan@google.com>
 <aHFpt0qJF-Rvb2bS@linux.dev>
In-Reply-To: <aHFpt0qJF-Rvb2bS@linux.dev>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 11 Jul 2025 16:59:53 -0700
X-Gm-Features: Ac12FXxsGWdg2WMinw3VOi85RWYlMpcQBa3KtW7EiT-XKhADcP3_mP0w71DBbsg
Message-ID: <CACw3F525HQZ81riTQPuhR0moe8tNEst2AycwrGuM5xDq=oJGaw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] KVM: selftests: Test for KVM_CAP_INJECT_EXT_IABT
To: Oliver Upton <oliver.upton@linux.dev>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, duenwen@google.com, rananta@google.com, 
	jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 12:45=E2=80=AFPM Oliver Upton <oliver.upton@linux.d=
ev> wrote:
>
> On Wed, Jun 04, 2025 at 05:09:00AM +0000, Jiaqi Yan wrote:
> > Test userspace can use KVM_SET_VCPU_EVENTS to inject an external
> > instruction abort into guest. The test injects instruction abort at an
> > arbitrary time without real SEA happening in the guest VCPU, so only
> > certain ESR_EL1 bits are expected and asserted.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
>
> I reworked mmio_abort to be a general external abort test, can you add
> your test cases there in the next spin (arm64/external_aborts.c)?

For sure!

>
> Thanks,
> Oliver
>
> > ---
> >  tools/arch/arm64/include/uapi/asm/kvm.h       |  3 +-
> >  tools/testing/selftests/kvm/Makefile.kvm      |  1 +
> >  .../testing/selftests/kvm/arm64/inject_iabt.c | 98 +++++++++++++++++++
> >  3 files changed, 101 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/kvm/arm64/inject_iabt.c
> >
> > diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64=
/include/uapi/asm/kvm.h
> > index af9d9acaf9975..d3a4530846311 100644
> > --- a/tools/arch/arm64/include/uapi/asm/kvm.h
> > +++ b/tools/arch/arm64/include/uapi/asm/kvm.h
> > @@ -184,8 +184,9 @@ struct kvm_vcpu_events {
> >               __u8 serror_pending;
> >               __u8 serror_has_esr;
> >               __u8 ext_dabt_pending;
> > +             __u8 ext_iabt_pending;
> >               /* Align it to 8 bytes */
> > -             __u8 pad[5];
> > +             __u8 pad[4];
> >               __u64 serror_esr;
> >       } exception;
> >       __u32 reserved[12];
> > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/s=
elftests/kvm/Makefile.kvm
> > index 9eecce6b8274f..e6b504ded9c1c 100644
> > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > @@ -149,6 +149,7 @@ TEST_GEN_PROGS_arm64 +=3D arm64/arch_timer_edge_cas=
es
> >  TEST_GEN_PROGS_arm64 +=3D arm64/debug-exceptions
> >  TEST_GEN_PROGS_arm64 +=3D arm64/host_sve
> >  TEST_GEN_PROGS_arm64 +=3D arm64/hypercalls
> > +TEST_GEN_PROGS_arm64 +=3D arm64/inject_iabt
> >  TEST_GEN_PROGS_arm64 +=3D arm64/mmio_abort
> >  TEST_GEN_PROGS_arm64 +=3D arm64/page_fault_test
> >  TEST_GEN_PROGS_arm64 +=3D arm64/psci_test
> > diff --git a/tools/testing/selftests/kvm/arm64/inject_iabt.c b/tools/te=
sting/selftests/kvm/arm64/inject_iabt.c
> > new file mode 100644
> > index 0000000000000..0c7999e5ba5b3
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/arm64/inject_iabt.c
> > @@ -0,0 +1,98 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * inject_iabt.c - Tests for injecting instruction aborts into guest.
> > + */
> > +
> > +#include "processor.h"
> > +#include "test_util.h"
> > +
> > +static void expect_iabt_handler(struct ex_regs *regs)
> > +{
> > +     u64 esr =3D read_sysreg(esr_el1);
> > +
> > +     GUEST_PRINTF("Handling Guest SEA\n");
> > +     GUEST_PRINTF("  ESR_EL1=3D%#lx\n", esr);
> > +
> > +     GUEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_IABT_CUR);
> > +     GUEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
> > +
> > +     GUEST_DONE();
> > +}
> > +
> > +static void guest_code(void)
> > +{
> > +     GUEST_FAIL("Guest should only run SEA handler");
> > +}
> > +
> > +static void vcpu_run_expect_done(struct kvm_vcpu *vcpu)
> > +{
> > +     struct ucall uc;
> > +     bool guest_done =3D false;
> > +
> > +     do {
> > +             vcpu_run(vcpu);
> > +             switch (get_ucall(vcpu, &uc)) {
> > +             case UCALL_ABORT:
> > +                     REPORT_GUEST_ASSERT(uc);
> > +                     break;
> > +             case UCALL_PRINTF:
> > +                     ksft_print_msg("From guest: %s", uc.buffer);
> > +                     break;
> > +             case UCALL_DONE:
> > +                     ksft_print_msg("Guest done gracefully!\n");
> > +                     guest_done =3D true;
> > +                     break;
> > +             default:
> > +                     TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
> > +             }
> > +     } while (!guest_done);
> > +}
> > +
> > +static void vcpu_inject_ext_iabt(struct kvm_vcpu *vcpu)
> > +{
> > +     struct kvm_vcpu_events events =3D {};
> > +
> > +     events.exception.ext_iabt_pending =3D true;
> > +     vcpu_events_set(vcpu, &events);
> > +}
> > +
> > +static void vcpu_inject_invalid_abt(struct kvm_vcpu *vcpu)
> > +{
> > +     struct kvm_vcpu_events events =3D {};
> > +     int r;
> > +
> > +     events.exception.ext_iabt_pending =3D true;
> > +     events.exception.ext_dabt_pending =3D true;
> > +
> > +     ksft_print_msg("Injecting invalid external abort events\n");
> > +     r =3D __vcpu_ioctl(vcpu, KVM_SET_VCPU_EVENTS, &events);
> > +     TEST_ASSERT(r && errno =3D=3D EINVAL,
> > +                 KVM_IOCTL_ERROR(KVM_SET_VCPU_EVENTS, r));
> > +}
> > +
> > +static void test_inject_iabt(void)
> > +{
> > +     struct kvm_vcpu *vcpu;
> > +     struct kvm_vm *vm;
> > +
> > +     vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> > +
> > +     vm_init_descriptor_tables(vm);
> > +     vcpu_init_descriptor_tables(vcpu);
> > +
> > +     vm_install_sync_handler(vm, VECTOR_SYNC_CURRENT,
> > +                             ESR_ELx_EC_IABT_CUR, expect_iabt_handler)=
;
> > +
> > +     vcpu_inject_invalid_abt(vcpu);
> > +
> > +     vcpu_inject_ext_iabt(vcpu);
> > +     vcpu_run_expect_done(vcpu);
> > +
> > +     kvm_vm_free(vm);
> > +}
> > +
> > +int main(void)
> > +{
> > +     test_inject_iabt();
> > +     return 0;
> > +}
> > --
> > 2.49.0.1266.g31b7d2e469-goog
> >

