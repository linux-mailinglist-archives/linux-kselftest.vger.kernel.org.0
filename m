Return-Path: <linux-kselftest+bounces-7780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F3E8A28F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 10:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F9F1C21D94
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 08:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A4E4F200;
	Fri, 12 Apr 2024 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsbuqPSj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D65182DF;
	Fri, 12 Apr 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909688; cv=none; b=eGs+AS4U1YsQ3+7G6ya3fECnLk3prDcaWD5eACd0cmSJd7e1lgtBmwfha7UnySF2uEEjQANFZKZDDt+ftdikox6tfaUJJcEeR/6X0H5HJ+lYY2adt84ryV7ZuCw7AG5/IqK6E01WhxKVRa1iFeW3J/QsPqen6qxMKymOmB/Phdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909688; c=relaxed/simple;
	bh=a0qLjKxBtHOgn5g9o5nOx2EYCPyMSiqw+0xX4M9kGIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+R4NT95LaO/2Kr5WNSNfdXZpy0PNpP+l+BwEZSib/ajj1TCUwWgRoYfr/D99xuHsX/0nsbKnuy3WbGzfXhb3b07AEOD+nY2SjSFvv7U0MhEauqwkMHOcFyMN8iM7kdiaNZu7NSSLrKzruog8WkdxklJu91cjLkkk5XqaI0XpSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsbuqPSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BC2C113CC;
	Fri, 12 Apr 2024 08:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712909687;
	bh=a0qLjKxBtHOgn5g9o5nOx2EYCPyMSiqw+0xX4M9kGIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsbuqPSjh+B2tJ+Uyah1zXHR6JlX4N5f8YbdxPNONWaEBIATj8ttmX1l5FLu7ueHz
	 AYmgnLICRoHKgEpYpJiqcvLMGJNGMtoAuoUZxA3nlGCar6T2YPbCiVf9YjoXPc3Qom
	 cvqwyvrPL2IWYCn5jncvbetK86nSvdXXBelSagCeM+dBECRqKeX/SJ/G2DTa8Z/znm
	 XDc2J/wrtWTkXmllHmI/5SpiOj5C+e5cI3J0xZHZgb3xXdVSITD5VUDtFgSA0SG8sO
	 Cluol/CW6q17bNjTrBqxE+uTZJfxYJHyG6XZcSEVMk8ZNxwAvaFh+I/FRCcSysVB1Z
	 4KR3Bs2MKy2hw==
Date: Fri, 12 Apr 2024 10:14:40 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH RFC bpf-next v6 2/6] bpf: Add support for
 KF_ARG_PTR_TO_TIMER
Message-ID: <ujmvbzbu4yzubk5jvpy5saclqi2yhwu7c6fsgs4dinvzekazh2@khwefybboea2>
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
 <20240408-hid-bpf-sleepable-v6-2-0499ddd91b94@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408-hid-bpf-sleepable-v6-2-0499ddd91b94@kernel.org>

On Apr 08 2024, bentiss@kernel.org wrote:
> From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> 
> Introduce support for KF_ARG_PTR_TO_TIMER. The kfuncs will use bpf_timer
> as argument and that will be recognized as timer argument by verifier.
> bpf_timer_kern casting can happen inside kfunc, but using bpf_timer in
> argument makes life easier for users who work with non-kern type in BPF
> progs.
> 
> Fix up process_timer_func's meta argument usage (ignore if NULL) so that
> we can share the same checks for helpers and kfuncs. meta argument is
> only needed to ensure bpf_timer_init's timer and map arguments are
> coming from the same map (map_uid logic is necessary for correct
> inner-map handling).
> 
> No such concerns will be necessary for kfuncs as timer initialization
> happens using helpers, hence pass NULL to process_timer_func from kfunc
> argument handling code to ignore it.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> ---
> 
> changes in v6:
> - used Kumar's version of the patch
> - reverted `+BTF_ID(struct, bpf_timer_kern)`

