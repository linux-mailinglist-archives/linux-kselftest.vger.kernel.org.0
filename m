Return-Path: <linux-kselftest+bounces-14491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D723894204F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 21:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2A2284967
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 19:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A35518A6BC;
	Tue, 30 Jul 2024 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPhkCUOf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205D1AA3C3;
	Tue, 30 Jul 2024 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722366490; cv=none; b=hTaZ6QftlwnV0AukdfjmLsFMm19wqtu66ffXnyO8ZNooTFpsReEcF7w6V82ogDZZuqJuiLF8/tiI8RLEULWKQdvoJ0rQwjtsen777xdAj7v/CrkJM6Ep17RBShfwWzx38gySgtLKa1z2Hs9XyEvIhf+8ggECEi+SoPY1JOUbpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722366490; c=relaxed/simple;
	bh=xWVqs2258UHmA+CoMjBHPne4eFNjGXP4z5/g3OSO1M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXZbOXMwbFetxiiSi1n0ATN8YXrf739nw0HRUV4hQKoefQZwWjDrVSuFDE1QCnSrZvn8CjJZkAPs5CrV/jS0vocbCphsYXHQyhxUWe/Clg9XiQTC5Fx5flFUWpIw4Kc1Sw+QMkwElnFPD61Bknkhe+GTJ3cCk3VE+mPMVYrYF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPhkCUOf; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cf213128a1so3053562a91.2;
        Tue, 30 Jul 2024 12:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722366489; x=1722971289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3dTVDxAQZ2aQnOrMxigVSHmZFXtubAHIkEkuQJGMu5g=;
        b=OPhkCUOfSBc7MEomf7HSM1CDP0AI0df5F/03vFSCLTKD07oX4DN9XEWWrMzXXcBV7U
         BCva7wA/jUCJ3o2FmXG6osx9kGcc7Zz/objFpjOx0xv5kp5PJYS+pSAYo7CO3EH/wrf5
         EXA+SueEVcE6fAwbliMxXPl1XprpQUiuE+9dNFqxamT7E+0sCfgHObt8Q+uavbq4ec9c
         s1rJluPaSBdfNFxUp2kDn4S9OVQjPCPa3Yg3+vvnVjp5mCMss9Dn466UUPk3kfF9NzA4
         hGqC62q85yOyf4TWC7euocuQeY1y8lm06r6VD3rvwqaNb/6THPs77gCavBG6vrNswSJu
         C/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722366489; x=1722971289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dTVDxAQZ2aQnOrMxigVSHmZFXtubAHIkEkuQJGMu5g=;
        b=oqgZPOY3AQBg+LBzoZ0v18wgUZiVdcwRXvVJ8R6NEU0/HDThT3U56gfPB97sNpAxbS
         2eEsnyXdsJ7Z9FFXs+2MJlcHQtrU7QOA3gzWlst6VJow7Z2DM7JEvrttm5f9woPrK+Ls
         bh2YduLMLl7uAEvrUbRmA4C0PMXmG6HKrKP8GMKFmWSOU025Le7nB7SvQH44uTL/ZQHC
         gXNFYwiGhc4/IQ+ExxgqU+5Vtrp+2ZHRIa8evcXi5KZs0WyS4mGdg8GsxKrug9LROixo
         Gt9Fp1Nigo9ET/2Uo/dwZi44om96GO6zcmkWFbVxfFVLnCleyjTijSADesLxKrcuM00F
         KxOA==
X-Forwarded-Encrypted: i=1; AJvYcCV+zpURbRKdUUC2jwPB/TchM5NwDsLLlwLXDnzFa+iaFe1J/iMTIhGcRKzMAup+TxGFowHa1L99X33O93xafNAWUHoVrsTdc/Q8aIkE2l3XVV8nNY7Kkg9VGc8fTuwbgLIyZt58/yGKiHdWBn2iYt4HMmOeXY9hGC6G20KqpVFX/270seT2
X-Gm-Message-State: AOJu0YxuMJ+3ehnSSYHFVaie8kFR99OvyNFUpCgrQqUYe0ga0kFX+Erp
	INbgljDlX+3RP4A7FpK7duhwHEExAoCvPNyGk4jl8Ah9HTlROEvAPx9YHv/jM+GN4YyY8vKcsSJ
	j86DkVjGQekQDZxK48Em3R/uglNo=
X-Google-Smtp-Source: AGHT+IGNJYK/Ium/WCNQzS+rP7PQrChYbiOyOCwmjvXXunxfEbdjCBMO21zU0d51BgrfNl6NbgST69vFnsNcR/rjtX4=
X-Received: by 2002:a17:90a:fc98:b0:2cd:2f63:a429 with SMTP id
 98e67ed59e1d1-2cf7e726968mr10165297a91.35.1722366488760; Tue, 30 Jul 2024
 12:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-tcp-ao-selftests-upd-6-12-v1-0-ffd4bf15d638@gmail.com> <8c2835ed-9066-4adb-8f8b-f38416d97849@redhat.com>
In-Reply-To: <8c2835ed-9066-4adb-8f8b-f38416d97849@redhat.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 30 Jul 2024 20:07:57 +0100
Message-ID: <CAJwJo6bzq9qo6i0UjqO9Ma0jdTedFS2GQNtQQbPzLUCg1a49Bg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/7] net/selftests: TCP-AO selftests updates
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 11:51, Paolo Abeni <pabeni@redhat.com> wrote:
[..]
> It looks like this is not well digested by the CI, e.g.:
>
> https://netdev.bots.linux.dev/flakes.html?tn-needle=tcp-ao
>
> https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/705502/8-restore-ipv4/stdout

Thanks Paolo!
I see the 2 issues there, going to fix them up and resend v2.
I guess, I'll wait a day or two to be polite and less disruptive to
netdev testing.

> BTW wearing for a moment Cato the censor's shoes, I note that patch 1 &&
> 2 commit messages are quite more informal and less informative than the
> average;)

Yeah, fair enough. They are pretty trivial, but I should improve the
messages there.

Thanks,
             Dmitry

