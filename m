Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0889F5A200E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 06:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244545AbiHZEyp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 00:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHZEyo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 00:54:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C215FCE469;
        Thu, 25 Aug 2022 21:54:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7182CB82F72;
        Fri, 26 Aug 2022 04:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F82C433C1;
        Fri, 26 Aug 2022 04:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661489680;
        bh=idc5YK1jlEolWA/qY99HMYvkp3aVHFDcLFOg74vVVrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SkEn5kNLMNfBdbTHtCCAQaN54nmtTmCnJB/wyOS+bxJgWnPIqaJ1png/uRIJyLzj2
         rDJMzBTqCJq9hpF2B+qL9Ipyus+ct7dSd26CbGbvE1UZyrnsVZD9VbBwvWikWuaiMW
         uKBXYXwGw7y1nVlmwheIcN2maMxd1bd+7/gKRGipsDdUuJ+zrdJdoQS2Pe+ymn4yy4
         tC0a82BjrlgGORBxRCIrFbsvbMIrh/IikyuEFzx6cv1dsdnOeEYELneVqXTv0jTasB
         B6r8D1NzZfBhu70ajF1kVM6vrV/l8RVm+YQ2jHhIeatZtI4xc9wThbOmcy8IXlH9c/
         sSno1X/t0tF2A==
Date:   Fri, 26 Aug 2022 07:54:32 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     roberto.sassu@huaweicloud.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        corbet@lwn.net, dhowells@redhat.com, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH v12 02/10] btf: Handle dynamic pointer parameter in kfuncs
Message-ID: <YwhSCE0H+JfUe4Ew@kernel.org>
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
 <20220818152929.402605-3-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818152929.402605-3-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 18, 2022 at 05:29:21PM +0200, roberto.sassu@huaweicloud.com wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Allow the bpf_dynptr_kern parameter to be specified in kfuncs. Also, ensure
> that the dynamic pointer is valid and initialized.
> 
> To properly detect whether a parameter is of the desired type, introduce
> the stringify_struct() macro to compare the returned structure name with
> the desired name. In addition, protect against structure renames, by
> halting the build with BUILD_BUG_ON(), so that developers have to revisit
> the code.
> 
> Cc: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/bpf_verifier.h |  3 +++
>  include/linux/btf.h          |  9 +++++++++
>  kernel/bpf/btf.c             | 18 ++++++++++++++++++
>  kernel/bpf/verifier.c        |  4 ++--
>  4 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 2e3bad8640dc..55876fbdbae2 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -560,6 +560,9 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
>  			     u32 regno);
>  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>  		   u32 regno, u32 mem_size);
> +bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> +			      struct bpf_reg_state *reg,
> +			      enum bpf_arg_type arg_type);
>  
>  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
>  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index ad93c2d9cc1c..f546d368ac5d 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -52,6 +52,15 @@
>  #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
>  #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
>  
> +/*
> + * Return the name of the passed struct, if exists, or halt the build if for
> + * example the structure gets renamed. In this way, developers have to revisit
> + * the code using that structure name, and update it accordingly.
> + */
> +#define stringify_struct(x)			\
> +	({ BUILD_BUG_ON(sizeof(struct x) < 0);	\
> +	   __stringify(x); })
> +
>  struct btf;
>  struct btf_member;
>  struct btf_type;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index e49b3b6d48ad..26cb548420af 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6362,15 +6362,20 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  
>  			if (is_kfunc) {
>  				bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
> +				bool arg_dynptr = btf_type_is_struct(ref_t) &&
> +						  !strcmp(ref_tname,
> +							  stringify_struct(bpf_dynptr_kern));
>  
>  				/* Permit pointer to mem, but only when argument
>  				 * type is pointer to scalar, or struct composed
>  				 * (recursively) of scalars.
>  				 * When arg_mem_size is true, the pointer can be
>  				 * void *.
> +				 * Also permit initialized dynamic pointers.
>  				 */
>  				if (!btf_type_is_scalar(ref_t) &&
>  				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
> +				    !arg_dynptr &&
>  				    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
>  					bpf_log(log,
>  						"arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
> @@ -6378,6 +6383,19 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  					return -EINVAL;
>  				}
>  
> +				if (arg_dynptr) {
> +					if (!is_dynptr_reg_valid_init(env, reg,
> +							ARG_PTR_TO_DYNPTR)) {
> +						bpf_log(log,
> +							"arg#%d pointer type %s %s must be initialized\n",
> +							i, btf_type_str(ref_t),
> +							ref_tname);
> +						return -EINVAL;
> +					}
> +
> +					continue;
> +				}
> +
>  				/* Check for mem, len pair */
>  				if (arg_mem_size) {
>  					if (check_kfunc_mem_size_reg(env, &regs[regno + 1], regno + 1)) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2c1f8069f7b7..aa834e7bb296 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -779,8 +779,8 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
>  	return true;
>  }
>  
> -static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> -				     enum bpf_arg_type arg_type)
> +bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +			      enum bpf_arg_type arg_type)
>  {
>  	struct bpf_func_state *state = func(env, reg);
>  	int spi = get_spi(reg->off);
> -- 
> 2.25.1
> 

Might be niticking but generally I'd consider splitting
exports as commits of their own.

BR, Jarko
