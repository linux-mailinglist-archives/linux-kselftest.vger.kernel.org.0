Return-Path: <linux-kselftest+bounces-36133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AD4AEECAE
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 05:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120123A5017
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 03:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E811D63EE;
	Tue,  1 Jul 2025 03:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvH0p/Kz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651A165F16;
	Tue,  1 Jul 2025 03:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751339139; cv=none; b=ZEMlRdLYGkQ+yVl41j8eaJ3e+iGnBzrCp7aHbKxtBI9YlMl/Kb0GXAahHKID/u2W39exXqyHzr/g/Cfs5xBcxiPmkDoE/fG9r8DWG96idudcph8TAHdXCh9tLmYLrp17cD3WUk2zX+hDizeE53x2cTIrcByHXZ5obkl4YgO6tsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751339139; c=relaxed/simple;
	bh=UnOhBZOD+Sy4hgWxp37CdPJ8mn8KKTgJDck3AguqNwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcWTibAZmwyoSNXvFt4rYvLUsfRfocF91acC9oJhUO7et9LUy96VPW12k2NeFbt/fp7buP45CK8Afp4YFGnGSAd2uUj80Oj2i9UYjRVyyZmSoUsVgO6aTdL3GAwX1cfUfjfLwfPGBnjtSPW1JNf8qf9q+wWA9hETDALSP7g8tl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvH0p/Kz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so8053936a12.2;
        Mon, 30 Jun 2025 20:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751339136; x=1751943936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbNKiMl4ADEtVuFaLA23mUObS8nQVO5HnFKy4PYoOfg=;
        b=GvH0p/KzomNyRkZd1RWD4IORr3ZTDws55eORTXZ3xuFrv+M74zjFq8jXEiTJg5AK7z
         iPT5ujjyLjZ0IuzhQI2MvwDnLXntjMuRWye2yb8jkuQjyvSDdwILlrG0qLi2vObW2B7A
         j5eQoRKNpz7pdCnWewEH4rUI9xybhVKqE7z/dSvB3jtk4kqUDWV9yR/7jvg07jLKvv8Y
         4nd4ou2XsD/onEMO0tn3pkIU7DSJNXGRN87ziEv8eHc9xC6VVxI6Cl/3fCyLQv3vKewI
         R9Rjp4cRPy/9mPsT3cYpfxpfuadsZLVjuU6tEBkiY6gvAIrsLQWBm3ePSNBtTa6l08TV
         pyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751339136; x=1751943936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbNKiMl4ADEtVuFaLA23mUObS8nQVO5HnFKy4PYoOfg=;
        b=av42veoyi8GWuuH/NJq+o5mSRayBd53jIppIr+j/zdEb7WdAeJtA582PfpQhk/bRql
         tksmW9X4Z0I2JM736JIHtYAkkEvfPLIjvGlWBEy+WpWyAS9abOLHgRV3bWMIPWUaREcR
         Tf2AtiIupFp+iZtNiiDYykwfEb65jHSejaMJFum+Xb4/BoEplSPoiZvePuJFsdV9Ekew
         dyYEPiJBX/s/+/UDmsaLDoGGGNXwqix+aSskSojfyjiqYvueticmVcy0uuRrnb45/AB1
         ecX2hqWZ+XGjoNl7XVPHFEr3iPcchOpNT0j4aaN4vrrbW+WBt55vO/0Yapag7G4k5hcK
         dtKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWrWUnnPIe09WJqcLKQWD7+peSJigItBlFuyE3OdFuQrdvAd1rKGrtEm15/JrFSvCZNTpHn3GZ8ykkuoqIhNQ=@vger.kernel.org, AJvYcCW3DX4QgNHhqK6YjKqXDiAENR4mT9J/Q7R17iZslo/xgZNUAkuW5YNZi3vXw+gf4PBs+Rn5Q79Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzpbyPKIR9pHWxjW6u1AMvNFBaihcNe65WYoj4MskR9O7SNGK0+
	AIQYS6NIFSJr5m5uk4pfdAwXmvZK3yqCvF88Ay3iil7NFIoWRkCzPeAksV0T2z1tcqyYNkPhU9Q
	My1tqaLny2dqpcrWVvpaw0/AXwBjI3Uo=
