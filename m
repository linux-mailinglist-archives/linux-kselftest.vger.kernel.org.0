Return-Path: <linux-kselftest+bounces-11282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A8E8FDC9C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 04:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3C0289223
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 02:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60917BA2;
	Thu,  6 Jun 2024 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP+iem6i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DE18BE8;
	Thu,  6 Jun 2024 02:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717640158; cv=none; b=j0Tfcx7gENrFX2pURMYARHtYNW02syNtQtXQfiTDbKiScXrp9YWyhLPHdJ/GFTftppfoG6K0ovYQulccP8JUt1X+rU41dzujHQ0CHtsTbp3aHpGe3cfVnxNy6zvp/jxR6dbyvMbg7FeMVp4AYQhN+6LTXsbZBvee6I5VIXfveX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717640158; c=relaxed/simple;
	bh=6YiCaeGRIRC6Mza9FWAyFiww/A1swV00WkMpYxit8Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEDTyJ717u1yYs1oG3JuJUmJybXUZ/XP62OGm3LCRcMDkSZUc3vBm7aIn1iXzzdV81ybYNypmcVQR22Bqvsga8frCj9o18rwzXNQwx35iLnrUny9HSiDxH/GlQWM0kai5JrOfE6Wg8i4veXSqlOJgqqlpU6hsGfYR2Ipip8c39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HP+iem6i; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-24ca0876a83so201059fac.2;
        Wed, 05 Jun 2024 19:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717640156; x=1718244956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmL6mA1X24mzn6/BlM9GrDNbWk2sLMyybrXWqmNiVrg=;
        b=HP+iem6iBhthbMgZbV0vGN96iVltwnHrSInIk/chhvSxFrme+6MTcTVeO4N87XqGpA
         nyFQshKrgnxYYWaEjFbkqSYWZLwCcIq8MiUlkv42tKfvobxhMwr7/4x6K/OMaMy/BUF/
         vfsnmTB4KzjKPr05XGGoosckJ5a6huibYQEbroxSi8bpoJnqQSm706kwoM7c7v0E4ZDC
         3PbJ7vsZ5Ftp63oqdQSBaBv+DHWutefG70jDgGEJUuDudp870DI0s81fM+PzeNzQbyl8
         UlCJhcaaGgkvJWE9tpRY8vWSgDqrzwm2JrSC7tJ+nqJcaLdJhMaki7n7CjgCk3sCzBZ2
         ZLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717640156; x=1718244956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmL6mA1X24mzn6/BlM9GrDNbWk2sLMyybrXWqmNiVrg=;
        b=NDKKvuKfYBkwi4ZtXujZmpXYxuTClBKv5FjxEmfwySvGVpA9xATRDC5rvpRm5oE5zR
         Nln6mw05G/KcyJl//3aUIXPRUTGNJQvDDusWVaGZYUn4vBdycV6KRkxoSdvLVT9cwNfw
         kkBVRhS2R4CLhruIep/+/EjqHycBiNPV9loTgKRjnd4EDUWJJr7kpQTnQY6p3I5dkJ3F
         TM0Fd/1hh00PEB8KzYpbDr0kRwNTjP/mVrOxbB2touc6fLw2H92URHLjCz8/R4+L4zpW
         zdU6tVk8f3M8VZ/nSdjY8h+Sx684ij7STdgt51BCMrazYxpUDZ5xopDsrYV0dVMZJEmi
         q75A==
X-Forwarded-Encrypted: i=1; AJvYcCW5ZFJZJzv2buApcBzkKDLAtjE616xIaxTDLpXxE/EA1WWsYJenXDwWShC9aas4rzgryAPTRASm4I4W897XgQJ0Rmo0mefP+2CrmR39qSrES4cERgQMHmLVXiyj2clj91/VW/FahWcTFaeymaQYS6etsbb7t9jX89MeaUjVzsUTi4VGpgKNKw63YDviKmU/s3J0TLTvxNuuS5BKSQxE
X-Gm-Message-State: AOJu0YyYDs0lXjZu6JPiybWU6uK+0i5FYLN6sTEYW3AxCLsClxWQIkRE
	3F8HURZrEwS/Sa03PIONub4lnJOQLVvxHNcqNL8Q/UBngJXct0MC
X-Google-Smtp-Source: AGHT+IGRRDe4RyIMQgWMV2KX+qTPdrx8+5e3bTbCxproVRCUXYs8LDSdfxXHHE5esmuVCbKLoHpKCQ==
X-Received: by 2002:a05:6870:1711:b0:24f:d5fa:615e with SMTP id 586e51a60fabf-251227360b0mr4746485fac.27.1717640156084;
        Wed, 05 Jun 2024 19:15:56 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782b:80e0:aaca:87fa:f402:cc0f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd494fc0sm166701b3a.127.2024.06.05.19.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 19:15:55 -0700 (PDT)
Date: Thu, 6 Jun 2024 10:15:50 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH net 2/3] selftests: net: lib: avoid error removing empty
 netns name
Message-ID: <ZmEb1q_gCHvKhzib@Laptop-X1>
References: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
 <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-2-b3afadd368c9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-2-b3afadd368c9@kernel.org>

On Wed, Jun 05, 2024 at 11:21:17AM +0200, Matthieu Baerts (NGI0) wrote:
> If there is an error to create the first netns with 'setup_ns()',
> 'cleanup_ns()' will be called with an empty string as first parameter.
> 
> The consequences is that 'cleanup_ns()' will try to delete an invalid
> netns, and wait 20 seconds if the netns list is empty.
> 
> Instead of just checking if the name is not empty, convert the string
> separated by spaces to an array. Manipulating the array is cleaner, and
> calling 'cleanup_ns()' with an empty array will be a no-op.
> 
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> Cc: stable@vger.kernel.org
> Acked-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/lib.sh | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index a422e10d3d3a..e2f51102d7e1 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -15,7 +15,7 @@ ksft_xfail=2
>  ksft_skip=4
>  
>  # namespace list created by setup_ns
> -NS_LIST=""
> +NS_LIST=()
>  
>  ##############################################################################
>  # Helpers
> @@ -137,6 +137,7 @@ cleanup_ns()
>  	fi
>  
>  	for ns in "$@"; do
> +		[ -z "${ns}" ] && continue
>  		ip netns delete "${ns}" &> /dev/null
>  		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
>  			echo "Warn: Failed to remove namespace $ns"
> @@ -150,7 +151,7 @@ cleanup_ns()
>  
>  cleanup_all_ns()
>  {
> -	cleanup_ns $NS_LIST
> +	cleanup_ns "${NS_LIST[@]}"
>  }
>  
>  # setup netns with given names as prefix. e.g
> @@ -159,7 +160,7 @@ setup_ns()
>  {
>  	local ns=""
>  	local ns_name=""
> -	local ns_list=""
> +	local ns_list=()
>  	local ns_exist=
>  	for ns_name in "$@"; do
>  		# Some test may setup/remove same netns multi times
> @@ -175,13 +176,13 @@ setup_ns()
>  
>  		if ! ip netns add "$ns"; then
>  			echo "Failed to create namespace $ns_name"
> -			cleanup_ns "$ns_list"
> +			cleanup_ns "${ns_list[@]}"
>  			return $ksft_skip
>  		fi
>  		ip -n "$ns" link set lo up
> -		! $ns_exist && ns_list="$ns_list $ns"
> +		! $ns_exist && ns_list+=("$ns")
>  	done
> -	NS_LIST="$NS_LIST $ns_list"
> +	NS_LIST+=("${ns_list[@]}")
>  }
>  
>  tc_rule_stats_get()
> 
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

