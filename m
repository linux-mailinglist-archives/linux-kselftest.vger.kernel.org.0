Return-Path: <linux-kselftest+bounces-38993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8AEB26BE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 18:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 304BF7A982D
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CBC244690;
	Thu, 14 Aug 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdhgNAEH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31049220F55;
	Thu, 14 Aug 2025 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187602; cv=none; b=BceVhMZc7VKP2a+d+fAhPWmHPatDj7UyXa/oMuPJoJX9QnOzMKUuwd4CJRHvwso9J98SuzrLqeEP122UJcOZdZDZgGf7qR697ZJXpqoiPZ134PlugzpsEtdZ+iT5VJvpdd0c6BLAZTYVob2ndIOnR3IoFV6K0mn7E9frqAFZSAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187602; c=relaxed/simple;
	bh=lz47cxuQXW9kCaneS5tiSGf5QivssZJjHuGYjSUYoDE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tNggl4fXwHKkn60okcvuOQm+0TQFHF6Bv7qqJX8FBraiZTDnDJpLAYt4tYrbO2tLKW6dVElXE5uzeBFKuswiMsvxLK4vDvfnzK81T800nifSmhEGshNbTNsbGdF9Skmk6VlaKD+RTybVEHuQqhkVKNkH3kAxtNCRq0zxr0cMqSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdhgNAEH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-323266d6f57so1319082a91.0;
        Thu, 14 Aug 2025 09:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755187600; x=1755792400; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2JQC78ZpgMIMuWQWRfvjMuPKHibgoB05xt+yx0YmXFw=;
        b=QdhgNAEHZO265vJT4m3HGJ817fIbSIqIVCixapDZ2OMf/kiW4yfhFGRECcIvvECMJh
         iZsAumfMmtbBpE+qMnRBAmG38RqHOEjk62pIJ3LDECfyLkYED/ngN2SE86Z2K9MrbjOk
         +ugbq55w2bjRyI/vMRDnwoDjgKKD/J1WnDoZXvc1TLTNFSUyBs0WxavQqEUMtzm3+lcE
         +//eVSza9qfws79KoUJEhsLsNo+Z3ZyS0YzzD3KetHW/f0grrlrvCob06n6vkS58nkL2
         AxuGqTvhMy+7AKM36yOWBdKfli5ZB4H8l+fy3tPRIWwsjLZ6LwVg6dKmLElDA/0cXJr5
         RGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187600; x=1755792400;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JQC78ZpgMIMuWQWRfvjMuPKHibgoB05xt+yx0YmXFw=;
        b=CRsedaOioT/QLbC5iSgEdJBeC95qdnCmLqySJYvImiKlUKEfTTEFQYRZKVYTy3G65A
         LSpJGHkqqyecyYp/WMwsfHLaVxNiAfZvvv90qquP419asFyHc3j8gfP428jlnFBtnwXH
         lFegFA1f3DEoiNJA/QU6albpZJ9F/Wp8sy0rz4v41BjdIAeA/ikPy6Tr+cqJakDeDKHF
         UZYpTsT/gS1SkesqatJ0YSZkJIl7Z2o/2OpnjrVjV1138DgDQ4Ziz7IQksKvdith1eFA
         uszBEj2g/PljqkghbNAfB/Zg018AWTNbsIzxJ6vrl7VNEZFxxM4UkWJs8igoC5BVSWVA
         vM9w==
X-Forwarded-Encrypted: i=1; AJvYcCU0EdazzusJ9VpP0llZ+DeOQ7CBY84DHcwJ7iQSBT6m9+2rqq+ZnS9zBrWuqUXKsVqwNEkGnoq722ZqnOcy@vger.kernel.org, AJvYcCVG3rQyqU3Pp4/TSwTKtYGlimkHB1xAd9ygDTvxZ42ytNMkFrm4Atd+0xYV1zt1IE7T9P0=@vger.kernel.org, AJvYcCWcV19tz88Qgdo0wViFSIlwgHKg5pNETUMH2BEIzhaZ9ms9m6b2tOKAc33ezl6f2zMl92bohIOCx8tUTJqBDbpa@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ4JekbJ3hrAn6kKNkhPyXOPz6UUGpkt3bWz4rP1+gc+Flsgj9
	32h4HfrXK9ColyuaJbz1YLG0dNJd9SdxqLGckX3NQ9tpRupi5UlpnpHZ
