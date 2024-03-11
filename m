Return-Path: <linux-kselftest+bounces-6187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A285C878058
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 14:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F027DB20E40
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F193D0AF;
	Mon, 11 Mar 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMwTmTlx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15D3FB9D;
	Mon, 11 Mar 2024 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710162833; cv=none; b=om4crdmYXWLOKn4rS1dSn1Irr0BWgUaF72rJ+41iOHHVMqyeag3rV5n7uQW+20FcgPATYo1U6svtTf9CRJjGn2ymUts03gi4s959W1bVx8/044xGHa+IYQ5ZmzGGOxXopIbnyVvLNwJbeHFYxwN3G+ES9YZCHDJgIDkN26+eoJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710162833; c=relaxed/simple;
	bh=dgrigR/7NCTojYkAKWD9wX9ICHnAGPtLi21TWc4E8dg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=L7/72fjuJh/FafHzay48uvPZw23MO8WpZNtRSFa457Z5fkppAVJ5Pv4LAyXhki36MIxbWc8f6HMR6ExntYU9uaRvsDKdkys88SaIDzLc0NQr5LllFUaCbCFDI3v828mKjlKa7i9CeVd9MwsxUYeuiXBNA98ccelVVoYh/y2zApo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMwTmTlx; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a17a739935so2564207eaf.1;
        Mon, 11 Mar 2024 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710162831; x=1710767631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dezxuW9pGx05LDmCqYlbJ6coIEuJ6OpOhgk2fuSR0X8=;
        b=XMwTmTlxM6IzRlzCRPmXobHSLTdnUaKtx5o8VwoNCm4g481wCzpsPN1CaRiyNu7/tz
         CQmh/H7ZKoPv6NRDdi4w/WtK/hH1ULdHvZrZ1IWLSNy+MNWSsxzw2wf5sCDTv3i2DiHY
         3+22vPZVxBVczhTwengrspEXTMbzXBQKQicM9lh813BpK/QQ+5jSSjnLzDJxFPPK2nUE
         YCSl2uvqiZyyqd4RceyHWoA7Zt4w/JTrQOndjHp9fwu4n2aFjpoqFyyDEbv5JeWQr3bM
         0slY2TuK1nAQXJ0khF6ygXcPsaDFIz444ZCUA1YB9u8SgL16LtsaYmcp6vyDYa5Ieh0k
         TlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710162831; x=1710767631;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dezxuW9pGx05LDmCqYlbJ6coIEuJ6OpOhgk2fuSR0X8=;
        b=j3lRCmJfn6OYz7IYn9Zwf06NcEpfiOICQ+HwPdUYXa8cs3ih/9pQkmGn18EeDsEK69
         frwt3kkPwvd6vEEOslss0mvyEUJavp25hqeAxQbo2GOvZ11nz3AZ4NkHp6dLMXVdRPaR
         A56y4im3vegOjYWTsoWlzndJTcprw7JkI3oZ0Friy8+JGSnvr6bilpxMKEHIWOY7vIYw
         r11jz47oWQC2McFgbXhskkGH+M5GZa4kZzFNEIVzU4kfRzzYQxCqgwTRj7lVOxvucdCp
         wB1Eilo65MyxSepFX0GYMPDIKGg9fujW1GetXjMDrot6c21ATYnrPKQTKq1+UdWmsrnk
         zxvg==
X-Forwarded-Encrypted: i=1; AJvYcCW7Lk/0HvHbUtEiKwhFxYm8xZZ7Y62G5GmD2gZbzKG0QCc8N8N5Q6Nfj+IsX2HGwf84kdOzYrjuMaVOwqFjrzWRvh8jnBUCgl2OFz9bYJ9h9Cxl55a/excXksFTanjk1wYp02uBI21qS1ky2rPNhYYEo6SISZn0lkou3vW3lu/f6cW2F+vb
X-Gm-Message-State: AOJu0YzO/9Uj2U5LrvrQC3tU9sgk3slZ1Q2FN78HpJD4emqmndY9979I
	33lyN9rXveGSWuDaV9sb5Bak5mpzdOJhDJfFFuInk/MMQUT7e/FU
