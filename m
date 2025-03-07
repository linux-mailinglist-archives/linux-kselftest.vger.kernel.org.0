Return-Path: <linux-kselftest+bounces-28456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF5CA56025
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 06:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D593B32BF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 05:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC188192B9D;
	Fri,  7 Mar 2025 05:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfrvOjfx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2639F7FD;
	Fri,  7 Mar 2025 05:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326167; cv=none; b=ax0CYAoh64Ytb0gBbnZTB6lzc2BLcr6yGm8y3KgqcFYyrNAtM0xmXIsqQF8C/mGYTQ00t3z/c7URDZm9tbzYXBkTM53J9bKYHBrHBrowfh6RbEY/KH4z4mZcNZgvJ/ctsHuByWfj2v8Cap+2JqQYGhRbs6r+K/1IS8FpRMiC/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326167; c=relaxed/simple;
	bh=2VDFGRlYKXRUljBblvdtFlwOOzj13mn547LMTaJP2gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzFzCPXKxwmFzDUniqoJsp8UfHffh0aYbLoQAGexJX2mtVqz+74TyR/BpQtXAqbnG8IKYtDcC0A3tOaQdrg/R4fWIjPhZN4Xz+EYSq7mtXyWE39Upgs288GIDy+hU0nFHerVFDIhsX1bPjpHhyzD4yEh2jUJhPmTcK+Bx1X9P20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfrvOjfx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e4d3f92250so2057813a12.1;
        Thu, 06 Mar 2025 21:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741326164; x=1741930964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCCuSIdseDmohQkR/a0WVoB8hKN3v/q9qa5r2iXYOqo=;
        b=NfrvOjfxEYG/YE8BX4gCmBYij08fYvo1Pa2Tob3y6Ne7hUA9IWwT5fp7rw5DTrZVE6
         AyxgBC905Vvd/X8F6tP7O80KUItKevWyAays194tUGT8I03OV6ohI0g1vq6/9+u8MSXI
         XQ4a2huJ9WR1pT7LOm6I/zlmAo2p/STvt/q/oidO04T4nox4fm+sJuNlir0jFnhd2MA0
         AnPgfisLQdhkpam9PWx8uPJhSlKTuuWIkavMITSEZ5iFinnZLlXk6dz8BkXdzzdAdt44
         LXWpZOnHgsQ39pFGCxKRiwcMyee17sCP+b6g2lh1013XVj2bsnK6vyL74TBfde/LCtXM
         0r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741326164; x=1741930964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCCuSIdseDmohQkR/a0WVoB8hKN3v/q9qa5r2iXYOqo=;
        b=tHIeEvm/VrqjqK6ksVhnVxFC8yZflMUFKqQBZtN2DaEKHIeHPHCr1LHW2OL1L2ETwr
         WKhCV69/0V1AKzrhHzEnw8Kmn2d2/woMYJR0hIrkvAjGYhU0EgcrsXQ6g69MHYUXQq3J
         fzlIgJkM4kCyqC5NtJOB3of6ikNj/SiCXskDZjA5vs2tOGw3bAixDgvBv9HWV+LIKcst
         CbKubEbyXZI+TV3XXFAO57dnuLm0EbdRxRpRg9i5yLA3QxiRIyyQ7nX0AgitK//Y/CwZ
         1SZc1mkS/jFC447UmRJVbvu7ZlCGZHM78Qv7WgK7deOJzRRZj7VH9oxhGQ/MhEXTa1ff
         XOew==
X-Forwarded-Encrypted: i=1; AJvYcCUzav3jyNQgEUmwcrD521/dzHvLjo9xlJljYJmw5uhPkZ6DS2T52W26KMu//WW9uPinolzg2RcS@vger.kernel.org, AJvYcCXpx8DBOazZr6kat3/MzKCM5Z9vsNzYbdsnYYNhYfhs/OtY7Ib+xuDKz35ARhP2VvkXkGkW7GEoOV6q0OEfUlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxf63KmjiZGnmm/7Wpks1zp+GaTvgAsFMAqqnYRGrOvrKmpBwu
	TrxGkVBK0jeZyFR5CqJJ5xC55mhQAGcomrhp10GL49fd+vwuslbMprXQ2H1aJzvKjnKp5B/YrUE
	WndgkQHIU+ZRGuot12yjerIMv13w=
X-Gm-Gg: ASbGnctZ7SX8vU/sZdGB6kErx6+I1r3coTQrvXwpH+Uzs7CNxXgI5zrxeXPf5MZ4t1T
	EmEIdp5oinx0HYpZNkWMdRICyfMLptg0TcPdzWHNRHJDnWUcujWg8ld9/NpDzOmBlFLu7Cbrz6M
	G97XUxohnsu7LTZf6Y+TY5cmga8KU=
X-Google-Smtp-Source: AGHT+IGZ1N/0BVEIwoeC7pN0a4dU5zNpzeIOnjPo6+wNNho224DKHGoP+JyHqv+hhiNvvcswdXE4FXYOgm6J4PZJDFQ=
X-Received: by 2002:a05:6402:2808:b0:5e5:71e:8c63 with SMTP id
 4fb4d7f45d1cf-5e5e22e5476mr2166342a12.15.1741326164093; Thu, 06 Mar 2025
 21:42:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306072422.3303386-1-ap420073@gmail.com> <20250306072422.3303386-2-ap420073@gmail.com>
 <20250306173523.20b136ea@kernel.org>
In-Reply-To: <20250306173523.20b136ea@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 7 Mar 2025 14:42:32 +0900
X-Gm-Features: AQ5f1Jr7Gp5qqttUDWMqc-W6lQJFcMf1qiuEp95WhQpeUcsi3pljEnW7glUWB6E
Message-ID: <CAMArcTWmZv+rUi8ci4tbzVz6dW==hDT6njehcd8Lkn44v50gPQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 1/6] eth: bnxt: fix truesize for mb-xdp-pass case
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	andrew+netdev@lunn.ch, michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, almasrymina@google.com, 
	asml.silence@gmail.com, willemb@google.com, kaiyuanz@google.com, 
	skhawaja@google.com, sdf@fomichev.me, gospo@broadcom.com, 
	somnath.kotur@broadcom.com, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 10:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

Hi Jakub,
Thanks a lot for the review!

> On Thu,  6 Mar 2025 07:24:17 +0000 Taehee Yoo wrote:
> > +     struct skb_shared_info sinfo =3D {0};
>
> > +             memcpy(&sinfo, xdp_get_shared_info_from_buff(&xdp),
> > +                    sizeof(struct skb_shared_info));
>
> This may be a little expensive, struct skb_shared_info
> is 320B and we only really need it in a rare occasion
> of having multi-buf XDP.

You're right, it's pretty heavy. I didn't think about the total size of
the shared_info.

>
> Can we update agg_bufs =3D sinfo->nr_frags after calling
> bnxt_rx_xdp(), and otherwise go back to something like you v1?

Okay, I will update agg_bufs with stored sinfo->nr_frags.

> Sorry if I mislead you.

It was my intention, no problem :)

Thanks a lot!
Taehee Yoo

> --
> pw-bot: cr

