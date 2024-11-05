Return-Path: <linux-kselftest+bounces-21425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950239BC1DB
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 01:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E6D1C21618
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 00:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E28A4C85;
	Tue,  5 Nov 2024 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="V9DycDZc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB8D383
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730765498; cv=none; b=HHapUm0tMjmBgWR/Y1H2XYdgFLyRUhKBAVdjwGJV61zGpJZepzFDdGbekSkPwftPsA7wyriJ1/V4okDZ9HbTV9covwjQLfQ83ZYsYjBRTlXcLA/b3/f2EmW/LKeYQ1OkmIDtP/EbZjfvG5F1x6dPIG/XB/jozBw0TDhgOLjeyVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730765498; c=relaxed/simple;
	bh=gWgRcXOWyPuYyTeu+HI4eru08VqwWwTDaEH/C3Ai8TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aldGyCejhyu2O9BWdwAgfvaZqt1uaFQf2ez9OmNDb3QY1GWKnS30vCcaxLOvFmNjaBqnviLl+bz+hzn91O80AXXZKktts24S7HT8zNk+Zsv+fnhvyUQqpFeOJLUTkRGDNlZ1vpvU04NdFhXpDD2MYSHe4bUI+9y/SbMHkrZ2X+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=V9DycDZc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e625b00bcso4366487b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 16:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730765494; x=1731370294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzBGIIzGVWypDF2F/j8kxcVTvvbYnIIP9aDVrmVHUqo=;
        b=V9DycDZcrQMIiQgw99c8ifLm4wYIdgDN2GLr0l3lnmzTBH6iUmfpRqswwvXCjy90Xq
         Tn1dxlJ/63MYXkzJblf9BC8YJ7S3o7i2WhtYvhcWGYn29i0jdSUCM9x0cDRnAN8DQVZg
         ZyP1sxi/7nLU/PhHNKBhGe2Sn9Yvdh43kxais=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730765494; x=1731370294;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzBGIIzGVWypDF2F/j8kxcVTvvbYnIIP9aDVrmVHUqo=;
        b=H8WkCk4NJxK+Ih7yzdTwVGUUI9T7Aj/+1qegpbu7cQQ+eIbp9pnpM+3ZN5kCopIT56
         kYThgVOy5GW+ZNeDpl6dypEbgrQwGP43KVMEbVjKgu9GkO/4CqppI8KMNXvEeoW1D0Jj
         1R7jjPgXNWq828TRzmiigb152fVmW0FxAVYYv23k3MuhPG4QtXxvHUAMaxkA7afEHUG+
         Tb0jHCyNCHu1M4fHLPgr60nLM/HURhlaRJrtavrpJdYJ9eeJLFq4QTDG8BD1gjqqpXj8
         tgiJg8iActwYdAnk58SgKQHaod3Z0apDaAnJde/i919tW6Qp9z4sf46S0cRJMp6xDGZL
         VIkA==
X-Forwarded-Encrypted: i=1; AJvYcCVfVgH1wVQUk+uskJ5pYM5bHE0LSf5xL09VUCaTY6smJ8XuIV+2KibDsuoe8i71Hu9BlzSPU+JDW+Je+v4oYf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy6YGczpsJU7HFe3sdvzl9inhQM4RwRCpwpkZQRZI+gjBwtjDq
	GdIAkDLJyN5qZz9mRKZu3lneGX8YCYByryaYC0eVsMrGiRHWdTcR6jfXiBMcG8U=
X-Google-Smtp-Source: AGHT+IE6+0r70GgR/JYYtrp8S6WEpFk6AKBf4ysxpcdZyo74q6Lq8+iIND0dfroDCYdzA0K/G5OkBQ==
X-Received: by 2002:a05:6a20:d498:b0:1d9:1823:83bf with SMTP id adf61e73a8af0-1db91d516d0mr24240567637.8.1730765494528;
        Mon, 04 Nov 2024 16:11:34 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1eac2fsm8150260b3a.72.2024.11.04.16.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 16:11:34 -0800 (PST)
Date: Mon, 4 Nov 2024 16:11:31 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 10/12] selftests: ncdevmem: Run selftest when
 none of the -s or -c has been provided
Message-ID: <ZyliszeFtcZqfsnm@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-11-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-11-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:28AM -0800, Stanislav Fomichev wrote:
> This will be used as a 'probe' mode in the selftest to check whether
> the device supports the devmem or not. Use hard-coded queue layout
> (two last queues) and prevent user from passing custom -q and/or -t.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 42 ++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> index 044198ce02a7..270a77206f65 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -76,7 +76,7 @@ static char *client_ip;
>  static char *port;
>  static size_t do_validation;
>  static int start_queue = -1;
> -static int num_queues = 1;
> +static int num_queues = -1;
>  static char *ifname;
>  static unsigned int ifindex;
>  static unsigned int dmabuf_id;
> @@ -731,19 +731,31 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> -	if (!server_ip)
> -		error(1, 0, "Missing -s argument\n");
> -
> -	if (!port)
> -		error(1, 0, "Missing -p argument\n");
> -
>  	if (!ifname)
>  		error(1, 0, "Missing -f argument\n");
>  
>  	ifindex = if_nametoindex(ifname);
>  
> -	if (start_queue < 0) {
> -		start_queue = rxq_num(ifindex) - 1;
> +	if (!server_ip && !client_ip) {
> +		if (start_queue < 0 && num_queues < 0) {
> +			num_queues = rxq_num(ifindex);
> +			if (num_queues < 0)
> +				error(1, 0, "couldn't detect number of queues\n");
> +			/* make sure can bind to multiple queues */
> +			start_queue = num_queues / 2;
> +			num_queues /= 2;

Sorry for the beginner question :) -- is it possible that rxq_num
ever returns 1 and thus start_queue = 0, num_queues = 0

> +		}
> +
> +		if (start_queue < 0 || num_queues < 0)
> +			error(1, 0, "Both -t and -q are required\n");

And then isn't caught here because this only checks < 0 (instead of
num_queues <= 0) ?

