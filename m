Return-Path: <linux-kselftest+bounces-6868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E48916AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 11:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11881F2350B
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 10:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258A1535B4;
	Fri, 29 Mar 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AcWaRrdt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25F0535A2;
	Fri, 29 Mar 2024 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711707781; cv=none; b=dbBGry+kaYaEGGFerCrENzJOuJctNTgxTYOea2f1bYXYnzalISx166H/D2iJTTu15KBP9wWC/WKYOqSGU//WKLvTkPM+4AJfnvboPWM+AZsrzvcCt/T4l1/4YOfbREf2aIU4Rf9GxXEYHu7jPiKzcSI2ksbK53hhUHRyv6AJZKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711707781; c=relaxed/simple;
	bh=1r6x7Gswn3GUpeRZpRuR1fp00nqTBQ5kSjmps/2V46Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=te5V7AaR4MMaUiSQC1K+metUh3nKUXsiGtKMkR7ZSdRIj2/oByAwMHvS2Z1F4EsB+OgDktbEt3Cf/MCIDHksq5jXIDQkVN48bUNRWO4sOFwNZwLjaiLnteOnkYY+0skORWRZRRTouwY96qvpP3vrv/rb7XqGE54WpHMZehSijIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AcWaRrdt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711707779; x=1743243779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1r6x7Gswn3GUpeRZpRuR1fp00nqTBQ5kSjmps/2V46Q=;
  b=AcWaRrdtfDvyPFfk+czcCaofglZV7rRAfD36NRL5PQTOr9bfuqY+iR5W
   3nBzjfDeLYqFUv+d6Q9C7cmO2qb8yspzbroZp/7MaWAQAfSwqBJWmFU9w
   VeGP4eXevNwgGpWjANxs2v3osYX2ladur4frnjNPyGw12KCiMD+wBN3rQ
   3iA39W/jHNIn1XBS/wBgfhtklVaer1MlU3jP+aXogF8tW7H/ZJlX8PzgA
   21UYhWD/ineGGjr0EjPOzh9OcAhixEF4HlLtgBsOzEjojyuqfc86vGs6e
   WXlaSvHQ8EuaGD5Do9iP9DlFVS33OAwJtrNNEewcfN7GFXl04DlxqfvZK
   g==;
X-CSE-ConnectionGUID: QbvD0OvjTziR5bNjZW4tvQ==
X-CSE-MsgGUID: rph7hLVDQvOEe5l5cj2xvA==
X-IronPort-AV: E=Sophos;i="6.07,164,1708412400"; 
   d="asc'?scan'208";a="18638556"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2024 03:22:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 03:22:31 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 03:22:27 -0700
Date: Fri, 29 Mar 2024 10:21:39 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Max Hsu <max.hsu@sifive.com>
CC: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel
 Machek <pavel@ucw.cz>, Anup Patel <anup@brainfault.org>, Atish Patra
	<atishp@atishpatra.org>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Palmer Dabbelt <palmer@sifive.com>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC 05/11] riscv: cpufeature: Add Sdtrig optional CSRs
 checks
Message-ID: <20240329-avid-footgear-ed5e7f8788ba@wendy>
References: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
 <20240329-dev-maxh-lin-452-6-9-v1-5-1534f93b94a7@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8okYWFxSwcNviT76"
Content-Disposition: inline
In-Reply-To: <20240329-dev-maxh-lin-452-6-9-v1-5-1534f93b94a7@sifive.com>

