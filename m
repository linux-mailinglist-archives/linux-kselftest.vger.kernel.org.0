Return-Path: <linux-kselftest+bounces-31568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B79A9B294
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 17:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8DAA7AC2B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6946214A91;
	Thu, 24 Apr 2025 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heD40srs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9A1AA1E8;
	Thu, 24 Apr 2025 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509157; cv=none; b=hkKXMSaI8HeW6e+ez2patunV6TOqpxnWQcStGVcoyt92DPnYR+V/AIcDlXRCk3vPT2He3iBXJuCpyiFCPoPbXwIX5RM1GcbC7JpCf5hJl7V1ms7UPtqWvHI6X/zfRR0s7XvSqisDI5wW6iMctwicOxllEXFChjuZTEMu2YFvPeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509157; c=relaxed/simple;
	bh=bG/8KkN6g08cy15bXp7SU/ACSW5hKRw9IHiEHmSO58w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAlyjtTExOyvF/ocRuTvCEP57hI82s9B6Rojb6wglVUwOqPmw6g7BP7MINrytjBIi16MfKJ9FhrebUVj+Vy/6IkCc1yObl3iqfW5ftKbELCU6d7AOTPvHR8rTgMci2VJN0JK8szMxOtanfGf3elBvB+vsoHSmhuRF0OlbyCb2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heD40srs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03722C4CEEC;
	Thu, 24 Apr 2025 15:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745509157;
	bh=bG/8KkN6g08cy15bXp7SU/ACSW5hKRw9IHiEHmSO58w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=heD40srsNULa7S6ZUDtl7iM2UnAy9jC0BmBCAdtwpwi1GuLS0RMUOCjOGviqqkxvG
	 Dz81/PJ0XPdH9IFjNF9Oobg2UlMPSfcvJcz7gGJadUx4unyVFeJC2aZvEbTifyPrvI
	 Dc8tEjq+SlRvuekHUYJT4+JGEa+92Fz52mjnF3uvsDpyYhLupZqPuRkkNcKasCmZzi
	 dr7Ye1TB49rULcVUdYKjypzUn1gkyikwGZw+n8y+tuz1dDBsgifvwLRvlKIiz4r74u
	 QeJ1MaCtSjggBz73l7X82W0zdMjPRNPX5D7mBECj5bfeARxOQCiEpnVgF6chy97eHS
	 GUJD11dpRlaMw==
Message-ID: <783dacd8-6782-484a-8934-f4a5d20eeddb@kernel.org>
Date: Thu, 24 Apr 2025 17:39:10 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Allow XDP dev-bound programs to perform
 XDP_REDIRECT into maps
To: Lorenzo Bianconi <lorenzo@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/04/2025 19.44, Lorenzo Bianconi wrote:
> In the current implementation if the program is dev-bound to a specific
> device, it will not be possible to perform XDP_REDIRECT into a DEVMAP
> or CPUMAP even if the program is running in the driver NAPI context and
> it is not attached to any map entry. This seems in contrast with the
> explanation available in bpf_prog_map_compatible routine.
> Fix the issue introducing __bpf_prog_map_compatible utility routine in
> order to avoid bpf_prog_is_dev_bound() check running bpf_check_tail_call()
> at program load time (bpf_prog_select_runtime()).
> Continue forbidding to attach a dev-bound program to XDP maps
> (BPF_MAP_TYPE_PROG_ARRAY, BPF_MAP_TYPE_DEVMAP and BPF_MAP_TYPE_CPUMAP).
> 
> Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
> Signed-off-by: Lorenzo Bianconi<lorenzo@kernel.org>
> ---
> Changes in v2:
> - Introduce __bpf_prog_map_compatible() utility routine in order to skip
>    bpf_prog_is_dev_bound check in bpf_check_tail_call()
> - Extend xdp_metadata selftest
> - Link to v1:https://lore.kernel.org/r/20250422-xdp-prog-bound-fix-v1-1-0b581fa186fe@kernel.org
> ---
>   kernel/bpf/core.c                                  | 27 +++++++++++++---------
>   .../selftests/bpf/prog_tests/xdp_metadata.c        | 22 +++++++++++++++++-
>   tools/testing/selftests/bpf/progs/xdp_metadata.c   | 13 +++++++++++
>   3 files changed, 50 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ba6b6118cf504041278d05417c4212d57be6fca0..a3e571688421196c3ceaed62b3b59b62a0258a8c 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2358,8 +2358,8 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
>   	return 0;
>   }
>   
> -bool bpf_prog_map_compatible(struct bpf_map *map,
> -			     const struct bpf_prog *fp)
> +static bool __bpf_prog_map_compatible(struct bpf_map *map,
> +				      const struct bpf_prog *fp)
>   {
>   	enum bpf_prog_type prog_type = resolve_prog_type(fp);
>   	bool ret;
> @@ -2368,14 +2368,6 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
>   	if (fp->kprobe_override)
>   		return false;
>   
> -	/* XDP programs inserted into maps are not guaranteed to run on
> -	 * a particular netdev (and can run outside driver context entirely
> -	 * in the case of devmap and cpumap). Until device checks
> -	 * are implemented, prohibit adding dev-bound programs to program maps.
> -	 */
> -	if (bpf_prog_is_dev_bound(aux))
> -		return false;
> -
>   	spin_lock(&map->owner.lock);
>   	if (!map->owner.type) {
>   		/* There's no owner yet where we could check for
> @@ -2409,6 +2401,19 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
>   	return ret;
>   }
>   
> +bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_prog *fp)
> +{
> +	/* XDP programs inserted into maps are not guaranteed to run on
> +	 * a particular netdev (and can run outside driver context entirely
> +	 * in the case of devmap and cpumap). Until device checks
> +	 * are implemented, prohibit adding dev-bound programs to program maps.
> +	 */
> +	if (bpf_prog_is_dev_bound(fp->aux))
> +		return false;
> +
> +	return __bpf_prog_map_compatible(map, fp);
> +}
> +
>   static int bpf_check_tail_call(const struct bpf_prog *fp)
>   {
>   	struct bpf_prog_aux *aux = fp->aux;
> @@ -2421,7 +2426,7 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
>   		if (!map_type_contains_progs(map))
>   			continue;
>   
> -		if (!bpf_prog_map_compatible(map, fp)) {
> +		if (!__bpf_prog_map_compatible(map, fp)) {
>   			ret = -EINVAL;
>   			goto out;
>   		}

Does this change allow us to have a dev_bound BPF-prog that have
tail-call BPF-progs that are not dev_bound?

The use-case is a dev_bound BPF-prog that reads e.g. HW vlan, store this 
in data_meta (or a per CPU array), and then tail-calls another BPF-prog 
that reads the data stored (from data_meta area). Maybe this is already 
supported before?

--Jesper

