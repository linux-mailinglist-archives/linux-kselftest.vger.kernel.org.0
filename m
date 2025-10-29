Return-Path: <linux-kselftest+bounces-44340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28AC1C9F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 18:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 845F034BF4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C1F354704;
	Wed, 29 Oct 2025 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nrf0lCxh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403035470C
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760596; cv=none; b=E5vQ1b6kQBfka3q6DVvqev669LH7fQQhQHVTQt6HRppN1sj76q3MG0k9dUhkSa32uSWKFjIQWISzWvp8vHb+OURtUTBbqHWorBGGgGjarMm+mYrSymesrfPyc9x/tuJk6vWooS8O+nscL6DB/MEOP2JgMfBMlFyK69vNzzvEJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760596; c=relaxed/simple;
	bh=dQC30MHTvswSnusn5NOPjHmGoeeb2j1cD3HcbesEOFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+B/70lLsa3QiXznSuo57JzHSC7EDkYbB7n6yXNdiASZ4ZB/deg6v/fuS2Tmjd3H1jBQjxvDEE9KkkbNS6jpjRiX8P+ZTFmC3QSUUYW6M+UJvVuEsHeeVf/hZvc+T9NYU+lst4aDq3/4dMUXTKfnPg0zBdLIaVgJ9xjTx040zHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nrf0lCxh; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7a6be149-9e04-444e-a433-49450385d6a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761760590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppd0RHap4q7bSCes82xlTLvMUFropcMpTg+3MxryB3c=;
	b=nrf0lCxhmc2lqlJiWe4YAO99sFd0VWUhwpdBQuozQojjIKuPKXFjvPd6+SDExpptyAoSW+
	rtEHu8cGVS5FatxkW3l8Xsu7eCTWzdvE0lP7zhPDwyP94kto5OW1YVfadpn2ys/7/3aVE5
	jdxCVH0oM92ZV21XRgiZl07i28tmDoM=
Date: Wed, 29 Oct 2025 10:56:23 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next 1/2] bpftool: Print map ID upon creation and
 support JSON output
Content-Language: en-GB
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 bpf@vger.kernel.org
Cc: alan.maguire@oracle.com, Quentin Monnet <qmo@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251028125705.3586552-1-harshit.m.mogalapalli@oracle.com>
 <20251028125705.3586552-2-harshit.m.mogalapalli@oracle.com>
 <89b12696-26ff-411f-9cd3-74361f0f1ecd@linux.dev>
 <cc32d3db-60ef-4046-8988-289cd0cc8c26@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <cc32d3db-60ef-4046-8988-289cd0cc8c26@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/29/25 9:05 AM, Harshit Mogalapalli wrote:
> Hi Yonghong,
>
>
> On 29/10/25 07:44, Yonghong Song wrote:
>>
>>
>> On 10/28/25 5:57 AM, Harshit Mogalapalli wrote:
>>> It is useful to print map ID on successful creation.
>>>
>>> JSON case:
>>> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 
>>> value 8 entries 128 name map4
>>> {"id":12}
>>>
>>> Generic case:
>>> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 
>>> 8 entries 128 name map5
>>> Map successfully created with ID: 15
>>>
>>> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
>>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>>> ---
>>>   tools/bpf/bpftool/map.c | 24 ++++++++++++++++++++----
>>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>>> index c9de44a45778..b6580f25361d 100644
>>> --- a/tools/bpf/bpftool/map.c
>>> +++ b/tools/bpf/bpftool/map.c
>>> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
>>>       LIBBPF_OPTS(bpf_map_create_opts, attr);
>>>       enum bpf_map_type map_type = BPF_MAP_TYPE_UNSPEC;
>>>       __u32 key_size = 0, value_size = 0, max_entries = 0;
>>> +    struct bpf_map_info map_info = {};
>>> +    __u32 map_info_len = sizeof(map_info);
>>>       const char *map_name = NULL;
>>>       const char *pinfile;
>>>       int err = -1, fd;
>>> @@ -1353,13 +1355,27 @@ static int do_create(int argc, char **argv)
>>>       }
>>>       err = do_pin_fd(fd, pinfile);
>>> -    close(fd);
>>> -    if (err)
>>> +    if (err) {
>>> +        close(fd);
>>
>> I think you can remove close(fd) here,
>>
>>>           goto exit;
>>> +    }
>>> -    if (json_output)
>>> -        jsonw_null(json_wtr);
>>> +    err = bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
>>> +    if (err) {
>>> +        p_err("Failed to fetch map info: %s\n", strerror(errno));
>>> +        close(fd);
>>
>> and here
>>
>>> +        goto exit;
>>> +    }
>>> +    close(fd);
>>
>> and here,
>>
>>> +
>>> +    if (json_output) {
>>> +        jsonw_start_object(json_wtr);
>>> +        jsonw_int_field(json_wtr, "id", map_info.id);
>>> +        jsonw_end_object(json_wtr);
>>> +    } else {
>>> +        printf("Map successfully created with ID: %u\n", map_info.id);
>>> +    }
>>>   exit:
>>
>> and put close(fd) here.
>
> I think we need one more close_fd: label and then put a close(fd); 
> here. As there are other gotos to exit earlier in this function when 
> fd is uninitialized, which can the error like:
>
> map.c: In function ‘do_create’:
> map.c:1375:9: warning: ‘fd’ may be used uninitialized 
> [-Wmaybe-uninitialized]
>  1375 |         close(fd);
>       |         ^~~~~~~~~
> map.c:1258:23: note: ‘fd’ was declared here
>  1258 |         int err = -1, fd;
>       |                       ^~
>
>
>
> So, maybe we could do something like this:
>
>         err = do_pin_fd(fd, pinfile);
> -       close(fd);
>         if (err)
> -               goto exit;
> +               goto close_fd;
>
> -       if (json_output)
> -               jsonw_null(json_wtr);
> +       err = bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> +       if (err) {
> +               p_err("Failed to fetch map info: %s\n", strerror(errno));
> +               goto close_fd;
> +       }
>
> +       if (json_output) {
> +               jsonw_start_object(json_wtr);
> +               jsonw_int_field(json_wtr, "id", map_info.id);
> +               jsonw_end_object(json_wtr);
> +       } else {
> +               printf("Map successfully created with ID: %u\n", 
> map_info.id);
> +       }
> +close_fd:
> +       close(fd);
>  exit:
>         if (attr.inner_map_fd > 0)
>                 close(attr.inner_map_fd);
>
> I can prepare a v2 with this change, but wouldn't it be simpler to add a
> direct close(fd); on the few error paths instead of introducing an
> additional label for close(fd);?

The above change LGTM. Thanks!

>
> Thoughts/Suggestions ?
>
> Thanks,
> Harshit
>
>>
>>>       if (attr.inner_map_fd > 0)
>>>           close(attr.inner_map_fd);
>>
>>
>
>