--8okYWFxSwcNviT76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 05:26:21PM +0800, Max Hsu wrote:
> Sdtrig extension introduce two optional CSRs [hcontext/scontext],
> that will be storing PID/Guest OS ID for the debug feature.
>=20
> The availability of these two CSRs will be determined by
> DTS and Smstateen extension [h/s]stateen0 CSR bit 57.
>=20
> If all CPUs hcontext/scontext checks are satisfied, it will enable the
> use_hcontext/use_scontext static branch.
>=20
> Signed-off-by: Max Hsu <max.hsu@sifive.com>
> ---
>  arch/riscv/include/asm/switch_to.h |   6 ++
>  arch/riscv/kernel/cpufeature.c     | 161 +++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 167 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/=
switch_to.h
> index 7efdb0584d47..07432550ed54 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -69,6 +69,12 @@ static __always_inline bool has_fpu(void) { return fal=
se; }
>  #define __switch_to_fpu(__prev, __next) do { } while (0)
>  #endif
> =20
> +DECLARE_STATIC_KEY_FALSE(use_scontext);
> +static __always_inline bool has_scontext(void)
> +{
> +	return static_branch_likely(&use_scontext);
> +}
> +
>  extern struct task_struct *__switch_to(struct task_struct *,
>  				       struct task_struct *);
> =20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 080c06b76f53..44ff84b920af 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -35,6 +35,19 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __=
read_mostly;
>  /* Per-cpu ISA extensions. */
>  struct riscv_isainfo hart_isa[NR_CPUS];
> =20
> +atomic_t hcontext_disable;
> +atomic_t scontext_disable;
> +
> +DEFINE_STATIC_KEY_FALSE_RO(use_hcontext);
> +EXPORT_SYMBOL(use_hcontext);
> +
> +DEFINE_STATIC_KEY_FALSE_RO(use_scontext);
> +EXPORT_SYMBOL(use_scontext);
> +
> +/* Record the maximum number that the hcontext CSR allowed to hold */
> +atomic_long_t hcontext_id_share;
> +EXPORT_SYMBOL(hcontext_id_share);
> +
>  /**
>   * riscv_isa_extension_base() - Get base extension word
>   *
> @@ -719,6 +732,154 @@ unsigned long riscv_get_elf_hwcap(void)
>  	return hwcap;
>  }
> =20
> +static void __init sdtrig_percpu_csrs_check(void *data)
> +{
> +	struct device_node *node;
> +	struct device_node *debug_node;
> +	struct device_node *trigger_module;
> +
> +	unsigned int cpu =3D smp_processor_id();
> +
> +	/*
> +	 * Expect every cpu node has the [h/s]context-present property
> +	 * otherwise, jump to sdtrig_csrs_disable_all to disable all access to
> +	 * [h/s]context CSRs

I think the wording of this comment is kinda strange. What you're trying
to say is that homogeneous support for sdtrig (and the contexts) is
required.

> +	 */
> +	node =3D of_cpu_device_node_get(cpu);

If there's no ACPI support, shouldn't the first thing here by a fast
path out before you start assuming DT?

> +	if (!node)
> +		goto sdtrig_csrs_disable_all;
> +
> +	debug_node =3D of_get_compatible_child(node, "riscv,debug-v1.0.0");
> +	of_node_put(node);
> +
> +	if (!debug_node)
> +		goto sdtrig_csrs_disable_all;
> +
> +	trigger_module =3D of_get_child_by_name(debug_node, "trigger-module");
> +	of_node_put(debug_node);
> +
> +	if (!trigger_module)
> +		goto sdtrig_csrs_disable_all;
> +
> +	if (!(IS_ENABLED(CONFIG_KVM) &&
> +	      of_property_read_bool(trigger_module, "hcontext-present")))
> +		atomic_inc(&hcontext_disable);
> +
> +	if (!of_property_read_bool(trigger_module, "scontext-present"))
> +		atomic_inc(&scontext_disable);

I think we should define pseudo extensions for {h,s}context-present and
parse this out of riscv,isa-extensions. That'd also give you the per-cpu
checks for homogeneous support for "free".
My immediate thought is that sdtrig doesn't seem valuable in isolation,
if you're gonna need additional properties that communicate support for
additional modes.

