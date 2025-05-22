Return-Path: <linux-kselftest+bounces-33492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63663AC0360
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 06:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44A41BA2666
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 04:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FDD1531E9;
	Thu, 22 May 2025 04:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhUGLuTC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA613C3C2;
	Thu, 22 May 2025 04:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747888495; cv=none; b=XTfWbDwSoGnCWDN5RwuBuUNzFiPb1fwj1Kvr4dA/lPo4aNiLusjhrM9esFGmO3ELVw9PW95J2RY+lT1117Rcje1xjZpUvH02DNIs0FTI8whACj66HcqRYuPoRE+kVF9AuBgY2z6o8u5KRlPnSmQHHFlhiXMS2RwI5lxAsV7DXKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747888495; c=relaxed/simple;
	bh=maXsqPtGcGxSazJ5XApc+kX6npnd7DTsARU3qhaPnjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSSZAoI7a9fX71tb1C1zm7bGEMm0TSWvWhEh7aK7kXvs5SrHfUBSAYgG1BtU8VfY5VaFYDJUAK5YldcFnU7pIxJSKf4U1UBtNJZvWtTK/bF07L/JS4TrXc11xYbJfGIUKky/JYIxadXaVefrbNAyFOjP9zk+SD+imin/bz/c3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhUGLuTC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so6229415b3a.0;
        Wed, 21 May 2025 21:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747888493; x=1748493293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dky3FIQgBX8aNP78AifCGTL6ccyTVByog03wzzXO4zc=;
        b=QhUGLuTCRA9hlvAwKZP96PMj7Wljt4qJC3MHW1BppWwLxyIPLxDoXiT+qdIgeVPQVM
         A7aAwmkqEZsPgDyvX/xlIQVhv+AxMLPwbNVO2rb9TaitvBzTF7HDjg36qmbuAR7gCi4B
         mZc51WY9MsPv1ZPWKYcSz4iYFkDDVhv6vQGmZS40gur4AST1mFQAI+uUIaPH3/8iW0v9
         NRX5Z7JLu99btYJq+wH5d+q6NeJa2acadldymyGSFBmrBG15m3jvvcIbQtJe2H6j6fji
         AA7l5P4qAR6i2H6RUJ6ylbog4Y1U2jFqZUdWLHW9ebB0LzoQKkC/lpHzBjLAvKZnFevX
         GzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747888493; x=1748493293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dky3FIQgBX8aNP78AifCGTL6ccyTVByog03wzzXO4zc=;
        b=YYzyYvmxhsRz+AUerImcxZuzcOED+SgMPeaFdV/9p54igiBoPmU6LMD5R30uhtdzwk
         SBw8la8SjyHLle4jbaiipcXH2W3ojVB3Q1upfw37HKgHQJJPEUJb63q8DMXjdOVoSvVS
         ZgTXqWwmMcidxhRze0k6BP7i2WP0vTF+pjAT9rkETsH5+mMC2iStofsBx3z6Fd7RCOx2
         q5PVrZ89N0hblxz2POumgBfRVYmQa069zuEFc7eEDP5wzZ26hP2Tuf8f6BbgV8MbjBOR
         MMrcAKfCNV14JqVOgVTK2LIp+r4LJ4JMACK96OJwdVe3oxszUtnpVtbxE9aj0IdyKBGo
         1BGg==
X-Forwarded-Encrypted: i=1; AJvYcCWgHxE8O/co7S93An9wqPADrOthzZrDnt7WpfZAsa/AjBGF6C7Tg9KrshswVyXflV/uG0FUxPOh9bkemLs=@vger.kernel.org, AJvYcCXh52mFpdhHDLRtomLHV/SMv2PHamXc787sSRrpx8Z4nS6LdZHvtJYsu5XZbULoYTabdsZDLUK/qCsYpzpQPCro@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1GQU8KIovwPuSrpNUrsTmEHfdslm9A0LelpEVj0pfy8xnC+8
	X4Dz5WOxvOrUGiehLrvI0XaUjrkEjDLlCOowpSkD/dSFG32UqRndvAld
X-Gm-Gg: ASbGncsOX0M4dz4PqB095QZ3mpMUHarGeRVGLhVJmTGPqS14E1DHFCtUHd13ybtjl0F
	nMlcN8UGXfcNkUBhD/rOaoUXL3+gHTA6SltIn986k9dN8CIhOgpBmGjL23fkYYuUdkhV1Y50eWk
	CWG+vNoywocTLqeT8n5IbpcTZw/OVaXf0jGc14cAeT6Hgs6PRloV+/LdnxRpfh0ZfKrvSi2vyqy
	zQQxcj99ZVoqh64BZq4GVEessxM00HKKssc5P8x88gkSbES5JEWN7D7jNAODE4e+1w6dcIc1ptY
	J8cAXimMsnRf5qXiMt7MS97jWyyk7xtEk+vfFIu5GUBhvP+44IhT8tiC
X-Google-Smtp-Source: AGHT+IGh3Q2clU7Qyx5JWq+TxnZeFNMMnKfZXa7ry6Qxs7rCrVIzwW2jPAJC0kCMqhcqM6mA3QmumQ==
X-Received: by 2002:a05:6a21:3993:b0:1f5:56fe:b437 with SMTP id adf61e73a8af0-216219b13demr42046834637.32.1747888492887;
        Wed, 21 May 2025 21:34:52 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a9893sm10518551a12.72.2025.05.21.21.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 21:34:51 -0700 (PDT)
Date: Thu, 22 May 2025 04:34:44 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>, Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 net-next 0/2] wireguard: selftests: use nftables for
 testing
Message-ID: <aC6pZJJn3BiGFVwr@fedora>
References: <20250408081652.1330-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408081652.1330-1-liuhangbin@gmail.com>

Hi Jason,

I just saw this patch set is not applied to wireguard tree. Did I missed
any change request? Should I repost the patch?

BTW, what prefix should I use when the target is wireguard next?
[PATCH wireguard-next] ?

Thanks
Hangbin

On Tue, Apr 08, 2025 at 08:16:50AM +0000, Hangbin Liu wrote:
> This patch set convert the wireguard selftest to nftables, as iptables is
> deparated and nftables is the default framework of most releases.
> 
> v6: fix typo in patch 1/2. Update the description (Phil Sutter)
> v5: remove the counter in nft rules and link nft statically (Jason A. Donenfeld)
> v4: no update, just re-send
> v3: drop iptables directly (Jason A. Donenfeld)
>     Also convert to using nft for qemu testing (Jason A. Donenfeld)
> v2: use one nft table for testing (Phil Sutter)
> 
> Hangbin Liu (2):
>   wireguard: selftests: convert iptables to nft
>   wireguard: selftests: update to using nft for qemu test
> 
>  tools/testing/selftests/wireguard/netns.sh    | 29 +++++++++------
>  .../testing/selftests/wireguard/qemu/Makefile | 36 ++++++++++++++-----
>  .../selftests/wireguard/qemu/kernel.config    |  7 ++--
>  3 files changed, 49 insertions(+), 23 deletions(-)
> 
> -- 
> 2.46.0
> 

