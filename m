Return-Path: <linux-kselftest+bounces-36473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 899B1AF7E5C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 19:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0479189461F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79C6258CF1;
	Thu,  3 Jul 2025 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPP1CG6N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAC92DE6E2;
	Thu,  3 Jul 2025 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751562289; cv=none; b=I79do1JhZM+qtUx3CLB0LF2hE3u8vBxw0DpGRfNvpRTcwIyPyrZ3ouzV7laQq3WCqckAqXiYE39l7j+O9sSKLWieNeqND0p+AZUdGs27xLW/0K1Y3JdDIHA7ejvQK2F5NR5AZ9T2puYCeEUi8I/D7N+RJB/OTuVGwJKBEUITA+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751562289; c=relaxed/simple;
	bh=bZcJzIvU2xfVHTfZc29TBf4+77DN+3g3AyZAs8mpWR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOKw372+XMI6pCSOypcoO4lzQXicgwlXkMkcxoOGB1Zqb6YiBRv0eUdoNBJGzzuhPHUHPrNc2+/0z/qQjN4rQsEphxDsJdylq4S5IMwNIKMjMQDt7j+bEkMXgHHy5ty+yD6RpvTe4EiQY/JomwuhksUXzgorzLdwORXb2ilVt4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPP1CG6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917CFC4CEE3;
	Thu,  3 Jul 2025 17:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751562289;
	bh=bZcJzIvU2xfVHTfZc29TBf4+77DN+3g3AyZAs8mpWR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RPP1CG6NuYbwA4N9BynixQ6y29XsBe7R2jABg659D4ywBgjQWLPIlELLEqj/5ryVR
	 6JWa0dLceCLaDEYMcHR/H8fAAJjhsWRlo+ilzipyataUNldg4FVI1OEx8g41zPjiwb
	 fBhtKzfXRqbV0NsR7wyvk51BndNAWE0jityG9Pv0Awlq6uotN0yvFIli1FEmWu/Sfx
	 kOwPI83tbecp0ZZGEorUK6nVj3n5dS9aN+UslhbuMzumHsK6Jn3vAxPTRyhvJwpUFS
	 ZhPKTiHQoNkikwDV+AiKJ15T6tAJ4Lg4i74Eq+IvfIKzekeBNX9YQOQBwrKbAdBsac
	 Et2kwFVCpYfSw==
Message-ID: <77463344-1b1a-443a-97be-a7ef8a88b8af@kernel.org>
Date: Thu, 3 Jul 2025 19:04:40 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next,v3 2/2] selftests/bpf: Enhance XDP Rx metadata
 handling
To: Song Yoong Siang <yoong.siang.song@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250702165757.3278625-1-yoong.siang.song@intel.com>
 <20250702165757.3278625-3-yoong.siang.song@intel.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250702165757.3278625-3-yoong.siang.song@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/07/2025 18.57, Song Yoong Siang wrote:
> Introduce the XDP_METADATA_SIZE macro as a conservative measure to
> accommodate any metadata areas reserved by Ethernet devices.
> 

This seems like a sloppy workaround :-(

To me, the problem arise because AF_XDP is lacking the ability to
communicate the size of the data_meta area.  If we had this capability,
then we could allow the IGC driver to take some of the space, have the
BPF-prog expand it futher (bpf_xdp_adjust_meta) and then userspace
AF_XDP would simply be able to see the size of the data_meta area, and
apply the struct xdp_meta at right offset.


> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 2 +-
>   tools/testing/selftests/bpf/progs/xdp_hw_metadata.c   | 2 +-
>   tools/testing/selftests/bpf/progs/xdp_metadata.c      | 2 +-
>   tools/testing/selftests/bpf/xdp_hw_metadata.c         | 2 +-
>   tools/testing/selftests/bpf/xdp_metadata.h            | 7 +++++++
>   5 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 19f92affc2da..8d6c2633698b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -302,7 +302,7 @@ static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
>   
>   	/* custom metadata */
>   
> -	meta = data - sizeof(struct xdp_meta);
> +	meta = data - XDP_METADATA_SIZE;
>   
>   	if (!ASSERT_NEQ(meta->rx_timestamp, 0, "rx_timestamp"))
>   		return -1;
> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> index 330ece2eabdb..3766f58d3486 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> @@ -72,7 +72,7 @@ int rx(struct xdp_md *ctx)
>   		return XDP_PASS;
>   	}
>   
> -	err = bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta));
> +	err = bpf_xdp_adjust_meta(ctx, -(int)XDP_METADATA_SIZE);
>   	if (err) {
>   		__sync_add_and_fetch(&pkts_fail, 1);
>   		return XDP_PASS;
> diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> index 09bb8a038d52..5cada85fe0f4 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> @@ -73,7 +73,7 @@ int rx(struct xdp_md *ctx)
>   
>   	/* Reserve enough for all custom metadata. */
>   
> -	ret = bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta));
> +	ret = bpf_xdp_adjust_meta(ctx, -(int)XDP_METADATA_SIZE);
>   	if (ret != 0)
>   		return XDP_DROP;
>   
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> index 3d8de0d4c96a..a529d55d4ff4 100644
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -223,7 +223,7 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
>   {
>   	struct xdp_meta *meta;
>   
> -	meta = data - sizeof(*meta);
> +	meta = data - XDP_METADATA_SIZE;
>   
>   	if (meta->hint_valid & XDP_META_FIELD_RSS)
>   		printf("rx_hash: 0x%X with RSS type:0x%X\n",
> diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
> index 87318ad1117a..2dfd3bf5e7bb 100644
> --- a/tools/testing/selftests/bpf/xdp_metadata.h
> +++ b/tools/testing/selftests/bpf/xdp_metadata.h
> @@ -50,3 +50,10 @@ struct xdp_meta {
>   	};
>   	enum xdp_meta_field hint_valid;
>   };
> +
> +/* XDP_METADATA_SIZE must be at least the size of struct xdp_meta. An additional
> + * 32 bytes of padding is included as a conservative measure to accommodate any
> + * metadata areas reserved by Ethernet devices. If the device-reserved metadata
> + * exceeds 32 bytes, this value will need adjustment.
> + */
> +#define XDP_METADATA_SIZE	(sizeof(struct xdp_meta) + 32)

