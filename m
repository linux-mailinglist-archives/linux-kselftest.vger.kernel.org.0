Return-Path: <linux-kselftest+bounces-15743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F98C957BE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 05:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17179284852
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 03:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ACE4643B;
	Tue, 20 Aug 2024 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5fiCGY6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4913634C;
	Tue, 20 Aug 2024 03:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724124115; cv=none; b=Q0k8/6eUmHoXNR9NPWx82jnCbCPFTmMjfyVNvB//9i7vBkh6EzlZDE6DiKqMnwQvmSRWwnj81PhCWBQXUHsRef9MNeKIZXkq8ZU/tS5Ui0wSWdMcJ2u2wlAQRrMW6aurUNOiU4hnBzD+QannbVDyf8pXHTwetlS1x3AWQabZ9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724124115; c=relaxed/simple;
	bh=uGNqOQL26rrTuJVFXnW3F7wq8sOSCiZwCgqeIX7igbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpRsxrjD4rOh41AXSVNKuCvJQr6w806Lif9lkW04Mq3134k/0TWJ1CeuBbPKLrxUyZuko/JLKVDWG+002o6Udoh2zC9/vvwqrgmGnbDnWapsWo+YWyhLKi6UntYO5apz1k4KtqJMX13VR1GIX9hN0H2bkd5nmJjPHYCWZ2iDCqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5fiCGY6; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-270298a3b6eso2456288fac.3;
        Mon, 19 Aug 2024 20:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724124113; x=1724728913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1JjJ4+jGiJ3SZfJ6R443ns5ItNY2tlMP7e/ayzTSUE=;
        b=S5fiCGY6OPO9DH55AvJPdAet7614kJPer4HZvtOu3PIPLCYBPQBnIZUl7UtW1QmGGc
         /KCYsXcezhUkxgdqZ7f2hJaU9FODFekmIOjHYmmgtJQUGUdhgmT0mtguzzLz27MnxQFe
         0Q45aHnaBiWqrxLIcbN61RgQClepYrlUDHhZYREcN8dWVROEWJMCiR/u3G0hn8+RQsHJ
         E/RZimX6l24mbI2VVFx3D4pKcmXtAZQclsTsPVcEnoLb9iHua9X2kyciUxJYW/LI5B85
         LM2uuca4E6vQq8pJld+LlJNC6lQ/sG7GXiaW5RYj0bo4p+eU/10LI0g8zNyXYSoQI0RR
         8OIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724124113; x=1724728913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1JjJ4+jGiJ3SZfJ6R443ns5ItNY2tlMP7e/ayzTSUE=;
        b=KUrgCu9KOjKt5r8UVNdFxcIWxnj7iEKmVdtM7S7JoXTJp05Cfcrl0iwy2nokBwg6Rw
         P7vBFxMyrmp9iQm4Wdk+PZ56pZBiQtTSKxfyCAlwT6Zy4DletjPEnp3F2V4LzbzVWVMC
         JKm6lTuAYEDmHDPoTtu+hFgiL4JXEoT4DUuWUa0/ppl/AY+wTxx5ALFV5RTUqLbQK/13
         RFUXzJKcfGt1AC4b6yQ3KQy6chFNcuwJMND2QOMMP8/RcuVefDjP7vw2bWU2t2Mm1pKL
         fdkCip6K3+3O8SyaHi8ZNVKBzTBifiVxjgBzUW/VB9scPf9mOGSWizgb+oN6MvSeZdDm
         1L8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8qTAy/6HPkfwJA0PX29WqEZF6aZqQqxOORaElafX6BBjbj7TAY/IUrtukiZpAh8Eb+y4SWQrkXcUzpcQLgAPuWgUf0SMPmIzsWgx+UQY/8UmZ7+OcuMSs1INqbPSs82Bpaj7hv9th
X-Gm-Message-State: AOJu0YxFNc28r1Lpr4bw6DVHrLDPfwzPGuZ8vsFoOuo+ffPpBKKGb7nX
	uGBKKxh15++zZqeijvvSu95q4xxnzf4gFDtMoaasLREEE70u17vU
