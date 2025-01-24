Return-Path: <linux-kselftest+bounces-25065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2C6A1AF0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 04:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C4F3A7839
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 03:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE5C1D61A7;
	Fri, 24 Jan 2025 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZhvDzX5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17271EA65;
	Fri, 24 Jan 2025 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737689370; cv=none; b=XXnKMTwfU+gKnGPZBq5LQrP1zhUI0N/seDSzmm9nNRyzpzTmye8WJ8g4LolLte26AJZMBY3iVi5BmzCEpmBZL1LXRZz7kZTZHZKC756u2OX5e4HDwWetSgfdh+jliqQuFHSky/XEYqrcZTHSawExMDp+chD4JBvPDnwH8jMRs18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737689370; c=relaxed/simple;
	bh=+4Wxuy5BCPj8fh7yuefG8SsoZEgoF+IRZmzQsBgphAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ay58jqEPO36uwR5j7QOXdgkUhN6zb5NvVVR+ZVpJW6ZiRS4YWSDAeWjyhCtEJ9E155m96et5q/GQIoU6a/RZnKma1dNef1I7xX7GTBidUXMUUU1hCiIh4cZ15cNcdmLor5Ectv5G6UDTTl42M6ygrpe15i2f2u0rcz4IyOqQT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZhvDzX5; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so2323043a91.1;
        Thu, 23 Jan 2025 19:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737689368; x=1738294168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gj1RoLoVlwQzdB1wfoIjHWpsMAIiM79D2dMStBxbBwU=;
        b=MZhvDzX59L65BiDbFIkDo/UvmBRYaCKK7Ars2xEBFygfNl6l6hSCAkoYtoNRyeEyTC
         0z4vqYaicwNl+RNx9IPBi4CkiNg0z2mpirA2031GFzhZ7xXaxtgtzGmcSd8C//mW+zM8
         Weo3brHN37Ar/cn4QZX8v/Lo1K/77dCOj5KMwCP/+Qum+hwHVl6Z+M5jrw9Gm95gHZ0x
         TTQ/FwjmkPTECHYJOou/PSGHVx7Fo0Or45A15VCd/roU4cM2Wa8ZP4v8Sf7qRQNyHtCB
         on+8BSlfSO1kyxEp7caUsyHCHZtbJTWrheFpzyReRN7g996ZiNpxZzruehQuemfo833/
         SCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737689368; x=1738294168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gj1RoLoVlwQzdB1wfoIjHWpsMAIiM79D2dMStBxbBwU=;
        b=iYA1dZqTPlcKpuILTPRxbYncNedT8v3MhtiGA/htz0W/o1aSUViBhZP0c1NNrAwiS9
         xAqPyGX9eq2mzBt057KuMv2vK1d6eoIe082D0sLW1VRX3ZBQhkAHlMGaxXcjip9r2+NW
         vWm8NXd123CnLnXItxE3BLkqy4/yG8gC3frQgArjOD6pTDK33nay4ancpBgRqyiQze0O
         A4MtfdSB0CiXtrs8lHEUO3Bxa08AMGIIFlLXRC3j1VRZQO737hj20xEB83Oi3nV36I7U
         wYk1yT/utgI32UEtvXhuUORwQJgMMbH7HcUPpi6Om4Q3ifXpuhjFMb5++Bc+GxmV9iHq
         jwRg==
X-Forwarded-Encrypted: i=1; AJvYcCXT5LqZ6gMi+M1qAStpz/JqsLdHtpn9MruHmKW1q3JBsH68um33pOaiqiFWV32MVGFQr4rAeffFbiiq6CSZDgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOfx8UsBFCwEukTxbYqBFtNqxP53QkAP1X3xn2xVdBddPA9Y4J
	LeqhrsLlBxtXd5CV3qsn2lEuzIk1AnlDzC+RN6nWiBricOYsZdj2tZYSJjt4y6U=
X-Gm-Gg: ASbGncsQ3DzQZYmdBTmztbe6eCYrwN0edmahF5l+Fq0YNrhKgnkVoSEtLlWzFZoj2f/
	b/wb4skUAVm++WNtUk46SMgrHpJ9a0Dg6jBzXM0Sh3L2DrebCukexzMOytJnkVzuQZXIIkVRiZ2
	DwyOpxkK0KcZMqnujDU1mY9/Ev9U3BYJyz4PRHVta3SC6LHg/6+qK+mgsgXLkCCOcA/lLRI+7AN
	zVe5FhK6yxcqy7tqo4qMy3iR1AoH3nG+WtvWF4RkQsJ9jjiG7XnQkwyQ0HX4CS7Dx/olrLrDvpN
	gNF+iT9HLA==
X-Google-Smtp-Source: AGHT+IH3IwxVBc5iCFfZ/tTdPpbMOu2GN6Xu826DtVOjZAcpvHqXcaecnnKv+c/BIi/cXVPjHrhrJQ==
X-Received: by 2002:a17:90b:2cc5:b0:2ee:bbe0:98c6 with SMTP id 98e67ed59e1d1-2f782c73b74mr41192728a91.8.1737689367772;
        Thu, 23 Jan 2025 19:29:27 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa82f9esm511960a91.43.2025.01.23.19.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 19:29:27 -0800 (PST)
Date: Fri, 24 Jan 2025 03:29:21 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, linux-kselftest@vger.kernel.org,
	Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] bonding: Correctly support GSO ESP offload
Message-ID: <Z5MJEShoqJqiNWP6@fedora>
References: <20250123150909.387415-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123150909.387415-1-cratiu@nvidia.com>

On Thu, Jan 23, 2025 at 05:09:09PM +0200, Cosmin Ratiu wrote:
> The referenced fix is incomplete. It correctly computes
> bond_dev->gso_partial_features across slaves, but unfortunately
> netdev_fix_features discards gso_partial_features from the feature set
> if NETIF_F_GSO_PARTIAL isn't set in bond->features.
> 
> This is visible with ethtool -k bond0 | grep esp:
> tx-esp-segmentation: off [requested on]
> esp-hw-offload: on
> esp-tx-csum-hw-offload: on
> 
> This patch reworks the bonding GSO offload support by:
> - making aggregating gso_partial_features across slaves similar to the
>   other feature sets (this part is a no-op).
> - adding NETIF_F_GSO_PARTIAL to hw_enc_features filtered across slaves.
> - adding NETIF_F_GSO_PARTIAL to features in bond_setup()
> 
> With all of these, 'ethtool -k bond0 | grep esp' now reports:
> tx-esp-segmentation: on
> esp-hw-offload: on
> esp-tx-csum-hw-offload: on
> 
> Fixes: 4861333b4217 ("bonding: add ESP offload features when slaves support")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Change-Id: Iebd2a9d903d3e056e7717e8ca2527a9adf21b2e1

What's Change-Id here? Others looks good to me.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

