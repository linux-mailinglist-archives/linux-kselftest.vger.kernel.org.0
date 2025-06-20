Return-Path: <linux-kselftest+bounces-35411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D39AE1686
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 10:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AA01895224
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 08:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8DC26D4CD;
	Fri, 20 Jun 2025 08:39:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F42252287;
	Fri, 20 Jun 2025 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408789; cv=none; b=PNELNmiH/gKH5zD+XE7gtk7I26t5nmC2jglGt5ZO31la0J/FOawDFeceyIg1OB348ypFoNIDeZbWdVNqkm2THgm42mi9r1WSZZKiX+SG8RzUS+BqXMeXWzXh9lWaGsPcR6RrjVBBAydViRPkFpwqzM2J7vvMYpfvRWgipF/RZTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408789; c=relaxed/simple;
	bh=t3m4zgkquuasfnbkxfN0dX0nzEs/hohOPoU5Oje+sZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5sr6sSBJPkdImoFISqk3OW/iKbKvsBop8BOSFdtH/8lmv+lmg8GCGz4quZuZPT4Tjoh/i7Pad6/DNQqWqXZcx9/bw7O59N7T973iUjaz9tlXYIpIEcYNx9puskkUZozvU/3A2tkrv44667Vy3SfOuntSP6ft2ztzcqI0Ax3+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so274801066b.2;
        Fri, 20 Jun 2025 01:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750408786; x=1751013586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/6KSINIX8nITlevtHLgkn3+hb19b17sG99+6WMB0gY=;
        b=Bfp8TtCFkUGnlVeURedgGyNte6JR3RS6RpCBQ2yScb1yq+1GU0qoM43W/nsPzsAY0p
         G9nu96ZxHVzdzHul8VLFb5szAB08vLkTUEk3BJfvAH2p7btE6v4TIGZOd9LcY+2qMVDD
         KwW4KU9uolWS2Bvk0uDyzoab7Q9dt/L2eSuK0Cgjz8nDGZXb5xzDAlmlozpx5N1Mun3J
         gIFL/4AWCtOmdMWrmx2A8rTyNaPz9UrrBg/5RzATbifCOt+8NnytshsXCzf8Zcl/x0ju
         4HKVTFHAXJILtZ16CVNu2vuP8whwDp7WoygMbGgwMjND6u2Ns5LULyTQgZXm4WEJrVQi
         MiPw==
X-Forwarded-Encrypted: i=1; AJvYcCUmo/VlU2wJsgby2bEOKjybFklM+fcOZAhJOTYcNTGieQ8B00F41PFhNDb+0zcpdgljH5qTYV3l@vger.kernel.org, AJvYcCVm684NMaQanHhT3Ab2mHitI4TCeUuKKaQ7C7opVQBZQAZHXkLJYlBg+xdktSucf/9x3S9ML0n5u6VJ3w1svsxe@vger.kernel.org, AJvYcCXzmeL29O70wIkFvNydsOExRJWR2IJJNCpeR5PFfTagiYoH2uHPy7bWssKU9y2GvYGK8FmBxIsjR2xvdtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFRmCpOqyyVrWXTSBxeh5WYHVX3lMXXX7+VzXl3JVxa9KZfHmk
	H8VWyueuqcAZGuKzC/VciFvWp7EKzUWb4a5Xjj/wWYWL7wpqmXRBmKlj
X-Gm-Gg: ASbGnctVq6sHwMmA/ThX/qPsDRo6Fc697NAbhjOieRQJ4X0hEZEnADbwO2grvD/VNsS
	Ir6XsIP4ASqAE2cEoO84bQDSd8vNHQ/39RdO5psU0y8uXWHZXAiKjlvDZsWiizXP98KquVWx72x
	9+hDeyqLbBOAR5wLRwEV9tOa68tjt4GPIGScpGJF0c1EP8vU2RVq6Nm0FpOlZZTdptPcrUyjRTE
	Qq/g8aj15wF2XShIl2rdAiqJJA8RQf0NdNXpom0Z3YUgX8u3xshsEd9zp7whJbh37/2hxjTlHoQ
	WGJQt4uJ9ohaaKU9HR9/M0bPGifz7dnZJSQVNrRRhdfL0j4Ubt+d
X-Google-Smtp-Source: AGHT+IFJC+uPUCQdo0jPF8qiWvYcBREhi2HoqhqKfSvYBtJf/pYW+MJ6BHIIjikhDG8oYFShX4n9kQ==
X-Received: by 2002:a17:907:d06:b0:adb:3509:b459 with SMTP id a640c23a62f3a-ae0579c7346mr199707366b.19.1750408785980;
        Fri, 20 Jun 2025 01:39:45 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054209a62sm126137066b.177.2025.06.20.01.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 01:39:45 -0700 (PDT)
Date: Fri, 20 Jun 2025 01:39:43 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	ast@kernel.org
Subject: Re: [PATCH net-next RFC] selftests: net: add netpoll basic
 functionality test
Message-ID: <aFUeT8HSPYiDyALB@gmail.com>
References: <20250612-netpoll_test-v1-1-4774fd95933f@debian.org>
 <684b8e8abb874_dcc45294a5@willemb.c.googlers.com.notmuch>
 <aEwd9oLRnxna97JK@gmail.com>
 <20250613174233.0dd5e7c1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613174233.0dd5e7c1@kernel.org>

On Fri, Jun 13, 2025 at 05:42:33PM -0700, Jakub Kicinski wrote:
> On Fri, 13 Jun 2025 05:47:50 -0700 Breno Leitao wrote:
> > > Or is there another way that the packets could be observed, e.g.,
> > > counters.  
> > 
> > Unfortunately netpoll doesn't expose any data, thus, it is hard to get
> > it. 
> > 
> > I have plans to create a configfs for netpoll, so, we can check for
> > these numbers (as also configure some pre-defined values today, such as
> > USEC_PER_POLL, MAX_SKBS, ip6h->version = 6; ip6h->priority = 0, etc.
> > 
> > In fact, I've an private PoC for this, but, I am modernizing the code
> > first, and creating some selftests to help me with those changes later
> > (given we have very little test on netpoll, and I aim to improve this,
> > given how critical it is for some datacenter designs).
> 
> FWIW you can steal bpftrace integration from this series:
> https://lore.kernel.org/all/20250421222827.283737-22-kuba@kernel.org/

Yes, that would be great. I think we can iterate until we hit the poll
path, otherwise we skip the test at timeout. Something as:

	while (true):
		send msg
		if netpoll_poll_dev() was invoked:
			ksft_exit
		
		if timeout:
			raise KsftSkipEx
	
As soon as your code lands, I will adapt the test to do so. Meanwhile,
I will send the v1 for the netpoll, and later we can iterate.

Thanks for working on this bfptrace helper. This will be useful on other
usecases as well.

--breno

