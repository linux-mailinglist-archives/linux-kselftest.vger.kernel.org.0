Return-Path: <linux-kselftest+bounces-13440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC79692CBC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 09:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6744D1F23FE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 07:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1898289A;
	Wed, 10 Jul 2024 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HAWKf4e0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2060656B81;
	Wed, 10 Jul 2024 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595816; cv=none; b=Upc16AGzcrAaqnPb22h5zKcLsn7voYnmThUJlDNARUAlPkz/u/Q0M8y7R5Nj4zgLpWjN2AR+e7L0/DViyvKPSLkHZf/FlYI83dcG+7RxbFRiAdPffj3N7VpAwEpkhb8CzUFt07ApueWQV/F7XG5yBDZz1kiM8SXXcU9aawuTR+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595816; c=relaxed/simple;
	bh=vRxaKifrFZOMn7KIEgLCY9pKKr2t2I38//6FvE8eyBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9Yt44lW0llFcprR1y6OcZNqwOufnUc//7GZ0XbUcepOl/rZ92QNURaXd1ivDlv/70x9jlf0bheH+NczmNpvOKrb63gAnhjANA6f1lX4jqirE76u+uutCR6VXV74FIDUw2mcHld4fcAwg8zVw4z0mHknKFVWZ1qMn19WTpH6MeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HAWKf4e0; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0AF28E0007;
	Wed, 10 Jul 2024 07:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720595811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RhNExrqvN8QoPWUjFeQBs8I0s2VMlyexMTfcOk11t94=;
	b=HAWKf4e0ewmxclW9Y2i1O0dOgmPXVPaR+TwItpT9D/u7ZOO+RVv0ZLP9qpebnuVQ2EqFYl
	oefVMo/ef/zJbzUh03Js8MUfv8qOlfyx8lykizQiLEEZuScF8lPm4LbMASJysR0gxP2qqN
	Oj3Zilz/bAKWd3vUEbB5igK6YEmlLLshI+s8YQQj3BF+ghY9lTXr0oO+LDXjHZnKrKhIZD
	3BYaS8LHd0UBj05bhAgn7FJRhu5MyRUvPVAtv/jy1UmlKF2x0R0bMT2KENi1HofVRXDMm+
	suac0BfOpCdR53Wj62Nd6U9e9SyqQcs91EkeAWPjuXXq+Lg7Cszxajg9/hKAag==
Date: Wed, 10 Jul 2024 09:16:50 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: shuah@kernel.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/rtc:Fix a resource leak
Message-ID: <20240710071650f7265b40@mail.local>
References: <20240710060743.4691-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710060743.4691-1-zhujun2@cmss.chinamobile.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 09/07/2024 23:07:43-0700, Zhu Jun wrote:
> The opened file should be closed before exit, otherwise resource leak
> will occur that this problem was discovered by reading code

Can you elaborate on the leak? All the fds are getting closed on exit.

> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/rtc/setdate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/rtc/setdate.c b/tools/testing/selftests/rtc/setdate.c
> index b303890b3de2..17a00affb0ec 100644
> --- a/tools/testing/selftests/rtc/setdate.c
> +++ b/tools/testing/selftests/rtc/setdate.c
> @@ -65,6 +65,7 @@ int main(int argc, char **argv)
>  	retval = ioctl(fd, RTC_RD_TIME, &current);
>  	if (retval == -1) {
>  		perror("RTC_RD_TIME ioctl");
> +		close(fd);
>  		exit(errno);
>  	}
>  
> -- 
> 2.17.1
> 
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

