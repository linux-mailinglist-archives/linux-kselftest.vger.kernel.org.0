Return-Path: <linux-kselftest+bounces-48770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4FDD13E25
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 17:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AAFD3021763
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 16:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEC736403D;
	Mon, 12 Jan 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv49jL0v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1AD2C11D5
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233975; cv=none; b=ZRjQbxgJCfrYnlyFld0TjUHN5ZTrQLyUTrQCqgqnrWuum2OKOr/PB90L7CGtBNtZOE03nSqs0vJ8WgX2q3DkQshiasH1woQXZKH/8X6tfwqijoOdd/uuRO44zT+fVcCryG+OFYOUIBnpDYwhd320fxK9cT1iZwNIk47aDXsqiw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233975; c=relaxed/simple;
	bh=hr1LpeUSVsgMgXX04pPeVZ3/Tz/dvWj7altLipWq/c4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ETJ0JGuC2TFcDAsk4IYj//U33vnrr2Q+aDKsxyznPTquaLNWtIeLeStqqZ6mWHiFM1cS99tj4FzU9doOOPIPPTc9nKAegYnXp4tf8hRxQuoKDC5bN4A6M8zajvhkEeBUAVwO20gQsXJWcqn3nQ63nQ+BQ0GBxp5VKjiI4gfBdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kv49jL0v; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64669a2ecb5so6042702d50.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 08:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768233973; x=1768838773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JGdgHIhiZP3m+qHj7U1YyVaqXSCkghOp17m4pp5neQ=;
        b=kv49jL0vhJXyu5QWec/dC+FjSBuZ28LWz5/7d4de2Rl7n5d6sHJ/7nJCfYRFvog89Q
         cY4Znai69uRcWPEe25tGo3+PqGYasvkD/yVMI1SBLaK2JADPhgatKyiV17yPXDqzEOoZ
         t3SXJdXXev9e5NS6BeWFoGhyECEgXe/tKuAa8d04KnaD0WnGjCMsQ+CqQKkDSp7ONSez
         9XtrQ0SpKEzSt5xVyw7BhkhCuvNkKROrexXPJaFLH8gSzUHw4uMxpcuKoAY8eYmfzBzy
         JQueIPKe7ndSUof3881FCOr0k6+pwct6Ii/kTS7j9SL/9+3YfCoAM/6wThIGVU7svrt/
         iDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768233973; x=1768838773;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0JGdgHIhiZP3m+qHj7U1YyVaqXSCkghOp17m4pp5neQ=;
        b=muv70pkL0fHyyFHKd9u0EGhv/fgS0Nsn6Fr9XBR4Rm5RSSb6A/oU8Q5c/YSmV7Jd6B
         jvvraVJYWG+dmWY6q3/ybn9s1enXh4hEmjEZcEOG+mLv70A8geb1Ii+sCF9X3kwPWyRz
         BdWGpa7CR5VqSm/U4Rxzv5cVabgEfZ2vymzHArv3Yv8HOBRrZmvE3Ni1UZURhWWIAWBE
         lpZzZbzm/WdnbSh3U0Dh/Idr9/YSYzxXt9iqm+JRCt2boqSfOY2/3g+FluK0AP3Bshrd
         Y4BZpnS6E005Hm1pZeTTXIb4eki6PLGh/QZLpzVBDPBJ6o1uLOaWrznQx8uemnrqWnGt
         ocbA==
X-Forwarded-Encrypted: i=1; AJvYcCUb4XDntfDUBDDjhpdhYy6qY1H/2N3eTM1Ix1pjtx7w40aLjeikz4qfQjQGSOWpM7djKyzu5tNi7RsAUoMCkB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyey6abI3eZO2hpI9rEB76VbLJOsE4bJDa3uG1D2Wed52hgrrFR
	tY9euNC1T5X1NamVwq3heZo0hx92DGWSbbvPU9qPHTiYRFRjsCjMTm4K
X-Gm-Gg: AY/fxX6Wsv4nH+ol5sfGiN56+EpVe+TGIeJke3jb0ZwqYoOQJJ92xZJPk0Dw3RPtLE3
	pWJs5js/D/xzZOr0MGWgE7dB73+waQUAynO3t9v+6Hy9gFxsJ6nl3RAYkh1DHoqIcfLfFZJyckG
	NnPzyGpy1aTtdJ1DCAGBfSILoFe/9zevNzr6lashuDl3r5Ex85VjSMaYw+UHydFGVzNgs3v7HQY
	EpH59o6kFQBmxVitSaxEDCjOgQtpjFHWf7YVQtoLkGpnzst91+zl1YgCh0qjVY3vwuejKwhQedR
	nHnVuMyC4vHLmtxIdhuK6Y5+/JVoksQWxXPL03CJaNdGaQS2IithXajCiuqy9Hz4QaSicqnVHIA
	EfydU2wrV22ZOJvzf+YPZqvrQG2B2ywH5ckBtF9ErSEatRgiHVYlMeBo3M8qhcvYgJNMEcfJHke
	xaY3CVp4a3VKtBMSmKXqY+HVMhO3g+IaFlb6kfAFkhFANyJaO7AVfJSSQckAQ=
X-Google-Smtp-Source: AGHT+IGmPosrm+A15oJLUPggJ93G4/eVuIjwCR8uuTr+1EtXKG52ldXvyt14EhDewF04LtFg+sLUUw==
X-Received: by 2002:a05:690e:b84:b0:644:6d8c:e439 with SMTP id 956f58d0204a3-6470d156cfdmr15999476d50.0.1768233973298;
        Mon, 12 Jan 2026 08:06:13 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790b14df5e7sm65359617b3.7.2026.01.12.08.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:06:12 -0800 (PST)
Date: Mon, 12 Jan 2026 11:06:12 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gal Pressman <gal@nvidia.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Petr Machata <petrm@nvidia.com>, 
 Coco Li <lixiaoyan@google.com>, 
 linux-kselftest@vger.kernel.org, 
 Nimrod Oren <noren@nvidia.com>
Message-ID: <willemdebruijn.kernel.e77552f797c0@gmail.com>
In-Reply-To: <a95dca83-b996-49e7-86d5-f07e8f178767@nvidia.com>
References: <20260111171658.179286-1-gal@nvidia.com>
 <20260111171658.179286-3-gal@nvidia.com>
 <willemdebruijn.kernel.e28b1e33bbf@gmail.com>
 <a95dca83-b996-49e7-86d5-f07e8f178767@nvidia.com>
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: fix RPS mask handling
 for high CPU numbers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gal Pressman wrote:
> On 12/01/2026 5:29, Willem de Bruijn wrote:
> > Gal Pressman wrote:
> >> The RPS bitmask bounds check uses ~(RPS_MAX_CPUS - 1) which equals ~15 =
> >> 0xfff0, only allowing CPUs 0-3.
> >>
> >> Change the mask to ~((1UL << RPS_MAX_CPUS) - 1) = ~0xffff to allow CPUs
> >> 0-15.
> >>
> >> Fixes: 5ebfb4cc3048 ("selftests/net: toeplitz test")
> >> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> >> Signed-off-by: Gal Pressman <gal@nvidia.com>
> > 
> > Should go to net instead of net-next?
> > 
> > Reviewed-by: Willem de Bruijn <willemb@google.com> 
> 
> I usually send tests bug fixes to net-next, since it doesn't fix a bug
> in the kernel.
> 
> Should I send those to net instead?

I'm not aware of a separate policy for tests. Not sure if maintainers
have a preference. Probably behavior on this is a bit inconsistent
anyway.

