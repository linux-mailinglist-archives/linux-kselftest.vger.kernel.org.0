Return-Path: <linux-kselftest+bounces-46847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CDDC99156
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 21:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A029D4E16DC
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 20:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B4324A049;
	Mon,  1 Dec 2025 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt0WKWEZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED2B223DEF
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622311; cv=none; b=EYa4/ozTHn1BtwHLRzBf1BklWVyrmzElYkYCxMkv5RGDDi9/EDBY7XOkmWUacJUFea1/7cv11TvJruQh4vs5/7PfDMSwcirTiAHsloifAA2URUrKmR4rIYcuwLSkzDUOYudkQzYdpLKmVRmUsdCGxNm0i9AfTHhUEMfYuhkun7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622311; c=relaxed/simple;
	bh=4KoOzqv+ipGv0rqgnbX7X1rXY08lVBleYOU3gfU0n9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu25I3iNJeWYrBraSp3cY8jDdUfYXoeH8YNSz5PnT6Pn5mLq/yY0OCMUSKX5ORhjstVSJB4wgC7afSc8yBiK/t7BguvkDbSEAlEoYUzzJaw8//ln7kvfR/yFDektjv2Ke7iJg1xcXKDmlvvkYgnY9TDEH6R7QjCC6SgpiXg16+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dt0WKWEZ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bc1f6dfeb3dso2807175a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 12:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764622309; x=1765227109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/UP587KpUNebVt7/3EF26h5ZIXHGWKuQxdNdoes2rQ=;
        b=Dt0WKWEZP2HNGIllH2dcLL4ZwZj4/mgYUDslS3QdzzPUmfGyRV8VL/yguiJ8kVqiKI
         +3sI1664knGB7gdgHRVt1pIAa4ztYb8mZOi4Si73rvZOcPWh3PuAkzvSV+GhLkWAGQTs
         GGnehs1wha9IvGLfs2GTd9PBmlE1CnsRqsudX27lVeyMG8WwJWk8COX/NWFf/j1wjD4I
         P2EznpYfONe++XTFYcbyegiFk0wYyZaBrf6Pwd57rJWEsBTdLL1wkKr57cN7Kk1gSDSa
         Xzce/cff7VKGeBNTVBRByiqIOdcqElSsmRFaDe31NjqQz4f6poO7/iFPb3RUMyQ2q66u
         DbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764622309; x=1765227109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/UP587KpUNebVt7/3EF26h5ZIXHGWKuQxdNdoes2rQ=;
        b=vQ0ZnKAo4eODYpg9zzcg6DLVZdYjp2Vu5OT5Up3me1cYJHtxBXn/IIn591mSbwLy7H
         tOi7lny/lPBH3K4Z8NkkQlsYAl1CRuevWdcxTxXAAVPJAPRURk6PGbEmkPtU4fI6rRCX
         5SXOzxmipZC6o7ajFzIcsDEEipBPa6hS7CLhqU6Vc6TwjT6uY1Wq1fwVSEdWMbj4wTUh
         3SyzgLnp32kTJu2DQIkDEsngeYos1w0BO07hMWdyv8wPX8HOBisV6+S80fuadwMc8xSW
         UuokJZDnFXynNnVazPOKlhe0Lfsgc+6+ByP7JPezwhiYSGAdLGqkYtzjibbP6NcxUcGi
         +Iwg==
X-Forwarded-Encrypted: i=1; AJvYcCVVpBSXoVW9dJvJ0eAXhv/6mdgvRTQBLEVEdOtvS6VkJrLov1Kwg09CfDHc+1Qir7v1hYbc1be/IfWmYChIyC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMiATQWWevOweWEWnSLd74z2uylHHF+FoiX7V9+FfRPJe4BoNu
	R6ybQQMsrC9IoHevt8rgKRv8Ke/hnDqa7XjTRCq7YYTasLqeU2+98vPr
X-Gm-Gg: ASbGncuUjo5R894LbIj7bUXYCfEoVV94XWkWLWbI/3Jtxq2kAFNFOGyUoVVRvvteUwy
	7neq/xA2uG5JoJF43x6zGwwF1XmQfW1H04+1pWlymi/8gTPS2Kmts1s8Hs5KTY4FVuIrbxtL8CJ
	oNCP23/jNYcuPJFXDrUpguBplDdBVl4RmwrtPHVKXeA90cQNLTsK2bdkeZJ9W9P1mYpvo4nV7RB
	nPrLYAT/BQUYvWMULi++MTzqN0lLzid7DWlYbtijEb61qqTct9AJ0G5mZ3je0m1hrqcIQZr0Fiv
	1AN9WEcy6jFTx55qWlfLdi5rnm3sJYBlt+87dCxQVGL2xvSeTXwZHh1qf3Pm9tBjjV1GwtbdWNW
	Z7DiYqViVHByMSQM/SyI7mj5xPbgb6W7hFpP/NcxLSHEiK4EN82ie0h8ukKO1bvmeqsuHe55EFP
	s/FGkjoZn0vi+ZO4T9r2T+
