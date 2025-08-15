Return-Path: <linux-kselftest+bounces-39048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C50B277C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 06:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379AF3AB40E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 04:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0945C1C8616;
	Fri, 15 Aug 2025 04:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jb03uXgm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF8184E
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 04:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755232328; cv=none; b=Cejaczx3SGkDTwgJ9mIolkJp4KI2G9xNdnyvbbPq8QHFvSDOqj/qTzI1zrhBaKtOJ0AhX21KZm1f3f5OoBVTUgcyAjpV0lMeoMZluL/EkGftO9X8R5dkI7gcWYb9WECe8dself9h68D8tM3hyu884enS4hQNxpSjhHNyXSpB+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755232328; c=relaxed/simple;
	bh=ZrNGdDa3ue2pXZ7p4mCgz63fzMgbaYzPSvRgN66XhtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXZMad9+ZyDrSMA7KzIGTLr0YW2Xd04k3ukZtV2vQCmxalXC1DwvwZO07Esu5mP9QwMvZaMtoK7A2xFG/EwyUseIvOO0nCij/YakvLb3OjUEX1H1BVoBk9hLJdIhPhycU3Ykce0OI2zqS6oX/c0MFIaALQAiAPrP3bHU/pKz7Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jb03uXgm; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b0bf08551cso143301cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 21:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755232326; x=1755837126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vphq+KdVGQBHDleeYMXLhEN4hWNJK2UKgGf0Gk0kNNA=;
        b=jb03uXgm3WzytuhEHVyuOFqcC9m/Qsf9DWsPR+uomXYkAyZqQyw289KD0vpHV74hfE
         NT8tuo2dNy+kHmqyTWFAaAZn+GLVHa6u3tQe4T6CiGvVMJfKGXLdKSy5xoGg+cN1hA+A
         dl5sH3SSEGnW9LF3C3VZI59nRX7nkk3aHKpeUUgtTDTyLf4yhLN8wtswMom6zFBdpJHY
         nFcjPKgzsA/HiutyYgKHJD0oeZOriRh6CGftM+H7I8TfD4bYYRa+izwrA/IXCoSPOihV
         3L6Dw+PBzzGtyIw7HzEhQGp/rMMFKZQZLfIRPlke51zBaRRmO+AnjMCNnMcrvAyp9I/N
         R64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755232326; x=1755837126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vphq+KdVGQBHDleeYMXLhEN4hWNJK2UKgGf0Gk0kNNA=;
        b=QgcI0plaCqSX3gglsfYJSWguyU2lLO4vBTTq+JN7fx7uv++cgIbzkUqW3kFb6uDohe
         /ld6HULE7nwNY12uyorbNNVysfzrlkfNIWOciqfuiaEJx1+o6algu9h/UPAFXcquQZ3O
         UGgVWGKwBRCalDV0VmSXwESTSyNsTjbtoeBuEsifWt1w2G6CsIQ6i9VDvsLOZj0hAfEz
         wfl2rHTI5kjKD6qC14lLuTDzkRfSbIBWthVxm+bxsulCNCBJF2e5l0MGLBWZdxKUJ3JO
         Zl8y2Ovyzg0qMB3uoB8dqr4TMyOy9bV1hDtaIjNLyF2+zCaXp/PX1Um2e+6FWwg3Lp5a
         7wyQ==
X-Gm-Message-State: AOJu0YwssgMDmSQuaorB7GtPxxy9033t6+cLll6V6RMwKAipDOL7HTML
	ASWg5ofDkV2GZ0QgHli7JmD1RLQZwf/v3qx9ZniNSvrqp66iGaVcCanwE35jIYE0g5kYkj60AAg
	G6lqxBRW+tsy3qrMNvNiOE+do5l+n4TYdxWDAOq69
X-Gm-Gg: ASbGncuYeCXW+LnuO/8won1eCblw3BOkobypezPUgb31pA/lr52+aBZYeI/n0sOcEZU
	v24FoT6QnTugoIs+EZ4qzxJKGqfTgjAyh7esl2tXvOpv/gqPYwIs4LuAVCpi/VEbVF4XoBbVIok
	+xu7l8S18p/c68DPfT3IyZsOZyapCHY/xCrTC2rMNCeJx/H8SmKxgREmx03DDMpa0FVM0jgedqW
	s4cS39Zrp3AF2RI8uYb0KoUURFnu0PPI1k4y/7uGCAyfA==
X-Google-Smtp-Source: AGHT+IFnROl57LOIo9VPRxxOkeG5UUxFhM748VBrThhMVODn1XycukQQxmqkPtifgt9g/+IDrdCECfZfwFk25dWIj7k=
X-Received: by 2002:a05:622a:1194:b0:4b0:f1f3:db94 with SMTP id
 d75a77b69052e-4b11b73e747mr1445661cf.5.1755232325910; Thu, 14 Aug 2025
 21:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-6-sagis@google.com>
 <aJo3ww82Ln-PxgGL@google.com>
