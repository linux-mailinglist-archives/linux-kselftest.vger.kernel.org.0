Return-Path: <linux-kselftest+bounces-44867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59FC38C9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 03:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B95188A2DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 02:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4C321CC58;
	Thu,  6 Nov 2025 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovX2A7AT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FBE1BBBE5;
	Thu,  6 Nov 2025 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394738; cv=none; b=DyJWnx/DyhJjzh7hxGgmmn4kSuQZzZ0UOfKqBCXwlN9ZLq2EKP4daQu0LbgituMdirZVYz+DBtuorwIC4Xv9/3rtWyuYYuiLPQ9pdQBCBlUsy6I5r7xOuAtu8IN5L4L+p+aJbw5nM9OV5mlPmfEdesOCN3Ffmy5I+ShcQ/ybxco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394738; c=relaxed/simple;
	bh=xSo1QG7jcFmN0SM7+LXjZkCh5DUFQhWr/bi5N6n+B1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbSWebFY5wdL5SnNI0kppsSxi9ZurbTA1hfQBg580+Z24jibbtAPUE+VU9luboaz4dcaYZs8gtOk7xod+piYOC6MujZ059iqsjHD+yNwH4rJV6j+rKEMexOIzPmp8tE6q6hi+ZpjOiufXazQafxsS/9xaGC5kMHI9LeC2S1DZsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovX2A7AT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C106CC4CEF5;
	Thu,  6 Nov 2025 02:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762394737;
	bh=xSo1QG7jcFmN0SM7+LXjZkCh5DUFQhWr/bi5N6n+B1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ovX2A7ATdmrj3Cjesh1lIuQ2BKoyDM80J9InYH/fbgd6IvCx2AJl7f4/1oEGyfuGy
	 I3G/tjezAaUVS2TcXH5g8qzJ8pGYnwlD0wa1+cZ7dCLQKJx5l/+095RfPGPqQyqF4j
	 HWUEsaYrCV5I+6uIUmhoN1cZBm3ni8ePvFqGmShDX29jUBFokuQJbbnbMxpPYOy6g9
	 Zvp8OK+qZ82w8twCMiYuPZQC5rw8lP0PmXfj6c58n67JcQlwOHN2h3lwOXV3KYHPFG
	 owVB31qzUkDkW3jKw1A5fj8ywAbiEH20OM+IqU2O7nIwXYfIsM6/8+eYFvowDy8hDZ
	 zq3aifVY82Wuw==
Message-ID: <7874cfab-3f96-4cfb-9e52-b9d8108bc536@kernel.org>
Date: Thu, 6 Nov 2025 02:05:33 +0000
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
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAADnVQKzSBZYaj0iMkNBk6FvaOket1mWPksX661zwC2rg2FBkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-11-05 17:29 UTC-0800 ~ Alexei Starovoitov
<alexei.starovoitov@gmail.com>
> On Wed, Nov 5, 2025 at 1:38 AM Quentin Monnet <qmo@kernel.org> wrote:
>>
>> 2025-11-04 09:54 UTC-0800 ~ Alexei Starovoitov
>> <alexei.starovoitov@gmail.com>
>>> On Sat, Nov 1, 2025 at 12:34 PM Harshit Mogalapalli
>>> <harshit.m.mogalapalli@oracle.com> wrote:
>>>>
>>>> It is useful to print map ID on successful creation.
>>>>
>>>> JSON case:
>>>> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 value 8 entries 128 name map4
>>>> {"id":12}
>>>>
>>>> Generic case:
>>>> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 8 entries 128 name map5
>>>> Map successfully created with ID: 15
>>>>
>>>> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
>>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>>> Reviewed-by: Quentin Monnet <qmo@kernel.org>
>>>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>>>> ---
>>>> v2->v3: remove a line break("\n" ) in p_err statement. [Thanks Quentin]
>>>> ---
>>>>  tools/bpf/bpftool/map.c | 21 +++++++++++++++++----
>>>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>>>> index c9de44a45778..f32ae5476d76 100644
>>>> --- a/tools/bpf/bpftool/map.c
>>>> +++ b/tools/bpf/bpftool/map.c
>>>> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
>>>>         LIBBPF_OPTS(bpf_map_create_opts, attr);
>>>>         enum bpf_map_type map_type = BPF_MAP_TYPE_UNSPEC;
>>>>         __u32 key_size = 0, value_size = 0, max_entries = 0;
>>>> +       struct bpf_map_info map_info = {};
>>>> +       __u32 map_info_len = sizeof(map_info);
>>>>         const char *map_name = NULL;
>>>>         const char *pinfile;
>>>>         int err = -1, fd;
>>>> @@ -1353,13 +1355,24 @@ static int do_create(int argc, char **argv)
>>>>         }
>>>>
>>>>         err = do_pin_fd(fd, pinfile);
>>>> -       close(fd);
>>>>         if (err)
>>>> -               goto exit;
>>>> +               goto close_fd;
>>>>
>>>> -       if (json_output)
>>>> -               jsonw_null(json_wtr);
>>>> +       err = bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
>>>> +       if (err) {
>>>> +               p_err("Failed to fetch map info: %s", strerror(errno));
>>>> +               goto close_fd;
>>>> +       }
>>>>
>>>> +       if (json_output) {
>>>> +               jsonw_start_object(json_wtr);
>>>> +               jsonw_int_field(json_wtr, "id", map_info.id);
>>>> +               jsonw_end_object(json_wtr);
>>>> +       } else {
>>>> +               printf("Map successfully created with ID: %u\n", map_info.id);
>>>> +       }
>>>
>>> bpftool doesn't print it today and some scripts may depend on that.
>>
>>
>> Hi Alexei, are you sure we can't add any input at all? I'm concerned
>> that users won't ever find the IDs for created maps they might want to
>> use, if they never see it in the plain output.
>>
>>
>>> Let's drop this 'printf'. Json can do it unconditionally, since
>>> json parsing scripts should filter things they care about.
>>
>> I'd say the risk is the same. Scripts should filter things, but in
>> practise they might just as well be comparing to "null" today, given
>> that we didn't have any other output for the command so far. Conversely,
>> what scripts should not do is rely on plain output, we've always
>> recommended using bpftool's JSON for automation (or the exit code, in
>> the case of map creation). So I'm not convinced it's justified to
>> introduce a difference between plain and JSON in the current case.
> 
> tbh the "map create" feature suppose to create and pin and if both
> are successful then the map will be there and bpftool will
> exit with success.
> Now you're arguing that there could be a race with another
> bpftool/something that pins a different map in the same location
> and success of bpftool doesn't mean that exact that map is there.
> Other tool could have unpinned/deleted map, pinned another one, etc.
> Sure, such races are possible, but returning map id still
> looks pointless. It doesn't solve any race.
> So the whole 'lets print id' doesn't quite make sense to me.

OK "solving races" is not accurate, but returning the ID gives a unique
handle to work with the map, if a user runs a follow-up invocation to
update entries using the ID they can be sure they're working with the
same map - whatever happened with the bpffs. Or they can have the update
fail if you really want that particular map but, for example, it's been
recreated in the meantime. At the moment there's no way to uniquely
identify the map we've created with bpftool, and that seems weird to me.

