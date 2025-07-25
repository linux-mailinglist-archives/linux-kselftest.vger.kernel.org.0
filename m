Return-Path: <linux-kselftest+bounces-37976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DA4B11993
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 10:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4FF1CC7BD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 08:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C6A2BE7B2;
	Fri, 25 Jul 2025 08:12:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7408220F2D;
	Fri, 25 Jul 2025 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431120; cv=none; b=WDBO5YctJJfpSjiXM80J3w6jab908vd8Fg4L2IUwYERz3N0tFhAw3+gsOOS330TZgycj8GxyaXpe+IUON/UgGEciOzX3nOcY/UCpFiRWZW2byNxYMj8rU8VK7w0Ic2xaFIciX4uvIBx4fXoCS9DJClmf1lYxPqHqngGzStaBqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431120; c=relaxed/simple;
	bh=CM5Oea36uZvfoiK7/r+AcRjxy2phxOcl8b1GZzZwgQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZ67r3VitPwtj+6rNj4TclhPLI14QMF1ShRtPcHPxkLVhnwP60qsmK2TRJMCRiWw6gvyUUKVUtwHFx69CUO1hO0hc8+dj6U/EvdE9KEgqqMKjfL/Hxr3n471Y2A3KI3PsYPtWJFYOd3AJE5001uX1CpYbfMGvWxitUH3OIf59Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af2a2a54a95so289625466b.0;
        Fri, 25 Jul 2025 01:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753431117; x=1754035917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAKrd+LD+XDBmFxqxGAliD+PzOnak8xlMGa/MN+UIZM=;
        b=qP0BpN40xgMvtKwaGWW3V24acoW342K3NtpgFrMpvyCEygs2bogmWzuO8WBCXVpIrt
         pZuKF8WNncGtf/wDE8Pogy36fVKRAlAh5QbvTB08Q0U9dF/I2BAAK7ViaRpRcCMChgn3
         DUv6kphG8rPqcVgat6gkuwkFqmzbdKGMD7Z7NMnp43pAgH05y2nAOTAxX0U8yu86fKQm
         UHFgU0O26WQo3ZsEKwfmPPwm/nNa+GcVpDQI6/1vz/CglCWKuBcaKK1YYApm9LLwF/sM
         jPrInGfMy6V0zeUCNo+kPrXgLURB6sL2JddYYRLaO20/i7CXT6hGlNNLiIGYKx8NWSJK
         Buug==
X-Forwarded-Encrypted: i=1; AJvYcCVhNI51sXzypv/OWU9DjBVqU83U/EiUkucS29UtSelZjFQtdcThAaU2NkvEzxmUbGUVplpZd2h/@vger.kernel.org, AJvYcCXeEylBckb75J26b2O965bgVH9mbFnyXW/0he+YCYS3kKZ+8wWwiPvA3VqsF4pvBTq+Y1PVck+PqFfDPuw=@vger.kernel.org, AJvYcCXfx1Y0c8/EaybwUyHGLTU3bWjHp4d6RHHNPjXl0sYuHE1+witTdWMDi0LtlzK3lu/mdORL0K7bXwt0Jd/Bk/+1@vger.kernel.org
X-Gm-Message-State: AOJu0YyBikQhxJzq6nK+WrMgE1KohvSx/87sWDntBJVTzkmkenyUdIkk
	tfoLelqCNnoZoTVUQKrD5v4Gw7WB8KDZyQv8N51Hr08bsgSfqZ7ilVcr
X-Gm-Gg: ASbGncsSKvJ3Rp9+1fI29y29GDvL7KIDCf1PydkxtZeuCSYdxVA2KofoCDhElRzPbBf
	NQ39fhuZVlUHOqzjD7HfWG8skKalbINSWlLLKHQO315H7LxodqkQJCO5GuNAu1or9ZfQeMfHh0c
	JomM0h6aePNWUvHchd35/R2nGgKrzjwFz7pS74ZG4HvaNGitUgsIMTMUUIQGsYPg8aTVHaF86kp
	4M7f5MJ/mkMHb4L/+S2WJ/q4gep+6/0WCmOb0IwY+uyd31m+EyNtimcjaQrFfXOJfat7gujLK8B
	/KksAZi6y3Kh7wx0tRq+Lq3sjhDOUmGAQBdyKqVoJVdIBAMqbT+adOY6Vh/jERGiC2AZD/xudNW
	eV0RnC7vhXWu7
X-Google-Smtp-Source: AGHT+IFPX0c0Ndbx/2iAsFsxKcF7ID2/9I3H+CH1/uhcG0UBdqcuIER/o/Dwg7+S2WsxGNYL9nmpRQ==
X-Received: by 2002:a17:907:7209:b0:af2:7ccd:3429 with SMTP id a640c23a62f3a-af61c2aaad7mr92257966b.9.1753431116776;
        Fri, 25 Jul 2025 01:11:56 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f85ea59sm232531566b.101.2025.07.25.01.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 01:11:56 -0700 (PDT)
Date: Fri, 25 Jul 2025 01:11:50 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] selftests: net: Skip test if IPv6 is not
 configured
Message-ID: <eutsqoc6f7xcaez2ttuce4uqtfvs3hyit6dradikvfcgxdev75@3senqada4nzn>
References: <20250723-netcons_test_ipv6-v1-1-41c9092f93f9@debian.org>
 <20250724182427.5ece92e8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250724182427.5ece92e8@kernel.org>

Hello Jakub,

On Thu, Jul 24, 2025 at 06:24:27PM -0700, Jakub Kicinski wrote:
> On Wed, 23 Jul 2025 10:35:06 -0700 Breno Leitao wrote:
> > Extend the `check_for_dependencies()` function in `lib_netcons.sh` to check
> > whether IPv6 is enabled by verifying the existence of
> > `/proc/net/if_inet6`. Having IPv6 is a now a dependency of netconsole
> > tests. If the file does not exist, the script will skip the test with an
> > appropriate message suggesting to verify if `CONFIG_IPV6` is enabled.
> > 
> > This prevents the test to misbehave if IPv6 is not configured.
> 
> IDK. I think this is related to some of the recent patches?

Yes, commit 3dc6c76391cbe (“selftests: net: Add IPv6 support to
netconsole basic tests”) introduced IPv6 support to the netconsole basic
tests.

Because the NIPA config enables IPv6, the tests pass in that
environment. However, if the tests are run somewhere without IPv6
support such as in a test I was doing regarding another patch, they will
fail, when it should be skipped.

> The context would be helpful in the commit message.

Apologies for not including more context in the commit message.

> Otherwise, as networking people, I think we are obligated 
> to respond with hostility to "IPv6 may not be enabled"..

As for handling systems without IPv6, if IPv6 isn’t available, the
intention is for the test to be skipped. That’s exactly what this patch
addresses.

I did consider making the test adaptable so it would just run with
whichever protocol (IPv4 or IPv6) is present, but rejected that
approach. Allowing the test to “pass” in such cases doesn’t really
demonstrate meaningful coverage, since the test isn’t actually being
exercised as intended.

In short, it seems more appropriate to skip the test entirely if all
conditions aren’t met, so, you know that your .config needs adjustment.

Thanks for your review,
--breno

