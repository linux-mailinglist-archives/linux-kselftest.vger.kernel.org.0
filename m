Return-Path: <linux-kselftest+bounces-8397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55A28AA827
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 08:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A581282B8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 06:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C13C129;
	Fri, 19 Apr 2024 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUwpL88V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7B3BA41;
	Fri, 19 Apr 2024 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506466; cv=none; b=t3lt3cXVK3Uuq2IXMHHkVWPdgK0IYQ80X/pmScAF8Yq/mknzVKVV7VJJ6BA/WZv5Duaavz5G5xZOmfhs2BtJ0AdaY4ZM1kmPESr2TU0B/F8c8SzlnsEMcR5mts8/5N+NnUgrJExk8hW52cGJfD01CFWySadgCKQOAr6PPOspguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506466; c=relaxed/simple;
	bh=vEfr/2mHS3kQKxZRo1YmDmJmMS/GOSvFzjpyZ2bD2v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdwM6GFwVjYBzLCk9tYYvAkUkF1rhXf83uMm0L0LSJmawW+GpjmrMNNDw4Lfd0eX9KY4UPLNJIu7o+9icV8Xap2qj8VKBFYLK8/lMNIqpC6WJwldKnZINKAfFiz3+0F7vZ1UXxtJ0bwq0IwLR70qWA6C2pWFLbTcVNej6Gg7Sf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUwpL88V; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso1246405a12.3;
        Thu, 18 Apr 2024 23:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713506463; x=1714111263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c8lk+adx8LAtX6qbpCQuQPq6JXuFchNPspBiKO0qmRI=;
        b=NUwpL88VPD8RTb0A2RFbgULFQZPPFODJX3UesE7SZzdrF8SAzN+ISAEUgh0jORs4J9
         KqoiMCEtaxZ0vHgI4rhWZyP6vUIIq3mqfI+/pez8sAncnnGZuiRmUEXSb1ICveZZTjBq
         Jx885m5nFOFXiHJSGRXqYyLYWsbd+u2iUZaWpXln4Z0E0kHnFdDC3upq+eDHoAGVmApd
         k8S1Tvv1xpHMzwt7WUZFqmznlywV63vznu04qwFz5rBgDOQ6eWKDATUrdvHMJFPpNOdz
         zRxiil0shjhk1pUG+2YAsVqButlBznCyxWEtDxruLYVdKALP2fMaua0LO7/aokfzsXfz
         N/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713506463; x=1714111263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8lk+adx8LAtX6qbpCQuQPq6JXuFchNPspBiKO0qmRI=;
        b=aiPiAjXvf9ZIZSp1lptZVJMk76Jvc9iCs7Zj+hX5UNYjKQhhVRKJAHfZC3Nl8JmuuK
         wrT3Fls8GA2jpfD5YHDDzwu7udol9c7ZAXeSy/WTqJOCqkw+Y915O9277m8CAx2l/d2x
         RbloYwJgie5y14uvskHizPStCYk5EdtBmWaIrOZ/XmYVZEIpZH6Z2CUNh/3YTGuYjP45
         NFGq5yr0Rpf26RMpB4D/yDv/bplR7wFLY3qBTjaGSA/5FhIwI4IA9PZ/iD4ngO/azB9z
         uyrP3ngyrf5riOmIQ2ABs8W3m+TuvfbLYeQL6vXgu3z//3yW6RvRagC2ktKo0XI4/he+
         Auqw==
X-Forwarded-Encrypted: i=1; AJvYcCV4FD5N8qTXSdPBorjqvlFqUlNwUXDfweOoPPopufcNEL4pWRrUmfovNmIHaDkoDgaIpi7irCC4/qJisdsnDyg+iJhKmsE2A02jM3xm9vVQSiXaSFmmVFC+EyTdoG6uYdbuk91WWjQtA6XhBOVy/lnN9OzFuBM4RA7Cz5jhr//kdhiZ
X-Gm-Message-State: AOJu0YxmjbYfhUuRH+G2bvr+4d1InZzvryZ7vCcNhEGmnfIRV8erYE0w
	PdzMYY6tSahYscozaNBROfiPdnw5EZ441y9mZcTtArNencYn4F8A
