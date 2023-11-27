Return-Path: <linux-kselftest+bounces-670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D43A7FACC9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 22:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A041EB21301
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 21:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587354653A;
	Mon, 27 Nov 2023 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qrJmucY9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DD6C1
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Nov 2023 13:49:08 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35c6cefa872so3735ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Nov 2023 13:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701121747; x=1701726547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL7KVwhVfPkfWvKDrxAO+rIkZlfltIKSwwMISdQlBCo=;
        b=qrJmucY9Sx2i/mAfpEhGmev/PugqYK3d99REexs6RKGEYsO696OICgXk+Ds0nY6Of6
         hIn6eIcBKNIsEogEw+t7tovT6bTzkMMOqv1yZjGPEoLMNy2MCCX6UNArTnZTTaNbP6yb
         N/ljkd6OABwthiM+hetKtxH/5Nw2FHjFnvJGNpVP0bjStJfZmwJePKfrPXaG80w8YwQ7
         kNvqznrkH+2uaTijc0Vyxft1LV4DGHxhn5EkWRlJxIRBmVeegeC+ny1cmEykF0kOsuQ/
         zSOI1CFgS4MSDFGR4w6282t2K6E+k9QSDZdhD31dOom2bStf8tWH5KaNREVndJlsCgZo
         xxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701121747; x=1701726547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rL7KVwhVfPkfWvKDrxAO+rIkZlfltIKSwwMISdQlBCo=;
        b=estOg3H7WrC4lozj6UN2uP+/cKDhrdsoWZITnAdp7bZ0zbynirHLyDxIBF3/3eVBTL
         +H4Jzjh5Y6sNWTV/m2uEGGdiEMy1UxcVGhwcGC9RQmc98LAD/zVTVHyehMmBUploq5j9
         xkGLa9LMQpleyrXoaX0httFli57pduKXQQbYt4vTIJAc8eMJrSQgLx9p0cKMzoU4nvET
         0fwhmzELnwhLd8HMwoIUUEnldrbkD7HBUXqyhWhQLmD1uB8j3Vg4yQX+Is3NlynmL1g8
         20A57nsDFqZGOo3Y9Z8M+4CVhtshrdfoKO7mr6kCpnXDT+7Qt8nNI5NbT343UOMpQfNk
         qkJg==
X-Gm-Message-State: AOJu0Ywfj03Db14l6lNlDmZt5KFkEF7Po2mbJxf3LEVeD0aAamVOo99n
	UqYcdfIY+Pg3S5Y+19kZASHDBlPcU5eW9Qp4E8BSqQ==
X-Google-Smtp-Source: AGHT+IGBz/hdmIHzOD7XYFvALEYOer516+cuVsxQc8kRZN8uSgaLygv9fKh/E0zdA/o3mgt3C8FDNrfhKjxvlcOM0+g=
X-Received: by 2002:a92:de10:0:b0:35c:b910:3493 with SMTP id
 x16-20020a92de10000000b0035cb9103493mr269011ilm.29.1701121747268; Mon, 27 Nov
 2023 13:49:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123063750.2176250-1-shahuang@redhat.com> <20231123063750.2176250-3-shahuang@redhat.com>
In-Reply-To: <20231123063750.2176250-3-shahuang@redhat.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Mon, 27 Nov 2023 13:48:55 -0800
Message-ID: <CAJHc60wsEjjLmAVUrb3n9Tyftqi7UXWh7V1hE1E90bUXiUk+Tw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] KVM: selftests: aarch64: Move the pmu helper
 function into lib/
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shaoqin,

