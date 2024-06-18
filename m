Return-Path: <linux-kselftest+bounces-12107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D998F90BFFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 02:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49847B21CC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 00:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CE0291E;
	Tue, 18 Jun 2024 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqACPPX7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72644D8A4
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 00:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718668910; cv=none; b=brMB3JooMCgMb4OvFgMY7fGBL/02QnyjoBZa+pbUXNIpJ7CA9CbFmWF8q5yYYCWVhNUh8/nyCj6sttsl8Thmph0Yq6K/MMz4Z8oAIDKQq3wjD5XXYNBn6BXnEGC0hRebR26cSCZmIiXp5mJ0JHPbK8Aeuuu5uxaGLM8+TGlcSgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718668910; c=relaxed/simple;
	bh=WsXnkl7kVUYze+FeKGmExkt9GJ8bPzG9K5cBRVrE94Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYKe5ZaU5gKjb9jMDbkoC6Tp5l1pAJ4vN2XlZeYYqtsc4jyEd3IZ6qsI40AsydmGCLV2EVnReO9ta3OMEhgtT1KjOUjbmONV6KURWP3XLeCgwv/nJFuv2TVSKqfXDZ5oZVANQfuMlRgpE071afL1KIJSCOu6k90bK/Ts1IsSzqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LqACPPX7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-443580f290dso67551cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 17:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718668908; x=1719273708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szeTbx+n4i/RQE7ZeuWhiCumzoRR7Ut1YseLs3KbJhQ=;
        b=LqACPPX7taB8wao5TU2wDvxyePHktsw1vqMDPHKfrMc47roqxlrVwRAzmjj1IVRGiq
         8V74Kmp29+vQIqFQZoiyBa1Fj5HY8llC+vnw6gEac9WLDIqNx34L8RR4LXE9OOcQ1yOU
         vi7kYDb0mHWckOe66R3hmFGtinLmc7QPXIX7yo1F8o7wXCsZLsNuozE1AuplSN1NPhHy
         rNXySMFsdZPS6KmVKJF8a/C5hGPjDNQDWnAqcSWYAXYt6CmO0q/sX/UHOg345S9f3dxC
         tVx1qpVLp45gpzOvqKo5keZAINa08NJXwqLfHScFDduIAaYfEcN0avu0fhRW9zaQ32IZ
         cguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718668908; x=1719273708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szeTbx+n4i/RQE7ZeuWhiCumzoRR7Ut1YseLs3KbJhQ=;
        b=UQi7iySKkxkxOoQJjboTc9ErTr2OR64JiEdDAY40QpIE9nH8YW09pTdIbYML2t9EHP
         7MiLsJh3kPL9oGMG1SId1JudxhYeWSNq/tgE5DZqJKe89TrTmUho9z52clLKpMHtSviF
         1exJhdO0EIalZoT5UnXNuEnqR3IiUG1wtpVxMSQ+tUMUtP7zSjvaO/p01wjyq8/w2Uh4
         +GaYrC1WRBmSQ8/+QYAJFFHvR1Pb9iF1GITVj3GEqNARhwaQrutV3ETyIh2d4VhVTL3P
         Yut43TXGLu/q98cQkWsaEjQ2ewNBhn0HxBNq3xMNlxlvyusHdR1bZ7rVatIA9dO6t8qZ
         VArg==
X-Forwarded-Encrypted: i=1; AJvYcCVXiiZevqYjh2AOwMSHazklYf+UHqCHGKDVD0zZ8sz2FSnhLJic6NOPqCPsnGLqL4GcAY1wgJhEthoathZh34Dv51WSEnNa6+m7uvrHY3gK
X-Gm-Message-State: AOJu0YwltUrbPifoJFPo6Cb77DH3X/5krygpM/5wFuGqtFa45VKbImBa
	UHptbiGwflfO0FkxhV4c0/ZtdTh/QvSIeIbgI7H8Su5KochIwQ2kOPWH3xw1J6SQNYiuXWrR4VO
	5r6Rlr3JqfTfA9ZIkmVPD9W5smNF12IL2ATph
X-Google-Smtp-Source: AGHT+IGHzkobBDc6M3yopcf16QeXn++VzvN+NTr0crpz0Mygnf9RbsKFdcd1bMRE+npFHMvEgbm3YMfrR8FegyixQZ4=
X-Received: by 2002:a05:622a:1309:b0:43f:bba6:3759 with SMTP id
 d75a77b69052e-4449c68d727mr1309401cf.10.1718668907696; Mon, 17 Jun 2024
 17:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613082345.132336-1-shahuang@redhat.com> <20240613082345.132336-4-shahuang@redhat.com>