X-Google-Smtp-Source: AGHT+IFSdO41XCfP0s9UoVBQECd3PUp4tktUJA19IyF8le2ikthW676EtTvcvuJcSrLdqZ8+wP3wiw==
X-Received: by 2002:a05:693c:2504:b0:2a4:3593:466d with SMTP id 5a478bee46e88-2a9415a2a6dmr12482341eec.9.1764622309241;
        Mon, 01 Dec 2025 12:51:49 -0800 (PST)
Received: from archlinux ([2804:7f1:ebc3:d24b:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b1ceeesm46355372eec.5.2025.12.01.12.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 12:51:48 -0800 (PST)
Date: Mon, 1 Dec 2025 20:51:40 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8 4/5] netconsole: resume previously
 deactivated target
Message-ID: <gmzstxyozxprqt4g6qotq6tjkbzx25e2c5mvvah6w43uvullw4@6vzf7qtvvh62>
References: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
 <20251128-netcons-retrigger-v8-4-0bccbf4c6385@gmail.com>
 <65vs7a63onl37a7q7vjxo7wgmgkdcixkittcrirdje2e6qmkkj@syujqrygyvcd>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65vs7a63onl37a7q7vjxo7wgmgkdcixkittcrirdje2e6qmkkj@syujqrygyvcd>

On Mon, Dec 01, 2025 at 03:35:04AM -0800, Breno Leitao wrote:
> Given you are completely lockless here, so, there is a chance you hit
> a TOCTOU, also.
> 
> I think you want to have dynamic_netconsole_mutex held during the
> operation of process_resume_target().
> 
>   * mutex_lock(&dynamic_netconsole_mutex);
>   * remove from the list
>   * resume
>   * re-add to the list
>   * mutex_unlock(&dynamic_netconsole_mutex);
>   

This is a pretty good point. Will address this on the next version.

> > +	if (bound_by_mac(nt))
> > +		/* ensure netpoll_setup will retrieve device by mac */
> > +		memset(&nt->np.dev_name, 0, IFNAMSIZ);
> 
> This is a clean-up step that was missing whent the target is getting
> down, and htis is just a work around that doesn't belong in here.
> 
> Please move it to netconsole_process_cleanups_core(), in a separate
> patch.

Sounds good. Will include this as a separated patch on the next version of this
series.

> Something as: 
> 
> 	list_for_each_entry_safe(nt, tmp, &target_cleanup_list, list)
> 		do_netpoll_cleanup(&nt->np);
> 		if (bound_by_mac(nt))
> 			memset(&nt->np.dev_name, 0, IFNAMSIZ);
> 			
> 
> Ideally this should belong to do_netpoll_cleanup(), but let's keep it in
> netconsole_process_cleanups_core() for three reasons:
> 
> 
> 1) Bounding by mac is a netconsole concept
> 2) do_netpoll_cleanup() is only used by netconsole, and I plan to move
>    it back to netconsole. Some PoC in [1]
> 3) bound_by_mac() should be in netconsole and we do not want to export
>    it.
> 
> [1]:
> https://lore.kernel.org/all/20250902-netpoll_untangle_v3-v1-3-51a03d6411be@debian.org/

The reasoning makes sense to me. I considered performing this cleanup on netpoll,
but given your patch opted for this 'hack' before setup - I think doing it on
netconsole_process_cleanups_core makes more sense. 

I need to check this more, but I'm wondering if we would be able to completely
remove dev_name and dev_mac from netpoll and make it part of the netconsole_target.
Perhaps as a future refactoring after your patch series.

> 
> It needs to be initialized earlier before the kzalloc, otherwise we
> might hit a similar problem to the one fixed by e5235eb6cfe0  ("net:
> netpoll: initialize work queue before error checks")
> 
> The code path would be:
>   * alloc_param_target()
> 	  * alloc_and_init()
> 		  * kzalloc() fails and return NULL.
> 		  * resume_wq() is still not initialized
>   fail:
> 	* free_param_target()
> 		* cancel_work_sync(&nt->resume_wq); and resume_wq is not
> 		  initialized

Ack. Will fix this.

> 
> Thanks for the patch,
> --breno

Thanks again for the review. Will submit a new version addressing all the comments
once net-next re-opens.

-- 
Andre Carvalho

