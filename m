Return-Path: <linux-kselftest+bounces-655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7AE7FA678
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 17:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7877D2819D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 16:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746C436B04;
	Mon, 27 Nov 2023 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emGQes6h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3CD36AF8;
	Mon, 27 Nov 2023 16:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A3BC433CA;
	Mon, 27 Nov 2023 16:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102798;
	bh=q8CjublePtfiKImqudcCE2+e+AAb9xecxB7oE7ggKsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=emGQes6h2lpreTNW1hbSkw3I9/1dl9Xkox0JGYkbPgAr3La7UCTfdMkehq989zmKB
	 SfEI/YF4/t5FG98d8VzbU+9jCi5xrEZ/ID8GiSXUgGBambtcP0pT+qLunBUUk0ncDF
	 1sshqabd5MuAIBcNJj1crGUV7r6+vnP5vR/3978Twa4WwPCDBmNv4uYfzjG2tVCZjO
	 AC0NwF/PcwG8qKPlerfDazehjOvmiDY5aT7TMPI8Y7ltu1l7tSQYMN4LRviiJHt7uI
	 R0joDf6IhX/xZfNWxEpmGSj7/rWdwaFs30P5MPFaQCMOY8LjSKeage0+orM2IvE+tv
	 psC4GkYCZ0UZw==
Message-ID: <41c542f4-c316-4a3e-aa7d-691a19c4eb0b@kernel.org>
Date: Mon, 27 Nov 2023 17:33:13 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] selftests/net: mptcp: fix uninitialized variable
 warnings
Content-Language: en-GB, fr-BE
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux-kselftest@vger.kernel.org,
 Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20231124171645.1011043-1-willemdebruijn.kernel@gmail.com>
 <20231124171645.1011043-5-willemdebruijn.kernel@gmail.com>
 <7418fa0c-c0c2-4615-ba55-f148ceb82328@kernel.org>
 <6564b9d831e24_8a1ac29498@willemb.c.googlers.com.notmuch>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
In-Reply-To: <6564b9d831e24_8a1ac29498@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/11/2023 16:46, Willem de Bruijn wrote:
> Matthieu Baerts wrote:
>> Hi Willem,
>>
>> (+ cc MPTCP list)
>>
>> On 24/11/2023 18:15, Willem de Bruijn wrote:
>>> From: Willem de Bruijn <willemb@google.com>
>>>
>>> Same init_rng() in both tests. The function reads /dev/urandom to
>>> initialize srand(). In case of failure, it falls back onto the
>>> entropy in the uninitialized variable. Not sure if this is on purpose.
>>> But failure reading urandom should be rare, so just fail hard. While
>>> at it, convert to getrandom(). Which man 4 random suggests is simpler
>>> and more robust.
>>>
>>>     mptcp_inq.c:525:6:
>>>     mptcp_connect.c:1131:6:
>>>
>>>     error: variable 'foo' is used uninitialized
>>>     whenever 'if' condition is false
>>>     [-Werror,-Wsometimes-uninitialized]
>>
>> Thank you for the patch!
>>
>> It looks good to me:
>>
>> Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
>>
>>> Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
>>> Fixes: b51880568f20 ("selftests: mptcp: add inq test case")
>>> Cc: Florian Westphal <fw@strlen.de>
>>> Signed-off-by: Willem de Bruijn <willemb@google.com>
>>>
>>> ----
>>>
>>> When input is randomized because this is expected to meaningfully
>>> explore edge cases, should we also add
>>> 1. logging the random seed to stdout and
>>> 2. adding a command line argument to replay from a specific seed
>>> I can do this in net-next, if authors find it useful in this case.
>>
>> I think we should have done that from the beginning, otherwise we cannot
>> easily reproduce these edge cases. To be honest, I don't think this
>> technique helped to find bugs, and it was probably used here as a good
>> habit to increase the coverage. But on the other hand, we might not
>> realise some inputs are randomised and can cause instabilities in the
>> tests because we don't print anything about that.
>>
>> So I would say that the minimal thing to do is to log the random seed.
>> But it might not be that easy to do, for example 'mptcp_connect' is used
>> a lot of time by the .sh scripts: printing this seed number each time
>> 'mptcp_connect' is started will "flood" the logs. Maybe we should only
>> print that at the end, in case of errors: e.g. in xerror() and
>> die_perror() for example, but I see 'exit(1)' is directly used in other
>> places...
>>
>> That's more code to change, but if it is still OK for you to do that,
>> please also note that you will need to log this to stderr: mptcp_connect
>> prints what has been received from the other peer to stdout.
>>
>> Because it is more than just adding a 'printf()', I just created a
>> ticket in our bug tracker, so anybody can look at that and check all the
>> details about that:
>>
>> https://github.com/multipath-tcp/mptcp_net-next/issues/462
> 
> Thanks for the detailed feedback, Matthieu!
> 
> Another option to avoid flooding the logs might be to choose a pseudo
> random number in the script and pass the explicit value mptcp_connect.

Good idea!

If I understood correctly, from the .c file, we can check if an env var
is set (e.g. `MPTCP_RND_SEED`) and use it. If not, we generate a random
one like before. The .sh scripts should generate a random number if the
env var is not already set. In any case, this seed should be printed by
the scripts.

> I haven't looked closely, but for transport layer tests it is likely
> that the payload is entirely ignored. Bar perhaps checksum coverage.
> If it does not increase code coverage, randomization can also just be
> turned off.

Here the randomisation is used to change the length of the data that are
exchanged or to do some actions in different orders. I think it still
makes sense to have randomisation. But in case of issues around that, it
might not be clear what the userspace was exactly doing. That's what can
be improved later in net-next.

Cheers,
Matt