In-Reply-To: <20240613082345.132336-4-shahuang@redhat.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Mon, 17 Jun 2024 17:01:36 -0700
Message-ID: <CAJHc60xpGAA1pmz0ad_Fq3a5M-pQMiyxQ4hdNhc6vQrgpSjGww@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] KVM: selftests: aarch64: Add invalid filter test
 in pmu_event_filter_test
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	Eric Auger <eric.auger@redhat.com>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shaoqin,

On Thu, Jun 13, 2024 at 1:27=E2=80=AFAM Shaoqin Huang <shahuang@redhat.com>=
 wrote:
>
> Add the invalid filter test which sets the filter beyond the event
> space and sets the invalid action to double check if the
> KVM_ARM_VCPU_PMU_V3_FILTER will return the expected error.
>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  .../kvm/aarch64/pmu_event_filter_test.c       | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c =
b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> index fb0fde1ed436..13b2f354c39b 100644
> --- a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> @@ -8,6 +8,7 @@
>   * This test checks if the guest only see the limited pmu event that use=
rspace
>   * sets, if the guest can use those events which user allow, and if the =
guest
>   * can't use those events which user deny.
> + * It also checks that setting invalid filter ranges return the expected=
 error.
>   * This test runs only when KVM_CAP_ARM_PMU_V3, KVM_ARM_VCPU_PMU_V3_FILT=
ER
>   * is supported on the host.
>   */
> @@ -178,6 +179,40 @@ static void destroy_vpmu_vm(void)
>         kvm_vm_free(vpmu_vm.vm);
>  }
>
> +static void test_invalid_filter(void)
> +{
> +       struct kvm_pmu_event_filter invalid;
> +       int ret;
> +
> +       pr_info("Test: test_invalid_filter\n");
> +
> +       memset(&vpmu_vm, 0, sizeof(vpmu_vm));
> +
> +       vpmu_vm.vm =3D vm_create(1);
> +       vpmu_vm.vcpu =3D vm_vcpu_add_with_vpmu(vpmu_vm.vm, 0, guest_code)=
;
> +       vpmu_vm.gic_fd =3D vgic_v3_setup(vpmu_vm.vm, 1, 64);
> +       __TEST_REQUIRE(vpmu_vm.gic_fd >=3D 0,
> +                      "Failed to create vgic-v3, skipping");
> +
> +       /* The max event number is (1 << 16), set a range largeer than it=
. */
nit: s/largeer/larger

Also, perhaps not in this series, but we can also check for -EBUSY
situations such as setting a (valid) filter after
KVM_ARM_VCPU_PMU_V3_INIT and after the vCPUs have started.

Besides that, Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>

- Raghavendra



> +       invalid =3D __DEFINE_FILTER(BIT(15), BIT(15) + 1, 0);
> +       ret =3D __kvm_device_attr_set(vpmu_vm.vcpu->fd, KVM_ARM_VCPU_PMU_=
V3_CTRL,
> +                                   KVM_ARM_VCPU_PMU_V3_FILTER, &invalid)=
;
> +       TEST_ASSERT(ret && errno =3D=3D EINVAL, "Set Invalid filter range=
 "
> +                   "ret =3D %d, errno =3D %d (expected ret =3D -1, errno=
 =3D EINVAL)",
> +                   ret, errno);
> +
> +       /* Set the Invalid action. */
> +       invalid =3D __DEFINE_FILTER(0, 1, 3);
> +       ret =3D __kvm_device_attr_set(vpmu_vm.vcpu->fd, KVM_ARM_VCPU_PMU_=
V3_CTRL,
> +                                   KVM_ARM_VCPU_PMU_V3_FILTER, &invalid)=
;
> +       TEST_ASSERT(ret && errno =3D=3D EINVAL, "Set Invalid filter actio=
n "
> +                   "ret =3D %d, errno =3D %d (expected ret =3D -1, errno=
 =3D EINVAL)",
> +                   ret, errno);
> +
> +       destroy_vpmu_vm();
> +}
> +
>  static void run_test(struct test_desc *t)
>  {
>         pr_info("Test: %s\n", t->name);
> @@ -300,4 +335,6 @@ int main(void)
>         TEST_REQUIRE(kvm_pmu_support_events());
>
>         run_tests();
> +
> +       test_invalid_filter();
>  }
> --
> 2.40.1
>
>

