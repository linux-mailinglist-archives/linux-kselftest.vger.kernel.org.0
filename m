Return-Path: <linux-kselftest+bounces-17525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB63971C33
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 16:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956D91F234FE
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1475A1B9B57;
	Mon,  9 Sep 2024 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4so0DLY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE71B5811;
	Mon,  9 Sep 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891288; cv=none; b=nGu/J/qPtutN/It/Rt3FCs4wWEI4V2RjTzA3StsY3j+3r5pMx0qGwrhfDQxZbpt8Z1bC7VxpTFo4tKW4sM3hXmVi6DmizkLAWX23z3hUukfQcKCCeQiVt0BGe6bjDNIo5HcEMqv7LqBjjT33NHpO1txtvGn/4pk1I6RcyPBGG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891288; c=relaxed/simple;
	bh=yK9KZsh6yF6/uKglFU3dnVEhOn7vpDrb6npAFcZoM8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByR5jrvdJExpJuFYgNV+6Vbr3an4Ok3pyonwuBuzH7IbHTWPjt/9GJFzR0JpN54v+7Su8fFLW9H9sD5pythElGDPkpJIGEM2PbI+J0MKkuhOJ6rwa/kVxm6mVCcU//YV84IPzQAeArZF+NcviVzswCPckKB9tprvMHyK2+umpbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4so0DLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FDBC4CEC5;
	Mon,  9 Sep 2024 14:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725891287;
	bh=yK9KZsh6yF6/uKglFU3dnVEhOn7vpDrb6npAFcZoM8c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p4so0DLYMi1TSlGQvskIEIAQZ6yPVszXKODjV4YNP+7ghtLmdRxDW4WDXU0g7P3/P
	 /nvV82pMbDWY+12tnN2quo32LP1PvN9kTApQCrv1DTDlHvV+NHZmxF7y193oAhW7/5
	 0m/QjlUsETxSwFlLKyaUe3QhcksIjntSzuRPW8rCUQ09bTDRLhNvKUcpc8/2RDtQ7m
	 qR+Dfv7TQRzKIwtqR+xnQk57op6VzN7bk93X67byKjv1v8VmJVhYmlbWGzvzkyCK8v
	 2MYGdZvMwzZtVIQc57JwjUIkF2BWypBaDtuuOnYWBHd5Zo9AF4mzhtzNduXPrD7RZ1
	 /qbVkomoO6lSA==
Message-ID: <e8285b8c-1fed-4f36-b63b-bf3323739d59@kernel.org>
Date: Mon, 9 Sep 2024 16:14:42 +0200
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
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
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
 <f5c79fd4-d317-4227-a3ca-05cf5e683cad@kernel.org>
 <66def4d595d4_320b62942a@willemb.c.googlers.com.notmuch>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <66def4d595d4_320b62942a@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Willem,

On 09/09/2024 15:15, Willem de Bruijn wrote:
> Matthieu Baerts wrote:
>> Hi Jakub,
>>
>> On 07/09/2024 02:04, Jakub Kicinski wrote:
>>> On Fri, 06 Sep 2024 19:28:08 -0400 Willem de Bruijn wrote:
>>>>>> No, we opted for this design exactly to use existing kselftest infra,
>>>>>> rather than reimplementing that in our wrapper, as I did in the RFC.  
>>>>>
>>>>> OK, I understood from the discussions from the RFC that by using the
>>>>> kselftest infra, the tests would be automatically executed in dedicated
>>>>> netns, and it could also help running tests in parallel. That sounded
>>>>> great to me, but that's not the case by default from what I see.  
>>>>
>>>> Perhaps that's something to change in the defaults for run_tests.
>>>>
>>>> Since the infra exist, that is preferable over reimplementing it for
>>>> one particular subset of tests.
>>>>
>>>> Or if not all kselftests can run in netns (quite likely), this needs
>>>> to be opt-in. Then a variable defined in the Makefile perhaps. To
>>>> tell kselftest to enable the feature for this target.
>>>
>>> Indeed, I was thinking along the same lines.
>>
>> Yes, I was also thinking about a variable defined in the Makefile.
>>
>> Because I suppose this variable will not be added in this cycle, and if
>> a v3 is planned, would it be OK to simply prefix the 'packetdrill'
>> commands with "unshare -n"? That would be similar to what is already
>> done in Netfilter, and it prevents messing up with other tests/host
>> settings?
> 
> Each target is built and booted separately, right?

From what I see, on NIPA, there are two executors dedicated to
packetdrill: one with and one without a debug kernel config. Each of
them is running in a dedicated VM.

So yes, on NIPA, we are safe.

But someone could run these packetdrill tests on a test machine
manually, then switch to something else and have unexpected behaviours.

> These three initial tests share set_defaults.sh, so in practice this
> should be fine. Most importantly, not affecting any tests outside
> net/packetdrill.
> 
> But agreed that netns are needed before adding more.
> 
> The unshare approach sounds fine to me. Easier than to plumb a Makefile
> variable through to the standalone run_kselftest.sh.

Yes, easier indeed.

>>>  3  give up on target proliferation; on a quick count we have 15 targets
>>>     in ksft for various bits of networking, faaar more than anyone else
>>>    + fewer targets limits the need for libraries, libraries local to
>>>      the target are trivial to handle
>>>    - ksft has no other form of "grouping" tests, if we collapse into 
>>>      a small number of targets it will be hard to run a group of tests
>>
>> It is good to have targets, to easily run a group of tests related to a
>> modification that has just been done, and to limit the size of the
>> required kernel config, etc. Probably easier to have different libs per
>> target/subsystem, and when something can be re-used elsewhere, it can be
>> extracted to a more generic lib maybe?
> 
> The conflicting CONFIGs between targets could be an issue. Even with
> packetdrill I had to check HZ and saw a difference with net/bpf.

If some kernel configs are conflicting, it might be needed to add a
check in ksft_runner.sh, because I know some CIs like LKFT build the
kernel once mixing different kernel config files, then run the different
targets on different VMs.

But maybe it is not needed to consider this case, and just adding
CONFIG_HZ_100=y in the config file is enough.

> That said, there could probably be a way to select tests between
> -c (collection/target) and -t (individual test) that uses a wildcard.

There are probably too many ways to run the selftests: personally, I
never use run_kselftest.sh. Either I use 'make run_tests' to run all
tests, or, when I need to check one specific selftest, I often directly
execute the script manually, instead of dealing with the kselftest
infrastructure. In this case, I can also simply use a for-loop using a
wildcard in bash to execute all the tests I want.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


