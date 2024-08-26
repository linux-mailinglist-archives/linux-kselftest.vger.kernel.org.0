Return-Path: <linux-kselftest+bounces-16293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6218395F587
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 17:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16ED81F22242
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18469191F75;
	Mon, 26 Aug 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2iXpDqT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CFD49631;
	Mon, 26 Aug 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687412; cv=none; b=RCKUXmzUJoAz8YugfwW//FEOXT06a6ky39UFK06Vqt2XhU7oC0U2UnrEbyCiRDc9dnTORqStIj9qcpRw9SSrVc9MHoTM2rw1Cce0fejuytQxfzETvWcM7GpJXuiJYxT0foFVe51/MxM8Tc96hJiNajLsZUa+cljtKedVmZ+HeJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687412; c=relaxed/simple;
	bh=j6zLXif+ZPcktt6sG3QgwLXoxoeRpbwDnvlzyj8TG/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHzMN2dJLAnNawlBuReIlxCkG4AUNcZI9mPghiSlURdmuawQwCcm9XLS2W4xb4wvFoZE6cD3QpNowqQPB6xl/251RN1uK4M20GIxSPO46UjErmB+llAxJZ8NoHMWaQo0aklIrSd/+FzHAMs5hT4Z3CpoLhaheLe3rDNmcPzf4K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2iXpDqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E849C4FEFB;
	Mon, 26 Aug 2024 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687411;
	bh=j6zLXif+ZPcktt6sG3QgwLXoxoeRpbwDnvlzyj8TG/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s2iXpDqTnZwWxlK7z+ORUlf5GtL/bAdkDSyB5vVYBy9bCwFec4uSd4OEWn7Gpe4bI
	 p7IdigKEz9gWKhPJG0v0gR9Urq4f7w1PPrHkkwCIfBJgoW4CWkc+Y/OmeMDuLx0IQh
	 i5+pGYGMdeSZ8dSshDeeap0FGdsU02op3FBFe6Jzl2TU0MBfK/Od0uLEI8IN11m3BV
	 BnW7vxNgXyxGKE1gMDnZL7BR4JV4WuW3lkj+SBws/i2EMFOmrz/Y/YXui/Mg7oN2GQ
	 YMxi3zKS4xfMLupMyqLGSv8JV8jOybOWxyR/3EDglIR/jTO53wzqmkgDqsB4uVa2a1
	 jzG9yFrU7lxbg==
Date: Mon, 26 Aug 2024 08:50:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Hunter <david.hunter.linux@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH 1/1 V2] Selftests: net: Improve missing modules error
 message
Message-ID: <20240826085010.27ff4377@kernel.org>
In-Reply-To: <20240823054833.144612-1-david.hunter.linux@gmail.com>
References: <20240823054833.144612-1-david.hunter.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 01:48:30 -0400 David Hunter wrote:
> Subject: [PATCH 1/1 V2] Selftests: net: Improve missing modules error message

don't capitalize the prefix

> The error message descirbing the required modules is inaccurate.

spellcheck the commit message, please

> Currently, only  "SKIP: Need act_mirred module" is printed when any of
> the modules are missing. As a result, users might only include that
> module; however, three modules are required.

>  needed_mods="act_mirred cls_flower sch_ingress"
> +mods_missing=""
> +numb_mods_needed=0;

trailing semicolon

> +
>  for mod in $needed_mods; do
> -	modinfo $mod &>/dev/null || { echo "SKIP: Need act_mirred module"; exit $ksft_skip; }
> +	modinfo $mod &>/dev/null ||
> +	{ mods_missing="$mods_missing$mod " ; numb_mods_needed=$(expr $numb_mods_needed + 1);}

this is getting too long, use a "&& continue" instead of ||

>  done
>  
> +if [[ $numb_mods_needed>0 ]]; then

no need to use [[]], -gt

> +	echo "SKIP: $numb_mods_needed modules needed: $mods_missing" ; exit $ksft_skip;

why single line with semicolons, it can be two lines

> +fi
> +
> +
-- 
pw-bot: cr

