Return-Path: <linux-kselftest+bounces-5461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69CD8684C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 00:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDD6287832
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 23:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5713135A61;
	Mon, 26 Feb 2024 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="B6X5dYA3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D81135A45
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Feb 2024 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991522; cv=none; b=M8CwkdDTAueXK/MYfDY5vA+l+afBo/2fol+NLXAgD7ltf5OPo7GcbvAFqKwR7i5pnXXjWykdwatAWrVjBGeyni/72Zqb3HUhnIbeOwg/aCMMRBDErEDnrA0W2nzkW6aH8ngwDwseSUVNw4uS+2hjhNt3lQPZ7v+kipIDZqYAG7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991522; c=relaxed/simple;
	bh=8lUSqlHGMqI8I1r1rpRBEXkwRpZ7oqe4M8MCNf1etHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdwFaAn5sET2UmSuwGSGTdyBQwtnI4DIZS1WzHLkH8yGWg9M87h3z1+X2eYzHtDnHiwnKUJRnQ7zaaaPcBoNX0piKA8ubDLhZYXek9foBEE0+ShI0beaub26MaMMPA5Egovf2aokp8iJESbwzjrsqwYmG3Z7vDcnTpRxXO0Y238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=B6X5dYA3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dcafff3c50so8608075ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Feb 2024 15:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708991520; x=1709596320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyh7mdFRyjlmJV4fW69ox7tTTJCxGb5XPOBSz1bCTds=;
        b=B6X5dYA3THgOp6st2c8F6tAXMRD1omasU5NmLQgv59huRvDdk544qAzWwMS1+dkokV
         Z2aMZgwNAjX5NbwbNDjudPSys5kedeAn67NLAm8AUCM0jrckZ0l+qbSYUvrUy7EgkDc1
         TOKRoMdkJnZ1nULU19ChI3FxdQ1yCIvUUIjc9Sf9zqvpPqeKueHG6Msr1BgA/TDROXK+
         FpHCdJ4F8Fx36Zghr07QNGX+lIWpX4s2DX60dJ6guEdzK0K4MOXFdjTEn5Z6SMjGKwKE
         qtyQGv0gfJTnxbKY2JsIWQEu9aOSaYfXP5mcPPCh0JL2M0ddPbNtTS8wPMyZnqeGaCaU
         Hj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708991520; x=1709596320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyh7mdFRyjlmJV4fW69ox7tTTJCxGb5XPOBSz1bCTds=;
        b=VLrHId1b6eRRP9gL6VpyM3E4R0LVhFmfVDoDnkyM/vkk0xZGWjMIVFvaTuk9TJovQP
         6GUQoC9mrt2IgMSFxvEmBqSM6/4ab1DexHaQ7NKioVLmlKJMqswgPIXBz+v3ml+QU6kc
         pd667ReXbkofqp0CBMeqRh4XaDiMics70Ch0OqrRqe1P61r4WwYF5tmZwjZFKEli1PoP
         I9N2gCa72zMxYZxWVzhEf6iTl9RlTtR0tiL4YzmxkA+n8vnjJ//A38imakyFoXS9jAKx
         Tz6iCKeoGVkjIkSIWlz2n/yZ1MCTF1KBfe8oUMkC1PXrONSf6nziLe4vqaD/u6Xor0fc
         n0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMtqA8xCmXVmv2gB/XlJt5iKofAFZ3s7y+P+RLqClDS4xWADEq5tbxwoVuBC2tYwv9Wvl0vX9M+omJ0l1XNVfRzrv5VND4PUYrBW2T8K4f
X-Gm-Message-State: AOJu0YxYt0j6oxUKQ53RBmheadCyg9JAPTZ4f0lx/w0oiACqpahERMfc
	30Bm6cHVv3Rp8iKVvxcl8qa0Dx27wuJNO3IWBLsjhOukqEUzeuCCLCsBBjy/IVDSymxyBTcOYpW
	c7gC00xf2yH3l+mxkDBhV2ujnP5MZZQy9cHqA
X-Google-Smtp-Source: AGHT+IGcY9ko42XXIFbh54WiWMk6NMI+6vNUAaXKGgq93/tZ3zK1OHEtzgeAGptztw3FB17mOtXCnI7Z0xkxwMG3Vu8=
X-Received: by 2002:a17:902:ebc6:b0:1dc:83b3:99a6 with SMTP id
 p6-20020a170902ebc600b001dc83b399a6mr9032283plg.41.1708991520569; Mon, 26 Feb
 2024 15:52:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
 <20240224-tcp-ao-tracepoints-v1-3-15f31b7f30a7@arista.com> <20240226204142.GJ13129@kernel.org>
In-Reply-To: <20240226204142.GJ13129@kernel.org>
From: Dmitry Safonov <dima@arista.com>
Date: Mon, 26 Feb 2024 23:51:49 +0000
Message-ID: <CAGrbwDTDfkwf40cTkXh6QgQwPpsAVVLWENYH=_eko5tHCKC5VQ@mail.gmail.com>
Subject: Re: [PATCH net-next 03/10] net/tcp: Move tcp_inbound_hash() from headers
To: Simon Horman <horms@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 8:43=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Sat, Feb 24, 2024 at 09:04:11AM +0000, Dmitry Safonov wrote:
[..]
> > +     if (req) {
> > +             if (tcp_rsk_used_ao(req) !=3D !!aoh) {
> > +                     u8 keyid, rnext, maclen;
> > +
> > +                     if (aoh) {
> > +                             keyid =3D aoh->keyid;
> > +                             rnext =3D aoh->rnext_keyid;
> > +                             maclen =3D tcp_ao_hdr_maclen(aoh);
> > +                     } else {
> > +                             keyid =3D rnext =3D maclen =3D 0;
> > +                     }
>
> Hi Dmitry,
>
> it looks like keyid is set but otherwise unused.
>
> Flagged by W=3D1 builds with gcc-13 and clang-17.

Hi Simon,

Yeah, I think I didn't notice it when I was splitting the WIP patch.
It should be in the very next patch that uses them:
+                       trace_tcp_ao_handshake_failure(sk, skb, keyid,
rnext, maclen);

Thanks for the report, going to fix in v2,
             Dmitry

