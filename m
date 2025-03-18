Return-Path: <linux-kselftest+bounces-29343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D2FA6712E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 11:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD570421530
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 10:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88475207E03;
	Tue, 18 Mar 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9Cn2E0L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAABD204F97;
	Tue, 18 Mar 2025 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293507; cv=none; b=Z3bPyMOP5nVa8cgDweAnEtf4iK7p2wxOtpDT38562+4tuayZFhPn0/DiHi+MvzI0P3eizX9ZW1b9vZSR77NV4l0eyVprdCD9Q46OsJwhYg82CAPhR/6K8DpapJQI1jw+t1WfqUMW/hLY48lkzuSE+QnlxENNoD7KwX25TgDICHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293507; c=relaxed/simple;
	bh=L642RSwY3Rs3Y6ml+gWQYS1/2YS01C+t38KIsfFZw7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlH8AWmxPRNFfV5UH57eD9cuumsddH5aXa76QhzbhIJUSbfu4GtcMiO36eoiMfxdXvSHrcijAn+PyDbTjWgjXbXWajbLqEujowALRZT8ZlVunGBSONjTZ5AM+aLPYVwuXaZ1xtPe1Y+b6lcHvJkM9hr1/Dn3oRwYBMDATRskE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9Cn2E0L; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224341bbc1dso99939195ad.3;
        Tue, 18 Mar 2025 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742293505; x=1742898305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHJpZP+ouwvFF8IfLMmV8qW0ir9r9wU3clAjxfEY604=;
        b=Y9Cn2E0LwqT5JQQCuTK2KxyXsbqwLQN5rG+HlhM0dr8M5dU+W5aVlQXpeKaJYEoQs3
         1bxvMNA6S1HPcXLE6cPw9ne1BIlATJ5RYjIrjwwyiERCgKg5uwKIcZMGMxI7E+cxMhnL
         yxNcX6ay5mB0YdWWXOcbQvxsod1KfbeGig4cNtxoY7/tloOKjG6DhTz0Zq8dfpf0Xc8T
         ij6s1N0k4l2lQ7RXJ+VYukyJULYvtvH/OYDgppmxscCQuV8w/KttAIrtrtszADAPSK9g
         ilcwSxj8WmWSXpRs13MxID8Svzm67A+krt6qG2m9FKtLgMquK2roIowh+6EICOIWDR+0
         gyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742293505; x=1742898305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHJpZP+ouwvFF8IfLMmV8qW0ir9r9wU3clAjxfEY604=;
        b=OU/A44gnl1FKd463Tit9jdTyizDTlVT2THcjJNx4EcXTc8Pb1WFfdLq1fkp+3/S2N4
         pKLUjH71PP76Waf7VCxVoj2P3CaOSFmUXliaLpqxp/gBc8ly4Yhe1eL21hkn2vCVPgR8
         VbU4EBo7NrtfZaChP4yVJkAZ6mzalRCrA0m4qXXRGzUQnNdUixuitCrQANUgOS8UdadV
         hPAKOmN1576o/i9UTpwIWPJIyOmfonIhgoiwuy7iHsODGsT74uCm1HV8rAXl4wpM4BFu
         M2+r5zIeG/4+Wa6DmvjnRY1JwzhFiJ7DS18hyuNPl4YzP5k72k80sSkhekXKE5b72qOh
         fr5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV97SV/4baFhKPNR9v+fL/HXZmHvKyh9o6cGg0Wek3WSf97+sb0Yri4wY7jAurSKec4iRM=@vger.kernel.org, AJvYcCWsr82XFYIcU5n0defP92hohxzpfod6NXIHKfQKexTWsujbd3ACVMjnH+GGk0MEIzdsabZEwi3d@vger.kernel.org, AJvYcCXHER7oGbzfXdPX397cizmMRoajAwKPgupiLT8pElrlssSQ3UHDfzRbp5gVDQsi/B9OI1xdFf9yByGC9DZq@vger.kernel.org, AJvYcCXk/otUKiEsIxecwkfWnrM9cyI9M88rUP+Gssi8AgFaVx6UNlRSn4TMaM2YlX4LelAc6lIrcFkP8Hxz0dyX5mif@vger.kernel.org
X-Gm-Message-State: AOJu0YzNLjZD0lfOLWMP9nVcbCAmNP1wJou/JLEiNDqJRLJRVKn2W6wk
	d76U8jEazt8N/X9KkFbHd+w2nDLEjsxQyYH9o1uGln4bHtTHWkA1pUUC5dy7syoOwg==
X-Gm-Gg: ASbGncvwJU0NclE9/VqbiKYw4n0ApONBLRpycZsyPGUbBHIOSBOlxfRCS1yBnTLdljR
	g0uMWk5RK7Fg97wdyzrGZ/+icYqy6FsZHCGvpx9Z/bjyoPVdRFX8d+x53fCYu1CZwIKHfz69WqA
	XF5MU8o59hAnIv/JG82NP37FeWpMMTV2YacG5Tu8TtXmQC+o6P2o3gex1wH5eZc0h3aarpyrPPi
	veFzs++fR97miypS72Lii/nRwqjcciajZ4/jHNOf2KYw6p8KYVAuw0Sf1qMij2pVCRS+WX3Z0kJ
	FQOvfAJ0vRZ0KIgeISdbwW4CdvHiUtAYJmcnC6Hyukw7SX+gCw==
X-Google-Smtp-Source: AGHT+IE6gdO1UuE0ixmpB6cazW3Pjzhx+tIz6PbNhLSt1J2XBNAgq1vv++MsWYhJd831LrG0jM1yLg==
X-Received: by 2002:a17:902:d2ce:b0:210:fce4:11ec with SMTP id d9443c01a7336-2262c51bc7dmr45795425ad.1.1742293505083;
        Tue, 18 Mar 2025 03:25:05 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6a38sm90449665ad.108.2025.03.18.03.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 03:25:03 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:24:40 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>, Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 RESEND net-next 0/2] selftests: wireguards: use
 nftables for testing
Message-ID: <Z9lJ6PXHeL7tfhUf@fedora>
References: <20250106081043.2073169-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106081043.2073169-1-liuhangbin@gmail.com>

Hi Jason,

I saw the patch status[1] is still "Awaiting Upstream".
Is there anything I need to do?

https://patchwork.kernel.org/project/netdevbpf/patch/20250106081043.2073169-2-liuhangbin@gmail.com/

Thanks
Hangbin
On Mon, Jan 06, 2025 at 08:10:41AM +0000, Hangbin Liu wrote:
> This patch set convert iptables to nftables for wireguard testing, as
> iptables is deparated and nftables is the default framework of most releases.
> 
> v3: drop iptables directly (Jason A. Donenfeld)
>     Also convert to using nft for qemu testing (Jason A. Donenfeld)
> v2: use one nft table for testing (Phil Sutter)
> 
> Hangbin Liu (2):
>   selftests: wireguards: convert iptables to nft
>   selftests: wireguard: update to using nft for qemu test
> 
>  tools/testing/selftests/wireguard/netns.sh    | 29 +++++++++-----
>  .../testing/selftests/wireguard/qemu/Makefile | 40 ++++++++++++++-----
>  .../selftests/wireguard/qemu/kernel.config    |  7 ++--
>  3 files changed, 53 insertions(+), 23 deletions(-)
> 
> -- 
> 2.46.0
> 

