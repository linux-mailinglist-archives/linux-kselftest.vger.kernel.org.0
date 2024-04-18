Return-Path: <linux-kselftest+bounces-8340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8585D8A9DF3
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 17:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B89B2393C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 15:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D040616C68D;
	Thu, 18 Apr 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9rIHRet"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8AE16C685;
	Thu, 18 Apr 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452764; cv=none; b=Ui6vkDQnkTXM1eHQdLEJxg2mH40XxGo8w0qhu2374kOMPGul1FXRxEp0Yg0IoqIvlQmot2lj1diq5SPFC1+iHmgGcIDqNzhY1cpGajoE9r3gUpX3fe3DtoGefo4CNULCz28QECwlwFmhhWM8suzL10IeyawrbNo9hV+nj3q5E+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452764; c=relaxed/simple;
	bh=xz1KryzBkXPpCkiszO0fSTagmb1tt/fdTNZWOu6yhsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m0SZiiFeJUF4Ew7hJXAcGr2aRbesTNfGt+DJgAn65xypls6IATXhuV7X8ialIBgLJV5EjVBDOPoRnrlrQJT88TQ2tKskIIhNT0XP6dxaujzrjjbDygOkl2voCHY2xaCc1CyHiGU3CqXxcfok7wPXEUoKwPhGWcuIqdLuJ5quFxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9rIHRet; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34388753650so483273f8f.3;
        Thu, 18 Apr 2024 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713452761; x=1714057561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2e/V3U1UC9ugP6i7TU7zPmhluDvsy6sYXgqrEvEBwwY=;
        b=C9rIHRetxmzPQ3wkgHnWBQ/7ACNbIePWHIuyWPXrmziIMraePz5CFlRoyjogkH7XT3
         GhcaPkcuc76UJ4THGpz8ZjFqR1Ghc4einfCK/wdx1i5rOmjGVSz1ClUO8HVPa7lhDAwZ
         XVyjdQJ5Tg+JjbmNaKifCbXw3oehMgiGzaW/AwN/yG54Eng/GraFKl8hNhdli6z54Duf
         TM7xs/Y7WO6D1fzcgBK5EJp8AaW1l49pZsee3ck0KLlW6Lrvje9ukscGZaHnh++0A3Rr
         6QaAuP2Pik1fwyba0NF3JcXMLQlCj3GKuxfOZUnhBYaNo51hMH2i9hbRwwdh7tXPapjD
         DO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452761; x=1714057561;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2e/V3U1UC9ugP6i7TU7zPmhluDvsy6sYXgqrEvEBwwY=;
        b=Kj9DBCxnV+0Cn4H9EOA5fv4yj63x9M7NEeT5H64B0ITiDutS0zYFDU8pzKK74fT0KE
         UAqifrNW+/GaCDExHfkv0yAvmJpeWkq6bSuJUkR1nPn//AywMJfUi9hN55twVbQLjFm3
         73FLFtr70F9UOU/Oq5iGX+U3iqkhsJwMk2b6Q7R0j6mCfnCNx7TxWvcaztcOXHW3HtDO
         UkYz39Qr+J55hQOTgRYJ3kyJ3HSYoDLEUIgSZBSrmhpgbombNzFPiWL5tlpnthQWL378
         f6VWOgRo/je9Qf66Y1kC4UU2Fwo0rTadiyQkZ//vNinbQnkoLtQqNtl0uIUO3mJ+msex
         /4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi8Dn2N1e098oGm7evElCvhc1AeEP8U0B/kMDG3uCUG+zeknSTdGxfRDXX+RSNDbQ5TNOdgGlXELJJSsAWF8n4xu8hOksu9i8/8/bQynyrhCGF+4jY1o5ZXIMV6qK9/wpxSUIp6EawYkbLM5nEZboqR50+Sh0iNV42l3bCCbVCsvYm5QRk
X-Gm-Message-State: AOJu0Yw+niYiVhHjFVVl8Yc+iDHC29pD1XKwwFOEC1y1twCgGtuadT49
	3DxZi8uTZ4zH44CTGyXbOUeVN+D4SGK8QiXK89abKEltl7YxQJrd
