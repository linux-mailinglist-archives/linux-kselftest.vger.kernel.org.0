Return-Path: <linux-kselftest+bounces-39272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 182C8B2B6F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 04:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C07F1B65860
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 02:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB23287507;
	Tue, 19 Aug 2025 02:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJCbDcVy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C246118E3F;
	Tue, 19 Aug 2025 02:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755570487; cv=none; b=sVXGG9uHU578C+sl7VfZRGrZrrpsZC47LMvgp9rJ4Pkjo4dZUizLbVNkJSyunzZbcsaxtLaaE7j3l6/aIiaLXXEvUTVvOMu6Y2n2lCkHioJ0dz3mw1EnLV5b6peXpnvu1ZB4fCRrfdDISc1ou3ndZMtyCWxH+72CFv0mSdEbX3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755570487; c=relaxed/simple;
	bh=pMZLh0ErO9L7/l2fEtxtjWSNmkkb0U3sFRWnIMzmtoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfOUbxKK9l+5IYYecy9qQjaTs2lHTSMC7qblEiylJF0HwSsL2jaBw9EJz22AIwui+WYSzrEahW8fhO6Hs/hg95uU8wipCIX7SrgwxLXXwQKT536cVkAUQRr4QYZuB190OnQr00oCTw0R3FYMYyxerxYn3WcfozNDiZdX1xGX7Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJCbDcVy; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-50f8bd5ea75so1438970137.3;
        Mon, 18 Aug 2025 19:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755570485; x=1756175285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBu8fyb/ZfQIoFDSaiBFKOpNGRZh+wdN+S+969V7hR0=;
        b=JJCbDcVyySjT1NP5cTqnV1clO4/RSsqa8l+sZ09eJ8me4TROlnH20FIttdnzgCH0lS
         1qPf3EQFUUmZW5OhAJel8xriN39hfq61O/VqU0mbnG892fXieiprZ1WaBbwPG/ZGxtC8
         Y0bNeh6EoLwAvMkfTc1zNzH0WqTYxB1Hck81YI5Zab+mSMKY3MqHdzMMwicxXOWq7DsY
         LiE/ukeWi6u9TpIpzeEz8+6u3ep/VAGy/SPpGMsSuw3g/kuTs0XuHynXGaDbBVK7tCXt
         hYCPyWKHZltAclFjRVyXpBzBWBjlEQDxVpXB4Bbr7GtpkHxRvjZouKW6xwLc542evQ4Z
         AFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755570485; x=1756175285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBu8fyb/ZfQIoFDSaiBFKOpNGRZh+wdN+S+969V7hR0=;
        b=ljfaR8c4xkJuliITCptlKnFNa5e+wJUX0qLHJ8XTb7vhQCenj3ehFmCcphaMFs/R5V
         oDr31OEnQvlrkdmLB956lEBwZtDLhTIc+XyzM0bHyaL73ajeukkEdhWpbc6dwMYszBjn
         riKCvA72u4PeI/TPnK9Uek8Kdz/HM5m3BVQ+SH6cxoSL/x+SSgg4KiCAT4RmVMwzhTsg
         BcQ5bLVREFDzsKRF5D824QzJNJcrvH0lZiFCWMRUrYguaF+mZmt60WxDVyrhFYL5FCtj
         DPlqj+PN6roHNTuCP3qSyLhQyAz2jKCQLytSp4WRZ9xk5SLXM41c+3qY1ZK9XjPQ7TPp
         zi0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUt1Skd+VCQr5ZisUGWzRD+AxKGlzfQYGGGpPjAkz+7ww4MOtQsj7Y0fL7WWnJpZUbuI7fWyPN5@vger.kernel.org, AJvYcCUxretbnl+pNOyqqXoFwR5C78SvSwd637N8LbmxXj1jo2zmJNh8PuMDpzE6IFjXBfOdKZFxkLgdSC2mRbA=@vger.kernel.org, AJvYcCVPR6OtSIlPTB1i/KgtRTYX+jFKLS5wPk9ILJ4Uw33ZZ2iKN/KjsqrKojbUeNc6Rc3ipgOu8B4K1U9kUtg+wfVC@vger.kernel.org
X-Gm-Message-State: AOJu0YzDPqLA2u9As1MsuYy/cjkYUNlWgKMZbPUSRdqj9JXYiGEV8lrA
	goOa4f73tSrDJ4NX5dllyUCpn23p8ZWAYJFH56OtDEHUhAOisTQCbVcWfwSOUxndz/k9ZP+yej+
	dlN/VuwfCiMjMOzaM2ekl3IklK2lWgi4=
X-Gm-Gg: ASbGnct+8usHQWkNOPDvgD+URj3AEPZcLYmI5YO2FXXJDKdY23bVfuOvr5ezD/gU4A7
	tCVL+Ra52PrzhFX480nLT8DGnBBSdzzZXcFnmM3fiAMYXPsNHMC90dTMeyifnis5Z21vrrT+06d
	qd+z8Ko+YYk8i0oFDosVjPbJmMuxqdRT0YG553zRN2ppTUn28Xb1doDdJyQwTkf++EZnXLvcIJK
	H6IBXY=
X-Google-Smtp-Source: AGHT+IEuY7si+OaA9HP1T5nqxoaTaLB1ycm2StZKBXsp+IF9nZCgP1Gvy65TIuwaicovOIeD39ip7MgYYVP7JasLc2I=
X-Received: by 2002:a05:6102:2ad5:b0:4e9:b0ec:9682 with SMTP id
 ada2fe7eead31-51923e3253bmr266375137.24.1755570484648; Mon, 18 Aug 2025
 19:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815060631.144471-1-alex.t.tran@gmail.com> <20250818173515.1845a785@kernel.org>
In-Reply-To: <20250818173515.1845a785@kernel.org>
From: Alex Tran <alex.t.tran@gmail.com>
Date: Mon, 18 Aug 2025 19:27:53 -0700
X-Gm-Features: Ac12FXyqU6njDi1XsjYtUzR2J0O2588L-ybyjXnwfH1CZceoloiBKKGe_ADRI-o
Message-ID: <CA+hkOd4T1rNymXV1C+kf78_Z+Bie59q_uMsMt_bOrvsPn3EqZQ@mail.gmail.com>
Subject: Re: [PATCH] selftests net/socket.c: removed warnings from unused returns
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review! I'll send the patch v2 with the adjustments shortly.

On Mon, Aug 18, 2025 at 5:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 14 Aug 2025 23:06:31 -0700 Alex Tran wrote:
> > +     char *err_message1;
> > +     char *err_message2;
>
> nit, how about:
>
>         const char *msg1, *msg2;
>
> ? And then please wrap the lines at 80 chars.
>
> >       int i, err;
> >
> >       err =3D 0;
> > @@ -56,13 +58,13 @@ static int run_tests(void)
> >                           errno =3D=3D -s->expect)
> >                               continue;
> >
> > -                     strerror_r(-s->expect, err_string1, ERR_STRING_SZ=
);
> > -                     strerror_r(errno, err_string2, ERR_STRING_SZ);
> > +                     err_message1 =3D strerror_r(-s->expect, err_strin=
g1, ERR_STRING_SZ);
> > +                     err_message2 =3D strerror_r(errno, err_string2, E=
RR_STRING_SZ);



--=20
Alex Tran
alex.t.tran@gmail.com | 408-406-2417

