Return-Path: <linux-kselftest+bounces-10338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26248C82CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 10:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DFFAB2131E
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 08:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D738E1DDC9;
	Fri, 17 May 2024 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSgbPoBg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B281CFBC;
	Fri, 17 May 2024 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715936099; cv=none; b=CACMwLi7s0OBiHmf+A807GkcGR17y4MQlWzPlOIHsoAFX+rUY9XvRtbvVhdC0q8GvIbPrR6WqVdAZ51YWhuLmICCxxXbS/d3X61pmM+QHhfNK9gDxovYlVGNGalFmbtF6wSx4hNaeCgeHZmrp27Kpf5h6l2pnWf6pDFM6A3w+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715936099; c=relaxed/simple;
	bh=iw+dF08yIxyTj1jJ50utoXxxBmfeDsLs/Hd8UVvCMew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7HSXF7sjR8mvpVXxof/XwXRcnaYQL6B5C60B5gyi64jkCwpUgWz2iUlHIlns9hPR3/+2JrGGwneLFvTcHFfR9KPsz+AGC6ZBUlPahB5A8071YY2GEWZYB00+/lWvmscZiOFoplPPWzjSmrn90msIIzFWR5hBe7BxclY8osR0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSgbPoBg; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2bd42c81d33so880194a91.1;
        Fri, 17 May 2024 01:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715936098; x=1716540898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMmTojAP3FRujDMUgpb3ucGAqyvMxCJuth7y/Wv7FYg=;
        b=SSgbPoBgBQcqdD1HsGBpHcxJ35WxAA63K3YowbBMLRXngKuM+U9HmiskYkUZkifTDz
         rakTF0lrpeSQ3MAhzi2VhkkodnSjUhQIZyEWUAVzd+3HzXQSg00Z80WNBJdBDCNgduiG
         d+v1Qd81kBQAJl6kLDgO0dWC2564gMJiuAQ4V33nntum2oKJPkBKM0GKQRNzKPH7GI2u
         IGrmONF/2wqwNtp8S16NsA8rNJBT1OhAktRNAUNf4kq6puzNUpii88qC1+G4l2TcbgPW
         HJrxzKOyiXj5ANA/J5KKGfkISdVU0cbZDmdi2GcaBNE8FQghUKKk2TRC3qu9kceyNf4A
         a40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715936098; x=1716540898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMmTojAP3FRujDMUgpb3ucGAqyvMxCJuth7y/Wv7FYg=;
        b=h0/G2CtLT+LN8CcXJRxRG6fIucbiedfj+vQbxbuJ979mqUgFwAtCdDgQ6mxPD8TbAt
         u5I3I8rYCy9yko0FisSq0MUUia/O6Ek18UkPG0oJcdpV7zKptzq/tLdtI4pHvqTDENhz
         o69w/gUt9eAdcKiUynPzhT+B/gibd5wff4UPKE1Q2q9Y8+34muPLAdF7AuFZD4VaF9Wc
         n8UcFWNkT9f/lstTQz6U64G2XeifoNqZO8BYfobrFbllS3RHO7oweRg8G1o16vlaBTVP
         e7xwESl8QX6Q6BMxwLNQR+7Hohfd7bZjWvKJOY5nFQibhw1aK+/wRk0Fqi3uyRMEVqmn
         yRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpWUGLdkBz+fdX7rMth32N33ECKQefsWAunB1jnwHxoynpBYkQBM+WPyOD3Ztx8P/feJaoUHFHKSStos5UAWFqQ8PyBn0Fxj+DPvS2qH0mJYYHAQ4TOGDeX8nQLfCA0WrcmLT5E0MP
X-Gm-Message-State: AOJu0YzwOQvye4+6oTYQ86QDkXkzU2qra7+W8fffdea8Tj6nNty7Tbwo
	ZKSpIa94DYWPVFUFuj1JLw8LO7441reBtdYeHWRPHUuUW0S1JxrA
X-Google-Smtp-Source: AGHT+IFx+oP2YCwfYKFrxiuGgL4MnlHgZ0Uy8fG6e0o551dqwjs2/ivPpENpoe9mCGVxqnTthWMZYw==
X-Received: by 2002:a17:90a:7181:b0:2b2:ae4b:9e54 with SMTP id 98e67ed59e1d1-2b6cc772eadmr19708957a91.11.1715936097681;
        Fri, 17 May 2024 01:54:57 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b6710564bfsm15139734a91.12.2024.05.17.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 01:54:57 -0700 (PDT)
