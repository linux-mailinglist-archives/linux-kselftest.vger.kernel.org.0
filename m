Return-Path: <linux-kselftest+bounces-8831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FBE8B1889
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 03:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C825A1C21C2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 01:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7EAF9F0;
	Thu, 25 Apr 2024 01:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G26FYc8y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FB310A16;
	Thu, 25 Apr 2024 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714009438; cv=none; b=DojCCGwHm7aGnjefpM1K/Go6Uu+3ZATKPzBsa3PkguG0/lDlpZoQen7YWmcHFVujOIWySpU9fnL/LNteyrlJwSWerKkMPWw2QP5CDJRxpiH3fXKMk4Q/5oVOlD2neJobZr4EeIEY17HkByN2IDWsPgEZwJeewXgQRj3MN96gVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714009438; c=relaxed/simple;
	bh=fNOjgKxmz6/XvU4Sk5V4cQmWoQN4xmUGSdy00ZVGpsY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KimOwImmQ3eCEsOxiFfrNT2cxk3zFSvWqBtcPzCC46aOnH5NU/uYee8BkUKOonJkJ+Ly9YJmLBPUFU8Bvy9ifDedGQ1JsvdIiy4gg0a8R/cEmdur79B21qt5SS2vXdilrZhNazMHMHJUKnz6gOBLlWkGNxqo6IrxG3fJHxuYiYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G26FYc8y; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-437274f3bd4so5336141cf.1;
        Wed, 24 Apr 2024 18:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714009436; x=1714614236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DL8Zijm8xfKunCI2j8BQiY+QhLbVEzSZEL3FU2+1KEc=;
        b=G26FYc8y7EfSAeG4oO2YRirM6Ew7+w87heTgmN3nEzzUVlVN7VT4qNg/17VhvFQrNq
         DijF5FQZ/isocq9wDHWoUZPkBvH/H6SXhmZQ3rBWnRzENQf8Ra/uVP3pdy6T5YrAO/jf
         QL3Stnbe+B3+e/44mOApKLuwqkcG0aSBwyh+63LvS86uE7VDGXcyzhYrlAqFEaJkgynw
         wI10KHWP58+G7SyGG01wIsXK9Fd1Ye7QBZVQZaf3HQnrKwkJUiPvGy8nZKeW6bHvP8vF
         LMKfuyJ7YRlF3LuvLNmV6U/gRgqdGOA/lHUUlLWOumhMGQh2077ganp5DF5HVFgnkZd/
         Ko5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714009436; x=1714614236;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DL8Zijm8xfKunCI2j8BQiY+QhLbVEzSZEL3FU2+1KEc=;
        b=Qgqfu1Yd06CwAbSkrX4n+1q3NAIUWQLd2dbluAMJvpPWg1VAkXPMSqqt3gsmgBcT2R
         xHASPam8FDhEMxBHUMo0w3dRoyzzYtRw9grCIW1YV65cKFTlHzUOlf51v+RWrOofjqeb
         2BdaKvNEzbzRlyJrX2ZlddRldB5EymMWshqCZRPEjdefVzKP4DVTkqFu4A54k0VbQn34
         HSWxzZFHZ43ZX++ethxFeZ7+0hPqI1YG2nTv0Sa1mTBXrj+WBh22P92nZr6xAT+KboYd
         Mygl3bwdlj98aJoNiRUVjHRmnrzmqG4V5fsvIYblQJyfFkAyybyF0MOqQtWwraVX9TSI
         wVBg==
X-Forwarded-Encrypted: i=1; AJvYcCWgZJFurut+gb8Ye7/cfd9eb7kiFsNM0I0hzJln/opHg3dSmh0S1o9SjbymN6QqB4G1LHj8Rp07OT8qyrBziG7m8nIP6vcGWS3RDigeheFD
X-Gm-Message-State: AOJu0Yyn6+cer3JWnx+zO9PH/GN743oiC0KQBU5hMd0uUAfEi122/Q8O
	BuaDDrV6Oyyfy9C4qjmGX/XgMs/6Y2gjHajh3sP/bGHCW7DEK5us
X-Google-Smtp-Source: AGHT+IHj4TVBSXkEznMmNPbQ1QaQFiIsuGqpKZPfGJvRMKtR6izb7aEg0yASUiRdQtQJJlTOhJ+A5g==
X-Received: by 2002:ac8:5a46:0:b0:43a:1377:60f5 with SMTP id o6-20020ac85a46000000b0043a137760f5mr2090874qta.12.1714009436355;
        Wed, 24 Apr 2024 18:43:56 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id o20-20020ac86d14000000b0043842dc662esm5323949qtt.4.2024.04.24.18.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 18:43:56 -0700 (PDT)
Date: Wed, 24 Apr 2024 21:43:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 linux-kselftest@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6629b55be33b5_1bd6b029419@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240424221444.4194069-5-kuba@kernel.org>
References: <20240424221444.4194069-1-kuba@kernel.org>
 <20240424221444.4194069-5-kuba@kernel.org>
Subject: Re: [PATCH net-next 4/4] selftests: drv-net: validate the environment
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Throw a slightly more helpful exception when env variables
> are partially populated. Prior to this change we'd get
> a dictionary key exception somewhere later on.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/lib/py/env.py       | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index a6a5a5f9c6db..fda4967503de 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -88,6 +88,7 @@ from .remote import Remote
>          self._ns_peer = None
>  
>          if "NETIF" in self.env:
> +            self._check_env()
>              self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
>  
>              self.v4 = self.env.get("LOCAL_V4")
> @@ -143,6 +144,25 @@ from .remote import Remote
>          ip(f"-6 addr add dev {self._ns_peer.nsims[0].ifname} {self.nsim_v6_pfx}2/64 nodad", ns=self._netns)
>          ip(f"   link set dev {self._ns_peer.nsims[0].ifname} up", ns=self._netns)
>  
> +    def _check_env(self):
> +        vars_needed = [
> +            ["LOCAL_V4", "LOCAL_V6"],
> +            ["REMOTE_V4", "REMOTE_V6"],
> +            ["REMOTE_TYPE"],
> +            ["REMOTE_ARGS"]
> +        ]
> +        missing = []
> +
> +        for choice in vars_needed:
> +            for entry in choice:
> +                if entry in self.env:
> +                    break
> +            else:
> +                missing.append(choice)
> +        if missing:
> +            raise Exception("Invalid environment, missing configuration:", missing,
> +                            "Please see tools/testing/selftests/drivers/net/README.rst")
> +

I suppose this could still reach the exception if a file contains
LOCAL_V4 and REMOTE_V6 or vice versa.

But this is best effort anyway.



