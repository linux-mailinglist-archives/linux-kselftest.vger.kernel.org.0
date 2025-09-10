Return-Path: <linux-kselftest+bounces-41117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71969B512F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 11:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2293B1E27
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5251A314B88;
	Wed, 10 Sep 2025 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FjKKfRzp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40A3115B8
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497406; cv=none; b=g1wajs9P7lAYVo1TL0OPVOlP5TDJNUgOMOMqZw2c/ZK9avbSoah37n4GBVlEt5wUq4cJi0U7dk2I7ku711bnK1f+9yVRFqKH36KsjldG2UtUcDJxJdB4HlK428qjUb4pHGyF1XrIWUyvus6aJIjgz9xbO2uK2/6NcELrx/SiXYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497406; c=relaxed/simple;
	bh=GeZ8gRXpmuh4zIH2qzoEpO1TgLkvX/hmsfatSykJQdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dk1G2iezhsuEvX95kFtUaZBZ6pnLtRJy49obHCojW22fL59Nwlq6Dhr4gfdRZ57fshNxZvOuqvfIkPantnKyRophWrrQr3z+wLGfZdQ+GdwP8EP4PuWXLMxp6NAQWDvVkVqEaEl+tcLIWIzYb+nmZf2BXmk33NO0VdrsEBlNkG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FjKKfRzp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-621b8b0893bso8448888a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 02:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1757497403; x=1758102203; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UH6/XT0kvfyB5mO2cKrXbyp31DnusO7Ul6sUo8daz10=;
        b=FjKKfRzp/hxCDsMl1xDnwLyR79PZ7k+UjNNip2MAJMvzJevAf8hf1i9LM2JlVoiP89
         gIOxALJWod57EihdfypzXXN60vlCckxlrl40uKKNpD8oWrBcWoGOQK2JoRcB1cfTdqLk
         CByM1UAJwhqzmvY8DMBwNDilIpKN22S2KShATesu3ITjrvRokazM7vRejCy423xXLksO
         HHhgQCLMhpU0mszfYHGNXp7/x8lfsQzTqGt1mD0GpYoiPurGu8OrkqhDRQ27gZxE35tS
         Xjzh0dT9DrWCx7+Od9DxF+JfIAM71+dcswESBHwjNixCD9StNMTGtEWZn7mqH/8xkzAW
         XPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497403; x=1758102203;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UH6/XT0kvfyB5mO2cKrXbyp31DnusO7Ul6sUo8daz10=;
        b=sCU9l3R1CiQwu0XHdENORzmgO8Vj29kTGFQKYU3rF20bgxdb8mTQyesx/ezZ2m4TFp
         g0ZksK1jk/Afw634wkiObVNlBIvP5d8djDpHIZWcxpF8joV3WctuKDFeYxoCf1LlgLhh
         p9OqSIS88VEF3aqIk3Guc3HrRAmzUFOaoPAFw7JlscfQg2Acf4L46bQPsWuzCvQeNBba
         i08H9cfP8isNj9/W0h1lcPR4IPpWgBrk6qKE6eeRZtrZnWD09J58Jaei1chrzTQIzF5+
         IuFplls82sBuXbSNreJFHtL9KIQmPfeb4KegsbcJfbNyVUPBDV4X/Ey5QbYpmP3tHPb3
         SD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWCmt7TNTWg2A5q50uQRwyrJcUEXPj0YZmMYkBzHMXYwzpwEAJZWOM8FuHfptbfqsVU2hf+rWgaFhYY048fiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWOFs9GYjnrROfHcOlcdQuuz3k8G8eXpnucdp6tslLtfXJgI65
	5dWAwUJ8ge99BYOe1mocy4VVy0XEBQq0qDE4BQTf72s7lHx8ARHUqGuvggawxZnLA6M=
X-Gm-Gg: ASbGncsHsvTRZbkOK7p2JUUN9hxCnGOQNY209HTGMDSR7EXWgFSbzFlOuvz2SzQQ7+L
	aSHY5jRQn0zlnszdqMkv/sL7laawihip4NgR5LDDaaQkELBuATg1O3Elq6dRLPDN1m3n/Ip2L+Q
	4D//vMlnfYkxiSU09vxmC34FunPznMkWA5QGo42yh/5728r9a9zjDQtyRXwRbdLjk5c1FzCAFSe
	F/Bq+k/sAejmVfNDEBpQECQrhtvseQWwPkhPnNNFnidwJ0q4cVsbsUyoPyX3xGW1edWQp+3E1pX
	6JtLEMm0A4FRgThbkz5B/yYRvgNYTS7e9Vov0xZmvBsg5fcXpxlRIoS+xeIyCTW9/YQSCO0MXGn
	FJEvyKy40SicFt31wl7PXdg1VlQ==
