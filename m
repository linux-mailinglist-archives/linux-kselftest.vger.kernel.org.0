Return-Path: <linux-kselftest+bounces-23294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634539F0358
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 05:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196F528443A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 04:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC5916EB76;
	Fri, 13 Dec 2024 04:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUAtMkvC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0BF8F5E;
	Fri, 13 Dec 2024 04:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062676; cv=none; b=obazx7c3SWKf6MB+4lX+fkx4cKEJH0srnLdvTZkKwq277dbzKjkpV0xYaIjj+l7phS5vvetMwFvsLVhxQM+Prruv8qKceRm4DH/Kem/YKVkPMQtbK4zDAuwgITvbtYWT5wnxHvISHuqhv/Y/SZ4nq5k8qB0PD5BUozZNT6LX8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062676; c=relaxed/simple;
	bh=Lr7LQGbvd4wuev1AjaD6YqWh9lB5cJFr9owEedqmdvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pG74dgcDJcM21f5djVtC75U6QqzW/PtIU9M6KkQm2uwCGM5/mglPdR8+ktJvOIn+YXpWOqNp3WUsgwyzhwAH6QPHJq7ER+WDi3KqgbmPMFCln+Au+Vxb0T4+hbNYkq4ia59tmRX5bI42E7HUtB9f8AxMM/PQTPA2qfI1HhbSA/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUAtMkvC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2164b1f05caso12944815ad.3;
        Thu, 12 Dec 2024 20:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734062674; x=1734667474; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xzcHtM4625I5D50j6uu6xeVIa1jpXt6gHxEIvpDf7CI=;
        b=hUAtMkvCJaTScZmleW3Qop7gGh9KVAMMp/vncTcEKMGnOjhmzFbcVEUO/AvKVpMBkj
         DmIXw5uoQwoywIrMb1CSPiYvWid3RUbd6w8xzoBRBhSO2TyAJ5ILFOCZrCD9dyhw+pBg
         nKoldl75Ksc/PwrVcodpte1Pf6qHcfykNiAhuNe86jwHqEhAMcG08D+MAckL7m9cy2Nx
         Mvx7JfTnuEaz1rgczJph/cKsSoOpw+d1JTJyXxXd+1sWfeTrkoh9hSP04Ot1pOyMGLzC
         DJrRkgFtSAJTgpMqDqPd2fj/jvO+rJeZmRe37KzcHo2/o/suwUW9uPZKLHWWV4cW9Y5J
         EdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734062674; x=1734667474;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xzcHtM4625I5D50j6uu6xeVIa1jpXt6gHxEIvpDf7CI=;
        b=CsFYQlWJ+gohcwA7PCK+9iorG3dnof0MvXYPktuJ3ti9fqiBiHrJODPEB/q8OYR0DT
         /414Ps7Forc2qhITLdkkcwhCml08AeCHYl3B9RgH3F/U8RCDeYn/Amz6bGbMxXtZwazc
         LHgDamAeTegobuqxh2vvC8s2rHOjvIQ4l4YaMGTGbNXb5WhdPk0PzlM5cY6MUOjHLsgW
         G5uhaF/rYzuj6xoA/F4qQNIGbt9bpG1sjdkO7DpmcsdeQGqL2GdPwPhvkNZ2SAuwibv+
         OnKnyK5bu3DFiCq6N1tXnZzOPtnfCtk6gKzk50XexGZz0fTfXIQZU6qKu4/B//bqTHzW
         YH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUR5QFU38Ytpqwshtla/p9q3Yhf+uRJc+FJPiECZuY6LAJCLIn50yTvc8FsI1TyvElG2Z+8hw7i1O6yW+7W@vger.kernel.org, AJvYcCUVs+OpEKpOwJeZZWjwBqmeTtzrV74VDclx71XKk+zG4mrb2tNdhYR4aWt0yOTrjyGA++ryuFVZvgsFtw/XVcPJ@vger.kernel.org, AJvYcCVL7vnv1/AqAQkeE5ckgTrl6KSfGoswilzx7IJ17IUgctu+lsyXqNIPR84tTC6VwVP/ogg=@vger.kernel.org, AJvYcCXC2zrFtXxDZA6ji21BTcSQLVKWEf96cNpvrAq3p9wMEchvCZ/f+uWjXD18H5VgfWGkMOLVxOny@vger.kernel.org