X-Google-Smtp-Source: AGHT+IGTQa8y59aDsLASaj7LZksfhOKifn5u3+CiaI7MeePb6ux4rgQVzmT+x0EFZi2xsLFMGaQnYw==
X-Received: by 2002:a05:6358:480c:b0:17b:f637:7bb with SMTP id k12-20020a056358480c00b0017bf63707bbmr7300635rwn.30.1710162831109;
        Mon, 11 Mar 2024 06:13:51 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id f1-20020ac87f01000000b0042f37ebfbf2sm2481546qtk.5.2024.03.11.06.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 06:13:50 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:13:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 xeb@mail.ru, 
 shuah@kernel.org, 
 idosch@nvidia.com, 
 razor@blackwall.org, 
 amcohen@nvidia.com, 
 petrm@nvidia.com, 
 jbenc@redhat.com, 
 bpoirier@nvidia.com, 
 b.galvani@gmail.com, 
 gavinl@nvidia.com, 
 liujian56@huawei.com, 
 horms@kernel.org, 
 linyunsheng@huawei.com, 
 therbert@google.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <65ef038e78a8b_20699f29437@willemb.c.googlers.com.notmuch>
In-Reply-To: <d72bfd79-ce72-49db-b648-930a08b9302e@gmail.com>
References: <f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com>
 <88831c36-a589-429f-8e8b-2ecb66a30263@gmail.com>
 <CANn89iK5+wqYdqMt_Rg3+jO+Xf4n4yO4kOK0kzNdqh99qgL3iQ@mail.gmail.com>
 <967ed173-b556-4bfc-b3c8-ff0fc902b951@gmail.com>
 <65eef506331e8_1db78c2941c@willemb.c.googlers.com.notmuch>
 <d72bfd79-ce72-49db-b648-930a08b9302e@gmail.com>
Subject: Re: [PATCH net-next v3 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Richard Gobert wrote:
> Willem de Bruijn wrote:
> > Richard Gobert wrote:
> >> Eric Dumazet wrote:
> >>> On Sat, Mar 9, 2024 at 4:35=E2=80=AFPM Richard Gobert <richardbgobe=
rt@gmail.com> wrote:
> >>>>
> >>>> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags=
,
> >>>> iph->id, ...) against all packets in a loop. These flush checks ar=
e
> >>>> relevant only to tcp flows, and as such they're used to determine =
whether
> >>>> the packets can be merged later in tcp_gro_receive.
> >>>>
> >>>> These checks are not relevant to UDP packets.
> >>>
> >>> I do not think this claim is true.
> >>>
> >>> Incoming packets  ->  GRO -> GSO -> forwarded packets
> >>>
> >>> The {GRO,GSO} step must be transparent, GRO is not LRO.
> >>
> >> Sorry, I should rephrase myself. The patch preserves the
> >> current logic in GRO. These L3 checks (ttl, flags, etc.) are written=
 to
> >> NAPI_GRO_CB(p)->{flush,flush_id}, and NAPI_GRO_CB(skb)->is_atomic - =
and
> >> all of these are currently used only in tcp_gro_receive.
> > =

> > That was perhaps an oversight when adding UDP GRO?
> > =

> > Simply because the flush is determined in the innermost callback.
> =

> It might have been an oversight. From what I have seen it's only releva=
nt
> to GRO's UDP fraglist path (it was added in 9fd1ff5d ("udp: Support UDP=

> fraglist GRO/GSO.")). That's the only UDP path that calls skb_gro_recei=
ve -
> which may alter the forwarded packets and make GRO/GSO not transparent.=

> =

> AFAIU NAPI_GRO_CB(p)->flush value is not overwritten in encapsulation -=
 it
> is determined by both outer and inner callbacks.

Thanks for the context

> I tried to preserve the current behaviour in GRO - if we want to change=

> this behaviour I'll gladly do it, although I'd prefer to address it in =
a
> different patch series. What do you think?

Yes, it's entirely reasonable to leave that out of this series.