> +	of_node_put(trigger_module);
> +
> +	/*
> +	 * Before access to hcontext/scontext CSRs, if the smstateen
> +	 * extension is present, the accessibility will be controlled
> +	 * by the hstateen0[H]/sstateen0 CSRs.
> +	 */
> +	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SMSTATEEN)) {

Why can't you use the non-underscore prefixed version of this function
here?

> +		u64 hstateen_bit, sstateen_bit;
> +
> +		if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_h)) {
> +#if __riscv_xlen > 32
> +			csr_set(CSR_HSTATEEN0, SMSTATEEN0_HSCONTEXT);

For zkr we require the CSR to be usable at the privilege level to which
the DT is passed:
        - const: zkr
          description:
            The standard Zkr entropy source extension as ratified in version
            1.0 of RISC-V Cryptography Extensions Volume I specification.
            This string being present means that the CSR associated to this
            extension is accessible at the privilege level to which that
            device-tree has been provided.

I wonder if we should do something similar here and make this a
requirement for anything with bits in stateen registers. I'd love to
avoid having to read CSRs on all harts before being able to make
judgements about whether or not an extension is enabled. I dunno if that
is possible here though, given you want to also make some checks on the
exact nature of the support below.

Cheers,
Conor.

> +			hstateen_bit =3D csr_read(CSR_HSTATEEN0);
> +#else
> +			csr_set(CSR_HSTATEEN0H, SMSTATEEN0_HSCONTEXT >> 32);
> +			hstateen_bit =3D csr_read(CSR_HSTATEEN0H) << 32;
> +#endif
> +			if (!(hstateen_bit & SMSTATEEN0_HSCONTEXT))
> +				goto sdtrig_csrs_disable_all;
> +
> +		} else {
> +			if (IS_ENABLED(CONFIG_KVM))
> +				atomic_inc(&hcontext_disable);
> +
> +			/*
> +			 * In RV32, the smstateen extension doesn't provide
> +			 * high 32 bits of sstateen0 CSR which represent
> +			 * accessibility for scontext CSR;
> +			 * The decision is left on whether the dts has the
> +			 * property to access the scontext CSR.
> +			 */
> +#if __riscv_xlen > 32
> +			csr_set(CSR_SSTATEEN0, SMSTATEEN0_HSCONTEXT);
> +			sstateen_bit =3D csr_read(CSR_SSTATEEN0);
> +
> +			if (!(sstateen_bit & SMSTATEEN0_HSCONTEXT))
> +				atomic_inc(&scontext_disable);
> +#endif
> +		}
> +	}
> +
> +	/*
> +	 * The code can only access hcontext/scontext CSRs if:
> +	 * The cpu dts node have [h/s]context-present;
> +	 * If Smstateen extension is presented, then the accessibility bit
> +	 * toward hcontext/scontext CSRs is enabled; Or the Smstateen extension
> +	 * isn't available, thus the access won't be blocked by it.
> +	 *
> +	 * With writing 1 to the every bit of these CSRs, we retrieve the
> +	 * maximum bits that is available on the CSRs. and decide
> +	 * whether it's suit for its context recording operation.
> +	 */
> +	if (IS_ENABLED(CONFIG_KVM) &&
> +	    !atomic_read(&hcontext_disable)) {
> +		unsigned long hcontext_available_bits =3D 0;
> +
> +		csr_write(CSR_HCONTEXT, -1UL);
> +		hcontext_available_bits =3D csr_swap(CSR_HCONTEXT, hcontext_available_=
bits);
> +
> +		/* hcontext CSR is required by at least 1 bit */
> +		if (hcontext_available_bits)
> +			atomic_long_and(hcontext_available_bits, &hcontext_id_share);
> +		else
> +			atomic_inc(&hcontext_disable);
> +	}
> +
> +	if (!atomic_read(&scontext_disable)) {
> +		unsigned long scontext_available_bits =3D 0;
> +
> +		csr_write(CSR_SCONTEXT, -1UL);
> +		scontext_available_bits =3D csr_swap(CSR_SCONTEXT, scontext_available_=
bits);
> +
> +		/* scontext CSR is required by at least the sizeof pid_t */
> +		if (scontext_available_bits < ((1UL << (sizeof(pid_t) << 3)) - 1))
> +			atomic_inc(&scontext_disable);
> +	}
> +
> +	return;
> +
> +sdtrig_csrs_disable_all:
> +	if (IS_ENABLED(CONFIG_KVM))
> +		atomic_inc(&hcontext_disable);
> +
> +	atomic_inc(&scontext_disable);
> +}
> +
> +static int __init sdtrig_enable_csrs_fill(void)
> +{
> +	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SDTRIG)) {
> +		atomic_long_set(&hcontext_id_share, -1UL);
> +
> +		/* check every CPUs sdtrig extension optional CSRs */
> +		sdtrig_percpu_csrs_check(NULL);
> +		smp_call_function(sdtrig_percpu_csrs_check, NULL, 1);
> +
> +		if (IS_ENABLED(CONFIG_KVM) &&
> +		    !atomic_read(&hcontext_disable)) {
> +			pr_info("riscv-sdtrig: Writing 'GuestOS ID' to hcontext CSR is enable=
d\n");
> +			static_branch_enable(&use_hcontext);
> +		}
> +
> +		if (!atomic_read(&scontext_disable)) {
> +			pr_info("riscv-sdtrig: Writing 'PID' to scontext CSR is enabled\n");
> +			static_branch_enable(&use_scontext);
> +		}
> +	}
> +	return 0;
> +}
> +
> +arch_initcall(sdtrig_enable_csrs_fill);
> +
>  void riscv_user_isa_enable(void)
>  {
>  	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_=
ZICBOZ))
>=20
> --=20
> 2.43.2
>=20

--8okYWFxSwcNviT76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgaWMwAKCRB4tDGHoIJi
0h1GAP4+5oXB5cobRxRtWLslJG09DwwJGYWbihRkLfHJDm/UFgD/S1TTku0iG2+W
X79DFf9P7rs4DeI4yWy2X6xC2rQfGgY=
=hWrB
-----END PGP SIGNATURE-----

--8okYWFxSwcNviT76--

