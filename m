Return-Path: <linux-kselftest+bounces-35234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE894ADDC6B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 21:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E903BFAAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 19:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAED2EF9AB;
	Tue, 17 Jun 2025 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="savLHHtk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAE20297C
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188836; cv=none; b=MMzRO+eLDUWIutqPJ9SsDKk6X6osrzAMAlostsvHTDx0uK0rFOSWOjlLHm4huIes7kph4kPeTHTFU8kAdlU1ORroROYOedknR3alBSTKOaTPjFwD8kUSN2cFPYreZe5wFXQT9pHXXIWirkTHgvm/YymGaNkk+iz5eqR4bA+o28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188836; c=relaxed/simple;
	bh=k/TpLa/PtWMfFkZ4PpMbzwrabb0DP58l+kNvcugkCXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJF9TNzxk7VC7GuCPO4GoE34zX7t+Cp8KkJaQ4f3EW6dNCxSM5KLDvsmdvFFKRvDvnTWJxiKnGWeCIn2w7Eqgkt7Jmju7hF/BfXPH40jtEYZ71S1pEDhj/tDgZrVBErFLH5MwSz+s+o2rtRKwKuHNDvf/jvrHsizDe2OGcqaXNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=savLHHtk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so8893f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 12:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750188833; x=1750793633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9AFIG2TIq+3H8Om9x4puK4H6GBxJfrgH+yDtc9rGns=;
        b=savLHHtkigRbwEN8fhi74siBsUCc+NdjO2fW09sXrReDg/AVqKUvVC/SOJeM2QCqjj
         HEiK8N8OVoaPKnYMb6tiz37a0lmQBfVgXBSTLFhqI1WKko/32WNYGy9Iom0lTSIWKaa8
         YwZq3WDXWIbmnrHfQEijcdZ1pailuJNzHv3upGZ0yD/Giuo/OennSjsTBGz3ALZWt/sp
         DmuclvbbpFJ46Lb+QzJW22013+rxP/sPT8NFEuino0+VP4KswBTO8lQznQZc1j+BK91Y
         FkQi0DNAz43EnDBBe1Rf0zF9a9c8wGlio9SChnfutmruV0UPwbX3f9eY00/qUcYwgF+3
         zkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188833; x=1750793633;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9AFIG2TIq+3H8Om9x4puK4H6GBxJfrgH+yDtc9rGns=;
        b=dv1ORClWj9lJiBR+Tfb7u6HM7Y6FzXQ7rPUgHv74ji7tsyN7JWeWMnrdfwTQHwF1U9
         v9Uu4AdQzYuLEr46h1JrteGxbFs03FrDg0D+BiiWYHbYmA237345mZJmkBoosVMrR4JS
         JRCG02sctbLEnht/gEJwspb95yU+Wy6ueQEIYqHh1GY0jdNJEh/UvHRdL1WDi5FpgOyK
         jaexdl0gihEq4CoMvZh4/E8mR0VzzGHfuwv6DY0soASLmKcRTGqOxphsrjn528Zqsv0x
         nW6/ahr6yO1GRs2I230X5v0hnKntqPicpRR+6aUNfjECaOWIxTcfUFhgc/5y1WrFbjWp
         y/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNQyWKPSxVxmcd9hoBDaDc3ACC1d3p0a3bJe9cKyFLK1ja811vtz9APbyQHvKmQ0z3futXg5CCyJivKwt4A14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhdQBD4wtIFOFvHIL5iZ3B0xAXonq7Ti4JNUtvACIAuRmQtlmM
	SmjTpyPdX+vZyCin2LzACfG4xaiAc8pXY6LvOxLHzW0xXE+NULQAPmilpHmxzJkQjA0=
X-Gm-Gg: ASbGncv7wpkhCXnQpky1rcmxwSQx3r+7QCUz01R/uHSpvUjbPEyjeBbqy5Nfrm4jVdM
	HAn1wP9RuuauPi8b+1eNbhGtv/21nyfBqgsNUVuHEyhoPo5ctjZC2gpjAP74AlYzTWb5KsA2AfG
	1rxG0TYBSjwyDWSCbn0yFEXG41wXP3j3WcJcQfN07HotysdBJF87OLJXtuINgmOL258wsk23sHz
	Mej7DnWf1cAcP1B0X+Q4TDa/kH2SDll5DnFF7gYpw8apoJEmRRctzs+SxJ7XbPtO4lTTzROXPzS
	DqHMcs26i8AMRTULSYae48K9AfHSw59GSdCLE8yuEQtPal3UhwpUsoIGrKlk+fTW7Nxx+mbheJ6
	K5w==
X-Google-Smtp-Source: AGHT+IFdeD1FalHjh/M0Id4CVVT8Uo1X9UM+/h0kDU2haqdwcsz+E9jE8GI2CMfLB+2+NJ4yrS8evQ==
X-Received: by 2002:a05:6000:2f86:b0:3a3:7117:1bba with SMTP id ffacd0b85a97d-3a572e85245mr12261631f8f.24.1750188832660;
        Tue, 17 Jun 2025 12:33:52 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b089b5sm14613782f8f.48.2025.06.17.12.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:33:52 -0700 (PDT)
Date: Tue, 17 Jun 2025 22:33:48 +0300
From: Joe Damato <joe@dama.to>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	gustavold@gmail.com
Subject: Re: [PATCH net-next v3 3/4] net: add dev_dstats_rx_dropped_add()
 helper
Message-ID: <aFHDHOAAqym2DKIq@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	gustavold@gmail.com
References: <20250617-netdevsim_stat-v3-0-afe4bdcbf237@debian.org>
 <20250617-netdevsim_stat-v3-3-afe4bdcbf237@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617-netdevsim_stat-v3-3-afe4bdcbf237@debian.org>

On Tue, Jun 17, 2025 at 01:18:59AM -0700, Breno Leitao wrote:
> Introduce the dev_dstats_rx_dropped_add() helper to allow incrementing
> the rx_drops per-CPU statistic by an arbitrary value, rather than just
> one. This is useful for drivers or code paths that need to account for
> multiple dropped packets at once, such as when dropping entire queues.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/netdevice.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>

Reviewed-by: Joe Damato <joe@dama.to>

