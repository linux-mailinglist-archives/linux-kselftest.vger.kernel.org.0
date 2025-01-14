Return-Path: <linux-kselftest+bounces-24456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F262AA10BA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 17:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1242F162E1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 16:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7911607B4;
	Tue, 14 Jan 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuzlAxtP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543A423245B;
	Tue, 14 Jan 2025 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870491; cv=none; b=ovn5W7bBZA2GlaXOHiq/X85v8ELgS5FRnwzEh77VTlkUN/qN90nObBKD2JypCVQlWtVJgd3ohBJlplgKBiBr2kjp2kkUmaU42wJZGO7zqgKDFA6TCPX7JrWW2SxO6+u7jXrm05/JJdwU9BXRgYEtc/oHJVVTTbpP8DgCyCg+Bbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870491; c=relaxed/simple;
	bh=E8wcpjjKxN7PZVun6ZJh8nh0xfl0Xq+7Y2b5W/LB6Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcoSlnWs4dXKS27zWZMwNfvHSM1tjyVBJBJpc16h1cU7+1pZL3IpMjCuz7it/OlA0sYw3oGUV8j5F06xuV2FmibTu82P7ZY5+jneRe5idH2cpqm4ad/KUtOpk4ZUEXejG9gw9HhIWZdUWXPVY+9kQOJYui1MF+5y1SAfRJ+Dv+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuzlAxtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFC2C4CEDD;
	Tue, 14 Jan 2025 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736870490;
	bh=E8wcpjjKxN7PZVun6ZJh8nh0xfl0Xq+7Y2b5W/LB6Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AuzlAxtPa0Dpbiu6IjvXMxWxUBMJoXBDdn/xIPjpetDsAO4dnL8MsnlfeSHqNQKpI
	 ME8bAb5cs8MdpD1BfNFyhxOODcUnbN0PfQrRdyw4brCOQagyrJSbffTrxMNgrsMABF
	 834gfE/WS6MEG/CFTsS7lOA+ZsTMblSVwDOYcu1OFtcbHtJMht0SBqyxfNQBh+vL1D
	 0CnDue/yWcyYK2WjnBsRwIyx6cGLFkf0K3oiIctAImunLgW+Vb0L35JoJUGtIja2+r
	 DRI7c8Jw1Dkvf94d8cX/TadjUAi8Ja1TB+x0AJneGKoYu8FGFKrEl3vn4MgesDUDVr
	 4G5DLvWePvIKg==
Date: Tue, 14 Jan 2025 16:01:26 +0000
From: Simon Horman <horms@kernel.org>
To: liuye <liuye@kylinos.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net/ipsec: Fix Null pointer dereference in
 rtattr_pack()
Message-ID: <20250114160126.GJ5497@kernel.org>
References: <20250114074329.102691-1-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114074329.102691-1-liuye@kylinos.cn>

On Tue, Jan 14, 2025 at 03:43:29PM +0800, liuye wrote:
>     Fix the following warning.

I think it is a bit more than a warning, I'd phrase this more like,
even as it repeats the subject. Also, it would be nice to cite
the tool that generates the warning.

Address Null pointer dereference in rtattr_pack.

Flagged by ??? as:

> 
>     tools/testing/selftests/net/ipsec.c:230:25: warning: Possible null pointer
>     dereference: payload [nullPointer]
>     memcpy(RTA_DATA(attr), payload, size);
>                            ^
>     tools/testing/selftests/net/ipsec.c:1618:54: note: Calling function 'rtattr_pack',
>     4th argument 'NULL' value is 0
>     if (rtattr_pack(&req.nh, sizeof(req), XFRMA_IF_ID, NULL, 0)) {
>                                                        ^
>     tools/testing/selftests/net/ipsec.c:230:25: note: Null pointer dereference
>     memcpy(RTA_DATA(attr), payload, size);
>                            ^
> 

And I wonder if a fixes tag is appropriate, and if so this one:

70bfdf62e93a ("selftests/net/ipsec: Add test for xfrm_spdattr_type_t")

And, accordingly if this patch should be targeted at net:

	[PATCH net] ...

> Signed-off-by: liuye <liuye@kylinos.cn>

Please consider separating out your family and given name in hte
signed-off-by line. Perhaps Lin Ye (apologies if that is incorrect).

The above not withstanding, the code change looks good to me.
So feel free to include the following in a v2 with an updated patch
description.

> ---
>  tools/testing/selftests/net/ipsec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
> index be4a30a0d02a..725310ac26a9 100644
> --- a/tools/testing/selftests/net/ipsec.c
> +++ b/tools/testing/selftests/net/ipsec.c
> @@ -227,7 +227,8 @@ static int rtattr_pack(struct nlmsghdr *nh, size_t req_sz,
>  
>  	attr->rta_len = RTA_LENGTH(size);
>  	attr->rta_type = rta_type;
> -	memcpy(RTA_DATA(attr), payload, size);
> +	if (payload != NULL)

I think it would be more idiomatic to express this as:

	if (payload)

> +		memcpy(RTA_DATA(attr), payload, size);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 

