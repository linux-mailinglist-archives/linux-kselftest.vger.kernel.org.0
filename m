Return-Path: <linux-kselftest+bounces-48690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FC7D0F9F0
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 20:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7789E301880D
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6BA352C5B;
	Sun, 11 Jan 2026 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwZEnLcV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D375346AEE
	for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768158878; cv=pass; b=LmecEFfNmmAxDJZ9/RnOgjnCwFX0/W7Yy7wTPhdzxiMN8Vz9/MTc+X5lkhlb+jMOJ+J6xhLEUfAXGHGe9bUB/DJz4AKkQ94rNeNJOY4bxJ9xtj6FAuwEaKhgSK/rvXlKMAzaaa3Cq2K04x5rnFbv4GT7k+4S8dIh5DqpchoMeKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768158878; c=relaxed/simple;
	bh=k6AlMVy9ciJTJpdV8gMWZ1nSB+n2ZPly1UT3btHq6go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyjpXPhzq8AvIsThtTEZWfh9bc9QFQXDLP4FJFNI0wawldbY+LK2+lKnW/QICypJpxO7XwRAK48txcqSXov7y9utCeEBOOHGfGYXwLDuktr/rysGNwmrtoGR+HAfI/frHYjiP7XaP1CIAkMdSdSFRAzWnXVS737t2Tu6MrGAyZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YwZEnLcV; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59b6935a784so3680e87.1
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 11:14:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768158875; cv=none;
        d=google.com; s=arc-20240605;
        b=atSfY4nCrzyr0hahvlTducX9FAhWU9ur4QMn0fOa6HxEEnr/2Vd6x/3TbMF0j24lYS
         HGFX3fCTizM9rj+6F82wqdU1dyPzGAHOG1XeRE6e6/RAxzESjMusU+Ibe4152MkGKHTQ
         IJsH/AsQB5Kt/7FaIkbv67fWw92fJMQork7LhdQlgKYuQjds+H906vKieOjSgbGA8V9V
         aDbUa6cKtbCMGzG/p/bShcwxJZdzcLW/GxaV+8+6e0Ivb57m0Plvfs+dsD0NogZCH1EU
         xKBMxb5ROmtjofE0kYsm1ReqD34mh8PrtdCzIvr2GSF8iu4nXF/scfKM8dF3whCK4JrK
         EOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k6AlMVy9ciJTJpdV8gMWZ1nSB+n2ZPly1UT3btHq6go=;
        fh=jK2BrRuhW8A0U/O9FmXFC0eJx0GeXglTArG3kE14gmE=;
        b=QVhXHFENHeId1+7I2NDpJa0zoS1rHhf5BYixMojXQIaVH1w64N+d3dTBs304n/Yr2q
         6Lc3nrSHA6S5sSHEjoFEVas4GBVies1K/bRWTKoAyjVpcjK3/xOmuiGiLQN9A4w5pTYj
         VHOSFZTbJYRi5kofLPsB8PXHdXdpkl0KW2KOHf24z5JVtWxJDDVeqjItu1xL49+1EiJj
         gO7SxhSLTgisssMYnGwo9vX0vZibAptBrBn8U5iDau02FBeqNRodUeLz84ULmhYdtWBm
         f8b80riPcfIVpJy9ij6/zASDZz51r8jRMg/IewEf5N9aM0kXAZdimRkaJrgsai6fETIV
         7Aqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768158875; x=1768763675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6AlMVy9ciJTJpdV8gMWZ1nSB+n2ZPly1UT3btHq6go=;
        b=YwZEnLcVqIzSeKspGBMgiQsamdY9J47OeszZkd17u2WGJZ2R3NDdnM1klKlKJ2hXCE
         dPl6Ja0ECKfJjKRjJCffz3Elfr1InkHly4OLGUNy5JQZoFDnHx5dqyDZckTk6S5co+tJ
         KunFm1p6UejfZGc/Mo+sXI8QO7UFESS9QVbkBgn0PsfnHG7vSWMjSpdTm/yuTPv1S22q
         yAOaG46N94oZrqFUPi8G41iiyr98rN5EDw7/sMKzBdWb3lhV4xOv/N4nTm3QEBg1T96B
         hkbOF+ukA7Lpg2ISpyXm9zR/eM2RqZIzhDy6r6UhK9ONN5oRQbW+RXDgZvZFelre5jve
         0fLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768158875; x=1768763675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k6AlMVy9ciJTJpdV8gMWZ1nSB+n2ZPly1UT3btHq6go=;
        b=dB/dEm1em6aHnCm2+2vhgVQjTvCcPh3BNNokbaB5YZAHiPlmT5yHs/r/+XjjNBrEeH
         cjOIF1AR+otFW7Ak95hLDOEWP1SiZIer1jdK/X1pV+PpjRV/6waDwmedywlwQheRbwtC
         fcQCX4Dcq6BfFUzcQsi8wkFc917SRkKEFGqXPBiCywfzyMBUJpQ8ehYJGdrdAjDBQoTj
         Ui05OAnPsv/xL0M4lXr6lnENExi++GCbEQe7KvjxCLNkUHmNiUg5fNmbwbR75YeSqjWQ
         4XTwndP4SUAjZXKO2RKiVVhPg/43F83iZucvTRs4NR6ooQmpfh7T3YuH+rNyQ2vqE+8f
         m4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkTM6cFlsCRyUWKcyrl3eB5haw7vwlRUNdcKrsX/mIY3jXFpp9sJdFOJDs04U9o/K9ljKVpEJiMn8w6n+Wwtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ3Rlc6pwwJ2aglRx9DKwpNf459xGsDMQgiU4ZkdPP9D2pzKWM
	XxktiK/IuHBUKLtie0HoTyqcpOAN1csA+aHwBJyfJZNzHbTe1hG7goofxLmOYZwpVhtfoij6aCj
	mPu/S/wgYDYbGBuzVM4R9cIG2Tlo6zAq8Jsi39y1z
