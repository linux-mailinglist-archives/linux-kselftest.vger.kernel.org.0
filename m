Return-Path: <linux-kselftest+bounces-6634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523E188C664
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 16:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8A1B259F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 15:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3013C69A;
	Tue, 26 Mar 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecLQ4xF6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEBD13C67E;
	Tue, 26 Mar 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465841; cv=none; b=greEap8CabneL7FU2u0KgbF7siFJHhicyIJSmyNtACF3qLlESXbupmS4XcQSTcfflfwxGWpIOAgXL+3C6X3cntbvrpyQD3iPVBCHStDHR1kMIFzDJQ7KTsKmqmrN8lHN3RZtbqEgdAdadcD759zc4HVxGzlSA6OgD8kwsf5txbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465841; c=relaxed/simple;
	bh=mzJombKbEWRKDl6OlPgaMOZIIcKPzrlFoWruizKqFJA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pAOas2itF9APnkL58k+dY5vCCqFmWy1M1YrSpuEE/gCEbgqp03Pag9kAiRnV6PzLswBvUvuIzeB8t+FATEXQ9syLCNv+cR2OVHNm3/CALJyqCwnUOcolD0vMZbb8HqV9iz0f49oyAq9wyw1zI+CY+nT8kB9nXQuawD957s5Y/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecLQ4xF6; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-430c45ab240so32898481cf.0;
        Tue, 26 Mar 2024 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711465838; x=1712070638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgboSOXSaJN+npjxRR5//kw9dc8gv3PuHBnyX+Oqs3c=;
        b=ecLQ4xF6eEwC8koQ1SQ2hCwD9jVnXRAj8q6G5FbjDZkJqxZOTWjFRnddLg1DJD1nwJ
         XxkcfRHd1HbGBrnbC3lfEXEuV9K+XVwvfiToAFap3FlVqlC8iMgJO9mhLEb/Dqa4pJGo
         WrrAIklrX2FMLSFcB1CuasOFMlN7Q4V/lXJ1QV274uSz2ZHMgKJAK7CZggcAAeJzTyUM
         rbjRq4+ukFsSWGsq/Blp/lQiKdmYlIuMzRZw41URfXxMG9sgQT8TqYy0tfIL0P1YioYR
         zfI54xL5Ab44mJg+zUa6kdbi6OWhVEPrg+i60Xw37uTB/bkuuxJt2aUrjKazfVznjv1o
         uz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711465838; x=1712070638;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xgboSOXSaJN+npjxRR5//kw9dc8gv3PuHBnyX+Oqs3c=;
        b=TBDygXdMtAuCe59P/itShaH9CsZJcY/88XWojcvSPfIdDZJbV7b0w/+uxetWoRhlB7
         P09C+zbRyAHMO7N6z7AUpeZPVA565Dwfgrw43rv0DphOI6UlavbVs72WmSla68BbeejH
         IBQJdRA5MXQCQJIK/Echt3vv+4T96zWq3pVMKUz3JxGTTtKtSkoTRKKF7CNjAuB1uZin
         uMAXr1vl93wZbfM4CE2lWVaJ76Vdw3bidPyCsFNZUeDhPFC5I7AYeJCwbEXeQ/5KFnno
         SuHWb0q+OYI1Ha5MA7nmHCXMTqbUkZD7Iotfv2/kUULEbZxePSdEEd1s6xksdbPzObSj
         5zVA==
X-Forwarded-Encrypted: i=1; AJvYcCVj8q8br4tfy8E+5zMYTdV2mROCcNVYTlpES4Ej8EAKDYVTr5EL6iitM8gI07O8smPwm9a/knA7qNKkk/usI2LZZMgLdCScFzPJWTwYPGie7mOkCxv9h9GUgdtfRESo/E+fJRg0WauaVv4/3/sNys7cDNmF5pk9cF861BP/jeLYE4KqENCc
X-Gm-Message-State: AOJu0YyypI3dRWkWoqskYm1RLrnKtYOHhBFOpOHErn0NAhaGMvfRp4wl
	+SQ/yRHH+ZHlgC/ObVqj6Hq3blSZ6IOkDI+eIi8qXGIl0IeANyrg
X-Google-Smtp-Source: AGHT+IGzyx0zvMcRf1q9UjiligTtpy6suyD4CI7inXc9cNeFIiGqNvE8sABz/EuQAAZd4VFfuUvzwA==
X-Received: by 2002:a05:622a:283:b0:431:23c8:7aa3 with SMTP id z3-20020a05622a028300b0043123c87aa3mr1433295qtw.13.1711465837959;
        Tue, 26 Mar 2024 08:10:37 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id hz2-20020a05622a678200b004313b7cf2c7sm3708208qtb.39.2024.03.26.08.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:10:37 -0700 (PDT)
Date: Tue, 26 Mar 2024 11:10:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <6602e56d7a02c_1408f429432@willemb.c.googlers.com.notmuch>
In-Reply-To: <6566fd5f-fcdf-4dc7-b8a2-5e8a182f8c49@gmail.com>
References: <20240325182543.87683-1-richardbgobert@gmail.com>
 <20240325182543.87683-5-richardbgobert@gmail.com>
 <CANn89iKzeTKuBA3NL0DQUmUHmmc0QzZ0X62DUarZ2Q7cKRZvSA@mail.gmail.com>
 <46e0c775-91e7-4bf6-88f3-53ab5e00414f@gmail.com>
 <CANn89iJkDbzLKmUGRHNFpfiaO8z19i44qgqkBA9Updt4QsRkyg@mail.gmail.com>
 <6566fd5f-fcdf-4dc7-b8a2-5e8a182f8c49@gmail.com>
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Eric Dumazet wrote:
> > 
> > I do not understand this patch 4/4 then.
> > 
> > Why bother moving stuff in net/ipv4/tcp_offload.c if we plan to move
> > it back to where it belongs ?
> 
> Willem also pointed that out, and I agree. I'll post a v5 and move this
> functionality to gro.c. Currently, gro_network_flush will be called from
> tcp_gro_receive and in a separate series I'll fix the bug by calling
> gro_network_flush in skb_gro_receive or adding it to
> udp_gro_receive_segment - whichever is better.
> 
> This patch is meaningful by itself - removing checks against non-relevant
> packets and making the flush/flush_id checks in a single place.

One issue: if the do this move in net/next, then a later fix that
relies on it cannot be backporter to older stable kernels.


