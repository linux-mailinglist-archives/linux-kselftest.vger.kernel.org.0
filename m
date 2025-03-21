Return-Path: <linux-kselftest+bounces-29540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98388A6B319
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 03:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9793AA886
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 02:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08B51DF968;
	Fri, 21 Mar 2025 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW/4OWyx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94BA1876;
	Fri, 21 Mar 2025 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742525855; cv=none; b=Sr8Vqb+hzgyEhslxfktcXSiq3H4a26YaI3a8Yu8Mt9VG1r+JecP6+JX1+x0Nrve6Xocrh7kLyRq8rQEiizhEoOUQjfqR9ZXje5ztTfaDlRPcVkslBET84F9lbPzSSdTcSeoyVUmjrTb6EEyHmBPbOvUimFCCi3BsTxTukYcg/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742525855; c=relaxed/simple;
	bh=z00h5ZccuBaL/+cbY4BTvFWBuLSy7a3O8PySg1+sgEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=In4+0n1uHiqmr6sNRW+z2WzUVCtnwPWxSj0Q7kkP4fgjy/7kI06aduDyNQ07b08DPyKsN/otgm1oMWhqGMq7qSbTM71nMbHU7WTOzJqxjVtSAgvM5VYye6Er7ofUa4ec+AdwVXNAo5UOHl5xFYbLLbmUijOuShNXahTyFvgiMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SW/4OWyx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225b5448519so28584025ad.0;
        Thu, 20 Mar 2025 19:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742525852; x=1743130652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8EHp5t0i20unF9PUlSCsvUF3XIGotNl9hAodY6Jg+Tg=;
        b=SW/4OWyx1gBx/5xHYJq5sp5dUI+YLHfa3P143gjf1zJXBJK/FmE2qhcVlWr2xcO7rq
         KtImvZFgWCi5Gk9n+qYi2ZLQ1Uvr4xtWTf4IjDJDeaJ4nw5UagwYizc6U+sAx4wvo6w0
         LglNgYmsEwIi28f0RwwHAVhIuu75OHRN/LOfrLHPopf2JE2uUJg+ZBnq3JmAnYBk6az7
         a4f+raFVSeqxXbxj8aC1Nny1jUPDSvUDkkBSmpng0zw4LLCT7Cq2q7HXJW3/6ZuuEqUG
         WRWSqourOOFVUlZJVL0dUagx/QQHw/jyawHuFs+yQkfnpfIEybkfBG/lXbkBs/Ek+5Tc
         k1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742525852; x=1743130652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EHp5t0i20unF9PUlSCsvUF3XIGotNl9hAodY6Jg+Tg=;
        b=EqnSp4IiT/s6LoX0QRV13+LVeiGQOSzdadcRGVkT/DKKBlWRCcgr/Pkk6BzEbYIaKc
         9AXWNZNCILmhrzmsN7yY3Q1httkahpN2I7rOsY/WlZ+REmpeSIoR6ksQielfKPXmqYqJ
         /hNn3b3Q31OEx6lGm7FJYGt6tC3CoMLkElPs6sef9c1fbf0A24M3tiRZN6XLaIm7cIls
         AW6rLzJ1PtIO/Z7+atj5Qll2lQFB7FofMqXchHXYCN/wPB/7MwA81DbpXEO1CcKOww6M
         YplgLE56oWUweu7LTbRCu95mSe4Yj7WZfh865C8jdCWrjl5OKpXnkbLH9eo8wuHhOz7+
         J1lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnDGdeNzp9cRvS7MLfWsedP9e3WxpkcYOqeWNpeLtpHx+h59gFD7ulWunPoYQhu5NvyACc3o7j@vger.kernel.org, AJvYcCXDMMh+eaArU9zFe+KQ3b/tUcRWRdcMGNgPg3mQViFnE2Z+PwmJkerA504x+KYc4+NbkseuYJLwcoBygl4pHjjS@vger.kernel.org, AJvYcCXbHBz/GzBPFPw+tCFCz/IcaTxfgtDg6GmCQFRogp2fo/avB8Bs/kle+vWundlpMSxhZGgY9CCKR8sVmks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2Thi5QQY/Rrwh9mPm8hc+/7ccBsbHLo5KFpeOr18rCrLNp1b
	NQNzTWei40qkCHMc9+EJj31V2PqxLgUew9hyKRuDmnV2Aa+RVjcTys4q9OgL0O4bIfp9gtLi63R
	oOtKGuPT0ZOMJw2zBEBO0ugcPrEQ=
X-Gm-Gg: ASbGncsn88hEsCcDstz/K+lJJF13ZMMyBfZd3optzrXMNliUegBthy+cIdWXcVzCsLo
	Q3mhbVKAVyJt4SGpItoY3/nmlgya5AtJyOmGwjhnlDDZ7gxVCR7ZzWcCAa5Veh0UZ2zBBi9JYiT
	PeIT7RuCMs9O2Jmw6HP2ltDEYEvw==
X-Google-Smtp-Source: AGHT+IHqqWN6+ajO1aoK/OwTZYrxuIYCCIBXPSEsBEaXovcRuW0fTstyDicQ8DJu92TyLEAfFg+Jw2lhddhMiCHkQt0=
X-Received: by 2002:a17:90b:380e:b0:2ff:4f04:4266 with SMTP id
 98e67ed59e1d1-3030ff0da00mr2142555a91.23.1742525851890; Thu, 20 Mar 2025
 19:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
 <CAJwJo6bkdeGh0j1ABfrMQ3dRD7frEsNnJERWP8-jJs8dSYFwYA@mail.gmail.com>
 <CAJwJo6Y9g0JYiLY-taxtj7bo=Jy+U7bqTFsQjhgu2Re7BgaLsA@mail.gmail.com>
 <20250319-abstract-classic-woodlouse-66eef5@lemur> <20250320-fancy-chital-of-attraction-c7a096@lemur>
In-Reply-To: <20250320-fancy-chital-of-attraction-c7a096@lemur>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 21 Mar 2025 02:57:20 +0000
X-Gm-Features: AQ5f1Jr_MpnVghd8h5FM2vWxMUtRq4g3LttZUr_Z6sAGSLtIeZGZ_tXFITcrlMA
Message-ID: <CAJwJo6bQq1vWr+xQDnHK1aVzdXXSoh0QHuv9ue-OOutCt5epWA@mail.gmail.com>
Subject: Re: [PATCH net 0/7] selftests/net: Mixed select()+polling mode for
 TCP-AO tests
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: helpdesk@kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 13:51, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Wed, Mar 19, 2025 at 09:18:37AM -0400, Konstantin Ryabitsev wrote:
> > On Wed, Mar 19, 2025 at 03:26:27AM +0000, Dmitry Safonov wrote:
> > > However, as I sent the patches with b4 relay, it seems patchwork is
> > > unable to authorise me as the author of the series. Ugh :(
> >
> > Oops. We should definitely properly handle this.
> > Sending a note to self via the helpdesk.
>
> This should be handled correctly now, e.g. see this series sent via the relay
> yesterday:
>
> https://patchwork.kernel.org/project/netdevbpf/patch/20250319-rfc2203-seqnum-cache-v2-2-2c98b859f2dd@janestreet.com/
> vs.
> https://lore.kernel.org/netdev/20250319-rfc2203-seqnum-cache-v2-2-2c98b859f2dd@janestreet.com/

Thank you, Konstantin!
I appreciate your fixes and b4 development.

Thanks,
             Dmitry

