Return-Path: <linux-kselftest+bounces-9032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563F58B5C43
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 17:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6931F23442
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3F880BE3;
	Mon, 29 Apr 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6cMH6ag"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876177A15C;
	Mon, 29 Apr 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402974; cv=none; b=T8TD0bUx1CjKtqgyZL0GdJ+usOBdan/iHK3odP2ch9qVQZomULIYEXdWAe6Hufaym0RDys+KkCayHjBdqxiULqpY4eiTDo20jC+keu/ZjrcsSW7aLn+eGzzqqynJRWNZFmvW0V96T+jS1l28Fu7i81IEJwdCjH4exCR/D408Cpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402974; c=relaxed/simple;
	bh=9mH8mEOE1dSSYwgn2rU6/gupBcn8q44CEw5+mQNPKC4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gFovlcXRN9GNje8IEPIS4724Ni6YyfZaL0IMgFTj/qXnj2coKcA4aVbRp8gOQlZmRVsyZbejqYfejIbIbXAYkmUg8HO0xxaVgZSQFh9vCQjnvGyzI4Rrwz/SN5d20BIrrSPVu1IY7KUmW8UIwI3Xiw1Dv05GQX9wD9Yeoctyurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6cMH6ag; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-790fb2b780dso64145385a.0;
        Mon, 29 Apr 2024 08:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714402972; x=1715007772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0b4utLXVbvyB8TX/ZY7IuTcEIFQDuGxLkh23ndrmBYc=;
        b=S6cMH6agAju6h95jbdkCco4WIu8PSOVqR1PiJ2OeXNnLsnHHw7tkDUy31SvOBl1bC8
         sBcN3N/JAG1AajrjhKz5sGIEtzDdx3sYoeX6LAz1qejZ3kGLdyFpUFkqlXqfIreAXZr6
         mp3qe1/SQgAsbhYCzvcxg44yfqjjc/CBDWG9CHzMqyhjjH+zgR8BKJTkhwm3uIv7PGwi
         V3bRazOO5X+1qqo4dTfMVc6UdqJepswo/1EnW4tdzOwmGVu3umNibhbsyaaz/cbS2Zkc
         9yxxxGWbjV6GmNN3CfAL6gQT6OjINXAEPUJ3gd9coiw2SVb+fjNfgZEz/nTOpm258uIm
         eXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714402972; x=1715007772;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0b4utLXVbvyB8TX/ZY7IuTcEIFQDuGxLkh23ndrmBYc=;
        b=PTtpOUvmpUxFlmZPKJT8kokoZQZiwIx9WVaOsjJ954kZpnET56LRsf6oljDDpnmj68
         OE9uJpvBbCMjh2CKb2mT3Wec7edblvk8appUyk3Jtol7lKHwEdHB5HoLVKj2y11C2HK4
         sp4DF9b2pT9gQdmy74DJkR0PIoIkK79IrwTET44Pml8J6K84t1R7uEZipxF9iKaAOOJ0
         QfX2RBPab3mqJSIO8ayB+GXPNf23r9s2Zjzgo9J8tJQHP4S2jUaYtbwvkDxZ4TnD3MhL
         F45mbVP8MzNkv34P059BuVzyPa4rNk1lbEb1JD1HvB5GdZtUZPsPDZQxQUvw+Y9YTIQy
         yo+w==
X-Forwarded-Encrypted: i=1; AJvYcCUhq/z+3nAnrjdgeMSfXJoF7/pP1eC4rpvVgp9DvgoxJ03CEhDjOyeBhLWd26btyNtU3oKL55bh2qmswF9FxQ4vtynpn+YDUN7XlG1dLBctIEmkYhqYNcOaFJ7bPY8UCNSqbDbdeKbh
X-Gm-Message-State: AOJu0YxgrkGW5SqTeVlgnQ/wVxvdW9fPCKzEoKf7hq9dLLeqTJB3uCGa
	gEXUztz5tG2keWEdnf/69qG1J8mOjv0Cs6Zb4GTDG/NSeg2Eemh0
X-Google-Smtp-Source: AGHT+IFfdsyUdB3MEnaRf39QtbrDkeRho2UKF7CuRGNRm1CnVlBH/LY39EQ4B8tYyRoIIdUExf/7DQ==
X-Received: by 2002:a05:620a:2699:b0:790:f387:c2d1 with SMTP id c25-20020a05620a269900b00790f387c2d1mr4894104qkp.5.1714402972174;
        Mon, 29 Apr 2024 08:02:52 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id oo8-20020a05620a530800b0078d693c0b4bsm10469745qkn.135.2024.04.29.08.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:02:51 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:02:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <662fb69baa4b7_2e6aae2947c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240429075158.51b3f8d6@kernel.org>
References: <20240426232400.624864-1-kuba@kernel.org>
 <20240426232400.624864-7-kuba@kernel.org>
 <662d0268e71c5_28b98529417@willemb.c.googlers.com.notmuch>
 <20240429075158.51b3f8d6@kernel.org>
Subject: Re: [PATCH net-next 6/6] selftests: drv-net-hw: add test for memory
 allocation failures with page pool
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
> On Sat, 27 Apr 2024 09:49:28 -0400 Willem de Bruijn wrote:
> > Eventually probably want a more generic fault injection class.
> > 
> > And for both fault injection and background traffic the with object
> > construct to ensure cleanup in all cases.
> > 
> > Maybe even the same for ethtool, as ip and ethtool config changes that
> > need to be reverted to original state will be common.
> 
> Agreed, the nice way of wrapping all that has not revealed itself to me
> yet. When we discussed it with Petr a while back he was suggesting
> "with", and I was thinking of creating an object with test as the
> parent. The with is nicer but here we'd end up doing:
> 
> 	with a():
> 		# some code
> 		with b():
> 			# more code
> 				with c():
> 					# check traffic
> 
> which offends my sensibilities.
> 
> There are many options, hard to say which one is best without having 
> a bunch of tests to convert as a litmus test :S So I stuck to "finally"

Entirely reasonable.

Btw, I have a preliminary tools/testing/selftests/net/csum test on
top of this series.

The only interesting points so far are the use of deploy (which I
assume you have on some internal patch already) and that with bkg
would not fail the test if the background process exits with error.


