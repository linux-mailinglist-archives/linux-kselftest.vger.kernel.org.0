Return-Path: <linux-kselftest+bounces-338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 553477F1D02
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 20:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC6D28271A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 19:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD891EB24;
	Mon, 20 Nov 2023 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LXLgLVWq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [IPv6:2001:41d0:203:375::aa])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B32100;
	Mon, 20 Nov 2023 11:00:26 -0800 (PST)
Message-ID: <be025c4d-4602-4b2f-963c-5ec2561cc255@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700506824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfwHLBU/eMYU2BU5PuQp1CafAYg938BQTjSvVXHWz4g=;
	b=LXLgLVWq5d+Vt3kcSsr/102ISqSrsb2lZKMQtSIc6oXuNTEevMqOjFf0A2S5Qa8E8ymmfl
	HtJX1uvCKr4/QI3sG4lwRY4oyVYmmHNEcjYuuiuSfBUoSyEO60ybTCWPO0RZ6nC4JG7p9E
	aGJElRS3bcHtUTeQQE1jKb8w/N/R/UA=
Date: Mon, 20 Nov 2023 11:00:17 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: Replaces the usage of
 CHECK calls for ASSERTs in bpf_tcp_ca
Content-Language: en-GB
To: Yuran Pereira <yuran.pereira@hotmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, andrii.nakryiko@gmail.com,
 mykolal@fb.com, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <GV1PR10MB6563A7938B9B403861CA88F3E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <14c7dea0-242c-4b47-929c-7cbd1d7e202a@linux.dev>
 <GV1PR10MB6563596BC3E2B01F664010C7E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <GV1PR10MB6563596BC3E2B01F664010C7E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/20/23 12:15 PM, Yuran Pereira wrote:
> Hello Yonghong,
> On Mon, Nov 20, 2023 at 07:22:59AM -0800, Yonghong Song wrote:
>>> -		if (CHECK(!err || errno != ENOENT,
>>> -			  "bpf_map_lookup_elem(sk_stg_map)",
>>> -			  "err:%d errno:%d\n", err, errno))
>>> +		if (!ASSERT_NEQ(err, 0, "bpf_map_lookup_elem(sk_stg_map)") ||
>> !ASSERT_ERR(err, "bpf_map_lookup_elem(sk_stg_map)")
>> might be simpler than !ASSERT_NEQ(..).
>>
> Sure, that makes sense. I'll change it in v3.
>>> -	pthread_join(srv_thread, &thread_ret);
>>> -	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
>>> -	      PTR_ERR(thread_ret));
>>> +	err = pthread_join(srv_thread, &thread_ret);
>>> +	ASSERT_OK(err, "pthread_join");
>> The above is not equivalent to the original code.
>> The original didn't check pthread_join() return as it
>> is very very unlikely to fail. And check 'thread_ret'
>> is still needed.
>>
> Yes that is true, but the v1 [1] broke the tests because the
> ASSERT_OK_PTR(thread_ret, "pthread_join") kept failing, even
> though all the asserts within the `server()` function itself
> passed.
>
> Also, isn't asserting `thread_ret` technically checking the
> `server()` function instead of `pthread_join`? So should we
> have two asserts here? One for `server` and one for `pthread_join`
> or is it not necessary?
> i.e:
> ```
> ASSERT_OK_PTR(thread_ret, "server");
> ASSERT_OK(err, "pthread_join");
> ```

As I mentioned, checking return value of pthread_join()
is not critical as in general pthread_join() not fail.
The test is not to test pthread_join() and if pthread_join()
fails it would be an even bigger problem affecting many other
tests.

>
> Upon taking a second look, I now think that the reason why
> `ASSERT_OK_PTR(thread_ret, "pthread_join");` failed in v1 might
> have been because it calls `libbpf_get_error` which returns
> `-errno` when the pointer is `NULL`.
>
> Since `server`'s return value is not a bpf address, which
> `ASSERT_OK_PTR` expects it to be, do you that think we should
> explicitly set `errno = 0` prior to returning NULL on server?
> That way that assert would pass even when the pointer is NULL
> (which is the case when `server` returns successfuly).

Let us just do

   ASSERT_OK(IS_ERR(thread_ret), "thread_ret")


>
> [1] - https://lore.kernel.org/lkml/GV1PR10MB6563A0BE91080E6E8EC2651DE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM/
>
> As always, thank you for your feedback.
>
> Yuran Pereira
>

