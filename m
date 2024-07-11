Return-Path: <linux-kselftest+bounces-13597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E62EB92EC18
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 17:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1568B1C2363B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 15:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD3C16C86D;
	Thu, 11 Jul 2024 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2K6fI/n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BE816C856
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713444; cv=none; b=Cr1Qw4W11ak+wfcS+ppNjniZld69oPmbSR5FHDYrrTdpzEiPn8KT2M0QYVvXtu+z2un3gSUNo8nwqZFCVfA6tXkw7/8iN3ET8iH6LLPIswX2+OzOQaIPP9KAae+8W2ZXbkQyBrMzaoF4sjcOtJE8/RoA4JuHmHdaznL7qkyw51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713444; c=relaxed/simple;
	bh=omvGZOjrfOzXZVs/WIoBZ6izGXTZ8t0wIj+HOyMaW2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZ4bpJSX0Qs52JPWt25StOwe0MkJ70oXvPr+pqYPKSsZxtUkHo3SyT4AXWrX6EvcXZJzu+TcPt0A9NWO75Cws5kSE42eIlEEJ6eU42Mtt6tGQLQIxzfTCwf8LF82PnnSqaNFqwBzUgk7tH64sPZVa6ii2ihnX6pJvLUdkFWxNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2K6fI/n; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so14410a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720713441; x=1721318241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgL7ROjy5iOMPF0UW7tQZ1QpAAIOvTOyfKxpIJ4bmyo=;
        b=O2K6fI/nCDvwAJNz9R+ludgws7hTNYRViFPd0IH5gYY7nRfpr7pMU5NzQFm19tRqwL
         1Znv+VHceAXLizdV3DJOVJUbORlDiyIaHxkWBHNYsO8VaxXAFOXBjGM4KZyuFngJiPUY
         v/qGEV6KZ0jpUoz7xAVgw4/0I8KNkUeRiGrqGTQ9Nio9i6NpjtDK1eH36cxHv3s4zUMg
         sVTjDYCmM5LKS0AMj/nfRw7/1FcPGchDS53+KcxrOABwW7bP37mkEAQpELJJWB0zw8vo
         FjgB/6CSA0lroLHHEY8SlkQKXjVs19/fWQoitRxEznuZhwAq565LrzjjjlK4q8of/+kv
         2gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720713441; x=1721318241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgL7ROjy5iOMPF0UW7tQZ1QpAAIOvTOyfKxpIJ4bmyo=;
        b=qNK6FGF1YTvXKUuuE+aJ322p71tgc2vp7MRSXpgXt83BjGqofjZ0lp/gvwx4lel+rO
         Mi5G6m0GjSi9Sh3iaJNA7U5vkpqRuWMvCv1NQSvhav/i87twUFQqsYeH90ltJEBmcpwg
         yD33JXH9bO4mn9wc4vu/5R+0taD2plrU+xb6tozSnoUvVFR/geOQbdl1EH/hpCg3rBVK
         UBGG/mK15u4q4B3F4fv7TZjOvdJwhukRl5ln1FfTPcLMmTIAoiB8Hbm6UOTDp1+KSKma
         65w643gPWo4acrd8zTgRFR7R449IcJsAgY4MuvPiG3yYBvsP5oc3UkD7H8WW+FaXp07p
         DoNw==
X-Forwarded-Encrypted: i=1; AJvYcCX3ZhZZqXk1H8xtBH5geYdEc2USWzA1qRlEmU05qDPYKJNULXc+365tMOPDogLemEaN4eNho83l/2TvlkIhx7ZpWQG+K67WlbFIb20I/4JL
X-Gm-Message-State: AOJu0YxION9zEjjjAUG1t27VIWp9nJel8ud+RRGJm5FcSY3vPoF46zku
	oLfXNi9tEgHw6w1dpu/LXj0zqMiyPxdapiCeippvibXN33u608i+87jo5W5A4FElrErhDQGl/OR
	jEqbP/jQJ1eCMhks2EBIZ79LQcsnyMV4lbJeR
