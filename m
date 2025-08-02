Return-Path: <linux-kselftest+bounces-38221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68350B18E93
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 15:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C609CAA4B55
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 13:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF4238144;
	Sat,  2 Aug 2025 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzDCcA0/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF8520296C;
	Sat,  2 Aug 2025 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754139976; cv=none; b=LYi9OK6grZ1fqkDrFHItHVNa8cNNRATvLc9Z9aNpQtoFyTnyNrvY1RnEWDIdkOuHRRGQFDM8D6AWk0Y4qZgTAOjWHLc16xmVnGvZZ/+bT25GpfxFoWnYHtHisEMztejp3lGcfk8XNBrU9FFDzMNpXYMixaJrXk472hqVCVeW/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754139976; c=relaxed/simple;
	bh=4y4BBMpRTlGCIWdhx/iujTMekc86BpwM2Byf2EHcVwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAN94vbjYwoau8ObtUD0z0STkEdK3x5EyO9ZA3Aj1Je5HledKxJF+0XL3Mj11yUseZpyR39L8Zyf99M3b2hun6As0Y4FXO7vZfiOUtbvx4WivL2rAsfusTPQqvxav8ujFNgiNq3cCLjpkuDpxFfW+Y5yFaESStj2g36vLUBSEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzDCcA0/; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e40ac40940so10551465ab.0;
        Sat, 02 Aug 2025 06:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754139972; x=1754744772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmonmtKoAvELfCzQBfuBaiOtioQAYepmYG58Tt5t4Vk=;
        b=LzDCcA0/fpMSlq9RWiSG+6iddiJsoy5Y/ej6mgeWlYFJTjCWOwr4L56cj4CRWGRr0x
         UQIrR/9yIePCqY1LUx5dEOq/8qXjMC3jtkhyCTMm90P3E8OUt4Fv5I769/5qJDdW3vW6
         V0O9W5I/stwlSCj5FUWn/IXRACNIYahvBiw4KbSa+76+n+FORs+FRmp/cHi6pui7xYHO
         uKTAAmZm78Brx1HJbcrbWDidnZn/oGzQPGRt99+j5SOuu24uMjdfDZ1ww5gYmvXskLJf
         lEnWSI87YLYIxBrmmtK+G+EEWpvmZNv/PDzhzzoaDuT3JvL74PdD/z4h8wKWjNcow0O4
         uNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754139972; x=1754744772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmonmtKoAvELfCzQBfuBaiOtioQAYepmYG58Tt5t4Vk=;
        b=Nu2+zDc1WjJBcTqGiclXhVF2JtMKxprz03iIx6YavUON99UlN0QURGZ+04C/AjZtYK
         3RSVkJqGZciFeBTXdZ8RvGb8hzlBk5HcdWUqa3N0ljmNQUOV/dpQy2RJmcLjGmDL0C4W
         7Y46BMguizlz9E8h5v2w729ST9bkQiTgwbbSWCGMQ/bs6CFifMfhXgUJzLbNG7nwZj+F
         SuDCm09ccmcfxLN6ptHH5NWFLtG/qycBdpjj2EaFk4nZO10AxxsGfFJiWeioOGwbJqY7
         YDhkBdLhvEIUjedF/52hU8KxRaspLxAgHq59VmPadAA9FPSAdXA66mx8BAPXL9b5fOEY
         390Q==
X-Forwarded-Encrypted: i=1; AJvYcCUq6FYqyRR+VtuOMlqcwmPyD7X7s/oOpaT/LIjbwkrz8AjCRm47MCV3AO+QSUICuFBwU+doPeHlMKAOx1o=@vger.kernel.org, AJvYcCUxR4UPvvEzaOc/b86Q3e9SyNo1bAcBw9BMuHPuq/OBvs3rc/T7WymTtiIvYMFukOkd7a1lhhKr@vger.kernel.org, AJvYcCXPyiswZASiLua80DT9JJa9rFRQn/FKQqXjhv9YsTMToIbUYMFCEvhLpcgkyyqyJyevpE74uCsj4xa1iJTJVr2T@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk2DUCFble4cpbemOhoNJxOs/XWG+IVgjNXhPAZ94wOVV1zrg5
	LW1GMJ9iubJUF3zoRMOuFmTNSlkLzv0QtqGo0iUN31N+c+l0/ulVAjhEjXKZgtl9JKdA0zwmENI
	TTFj8TE77/PpCVwjZh7Vr9LiRaXmDLvY=
