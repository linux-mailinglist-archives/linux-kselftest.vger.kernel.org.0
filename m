Return-Path: <linux-kselftest+bounces-9990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C78C1E97
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 09:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB5A1F21BA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 07:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B17153BE2;
	Fri, 10 May 2024 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSR6UNy7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF4482D0
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715324516; cv=none; b=WlwbcSDq/x1wCuNmymtFkmJcSJrt8qQWa6u4wKwYCX2XMVWxZD6RNqtRL0IpPQcqGCMkZ05nmjcVSpU9zbAuKd5X0ZrmC6FnTLii0P2G9zlw6pOyNBFc1AHWU8AMzsfKfFmwqjIAsMfdc20hZ1DBtowfY0Y8Y/VYY5Nu+1lwZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715324516; c=relaxed/simple;
	bh=7oGXbFORwBCyzCIXmLVRq2rm6tpAyoLE/wEl7xVni/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfSuY/wdhA35Hyil9s3CUeVd0JZH7FdUwVxJB11VefAeqMVh1SATQatqb88WOno7buTwBgugmYBmxIVotKC1M+LkNXYr9SADOXR8GvCMoeeBXxforgobS+bDQhfjOP97XdA8FPbGk/f9UBQeVvdDfPnZG6MWDyJDBMkKXukObS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSR6UNy7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b48daaaf4so55425e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715324513; x=1715929313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fNjQtXaSKOYp8nX/E0knSnpY+xEYmx9idjbqHww5m8=;
        b=FSR6UNy7ZCeAoKw4kCtum0FHjMP04IWADohr7m7A5TLlSkuMvQAjAcvzR8UjzJfBNC
         3tH7uJQlHm9S8jDO6mu/RD1pDyNcw8i8+pjqVYJmkM6H3p4vvwvDTCRPDQ+Lla7srN1u
         jHJWTGQxz/SPK7mJqIYKLsMtyepy5LA5XDs57QyfEYwjukbNg/MrZ/kCBNl6Khp3UTE0
         UERCbamJedTMLe+klmnv4hli01rs0GgW6e1p91U/vJNfArxZWxwAC9MDidnzM/4fMSVY
         kT/vxWA/+Z3IkROawa9ZCYxHlLHIJAIGXOyToPnpCgWZYyrgZUeNT+5U0HLEElf9UYyi
         cxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715324513; x=1715929313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fNjQtXaSKOYp8nX/E0knSnpY+xEYmx9idjbqHww5m8=;
        b=sbnFwDfPy6PLuy+b/8FgCTkOGLpnhyP0Y6vvLhf5bc1zS2P8KF65LdKbt7WdYOCpLs
         lRgl3bQOWHXxGIYrlMtuSMtZ3Mrai5bkWp1aWwS8lybJK6DR+xA48vNnMXMiZf5Cm6D4
         Aa34f0K7rXs6HZqOhiHZZhk7Ke3AR/sP6MEcHT+1kNhUepAOgdJxypdYOMcf63g3OnsD
         ri1eNAzrXkV+IEZ80pa6JfIWH4vSRMYSbq27LBg6VSsHF7apg18uvVZqWlOWo6qeq4J7
         m2UHW6mxdNBLa+nodJUt0SZIEOQMGmec2nM4dYs2H4s90ARl5IP1cDw+lBBVPq14/5uq
         qSIg==
X-Forwarded-Encrypted: i=1; AJvYcCWyXdvOvzRVtXQWzinhodsS1AO3zDHOsh+fnIzrSilzdsCuIYqZQdonsSRZPdEeWt0x2zQwRqR30RMMVdFOm31mYZKKNZ+GgpwDE1fQFox0
X-Gm-Message-State: AOJu0YyblY26V4getjWFDdUU5cFbP0dFuli0GvldI1SRTYrYu7JJ0byd
	Gihob/cyR0LBwxe76OnPuL0aYEVZo3iN+QwZShhlRHTxf5ZZ5O1c8vGyHka2P5uwq5hLmrTy6+g
	bA1Fmef0xpjdbi/OSZTm4YOnPKmqT9no6z1is1QzxWrC1AAqyivcK
X-Google-Smtp-Source: AGHT+IHXgoYwv8mIiaDIGVOr7ncUPb8+Jxgb25xnmzzrh7Nx+vSrbhU+T7T2JV86E1ZVTxXeU3M9WBbaaejAwoMk2Q4=
X-Received: by 2002:a05:600c:6b13:b0:41b:e416:1073 with SMTP id
 5b1f17b1804b1-41fedc6d1d4mr1312435e9.0.1715324512596; Fri, 10 May 2024
 00:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507162349.130277-1-richardbgobert@gmail.com>
 <20240507163021.130466-1-richardbgobert@gmail.com> <CANn89iJfVHA=n-vSpFwoP3Jb8Wxr1hgem1rLqmyPWPUwDpe-cg@mail.gmail.com>
 <82f6854c-5d69-4675-8233-052a7b085cd4@gmail.com>
In-Reply-To: <82f6854c-5d69-4675-8233-052a7b085cd4@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 May 2024 09:01:37 +0200
Message-ID: <CANn89iJ7TPa350Git+r2dp6rvvJ-TUTYj5RiLi7i5TWsBJO1bQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
To: Richard Gobert <richardbgobert@gmail.com>
Cc: alexander.duyck@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:58=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
.com> wrote:
>

>
> Interesting, I think that is indeed a bug, that exists also in the curren=
t
> implementation.
> NAPI_GRO_CB(p)->ip_fixedid (is_atomic before we renamed it in this commit=
)
> is cleared as being part of NAPI_GRO_CB(skb)->zeroed in dev_gro_receive.

And the code there seems wrong.

A compiler can absolutely reorder things, I have seen this many times.

I would play safe here, to make sure NAPI_GRO_CB(skb)->is_atomic =3D 1;
can not be lost.

diff --git a/net/core/gro.c b/net/core/gro.c
index c7901253a1a8fc1e9425add77014e15b363a1623..6e4203ea4d54b8955a504e42633=
f7667740b796e
100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -470,6 +470,7 @@ static enum gro_result dev_gro_receive(struct
napi_struct *napi, struct sk_buff
        BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct napi_gro_cb, zeroed),
                                        sizeof(u32))); /* Avoid slow
unaligned acc */
        *(u32 *)&NAPI_GRO_CB(skb)->zeroed =3D 0;
+       barrier();
        NAPI_GRO_CB(skb)->flush =3D skb_has_frag_list(skb);
        NAPI_GRO_CB(skb)->is_atomic =3D 1;
        NAPI_GRO_CB(skb)->count =3D 1;

