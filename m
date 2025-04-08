Return-Path: <linux-kselftest+bounces-30322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE03EA7F269
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 03:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140043AC97E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 01:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1403F2744E;
	Tue,  8 Apr 2025 01:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAYeVy/o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4804243953;
	Tue,  8 Apr 2025 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744076611; cv=none; b=d3PGS+fAspcFx+06/T2S+73V/F8v50v6fAnaGxnYrxiPyIQ2/tJ5Z5CLROT/TK44GAsXAbJv7BrNiXJQB5Uj2jxrJXOOrPuF67s7eYswRbG29h6ZhnhJ6YKjN7YatbS33jDuPb5Q1OdW76MbZrYgefv5mDnyM/c89/yoWZjxQt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744076611; c=relaxed/simple;
	bh=LVDE8olUhIvfNM8yIe6JkU4em+QU0SCXxarI2iS1cj8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jFT+yaHwcicX9TBNp+e0XCynbtplJGduaoTnZQw7im4FEtxeZh7l9qg3SCPwwobiOqigGlxLwQ/gtqVOkb/dct3mQWUqkbTL0FsGKXsqT9KmKl9/Gzhi2qrPjxCFfqguzrtSzaNHR3RcKqPcg0V5CL7UGS4OG1wIaUqjAvhtWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAYeVy/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79044C4CEE8;
	Tue,  8 Apr 2025 01:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744076610;
	bh=LVDE8olUhIvfNM8yIe6JkU4em+QU0SCXxarI2iS1cj8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eAYeVy/oji6+e1wmExI6n/NK9RTbYlPhiAbSyZugg1Zo2BqeX8Hodn9JeEGnbYnEp
	 jC2aOE7Evekr7IMM3u9rlfZACVsUw5boFJCzB+xdOWsK1Iy0psbgFtlJkRevJpVRCV
	 SyaDiZ4+Aacfa6GQoDm25MvyWqnVd1icYXzDZexDtRa/joJ1BevNV8afq1Sf7c2jog
	 G/3wAwZ8mTaBUjtlIzZAiyWCYWa0S+Od8mVsKlnW742NBOnSCSHTEuwDJylB2Rmql+
	 IGALx9oxJHhyjAvrbU7J/pWBlTC2W2fXTlg6Z2odp4QAbE0MZL1ivDlXkOLKPzjSCl
	 PgPXNCOX+DQGg==
Message-ID: <ae367fb7158e2f1c284a4acaea86f96a7a95b0c4.camel@kernel.org>
Subject: Re: [PATCH] selftests: mptcp: add comment for getaddrinfo
From: Geliang Tang <geliang@kernel.org>
To: zhenwei pi <pizhenwei@bytedance.com>, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Cc: matttbe@kernel.org, martineau@kernel.org, viktor.soderqvist@est.tech, 
 zhenwei pi <zhenwei.pi@linux.dev>
Date: Tue, 08 Apr 2025 09:43:24 +0800
In-Reply-To: <20250407085122.1203489-1-pizhenwei@bytedance.com>
References: <20250407085122.1203489-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi zhenwei,

On Mon, 2025-04-07 at 16:51 +0800, zhenwei pi wrote:
> mptcp_connect.c is a startup tutorial of MPTCP programming, however
> there is a lack of ai_protocol(IPPROTO_MPTCP) usage. Add comment for
> getaddrinfo MPTCP support.
> 
> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index c83a8b47bbdf..6b9031273964 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -179,6 +179,18 @@ static void xgetnameinfo(const struct sockaddr
> *addr, socklen_t addrlen,
>  	}
>  }
>  
> +/* There is a lack of MPTCP support from glibc, these code leads
> error:
> + *	struct addrinfo hints = {
> + *		.ai_protocol = IPPROTO_MPTCP,
> + *		...
> + *	};
> + *	err = getaddrinfo(node, service, &hints, res);
> + *	...
> + * So using IPPROTO_TCP to resolve, and use TCP/MPTCP to create
> socket.
> + *
> + * glibc starts to support MPTCP since v2.42.
> + * Link:
> https://sourceware.org/git/?p=glibc.git;a=commit;h=a8e9022e0f82

Thanks for adding getaddrinfo mptcp support to glibc. I think we should
not only add a comment for getaddrinfo mptcp here, but also add an
example of using it in mptcp_connect.c. I will work with you to
implement this example in v2.

Thanks,
-Geliang

> + */
>  static void xgetaddrinfo(const char *node, const char *service,
>  			 const struct addrinfo *hints,
>  			 struct addrinfo **res)


