Return-Path: <linux-kselftest+bounces-40062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C61FBB38794
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 18:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6721C20EE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F170341ACA;
	Wed, 27 Aug 2025 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vA5PCl5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE533EB16;
	Wed, 27 Aug 2025 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311154; cv=none; b=sZNZVtvVtIXsKMz1nhPjkWyhwnbqDcIZxpeEr5xzlJpCs/HJsm56dmJoaae68oLgba1CIQYau94gB9WO73liSFJyfSEGwbFB3J9mcuZuHN2VpVZyuDLV3ca4oCiUT/Htup9Vgl9XuHgpjIbUhWZXuDXvw4rpCpRfjS6ML4A8ZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311154; c=relaxed/simple;
	bh=qLmoUN8pwZB6Pe4SuUfEejK8uGiXnbsyQCY4qM2GGq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+9QSlM/5z+9C/6Zt7cFPOQMLcHcuHTWQs3TBZVTanuWHFBAGKiE+2C6A6m69YoMecrmAduMD8QG5wO/50CcLTL5YRsUZFjorwBzWCLDoUWX3+fH+Qow1KPtdXM7TG2bVnOs4XsbVk4IOXnDlZdo7VB2k7Iz8P1z+ZL+3Xff/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vA5PCl5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC29C4CEEB;
	Wed, 27 Aug 2025 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756311154;
	bh=qLmoUN8pwZB6Pe4SuUfEejK8uGiXnbsyQCY4qM2GGq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vA5PCl5IUlRTONlf5xK/Q0D5mOJVEzFGA95s+sLo0f+SWqMv+G0lZFnN/o/0I6M4E
	 7tUDl3+yAhXBJrUzYS63xE+arLgCNEgT+F41hAhG6hjuhVRGGi/gWmnhWjD+MSvYlN
	 8qsOLF6DbfSM6YMX1sz70JObXV6r4LULEqi5P2gYaUTAleWGwI6JC6kMrJ2eDp7BFz
	 G6meHQtXOopAy1ZdThk+75eXSdZFSQJjtEZvDQJUJXhnsCgTl5xEfWwNc/1CEP9qOY
	 Wow5GSCbujQHqC7ElFL0cfyX0R+ftUI5CKqr/1T5MrW8D3+0YFy0iMiiALB5SpDUWM
	 jpJp3sU0lB9fQ==
Date: Wed, 27 Aug 2025 17:12:30 +0100
From: Simon Horman <horms@kernel.org>
To: Zongmin Zhou <min_halo@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: Re: [PATCH] selftests: net: avoid memory leak
Message-ID: <20250827161230.GB10519@horms.kernel.org>
References: <20250826031540.28010-1-min_halo@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826031540.28010-1-min_halo@163.com>

On Tue, Aug 26, 2025 at 11:15:40AM +0800, Zongmin Zhou wrote:
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> The buffer be used without free,fix it to avoid memory leak.

I'm assuming this is a short-lived user-space program.
And any memory is freed when it exits.
So I'm unsure about the value of this change.

> 
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> ---
>  tools/testing/selftests/net/cmsg_sender.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
> index a825e628aee7..5358aa09ecb9 100644
> --- a/tools/testing/selftests/net/cmsg_sender.c
> +++ b/tools/testing/selftests/net/cmsg_sender.c
> @@ -491,6 +491,7 @@ int main(int argc, char *argv[])
>  	if (err) {
>  		fprintf(stderr, "Can't resolve address [%s]:%s\n",
>  			opt.host, opt.service);
> +		free(buf);
>  		return ERN_SOCK_CREATE;
>  	}
>  
> @@ -501,6 +502,7 @@ int main(int argc, char *argv[])
>  	if (fd < 0) {
>  		fprintf(stderr, "Can't open socket: %s\n", strerror(errno));
>  		freeaddrinfo(ai);
> +		free(buf);
>  		return ERN_RESOLVE;
>  	}
>  
> @@ -575,5 +577,6 @@ int main(int argc, char *argv[])
>  err_out:
>  	close(fd);
>  	freeaddrinfo(ai);

I think it would be nicer to add another label here, say err_free_buff,
and then use it in the previous two hunks.

> +	free(buf);
>  	return err;
>  }
> -- 
> 2.34.1
> 