X-Gm-Gg: AY/fxX6F2cugI8l8ASIR48vcyIuEI6RDeaV9EJh3ZKubxqkP+LUkKAi+3abclb/B8tk
	GZcPx90/HMJRSBEcX1kCerJqxA3SvnkRPHI9V5MLvXn8dy5mzfMmOhj3sYSsqXfAetKjHUlTPDu
	ytWuc2TCdvxltVh4UqhtDDaRmFoiFp4/ue4aF5D3r0fMa4jbcR9w6pItxZeI2Gkm4bz4ZrrPW8h
	aEioxImNE4IfSltujfaqYmt37ud7aMah+eRN5+9em8kXDu7rXDUCJMCqC73M49SVLg9W2zjT0k1
	hg18gg==
X-Received: by 2002:ac2:5392:0:b0:59b:9403:c67f with SMTP id
 2adb3069b0e04-59b9403c7fdmr1298e87.14.1768158874137; Sun, 11 Jan 2026
 11:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-4-8042930d00d7@meta.com>
In-Reply-To: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-4-8042930d00d7@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Jan 2026 11:14:21 -0800
X-Gm-Features: AZwV_Qjc9N7obQhSR7tfjDnibSqsWsISSF4YswjnxYBiVBax_pCtfSgtAahmfw0
Message-ID: <CAHS8izP=udLS2E2ZCvY4dGu3=L+SnPVQePsh=hNaM=3gy=YtHw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 4/5] net: devmem: document NETDEV_A_DMABUF_AUTORELEASE
 netlink attribute
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 6:19=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Update devmem.rst documentation to describe the autorelease netlink
> attribute used during RX dmabuf binding.
>
> The autorelease attribute is specified at bind-time via the netlink API
> (NETDEV_CMD_BIND_RX) and controls what happens to outstanding tokens
> when the socket closes.
>
> Document the two token release modes (automatic vs manual), how to
> configure the binding for autorelease, the perf benefits, new caveats
> and restrictions, and the way the mode is enforced system-wide.
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

