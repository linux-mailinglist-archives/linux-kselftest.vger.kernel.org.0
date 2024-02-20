Return-Path: <linux-kselftest+bounces-5047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5190F85C257
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B69285A18
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 17:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0797F76C69;
	Tue, 20 Feb 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMBYgHSj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD3B76909;
	Tue, 20 Feb 2024 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449516; cv=none; b=u/iKt7o5Z0EDvm8s/0Xgwm1cvV/ZTH56O+ydaOOjIOpkfq/KwdGix0Cn1iPeyqp9lh6BEEYgpADiNlisDNfuPrFUzMw5Z95fypmlwnTnvKI97mAqCEQzYDSxvjEFIvaBbU/AT+8OT09DVkoQk3hPBY7UgNsij3QJOaWZ2gnIYIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449516; c=relaxed/simple;
	bh=BVzlnbEPLER7R7THzPc5B1uYCCS6jDIuLa1IqpQ5PA4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7NYU/Q6z9aUMWl3VfYNpSdue4dUhfHBLLm/qhq6k95KdnNAWlJ4sARifNQLBChbKzvqPjDk4ZboBQZNdahMr+rq4t1v4qnvGJxdD5LL6zZe7cc4632L1KWvshDwoSR4NFkxWzQW4OOJr5I4IJiOIOBR2G3VISUY9CrA1RhdtDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMBYgHSj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so795176266b.0;
        Tue, 20 Feb 2024 09:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708449513; x=1709054313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dmxS6iktBtidz6yGIwqms+MtYfTcC8Gwrx4Li+2LctM=;
        b=XMBYgHSjW1pXnuRJWXWJV9+GNB7SdT2yBsoYWBSrB4HImFCTfOdSP1FdRaKQlbebDE
         M96vPMUp8YpJ8tcUtpxkDI9jpy5JXYTGyIHvaMxDapK1QDga1I42gwIVWCMphT2mknWG
         Gl/HPEB0CMAnjc98DAfRKkYxh1G1QPBnvLqwF60DiAzSE7Bn5FbpAxOCaTeQaaJ82XxN
         mLFeARqbn/1As36meb8b2EMQE6Go+yvL0rj63gCjORgu5ZniaVoZ2+sbh1G1WLzGafzm
         LZi06c//T6t8Gjr9A0KH7hAxsYEtbMagoC/dsIqpQlsK+yHSKSj6JPFf6q6NXfpPyYGZ
         HVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708449513; x=1709054313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmxS6iktBtidz6yGIwqms+MtYfTcC8Gwrx4Li+2LctM=;
        b=MeRb4rcmwFOLF+LSneN6G4UJfmFNurqyyplWhkX2Ju57/fIUOBzHl4lG8DldzA105q
         W2XUBHylE9S8SmnCJDdte+ec07diWOAuclJRXEu1FsgLKE7LYlg410ugokOSQucW02Iv
         ZeNcjCIdrifH2lNY/9aw1WGleMFfnWIFGelHUg78dgmWIh1d2B/DzsoWf/3Zr9Za+d34
         cLg630T+msJqpg0oTgkmkSv2v6tDfBPWIkPyCNFiB32WMFGHx4oa1ei85FPT/1/lKbpE
         +Zft95CeeWcjGmRdbzBPXLWnA4Q2J53WQ9DXqfM/LlUqEJuE0Mr+PilkwvK+Q80ZFoRX
         zEdw==
X-Forwarded-Encrypted: i=1; AJvYcCWp02saBdXsfs6WGeW2OGx8I0elj41wdi3S6m1WAk3ApcefFVyDW6gFnqNi8AIjoKY2RJpk5DmPKPT4XN9xEBdYVule3FHP6ByoZduYF1BCbIdKKUaEYvrD/qAkDzi0UpnRPrlhXZk8ZpG3BfDeKq5jEd8u/a8xJmvWebA/ge1ZCjNH
X-Gm-Message-State: AOJu0YxZgd5X4GTYoWeV3lPa5sDpOUGdTDqXNKRyD/vyTXZLsM2BMg7B
	P+3wQPPigaTeAbhjwvup4I8rJnjn3M7cQKRnaLlJGkmfzacjbhkq
