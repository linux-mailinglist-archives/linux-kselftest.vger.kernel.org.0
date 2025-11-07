Return-Path: <linux-kselftest+bounces-45146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A071DC41794
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 20:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293481891D9A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 19:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC1A307AFC;
	Fri,  7 Nov 2025 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEQrSQBT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E55D32779A
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762544950; cv=none; b=ua8wMt5KS379leyzFwK0Pr0q158Pf9KhhtIobl949LcTVUEKX25jfzt3QbzCtepTBAbox5ywrY6wZvHFZFgpljdftMXh79AnOy53TkFUwdImoJ9f+wKmCoqpXhkatHZLOLgdn6McXDNiBauXyKPZJHtp0CV+Gzaoipjyf0TZS5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762544950; c=relaxed/simple;
	bh=J4wZUvXi7BlP1+Ww/G+19x0mF6vC2xky7wV/+fkku8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7yx9WNM5okoFyRpyQ7Nvmy79Zh/kMeYp02lDHHCEXYS7xgv54U1G2Fhd9RLme7e8et7uJVZEms+S2n4xggRaO9OGBO52+S7OPdslafAcWI5yNelwAyQuPLt2tslmJmXRq0HbgtvwvXmLT+OTnBTsgYVrzopNoYOf+xNPV77zrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEQrSQBT; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-640d264dbfeso42184d50.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 11:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762544948; x=1763149748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpMh/mSxXtjLHlF/+Q/QfN7xTlxrTVnWklcGRRkugvw=;
        b=cEQrSQBTJKHEdRLeVj0p1tOF43+NDEfHF/o3bsc0OUXzwPgf+b866E14JMyARHhccu
         AH2wi6J1QoshIeolyymQannrox6HGoRRjKfxp9Hu62SZpRI2A5yWT6XaUbyuPUFw6kKh
         NaAysFHW+pTer9LHs8XJK3j1YDqF0mPXFH2HzNaePCN+czkiE5iw2YBcjhD98wi39U2c
         1tfmGS5/EMTBxOSyDVBbQ8h4UxevwpndrXC5dqr2+VLpbhcXmChDRZqooNXhxAe8UnOb
         zqvjY1DlcAc9zr7O+B6/HT59ByLiubaCsgobeM4Kv9/Wfc0feL3MJxvgDPN238tyRUuT
         Ccww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762544948; x=1763149748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SpMh/mSxXtjLHlF/+Q/QfN7xTlxrTVnWklcGRRkugvw=;
        b=ndyuWbCx8oPNC/eU9AjXMO7SUOpaRPDT17c4ATgoyqRlJC/fIQjXP8Ns5t3hqSALVv
         8ehbLU/6lgOXs0561IkilTx0tznOVQHLfemmqboJTxMOcnOYzxMFq1invnafMud1BTE1
         c0apO6Gg7JiTvjS2S/C58M3X3emHIGBnmwYd771VJXU6XsAWU3/tq5B0kS+mEswCvJce
         Ki1I+GKygCmfwO6qtaIAN1kMeCh6gQtsmfik2PXsRVV2RutaRfZszwMy4/JmB1VFVMwN
         5iOX79bu3/DeKYcGImDE/uNam0AsWdiVkS+DpDsM9atcRuJYR39+ULCWPP/tuiPB13e/
         obMw==
X-Forwarded-Encrypted: i=1; AJvYcCUyBfRCjQix7VR/PA2aBKNTdFTI7qYnhVXwSaOW4E/Xma+3287fFhhw/JYuHrKeTe8AJapM+dFUCJMXrX+ArK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7bx31y0sLUOQGXHDtrCe/SoV9AjjNpdafWDLg9uQ8jeYLRXhx
	9dGQ4mhXr/VgLMqOqCoG+cAjANwYA1gVw2FD4NlHXB3ubthQ2/XuymmRGYf+fTMeXEWRWfkkJ2a
	bn+SsUD4wYhgs3lLbZAAakKjYcjTx51Q=
X-Gm-Gg: ASbGncu24K7ANqfmgEZSXLIiHoIYVkjSicvaN+Pdn6I0WOZ3wCxutFQ0GdlGm+dBtRJ
	NVubzrxu5dV0530XCaGyWezVtB3UtOxcnpqbzZJL0Zmbx5cvaswJhF07hLRzX/LjuWOfPe5ibRh
	H76WI4Xn0ApKU1xqDpxhJmJz/8b2zImZwtI6A99gPswAKrH/UOa2fiIuD0ijMc5qTy3Mo5pcNp0
	/sxDMoDkdhl1rvq1yMtUNlF5ucH310LzXGtCJfloqECKkRJYVSkWsf3G16CE6sXpyUzGzRPyHWo
	792tlP6R7Jo=
X-Google-Smtp-Source: AGHT+IHsyPGiBPpWGTmfAzt0nLOcnLYu1Vx+IbU42YfuoVbWUugKdmDuL5485A/o+78TaJSGduCD14DMWercRrYK3d4=
X-Received: by 2002:a05:690c:4391:b0:787:c976:4dcf with SMTP id
 00721157ae682-787d544111dmr2749227b3.8.1762544947835; Fri, 07 Nov 2025
 11:49:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
 <20251105-netconsole_dynamic_extradata-v1-1-142890bf4936@meta.com> <s6zjlx2geyjlfwgp2rvw2qolgu6vnsstv5y2rdihxwkt5i45nb@y6jzzo5pvgge>
