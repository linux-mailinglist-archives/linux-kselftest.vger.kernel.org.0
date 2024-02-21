Return-Path: <linux-kselftest+bounces-5124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C6885CE72
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 03:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB2B1F2319D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 02:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C00F2B9D6;
	Wed, 21 Feb 2024 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwNL6Y+8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C012837E;
	Wed, 21 Feb 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484349; cv=none; b=csqehXsatSuD0j2F3LVg2lYeHEqEApyrtOzTBR7ww+7yFezT837+HJ/JbMvzXXFq64UMhCVHfLLI5MXWWmPSn883qbrm3BonKbe05NW4+iWT5blv6fmpGa+xieNhzBFCwQpPr81q65/v5AsmXqzehfqw28gEow+YkGcW0PKbB1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484349; c=relaxed/simple;
	bh=ki7oZqPLTBBU4e9QixFjvu/JrFVfmPfGr4kBpBiuZ54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cE1uA2XgQhG14HJF/JTVK/VRFavCWFztbi4Vl4IG/fHu3F6nO1Ds9k9U5yFaMyG9Lle5JofLdcIGuXhqk3wGyz7xiKfznZRAtozsNJ+dffSxMzHI6U2OcqDmSdtCEETnOmEsq3ToKC0OiuH0ucIritRuoMLvjw8uJC4JpJbu1Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwNL6Y+8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2997a9f4d61so2305000a91.3;
        Tue, 20 Feb 2024 18:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484347; x=1709089147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rKRR1jeoUaWk2hMXPXX2OybDUOW0Xq12PBDdL5AGBKI=;
        b=bwNL6Y+8qjOyLB+DqaMtGAIpKquvsbtfWnghCa6NymM2uah81RKAr/8xuC4parLLPc
         Cm8YPHq1zyuh7+ZJroPhh6el0CLRKP4NUiQKzzBlZ7JpIpX1PfAZ3Xyd1IUjSoBhquzV
         UfybgqXVpHuXoaNS1t/vRo7vpqsZlTun8xBRgTLY01/AJwN/HEdrJemxQIa2hOMZlncf
         6VXU90H+nFnn6ofjpTCO0J44t0Mdy/W6MJ3qehbVlZyVa0rCIQ1rG39wKD0IiPSV767+
         Fn3Y/4MTLWYf3N9DYj816Al3JsEm3wBXW71kXD5L8Z8Y0RdILHggboYnAWHRaGrbRKXZ
         kw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484347; x=1709089147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKRR1jeoUaWk2hMXPXX2OybDUOW0Xq12PBDdL5AGBKI=;
        b=CLuYWYOsie0mHLVToPocc2T7wmviNWS+cTluQ5Iy2Iie5IeqTmMl8o+ktMlEu/NBQ/
         5bnHwnFHYl4VTF4jOvOSwm8bHF57zkiG5HC6fMxhgo7zHfvmLKVCKfEPj0FuX9Ty5Szg
         Eastous87nAwD5rZfgKyrtVBOeRTJJQzPu5VIlaKMxumxW6IOdxMYElcU3drUkCqKzob
         KAyNJm9CRaa75ggJL+wKJ+WZAFvsCOmT2HlWlLfFhH4jrZkuISlMwdT15PA2VGwtCzia
         F6vJSyGKUPEx0Owil2JzwZzHtG41h6yvXKwL53qh+srJgW1k7ODnc/yvNcfxPllp7I57
         oZvg==
X-Forwarded-Encrypted: i=1; AJvYcCU4JazQ+Z2Xy1tyQUI3qAtv9+/QJcktpGCOu51WQ3Vi1bp1MGJq1nLCCYrX8xs3iCnFW0xOrHCdyEwIcGkI9T/kALbpq0oghigAFX/ETh1I5Lg+gmmrOSg9MF37kjGqcfn3KFYi3xiiusp6N2CXLKVSbjPQjiBZ+4j+ADnnfRPlFoyvTAY3aF0zuKKdCTeMK14JNaJlTcHw8TBZczFvY1WWa+iqmmzrt2RIh72x9Ilc8wii6aQ3/nH+08o=
X-Gm-Message-State: AOJu0Yz4kvYOSfo9U3ptbqclifaoWFE5Ry+VGxlULmKc2S3M1Xmb5f+D
	C8IxxiY0rWnDi8toi4n8lBSa/Q+f0Up36KsZBiKBcbpMlx/g620i
X-Google-Smtp-Source: AGHT+IE2gQvSK+KiBH2dx0Jzo04yUo8mrIkZhKNv7p0hXChfvZRY6ZjsADui/Js2Q+b5v2KsXmCBVg==
X-Received: by 2002:a17:90b:4a0c:b0:299:3334:51d1 with SMTP id kk12-20020a17090b4a0c00b00299333451d1mr11593925pjb.10.1708484346801;
        Tue, 20 Feb 2024 18:59:06 -0800 (PST)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:b11c])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902f0cb00b001d937bc5602sm6946664pla.227.2024.02.20.18.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 18:59:06 -0800 (PST)
Date: Tue, 20 Feb 2024 18:59:03 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 02/10] bpf/helpers: introduce sleepable
 timers
Message-ID: <i2womwfk2bvxh3h7ubmj2p4aqywci36hcfufuqflcusg73ilsq@chpndguq7bgu>
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
 <20240214-hid-bpf-sleepable-v2-2-5756b054724d@kernel.org>
 <mth43jfjhwtatwfo3unefrze62opht3yklleblslyz2adc6p5p@wm3miaqhhtkt>
 <rhdu4st5tfabsdqs27ewhvdlwblhj2re4o56iz3fq3bsuokxxe@gtuqdjffj2hn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rhdu4st5tfabsdqs27ewhvdlwblhj2re4o56iz3fq3bsuokxxe@gtuqdjffj2hn>

On Fri, Feb 16, 2024 at 10:50:10AM +0100, Benjamin Tissoires wrote:
>  static bool is_rbtree_lock_required_kfunc(u32 btf_id)
>  {
>  	return is_bpf_rbtree_api_kfunc(btf_id);
> @@ -12140,6 +12143,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		}
>  	}
>  
> +	if (is_bpf_timer_set_sleepable_cb_kfunc(meta.func_id)) {
> +		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
> +					 set_timer_callback_state);
> +		if (err) {
> +			verbose(env, "kfunc %s#%d failed callback verification\n",
> +				func_name, meta.func_id);
> +			return err;
> +		}
> +	}

All makes sense so far.
Please squash all the fix and repost.
It's hard to do a proper review in this shape of the patch.
As far as rcu_read_lock/unlock that is done in callback...
it feels buggy and unnecessary.
bpf prog and timer won't disappear while work is queued.
array and hash map will call bpf_obj_free_timer() before going away.

And things like:
+       rcu_read_lock();
+       callback_fn = rcu_dereference(t->sleepable_cb_fn);
+       rcu_read_unlock();
+       if (!callback_fn)
+               return;

is 99% broken. if (!callback_fn) line is UAF.

