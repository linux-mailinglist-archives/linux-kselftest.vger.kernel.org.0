Return-Path: <linux-kselftest+bounces-43651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B95D5BF5AE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 12:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 956EE4E6E91
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 10:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46732F12D6;
	Tue, 21 Oct 2025 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="druJg+gG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530A25BF13;
	Tue, 21 Oct 2025 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041098; cv=none; b=fPqOoA+Is3KhqC2qPEA/5oaA1XOeamBOc8uXMU5XFmySC8fd4QVhgvLZPf3CZOAs2DYzv2PTa3hNP+MmKklzu4S4uZU2IijUIUC+DZRxPgUQVZHxw/iXG2NhEmsc4Ybqzv8zGreVovydKpo3jbTuC4m9swCIznIfUY547pCFMEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041098; c=relaxed/simple;
	bh=UNDuyBu/H9MLieySEn/zKXMZnN2v+zyRHcL9xe+3KKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddUv8zewE/EF6SKXMp61WkYVLre2RwWGwjDJghoFMJPAKOwWN4JAvCfYTtu6GF2c2P4vkw86quRxTEQOj3O5qV14QobW3euNc+K+S7WDoq4MQpxawBWUY8DXxAJvFeFEVhF5tTy3Mk/A0fguXm8zbvlIpAIgQjKQ3uTk0ymWKK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=druJg+gG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4448C4CEF1;
	Tue, 21 Oct 2025 10:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761041098;
	bh=UNDuyBu/H9MLieySEn/zKXMZnN2v+zyRHcL9xe+3KKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=druJg+gGstrNmnqvB3SEHDFZc6qu9YG+3G4hJWNMy42QLfnZJDQWICRungso+3O9H
	 MkND4jyCl2Q/7nlXIxdvfsOhuz7M6PFpUzA7UPbgy3P7yAu8PDbC4fyClhMmYMGJtn
	 T2bCHqCmrJGuSm9+AJxnvnOFYXpfiD9L90b4bSphYADfNU2V1TVh1o9Hic1UImtZx+
	 BO5E5xVu4lG8Fq/1VqCP+hbYSfiswqAxDnMh+uCnj44Hj6k5Pr8ipu3nraUE+zNpVk
	 OHTLz/ViFQdRThwbTx8kVZT/qPBw1lgaeQ4LHTZCUaSsSYt5GdvVQ17mNZStiqQzN3
	 vG6A8al9ZiQhg==
Date: Tue, 21 Oct 2025 11:04:53 +0100
From: Simon Horman <horms@kernel.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Matthew Wood <thepacketgeek@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] netconsole: Fix race condition in between reader
 and writer of userdata
Message-ID: <aPdaxSUBMYwfQXW6@horms.kernel.org>
References: <20251020-netconsole-fix-race-v1-0-b775be30ee8a@gmail.com>
 <20251020-netconsole-fix-race-v1-2-b775be30ee8a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-netconsole-fix-race-v1-2-b775be30ee8a@gmail.com>

On Mon, Oct 20, 2025 at 02:22:35PM -0700, Gustavo Luiz Duarte wrote:
> The update_userdata() function constructs the complete userdata string
> in nt->extradata_complete and updates nt->userdata_length. This data
> is then read by write_msg() and write_ext_msg() when sending netconsole
> messages. However, update_userdata() was not holding target_list_lock
> during this process, allowing concurrent message transmission to read
> partially updated userdata.
> 
> This race condition could result in netconsole messages containing
> incomplete or inconsistent userdata - for example, reading the old
> userdata_length with new extradata_complete content, or vice versa,
> leading to truncated or corrupted output.
> 
> Fix this by acquiring target_list_lock with spin_lock_irqsave() before
> updating extradata_complete and userdata_length, and releasing it after
> both fields are fully updated. This ensures that readers see a
> consistent view of the userdata, preventing corruption during concurrent
> access.
> 
> The fix aligns with the existing locking pattern used throughout the
> netconsole code, where target_list_lock protects access to target
> fields including buf[] and msgcounter that are accessed during message
> transmission.
> 
> Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")

nit: no blank line here please

> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> ---
>  drivers/net/netconsole.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 194570443493b..1f9cf6b12dfc5 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -888,6 +888,9 @@ static void update_userdata(struct netconsole_target *nt)
>  {
>  	int complete_idx = 0, child_count = 0;
>  	struct list_head *entry;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&target_list_lock, flags);
>  
>  	/* Clear the current string in case the last userdatum was deleted */
>  	nt->userdata_length = 0;
> @@ -918,6 +921,8 @@ static void update_userdata(struct netconsole_target *nt)
>  	}
>  	nt->userdata_length = strnlen(nt->extradata_complete,
>  				      sizeof(nt->extradata_complete));
> +
> +	spin_unlock_irqrestore(&target_list_lock, flags);
>  }
>  
>  static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
> 
> -- 
> 2.47.3
> 
> 

