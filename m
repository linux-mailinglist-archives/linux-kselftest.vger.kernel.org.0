Return-Path: <linux-kselftest+bounces-3965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAAB8465BE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 03:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63A828D9E6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 02:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666AB8839;
	Fri,  2 Feb 2024 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUpbzJ21"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BEBA24;
	Fri,  2 Feb 2024 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840484; cv=none; b=SlzkFnNUmK8OaQ+qMAiKpwVHJpmtMTgU+/ElosTF2GTIk15pHT2lYsXK0dSpyQ0dg+bceujvwdQnSVWMOhYoAVZG01hM9cvnHoyTF9tsuFIjk23eV5MjVk1yXJrGaUmFp9NkaNsDEMw1Sccd9/NnYB9GrbdszDhFnj2m4Q+eqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840484; c=relaxed/simple;
	bh=DdoXRzk+lKR3FazbKRtaW/yjrgzce0EILdYm+2tlAR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0qgMgrJvK23ompWlAM8Le4U25Gq3JrL5kTmuJejycrSUmOUZlaKfD3baoLL+0V61V7UKF6DpqqPWw6RdOqk58/231pJJQtGFMOuyQs4Ov7izx07o5mKwMq2JStZIHlcBW2FGaAjskufMfAhjkPF16NN1x0MJx4xAfj4P+o6qSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUpbzJ21; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7beda2e6794so12224339f.1;
        Thu, 01 Feb 2024 18:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706840482; x=1707445282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCF/rEIk8KrA7PI0LjZREJr/uXjAEXA/eqE8UNUtZHQ=;
        b=bUpbzJ214W1tJiZ+5tIFVatE/EFBlu3b6zDLr0DR//OKq+vQ2Wwrb3klYwLwrx06LU
         2NyqVTK4raG8uSwIdVGyIr6dCbG3kIjjGZ8q9m6ymn7+Iz8QeeQT0E2Vlbcj+KBqI136
         aISxDOtksMSFfMV+f3F/BZFwf3jKuL4l84Pw6mGrkaFv6Xixzopb1aGiFIcMiAqwdmnm
         Cy8QVUAPcBJX4luGi2o9TxTFfXUa4uMeD8qs4r2aG+EPHZTAK0VOTnSwgyLjzfpttl9O
         3ptoopURnHSSEwv623L23k0w62CbHby+sO2VetgipynAF3+4MVoSSCTn8cCjC358jIcP
         dxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706840482; x=1707445282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCF/rEIk8KrA7PI0LjZREJr/uXjAEXA/eqE8UNUtZHQ=;
        b=J7Yw7uEb9U9s9dnHz6qwH2/OFgEb37UVHhelh4yTSE7hgfZO8GHJA/WuwBDgJrG4Xo
         TRfq4p9a8neaSEgV2G7Qp/+hUU6/E3r/dc1jWw4u4P4L+Q+HCyei9HkDQI290Apty8CE
         eG3jwAFcMAEEAfVlxsrQQCrOP7dCYr8Ph6eqPiFprLVMHVHmHV1m5WUV71RdDpon5wEE
         uIs/aoeZdvV2KxQzLz2brx+kCdBiIUI+4nJDD6ep6O84cis8YSVdZXrgFWN4wlV8ldcJ
         8Mr4noVye+xfqUkQWkRVrQWHWKHRWj0NC9aJtOGw94jXzCFd2KdgW6xkE7JQ3aroXi02
         uxVw==
X-Gm-Message-State: AOJu0YwS7drp0UtKA2UH15IhTftY7SIPwWmldzkMPQGxNWtO7zbFXa7g
	++Fdjca91+huWlJlkFpxO9GvkvMJodgrNkPGP4e0La5O0qfNlHAM
X-Google-Smtp-Source: AGHT+IHEmAORMd6S6PZh9WzCAsfNYaDaqJGdy0b1gumH93sXlykxSlBsSgetstaQxphrN1IzEibGwQ==
X-Received: by 2002:a5e:df47:0:b0:7bf:9e23:99a3 with SMTP id g7-20020a5edf47000000b007bf9e2399a3mr685000ioq.2.1706840481849;
        Thu, 01 Feb 2024 18:21:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUjJjJeDecBv9ijEaATRrQYjUJGvfUqn78QhfOMy/FFHOLBsSLJcpvFs2H3ldDffa2EWA1N/PwN41IM9fswaandc0TIGkAEmC49lEkvHD4VYz0UwcwFCu9gFXgtavxw2JO46Hr/43UIxa9DXpg4Hi7RRrn0Rusog1TRY0uu/1btV4NFLh/dnvEn+tLyvigsHoNN4Z/IPOe7TYbQXFVOcOkjOA6lqLJcvRTY3OFILJPDept+aGURNCjrTAcKFK7bmOQB
Received: from ?IPV6:2601:282:1e82:2350:245c:6a9e:25c1:5469? ([2601:282:1e82:2350:245c:6a9e:25c1:5469])
        by smtp.googlemail.com with ESMTPSA id l22-20020a5e8816000000b007baf1948186sm227403ioj.42.2024.02.01.18.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 18:21:21 -0800 (PST)
Message-ID: <5e6edac1-1f52-4978-b483-974c3958daa0@gmail.com>
Date: Thu, 1 Feb 2024 19:21:20 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 0/4] selftests: net: more fixes
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Florian Westphal <fw@strlen.de>, linux-kselftest@vger.kernel.org
References: <cover.1706812005.git.pabeni@redhat.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <cover.1706812005.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/24 11:42 AM, Paolo Abeni wrote:
> Another small bunch of fixes, addressing issues outlined by the
> netdev CI.
> 
> The first 2 patches are just rebased.
> 
> The following 2 are new fixes, for even more problems that surfaced
> meanwhile.
> 
> Paolo Abeni (4):
>   selftests: net: cut more slack for gro fwd tests.
>   selftests: net: fix setup_ns usage in rtnetlink.sh
>   selftests: net: fix tcp listener handling in pmtu.sh
>   selftests: net: avoid just another constant wait
> 
>  tools/testing/selftests/net/pmtu.sh           | 23 ++++++++++++++-----
>  tools/testing/selftests/net/rtnetlink.sh      |  6 ++---
>  tools/testing/selftests/net/udpgro_fwd.sh     | 14 +++++++++--
>  tools/testing/selftests/net/udpgso_bench_rx.c |  2 +-
>  4 files changed, 32 insertions(+), 13 deletions(-)
> 

For the set:

Reviewed-by: David Ahern <dsahern@kernel.org>


