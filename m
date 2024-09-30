Return-Path: <linux-kselftest+bounces-18616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B8898A0B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 13:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC471287E9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8102D18DF86;
	Mon, 30 Sep 2024 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK2Sgo9z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5B18DF94;
	Mon, 30 Sep 2024 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695481; cv=none; b=L+LUc3iM7GqlVl/O89U9Wp4Y8lKXS5DvsVzSQr4vooqrm2jQH3tvzi0GDYH1sbiN0pTHMAByGf7r0+qc9F3JN24E6reYgn+TeHSuZFxaUmpQbuGIVe/nqmqk5zWWSyy/Wi0Sm4HMjdmoxTQSlpoyEwKhrCLnMWjA4NmoMj+8i/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695481; c=relaxed/simple;
	bh=eoZaZgdErkVB20t5yciUNmtFmCelhEs7R6rJOBirD84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cL0BzAZE4m5/jYPJZBrTnW8Wb8I3mJCh/ChKuluwxNpcxjHleqXQJIgqm+e4v5abyoTKUQDFkhjzkXDJQhbE4FAXT8BVWuLkuSabqGlpOd5tN5xrk14Dcvm8j2crM2uZxv/3YIC0G50oORbZ5ntTeCHq21RYcKe4lNF90uzwGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK2Sgo9z; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a0cad8a0a5so23503235ab.1;
        Mon, 30 Sep 2024 04:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727695479; x=1728300279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEm+5IcrPXHErMOmcibqndoVvsgCS+zTxs5m+nzV+oU=;
        b=RK2Sgo9zHczR3KbzdOWjw7pdUPNM9734QFUoUez8b2DNwF3hKqyCL1ntQn8M7CnLqZ
         2JXI6IFYDxc/5YdSLuDShrquzHrP/OrBIq0hsWESR/jRjGUJ6+/n+wGkc3gH5sVD2LWD
         qVyGyLJPkowi/mVreZx5VxZvKFKR0uBO2q+UT/mm1z9vr0ULe69n+kk/IMG9j3S9BsoD
         I45hRAi0k1z8GAtsH6LHbvZdzmlwJedI2aLAL9Hl+LZgAuvWMoFuq5PDaO+pbid+/Ns7
         PG5YTzXY5k1T9s3TI5tuiZ7TnyzqUm6wATwyU75I77pdXnOAkPaCQHRILgCi1idgs60q
         tFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727695479; x=1728300279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEm+5IcrPXHErMOmcibqndoVvsgCS+zTxs5m+nzV+oU=;
        b=LcZXWtfbGDSNAmSaXSODTzAY3ueeaD7z7M7dXEN/IDYSktGK5P1aq3+RTfcNLri49g
         nzV6j2Ss4duiwr8gy65siOn5bwpmipmILKZYlmPcTIXT4kx2VR9dfKcPeLMM/j14ScjG
         LTmRu9l6QJECYvJkpajpOu4gBXNPjGAPKOxcGVHWjSe5Wni3wFwT0v35gynrFF9ZxTkX
         EmJo0vYddaCRZfFGXeGTdxIzbNaN55LawRTMj6W5iCzXfep6Pfl/j5HQeGdQoWWecXYO
         v1w1Ja8I9lt4hMh5xlQOE14VZ5Y/x1WkdZDAvJf50kUFaiNQkYTjksMWLmBIpW5mFBlu
         5j9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgI8RoiR6f9gO1SFgEPh8x9HpSKXv1SeTpH3ftAHFgFXKW5vGnyqRupPv/NFc757I84Ks+PBNB@vger.kernel.org, AJvYcCUpvyapOS13iviBGyyy5/WlCcNrsKXcUPgWONp7M1NojuACeIXtYPNpZ4aG0MSHv09vZH5oMhfyESHwSSnEuJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLGrgZkAJqxzL81YU2JIF0iAfGW7/UnoaMt0cskUQySZZm+k0t
	hd7XF81SlQcKcgLEl72JFhGMe8KNQwnPIra8thSkmUKwCfTWUXxIUEo8XUOZcplAtZrZQxKfZOe
	Bku1FHoVEFjdOxRHpJFa9p8ZABaE=
X-Google-Smtp-Source: AGHT+IGWsinEknh7FKS58G5D7DK45bld1NeLf9z57TeDpI9H+YN6Dt0av49Vb6m79z80yi2n6q7A5+QYxbjyiyxfF/c=
X-Received: by 2002:a05:6e02:20c5:b0:3a0:9b0c:6b2c with SMTP id
 e9e14a558f8ab-3a3451aadcfmr90164055ab.18.1727695478826; Mon, 30 Sep 2024
 04:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
 <20240930092416.80830-2-kerneljasonxing@gmail.com> <79998b2c-0ca7-4180-9d7c-1d6af96dd4cf@linux.dev>
In-Reply-To: <79998b2c-0ca7-4180-9d7c-1d6af96dd4cf@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 30 Sep 2024 19:24:02 +0800
Message-ID: <CAL+tcoCc5H4tZ6m+aWUWPJnJUHbYV=upEZLSZ41PvuU9mw0kRQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net-timestamp: add strict check when setting
 tx flags
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	shuah@kernel.org, willemb@google.com, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 6:48=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 30/09/2024 10:24, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Even though this case is unlikely to happen, we have to avoid such
> > a case occurring at an earlier point: the sk_rmem_alloc could get
> > increased because of inserting more and more skbs into the errqueue
> > when calling __skb_complete_tx_timestamp(). This bad case would stop
> > the socket transmitting soon.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   net/core/sock.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index fe87f9bd8f16..4bddd6f62e4f 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -905,6 +905,10 @@ int sock_set_timestamping(struct sock *sk, int opt=
name,
> >       if (val & ~SOF_TIMESTAMPING_MASK)
> >               return -EINVAL;
> >
> > +     if (val & SOF_TIMESTAMPING_TX_RECORD_MASK &&
> > +         !(val & SOF_TIMESTAMPING_SOFTWARE))
> > +             return -EINVAL;
>
> SOF_TIMESTAMPING_TX_RECORD_MASK contains SOF_TIMESTAMPING_TX_HARDWARE.
> That means that there will be no option to enable HW TX timestamping
> without enabling software timestamping. I believe this is wrong
> restriction.

Thanks! You are right. I should have realized that. I need to get rid
of this one.

Thanks,
Jason

