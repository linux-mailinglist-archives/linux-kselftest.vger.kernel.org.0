Return-Path: <linux-kselftest+bounces-12371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AE89115BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 00:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F161F230CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 22:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFA28288F;
	Thu, 20 Jun 2024 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ldaDGIyB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33476F2F1
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922633; cv=none; b=ogdEODC9uorNggOWWj2tyNoBObuF4yp8YHtv5A3neLGrfzEhvK9OI3jNWz8x7cohsN87e1zX/cMRoojrvPgE6QGT8YARRr6e9I/EKf9jA/Qsv5FtqG/Gb3SqurtVs3EY3ewjylnfAUnD4GiAtvDFnnuoIZxpFGsZZ4FvnzvssUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922633; c=relaxed/simple;
	bh=qU/CK7cK2ztIubEiOnDLG3FhSQGWI8q05/wnLRMya7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZJi4jAaJBmBZSdR3/9DBfZ4OQH2ESn5rI3asvcdYRegxPXfARNkGSK4ZGNxhlICTGYyTqgJBhanNI1tjZU+UtSs2c68lFMWlhNXxger+EdnVsWyWEL+6tWHbsPW97e/bMFy+QQzijcinrrtY7XaeDCblFJNUmpTtmfa8FJhHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ldaDGIyB; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-375bb80e5b8so17605ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718922631; x=1719527431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHREBPCUIs8n+I6KtcDeDKXi3C09zaSei5HzCaoQhXU=;
        b=ldaDGIyBvF6wDNkosaJ+hgro8FvJeadsCQP3rIOCRZ9OZ36+IkbsIKQpOdnwh3ou8G
         syTScZJIW/zBzuSHM3SGawhMcpw8+f0ppw8zLQ+gbFWFFJPNz627hT/dq/nuA+d5eGs7
         +93+UDvrEbbRqx/bWooE0skUu9ENoFEsIqlH7+JkABeb9t9VXhtRjCpqjUyxu82f/Y1D
         02erSUOoki57n3Yk/pYxqUXb55Ine+PnZnxeUuEB6+DqoHdQnt6a6/xHcV6pJ9HbBM9r
         jBzuAX+ZghWUtK3bpYdO/rfAn3t7xS/fe9luRyb1oEDsNhAue5aX6Z6+3GQ6hH2PYHKi
         vPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718922631; x=1719527431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHREBPCUIs8n+I6KtcDeDKXi3C09zaSei5HzCaoQhXU=;
        b=Sgq29vm668NL0PkELjMgcvlpfA1p3YW7wrsTtjv9hOWJyosJsIpolIYYeIeghbqlvy
         Jpj9S9RWxlFM1RFGHH809Vz6OTrHivBecVPkXQ6xO1OjjcEzt++KcgyHU6TABRQsDv+A
         pk2C16vcVxr7pFUuLIMzFAcIW8BDHGrM3fOtomGL1XqkS/H6wLNY/3pN8+RiQsENbhYz
         iABg46rukXlBNiy2a/m2u1DGqYITqWHG9M5qcwVqCUmsx5boK6pgkJ3iobKu0LM/i6x1
         tOkYtMvP+TC/prRA1VSGl13kqkySzXpaAoBQMZrQdiEWou2CppMOpYl59GqxjHrHpLFj
         u/OA==
X-Forwarded-Encrypted: i=1; AJvYcCV6F9uKK5pkN37gfybzHjCH27p7I0UHN1QTu66rZ9OveadR1xUsYOXitf65MbPIdtbZuBmlV5iOsfcfnQtSywgzCsofpDLTHd1QpshkZM3n
X-Gm-Message-State: AOJu0YwZBdXmItcpTaT2HbWwIyRw+IBv0yEkH+6o5xYEnEwh2m7dd/f/
	yPyXSA8S/EX47/OG5vrD7gtWrybbJ+1KyRTNK6npu8ydJC+2kTxawIBA5L/jCOcKv5l7R0JwHaL
	cwNI15xIttcGSbJEfoIrwyBdVTxx2ItBp3Qpy
X-Google-Smtp-Source: AGHT+IG3QZzSrTWr7FqOD3AtuM1SKP3sfyODhN7mg13aomMD50DF/jtHQSYwrOACQW7sSeuYOA45Mb+PEMZtdzwhpq8=
X-Received: by 2002:a92:dc10:0:b0:375:9e2b:a832 with SMTP id
 e9e14a558f8ab-3762f4f3869mr453635ab.21.1718922630941; Thu, 20 Jun 2024
 15:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619083200.1047073-1-shahuang@redhat.com> <20240619083200.1047073-2-shahuang@redhat.com>
In-Reply-To: <20240619083200.1047073-2-shahuang@redhat.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 20 Jun 2024 15:30:18 -0700
Message-ID: <CAJHc60zNNsaALEV6XPdwuTZo1_0y2dT--MLMad0ar5Htt8jCtQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] KVM: selftests: aarch64: Add helper function for
 the vpmu vcpu creation
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	Eric Auger <eric.auger@redhat.com>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shaoqin

On Wed, Jun 19, 2024 at 1:32=E2=80=AFAM Shaoqin Huang <shahuang@redhat.com>=
 wrote:
