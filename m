Return-Path: <linux-kselftest+bounces-31357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B951A977F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 22:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2711892181
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 20:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1BB2D8684;
	Tue, 22 Apr 2025 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="maDEm0/9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDC3298CD2
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745354800; cv=none; b=Cv+N7/qPzkuIPihQ0rODxBDxcnZD5L8nrfd/bIzfhmbbczB7X1WZtYmrtzB2Kqz/OdfIG975ASE9jqDwdjRLpJEVQPnzdKwbsAcnL+ildk7zbC1BiPiUXZQZgtV9sQlcnB/G5LLMHqEGYyDjT81fHK7xngy2GQLFzODzh2GQkwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745354800; c=relaxed/simple;
	bh=AepzvkTaXC3tf015Trnt4kidHqKonWdB6m9AqTJB5Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4H4M+oBcNIhts4v7vdSZDliwPhGMdsxL4ZiXFvDHyNyfrh1nOprB41ggdnKm+8IG6uoon/EpujwegmCvGRsL5V7fGE1SQoAgSAwP9teALqgXPSZHgesAzz0ZE+qm2NpfRhjYlayDo864L1kgJ3STpP5piUdpmh4HY+VojU8ADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=maDEm0/9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2263428c8baso13405ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745354798; x=1745959598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hbnVvENaVU3NRLrUDXLjqPtRsqZnanRvkC7zMsTFmw=;
        b=maDEm0/9uQs9/f9YyauaANBQvRiwE/gBMcs2NalSOx2kq7A9HxYvAFgU6uBag79YDM
         zhP8YHIrVOHPphcC182uhhXJnm1Bh4R1RaL1BmUhtTwn20leEt5B2+Yy6WZCF2jQNWYG
         a53e6R4X7AIHFD2r2iuUkFWwwqRcWh1hcVKnIz7Yz8hwp+0KlUNbVPKoYSwyo6/C17tm
         Xpxswaob9wTMBlgp30y03vJo+sd4/odiRz2MZVdNat1YJALG2hEN4VUnT9tF1qvhZgjr
         FR2N2NbZHEbYtIT/PYY4CZBl4kW/A2noNHH+lBCys5kiYlM6UZqwMnhC8ou48Aw8sWgF
         Jtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745354798; x=1745959598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hbnVvENaVU3NRLrUDXLjqPtRsqZnanRvkC7zMsTFmw=;
        b=ICRRYnz3hWSA3GUEESRQPwQ0x4efiII9zZs/6GIT7KpJBKOyixsM6Cw6EFkivECI7i
         Db8voJpD3YjjHSQ8Of5aLxho5Co9uVQyTDbraaO9Zeggv8pUSxESfKrKbqa0ACTFnjGc
         VrS00FPBZLb4R7W8xGhpVyG+F7m1hajlzej5oqyHBX5GmXDk3Apr5+/c2nRP9zhiWY5G
         uYxETMSuvE83Twnt6GBXS5xCHaNsKoYjDGeO4jFw33hC2RtTcJIRZzTI3D4lRW1xBV2O
         dQSYpw2KO9qGbEe4yClbLGg9ZtBj3TtLZM4so8Y6xRY19Boi9e2qEDzJaxqSAXhB5Bd1
         hC6g==
X-Forwarded-Encrypted: i=1; AJvYcCVMU6oONTnRokBHwmse7VRx6vOWLSJCNl7pHc7I3EiEnC/WQov+3owXLiBd+uGyQKyrd45btjzeUdWTrKX6Etc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9EGHBRBWpkPPS1eZsSPImJ0/x7TH+hy8ERk8AMhWDhlruYwUC
	FtFUZpmEySoQQ9p/U7tzJ2ptnoC81sqSgFZ5h5DIAkapFUoUFYGXZgvn0RrpmrYVGRp3uMGq0l6
	uWWXSadNLpbo4FxGt8PjAALI9JHR8GWCD7XC5
X-Gm-Gg: ASbGnctEqmVIUtz0QMFF9lM3spYvw4wkF5EcPaSRv3fTm9WoBqu1IP3UjpR9FJWUy8F
	Wvp8HTi/+a+urOZAF/rh4ZVaLfWJNwDlXAQeTuYTdCdIvCFzhloMkj6zVrG+PU1uCG7+OyA/JC0
	rtDhHVoJ+Bgj9hvCRIxWu1DR0/ACqKQRTrPs5FaVE0po62Vk4euHmH
X-Google-Smtp-Source: AGHT+IEri+jHg7nzBWYce/s95T8w1odDrVsc9bNQomfJRGLKE9zLufWZUYri8enjRiH0NTmCrON34chxcEP4+8+fy1g=
X-Received: by 2002:a17:902:f78d:b0:224:1fb:7b65 with SMTP id
 d9443c01a7336-22da2c3fe23mr741975ad.22.1745354797940; Tue, 22 Apr 2025
 13:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
 <20250417231540.2780723-2-almasrymina@google.com> <f7a96367-1bb0-4ed2-8fbf-af7558fccc20@gmail.com>
 <CAHS8izMFxDG5E07ZdqnDH_2D_g1fW8X0M7u3gGyV8efzxDNZbg@mail.gmail.com> <5d2f86ce-e2bb-406a-8d53-58a464958d2d@gmail.com>
In-Reply-To: <5d2f86ce-e2bb-406a-8d53-58a464958d2d@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 22 Apr 2025 13:46:24 -0700
X-Gm-Features: ATxdqUFHY8ewiDnZPwv9bGxstV-8bLqJUqf0obD0wDTOy1se33mAidQpqaIoPl0
Message-ID: <CAHS8izMZbt=NAK0GF6VqJNBRKy+iZQGMFG+jFJEesbz=5RiLXg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 1/9] netmem: add niov->type attribute to
 distinguish different net_iov types
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 12:52=E2=80=AFPM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 4/22/25 15:03, Mina Almasry wrote:
> > On Tue, Apr 22, 2025 at 1:16=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> On 4/18/25 00:15, Mina Almasry wrote:
> >>> Later patches in the series adds TX net_iovs where there is no pp
> >>> associated, so we can't rely on niov->pp->mp_ops to tell what is the
> >>> type of the net_iov.
> >>
> >> That's fine, but that needs a NULL pp check in io_uring as well,
> >> specifically in io_zcrx_recv_frag().
> >>
> >
> > I think you mean this update in the code:
> >
> > if (!niov->pp || niov->pp->mp_ops !=3D &io_uring_pp_zc_ops ||
> >      io_pp_to_ifq(niov->pp) !=3D ifq)
> > return -EFAULT;
> >
> > Yes, thanks, will do.
>
> That will work. I'm assuming that those pp-less niovs can
> end up in the rx path. I think it was deemed not impossible,
> right?
>

I'm not sure these pp-less niovs can ever end up in the RX path, but
I'm not sure, and I guess better safe than sorry. We usually get
yelled at for defensive checks but I don't think this one is too
defensive. There could be a path where a TX skb somehow ends up here.

--
Thanks,
Mina