X-Google-Smtp-Source: AGHT+IHWjw6rrg3wEC86CDm1qnD0sqtXFuWftWSzoENgXuDGItoxz02+wvC80BcHEynwfNBNblRRdA==
X-Received: by 2002:a05:6870:168c:b0:25e:f4e:da53 with SMTP id 586e51a60fabf-2701c522e08mr14744180fac.37.1724124112874;
        Mon, 19 Aug 2024 20:21:52 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127addcc5fsm7271219b3a.9.2024.08.19.20.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 20:21:52 -0700 (PDT)
Date: Tue, 20 Aug 2024 11:21:47 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org, idosch@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net/forwarding: spawn sh inside vrf
 to speed up ping loop
Message-ID: <ZsQLy00e588pcf6p@Laptop-X1>
References: <20240817203659.712085-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817203659.712085-1-kuba@kernel.org>

On Sat, Aug 17, 2024 at 01:36:59PM -0700, Jakub Kicinski wrote:
> Looking at timestamped output of netdev CI reveals that
> most of the time in forwarding tests for custom route
> hashing is spent on a single case, namely the test which
> uses ping (mausezahn does not support flow labels).
> 
> On a non-debug kernel we spend 714 of 730 total test
> runtime (97%) on this test case. While having flow label
> support in a traffic gen tool / mausezahn would be best,
> we can significantly speed up the loop by putting ip vrf exec
> outside of the iteration.
> 
> In a test of 1000 pings using a normal loop takes 50 seconds
> to finish. While using:
> 
>   ip vrf exec $vrf sh -c "$loop-body"
> 
> takes 12 seconds (1/4 of the time).
> 
> Some of the slowness is likely due to our inefficient virtualization
> setup, but even on my laptop running "ip link help" 16k times takes
> 25-30 seconds, so I think it's worth optimizing even for fastest
> setups.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: idosch@nvidia.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  .../selftests/net/forwarding/custom_multipath_hash.sh     | 8 ++++----
>  .../selftests/net/forwarding/gre_custom_multipath_hash.sh | 8 ++++----
>  .../net/forwarding/ip6gre_custom_multipath_hash.sh        | 8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
> index 1783c10215e5..7d531f7091e6 100755
> --- a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
> +++ b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
> @@ -224,10 +224,10 @@ send_dst_ipv6()
>  send_flowlabel()
>  {
>  	# Generate 16384 echo requests, each with a random flow label.
> -	for _ in $(seq 1 16384); do
> -		ip vrf exec v$h1 \
> -			$PING6 2001:db8:4::2 -F 0 -c 1 -q >/dev/null 2>&1
> -	done
> +	ip vrf exec v$h1 sh -c \
> +		"for _ in {1..16384}; do \
> +			$PING6 2001:db8:4::2 -F 0 -c 1 -q >/dev/null 2>&1; \
> +		done"
>  }
>  
>  send_src_udp6()
> diff --git a/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
> index 9788bd0f6e8b..dda11a4a9450 100755
> --- a/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
> +++ b/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
> @@ -319,10 +319,10 @@ send_dst_ipv6()
>  send_flowlabel()
>  {
>  	# Generate 16384 echo requests, each with a random flow label.
> -	for _ in $(seq 1 16384); do
> -		ip vrf exec v$h1 \
> -			$PING6 2001:db8:2::2 -F 0 -c 1 -q >/dev/null 2>&1
> -	done
> +	ip vrf exec v$h1 sh -c \
> +		"for _ in {1..16384}; do \
> +			$PING6 2001:db8:2::2 -F 0 -c 1 -q >/dev/null 2>&1; \
> +		done"
>  }
>  
>  send_src_udp6()
> diff --git a/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
> index 2ab9eaaa5532..e28b4a079e52 100755
> --- a/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
> +++ b/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
> @@ -321,10 +321,10 @@ send_dst_ipv6()
>  send_flowlabel()
>  {
>  	# Generate 16384 echo requests, each with a random flow label.
> -	for _ in $(seq 1 16384); do
> -		ip vrf exec v$h1 \
> -			$PING6 2001:db8:2::2 -F 0 -c 1 -q >/dev/null 2>&1
> -	done
> +	ip vrf exec v$h1 sh -c \
> +		"for _ in {1..16384}; do \
> +			$PING6 2001:db8:2::2 -F 0 -c 1 -q >/dev/null 2>&1; \
> +		done"
>  }
>  
>  send_src_udp6()
> -- 
> 2.46.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

