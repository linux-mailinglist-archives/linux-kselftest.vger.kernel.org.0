Return-Path: <linux-kselftest+bounces-43519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C3FBEEEBD
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 02:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78B0F4E2958
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 00:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AA3B652;
	Mon, 20 Oct 2025 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdN8T2LH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3FB33F6
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760918420; cv=none; b=tc1quPrZiMOdRlLBdGX43/P4uo+9+VHhqsWQXrvRj0JwGeVb5sYbTN6QHhJe/xyIhwzOkyHxtzsy+bhmsiXAvphU0GOyAaoTe5BHPOu3okdOgOcgv/9PZQl0pxJhUWgtwsj051ThYotaTeBn7qnBVzLS/b/NfokcdSho0yN0pFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760918420; c=relaxed/simple;
	bh=ezMN77l/qcVaMgmJJ7bxGKgebH9Xy6zHK2EiL+Mja6g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M3P9WJS4Sa5TZAcDPWJdgyL05pBGLfbf9JKzL4JyAaeoTSj/1xu7FxLdUtyc71lTl21MHq3jRLhSn7jGg2Y0Hp/GXEiFQh3ytAGdN2Gr6E9zE/6oyN5weiJmlk95JXzreXPKMp1HqNL8I2GfD+CByaRuN5eH4HEawru7JuZw1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdN8T2LH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27c369f8986so37440945ad.3
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Oct 2025 17:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760918419; x=1761523219; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VaiAWLD4XNNKUuKlNpoWsuUt8QnNRZuGQMftj6fdN74=;
        b=kdN8T2LHmzKckBMEPGtkUkWjbogtRZAwPdlIHx57qD83musWmtd0xsxOSKzPMPL8do
         TnhzIB+vYpaFYF8BQRmmGF3KPqnaR77lQJCt64yhAypRca6ptgkqYdHpIxPhvaaaUA1F
         aCvySa+wsBaL7xrgZv00qyviGhIm+V7WxHWChnS44ZZuwoPn9Z+Rb6xoDs9hEXJMm4oI
         KRsyz1XYy3C03ZxwOjGUqCvxk3X4qsvXbX45ire5Hu/1eTS0NRg0JfYkSHMbiOnubiJH
         AXWwhJbp0eZx/6Ok2HIMTnaPgSlW477iMJ7sz2EEB5zEIADJ33l941LHqabfUdEI8OrZ
         pMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760918419; x=1761523219;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VaiAWLD4XNNKUuKlNpoWsuUt8QnNRZuGQMftj6fdN74=;
        b=mD9tDfl+9F1R7ksQ5XjEN2SK5D2a6PGSizTfrCKmSVGSkgqpO8nFtdi2DZFL45sC7h
         HZyYIHLPjGHOmUYRc8pYqx+GpxVFKe1dgZrE+vWDezmNqpgHHjt6Rt/BMLPz1zBcm+bt
         HzTenHOMq/vMIhCZ9fc/+ZIc/ZsEOG26SwaPiTKwmrKS1uTKCmR+ILSmjJWIavCpSwbp
         7W3Lckot8dTF5bmpKvmdU4BXwVn6EOatRxz/xiXND5iEldt0FPwIUQdTxU2A17YXJAEo
         3KDfoiYEfTlymh0f/WoHqqDIfT6UcvzzfHVXboEI8bRCHCcKF6V2BDQTaZ6bz0gFNo2V
         +46g==
X-Forwarded-Encrypted: i=1; AJvYcCVvgJtrNnrbKC6XRzupgKA18o1+CWDxvuEneNb4kDUuizIe+gu57JQPGYwLGu8KQYtM/JlIEaHTZWFnchzRwhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXF/fNyOoL/5IOXwGjn3OPtGMwaxUWNZai99bIv8UEo0QGuPUo
	mw9W/Xv1rq34igdPJFOFyV11WQG0+A5uIp6QpU9ZWXZ8bOcfrPzKRhaK
X-Gm-Gg: ASbGncvddv/u1E+xdi8H0GmHOXOy0t4cmRtkDgCzgjIuZ7auKk6oLS2kgzqOF7r6hhr
	XB5druvvg36/FOfqoL/w6T2MKWZ6TpVy77XvicIVeONGNBdQEoBO1qBjniGsd+SDVb6/3l0bWgj
	6FYt1FLe/2nbrqRd2wOB54kU57qAThlQCk1MfwzLsK9T02DQVzz/yuwykPnwUGfH0vq9mmQjjkR
	6LeE4QtovymhQS/tFcMpsHh04yB8mcB+c1nSlB3cs30FAizHyf10ey+fjwTNx2v/TdB0vCNxJIP
	Gv09bZs/b2oyk0Wi48Ah45/EyG11Is9nFDOoeMmQwiDmV8yNk7bsRQ3QpBl2JwPN/fBKth7OFBi
	AQ3qLh4YDYLA5qqNFJnUMMavrPVAy9iAhKcvDdV5EwcflJNkfEPJzzuwVS/33lV7k/Z6azQO+Cm
	MsTcWnr9vxsiT9BkEqMYTHaOe52Q==
