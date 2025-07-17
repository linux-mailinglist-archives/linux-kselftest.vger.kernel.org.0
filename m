Return-Path: <linux-kselftest+bounces-37539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B200EB098A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3451C44C40
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3D023BD06;
	Thu, 17 Jul 2025 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwysKk9h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C949641;
	Thu, 17 Jul 2025 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752796170; cv=none; b=dkgy4qG5ZIGgnp5tRtnxXwwqRRhBbVYwqqtCX4+D6pItYxYz9qrVX34re3Ljnb4WAmCHqpexMIuB5ag9GHcCMV9uZaBQtR5667Ir0Cdpi/SW+HkYbpPwgx2F/Z8ZcEYJpZmT1xHkAvTo/tLwhrBFiGfDHErZQ1sN4BK7lAQeql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752796170; c=relaxed/simple;
	bh=Cq5Mb8Ty0pSJRETR6msxyZq2CIyD0ENwG1KIzU6IlZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJ6IPCbhJRh1B+DH2iwFbEH76Dbq4DPygsjI2EUV9G0ihnRmivqCYaHwG0h01PR/Le8dbYrbE6RXvjqqnBMLuzKdszfZ1rzOXWlCM9B5yLZ5Prs1tuTcQb/KVmv7EOTLgvZmscAn+0W04EtaGJFYEX6uMnkRm9CHgT5DTZ5kJpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwysKk9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166E5C4CEE3;
	Thu, 17 Jul 2025 23:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752796170;
	bh=Cq5Mb8Ty0pSJRETR6msxyZq2CIyD0ENwG1KIzU6IlZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IwysKk9hK55wp0s40tpFq0FJaGdXT3fBVuRsgcwTY2b4PikHBECgcX7hWobbtH02d
	 SyCaMenwQY4z2/ELRZUUX+TUOhIjqPJpP1PRz3gwWJiHdn/XuLhAK059cHIsz7yn8s
	 7g0oIm39p4AIdmaJSKba/msqYMi31gUbrh0swxnCIr9uhwHPNjwVmyn8C/j2MWeLeJ
	 R+leE+CIC862qdTM9oCLcgJK3afjaudHiWIzODec6ms5GDL+mHH8LQyjCbV53OYzqK
	 EHQERsD5FBJJneDBbOAGJLKDCac5ZJYBxnoGbTBw9Kz3Lv2yWL34hoc8+gO8rjS5J3
	 8s0lisJfycLMg==
Message-ID: <9175b633-b61f-4ca0-9023-c99dff4f53f0@kernel.org>
Date: Fri, 18 Jul 2025 01:49:24 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2 0/2] selftests: mptcp: connect: cover alt modes
Content-Language: en-GB, fr-BE
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Christoph Paasch <cpaasch@openai.com>,
 Davide Caratti <dcaratti@redhat.com>, Florian Westphal <fw@strlen.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250715-net-mptcp-sft-connect-alt-v2-0-8230ddd82454@kernel.org>
 <20250715185308.2ad30691@kernel.org> <20250716072602.386a8963@kernel.org>
 <ae6d333a-f3b2-4463-b930-b4caf56b39f8@kernel.org>
 <20250716083632.72854bd5@kernel.org>
 <e46aadbf-51c6-4e09-bdaa-374698b406f3@kernel.org>
 <20250717074242.1ef5d441@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250717074242.1ef5d441@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 17/07/2025 16:42, Jakub Kicinski wrote:
> On Wed, 16 Jul 2025 18:35:11 +0200 Matthieu Baerts wrote:
>>>> And just to be sure, no CPU or IO overload at that moment? I didn't see
>>>> such errors reported by our CI, but I can try to reproduce them locally
>>>> in different conditions.  
>>>
>>> None that I can see. The test run ~10min after all the builds completed,
>>> and we wait now for the CPU load to die down and writeback to finish
>>> before we kick off VMs. The VMs for various tests are running at that
>>> point, the CPU util averaged across cores is 66%.  
>>
>> Thank you for having checked, and for the explanations!
>>
>> OK, so maybe running stress-ng in parallel to be able to reproduce the
>> issue might not help. We will investigate.
> 
> connect tests failed again overnight. Now I see why Paolo was
> responding on Eric's series, that seems like a more likely culprit..

Good point, Paolo was certainly right, as always :)

We do need to investigate. Note that it might be hard for me to do that
the next few days as I'm travelling for work, but we are tracking the issue:

  https://github.com/multipath-tcp/mptcp_net-next/issues/574

I see that you already marked the mptcp-connect-sh selftest as ignored,
so I guess we are not causing other troubles with the CI. (We could then
also apply this series here and ignore the new tests, but it is also
fine for me to wait.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


