Return-Path: <linux-kselftest+bounces-10125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 401958C39B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 02:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D4A1C20ADE
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 00:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C707489;
	Mon, 13 May 2024 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDxw1R3x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E733C9;
	Mon, 13 May 2024 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715561039; cv=none; b=OuWAlTS+oUhnfdFCBNfniueX9z3HnhPHAiV4eIcc33K3natY9gLbBbITc9tcCtnq1m817wwLRo2SjKU0KEDL7xKkvbHf4r9NMosUVZT0F4WlA5+UqgIdF3xkafplKvm7Y3o/aCWL3XSt0+3S6Yf2Ln916IFGqSTZYlGqsBwpLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715561039; c=relaxed/simple;
	bh=vlIl0kulMw4fEjKMTSq/sVG8/tbzC8r7gx6/iKJaVuM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YoR3YD7j+AVYdFHT7+2s4+u2ju6FvrepIa3aypsXEK4/TUxnoo5FAUtqVovzAqev0sxhRMoxa/DtfJI4SrZtG62arU40X7lKPiZkU22h1luFyHAg/i02m6xiZrSqsXhpFD/SqXBYYzrJF1q0UyfLCIQmMIOTVgCy+fhL48WTEHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDxw1R3x; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43de92e228aso22957241cf.1;
        Sun, 12 May 2024 17:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715561037; x=1716165837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPwkkwN0UIV1Umvsq0exeNGulyjzeLIValecFKr2KcE=;
        b=VDxw1R3x3gp32czo8P19KzwlQ9wOlEg7q8iKcnAYcEmK3moHWgUjj0VfiEIO81GM+J
         TUasSnkl52SEuZtk4XNx5bVhjlRYVtMgNNSLXiw2PUHMDPTwcvzEcWbppzra9O2dph7e
         ABRSa9jfvbS5qkR67VEAf5v704NT48aLwnM7GQxg6ViDQd5onFH505ndkAxG0MuX9Qt+
         14GZjmEzuERM9SyslH2yY2ZL0xxB+ygryR8b51n4ThgrrgTKbC/Rvd70jPzte5otgMza
         D6KlyZrcr2/01EpusclxU+NUulMpKMMu0QjxjV7Ys34ypc9r6PXD3M5dHfj51zGkqaVR
         cYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715561037; x=1716165837;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KPwkkwN0UIV1Umvsq0exeNGulyjzeLIValecFKr2KcE=;
        b=sIWzsciKafUH+XeprlkSixm8h0GHAbnv0zoA0sVarUa60INCDiLEvpW62RUBRb/oCK
         YL+D1fQEfaQg0i9LsZxlX7SOuc2aqNbYoJGwwv5HGqIKaNGOdB90/NGiD2cL1UrYCTWC
         HI1MrYj6Wb/wfY5zVoECmGZLFc5aLNAun439HKdBh5xf/iebnv08Ic6IV7Nl4Us8nc3E
         Pfk3FXfNHxm44f3PHsaB/xrZ2EwdlP2tzytmDkkR+GhzzcOnVfqQPlDduSVSRCKEhfJE
         n5PzAI+7XvTDBPOQRqYfnTQ9nk//5dXyzpYdRyEnd/EbYeJPYUq/12Rm2Fouef3djifg
         Ob3A==
X-Forwarded-Encrypted: i=1; AJvYcCV2FwY0jskGWLv0k4MikjlJwYu9Y/5OPsMj6xj+/pHrPvNWpdmU0tkulNZgX9pyttuYVaKih/EB73DXAH76pMHb6Cb2h2nDYbPFsg+A+wgkgNfw7arMfdNSh3hCYCfKrtA3I7mpFn28saxjtBPEwfcIKS4yILJMOzQvMgqfl70ilDf0EBwd
X-Gm-Message-State: AOJu0YxS5fhEzVhV5Y/ziwT+iUA72rGkFMrmM/hvpsLEi72vAl5TMVjy
	s7ZCLPLhljkPJHea4BWNrhl76mUUIJ6Va0gp+dl9Sia7+6ah/DMa
X-Google-Smtp-Source: AGHT+IGijc+DzcJ9t7qm/HSNQ/VAtUc3a0cXqCzrN05V/OF3XJI2vZLoxINyBUg8LGGKtlhiPSnC+A==
X-Received: by 2002:a05:622a:148c:b0:43d:f9ca:4f44 with SMTP id d75a77b69052e-43dfdac3958mr115940761cf.13.1715561036801;
        Sun, 12 May 2024 17:43:56 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e0bf64844sm22131141cf.62.2024.05.12.17.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 17:43:56 -0700 (PDT)
Date: Sun, 12 May 2024 20:43:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 dsahern@kernel.org, 
 alexander.duyck@gmail.com, 
 shuah@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Message-ID: <6641624c54b46_1d6c6729483@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240509190819.2985-3-richardbgobert@gmail.com>
References: <20240509190819.2985-1-richardbgobert@gmail.com>
 <20240509190819.2985-3-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v10 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
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
> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> iph->id, ...) against all packets in a loop. These flush checks are used in
> all merging UDP and TCP flows.
> 
> These checks need to be done only once and only against the found p skb,
> since they only affect flush and not same_flow.
> 
> This patch leverages correct network header offsets from the cb for both
> outer and inner network headers - allowing these checks to be done only
> once, in tcp_gro_receive and udp_gro_receive_segment. As a result,
> NAPI_GRO_CB(p)->flush is not used at all. In addition, flush_id checks are
> more declarative and contained in inet_gro_flush, thus removing the need
> for flush_id in napi_gro_cb.
> 
> This results in less parsing code for non-loop flush tests for TCP and UDP
> flows.
> 
> To make sure results are not within noise range - I've made netfilter drop
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
> perf top while replaying 64 parallel IP/IP/TCP streams merging in GRO (same
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

Reviewed-by: Willem de Bruijn <willemb@google.com>

