Return-Path: <linux-kselftest+bounces-29111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FA4A620C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 23:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F64519C0792
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58571E98F2;
	Fri, 14 Mar 2025 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WG20yWjb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309EA1922DE;
	Fri, 14 Mar 2025 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741992428; cv=none; b=EVuC5EZEJd1724OJGl6yvUUPheYHq9UjG1kAl9KGLxibwdK9L0HdTLqUIfhXdn1VxjqUgfmdZc3euWRQJfRYpIJ7cb2iLUjmEe6r+taLFacCS50e3xGtt3CLldTCUcvfTTvVAmXm5fMTs9raYIt36W1g4Vq0E6mZxzoOloA4V1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741992428; c=relaxed/simple;
	bh=Hk1rEIe9IsOXSaCzKOhfu7iBhtKI3LYOq/oFVgld87g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pmm570S5EYUvLyWnBdow+yxaqOYyRiQ7B63GEe+IE5b+PNKser1Hk1hc06qJYeZs7SNU6sy1og158ee7rw9iiMKp552v2dIW3WetlY274Rz7VIjlvLxG6Ywj0qATPMF3WkqFG+OC/p7dEu4IIXAUPV4e5a2TZ2FHENPwUOoxlPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WG20yWjb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22403cbb47fso48805305ad.0;
        Fri, 14 Mar 2025 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741992426; x=1742597226; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0zZoEhi64Kn/eQi3WO9JY1pGevNfO0NZbYey6p1uGuc=;
        b=WG20yWjbive7XJxidfRhUse/MsKeBOaf0Pk4bRXSI4dcuVzc3Iu3sMBGelbsJLr7lJ
         BLc9YrC6lT5COExNsqOe3a6XtebwSzP6nAgJGR1afP6kJNBbxR7lTbIp1RedKmjFqiWS
         l82EnqxmOzliOrUiHmSefbx4hP2Gwy7fggkf1cyx1l/Zz9cxSwtffxW7CqS+4Es+/oyn
         MKkXwrb//bfUE1uq1GePkmTRvO+z0akIcshOb5eKa8PO9wMh/a0QZyFNlsRnOYlrH32X
         39d/rWeqViTe080zFiXYfQBfg/j6awpTUQJisOBd7ffyPhCxY84AR87Gno/Qemmu1+S9
         bKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741992426; x=1742597226;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0zZoEhi64Kn/eQi3WO9JY1pGevNfO0NZbYey6p1uGuc=;
        b=d2ZI7bxQNjbYnnTZXz/L/fTIdtsZrex/K0zbMYx8H6f/ixhC996vu2bgNsb0khnDyc
         egtkUFjUnALLdpNd/gAsquMZvWUrGtgz+3y8dWdsuP4jW5ckZdrLnQ2r7GSKvwokH8Ry
         20hn9iIU+rqzS76LwkGtnBdtVMTq/7k9EeqrwBZWDGzk1J0H0y1llmwOp2q9IWcI3tlU
         gH/IU1N9HBjBm8/izccFWSvyV17/iLAbowJUjpR+VCvb1OzrIey9bIXipIS3BsUtudxa
         aIcvftgQUygMSX+YsZ72WGwZM+6mxY7RyKzOMDfr8pV57d/xP34kQ5UmIo/5BM/Y8W/v
         cnGg==
X-Forwarded-Encrypted: i=1; AJvYcCUmAvYs9jXGBsTc4Sd2+cwDVcuk6//hBzmkITcqNhdhh4STJF3Sf29qdfENrFuQp+jBCKE=@vger.kernel.org, AJvYcCW/jwE/ZAo2JExcs1pLSjSOmKKPuCosOwO/q8xOCBe4x6+bjuG5MU+ERnk8GElqw3+0Bht7eCJ0k7dxFWenXENi@vger.kernel.org, AJvYcCWEtQ0T7i53/XNcJY3UkTYKFbNCi3WafU1lLyy2NT2tSZclo8/z/p9VQC8r8JWkHlD+RLtAArUJrpTkKkKN@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBvxbZ0YSpRQkg3jQU+Q2sWszFv3jU8TLgOnuxlALS/9rRdP4
	UIZOlgQQ9P+piRalQstnyh3YxEBHJme0mEAFixhMDqDFzrIUN98Y
