Return-Path: <linux-kselftest+bounces-22092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBF09CDE8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 13:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443401F2353D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 12:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470531BC066;
	Fri, 15 Nov 2024 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkSS+rHH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C361BBBF1;
	Fri, 15 Nov 2024 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674639; cv=none; b=Zm3HBCt+wm6jagwwI+BN//81GJgLy2veErmUtnkBgOSfamCvZR3NzkZb7rHaCjtBLAHXsWDGCetuzpVJvakZpYaH2XUD1wLqLh7Pc5X0Ib4fUekQD3hnrcS32kwzFeR+NgWOkuryYk2AiPtJ+0lWY9bZ8GDF3P89hGFOnqzRyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674639; c=relaxed/simple;
	bh=cYX7GXi9ImnHfIdIrQUSC8K+782uWUdGRo7f+QzT8X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJcECCz4tRzKE9ZMH3CVtf+2Fa1oFKrjBzztRvAf/lyEnTlS+cSfj6+tFwsZa0Q5wMQ2yDd19pWcUY//C54he+8dNayNifaaydyjqLfjMpTROmVc1hYMmQtYdRcGKlQAQ5Z3DV8k/IbU4Pwlxj4RkjLOFly3JUbmCEgTl1jmB8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkSS+rHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0476C4CECF;
	Fri, 15 Nov 2024 12:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731674638;
	bh=cYX7GXi9ImnHfIdIrQUSC8K+782uWUdGRo7f+QzT8X0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SkSS+rHHWRMRwKmmZqyaAXSH44JgPqdeQXHGYJ23UB5wLpwBtLNu6E560HL0Ez/JG
	 pb6l24FkBQBZqDF+2W6mN4QL3ldG3wTIgCExRlyIoVDcAGYXOn6Seuo27a6DRtxvUo
	 mxO9bQyJcbVkvzUZDMCRwK2tPPsh2+KGTpLVUUsSt7wJ7/D1fktiqSX5iadNoVd43G
	 Up+OXD/us/Vq+hNtFHrDguTUqiAI8YPKC0jCTsTG65JQU27kNplWYRd6gWpJ3o6QPJ
	 HqDL+CUrlKhAqck5YXE8kWny4UOAxisC4dPyiOUG0cl88Xbsdel7dkUEdOQAF81URu
	 PpDIc1hF5EnFg==
Message-ID: <cd23ae9d-83a4-469a-b560-edcd0e94a008@kernel.org>
Date: Fri, 15 Nov 2024 13:43:29 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: LKFT CI: improving Networking selftests results when validating
 stable kernels
Content-Language: en-GB
To: Shuah Khan <skhan@linuxfoundation.org>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Linux Kernel Functional Testing <lkft@linaro.org>,
 Shuah Khan <shuah@kernel.org>,
 Kernel Selftests <linux-kselftest@vger.kernel.org>,
 Netdev <netdev@vger.kernel.org>, Linux Kernel
 <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, Ido Schimmel
 <idosch@nvidia.com>, stable@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <ff870428-6375-4125-83bd-fc960b3c109b@kernel.org>
 <eb4b9c05-66a2-4a14-b59b-37149beba3b2@linuxfoundation.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <eb4b9c05-66a2-4a14-b59b-37149beba3b2@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shuah, Greg,

Thank you for your reply!

On 13/11/2024 19:33, Shuah Khan wrote:
> On 11/8/24 11:21, Matthieu Baerts wrote:
>> Hello LKFT maintainers, CI operators,
>>
>> First, I would like to say thank you to the people behind the LKFT
>> project for validating stable kernels (and more), and including some
>> Network selftests in their tests suites.
>>
>> A lot of improvements around the networking kselftests have been done
>> this year. At the last Netconf [1], we discussed how these tests were
>> validated on stable kernels from CIs like the LKFT one, and we have some
>> suggestions to improve the situation.
>>
>>
>> KSelftests from the same version
>> --------------------------------
>>
>> According to the doc [2], kselftests should support all previous kernel
>> versions. The LKFT CI is then using the kselftests from the last stable
>> release to validate all stable versions. Even if there are good reasons
>> to do that, we would like to ask for an opt-out for this policy for the
>> networking tests: this is hard to maintain with the increased
>> complexity, hard to validate on all stable kernels before applying
>> patches, and hard to put in place in some situations. As a result, many
>> tests are failing on older kernels, and it looks like it is a lot of
>> work to support older kernels, and to maintain this.
>>
> 
> This is from the Documentation/dev-tools/kselftest.rst:
> ----
> Kselftest from mainline can be run on older stable kernels. Running tests
> from mainline offers the best coverage. Several test rings run mainline
> kselftest suite on stable releases. The reason is that when a new test
> gets added to test existing code to regression test a bug, we should be
> able to run that test on an older kernel. Hence, it is important to keep
> code that can still test an older kernel and make sure it skips the test
> gracefully on newer releases.
> ----
> 
> As it states, running tests from mainline increases the coverage when new
> tests are added to regression test an existing kernel feature in a stable
> release.
> 
> It also says that when mainline tests are running on an older kernel, the
> test should detect missing features and report skips.
> 
> The above paragraph addresses test developers and users. I would say the
> policy regarding the test development will not change. We want to keep
> it the same, continuing to take measures to skip tests when a feature
> isn't supported in the kernel the tests are running on. This addresses
> not just a kernel and test revision mismatch, but also when a feature
> isn't enabled when kernel and test revisions match.
> 
> This policy helps us find bugs in the tests failing when they should
> skip. If test rings move to a new policy, our ability to find bugs
> like this goes down.
> 
> As per users and test ring maintainers, they need to be aware of the
> reduced coverage if they revision match kernel and tests.
> Revision matching example: 6.11.8 tests on 6.11.8 stable
> 
> Greg KH and other stable maintainers can weigh in on whether they would
> like LKFT to go from running mainline tests on stable releases to
> revision matching.