X-Gm-Message-State: AOJu0YxLeOdwDEF9yDgCsf2egiZYgu/pBDpeCsPPB2Gm0xad3p2OCS3c
	WCUJEqmL1ha95DxWq7N5MUZtaF7/u4KLG9n449pxkkaMape7yUSq
X-Gm-Gg: ASbGnctbfrPj0E5UT+Ztjq0V7HRRnbsf8zTtMdgOq/2joRUPQ2QN2izSfZvgZx9JxrC
	oOVtg52NiybunKa++F3S83aj5CXmUmu7nIX52CiceTUFhfMQtuGCZUcTk7lt/hgqJrl6kh6fxdO
	d9hoBUBh14KvDEF9oGfQNkNod8LYY6+Jo6CwUP3zc/SJQA8y5paPYWJcUV8dOrHItZziWps/MYs
	9kynwWnVoOnothwl6J23ZYZJ6+f+2TYx1io7aC2gPUN1w5fYxBtKg==
X-Google-Smtp-Source: AGHT+IEiczGJ5x34lhN8LhMymQTWLT/xwZGklt3tM0ClHmnnfxPojX+b+1esUx6LZ67ZkomNi1c18g==
X-Received: by 2002:a17:902:e886:b0:216:59ed:1aa3 with SMTP id d9443c01a7336-218929d8431mr15903305ad.27.1734062674130;
        Thu, 12 Dec 2024 20:04:34 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21654150cc2sm74300745ad.68.2024.12.12.20.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 20:04:33 -0800 (PST)
Message-ID: <341df2d52af6c1584353b89a8a65d9d0fb5f0f27.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 3/5] bpf: verifier: Refactor helper access
 type tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, andrii@kernel.org, ast@kernel.org, 
	shuah@kernel.org, daniel@iogearbox.net
Cc: john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, 	jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Date: Thu, 12 Dec 2024 20:04:28 -0800
In-Reply-To: <4727abf12fbc53723359d4edcdf5b6dd7d33f9cb.1734045451.git.dxu@dxuuu.xyz>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
		 <4727abf12fbc53723359d4edcdf5b6dd7d33f9cb.1734045451.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-12 at 16:22 -0700, Daniel Xu wrote:
> Previously, the verifier was treating all PTR_TO_STACK registers passed
> to a helper call as potentially written to by the helper. However, all
> calls to check_stack_range_initialized() already have precise access type
> information available.
>=20
> Rather than treat ACCESS_HELPER as a proxy for BPF_WRITE, pass
> enum bpf_access_type to check_stack_range_initialized() to more
> precisely track helper arguments.
>=20
> One benefit from this precision is that registers tracked as valid
> spills and passed as a read-only helper argument remain tracked after
> the call.  Rather than being marked STACK_MISC afterwards.
>=20
> An additional benefit is the verifier logs are also more precise. For
> this particular error, users will enjoy a slightly clearer message. See
> included selftest updates for examples.
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

I think this change is ok.
With it there is only one use of 'enum bpf_access_src' remains,
but it doesn't look like it could be removed.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> --- a/tools/testing/selftests/bpf/progs/uninit_stack.c
> +++ b/tools/testing/selftests/bpf/progs/uninit_stack.c
> @@ -55,33 +55,4 @@ exit_%=3D:	r0 =3D 0;					\
>  		      : __clobber_all);
>  }
> =20
> -static __noinline void dummy(void) {}
> -
> -/* Pass a pointer to uninitialized stack memory to a helper.
> - * Passed memory block should be marked as STACK_MISC after helper call.
> - */
> -SEC("socket")
> -__log_level(7) __msg("fp-104=3Dmmmmmmmm")
> -__naked int helper_uninit_to_misc(void *ctx)

Is it possible to peek a helper that writes into memory and not delete
this test?

> -{
> -	asm volatile ("					\
> -		/* force stack depth to be 128 */	\
> -		*(u64*)(r10 - 128) =3D r1;		\
> -		r1 =3D r10;				\
> -		r1 +=3D -128;				\
> -		r2 =3D 32;				\
> -		call %[bpf_trace_printk];		\
> -		/* Call to dummy() forces print_verifier_state(..., true),	\
> -		 * thus showing the stack state, matched by __msg().		\
> -		 */					\
> -		call %[dummy];				\
> -		r0 =3D 0;					\
> -		exit;					\
> -"
> -		      :
> -		      : __imm(bpf_trace_printk),
> -			__imm(dummy)
> -		      : __clobber_all);
> -}
> -

[...]


