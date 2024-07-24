Return-Path: <linux-kselftest+bounces-14141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB6193ADE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 10:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A2C28304D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 08:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BC414B08C;
	Wed, 24 Jul 2024 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSqG3o5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0DBAD23;
	Wed, 24 Jul 2024 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721809489; cv=none; b=Sx56vzIk5p4xcHAliwbpzlMb3OghtZ8mTzhkWn9V5B3KZmtrZMTDbITR1eR6S5vfui4P+Eyk0Ya2eYU9Mj6Bjd30HmNiezegDKVrmsykf7zZTE1/bv9mTMd376EfAGgVgTEX7sXLjr/7tXk1s1AAAe6kvrF2twf9R8LoFrMiCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721809489; c=relaxed/simple;
	bh=HiGKmXRe4u6JuGpziWw1IAJIcZn0wakFfLZ3cyEgqJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GV/DF4wbzMZUHgnowxcRvmXiRwGkYuUfq8VbXhXizVN/8PJLO/Q1jRlQLaV3trwPs0d4sej0hjS+1vDDGckCHJSSyv9wtt438u+B0dHLWRd9hg0v2DusU/3YjX9eDMU23+69OM3ZrtbY6tf77DYmbjESqZ0NtFaQ/6/eBwVeY1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSqG3o5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9375FC32782;
	Wed, 24 Jul 2024 08:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721809489;
	bh=HiGKmXRe4u6JuGpziWw1IAJIcZn0wakFfLZ3cyEgqJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hSqG3o5I8vPPUDpmEkImH2WFIMTfajyKfbNxlFTFah7WDiSavAos8wG1DO42lCY9e
	 cWqKwfIxVHMOIXg2NsrM7XFvLNLDOonpAm+pq39WmSGzT9y5eBHOuB+CaqCzfUKa7m
	 mh8qDljeVqCGCAh7YIygJXmocACPLyIcYrCCjW2Jt0z6abG5K2tB8yG/JCK7gb6C0f
	 HXFQTBsAQwtGcAntT/TymK8Kqy864ETtXfolMon+4r5EJL5xSJgFMTUFJdCdQ0KKxG
	 A5QNCd/iOUP4PplqHm5DoXNzCZzsvNemSBUD0laP55Cgn7lschAib7t5Jc3TckybbO
	 JMQG7N6UX2cKQ==
Message-ID: <684fd6c2-ad54-4479-8a6a-ab3270e558a7@kernel.org>
Date: Wed, 24 Jul 2024 10:24:40 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Add mptcp pm_nl_ctl link
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Geliang Tang <tanggeliang@kylinos.cn>,
 mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-0-ebdc2d494049@kernel.org>
 <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-2-ebdc2d494049@kernel.org>
 <08f925cd-e267-4a6b-84b1-792515c4e199@kernel.org>
 <90e916e8-ec4e-447b-8ee6-eb247f3a72ad@linux.dev>
 <ab8112e6-ea7b-4b36-b395-049214e1608d@kernel.org>
 <780ed38257480940def86947b2ee354f298e890b.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <780ed38257480940def86947b2ee354f298e890b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for your reply!

