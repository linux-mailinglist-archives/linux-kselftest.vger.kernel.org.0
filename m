Return-Path: <linux-kselftest+bounces-18042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4239497A67F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 19:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F01280FEA
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2AC15958A;
	Mon, 16 Sep 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3RBDNKq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22082158870;
	Mon, 16 Sep 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726506732; cv=none; b=VSUrmrvUe7tH2MJ7y2uPUZZdLdEZELQrZsaQh1D3lFTn2L/AsZ3DJlHX5t7C99BrD7Gghy86AiF79OCT7ewBwP1Lqrt7+2cbVBcl1fZeRj/AkG/Kd8QNNmRtod4pAZdOdFVCYbKsmXDIJNDIgEqBOlp09Xruq37LSzsmBoppXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726506732; c=relaxed/simple;
	bh=ESyQ19D7oY453VbqYsz3XtbEyH1pkWUw3SfThNLvBeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIayKTyWQxN107h+lVmflTFYT9CK8vJpWYU1OGKcenyGhjH+3hpX6aXynLyVNaqtuqFJrgvSTBkVHnH6tmBDn2Z2wnTH0p85FdfKLz8lsGj5nOUPX+rWnSjuQeAu37wlxGlut2spk1XaspydQy6xvBRtW9iR9gPOWNNAyh1230s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3RBDNKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F43DC4CEC4;
	Mon, 16 Sep 2024 17:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726506731;
	bh=ESyQ19D7oY453VbqYsz3XtbEyH1pkWUw3SfThNLvBeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D3RBDNKqnKDFIMG0mPW/j5cOna+tieuvNQzY5kyyq91/e9nzLStnQVM7rhf9MXQVr
	 wj2z96u9fAtlMT2N+5Bb5rvUczabmv479ylyy957Xa8rhmLkSZr8a960AJalIKwb/Y
	 uuEqmDiNjIYDix+MB1Vu12/cIDRNvT5TTZoc5H9glGHAMiijHo/ij20SmXxhQwnaY7
	 x7P9QMJrD0ea2CuxOaVAXnKGYl28713NWryQED2HaluTPLvgQTzkUMX8iTWIp/lJ82
	 yPpRjGwDNP4iUfak9BqkzQBpZ3TXtGmzWvbVQqB8NTHZd8+RY/QvQ+ca1mGw4rOYwh
	 e5gREl43NaYxQ==
Date: Mon, 16 Sep 2024 18:12:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v10 14/14] riscv: Add ghostwrite vulnerability
Message-ID: <20240916-pretext-freehand-20dca1376cd4@spud>
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
 <20240911-xtheadvector-v10-14-8d3930091246@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BDWQktOaFXWzZKLA"
Content-Disposition: inline
In-Reply-To: <20240911-xtheadvector-v10-14-8d3930091246@rivosinc.com>


--BDWQktOaFXWzZKLA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 10:55:22PM -0700, Charlie Jenkins wrote:
> Follow the patterns of the other architectures that use
> GENERIC_CPU_VULNERABILITIES for riscv to introduce the ghostwrite
> vulnerability and mitigation. The mitigation is to disable all vector
> which is accomplished by clearing the bit from the cpufeature field.
>=20
> Ghostwrite only affects thead c9xx CPUs that impelment xtheadvector, so
> the vulerability will only be mitigated on these CPUs.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig.errata            | 11 ++++++++
>  arch/riscv/errata/thead/errata.c     | 28 ++++++++++++++++++
>  arch/riscv/include/asm/bugs.h        | 22 +++++++++++++++
>  arch/riscv/include/asm/errata_list.h |  3 +-
>  arch/riscv/kernel/Makefile           |  2 ++
>  arch/riscv/kernel/bugs.c             | 55 ++++++++++++++++++++++++++++++=
++++++
>  arch/riscv/kernel/cpufeature.c       |  9 +++++-
>  drivers/base/cpu.c                   |  3 ++
>  include/linux/cpu.h                  |  1 +
>  9 files changed, 132 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 2acc7d876e1f..e318119d570d 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -119,4 +119,15 @@ config ERRATA_THEAD_PMU
> =20
>  	  If you don't know what to do here, say "Y".
> =20
> +config ERRATA_THEAD_GHOSTWRITE
> +	bool "Apply T-Head Ghostwrite errata"
> +	depends on ERRATA_THEAD && RISCV_ISA_XTHEADVECTOR
> +	default y
> +	help
> +	  The T-Head C9xx cores have a vulnerability in the xtheadvector
> +	  instruction set. When this errata is enabled, the CPUs will be probed
> +	  to determine if they are vulnerable and disable xtheadvector.
> +
> +	  If you don't know what to do here, say "Y".
> +
>  endmenu # "CPU errata selection"
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/e=
rrata.c
> index f5120e07c318..5cc008ab41a8 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -10,6 +10,7 @@
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
>  #include <asm/alternative.h>
> +#include <asm/bugs.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>
>  #include <asm/dma-noncoherent.h>
> @@ -142,6 +143,31 @@ static bool errata_probe_pmu(unsigned int stage,
>  	return true;
>  }
> =20
> +static bool errata_probe_ghostwrite(unsigned int stage,
> +				    unsigned long arch_id, unsigned long impid)
> +{
> +	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_GHOSTWRITE))
> +		return false;
> +
> +	/*
> +	 * target-c9xx cores report arch_id and impid as 0
> +	 *
> +	 * While ghostwrite may not affect all c9xx cores that implement
> +	 * xtheadvector, there is no futher granularity than c9xx. Assume
> +	 * vulnerable for this entire class of processors when xtheadvector is
> +	 * enabled.
> +	 */

