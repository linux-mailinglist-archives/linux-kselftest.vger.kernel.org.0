Return-Path: <linux-kselftest+bounces-42629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7917EBACBCF
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 13:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329E23B4C58
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 11:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398292F363E;
	Tue, 30 Sep 2025 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlSu87lr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E526FD86
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759233455; cv=none; b=JkQA7uJjD68Pi6oj4Gn/wG7EPohnZGCHtt/+1TcLlcOvHFA6uTB0xCBkmw9fATSACy9FmIExZHeEktFmrntaOmmQyEQ/xhTkXvsYB3pBzkoSkJeAo9Ck0s63eTf1TSI9QSIpHoZUUGkezmrncsYksebMLW4W8MovsKyon/0CgMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759233455; c=relaxed/simple;
	bh=kqh94AtRdnvNOtGrMAnDMgdoDLSE5h0RhP/RH4pYhF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHUONVjPhOynQFpcxuN3nGyTpdbHNUpf45+N8fJDkpi5n4c3CeD4LL2vitYkNw1eU05Jx58X3LjYNdYqF9DCKZxwDDCDYZcQBTKWZEQx5U292Y7nu/E/ChNJKQIUw/kO7HbzKqu9tqqWMClbrLvCAc+hcnIN9KavOznGzbwCwgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlSu87lr; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7a16441so953676866b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759233452; x=1759838252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqh94AtRdnvNOtGrMAnDMgdoDLSE5h0RhP/RH4pYhF4=;
        b=JlSu87lrBGp51zsJOfS9Gtmj29SnA4ufqCSxSgHLG/eerN4NAGR0zwFC7Vn0rRPmGr
         lfVXhT4I5SLzKGbFeyhTPLIki5kJryEdq6lqeZibAhgb/goZkpLkO5idZrqNj4Xwdfgq
         n+J68h9pG26lJcNOrEZGolrcmJLF9TTGyevKASMmtAi7VMutSl5dHEyFdjTzleVzU65i
         65v/+tpc7UINF+ghDj6DUn5uXatBBuk0K//EfbskD7pdUD/kdH/BNThSVtsYM6dltJbl
         dX4q52N9EaeEAY+hgi65d7EiMBoHYHnpAA/RyB9R5iKlBmHHEbuH4+rhyjaafxJtyF2I
         UwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759233452; x=1759838252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqh94AtRdnvNOtGrMAnDMgdoDLSE5h0RhP/RH4pYhF4=;
        b=RmmjWJKN27xvRLUsytfcsR0z5MlzqJJIHc/a3WCqQdFj9M9GszV+nQwvm0B6DXCAuv
         UwbSJstQQVAPIL7AFyBhdiigrZgwreqelEC1ZVDoWivCUdZvMmL0r5o0pEruIAlev3Mo
         vrSCyvuHzN41muXCerCSR/x+zLL0u8sHuni3AIkx7ewzv3eW/DQQ5pOLofAD5SBfHNW3
         vrJzft85P+xz0GnhiwwYYwHyn68t2ddSFOm2PwHo9eS7zJzDOFizGDDjwJRsROyIZkOs
         GQau8AMseKWPwLfySj6DmFtDUH6EZKlNINTmBKMvL3J66oEis4xJ4WW1dyJr3FvNMrr1
         e4qg==
X-Forwarded-Encrypted: i=1; AJvYcCWb//b842A9xsxOef/KRwdTQhq+xOlY9ZkQTdk6kezs/deBlnqubsP3GwgIbXOt5mpZyTl+30ZKpj75z+Kvv5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BD9DxZl1YEN+tHAFeoh1kA+zQSTgZk8IHLN6LWf/AuSCN46l
	YFZv0YHzx6DlDBNaqTUon5/lhRwChao2tDIcEwI9ZUrs3K4CxWglUyd11yp12D1ZxgeUymrNxfm
	5eQ87wCOZv/xrDoRJPrqEtklgkKugRAI=
X-Gm-Gg: ASbGncv6c0j202bvd64VFlAW+u95O6bykFkylYB9mLkvLoS62QiAwIRHmwhkdQK9RdA
	W3MjvotrQSeGUvgy7hKgs5RmvNYpVPnqXYoyCucc0i9MTFW2yaGQNFusbA97pmlREp5NYDtL0oL
	3XzcDjG/H5EgU8qoCnD7Kpsc9TNOltGuZcER99V8/vABmTSAnD2+0ro4ERahLAw3z+Zc3AVltA7
	IbjhYQEu0J8X1V1gp5mQW1ISXLXlzSkvWF1adnHCdzlfX6UTt+ujje4kfWB7cNWt3wX7U+0zhEP
X-Google-Smtp-Source: AGHT+IFMtK7lQG2C6CXy0BdUz73VA5EZWA5GWFM67vubKVCmaj1C4S2cfo3XpGObqlbGqLwQb0CID+MEAVyWsVhI3os=
X-Received: by 2002:a17:907:1c95:b0:b46:1db9:cb7c with SMTP id
 a640c23a62f3a-b461db9dc6cmr76159766b.33.1759233451417; Tue, 30 Sep 2025
 04:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930100656.80420-2-sidharthseela@gmail.com> <a21498ff-4dd0-4b3a-9b2e-9b932b5925ad@openvpn.net>
In-Reply-To: <a21498ff-4dd0-4b3a-9b2e-9b932b5925ad@openvpn.net>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Tue, 30 Sep 2025 17:27:20 +0530
X-Gm-Features: AS18NWCxdvM572oUhIGZSez5YvvgrvAB2_xyu9_VKgGBmy-3EY7uowJXb-VjjF4
Message-ID: <CAJE-K+BrTdtXTF6VgRzen=YVmuUgU8ktu_36nXqc2vTF=u_vLw@mail.gmail.com>
Subject: Re: [PATCH net v4] selftest:net: Fix uninit return values
To: Antonio Quartulli <antonio@openvpn.net>
Cc: sd@queasysnail.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	willemdebruijn.kernel@gmail.com, kernelxing@tencent.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 4:50=E2=80=AFPM Antonio Quartulli <antonio@openvpn.=
net> wrote:
> Hi,
> Thanks a lot for fixing this - I hadn't see the warnings with gcc.

I am glad, thankyou.

> ret goes uninitialized only under the "if (!sock)" condition, therefore
> I'd rather assign ret a meaningful value instead of -1.

Yes, you are right.

> How about adding "err =3D -ENOMEM;" directly inside the if block?
> Same here.
> ret goes uninitialized only under the "CMD_INVALID" case.
> How about adding "ret =3D -EINVAL;" inside the affected case?
> Both values are returned by ovpn_run_cmd() and then printed as
> strerror(-ret).
> If we blindly use -1 we will get "Operation not permitted" which will
> confuse the user IMHO.

Alright, understood, Thank you.

Sending in the changes in v5.


--=20
Thanks,
Sidharth Seela
www.realtimedesign.org