X-Google-Smtp-Source: AGHT+IE3cvfKOYjE6nqB0ekOsf+rVygYEUaDO+ZYgsZUi+mmZ/AGBh1xu5c3PU2Vla9SYolYkwBR2jbQrCMeN1wuqrU=
X-Received: by 2002:a50:8e58:0:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-5984e3226a6mr225185a12.3.1720713440316; Thu, 11 Jul 2024
 08:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com> <20240710220540.188239-5-pratikrajesh.sampat@amd.com>
In-Reply-To: <20240710220540.188239-5-pratikrajesh.sampat@amd.com>
From: Peter Gonda <pgonda@google.com>
Date: Thu, 11 Jul 2024 09:57:07 -0600
Message-ID: <CAMkAt6ojzv+FYV5Hnvy9whf-TRTxht2C2y4Xnx_VsM_O5G50eA@mail.gmail.com>
Subject: Re: [RFC 4/5] selftests: KVM: SNP IOCTL test
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, shuah@kernel.org, thomas.lendacky@amd.com, 
	michael.roth@amd.com, seanjc@google.com, pbonzini@redhat.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:06=E2=80=AFPM Pratik R. Sampat
<pratikrajesh.sampat@amd.com> wrote:
>
> Introduce testing of SNP ioctl calls. This patch includes both positive
> and negative tests of various parameters such as flags, page types and
> policies.
>
> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>

Tested-by: Peter Gonda <pgonda@google.com>

