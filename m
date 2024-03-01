Return-Path: <linux-kselftest+bounces-5766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10C086E85E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFD71F221A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E60C374DE;
	Fri,  1 Mar 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/TpT1T8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC671CA98;
	Fri,  1 Mar 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317498; cv=none; b=On+nhi59MyFDbT1gKQyZRVjd2pHA1ua2OIHodck3L82Zg/JY+Jd0rxO0HePA0X7gP8qym2fL9sCGT3ewzFYeYtbIH2IL8wQQf0PwLBeGagkR1RclLxPPg1LmAIUVCFL1sjCR4dC1WVAEKCOR5B7uJblh0Z/IhxOQHpEFvPEvzgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317498; c=relaxed/simple;
	bh=CQJcqv4UUzXrW38JsKfEq0OskcjwQA9TwEXYUE4giFk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LwfJedtb5+MLW19PeQUmku3UanOqczW99IXAVe71Bh8zVs/Op6WI8Fxb/gOOvo28T0MTA/dhwzoBOFhqZfGD6seotb9ffWGQa/lDr7rvGsvwwN9de54RoRdHUYRuyBWpYMmm5aEoix8PloVTtL1HQUly3vNUHQW+I1i6Pflm7ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/TpT1T8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A7DC433C7;
	Fri,  1 Mar 2024 18:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317497;
	bh=CQJcqv4UUzXrW38JsKfEq0OskcjwQA9TwEXYUE4giFk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=u/TpT1T8wIiENRVpQr5nT4Aq2KE2355h7bVAHGdVSfhAGfRIlWeA2K2RHqfks2QO8
	 9J3Vnwh/Rk3fl28/jUCg8gmJAcv07frkpVXDaiW7sEzUyrM+GSVBLMD/7zcM2wi6r9
	 cE67L9UY6/MCJX1qpWNS3z7HYmSEE2Ny45Ua3AhR/Ggf6xgQ3WgxyDsppvEunPkGMi
	 igFcWI60WAezWEtc22QJ5feN9JufLY3qadbY5vIvdnZ0ikD/a8VxNdCN6NUC5wnJ+A
	 tJBnL4ICr+yUEqehg086+NUAwG5QRnBuDirM2uOFxTYZXWLnKh407vCiv+XVozUIBT
	 V7wd5bLnyufsg==
Message-ID: <52f0cd4c-9306-43af-87a7-3f5c47646059@kernel.org>
Date: Fri, 1 Mar 2024 19:24:53 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 10/10] selftests: mptcp: explicitly trigger the
 listener diag code-path
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Westphal <fw@strlen.de>, Kishen Maloor <kishen.maloor@intel.com>,
 Shuah Khan <shuah@kernel.org>, Peter Krystad
 <peter.krystad@linux.intel.com>, Christoph Paasch <cpaasch@apple.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
 <20240223-upstream-net-20240223-misc-fixes-v1-10-162e87e48497@kernel.org>
 <20240301063754.2ecefecf@kernel.org>
 <09046dcc-a388-4703-83bb-9fa0c36af861@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <09046dcc-a388-4703-83bb-9fa0c36af861@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 01/03/2024 16:10, Matthieu Baerts wrote:
> On 01/03/2024 15:37, Jakub Kicinski wrote:
>> On Fri, 23 Feb 2024 17:14:20 +0100 Matthieu Baerts (NGI0) wrote:
>>> From: Paolo Abeni <pabeni@redhat.com>
>>>
>>> The mptcp diag interface already experienced a few locking bugs
>>> that lockdep and appropriate coverage have detected in advance.
>>>
>>> Let's add a test-case triggering the relevant code path, to prevent
>>> similar issues in the future.
>>>
>>> Be careful to cope with very slow environments.
>>>
>>> Note that we don't need an explicit timeout on the mptcp_connect
>>> subprocess to cope with eventual bug/hang-up as the final cleanup
>>> terminating the child processes will take care of that.
>>
>> Hi!
>>
>> There's a failure in CI under debug after merging net and net-next 
>> in diag.sh. Maybe because of the patch which lowered timeout?
>> https://lore.kernel.org/all/20240223-upstream-net-next-20240223-misc-improvements-v1-8-b6c8a10396bd@kernel.org/
> 
> Thank you for this message!
> 
> I didn't have this error on my side, even without '-d SLUB_DEBUG_ON' we
> do on top of the debug kconfig, but I see I can reproduce it on slower
> environments. Indeed, it looks like it can be caused by that
> modification. I will send a fix ASAP!

The following patch fixes the issue on my side (when using 'renice 20'
and stress-ng in parallel :) ):

https://lore.kernel.org/netdev/20240301-upstream-net-20240301-selftests-mptcp-diag-exit-timeout-v1-2-07cb2fa15c06@kernel.org/T/

I queued it for -net, but the issue should only be visible in net-next
due to the reduction of the timeout, as you suggested. This patch can
also be applied in net-next if preferred, it will not cause any
conflicts between net and net-next.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

