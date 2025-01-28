Return-Path: <linux-kselftest+bounces-25312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F8A20CFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D263A7921
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D38A1B0F30;
	Tue, 28 Jan 2025 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjQUKk8t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F271A9B2B;
	Tue, 28 Jan 2025 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738077941; cv=none; b=qvAvnLGnmn/bkLALrC1Ad0X3x4HdnGQOxhVwS9aRwfXsEov3nb6VN2jKYmUihoMlY9l8xOhMzeOCvijNAOWzDlpA8Ik32Kg1gyK8kUKbCWqEReoyl8DApbxAK1NNRsDUhUQ9xUGWuktfs5kaLiozzdWWbWMdQdDMMXhl1iSYb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738077941; c=relaxed/simple;
	bh=nV+FzWKbANZx9HgkidFwG5xrewDqm4kJlQ/F9Fw2IS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTL1s9XWT/500H9X30rEGWTyUPs5GH6fAJOxhZHBng3kaBrYzwQ5icJ9aCM4vbk1CTEZqXPiGYpRxdi1dMIreMGiGlKNML1XqY5j1Qj55LHFu9qvQZ0cYjNP1DeT+0bHWArbe+NUGH8yyZsgfu6UAzonLy93BS9vfN9O571vTO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjQUKk8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7BCC4CEE4;
	Tue, 28 Jan 2025 15:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738077940;
	bh=nV+FzWKbANZx9HgkidFwG5xrewDqm4kJlQ/F9Fw2IS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CjQUKk8tgxNT5FiUYgBP/EkH7tciprh6KefMogl3Po5J42mA3NXuFZi0diBTojoUc
	 8dehbYcAIgY1+RCViQd/qQrLPWw6Sr5NiNCPOH2Zt26btzxy5SF2dyEHjCzr/mVi2g
	 U5YsZURkMYZA5Ajf74Ykhuf5uAc6+UvVXSU1XpiiTLluENpKrp8UJ3zO2Rf1VOAC1B
	 yf0cVzboM9VEGvZehKjN1UTBQTY6oRiojzAiRao8mFyZSrQqKEw9Ez+EU0+ZquVV8t
	 /ixlbIXRNpi/g/TyT76quaBuGmBMlqqNg7cVdf/1CEItBggR9PxZdBr7iZ5hanR/QA
	 q/RK3c0WhfAiQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-540254357c8so5797693e87.1;
        Tue, 28 Jan 2025 07:25:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVST/fm6/34PcapJvo+SMuv/kzpodTM2/etKF0/fGuw8YBHMsHR4Jbizm4K+yrwwibZBYv0AQzJk2yY/qufcP+o@vger.kernel.org, AJvYcCXqaTTjAJyRUbu839w8fzXQSTYK5YX/bIaUwD2aUfBpELcf4vYT44aAbr44ifrPXzQEvES9ulkef5+wQFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZTjqsy0PznvCUyBw+R4tnL+W2eqRcvBsUFxZz79hPO5DRncS
	RXqT6mG3ky0HXIiQ6HGg6WSb5GukC2S3SL1f5SWOb9M1LxkBnlDLEh21cPCXO4HlmIODXMWkWZb
	vP9nZgtVB6kFXDiJ5Zdw98hQl2g==
X-Google-Smtp-Source: AGHT+IEFby41Dzk8Di02mNOM5Cxy2EFRJLFUx7f25ID/UUfCbjR1gV58RWSxAT/uUFzd04BUgt4V0MNwsnwXgwYKw80=
X-Received: by 2002:a05:6512:3c92:b0:53e:39ed:85e6 with SMTP id
 2adb3069b0e04-5439c27fa73mr18344610e87.32.1738077938743; Tue, 28 Jan 2025
 07:25:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127222031.3078945-1-coltonlewis@google.com> <20250127222031.3078945-2-coltonlewis@google.com>
