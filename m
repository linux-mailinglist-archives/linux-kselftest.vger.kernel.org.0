Return-Path: <linux-kselftest+bounces-43971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CB9C04CCB
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 09:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 457614E34D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 07:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3013E2EBB80;
	Fri, 24 Oct 2025 07:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="PkL5KFp/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F22EB858
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291803; cv=none; b=MHQCa6gKldD0wU7iIJtMC+Ad7+lPUHOK28C+50423oMr7X+p+tAKaYuC5Qih//wea3FhAHJYc0g77T6sXK2QKGRKwon/2T5cpCRbqcJQ5jsb6mFUj8pW/kAKTp/8qEYkRSQmhVg05CHzIVeP0AJx2f3nWoCujWEnDaA9zX2jZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291803; c=relaxed/simple;
	bh=n9vrj8rw3vvgLnp0wFhiU0wr83DTSKQ91SlzmqgRO7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAE4c520mIbeBMJiR6ReyabP4c/Wixw/lP67TJgm5kHYWcGHp/ki6+toIJZgteSlfe/ch4qef1+KqM0Kx9rd3ploakrrZpXEc/7196H27mv5OZjg9Wcm1PTiRN4z33tHrlPAIzd6f9Mn81AJYoI/B/oKocGoHwceiyM99XaIvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=PkL5KFp/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b6d5e04e0d3so225387666b.2
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 00:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761291800; x=1761896600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btg6WWXpIi0CWUiiHvKL1LewBs3OVn+no42TB4G5pPk=;
        b=PkL5KFp/7P3i8NiDEWB0LFmIDPhX+9t6CAfkDZ3joMpWEfkIkpwJRz0UmMYeivRgUl
         525dlBX/WxfXNFVpVhgBiOmpM0XLrhCsS+wut04tg+042TZX9eDL3vAVNCNVUCl2VDfa
         mLVi+bVeNG9A+jo8Ct0mpbMgvtuCuS/5ydSQoEPgKjjiLwdFIP+k+q5vvlB7aMYRz2Be
         2TQvjOz5XuMwmOUFi1/qwL0skLx6+A1oLHo9kZ4ajgseuvDY4DZH0JkTDnuMD6J1b/fr
         O5Nd7d1jL5PEEF1HA1roD5l9YRkce72xMzlAwSC177bF4bYm6QarF/2XO82h+m8jBlbC
         UgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291800; x=1761896600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btg6WWXpIi0CWUiiHvKL1LewBs3OVn+no42TB4G5pPk=;
        b=VLPoBMBxXFRf/gQAMeeW+yDv0m18yaasyrmx0pnSOhjv/RpDETpRHgRN7sPlsa4OJe
         1HEqKxx3CzYwJ61mKJP3NU+ZKLVgxOE20eXwxm3MX6G/qnJD36SapZTpj+ONSiSIrKS0
         eAuRiHiX/L+w2yrUwhWIbQ9x8sSAH0cbBZ33TAreKeT3J+Az/lN+AAcCIcbcx62FrAG3
         uPdYNfeeOa7Bx+hBy/52SQ92OBuEdFmkLSZz9bQRLhh/TPYj0lH9WLDBYWZwGYKptC/R
         4Eu9ba78w98tSwMuwiq7JYr9jlRq0RRKpsY9vXmPN9HLDhXDL2L/hIiRKu+ZkhKKTdAR
         uz5A==
X-Forwarded-Encrypted: i=1; AJvYcCWqstJRNM6UDdfVyIernZ4J2vvRlGdfqaxNj6OYziN1xOFHDBH75JTD8CitPJkVadzarrfTSxe8b6BFA8SDGT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl35qkexUZGF/rjISefDpv42gsPF7qTBpOQ4oqpgMyFJM4cY5X
	vNNIkQVV1btV7HGXbsF81H7nn5Hg4wHuNNtK3H6CM7pWeLFu3/RImKN4XyuVjxpmBC0=
X-Gm-Gg: ASbGncvezg5cOqW75za0Q/ORqlSs/pB3hMNrHc+EPVmiF3ZLqmdlNx3DkRJY7diNSFH
	Y0ZACDLsJbfxmwkTpsRNf9xMgoQwPajnZaLoZoh+7XkLpDz4T+M+uqsQ51DCOrB01qwaVmF2Aki
	pCd7m6pr9kvWFUylVh10BF4W5dSlcIc6NJKw32zzdvIY+AQaUhhCth/2DkZRnIWQbeb1WXIU/yk
	22fbY81k+1nMUOWxPiQrJfEVKguVTCeGt/bgNL2MAg+p+U4GnB2ejXictZqx/oOWIaSnkIg2dUY
	ZabQCpQ5ph/NI84iiEIkXPsogrNtb0vFGYr9aUXJQXTQFNJGsYH1+uIYWsSKNCNBPGwzzSKrQgn
	F/JtzBIEMTaTGW76HrjqEXVEyMjqYWdybYFG0lmPwAa4JHqgvflA9M5gSTE2ZQEEtzVfBoJo/iM
	yB6jvthFTyqH056QIun4ygEYvz95p+enWDAkWQ0YTzfV4=
X-Google-Smtp-Source: AGHT+IENVgAAY05iZMjJCVKA8oSGaw8hZMk+fKU5hdYwbKNdz8hghfeyg+3i0gPeAqEdHdSGOTqcCA==
X-Received: by 2002:a17:907:1c21:b0:b6d:536f:ada with SMTP id a640c23a62f3a-b6d536f1134mr702214066b.43.1761291799580;
        Fri, 24 Oct 2025 00:43:19 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f316847sm3676823a12.23.2025.10.24.00.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:43:19 -0700 (PDT)
Message-ID: <4cb007ea-c29a-44e7-933c-cfe3f728d42c@blackwall.org>
Date: Fri, 24 Oct 2025 10:43:18 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: bridge_mdb: Add a test for MDB
 flush on snooping disable
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 bridge@lists.linux.dev, mlxsw@nvidia.com, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
References: <5e992df1bb93b88e19c0ea5819e23b669e3dde5d.1761228273.git.petrm@nvidia.com>
 <9420dfbcf26c8e1134d31244e9e7d6a49d677a69.1761228273.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <9420dfbcf26c8e1134d31244e9e7d6a49d677a69.1761228273.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 17:45, Petr Machata wrote:
> Check that non-permanent MDB entries are removed as IGMP / MLD snooping is
> disabled.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: linux-kselftest@vger.kernel.org
> CC: Shuah Khan <shuah@kernel.org>
> 
>  .../selftests/net/forwarding/bridge_mdb.sh    | 100 +++++++++++++++++-
>  1 file changed, 98 insertions(+), 2 deletions(-)
> 


Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


