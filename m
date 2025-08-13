Return-Path: <linux-kselftest+bounces-38848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B849B249EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 14:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D461A25592
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDE12E6106;
	Wed, 13 Aug 2025 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVEU1jYa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62162E54D8;
	Wed, 13 Aug 2025 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089701; cv=none; b=kHoyWAItZe141bN79V0tcEsDYkfeKB/w1X2+r6AjsPLf4+YNGDMTe3HLC5Qy7K2B7T7VJxbqt8JqKdk/YGfNRv9PS25QAoYj0QAcPTWTRn0MScz6L8+ccIUPs1MpgsEblXOCKYsC44zu9hJ2JCXwmO2qqiXIHEktt19n9C0eetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089701; c=relaxed/simple;
	bh=UtbKvHUL/lh+x3YjI5uRS1BmHx10K5hZERwtwnnXLqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+8p8gMtKuG24aZeHrL9ZhtWO8yoG7LgeB/NEBh9MJSYNwjwfoYIbZtHm2f4yE9fa3Teu5gLxGjs5WehSOYWpquEsdQU7rVQcmn9Svp92Tk38MbY4Tc8Zi6LDZRoOe0uV7Fa+DD30gzkuZ8f0mM6K0gO0yE2knOtmk1+FIQb35g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVEU1jYa; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-71d3b3606d0so16896237b3.1;
        Wed, 13 Aug 2025 05:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755089699; x=1755694499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtbKvHUL/lh+x3YjI5uRS1BmHx10K5hZERwtwnnXLqA=;
        b=eVEU1jYat5CgCYxwt3hSyg8R2RfDwpXE3j+3aTYmJMZgOEspUs2vy7yK5Eb/mb5NQV
         wbuVCI14SXJWZCxHkfl1qWqsmvDQuSMRBxxuY3Wg0xZPnhOIyn8rbYzqMoJrTjjFiHZ2
         YvNtYNufIblRw7M4GrEUv+91puxoUXHgvtxsDH6pAHC/J+G33+qpMJIhMK5MFlDdRULW
         mfs9F2EOyDoREVbBjLeXQf+FDbyy4ldl5nXhv46PHUVU5AxShjLCW/nWzdfWDZxl0rfS
         ZDQp3teMsYq/DDLVaLGxmtppFhwkYF3hm7+pENzyqXkosJIx9/HRBHoMfxMhzPbWp1AA
         xMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755089699; x=1755694499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtbKvHUL/lh+x3YjI5uRS1BmHx10K5hZERwtwnnXLqA=;
        b=Bvz38bKBDtrGu5hNCmc/j1yhMstTcZDnIxoDZQz+nZcdz9OfAXBc503oE1tLGiKd73
         sFA4Gu0kLG1FHe9auXWplTmi/xKLIc0jsaSv9P2mEgK1yjd2uePjrV3tZaBQP3DFSj9r
         LIUaJTKksyZ4+chAYrqSXeRMy+a6C400w12i7zCzgAj9yqlk2Jv2Looo3adEB8WJ1Hag
         Cdme5pAkL3lnq6FMM3KDChakDx/o5EA8nXGE4s6gMYS1gYmz/Qbj9pVBUW376bcgiP19
         m+TJ5kUG8mSeIx4fLltFCdotosrBSAL6jPh6SknGtgJSZhdJvXsBOlcCiZwhzPN/bYI/
         OeOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD4iSCiE6zsJU/di42PdZJbNgpQJVh9rUO7n8tkJJkUnEMSuObvaUzD6Uwdg/O/dumpLSXtLv/gsEguxCfCP5c@vger.kernel.org, AJvYcCVHEwpJheuTs/TXXrpiWWvZkE9E5pLrYcMJHoAPzIeHQGv2uZBBc075zIthmZU/IswjAx4if8Mx@vger.kernel.org, AJvYcCXbGWtizqfK4U8/J4vnRGcPIqbZVqmzXRfIy+2Yi42kzW3QpmA9TsqUBqR66sGTaWiRTsh6jBBI+jNVCCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuYOZBf/3gwomwJiTBrsN3dfpkDSSBsr0m8oMithTsd4PWc0qd
	2iiOP1bVZGX3QHbRsSfIhfqsAJbR/xNLQ6ROn0M1TIOlRIC36fte2ahg+BpX0L9kfQTWd22hn/7
	wbgj+MEQ8n6FRWpxbjd19OdXVJsKsb58=
