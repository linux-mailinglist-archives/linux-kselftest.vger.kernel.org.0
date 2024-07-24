Return-Path: <linux-kselftest+bounces-14179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3A693B7AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 21:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB1DB245D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1C416C6AC;
	Wed, 24 Jul 2024 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H6J9pa23"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D8515ECEA
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721850478; cv=none; b=az3ktWL7TEviH6CAE2SwVnmSAC1f7C0+liNHj5EITZPZgDEGmNSIbeOIVv7FwamnvOTNrxl20t8PITbBMWjVj/BwH5WcewN2fpUlGkLTsBzeC4PayOfyYGm+rCNKXkEf1N5GfYzCz9EXqntyyl22Ju1ruM9fV2h7AZnG7qTsiT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721850478; c=relaxed/simple;
	bh=k6FwyC2TQEGHr4zuRg4goZTUWzjhVQKmKTKmITDQEuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNIShXouvZFMByVfo7PaJpiuc+FlOScn0c4XsrHp5HXdSw+DsNgyUgns/Yn/Dd1TFILYir2NcEXC/MdicHCA8VbRIlwCz06FH7OVmlbsiPpfg3dJtSDr2o9qRtsqGx/N9E1eUKwpnwh1LOABnOKhlIJZGoh52P6/G8HCuvRg3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H6J9pa23; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cdba9d7c-e5da-4e3b-a121-1fad4f517917@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721850474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YaV2tZ+kfBixAFIS2ceMaaoLIfoRysDRpw3nqa337M=;
	b=H6J9pa23EkrNXfqC0xApI0RyKxu3miq3uV7DzOQGSNSV7SWO2lx9NE5PrF0cwhsltlKcCX
	ILRrjOrHKRSUw3tauG2LEDDI+sMz1Nz75/fBcJqzV6Tl8j3brE7qyjUtN5PBaFPL/3YzGL
	FUbs4B6XKawy/H/PHczYnnYl/fx63+U=
Date: Wed, 24 Jul 2024 12:47:44 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Add mptcp pm_nl_ctl link
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
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
 <684fd6c2-ad54-4479-8a6a-ab3270e558a7@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <684fd6c2-ad54-4479-8a6a-ab3270e558a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/24/24 1:24 AM, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for your reply!
