Return-Path: <linux-kselftest+bounces-38797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25456B22E8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BC93BA8B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CB42FAC18;
	Tue, 12 Aug 2025 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AGqd+B6S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE4E78F51
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018196; cv=none; b=AKmTxoM9uvC8TwDbuCzSCpWWekf6Hf9sjV0Y9/VI1PM81FaFR2zbU+jU2swALOD4OTWYY0p8u+QsU/1w+b26H2xOGmUx8IUTdGl1K9AZSjbtHSJRdpEeOXzbAbpVQcyK8FPkbnn/BzdDNRe+S3mjxFx0PLVaxKpSxGk7IgACTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018196; c=relaxed/simple;
	bh=OWuuTvMfPyA+107W7mBI9T0en4MRUWzU9Hz6iht/BAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdIPWJZeHenXOuTV8j1dQKu5/yxnTrfLfJUo0DliRWXaUm3NRUhitod/wznz/Ud3IM7CigB5kLtE/AGj5E9hc95F9Q1j6KXd2GO/AhTFOtGt3MY591GoJwY/8OydEP3wFTp910D7YhJ02Th7Dbg7iogQEOpbMe02X4PX1//rVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AGqd+B6S; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55cdfd57585so434e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 10:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755018193; x=1755622993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmMKlUXAZp3eKZ4PwgQ72Z7vvc5pT/7V2A2LMb9mhe0=;
        b=AGqd+B6STjvYl/IHnh6SGv4txrr+TsUEOWo7KIlv1a1gowHO0FOHoAdz7Dh6UwmHLs
         q+yBHQ6YRqyU8Om/mNbrAkunjCHbBGPgaebbxdkein1vIUm1EbT5O+RDs8SwZ8ekKZ6D
         bb1OXiHGQ/M3OEzvKxEPBArEam5/xOGEolJShLuJoF4UxEcWulHlQgPx+j5XQ0ky7bzW
         6Gi45Ua01l1MfhE5wMUa1wh5ZtcT5FawN1ChpIg2IfcCo8KsfqemgH5bX02YYJYixmGg
         aN+g+0PRdZdYSpl8JiIltSjWeB/HNU2eaKeQtUB3TonT2GESXrA8kSiGgL7FYV2E0Yo9
         SJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018193; x=1755622993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmMKlUXAZp3eKZ4PwgQ72Z7vvc5pT/7V2A2LMb9mhe0=;
        b=LS2dfOip618eMFXtTvpM7skLCknfTB5u/x40gVxRqRzjEBv5EDwL2X4Kd10BkQl4Z8
         GFjCCZq4Ilxx1JI+rNdyvoSbcGD4sC8SvuKH9Mp05yR7WXRvka083Qzo+sk8sSPMm5mW
         9Q6F7foBZF2HiUT3cH/jhemO9q8a003drQwsIBoeKLzoQa3qJFVl/WV1EdEu9C2fQkl8
         c98FlC5S1T9GNuQfxTVFf20NtXraSCmBBb9qYU+1Y9lgml/vwn6lmNqj53kpm+9lUg2/
         KiAVM4lGBhixmlskmpZuUoMXW5zHUeTWE8dai3QaJaTuCBwTialY+CQnNWaiSNCRmzBM
         Miaw==
X-Forwarded-Encrypted: i=1; AJvYcCUemQJWY0TF5+scfCRr0d2bD/mSVu22Sb7IYzE6INzcQI1+x/KQHR3uEJBufJCwZL4uZ1iDZjqQP9EFpEVh/GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOvJ9GQ99XnBX3AKRNLw1y5li0njaBw2N6WglxNGhz/f8LaTo0
	+I8OXGMN+LRbxZUjo3ZijWAEuml8Go75mylQRQjrwlHUG78JlEQvqx0IsMgbeoNY9JKHPqZOyYT
	ka1ongWfr90hrrChK2QP7ZjhpyDevXNlNu752yn1U
X-Gm-Gg: ASbGncsAZpY4VUmtg8bh0loTMhdLX7C6rMb01fXEtEh/SVt2d91OB+S5d/NGzpP1zPH
	QL+cHWRUrPyLinXMeMmxO2tAkMPoXASE1PGG63ZsgVToj3U2Hia5xa0OSp2MkTLOPncbjkMOElY
	UoSdpIx5oYw56SZ38FEh1PbnYAXWGQHdBTFY4iMMgt/kpUUJHe45ZBtiTMJyslil9fAPpv97cPm
	qCXyrhiNxKbruFSpn0UyTbnwv/gsFpWK40nRkZnVglfH6RW
X-Google-Smtp-Source: AGHT+IFhtF4CeSf0xkbpb20x4AxC2mCxdHvNXx3p+5yro8kmMD5Y7rhUC492jZT6952EjCndfu7lMsaPU9kKTO+1tz4=
X-Received: by 2002:ac2:4f16:0:b0:55b:5e26:ed7b with SMTP id
 2adb3069b0e04-55cd92926c4mr447320e87.0.1755018192643; Tue, 12 Aug 2025
 10:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811231334.561137-1-kuba@kernel.org> <20250811231334.561137-5-kuba@kernel.org>
In-Reply-To: <20250811231334.561137-5-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Aug 2025 10:02:59 -0700
X-Gm-Features: Ac12FXz9hgUmCbmNnyGlQXztiWauwAYP8otTJ0HXPRbUpIkQERsnZD1mo-yj4yE
Message-ID: <CAHS8izMbL0Yph4JmG35svABsuB5D_GwrvZuDiHLZ-TE4pwC1KA@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] selftests: net: terminate bkg() commands on exception
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, noren@nvidia.com, linux-kselftest@vger.kernel.org, 
	ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> There is a number of:
>
>   with bkg("socat ..LISTEN..", exit_wait=3DTrue)
>
> uses in the tests. If whatever is supposed to send the traffic
> fails we will get stuck in the bkg(). Try to kill the process
> in case of exception, to avoid the long wait.
>
> A specific example where this happens is the devmem Tx tests.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

--=20
Thanks,
Mina
Acked-by: Mina Almasry <almasrymina@google.com>

