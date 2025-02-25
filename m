Return-Path: <linux-kselftest+bounces-27425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A8EA43B50
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156A7168273
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 10:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54788266EE6;
	Tue, 25 Feb 2025 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrDwrTl9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2534626657D;
	Tue, 25 Feb 2025 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478756; cv=none; b=nC7NGAUiCCZ9enkUUewLIRxYl+gw9r/k1uqUk+iYqFViZRO0rxG9D8k7FlI8jAkkzz+rPDrCnJJa/4c8+6TQc8IqWu8kR0uSoz7FKFwPgingW1k8sMSpPjpqBKV3VAu0+7TWT6zgqAmvetln4WwhVwmt/aiFviTDC83mqufL8p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478756; c=relaxed/simple;
	bh=9rdRKX7IXYuO7sS8gLgPkNl5dy7GjXAzfQMyNV+OMlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5VJbYTAsHP1aAArh4dCc+q1XzKh0bC6FK7Dr8plzWUCnVaARabbxXC84kPq6mnyQNkkvhAB9+vY4OMc6CvVbfbWAhFT75b3czDZZfbHe1Foz55TOtPidcWZRWV17wuzFrQ23sr+8UBECk4NVq7TmayJurv/c8M59yfJJqkDEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrDwrTl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F0BC4CEE2;
	Tue, 25 Feb 2025 10:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740478755;
	bh=9rdRKX7IXYuO7sS8gLgPkNl5dy7GjXAzfQMyNV+OMlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrDwrTl9ScuMmkJNNw7g/bNbpUy7QJk60/fri7IyABF3bYQbJk1eHYZd01WPpyRXI
	 KelPM7tVh7ZkMRBWhUOfhgou2yXsrgEoNuJkDEqTxGwC1zQTnreYHxHTEKkMRypGQC
	 KKO79jdzcD2dsPJ7R9jS2nOGPee6btkX5b3d2eP68JAoMNJT/zfyAYydPqXRJ9+yWz
	 bAOLwZ4dwgWWqrerTt96XbPZuChBGymjy9gKNgeRFGTfA6HPlog6MYshV2yI1tgG+I
	 oRw5PMNHERZJJi2d8f8t09TQIvoCa8rM+pdVcy2SiCSJe8GFHzHyUqen1Gnk53OYeP
	 3rpb+8qlRTNSw==
Date: Tue, 25 Feb 2025 10:19:10 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 5/7] netconsole: add task name to extra data
 fields
Message-ID: <20250225101910.GM1615191@kernel.org>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-5-21c86ae8fc0d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-netcons_current-v1-5-21c86ae8fc0d@debian.org>

On Fri, Feb 21, 2025 at 05:52:10AM -0800, Breno Leitao wrote:
> This is the core patch for this whole patchset. Add support for
> including the current task's name in netconsole's extra data output.
> This adds a new append_taskname() function that writes the task name
> (from current->comm) into the target's extradata buffer, similar to how
> CPU numbers are handled.
> 
> The task name is included when the SYSDATA_TASKNAME field is set,
> appearing in the format "taskname=<name>" in the output. This additional
> context can help with debugging by showing which task generated each
> console message.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 5a29144ae37ee7b487b1a252b0f2ce8574f9cefa..625f4c0be11d8deb454139b1c526abc842697219 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -1179,12 +1179,22 @@ static int append_cpu_nr(struct netconsole_target *nt, int offset)
>  			 raw_smp_processor_id());
>  }
>  
> +static int append_taskname(struct netconsole_target *nt, int offset)
> +{
> +	if (WARN_ON_ONCE(!current))
> +		return 0;

Hi Breno,

I gather that theoretically this could occur, but it isn't expected
to happen in practice. Is that right?

...

