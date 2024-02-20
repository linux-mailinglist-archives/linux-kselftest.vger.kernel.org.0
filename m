Return-Path: <linux-kselftest+bounces-5048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37EA85C25F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 18:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3BA5B21C8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 17:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3B277643;
	Tue, 20 Feb 2024 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfS+TvPW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5676C74;
	Tue, 20 Feb 2024 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449526; cv=none; b=VB0lFvML8LxjVQ6GwinjKalcX8Cs6c0vT5yHW7zQQP5UjHip2B7ZNdw1Pt6FkNyDYzbiLFwNwVGkhVyUdyNXSJP4Za4Ml4r6svpB4zYxkq+UxVfmeGoybQYL7h1gCW2fTzEcg5qFGbKMdxG4TIGClX59F7HrONtRm9UVPlyVeFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449526; c=relaxed/simple;
	bh=oAmeEfyjXLv4RIi34kUBYqESf31shoVCzi2Fy9DSnI4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCreF22M9Dn/Y6IobZ0O2ME27VTjgfIC3YWcZntZXmZq8v+jxmA6hYhcUof+ykfWZGPWHYcoeXKBrUGYr3T6PE0HCeNSmvZ+IWJyJA+eihdytrrO9OUmprHA6Fyjy8rvgPFxQo5CAKX6yrT7xMixiQGkLw3zei3KgTmd9AuW+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfS+TvPW; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so5187232a12.0;
        Tue, 20 Feb 2024 09:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708449523; x=1709054323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2jsimXL4CWxMWFytJ0GOuQvmJcBH3su7G6flKHH6vaI=;
        b=jfS+TvPWBy3pdZtVyDITo+zcyrHS6v33pfXYDJYx75YloyvjB4a3Jjg9QAKjgwqCpS
         n1OI6oHneNmzEti6tNxlUuczg5gxoQYMuCfALN9cq//r8k8sNetGVyaKTEvVDoZQctQw
         QBUBzpn4y5nCGG3b34bd9vyONdVH+Xmg8ILgnt7E9vGD2mHToS9yGgWgulwhJ2OUJLl5
         X0BrR1hrj1d+FvxW8e3GEPmp5AE+ef3q7t49G14Jmv71ha+TZlSizdg7F2ramz/PZkVw
         /7t8aFaISl7iO1J1Ton95YtFE0ThAUkW08F+/ogigA3NZj2Zstd+asyRvysOZ5ywHxvU
         bo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708449523; x=1709054323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jsimXL4CWxMWFytJ0GOuQvmJcBH3su7G6flKHH6vaI=;
        b=aJHS9XNXWOHSun9wT8zipPdwntoCriV7AN/mw7kilfsf+B+VB4QsKg/9CI+M9OWlHU
         7LaugUFjzNyRd9BohOUGp28JupMpmuKo9Bu9WKiUri7lQMLbsYXU5otZTKUzuoWlPpgQ
         H8l6geIW96IXKBAnXyPh3wBdzxwvz7907q0mMKQwqitEDd8JtSCcyKC9qo7pbhJD6PP5
         zJdZO9NYlggxbshfYVC2sxK4su14en7SVewIV5vCaY7xQODul2CT2h1yWPgeXNPR/mm1
         OdqRpjdw9LxaqLZd6kqJei7MYkpDG+m579TnzCO+/918fb7ECNl/npFwigpNkrMaaItJ
         XIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVElQFiQqZHZIjUIW3wlxbDMrj1czJzjXQApybWV9Q6BwcskBj84VbCHTMYoNHTxzsrVWid5M/rZDQpLQQ3IwuQS73AKCtTOKq3l8jX71+waE+vewvOypikVIenes+1AkbJVlo4tfhqvilngqSJOUyJCBdijmvStJh4Gv1z+zGq/n8H
X-Gm-Message-State: AOJu0YxIQNg3xWeG8K6jRj28/IziOZ0ctJss2740TC1CjoToQQj7lnh1
	jJdfffuZ+jMYzG+WrmNjQHsNesitg1VMjQGvu3y39bTMwzRNb1Wv
X-Google-Smtp-Source: AGHT+IHc0pN9KHkKeb7luanourVgNNVzQPzVIAPQ4poYAK/bHeBaBBTbjvPtzX2mIiyI/iKaLuo4xQ==
X-Received: by 2002:aa7:db49:0:b0:564:a76b:aa55 with SMTP id n9-20020aa7db49000000b00564a76baa55mr2426459edt.12.1708449523138;
        Tue, 20 Feb 2024 09:18:43 -0800 (PST)
