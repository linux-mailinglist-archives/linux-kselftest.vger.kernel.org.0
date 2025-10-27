Return-Path: <linux-kselftest+bounces-44139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F80DC1136C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 20:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD41188A91A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D54309EF7;
	Mon, 27 Oct 2025 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTbBK6PH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E482F25F1
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594049; cv=none; b=lencG2xvlZZzN5tBKeqvIHyNCioYFNuEGC5MSGCsgSHIB2BhUCpqGo9Kcm5flJ28zrJX5TYFegHsXwuXZq5F2SQbUL7sIPkofUvrFWTirPy2EzCYV+upwfeCCCxd+l9e9+usR51jaWoZ9pjTaNW3FMzBS6rIeh9LuJI55Rpy4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594049; c=relaxed/simple;
	bh=LJsc2dF401a18ttCGln4rv/KtK9MA6GnYaTwe6pSYCE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=srA7F2vl4Dj5P5BRTegS8OyaA8T4c5t8G4bVc0AtsmjwlPMPJpsNjJL1O9z9lSbrEOE9+E3kO3R4Lm4NNj+6MzTXyGpeYDXeoWp1gZZPAtaxiSCYdbVuWNGy/xGuoValQJLHDtMg8CLS3RR0FoyR8vsEqvkPlPLip1YYuXxQ8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTbBK6PH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26e68904f0eso55041605ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761594046; x=1762198846; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYquFuM2DJku7BjAYv0r20xBxJ+mXs/GgHx2sVKAPks=;
        b=KTbBK6PHuKNjrmHY2fn/ttQ2gnhh7SK55pqbh/IBQ3W2Zn+aXOA6s2eLvpT65Mr21g
         hRE76RVsbCxY86X17XIKEEaqw213pel0ZyfqnfwHJzoGVEm6oG0jaNyUpeAVr+1lhjCb
         15IgMsfVIe6bwcF7HScgpKgOgXwwb//RyLIgZT+LTWfY4cQks5NQ0O0Iq4Uvq3ufUe0i
         kIjTuiIMe/sQMLJVEhALg1yMOq/ogPpp8nMt6RsY7lt1Y0+nR1Na41KtOZRNmkt1Dq6e
         KKVPn3jaJaAghV5q4K4RzOLwJMji5IsAtUJXWGAhlY3bTlFdLBKvK0BWPnQrEr3S8VFg
         QZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761594046; x=1762198846;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DYquFuM2DJku7BjAYv0r20xBxJ+mXs/GgHx2sVKAPks=;
        b=Bub2Jfv8Qn1u+0eZhy07qhaS305VVDqW5StnJ1sS3g82BLv8ZRd4+huZMNZv56Uzu5
         CwI3E8kAEQoZ2QTzCqj0N37mpCdjx3Y0CP7aNfA3p2+7n9gklHjEYTCtr3iMwKtIQucL
         A92gTUEd1uxba/hBmT9JiO1ddgiM+I2KMmb2YUZ+6lQEc2RB04yEQ+F+fazgBZV6Kfgm
         mxQal4VQdYSgiT+6XvJk5uGxmPU3KIv6cTQ0lMQGBE7NIya47TU4i7aT3ugi7WHgWbrQ
         LF7+6Wfg6+JYKtLz5Gs/qnd40U3QbW4XkrQSlO2S8FBNPTxkcpEAqwtYimCxV01hq5nu
         Xvbg==
X-Forwarded-Encrypted: i=1; AJvYcCXpUQZixpcrvdY6K2xzNPtmIG48ndfIRqvSf+VWAKYF8SFxCzeMQ658oTprYHPQeIuqoK34LtRJ0zsOfmJMKzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYNP/q9qI211G0lMbDmlVVcF4poMQyl9KOihb0j3VMIW1cpZ/K
	xm5d4KR8gR2Gj3mOd2GO6gdcg08mK++1fXnJoVmz850IEHrGaQ21zcqo
X-Gm-Gg: ASbGncvOc/5grG0nmVE1OjsY8u1L6uAYt7rwwDkfWvcmoB6oUoYL9J/ZhAtfi5ox7F0
	0VtoSonb2m1TKNtsyzDxOY2i0/asizhRQzQM4zJv0+hFjKOkXw8tEe6y++9Rg4U9mrOjAURa07z
	3KpA7TH1p6ekZ2kRWcXs1P8ils1hdNDXaCuFvkLZu52XpVslIWsVzAm+KDv3fh2HOPsqtJbnBHH
	YKYJvpJTVA3dDI0XcTNRiprfirDZR2DWv7bCjB+VHAzEb79V7fX2JifeWVZV0GGmxqLJykrZx8v
	+Lxth8dYqPDYASY9cKGBAbB54fzE55ssJaODoMdA38SrmqJv1PhrXV0Fugw+XR9ukU3wmUh2WhV
	aZEm+kYK/1hFgUdkRIm5Osr13ycM0gHPjTbLqzd6DOO4eGkCgGb3yKpHLj6edxJ8deZcWWQ4QRG
	+GltpS2SG3
X-Google-Smtp-Source: AGHT+IFlDwV56FqNaaR7GrdvETO82oysKmQtrwPBBWfO2vJ67aNk29JP9vzetVkVDQ18K8dgn7gLxg==
X-Received: by 2002:a17:903:244d:b0:24c:b39f:baaa with SMTP id d9443c01a7336-294cb65f7f9mr9917365ad.49.1761594045818;
        Mon, 27 Oct 2025 12:40:45 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed835e26sm9393463a91.20.2025.10.27.12.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:40:45 -0700 (PDT)
Message-ID: <3e3643bdbad74611b5c00bb2d5931647dc7b8208.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add test for BPF_JGT on
 same register
From: Eduard Zingerman <eddyz87@gmail.com>
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, shuah@kernel.org,
 paul.chaignon@gmail.com, m.shachnai@gmail.com, 
	harishankar.vishwanathan@gmail.com, colin.i.king@gmail.com,
 luis.gerhorst@fau.de, 	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Mon, 27 Oct 2025 12:40:42 -0700
In-Reply-To: <20251025053017.2308823-3-kafai.wan@linux.dev>
References: <20251025053017.2308823-1-kafai.wan@linux.dev>
	 <20251025053017.2308823-3-kafai.wan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-25 at 13:30 +0800, KaFai Wan wrote:
> Add a test to verify that conditional jumps using the BPF_JGT opcode on
> the same register (e.g., "if r0 > r0") do not trigger verifier BUG
> warnings when the register contains a scalar value with range information=
.
>=20
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---

Could you please add test cases for JSET and for one of the *E
variants?

>  .../selftests/bpf/progs/verifier_bounds.c      | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index 0a72e0228ea9..1536235c3e87 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -1709,4 +1709,22 @@ __naked void jeq_disagreeing_tnums(void *ctx)
>  	: __clobber_all);
>  }
> =20
> +SEC("socket")
> +__description("JGT on same register")
> +__success __log_level(2)
> +__retval(0)
> +__naked void jgt_same_register(void *ctx)
> +{
> +	asm volatile("			\
> +	call %[bpf_get_prandom_u32];	\
> +	w8 =3D 0x80000000;		\
> +	r0 &=3D r8;			\
> +	if r0 > r0 goto +1;		\
> +	r0 =3D 0;				\
> +	exit;				\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