Date: Fri, 17 May 2024 16:54:52 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, Petr Machata <petrm@nvidia.com>,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net v3] selftests: net: local_termination: annotate the
 expected failures
Message-ID: <ZkcbXKfLHHg1h15w@Laptop-X1>
References: <20240516152513.1115270-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516152513.1115270-1-kuba@kernel.org>

On Thu, May 16, 2024 at 08:25:13AM -0700, Jakub Kicinski wrote:
> Vladimir said when adding this test:
> 
>   The bridge driver fares particularly badly [...] mainly because
>   it does not implement IFF_UNICAST_FLT.
> 
> See commit 90b9566aa5cd ("selftests: forwarding: add a test for
> local_termination.sh").
> 
> We don't want to hide the known gaps, but having a test which
> always fails prevents us from catching regressions. Report
> the cases we know may fail as XFAIL.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: liuhangbin@gmail.com
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> CC: Petr Machata <petrm@nvidia.com>
> CC: vladimir.oltean@nxp.com
> 
> v3:
>  - use xfail_on_veth correctly as a "prefix" call
>  - dropping Vladimir's tags since the code is quite different now
> v2: https://lore.kernel.org/r/20240509235553.5740-1-kuba@kernel.org/
>  - remove duplicated log_test_xfail
> v1: https://lore.kernel.org/all/20240509235553.5740-1-kuba@kernel.org/
> ---
>  .../net/forwarding/local_termination.sh       | 30 +++++++++++--------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
> index c5b0cbc85b3e..4b364cdf3ef0 100755
> --- a/tools/testing/selftests/net/forwarding/local_termination.sh
> +++ b/tools/testing/selftests/net/forwarding/local_termination.sh
> @@ -155,25 +155,30 @@ run_test()
>  		"$smac > $MACVLAN_ADDR, ethertype IPv4 (0x0800)" \
>  		true
>  
> -	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
> -		"$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
> -		false
> +	xfail_on_veth $h1 \
> +		check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
> +			"$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
> +			false
>  
>  	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address, promisc" \
>  		"$smac > $UNKNOWN_UC_ADDR2, ethertype IPv4 (0x0800)" \
>  		true
>  
> -	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address, allmulti" \
> -		"$smac > $UNKNOWN_UC_ADDR3, ethertype IPv4 (0x0800)" \
> -		false
> +	xfail_on_veth $h1 \
> +		check_rcv $rcv_if_name \
> +			"Unicast IPv4 to unknown MAC address, allmulti" \
> +			"$smac > $UNKNOWN_UC_ADDR3, ethertype IPv4 (0x0800)" \
> +			false
>  
>  	check_rcv $rcv_if_name "Multicast IPv4 to joined group" \
>  		"$smac > $JOINED_MACV4_MC_ADDR, ethertype IPv4 (0x0800)" \
>  		true
>  
> -	check_rcv $rcv_if_name "Multicast IPv4 to unknown group" \
> -		"$smac > $UNKNOWN_MACV4_MC_ADDR1, ethertype IPv4 (0x0800)" \
> -		false
> +	xfail_on_veth $h1 \
> +		check_rcv $rcv_if_name \
> +			"Multicast IPv4 to unknown group" \
> +			"$smac > $UNKNOWN_MACV4_MC_ADDR1, ethertype IPv4 (0x0800)" \
> +			false
>  
>  	check_rcv $rcv_if_name "Multicast IPv4 to unknown group, promisc" \
>  		"$smac > $UNKNOWN_MACV4_MC_ADDR2, ethertype IPv4 (0x0800)" \
> @@ -187,9 +192,10 @@ run_test()
>  		"$smac > $JOINED_MACV6_MC_ADDR, ethertype IPv6 (0x86dd)" \
>  		true
>  
> -	check_rcv $rcv_if_name "Multicast IPv6 to unknown group" \
> -		"$smac > $UNKNOWN_MACV6_MC_ADDR1, ethertype IPv6 (0x86dd)" \
> -		false
> +	xfail_on_veth $h1 \
> +		check_rcv $rcv_if_name "Multicast IPv6 to unknown group" \
> +			"$smac > $UNKNOWN_MACV6_MC_ADDR1, ethertype IPv6 (0x86dd)" \
> +			false
>  
>  	check_rcv $rcv_if_name "Multicast IPv6 to unknown group, promisc" \
>  		"$smac > $UNKNOWN_MACV6_MC_ADDR2, ethertype IPv6 (0x86dd)" \
> -- 
> 2.45.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

