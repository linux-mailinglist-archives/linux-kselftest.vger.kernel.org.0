Return-Path: <linux-kselftest+bounces-5552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4621F86B9C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 22:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9081F226CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 21:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E17F8627C;
	Wed, 28 Feb 2024 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="poRPXhfs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E747002C
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155193; cv=none; b=GX9JYPnqC9DxjuRVyN/6Dpdcur9g7Lw3eVFI4y/pTpNprefuiLBk0f307YnkS/HCFl6aJ0/yvA+Ap2KpwS6bHDMeHpKju7mXS6g1ABDa0qa/zwqTNlUs+ER23dYS90zjZtqPPfkVLPCih31bw7qwvdzIX4YttKgMjtMUa0tlSgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155193; c=relaxed/simple;
	bh=gk/MrBtcV7Nj4M6X2sQOVcKzwLMPmaE9N2JN751XURU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uqRvBqhGWyYAiGrRMWdyf3kkPAp9AzH9ilzqlvcKKqnuemfOp0m37V74pgOuBvzwYm9sj3mtn7k6l1SmHLIbOyBIPUiYa+Yc61qaObSZTnDmLb2iIWlZG7y1ijCofdhN5Wmot482lDI1yra7I3RNCBO7s1XTdN5Z1AParOVy9dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=poRPXhfs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608cf88048eso3880817b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 13:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709155190; x=1709759990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3lMvE57lAGMOn/5i5GUfHlWgJVlKCqOgZHHFIXT5YI=;
        b=poRPXhfsYkCniLxu2SKdSpdTc8kxYQFx268+jR6EGsyEEsUNkBSLHbI8qy4ZXOAELO
         Ygn0BdGKwB3A70aIzf1JPMv7vBbEFE8Re1J5rwL+kfhdMazmI/71c+ySjWteu/kEzZED
         dEmyXtOUe3gve0NgqXtGvDTppaVDyEv+r/DMj49nqVo6+lMCLonzFiL5vSQ2njXdSLuh
         yYd3bOsrd4eDJhAeSAHjtMX3qXkrVU1XlCGWvEvnBTzzcNiH46/KNb6R5KJSMSyP2pJE
         dyglx+6TLSZ/0mRg2ZnavTNyvDbv+0RWf3CI3fy5CmiwQihdR/PeI89ajk9MpWIcona9
         Z4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155190; x=1709759990;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I3lMvE57lAGMOn/5i5GUfHlWgJVlKCqOgZHHFIXT5YI=;
        b=qVtghbMXaXQQNfgisBO76KLnuTwqZQRJR81CM200LP9bHDZBZPFDdP1qS0IPpk5oYJ
         eihcAQS+fo1pMmijw6M7FK+0vMSMGXWn8FaN4oQP0rfszDNnSF/v0xDRngZvBgi5wT6C
         KXjccd3Kxx6J563xoTywBqvel1u8F5unqhzsJ1ESdrnlspwi6Sq1mLbpZStJt1p7aHLn
         nwWH9vYfsHIGSmIXcmRnhrJXoPCr95vm/l7/6W8zGcQtHn0PqwhDLx56mhzD3CGdf+rg
         RpqwwyWl5fxpUk3uMy6rdDeIG2ogN8n6dlMfDgRrkZtRR/SMw+8rf3fiPrp2EeBsjhZu
         jMQg==
X-Forwarded-Encrypted: i=1; AJvYcCXs+R/C7KjYdamraU/uIhHygqVD9TYeJks7Zw4vIbCp/1FnmMrIqFdrhV25P69andvq9rA2OTyZiwO0J6HaSLZby4M7lKxzr6vqzwMbSTos
X-Gm-Message-State: AOJu0Yyk1kbvTmq1Jd8M2C3lGrC7VhTrGbUd8z3AodmjuWrKaBGJs4Co
	40ygE8kk7dd5ErARdCXXCo2LRtG0Dqausr0l/JXcZPhDkMmPNHrqlzNxfuLA1/CFEY9KTnAbwYv
	JMA==
X-Google-Smtp-Source: AGHT+IGIb2EDaA1Xfc5xFJEWOVFhVtRT96S9AFF70n2hacpd3aAGkhz27VZdHFJQY6yEoiJnM3glwUpknsM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:338b:b0:609:22ea:f95e with SMTP id
 fl11-20020a05690c338b00b0060922eaf95emr59391ywb.4.1709155190409; Wed, 28 Feb
 2024 13:19:50 -0800 (PST)
Date: Wed, 28 Feb 2024 13:19:48 -0800
In-Reply-To: <Zd-JjBNCpFG5iDul@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208204844.119326-1-thuth@redhat.com> <20240208204844.119326-4-thuth@redhat.com>
 <501ac94d-11ab-4765-a25d-75013c021be6@sirena.org.uk> <Zd-JjBNCpFG5iDul@google.com>
Message-ID: <Zd-jdAtI_C_d_fp4@google.com>
Subject: Re: [PATCH v3 3/8] KVM: selftests: Move setting a vCPU's entry point
 to a dedicated API
From: Sean Christopherson <seanjc@google.com>
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Aishwarya TCV <aishwarya.tcv@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Oliver and/or Marc, question for y'all towards the bottom.

