Return-Path: <linux-kselftest+bounces-38793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373AEB22E43
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 18:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC372A1DC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 16:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C2A2ECD1C;
	Tue, 12 Aug 2025 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeEfr4yu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085B9279789;
	Tue, 12 Aug 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017210; cv=none; b=kJ8jkL3jxc9jG+KFJFErn776+Xi9D6pxqevPbnEM3pyf+VQ+mXfmwOMjGpUlPHjeQMpOWGUxJfXZe/I7cObfMG5Sdl/im4fZvuGPGc8x6Zzubyiysqci7R6+0ST3Va2nyAvM3WuxlGe8pScq5HEq103hxBTlobuw9ablK709e8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017210; c=relaxed/simple;
	bh=xFqw43ARvi3BBdp88kj9s3oqfRlMorolw8kQY2CD3uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1ynN4blxZJUPAzahg6VkJhHg9ZhJyPv/cGDgmuxhnvuLzwtQhd7Onbeshq2jgbHO1GHEIbXaXgsSwnRymyy4avdfbtHnWBEZFvZk17sPydAhU4/GDNRk8rwBcQ4ZxDwW36mMU1/Uz67QEYkYjOV047QytDkSZ4NoJvR/Bw0S6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeEfr4yu; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bd041c431so5078983b3a.2;
        Tue, 12 Aug 2025 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755017208; x=1755622008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7eiYNupysPDWdip4k0dNtH/4KCtSU1V8Hb/uMZEnJvk=;
        b=ZeEfr4yur+IsVNWckbI3Ok/MUNoMrI16n5lyTRmOfZLP6YK+qjZG+M24MLqA/IYAvV
         WqCWtXI4V6/7ujzQ9m06rQflud/rzg9K2pY3IPiGThXu7pEalIpexGJTDOKpfNpjH2E7
         584NHzHJ/oVLemfjiW+bNIlybeKfshoouVqFRJky5DsEmQ6Te1CdKQYXkVv/3mWempzl
         /MKEbh5VjaYG1xZ1Q/w2V5JJ3Tsrq28kXIt6pL23Z2IevJaQpSi1rkDEp19fNlBr3diE
         897l4HzLx1ievr8Cv1btXWpDjMyP3J7iDOvJkUhLlESyWlkYLjZ2BcDcrSGqAPD09XVn
         CcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755017208; x=1755622008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eiYNupysPDWdip4k0dNtH/4KCtSU1V8Hb/uMZEnJvk=;
        b=DKkJVlWsJmyj72ggaV/LmdfrS0kxC6BRJw0qUksDbdykqe16ZaIiNEz4a9XBjWogV4
         tdjKa3Q4xBP23UxyjvNi7EGZ0YQUPdV3jlnnSQ7wVSPgOAuTXlXKllnBLVBHOcJSjUvf
         OFF8CLGfk01xVWf6Y/UJuij2XUVA46K9/PzegHH1CcYbZ1gVCLA/eqKxYnX9I0ZsnLjx
         Yezq78wGXYUrmW+Tzo20j28wP8WIlkkS/UBml5ikM/VvIfHjphDUm21a4cndSUMBuWn1
         q2hXPCpXUnKn3eYTacNT7IFvkrRIvontfXHffCHbTPmpUgFkikxi3RCXYEDT6yBfbC4M
         2ywQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIrnOXXgZGAtyf7zXjP6rhc29Zv9jutaTeAkDMf7a0+BHoF//iHeHhswsV0PFoZJ8ICelnLWCx@vger.kernel.org, AJvYcCWiXgrmMgmkGF28XNhYdXw2IgS+vaTbJ9wu685IUwUzTNVcHiu+bV4TMHY3bArOEC91Whqmbg36VRwswDr2biY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+fRvz4drAiUrO+qsxh81Sxv/eNEMs0+n4OTs/3j6tZwIg+yZ8
	bAsfqV3EoASP1xYqHYnaKsrXTn0ke1pKKhLYpEpmxAXQhGriOWGznn2txqFC
X-Gm-Gg: ASbGnctftl4Jv1LJLNgC3og5ZLmDiVayOQSxWG/3eSrHBIw07TEDH+XrP2oSEZLpEk6
	+Zq7cgIVK3I8xdgRz6HBsCMGez79d1WU/QKW35r8PkhNkrx8r9l/Hg3ALVCwEZZY4UkuVgHKPx8
	2sNSoMYO31WcZxd6FyfGxuriDkn5ERfdKuLA96qIBaMmMS8YmGEWolisZLPiNqF1dzYmlqhxKGY
	xPUZtGvR3KJmydsfBHc9uYOuOK797T155bveIZt5YBYh3nli4wZuwZoNvHYtgxgK9j0/M8Wg4+n
	8orFrYtVY3GmDTYJYTAGWBdl14aCvo/c5YSUSOeO6kqOioabXMJwahFW2DgZoaca2t34eIG30dX
	82fWspqG+KX8jNUS46hpQDqWXKPD1grtKuIOgHgf9ADi7CB1MtA7rITke1trzAV4GWAVGEg==
X-Google-Smtp-Source: AGHT+IHIO803B+hrcwF9FTHffTpNByVSl38Shq7QHcKb0pTI30poWovJLCHJBqAdkYPjv6qRRY/p3w==
X-Received: by 2002:a05:6a00:ac8:b0:76b:c9b9:a11b with SMTP id d2e1a72fcca58-76e1fd62aedmr420754b3a.3.1755017208181;
        Tue, 12 Aug 2025 09:46:48 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76bccfd026dsm29830559b3a.95.2025.08.12.09.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 09:46:47 -0700 (PDT)
Date: Tue, 12 Aug 2025 09:46:47 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, almasrymina@google.com,
	noren@nvidia.com, linux-kselftest@vger.kernel.org,
	ap420073@gmail.com
Subject: Re: [PATCH net-next 0/5] selftests: drv-net: improve zerocopy tests
Message-ID: <aJtv9z8wtQiu80ua@mini-arch>
References: <20250811231334.561137-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811231334.561137-1-kuba@kernel.org>

On 08/11, Jakub Kicinski wrote:
> A few tweaks to the devmem test to make it more "NIPA-compatible".
> We still need a fix to make sure that the test sets hds threshold
> to 0. Taehee is presumably already/still working on that:
> https://lore.kernel.org/20250702104249.1665034-1-ap420073@gmail.com
> so I'm not including my version.
> 
>   # ./tools/testing/selftests/drivers/net/hw/devmem.py
>   TAP version 13
>   1..3
>   ok 1 devmem.check_rx
>   ok 2 devmem.check_tx
>   ok 3 devmem.check_tx_chunks
>   # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Jakub Kicinski (5):
>   selftests: drv-net: add configs for zerocopy Rx
>   selftests: drv-net: devmem: remove sudo from system() calls
>   selftests: drv-net: devmem: add / correct the IPv6 support
>   selftests: net: terminate bkg() commands on exception
>   selftests: drv-net: devmem: flip the direction of Tx tests

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

