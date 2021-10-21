Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DDF435E62
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 11:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhJUJ6Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 05:58:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhJUJ6M (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 05:58:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDDE8610D0;
        Thu, 21 Oct 2021 09:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634810156;
        bh=NRXw7FX1C0/t7ziTd29EkH2grm/NO5AyHJqd2JBQiPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opOxKVR9ZKhEKr2zLvhWpk502ISvCze5qo6tK0+xJMKls5HtzRcyHmO/TBwk7mrrD
         0FW1Ly6vKoYr2rw2+jIuQMrpt+sUL+nh3Dz0F/xNXTUHFAREZ837+T6Bdlve2/GbMx
         /8UPEcm/Tpw58UWzZ3I821E0W4tHVXf3MJnkXmtIeDH7iQjtDlu6A7Uo38OQSGdhD9
         C8htXFTGAlBK2+ruWuT6TVYNOqIm+hIu/TzrpcBM+MPJHYcmZbLjTyFq1xiNfWJ15P
         yc/xKS1J2y6i3ExErHO2slXJiWj6TvbbDwW4wQmblTQF03QLo0N+0BgJ+G3AHQDSuL
         OzoVSjWjOgaag==
Date:   Thu, 21 Oct 2021 10:55:51 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 10/42] arm64/sve: Make sysctl interface for SVE
 reusable by SME
Message-ID: <20211021095550.GA16377@willie-the-truck>
References: <20211019172247.3045838-1-broonie@kernel.org>
 <20211019172247.3045838-11-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019172247.3045838-11-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 19, 2021 at 06:22:15PM +0100, Mark Brown wrote:
> The vector length configuration for SME is very similar to that for SVE
> so in order to allow reuse refactor the SVE configuration so that it takes
> the vector type from the struct ctl_table. Since there's no dedicated space
> for this we repurpose the extra1 field to store the vector type, this is
> otherwise unused for integer sysctls.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/fpsimd.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 3474122f9207..53462636b5cf 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -15,6 +15,7 @@
>  #include <linux/compiler.h>
>  #include <linux/cpu.h>
>  #include <linux/cpu_pm.h>
> +#include <linux/ctype.h>
>  #include <linux/kernel.h>
>  #include <linux/linkage.h>
>  #include <linux/irqflags.h>
> @@ -155,11 +156,6 @@ static int get_default_vl(enum vec_type type)
>  	return READ_ONCE(vl_config[type].__default_vl);
>  }
>  
> -static int get_sve_default_vl(void)
> -{
> -	return get_default_vl(ARM64_VEC_SVE);
> -}
> -
>  #ifdef CONFIG_ARM64_SVE
>  
>  static void set_default_vl(enum vec_type type, int val)
> @@ -172,6 +168,11 @@ static void set_sve_default_vl(int val)
>  	set_default_vl(ARM64_VEC_SVE, val);
>  }
>  
> +static int get_sve_default_vl(void)
> +{
> +	return get_default_vl(ARM64_VEC_SVE);
> +}
> +
>  static void __percpu *efi_sve_state;
>  
>  #else /* ! CONFIG_ARM64_SVE */
> @@ -406,17 +407,21 @@ static unsigned int find_supported_vector_length(enum vec_type type,
>  
>  #if defined(CONFIG_ARM64_SVE) && defined(CONFIG_SYSCTL)
>  
> -static int sve_proc_do_default_vl(struct ctl_table *table, int write,
> +static int vec_proc_do_default_vl(struct ctl_table *table, int write,
>  				  void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	struct vl_info *info = &vl_info[ARM64_VEC_SVE];
> +	struct vl_info *info = table->extra1;
> +	enum vec_type type = info->type;
>  	int ret;
> -	int vl = get_sve_default_vl();
> +	int vl = get_default_vl(type);
>  	struct ctl_table tmp_table = {
>  		.data = &vl,
>  		.maxlen = sizeof(vl),
>  	};
>  
> +	if (!info)
> +		return -EINVAL;

Is this check actually needed? If so, you've already dereferenced the
pointer.

Will
