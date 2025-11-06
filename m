Return-Path: <linux-kselftest+bounces-44869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0E5C38DC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 03:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA3DA4E1909
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 02:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EF023BD1D;
	Thu,  6 Nov 2025 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdb3Jc4m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53457224234;
	Thu,  6 Nov 2025 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395956; cv=none; b=rWvZhZzZS6/w2RY2sLHEAXMnO+mC8RL7nWpZ9u7JB0PeSuM1Dt4SqAdjht0HT2oBUIF92fOQaHGi1mzyQhL0tY4YIzzPG4tXVAp5ZMvCYawfN3YkhqDI8TvvnmzbxZcbhtHZ43ctCI4RGOxB2iMnYM8bJmpDBL+TXa0uAgIoB3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395956; c=relaxed/simple;
	bh=eVgK39ZeKae/dZ5DvJbKrnRO5CVKL0TeuGPKCJfDGwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4lB55uQpJFgQAqCcMfxWRMygVCtyHaeyJLQJVkYC3A7w/+WhAFNeLI459XK07oelDjNyx/vEkhsIMglGHe3lx4oY8G3L2lyniFhEM4eFhOIiaZv/l0WjZc8phReJKMb5Jf8dZ2uqscKJv1G/QxfG96N43/7pET+fNxwL8jF4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdb3Jc4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9DFC4CEF5;
	Thu,  6 Nov 2025 02:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762395955;
	bh=eVgK39ZeKae/dZ5DvJbKrnRO5CVKL0TeuGPKCJfDGwQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rdb3Jc4mpMFDFzJGgwkWHAkmFDCVLABesE4Yj/dkTart+RWa5yAaY7x4FImRQm6mx
	 KAIf8bKaKEDU+uewWE2Ewz+Ms8kOl50R1qCIyUsqw88wLayWbptXcPBCHpPUGV5XMs
	 129ST2k1i1WZfaV8d/KA7EN6Yev3a+rGGyn73D4vW+timT1UKyHECp7nZ6tXL3eSBU
	 3qavp+yyefK3XzL7DuQOtuwB67ukPYwVqYqdC0LqryplpZjSmoL2YxJ6Zm7hdhPoqv
	 Wm8XZuXiGzJokyD6gXL9lht9Jy/4zUM5IzygIzBNe/maA0ux+zspJB7X4GotDJLZj/
	 +vmLMsmUMBd5A==
Message-ID: <667fb65c-d8d3-4af9-8efe-196e6d1befcc@kernel.org>
Date: Thu, 6 Nov 2025 02:25:51 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] bpftool: Print map ID upon creation and support
 JSON output
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 bpf <bpf@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
 Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20251101193357.111186-1-harshit.m.mogalapalli@oracle.com>
 <20251101193357.111186-2-harshit.m.mogalapalli@oracle.com>
 <CAADnVQLe6a8Kae892sVaND-2p1DQDXGD5gqxHWHHUC85ntLCqw@mail.gmail.com>
 <e9d43dab-cfae-48a8-9039-e050ea392797@kernel.org>
 <CAADnVQKzSBZYaj0iMkNBk6FvaOket1mWPksX661zwC2rg2FBkQ@mail.gmail.com>
 <7874cfab-3f96-4cfb-9e52-b9d8108bc536@kernel.org>
 <CAADnVQL7cLYPKEQOLWi1DjTZjhE_Fy4zWLrWG+=NSeN821SyMw@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAADnVQL7cLYPKEQOLWi1DjTZjhE_Fy4zWLrWG+=NSeN821SyMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-11-05 18:14 UTC-0800 ~ Alexei Starovoitov
