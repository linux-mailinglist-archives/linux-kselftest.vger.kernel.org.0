Return-Path: <linux-kselftest+bounces-44792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE718C34E8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 10:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C544F4F508C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E392FFDCA;
	Wed,  5 Nov 2025 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8WqExk8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC30934D3BD;
	Wed,  5 Nov 2025 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335482; cv=none; b=ukbHGy4CJjBx0Xt9A18yrrrDgawCwB60MiYMLrkOnIfC9E6KV6WOU+OKGB+KwpFq4G0EDnLqbGN47CzmsDwZQuUjRjak08A3qrRSxcCNfh2Xkouu1d3HHoSlpdg10Ku8S1IkVto51G/xV2sQwwlpupjwN/WUtVx7Rn61nlZK5KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335482; c=relaxed/simple;
	bh=qe5u7c4FemlavOYTA8gwuTHm1A63995BSzBoTLojJJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYHwiYzfJ9Hgin9/UzOc4LN+N5GFCX+Lsx3FUGwY9iMHNjPShtv0MwodkCS54qw5NTEVYNESX3aYVqmWyWGC8V8IB5c2FdLDc5YVmwJVw1fJ5Y/PDovckZRkLZsHAoxKF0OlbZPr+FAOvtMjI2RPIY3OHQVvbH8iKRN2BtjG1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8WqExk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99874C4CEF8;
	Wed,  5 Nov 2025 09:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762335481;
	bh=qe5u7c4FemlavOYTA8gwuTHm1A63995BSzBoTLojJJI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p8WqExk8FquJ2nz5yIjLJbNA9DhfFSvbHZsTuMkfVfYFD52mLyQWA7z9s+UbFi2Re
	 0Vt9/JCfmdwnWIUUlLTh7KvCsCwf3PHB1TP2/yKENIO2DSI0i/4FmENiu8QeN15MUA
	 qyr7JY5TOu3F2auYTbfUl7eGpqtP/w1kO1OvcpeBNyb6zJNc6C27ve+sIUV+BnFg2L
	 pPkN09pep0FIFejONTWv73skCCucGg7Q6bgHP5hfWGbij69l/i2fJg36CdrjwvFkod
	 QIGRFkqtC/gXEn7nqCbD8rpt2eMtcs4u8jXVD5ILBKm942M5V8W7wOpsJdmfvAbHf0
	 D4viOatA2by9Q==
Message-ID: <e9d43dab-cfae-48a8-9039-e050ea392797@kernel.org>
Date: Wed, 5 Nov 2025 09:37:57 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] bpftool: Print map ID upon creation and support
 JSON output
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
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
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAADnVQLe6a8Kae892sVaND-2p1DQDXGD5gqxHWHHUC85ntLCqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-11-04 09:54 UTC-0800 ~ Alexei Starovoitov
<alexei.starovoitov@gmail.com>
> On Sat, Nov 1, 2025 at 12:34 PM Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com> wrote:
>>
>> It is useful to print map ID on successful creation.
>>
>> JSON case:
>> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 value 8 entries 128 name map4
>> {"id":12}
>>
>> Generic case:
>> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 8 entries 128 name map5
>> Map successfully created with ID: 15
>>
>> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>> Reviewed-by: Quentin Monnet <qmo@kernel.org>
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>> v2->v3: remove a line break("\n" ) in p_err statement. [Thanks Quentin]
>> ---
>>  tools/bpf/bpftool/map.c | 21 +++++++++++++++++----
>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>> index c9de44a45778..f32ae5476d76 100644
>> --- a/tools/bpf/bpftool/map.c
>> +++ b/tools/bpf/bpftool/map.c
>> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
>>         LIBBPF_OPTS(bpf_map_create_opts, attr);
>>         enum bpf_map_type map_type = BPF_MAP_TYPE_UNSPEC;
>>         __u32 key_size = 0, value_size = 0, max_entries = 0;
>> +       struct bpf_map_info map_info = {};
>> +       __u32 map_info_len = sizeof(map_info);
>>         const char *map_name = NULL;
>>         const char *pinfile;
>>         int err = -1, fd;
>> @@ -1353,13 +1355,24 @@ static int do_create(int argc, char **argv)
>>         }
>>
>>         err = do_pin_fd(fd, pinfile);
>> -       close(fd);
>>         if (err)
>> -               goto exit;
>> +               goto close_fd;
>>
>> -       if (json_output)
>> -               jsonw_null(json_wtr);
>> +       err = bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
>> +       if (err) {
>> +               p_err("Failed to fetch map info: %s", strerror(errno));
>> +               goto close_fd;
>> +       }
>>
>> +       if (json_output) {
>> +               jsonw_start_object(json_wtr);
>> +               jsonw_int_field(json_wtr, "id", map_info.id);
>> +               jsonw_end_object(json_wtr);
>> +       } else {
>> +               printf("Map successfully created with ID: %u\n", map_info.id);
>> +       }
> 
> bpftool doesn't print it today and some scripts may depend on that.


Hi Alexei, are you sure we can't add any input at all? I'm concerned
that users won't ever find the IDs for created maps they might want to
use, if they never see it in the plain output.


> Let's drop this 'printf'. Json can do it unconditionally, since
> json parsing scripts should filter things they care about.

I'd say the risk is the same. Scripts should filter things, but in
practise they might just as well be comparing to "null" today, given
that we didn't have any other output for the command so far. Conversely,
what scripts should not do is rely on plain output, we've always
recommended using bpftool's JSON for automation (or the exit code, in
the case of map creation). So I'm not convinced it's justified to
introduce a difference between plain and JSON in the current case.

Quentin

