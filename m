Return-Path: <linux-kselftest+bounces-46701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B57C9320D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 21:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB66E345827
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 20:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B44029C328;
	Fri, 28 Nov 2025 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da+eUEIR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6E31391
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764362650; cv=none; b=f5Adgs8jZydV7KLV4XpVHWve1Vcve5OSh0sfq/Vp5iMk81BhpxIqtN7tcy57W+wCOBxRvifWOBOhwXCS1L7CxOHr2OmbzUdjPI+QzAklsoKGxUqS6GHoTO3WLeJfYwABu7IztUqAw/472XQsahVH8+3Z5l/eWex41w13rwRu7b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764362650; c=relaxed/simple;
	bh=RKONEjWtCXcKuedr9wFHNDcMCLGG7Ccum/K31JfFUvI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=otuwh1i7cIjH6Ahqyx1znPYGM+AT41w28mzjSpZ2JUKjvkmlEI3cZfRyfQw4gL+V0dS1btSoVrt5gEMmfPdIBWH/cjckfR1dBJ+e+M7rLa+4S6whPGIpLPRTQRYUis26RnDEksYjAIYwib1nA2TRiFwkBoiYvWEFzLDORd9BJkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=da+eUEIR; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7881b67da53so21557557b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 12:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764362647; x=1764967447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3579fpvRdDByAHFJwL7M17Ky/UTPJOpn3cS9FXXfw6o=;
        b=da+eUEIR6KlgxHAYUzLUbXnwKidxt+dDLhim/zVNlHsdjHk/aqPi2gfrYMyfolKisZ
         a21WwydgDAYsjOO8Rpa+FAi3hmQxARiUbJ52Oj2ruJnrmr/kDLasCkVEHyePDeefpuxu
         y6YgyIpoWskaPm5ueuEgBUmCEC9SW0hnd8fx2PwoGzDDY1vLHDwLyeQbja17ULYy/YYH
         YTlTUB6RtrZyC/LvTtlAOAGW63xoHMbERpsszQwwbbSoCw7dXM0GQyxgn6Z5XkDMsFGb
         SKgNG1/PvXAMqQ91VcoFo0ycYLg4n972s2Pe5/NqjBQGMrWfkSFRF0r4wtV6q6tMPis2
         1e0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764362647; x=1764967447;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3579fpvRdDByAHFJwL7M17Ky/UTPJOpn3cS9FXXfw6o=;
        b=vd4s41PvzzRRH/jVADkB4qDBCbAbpt4k8k04f/GG5+X9prOG0svpaHV8maeqLzM1ta
         9xMso3neP1HZo8A7TBGnAGgLnYt3SSJ1GePhFjaSlJzWeAGdUL/DIybiTJJkRh2UecS6
         xZAOY3UhQSJHKFTyAk6e0IHxIUt0F4Nd2AMzcQQ38o/kFNROqT9H7YJ69DtsP0aKc5RU
         FZdbeWaJWrSntieIdiZZ7WqjxbF64SR56myjfSqQUNfEJ7GIopL2vYlIUZ4jidpvuQFh
         ZlrQAg6xnXEhROUCsex4N0gHgZq+RAfFoLB08ETWxU7Mz5O8CO3sMRPO6BGm2ymOfSx1
         c/ng==
X-Forwarded-Encrypted: i=1; AJvYcCW2sT23kUW0ggS5l/v634T0VN0zuDcfI+1bvc6dKJGfGMcLCA7Y1Uf4a7wNySHh0vzDZpVgPecGJbFQlsMxbjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywbEIxXDsiMvJMl0KHknPSgQDcASxzzmI2ZTe4cJuiD8dGnO2j
	Cl2bk/iu0F5eTNrkanlOEFelhX9geskR4NQnMDImsedzpQoVFR0BDpIK
X-Gm-Gg: ASbGnctsmHWHiPTb6xtzYjb331mdJYeIrAkRj174fzlRFWhszI3rYetguKedMdKDKEX
	23gmIu9wzNAOpx0m73BolEnspSpruIIhFuvNOJsNqlMdnznn7mPDq2ct4S3XreuOh14tAIWsolr
	BsSalThXbiG6mYnqLJU7z6rf9cDFAl64oj76bIZzD2BLjwLB6hu/YApkKisaq+MjW8XJgz1ucQG
	vcEKVHb3vXp9WkQ/l0tBeJ/fyQtv2NAQQRPD1a3uZR4faNkC+wWE3j+woPgUU19ncT6naXBDbyR
	dOS6mk4ifWpzAE5iDNqdBw6jmCsXCIlbGEEug3lnzAO8GUgUWRfeoHvJXJPI1ZNn7h1zU1Au2pb
	YCVTL+JL3knnXn6XGW87Myxff1BRhN5n2dvs5as/3JaHPCyCoV5WajWgPOUmlAd43kGmkyeHWmS
	SEpBkwTiQMItwehlVpCKhQXCuzCoen/Lqk67iK3KUci6TlVzVKEhnp7eTjNgB5u9LfhEc=
