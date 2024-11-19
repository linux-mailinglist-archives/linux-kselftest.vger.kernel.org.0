Return-Path: <linux-kselftest+bounces-22222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D739D1E50
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 03:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F28FB237C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 02:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC2378C76;
	Tue, 19 Nov 2024 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qh9HNbUc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970EC27735;
	Tue, 19 Nov 2024 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983618; cv=none; b=j5CSnHIlqqoSUY/ZMgjBwd/v5Zox6QTpKTCY3t6i8urijjL7R5pG7ointQYz0RRm345M5TWGcTziglWJDJJT3KGBM00hEs/QZonqN0i/wtfWbU2HISruVzWR+dxL888Mib0Mm6RgS2jAj0uvU+WcgIPTVWFvgeFWJj2/e0y+hTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983618; c=relaxed/simple;
	bh=kzehaPiccsw15px7PPl9C3XDFhEo1QI2seSrggxszCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNsSoBOxiAxZgKStmIbz77XR4oysNFcDOAjN1gJdYwrgYPwOFzfayuxdgqrtX7pNOC1ohUfYfL6fEQfLo2GfgjIongtvkXeJw1EE38AfMFGAagKatAQdg/rxlFS0KqXUZUzIs1tBZmL+VFiaIY6E58q05zZEvEJb7906nLn6BOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qh9HNbUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADB0C4CECC;
	Tue, 19 Nov 2024 02:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731983618;
	bh=kzehaPiccsw15px7PPl9C3XDFhEo1QI2seSrggxszCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qh9HNbUcw9AwZL9kqkcf6F2dPF7vmHpBNWJKznT0J3Ky5XYbl+NCqf6hp7j2cAbeV
	 1Yk5i/5XoDngwiz7G7WYcmnFqU9P3iEvaxwImwSHL2ccIvw27KIx+boXsFjH9T8eeR
	 AjwwF1epXj1s8rIXeEUWBrf33Qe5c3QQ5W0+Ft6o3XE5a3vJsCXqNUKx2xRCJbZQhA
	 qPoPIsCa+qdqd2IhQ8whlKP6tw/m7qcwiWLUFknVcOC0LnX1tpmcki1ix/IL1WwjHa
	 HWgaikmaMrX8jxsFXdY+BdsIPCCqnkF6FFI6DtiPDofyvS9IpQalyxWlqBHMCY5M08
	 z/WlCqMZ8Dqxg==
Date: Mon, 18 Nov 2024 18:33:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, max@kutsevol.com, thepacketgeek@gmail.com,
 vlad.wing@gmail.com, davej@codemonkey.org.uk
Subject: Re: [PATCH net-next 2/4] netconsole: Add option to auto-populate
 CPU number in userdata
Message-ID: <20241118183336.34e42b01@kernel.org>
In-Reply-To: <20241113-netcon_cpu-v1-2-d187bf7c0321@debian.org>
References: <20241113-netcon_cpu-v1-0-d187bf7c0321@debian.org>
	<20241113-netcon_cpu-v1-2-d187bf7c0321@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Sorry for the late review, I think this will miss v6.13 :(

On Wed, 13 Nov 2024 07:10:53 -0800 Breno Leitao wrote:
>  /**
>   * struct netconsole_target - Represents a configured netconsole target.
>   * @list:	Links this target into the target_list.
> @@ -97,6 +105,7 @@ static struct console netconsole_ext;
>   * @userdata_group:	Links to the userdata configfs hierarchy
>   * @userdata_complete:	Cached, formatted string of append
>   * @userdata_length:	String length of userdata_complete
> + * @userdata_auto:	Kernel auto-populated bitwise fields in userdata.
>   * @enabled:	On / off knob to enable / disable target.
>   *		Visible from userspace (read-write).
>   *		We maintain a strict 1:1 correspondence between this and
> @@ -123,6 +132,7 @@ struct netconsole_target {
>  	struct config_group	userdata_group;
>  	char userdata_complete[MAX_USERDATA_ENTRY_LENGTH * MAX_USERDATA_ITEMS];
>  	size_t			userdata_length;
> +	enum userdata_auto	userdata_auto;

If you want to set multiple bits here type should probably be unsigned
long. Otherwise the enum will contain combination of its values, which
are in themselves not valid enum values ... if that makes sense.

>  #endif
>  	bool			enabled;
>  	bool			extended;

> +	/* Check if CPU NR should be populated, and append it to the user
> +	 * dictionary.
> +	 */
> +	if (child_count < MAX_USERDATA_ITEMS && nt->userdata_auto & AUTO_CPU_NR)
> +		scnprintf(&nt->userdata_complete[complete_idx],
> +			  MAX_USERDATA_ENTRY_LENGTH, " cpu=%u\n",
> +			  raw_smp_processor_id());

I guess it may be tricky for backward compat, but shouldn't we return
an error rather than silently skip?

>  	nt->userdata_length = strnlen(nt->userdata_complete,
>  				      sizeof(nt->userdata_complete));
>  }
> @@ -757,7 +788,36 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
>  	return ret;
>  }
>  
> +static ssize_t populate_cpu_nr_store(struct config_item *item, const char *buf,
> +				     size_t count)
> +{
> +	struct netconsole_target *nt = to_target(item->ci_parent);
> +	bool cpu_nr_enabled;
> +	ssize_t ret;
> +
> +	if (!nt)
> +		return -EINVAL;

Can this happen? Only if function gets called with a NULL @item
which would be pretty nutty.

> +	mutex_lock(&dynamic_netconsole_mutex);
> +	ret = kstrtobool(buf, &cpu_nr_enabled);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (cpu_nr_enabled)
> +		nt->userdata_auto |= AUTO_CPU_NR;
> +	else
> +		nt->userdata_auto &= ~AUTO_CPU_NR;
> +
> +	update_userdata(nt);
> +
> +	ret = strnlen(buf, count);
> +out_unlock:
> +	mutex_unlock(&dynamic_netconsole_mutex);
> +	return ret;
> +}