Is it not possible to use the cpu compatible string for this? Given that
we only know if xtheadvector is enabled once we are already parsing the
cpu node devicetree, it seems, to me, as if it should be possible to be
more granular. AFAIU, some T-Head c900 series devices are not venerable.

Cheers,
Conor.

> +	if (arch_id !=3D 0 || impid !=3D 0)
> +		return false;
> +
> +	if (stage !=3D RISCV_ALTERNATIVES_EARLY_BOOT)
> +		return false;
> +
> +	ghostwrite_set_vulnerable();
> +
> +	return true;
> +}
> +
>  static u32 thead_errata_probe(unsigned int stage,
>  			      unsigned long archid, unsigned long impid)
>  {
> @@ -155,6 +181,8 @@ static u32 thead_errata_probe(unsigned int stage,
>  	if (errata_probe_pmu(stage, archid, impid))
>  		cpu_req_errata |=3D BIT(ERRATA_THEAD_PMU);
> =20
> +	errata_probe_ghostwrite(stage, archid, impid);
> +
>  	return cpu_req_errata;
>  }
> =20
> diff --git a/arch/riscv/include/asm/bugs.h b/arch/riscv/include/asm/bugs.h
> new file mode 100644
> index 000000000000..e294b15bf78e
> --- /dev/null
> +++ b/arch/riscv/include/asm/bugs.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Interface for managing mitigations for riscv vulnerabilities.
> + *
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +
> +#ifndef __ASM_BUGS_H
> +#define __ASM_BUGS_H
> +
> +/* Watch out, ordering is important here. */
> +enum mitigation_state {
> +	UNAFFECTED,
> +	MITIGATED,
> +	VULNERABLE,
> +};
> +
> +void ghostwrite_set_vulnerable(void);
> +void ghostwrite_enable_mitigation(void);
> +enum mitigation_state ghostwrite_get_state(void);
> +
> +#endif /* __ASM_BUGS_H */
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/as=
m/errata_list.h
> index 7c8a71a526a3..6e426ed7919a 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -25,7 +25,8 @@
>  #ifdef CONFIG_ERRATA_THEAD
>  #define	ERRATA_THEAD_MAE 0
>  #define	ERRATA_THEAD_PMU 1
> -#define	ERRATA_THEAD_NUMBER 2
> +#define	ERRATA_THEAD_GHOSTWRITE 2
> +#define	ERRATA_THEAD_NUMBER 3
>  #endif
> =20
>  #ifdef __ASSEMBLY__
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 06d407f1b30b..d7a54e34178e 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -113,3 +113,5 @@ obj-$(CONFIG_COMPAT)		+=3D compat_vdso/
>  obj-$(CONFIG_64BIT)		+=3D pi/
>  obj-$(CONFIG_ACPI)		+=3D acpi.o
>  obj-$(CONFIG_ACPI_NUMA)	+=3D acpi_numa.o
> +
> +obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) +=3D bugs.o
> diff --git a/arch/riscv/kernel/bugs.c b/arch/riscv/kernel/bugs.c
> new file mode 100644
> index 000000000000..0c19691b4cd5
> --- /dev/null
> +++ b/arch/riscv/kernel/bugs.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/device.h>
> +#include <linux/sprintf.h>
> +
> +#include <asm/bugs.h>
> +#include <asm/vendor_extensions/thead.h>
> +
> +static enum mitigation_state ghostwrite_state;
> +
> +void ghostwrite_set_vulnerable(void)
> +{
> +	ghostwrite_state =3D VULNERABLE;
> +}
> +
> +/*
> + * Vendor extension alternatives will use the value set at the time of b=
oot
> + * alternative patching, thus this must be called before boot alternativ=
es are
> + * patched (and after extension probing) to be effective.
> + */
> +void ghostwrite_enable_mitigation(void)
> +{
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR) &&
> +	    ghostwrite_state =3D=3D VULNERABLE && !cpu_mitigations_off()) {
> +		disable_xtheadvector();
> +		ghostwrite_state =3D MITIGATED;
> +	}
> +}
> +
> +enum mitigation_state ghostwrite_get_state(void)
> +{
> +	return ghostwrite_state;
> +}
> +
> +ssize_t cpu_show_ghostwrite(struct device *dev, struct device_attribute =
*attr, char *buf)
> +{
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR)) {
> +		switch (ghostwrite_state) {
> +		case UNAFFECTED:
> +			return sprintf(buf, "Not affected\n");
> +		case MITIGATED:
> +			return sprintf(buf, "Mitigation: xtheadvector disabled\n");
> +		case VULNERABLE:
> +			fallthrough;
> +		default:
> +			return sprintf(buf, "Vulnerable\n");
> +		}
> +	} else {
> +		return sprintf(buf, "Not affected\n");
> +	}
> +}
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 56b5054b8f86..1f4329bb8a9d 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -17,6 +17,7 @@
>  #include <linux/of.h>
>  #include <asm/acpi.h>
>  #include <asm/alternative.h>
> +#include <asm/bugs.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>
>  #include <asm/hwcap.h>
> @@ -867,7 +868,13 @@ static int __init riscv_fill_hwcap_from_ext_list(uns=
igned long *isa2hwcap)
>  		riscv_fill_vendor_ext_list(cpu);
>  	}
> =20
> -	if (has_xtheadvector_no_alternatives() && has_thead_homogeneous_vlenb()=
 < 0) {
> +	/*
> +	 * Execute ghostwrite mitigation immediately after detecting extensions
> +	 * to disable xtheadvector if necessary.
> +	 */
> +	if (ghostwrite_get_state() =3D=3D VULNERABLE) {
> +		ghostwrite_enable_mitigation();
> +	} else if (has_xtheadvector_no_alternatives() && has_thead_homogeneous_=
vlenb() < 0) {
>  		pr_warn("Unsupported heterogeneous vlenb detected, vector extension di=
sabled.\n");
>  		disable_xtheadvector();
>  	}
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index fdaa24bb641a..a7e511849875 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -599,6 +599,7 @@ CPU_SHOW_VULN_FALLBACK(retbleed);
>  CPU_SHOW_VULN_FALLBACK(spec_rstack_overflow);
>  CPU_SHOW_VULN_FALLBACK(gds);
>  CPU_SHOW_VULN_FALLBACK(reg_file_data_sampling);
> +CPU_SHOW_VULN_FALLBACK(ghostwrite);
> =20
>  static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
>  static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
> @@ -614,6 +615,7 @@ static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed,=
 NULL);
>  static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_over=
flow, NULL);
>  static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
>  static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_=
sampling, NULL);
> +static DEVICE_ATTR(ghostwrite, 0444, cpu_show_ghostwrite, NULL);
> =20
>  static struct attribute *cpu_root_vulnerabilities_attrs[] =3D {
>  	&dev_attr_meltdown.attr,
> @@ -630,6 +632,7 @@ static struct attribute *cpu_root_vulnerabilities_att=
rs[] =3D {
>  	&dev_attr_spec_rstack_overflow.attr,
>  	&dev_attr_gather_data_sampling.attr,
>  	&dev_attr_reg_file_data_sampling.attr,
> +	&dev_attr_ghostwrite.attr,
>  	NULL
>  };
> =20
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index bdcec1732445..6a0a8f1c7c90 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -77,6 +77,7 @@ extern ssize_t cpu_show_gds(struct device *dev,
>  			    struct device_attribute *attr, char *buf);
>  extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
>  					       struct device_attribute *attr, char *buf);
> +extern ssize_t cpu_show_ghostwrite(struct device *dev, struct device_att=
ribute *attr, char *buf);
> =20
>  extern __printf(4, 5)
>  struct device *cpu_device_create(struct device *parent, void *drvdata,
>=20
> --=20
> 2.45.0
>=20

--BDWQktOaFXWzZKLA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuhm5AAKCRB4tDGHoIJi
0o/8AP46nRHLzYJMf/Kn0ccLu8HgFMl06xA2uZNL2DRsNcsvYwEA6UAJp/+RMDFw
Rn7EJEd5f5gEMcMAQ8ZT4ak2Y/t3kws=
=fR+0
-----END PGP SIGNATURE-----

--BDWQktOaFXWzZKLA--