>
> Create a vcpu with vpmu would be a common requirement for the vpmu test,
> so add the helper function for the vpmu vcpu creation. And use those
> helper function in the vpmu_counter_access.c test.
>
> Use this chance to delete the meaningless ASSERT about the pmuver,
> because KVM does not advertise an IMP_DEF PMU to guests.
>
> No functional changes intended.
>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  .../kvm/aarch64/vpmu_counter_access.c         | 32 ++++---------------
>  .../selftests/kvm/include/aarch64/vpmu.h      | 28 ++++++++++++++++
>  2 files changed, 34 insertions(+), 26 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/aarch64/vpmu.h
>
> diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/=
tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> index d31b9f64ba14..68da44198719 100644
> --- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> +++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> @@ -16,6 +16,7 @@
>  #include <processor.h>
>  #include <test_util.h>
>  #include <vgic.h>
> +#include <vpmu.h>
>  #include <perf/arm_pmuv3.h>
>  #include <linux/bitfield.h>
>
> @@ -407,18 +408,8 @@ static void guest_code(uint64_t expected_pmcr_n)
>  /* Create a VM that has one vCPU with PMUv3 configured. */
>  static void create_vpmu_vm(void *guest_code)
>  {
> -       struct kvm_vcpu_init init;
> -       uint8_t pmuver, ec;
> -       uint64_t dfr0, irq =3D 23;
> -       struct kvm_device_attr irq_attr =3D {
> -               .group =3D KVM_ARM_VCPU_PMU_V3_CTRL,
> -               .attr =3D KVM_ARM_VCPU_PMU_V3_IRQ,
> -               .addr =3D (uint64_t)&irq,
> -       };
> -       struct kvm_device_attr init_attr =3D {
> -               .group =3D KVM_ARM_VCPU_PMU_V3_CTRL,
> -               .attr =3D KVM_ARM_VCPU_PMU_V3_INIT,
> -       };
> +       uint8_t ec;
> +       uint64_t irq =3D 23;
>
>         /* The test creates the vpmu_vm multiple times. Ensure a clean st=
ate */
>         memset(&vpmu_vm, 0, sizeof(vpmu_vm));
> @@ -430,26 +421,15 @@ static void create_vpmu_vm(void *guest_code)
>                                         guest_sync_handler);
>         }
>
> -       /* Create vCPU with PMUv3 */
> -       vm_ioctl(vpmu_vm.vm, KVM_ARM_PREFERRED_TARGET, &init);
> -       init.features[0] |=3D (1 << KVM_ARM_VCPU_PMU_V3);
> -       vpmu_vm.vcpu =3D aarch64_vcpu_add(vpmu_vm.vm, 0, &init, guest_cod=
e);
> +       vpmu_vm.vcpu =3D vm_vcpu_add_with_vpmu(vpmu_vm.vm, 0, guest_code)=
;
>         vcpu_init_descriptor_tables(vpmu_vm.vcpu);
>         vpmu_vm.gic_fd =3D vgic_v3_setup(vpmu_vm.vm, 1, 64);
>         __TEST_REQUIRE(vpmu_vm.gic_fd >=3D 0,
>                        "Failed to create vgic-v3, skipping");
>
> -       /* Make sure that PMUv3 support is indicated in the ID register *=
/
> -       vcpu_get_reg(vpmu_vm.vcpu,
> -                    KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1), &dfr0);
> -       pmuver =3D FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), =
dfr0);
> -       TEST_ASSERT(pmuver !=3D ID_AA64DFR0_EL1_PMUVer_IMP_DEF &&
> -                   pmuver >=3D ID_AA64DFR0_EL1_PMUVer_IMP,
> -                   "Unexpected PMUVER (0x%x) on the vCPU with PMUv3", pm=
uver);
> -
>         /* Initialize vPMU */
> -       vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
> -       vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &init_attr);
> +       vpmu_set_irq(vpmu_vm.vcpu, irq);
> +       vpmu_init(vpmu_vm.vcpu);
>  }
>
>  static void destroy_vpmu_vm(void)
> diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/t=
esting/selftests/kvm/include/aarch64/vpmu.h
> new file mode 100644
> index 000000000000..5ef6cb011e41
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <kvm_util.h>
> +
> +static inline struct kvm_vcpu *vm_vcpu_add_with_vpmu(struct kvm_vm *vm,
> +                                                    uint32_t vcpu_id,
> +                                                    void *guest_code)
> +{
> +       struct kvm_vcpu_init init;
> +
> +       /* Create vCPU with PMUv3 */
> +       vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
> +       init.features[0] |=3D (1 << KVM_ARM_VCPU_PMU_V3);
> +
> +       return aarch64_vcpu_add(vm, 0, &init, guest_code);
> +}
> +
> +static void vpmu_set_irq(struct kvm_vcpu *vcpu, int irq)
> +{
> +       kvm_device_attr_set(vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
> +                           KVM_ARM_VCPU_PMU_V3_IRQ, &irq);
> +}
> +
> +static void vpmu_init(struct kvm_vcpu *vcpu)
> +{
> +       kvm_device_attr_set(vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
> +                           KVM_ARM_VCPU_PMU_V3_INIT, NULL);
> +}
> --
> 2.40.1
>
>
Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>

- Raghavendra

