Return-Path: <linux-kselftest+bounces-12396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CEF9119F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 07:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37EB828284F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 05:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7862F86AE3;
	Fri, 21 Jun 2024 05:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="krGAgCuv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A3923A6;
	Fri, 21 Jun 2024 05:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946259; cv=none; b=j/okFRT/q1rHMCZqVX8YuRS730J315BMr27KkblvhCtyffdkelbgJ6qTnB6iEacPF7ulBYcmkYarNAQTCzSW9UlIYgUzJ3uGAquhhkZVlM99oLgdmpukQoyuvM6DddBXsF2opuLNFBMZ+5250a6ri3Cla4dtpQNTdXFt7s/eKXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946259; c=relaxed/simple;
	bh=2+xOBlFMBUl3pAT0WuVjPwwlUNbHed/6NAmGh7Q2boE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tFqa+2UwbJnB4LevE/7igqKWCzYkBbvw1b48+Y2QfhN2glhV63Pa8eZkv7pFO1HGyzs3Ca5tqguu8+Y/xmN5VvdwMhgnTnKvytcQXPaZ4z2YlE4k3Hq+8qs5zvEmjCwgDFi9g9NlAznYX+qYMWqZyUtOSF5htGLEs286xS76hvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=krGAgCuv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718946256;
	bh=2+xOBlFMBUl3pAT0WuVjPwwlUNbHed/6NAmGh7Q2boE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=krGAgCuvuXqhhRO6cAZ/K0EtLXgVXlNsK9B8325RcD+5V+ojZ3fpHxT7d6RufvlPZ
	 p9DvHEzCBY1FnzKKt8rpfar757MglNenk3wuQpDf43nREa5Q4K2HCF6vSlamiGoPx5
	 BhTl6sZ51Kn6nwrqAvuDHt5OxCNfCnQRKPPq1/rP1eLEALWX0RGlELWN0ws4l3UWsk
	 p66YjmRB6nkXPjrSPkkXP4DyPAQDr5NaKf6PY4bJ42Bi2v+fgZLpv5imBqw1Vo/YBi
	 yiHbyEmaB/67XGlw4Qmt5ER8dNUQphJWvYyFnwrHhJpNw6arctX9RM1/AHKetADo9C
	 EgSfAoSb+IRDg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 745B837808FA;
	Fri, 21 Jun 2024 05:04:13 +0000 (UTC)
Message-ID: <a077d2fe-89d7-46d9-a0ea-779ac575eba0@collabora.com>
Date: Fri, 21 Jun 2024 10:04:51 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH net-next] selftests: net: change shebang to bash in amt.sh
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240621041637.3600944-1-ap420073@gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240621041637.3600944-1-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/24 9:16 AM, Taehee Yoo wrote:
> amt.sh is written in bash, not sh.
> So, shebang should be bash.
> 
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Acked-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/net/amt.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
> index 7e7ed6c558da..d458b45c775b 100755
> --- a/tools/testing/selftests/net/amt.sh
> +++ b/tools/testing/selftests/net/amt.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
>  # Author: Taehee Yoo <ap420073@gmail.com>

-- 
BR,
Muhammad Usama Anjum

