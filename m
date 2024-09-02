Return-Path: <linux-kselftest+bounces-16921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463D0967DF7
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 04:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E992821F1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 02:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9792C1A2;
	Mon,  2 Sep 2024 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUaWcqiM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E352CA2;
	Mon,  2 Sep 2024 02:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725245712; cv=none; b=bDnlQlBzbvMmR8bAFQaMqzjkF2SM6iBluujE1ERCVzxuziP925XFoLJkrz6IJo/Zh5UipU9hRJqD/gfyUPp2m/yZPqe2tH2UkR2ydXDEF0yBg5Fe3jC3fEECPNfhaf/Qaa8tyt41j9jvk4tpTvig5G0K//pZeN/Eq3NNfBZAn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725245712; c=relaxed/simple;
	bh=F8e3QFbFm6oqH1Vt3liZNlf294Fn2rRIi2fU8ykSv5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aloFV4ns0+OE3nAEpp7TxczzHnGfQu62qeB/MaZRdsB43p+kbn3bifsUz/0491IahMqLR9hfqo24ucK5FDIT9KZmiz9ECQLv9Jpsf64IPo8SyCuS7UQjXZAqPrDjoOwbhudOBQfBe1TKlBN3bwamRfhb3/K5M2lxVR/j+A8t7d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUaWcqiM; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82a1af43502so183621639f.0;
        Sun, 01 Sep 2024 19:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725245710; x=1725850510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJq546ZBodcE5BskgeASBDcTLksJN6RudMcIFFrNGDI=;
        b=hUaWcqiMWvOCqOY10Co6vQ6Y4/xkTaOfZ1TDrYEOccAL5Q4Qui2fEhRn+pHdtOYpw1
         4Clr4DYh/pgo5I66tw972odnj7lB97T8coJRzT2pxAHrg4IPXv2QP/wCZspm3JbnV+/w
         roF41NrVQld7TMozUwTaWY3zdPtkxFDPeTV3/0+gIfxMa3t/3lj/e4FKvde8XcTsoT2m
         Dmi8E0p4hfqiHRAH7Tvdai/tClByuUt+jvEqTMNZnF0Sqolcz4nmfuZPEmCEVbm100So
         1LTsB8GldKxDUfNjt0Kq/UwgVwO1PCgvKLRCHY+9BeKym0EtK6iUlvIxSfFXbvz+DoVe
         0mDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725245710; x=1725850510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJq546ZBodcE5BskgeASBDcTLksJN6RudMcIFFrNGDI=;
        b=LPfNlKo8Kj9zMYaahrGv6/g5o+tJjZdlUZXp+yt0zMrZPi70kcnJHELnpCjdyA3yZa
         Wsc2u88RR1MmlG5FUINB9X4YDpo69xjDRZozglxDXmRjLIuH1LNAyy0W28IlGyugNwKe
         87Z0NtZJe6syCNV/U/ns7BnVWat8v8IxoP4xbYgZb8YjpBzFPCydHsJrqZ/JBQ5t20Y+
         HXi7m3wwrAVEuBmpxW/a2WK94KP74gKB4wbuAC0wgLTxvdKmLfEXJUY0YiRLuTN7xiDr
         h5blbFUkpX2D+XKvy5LjtnxQQ+CUUSzB9hOAisAgrsFNbzOhsRBFAaiy3058Q7jLGM3k
         lEYg==
X-Forwarded-Encrypted: i=1; AJvYcCUeUGwyL7b5wOJ49V52zD5H8A7DDPiPCOI77f8yah/IJ7/cWDhYkCblU1JpbIT/eNghbPEY2Rg4@vger.kernel.org, AJvYcCVE2X4Ys4sRwoAegmf+HOci7kuFqFc9wtXMq6Yo7MNNz8NtqZt2DmIdkKuFLfOUBbwVgXrOIeeW1KzLxgY3yUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qp3XfjBa465hO4rk3tey6hVVpb0qTqluyfC6EJzLQFufvNFP
	nqM9tz5JfgjpUrx79O09nA1HWFZC52UIZ6dr3nNEhJs0hxBLpgKTvz0KPIkCtRUvGVVQgA88UTZ
	+SFB0lsBMQ3yXmjPS++6yZC7a4fY=
X-Google-Smtp-Source: AGHT+IGv5dadAA7M5vxrA8HegT19prJQZMaXNDcR+13NiB2iYuMLQwu5Ucs9+D8jvTp7w8Pq7SWXQG9Wq6n7YZ/5lZs=
X-Received: by 2002:a05:6e02:1a04:b0:39a:ea86:12ec with SMTP id
 e9e14a558f8ab-39f3795a2b2mr152313635ab.13.1725245709825; Sun, 01 Sep 2024
 19:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901051821.94956-1-kerneljasonxing@gmail.com> <ZtUPu4OYHbitqYtn@mini-arch>
In-Reply-To: <ZtUPu4OYHbitqYtn@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 2 Sep 2024 10:54:33 +0800
Message-ID: <CAL+tcoBH-UGxyoiVY6PKfYdcGpXc_+x4GbEv6XNNyO+qW4rpvQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: add selftest for UDP SO_PEEK_OFF support
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, jmaloy@redhat.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 9:07=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me>=
 wrote:
>
> On 09/01, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Add the SO_PEEK_OFF selftest for UDP. In this patch, I mainly do
> > three things:
> > 1. rename tcp_so_peek_off.c
> > 2. adjust for UDP protocol
> > 3. add selftests into it
> >
> > Suggested-by: Jon Maloy <jmaloy@redhat.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > Link: https://lore.kernel.org/all/9f4dd14d-fbe3-4c61-b04c-f0e6b8096d7b@=
redhat.com/
> > ---
> >  tools/testing/selftests/net/Makefile          |  2 +-
> >  .../{tcp_so_peek_off.c =3D> sk_so_peek_off.c}   | 91 +++++++++++------=
--
> >  2 files changed, 56 insertions(+), 37 deletions(-)
> >  rename tools/testing/selftests/net/{tcp_so_peek_off.c =3D> sk_so_peek_=
off.c} (58%)
> >
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selft=
ests/net/Makefile
> > index 1179e3261bef..d5029f978aa9 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -80,7 +80,7 @@ TEST_PROGS +=3D io_uring_zerocopy_tx.sh
> >  TEST_GEN_FILES +=3D bind_bhash
> >  TEST_GEN_PROGS +=3D sk_bind_sendto_listen
> >  TEST_GEN_PROGS +=3D sk_connect_zero_addr
> > -TEST_GEN_PROGS +=3D tcp_so_peek_off
> > +TEST_GEN_PROGS +=3D sk_so_peek_off
>
> Should we also add sk_so_peek_off to gitignore?

Good catch. Will update it in the next version :)

Thanks,
Jason

