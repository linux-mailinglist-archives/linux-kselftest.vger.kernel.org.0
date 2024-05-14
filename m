Return-Path: <linux-kselftest+bounces-10173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3EE8C55DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 14:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6495FB20CA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 12:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52743D971;
	Tue, 14 May 2024 12:13:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE62B9B3;
	Tue, 14 May 2024 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688818; cv=none; b=uNxfx0ETSw/HIwLM5kJxg2gML+qm/UwazClxYSHH0ZI/MhO7xjchQHyYKS1YfjFGg7ZDJtIfgX+nZj80fr9N4orM8Qc4Tky5p/eWqKZUUQVnyiM+u5/HHhOGwe/lue76agY4G9ZIL3AQnq3t7CL7OAop/NheXLXX9rkV4wMoya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688818; c=relaxed/simple;
	bh=SAh86WZuy+3Mi3t0E3g4MD/8KNjqtP5jCPGaQVvTfX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bwli8T/DyS3PpYEWtTdhCW7Zlc1k6OFFTMW8Fd5eCDvx0hdiA8IVTq8aLONqBYXJbCb3E0IiHsHJtJAJ+7zEDsu5kEXLTiLTdDTCje3JdrSvZTng/vBcIsPeJClkuFAy9M93gYk0N+qE+t+5ODEyTjyLT/5E6t6nHyDGqPtR1oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-deb654482bcso6030947276.1;
        Tue, 14 May 2024 05:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715688815; x=1716293615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R64lFTR0r2luFzeMpjygmzdIkrGNpnnAqlD2Bb/1onQ=;
        b=N/58GmANb0iSN84gfsjWf1S/hrF7kM/woxs5ZCz6xUQgaGvwr8IpsXs+WksS5JIqHt
         W4MN8Qrlo/sWiKSd8OGzUncFfPsIPXS1wUiXH1BsW6yfW3Wd3RfTHrKAsCZrvHOVWjkh
         nauzUN5aiNWTAfrWd7TOrbT8EBkzNpq7YnnUIU7wc/XZ1OqPoGj7tH7brSrXo0zsbsxz
         uzC4uaDEit0BzBVOkhEfR67pCP1iCgUznD/57jEW2ywiVTLojS8RAqzD/8/UQ0zdlmqn
         R8dq0eKVMdnZfKltoXUUAkeUAvTOrV3Pfywf8tfo92XMuEZ3KX2m+0LGYE1j0/ynU7JY
         01Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXFqxN+TkNdkuOVhrrpXhVaqg1KWb1XuJTgR+6Qv0L1uBRf+Eh9Ajb18Q7D0aYRQSwWT4KsimzPZee5TtzMdmGXNoLmoRc7j6WPe809Ng017fatPR0czArYjCGnRZ1e4TjK5iqB6TEsOvfAvFZhT1VSEzi0ufOcjN3kFGrDGwfDZQlTGZHY
X-Gm-Message-State: AOJu0YxkQuBODXrOXrdTDgV/D3un+itsvSnxG3xPNLeNG5CNuyHF7eXv
	lDp+Zw0tzoS4ceOG9vVHDvf6cPiwnCiiM9A3KZzj6WVKM+5VjxD2WfFZzg0r
X-Google-Smtp-Source: AGHT+IG/l/g+rKVKvvSz6FBGWRMFLxdNjCBrQXGJwAnbHYnoawB5VgVytZPinpgvuT1laWfHRTJB1g==
X-Received: by 2002:a25:d607:0:b0:de5:5a17:de9f with SMTP id 3f1490d57ef6-dee4f1b7853mr12150118276.13.1715688815023;
        Tue, 14 May 2024 05:13:35 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd34fde87sm2549076276.0.2024.05.14.05.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 05:13:34 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61be4b986aaso61981357b3.3;
        Tue, 14 May 2024 05:13:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbkmmAiu0Z6xXBEiUFOdKYaiOAUxQ3D3pQt6L3I2/lUGVgrY+lqPg0tb8Kbh0KwzDzOhs9KOS+XzpAtibphVmBP61yKrua9ZVAJ5hpHCM0jBbKuu2e7kVEAROgmv17WS4AUSPtHawXA4Ot6KCvilykmojps01k57fpnXCoXsBnPbnmVU8Q
