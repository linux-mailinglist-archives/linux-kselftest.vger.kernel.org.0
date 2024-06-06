Return-Path: <linux-kselftest+bounces-11281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279758FDC96
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 04:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C066D286657
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 02:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038011798C;
	Thu,  6 Jun 2024 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft/AAXQ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5B1758D;
	Thu,  6 Jun 2024 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717640021; cv=none; b=u3+TAowk9RKpIhpJEVVNS53uO7bGf3SwB9WRLTSuEdm1JTgiZBlG8bEeD4Air9opK7Vna24tT41p3F4yo0b0HRni48L5NBuDNedflY8WD9vv1+d2cqn+YptM6LLCWtJvOEs1lVTdIsbPFICw+oxR/dQSvXD5GDltqlEoo8Kuz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717640021; c=relaxed/simple;
	bh=dH5Lo1JA8dLCZsYd45JVwDzDzX4JrpI0pIOa2GxHYEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjNUH0hCW3TSTutl+nFpjeE2w4Pbw00JboWOu8vzix+Xuv3kE0rs7v4PAdDIY4yQPgy7gKFwG4U9WfFoOo4ckfa1mky6d/MPRIj8hy0enxJM5nbfKA6v3dZNscm2BDAmYuGLbRmb8RPx+9HbEecPl0lp1tCy3F87ZYyEUGIhe7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft/AAXQ1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6342c5faaso4400855ad.2;
        Wed, 05 Jun 2024 19:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717640020; x=1718244820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fRVnmlsc7QNkh6mX1rqWyPONrK5lstvoABVQOrhbpTU=;
        b=Ft/AAXQ17hRYjoUM2exvMytWAm1Gep1YSN2yLh8AciKwJJ1C+UiNhEmWMGGrneW40g
         oHeW155DzQbDIn3YP0RYegOcJZO/mKooKONHnXL1CcLfiMebhw5VCpgS84xHNThjqXOJ
         WTnbyv3J5Z16ymjFDWNUiNyDEiyzxlbVFpafj+0tIzC8WSF+wI+GOqvNM82ypi0ue+M3
         hNRMnySM3X7vNPHpo7P5fXU6vs6F9zS3afy2UBanLNM7FM5BPLgyD8r6HN9qN5GyVkiF
         /yk/WJP8jMwSa1BfRUX/fXADQEMDoKexuJ7YuIEjUH9g44UJOC9ndJ40gV8HiYcNqB5K
         PZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717640020; x=1718244820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRVnmlsc7QNkh6mX1rqWyPONrK5lstvoABVQOrhbpTU=;
        b=hI7s3slykKZu+5RD0OTqASjDDMDdeqAhm5XgstbE+VkHjlvjFEzCJbaPt60QRnCSFq
         0tq0By27GmYlsCvZ1eAlwujENcd1z9iwM5RjPOdqk8V7BiK0MjCP4pvpreuHsyW5lWWf
         tayJ5wFA9pOaIv/das318KoW+VPz1woPHGe+ZCxQ4ZbAQ2tYz9oqDQ5QENRXrWPFi97A
         HWWpSKp4jTd22pNhrhYUQtsg8h+FkRmhGBIXm1aw8N2Z4TKRCu1QOeKOUJ6eb4KzMTjf
         fea3E7es6bzCn3RUK0tyPTViPpQwd8bIJ5YOj+vnBtGSMXTZx9GmcwHv04YLKFETSxZi
         vj0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxYkeJFt3C2n+CuepP/NEBHRif0xAvDHLzDqxuxtCgOsGkfkKaMxjK3tS5N9+CoAp+JZn0tttSKlwjGLCqgTzgd2ZmzUbxiyQt+0aO4lrjhYacB+vfke2Mvw967f1x2LLPEq3+OkSaqpvkycWDr0fMbTI39z4J7YMLvXRIlBtzZ4Vqjd1f
X-Gm-Message-State: AOJu0Yz0Yic2tDm2EOJ19Qa7OAGOcLi/CYrXaTGKfrgPTw61uyxW3L6l
	aqfcoxwu/PsolMSsouX24z9+r2X6RZUp6Rlm5AWnpauAltLYksx8
X-Google-Smtp-Source: AGHT+IHNnmRW3asdFRMsFQH79iiIi8CETXvV5SMOdyD/clYI1911oYDaeGIPIpoRJH1VtdOoodH6lg==
X-Received: by 2002:a17:902:da87:b0:1f6:673c:ff2f with SMTP id d9443c01a7336-1f6a5a8785fmr47274225ad.68.1717640019818;
        Wed, 05 Jun 2024 19:13:39 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782b:80e0:aaca:87fa:f402:cc0f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ccfacsm2226765ad.167.2024.06.05.19.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 19:13:39 -0700 (PDT)
Date: Thu, 6 Jun 2024 10:13:34 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH net 3/3] selftests: net: lib: set 'i' as local
Message-ID: <ZmEbTvuUOGxc-quG@Laptop-X1>
References: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
 <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-3-b3afadd368c9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-3-b3afadd368c9@kernel.org>

On Wed, Jun 05, 2024 at 11:21:18AM +0200, Matthieu Baerts (NGI0) wrote:
> Without this, the 'i' variable declared before could be overridden by
> accident, e.g.
> 
>   for i in "${@}"; do
>       __ksft_status_merge "${i}"  ## 'i' has been modified
>       foo "${i}"                  ## using 'i' with an unexpected value
>   done
> 
> After a quick look, it looks like 'i' is currently not used after having
> been modified in __ksft_status_merge(), but still, better be safe than
> sorry. I saw this while modifying the same file, not because I suspected
> an issue somewhere.
> 
> Fixes: 596c8819cb78 ("selftests: forwarding: Have RET track kselftest framework constants")
> Acked-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/lib.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index e2f51102d7e1..9155c914c064 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -27,6 +27,7 @@ __ksft_status_merge()
>  	local -A weights
>  	local weight=0
>  
> +	local i
>  	for i in "$@"; do
>  		weights[$i]=$((weight++))
>  	done
> 
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