X-Gm-Gg: ASbGncuNOeW8klaUsM7usd4g8KCFq0qob7Uxi5W/Io0KXnbfw6FZLABBo/ceuYaMURO
	DDYZqEVieAMIhR5DpSxintAdha/ueXEZPEhFekIKEoS1M6EiZPoUqebkDqReobPvXX2E54whBb8
	+3jWXH3a+/7o3flRLX9xlCYjZpBKCA0Bn985QLgFdD1l37hDI3TCyKuMudPyQhYI4auyD/5/oXE
	uE27KbGW1EOZ1PElN4Jng/dz0cN/0i/BX9TCVqMAfupE140Po4s3nwvw4+toqoE+wNQXBBlD0gm
	G+WgyFGuA2PVwQ8agjsrba2pHl4nd7ynO2NjMX4n
X-Google-Smtp-Source: AGHT+IE5BsFikv0Zy/M5K5/YooQ0IZXHiKgPfdHvD36gcvkA4VKCXVrThbSUpc5Gp513eGAfeESaMA==
X-Received: by 2002:a05:6a00:92a3:b0:736:4abf:2961 with SMTP id d2e1a72fcca58-737223e8ef3mr4206808b3a.17.1741992426214;
        Fri, 14 Mar 2025 15:47:06 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115511cfsm3390784b3a.45.2025.03.14.15.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 15:47:05 -0700 (PDT)
Message-ID: <293dbe3950a782b8eb3b87b71d7a967e120191fd.camel@gmail.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Move insn if/else into
 do_check_insn()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai
 <xukuohai@huaweicloud.com>, Catalin Marinas	 <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Hari Bathini	 <hbathini@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,  Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman	 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Mykola
 Lysenko	 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Henriette Herzog	
 <henriette.herzog@rub.de>, Cupertino Miranda
 <cupertino.miranda@oracle.com>,  Matan Shachnai <m.shachnai@gmail.com>,
 Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, Shung-Hsi Yu	
 <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, George Guo	
 <guodongtai@kylinos.cn>, WANG Xuerui <git@xen0n.name>, Tiezhu Yang	
 <yangtiezhu@loongson.cn>
Cc: Maximilian Ott <ott@cs.fau.de>, Milan Stephan <milan.stephan@fau.de>
Date: Fri, 14 Mar 2025 15:47:00 -0700
In-Reply-To: <20250313172127.1098195-2-luis.gerhorst@fau.de>
References: <20250313172127.1098195-1-luis.gerhorst@fau.de>
	 <20250313172127.1098195-2-luis.gerhorst@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-13 at 18:21 +0100, Luis Gerhorst wrote:
> This is required to catch the errors later and fall back to a nospec if
> on a speculative path.
>=20
> Move code into do_check_insn(), replace
> * "continue" with "return INSN_IDX_MODIFIED"
> * "goto process_bpf_exit" with "return PROCESS_BPF_EXIT"
> * "do_print_state =3D " with "*do_print_state =3D "
>=20
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Acked-by: Henriette Herzog <henriette.herzog@rub.de>
> Cc: Maximilian Ott <ott@cs.fau.de>
> Cc: Milan Stephan <milan.stephan@fau.de>
> ---

This refactoring is a long overdue, thank you!
A few nits below.

[...]

> +		err =3D do_check_insn(env, insn, pop_log, &do_print_state, regs, state=
,
> +				    &prev_insn_idx);

- `regs` remains declared in do_check(), while nothing prevents
  pushing its declaration to do_check_insn().
- `state` is `env->cur_state`, so I'd avoid passing it as a parameter
  (just to reduce count);
- `prev_insn_idx` is unused by `do_check_insn`;
- `pop_log` is not used by `do_check_insn`;
- given that `insn` is presumed to correspond to `env->insn_idx` in
  many places down the stack not sure about this parameter.

> +		if (err < 0) {
> +			return err;
> +		} else if (err =3D=3D INSN_IDX_MODIFIED) {

Also, I'd get rid of `INSN_IDX_MODIFIED` and move `env->insn_idx++`
into `do_check_insn()`. This would save a few mental cycles when
looking at the code with full patch-set applied:

		} else if (err =3D=3D INSN_IDX_MODIFIED) {
			continue;
		} else if (err =3D=3D PROCESS_BPF_EXIT) {
			goto process_bpf_exit;
		}
		WARN_ON_ONCE(err);

		if (state->speculative && cur_aux(env)->nospec_result) {
			... bunch of actions ...
		}

		env->insn_idx++;

One needs to stop for a moment and think why "bunch of actions" is
performed for regular index increment, but not for INSN_IDX_MODIFIED.

> +			continue;
> +		} else if (err =3D=3D PROCESS_BPF_EXIT) {

[...]


