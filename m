Return-Path: <linux-kselftest+bounces-30411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14EFA82411
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 13:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C744A21DC
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDAD25E455;
	Wed,  9 Apr 2025 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUk1Lwcm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA4F2253E4;
	Wed,  9 Apr 2025 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199900; cv=none; b=g6JgcSiI/KLnBeC4bdERyh9lVUhWRGH9RlXoRMj3zXas46buwXxLR3kFK1kS0lGP8a23E4eNEKObQAdsnCP8fbhFLmEz+pc4xz++qdzh+NAtAmCM1jYwZvQkMXX3FtM4VV27jYGruDd/5kLnilipPXAhOuxviYHAuDLuTMQu5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199900; c=relaxed/simple;
	bh=ZX4KLllHvrC+KNh1vzkMFKHrJdydGv84kvvGARc574E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMRhBxzSJaT75S5/38bQAz5PtQdU7cAkK4Mo12c14wPusZlPRnAkfG0IoByX/vFqvermAnmA2a9KKjNhD2Z3XJEnaK51BJPzpP20MBWe7UGbPXh7Ve4bcOm/u+vFzt2im2Imv20iZPpfEU/yThH5AfDvle/CNNyiN/2oyiFNK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUk1Lwcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89605C4CEE3;
	Wed,  9 Apr 2025 11:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744199900;
	bh=ZX4KLllHvrC+KNh1vzkMFKHrJdydGv84kvvGARc574E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eUk1LwcmKFC5Vyp3+gKwd4wLpNeVG5Vz1JsnIBWTAj4wwTt/4Ylj0K2WQV3iDPAr0
	 6nd7C17YYgw7Mw3v5EgEijXqU4Sz6w/ut09bvqEDqr2E5ozWgoTm5MLOazTQOyjU+r
	 Ptua9ArLRrweafBoyIY3AA90pKlqxiYYBvFj4OiPRpSoUngzjz7OPJwYyW4NeWH3i4
	 fni/jvLeA5IjdgCcjdYtfBM2oKh5kvJJT4g9AQs8TmOAhO0lJkobF+2NoPWqLZII4b
	 eJEWW4SFSzLjwSgkaxEyq12p2By8dcitzN5nI7XMb38P6IYuFcroiYFA5wvmUniEoi
	 jWFA80yqi98Zg==
Message-ID: <3f5ff26b-9904-462e-ac22-84b5d212e9ff@kernel.org>
Date: Wed, 9 Apr 2025 13:58:13 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] configs/debug: run and debug PREEMPT
Content-Language: en-GB, fr-BE
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 paulmck@kernel.org, joel@joelfernandes.org, steven.price@arm.com,
 akpm@linux-foundation.org, anshuman.khandual@arm.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250402172305.1775226-1-sdf@fomichev.me>
 <df253016-81df-4cc9-8a8c-f92fd1cb8aea@kernel.org>
 <20250408120318.65125876@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250408120318.65125876@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 08/04/2025 21:03, Jakub Kicinski wrote:
> On Tue, 8 Apr 2025 20:18:26 +0200 Matthieu Baerts wrote:
>> On 02/04/2025 19:23, Stanislav Fomichev wrote:
>>> Recent change [0] resulted in a "BUG: using __this_cpu_read() in
>>> preemptible" splat [1]. PREEMPT kernels have additional requirements
>>> on what can and can not run with/without preemption enabled.
>>> Expose those constrains in the debug kernels.  
>>
>> Good idea to suggest this to find more bugs!
>>
>> I did some quick tests on my side with our CI, and the MPTCP selftests
>> seem to take a bit more time, but without impacting the results.
>> Hopefully, there will be no impact in slower/busy environments :)
> 
> What kind of slow down do you see? I think we get up to 50% more time
> spent in the longer tests.

That's difficult to measure in our CI because we have a majority of
tests either creating test envs with random parameters (latency, losses,
etc.), or waiting for a transfer at a limited speed to finish. Plus, we
don't control the host running our tests. But if we omit that, our
packetdrill tests take ~20% longer on the CI, and our 2 mini KUnit tests
took ~10% longer (275ms -> 305ms). Globally, our test suite took maybe
~10-20% longer, and that's acceptable.

So not 50%. Is this difference acceptable for NIPA? Even when some tests
are restarted automatically in case of instabilities?

One last thing, Stanislav's patch has been shared during Linus' merge
window: perhaps something else could also impact the time?

> Not sure how bad is too bad..

Did you observe more instabilities? Maybe the individual results should
be omitted, and only debug specific issues (calltraces, kmemleak, etc.)
should be looked at?

> I'm leaning
> towards applying this to net-next and we can see if people running
> on linux-next complain?

Good idea! But I do wonder how run **and monitor** the selftests in
linux-next with a debug kernel :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