I appreciate these explanations. When we discussed this subject at
Netconf, we looked at the documentation, and we understood the
advantages of running newer kselftests on older kernels. But the issue
we have is to "detect missing features and report skips": that's hard to
maintain, because it increases the code complexity, and it is hard to
validate before applying patches.

One of the reasons is that many networking selftests are validating
internal behaviours that are not exposed to the userspace. That makes it
hard to detect what behaviour to expect, and checking the kernel version
doesn't seem to be the right thing to do here. Or does it mean that
these essential tests should not validate the internal behaviours, e.g.
checking that the packets sent on the wire are formatted correctly?

A compromise could be to mark the tests checking internal behaviours,
and warn testers that they should be executed on the same version. Or
even run all the tests twice: once with the kselftests from the same
version, and once using the kselftests from the latest stable version. WDYT?


The main problem we saw when using kselftests from a newer version is
that the code coverage of many 'net' tests might even decrease over
time. In this subsystem, it is common to have "big" selftests running
many subtests. When a new feature is added, a new subtest might be added
in an existing selftest. When one subtest fails -- e.g. because the test
is not skipped on older kernels -- the whole selftest is marked as
failed. In a situation where a selftest is always failing due to one
subtest, it means people stop looking at regressions with the other
subtests. If we cannot easily predict which internal behaviour is
expected, a workaround not to reduce the code coverage is to parse
subtests, but not all selftests formats the results in an inner TAP 13
format. Both predicting the kernel behaviour, and changing the output
format look like quite a lot of work as there are hundreds of existing
selftests, with thousands of subtests.


>> Many networking tests are validating the internal behaviour that is not
>> exposed to the userspace. A typical example: some tests look at the raw
>> packets being exchanged during a test, and this behaviour can change
>> without modifying how the userspace is interacting with the kernel. The
>> kernel could expose capabilities, but that's not something that seems
>> natural to put in place for internal behaviours that are not exposed to
>> end users. Maybe workarounds could be used, e.g. looking at kernel
>> symbols, etc. Nut that doesn't always work, increase the complexity, and
>> often "false positive" issue will be noticed only after a patch hits
>> stable, and will cause a bunch of tests to be ignored.
>>
>> Regarding fixes, ideally they will come with a new or modified test that
>> can also be backported. So the coverage can continue to grow in stable
>> versions too.
>>
> 
> The assumption that new tests can be backported is incorrect. It goes
> against the stable rules. We backport fixes and not new features and
> new tests.


I'm sorry, I don't think I clearly explained what I wanted to say here:
tests validating new features are obviously not backported. On the other
hand, fixes regularly come with a regression test, and often, they are
even part of the same commit. So both the fix, and the modified / added
test are backported. It is useful to quickly validate a fix on a stable
version. Is it something that should not be done?


> Running kselftests from the same release will reduce coverage when a new
> test is added to regression test a 6.11 feature. This happens more often
> than not.
> Revision matching example: 6.11.8 tests on 6.11.8 stable


I see, then does that mean tests attached to a fix cannot be backported?
If they can, and assuming new tests are validating new features, not old
ones, then the impact should be limited, no?


>> Do you think that from the kernel v6.12 (or before?), the LKFT CI could
>> run the networking kselftests from the version that is being validated,
>> and not from a newer one? So validating the selftests from v6.12.1 on a
>> v6.12.1, and not the ones from a future v6.16.y on a v6.12.42.
>>
> 
> It is expected that there will be more skipped tests as you run tests
> from mainline on stable releases. You will see more skips on older
> stables.


Indeed, if it is possible to detect when the test should be skipped or
adapted on older kernel versions. Some tests cannot be easily adapted to
run on older kernel versions. It means they would need to be skipped
when running on older versions after having been adapted to support an
internal behaviour change, e.g. a packet being formatted differently.
That would reduce the code coverage on older kernels then.


> An alternative would be to revision match for older stables. New tests
> could be written for 6.12 which should be run on 6.11 and maybe not on
> 6.1 depending on missed coverage.


That could be an alternative indeed. When looking at the results of the
5.10 kernel for example, we can see a very high number of failures --
1/3 for the basic net tests, 2/3 in some net sub-systems -- and not many
skips. This doesn't look good.


> Before changing the current approach, it is important to understand that
> running mainline tests on stable releases increases test coverage and that
> newer tests will not be backported and that the coverage gap will increase
> overtime.

Understood.

Again, thank you for your reply!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


