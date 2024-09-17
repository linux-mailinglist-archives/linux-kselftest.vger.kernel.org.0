Return-Path: <linux-kselftest+bounces-18085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E781797B294
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 18:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEEC1F23FE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 16:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C1217C7A5;
	Tue, 17 Sep 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PrtR+7V3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57772177998
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Sep 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589042; cv=none; b=GZBDFBLVUlExxUZowcCqgu4cZM7q27hcWu4voQu4X55YUDqxmOwNjQjYzf1qViq/e/zTrIs7YZl0SCvpAiPEtOv/AMOLcyW5UIwq5WzWUrE9GZlLb+PQEPL89zoalHOwp2REV7pIQkj9NaixTznqnANaUKSsQGG5ANVrKzdzO9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589042; c=relaxed/simple;
	bh=0PuAepZP1sMeQLDW26baLJXMCFGkoiK4j9E2aYYgQd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnUQ6dA9CIs5MnxI8cY4oMZJC2VGYHKB/HVX3LqnKyaZ6ori1K4Ck1S1Eb4e1w8g3EsgZBdoKvQxaL20JEZb3MHna/S/JU5TREgwlGJ40YbEiNiJMnAVfmEPgG1qggLZ04YOhzL4C8GqYpV0UAfsAQNWbwSDjkZGJ5hr15sFdMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PrtR+7V3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374c7d14191so4291033f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Sep 2024 09:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1726589039; x=1727193839; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LUR6P1shZ3CKhHBcBU/pF/r4AHgnylMjyz2ZEJJwzZ8=;
        b=PrtR+7V36+bdtIYbt8jGPfg4Fq8iv+OgbBEi38aTn4D6RkH8DfhftzDB2cEtbAE4ax
         +k/jjCPCysCZPACbPQfJBy/p6p4u6rvCvei6iQ3EVOPEvXyzVVaVz71FEWm3sCScFnRq
         rrMzAydd9aMzjGYlV2SCdhl1yzLnq4mMpnbBXzQC2E0nSq390cWSzGaw/Pup4STv8id+
         +bwAVT7NVtcm/vckPd8eDZI6CJDtErwEpleVN0wcLp3BTPKYRT09KntmcI53BepXUSLX
         5YXwB3WDlcOefY/LxhzP292n8RHzX+cYfj/GNqcuuUOY9C62/q6yrSLbVSU+fcBeI6zU
         la2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726589039; x=1727193839;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUR6P1shZ3CKhHBcBU/pF/r4AHgnylMjyz2ZEJJwzZ8=;
        b=H174wfcveHwBz0HvSgVkC141kb5OisHj2M1e/his7eNogQ3kOKx4IBKcOFK98by+27
         1RljTun7F2J3JN8VQz4zQWKnhRGOQ1qmRU+pLieoHoa7JwSHWFm0LlXYgT+7nDJkAHnT
         txCJ+DhJCv2HIjaxuYWnpKvpE0z2AtDAtWEWaEfl+4g3RnojkylR9MST2Az3QQ/SCSne
         DaAqIxAYortXwmHDL0Q4OBh8zNDvNFtVy+R2E+w1jj1zzhA/lBbn7f0bnS1mdvCsbw2L
         zGL+0VXbNHq1F0q9iDhUATZqKUjc5m9tTAg3bls5P9+u6xNPPj8uCD1gD5HygZRhigXa
         izqg==
X-Forwarded-Encrypted: i=1; AJvYcCWr7qahGKQoSctxOpztlBI3L+k56QBneYDLMOi52SASydHhYmiCpHG425LndNojOY2EDoyVqQHQAUYzW1IcC64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66aKgAd3yh9BZiAlkjVnrkVK/eE8W6RgiOikTAsxkfL1urtYn
	pqQA/r/WDKd9Hu7J8nWx+IX7Z6FwG1Mm6KQI2HjohSU7K1s9L5+8yUc/wmTimcs=
X-Google-Smtp-Source: AGHT+IELMxfdNDwf5iSZU7vWhaPPmOrDY6BB7npKjG6qP2MIc5qwafIMfPL8kaxPB51/BUhX9+hYJA==
X-Received: by 2002:a5d:4d0e:0:b0:374:cc89:174b with SMTP id ffacd0b85a97d-378a89e6471mr15397653f8f.4.1726589038490;
        Tue, 17 Sep 2024 09:03:58 -0700 (PDT)
Received: from GHGHG14 ([2a09:bac5:50ca:432::6b:83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22e733bsm106395475e9.22.2024.09.17.09.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 09:03:58 -0700 (PDT)
Date: Tue, 17 Sep 2024 17:03:54 +0100
From: Tiago Lam <tiagolam@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>, kernel-team@cloudflare.com
Subject: Re: [RFC PATCH 2/3] ipv6: Run a reverse sk_lookup on sendmsg.
Message-ID: <ZumoapFx+iLeCFZ0@GHGHG14>
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
 <20240913-reverse-sk-lookup-v1-2-e721ea003d4c@cloudflare.com>
 <CANn89iLE8zgX2U5+3YmBoPgsDAV8xGOcfZcd7Pzd_4MSFs64BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLE8zgX2U5+3YmBoPgsDAV8xGOcfZcd7Pzd_4MSFs64BA@mail.gmail.com>

On Sat, Sep 14, 2024 at 01:40:25PM +0200, Eric Dumazet wrote:
> On Fri, Sep 13, 2024 at 11:39 AM Tiago Lam <tiagolam@cloudflare.com> wrote:
> >
> > This follows the same rationale provided for the ipv4 counterpart, where
> > it now runs a reverse socket lookup when source addresses and/or ports
> > are changed, on sendmsg, to check whether egress traffic should be
> > allowed to go through or not.
> >
> > As with ipv4, the ipv6 sendmsg path is also extended here to support the
> > IPV6_ORIGDSTADDR ancilliary message to be able to specify a source
> > address/port.
> >
> > Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
> > ---
> >  net/ipv6/datagram.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  net/ipv6/udp.c      |  8 ++++--
> >  2 files changed, 82 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> > index fff78496803d..4214dda1c320 100644
> > --- a/net/ipv6/datagram.c
> > +++ b/net/ipv6/datagram.c
> > @@ -756,6 +756,27 @@ void ip6_datagram_recv_ctl(struct sock *sk, struct msghdr *msg,
> >  }
> >  EXPORT_SYMBOL_GPL(ip6_datagram_recv_ctl);
> >
> > +static inline bool reverse_sk_lookup(struct flowi6 *fl6, struct sock *sk,
> > +                                    struct in6_addr *saddr, __be16 sport)
> > +{
> > +       if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
> > +           (saddr && sport) &&
> > +           (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, saddr) || inet_sk(sk)->inet_sport != sport)) {
> > +               struct sock *sk_egress;
> > +
> > +               bpf_sk_lookup_run_v6(sock_net(sk), IPPROTO_UDP, &fl6->daddr, fl6->fl6_dport,
> > +                                    saddr, ntohs(sport), 0, &sk_egress);
> > +               if (!IS_ERR_OR_NULL(sk_egress) &&
> > +                   atomic64_read(&sk_egress->sk_cookie) == atomic64_read(&sk->sk_cookie))
> 
> I do not understand this.
> 
> 1) sk_cookie is not always initialized. It is done on demand, when/if
> __sock_gen_cookie() was called.
> 
> 2) if sk1 and sk2 share the same sk_cookie, then sk1 == sk2 ???
> 
> So why not simply testing sk_egress == sk ?
> 

Oh, yes, you're right. I'll include this in my next revision, thanks.