X-Gm-Gg: ASbGncv4tOCpe+KAFj3TeHLDAmwpZRhqo+JIgY+nw8pXYAFc3AG9EnuO0jbvwyyVJ7F
	BwK8fWy+1WG8NXdk1nQk/M6XZVnGmVJSjF1JXEwptQCOPFTMle373PnIbXftewR5jwmBud0SJNb
	kSgN7T7i7KKR+fZniBkcdS3c9cKyGtzUsMWp+0e73KiVf/uVfVZmKLodPhq4uJEkEi2iOcAYIF+
	XFXxlaAWQKOZKVtVvDp3nplPLhgzIqJzpjDSPFt8gWVYbNTweIg6Ch6+gsab5ibDJa9KtWdjsB+
	miIspqGOULBTmUJ+r75n4Uch4PYzpfD1rsqHGePDnY/9LriRVVfIOjtMTOb+AiDx2EvldS05nGN
	Cp9gEwj5Sra/5cBFzqNY=
X-Google-Smtp-Source: AGHT+IEhBBG0ngLQSL1m1pTEMacHumOyYx5CiFYAiylVBFK4bQhJSTeJAL3kGYnVrMJWW2lrkPzzkg==
X-Received: by 2002:a17:90b:2745:b0:31f:eae:a7e8 with SMTP id 98e67ed59e1d1-32327b28cbdmr5893443a91.11.1755187600264;
        Thu, 14 Aug 2025 09:06:40 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32331097831sm2246465a91.33.2025.08.14.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:06:39 -0700 (PDT)
Message-ID: <35c18502a4870d8a833c1c9af20b85ca3f8a0ff6.camel@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add socket filter attach test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: KaFai Wan <kafai.wan@linux.dev>, puranjay@kernel.org, 
	xukuohai@huaweicloud.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, mrpre@163.com, 	linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-kselftest@vger.kernel.org
Date: Thu, 14 Aug 2025 09:06:35 -0700
In-Reply-To: <CANk7y0hQWOL3OW8Ok4e-kp7Brn5Zq6H5+EfS=mVtoVd+AUxZmA@mail.gmail.com>
References: <20250813152958.3107403-1-kafai.wan@linux.dev>
	 <20250813152958.3107403-3-kafai.wan@linux.dev>
	 <eb6f9ba4acccc7685596a8f1b282667a43d51ca8.camel@gmail.com>
	 <CANk7y0hQWOL3OW8Ok4e-kp7Brn5Zq6H5+EfS=mVtoVd+AUxZmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-14 at 13:23 +0200, Puranjay Mohan wrote:
> On Thu, Aug 14, 2025 at 2:35=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Wed, 2025-08-13 at 23:29 +0800, KaFai Wan wrote:
> > > This test verifies socket filter attachment functionality on architec=
tures
> > > supporting either BPF JIT compilation or the interpreter.
> > >=20
> > > It specifically validates the fallback to interpreter behavior when J=
IT fails,
> > > particularly targeting ARMv6 devices with the following configuration=
:
> > >   # CONFIG_BPF_JIT_ALWAYS_ON is not set
> > >   CONFIG_BPF_JIT_DEFAULT_ON=3Dy
> > >=20
> > > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > > ---
> >=20
> > This test should not be landed as-is, first let's do an analysis for
> > why the program fails to jit compile on arm.
> >=20
> > I modified kernel to dump BPF program before jit attempt, but don't
> > see anything obviously wrong with it.  The patch to get disassembly
> > and disassembly itself with resolved kallsyms are attached.
> >=20
> > Can someone with access to ARM vm/machine take a looks at this?
> > Puranjay, Xu, would you have some time?
>=20
> Hi Eduard,
> Thanks for the email, I will look into it.
>=20
> Let me try to boot a kernel on ARMv6 qemu and reproduce this.

Thank you, Puranjay,

While looking at the code yesterday I found a legit case for failing
to jit on armv6:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/arch/=
arm/net/bpf_jit_32.c#n445
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/arch/=
arm/net/bpf_jit_32.c#n2089

But attached program does not seem to be that big to hit 0xfff boundary.