On Wed, Feb 28, 2024, Sean Christopherson wrote:
> On Wed, Feb 28, 2024, Mark Brown wrote:
> > On Thu, Feb 08, 2024 at 09:48:39PM +0100, Thomas Huth wrote:
> > > From: Sean Christopherson <seanjc@google.com>
> > >=20
> > > Extract the code to set a vCPU's entry point out of vm_arch_vcpu_add(=
) and
> > > into a new API, vcpu_arch_set_entry_point().  Providing a separate AP=
I
> > > will allow creating a KVM selftests hardness that can handle tests th=
at
> > > use different entry points for sub-tests, whereas *requiring* the ent=
ry
> > > point to be specified at vCPU creation makes it difficult to create a
> > > generic harness, e.g. the boilerplate setup/teardown can't easily cre=
ate
> > > and destroy the VM and vCPUs.
> >=20
> > With today's -next I'm seeing most of the KVM selftests failing on an
> > arm64 defconfig with:
> >=20
> > # =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
> > #   include/kvm_util_base.h:677: !ret
> > #   pid=3D735 tid=3D735 errno=3D9 - Bad file descriptor
> > #      1	0x0000000000410937: vcpu_set_reg at kvm_util_base.h:677 (discr=
iminator 4)
> > #      2	 (inlined by) vcpu_arch_set_entry_point at processor.c:370 (di=
scriminator 4)
> > #      3	0x0000000000407bab: vm_vcpu_add at kvm_util_base.h:981
> > #      4	 (inlined by) __vm_create_with_vcpus at kvm_util.c:419
> > #      5	 (inlined by) __vm_create_shape_with_one_vcpu at kvm_util.c:43=
2
> > #      6	0x000000000040187b: __vm_create_with_one_vcpu at kvm_util_base=
.h:892
> > #      7	 (inlined by) vm_create_with_one_vcpu at kvm_util_base.h:899
> > #      8	 (inlined by) main at aarch32_id_regs.c:158
> > #      9	0x0000007fbcbe6dc3: ?? ??:0
> > #     10	0x0000007fbcbe6e97: ?? ??:0
> > #     11	0x0000000000401f2f: _start at ??:?
> > #   KVM_SET_ONE_REG failed, rc: -1 errno: 9 (Bad file descriptor)
> >=20
> > and a bisect pointed to this commit which does look plausibly relevant.
> >=20
> > Note that while this was bisected with plain arm64 defconfig and the KV=
M
> > selftests fragment was not enabled, but enabling the KVM fragment gave
> > the same result as would be expected based on the options enabled by th=
e
> > fragment.  We're also seeing an alternative failure pattern where the
> > tests segfault when run in a different environment, I'm also tracking
> > that down but I suspect these are the same issue.
>=20
> Gah, my bad, I should have at least tested on ARM since I have easy acces=
s to
> such hardware.  If I can't figure out what's going wrong in the next few =
hours,
> I'll drop this series and we can try again for 6.10.
>=20
> Sorry :-/

/facepalm

The inner helper doesn't return the vCPU, and by dumb (bad) luck, selftests=
 end
up trying to use fd=3D0.

diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/te=
sting/selftests/kvm/lib/aarch64/processor.c
index ed4ab29f4fad..a9eb17295be4 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -386,6 +386,7 @@ static struct kvm_vcpu *__aarch64_vcpu_add(struct kvm_v=
m *vm, uint32_t vcpu_id,
        aarch64_vcpu_setup(vcpu, init);
=20
        vcpu_set_reg(vcpu, ARM64_CORE_REG(sp_el1), stack_vaddr + stack_size=
);
+       return vcpu;
 }
=20
 struct kvm_vcpu *aarch64_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,

I'll squash the above and force push.


In my defense, I would have caught this when build-testing, as the compiler=
 does
warn...

  lib/aarch64/processor.c -o /usr/local/google/home/seanjc/go/src/kernel.or=
g/nox/tools/testing/selftests/kvm/lib/aarch64/processor.o
  lib/aarch64/processor.c: In function =E2=80=98__aarch64_vcpu_add=E2=80=99=
:
  lib/aarch64/processor.c:389:1: warning: no return statement in function r=
eturning non-void [-Wreturn-type]
    389 | }
        | ^
  At top level:
  cc1: note: unrecognized command-line option =E2=80=98-Wno-gnu-variable-si=
zed-type-not-at-end=E2=80=99 may have been intended to silence earlier diag=
nostics

but due to a different issue that is fixed in the kvm-arm tree[*], but not =
in mine,
I built without -Werror and didn't see the new warn in the sea of GUEST_PRI=
NTF
warnings.

Ugh, and I still can't enable -Werror, because there are unused functions i=
n
aarch64/vpmu_counter_access.c

  aarch64/vpmu_counter_access.c:96:20: error: unused function 'enable_count=
er' [-Werror,-Wunused-function]
  static inline void enable_counter(int idx)
                   ^
  aarch64/vpmu_counter_access.c:104:20: error: unused function 'disable_cou=
nter' [-Werror,-Wunused-function]
  static inline void disable_counter(int idx)
                   ^
  2 errors generated.
  make: *** [Makefile:278: /usr/local/google/home/seanjc/go/src/kernel.org/=
nox/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.o] Error 1
  make: *** Waiting for unfinished jobs....

  Commit 49f31cff9c533d264659356b90445023b04e10fb failed to build with 'mak=
e-clang make-arm make -j128'.

Oliver/Marc, any thoughts on how you want to fix the unused function warnin=
gs?
As evidenced by this goof, being able to compile with -Werror is super help=
ful.

And another question: is there any reason to not force -Werror for selftest=
s?

[*] https://lore.kernel.org/all/20240202234603.366925-1-seanjc@google.com

