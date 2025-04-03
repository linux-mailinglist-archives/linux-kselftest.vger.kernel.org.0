Return-Path: <linux-kselftest+bounces-30046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DE9A79DD1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 10:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B7F7A5E8B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 08:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A8E1DE3A0;
	Thu,  3 Apr 2025 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tav1fUh6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202F21854;
	Thu,  3 Apr 2025 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668235; cv=none; b=gF4+4npLemMmsU5gQb5cryYgnwlgflKImgmn0tmOGWpfXi74XlNZmqIlxqMAs6P0k9zcZG//occ07PXxyC+Kgcm1SIZSQMHpzsjSvuq1PVMwjc6YhZqgdj0Eq0I6avP2Cv5QBN/Lub6uaLjbKPhCWj3PoJ0/pVMb4nyQAdiFejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668235; c=relaxed/simple;
	bh=NH6Xl6My3uB8VV7ts3K3V3CB2w3gDVGSyxth+G2YtOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8TNRp3H8Ps+Q05EevGRrfbT9R6cbDnREmyqHC1HE3zB1LNJ96ji65K1Zwx/Qg8rNYDgh3TM4e093mTfUAZZR0/Mt4yo2Ep6nL4X8L1xSLpbEA7p3TXwOUi++/2kzsIxjHH7H17RB0Qkh491ou8tzg5IK30umRd+J4ZZax/qWjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tav1fUh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B72C4CEE3;
	Thu,  3 Apr 2025 08:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743668234;
	bh=NH6Xl6My3uB8VV7ts3K3V3CB2w3gDVGSyxth+G2YtOA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Tav1fUh6tkOTHKpkrkVLElZqk32bmwq6XVYJI7Z0Amp2fEqeapHSbiPFOpzZukK1m
	 pcsOAfZoXS2U0/dbqS3VwoaJP7V79/pu/anR5KyQfmMqyql486AHPXIBYgbyBedI4P
	 slUtZguyHTw1V0Hw5EAinpRnK175mvTcUutIPJFjXLw/5Fdk/x22EyN9wteAhjtjaz
	 JMa6ec/yXiOjIh/jFKfNVn3VpUcnoAVWRFPaU3Bl9H2I2gt36is+zDtpYb9/U6JbcL
	 Gp60qiiBC53h1D3EpT/aB7iWMSmlyzfIA6YL7s+SOHNq4eBe55Jzs9QI5eK2pelXVL
	 TH5977Wmx9M/A==
Message-ID: <75f49cbc-2d54-480e-b67d-35ef53c4421b@kernel.org>
Date: Thu, 3 Apr 2025 10:17:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/2] bpf, xdp: clean head/meta when expanding it
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: mrpre@163.com, syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Jason Xing
 <kerneljasonxing@gmail.com>, Anton Protopopov <aspsk@isovalent.com>,
 Abhishek Chauhan <quic_abchauha@quicinc.com>,
 Jordan Rome <linux@jordanrome.com>,
 Martin Kelly <martin.kelly@crowdstrike.com>,
 David Lechner <dlechner@baylibre.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250331032354.75808-1-jiayuan.chen@linux.dev>
 <20250331032354.75808-2-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250331032354.75808-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/03/2025 05.23, Jiayuan Chen wrote:
> The device allocates an skb, it additionally allocates a prepad size
> (usually equal to NET_SKB_PAD or XDP_PACKET_HEADROOM) but leaves it
> uninitialized.
> 
> The bpf_xdp_adjust_head function moves skb->data forward, which allows
> users to access data belonging to other programs, posing a security risk.

I find your description confusing, and it needs to be improved to avoid 
people interpenetrating this when reading the commit log in the future.

It is part of the UAPI that BPF programs access data belonging to other 
BPF programs.  It is the concept behind data_meta, e.g. that XDP set 
information in this memory and TC-BPF reads it again (chained XDP progs 
also have R/W access).  I hope/assume this is not the desired 
interpretation of your text.

I guess you want to say, that the intention is to avoid BPF programs 
accessing uninitialized data?
(... which is also what the code does at a glance)

> Reported-by: syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/00000000000067f65105edbd295d@google.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>   include/uapi/linux/bpf.h       | 8 +++++---
>   net/core/filter.c              | 5 ++++-
>   tools/include/uapi/linux/bpf.h | 6 ++++--
>   3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index defa5bb881f4..be01a848cbbf 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2760,8 +2760,9 @@ union bpf_attr {
>    *
>    * long bpf_xdp_adjust_head(struct xdp_buff *xdp_md, int delta)
>    * 	Description
> - * 		Adjust (move) *xdp_md*\ **->data** by *delta* bytes. Note that
> - * 		it is possible to use a negative value for *delta*. This helper
> + *		Adjust (move) *xdp_md*\ **->data** by *delta* bytes. Note that
> + *		it is possible to use a negative value for *delta*. If *delta*
> + *		is negative, the new header will be memset to zero. This helper
>    * 		can be used to prepare the packet for pushing or popping
>    * 		headers.
>    *
> @@ -2989,7 +2990,8 @@ union bpf_attr {
>    * long bpf_xdp_adjust_meta(struct xdp_buff *xdp_md, int delta)
>    * 	Description
>    * 		Adjust the address pointed by *xdp_md*\ **->data_meta** by
> - * 		*delta* (which can be positive or negative). Note that this
> + *		*delta* (which can be positive or negative). If *delta* is
> + *		negative, the new meta will be memset to zero. Note that this
>    * 		operation modifies the address stored in *xdp_md*\ **->data**,
>    * 		so the latter must be loaded only after the helper has been
>    * 		called.
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 46ae8eb7a03c..5f01d373b719 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3947,6 +3947,8 @@ BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff *, xdp, int, offset)
>   	if (metalen)
>   		memmove(xdp->data_meta + offset,
>   			xdp->data_meta, metalen);
> +	if (offset < 0)
> +		memset(data, 0, -offset);
>   	xdp->data_meta += offset;
>   	xdp->data = data;
>   
> @@ -4239,7 +4241,8 @@ BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff *, xdp, int, offset)
>   		return -EINVAL;
>   	if (unlikely(xdp_metalen_invalid(metalen)))
>   		return -EACCES;
> -
> +	if (offset < 0)
> +		memset(meta, 0, -offset);
>   	xdp->data_meta = meta;
>   
>   	return 0;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index defa5bb881f4..7b1871f2eccf 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -2761,7 +2761,8 @@ union bpf_attr {
>    * long bpf_xdp_adjust_head(struct xdp_buff *xdp_md, int delta)
>    * 	Description
>    * 		Adjust (move) *xdp_md*\ **->data** by *delta* bytes. Note that
> - * 		it is possible to use a negative value for *delta*. This helper
> + *		it is possible to use a negative value for *delta*. If *delta*
> + *		is negative, the new header will be memset to zero. This helper
>    * 		can be used to prepare the packet for pushing or popping
>    * 		headers.
>    *
> @@ -2989,7 +2990,8 @@ union bpf_attr {
>    * long bpf_xdp_adjust_meta(struct xdp_buff *xdp_md, int delta)
>    * 	Description
>    * 		Adjust the address pointed by *xdp_md*\ **->data_meta** by
> - * 		*delta* (which can be positive or negative). Note that this
> + *		*delta* (which can be positive or negative). If *delta* is
> + *		negative, the new meta will be memset to zero. Note that this
>    * 		operation modifies the address stored in *xdp_md*\ **->data**,
>    * 		so the latter must be loaded only after the helper has been
>    * 		called.

