Return-Path: <linux-kselftest+bounces-17406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F78596F942
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 18:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC67B2127F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2731D362E;
	Fri,  6 Sep 2024 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGhAxuVK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F04779F;
	Fri,  6 Sep 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640021; cv=none; b=QsTTxzbZ2h7hgbZd9XnX8Rc8YEx0yp4M/Dbf444F4vS4IOChkQgenJFvCx/lOvRIlHl8XNY+9gTPv17WrzJssCYb6GMiqiyi7fM7+B7XLAWOfNuIUhlDFx9mw3gWdFTz+46zpmtRlqEZZb5HwMlYEkI4UPFPx5wYkDnhQCaS9Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640021; c=relaxed/simple;
	bh=EGU+w5p35sCdk4jKzSjSqwb1uZuue7YtGopK42QMXyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGDt/aU9jS922YNs84dnshKrwbD8Wbf6KepWxKFt1UFNRYG/JmGCgnqgkkeruTCnFAhzTVOiX7TpWBfKAC6wyzN5s+xBn9hBOSdGRmrSdWwtlzH/xwJVcq361QcSFDqM44ocKAg8YtxX7vQmIzzNEUcDtlQ2NvgyDPpCxkts8Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGhAxuVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F60C4CEC4;
	Fri,  6 Sep 2024 16:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725640020;
	bh=EGU+w5p35sCdk4jKzSjSqwb1uZuue7YtGopK42QMXyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IGhAxuVKEDGIKATyvtPmM43z1GumHjh07sY9StOplpQmwhtP77Mh/Azu15JvM1r9N
	 tosiVuQT3klLE4ACN2j9q/W2dciIAYgg2j24RlfpzkInK61gcft64hd/qIUp4DRAi8
	 oIANDjdUq5qbED1wcEmFBZ+WicAu3AZnObfzSGvJEF/EBxv6do2s/XJdzdVTp1zreS
	 qvhB61p8DQCQ5Mqgc2feIAeYPLMHAiL9vv7zYaclBkMX68Q+QH/WtIcwRQoLW5If6m
	 8UPQDBBmhSN1baUWL8GPyZtwsVhKtmb09cOY7huHXLscpgDztcvKJhMtH41Zc89Qe9
	 F9//Ppg7qFkKw==
Message-ID: <ad780c53-9538-4d3f-a02f-1063828fc035@kernel.org>
Date: Fri, 6 Sep 2024 18:26:55 +0200
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
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ncardwell@google.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, fw@strlen.de,
 Willem de Bruijn <willemb@google.com>
References: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
 <20240905231653.2427327-3-willemdebruijn.kernel@gmail.com>
 <f63e7367-c4fb-4cdc-a44c-6accbc309c5a@kernel.org>
 <66db217a558c4_29a385294d3@willemb.c.googlers.com.notmuch>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <66db217a558c4_29a385294d3@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/09/2024 17:36, Willem de Bruijn wrote:
