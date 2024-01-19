Return-Path: <linux-kselftest+bounces-3258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F71833010
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 22:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A6E28447C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 21:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AB65732E;
	Fri, 19 Jan 2024 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAdYHeVy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFDC56B96;
	Fri, 19 Jan 2024 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698444; cv=none; b=P5RxhwpFZpfOS0+ZCPLB/2Z1UHv0JP/ePPEjlQC55rFfuDhjxWab9z6QXaBRkvOfBNx6UAZwu/gG57YiB9ClbrKTcVrvJPs517uIFZaQJN3AlS8owHGUZCiI7536s3pV0zFLgkUhooVmir/LayyPejunlvd2YChFeuZYJ4m26xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698444; c=relaxed/simple;
	bh=tBYFUh0aub60E5WCvZz/nbFsqgKVQ6NbogwE6RsuFo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tH8iSKLeKz4FtNd2z0+XDg1h2fgtTq2jpsMZWRbU4IMqzaltSLwOIDCcUsCQCPlBzc5waPN7XZEc+IwfAn4lCn7AnhM2oqkL9ifRssOxFnvgTrJh3MI/6DjIW6g2rjYT7RbpA6ImVFQcBSZE77e4bMWvmAemElwz3mg+JO+LGdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAdYHeVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A2CC433C7;
	Fri, 19 Jan 2024 21:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705698443;
	bh=tBYFUh0aub60E5WCvZz/nbFsqgKVQ6NbogwE6RsuFo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oAdYHeVyKHgPn0yL2ESfT3g7+scpLulgivhmGCIJRGwhZUWhro7d7k0Lu964cv4yY
	 ZuximW5ihlBu7cMH58r1mDdYGJJx91dpk+/rtrsGMQjCD1ADjyPYpCXUvDO1/aL5PN
	 4FgpoNhdl8BU+JxMAQyPzOSKxjeHTZJ9FSY4dAldjaqo9a3q2Un4GIiYwtBjdQxwol
	 u6cNEU+3KJ0FR/KzKAwHNYN8wTNUsFSbTGfXwui+LsGx4Z+seRKszJAyXorvQQvoAO
	 XuWf1byb1Xzvtc527TWqIJI8fKJQkFg92y7d1VgJE/uyOEPKScONOa0HxBcXFcWk7f
	 wGMTxLA3IX0Xw==
Date: Fri, 19 Jan 2024 21:07:19 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: fix rps_default_mask with >32 CPUs
Message-ID: <20240119210719.GA110182@kernel.org>
References: <20240119151248.3476897-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119151248.3476897-1-kuba@kernel.org>

On Fri, Jan 19, 2024 at 07:12:48AM -0800, Jakub Kicinski wrote:
> If there is more than 32 cpus the bitmask will start to contain
> commas, leading to:
> 
> ./rps_default_mask.sh: line 36: [: 00000000,00000000: integer expression expected
> 
> Remove the commas, bash doesn't interpret leading zeroes as oct
> so that should be good enough.
> 
> Fixes: c12e0d5f267d ("self-tests: introduce self-tests for RPS default mask")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: horms@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/rps_default_mask.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/rps_default_mask.sh b/tools/testing/selftests/net/rps_default_mask.sh
> index a26c5624429f..f8e786e220b6 100755
> --- a/tools/testing/selftests/net/rps_default_mask.sh
> +++ b/tools/testing/selftests/net/rps_default_mask.sh
> @@ -33,6 +33,10 @@ chk_rps() {
>  
>  	rps_mask=$($cmd /sys/class/net/$dev_name/queues/rx-0/rps_cpus)
>  	printf "%-60s" "$msg"
> +
> +	# In case there is more than 32 CPUs we need to remove commas from masks
> +	rps_mask=${rps_mask/,}
> +	expected_rps_mask=${expected_rps_mask/,}

Hi Jakub,

AFAIK this will only remove the first incidence of a comma.
So I'm assuming this breaks with >64 CPUs.

>  	if [ $rps_mask -eq $expected_rps_mask ]; then
>  		echo "[ ok ]"
>  	else