X-Google-Smtp-Source: AGHT+IHezEvVl+d9vvOZ0x6lYJthodH+9bMTe2BUEcXlfkeFgiHS5P2xoZIspY68/UNlg2yLMMtPQA==
X-Received: by 2002:a05:6402:270d:b0:62c:3878:747 with SMTP id 4fb4d7f45d1cf-62c38784cc4mr4323427a12.33.1757497402738;
        Wed, 10 Sep 2025 02:43:22 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018f660esm2874458a12.38.2025.09.10.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:43:21 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: sockmap_redir: Simplify
 try_recv()
In-Reply-To: <35912d55-eb6e-403a-9a7a-05cae551ccf3@rbox.co> (Michal Luczaj's
	message of "Tue, 9 Sep 2025 23:25:16 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-1-9d9e43ff40df@rbox.co>
	<87ikhs54z2.fsf@cloudflare.com> <87bjnk53uo.fsf@cloudflare.com>
	<35912d55-eb6e-403a-9a7a-05cae551ccf3@rbox.co>
Date: Wed, 10 Sep 2025 11:43:20 +0200
Message-ID: <877by663t3.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 09, 2025 at 11:25 PM +02, Michal Luczaj wrote:
> On 9/9/25 12:15, Jakub Sitnicki wrote:
>> On Tue, Sep 09, 2025 at 11:51 AM +02, Jakub Sitnicki wrote:
>>> On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
>>>> try_recv() was meant to support both @expect_success cases, but all the
>>>> callers use @expect_success=false anyway. Drop the unused logic and fold in
>>>> MSG_DONTWAIT. Adapt callers.
>>>>
>>>> Subtle change here: recv() return value of 0 will also be considered (an
>>>> unexpected) success.
>>>>
>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>> ---
>>>>  .../selftests/bpf/prog_tests/sockmap_redir.c       | 25 +++++++++-------------
>>>>  1 file changed, 10 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
>>>> index 9c461d93113db20de65ac353f92dfdbe32ffbd3b..c1bf1076e8152b7d83c3e07e2dce746b5a39cf7e 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
>>>> @@ -144,17 +144,14 @@ static void get_redir_params(struct redir_spec *redir,
>>>>  		*redirect_flags = 0;
>>>>  }
>>>>  
>>>> -static void try_recv(const char *prefix, int fd, int flags, bool expect_success)
>>>> +static void fail_recv(const char *prefix, int fd, int more_flags)
>>>>  {
>>>>  	ssize_t n;
>>>>  	char buf;
>>>>  
>>>> -	errno = 0;
>>>> -	n = recv(fd, &buf, 1, flags);
>>>> -	if (n < 0 && expect_success)
>>>> -		FAIL_ERRNO("%s: unexpected failure: retval=%zd", prefix, n);
>>>> -	if (!n && !expect_success)
>>>> -		FAIL("%s: expected failure: retval=%zd", prefix, n);
>>>> +	n = recv(fd, &buf, 1, MSG_DONTWAIT | more_flags);
>>>> +	if (n >= 0)
>>>> +		FAIL("%s: unexpected success: retval=%zd", prefix, n);
>>>>  }
>>>
>>> This bit, which you highlighted in the description, I don't get.
>>>
>>> If we're expecting to receive exactly one byte, why treat a short read
>>> as a succcess? Why not make it a strict "n != 1" check?
>>>
>>> [...]
>> 
>> Nevermind. It makes sense now. We do want to report a failure for 0-len
>> msg recv as well. You're effectively checking if the rcv queue is empty.
>> 
>> I'd add MSG_PEEK, to signal that we're _just checking_ if the socket is
>> readable, and turn the check into the below to succeed only when
>> queue is empty:
>> 
>>         (n != -1 || (errno != EAGAIN && errno != EWOULDBLOCK))
>
> Well, looks like adding MSG_PEEK exposed a bug in the test. I'll fix that.

The gift that keeps on giving xD

Other alternatives that should also work, but who knows:

- select/poll/epoll readability check
- ioctl(SIOCINQ) but no way to tell if 0-len msg is pending