X-Gm-Gg: ASbGnct0MGLUkF8Vovv2TObudf3fohr/4NKoy/kCI9lvn3vKqY/A39yfhsDa4OVS2G6
	OrXH/+CKJVqebkiX2YO6YFFcTAw5p63J5SP3fqTMZMv/IdXpPfyIhOAQEjw7yiAJlRqBQ4uJS7h
	CaXduy2zz+2oW4iKCWWnJVG07z4u4pjbBV8pdZ9Se7wPkqbwQgJDtXdWoR2iwN9SMIvYkNvgUNL
	fZSq/Q60yF+oSQi
X-Google-Smtp-Source: AGHT+IHpd35+kT9HdI5ApiKpoS8VgCg9bl6wjNctPoyEhnXzMQiFoSmDe+xgrsbVS76z0H4HD3/mJtYGgjbw29dVPsk=
X-Received: by 2002:a05:6e02:2194:b0:3e3:d224:c652 with SMTP id
 e9e14a558f8ab-3e415e6cca8mr47665065ab.11.1754139972399; Sat, 02 Aug 2025
 06:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802092435.288714-1-dongml2@chinatelecom.cn> <20250802092435.288714-2-dongml2@chinatelecom.cn>
In-Reply-To: <20250802092435.288714-2-dongml2@chinatelecom.cn>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 2 Aug 2025 21:05:36 +0800
X-Gm-Features: Ac12FXyl1Z17710ZsvGZEcG3nKUw1BENEpT2KZPZWCpTbIBZTcW63ECEgxt-fVk
Message-ID: <CAL+tcoA9Lvc4Cj9zjWVx1FzEQA=d=OnvZRDWA4nE_1GNbEDaRw@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net: tcp: lookup the best matched listen socket
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: edumazet@google.com, kuniyu@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, kraig@google.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Menglong,

On Sat, Aug 2, 2025 at 5:28=E2=80=AFPM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> For now, the tcp socket lookup will terminate if the socket is reuse port
> in inet_lhash2_lookup(), which makes the socket is not the best match.
>
> For example, we have socket1 and socket2 both listen on "0.0.0.0:1234",
> but socket1 bind on "eth0". We create socket1 first, and then socket2.
> Then, all connections will goto socket2, which is not expected, as socket=
1
> has higher priority.
>
> This can cause unexpected behavior if TCP MD5 keys is used, as described
> in Documentation/networking/vrf.rst -> Applications.
>
> Therefor, we lookup the best matched socket first, and then do the reuse

s/Therefor/Therefore

> port logic. This can increase some overhead if there are many reuse port
> socket :/
>
> Fixes: c125e80b8868 ("soreuseport: fast reuseport TCP socket selection")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v3:
> * use the approach in V1
> * add the Fixes tag
> ---
>  net/ipv4/inet_hashtables.c  | 13 +++++++------
>  net/ipv6/inet6_hashtables.c | 13 +++++++------
>  2 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index ceeeec9b7290..51751337f394 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -389,17 +389,18 @@ static struct sock *inet_lhash2_lookup(const struct=
 net *net,
>         sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
>                 score =3D compute_score(sk, net, hnum, daddr, dif, sdif);
>                 if (score > hiscore) {
> -                       result =3D inet_lookup_reuseport(net, sk, skb, do=
ff,
> -                                                      saddr, sport, dadd=
r, hnum, inet_ehashfn);
> -                       if (result)
> -                               return result;
> -
>                         result =3D sk;
>                         hiscore =3D score;
>                 }
>         }
>
> -       return result;
> +       if (!result)
> +               return NULL;
> +
> +       sk =3D inet_lookup_reuseport(net, result, skb, doff,
> +                                  saddr, sport, daddr, hnum, inet_ehashf=
n);
> +
> +       return sk ? sk : result;
>  }

IMHO, I don't see it as a bugfix. So can you elaborate on what the exact
side effect you're faced with is when the algorithm finally prefers
socket2 (without
this patch)?

AFAIK, the current approach breaks the initial design and might make
the whole lookup process take a longer time in certain cases like you menti=
oned.

Thanks,
Jason

