Return-Path: <linux-kselftest+bounces-40991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC8B49AFC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 22:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427CD18918D7
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 20:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6648F2D9ED1;
	Mon,  8 Sep 2025 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Arn0WWRQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9555C1E500C;
	Mon,  8 Sep 2025 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757363055; cv=none; b=G5uJmbXryEoiYd5z3EYLu5DilyQhlcFxrwHUV5SqYrCJA0tLUwgjRiVnWibPXcAlt+o6v4/KLrk/xTWlesMXr7PIKepDZ6IjjnYc2ConhDMqyZoGc08wUwSqpMg4P/xuPBldikLVOUdRtZUcbWl6zIAUOvhiHfJ2AmpXp0XS+Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757363055; c=relaxed/simple;
	bh=QXFdYsHOjGrAQWv2UNUlbH0J98PoVVVePcAINMQxDgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aE8Ymf7PG9V/3YluO5mOHPzNKPFzS//r/hsWDuNSB78g0LKe9ltieoHv2cziraOSszibhtxvrX0qUJlEPrRoeaJV/9NRDtUifzDxlUsQsaf0Xa/SfRWIrDxhp6p2VAINQ0mZNFNoH4fAaVTMyjJFzjtdTifwI9SYNz0oxPrHong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Arn0WWRQ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f7a34fb35so4792219e87.1;
        Mon, 08 Sep 2025 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757363052; x=1757967852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ2TUV+yNwTtqAUmSlgTNH8sd22jKGCG5+ClH2K636c=;
        b=Arn0WWRQHdzUaAJ+eJnNnWIpNvhj3Biww0qtXU6Hl6AB1mugmnXfZ8vbn66t6f8icM
         YU1S1xJZbUryQQ5OmVQrQDlcxaGPG98vkLAeYLJ57exXMx+DFeFjJQPKoY5nlH1MVm/q
         0G99fL7kObLJTI+52EJT1BlKwkzMYy8pyzmbL1KSZR6WchiysOWYcy+akZrOsqllYXBa
         04pTnXtnsUmfRrZaMXyNOqwryIsKdcnsZnXlxzB4YDK1nc1M1+zuu/jPFgMxGxTkSTbO
         KrApH3nuIBpsQdQHGkiQOFV4gyrLsJt88O/D4qurVoC+Hx228sj2lCUEWG2UxPHV6kGc
         66Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757363052; x=1757967852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZ2TUV+yNwTtqAUmSlgTNH8sd22jKGCG5+ClH2K636c=;
        b=gja1u1nmuaxLuTj3P2EBeicyxRxTL8Tnwh58MCRkfH/Lys4y1Id5PASf87kYbiOMAo
         cpLvj2HdNmTgdVhv5myuEARuE2BuJTo90RH3gqVuJaUlVSIzFZb9JL9WAc+v85QWh9o3
         2o9rJugGmC7poB0drKmBBqGA6wMfupSBJG6W5dbO6HiQDcKyb3i4RMFyjAxp6LDf+7FK
         77oUwAaL0Jbd6j4fpDGKJ75d0rSDDaI2e9UVRovnZ2bxC3bLNep/IW4FvDd6RgDU9G9b
         nCT9t66NbD2p7vscFVeeNNnEBFS2rDl9zbFel5xUs0tox4WdOZRQ4pz+YcfHq/Xczp30
         uzhA==
X-Forwarded-Encrypted: i=1; AJvYcCVLzJiBbztSeSdAskCPziwxsyWT0mdZf7IPQ0VynWaRD31MkHl4Mag9odmEFSYgYjHHHF8=@vger.kernel.org, AJvYcCXQ2DTNT8IGKkSaJiHs6GugI+CeEe/ZQENRWxTcgAqHzIev4VSjcMXptYbo8A52Er9MeJiizKMCJSQCdpZ/irQq@vger.kernel.org, AJvYcCXZj6Lg4rRsiymQwXeupPaa6bAEFBNn3wcBmLYNxioMQMND42dhVPh3LpVXgTEHoHRMUK+okOQUF2sn15bW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4epZW8NPHF4FyrGFc34gvcYaNPplJjum2G0UqeG2sY4gGrv9R
	nv+rYQ7r0RwdZpI2PbnLTgx4enSnqbVAcYGsWnDkGA69Ba+HpTav88fU23sK60ugI5jYgmt2T4C
	TvDNUJcRno+nD5W0HdocYmSmXn6wSdK8=