> ---
>  .../selftests/kvm/x86_64/sev_smoke_test.c     | 119 +++++++++++++++++-
>  1 file changed, 118 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/=
testing/selftests/kvm/x86_64/sev_smoke_test.c
> index 500c67b3793b..1d5c275c11b3 100644
> --- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> @@ -186,13 +186,130 @@ static void test_sev_launch(void *guest_code, uint=
32_t type, uint64_t policy)
>         kvm_vm_free(vm);
>  }
>
> +static int spawn_snp_launch_start(uint32_t type, uint64_t policy, uint8_=
t flags)
> +{
> +       struct kvm_vcpu *vcpu;
> +       struct kvm_vm *vm;
> +       int ret;
> +
> +       vm =3D vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
> +       ret =3D snp_vm_launch(vm, policy, flags);
> +       kvm_vm_free(vm);
> +
> +       return ret;
> +}
> +
> +static void test_snp_launch_start(uint32_t type, uint64_t policy)
> +{
> +       uint8_t i;
> +       int ret;
> +
> +       ret =3D spawn_snp_launch_start(type, policy, 0);
> +       TEST_ASSERT(!ret,
> +                   "KVM_SEV_SNP_LAUNCH_START should not fail, invalid fl=
ag.");
> +
> +       for (i =3D 1; i < 8; i++) {
> +               ret =3D spawn_snp_launch_start(type, policy, BIT(i));
> +               TEST_ASSERT(ret && errno =3D=3D EINVAL,
> +                           "KVM_SEV_SNP_LAUNCH_START should fail, invali=
d flag.");
> +       }

To save readers sometime do we want to comment that flags must be zero?

> +
> +       ret =3D spawn_snp_launch_start(type, 0, 0);
> +       TEST_ASSERT(ret && errno =3D=3D EINVAL,
> +                   "KVM_SEV_SNP_LAUNCH_START should fail, invalid policy=
.");
> +
> +       ret =3D spawn_snp_launch_start(type, SNP_POLICY_SMT, 0);
> +       TEST_ASSERT(ret && errno =3D=3D EINVAL,
> +                   "KVM_SEV_SNP_LAUNCH_START should fail, invalid policy=
.");
> +
> +       ret =3D spawn_snp_launch_start(type, SNP_POLICY_RSVD_MBO, 0);
> +       TEST_ASSERT(ret && errno =3D=3D EINVAL,
> +                   "KVM_SEV_SNP_LAUNCH_START should fail, invalid policy=
.");

Ditto on SMT comment, this could pass if SMT was disabled right?

> +
> +       ret =3D spawn_snp_launch_start(type, SNP_POLICY_SMT | SNP_POLICY_=
RSVD_MBO |
> +                                    (255 * SNP_POLICY_ABI_MAJOR) |
> +                                    (255 * SNP_POLICY_ABI_MINOR), 0);
> +       TEST_ASSERT(ret && errno =3D=3D EIO,
> +                   "KVM_SEV_SNP_LAUNCH_START should fail, invalid versio=
n.");
> +}
> +
> +static void test_snp_launch_update(uint32_t type, uint64_t policy)
> +{
> +       struct kvm_vcpu *vcpu;
> +       struct kvm_vm *vm;
> +       int ret;
> +
> +       for (int pgtype =3D 0; pgtype <=3D KVM_SEV_SNP_PAGE_TYPE_CPUID; p=
gtype++) {

Do we want to test KVM_SEV_SNP_PAGE_TYPE_CPUID+1 to make sure that fails?

> +               vm =3D vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
> +               snp_vm_launch(vm, policy, 0);
> +               ret =3D snp_vm_launch_update(vm, pgtype);
> +
> +               switch (pgtype) {
> +               case KVM_SEV_SNP_PAGE_TYPE_NORMAL:
> +               case KVM_SEV_SNP_PAGE_TYPE_ZERO:
> +               case KVM_SEV_SNP_PAGE_TYPE_UNMEASURED:
> +               case KVM_SEV_SNP_PAGE_TYPE_SECRETS:
> +                       TEST_ASSERT(!ret,
> +                                   "KVM_SEV_SNP_LAUNCH_UPDATE should not=
 fail, invalid Page type.");

Double negative maybe: "KVM_SEV_SNP_LAUNCH_UPDATE should succeed..."

> +                       break;
> +               case KVM_SEV_SNP_PAGE_TYPE_CPUID:
> +                       TEST_ASSERT(ret && errno =3D=3D EIO,
> +                                   "KVM_SEV_SNP_LAUNCH_UPDATE should fai=
l, invalid Page type.");

This is a valid page type right? But I think the error is from the ASP
due to the page being malformed for a CPUID page.

> +                       break;
> +               default:
> +                       TEST_ASSERT(ret && errno =3D=3D EINVAL,
> +                                   "KVM_SEV_SNP_LAUNCH_UPDATE should fai=
l, invalid Page type.");
> +               }
> +
> +               kvm_vm_free(vm);
> +       }
> +}
> +
> +void test_snp_launch_finish(uint32_t type, uint64_t policy)
> +{
> +       struct kvm_vcpu *vcpu;
> +       struct kvm_vm *vm;
> +       int ret;
> +
> +       vm =3D vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
> +       snp_vm_launch(vm, policy, 0);
> +       snp_vm_launch_update(vm, KVM_SEV_SNP_PAGE_TYPE_NORMAL);
> +       ret =3D snp_vm_launch_finish(vm, 0);
> +       TEST_ASSERT(!ret,
> +                   "KVM_SEV_SNP_LAUNCH_FINISH should not fail, invalid f=
lag.");

Comment is wrong, maybe: "KVM_SEV_SNP_LAUNCH_FINISH should not fail."

> +       kvm_vm_free(vm);
> +
> +       for (int i =3D 1; i < 16; i++) {
> +               vm =3D vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
> +               snp_vm_launch(vm, policy, 0);
> +               snp_vm_launch_update(vm, KVM_SEV_SNP_PAGE_TYPE_NORMAL);
> +               ret =3D snp_vm_launch_finish(vm, BIT(i));
> +               TEST_ASSERT(ret && errno =3D=3D EINVAL,
> +                           "KVM_SEV_SNP_LAUNCH_FINISH should fail, inval=
id flag.");
> +               kvm_vm_free(vm);

To save readers sometime do we want to comment that flags must be zero?

> +       }
> +}
> +
> +static void test_sev_ioctl(void *guest_code, uint32_t type, uint64_t pol=
icy)
> +{
> +       if (type =3D=3D KVM_X86_SNP_VM) {
> +               test_snp_launch_start(type, policy);
> +               test_snp_launch_update(type, policy);
> +               test_snp_launch_finish(type, policy);
> +
> +               return;
> +       }
> +
> +       test_sev_launch(guest_code, type, policy);
> +}
> +
>  static void test_sev(void *guest_code, uint32_t type, uint64_t policy)
>  {
>         struct kvm_vcpu *vcpu;
>         struct kvm_vm *vm;
>         struct ucall uc;
>
> -       test_sev_launch(guest_code, type, policy);
> +       test_sev_ioctl(guest_code, type, policy);
>
>         vm =3D vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
>
> --
> 2.34.1
>