X-Google-Smtp-Source: AGHT+IFcYo/fAegdA2C1gTxKem+CDCv348ZEZtfdFlF8lK+pytqmCXrWbosTkVJ1I3pvpi+J3kCQTA==
X-Received: by 2002:a17:903:98f:b0:277:3488:787e with SMTP id d9443c01a7336-290c9cf8e7fmr138965325ad.12.1760918418408;
        Sun, 19 Oct 2025 17:00:18 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdee2sm63726695ad.92.2025.10.19.17.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 17:00:18 -0700 (PDT)
Message-ID: <f0f97b8980fb141849861e67132dfffdfef4771a.camel@gmail.com>
Subject: Re: [PATCH net-next v6 1/2] net/tls: support setting the maximum
 payload size
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	 <corbet@lwn.net>, John Fastabend <john.fastabend@gmail.com>, Shuah Khan
	 <shuah@kernel.org>, syzbot@syzkaller.appspotmail.com
Date: Mon, 20 Oct 2025 10:00:11 +1000
In-Reply-To: <aPAjm1tKMKxIdUlj@krikkit>
References: <20251015015243.72259-2-wilfred.opensource@gmail.com>
	 <aPAjm1tKMKxIdUlj@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-16 at 00:43 +0200, Sabrina Dubroca wrote:
> 2025-10-15, 11:52:43 +1000, Wilfred Mallawa wrote:
> > diff --git a/Documentation/networking/tls.rst
> > b/Documentation/networking/tls.rst
> > index 36cc7afc2527..dabab17ab84a 100644
> > --- a/Documentation/networking/tls.rst
> > +++ b/Documentation/networking/tls.rst
> > @@ -280,6 +280,17 @@ If the record decrypted turns out to had been
> > padded or is not a data
> > =C2=A0record it will be decrypted again into a kernel buffer without
> > zero copy.
> > =C2=A0Such events are counted in the ``TlsDecryptRetry`` statistic.
> > =C2=A0
> > +TLS_TX_MAX_PAYLOAD_LEN
> > +~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Sets the maximum size for the plaintext of a protected record.
> > +
> > +When this option is set, the kernel enforces this limit on all
> > transmitted TLS
> > +records, ensuring no plaintext fragment exceeds the specified
> > size. This can be
> > +used to specify the TLS Record Size Limit [1].
>=20
> Since this is now "max payload" instead of directly the record size,
> we should probably add something to describe how to derive the value
> to pass to TLS_TX_MAX_PAYLOAD_LEN from the record size limit:
>=20
> =C2=A0=C2=A0=C2=A0 For TLS1.2, the record size limit can be used directly=
.
> =C2=A0=C2=A0=C2=A0 For TLS1.3, limit-1 should be passed, as the record si=
ze limit
> =C2=A0=C2=A0=C2=A0 includes 1B for the ContentType.
>=20
>=20
Good idea, I will add this on.
> And possibly mention that TLS1.3 record padding is currently
> unsupported, so whether it should be counted in the value passed via
> this setsockopt or not is undecided. (I'm not sure we need to go that
> far. Jakub, WDYT?)
>=20
>=20
> [...]
> > +static int do_tls_setsockopt_tx_payload_len(struct sock *sk,
> > sockptr_t optval,
> > +					=C2=A0=C2=A0=C2=A0 unsigned int optlen)
> > +{
> > +	struct tls_context *ctx =3D tls_get_ctx(sk);
> > +	struct tls_sw_context_tx *sw_ctx =3D tls_sw_ctx_tx(ctx);
> > +	u16 value;
> > +
> > +	if (sw_ctx && sw_ctx->open_rec)
> > +		return -EBUSY;
> > +
> > +	if (sockptr_is_null(optval) || optlen !=3D sizeof(value))
> > +		return -EINVAL;
> > +
> > +	if (copy_from_sockptr(&value, optval, sizeof(value)))
> > +		return -EFAULT;
> > +
> > +	if (value < TLS_MIN_RECORD_SIZE_LIM || value >
> > TLS_MAX_PAYLOAD_SIZE)
>=20
> For 1.3, should we allow TLS_MIN_RECORD_SIZE_LIM-1? The smallest
> valid
> record size limit (according to rfc8449) is 64
> (TLS_MIN_RECORD_SIZE_LIM), so after userspace subtracts 1 we would
> get
> TLS_MIN_RECORD_SIZE_LIM-1?
>=20
> (but this would bring back one "are we 1.2 or 1.3?" check :/)
Yeah I don't think there's a way around this...? I will update the
description to specify these details and add the limit checks. I do
think the payload size approach makes more sense, since, it could be
used for reasons other than just `record_size_limit`.

Regards,
Wilfred
>=20
> > +		return -EINVAL;
> > +
> > +	ctx->tx_max_payload_len =3D value;
> > +
> > +	return 0;
> > +}

