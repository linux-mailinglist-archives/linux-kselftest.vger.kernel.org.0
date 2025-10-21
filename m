Return-Path: <linux-kselftest+bounces-43694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D85EBF9442
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084D53AE0A2
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163E12C3745;
	Tue, 21 Oct 2025 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PpV8dXvS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6C2BEC31
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090033; cv=none; b=msIxXj5SwM6Dcmb0/mK8jCJq6g9iPMJ/z6t/CsZsN4Lm070R6ULxYyozDsIKGQN3XdQ5f/1qeWv22b9hoteqG8vvcZbGFpCUCqExjVSsKYypmtOYYw9OtelCY8ZGQ5Y2h6DoJvrtoyFGpzP9Bu8fB9GEDAhE08n2eP/TyDGlTPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090033; c=relaxed/simple;
	bh=24THtw9KQotm0JJaeG9x+QKYl5xdIQG4nQ13X99W/ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEWTbUSlp9wf1qsKm09wZEMzBGbxIUfgrep54Bbc18GfC79a95GCV501Yi6uKEJGHkRbc5BeT+3ZwK3QT6Imk7ObnGXJlnqdbaU73ApoNkKUxOoiGjbJZH5Hy8t2mppGnehEL6mast75qZtSmyrRGv+4861eU2kR9UhbbDLrkKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PpV8dXvS; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ea12242d2eso101701cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761090029; x=1761694829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIH2P6B80VZ2nxYWUFgW0L+iNtA4rO36PgliR7tGBx4=;
        b=PpV8dXvS2AewLkR5KAIwlbJByUSIUa24++V9v/dXxLk3X+KK5m4b4zmP1x8c8QiOGO
         3t6Nl+36UjCUhBrdQ7YH5Hocu8Y0lYaAc+c+SSG/tpxJ/EpZXTSTGefOUOk63iFBwCXl
         ffXB1Zciq2v0XfonuqTGhyzAPxfQadMIuXiCG0heBt26rozjWasBFoPpQBYkTlr4y6cP
         FYel+IjWpKpvgmKWZ3GwuihMR70SxTgKwSY2QO8SRlvXH9z85lcuB9l52MVl8k3T+nYQ
         j9hSnn6w8yS58K66wzDo3s0QCtygWGyXgo9w89dddulfL4BotATuoC7f8GQ1oveApXkk
         awkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090029; x=1761694829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIH2P6B80VZ2nxYWUFgW0L+iNtA4rO36PgliR7tGBx4=;
        b=c5vnhbfFNGRj96v0cnzb2dMsZwwZ0+ON5HkEOcuLsQ5yi326vfFqV+TOtUs/XaWxy9
         a/sRjSaDruBWbz94ZrJEo0C6rMcXOOjLU2GyAVNc2LC+bbZEJdaRmmiGpkDgZVmwd3ye
         GbkHeAbbxucxaIIuVRFqbJ/BFBk+ZzT/ciKsTvVFnlxnpGwa9v85l7jh1Jm8A8RNc5qo
         qQLkNRzBJ5DbdpWFzWCtRKkx9XTkM2X62z61koAlfocDLgq8Y0mXZXKi3xQBYauLSwXJ
         6UpDA2SH7dmCgLrfW8orttWHTaw9/IfMHG0NNKhSb7md5USVAaUGFCWck1bqJix+NQZO
         XmIg==
X-Forwarded-Encrypted: i=1; AJvYcCXbifpcmfDy3bXlPdAxvgN3oaW8BsHtxs6l7PHsiA30knfbAsppGKftY8RjBpELAsIw1L5Z0BeHNhh/LSRDGd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrG/1o6drB/V93I+yuk8c8FjXcKBcr19x+P98WgxC9mLi+p9eP
	Z0MLalQPCUQ7QbOLJYdX7fy1no8lu1pzFdDZa+ZsbM8OizkdxKlpvqPfRX9njruo8/OxLkXP6TI
	G2P+eu3+I5Iwc/D5/hu4z1peQnd6niK3318vj5N2D
X-Gm-Gg: ASbGnctHx78DlP8fkIUF2JGkEJeYUlb2KJTHq7WiMqZJnK6fRiR89vO35ihYUWGIRSp
	TbMJb8TlQ8nFlrsnYs7zFoAv2OYqqvkyClV6xJjwIy4GSE5MomvCkvE2P7y2CelRIay2D/rtg35
	Q6B1kg+BmEz6K/aIJsEfPiLezWoQkEJmiOqvbZIxuqOBQahbjwP6Ok6+Ai7AkyF3W42RNOVAJUn
	34GOKlSkHql1bxRvhDZvsGwl3ubhWNq7TYguWeXQx3TCrqGhNu0+wFj28ypjosRr4SRfJQ=