My bad. While working on bpf_wq I realized I shouldn't have touched this
part. See below:

> 
> changes in v5:
> - also check for the reg offset
> 
> changes in v4:
> - enforce KF_ARG_PTR_TO_TIMER to be of type PTR_TO_MAP_VALUE
> 
> new in v3 (split from v2 02/10)
> ---
>  kernel/bpf/verifier.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ca6cacf7b42f..ccfe9057d8dc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7568,12 +7568,16 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
>  			val + reg->off, map->record->timer_off);
>  		return -EINVAL;
>  	}
> +	/* meta is only needed for bpf_timer_init to match timer and map */
> +	if (!meta)
> +		goto out;
>  	if (meta->map_ptr) {
>  		verbose(env, "verifier bug. Two map pointers in a timer helper\n");
>  		return -EFAULT;
>  	}
>  	meta->map_uid = reg->map_uid;
>  	meta->map_ptr = map;
> +out:
>  	return 0;
>  }
>  
> @@ -10826,6 +10830,7 @@ enum {
>  	KF_ARG_LIST_NODE_ID,
>  	KF_ARG_RB_ROOT_ID,
>  	KF_ARG_RB_NODE_ID,
> +	KF_ARG_TIMER_ID,
>  };
>  
>  BTF_ID_LIST(kf_arg_btf_ids)
> @@ -10834,6 +10839,7 @@ BTF_ID(struct, bpf_list_head)
>  BTF_ID(struct, bpf_list_node)
>  BTF_ID(struct, bpf_rb_root)
>  BTF_ID(struct, bpf_rb_node)
> +BTF_ID(struct, bpf_timer_kern)

As Kumar originally put, this should be BTF_ID(struct, bpf_timer), and
he explained everything in the commit message. I was just too dumb to
understand it properly.

(Adding a comment here in case we want to extend bpf_timer API in the
future, and so this patch will be useful).

Cheers,
Benjamin

>  
>  static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
>  				    const struct btf_param *arg, int type)
> @@ -10877,6 +10883,11 @@ static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct btf_par
>  	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID);
>  }
>  
> +static bool is_kfunc_arg_timer(const struct btf *btf, const struct btf_param *arg)
> +{
> +	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_TIMER_ID);
> +}
> +
>  static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const struct btf *btf,
>  				  const struct btf_param *arg)
>  {
> @@ -10946,6 +10957,7 @@ enum kfunc_ptr_arg_type {
>  	KF_ARG_PTR_TO_NULL,
>  	KF_ARG_PTR_TO_CONST_STR,
>  	KF_ARG_PTR_TO_MAP,
> +	KF_ARG_PTR_TO_TIMER,
>  };
>  
>  enum special_kfunc_type {
> @@ -11102,6 +11114,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>  	if (is_kfunc_arg_map(meta->btf, &args[argno]))
>  		return KF_ARG_PTR_TO_MAP;
>  
> +	if (is_kfunc_arg_timer(meta->btf, &args[argno]))
> +		return KF_ARG_PTR_TO_TIMER;
> +
>  	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
>  		if (!btf_type_is_struct(ref_t)) {
>  			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
> @@ -11735,6 +11750,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  		case KF_ARG_PTR_TO_CALLBACK:
>  		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
>  		case KF_ARG_PTR_TO_CONST_STR:
> +		case KF_ARG_PTR_TO_TIMER:
>  			/* Trusted by default */
>  			break;
>  		default:
> @@ -12021,6 +12037,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			if (ret)
>  				return ret;
>  			break;
> +		case KF_ARG_PTR_TO_TIMER:
> +			if (reg->type != PTR_TO_MAP_VALUE) {
> +				verbose(env, "arg#%d doesn't point to a map value\n", i);
> +				return -EINVAL;
> +			}
> +			ret = process_timer_func(env, regno, NULL);
> +			if (ret < 0)
> +				return ret;
> +			break;
>  		}
>  	}
>  
> 
> -- 
> 2.44.0
> 