X-Google-Smtp-Source: AGHT+IFcO8MiaoD6Cte2ItgLhV+w9LAMsoeBHZyEn5ZrO/x7ZBnibRjWEqOEGIuYMtJYCpOsxEMCFg==
X-Received: by 2002:a17:906:28d1:b0:a3e:c77a:8100 with SMTP id p17-20020a17090628d100b00a3ec77a8100mr4485554ejd.17.1708449513035;
        Tue, 20 Feb 2024 09:18:33 -0800 (PST)
Received: from krava ([83.240.60.70])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906c18100b00a3e278c4a3fsm3668349ejz.53.2024.02.20.09.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:18:32 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 20 Feb 2024 18:18:30 +0100
To: Menglong Dong <dongmenglong.8@bytedance.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	mykolal@fb.com, shuah@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, thinker.li@gmail.com,
	zhoufeng.zf@bytedance.com, davemarchevsky@fb.com, dxu@dxuuu.xyz,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH bpf-next 2/5] bpf: tracing: support to attach program to
 multi hooks
Message-ID: <ZdTe5pyV16y4wYzv@krava>
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
 <20240220035105.34626-3-dongmenglong.8@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220035105.34626-3-dongmenglong.8@bytedance.com>

On Tue, Feb 20, 2024 at 11:51:02AM +0800, Menglong Dong wrote:

SNIP

