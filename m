Return-Path: <linux-kselftest+bounces-4716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326C08558DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 02:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF8728D680
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 01:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7730A184E;
	Thu, 15 Feb 2024 01:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MIlkEz7Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEB63FC7;
	Thu, 15 Feb 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707962257; cv=none; b=HaR59yPZzFGzN3dth0LNkovWQRF746cqPmqcjCYBq15O2Bd/tg90q7ZrgApGvDypB2ivZCc9WCW9Dub8JtrZ/+cQ0jNoC9WY2Zke6+SBbOi8R+Wsj8NkP7a5Zd0AYlarnO/Sshu1QKJb5kGWRSYsVDI1ciwZljVbzOWSg9w3r+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707962257; c=relaxed/simple;
	bh=88Qz9eFS1Y9K5U7QleKKZQI4CEyZ/DgYqYs6eEc0G1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7dV04fYHZoWdWjzAo0lwiX+vZPm87HNTcBIzz9D4aiXdtpxyC9d4lp3ywJqwZ1GU45fxAVR4rXJBjySIS+Z8YN8k188NYFEzt4WQazYQKuGeciEu1/yz51OobCFybKcVz41y10A4RbEPFyNDHzJCJZseaGUr270KX3IqljMGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MIlkEz7Z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=A+G9YvrX/oVxjoyzS0ghgMs1YJikNrn1ZJ9/JanSdZA=; b=MIlkEz7ZJfbWJ/ycFROYwW77RF
	rvToQo3TJ3tkK2fnq7XCIYiawsE124TvC9+rDaTc4FFPs/bl/ekteECIyxiVaXjp4HjsT3OzJ8rjq
	EHJoEdo9zIyVlbLcJRsqI4c7PSbZ+Gyc64x0cTWUvrAtmtu8fV4NPoKTdgaLDs9G04FuEUnPdg2Qe
	h7KdagzmGcEOxb1+uANLtXY7d471jfbXId1/aBvi4lJ6QhG5B9h5CHHEvhp5gzjQN7Ca7K6FAc+Ks
	iuFQhC1y2HNPDhStotSPQte/rDSI5iAAZWNhEKLwsDhWFRRsUKRJxjItCgZYc8avFRdmi3Al1Nnnf
	8ViCYGQA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raR09-0000000Emlx-45G3;
	Thu, 15 Feb 2024 01:57:26 +0000
Message-ID: <51a442ec-3835-4282-982b-734c0962141c@infradead.org>
Date: Wed, 14 Feb 2024 17:57:23 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/31] ntsync: Introduce the ntsync driver and character
 device.
Content-Language: en-US
To: Elizabeth Figura <zfigura@codeweavers.com>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Wolfram Sang <wsa@kernel.org>,
 Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240214233645.9273-1-zfigura@codeweavers.com>
 <20240214233645.9273-2-zfigura@codeweavers.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240214233645.9273-2-zfigura@codeweavers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/14/24 15:36, Elizabeth Figura wrote:
> ntsync uses a misc device as the simplest and least intrusive uAPI interface.
> 
> Each file description on the device represents an isolated NT instance, intended
> to correspond to a single NT virtual machine.
> 
> Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> ---
>  drivers/misc/Kconfig  |  9 ++++++++
>  drivers/misc/Makefile |  1 +
>  drivers/misc/ntsync.c | 52 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
>  create mode 100644 drivers/misc/ntsync.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 4fb291f0bf7c..bdd8a71bd853 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -504,6 +504,15 @@ config OPEN_DICE
>  	  measured boot flow. Userspace can use CDIs for remote attestation
>  	  and sealing.
>  
> +config NTSYNC
> +	tristate "NT synchronization primitive emulation"
> +	help
> +	  This module provides kernel support for emulation of Windows NT
> +	  synchronization primitives. It is not a hardware driver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ntsync.
> +
>  	  If unsure, say N.

It looks like the "If unsure" line belongs to the OPEN_DICE kconfig entry
above here. If you want one for NTSYNC, please add one.

>  
>  config VCPU_STALL_DETECTOR


> diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
> new file mode 100644
> index 000000000000..e4969ef90722
> --- /dev/null
> +++ b/drivers/misc/ntsync.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ntsync.c - Kernel driver for NT synchronization primitives
> + *
> + * Copyright (C) 2024 Elizabeth Figura

It would be nice to have your email address above...

> + */
> +

> +
> +MODULE_AUTHOR("Elizabeth Figura");

but at least please add it in MODULE_AUTHOR(). Yes it's optional, but
roughly 7900 of 10400 entries do include it (according to my rough
grepping).

Yes, I know that it's in MAINTAINERS.

> +MODULE_DESCRIPTION("Kernel driver for NT synchronization primitives");
> +MODULE_LICENSE("GPL");

thanks.
-- 
#Randy

