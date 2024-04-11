Return-Path: <linux-kselftest+bounces-7687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2256B8A0C22
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 11:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7691F24449
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 09:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DA6143868;
	Thu, 11 Apr 2024 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE8IbOiq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9C71442FA;
	Thu, 11 Apr 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827066; cv=none; b=GdfAioQtlgAb0+xLDne143P8pmWczcwSYAA8fA0Jgp9k9uuewcU9v+D1QP6w7ZrV7PAIBCoPflbI605Azrg0JO/s8HK1QX9tXfO9CCUsy0hgR3qTJBXQXsJHDPX8ACN3qOTATWORxuH7DRQAFR2irWwrAZIxLQtzFBvbbAR42qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827066; c=relaxed/simple;
	bh=m53nnFpzQz5oa1v/Euu3FIxD4QTQaLgZyNyzPdTs6Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCcx43R9EiDgiVZTnJnN2AjiaYKgXJ5FOGriMuPJCyyrVXvoOkX2QBc8zScVK4FfdwiUfevunr7ikBSzd+PZuSnd0L0o1D1uVSN9h9pRm7lhT/8YtNmjA1SBCSbAQ8FD86RLLtbqe5nHli18dTds0pdJFRXdPo/6xqqVNe2end4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE8IbOiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCEDC433C7;
	Thu, 11 Apr 2024 09:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712827065;
	bh=m53nnFpzQz5oa1v/Euu3FIxD4QTQaLgZyNyzPdTs6Rg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LE8IbOiqmjrO6CE65HQ6hZD7IoKOFza7js5vu8KknTIp7vqUjzjfw4yFAfwp5Z0k1
	 cphzy/9aL20qork06Rm98zcwXvgH6eAkRoya6inGKHltIJJbDvaSIzETVqxTjEqJAx
	 ereCYOFOWOA5A9GP+kSMRjdz4qnm/8SDD35kdVZ/iRE9t2PDmBhcK1luQb3yx9emER
	 KQv849WxEYmGuqSCNcFRhOuusGS49sIJeWhuiWM+HQwlmVNOY+jc672UW255conZ+l
	 oTFOrgv5Ad+3TJqrucHhfUVPZiCkyhZxL2XKryeqLJoH4dbYsbtXByORWeCmayjgaC
	 5eOUhgAihCQKw==
Message-ID: <d7faeacc-0442-4cee-a0ae-4b39b75d0cda@kernel.org>
Date: Thu, 11 Apr 2024 11:17:39 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v2 0/2] mptcp: add last time fields in mptcp_info
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Geliang Tang <tanggeliang@kylinos.cn>
References: <20240410-upstream-net-next-20240405-mptcp-last-time-info-v2-0-f95bd6b33e51@kernel.org>
 <20240410113452.56f156f4@kernel.org>
 <b8c14751-37a9-4a3d-b9af-a5c697d34781@kernel.org>
 <20240410140103.37b94193@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240410140103.37b94193@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jakub,

On 10/04/2024 23:01, Jakub Kicinski wrote:
> On Wed, 10 Apr 2024 21:31:13 +0200 (GMT+02:00) Matthieu Baerts wrote:
>>> Hi Mat, is this causing skips in selftests by any chance?
>>>
>>> # 07 ....chk last_data_sent                            [SKIP] Feature probably not supported
>>> # 08 ....chk last_data_recv                            [SKIP] Feature probably not supported
>>> # 09 ....chk last_ack_recv                             [SKIP] Feature probably not supported  
>>
>> Yes it does, I should have added a note about that, sorry: that's because
>> SS needs to be patched as well to display the new counters.
>>
>> https://patchwork.kernel.org/project/mptcp/patch/fd9e850f1e00691204f1dfebc63c01c6a4318c10.1711705327.git.geliang@kernel.org/
>>
>> This patch will be sent when the kernel one will be accepted.
> 
> I see, applied locally now, thanks!

Thank you!

>> Is it an issue? The modification of the selftests can be applied later
>> if you prefer.
> 
> Not sure. If it doesn't happen super often maybe co-post the iproute2
> patch as described:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#co-posting-changes-to-user-space-components
> and I'll apply it on the worker machines manually.

I missed that. Indeed, that should be rare. We will do that next time!

>> Earlier today, I was looking at changing NIPA not to mark the whole
>> selftest as "SKIP" but I saw it was not a bug: a check is there to
>> mark everything as skipped if one subtest is marked as skipped
>> from what I understood. So I guess we don't want to change that :)
> 
> Correct :) It's working as intended :)

It can maybe be modified when we can re-use the option to parse embedded
TAP results :)

>>> I'll "hide it" from patchwork for now..
>>> --
>>> pw-bot: defer  
>>
>> Thank you! Do you prefer if I resend only patch 1/2 for now?
> 
> No need, restored the patches back, let's see if next run is clean.

Thank you! It looks like they are OK now!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