On Wed, Nov 22, 2023 at 10:39=E2=80=AFPM Shaoqin Huang <shahuang@redhat.com=
> wrote:
>
> Move those pmu helper function into lib/, thus it can be used by other
> pmu test.
>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  .../kvm/aarch64/vpmu_counter_access.c         | 118 -----------------
>  .../selftests/kvm/include/aarch64/vpmu.h      | 119 ++++++++++++++++++
>  2 files changed, 119 insertions(+), 118 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/=
tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> index 17305408a334..62d6315790ab 100644
> --- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> +++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> @@ -20,12 +20,6 @@
>  #include <perf/arm_pmuv3.h>
>  #include <linux/bitfield.h>
>
> -/* The max number of the PMU event counters (excluding the cycle counter=
) */
> -#define ARMV8_PMU_MAX_GENERAL_COUNTERS (ARMV8_PMU_MAX_COUNTERS - 1)
> -
> -/* The cycle counter bit position that's common among the PMU registers =
*/
> -#define ARMV8_PMU_CYCLE_IDX            31
> -
>  static struct vpmu_vm *vpmu_vm;
>
>  struct pmreg_sets {
> @@ -35,118 +29,6 @@ struct pmreg_sets {
>
>  #define PMREG_SET(set, clr) {.set_reg_id =3D set, .clr_reg_id =3D clr}
>
> -static uint64_t get_pmcr_n(uint64_t pmcr)
> -{
> -       return (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
> -}
> -
> -static void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
> -{
> -       *pmcr =3D *pmcr & ~(ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHI=
FT);
> -       *pmcr |=3D (pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
> -}
> -
> -static uint64_t get_counters_mask(uint64_t n)
> -{
> -       uint64_t mask =3D BIT(ARMV8_PMU_CYCLE_IDX);
> -
> -       if (n)
> -               mask |=3D GENMASK(n - 1, 0);
> -       return mask;
> -}
> -
> -/* Read PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
> -static inline unsigned long read_sel_evcntr(int sel)
> -{
> -       write_sysreg(sel, pmselr_el0);
> -       isb();
> -       return read_sysreg(pmxevcntr_el0);
> -}
> -
> -/* Write PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
> -static inline void write_sel_evcntr(int sel, unsigned long val)
> -{
> -       write_sysreg(sel, pmselr_el0);
> -       isb();
> -       write_sysreg(val, pmxevcntr_el0);
> -       isb();
> -}
> -
> -/* Read PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
> -static inline unsigned long read_sel_evtyper(int sel)
> -{
> -       write_sysreg(sel, pmselr_el0);
> -       isb();
> -       return read_sysreg(pmxevtyper_el0);
> -}
> -
> -/* Write PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
> -static inline void write_sel_evtyper(int sel, unsigned long val)
> -{
> -       write_sysreg(sel, pmselr_el0);
> -       isb();
> -       write_sysreg(val, pmxevtyper_el0);
> -       isb();
> -}
> -
> -static inline void enable_counter(int idx)
> -{
> -       uint64_t v =3D read_sysreg(pmcntenset_el0);
> -
> -       write_sysreg(BIT(idx) | v, pmcntenset_el0);
> -       isb();
> -}
> -
> -static inline void disable_counter(int idx)
> -{
> -       uint64_t v =3D read_sysreg(pmcntenset_el0);
> -
> -       write_sysreg(BIT(idx) | v, pmcntenclr_el0);
> -       isb();
> -}
> -
> -static void pmu_disable_reset(void)
> -{
> -       uint64_t pmcr =3D read_sysreg(pmcr_el0);
> -
> -       /* Reset all counters, disabling them */
> -       pmcr &=3D ~ARMV8_PMU_PMCR_E;
> -       write_sysreg(pmcr | ARMV8_PMU_PMCR_P, pmcr_el0);
> -       isb();
> -}
> -
> -#define RETURN_READ_PMEVCNTRN(n) \
> -       return read_sysreg(pmevcntr##n##_el0)
> -static unsigned long read_pmevcntrn(int n)
> -{
> -       PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
> -       return 0;
> -}
> -
> -#define WRITE_PMEVCNTRN(n) \
> -       write_sysreg(val, pmevcntr##n##_el0)
> -static void write_pmevcntrn(int n, unsigned long val)
> -{
> -       PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
> -       isb();
> -}
> -
> -#define READ_PMEVTYPERN(n) \
> -       return read_sysreg(pmevtyper##n##_el0)
> -static unsigned long read_pmevtypern(int n)
> -{
> -       PMEVN_SWITCH(n, READ_PMEVTYPERN);
> -       return 0;
> -}
> -
> -#define WRITE_PMEVTYPERN(n) \
> -       write_sysreg(val, pmevtyper##n##_el0)
> -static void write_pmevtypern(int n, unsigned long val)
> -{
> -       PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
> -       isb();
> -}
> -
>  /*
>   * The pmc_accessor structure has pointers to PMEV{CNTR,TYPER}<n>_EL0
>   * accessors that test cases will use. Each of the accessors will
> diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/t=
esting/selftests/kvm/include/aarch64/vpmu.h
> index 0a56183644ee..e0cc1ca1c4b7 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> @@ -1,10 +1,17 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>
>  #include <kvm_util.h>
> +#include <perf/arm_pmuv3.h>
>
>  #define GICD_BASE_GPA  0x8000000ULL
>  #define GICR_BASE_GPA  0x80A0000ULL
>
> +/* The max number of the PMU event counters (excluding the cycle counter=
) */
> +#define ARMV8_PMU_MAX_GENERAL_COUNTERS (ARMV8_PMU_MAX_COUNTERS - 1)
> +
> +/* The cycle counter bit position that's common among the PMU registers =
*/
> +#define ARMV8_PMU_CYCLE_IDX            31
> +
>  struct vpmu_vm {
>         struct kvm_vm *vm;
>         struct kvm_vcpu *vcpu;
> @@ -14,3 +21,115 @@ struct vpmu_vm {
>  struct vpmu_vm *create_vpmu_vm(void *guest_code);
>
>  void destroy_vpmu_vm(struct vpmu_vm *vpmu_vm);
> +
> +static inline uint64_t get_pmcr_n(uint64_t pmcr)
> +{
> +       return (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
> +}
> +
> +static inline void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
> +{
> +       *pmcr =3D *pmcr & ~(ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHI=
FT);
> +       *pmcr |=3D (pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
> +}
> +
> +static inline uint64_t get_counters_mask(uint64_t n)
> +{
> +       uint64_t mask =3D BIT(ARMV8_PMU_CYCLE_IDX);
> +
> +       if (n)
> +               mask |=3D GENMASK(n - 1, 0);
> +       return mask;
> +}
> +
> +/* Read PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
> +static inline unsigned long read_sel_evcntr(int sel)
> +{
> +       write_sysreg(sel, pmselr_el0);
> +       isb();
> +       return read_sysreg(pmxevcntr_el0);
> +}
> +
> +/* Write PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
> +static inline void write_sel_evcntr(int sel, unsigned long val)
> +{
> +       write_sysreg(sel, pmselr_el0);
> +       isb();
> +       write_sysreg(val, pmxevcntr_el0);
> +       isb();
> +}
> +
> +/* Read PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
> +static inline unsigned long read_sel_evtyper(int sel)
> +{
> +       write_sysreg(sel, pmselr_el0);
> +       isb();
> +       return read_sysreg(pmxevtyper_el0);
> +}
> +
> +/* Write PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
> +static inline void write_sel_evtyper(int sel, unsigned long val)
> +{
> +       write_sysreg(sel, pmselr_el0);
> +       isb();
> +       write_sysreg(val, pmxevtyper_el0);
> +       isb();
> +}
> +
> +static inline void enable_counter(int idx)
> +{
> +       uint64_t v =3D read_sysreg(pmcntenset_el0);
> +
> +       write_sysreg(BIT(idx) | v, pmcntenset_el0);
> +       isb();
> +}
> +
> +static inline void disable_counter(int idx)
> +{
> +       uint64_t v =3D read_sysreg(pmcntenset_el0);
> +
> +       write_sysreg(BIT(idx) | v, pmcntenclr_el0);
> +       isb();
> +}
> +
As mentioned in [1], the current implementation of disable_counter()
is buggy and would end up disabling all the counters.
However if you intend to keep it (even though it would remain unused),
may be change the definition something to:

static inline void disable_counter(int idx)
{
    write_sysreg(BIT(idx), pmcntenclr_el0);
    isb();
}

Thank you.
Raghavendra

[1]: https://lore.kernel.org/all/20231122221526.2750966-1-rananta@google.co=
m/

> +static inline void pmu_disable_reset(void)
> +{
> +       uint64_t pmcr =3D read_sysreg(pmcr_el0);
> +
> +       /* Reset all counters, disabling them */
> +       pmcr &=3D ~ARMV8_PMU_PMCR_E;
> +       write_sysreg(pmcr | ARMV8_PMU_PMCR_P, pmcr_el0);
> +       isb();
> +}
> +
> +#define RETURN_READ_PMEVCNTRN(n) \
> +       return read_sysreg(pmevcntr##n##_el0)
> +static inline unsigned long read_pmevcntrn(int n)
> +{
> +       PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
> +       return 0;
> +}
> +
> +#define WRITE_PMEVCNTRN(n) \
> +       write_sysreg(val, pmevcntr##n##_el0)
> +static inline void write_pmevcntrn(int n, unsigned long val)
> +{
> +       PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
> +       isb();
> +}
> +
> +#define READ_PMEVTYPERN(n) \
> +       return read_sysreg(pmevtyper##n##_el0)
> +static inline unsigned long read_pmevtypern(int n)
> +{
> +       PMEVN_SWITCH(n, READ_PMEVTYPERN);
> +       return 0;
> +}
> +
> +#define WRITE_PMEVTYPERN(n) \
> +       write_sysreg(val, pmevtyper##n##_el0)
> +static inline void write_pmevtypern(int n, unsigned long val)
> +{
> +       PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
> +       isb();
> +}
> --
> 2.40.1
>
>

