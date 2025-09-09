Return-Path: <linux-kselftest+bounces-41073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DF8B5081D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 23:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1530C4E4C6C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 21:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118FB25A323;
	Tue,  9 Sep 2025 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="AxjhYTJC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A525F784;
	Tue,  9 Sep 2025 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453161; cv=none; b=jwPQrUkA59lSQW0UsXfinIFwolOegGy26cj//A+wv/kvJSz3LlcdX6ivVM7WeKfid3LwbVPLwZ7S3Zn/o06q0/qEyQaHmjUqfu1TbpKdqnw91qBWd1Bp5OG/IWVu4O+GzFC+C65FJpCZlYJwgaDDsz1UCveDVWt86tmjnl6FsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453161; c=relaxed/simple;
	bh=bzziaSea1ezUweh9b99QeO0GW6TdKMo9jl6rrcFxt/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGxuNsULy9Kv4DB6cvTIsHRipkb6nplL0p66wbC1zWnvGypbcREAqC7CxV3Z3uK4Zz1ADK0yamLbnsy9KR+XMNQDjySGsmzeA+ma48/KiOB6rVEJybz/OsRDcVKLhP8jw11OvZBsLF9pdX/00TGPmPqM57kA3vMmgibkKYjr7xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=AxjhYTJC; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uw5qG-00GhtX-Hv; Tue, 09 Sep 2025 23:25:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=0o2XDIdrcZ+poEKn50hqKwtLG2/0sDmrZ/MBl6kvJBw=; b=AxjhYTJCBDiSG2+dyYbg4GPiCC
	AlrS60fZGsOKZKFNHlP1YdTvA53yxtMc/fvo+Tk5l0rQTEYcaADUE8st+ydaR6qzVf04Mnw2uVlhL
	Yj40O+1qdo4y6Rw5XrNv7Yi7GepT4yx9kWGs2FACnYZNPS6eq8lGkgSEjFFbZRTePJHXPMMIoKHTj
	fVO8sKqk+gPw0W7S6OleVDiOI7h8LoGmWuuU2+tSmYnJ5y97ZjI0JIKxRK5PsTDXkvkl1ro6lmWAT
	OHdbXZTkE6ciSQoI3ZseK+fwaPm75H5eZcKi3rBjEd/7u4GH8zcMQX7wkwnjfmnVMihK90J3fpBU6
	ejg9w9yw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uw5qE-0007kN-Pu; Tue, 09 Sep 2025 23:25:31 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uw5q3-00Ev5C-4k; Tue, 09 Sep 2025 23:25:19 +0200
Message-ID: <35912d55-eb6e-403a-9a7a-05cae551ccf3@rbox.co>
Date: Tue, 9 Sep 2025 23:25:16 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: sockmap_redir: Simplify
 try_recv()
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
 <20250905-redir-test-pass-drop-v1-1-9d9e43ff40df@rbox.co>
 <87ikhs54z2.fsf@cloudflare.com> <87bjnk53uo.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87bjnk53uo.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 12:15, Jakub Sitnicki wrote:
> On Tue, Sep 09, 2025 at 11:51 AM +02, Jakub Sitnicki wrote:
>> On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
>>> try_recv() was meant to support both @expect_success cases, but all the
>>> callers use @expect_success=false anyway. Drop the unused logic and fold in
>>> MSG_DONTWAIT. Adapt callers.
>>>
>>> Subtle change here: recv() return value of 0 will also be considered (an
>>> unexpected) success.
>>>
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>>  .../selftests/bpf/prog_tests/sockmap_redir.c       | 25 +++++++++-------------
>>>  1 file changed, 10 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
>>> index 9c461d93113db20de65ac353f92dfdbe32ffbd3b..c1bf1076e8152b7d83c3e07e2dce746b5a39cf7e 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
>>> @@ -144,17 +144,14 @@ static void get_redir_params(struct redir_spec *redir,
>>>  		*redirect_flags = 0;
>>>  }
>>>  
>>> -static void try_recv(const char *prefix, int fd, int flags, bool expect_success)
>>> +static void fail_recv(const char *prefix, int fd, int more_flags)
>>>  {
>>>  	ssize_t n;
>>>  	char buf;
>>>  
>>> -	errno = 0;
>>> -	n = recv(fd, &buf, 1, flags);
>>> -	if (n < 0 && expect_success)
>>> -		FAIL_ERRNO("%s: unexpected failure: retval=%zd", prefix, n);
>>> -	if (!n && !expect_success)
>>> -		FAIL("%s: expected failure: retval=%zd", prefix, n);
>>> +	n = recv(fd, &buf, 1, MSG_DONTWAIT | more_flags);
>>> +	if (n >= 0)
>>> +		FAIL("%s: unexpected success: retval=%zd", prefix, n);
>>>  }
>>
>> This bit, which you highlighted in the description, I don't get.
>>
>> If we're expecting to receive exactly one byte, why treat a short read
>> as a succcess? Why not make it a strict "n != 1" check?
>>
>> [...]
> 
> Nevermind. It makes sense now. We do want to report a failure for 0-len
> msg recv as well. You're effectively checking if the rcv queue is empty.
> 
> I'd add MSG_PEEK, to signal that we're _just checking_ if the socket is
> readable, and turn the check into the below to succeed only when
> queue is empty:
> 
>         (n != -1 || (errno != EAGAIN && errno != EWOULDBLOCK))

Well, looks like adding MSG_PEEK exposed a bug in the test. I'll fix that.

Thanks,
Michal


