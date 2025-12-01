Return-Path: <linux-kselftest+bounces-46859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7E9C994C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 23:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4E93A4926
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 22:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36380286409;
	Mon,  1 Dec 2025 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awW4FuAi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68AF283FE3
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626796; cv=none; b=jPs8dU0jhK2Kr1KSABDqcaArFTQaxLcGkiXPOshmgFEr7IFSa9w7CFEJ5/+ySRFEobTLJNzmQYZGK+UMIFCI2b0PkMHL5ANzGBEh2ey0hg/fKVVu9Q4JPhlW1RS7KwVlltd21csEjESEoLln4de5L8b4+ppYSAyzWmJlIA7gXVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626796; c=relaxed/simple;
	bh=a+/3Ja2D/pQZL1X0Dhkaimbdc5lxjQT2Xnvsi0l8mf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssTwjmW7djtxv+2fAPTPAubbxPEriFzXpE+1s3pupR3nTY6y4kuGH4J86FjHNX2KSXe5HfkZE4ELWSzEvdHAdmiHtAcSfs6JObLJNclwmfQs0F0WIFcvXYKZOWVJ4xfeF0FD8fwPrkndezV2+ShiF6E8UdQfOPnlVyucW2EMSr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awW4FuAi; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b98983bae8eso3742536a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 14:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764626793; x=1765231593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bzBsG4oWJXV6B7jpmlKeQ9wP6eF71jAwh85HbHOqniI=;
        b=awW4FuAi/RtjVS0xcsfdV4j+6Molx9MNsVRFq9YrhbctvqJJii0nQNzzovsyGD97pH
         XniicBI9J/ibOWuaJ9HczsVnYMvV4vvrt9U8GyvndxTypPgMwdKuvMgC+9BPh9POmB3z
         1oNVS1Vcji40EcYnuLbxNJALzIxL2DM7cHJdJ5YMuBZGdbIt0sHQwe9p5VHJzIOV2vmq
         xS2nZLBE0RaATbcOLUw8fxPnqzxUk/lQcEkNmpHjM3mbEINxz2916DPEq6kPyHAmXYMg
         XUm6ev9YzNFrI7aN0yyA42nAJYXgKwsNysUBZZF5PQkxcFnt99BEZk3Y72c9V/6wD2G6
         UfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764626793; x=1765231593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzBsG4oWJXV6B7jpmlKeQ9wP6eF71jAwh85HbHOqniI=;
        b=iEYvGIZsLqGOyjBwDr5rN0OlI5TlZ3OTdhNlfooEjIgyFAPfW9rvIgQllwy2Mmdfwu
         TULMMBUd6Km8767E/1MdLK+O7PH4swMAZGxH0rm+yPWDa6NV1FYJFO62L/KdgkFAokPs
         pN+95+yXFjKg0yZaftvVoAW+CGiUyceJYVDF4Xk8mPM7OJppXrMzh2MEzF3LGTR84zN3
         eI9g54yUfcb5QWavl1rRaqD6lZcec5kTZHp5IqPrnRTGAvzrKQl8aoGpj365GpKdPtlP
         OM/0OIQef2l+PMsCwE4IjWNZqBTpEKS+/6Ec0ou1eoUZyuuRrUYm5mitvhiuFcZ55yn0
         iTmg==
X-Forwarded-Encrypted: i=1; AJvYcCXOYRmNgTpT2x1u6M8BF+mUAn4acPBX8JLx+M2IH2a5fKPkG26f80xzw/dlvtsgO3eEoUfH92gSWZ6B62Azz/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLNkf/HIvbRa1JaJzU0pd/lyb1s+bQo7VMXMkXfY+G/slycrxn
	6G9YuTNoNkZFaVA7G0pv75fIk6/2rDHduKQttbvrD0TNwUuTuEXrP7r1
X-Gm-Gg: ASbGnctyiXpdXJwttFMpqeU9uoq1ZpWJxe3ymLRyaDSe+yH3ZagEGAWWcZUZ2GYHeMp
	ivGM+bD1YkJ4yPMh3Nic1gBZHvCPTobCopzCY6/fZXnijch18Y6tuxleXkWXI34MaPGI6PKQnCh
	0P15z6N4pIfLSnNG6wzfJ7VHFz/D1K16djPvs9ThRGiW3A79QyNDS+uxHv71im0/IAIoCnp9JPx
	9hvpaVrszCoEujtNOYjrIWZTyL9DZGLv3CpoUqjKLG3s2p6G43wyY5CIrXHo3D9OJbAI4PPU0l/
	DaiQ0dJ9cud9D0E+wx9YeMj36F3JEXT+1QABbOsTnA4ISXIOT71KtnJj6TM0KQc3HLOv5icdkGJ
	LgtHuZW9NpZ/GuyDDpCjZd3UA9fUUZKhG4w+gaK/mDRXhpdv+nLKG4krqewA18tW0g3YSmficCQ
	0syO9ohfjqbw==
X-Google-Smtp-Source: AGHT+IGhmMxPsgaoPXnzgSVj6wNtw4Ah5MXEyylsvvZXtki7UPfq2bXLwFkO2O3wbGKc+QoBFG6+CQ==
X-Received: by 2002:a05:7301:b16:b0:2a4:3592:cf6d with SMTP id 5a478bee46e88-2a9415cd90emr11088569eec.17.1764626792802;
        Mon, 01 Dec 2025 14:06:32 -0800 (PST)
Received: from archlinux ([2804:7f1:ebc3:d24b:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b47caasm50506902eec.6.2025.12.01.14.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 14:06:32 -0800 (PST)
Date: Mon, 1 Dec 2025 22:06:24 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8 4/5] netconsole: resume previously
 deactivated target
Message-ID: <2sqyjsod2s6kdukgipgcpjqdoysaw6trpgymxci36lmi3gykvx@tvg4qh3veuiq>
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

Checking this a bit now and I'm not sure if we have the same problem. On 
alloc_param_target() the cleanup is simply kfree(nt).

free_param_target() is only called as part of netconsole module setup/cleanup but
only for targets that were succesfully added to the target list (so are guaranteed
to have resume_wq initialised) before we hit the error.

Let me know if I'm missing something!

-- 
Andre Carvalho

