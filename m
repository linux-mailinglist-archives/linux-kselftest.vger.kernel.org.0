Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7474375EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Oct 2021 13:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhJVLZn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Oct 2021 07:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232539AbhJVLZn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Oct 2021 07:25:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 511CB60F8F;
        Fri, 22 Oct 2021 11:23:24 +0000 (UTC)
Date:   Fri, 22 Oct 2021 12:23:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 07/42] arm64/sve: Put system wide vector length
 information into structs
Message-ID: <YXKfKJHRkiu6AXqy@arm.com>
References: <20211019172247.3045838-1-broonie@kernel.org>
 <20211019172247.3045838-8-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019172247.3045838-8-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 19, 2021 at 06:22:12PM +0100, Mark Brown wrote:
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index d164e2f35837..5a1f79a4a500 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -77,10 +77,6 @@ extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
>  
>  extern u64 read_zcr_features(void);
>  
> -extern int __ro_after_init sve_max_vl;
> -extern int __ro_after_init sve_max_virtualisable_vl;
> -extern __ro_after_init DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
> -
>  /*
>   * Helpers to translate bit indices in sve_vq_map to VQ values (and
>   * vice versa).  This allows find_next_bit() to be used to find the
[...]
> @@ -139,11 +151,63 @@ static inline void sve_user_enable(void)
[...]
> +static inline int sve_max_virtualisable_vl(void)
> +{
> +	return vec_max_virtualisable_vl(ARM64_VEC_SVE);
> +}

With this change, sve_max_virtualisable_vl() is only defined if
CONFIG_ARM64_SVE is enabled but it's still referenced from
kvm_arm_init_sve() and kvm_vcpu_finalize_sve(), so the build fails if
SVE is disabled.

> +static struct vl_config vl_config[ARM64_VEC_MAX];
> +
> +static int get_default_vl(enum vec_type type)
> +{
> +	return READ_ONCE(vl_config[type].__default_vl);
> +}
>  
>  static int get_sve_default_vl(void)
>  {
> -	return READ_ONCE(__sve_default_vl);
> +	return get_default_vl(ARM64_VEC_SVE);
>  }
>  
>  #ifdef CONFIG_ARM64_SVE

I think after patch 9 I think I also get a warning on
get_sve_default_vl() defined but not used when SVE is disabled. Maybe
move the #ifdef higher but also make these static inline.

>  
> -static void set_sve_default_vl(int val)
> +static void set_default_vl(enum vec_type type, int val)
>  {
> -	WRITE_ONCE(__sve_default_vl, val);
> +	WRITE_ONCE(vl_config[type].__default_vl, val);
>  }

Same here, it should probably be static inline.

>  
> -/* Maximum supported vector length across all CPUs (initially poisoned) */
> -int __ro_after_init sve_max_vl = SVE_VL_MIN;
> -int __ro_after_init sve_max_virtualisable_vl = SVE_VL_MIN;
> -
> -/*
> - * Set of available vector lengths,
> - * where length vq encoded as bit __vq_to_bit(vq):
> - */
> -__ro_after_init DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
> -/* Set of vector lengths present on at least one cpu: */
> -static __ro_after_init DECLARE_BITMAP(sve_vq_partial_map, SVE_VQ_MAX);
> +static void set_sve_default_vl(int val)
> +{
> +	set_default_vl(ARM64_VEC_SVE, val);
> +}

And here.

-- 
Catalin
