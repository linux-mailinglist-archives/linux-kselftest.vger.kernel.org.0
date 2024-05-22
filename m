Return-Path: <linux-kselftest+bounces-10558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B0F8CB96A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 05:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CC228268C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67F043147;
	Wed, 22 May 2024 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPQ3Hg+D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB034C89;
	Wed, 22 May 2024 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716347120; cv=none; b=omJsc519p8S/EzB7f/mBo8yIyZGEHwdqGSxrq3RmDpw2zUEZETyHoAHfmmPSgFlmrT9NMopnVb1efFpgJfYmccBXLv1uKB06xzG90yOL0V5wFhzK3qL3bvWEfSPYQWBhtq1e2eWqj3stDKDGiKS4FuBEbGtoYpxeEaoh3ehVdWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716347120; c=relaxed/simple;
	bh=nn98KQgF6EabfuJ9VzVzyr9fZf6eQZ1dpnixOK2mkXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWte0KxXOqsxa30Qi3yycz3Ugvz96RVngL4AxJP2CPPKr378/4ShlDTA9eJKjX93H8yLsMTy0cJBTLEpaqpvfXePNRWoLZYZeBX9KiSIb5Xvqp5HjMlx/y8HIUfD7yZBDPXHxFTuv11LeAAIK4K8TbowkNwQbcrg8M2ZaiJBKww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPQ3Hg+D; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b3241373adso2847490eaf.2;
        Tue, 21 May 2024 20:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716347118; x=1716951918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1laiRgyKO2AM2rgUwjP5Z21bRDF06AQd/g6ZI5X5xY=;
        b=LPQ3Hg+D/ILHIzWU6TCjXqYSm59z9acVlSrUuS7Se1EHTgh0XlJJhXEnBG1Xl0yiid
         rlGVLGILv4/0uD/01Gdm88gRwh38tqMq44ZEJFGB/AtqtuM1h+Q6rGwmIMoZLosaHeyK
         q9s7a18mifyCg7U0Bzo2KepyD4xRCM1FKBnYv4Ftm5ISMFrtdfl0gJ99TySsrf04aNEU
         PjQcaRQRqJgDcYvKfHTez4grHxPS2iERN++mEYVfnUAQZN+Fn1XfoE2D/3l07N5R89U0
         /do+iJW7agDPMHzNvM4vSR+t2OYyTcrYU12mEfalHGanxzbBCh7k3FVAEKKY53U8OLYm
         2cxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716347118; x=1716951918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1laiRgyKO2AM2rgUwjP5Z21bRDF06AQd/g6ZI5X5xY=;
        b=Gft89xJuIKomtCRbvZ/z1QaSYCtUmDZaxSG0AGnA2tbsf0CtbhNIxE80RH9rSxH6ao
         dyh2hy1AcLRfkAzqYgHzZw8u/beTwES7NAWE1TpOZr6i7AZ8P40fnn63VMW3HpMuTjPE
         zdg7Spxlzq/j/nmH/xeuhR1k7Q4GL/r4qGDCP/rqtJLleOriAGKB+DPywM+3ohIujdcr
         o0JVRp0Uj2mg5gO2GlZt32JO2emGrxKnwBjTerw8OjnLt9f5E5G0qix4LoRb4j0Dcv04
         ew95uEfCSaVN1hdEn9rm8Gw4FlWTOhyb6b0fo0ivIJutIbHov6v4J1fHYDyH3r7zOUcN
         9NHg==
X-Forwarded-Encrypted: i=1; AJvYcCXfajkfO1Nm4gmnTw+baWkW50ZMSigJqjr/nQRWX3QawveNmVJ9YjBlavWIIkEpn02UH3OwcaEmdOtyJ75gE1egHqgBf9PprM07yxjinidpVldVZkE8Rtc743qvomFlCNbxR2BIzlNv
X-Gm-Message-State: AOJu0YwNXysiam+0MMGvDXAOpV+r2gxa4SdalorIFsDfkAIGrmbLzqtq
	9zVb8VUTmVd73SZMfo5My/E0tLDuP+TadciE+A6wMND+yBDHtk1jFYjIvIN8lqzU6Q==
X-Google-Smtp-Source: AGHT+IFokm8KIr1EB2cOdu1VcpDt4iaD+Z0Aj3LSXub2lRaUKdubHTRtjVFSaV04Lb4lrypeeAYOPw==
X-Received: by 2002:a05:6358:8003:b0:186:f45:391a with SMTP id e5c5f4694b2df-1979214497fmr94730755d.28.1716347117650;
        Tue, 21 May 2024 20:05:17 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634103f67e8sm21423276a12.69.2024.05.21.20.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 20:05:16 -0700 (PDT)
Date: Wed, 22 May 2024 11:05:12 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Geliang Tang <geliang@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: hsr: Fix "File exists" errors for hsr_ping
Message-ID: <Zk1g6CRsvSids1Vs@Laptop-X1>
References: <db256340b909f8b6f8bb7f9e42dbe71c228993b6.1716280848.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db256340b909f8b6f8bb7f9e42dbe71c228993b6.1716280848.git.tanggeliang@kylinos.cn>

On Tue, May 21, 2024 at 04:49:44PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The hsr_ping test reports the following errors:
> 
>  INFO: preparing interfaces for HSRv0.
>  INFO: Initial validation ping.
>  INFO: Longer ping test.
>  INFO: Cutting one link.
>  INFO: Delay the link and drop a few packages.
>  INFO: All good.
>  INFO: preparing interfaces for HSRv1.
>  RTNETLINK answers: File exists
>  RTNETLINK answers: File exists
>  RTNETLINK answers: File exists
>  RTNETLINK answers: File exists
>  RTNETLINK answers: File exists
>  RTNETLINK answers: File exists
>  Error: ipv4: Address already assigned.
>  Error: ipv6: address already assigned.
>  Error: ipv4: Address already assigned.
>  Error: ipv6: address already assigned.
>  Error: ipv4: Address already assigned.
>  Error: ipv6: address already assigned.
>  INFO: Initial validation ping.
> 
> That is because the cleanup code for the 2nd round test before
> "setup_hsr_interfaces 1" is removed incorrectly in commit 680fda4f6714
> ("test: hsr: Remove script code already implemented in lib.sh").
> 
> This patch fixes it by adding a new helper delete_hsr_interfaces() to
> delete all interfaces before "setup_hsr_interfaces 1".
> 
> Fixes: 680fda4f6714 ("test: hsr: Remove script code already implemented in lib.sh")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/hsr/hsr_ping.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/selftests/net/hsr/hsr_ping.sh
> index 790294c8af83..0be1d5f78dab 100755
> --- a/tools/testing/selftests/net/hsr/hsr_ping.sh
> +++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
> @@ -166,6 +166,14 @@ setup_hsr_interfaces()
>  	ip -net "$ns3" link set hsr3 up
>  }
>  
> +delete_hsr_interfaces()
> +{
> +	echo "INFO: delete interfaces."
> +	ip -net "$ns1" link del ns1eth1
> +	ip -net "$ns1" link del ns1eth2
> +	ip -net "$ns3" link del ns3eth2
> +}
> +
>  check_prerequisites
>  setup_ns ns1 ns2 ns3
>  
> @@ -174,6 +182,8 @@ trap cleanup_all_ns EXIT
>  setup_hsr_interfaces 0
>  do_complete_ping_test
>  
> +delete_hsr_interfaces
> +

nit: you can also just re-setup the namespaces, which will delete previous ns
and create new one. e.g.

setup_ns ns1 ns2 ns3

>  setup_hsr_interfaces 1
>  do_complete_ping_test


Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

