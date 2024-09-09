Return-Path: <linux-kselftest+bounces-17492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DD7971006
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D935281C3C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960111AF4D9;
	Mon,  9 Sep 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGmeoG3C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF5D1AE04F;
	Mon,  9 Sep 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867746; cv=none; b=MAGT5n/XLrFRe8e5j/lJXjG2o9ccACnzRhMTmfn/NnDqqsKcDtLMIxftxZMiT1HDRmPTkNGdjGMYMqKnnh0vEiL7l9GM+rEjc1xqg7CSyxs/4HcVZVHMbqkWCsdock64lYYs1Fi+MRBsQdII/DDJt6awWcW6ROzn751gsS+a6P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867746; c=relaxed/simple;
	bh=xcamMNxtybh5ZuQ7ofBTfp4eeavywAS95bgdXjdRys0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZWwvUePV8O0VHcciHS7WSpmFNQpQQNjqDNwE4HrI1ANGJhU3ccgz/zNYfCahTzvJ+zH7V3Zcvb60EMBTmMo4RyO88X+pacEzNuMp5R5zx+EMDsjA6EMkbGyDtusXz/x3tBQgKQsgCm4jF12Y+jULPh4M+ATmxYyYTKo7ebUR8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGmeoG3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B6DC4CEC8;
	Mon,  9 Sep 2024 07:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725867746;
	bh=xcamMNxtybh5ZuQ7ofBTfp4eeavywAS95bgdXjdRys0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rGmeoG3CrNIulcBH/7B5vUo/sVbY7Z4VyKYlBREy17sKBUDaBXuKCGjXjKCkwGVvg
	 RfyLmM+o4SZ2lSx44Hdg376Owl/440+seMTDArYgQwpd7o7KR+UY22NxgDDVuGst7A
	 6gdyNMJ1kNJFy6xHxpSR8yyCFLTmpqTvocev7BgrYGZcOsDC0xfs7zR9UCeEzx/frm
	 rMLf129wRMJNDXN9Xn6DVZuKfonQkJ1kwCcvLTj1goeQIe4rTxC/t65qsWonKzR9tV
	 XpR3BgEvmkcLDDLnYTrS8F0RxFVf6lXNJ6gaI3cjCtCjcX9YB2WvK6eM5mghDu07NN
	 Yvj09l5srty5Q==
Message-ID: <f5c79fd4-d317-4227-a3ca-05cf5e683cad@kernel.org>
Date: Mon, 9 Sep 2024 09:42:21 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v2 2/2] selftests/net: integrate packetdrill with
 ksft
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ncardwell@google.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, fw@strlen.de,
 Willem de Bruijn <willemb@google.com>
References: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
 <20240905231653.2427327-3-willemdebruijn.kernel@gmail.com>
 <f63e7367-c4fb-4cdc-a44c-6accbc309c5a@kernel.org>
 <66db217a558c4_29a385294d3@willemb.c.googlers.com.notmuch>
 <ad780c53-9538-4d3f-a02f-1063828fc035@kernel.org>
 <66db9008e0b4e_2a33ef29428@willemb.c.googlers.com.notmuch>
 <20240906170456.5a113628@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240906170456.5a113628@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 07/09/2024 02:04, Jakub Kicinski wrote:
> On Fri, 06 Sep 2024 19:28:08 -0400 Willem de Bruijn wrote:
>>>> No, we opted for this design exactly to use existing kselftest infra,
>>>> rather than reimplementing that in our wrapper, as I did in the RFC.  
>>>
>>> OK, I understood from the discussions from the RFC that by using the
>>> kselftest infra, the tests would be automatically executed in dedicated
>>> netns, and it could also help running tests in parallel. That sounded
>>> great to me, but that's not the case by default from what I see.  
>>
>> Perhaps that's something to change in the defaults for run_tests.
>>
>> Since the infra exist, that is preferable over reimplementing it for
>> one particular subset of tests.
>>
>> Or if not all kselftests can run in netns (quite likely), this needs
>> to be opt-in. Then a variable defined in the Makefile perhaps. To
>> tell kselftest to enable the feature for this target.
> 
> Indeed, I was thinking along the same lines.

Yes, I was also thinking about a variable defined in the Makefile.

Because I suppose this variable will not be added in this cycle, and if
a v3 is planned, would it be OK to simply prefix the 'packetdrill'
commands with "unshare -n"? That would be similar to what is already
done in Netfilter, and it prevents messing up with other tests/host
settings?

> We're closing net-next in a week, it'd be great to have the baseline
> ksft interpreter mechanism in place in the next couple of days. 
> The exact implementation of packetdrill/ksft_runner.sh can be changed
> later as needed, and the current one works fine for NIPA.

It is fine for me if the v2 is applied. The suggested modifications were
small, not blocking, fixes can be sent after (or could be ignored if
preferred).

> Hopefully we can also discuss at LPC/netconf what to do about libraries
> (where setup / cleanup code could live).

Good idea!

> Looking at MPTCP tests - do
> they work out of tree? I see mptcp_lib.sh does:
> 
> . "$(dirname "${0}")/../lib.sh"
> . "$(dirname "${0}")/../net_helper.sh"
> 
> but lib/sh and net_helper.sh are not listed in the Makefile. So they
> won't get packaged...

Indeed, I noticed that when I reviewed Willem's series. It's only
recently that we started to use these files. I already fixed these two
on my side, I will share patches later after some testing.

> We should make sure we support running the tests with make run_tests
> and in installed mode. 
> 
> If we agree that the current situation with support for library code is
> far from ideal, I think we have three(ish) directions to explore:
> 
>  1  build netns handling into runner.sh
>    + already mostly there
>    + simpler tests, no need to worry about netns, it just happens
>    - not all tests need netns (HW-adjacent tests especially)
>    - netns setup is the main thing we need but not the only thing,
>      wait helpers, python code, etc. also need to be handled

Indeed, almost there. 'unshare' could also be used in runner.sh to
simplify things.

Please note that for some tests, multiple netns are needed, e.g. to
split the client and the server (and routers) in different netns. I
don't think such setups should be handled by runner.sh.

If the use of a dedicated netns is triggered by a variable in the
Makefile, it also means that all tests listed in this Makefile should
work the same way, which is not always the case.

On the other hand, creating the netns is not difficult, even easier with
the helper from lib.sh, and 'unshare -n' might be enough for simple cases.

>  2a improve library bundling at the ksft level
>    + we already have a net/lib "meta-target", it kinda works
>    + hopefully in a way that lets us Python
>    - no idea how

If the idea is only to launch tests in a dedicated netns, can we not
change the shebang to launch the test script with:

  unshare (...) <interpreter>

>  2b put all the code in kselftest/, like ktap_helpers.sh ?
>    + easy to do
>    + helps other subsystems
>    - could cause git conflicts

For me, that would be great to share more helpers between subsystems,
but that looks difficult from a maintenance point of view.

>    - won't help Python?
> 
>  3  give up on target proliferation; on a quick count we have 15 targets
>     in ksft for various bits of networking, faaar more than anyone else
>    + fewer targets limits the need for libraries, libraries local to
>      the target are trivial to handle
>    - ksft has no other form of "grouping" tests, if we collapse into 
>      a small number of targets it will be hard to run a group of tests

It is good to have targets, to easily run a group of tests related to a
modification that has just been done, and to limit the size of the
required kernel config, etc. Probably easier to have different libs per
target/subsystem, and when something can be re-used elsewhere, it can be
extracted to a more generic lib maybe?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


