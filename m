Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBD1428AB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhJKKXS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 06:23:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3956 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbhJKKXS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 06:23:18 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HSZVl73LDz67DRW;
        Mon, 11 Oct 2021 18:17:51 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 11 Oct 2021 12:21:16 +0200
Received: from localhost (10.52.122.204) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 11:21:15 +0100
Date:   Mon, 11 Oct 2021 11:20:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Alan Hayward" <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        "Salil Akerkar" <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 08/38] arm64/sve: Track vector lengths for tasks in
 an array
Message-ID: <20211011112057.00007b90@Huawei.com>
In-Reply-To: <20210930181144.10029-9-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
        <20210930181144.10029-9-broonie@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.204]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 30 Sep 2021 19:11:14 +0100
Mark Brown <broonie@kernel.org> wrote:

> As for SVE we will track a per task SME vector length for tasks. Convert
> the existing storage for the vector length into an array and update
> fpsimd_flush_task() to initialise this in a function.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

I'm clearly having a trivial comment day.  Given reduction in indenting
it would be nice perhaps to reformat comments to take that into account.

I'm also unconvinced the trivial wrappers are worthwhile.  (maybe you drop
those later?)

Jonathan

> ---
>  arch/arm64/include/asm/processor.h   | 44 +++++++++++--
>  arch/arm64/include/asm/thread_info.h |  2 +-
>  arch/arm64/kernel/fpsimd.c           | 97 ++++++++++++++++------------
>  3 files changed, 95 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index fb0608fe9ded..9b854e8196df 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -152,8 +152,8 @@ struct thread_struct {
>  
>  	unsigned int		fpsimd_cpu;
>  	void			*sve_state;	/* SVE registers, if any */
> -	unsigned int		sve_vl;		/* SVE vector length */
> -	unsigned int		sve_vl_onexec;	/* SVE vl after next exec */
> +	unsigned int		vl[ARM64_VEC_MAX];	/* vector length */
> +	unsigned int		vl_onexec[ARM64_VEC_MAX]; /* vl after next exec */
>  	unsigned long		fault_address;	/* fault info */
>  	unsigned long		fault_code;	/* ESR_EL1 value */
>  	struct debug_info	debug;		/* debugging */
> @@ -169,15 +169,45 @@ struct thread_struct {
>  	u64			sctlr_user;
>  };
>  
> +static inline unsigned int thread_get_vl(struct thread_struct *thread,
> +					 enum vec_type type)
> +{
> +	return thread->vl[type];
> +}
> +
>  static inline unsigned int thread_get_sve_vl(struct thread_struct *thread)
>  {
> -	return thread->sve_vl;
> +	return thread_get_vl(thread, ARM64_VEC_SVE);
> +}
> +
> +unsigned int task_get_vl(const struct task_struct *task, enum vec_type type);
> +void task_set_vl(struct task_struct *task, enum vec_type type,
> +		 unsigned long vl);
> +void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
> +			unsigned long vl);
> +unsigned int task_get_vl_onexec(const struct task_struct *task,
> +				enum vec_type type);
> +
> +static inline unsigned int task_get_sve_vl(const struct task_struct *task)
> +{
> +	return task_get_vl(task, ARM64_VEC_SVE);
>  }
>  
> -unsigned int task_get_sve_vl(const struct task_struct *task);
> -void task_set_sve_vl(struct task_struct *task, unsigned long vl);
> -unsigned int task_get_sve_vl_onexec(const struct task_struct *task);
> -void task_set_sve_vl_onexec(struct task_struct *task, unsigned long vl);
> +static inline void task_set_sve_vl(struct task_struct *task, unsigned long vl)
> +{
> +	task_set_vl(task, ARM64_VEC_SVE, vl);

Are these really worth having?  They make the refactor simpler perhaps, but
don't add any meaning in of themselves over just having the calls inline.

> +}
> +
> +static inline unsigned int task_get_sve_vl_onexec(const struct task_struct *task)
> +{
> +	return task_get_vl_onexec(task, ARM64_VEC_SVE);
> +}
> +
> +static inline void task_set_sve_vl_onexec(struct task_struct *task,
> +					  unsigned long vl)
> +{
> +	task_set_vl_onexec(task, ARM64_VEC_SVE, vl);
> +}
>  
>  #define SCTLR_USER_MASK                                                        \
>  	(SCTLR_ELx_ENIA | SCTLR_ELx_ENIB | SCTLR_ELx_ENDA | SCTLR_ELx_ENDB |   \
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 6623c99f0984..d5c8ac81ce11 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -78,7 +78,7 @@ int arch_dup_task_struct(struct task_struct *dst,
>  #define TIF_SINGLESTEP		21
>  #define TIF_32BIT		22	/* 32bit process */
>  #define TIF_SVE			23	/* Scalable Vector Extension in use */
> -#define TIF_SVE_VL_INHERIT	24	/* Inherit sve_vl_onexec across exec */
> +#define TIF_SVE_VL_INHERIT	24	/* Inherit SVE vl_onexec across exec */
>  #define TIF_SSBD		25	/* Wants SSB mitigation */
>  #define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
>  
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 44bb3203c9d1..814080209093 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -133,6 +133,17 @@ __ro_after_init struct vl_info vl_info[ARM64_VEC_MAX] = {
>  #endif
>  };
>  
> +static unsigned int vec_vl_inherit_flag(enum vec_type type)
> +{
> +	switch (type) {
> +	case ARM64_VEC_SVE:
> +		return TIF_SVE_VL_INHERIT;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return 0;
> +	}
> +}
> +
>  struct vl_config {
>  	int __default_vl;		/* Default VL for tasks */
>  };
> @@ -239,24 +250,27 @@ static void sve_free(struct task_struct *task)
>  	__sve_free(task);
>  }
>  
> -unsigned int task_get_sve_vl(const struct task_struct *task)
> +unsigned int task_get_vl(const struct task_struct *task, enum vec_type type)
>  {
> -	return task->thread.sve_vl;
> +	return task->thread.vl[type];
>  }
>  
> -void task_set_sve_vl(struct task_struct *task, unsigned long vl)
> +void task_set_vl(struct task_struct *task, enum vec_type type,
> +		 unsigned long vl)
>  {
> -	task->thread.sve_vl = vl;
> +	task->thread.vl[type] = vl;
>  }
>  
> -unsigned int task_get_sve_vl_onexec(const struct task_struct *task)
> +unsigned int task_get_vl_onexec(const struct task_struct *task,
> +				enum vec_type type)
>  {
> -	return task->thread.sve_vl_onexec;
> +	return task->thread.vl_onexec[type];
>  }
>  
> -void task_set_sve_vl_onexec(struct task_struct *task, unsigned long vl)
> +void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
> +			unsigned long vl)
>  {
> -	task->thread.sve_vl_onexec = vl;
> +	task->thread.vl_onexec[type] = vl;
>  }
>  
>  /*
> @@ -1074,10 +1088,43 @@ void fpsimd_thread_switch(struct task_struct *next)
>  	__put_cpu_fpsimd_context();
>  }
>  
> -void fpsimd_flush_thread(void)
> +static void fpsimd_flush_thread_vl(enum vec_type type)
>  {
>  	int vl, supported_vl;
>  
> +	/*
> +	 * Reset the task vector length as required.  This is where we
> +	 * ensure that all user tasks have a valid vector length

Nice to rewrap this to 80 chars whilst you are here?

> +	 * configured: no kernel task can become a user task without
> +	 * an exec and hence a call to this function.  By the time the
> +	 * first call to this function is made, all early hardware
> +	 * probing is complete, so __sve_default_vl should be valid.
> +	 * If a bug causes this to go wrong, we make some noise and
> +	 * try to fudge thread.sve_vl to a safe value here.
> +	 */
> +	vl = task_get_vl_onexec(current, type);
> +	if (!vl)
> +		vl = get_default_vl(type);
> +
> +	if (WARN_ON(!sve_vl_valid(vl)))
> +		vl = SVE_VL_MIN;
> +
> +	supported_vl = find_supported_vector_length(type, vl);
> +	if (WARN_ON(supported_vl != vl))
> +		vl = supported_vl;
> +
> +	task_set_vl(current, type, vl);
> +
> +	/*
> +	 * If the task is not set to inherit, ensure that the vector
> +	 * length will be reset by a subsequent exec:
> +	 */
> +	if (!test_thread_flag(vec_vl_inherit_flag(type)))
> +		task_set_vl_onexec(current, type, 0);
> +}
> +
> +void fpsimd_flush_thread(void)
> +{
>  	if (!system_supports_fpsimd())
>  		return;
>  
> @@ -1090,37 +1137,7 @@ void fpsimd_flush_thread(void)
>  	if (system_supports_sve()) {
>  		clear_thread_flag(TIF_SVE);
>  		sve_free(current);
> -
> -		/*
> -		 * Reset the task vector length as required.
> -		 * This is where we ensure that all user tasks have a valid
> -		 * vector length configured: no kernel task can become a user
> -		 * task without an exec and hence a call to this function.
> -		 * By the time the first call to this function is made, all
> -		 * early hardware probing is complete, so __sve_default_vl
> -		 * should be valid.
> -		 * If a bug causes this to go wrong, we make some noise and
> -		 * try to fudge thread.sve_vl to a safe value here.
> -		 */
> -		vl = task_get_sve_vl_onexec(current);
> -		if (!vl)
> -			vl = get_sve_default_vl();
> -
> -		if (WARN_ON(!sve_vl_valid(vl)))
> -			vl = SVE_VL_MIN;
> -
> -		supported_vl = find_supported_vector_length(ARM64_VEC_SVE, vl);
> -		if (WARN_ON(supported_vl != vl))
> -			vl = supported_vl;
> -
> -		task_set_sve_vl(current, vl);
> -
> -		/*
> -		 * If the task is not set to inherit, ensure that the vector
> -		 * length will be reset by a subsequent exec:
> -		 */
> -		if (!test_thread_flag(TIF_SVE_VL_INHERIT))
> -			task_set_sve_vl_onexec(current, 0);
> +		fpsimd_flush_thread_vl(ARM64_VEC_SVE);
>  	}
>  
>  	put_cpu_fpsimd_context();

