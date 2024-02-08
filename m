Return-Path: <linux-kselftest+bounces-4375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF22C84EE09
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 00:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7F71C22825
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 23:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CF050268;
	Thu,  8 Feb 2024 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eesw2JxU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9F250257;
	Thu,  8 Feb 2024 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436011; cv=none; b=ijFl3c4YOhFyYeeNuCQRCn+O9fPYMMz9CeVSeQy7pYUFmgOAtBi1ZCrF6lp2zADKkd+UznSsQ3SEPniPrk/ycZgXlc3YvHm5RRkDO8ucOP4akSDnIe7j+tWXl/X+iLuNl0gIPFVZmTMosrDPuESv18S3qn2zBw6HiIS2AsJryME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436011; c=relaxed/simple;
	bh=Z6/eq4mCECFr19qgzVTYlhY2snCKvObwpvIJlWzAdWA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mL0I4SbNvx8EyjbaS8Vskqaa16jGJNyhpSLgMfnlZu96w6NxYbptSgG01DgFlEv9o/DRJSOyD9s8cBXFpbr0Cmf7XLLIhG6EYD/sPG4iHsycDzinfQywm88WuAf7HV9b3hKDa4AWzY/KDEET/k3XEyi3raopIjlngSAZS10bS0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eesw2JxU; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-783eb452e01so40443485a.1;
        Thu, 08 Feb 2024 15:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707436009; x=1708040809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGOyRKO3JmFiBzuvnyUUaN491tu1C1D8YE+4TVghuF0=;
        b=Eesw2JxUtEu6+CLtjPwQv5Dm21XBPQeH9PdNF7mpNW/9926bnSpkr/mnzcQi1Gru1/
         dFZK/xvUPa2DKF6ylllMnW+aF7pBa3LjGnCnvb45mFMJ+yGTqfAHNDExHBjX/NfLjsor
         X9VrFNGE62sqAt9mkWKtCDFry6Csc2UPZEAc8OTtdBlhk8KGdcm6zlQK467WlKe5pAd9
         utBsOZzAVbSsP7W1inZSKsAM087gIfzrA+eDr2/z8TVEIOj+tk6btJJ3Cwc8OxaEfrPb
         rrbcYF9Ul2xJy4LPji4dp9o7zWKqgYMMmEl+1RIB52Cc8nWModoRVt8lAMhXgbw40W3H
         +J/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707436009; x=1708040809;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tGOyRKO3JmFiBzuvnyUUaN491tu1C1D8YE+4TVghuF0=;
        b=khVe0HI9BAlGnUtIQQn/pVFg6B+CFWT6SU3fXjyxC0r0zEoMJJt5XJ+d28XU3haF+N
         ODQVRpkQ8HgDRl0MElD6CV/0difPy14TQANR+eDzjZ2Cst1LUTMnV3mB0ftHxoJLQVpF
         PfidrCMXaahJ1DSP0n+BBVJ0ta15jrHOZn+G9MopIr+DB0IinsmrSaZAlDSU2kn9p5YZ
         rqM5s1tHj7BLNuujFMxpzC5tpPjPuib6OURBS3EBJO5UJNMuIRSAO0J+YVzSzZ+RCekH
         tBJw/OlRbYm2syMgZnAyamxis0Uj7OLsuPmqdWmXhAZw1rN8f2yAFPxHDKHuxJcQ2PRh
         EHCA==
X-Forwarded-Encrypted: i=1; AJvYcCW+A2weDMjOxMel5No12gm3a9eCeyCMxtSfwqfgO6WySQnOJQAtPIJq35Wm2VJcbRVXTbwY5fGI+P65sWked6Mg3bXtkcoqifiUQdw8jHBtX7kj7D0y6F3zwiNCFrya5dJqlRvI1dwF
X-Gm-Message-State: AOJu0YwDj7XAATYLAaeMU0CAY1lUPV0mS8opb7aRyA/Ms1YOSJvt5H3O
	kYxYVX0mUZUZOxY5Nmtbm2MaNRgKmChJlcKekvZ0Ev731zNgr36S
X-Google-Smtp-Source: AGHT+IGRDw3GJaw0eWJQjCwh+EHV8fItX0mhOG3l5oCqEVowqAjNBTB6jRib1ly02k/ynZ4l840bmQ==
X-Received: by 2002:a05:620a:1a24:b0:785:b412:c7dd with SMTP id bk36-20020a05620a1a2400b00785b412c7ddmr477410qkb.2.1707436009052;
        Thu, 08 Feb 2024 15:46:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUopiGD0HWBWb6BcnztTr8KWz4LESWfJvDA2hJST+Tq8COMy4/lQKNkeH8cCDjBuH1HkIQtvFNcuKVlRwUc+vp0UkmvPARZ+GEAcUyfFTtnJxAA7MToTAxD/lwyD8uTBLo1RC8/OmG6rWqBxvJhtNtcTOXuZrb95LQ1KuheM9xJ2dDB/YpR7nKiAlwpVKHfyqT0AO8K/+K1Nt3FhRBvwJ8v8p98qvkmy3MiNxj9rpLsBlJJ0uvohQHuTE960B/cQ27DjACk
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id b3-20020a05620a118300b0078560085d6bsm253534qkk.100.2024.02.08.15.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 15:46:48 -0800 (PST)
Date: Thu, 08 Feb 2024 18:46:48 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
Message-ID: <65c567e869ea6_28ece2945c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240208153440.590685bb@kernel.org>
References: <bca0a7a2bac7fb1db6288a54936cdacdb0eb345b.1707411748.git.pabeni@redhat.com>
 <65c53ed3bbeee_1ca1e229434@willemb.c.googlers.com.notmuch>
 <20240208153440.590685bb@kernel.org>
Subject: Re: [PATCH net-next] selftests: net: ignore timing errors in
 txtimestamp if KSFT_MACHINE_SLOW
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 08 Feb 2024 15:51:31 -0500 Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> > > This test is time sensitive. It may fail on virtual machines and for
> > > debug builds.
> > > 
> > > Similar to commit c41dfb0dfbec ("selftests/net: ignore timing errors in
> > > so_txtime if KSFT_MACHINE_SLOW"), optionally suppress failure for timing
> > > errors (only).
> > > 
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>  
> > 
> > Is this still failing after commit 5264ab612e28
> > ("selftests/net: calibrate txtimestamp")?
> 
> On a debug kernel it continues to flake :(
> 
> https://netdev.bots.linux.dev/flakes.html?br-cnt=80&tn-needle=txtimestamp&min-flip=0

Thanks. I should have checked the dash directly. Reminder for next time.

Reviewed-by: Willem de Bruijn <willemb@google.com>