Received: from krava ([83.240.60.70])
        by smtp.gmail.com with ESMTPSA id ew14-20020a056402538e00b005602346c3f5sm3823732edb.79.2024.02.20.09.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:18:42 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 20 Feb 2024 18:18:40 +0100
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
Subject: Re: [PATCH bpf-next 1/5] bpf: tracing: add support to record and
 check the accessed args
Message-ID: <ZdTe8LteoqR43d4q@krava>
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
 <20240220035105.34626-2-dongmenglong.8@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220035105.34626-2-dongmenglong.8@bytedance.com>

On Tue, Feb 20, 2024 at 11:51:01AM +0800, Menglong Dong wrote:

SNIP

> +static int get_ctx_arg_idx_aligned(struct btf *btf, const struct btf_type *t,
> +				   int off)
> +{
> +	const struct btf_param *args;
> +	u32 offset = 0, nr_args;
> +	int i;
> +
> +	nr_args = btf_type_vlen(t);
> +	args = (const struct btf_param *)(t + 1);
> +	for (i = 0; i < nr_args; i++) {
> +		if (offset == off)
> +			return i;
> +
> +		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
> +		offset += btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
> +		if (offset > off)
> +			return -1;
> +	}
> +	return -1;
> +}
> +
> +/* This function is similar to btf_check_func_type_match(), except that it
> + * only compare some function args of the function prototype t1 and t2.
> + */

could we reuse btf_check_func_type_match instead? perhaps just
adding extra argument with arguments bitmap to it?

jirka

> +int btf_check_func_part_match(struct btf *btf1, const struct btf_type *func1,
> +			      struct btf *btf2, const struct btf_type *func2,
> +			      u64 func_args)
> +{
> +	const struct btf_param *args1, *args2;
> +	u32 nargs1, i, offset = 0;
> +	const char *s1, *s2;
> +
> +	if (!btf_type_is_func_proto(func1) || !btf_type_is_func_proto(func2))
> +		return -EINVAL;
> +
> +	args1 = (const struct btf_param *)(func1 + 1);
> +	args2 = (const struct btf_param *)(func2 + 1);
> +	nargs1 = btf_type_vlen(func1);
> +
> +	for (i = 0; i <= nargs1; i++) {
> +		const struct btf_type *t1, *t2;
> +
> +		if (!(func_args & (1 << i)))
> +			goto next;
> +
> +		if (i < nargs1) {
> +			int t2_index;
> +
> +			/* get the index of the arg corresponding to args1[i]
> +			 * by the offset.
> +			 */
> +			t2_index = get_ctx_arg_idx_aligned(btf2, func2,
> +							   offset);
> +			if (t2_index < 0)
> +				return -EINVAL;
> +
> +			t1 = btf_type_skip_modifiers(btf1, args1[i].type, NULL);
> +			t2 = btf_type_skip_modifiers(btf2, args2[t2_index].type,
> +						     NULL);
> +		} else {
> +			/* i == nargs1, this is the index of return value of t1 */
> +			if (get_ctx_arg_total_size(btf1, func1) !=
> +			    get_ctx_arg_total_size(btf2, func2))
> +				return -EINVAL;
> +
> +			/* check the return type of t1 and t2 */
> +			t1 = btf_type_skip_modifiers(btf1, func1->type, NULL);
> +			t2 = btf_type_skip_modifiers(btf2, func2->type, NULL);
> +		}
> +
> +		if (t1->info != t2->info ||
> +		    (btf_type_has_size(t1) && t1->size != t2->size))
> +			return -EINVAL;
> +		if (btf_type_is_int(t1) || btf_is_any_enum(t1))
> +			goto next;
> +
> +		if (btf_type_is_struct(t1))
> +			goto on_struct;
> +
> +		if (!btf_type_is_ptr(t1))
> +			return -EINVAL;
> +
> +		t1 = btf_type_skip_modifiers(btf1, t1->type, NULL);
> +		t2 = btf_type_skip_modifiers(btf2, t2->type, NULL);
> +		if (!btf_type_is_struct(t1) || !btf_type_is_struct(t2))
> +			return -EINVAL;
> +
> +on_struct:
> +		s1 = btf_name_by_offset(btf1, t1->name_off);
> +		s2 = btf_name_by_offset(btf2, t2->name_off);
> +		if (strcmp(s1, s2))
> +			return -EINVAL;
> +next:
> +		if (i < nargs1) {
> +			t1 = btf_type_skip_modifiers(btf1, args1[i].type, NULL);
> +			offset += btf_type_is_ptr(t1) ? 8 : roundup(t1->size, 8);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf_type *t)
>  {
>  	const char *name;
> -- 
> 2.39.2
> 

