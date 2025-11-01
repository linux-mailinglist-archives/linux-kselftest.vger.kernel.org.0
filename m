Return-Path: <linux-kselftest+bounces-44577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA6CC28375
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 17:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 795234E4BAD
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 16:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32272777FE;
	Sat,  1 Nov 2025 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYtt9HRo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814B26B2D7;
	Sat,  1 Nov 2025 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762016356; cv=none; b=s+gZLC9fW+E9+Epa+KIaSoX5GrqGvvjw4QJIniW9Ju2QZ13VK7/gMWwmiasZAzcfsV7WWvFSntTKgL17p8suGhSqvPntRN/+9fyrHumotKYimRtNCDU9hhtpUAO2LA2mmBDsODBYPUB/Ao25fvCFOVyA7qbVHc7uz2bRnkH7PKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762016356; c=relaxed/simple;
	bh=fZNP1sbca0hHbjGKwT2QW+jj0sSNiindhgIlP47cyro=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iyk9hJS1QdR2wOdOWv1Ij2wZOvHlxB+P7A83qRI9Of2q7rxVKRZEpRUBXuAj22PG84HnFDQoCvOwv6RFPPTi3OWxzLQ1SC4tUCaozSq4KKG+PaL0d1OjJpVmCAAm75sjGsjgQHQiD5ZWu6QtcNXiFEtBd0HLbd7O2GkoBEYR7BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYtt9HRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA643C4CEF1;
	Sat,  1 Nov 2025 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762016356;
	bh=fZNP1sbca0hHbjGKwT2QW+jj0sSNiindhgIlP47cyro=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=kYtt9HRo51fGJDd6qk7HAjkzwkGRt0kyb9hYrfv4pcgs9FioFpo83+AMUBguoXADN
	 E8GhiWUUS//g7zUEZWVDPpIRnhIPb9mmCAkq32Hf/REHoLbG9m9dltWWKjsWP19Goa
	 JgQdPsxJB+tMp8EkIKHVDSvW8QxdGcMtSY1KJsT2vKRD3bG/GH38PxTTEC+dFkwBp7
	 /FElvcR9ihqwFcZyqNqx3QvdlcbXOO9lfx4XmQ1Go2JZLAl41v38YwWhlyPFDf7eYX
	 LzcT/FXVyhRf851vmkXRWfQBK/pbNACRK6K9XB7/iiPkyS9Pu3B2vc7LylldFtGC2t
	 T90/xJ6LCqbNw==
Message-ID: <d9baed0b-c272-4970-8a46-87f12757ee87@kernel.org>
Date: Sat, 1 Nov 2025 16:59:11 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v2 1/2] bpftool: Print map ID upon creation and support
 JSON output
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 bpf@vger.kernel.org
Cc: alan.maguire@oracle.com, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251030210655.3938262-1-harshit.m.mogalapalli@oracle.com>
 <20251030210655.3938262-2-harshit.m.mogalapalli@oracle.com>
Content-Language: en-GB
In-Reply-To: <20251030210655.3938262-2-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-10-30 14:06 UTC-0700 ~ Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com>
> It is useful to print map ID on successful creation.
> 
> JSON case:
> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 value 8 entries 128 name map4
> {"id":12}
> 
> Generic case:
> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 8 entries 128 name map5
> Map successfully created with ID: 15
> 
> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
>  tools/bpf/bpftool/map.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index c9de44a45778..80c96b33b553 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
>  	LIBBPF_OPTS(bpf_map_create_opts, attr);
>  	enum bpf_map_type map_type = BPF_MAP_TYPE_UNSPEC;
>  	__u32 key_size = 0, value_size = 0, max_entries = 0;
> +	struct bpf_map_info map_info = {};
> +	__u32 map_info_len = sizeof(map_info);
>  	const char *map_name = NULL;
>  	const char *pinfile;
>  	int err = -1, fd;
> @@ -1353,13 +1355,24 @@ static int do_create(int argc, char **argv)
>  	}
>  
>  	err = do_pin_fd(fd, pinfile);
> -	close(fd);
>  	if (err)
> -		goto exit;
> +		goto close_fd;
>  
> -	if (json_output)
> -		jsonw_null(json_wtr);
> +	err = bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> +	if (err) {
> +		p_err("Failed to fetch map info: %s\n", strerror(errno));


Nit: Please remove the line break ('\n') here, p_err() already adds it.


> +		goto close_fd;
> +	}
>  
> +	if (json_output) {
> +		jsonw_start_object(json_wtr);
> +		jsonw_int_field(json_wtr, "id", map_info.id);
> +		jsonw_end_object(json_wtr);


I've been wondering if we should have some parent object like
'{"map_created": { "id": 15 }}' in case we later add more output, but I
can't really see a good use case at the moment, I'm probably
overthinking it... So I'm good with the current output. Thanks for this!

With the line break removed:

Reviewed-by: Quentin Monnet <qmo@kernel.org>

