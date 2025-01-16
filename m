Return-Path: <linux-kselftest+bounces-24644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D00FA13A6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 14:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453A916822F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 13:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041A1DE8BB;
	Thu, 16 Jan 2025 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWB9x7MA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90FB1DBB3A;
	Thu, 16 Jan 2025 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737032761; cv=none; b=os/y3OnhXjlME0nJkdqimcBWIPjXpl/FfvbxAhRmy/asCNMXiQvmWcHGKwE4MfPYOAmiUjqhdo1n6dMatftCPQIQzbjcoq7IJ9BT1xCMAhnPVttx+jpQ+FzqfqgX4lXQjdW3QYGAg3yQGDDiPzRZmhOYVHHIg01qht277hEPNEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737032761; c=relaxed/simple;
	bh=xqmwHNMUxOzWQNMkjdnL99R7EvmlfjtjhNY8AJdh0J0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ruUqkvigdR4siBsUogcN21E8Iw/bCdsyCIGIXFKnKcFBefmwMPvI+383OmH07jXOoNfgTyCzNmjZQxSS91NexlQCK5aWEGKA747IMo/cOJbX6KKUvs1Wo8WIvEpYSCH2Z2grb0RNOAEWIfZ8lNmEeoQztSAqhamcBaA1ba9skFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWB9x7MA; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b7041273ddso63680285a.3;
        Thu, 16 Jan 2025 05:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737032759; x=1737637559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhBgJdxLvQes3eD3Fu4rvlsneR+YPZhZCBELAv2eIdc=;
        b=hWB9x7MAH8Qw/ZUAlIE2Gj+r8OVstXu19ABfOyAs74y/id0+PkFbVnlHN6Eo55hLzT
         2LpkBhT42YrDDwLIVBkSkwiNFQS6FhEGpx/V6ws//VtBHgArfyqwog21vGNHA9OVMiAH
         o+PUSFdFJruh03QosPCM/53FMj5OJhrGnkEa0nzdEOChqBGLm2AYbPtLu67JyAK3tvmz
         k25KCD/0Xn9Q3VHXiYZ5ggzk7kj7I1WfacGZsm8z3PDrOhBKC22U3aFskzJNghFBdL//
         33Q/fKyp3h16UyMTjz7c+HpX4tCsA4ZhUJkYbhE6hmK++C3uzjs8RofJOvskDsZk1HsO
         TYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737032759; x=1737637559;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OhBgJdxLvQes3eD3Fu4rvlsneR+YPZhZCBELAv2eIdc=;
        b=NHpKUEMCNLsYTd9t6tlXfmyitAh3N+T9Wm6MmLR7FpkXLFmmC8nT3GqWnORxSkpR/q
         D/eN4DW2hZzt1d7GSoKaYcViO7XfLIj2sm86tWgExAkwY7SiWxS3nlACFSGNqxD3lxlx
         sFLMu2/6EE+Lor4kWVGD06eOoUdp+dwhGf9NbPsmsZRq5dXHi4FPeQMzUYIs5lNjexie
         zWyxZfO5YOLnmhzS+iyXK466YsYxtwoQz4b/HNduApivSdrcNkLBxeLeJFv1jyt7h0jK
         e8RayJQoeqLksVeSVvfC0G9xovEVGLKoKZP+5cyzUHhzA7gOpQSKvMMeiqjqB7X3eTcx
         tYxg==
X-Forwarded-Encrypted: i=1; AJvYcCWsWRngbOV8gPqDPBgakfwPC91DcVXblBt1xSzu5zi0aZ3Dt5QmDJ2tgcld38PI0t07HGSB7sgsSqzaV9Z5TiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoE87tMvd/ReDujvZiwicuuv8q6u4ydCaDGc+qjjh/nLpdLmwX
	F9RqXDO1IJGZbrdhO/brQwA/74cUU3gFeF8nVqGb0en5xctuqdDM
X-Gm-Gg: ASbGncsc87n8X2JbzEwuP0Hk1gmjc1CeoSUfouZhANLf45oeBgoiB03+Pe/4y7ClOja
	hOl/ocrsziB8x8nhan1HIGqDjspBMn2pT9CdezDGzA7pG+1zdatFY4N7BLJfjhTxRVOAJR5Ew88
	TKO0ONP/O8gBTg87Lq3ab0lSPz911QecjqX89bVoD9YLC2jc4uCS/CHRc54/2VIr2ll7zRgRtzO
	pbkAmXQY7OcEkPf96eGHpyeFcNlvWW24VEkslR7cf4hcMTFpk8optPjHh0A7ICyso843X14jdJZ
	lzVIn2jcTsVNeiLjjwbSrXm3fkVA
X-Google-Smtp-Source: AGHT+IElbOoja7u6ZoigUpifYLw6hVVbviBYUjq+InFERrp8VSBSuxpHDrR748dJuhRz3jJqU6nUHw==
X-Received: by 2002:a05:620a:4612:b0:7b6:d736:55c4 with SMTP id af79cd13be357-7bcd973ca24mr4672937685a.17.1737032758410;
        Thu, 16 Jan 2025 05:05:58 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614d9989sm2130185a.83.2025.01.16.05.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 05:05:57 -0800 (PST)
Date: Thu, 16 Jan 2025 08:05:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 willemb@google.com, 
 matttbe@kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <678904353ca7e_3710bc294ef@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250115232129.845884-1-kuba@kernel.org>
References: <20250115232129.845884-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] selftests/net: packetdrill: make tcp buf limited
 timing tests benign
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> The following tests are failing on debug kernels:
> 
>   tcp_tcp_info_tcp-info-rwnd-limited.pkt
>   tcp_tcp_info_tcp-info-sndbuf-limited.pkt
> 
> with reports like:
> 
>       assert 19000 <= tcpi_sndbuf_limited <= 21000, tcpi_sndbuf_limited; \
>   AssertionError: 18000
> 
> and:
> 
>       assert 348000 <= tcpi_busy_time <= 360000, tcpi_busy_time
>   AssertionError: 362000
> 
> Extend commit 912d6f669725 ("selftests/net: packetdrill: report benign
> debug flakes as xfail") to cover them.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks.

I see that we'll still have a few flakes on dbg. Perhaps one total
failure a day. From the following.

tcp-close-close-local-close-then-remote-fin-pkt
tcp-ecn-ecn-uses-ect0-pkt
tcp-eor-no-coalesce-retrans-pkt
tcp-slow-start-slow-start-after-win-update-pkt
tcp-sack-sack-route-refresh-ip-tos-pkt
tcp-ts-recent-reset-tsval-pkt
tcp-zerocopy-closed-pkt

We'll take a look after this change whether we can make these
more resilient. But likely also allow-list or even xfail for
everything in dbg.

