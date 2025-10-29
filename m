Return-Path: <linux-kselftest+bounces-44250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B2BC18073
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 03:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 648804EC424
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 02:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA6B21019E;
	Wed, 29 Oct 2025 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fSFw1/D1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA31D79BE;
	Wed, 29 Oct 2025 02:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704115; cv=none; b=q1p8wbjMU2G7nYpocWri81v6mZs/vrVZkFV16sDVWQ++WEDfIq+swGe5OYdEnSL7TGoX6LEiqulqTFRpfLZFYubIaUU/J+QKcD2PlaySwfkMQ/eNuSXizV30FpJDTlltvYL6lFl03LsN27/tRLlXvB7Q0iqCNxmy3zR9YUX61Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704115; c=relaxed/simple;
	bh=8YGz7lqyS4flzJFoggVq1hD4balsOdu4JDpSFQKNzbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USnxwPrxoRExBvLEzT3woCPpGzkhFNJ5JF0yqGyNaLaoYrZ0wUO0tRX7xGZ2v4yIUBGRXhlnCiLBAK4PPSxTpv5YLhvn8bqSCPBEMjKHRAJBN13ZW9vRLlSEQcI/T11XwnvZALwIvCRD7LgTPCbQZGGWqc0XZS/JHlCrMgEzkGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fSFw1/D1; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <89b12696-26ff-411f-9cd3-74361f0f1ecd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761704100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9job/jvG4C58SduYrTaDjtXzGn++ab/BkAHbh9PW2w=;
	b=fSFw1/D17X/l1FA7o9jDScOEmpSieR/DTdKgpwmBBEGCoISGWMIiu0CRhB28C8U/In/9sV
	+cv2qn7PXmW8AhcNx0w5Y9EZM+0s2cHyTHFDoRzr/SDS/cYCR7F2qu0wMMqrqQinE2mQLl
	WdsuJ4PBn61FUKgYI2BHqQLfmU2oc80=
Date: Tue, 28 Oct 2025 19:14:52 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251028125705.3586552-2-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/28/25 5:57 AM, Harshit Mogalapalli wrote:
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
>   tools/bpf/bpftool/map.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index c9de44a45778..b6580f25361d 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
>   	LIBBPF_OPTS(bpf_map_create_opts, attr);
>   	enum bpf_map_type map_type = BPF_MAP_TYPE_UNSPEC;
>   	__u32 key_size = 0, value_size = 0, max_entries = 0;
> +	struct bpf_map_info map_info = {};
> +	__u32 map_info_len = sizeof(map_info);
>   	const char *map_name = NULL;
>   	const char *pinfile;
>   	int err = -1, fd;
> @@ -1353,13 +1355,27 @@ static int do_create(int argc, char **argv)
>   	}
>   
>   	err = do_pin_fd(fd, pinfile);
> -	close(fd);
> -	if (err)
> +	if (err) {
> +		close(fd);

I think you can remove close(fd) here,

>   		goto exit;
> +	}
>   
> -	if (json_output)
> -		jsonw_null(json_wtr);
> +	err = bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> +	if (err) {
> +		p_err("Failed to fetch map info: %s\n", strerror(errno));
> +		close(fd);

and here

> +		goto exit;
> +	}
>   
> +	close(fd);

and here,

> +
> +	if (json_output) {
> +		jsonw_start_object(json_wtr);
> +		jsonw_int_field(json_wtr, "id", map_info.id);
> +		jsonw_end_object(json_wtr);
> +	} else {
> +		printf("Map successfully created with ID: %u\n", map_info.id);
> +	}
>   exit:

and put close(fd) here.

>   	if (attr.inner_map_fd > 0)
>   		close(attr.inner_map_fd);


