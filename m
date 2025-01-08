Return-Path: <linux-kselftest+bounces-24049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44240A05581
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 09:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407B6160751
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 08:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770B11E32DA;
	Wed,  8 Jan 2025 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkG/XGFu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1891DFD85;
	Wed,  8 Jan 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325427; cv=none; b=h7smiKeQZwZx91pBa6CjIjVFWYjpqZxBOjtRcf9yXDp80stN3uQ7yD9ICIw2WpFmzSyfNo0vjl7wRHHFRHIeIELM/nq00wF8cmxMKxTMCg55ZZW6GjttBzm7zCSLkDXsZDmIFD0pk4cnHT3UiKfknrSF+PDuvzEpfJGm2Zeny3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325427; c=relaxed/simple;
	bh=nxtV4VMFqi9OawJzTCLL5xTqLQUX4En71MCqEoFkWhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGhq08b60gmuQSYhD4NA0IOtPEloev+NFwMVNw3UydjSlO8yg8vMLjNd8JRBJ3AYUAQrrLKTXKw5L0dVuv1fBNYNKQjgpC4RvIa9kfZCBqJmGL3xUopEXWixZ1udyf6trUKaLRC0QGPvJobZrwv+xz8Seo6U2Rw/pnVNjo4t6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkG/XGFu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e0e224cbso8206786f8f.2;
        Wed, 08 Jan 2025 00:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736325424; x=1736930224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvettVxfJ9lYY3or3UxLpfyl/cdkwWLgR9kVNnFx6ho=;
        b=GkG/XGFuEu5fAXYebJ4D+UF1kCOvf9KEv5Ag5qbcOcJAET7p6asIOac8DWx2wzvJDZ
         pjsikSy6uVdjOKqW9paEA0jTn8RZx0LJHyGP/wxPT4aNsmYUoE2r/UC5+Fq5ZoIDbKCs
         a2aUfCfzCy+IG4Ph97QlCttaG3A529UNFGBTrr29exWwqgS0FVq0WInljhlpEplKUHpj
         wiTGspRSfpECmN/hiWF8WjtrkqJMhXIeRUcxVmXklHnrtSiU89rV7S0mRwEtZpikEEAR
         h+Nx16D+VSFoDiHkbZoeWEopuBkR7bVXVsELelqj/LwjeoUSf9+L9P2dZjHRjm6u0zU0
         Kx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736325424; x=1736930224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvettVxfJ9lYY3or3UxLpfyl/cdkwWLgR9kVNnFx6ho=;
        b=m+pWUZwxKfJgwVuUdGn763aHhLkNaIxAvh68RRB6/1gvx8+swbfyQd5l7Tf0Wugbbr
         Yny3fAPyKz0d1zofR8KqIQy3Rz1JwGN2InDMqB291J9+r1YNlP6AbQtgWqR68Uw/P+YE
         +NGEc8L+6nM/1mNqd68r3cufap23ayN7qoh267u35N01avs9fqYjC9hv4L7BTYOw+amY
         XbHVP4WNEHNM35RXgr4opxV5ElXSegLi5lGHD328EgcoY8yGmNy+K1IWUhNYPcZZEqh5
         2AahZ7puXNO1b8tl/vRyZq3DlScuseAiUG5zgC1FnUnfZBptNswzZqi4fvBq6bQnZiZp
         rkdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1/Jb0JC861p9qQ0YT6w8tlcDRadJm1mVthU/GJCJ/aPs2/OG/bPF/E+vGj8NDZTEEpH+spV/U5w2u0HL6@vger.kernel.org, AJvYcCUIpC5zXE0t7oUvcWB/V5IeOSQEb3JyBJzcdMECOlhskj1Xem9ljid6oOgOKT5zkVI3dmW0OKvwyFX5BQ==@vger.kernel.org, AJvYcCUnkqVuCcgIhOlnH3+L/QACy0lOxR/Ys+uI9ak8zCrS3p2FxzPR79dz+pSIZdzsCgaSIUHUr/cjvhN4akK6niVV@vger.kernel.org, AJvYcCVIbb/HaeVt1BOSQenc3OJpSPpQIacorerpd9MePdSYL3jCWzso+TrZXa6em5lJPSVGPuUl/fk2LaQj@vger.kernel.org, AJvYcCVpGooN8S/3Sw6DQInUjv1FPTQfAryiBRlzT3hgHXdWQsh941xOaxHDwgormT6NAuWOwsc=@vger.kernel.org, AJvYcCVq7cHEQ23b622HzPTsykqdggc42oImWyP3Yn3AJjFH73sk2dQNa6tBt72gYSJ89qejQD+Cjg0DW4vP@vger.kernel.org, AJvYcCX09hsXpcdb5GMNx6wwVF199+rvCqpA7DoQR4ZjFFwtngpriT2OzVgTSiwrcTvHMBdGXWEBRSDOyuYVxFQrkj4=@vger.kernel.org, AJvYcCXB62Jhgio/XGsI9ATOEF5oXPl/TM1IS053Dj2WLpllLOWs2UuvPOV63ewayHhMibiF7EbcNGyepuWKIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBilIsjevSNkgXOqOUdmeBdi+JOtq+QxJUmctclmpJcQcNzs3z
	tgNrkECqI5OP2oLXAOk50oSX7tiMdVBkVWbmbjZ/2uw07cPwcssR0iLPn/GevJzv28CS/mAEdnh
	Kdot9oXASowOyoWPaZEdaAwWxZTs=