> @@ -3228,7 +3260,9 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  	struct bpf_link_primer link_primer;
>  	struct bpf_prog *tgt_prog = NULL;
>  	struct bpf_trampoline *tr = NULL;
> +	struct btf *attach_btf = NULL;
>  	struct bpf_tracing_link *link;
> +	struct module *mod = NULL;
>  	u64 key = 0;
>  	int err;
>  
> @@ -3258,31 +3292,50 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  		goto out_put_prog;
>  	}
>  
> -	if (!!tgt_prog_fd != !!btf_id) {
> -		err = -EINVAL;
> -		goto out_put_prog;
> -	}
> -
>  	if (tgt_prog_fd) {
> -		/*
> -		 * For now we only allow new targets for BPF_PROG_TYPE_EXT. If this
> -		 * part would be changed to implement the same for
> -		 * BPF_PROG_TYPE_TRACING, do not forget to update the way how
> -		 * attach_tracing_prog flag is set.
> -		 */
> -		if (prog->type != BPF_PROG_TYPE_EXT) {
> +		if (!btf_id) {
>  			err = -EINVAL;
>  			goto out_put_prog;
>  		}
> -
>  		tgt_prog = bpf_prog_get(tgt_prog_fd);
>  		if (IS_ERR(tgt_prog)) {
> -			err = PTR_ERR(tgt_prog);
>  			tgt_prog = NULL;
> -			goto out_put_prog;
> +			/* tgt_prog_fd is the fd of the kernel module BTF */
> +			attach_btf = btf_get_by_fd(tgt_prog_fd);

I think we should pass the btf_fd through attr, like add
link_create.tracing_btf_fd instead, this seems confusing

> +			if (IS_ERR(attach_btf)) {
> +				attach_btf = NULL;
> +				err = -EINVAL;
> +				goto out_put_prog;
> +			}
> +			if (!btf_is_kernel(attach_btf)) {
> +				btf_put(attach_btf);
> +				err = -EOPNOTSUPP;
> +				goto out_put_prog;
> +			}
> +		} else if (prog->type == BPF_PROG_TYPE_TRACING &&
> +			   tgt_prog->type == BPF_PROG_TYPE_TRACING) {
> +			prog->aux->attach_tracing_prog = true;
>  		}

could you please add comment on why this check is in here?

> -
> -		key = bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
> +		key = bpf_trampoline_compute_key(tgt_prog, attach_btf,
> +						 btf_id);
> +	} else if (btf_id) {
> +		attach_btf = bpf_get_btf_vmlinux();
> +		if (IS_ERR(attach_btf)) {
> +			attach_btf = NULL;
> +			err = PTR_ERR(attach_btf);
> +			goto out_unlock;
> +		}
> +		if (!attach_btf) {
> +			err = -EINVAL;
> +			goto out_unlock;
> +		}
> +		btf_get(attach_btf);
> +		key = bpf_trampoline_compute_key(NULL, attach_btf, btf_id);
> +	} else {
> +		attach_btf = prog->aux->attach_btf;
> +		/* get the reference of the btf for bpf link */
> +		if (attach_btf)
> +			btf_get(attach_btf);
>  	}
>  
>  	link = kzalloc(sizeof(*link), GFP_USER);
> @@ -3319,7 +3372,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  	 *   are NULL, then program was already attached and user did not provide
>  	 *   tgt_prog_fd so we have no way to find out or create trampoline
>  	 */
> -	if (!prog->aux->dst_trampoline && !tgt_prog) {
> +	if (!prog->aux->dst_trampoline && !tgt_prog && !btf_id) {
>  		/*
>  		 * Allow re-attach for TRACING and LSM programs. If it's
>  		 * currently linked, bpf_trampoline_link_prog will fail.
> @@ -3346,17 +3399,27 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  		 * different from the destination specified at load time, we
>  		 * need a new trampoline and a check for compatibility
>  		 */
> +		struct btf *origin_btf = prog->aux->attach_btf;
>  		struct bpf_attach_target_info tgt_info = {};
>  
> +		/* use the new attach_btf to check the target */
> +		prog->aux->attach_btf = attach_btf;
>  		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
>  					      &tgt_info);
> +		prog->aux->attach_btf = origin_btf;

could we pass the attach_btf as argument then?

jirka

>  		if (err)
>  			goto out_unlock;
>  
> -		if (tgt_info.tgt_mod) {
> -			module_put(prog->aux->mod);
> -			prog->aux->mod = tgt_info.tgt_mod;
> -		}
> +		mod = tgt_info.tgt_mod;
> +		/* the new target and the previous target are in the same
> +		 * module, release the reference once.
> +		 */
> +		if (mod && mod == prog->aux->mod)
> +			module_put(mod);
> +		err = bpf_tracing_check_multi(prog, tgt_prog, attach_btf,
> +					      tgt_info.tgt_type);
> +		if (err)
> +			goto out_unlock;
>  
>  		tr = bpf_trampoline_get(key, &tgt_info);
>  		if (!tr) {
> @@ -3373,6 +3436,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  		 */
>  		tr = prog->aux->dst_trampoline;
>  		tgt_prog = prog->aux->dst_prog;
> +		mod = prog->aux->mod;
>  	}
>  
>  	err = bpf_link_prime(&link->link.link, &link_primer);
> @@ -3388,6 +3452,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  
>  	link->tgt_prog = tgt_prog;
>  	link->trampoline = tr;
> +	link->attach_btf = attach_btf;
> +	link->mod = mod;
>  
>  	/* Always clear the trampoline and target prog from prog->aux to make
>  	 * sure the original attach destination is not kept alive after a
> @@ -3400,20 +3466,27 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  	if (prog->aux->dst_trampoline && tr != prog->aux->dst_trampoline)
>  		/* we allocated a new trampoline, so free the old one */
>  		bpf_trampoline_put(prog->aux->dst_trampoline);
> +	if (prog->aux->mod && mod != prog->aux->mod)
> +		/* the mod in prog is not used anywhere, move it to link */
> +		module_put(prog->aux->mod);
>  
>  	prog->aux->dst_prog = NULL;
>  	prog->aux->dst_trampoline = NULL;
> +	prog->aux->mod = NULL;
>  	mutex_unlock(&prog->aux->dst_mutex);
>  
>  	return bpf_link_settle(&link_primer);
>  out_unlock:
>  	if (tr && tr != prog->aux->dst_trampoline)
>  		bpf_trampoline_put(tr);
> +	if (mod && mod != prog->aux->mod)
> +		module_put(mod);
>  	mutex_unlock(&prog->aux->dst_mutex);
>  	kfree(link);
>  out_put_prog:
>  	if (tgt_prog_fd && tgt_prog)
>  		bpf_prog_put(tgt_prog);
> +	btf_put(attach_btf);
>  	return err;
>  }
>  
> -- 
> 2.39.2
> 

