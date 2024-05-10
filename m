Return-Path: <linux-kselftest+bounces-10048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA748C2B16
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 22:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C4E1C21E2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 20:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4E54DA13;
	Fri, 10 May 2024 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g59Lspif"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9554D595;
	Fri, 10 May 2024 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372420; cv=none; b=rZu8XrH1KFngBQVMTuq+3hB0odpRLyI3odxk9+zsrZRbs+omjHEzQyu9BEdCmCAdZextSSKdIZDQLVmXG4a+LtJhUVjE2c97FGbv437yXtN3cZepVv+jQKa2zBdVREGu2rFcj7AHBUKjkyR3sI9x6jejY4ibSTrZDrIZwp7T3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372420; c=relaxed/simple;
	bh=TCXUmEuv+iM2nkO3iZsdvA9IrZmd3DCpNc0fVLD83qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+Rz9eOKecWAeq79TcnLrq58/jQfeImmKBET38HTNGP8GserltWaFhhMKUR72FDyemkfrCda1PdV8o2LO24xOsa8EUk014ZU+L2kOoRw3rKpjxZtwgLyhLN+JpDvlVvziPDlC9dgqY1zUGfb8GXJxKo+6YR+v7Xs8u+OuCG0qPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g59Lspif; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41fc2f7fbb5so12911505e9.1;
        Fri, 10 May 2024 13:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715372417; x=1715977217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyletMkDgqWyPnxZ333kKZUZ/DMhM/dfy7JO2wgf3Ss=;
        b=g59Lspifh12xwhk1uv3ZRwrWxFDyCygDQdF39EANP4LSQBMhSNPbDV1ABBAjR2C4ZJ
         845THMMb6T8hWTiTsFG4LzSC5xs0xKASpiGc825ckjCkMUE4TsyQxr0X1prx/Fvh2xGp
         CizJrK4f0L+KO953J4Oou1YaKaI/cme3sJF7Trak4fQcDdd7P5GS0qZL6H8e8SOdtiFJ
         7L88vCoip4n0NcpPpFmPMc+aO0+WdFF2bROFXoJMR2N5HnJOcO/U2mE7OMXOMFGywVc0
         4rme36Joqar3Vt3l3z7nJMimSxPoAz7xpizhbY48NokcWjTbepKQ2uT3oWpMhifgaRw8
         c36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715372417; x=1715977217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iyletMkDgqWyPnxZ333kKZUZ/DMhM/dfy7JO2wgf3Ss=;
        b=vtyXkxF1ix2ONZbeRQjb1ePiZGm8+sI66lWaeTBCPA5PkvLoWrp1QfUknPeFM+zIYk
         AhHBN+QEwJSbCMtkB8WY2caPU3R0tIYXpxU1RdBOfSYHFaI/W4rOlHfW5iBw8M72TzK5
         NlHj4g5ukxKPNzpKotDNpH2vRMuGZyQtjmtl2sBU+fvbEV4hGsdLXHoj3poeKadQOy7b
         75FROAYOlz6GkcG6zN6Rpt8FJKV0nTyaIow3GDDXH4ujgkAnCoonLgB4VnWgkoZyJ5+8
         6ss+8Teba+pTd0k/5Vb9lekn84i2EBDY8zLveRBgRXuzohLPjh0BcL7vCDyHCVMtf4Sm
         Oe9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVkqGmv082ATlGV1bv6SmRUzUeaKwF9u+2sUTh/SfqAhVyiZf1+QjckLBzfJn6Q2c23wNpP94vCzdGyZ+KADw+3/zZswMCvtvs9qrDLTrG8HUYZrEmlRUnuMbhs92/17KPVS6PYoFW44CLNDqzQRnIkJy7N9K4ZJr4SXD1wBzTQJoltVVt
X-Gm-Message-State: AOJu0Yy/+VwVokhcYn+awSWUzaplGIN+5NIDx798zf23No23YcKYeHF0
	gxVFJDmoLBr9CvTY59G9BcWZ3IfMXeRfoAxYfSLvBYWKR0jUWsaX
X-Google-Smtp-Source: AGHT+IEkAB7/t6XX8iV/NWbXmikRz4on5SfubcNwb+IT8gYYxab7QXXgih1MZc1e5j72v5y6GXjBDA==
X-Received: by 2002:a05:600c:511f:b0:418:5ef3:4a04 with SMTP id 5b1f17b1804b1-41fead59f07mr33462855e9.18.1715372416890;
        Fri, 10 May 2024 13:20:16 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce25d5sm75046735e9.14.2024.05.10.13.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 13:20:16 -0700 (PDT)
Message-ID: <98b7998a-3111-4892-ba1e-d0a026b64b0b@gmail.com>
Date: Fri, 10 May 2024 22:20:03 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v9 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
To: Eric Dumazet <edumazet@google.com>
Cc: alexander.duyck@gmail.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org, willemdebruijn.kernel@gmail.com
References: <20240507162349.130277-1-richardbgobert@gmail.com>
 <20240507163021.130466-1-richardbgobert@gmail.com>
 <CANn89iJfVHA=n-vSpFwoP3Jb8Wxr1hgem1rLqmyPWPUwDpe-cg@mail.gmail.com>
 <82f6854c-5d69-4675-8233-052a7b085cd4@gmail.com>
 <CANn89iJ7TPa350Git+r2dp6rvvJ-TUTYj5RiLi7i5TWsBJO1bQ@mail.gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <CANn89iJ7TPa350Git+r2dp6rvvJ-TUTYj5RiLi7i5TWsBJO1bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Eric Dumazet wrote:
> On Thu, May 9, 2024 at 8:58 PM Richard Gobert <richardbgobert@gmail.com> wrote:
>>
> 
>>
>> Interesting, I think that is indeed a bug, that exists also in the current
>> implementation.
>> NAPI_GRO_CB(p)->ip_fixedid (is_atomic before we renamed it in this commit)
>> is cleared as being part of NAPI_GRO_CB(skb)->zeroed in dev_gro_receive.
> 
> And the code there seems wrong.
> 
> A compiler can absolutely reorder things, I have seen this many times.
> 
> I would play safe here, to make sure NAPI_GRO_CB(skb)->is_atomic = 1;
> can not be lost.
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index c7901253a1a8fc1e9425add77014e15b363a1623..6e4203ea4d54b8955a504e42633f7667740b796e
> 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -470,6 +470,7 @@ static enum gro_result dev_gro_receive(struct
> napi_struct *napi, struct sk_buff
>         BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct napi_gro_cb, zeroed),
>                                         sizeof(u32))); /* Avoid slow
> unaligned acc */
>         *(u32 *)&NAPI_GRO_CB(skb)->zeroed = 0;
> +       barrier();
>         NAPI_GRO_CB(skb)->flush = skb_has_frag_list(skb);
>         NAPI_GRO_CB(skb)->is_atomic = 1;
>         NAPI_GRO_CB(skb)->count = 1;

I removed NAPI_GRO_CB(skb)->is_atomic = 1 from dev_gro_receive in this series
since it is not needed anymore, so going forward this issue is fixed.
I understand your concern about previous versions, I could send a patch to 
net to settle this issue. 
WDYT? 