> 
> On 24/07/2024 09:42, Geliang Tang wrote:
>> Hi Matt,
>>
>> On Sat, 2024-07-06 at 02:25 +0200, Matthieu Baerts wrote:
>>> Hi Martin,
>>>
>>> Thank you for your reply!
>>>
>>> On 06/07/2024 01:10, Martin KaFai Lau wrote:
>>>> On 7/4/24 3:48 AM, Matthieu Baerts wrote:
>>>>>> diff --git a/tools/testing/selftests/bpf/Makefile
>>>>>> b/tools/testing/
>>>>>> selftests/bpf/Makefile
>>>>>> index e0b3887b3d2d..204269d0b5b8 100644
>>>>>> --- a/tools/testing/selftests/bpf/Makefile
>>>>>> +++ b/tools/testing/selftests/bpf/Makefile
>>>>>> @@ -144,7 +144,7 @@ TEST_GEN_PROGS_EXTENDED =
>>>>>> test_skb_cgroup_id_user \
>>>>>>        flow_dissector_load test_flow_dissector
>>>>>> test_tcp_check_syncookie_user \
>>>>>>        test_lirc_mode2_user xdping test_cpp runqslower bench
>>>>>> bpf_testmod.ko \
>>>>>>        xskxceiver xdp_redirect_multi xdp_synproxy veristat
>>>>>> xdp_hw_metadata \
>>>>>> -    xdp_features bpf_test_no_cfi.ko
>>>>>> +    xdp_features bpf_test_no_cfi.ko mptcp_pm_nl_ctl
>>>>> On the BPF CI, we have such errors:
>>>>>
>>>>>      mptcp_pm_nl_ctl.c:20:10: fatal error: 'linux/mptcp.h' file
>>>>> not found
>>>>>        20 | #include "linux/mptcp.h"
>>>>>           |          ^~~~~~~~~~~~~~~
>>>>>
>>>>> On my side, I don't have any issue, because the compiler uses the
>>>>> mptcp.h file from the system: /usr/include/linux/mptcp.h
>>>>>
>>>>> I suppose that's not OK on the BPF CI, as it looks like it
>>>>> doesn't have
>>>>> this file there, probably because it still uses Ubuntu 20.04 as
>>>>> base,
>>>>> which doesn't include this file in the linux-libc-dev package.
>>>>>
>>>>> When I look at how this 'mptcp_pm_nl_ctl' tool -- and all the
>>>>> other
>>>>> programs from that list -- is compiled (V=1), I see that the
>>>>> following
>>>>> "-I" options are given:
>>>>>
>>>>>     -I${PWD}/tools/testing/selftests/bpf
>>>>>     -I${BUILD}//tools/include
>>>>>     -I${BUILD}/include/generated
>>>>>     -I${PWD}/tools/lib
>>>>>     -I${PWD}/tools/include
>>>>>     -I${PWD}/tools/include/uapi
>>>>>     -I${BUILD}/
>>>>>
>>>>> It will then not look at -I${PWD}/usr/include or the directory
>>>>> generated
>>>>> with:
>>>>>
>>>>>     make headers_install INSTALL_HDR_PATH=(...)
>>>>
>>>> It sounds like the tools/testing/selftests/net/mptcp/Makefile is
>>>> looking
>>>> at this include path, so it works?
>>>
>>> Yes it does work.
>>>
>>>> iiu the bpf/Makefile correctly, it has the bpftool "make" compiled
>>>> and
>>>> installed at tools/testing/selftests/bpf/tools/sbin/. May be
>>>> directly
>>>> compile the pm_nl_ctl by "make tools/testing/selftests/net/mptcp/"?
>>>
>>> That could be an alternative, I didn't know it would be OK to add
>>> such
>>> dependence, good idea.
>>>
>>>>> I guess that's why people have duplicated files in
>>>>> 'tools/include/uapi',
>>>>> but I also understood from Jakub that it is not a good idea to
>>>>> continue
>>>>> to do so.
>>>>>
>>>>> What would be the best solution to avoid a copy? A symlink still
>>>>> looks
>>>>> like a workaround.
>>>>>
>>>>> In the other selftests, KHDR_INCLUDES is used to be able to
>>>>> include the
>>>>> path containing the UAPI headers. So if someone built the headers
>>>>> in a
>>>>
>>>> Meaning KHDR_INCLUDES should be used and -
>>>> I${PWD}/tools/include/uapi can
>>>> be retired?
>>>
>>> That's the idea, yes, for "userspace programs". I mean: for BPF
>>> programs
>>> requiring vmlinux.h (BPF_CFLAGS), I guess you will still need the
>>> bpf.h
>>> file from tools/include/uapi, no?
>>>
>>>> I haven't looked into the details. I quickly tried but it
>>>> fails in my environment.
>>>
>>> Do you not have issues because some files have something like:
>>>
>>>    #include <uapi/linux/(...).h>
>>>
>>> On my side, I had a working version using this patch:
>>>
>>>> diff --git a/tools/testing/selftests/bpf/Makefile
>>>> b/tools/testing/selftests/bpf/Makefile
>>>> index 7c5827d20c2e..112f14d40852 100644
>>>> --- a/tools/testing/selftests/bpf/Makefile
>>>> +++ b/tools/testing/selftests/bpf/Makefile
>>>> @@ -37,7 +37,7 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic            \
>>>>            -Wall -Werror -fno-omit-frame-pointer                  \
>>>>            $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)             \
>>>>            -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)   \
>>>> -         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
>>>> +         -I$(TOOLSINCDIR) $(KHDR_INCLUDES) -I$(OUTPUT)
>>>>   LDFLAGS += $(SAN_LDFLAGS)
>>>>   LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
>>>>   
>>>
>>> But only after having removed these extra 'uapi/':
>>>
>>>    $ git grep -l '<uapi/' -- tools/testing/selftests/bpf | \
>>>      xargs sed -i 's|#include <uapi/|#include <|g'
>>>
>>> Is it not OK for you like that?

I tried and it works for me with the above changes. The other $(APIDIR) usages 
in the Makefile can be replaced also?

Matt, do you want to post a patch and see how does it go with the bpf CI?

[ Sorry for the late reply. ]

>>>
>>> Note that I built the selftests using KHDR_INCLUDES=-
>>> I$INSTALL_HDR_PATH.