> Matthieu Baerts wrote:
>> Hi Willem,
>>
>> On 06/09/2024 01:15, Willem de Bruijn wrote:
>>> From: Willem de Bruijn <willemb@google.com>
>>>
>>> Lay the groundwork to import into kselftests the over 150 packetdrill
>>> TCP/IP conformance tests on github.com/google/packetdrill.
>>>
>>> Florian recently added support for packetdrill tests in nf_conntrack,
>>> in commit a8a388c2aae49 ("selftests: netfilter: add packetdrill based
>>> conntrack tests").
>>>
>>> This patch takes a slightly different approach. It relies on
>>> ksft_runner.sh to run every *.pkt file in the directory.
>>
>> Thank you for adding this support! I'm looking forward to seeing more
>> packetdrill tests being validated by the CI, and I hope that will
>> encourage people to add more tests, and increase the code coverage!
> 
> Thanks for taking a look and your feedback.

You are welcome!

>> I have some questions about how the packetdrill should be executed:
>> should they be isolated in dedicated netns?
> 
> Yes. The runner decides that, by passing -n 

But then it means that by default, the tests are not isolated. I think
many (most?) selftests are running in a dedicated netns by default, no?

To be honest, that's the first time I hear about:

  ./run_kselftest.sh --netns

I don't know if it is common to use it, nor if we can enable this
feature when using 'make run_tests'. And I don't know if many CI runs
multiple selftests in parallel from the same VM.

>> There are some other comments, but feel free to ignore them if they are
>> not relevant, or if they can be fixed later.
>>
>>> Tested:
>>> 	make -C tools/testing/selftests \
>>> 	  TARGETS=net/packetdrill \
>>> 	  run_tests
>>
>> Please note that this will not run the packetdrill tests in a dedicated
>> netns. I don't think that's a good idea. Especially when sysctl knobs
>> are being changed during the tests, and more.
>>
>>> 	make -C tools/testing/selftests \
>>> 	  TARGETS=net/packetdrill \
>>> 	  install INSTALL_PATH=$KSFT_INSTALL_PATH
>>>
>>> 	# in virtme-ng
>>> 	./run_kselftest.sh -c net/packetdrill
>>> 	./run_kselftest.sh -t net/packetdrill:tcp_inq_client.pkt
>>
>> I see that ./run_kselftest.sh can be executed with the "-n | --netns"
>> option to run each test in a dedicated net namespace, but it doesn't
>> seem to work:
>>
>>> # ./run_kselftest.sh -n -c net/packetdrill
>>> [  411.087208] kselftest: Running tests in net/packetdrill
>>> TAP version 13
>>> 1..3
>>> Cannot open network namespace "tcp_inq_client.pkt-TaQ8iN": No such file or directory
>>> setting the network namespace "tcp_inq_server.pkt-sW8YCz" failed: Invalid argument
>>> Cannot open network namespace "tcp_md5_md5-only-on-client-ack.pkt-YzJal6": No such file or directory
> 
> Ah, I guess this requires adding CONFIG_NET_NS=y to
> tools/testing/selftests/net/packetdrill/config

Good point. But I have CONFIG_NET_NS=y on my side. I didn't investigate
more, I was first wondering if other people tried this option.

>> But maybe it would be better to create the netns in ksft_runner.sh?
>> Please see below.
> 
> No, we opted for this design exactly to use existing kselftest infra,
> rather than reimplementing that in our wrapper, as I did in the RFC.

OK, I understood from the discussions from the RFC that by using the
kselftest infra, the tests would be automatically executed in dedicated
netns, and it could also help running tests in parallel. That sounded
great to me, but that's not the case by default from what I see.

>> (...)
>>
>>> diff --git a/tools/testing/selftests/net/packetdrill/defaults.sh b/tools/testing/selftests/net/packetdrill/defaults.sh
>>> new file mode 100755
>>> index 0000000000000..1095a7b22f44d
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/net/packetdrill/defaults.sh
>>> @@ -0,0 +1,63 @@
>>> +#!/bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +#
>>> +# Set standard production config values that relate to TCP behavior.
>>> +
>>> +# Flush old cached data (fastopen cookies).
>>> +ip tcp_metrics flush all > /dev/null 2>&1
>>
>> (Why ignoring errors if any?)
> 
> I don't know. Just importing this verbatim from github.
> As that is debugged over a long time and proven to work.

All good, I'm fine like that.

(...)

>>> diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
>>> new file mode 100755
>>> index 0000000000000..2f62caccbbbc5
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
>>> @@ -0,0 +1,41 @@

(...)

>>> +packetdrill ${ipv4_args[@]} $(basename $script) > /dev/null \
>>
>> (Why muting stdout? I see that the TCP MD5 test output lines from
>> /proc/net/tcp*, is it why? Is this info useful? Or should it be removed
>> from the test?)
> 
> Indeed that's why. If a test fails in automated testing we can run
> manually to inspect such output.

If we can reproduce the issue :)

Or maybe it is not an issue to store such output in the logs?

But if you tell me that this output has never been helpful in the past,
it is fine for me to mute it, not to have to modify the tests.

>>> +	&& ktap_test_pass "ipv4" || ktap_test_fail "ipv4"
>>> +packetdrill ${ipv6_args[@]} $(basename $script) > /dev/null \
>>> +	&& ktap_test_pass "ipv6" || ktap_test_fail "ipv6"
>>
>> Even if "run_kselftest.sh" creates dedicated netns before running this
>> script (RUN_IN_NETNS=1), it looks like the tests in v4 and in v6 will
>> share the same netns. Is it OK? It means that if a packetdrill test sets
>> something that is not reset by 'defaults.sh', it might break the
>> following v6 test.
> 
> That should be fine. If a test cares about a sysctl, then it needs to
> set it at the start. In this case, they both will set exactly the same
> anyway.

Ack.

>> Why not having "ksft_runner.sh" creating the netns? It should be easy to
>> do so, using helpers from the "../lib.sh" file:
> 
> See above.

Before the discussions from the RFC, I initially thought that the
selftest itself had to deal with the netns. But then I understood there
was a possibility to force the kselftest infra to execute the different
tests in a dedicated netns. To be honest, it is not clear to me who
should be in charge of creating these netns :)

Maybe that's fine like that then, but it feels strange to me not to have
such isolation :)

In Florian's version, the packetdrill tests are executed in a dedicated
netns using 'unshare -n'. That's an easier alternative than the one I
suggested in my previous email with setup_ns.

(...)

>>> diff --git a/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt b/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
>>> new file mode 100644
>>> index 0000000000000..df49c67645ac8
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
>>> @@ -0,0 +1,51 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +// Test TCP_INQ and TCP_CM_INQ on the client side.
>>> +`./defaults.sh
>>> +`
>> (I guess you prefer not to modify these tests, and keep them
>> self-contained, but just in case it is easier for you, this line could
>> be removed, and have ksft_runner.sh sourcing this file before executing
>> the packetdrill test.)
> 
> Future packetdrill tests can have different shell preambles. Let's
> indeed leave it to the tests themselves.

It makes sense.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