In-Reply-To: <20250127222031.3078945-2-coltonlewis@google.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 28 Jan 2025 09:25:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLa9KmYjkVBpxwkQXfQyj53=dgj_9rijca5JGem46qZLg@mail.gmail.com>
X-Gm-Features: AWEUYZkt7YkAXKfFlHInNwyPOLFZ80Bbbmqn6_x8T3vnHAb5bp8zMcQevYuFBUs
Message-ID: <CAL_JsqLa9KmYjkVBpxwkQXfQyj53=dgj_9rijca5JGem46qZLg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] perf: arm_pmuv3: Introduce module param to
 partition the PMU
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 4:26=E2=80=AFPM Colton Lewis <coltonlewis@google.co=
m> wrote:
>
> For PMUv3, the register MDCR_EL2.HPMN partitiones the PMU counters
> into two ranges where counters 0..HPMN-1 are accessible by EL1 and, if
> allowed, EL0 while counters HPMN..N are only accessible by EL2.
>
> Introduce a module parameter in the PMUv3 driver to set this
> register. The name reserved_guest_counters reflects the intent to
> reserve some counters for the guest so they may eventually be allowed
> direct access to a subset of PMU functionality for increased
> performance.
>
> Track HPMN and whether the pmu is partitioned in struct arm_pmu.
>
> While FEAT_HPMN0 does allow HPMN to be set to 0, this patch
> specifically disallows that case because it's not useful given the
> intention to allow guests access to their own counters.
>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  arch/arm/include/asm/arm_pmuv3.h   | 10 +++++++
>  arch/arm64/include/asm/arm_pmuv3.h | 10 +++++++
>  drivers/perf/arm_pmuv3.c           | 43 ++++++++++++++++++++++++++++--
>  include/linux/perf/arm_pmu.h       |  2 ++
>  include/linux/perf/arm_pmuv3.h     |  7 +++++
>  5 files changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_=
pmuv3.h
> index 2ec0e5e83fc9..49ad90486aa5 100644
> --- a/arch/arm/include/asm/arm_pmuv3.h
> +++ b/arch/arm/include/asm/arm_pmuv3.h
> @@ -277,4 +277,14 @@ static inline u64 read_pmceid1(void)
>         return val;
>  }
>
> +static inline u32 read_mdcr(void)
> +{
> +       return read_sysreg(mdcr_el2);
> +}
> +
> +static inline void write_mdcr(u32 val)
> +{
> +       write_sysreg(val, mdcr_el2);
> +}
> +
>  #endif
> diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/=
arm_pmuv3.h
> index 8a777dec8d88..fc37e7e81e07 100644
> --- a/arch/arm64/include/asm/arm_pmuv3.h
> +++ b/arch/arm64/include/asm/arm_pmuv3.h
> @@ -188,4 +188,14 @@ static inline bool is_pmuv3p9(int pmuver)
>         return pmuver >=3D ID_AA64DFR0_EL1_PMUVer_V3P9;
>  }
>
> +static inline u64 read_mdcr(void)
> +{
> +       return read_sysreg(mdcr_el2);
> +}
> +
> +static inline void write_mdcr(u64 val)
> +{
> +       write_sysreg(val, mdcr_el2);
> +}
> +
>  #endif
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index b5cc11abc962..55f9ae560715 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -325,6 +325,7 @@ GEN_PMU_FORMAT_ATTR(threshold_compare);
>  GEN_PMU_FORMAT_ATTR(threshold);
>
>  static int sysctl_perf_user_access __read_mostly;
> +static u8 reserved_guest_counters __read_mostly;
>
>  static bool armv8pmu_event_is_64bit(struct perf_event *event)
>  {
> @@ -500,6 +501,29 @@ static void armv8pmu_pmcr_write(u64 val)
>         write_pmcr(val);
>  }
>
> +static u64 armv8pmu_mdcr_read(void)
> +{
> +       return read_mdcr();
> +}
> +
> +static void armv8pmu_mdcr_write(u64 val)
> +{
> +       write_mdcr(val);
> +       isb();
> +}
> +
> +static void armv8pmu_partition(u8 hpmn)
> +{
> +       u64 mdcr =3D armv8pmu_mdcr_read();
> +
> +       mdcr &=3D ~MDCR_EL2_HPMN_MASK;
> +       mdcr |=3D FIELD_PREP(ARMV8_PMU_MDCR_HPMN, hpmn);
> +       /* Prevent guest counters counting at EL2 */
> +       mdcr |=3D ARMV8_PMU_MDCR_HPMD;
> +
> +       armv8pmu_mdcr_write(mdcr);
> +}
> +
>  static int armv8pmu_has_overflowed(u64 pmovsr)
>  {
>         return !!(pmovsr & ARMV8_PMU_OVERFLOWED_MASK);
> @@ -1069,6 +1093,9 @@ static void armv8pmu_reset(void *info)
>
>         bitmap_to_arr64(&mask, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS);
>
> +       if (cpu_pmu->partitioned)
> +               armv8pmu_partition(cpu_pmu->hpmn);
> +
>         /* The counter and interrupt enable registers are unknown at rese=
t. */
>         armv8pmu_disable_counter(mask);
>         armv8pmu_disable_intens(mask);
> @@ -1205,6 +1232,7 @@ static void __armv8pmu_probe_pmu(void *info)
>  {
>         struct armv8pmu_probe_info *probe =3D info;
>         struct arm_pmu *cpu_pmu =3D probe->pmu;
> +       u8 pmcr_n;
>         u64 pmceid_raw[2];
>         u32 pmceid[2];
>         int pmuver;
> @@ -1215,10 +1243,19 @@ static void __armv8pmu_probe_pmu(void *info)
>
>         cpu_pmu->pmuver =3D pmuver;
>         probe->present =3D true;
> +       pmcr_n =3D FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read());
>
>         /* Read the nb of CNTx counters supported from PMNC */
> -       bitmap_set(cpu_pmu->cntr_mask,
> -                  0, FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read()));
> +       bitmap_set(cpu_pmu->cntr_mask, 0, pmcr_n);
> +
> +       if (reserved_guest_counters > 0 && reserved_guest_counters < pmcr=
_n) {
> +               cpu_pmu->hpmn =3D reserved_guest_counters;
> +               cpu_pmu->partitioned =3D true;

You're storing the same information 3 times. 'partitioned' is just
'reserved_guest_counters !=3D 0' or 'cpu_pmu->hpmn !=3D pmcr_n'.

> +       } else {
> +               reserved_guest_counters =3D 0;
> +               cpu_pmu->hpmn =3D pmcr_n;
> +               cpu_pmu->partitioned =3D false;
> +       }
>
>         /* Add the CPU cycles counter */
>         set_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->cntr_mask);
> @@ -1516,3 +1553,5 @@ void arch_perf_update_userpage(struct perf_event *e=
vent,
>         userpg->cap_user_time_zero =3D 1;
>         userpg->cap_user_time_short =3D 1;
>  }
> +
> +module_param(reserved_guest_counters, byte, 0);

Module params are generally discouraged. Since this driver can't be a
module, this is a boot time only option. There's little reason this
can't be a sysfs setting. There's some complexity in changing this
when counters are in use (just reject the change) and when we have
asymmetric PMUs. Alternatively, it could be a sysctl like user access.

Rob