X-Received: by 2002:a0d:d44d:0:b0:61a:cb67:9d0d with SMTP id
 00721157ae682-622affdc8a1mr124948897b3.22.1715688814234; Tue, 14 May 2024
 05:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509190819.2985-1-richardbgobert@gmail.com> <20240509190819.2985-3-richardbgobert@gmail.com>
In-Reply-To: <20240509190819.2985-3-richardbgobert@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 May 2024 14:13:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXFJwxexojG+41ppD=2EmyXsVM6bwh+-cxCxfSsM_yJiw@mail.gmail.com>
Message-ID: <CAMuHMdXFJwxexojG+41ppD=2EmyXsVM6bwh+-cxCxfSsM_yJiw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com, dsahern@kernel.org, 
	alexander.duyck@gmail.com, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Thu, May 9, 2024 at 9:09=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
.com> wrote:
> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> iph->id, ...) against all packets in a loop. These flush checks are used =
in
> all merging UDP and TCP flows.
>
> These checks need to be done only once and only against the found p skb,
> since they only affect flush and not same_flow.
>
> This patch leverages correct network header offsets from the cb for both
> outer and inner network headers - allowing these checks to be done only
> once, in tcp_gro_receive and udp_gro_receive_segment. As a result,
> NAPI_GRO_CB(p)->flush is not used at all. In addition, flush_id checks ar=
e
> more declarative and contained in inet_gro_flush, thus removing the need
> for flush_id in napi_gro_cb.
>
> This results in less parsing code for non-loop flush tests for TCP and UD=
P
> flows.
>
> To make sure results are not within noise range - I've made netfilter dro=
p
> all TCP packets, and measured CPU performance in GRO (in this case GRO is
> responsible for about 50% of the CPU utilization).
>
> perf top while replaying 64 parallel IP/TCP streams merging in GRO:
> (gro_receive_network_flush is compiled inline to tcp_gro_receive)
> net-next:
>         6.94% [kernel] [k] inet_gro_receive
>         3.02% [kernel] [k] tcp_gro_receive
>
> patch applied:
>         4.27% [kernel] [k] tcp_gro_receive
>         4.22% [kernel] [k] inet_gro_receive
>
> perf top while replaying 64 parallel IP/IP/TCP streams merging in GRO (sa=
me
> results for any encapsulation, in this case inet_gro_receive is top
> offender in net-next)
> net-next:
>         10.09% [kernel] [k] inet_gro_receive
>         2.08% [kernel] [k] tcp_gro_receive
>
> patch applied:
>         6.97% [kernel] [k] inet_gro_receive
>         3.68% [kernel] [k] tcp_gro_receive
>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Thanks for your patch, which is now commit 4b0ebbca3e167976 ("net: gro:
move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment")
in net-next/main (next-20240514).

noreply@ellerman.id.au reports build failures on m68k, e.g.
http://kisskb.ellerman.id.au/kisskb/buildresult/15168903/

    net/core/gro.c: In function =E2=80=98dev_gro_receive=E2=80=99:
    ././include/linux/compiler_types.h:460:38: error: call to
=E2=80=98__compiletime_assert_654=E2=80=99 declared with attribute error: B=
UILD_BUG_ON
failed: !IS_ALIGNED(offsetof(struct napi_gro_cb, zeroed), sizeof(u32))

> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -36,15 +36,15 @@ struct napi_gro_cb {
>         /* This is non-zero if the packet cannot be merged with the new s=
kb. */
>         u16     flush;
>
> -       /* Save the IP ID here and check when we get to the transport lay=
er */
> -       u16     flush_id;
> -
>         /* Number of segments aggregated. */
>         u16     count;
>
>         /* Used in ipv6_gro_receive() and foo-over-udp and esp-in-udp */
>         u16     proto;

On most architectures, there is now a hole of 2 bytes here.
However, on m68k the minimum alignment of __wsum (__u32) below is 2,
hence there is no hole, breaking the assertion.

Probably you just want to make this explicit, by adding

    u16 pad;

here.

>
> +       /* used to support CHECKSUM_COMPLETE for tunneling protocols */
> +       __wsum  csum;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

