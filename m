Return-Path: <linux-kselftest+bounces-26752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E63DA379B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 03:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F8B16BBCC
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 02:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75606145323;
	Mon, 17 Feb 2025 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD1YnZWD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C62084D0E;
	Mon, 17 Feb 2025 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739758998; cv=none; b=XW8jxw1XoRrexXd+ubPeJTLo2WLFaLE8h+FD3PWd+7tZ+oBQXkvj/+oCeGsQoqUfwcuLdkigOyuO2RuCAAGywVDR4eOC6PpM1Atk92xLWAFEX61dZnigSe8rzb6qgnU86OBN2+AiVO7YTvIa5YLy0F61BASMI+mHN7VwWLz1S5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739758998; c=relaxed/simple;
	bh=yxz8zrIHDtO7kQkfjxlZZSzlZ1TclU9ag6W2VmYuy9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9Ti58djq/AlBVH5mJYyZIg3Y9WTrtYZwL//SnNYDVftniXFarj9N399DPfAtN+A+Gl0bkuGTeki9qEQ7JxYDYFJLcjPbhAzm9s38Sxzqqk0beDmirUOoXuPJKtfGOGkwixYQsi2vIaHLf0OwyW2Y+opUALQcLpQs/Xa6YKuXRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aD1YnZWD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22104c4de96so21937445ad.3;
        Sun, 16 Feb 2025 18:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739758996; x=1740363796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eATGpv/yzwW7RwTTlAQI0b6AWmzMq+BHQwUQKB0Quro=;
        b=aD1YnZWDuiz1/qlVLOZ1wU4XiF6nlh4ZPM6yFtIX+jj9TCCbqdz2DPhCJylyNBVl99
         uk+d8usrEFUSu9+7eqs8jFL3AbWDGZ2ScCWv49by1wjQ+Mewprp2LVpsucph5towxUup
         NRoQ9hc0BCbqvZJeCFjqTBeJFqJ0yKKGArIU3t4Gl0ZnoqkXKSnd8ersZSoRexL/nXAZ
         ehBJRtRBSOLPfacPsm2/tnSVX9963TO1q7NLcMHkhxlmt/uGD74s+n6L3jEVkCLGG4m7
         15rM8RkMVUnqCTAMknVOaVXrNrvAmlFpKibXBsLb99qGNP3Ox4xEJE+dCn1H0TeKfZYI
         MSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739758996; x=1740363796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eATGpv/yzwW7RwTTlAQI0b6AWmzMq+BHQwUQKB0Quro=;
        b=GbRm7K1+UdQtLz0c7T6ADpGiP/sS2sAEIYO7mnx89811xB3ZvmITtmEVOZgTnU4Dq2
         AQMMe29QhhtxWh8jJe/vrqNU0Hr8QHcMsue6/MrwNUbVrJn1/REpiY/Ur6RqA2E6E/uj
         3XFgl6qKkm4jVxCHV6Ls8PddgoPwS511Kx7e0Ozhik3aUCHbYIoTK8zPfxrHGoC/cCdu
         pn5QWARhJyfaAb+l/dWE+6vWH3wdYOqNxtJavKxK5NiyXWFjjau3nm0H72TGV1fegRQL
         /dPrkluKoUHXO6blzWDDkrRNflAQvp05Yr6u2n8C2wKM4F0yGDcl0IQWVXRHlF7p9UdK
         ioQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW4eesGVJrPOJsMXhzCBpspfllzXowXDbI41ohYuWIlrhF1I8DTU/txt2STW9UBVq15pi7JbQhKbgKryllDtE=@vger.kernel.org, AJvYcCW2LbB9Qg8fBGe/9Sx6fCsrLtGDqhcKdycv39krNMjTMz8Ro8/SIrLRVTIQkQQc4HsysbXPxIsVpUThBJPNI07V@vger.kernel.org, AJvYcCXfKWPBDp9bOdfGzsWBkBppeydfD7bdvEY15ekqBxc0D7mi7nBTmc2c5rGdHYYAcxQpH44TRJex@vger.kernel.org
X-Gm-Message-State: AOJu0YweaTeQ6B/aYBG1jf9S7RS9BcDRZZtX6dTKOQAN4FAG+yxAYxwg
	DHG3lT5j2hAN/YxJHIeS0Sty42DP9ZtdxpyQ07torOXoLXDfuXGz
X-Gm-Gg: ASbGncuXdS/IeDAagBM87k7a/BxLuiD877iGwpV7941UDZoVDqEG4HjF6oZTNz6a9nt
	SyUnmpBHX75CvACle4VdmzdI3gX80kba/1ozI49cCR3rwH+2sdrYqGU6XGRNDNSJ0y9GZPF9p72
	zoGq/V7o/bebg7PakmVmenhSYV8hNWSaYt90UQhIgWxvCPUcKIkecCuGUpREc5R4F+CV+Nv431Y
	YyzXT4k3Jto9C33RWyQYXeURB5LE+9cA1bR4a3+ntRo9Cck3cqbbVZ/g0BdpJUaLuosFc1XDASi
	d5LL+R7YsMsSYH+4bRBj
X-Google-Smtp-Source: AGHT+IFViZjLBVkpW3BxuNj7fXUHmg1Djc/5+NyaIqfXwEcnE1lFoV6Cujl/dUine4R6CXlTH10+QA==
X-Received: by 2002:a17:902:ef49:b0:220:fe51:1aab with SMTP id d9443c01a7336-221040b1359mr150473335ad.38.1739758996248;
        Sun, 16 Feb 2025 18:23:16 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb57c5e0b9sm6356740a12.6.2025.02.16.18.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 18:23:15 -0800 (PST)
Date: Mon, 17 Feb 2025 02:23:09 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Andres Urian Florez <andres.emb.sys@gmail.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, skhan@linuxfoundation.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net-next] selftest:net: fixed spelling mistakes
Message-ID: <Z7KdjZ80R5H4RlIo@fedora>
References: <20250217001452.29578-1-andres.emb.sys@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217001452.29578-1-andres.emb.sys@gmail.com>

On Sun, Feb 16, 2025 at 07:14:50PM -0500, Andres Urian Florez wrote:
> Fixed spelling errors in test_redirect6() error message and
> test_port_shadowing() comments
> 
> Signed-off-by: Andres Urian Florez <andres.emb.sys@gmail.com>

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

> ---
>  tools/testing/selftests/net/netfilter/nft_nat.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/netfilter/nft_nat.sh b/tools/testing/selftests/net/netfilter/nft_nat.sh
> index 9e39de26455f..8143b877ae7d 100755
> --- a/tools/testing/selftests/net/netfilter/nft_nat.sh
> +++ b/tools/testing/selftests/net/netfilter/nft_nat.sh
> @@ -569,7 +569,7 @@ test_redirect6()
>  	ip netns exec "$ns0" sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
>  
>  	if ! ip netns exec "$ns2" ping -q -c 1 dead:1::99 > /dev/null;then
> -		echo "ERROR: cannnot ping $ns1 from $ns2 via ipv6"
> +		echo "ERROR: cannot ping $ns1 from $ns2 via ipv6"
>  		lret=1
>  	fi
>  
> @@ -859,7 +859,7 @@ EOF
>  	# from router:service bypass connection tracking.
>  	test_port_shadow_notrack "$family"
>  
> -	# test nat based mitigation: fowarded packets coming from service port
> +	# test nat based mitigation: forwarded packets coming from service port
>  	# are masqueraded with random highport.
>  	test_port_shadow_pat "$family"
>  
> -- 
> 2.43.0
> 