X-Google-Smtp-Source: AGHT+IGu3WRwQ31grW/pHvbyCQ48ZzjBut8XFoPTUW0YMmrEld0S7dR9C7F6VKFG6SPrFs235+X3Qg==
X-Received: by 2002:a05:690c:6606:b0:787:e9bc:fad5 with SMTP id 00721157ae682-78a8b538ccemr254718307b3.33.1764362647484;
        Fri, 28 Nov 2025 12:44:07 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78ad0d3f616sm18817477b3.1.2025.11.28.12.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 12:44:07 -0800 (PST)
Date: Fri, 28 Nov 2025 15:44:06 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2a528ef888696@gmail.com>
In-Reply-To: <20251128005242.2604732-1-kuba@kernel.org>
References: <20251128005242.2604732-1-kuba@kernel.org>
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: gro: improve feature
 config
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
> We'll need to do a lot more feature handling to test HW-GRO and LRO.
> Clean up the feature handling for SW GRO a bit to let the next commit
> focus on the new test cases, only.
> 
> Make sure HW GRO-like features are not enabled for the SW tests.
> Be more careful about changing features as "nothing changed"
> situations may result in non-zero error code from ethtool.
> 
> Don't disable TSO on the local interface (receiver) when running over
> netdevsim, we just want GSO to break up the segments on the sender.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/gro.py | 38 ++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
> index ba83713bf7b5..6d633bdc7e67 100755
> --- a/tools/testing/selftests/drivers/net/gro.py
> +++ b/tools/testing/selftests/drivers/net/gro.py
> @@ -20,7 +20,7 @@ coalescing behavior.
>  import os
>  from lib.py import ksft_run, ksft_exit, ksft_pr
>  from lib.py import NetDrvEpEnv, KsftXfailEx
> -from lib.py import cmd, defer, bkg, ip
> +from lib.py import cmd, defer, bkg, ethtool, ip

Is there a pattern behind this order. Since inserted rather than
appended. Intended to be alphabetical?

>  from lib.py import ksft_variants
>  
>  
> @@ -70,6 +70,27 @@ from lib.py import ksft_variants
>          defer(ip, f"link set dev {dev['ifname']} mtu {dev['mtu']}", host=host)
>  
>  
> +def _set_ethtool_feat(dev, current, feats, host=None):
> +    s2n = {True: "on", False: "off"}
> +
> +    new = ["-K", dev]
> +    old = ["-K", dev]
> +    no_change = True
> +    for name, state in feats.items():
> +        new += [name, s2n[state]]
> +        old += [name, s2n[not state]]

Should the change set not only include items for which
current != state?

Now old assumes not state, but that is not necessarily true?
> +
> +        if current[name]["active"] != state:
> +            no_change = False
> +            if current[name]["fixed"]:
> +                raise KsftXfailEx(f"Device does not support {name}")
> +    if no_change:
> +        return
> +
> +    ethtool(" ".join(new), host=host)
> +    defer(ethtool, " ".join(old), host=host)
> +
> +
>  def _setup(cfg, test_name):
>      """ Setup hardware loopback mode for GRO testing. """
>  
> @@ -77,6 +98,11 @@ from lib.py import ksft_variants
>          cfg.bin_local = cfg.test_dir / "gro"
>          cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
>  
> +    if not hasattr(cfg, "feat"):
> +        cfg.feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
> +        cfg.remote_feat = ethtool(f"-k {cfg.remote_ifname}",
> +                                  host=cfg.remote, json=True)[0]
> +
>      # "large" test needs at least 4k MTU
>      if test_name == "large":
>          _set_mtu_restore(cfg.dev, 4096, None)
> @@ -88,15 +114,21 @@ from lib.py import ksft_variants
>      _write_defer_restore(cfg, flush_path, "200000", defer_undo=True)
>      _write_defer_restore(cfg, irq_path, "10", defer_undo=True)
>  
> +    _set_ethtool_feat(cfg.ifname, cfg.feat,
> +                      {"generic-receive-offload": True,
> +                       "rx-gro-hw": False,
> +                       "large-receive-offload": False})
> +
>      try:
>          # Disable TSO for local tests
>          cfg.require_nsim()  # will raise KsftXfailEx if not running on nsim
>  
> -        cmd(f"ethtool -K {cfg.ifname} gro on tso off")
> -        cmd(f"ethtool -K {cfg.remote_ifname} gro on tso off", host=cfg.remote)
> +        _set_ethtool_feat(cfg.remote_ifname, cfg.remote_feat, {"tso": False},
> +                          host=cfg.remote)
>      except KsftXfailEx:
>          pass
>  
> +
>  def _gro_variants():
>      """Generator that yields all combinations of protocol and test types."""
>  
> -- 
> 2.51.1
> 



