Return-Path: <linux-kselftest+bounces-9987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDA98C1DA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 07:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACD9283755
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 05:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA5E14E2D5;
	Fri, 10 May 2024 05:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEf+sA6G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2955B14A63C;
	Fri, 10 May 2024 05:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715318246; cv=none; b=Ol8FG/2xgfM24x64xgt36liJKg5muDOGgcXQpJi+MveU8GHDJxmeQS8uynYm2NAXnDne9ZT7puo173Zwi/l52H1YAWnJdTWGoRQIXET03ALVU2SIOZ99myRsWHKPot1Vss9dLSQje9nbE5FPz3Z4qt7+oLMAVQ33oNTN7qXU9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715318246; c=relaxed/simple;
	bh=dE+qD+g3KmzOQgoEuCTr15P/CZqaA4bmglQuowx/FFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnEWJ+w9b8iVd3iAQrdNMEQS9b+5BSRxiDVjrYt5ziP2WlFJY/ntWAzrIMhZiEr/s7swGvItL2H4OnRgSVYZ4OUS8OxZdbPYItzdWf4w0N8LH+xcGNVZz19zr1NDnmbxRPRHLQXSQAcWqIZYxHdPE09Rz6m0aEWsaLPYOXEfWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEf+sA6G; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a599c55055dso409082766b.0;
        Thu, 09 May 2024 22:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715318243; x=1715923043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B16ozbzV/6/ExRtvJywDAuXn8gAsVLtiBq1Txuwd8uM=;
        b=BEf+sA6GESq6OkU+5FNn2xen73xRmjS7MqsI9w4u2zzN8lfsnh+q9C6+ZUXqQwVFlL
         dH4D8O8gtvFY2mJFi9f6c7ioYbKYojnqA9vUsczwX5RjHeFy9xzsSOOKnqPMBsSIrgzy
         +tZgcHP5M/4zzV7m51dAceE0839zkSwhUqDxF4ZVcTcvNhqBYgMOtNGsCdlJBvy1YSYH
         7jxC99WM0w4nMrTE/+WlFeUUZUiz6ztiavhyfUs0ggDpYGyC+a72MVPK6wHpVSL4TmU7
         RQY/m/qvMMdNZjJjP0einbCtLsspVaUlXBEyEQjn2N7BLUiQ8KVSYuq8yJ8XvpPW/cW1
         ODXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715318243; x=1715923043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B16ozbzV/6/ExRtvJywDAuXn8gAsVLtiBq1Txuwd8uM=;
        b=J7A+uVhrUV6U69on/zagUnirhdYZqL/z1QB0xUWl6Oo3cw2sm4YSHcfC9/2bVxGqFS
         EYS6RFKa+Aprobdq9dUQUilvrbZS9G9O8lzioid1Be1niJUM2MNYtyF1eqcM6RRFvdSt
         8U1McC8XifA2Ce3yWR1fz7ZENllaNS7f3ByaNhOrkHGq+RkC5OdZQuDgRwe2b/fXUfLZ
         Zv2w16ZCLR8gKph9rB8EmzvQ0+SESRnTpAVyOqKevO6PJnktOo5A8c1hQrvWhfKXaVLl
         OUnvYAbWRvW6kwflA63CQL3F9MW2sUOtZ7se0u3PJCX/HpTS95Uky1toFt6LPKJApktA
         oKpw==
X-Forwarded-Encrypted: i=1; AJvYcCU4WliVSXE1M6vWqgEgVGoUy00FO5o19yt24bfjM5kyE/TMN55kQO1rq2bqugzVVhkWClmBa5EPDydM3oknRlOzVs7k+zFePvC9YtOqoDATHsCoZkVy1JVdeyGAtx0qgQGadJzcNTBf
X-Gm-Message-State: AOJu0YyRclC45wT8TgsknfzRmGjWLYaozpmzMYL43Obox9UASbNYOllM
	oEARVAbzOfVVvsISEQYc15IUvhP9f1FDhdNjlrGoxUrQBBJ67oBhUpYc2Z5zaaD5LfPblBU+jYP
	SDkfskQGATyMcD9eSFDULdEs+MHI=
X-Google-Smtp-Source: AGHT+IEJ9DEbuPceorlzgRGznv9pDwSBTfvFnSTibOF/x5IbXBcj6m7NZz3YBhdujqufq4dMSA826UXnBLPnIEQNtzM=
X-Received: by 2002:a50:8e55:0:b0:572:952e:7a5e with SMTP id
 4fb4d7f45d1cf-5734d5cfe4amr1001131a12.24.1715318243459; Thu, 09 May 2024
 22:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508040643.229383-1-ap420073@gmail.com> <20240509092257.2ecb8fd4@kernel.org>
In-Reply-To: <20240509092257.2ecb8fd4@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 10 May 2024 14:17:12 +0900
Message-ID: <CAMArcTUi9bBd=b4nXsG3qs8MMi8ghS19DjszHhEdnQNfM-DmHg@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: avoid waiting for server in amt.sh
 forever when it fails.
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 1:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

Hi Jakub,
Thanks a lot for the review and looking into the bug.

> On Wed,  8 May 2024 04:06:43 +0000 Taehee Yoo wrote:
> > In the forwarding testcase, it opens a server and a client with the nc.
> > The server receives the correct message from NC, it prints OK.
> > The server prints FAIL if it receives the wrong message from the client=
.
> >
> > But If the server can't receive any message, it will not close so
> > the amt.sh waits forever.
> > There are several reasons.
> > 1. crash of smcrouted.
> > 2. Send a message from the client to the server before the server is up=
.
> >
> > To avoid this problem, the server waits only for 10 seconds.
> > The client sends messages for 10 seconds.
> > If the server is successfully closed, it kills the client.
>
> Since this didn't fix the problem of smcroute crashing I had to take
> a closer look myself.
>
> I filed https://github.com/troglobit/smcroute/issues/207 for smcroute
>

Thank you so much for looking into this bug!
I will test it.

> And sent:
> https://lore.kernel.org/all/20240509161919.3939966-1-kuba@kernel.org/
> and
> https://lore.kernel.org/all/20240509161952.3940476-1-kuba@kernel.org/
>
> Please don't use netcat in tests in the future. There are two
> incompatible implementations which always cause hard to repro
> issues.

Okay, I will not use netcat in the future.

Thanks a lot!
Taehee Yoo