<alexei.starovoitov@gmail.com>
> On Wed, Nov 5, 2025 at 6:05 PM Quentin Monnet <qmo@kernel.org> wrote:
>>
>> 2025-11-05 17:29 UTC-0800 ~ Alexei Starovoitov
>> <alexei.starovoitov@gmail.com>
>>> On Wed, Nov 5, 2025 at 1:38 AM Quentin Monnet <qmo@kernel.org> wrote:
>>>>
>>>> 2025-11-04 09:54 UTC-0800 ~ Alexei Starovoitov
>>>> <alexei.starovoitov@gmail.com>
>>>>> On Sat, Nov 1, 2025 at 12:34 PM Harshit Mogalapalli
>>>>> <harshit.m.mogalapalli@oracle.com> wrote:
>>>>>>
>>>>>> It is useful to print map ID on successful creation.
>>>>>>
>>>>>> JSON case:
>>>>>> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 value 8 entries 128 name map4
>>>>>> {"id":12}
>>>>>>
>>>>>> Generic case:
>>>>>> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 8 entries 128 name map5
>>>>>> Map successfully created with ID: 15
>>>>>>
>>>>>> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
>>>>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>>>>> Reviewed-by: Quentin Monnet <qmo@kernel.org>
>>>>>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>>>>>> ---
>>>>>> v2->v3: remove a line break("\n" ) in p_err statement. [Thanks Quentin]
>>>>>> ---
>>>>>>  tools/bpf/bpftool/map.c | 21 +++++++++++++++++----
>>>>>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>>>>>> index c9de44a45778..f32ae5476d76 100644
>>>>>> --- a/tools/bpf/bpftool/map.c
>>>>>> +++ b/tools/bpf/bpftool/map.c
>>>>>> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
>>>>>>         LIBBPF_OPTS(bpf_map_create_opts, attr);
>>>>>>         enum bpf_map_type map_type = BPF_MAP_TYPE_UNSPEC;
>>>>>>         __u32 key_size = 0, value_size = 0, max_entries = 0;
>>>>>> +       struct bpf_map_info map_info = {};
>>>>>> +       __u32 map_info_len = sizeof(map_info);
>>>>>>         const char *map_name = NULL;
>>>>>>         const char *pinfile;
>>>>>>         int err = -1, fd;
>>>>>> @@ -1353,13 +1355,24 @@ static int do_create(int argc, char **argv)
>>>>>>         }
>>>>>>
>>>>>>         err = do_pin_fd(fd, pinfile);
>>>>>> -       close(fd);
>>>>>>         if (err)
>>>>>> -               goto exit;
>>>>>> +               goto close_fd;
>>>>>>
>>>>>> -       if (json_output)
>>>>>> -               jsonw_null(json_wtr);
>>>>>> +       err = bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
>>>>>> +       if (err) {
>>>>>> +               p_err("Failed to fetch map info: %s", strerror(errno));
>>>>>> +               goto close_fd;
>>>>>> +       }
>>>>>>
>>>>>> +       if (json_output) {
>>>>>> +               jsonw_start_object(json_wtr);
>>>>>> +               jsonw_int_field(json_wtr, "id", map_info.id);
>>>>>> +               jsonw_end_object(json_wtr);
>>>>>> +       } else {
>>>>>> +               printf("Map successfully created with ID: %u\n", map_info.id);
>>>>>> +       }
>>>>>
>>>>> bpftool doesn't print it today and some scripts may depend on that.
>>>>
>>>>
>>>> Hi Alexei, are you sure we can't add any input at all? I'm concerned
>>>> that users won't ever find the IDs for created maps they might want to
>>>> use, if they never see it in the plain output.
>>>>
>>>>
>>>>> Let's drop this 'printf'. Json can do it unconditionally, since
>>>>> json parsing scripts should filter things they care about.
>>>>
>>>> I'd say the risk is the same. Scripts should filter things, but in
>>>> practise they might just as well be comparing to "null" today, given
>>>> that we didn't have any other output for the command so far. Conversely,
>>>> what scripts should not do is rely on plain output, we've always
>>>> recommended using bpftool's JSON for automation (or the exit code, in
>>>> the case of map creation). So I'm not convinced it's justified to
>>>> introduce a difference between plain and JSON in the current case.
>>>
>>> tbh the "map create" feature suppose to create and pin and if both
>>> are successful then the map will be there and bpftool will
>>> exit with success.
>>> Now you're arguing that there could be a race with another
>>> bpftool/something that pins a different map in the same location
>>> and success of bpftool doesn't mean that exact that map is there.
>>> Other tool could have unpinned/deleted map, pinned another one, etc.
>>> Sure, such races are possible, but returning map id still
>>> looks pointless. It doesn't solve any race.
>>> So the whole 'lets print id' doesn't quite make sense to me.
>>
>> OK "solving races" is not accurate, but returning the ID gives a unique
>> handle to work with the map, if a user runs a follow-up invocation to
>> update entries using the ID they can be sure they're working with the
>> same map - whatever happened with the bpffs. Or they can have the update
>> fail if you really want that particular map but, for example, it's been
>> recreated in the meantime. At the moment there's no way to uniquely
>> identify the map we've created with bpftool, and that seems weird to me.
> 
> ID is not unique. If somebody rm -rf bpffs. That ID will not point anywhere.
> Also it's 31-bit space and folks in the past demonstrated an attack
> to recycle the same ID.
> So the users cannot be sure what ID is this.
> 

Ah. I did assume it was unique :/. My bad, then in that case it doesn't
make too much sense, indeed.