X-Google-Smtp-Source: AGHT+IHoH7UQ5IYUBKzxkx5zGkIHMIpVhLUrhL8SwWlsHSxZ6PC5HZPKI/StzjnH0CQlOVgzaMRyybaCwvaayAQwiM8=
X-Received: by 2002:a05:622a:1f12:b0:4e7:1e07:959c with SMTP id
 d75a77b69052e-4eb73a65b01mr3412081cf.10.1761090028632; Tue, 21 Oct 2025
 16:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917215031.2567566-1-jmattson@google.com> <20250917215031.2567566-5-jmattson@google.com>
 <4owz4js4mvl4dohgkydcyrdhh2j2xblbwbo7zistocb4knjzdo@kvrzl7vmvg67>
In-Reply-To: <4owz4js4mvl4dohgkydcyrdhh2j2xblbwbo7zistocb4knjzdo@kvrzl7vmvg67>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 21 Oct 2025 16:40:14 -0700
X-Gm-Features: AS18NWD5cc8imKkj8dT6YcsyQa2wPp5aTZYLjiwB4t7ZRHFEHQz3XPKi8X3MzPs
Message-ID: <CALMp9eRm+xH0b4TUMU3q8Wpo2uo6-OCaY7hD39dVeSm0fA+weA@mail.gmail.com>
Subject: Re: [PATCH 4/4] KVM: selftests: Add a VMX test for LA57 nested state
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 10:26=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev=
> wrote:
>
> On Wed, Sep 17, 2025 at 02:48:40PM -0700, Jim Mattson wrote:
> > Add a selftest that verifies KVM's ability to save and restore
> > nested state when the L1 guest is using 5-level paging and the L2
> > guest is using 4-level paging. Specifically, canonicality tests of
> > the VMCS12 host-state fields should accept 57-bit virtual addresses.
> >
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> > ...
> > +void guest_code(struct vmx_pages *vmx_pages)
> > +{
> > +     if (vmx_pages)
> > +             l1_guest_code(vmx_pages);
>
> I think none of the other tests do the NULL check. Seems like the test
> will actually pass if we pass vmx_pages =3D=3D NULL. I think it's better =
if
> we let L1 crash if we mess up the setup.

I'll drop the check in the next version.

> > +
> > +     GUEST_DONE();
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     vm_vaddr_t vmx_pages_gva =3D 0;
> > +     struct kvm_vm *vm;
> > +     struct kvm_vcpu *vcpu;
> > +     struct kvm_x86_state *state;
> > +     struct ucall uc;
> > +     int stage;
> > +
> > +     TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
> > +     TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_LA57));
> > +     TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
> > +
> > +     vm =3D vm_create_shape_with_one_vcpu(VM_SHAPE(VM_MODE_PXXV57_4K),=
 &vcpu,
> > +                                        guest_code);
> > +
> > +     /*
> > +      * L1 needs to read its own PML5 table to set up L2. Identity map
> > +      * the PML5 table to facilitate this.
> > +      */
> > +     virt_map(vm, vm->pgd, vm->pgd, 1);
> > +
> > +     vcpu_alloc_vmx(vm, &vmx_pages_gva);
> > +     vcpu_args_set(vcpu, 1, vmx_pages_gva);
> > +
> > +     for (stage =3D 1;; stage++) {
> > +             vcpu_run(vcpu);
> > +             TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> > +
> > +             switch (get_ucall(vcpu, &uc)) {
> > +             case UCALL_ABORT:
> > +                     REPORT_GUEST_ASSERT(uc);
> > +                     /* NOT REACHED */
> > +             case UCALL_SYNC:
> > +                     break;
> > +             case UCALL_DONE:
> > +                     goto done;
> > +             default:
> > +                     TEST_FAIL("Unknown ucall %lu", uc.cmd);
> > +             }
> > +
> > +             TEST_ASSERT(uc.args[1] =3D=3D stage,
> > +                         "Expected stage %d, got stage %lu", stage, (u=
long)uc.args[1]);
> > +             if (stage =3D=3D 1) {
> > +                     pr_info("L2 is active; performing save/restore.\n=
");
> > +                     state =3D vcpu_save_state(vcpu);
> > +
> > +                     kvm_vm_release(vm);
> > +
> > +                     /* Restore state in a new VM. */
> > +                     vcpu =3D vm_recreate_with_one_vcpu(vm);
> > +                     vcpu_load_state(vcpu, state);
> > +                     kvm_x86_state_cleanup(state);
>
> It seems like we only load the vCPU state but we don't actually run it
> after restoring the nested state. Should we have another stage and run
> L2 again after the restore? What is the current failure mode without
> 9245fd6b8531?

When everything works, we do actually run the vCPU again after
restoring the nested state. L1 has to execute GUEST_DONE() to exit
this loop.

Without commit 9245fd6b8531 ("KVM: x86: model canonical checks more
precisely"), the test fails with:

KVM_SET_NESTED_STATE failed, rc: -1 errno: 22 (Invalid argument)

(And, in that case, we do not re-enter the guest.)



> > +             }
> > +     }
> > +
> > +done:
> > +     kvm_vm_free(vm);
> > +     return 0;
> > +}
> > --
> > 2.51.0.470.ga7dc726c21-goog
> >