X-Gm-Gg: ASbGnctSFLdWZYz8JTEjL/mehGoOJcmW/NsZfn/rdixYNWZnlKxBwsifHeaE23bYTJj
	3msWMhnCAE9iZcE9tQdFZNRpHWA6JCYSbCBpR
X-Google-Smtp-Source: AGHT+IFnmy3aEmpEtSYOMGcp/W5oHyWUG1cZe2OhDShkb+8U3jvy3oPHzekY3BLrSLnXQaOhfCodhl5ttnW21/EGgAw=
X-Received: by 2002:a05:6000:4712:b0:385:f38e:c0d3 with SMTP id
 ffacd0b85a97d-38a8731a4d3mr1171129f8f.58.1736325423889; Wed, 08 Jan 2025
 00:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250104125732.17335-1-shaw.leon@gmail.com> <20250104125732.17335-3-shaw.leon@gmail.com>
 <20250107123805.748080ab@kernel.org>
In-Reply-To: <20250107123805.748080ab@kernel.org>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 8 Jan 2025 16:36:26 +0800
X-Gm-Features: AbW1kvZots7MSnDo6hVFO1pdLy0jTDp88J1frKk6l9Bo0g1-dsYfw260dsxsY30
Message-ID: <CABAhCORV_s9m-EJ8914zUXCXt6O_e1wsaOVdSKUtm0Rbvc4orQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 02/11] rtnetlink: Pack newlink() params into struct
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Hangbin Liu <liuhangbin@gmail.com>, linux-rdma@vger.kernel.org, 
	linux-can@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org, 
	bpf@vger.kernel.org, linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com, 
	linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, 
	bridge@lists.linux.dev, linux-wpan@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 4:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sat,  4 Jan 2025 20:57:23 +0800 Xiao Liang wrote:
> > -static int amt_newlink(struct net *net, struct net_device *dev,
> > -                    struct nlattr *tb[], struct nlattr *data[],
> > -                    struct netlink_ext_ack *extack)
> > +static int amt_newlink(struct rtnl_newlink_params *params)
> >  {
> > -     struct amt_dev *amt =3D netdev_priv(dev);
> > +     struct netlink_ext_ack *extack =3D params->extack;
> > +     struct net_device *dev =3D params->dev;
> > +     struct nlattr **data =3D params->data;
> > +     struct nlattr **tb =3D params->tb;
> > +     struct net *net =3D params->net;
> > +     struct amt_dev *amt;
>
> IMHO you packed a little too much into the struct.
> Could you take the dev and the extack back out?

Sure. I thought you were suggesting packing them all
in review of v3...

