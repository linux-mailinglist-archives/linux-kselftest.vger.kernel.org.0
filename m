Return-Path: <linux-kselftest+bounces-11242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8651D8FC837
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 11:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEBC1C22B3E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D2418FC78;
	Wed,  5 Jun 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA6gr2ph"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FF1372;
	Wed,  5 Jun 2024 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580652; cv=none; b=iwgtKGXf2+hZW3V/y0PsZdQrLbSmwLDwmtNKQNlMbFhGo2jcQYMO7fjRtc2uEXClkvaxxoDnajAd777xId7PVIo/SojBP+y6o4qji7uhxfdjU1ckq74w3KSR7TTYJan6AvaV5f0OvkG7Hg+JBwnbzuN2B+Z/dIrBFX8mRPPKeiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580652; c=relaxed/simple;
	bh=7Bgdx7IqaGbveO1omriWFiC4m25biWloVy12Zy4BeMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLKFKvtvmGrcZb8iXSDgacZLfl6bmba2JgMVzlwWpwzuSng6yHjmClkZ8N09ul+GEkjR3Dqm39UIdbdGJ+t52H3+TNv4COq83qTdNFsfNkDUnJiNF7OAyGdR62AuHIuUJlnMSUJodBrmRQPUZHL/wrFLMee/R8ottOKGxTheGfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VA6gr2ph; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d1fd55081fso1022033b6e.2;
        Wed, 05 Jun 2024 02:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717580650; x=1718185450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gK79F04gd642egsqzJF+CSBzAbwsHZYo+7RIWwdUwAQ=;
        b=VA6gr2phDmbvpK1IXArZf4NbVn5TVc55GMSQvUyBcInQIolkpPUKREGENVXEZHeD2/
         n+hDLZOiX3n3c6cijofdTBGTvn2B7r7NfJIk/KMqiXATIwTsnwxVjyuvobHoblP9Z4+T
         Hx/fhrkT74msDLO0tcU9LTHxT3FguylOhjR3JcysXxC4eVx0pWIhTE6k2tsDzmo0k5X0
         Oc9501RhkA3zSdOLStVQztoiraNyPPdooXAoRF8c7rjU/9wQZMRX3erMHHexVokPkk7S
         T7u4xFuOiC/Vnyr+lwjtZ/B/FcX5ARMTCEUYh9EvQuWFMlkrbtwrmaFmstyaRhC9gYoi
         hktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717580650; x=1718185450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gK79F04gd642egsqzJF+CSBzAbwsHZYo+7RIWwdUwAQ=;
        b=cSOm9iuP/tZseJtUXnIbAE+kT9OOgwUya/EpdzIwP/V04YO28mLQf10YPunayG3o8a
         m5VsRYsx2Bpkhl/gVtDBj796XEgq2i+fRkm4Sj4OUW4tuToz1TZiYlC2KGWZb7xJsZKa
         w0GpIlr/GUYA5XyNrOeJUn+4nWz1ZRX4jRROP5r72x2t7n6LS/TMr9Rox8//UP5VEjrr
         DPHFiDa08UgTh9slvdvPflePucWzJ6AutSEfV7std8Ffafdwx3+/A9XpLZ0nK/RhbH5A
         Bb1btZEh/DDkOSiwQRovENGabwzuKLpSrr4FlV3WxzzAQcHMTXYVhH6zkA0hlGXLWkXF
         drOg==
X-Forwarded-Encrypted: i=1; AJvYcCVnKdjMYzpIuvOi04TJFUIOK4sikse/+yPp1APTjXUvcR05zkl/wlY5OUoKJ+NEhQ2K+Xt30WYUqsUsZPjpXBnqJo3P6P1xwjvucXwED9/vVt7nos325Nw+0yVvnJIjwH0w7QsHrdqO3Imkt+HccYvx1zoCNDHaWPZnDshtGbrlmT3jPMzSTN35judSMkI/gDW66xtzyLHSIkysGmNx
X-Gm-Message-State: AOJu0YxIKQHBpJtC0j+ANq9+kd5Vn6jeBeeItY0C+VUAAK8NKohhLgRW
	qQohuQ6QXNOeiuoDrXYwW0KOtko+50bDrca9iOQ9xLOSnctIOf+i2oearhX2qeU=
X-Google-Smtp-Source: AGHT+IFaaRDnVhyOvSL7Tug0T39Td77AqPRbZu5+wRY+YQIvmBZMA+HYEQdgMdCZkXmHoAHJ9hatiQ==
X-Received: by 2002:a05:6870:5e14:b0:24c:b878:b515 with SMTP id 586e51a60fabf-2512208d4edmr2327156fac.49.1717580649622;
        Wed, 05 Jun 2024 02:44:09 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782b:80e0:aaca:87fa:f402:cc0f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242aea177sm8288566b3a.110.2024.06.05.02.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 02:44:09 -0700 (PDT)
Date: Wed, 5 Jun 2024 17:44:03 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH net 1/3] selftests: net: lib: support errexit with
 busywait
Message-ID: <ZmAzY4eE9eaJ0IpE@Laptop-X1>
References: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
 <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-1-b3afadd368c9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-1-b3afadd368c9@kernel.org>

On Wed, Jun 05, 2024 at 11:21:16AM +0200, Matthieu Baerts (NGI0) wrote:
> If errexit is enabled ('set -e'), loopy_wait -- or busywait and others
> using it -- will stop after the first failure.
> 
> Note that if the returned status of loopy_wait is checked, and even if
> errexit is enabled, Bash will not stop at the first error.
> 
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")

Not sure if the fixes tag should be c5341bcc337c ("selftests: mlxsw: Add a
self-test for port-default priority"), so the fixes could be backported to
stable kernel for forwarding/lib.sh. Others looks good to me.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

> Cc: stable@vger.kernel.org
> Acked-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/lib.sh | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index edc030e81a46..a422e10d3d3a 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -67,9 +67,7 @@ loopy_wait()
>  	while true
>  	do
>  		local out
> -		out=$("$@")
> -		local ret=$?
> -		if ((!ret)); then
> +		if out=$("$@"); then
>  			echo -n "$out"
>  			return 0
>  		fi
> 
> -- 
> 2.43.0
> 

