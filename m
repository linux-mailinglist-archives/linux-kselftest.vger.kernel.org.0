Return-Path: <linux-kselftest+bounces-41800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7948B82E6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 06:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D39D16E620
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 04:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2CF258ED5;
	Thu, 18 Sep 2025 04:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c4l3eKoY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BAF23909F
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 04:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170876; cv=none; b=Z3v6pdqPFeH2gUtGdPSLiMIgcekYLkkGiLaAeVoKMNcNo1U3U9sLlHApKu+iwVuyMVB6sAvLllRKWgIZ8WOKawvtXZucdXR7VYnQwWx8Ntb562LBPQgHWkyBfdlrHpyOVaBVs0/d45v6+wi1RMAsksFx49/1Kcu/EcoZxa1RPhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170876; c=relaxed/simple;
	bh=/EotVPQ2fazO+q333eMMFjQICAKBRdVhGAXoakK7FcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKrMcIZm+8gB2IxFASb8vpMBeoUyyStIbZKkdVWkb9koCI/srF2sekY8711zN5cfi4rZciaEXz1znw7qlm0aKkP68xZFSAuN8pGFeLBBFnrMGOUbCswJkHneiwT3j2yOtRUkDF0kaqUFP4N4kAgkHcQR00kQde2XIbZBQA03i0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c4l3eKoY; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-81076e81aabso56621285a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 21:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758170873; x=1758775673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icm0Mx0uEIZ2AHKvNR5F63qVMXOP8j6zMjtxQgp3SWU=;
        b=c4l3eKoYjuDmUAFTsSr1mDFjNG/4EseR6OrYvrDeqeDrqt9Uk4Mj0CDVdH6kyTThpr
         4kMFlv1sxJNhLq6m0tOx19k9N9jTUuF9h3DZJtn2MkpXvxLIyKIXS5oimXB4CUQiLNhx
         VDZbJous2PRdOGps36gRUTTuRwqbg94l3tZOBSB/E34rJ/TXJ6QnjkVlAsvoUY0UhSs/
         tJsf/9rS0XG3GnOH2bwcHO1sQMEsaT/V+6Nt+WLsRUkhAiucb7rRzxuaNgv28b8/FPyE
         bTnRNF3ifIIcJexJHPD/Nu4FainRaoW+gL/iVp9Bicz+oS4YIWoQ69fRlDbowOIG4anF
         BSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758170873; x=1758775673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icm0Mx0uEIZ2AHKvNR5F63qVMXOP8j6zMjtxQgp3SWU=;
        b=XVxUh27oOrAcrUwP8BLZm4cHDR34G4eBzRl5SSsVdK4KSvgeuN+eSHEik0YgN+9kxV
         VIX6KTszdvbYdq1dKlw98sbeSmaVblezid45lbzJaSkMvp9HA3YHEp8oWVa1P37zHJMo
         /V3HmdY3LoDNyO0IFX8avbdf5MpPll2/bhFtslZUx/MSaZcvDVB0Sn8MyzAWeHuABKJ6
         NLT8jxmnE39mYLg8SzL+wcW/wQvrVn/5ODB3V4dWFZMH6x4cjoAYMY7NglwRXaoLu+bZ
         iJcEM5MtQsNV33jul1VLS74MAnytFtaT+AJdrE4zwb43HD3B+dkK4I5agD+MH6ziaImN
         1VSA==
X-Forwarded-Encrypted: i=1; AJvYcCUPGMVEoiHZ1zP9Ne+asebtcIJer57T+zCW1AuVy2LLwdMeALfLaifrE21LTpLXW6AGqMy8ouoJzbauOFjTr4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfp1Zz4UvHJEsEe0E8DJbvBcZHOsxNFrwZG9HNwiHu4eQiDtRM
	whFuiq00zHWEscd56OjTB4OO1z/b1n0wxuNMYavEHtYk4mIVVMBRZdiWmNXzzU/51UXDWU/5yiN
	g3A7fapHwNUANnUOhWNo/QMIfQ6aaZjmUak9TxOdq
X-Gm-Gg: ASbGncu7fDdUlNQ3ruvUcIk2MhcCLxOSQ9E9L7+w4FZpozplKfFZuiY82EYJJmtYqHv
	Fku1BXBj2rUM0XtTTjcLFbsHH6b4jVoEdjsWd7KHyt+xVYbCRQM7E2yN9vOhFiaoCHj96/TjVUG
	AtDRknNcejebkPD/awg1ebAOLSmDzLueSSvdD9LW+4EYfrxxHBY1L894RTv+FLPDnK1eY80dMiu
	2uTWWmAxmhLfXGxnYdPulhC2IkPo0oC
X-Google-Smtp-Source: AGHT+IEE3vW50mN+g7sjB3JgnHPpFDaaYz8tXLvVhOdGDaDQ1ipJAp2C5Ss5TYurb7YYRKBrUGBk9/H1VW7xYygqNI8=
X-Received: by 2002:a05:620a:710c:b0:80b:b8aa:5c44 with SMTP id
 af79cd13be357-8311334b681mr607648285a.39.1758170872886; Wed, 17 Sep 2025
 21:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com> <20250916082434.100722-9-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250916082434.100722-9-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 21:47:41 -0700
X-Gm-Features: AS18NWDnsTzobqovaqJgXSNsHC41dTN6DzbIFMvP6OalmtSpwFDjRSKr7Mn4RAo
Message-ID: <CANn89iK9Ro517nbmNTRfOr3q5-T7iuJUN1QXU2p_5CWKE1aprw@mail.gmail.com>
Subject: Re: [PATCH v19 net-next 08/10] tcp: accecn: AccECN option failure handling
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 1:25=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> AccECN option may fail in various way, handle these:
> - Attempt to negotiate the use of AccECN on the 1st retransmitted SYN
>         - From the 2nd retransmitted SYN, stop AccECN negotiation
> - Remove option from SYN/ACK rexmits to handle blackholes
> - If no option arrives in SYN/ACK, assume Option is not usable
>         - If an option arrives later, re-enabled
> - If option is zeroed, disable AccECN option processing
>
> This patch use existing padding bits in tcp_request_sock and
> holes in tcp_sock without increasing the size.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