X-Google-Smtp-Source: AGHT+IH78bRPKUvMvaJjYUvlBiDT1oqCUhnxxtt0Qe2fWQAzk44QDnWyeewONAibgiD3C+Uo72INAg==
X-Received: by 2002:a05:6a21:3a82:b0:1ac:3c97:5cbe with SMTP id zv2-20020a056a213a8200b001ac3c975cbemr989581pzb.46.1713506463545;
        Thu, 18 Apr 2024 23:01:03 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:fbcc])
        by smtp.gmail.com with ESMTPSA id km3-20020a056a003c4300b006eaa21301a7sm2470308pfb.162.2024.04.18.23.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 23:01:03 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:00:58 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 08/18] bpf: add support for
 KF_ARG_PTR_TO_WORKQUEUE
Message-ID: <wkcvx6cgti2mowyn646usogqe5ebafsj2k5oejn7tbvzgwttfb@c62ktm7za5ru>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
 <20240416-bpf_wq-v1-8-c9e66092f842@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-bpf_wq-v1-8-c9e66092f842@kernel.org>

On Tue, Apr 16, 2024 at 04:08:21PM +0200, Benjamin Tissoires wrote:
> Introduce support for KF_ARG_PTR_TO_WORKQUEUE. The kfuncs will use bpf_wq
> as argument and that will be recognized as workqueue argument by verifier.
> bpf_wq_kern casting can happen inside kfunc, but using bpf_wq in
> argument makes life easier for users who work with non-kern type in BPF
> progs.
> 
> Duplicate process_timer_func into process_wq_func.
> meta argument is only needed to ensure bpf_wq_init's workqueue and map
> arguments are coming from the same map (map_uid logic is necessary for
> correct inner-map handling), so also amend check_kfunc_args() to
> match what helpers functions check is doing.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  kernel/bpf/verifier.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index deaf2e1ab690..112faf2cd7e9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -332,6 +332,10 @@ struct bpf_kfunc_call_arg_meta {
>  		u8 spi;
>  		u8 frameno;
>  	} iter;
> +	struct {
> +		struct bpf_map *ptr;
> +		int uid;
> +	} map;
>  	u64 mem_size;
>  };
>  
> @@ -7598,6 +7602,43 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
>  	return 0;
>  }
>  
> +static int process_wq_func(struct bpf_verifier_env *env, int regno,
> +			   struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> +	bool is_const = tnum_is_const(reg->var_off);
> +	struct bpf_map *map = reg->map_ptr;
> +	u64 val = reg->var_off.value;
> +
> +	if (!is_const) {
> +		verbose(env,
> +			"R%d doesn't have constant offset. bpf_wq has to be at the constant offset\n",
> +			regno);
> +		return -EINVAL;
> +	}

This check is unnecessary.
Before calling into this function it goes as:
switch (kf_arg_type) {
case KF_ARG_PTR_TO_MAP:
    ... your new checks ...
    fallthrough;
case KF_ARG_PTR_TO_CTX:
    arg_type |= OBJ_RELEASE;
    break;

check_func_arg_reg_off()
  if (arg_type_is_release(arg_type)
      return __check_ptr_off_reg() 
      // that does offset checks

> +	if (!map->btf) {
> +		verbose(env, "map '%s' has to have BTF in order to use bpf_wq\n",
> +			map->name);
> +		return -EINVAL;
> +	}
> +	if (!btf_record_has_field(map->record, BPF_WORKQUEUE)) {
> +		verbose(env, "map '%s' has no valid bpf_wq\n", map->name);
> +		return -EINVAL;
> +	}

above two are also unnecessary. wq_off will be negative otherwise.

> +	if (map->record->wq_off != val + reg->off) {
> +		verbose(env, "off %lld doesn't point to 'struct bpf_wq' that is at %d\n",
> +			val + reg->off, map->record->wq_off);
> +		return -EINVAL;
> +	}

only this one is needed, but I need to study the rest of the patches.

> +	if (meta->map.ptr) {
> +		verbose(env, "verifier bug. Two map pointers in a workqueue helper\n");
> +		return -EFAULT;
> +	}

this was checked already as well.

> +	meta->map.uid = reg->map_uid;
> +	meta->map.ptr = map;
> +	return 0;
> +}
> +
>  static int process_kptr_func(struct bpf_verifier_env *env, int regno,
>  			     struct bpf_call_arg_meta *meta)
>  {
> @@ -10843,6 +10884,7 @@ enum {
>  	KF_ARG_LIST_NODE_ID,
>  	KF_ARG_RB_ROOT_ID,
>  	KF_ARG_RB_NODE_ID,
> +	KF_ARG_WORKQUEUE_ID,
>  };
>  
>  BTF_ID_LIST(kf_arg_btf_ids)
> @@ -10851,6 +10893,7 @@ BTF_ID(struct, bpf_list_head)
>  BTF_ID(struct, bpf_list_node)
>  BTF_ID(struct, bpf_rb_root)
>  BTF_ID(struct, bpf_rb_node)
> +BTF_ID(struct, bpf_wq)
>  
>  static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
>  				    const struct btf_param *arg, int type)
> @@ -10894,6 +10937,11 @@ static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct btf_par
>  	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID);
>  }
>  
> +static bool is_kfunc_arg_wq(const struct btf *btf, const struct btf_param *arg)
> +{
> +	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_WORKQUEUE_ID);
> +}
> +
>  static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const struct btf *btf,
>  				  const struct btf_param *arg)
>  {
> @@ -10963,6 +11011,7 @@ enum kfunc_ptr_arg_type {
>  	KF_ARG_PTR_TO_NULL,
>  	KF_ARG_PTR_TO_CONST_STR,
>  	KF_ARG_PTR_TO_MAP,
> +	KF_ARG_PTR_TO_WORKQUEUE,
>  };
>  
>  enum special_kfunc_type {
> @@ -11119,6 +11168,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>  	if (is_kfunc_arg_map(meta->btf, &args[argno]))
>  		return KF_ARG_PTR_TO_MAP;
>  
> +	if (is_kfunc_arg_wq(meta->btf, &args[argno]))
> +		return KF_ARG_PTR_TO_WORKQUEUE;
> +
>  	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
>  		if (!btf_type_is_struct(ref_t)) {
>  			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
> @@ -11720,6 +11772,30 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  		case KF_ARG_PTR_TO_NULL:
>  			continue;
>  		case KF_ARG_PTR_TO_MAP:
> +			if (meta->map.ptr) {
> +				/* Use map_uid (which is unique id of inner map) to reject:
> +				 * inner_map1 = bpf_map_lookup_elem(outer_map, key1)
> +				 * inner_map2 = bpf_map_lookup_elem(outer_map, key2)
> +				 * if (inner_map1 && inner_map2) {
> +				 *     timer = bpf_map_lookup_elem(inner_map1);
> +				 *     if (timer)
> +				 *         // mismatch would have been allowed
> +				 *         bpf_timer_init(timer, inner_map2);

adjust the comment too. Here it can only be wq.

> +				 * }
> +				 *
> +				 * Comparing map_ptr is enough to distinguish normal and outer maps.
> +				 */
> +				if (meta->map.ptr != reg->map_ptr ||
> +				    meta->map.uid != reg->map_uid) {

let's also gate this check with map->record->wq_off.
Otherwise it will trigger for maps that don't have wq field.

Copy paste is a bit unfortunate, but fine. We can clean it up later.

> +					verbose(env,
> +						"workqueue pointer in R1 map_uid=%d doesn't match map pointer in R2 map_uid=%d\n",
> +						meta->map.uid, reg->map_uid);
> +					return -EINVAL;
> +				}
> +			}
> +			meta->map.ptr = reg->map_ptr;
> +			meta->map.uid = reg->map_uid;
> +			fallthrough;
>  		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
>  		case KF_ARG_PTR_TO_BTF_ID:
>  			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
> @@ -11752,6 +11828,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  		case KF_ARG_PTR_TO_CALLBACK:
>  		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
>  		case KF_ARG_PTR_TO_CONST_STR:
> +		case KF_ARG_PTR_TO_WORKQUEUE:
>  			/* Trusted by default */
>  			break;
>  		default:
> @@ -12038,6 +12115,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			if (ret)
>  				return ret;
>  			break;
> +		case KF_ARG_PTR_TO_WORKQUEUE:
> +			if (reg->type != PTR_TO_MAP_VALUE) {
> +				verbose(env, "arg#%d doesn't point to a map value\n", i);
> +				return -EINVAL;
> +			}
> +			ret = process_wq_func(env, regno, meta);
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