In-Reply-To: <s6zjlx2geyjlfwgp2rvw2qolgu6vnsstv5y2rdihxwkt5i45nb@y6jzzo5pvgge>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Fri, 7 Nov 2025 19:48:56 +0000
X-Gm-Features: AWmQ_bk-gLlNX4oNGxsyxs2m_1vD8UMLpvR4pfZztJHvTMRqknJxZnS1hzE7vEw
Message-ID: <CAGSyskWFhLKBE3f=rcPducGXwcUx8sFK5RuU-BLobV7wg8X8KA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] netconsole: Simplify send_fragmented_body()
To: Breno Leitao <leitao@debian.org>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 12:15=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 5d8d0214786c..0a8ba7c4bc9d 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -1553,13 +1553,16 @@ static void send_fragmented_body(struct netcons=
ole_target *nt,
> >                                const char *msgbody, int header_len,
> >                                int msgbody_len, int extradata_len)
> >  {
> > -     int sent_extradata, preceding_bytes;
> >       const char *extradata =3D NULL;
> >       int body_len, offset =3D 0;
> > +     int extradata_offset =3D 0;
> > +     int msgbody_offset =3D 0;
> >
> >  #ifdef CONFIG_NETCONSOLE_DYNAMIC
> >       extradata =3D nt->extradata_complete;
> >  #endif
>
>
> extradata could be NULL at this time if CONFIG_NETCONSOLE_DYNAMIC is
> unset. Basically extradata=3DNULL will not be replaced.
>
> > +     if (WARN_ON_ONCE(!extradata && extradata_len !=3D 0))
> > +             return;
>
> And entradata_len =3D 0 for CONFIG_NETCONSOLE_DYNAMIC disabled.
>
> > +             /* write msgbody first */
> > +             this_chunk =3D min(msgbody_len - msgbody_offset,
> > +                              MAX_PRINT_CHUNK - this_header);
> > +             memcpy(nt->buf + this_header, msgbody + msgbody_offset,
> > +                    this_chunk);
> > +             msgbody_offset +=3D this_chunk;
> > +             this_offset +=3D this_chunk;
> > +
> > +             /* after msgbody, append extradata */
> > +             this_chunk =3D min(extradata_len - extradata_offset,
> > +                              MAX_PRINT_CHUNK - this_header - this_off=
set);
> > +             memcpy(nt->buf + this_header + this_offset,
> > +                    extradata + extradata_offset, this_chunk);
>
> then you are going to memcpy from NULL pointer (`extradata + extradata_of=
fset` =3D=3D 0).

I believe passing NULL to memcpy() should be safe as long as count is
zero (which is the case here).
However, what I didn't realize at first is that we would be doing
pointer arithmetic with NULL, which is undefined behavior :(
I will add a check if extradata is NULL here.

Thanks for the careful review!

>
> I got this my vim LSP that printed:
>
>         Null pointer passed as 2nd argument to memory copy function [unix=
.cstring.NullArg]
>

On Fri, Nov 7, 2025 at 12:15=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Wed, Nov 05, 2025 at 09:06:43AM -0800, Gustavo Luiz Duarte wrote:
> > Refactor send_fragmented_body() to use separate offset tracking for
> > msgbody, and extradata instead of complex conditional logic.
> > The previous implementation used boolean flags and calculated offsets
> > which made the code harder to follow.
> >
> > The new implementation maintains independent offset counters
> > (msgbody_offset, extradata_offset) and processes each section
> > sequentially, making the data flow more straightforward and the code
> > easier to maintain.
> >
> > This is a preparatory refactoring with no functional changes, which wil=
l
> > allow easily splitting extradata_complete into separate userdata and
> > sysdata buffers in the next patch.
> >
> > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> > ---
> >  drivers/net/netconsole.c | 73 ++++++++++++++++------------------------=
--------
> >  1 file changed, 24 insertions(+), 49 deletions(-)
> >
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 5d8d0214786c..0a8ba7c4bc9d 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -1553,13 +1553,16 @@ static void send_fragmented_body(struct netcons=
ole_target *nt,
> >                                const char *msgbody, int header_len,
> >                                int msgbody_len, int extradata_len)
> >  {
> > -     int sent_extradata, preceding_bytes;
> >       const char *extradata =3D NULL;
> >       int body_len, offset =3D 0;
> > +     int extradata_offset =3D 0;
> > +     int msgbody_offset =3D 0;
> >
> >  #ifdef CONFIG_NETCONSOLE_DYNAMIC
> >       extradata =3D nt->extradata_complete;
> >  #endif
>
>
> extradata could be NULL at this time if CONFIG_NETCONSOLE_DYNAMIC is
> unset. Basically extradata=3DNULL will not be replaced.
>
> > +     if (WARN_ON_ONCE(!extradata && extradata_len !=3D 0))
> > +             return;
>
> And entradata_len =3D 0 for CONFIG_NETCONSOLE_DYNAMIC disabled.
>
> > +             /* write msgbody first */
> > +             this_chunk =3D min(msgbody_len - msgbody_offset,
> > +                              MAX_PRINT_CHUNK - this_header);
> > +             memcpy(nt->buf + this_header, msgbody + msgbody_offset,
> > +                    this_chunk);
> > +             msgbody_offset +=3D this_chunk;
> > +             this_offset +=3D this_chunk;
> > +
> > +             /* after msgbody, append extradata */
> > +             this_chunk =3D min(extradata_len - extradata_offset,
> > +                              MAX_PRINT_CHUNK - this_header - this_off=
set);
> > +             memcpy(nt->buf + this_header + this_offset,
> > +                    extradata + extradata_offset, this_chunk);
>
> then you are going to memcpy from NULL pointer (`extradata + extradata_of=
fset` =3D=3D 0).
>
> I got this my vim LSP that printed:
>
>         Null pointer passed as 2nd argument to memory copy function [unix=
.cstring.NullArg]
>