X-Gm-Gg: ASbGncsUAg5TvdMJd09AZo9DD04oWzgg63EFiWmTpA+QIV4rOIpdqc2pUGY2EDQeIeG
	tSUWG7Y1kKHgL4uQew5Pbg8N30Pvo8W1ICHqGdI+siLn32RGF0F026Q2sQsv4zrD7j6jTY6tQtC
	PqZtggLqxWaBl3ZRqxOdz7wf3+kGgPj2F0ZJKq+3acs3r0XjKTg0Z7dyCAuYpw9ZFFxxSQyqp8J
	5BNDoc=
X-Google-Smtp-Source: AGHT+IEj4c/eRF5bgP80NzKx8WLV6vRnZFyhb68/3YLBJKOdVzSXdaAlXeCcwAYa+QSYnZzydcnhgLjDYVha3frkjfk=
X-Received: by 2002:a05:690c:4b8c:b0:70e:2d17:84b5 with SMTP id
 00721157ae682-71d4e2491dfmr38757477b3.0.1755089698869; Wed, 13 Aug 2025
 05:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802092435.288714-1-dongml2@chinatelecom.cn>
 <20250802092435.288714-2-dongml2@chinatelecom.cn> <CAL+tcoA9Lvc4Cj9zjWVx1FzEQA=d=OnvZRDWA4nE_1GNbEDaRw@mail.gmail.com>
 <CADxym3bD17eL0U0sQkuSZZgNtg7gmvzt0YAA+CiHf9Lw5-+awA@mail.gmail.com>
 <CAL+tcoD80feEhPA_1L7D55UqkRuLSnZ-Kmmdab5J2v9K6uCzTA@mail.gmail.com>
 <CADxym3Zv9+6D0hCEx1KzvW+oAQW5oEDgSHBQPyRjHodezH9O1g@mail.gmail.com> <CAL+tcoCCq8Hc3R0_75wZxHUiZrjhfS-q65XFWM69F8pcoJPdyw@mail.gmail.com>
In-Reply-To: <CAL+tcoCCq8Hc3R0_75wZxHUiZrjhfS-q65XFWM69F8pcoJPdyw@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 13 Aug 2025 20:54:48 +0800
X-Gm-Features: Ac12FXzTK5seVQHGDbrcMI1iRSeJ-Q4x1Wbny7vI56994fdby3CWV9gaOwgaCHs
Message-ID: <CADxym3bBVEKRNa790CchSyH-WPeXmv9tjTxtmYyJamQv357zKg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net: tcp: lookup the best matched listen socket
To: Jason Xing <kerneljasonxing@gmail.com>, kuniyu@google.com
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, kraig@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 4:32=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Sun, Aug 3, 2025 at 12:00=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > On Sun, Aug 3, 2025 at 10:54=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Sun, Aug 3, 2025 at 9:59=E2=80=AFAM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > > >
> > > > On Sat, Aug 2, 2025 at 9:06=E2=80=AFPM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > > >
[......]
> > >
> > > I'm trying to picture what the usage can be in the userland as you
> > > pointed out in the MD5 case. As to the client side, it seems weird
> > > since it cannot detect and know the priority of the other side where =
a
> > > few sockets listen on the same address and port.
> >
> > For the server side, it needs to add all the clients information
> > with the TCP_MD5SIG option. For socket1 that binded on the
> > eth0, it will add all the client addresses that come from eth0 to the
> > socket1 with TCP_MD5SIG. So the server knows the clients.
>
> Right, but I meant the _client_ side doesn't know the details of the
> other side, that is to say, the server side needs to keep sure the
> client server easily connects to your preferred listener regardless of
> what the selection algorithm looks like. In terms of what you
> depicted, I see your point. One question is if the kernel or API
> provides any rules and instructions to the users that on the server
> side the sk1 must be selected in your case? Is it possible for other
> cases where the sk2 is the preferable/ideal one? I'm not sure if it's
> worth 'fixing' it in the kernel.

What does sk2 represent here? I don't think that the sk2 should
be preferable. For now, it is selected by the creating order, and
there should not be a case that relies on the socket creation
order......would it?

So the socket should be selected by priority, and sk1, which is binded
on eth0, has higher priority, which is awarded by the users.

I noticed that the net-next is open, so we can use Kuniyuki's
solution instead, which is better for the performance ;)

Thanks!
Menglong Dong

