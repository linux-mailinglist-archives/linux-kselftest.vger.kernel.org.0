Return-Path: <linux-kselftest+bounces-28293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DFCA4F8BB
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 09:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997A316FD9A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 08:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E721F78E6;
	Wed,  5 Mar 2025 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLBoavu4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB31EF0BC;
	Wed,  5 Mar 2025 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163117; cv=none; b=Du0cGG39zs7I4brl/YyyuRKpCroOjuKJVZV6rgtcO7blFQgcScNRnUmv2EOheOx2qSc5nCvKvlCDCrsZ3OjO/gH77UVucx9Eo7dSGci7Ba0uDBUUHVJdOYl3zlI8ixMyuVB+ClDj9muvZRvtE3fg2zdU5P7zBuiMQLizySiH+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163117; c=relaxed/simple;
	bh=xjCV87QS9rWKgqppFDXKt0vI9eyLO6QuERActP80ONM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+E/kRQmZIxUdSkgXn8dSzDYuPgtSRdkF3ttSXSJvDhatEFLkx0gBBkTKqWi0NhkBltby+sJ3sZx7Yy6hSDJFmWd4ND4Moi0MlzzAWxLzS8gBhgkKvxNTttdsCAvGgYNHiOynUK2u9UjsHqvQhyDA02sYUT6pZPlW7/NtnsZdMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLBoavu4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223959039f4so74390495ad.3;
        Wed, 05 Mar 2025 00:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741163114; x=1741767914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OAy0yRAMT7Smqg+BRU5KQgKll8wiYK//bScug3inKX8=;
        b=HLBoavu4sl8NWzMf+ZVvTaSfzND2IIqwVvNqZYS5+GRhwEsY2UgnWWyHjfrAEG16wY
         BsfbIpyTda6MBoOOyi8uF8kJSAq04idBaZM+RRlmWfbzBhvYEqh1/IXDDHx/rRl+cwlt
         3crdcuHTkTHQ7gAv0M5ZDo1//gdQxu7jeOsRAAl8Q2uHXJ2gkhMxxr4IRICq/Zh7Dkgj
         rbqindMSOfMOviheTYxftKV5Ux+zWVm9Ty8VF1YMEkvIDECYKpda70ozyMXymZs66Zcp
         Oa4PFjZhG1YhSeeLEX3QraD3JhzZDnMySwfJhEG3reflH3cnEgdznhoESR0UmMyXttBG
         Fqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163114; x=1741767914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAy0yRAMT7Smqg+BRU5KQgKll8wiYK//bScug3inKX8=;
        b=FzRwD9SxQW47HZv2OHA9fTPNeP78psWM+tM/zquUGPIso4W6jzRmW6JNsvDJWoSaHz
         osXp2D5GPtmDDtIRQzsjVSZI9FxS4kdLiDyeCl/XuJA2i/UMWBDOMkh1vdGNOZH6+aj/
         +HJQ4fNSj457OZDw0Ot7pyKC/Is+4lpyAjshvl6E1LrFY1KIcwfQK46TlELhcBOVFGud
         36Byn9Hoi7HiUptfJX2SsIDLczAVYTZXLUPl6AGaqYmeMWWlZVv8xW7/yY1pGDDNEaIH
         gurG4ScrphYME5VSrRTXXeHJn2blRn14FZ482zNzLXpAhE0rfWmIcYJQqhpoqyjJKShs
         wz6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIC7e9g0f9IDPA/vU6QDAHtZlJNaZ5VT/jLcZJtL3uXzb/6h8350TdKQW40mi7A8+CiRegsMQpS5UWaIlEScHe@vger.kernel.org, AJvYcCWmOG07egnlLPe3D290aQruJv3BQsAJHFN5+7eNs5hghUs/tUQRqFw7wAfiAfCYn+FzLrFaIbEO@vger.kernel.org, AJvYcCXvcE6D6v6L0LqNooDvgp255LB8JGbwYFPigra1LN/ILlveM5I2dKZTOL1DHKtrYhL762N8QhRuA8Jl3is=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJSL2UD9fkBKy+bfHaLxwVt5ySt12wDeVxYmE88whHfpwqrE+
	l3p76+O7X7KFJa4Cd3EQMAfhO5pxEOqbEYGx7JP2ktkGqPWg/Xn8
X-Gm-Gg: ASbGnctvnuiOxBxqTIAXwMEEVrfqhKyXbFjw8RqOTFI4e69LwHKuvcdf3SYZqybeEeN
	8LcaFdmfOYaQ+Y5KyxwdvbQy+cDfAu37rYnzu0gqxDiDE2GMQYhAXUtAt3tNyx/wu7l2sjIe9NC
	a4KnZAcl4xGysInyZgjjZ1J5LruGBGQMP9X59HlnnxuHY3tiI70ZthiSu8LTMO6Czpmzzo71oOf
	WK42gyNUKDCpSwEz7+Q1uAn+xa3jjH2bXI9L0Kj7wK8K/PKGxBHrRhPDQ6reVdKedsMn6uWt6vL
	olpRD1uSnfRDfUeDLxHPbdaVh089ykWdrRFUjDECLbPvoJuIMQ==
X-Google-Smtp-Source: AGHT+IEut6J9FI4nbFHnxEVhs0CR48OzGreX689CQaBRcgMg7yHEPcx5k0ExcEptJCVyddHSOWAMVA==
X-Received: by 2002:a17:902:d482:b0:221:7e04:d791 with SMTP id d9443c01a7336-223f1c9b5d4mr29996435ad.31.1741163114516;
        Wed, 05 Mar 2025 00:25:14 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d5247sm107558115ad.26.2025.03.05.00.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:25:13 -0800 (PST)
Date: Wed, 5 Mar 2025 08:25:07 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net 0/2] bonding: fix incorrect mac address setting
Message-ID: <Z8gKYzpJw_DoYEMx@fedora>
References: <20250207092920.543458-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207092920.543458-1-liuhangbin@gmail.com>

Hi David,

This patch set was marked as "Changes Requested" due to my initial reply.
The series has now been approved by Jay and Nikolay.

Could you help process it, or should I re-post it?

Thanks
Hangbin

On Fri, Feb 07, 2025 at 09:29:18AM +0000, Hangbin Liu wrote:
> The mac address on backup slave should be convert from Solicited-Node
> Multicast address, not from bonding unicast target address.
> 
> v3: also fix the mac setting for slave_set_ns_maddr. (Jay)
>     Add function description for slave_set_ns_maddr/slave_set_ns_maddrs (Jay)
> v2: fix patch 01's subject
> 
> Hangbin Liu (2):
>   bonding: fix incorrect MAC address setting to receive NS messages
>   selftests: bonding: fix incorrect mac address
> 
>  drivers/net/bonding/bond_options.c            | 55 ++++++++++++++++---
>  .../drivers/net/bonding/bond_options.sh       |  4 +-
>  2 files changed, 49 insertions(+), 10 deletions(-)
> 
> -- 
> 2.46.0
> 