X-Google-Smtp-Source: AGHT+IH+5mlTQpMMxVoyFt8D37CbaekJa0gy7uCGu59GilYj7x1ah3z0l5u9qwAxEJYwtfdM36z4Dg==
X-Received: by 2002:a05:6000:25b:b0:347:9bec:9ba3 with SMTP id m27-20020a056000025b00b003479bec9ba3mr1954606wrz.66.1713452761184;
        Thu, 18 Apr 2024 08:06:01 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id d4-20020a5d6dc4000000b00341ce80ea66sm2040456wrz.82.2024.04.18.08.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 08:06:00 -0700 (PDT)
Message-ID: <f4b10cc8-fdd9-4dd6-92c7-60acf66702e0@gmail.com>
Date: Thu, 18 Apr 2024 17:05:42 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
To: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 willemdebruijn.kernel@gmail.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240412155533.115507-1-richardbgobert@gmail.com>
 <20240412155533.115507-3-richardbgobert@gmail.com>
 <a36bf0b117f7786bbf028494d68185486025777d.camel@redhat.com>
 <469c26d112600bce3a7fe77131c62eae4ecae5d1.camel@redhat.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <469c26d112600bce3a7fe77131c62eae4ecae5d1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Paolo Abeni wrote:
> On Tue, 2024-04-16 at 11:21 +0200, Paolo Abeni wrote:
>> On Fri, 2024-04-12 at 17:55 +0200, Richard Gobert wrote:
>>> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
>>> iph->id, ...) against all packets in a loop. These flush checks are used
>>> currently in all tcp flows and in some UDP flows in GRO.
>>>
>>> These checks need to be done only once and only against the found p skb,
>>> since they only affect flush and not same_flow.
>>>
>>> Leveraging the previous commit in the series, in which correct network
>>> header offsets are saved for both outer and inner network headers -
>>> allowing these checks to be done only once, in tcp_gro_receive and
>>> udp_gro_receive_segment. As a result, NAPI_GRO_CB(p)->flush is not used at
>>> all. In addition, flush_id checks are more declarative and contained in
>>> inet_gro_flush, thus removing the need for flush_id in napi_gro_cb.
>>>
>>> This results in less parsing code for UDP flows and non-loop flush tests
>>> for TCP flows.
>>>
>>> To make sure results are not within noise range - I've made netfilter drop
>>> all TCP packets, and measured CPU performance in GRO (in this case GRO is
>>> responsible for about 50% of the CPU utilization).
>>>
>>> L3 flush/flush_id checks are not relevant to UDP connections where
>>> skb_gro_receive_list is called. The only code change relevant to this flow
>>> is inet_gro_receive. The rest of the code parsing this flow stays the
>>> same.
>>>
>>> All concurrent connections tested are with the same ip srcaddr and
>>> dstaddr.
>>>
>>> perf top while replaying 64 concurrent IP/UDP connections (UDP fwd flow):
>>> net-next:
>>>         3.03%  [kernel]  [k] inet_gro_receive
>>>
>>> patch applied:
>>>         2.78%  [kernel]  [k] inet_gro_receive
>>
>> Why there are no figures for
>> udp_gro_receive_segment()/gro_network_flush() here?
>>
>> Also you should be able to observer a very high amount of CPU usage by
>> GRO even with TCP with very high speed links, keeping the BH/GRO on a
>> CPU and the user-space/data copy on a different one (or using rx zero
>> copy).
> 
> To be more explicit: I think at least the above figures are required, 
> and I still fear the real gain in that case would range from zero to
> negative. 
> 

I wrote about it in the commit message in short, sorry if I wasn't clear
enough.

gro_network_flush is compiled in-line to both udp_gro_receive_segment and
tcp_gro_receive. udp_gro_receive_segment is compiled in-line to
udp_gro_receive.

The UDP numbers I posted are not relevant anymore after Willem and
Alexander's thread, after which we understood flush and flush_id should be
calculated for all UDP flows.

I can post new numbers for the UDP fwd path after implementing the correct
change. As for TCP - the numbers I posted stay the same.

You should note there is an increase in CPU utilization in tcp_gro_receive
because of the inline compilation of gro_network_flush. The numbers make
sense and show performance enhancement in the case I showed when both
inet_gro_receive and tcp_gro_receive are accounted for.

> If you can't do the TCP part of the testing, please provide at least
> the figures for a single UDP flow, that should give more indication WRT
> the result we can expect with TCP.
> 
> Note that GRO is used mainly by TCP and TCP packets with different
> src/dst port will land into different GRO hash buckets, having
> different RX hash.
> 
> That will happen even for UDP, at least for some (most?) nics include
> the UDP ports in the RX hash.
> 
> Thanks,
> 
> Paolo
> 

