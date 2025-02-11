Return-Path: <linux-kselftest+bounces-26433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3ADA3194E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 00:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428D6167240
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 23:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0C4268FD2;
	Tue, 11 Feb 2025 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJmMMZnQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D46272908;
	Tue, 11 Feb 2025 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739315456; cv=none; b=rSJQQwwy94a2TuArqNYJdLFfAqv854O5MhUZjG0vQMFWIy3qLxf8C0GBMQbICF3AuQqplk4rR296CJK1GJyKQyj/4ZsYZJrEK6Gvep1ua4t9IweEsaiuTvn0s/mkFSttbOdj6m11r2zM+GX3PP0xx1fRJjOPPveShb7gjcz1QzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739315456; c=relaxed/simple;
	bh=0dcK66hTVokbqMQxve1BwnKvFh7KdTxSGhckilILrKY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYzUdbr09jvSmouq5LH+acTa6QFoApd9JNJfBI5kpoVhsSGOVRLXQXP8bH7+vvHoSbqPI1UJdV2qMqrZ5ii5eh3wEJD8f7RnH0LjJyrl+uf8o50S+dF2Q8YKpneKxB5Y3tXGWpLQezVl7V+8okFo2A9+yUNpWh/4eM+BVYfje5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJmMMZnQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f833af7a09so8478084a91.2;
        Tue, 11 Feb 2025 15:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739315454; x=1739920254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uf52XgtaIcQPJFViGKUdg83OmEWQbqg8rDzjq+MorWA=;
        b=UJmMMZnQsMDNPHT6bkhpZfYkGWVcVkwrud3nvh+3QUPIWHS0wehP4tCaYdM+Zc53Bi
         OBQ3ieOZ2VTjvSEhMvO8P30cW7lZUexN0GQHDQHCk0rD9K71idKwH5rY7H2nTbN+vfZ+
         2k8QNCzJ4MZNkZ4GvarIbNz27APKjpQlJgOoEbtXo3cDy8kDFlOjIqwCnwblnVRQtRUd
         b+plJtsPT1NKCkl0YAQwNTgLBX6KMz/nTEfXMGmMCryZDCiOMf66RSxDV2FHY34OYJz2
         4QfdgCf4FmCJhZrbZmH60v7oct0S0LdRth5trgMmGNNjLgx5LGcnBZjrw+mWNbn3ZZiE
         WeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739315454; x=1739920254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf52XgtaIcQPJFViGKUdg83OmEWQbqg8rDzjq+MorWA=;
        b=WHog6JhRVJubBoG+6UlxMrxTD3i20EzZG7PCtj5fE+xZl5OGmRMxbr4cPd98GpJkfv
         JiTGwbl8noO0OQ6gRkJuIB8qpHjMkJcCgXYG4RaCXfn+wFd4mijErL2oiMdwvjw1hdHb
         GkSwO7Tl6J0RiFjwm4lasKz/42eoWJAbWS4PyEUfPQ2o+/xw2ESUoo/4EUtzKQecSZYo
         6SUkEeGMxbNX2QJFxEREETwXDx9q0QqXE+CmULcmkCGnRbM2+zos+CQRhBeU9OPd2fGU
         7DMeIrOzKuVBNE/5J/aiM2zF3EJvvUB8kqxixnmcSoiQAGzPYilT/7mktfi4FuOSODWN
         dTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsN4uWSCJmcbj9IMY/hXjiCnqe65EC2lWnHv8TR3ejmmxToJAfR7dBixxo7QB8zwjOkcRLfKos@vger.kernel.org, AJvYcCXL/lN54DZ1YiiS+Wou0Z3OON1r8DrSlB9kWdeX9qEOsXONMnKeA+m6P28s3wmyAWYyk4aPQb4VuoKXEOhn@vger.kernel.org, AJvYcCXLTO42TyEWvZtrkfWkhlQb5+Aw8bRlodq1Ca915vpl0X3w4v93/amZf7JjhUZ9RD0sLLeisLB6KYOW6o/gUxeW@vger.kernel.org, AJvYcCXT1cQuEV+JbsGJGfBwjBiMGJWYYQWRI6+jMMrJVNDXqxLtFg8D2g7dE5OVxjKD9tZwcQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00DyQlmG3pSIOi3bHYt75bs+YrPx6AnNHGLUpYQrMxPlGIpOh
	SX7MryLR9JaM0xZlxgUmBI8D8UXBL6AZ2/hcUEWCusblQ5vy0Xk=
X-Gm-Gg: ASbGncu8hdi2XHFSO0QOvgzF+h/PrjDEZkwAuA23KhtHvoDFWl12PcNaoP3rhJz/9/6
	nHWaKTQ0iFXUcZVlDCVxH+QdDzDGRH4WkV7947hE7fK0JFLMSMSciDUAgF20B9efJQ9P2eCso/Z
	aXQxsN1doa5hiK9QDtGUklw+cw8LHKnuefhGEd9GBUYOYLQ6IhUkyKMuHZaQLFpx+5VUJCvuId7
	f1j4Yi0dLpyy4oUGB9CFt7GOMHZ0YkKTPIz9BmstkS7lpBb4TtDW65Vzp2lp68jvJj4ren9Nagp
	Hgv7mOpZqw7zVT0=