On 24/07/2024 09:42, Geliang Tang wrote:
> Hi Matt,
> 
> On Sat, 2024-07-06 at 02:25 +0200, Matthieu Baerts wrote:
>> Hi Martin,
>>
>> Thank you for your reply!
>>
>> On 06/07/2024 01:10, Martin KaFai Lau wrote:
>>> On 7/4/24 3:48 AM, Matthieu Baerts wrote:
>>>>> diff --git a/tools/testing/selftests/bpf/Makefile
>>>>> b/tools/testing/
>>>>> selftests/bpf/Makefile
>>>>> index e0b3887b3d2d..204269d0b5b8 100644
>>>>> --- a/tools/testing/selftests/bpf/Makefile
>>>>> +++ b/tools/testing/selftests/bpf/Makefile
>>>>> @@ -144,7 +144,7 @@ TEST_GEN_PROGS_EXTENDED =
>>>>> test_skb_cgroup_id_user \
>>>>>       flow_dissector_load test_flow_dissector
>>>>> test_tcp_check_syncookie_user \
>>>>>       test_lirc_mode2_user xdping test_cpp runqslower bench
>>>>> bpf_testmod.ko \
>>>>>       xskxceiver xdp_redirect_multi xdp_synproxy veristat
>>>>> xdp_hw_metadata \
>>>>> -    xdp_features bpf_test_no_cfi.ko
>>>>> +    xdp_features bpf_test_no_cfi.ko mptcp_pm_nl_ctl
>>>> On the BPF CI, we have such errors:
>>>>
>>>>     mptcp_pm_nl_ctl.c:20:10: fatal error: 'linux/mptcp.h' file
>>>> not found
>>>>       20 | #include "linux/mptcp.h"
>>>>          |          ^~~~~~~~~~~~~~~
>>>>
>>>> On my side, I don't have any issue, because the compiler uses the
>>>> mptcp.h file from the system: /usr/include/linux/mptcp.h
>>>>
>>>> I suppose that's not OK on the BPF CI, as it looks like it
>>>> doesn't have
>>>> this file there, probably because it still uses Ubuntu 20.04 as
>>>> base,
>>>> which doesn't include this file in the linux-libc-dev package.
>>>>
>>>> When I look at how this 'mptcp_pm_nl_ctl' tool -- and all the
>>>> other
>>>> programs from that list -- is compiled (V=1), I see that the
>>>> following
>>>> "-I" options are given:
>>>>
>>>>    -I${PWD}/tools/testing/selftests/bpf
>>>>    -I${BUILD}//tools/include
>>>>    -I${BUILD}/include/generated
>>>>    -I${PWD}/tools/lib
>>>>    -I${PWD}/tools/include
>>>>    -I${PWD}/tools/include/uapi
>>>>    -I${BUILD}/
>>>>
>>>> It will then not look at -I${PWD}/usr/include or the directory
>>>> generated
>>>> with:
>>>>
>>>>    make headers_install INSTALL_HDR_PATH=(...)
>>>
>>> It sounds like the tools/testing/selftests/net/mptcp/Makefile is
>>> looking
>>> at this include path, so it works?
>>
>> Yes it does work.
>>
>>> iiu the bpf/Makefile correctly, it has the bpftool "make" compiled
>>> and
>>> installed at tools/testing/selftests/bpf/tools/sbin/. May be
>>> directly
>>> compile the pm_nl_ctl by "make tools/testing/selftests/net/mptcp/"?
>>
>> That could be an alternative, I didn't know it would be OK to add
>> such
>> dependence, good idea.
>>
>>>> I guess that's why people have duplicated files in
>>>> 'tools/include/uapi',
>>>> but I also understood from Jakub that it is not a good idea to
>>>> continue
>>>> to do so.
>>>>
>>>> What would be the best solution to avoid a copy? A symlink still
>>>> looks
>>>> like a workaround.
>>>>
>>>> In the other selftests, KHDR_INCLUDES is used to be able to
>>>> include the
>>>> path containing the UAPI headers. So if someone built the headers
>>>> in a
>>>
>>> Meaning KHDR_INCLUDES should be used and -
>>> I${PWD}/tools/include/uapi can
>>> be retired?
>>
>> That's the idea, yes, for "userspace programs". I mean: for BPF
>> programs
>> requiring vmlinux.h (BPF_CFLAGS), I guess you will still need the
>> bpf.h
>> file from tools/include/uapi, no?
>>
>>> I haven't looked into the details. I quickly tried but it
>>> fails in my environment.
>>
>> Do you not have issues because some files have something like:
>>
>>   #include <uapi/linux/(...).h>
>>
>> On my side, I had a working version using this patch:
>>
>>> diff --git a/tools/testing/selftests/bpf/Makefile
>>> b/tools/testing/selftests/bpf/Makefile
>>> index 7c5827d20c2e..112f14d40852 100644
>>> --- a/tools/testing/selftests/bpf/Makefile
>>> +++ b/tools/testing/selftests/bpf/Makefile
>>> @@ -37,7 +37,7 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic            \
>>>           -Wall -Werror -fno-omit-frame-pointer                  \
>>>           $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)             \
>>>           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)   \
>>> -         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
>>> +         -I$(TOOLSINCDIR) $(KHDR_INCLUDES) -I$(OUTPUT)
>>>  LDFLAGS += $(SAN_LDFLAGS)
>>>  LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
>>>  
>>
>> But only after having removed these extra 'uapi/':
>>
>>   $ git grep -l '<uapi/' -- tools/testing/selftests/bpf | \
>>     xargs sed -i 's|#include <uapi/|#include <|g'
>>
>> Is it not OK for you like that?
>>
>> Note that I built the selftests using KHDR_INCLUDES=-
>> I$INSTALL_HDR_PATH.
> 
> Do you need me to do anything here? This patchset seems to have been
> waiting for several months.

Sorry, I was not sure my suggestion here above was OK for Martin and
other BPF maintainers. Maybe sending a proper patch implementing these
modifications would be easier?

> Another option is to roll back to v2, not add this mptcp_pm_nl_ctl
> tool, and continue to use "ip mptcp". I remember mentioning in the
> comments of v2 that BPF CI systems will also be upgraded to new Ubuntu
> system and iproute2 in the future. At this time now we can make a check
> for "ip mptcp" and only run this test on systems that support "ip
> mptcp", and skip the test with test__skip() for systems that do not
> support it, so that CI can also pass.

I think it would be good to get rid of some duplicated header files, but
well, that's not directly linked to the new test we want to add, it is
more something to ease the maintenance of these duplicated files.

Then yes, it might be good to skip the test if "ip mptcp" is not supported.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


