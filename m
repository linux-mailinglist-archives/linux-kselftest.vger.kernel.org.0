Return-Path: <linux-kselftest+bounces-7942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3278A494D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 09:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1948DB2389E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 07:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A514525774;
	Mon, 15 Apr 2024 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDFzUa+C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565E12575F;
	Mon, 15 Apr 2024 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167191; cv=none; b=cHcherD8HlJiOBOuUBPhLGc/Icbek2FW6lbSBJ+ngVJaZjFniYdnD5S655qogKcTaqP1QsJl7OLpwPJkpBxd7kpRV6aTOhpfNvYJgcB5I8TLnPlFZK0qyiwyokjlTKFg0u16HfIz1ghMmTeKzo1M+JdGSjuz/2j0HKi7TK3UlNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167191; c=relaxed/simple;
	bh=yXSkbV/J50HfP3pMGfH2WUQoK6n1YGjWdUKZLKpFasA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJxPgLilJVFGRI5FQFlHELIB6+r8NQ/07mhQrSG+6SDxpyn5JsBzdyDZ9rLvIW2bk3CTCBVlFYhaFbcnCA57YR4XMD2YYsjAzCK/x5KSRXJlJKr205eJlDVVMvWXYHxGE5OUiQYXb57u0jkRCAH7ha6MAjHhvgdEieTqGdbAkyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDFzUa+C; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed11782727so2410136b3a.1;
        Mon, 15 Apr 2024 00:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713167189; x=1713771989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgj1VTu82+m6P0j2dFsK+PNoaXP8Shv2+ErdOUuu+zk=;
        b=cDFzUa+Cdd+I0AzPMxw7ecC03k0iVtPQz5s7KxBM9UeHT4RCuf88QuU/27BZlW3UKL
         Pt2R7c0oJw3dob1LrKnhEH59VZSyTgNy02t0jySMnFo9BAbj7ckVppWqUqwXBS/4g1Gp
         Tf4JimIXd1V+MaYOuv98dvVtf1vB+JvTEY7sSM0Xl67ofCH7PudEZlIHNceQAJbROuXP
         vP1nEw7InXmBMblodGL7vGgTAhZaSv5PdbnSpX/XQQC4htIIgHkY0ZHBGPz32/AaDZQz
         WrK4x2cMVcLJaBIr+c5LlwXnAQVcdNzJqrUs+Elp9SBdxITlzQIQz/vjM8x3kwjBFrSU
         6BCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713167189; x=1713771989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgj1VTu82+m6P0j2dFsK+PNoaXP8Shv2+ErdOUuu+zk=;
        b=g02QCdMojMgmIHYBmBoBmkyfuLJdL6NEMmFbWoo0zqKlBzm+eryhK5yKW38deMR7+I
         5MgMLGzC07R4wCLQkhLBlC8GymH1AjMmqryuRHkPqNuY1za+GRhkLg9bjfbo/tdmqQhR
         pM9dG1nH/jBdi/NCNF8f8Z6xuc/LDPcXn24gmfB8TuZUpaPqA9EVW4L48HuzZZUGhVaD
         /zTVVTepR0dmgNRLsTLwUBOjj1obRVZnnbS8rrFwJi2tZargAX8z2aQjUgWwbx6HTho5
         0+8kAG/JDXHgaZOuJGqnw/YxGboH0+lMGd/sW89oZHCpqqH8nsSwFLCaLmGYGNj5br7/
         ectQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxcMjHFaF8bZtMUWBrsFRbNr8cwn43LOF4CTH8RmhGgPUrtH/pAm/iFCj64iWfQV52RjZMeV6IlQzBR3F8jdAH4lHVhd4O3p3379EvwrUvQwtaZti0m+HOJ33sb22Fte9ZAdnKZ7c9
X-Gm-Message-State: AOJu0YxCTOMJ7cYEOh0PGlcSfw0BudDGWRk9XEJASrma/3IUK/3FkD4L
	QLsCLqS3dR9QLey+EY7M5HKI1FNv5xbuYFol96YbAd+DyjUoCinw3sUGXV/szM556Q==
X-Google-Smtp-Source: AGHT+IGv8RQgNpGbLyrm7SjeHgdm3VchI2p4LSF1np0u1KbAjvifMu26I1kU1qdOvJrZkI1ynivXuA==
X-Received: by 2002:a05:6a20:2444:b0:1a7:4887:771e with SMTP id t4-20020a056a20244400b001a74887771emr8125147pzc.44.1713167189447;
        Mon, 15 Apr 2024 00:46:29 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m7-20020a1709026bc700b001dd69aca213sm7244316plt.270.2024.04.15.00.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 00:46:29 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:46:24 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com, Benjamin Poirier <bpoirier@nvidia.com>
Subject: Re: [PATCH net-next 03/10] selftests: forwarding: bail_on_lldpad()
 should SKIP
Message-ID: <ZhzbUBrJJ6-6l5Ql@Laptop-X1>
References: <cover.1712940759.git.petrm@nvidia.com>
 <686eeb760a35f228bde1392ffa3f59462223db26.1712940759.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686eeb760a35f228bde1392ffa3f59462223db26.1712940759.git.petrm@nvidia.com>

On Fri, Apr 12, 2024 at 07:03:06PM +0200, Petr Machata wrote:
> $ksft_skip is used to mark selftests that have tooling issues. The fact
> that LLDPad is running, but shouldn't, is one such issue. Therefore have
> bail_on_lldpad() bail with $ksft_skip.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 3cbbc2fd4d7d..7913c6ee418d 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -2138,6 +2138,8 @@ bail_on_lldpad()
>  {
>  	local reason1="$1"; shift
>  	local reason2="$1"; shift
> +	local caller=${FUNCNAME[1]}
> +	local src=${BASH_SOURCE[1]}
>  
>  	if systemctl is-active --quiet lldpad; then
>  
> @@ -2158,7 +2160,8 @@ bail_on_lldpad()
>  				an environment variable ALLOW_LLDPAD to a
>  				non-empty string.
>  			EOF
> -			exit 1
> +			log_test_skip $src:$caller
> +			exit $EXIT_STATUS
>  		else
>  			return
>  		fi
> -- 
> 2.43.0
> 
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

