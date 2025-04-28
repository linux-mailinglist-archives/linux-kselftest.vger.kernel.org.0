Return-Path: <linux-kselftest+bounces-31754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE545A9E8B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 09:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B74179311
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 07:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CE11C84C4;
	Mon, 28 Apr 2025 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehZX5cPa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B1BA34;
	Mon, 28 Apr 2025 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823671; cv=none; b=X4DnQUiYBHGZDIPR5Kze0dWtrJGnngOCz/EK7VWyqF+eF9VVeVXcDLC1H2JBDLLmKl+RR4MkFEyqhikM8HHp/Dq8DJZYCmk1DpYOc0uqKPYm3JeVdffEXVz3lEMTVXjrubqnCW/4DvFdaGtYEWF861wcEqYBXg+jH4Z9OezKMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823671; c=relaxed/simple;
	bh=LxquXLKCLwZcPsxPnxkwIdYRyzBiKzetFpKc+QaqwC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dzD6WCZZapxGNtLEhUKlH33ez0FuE1en4s2VN9bYXH9p3R6Y8zjEuLNRM1V1CE58r33lLJ4APE+5jDfBaeayrFw8gvuyQ2fC1dtyadVSdStfZ8DnGvA7ijpQkNucx45wCsFfupi6IUA9g6Pl5TI6wYKjHbquLX8/tidGIQO4Fzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehZX5cPa; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so4406857b3a.1;
        Mon, 28 Apr 2025 00:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745823668; x=1746428468; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9yZmW0hn3MrvYOWlnfGa/3CtDPfOpCdnzl3M85GUApc=;
        b=ehZX5cPa0imdfRHezLMbtXPSRvHhsG3VB/FLbyya0vRK+3aZG5qxFe7jL/lbrj3wEx
         4ey/JhOtMy8cazQfPMAuMfGW2teao+PBhU+93A5aJ8AlnkBYQq5XUSJqJiGh2dQ622Va
         vR0eRsSyeL1cBPvit/kPW7E6Dxjnc/BNTlWBIvniu3votmkQgK1HA93R4yAPbWVTgW9N
         Ixf2CLC8AHqz5VSsZMp+/8eikyBAQFsSXRGv0Eo8a1/bgG2+madAD5RZpYzEQFEaEBQv
         EwX+4mT/ATJWQ0+fdQG3L4Mxi+Rqa3zFPkQqSYU0FJOqopuT33q0uMXMxsAjPsp35vBd
         Kaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745823668; x=1746428468;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9yZmW0hn3MrvYOWlnfGa/3CtDPfOpCdnzl3M85GUApc=;
        b=YUeR/RUGPHJrD0rCU54MmJXCur+iyk3c2WnchgqN9KmRux204nbPiGUx4cclF7qvni
         CRsHWq+zW4FAa7MCth+L4QUA623t9MToqKU+pTM3exTwLeqYrBWZ/QjLwImQ/aA7LEqL
         26eDYx3otyM9j56tPAxl0nUbBtPvAA0gIcIG3YumT1ETa1qmcWlAyC6AhOfWWolrG7wm
         HN+j5V3m7esyz7LSZQ5ezsx6bDJpcJoPRxkAjteTJDdIsOzTM8a5T4iWjXIHBQptO7A4
         Yn0ks2P/s1o5Sgf628LiKEfkXddF1Nmi4sgyspo49/Qe8KjzOdZ/3fojhGicNioOSCKV
         7T0A==
X-Forwarded-Encrypted: i=1; AJvYcCUAZ5i4M2BPsKZ6KtgrH6rlyalogUqkvGAxNG5hQCDypHNFlj0+qkFLZf897BIuTI0KqQfebzIEI5PtAhx37gTx@vger.kernel.org, AJvYcCVspNc/c+CWlx4pUP1j8lxOmbVeeEMWi9/kW0/WlYLXoQLEPgw0Aes4JN1rtAS6+WzC1URRN5yeK6MAKjC6@vger.kernel.org, AJvYcCX+Ia49FzJ+7EMSfRIGFAcHpskOjcJdCrcrJIqFRT1GrsuBr8iEJophuUn9pzHKpWDregE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGBc11K6Zvi/ub3qxVPTuySwjNIOHqV6Q2AAeFgwBqQHTPZgCB
	Tk1/L5Qlbo9KlAqagZnnwuWksPyO7d9OgkWnLvxUnca/gIoMgHAX