In-Reply-To: <aJo3ww82Ln-PxgGL@google.com>
From: Sagi Shahar <sagis@google.com>
Date: Thu, 14 Aug 2025 23:31:55 -0500
X-Gm-Features: Ac12FXxKl3jb58UGowv2eTWXkzgtsssQat3t2ZOfCXUQ1j88a7mXr-l44I61YfE
Message-ID: <CAAhR5DF5RTT8nF6mwLQPePL01k-bXBLapZZ3uNLH01j1W4UjSQ@mail.gmail.com>
Subject: Re: [PATCH v8 05/30] KVM: selftests: Update kvm_init_vm_address_properties()
 for TDX
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:34=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Aug 07, 2025, Sagi Shahar wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> >
> > Let kvm_init_vm_address_properties() initialize vm->arch.{s_bit, tag_ma=
sk}
> > similar to SEV.
> >
> > Set shared bit position based on guest maximum physical address width
> > instead of maximum physical address width, because that is what KVM
> > uses,
>
> "because KVM does it" is not an acceptable explanation.
>
> > refer to setup_tdparams_eptp_controls(), and because maximum physical
> > address width can be different.
> >
> > In the case of SRF, guest maximum physical address width is 48 because =
SRF
> > does not support 5-level EPT, even though the maximum physical address
> > width is 52.
>
> Referencing a specific Intel microarchitecture is not proper justificatio=
n for
> why something is supported/legal/correct.  Using its three-letter acronym=
 is
> just icing on the cake.
>
> > Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >  tools/testing/selftests/kvm/lib/x86/processor.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/te=
sting/selftests/kvm/lib/x86/processor.c
> > index d082d429e127..5718b5911b0a 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> > @@ -1166,10 +1166,19 @@ void kvm_get_cpu_address_width(unsigned int *pa=
_bits, unsigned int *va_bits)
> >
> >  void kvm_init_vm_address_properties(struct kvm_vm *vm)
> >  {
> > +     uint32_t gpa_bits =3D kvm_cpu_property(X86_PROPERTY_GUEST_MAX_PHY=
_ADDR);
> > +
> >       if (is_sev_vm(vm)) {
> >               vm->arch.sev_fd =3D open_sev_dev_path_or_exit();
> >               vm->arch.c_bit =3D BIT_ULL(this_cpu_property(X86_PROPERTY=
_SEV_C_BIT));
> >               vm->gpa_tag_mask =3D vm->arch.c_bit;
> > +     } else if (vm->type =3D=3D KVM_X86_TDX_VM) {
>
> Please add an is_tdx_vm() helper.
>
> > +             TEST_ASSERT(gpa_bits =3D=3D 48 || gpa_bits =3D=3D 52,
> > +                         "TDX: bad X86_PROPERTY_GUEST_MAX_PHY_ADDR val=
ue: %u", gpa_bits);
> > +             vm->arch.sev_fd =3D -1;
> > +             vm->arch.s_bit =3D 1ULL << (gpa_bits - 1);
> > +             vm->arch.c_bit =3D 0;
>
> The VM is zero-initialized, no need to set c_bit.
>
> > +             vm->gpa_tag_mask =3D vm->arch.s_bit;
> >       } else {
> >               vm->arch.sev_fd =3D -1;
>
> I think it makes sense to set sev_fd to -1 by default instead of duplicat=
ing the
> non-SEV logic into all non-SEV paths.  SEV VMs will write it twice, but t=
hat's a
> non-issue.  E.g.
>
>         vm->arch.sev_fd =3D -1;
>
>         if (is_sev_vm(vm)) {
>                 vm->arch.sev_fd =3D open_sev_dev_path_or_exit();
>                 vm->arch.c_bit =3D BIT_ULL(this_cpu_property(X86_PROPERTY=
_SEV_C_BIT));
>                 vm->gpa_tag_mask =3D vm->arch.c_bit;
>         } else if (is_tdx_vm(vm)) {
>                 TEST_ASSERT(gpa_bits =3D=3D 48 || gpa_bits =3D=3D 52,
>                             "TDX: bad X86_PROPERTY_GUEST_MAX_PHY_ADDR val=
ue: %u", gpa_bits);
>                 vm->arch.s_bit =3D 1ULL << (gpa_bits - 1);
>                 vm->gpa_tag_mask =3D vm->arch.s_bit;
>         }
>

Thanks for all the suggestions. I will incorporate them in the next version=
.

