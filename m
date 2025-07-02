Return-Path: <linux-kselftest+bounces-36347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5F4AF5E34
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 18:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8432D1C43D2F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B7E2F1988;
	Wed,  2 Jul 2025 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjuvUP8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE82E7BB1;
	Wed,  2 Jul 2025 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472769; cv=none; b=crfhPQJ2cm7lj3xvker9U5V4/yikOtBM+GUY1OoYZxuNqe//gs8ZETXC0DqfkjQV83BCMBK672gaOKbLS9DdcqDm3cXhQH7unqcRntuEForYnmlgmHb08urDiSXUIUqmp7QQ70pn81fdE+lIgOPLwP/4p2Qr1pt98M9RgLK3/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472769; c=relaxed/simple;
	bh=Mj/eQDPsW7B/hVkR0pe5WwZLNFH+qA/UQyC8QBl9/CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=af2QltTmlVUiTuOjsTPVA3vhhs2BJguCybwEfuVaD2dUyvVU1Q5vSpaGJh2skLtwy0QsygzAK/9hltbLqruQB73hwCDCgwVu723ZA2K307yF3+ioxaJUGbBY06Wn5kB86B/LWaUj9iWsS7z8C4CgmwUktY9C0E6dpfyCi8m49R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjuvUP8p; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad574992fcaso794716066b.1;
        Wed, 02 Jul 2025 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751472766; x=1752077566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRXkeslkSF0Qc74wmKgpfg/jxaMx7sLomOmzHgyVDBk=;
        b=NjuvUP8psfBT5vgbtaap/fAf85YxuNkpw5+lo7L6iAV5F+1uwnPDiWKqwEREQe6LmA
         9I7LOasdkv9xNwMuOvas0p9uhxVnZkN206E5jr5RwY2IVykrIixHr9Vq58WfAfKhf/o+
         3U7YLVt1uStD0WiMYwtiDwOmRbmm1ElSvM9oR0f71SNWKa18aPoxkGgnKRECjoqpJYoX
         /qR9TBbEtDXbJx2Ecs6fn0TlkerNdntlR5Jrm17qPeAgU4F2lif9olJgzSGjK+dsHxOL
         Jlc9ciqTg9yQ9xK0nw2Ls5DHx1CIf6aowyXcJ0OOQLlCDt0lCbbeq00Ax1tNlCNsc8Xa
         da2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751472766; x=1752077566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRXkeslkSF0Qc74wmKgpfg/jxaMx7sLomOmzHgyVDBk=;
        b=qXeA6ZTZ6A18KacZ6i+onVojVgKdcWEOZiegAWkas+d+Os2HPRMt+DypntOg/GooHT
         RKSE44XQFiR3pPpzi/NRekCOw9Rm4O6dpAauiXTVMAJAsU5ODg0dZeYRkFm88kq6XoOD
         RJaP6Uu76drTLomzucscyo5F/0cWjSAUGUQId+gWkFb+aVsQAll6PIAxywISn4x3UMBf
         /m84uxhZhFMxS2utmg1J3kmcxqwplRFMH/SrXo2Rx6/xBXCE4/yASrPcz3tKhk5XU4wV
         6DMAqRhrvr19NJlG/EfGIKpkv2Wa0KZw2BHO8MasPzJ1/+fZ5hY4CFAEQtOJ9JMfUe/v
         0nYA==
X-Forwarded-Encrypted: i=1; AJvYcCUgYqAc0aYolampi8pLAG7s4Yhmry0j/hkby1+1FSxoxfSaPDQPdvmL15eSALTd5DSsfzKjMxV6+caVj/X0pmI=@vger.kernel.org, AJvYcCW4d8L2OmutlV1mfqB6Zi1kM2p9T+jX9PGEingDJwSAxvI/bDTvdOjPk4G0FuQngJQD8m+QyZ8w@vger.kernel.org
X-Gm-Message-State: AOJu0Yysb8YPKPmN71EDGlvp823O682m33s0ha8VNFHJjpQU5mL8oR1t
	3iJf8def2N+OkWY9/EoEM2wH/yv1bD7QcRg7urllGA65jGnUI2hhS120hPGwZu7L4JqzY+wwXbH
	3MQXH4dCh2kUC4wNClVaQcgUUeUngAHo=
X-Gm-Gg: ASbGncuS9JWJBF6LdJ74LEQWkbLSdy9NCo4sWlRqsvaAHLXl0GZtpcteYn9X8R8yXGO
	mKDlCK85LHL7IZFsEp1ZtxqbjCNZREhSwssxtWZNYR+en5eN3kU/7T6WLM4TyKcgoh6dKTaWwj4
	sHqApwjL7etxj+APyHOW8qudQy6eSNp53S0wwUV9hlJGUL
X-Google-Smtp-Source: AGHT+IG33YLe/sQSJeQ8e/uoaMs26Edj5CsoMr4/1UDSKPXKBeRzHr4jOrfHL0TXyDcw/+KkR4+sEBzOmtxVFNg8zbs=
X-Received: by 2002:a17:907:3e1c:b0:ae3:bd9d:2c46 with SMTP id
 a640c23a62f3a-ae3c2a94bf1mr376909966b.14.1751472765435; Wed, 02 Jul 2025
 09:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702104249.1665034-1-ap420073@gmail.com> <aGVSMYsoMvlBPtC4@mini-arch>
In-Reply-To: <aGVSMYsoMvlBPtC4@mini-arch>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 3 Jul 2025 01:12:33 +0900
X-Gm-Features: Ac12FXxJ0Dh2MI4BUNdjhDZoQuvGJzNAkGzPl8q4eTHLp4Bbv9enOwOqAOXrvhs
Message-ID: <CAMArcTVYyGWAY0B1mem2nosQk1sJsg5nq9Uz5qB-wa7MFsqt7g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] selftests: devmem: configure HDS threshold
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, shuah@kernel.org, 
	almasrymina@google.com, sdf@fomichev.me, jdamato@fastly.com, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 12:37=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>

Hi Stanislav,
Thanks a lot for your review!

> On 07/02, Taehee Yoo wrote:
> > The devmem TCP requires the hds-thresh value to be 0, but it doesn't
> > change it automatically.
> > Therefore, make configure_headersplit() sets hds-thresh value to 0.
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v2:
> >  - Do not implement configure_hds_thresh().
> >  - Make configure_headersplit() sets hds-thresh to 0.
> >
> >  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/=
testing/selftests/drivers/net/hw/ncdevmem.c
> > index cc9b40d9c5d5..52b72de11e3b 100644
> > --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > @@ -331,6 +331,12 @@ static int configure_headersplit(bool on)
> >       ret =3D ethtool_rings_set(ys, req);
> >       if (ret < 0)
> >               fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
> > +     if (on) {
> > +             ethtool_rings_set_req_set_hds_thresh(req, 0);
> > +             ret =3D ethtool_rings_set(ys, req);
>
> Why call ethtool_rings_set again here? Can we move ethtool_rings_set_req_=
set_hds_thresh
> to be after ethtool_rings_set_req_set_tcp_data_split ?

I think tcp-data-split will fail if a driver doesn't support
hds-thresh, even if it supports tcp-data-split.
So, I separated them.