X-Google-Smtp-Source: AGHT+IFnD65bCd+k11rd/D5ehPCwMtJROZBHWejN4ICUo1HalU2wCbTukHdFiyKco+ppnLlqyRQykg==
X-Received: by 2002:a17:90a:c88e:b0:2fa:20f4:d277 with SMTP id 98e67ed59e1d1-2fbf5c59edamr1478220a91.24.1739315453855;
        Tue, 11 Feb 2025 15:10:53 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2faa5cf22fesm1292240a91.1.2025.02.11.15.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 15:10:53 -0800 (PST)
Date: Tue, 11 Feb 2025 15:10:52 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v6 3/3] selftests: drv-net: Test queue xsk
 attribute
Message-ID: <Z6vY_LXp3LTp7qWV@mini-arch>
References: <20250210193903.16235-1-jdamato@fastly.com>
 <20250210193903.16235-4-jdamato@fastly.com>
 <13afab27-2066-4912-b8f6-15ee4846e802@redhat.com>
 <Z6uM1IDP9JgvGvev@LQ3V64L9R2>
 <Z6urp3d41nvBoSbG@LQ3V64L9R2>
 <Z6usZlrFJShn67su@mini-arch>
 <Z6vRD0agypHWDGkG@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6vRD0agypHWDGkG@LQ3V64L9R2>

On 02/11, Joe Damato wrote:
> On Tue, Feb 11, 2025 at 12:00:38PM -0800, Stanislav Fomichev wrote:
> > On 02/11, Joe Damato wrote:
> > > On Tue, Feb 11, 2025 at 09:45:56AM -0800, Joe Damato wrote:
> > > > On Tue, Feb 11, 2025 at 12:09:50PM +0100, Paolo Abeni wrote:
> > > > > On 2/10/25 8:38 PM, Joe Damato wrote:
> 
> [...]
> 
> > > > > 
> > > > > This causes self-test failures:
> > > > > 
> > > > > https://netdev-3.bots.linux.dev/vmksft-net-drv/results/987742/4-queues-py/stdout
> > > > > 
> > > > > but I really haven't done any real investigation here.
> > > > 
> > > > I think it's because the test kernel in this case has
> > > > CONFIG_XDP_SOCKETS undefined [1].
> > > > 
> > > > The error printed in the link you mentioned:
> > > > 
> > > >   socket creation failed: Address family not supported by protocol
> > > > 
> > > > is coming from the C program, which fails to create the AF_XDP
> > > > socket.
> > > > 
> > > > I think the immediate reaction is to add more error checking to the
> > > > python to make sure that the subprocess succeeded and if it failed,
> > > > skip.
> > > > 
> > > > But, we may want it to fail for other error states instead of
> > > > skipping? Not sure if there's general guidance on this, but my plan
> > > > was to have the AF_XDP socket creation failure return a different
> > > > error code (I dunno maybe -1?) and only skip the test in that case.
> > > > 
> > > > Will that work or is there a better way? I only want to skip if
> > > > AF_XDP doesn't exist in the test kernel.
> > > > 
> > > > [1]: https://netdev-3.bots.linux.dev/vmksft-net-drv/results/987742/config
> > > 
> > > I'll give it a few more hours incase anyone has comments before I
> > > resend, but I got something working (tested on kernels with and
> > > without XDP sockets).
> > > 
> > > xdp_helper returns -1 if (errno == EAFNOSUPPORT). All other error
> > > cases return 1.
> > > 
> > > Updated the python to do this:
> > > 
> > >   if xdp.returncode == 255:
> > >       raise KsftSkipEx('AF_XDP unsupported')
> > >   elif xdp.returncode > 0:
> > >       raise KsftFailEx('unable to create AF_XDP socket')
> > > 
> > > Which seems to work on both types of kernels?
> > > 
> > > Happy to take feedback; will hold off on respinning for a bit just
> > > incase there's a better way I don't know about.
> > 
> > Any reason not to enable CONFIG_XDP_SOCKETS on NIPA kernels? Seems a bit
> > surprising that we run networking tests without XSKs enabled.
> 
> I can't comment on NIPA because I have no idea how it works. Maybe
> there is a kernel with some options enabled and other kernels with
> various options disabled?

Sorry, should've been more clear. My suggestion is to add 
CONFIG_XDP_SOCKETS to tools/testing/selftests/drivers/net/config
to make your new testcase run in a proper environment with XSKs enabled.

> I wonder if that's a separate issue though?
>
> In other words: maybe writing the test as I've mentioned above so it
> works regardless of whether CONFIG_XDP_SOCKETS is set or not is a
> good idea just on its own?
> 
> I'm just not sure if there's some other pattern I should be
> following other than what I proposed above. I'm hesitant to re-spin
> until I get feedback on the proposed approach.

I'd keep your test as is (fail hard if XSK is not there), but 
let's see if Paolo/Jakub have any other suggestions.