X-Gm-Gg: ASbGncuH0xRHPaHTFZqp8wf8ZmYTmhJeAZaqsXbQp87HvduZZIeXU2JvelcsZNpuW9P
	dhYAikOyz7ScOURP1rXI5lX5heIT6mDb+qjx6BJRMkbxkv02F0mq+3E596hPcqzMmCHJvDYBQU9
	g1C30MmZz6hesgGLwpWqtsU2am/exQuWCMxA3yxlksrXOjgxNvt8sIoivwDEzVU2UvqjkRlE2Mg
	hdDlJY=
X-Google-Smtp-Source: AGHT+IEweKipaGVYkdkyd6OiRhTHMwwOqDRdqJr/8Z0s3/XGYL2tRNOH8u5INckzxdTYBRK8yvOVnbhnFMDPvc0canI=
X-Received: by 2002:a05:6512:2215:b0:55c:ad9d:5c10 with SMTP id
 2adb3069b0e04-56262192e52mr2574655e87.52.1757363050650; Mon, 08 Sep 2025
 13:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906184324.89974-1-hsukrut3@gmail.com> <aL7ogKtOUi2py1jx@google.com>
In-Reply-To: <aL7ogKtOUi2py1jx@google.com>
From: sukrut heroorkar <hsukrut3@gmail.com>
Date: Mon, 8 Sep 2025 22:23:59 +0200
X-Gm-Features: AS18NWD3rYhP-Ji3PL2Yxd1r4Omj1qvqh56i8RKvTDqgWhZ5hz83AQXCVbW3R_8
Message-ID: <CAHCkknocRNK=DWnmLVhrMDgBP6nW08HM=c6wGnHrjR1-Fbncnw@mail.gmail.com>
Subject: Re: [PATCH] selftests/kvm: Use vcpus count instead of hardcoded 0xff
 in test_icr
To: Sean Christopherson <seanjc@google.com>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)" <kvm@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Mon, Sep 8, 2025 at 4:30=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Sat, Sep 06, 2025, Sukrut Heroorkar wrote:
> > Replace the hardcoded 0xff in test_icr() with the actual number of vcpu=
s
> > created for the vm. This address the existing TODO and keeps the test
> > correct if it is ever run with multiple vcpus.
>
> The TODO is stale, it was resolved by commit 376bc1b458c9 ("KVM: selftest=
s: Don't
> assume vcpu->id is '0' in xAPIC state test"), I/we just forgot to delete =
the
> comment.
>
> > Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> > ---
> >  tools/testing/selftests/kvm/x86/xapic_state_test.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/kvm/x86/xapic_state_test.c b/tools=
/testing/selftests/kvm/x86/xapic_state_test.c
> > index fdebff1165c7..4af36682503e 100644
> > --- a/tools/testing/selftests/kvm/x86/xapic_state_test.c
> > +++ b/tools/testing/selftests/kvm/x86/xapic_state_test.c
> > @@ -56,6 +56,17 @@ static void x2apic_guest_code(void)
> >       } while (1);
> >  }
> >
> > +static unsigned int vm_nr_vcpus(struct kvm_vm *vm)
> > +{
> > +     struct kvm_vcpu *vcpu;
> > +     unsigned int count =3D 0;
> > +
> > +     list_for_each_entry(vcpu, &vm->vcpus, list)
> > +             count++;
> > +
> > +     return count;
> > +}
> > +
> >  static void ____test_icr(struct xapic_vcpu *x, uint64_t val)
> >  {
> >       struct kvm_vcpu *vcpu =3D x->vcpu;
> > @@ -124,7 +135,7 @@ static void test_icr(struct xapic_vcpu *x)
> >        * vCPUs, not vcpu.id + 1.  Arbitrarily use vector 0xff.
> >        */
> >       icr =3D APIC_INT_ASSERT | 0xff;
> > -     for (i =3D 0; i < 0xff; i++) {
> > +     for (i =3D 0; i < vm_nr_vcpus(vcpu->vm); i++) {
>
> This is wrong/undesirable.  The original code was:
>
>         for (i =3D vcpu->id + 1; i < 0xff; i++) {
>                 for (j =3D 0; j < 8; j++)
>                         __test_icr(vm, vcpu, i << (32 + 24) | APIC_INT_AS=
SERT | (j << 8));
>         }
>
> I.e. the _lower_ bound was nr_vcpus+1.  Regardless, as fixed by the aform=
entioned
> commit, using the number of vCPUs in any capacity is simply wrong.  The s=
tale
> comment just needs to be deleted.:

Thanks for the clarification. I will send a patch removing the stale
TODO comment.
>
> >               if (i =3D=3D vcpu->id)
> >                       continue;
> >               for (j =3D 0; j < 8; j++)
> > --
> > 2.43.0
> >