X-Gm-Gg: ASbGncsiZp6dwlzLYaTHaLMHoy55ii2Dc46A66mjVe8r2TnQSmYibKZVVZlESAWxOOg
	UOTX0fpMvimB9YzEaxAvedrGarVYLL7cXQzLyfl9EfMyVwTr+iBsGE+roKZuDy9tXiH5Hq27mpe
	zjsQscK1/8qSZJGUfJCUJA/XuMzjlFgNvMCzaaie6unasWCEzgsTAHI2XS
X-Google-Smtp-Source: AGHT+IH2mHvqd3veBQLL+5pvQLSiyUhSos3rcEU3A+2kHgdZT+OzU/86k2G4xotVZpHBBcxtz2aU5xPYvNpUhlnVGlY=
X-Received: by 2002:a05:6402:3549:b0:607:f61f:cc1c with SMTP id
 4fb4d7f45d1cf-60c8823bbf5mr12506249a12.0.1751339135376; Mon, 30 Jun 2025
 20:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630092818.1449599-1-ap420073@gmail.com> <aGKouujd9Y18lmQw@mini-arch>
In-Reply-To: <aGKouujd9Y18lmQw@mini-arch>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 1 Jul 2025 12:05:24 +0900
X-Gm-Features: Ac12FXzKhDLnJcjk6Rx3mFwWXn6PzW4NBKiKS3NeOrN0F4RrZmknBEdCzNFb4Jo
Message-ID: <CAMArcTVMRGCKF1y9qWEqAamTA+EOOr1FFBEROT0DtWenOHrd-g@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: devmem: configure HDS threshold
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, shuah@kernel.org, 
	almasrymina@google.com, sdf@fomichev.me, jdamato@fastly.com, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 12:09=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>

Hi Stanislav,
Thanks a lot for your review!

> On 06/30, Taehee Yoo wrote:
> > The devmem TCP requires the hds-thresh value to be 0, but it doesn't
> > change it automatically.
> > Therefore, configure_hds_thresh() is added to handle this.
> >
> > The run_devmem_tests() now tests hds_thresh, but it skips test if the
> > hds_thresh_max value is 0.
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >  .../selftests/drivers/net/hw/ncdevmem.c       | 86 +++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >
> > diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/=
testing/selftests/drivers/net/hw/ncdevmem.c
> > index cc9b40d9c5d5..d78b5e5697d7 100644
> > --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > @@ -349,6 +349,72 @@ static int configure_headersplit(bool on)
> >       return ret;
> >  }
> >
> > +static int configure_hds_thresh(int len)
> > +{
> > +     struct ethtool_rings_get_req *get_req;
> > +     struct ethtool_rings_get_rsp *get_rsp;
> > +     struct ethtool_rings_set_req *req;
> > +     struct ynl_error yerr;
> > +     struct ynl_sock *ys;
> > +     int ret;
> > +
> > +     ys =3D ynl_sock_create(&ynl_ethtool_family, &yerr);
> > +     if (!ys) {
> > +             fprintf(stderr, "YNL: %s\n", yerr.msg);
> > +             return -1;
> > +     }
> > +
> > +     req =3D ethtool_rings_set_req_alloc();
> > +     ethtool_rings_set_req_set_header_dev_index(req, ifindex);
>
> [..]
>
> > +     ethtool_rings_set_req_set_hds_thresh(req, len);
>
> Any reason not to add this to the existing configure_headersplit? Is it
> only for tests?

Yes, I thought testing code requires a separate function.
If a hds-thresh testing is not required, I think adding setting
hds-thresh value into configure_headersplit().

Thanks a lot!
Taehee Yoo

