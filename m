Return-Path: <linux-kselftest+bounces-7943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CED68A4951
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 09:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9C32836EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 07:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2F7286AD;
	Mon, 15 Apr 2024 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDnKY8DZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AFD1E4A9;
	Mon, 15 Apr 2024 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167248; cv=none; b=YFTtS9JKYTDZP/sdmslv/JCtlrkik3cldg2FVBr7Qs5axn3l08ZrdAPCqCXS9a4p8/083dqN0IrdRzpl+fU4htPc50yDNWOSqMLspE1vLxVjzfq7uPsLqele4/SctMBge8CeK1puLxRCMtHj2WYYbZQUzCf1Z9N0rU5Ucl8mXKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167248; c=relaxed/simple;
	bh=8QxPv3JG7HGnj3cDAkE5LdRRHUgT0c9A/iFhEMvBV8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhb+w3QxUk8Isz95UEKDdWEzwvEfs90KVdX3msAMqBmjZuvhtCe6kaHEDpzJPaxpUF7I3AMO9CPJvXjM320YTq0PufhQf4HLjJ+/8Yh7x4vpb3vVpSRYj90BixmE15Q3c0JYL6GjZJ1zA22vxGEh84SH6th9HMQr237y2uUFjME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDnKY8DZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed627829e6so3166448b3a.1;
        Mon, 15 Apr 2024 00:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713167246; x=1713772046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AlkCfQMw/u13rTL1XdVx4Wz7lR+OUDdhUc7fwOhjdwg=;
        b=PDnKY8DZYqY9QUzAxEciYe9Oktjqfqr66cI9zCn3OI62faZ1wpA3LUQ6m1jHUVJr4b
         AzAPcjOfwlJRsQGsVKP8VW1ky7UrXQznjsw7DdGqoyrgkZLE9d/OnF5N1gLwvAlo5pBM
         5W4p3a2JzvmLU+mKoXNSpRKzdHjr1KbC4/K+WYZ6xhqH7zoHqpiVyVRJptmWXJEIV2dB
         D1Ott5xowY/8rry+5u97kV5EV+E5K5VelVICWzcC4ipABl2N2QdEMwJe7jj8ETPwB8hw
         D8rbLpb2NeSZaBiUxMfUCWFXaCGfEZD9k2m659L7qmNQQrBaD6zRiGOB7AMUTV5+YpAb
         l6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713167246; x=1713772046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlkCfQMw/u13rTL1XdVx4Wz7lR+OUDdhUc7fwOhjdwg=;
        b=kKEsaNHbCc3atr2ikIIh19tHthPEOegFN4wO4waTzq/UI7gxJEDyvxY3uGX6f78OSI
         sZ04igu2nhiKa9b36xUkcjzzERxjQk2UMVkbB/APEb2NHjxb7kgWljxJy97c8fQ+vpwZ
         s8DdSGkdUXeUIFeEzRnpuPrwRq/QNTBFuYklWX3zToAc+FSPoLHPfbdVYQwmnOOP0Ylu
         TeSsQH/WfGxJWCEsC2FNosEmgY4z6vnLqgS+z3yOY8YtrTBKM7tb+6lZ5P9/uttZLFm6
         KBsdJTANrQY4iDzvMh6OHeLjA/0KHRuYSTb89JVKMwbN1aq8JtpybIZU+UAkSdxea/nE
         VE+w==
X-Forwarded-Encrypted: i=1; AJvYcCUJRUg0lyvGp8eQ9mFbj62YKy+Y0rNbSP59h5nWtGsuWEWKrcNi8umW/OyS5Qqa9uqZq39Iix64j/K0kFocgOJrX3HNDYw+cS6nbkSftc0YQe61wEsB+sQdS09teW1wf6onhEUgOEmX
X-Gm-Message-State: AOJu0YzwE/YYoIZdTpHgh30q4qL2ggKuB1/XIIvJGqD/PYbUTJmP+noU
	YAVO0QTn/EK+yZ+426SGwTmrEOnjDUnBA6i34qz1SVo0syv5pXDA
X-Google-Smtp-Source: AGHT+IE1PisHkqG3t5l6roO4HHNA95vpYSZHCK4P3IN8cxjx/g0grYyc+N3mHbpFjw0ajlBpbf1i/g==
X-Received: by 2002:a05:6a00:ad3:b0:6ec:ea14:b829 with SMTP id c19-20020a056a000ad300b006ecea14b829mr13673934pfl.28.1713167246346;
        Mon, 15 Apr 2024 00:47:26 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q2-20020a056a00084200b006ead124ff9fsm6650404pfk.136.2024.04.15.00.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 00:47:26 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:47:21 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com, Benjamin Poirier <bpoirier@nvidia.com>
Subject: Re: [PATCH net-next 02/10] selftests: forwarding: lib.sh: Validate
 NETIFS
Message-ID: <ZhzbidOT7t27Zdmu@Laptop-X1>
References: <cover.1712940759.git.petrm@nvidia.com>
 <4a7602678782a1f526bdcc895de437bebc96a695.1712940759.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a7602678782a1f526bdcc895de437bebc96a695.1712940759.git.petrm@nvidia.com>

On Fri, Apr 12, 2024 at 07:03:05PM +0200, Petr Machata wrote:
> The variable should contain at least NUM_NETIFS interfaces, stored
> as keys named "p$i", for i in `seq $NUM_NETIFS`.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 22 ++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 658e4e7bf4b9..3cbbc2fd4d7d 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -273,11 +273,6 @@ if [[ "$REQUIRE_MTOOLS" = "yes" ]]; then
>  	require_command mreceive
>  fi
>  
> -if [[ ! -v NUM_NETIFS ]]; then
> -	echo "SKIP: importer does not define \"NUM_NETIFS\""
> -	exit $ksft_skip
> -fi
> -
>  ##############################################################################
>  # Command line options handling
>  
> @@ -296,6 +291,23 @@ done
>  ##############################################################################
>  # Network interfaces configuration
>  
> +if [[ ! -v NUM_NETIFS ]]; then
> +	echo "SKIP: importer does not define \"NUM_NETIFS\""
> +	exit $ksft_skip
> +fi
> +
> +if (( NUM_NETIFS > ${#NETIFS[@]} )); then
> +	echo "SKIP: Importer requires $NUM_NETIFS NETIFS, but only ${#NETIFS[@]} are defined (${NETIFS[@]})"
> +	exit $ksft_skip
> +fi
> +
> +for i in $(seq ${#NETIFS[@]}); do
> +	if [[ ! ${NETIFS[p$i]} ]]; then
> +		echo "SKIP: NETIFS[p$i] not given"
> +		exit $ksft_skip
> +	fi
> +done
> +
>  create_netif_veth()
>  {
>  	local i
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