X-Gm-Gg: ASbGncvlmmZiRHcEGB5hLh7Ro7vFgmbIgbnobpBHTkXQQRXuw8zr6XXUTsQUVCNF335
	dMY2/4ALmZ4H1g2R7ZDd9HsMqbFusxO8ItdP7hDOqfFjZ7pXrvi7tRRindc9ovp0X7m2deNdHQL
	RT3o9CEMZ0TD8waPkh8SSjohcuU4Ruv7o0J7/041ntg83F8+9BNn7/nPfObbfMAs/Qouar8ssIi
	OA1XWZJh30rPNw7QBq1fOD4USLCWW5Wj1M9nruCtR2qR3+YwyWdIKofJF+Kaxex6queqmkFr5+q
	ZN7IEZdDpJbqRCadDRPQm0JvtwKkyhcc2HDf
X-Google-Smtp-Source: AGHT+IGP4IZjA+2oOl5Xp+BcG0TkWdBytzGu1mFgdq9c4ypqmC8f8TKCih+yUOSsexG/Sbbus31DKg==
X-Received: by 2002:a05:6a00:2e14:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-73ff73bcf1emr9419880b3a.15.1745823668236;
        Mon, 28 Apr 2025 00:01:08 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9abf2sm7173316b3a.122.2025.04.28.00.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 00:01:07 -0700 (PDT)
Message-ID: <3a16fae0346d4f733fb1a67ae6420d8bf935dbd8.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/4] bpf/selftests: add tests to validate
 proper arguments alignment on ARM64
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexis =?ISO-8859-1?Q?Lothor=E9?= "(eBPF Foundation)"	
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko	 <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Puranjay Mohan	 <puranjay@kernel.org>, Xu Kuohai
 <xukuohai@huaweicloud.com>, Catalin Marinas	 <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mykola Lysenko	 <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, Maxime Coquelin	 <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>,  Florent Revest <revest@chromium.org>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Date: Mon, 28 Apr 2025 00:01:05 -0700
In-Reply-To: <20250411-many_args_arm64-v1-3-0a32fe72339e@bootlin.com>
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
	 <20250411-many_args_arm64-v1-3-0a32fe72339e@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-11 at 22:32 +0200, Alexis Lothor=C3=A9 (eBPF Foundation) wr=
ote:
> When dealing with large types (>8 bytes), ARM64 trampolines need to take
> extra care about the arguments alignment to respect the calling
> convention set by AAPCS64.
>=20
> Add two tests ensuring that the BPF trampoline arranges arguments with
> the relevant layout. The two new tests involve almost the same
> arguments, except that the second one requires a more specific alignment
> to be set by the trampoline when preparing arguments before calling the
> the target function.
>=20
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>
> ---

[...]

> +SEC("fentry/bpf_testmod_test_struct_arg_11")
> +int BPF_PROG2(test_struct_many_args_9, struct bpf_testmod_struct_arg_5, =
a,
> +	      struct bpf_testmod_struct_arg_5, b,
> +	      struct bpf_testmod_struct_arg_5, c,
> +	      struct bpf_testmod_struct_arg_5, d, int, e,
> +	      struct bpf_testmod_struct_arg_5, f)

Hello Alexis,

I'm trying to double check the error you've seen for x86.
I see that tracing_struct/struct_many_args fails with assertion:
"test_struct_many_args:FAIL:t11:f unexpected t11:f: actual 35 !=3D expected=
 43".
Could you please help me understand this test?
The function listened to is defined as accepting 'struct bpf_testmod_struct=
_arg_7',
at the same time this function uses 'struct bpf_testmod_struct_arg_5'.
Nevertheless, the assertion persists even with correct types.

> +{
> +	t11_a =3D a.a;
> +	t11_b =3D b.a;
> +	t11_c =3D c.a;
> +	t11_d =3D d.a;
> +	t11_e =3D e;
> +	t11_f =3D f.a;
> +	return 0;
> +}

[...]


