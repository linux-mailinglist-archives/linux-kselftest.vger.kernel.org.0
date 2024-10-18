Return-Path: <linux-kselftest+bounces-20137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEE19A3E6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 14:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E4FFB21D12
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 12:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9B822EEF;
	Fri, 18 Oct 2024 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtzUUyeC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E38CF9F8;
	Fri, 18 Oct 2024 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254599; cv=none; b=sC/OeJiQsM2sIZwWNQcjAWkGNoQC/YMneNgskVs7Al9hb7i18NlRb3wK8YyTJfKWvsqd21f1vd5Rw6UqjdmAHEOKqPlFF/CnKsy2O6nvlHK6tlFgn2yt3O+qv9MN7OddKMZojfNShsot67Z17YEnSjAdMIkwgmXql/tHsrh0PFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254599; c=relaxed/simple;
	bh=HLjQKmdaYxfy+8LnQVOaIQoMvuAC/MShmNTH0mnP6Gc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Vc09TVFW5YC/CEvtPwL1uK0uE0B6NtsZi8NiScVvXEiUiJdWykpstpmfYWlrrqfbTVw3OoWE/j72haPFRulvLOxEVLEvqaSrm7c97gT3AL7bjkYPg9Od5M5bWkO3FldjplPk+1pnD3/DhbVzUTk5YS/urDX+6wQ5gfOMrOzuG6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtzUUyeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36102C4CEC3;
	Fri, 18 Oct 2024 12:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729254598;
	bh=HLjQKmdaYxfy+8LnQVOaIQoMvuAC/MShmNTH0mnP6Gc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=DtzUUyeC51vOuVASHib2mwMSVPbHWlCu+bBFYRxWb4UZ1KQfm2d7Uc5EDuyXxLlKY
	 iiLRvAjSAO5ved8NR3eTX6agpPgc8YjkaoYEawUOJ/ovaSQkN/lWu9WPorgJbRnLji
	 xTz6mqx+/CIeqgQzqKAfN9IscOMwO5hqOBvGu/k4gmDezNkBYmfn+ea7h1bZJpCPiK
	 gL2ZgrBirQSNz0fMyZC1jMDDxGJqnbICpLBQfIqcXbfV59+Uv5u/e2OF2Nv/yqBtJP
	 Unur8Md4EKLJyTdEfN+udx93z9JLR6JILhEJh8RkoLU8AFBIZ1PP5FQiog/cdl9kJr
	 QmFHozuTcbQGg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241017072534.127519-1-liujing@cmss.chinamobile.com>
References: <20241017072534.127519-1-liujing@cmss.chinamobile.com>
Subject: Re: [PATCH] selftests: netfilter: remove unused rplnlh parameter
From: Antoine Tenart <atenart@kernel.org>
Cc: kadlec@netfilter.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Liu Jing <liujing@cmss.chinamobile.com>
To: Liu Jing <liujing@cmss.chinamobile.com>, pablo@netfilter.org
Date: Fri, 18 Oct 2024 14:29:54 +0200
Message-ID: <172925459485.589680.8839743987026835475@kwain.local>

Quoting Liu Jing (2024-10-17 09:25:34)
> The rplnlh parameter is not used in many functions, so delete it.
>=20
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/net/netfilter/conntrack_dump_flush.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c=
 b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
> index bd9317bf5ada..e03ddc60b5d4 100644
> --- a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
> +++ b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
> @@ -96,7 +96,6 @@ static int conntrack_data_insert(struct mnl_socket *soc=
k, struct nlmsghdr *nlh,
>                                  uint16_t zone)
>  {
>         char buf[MNL_SOCKET_BUFFER_SIZE];
> -       struct nlmsghdr *rplnlh;
>         unsigned int portid;
>         int err, ret;

While at it, it seems 'err' is not used as well. In the two other
functions as well.

Thanks!
Antoine

> @@ -212,7 +211,7 @@ static int count_entries(const struct nlmsghdr *nlh, =
void *data)
>  static int conntracK_count_zone(struct mnl_socket *sock, uint16_t zone)
>  {
>         char buf[MNL_SOCKET_BUFFER_SIZE];
> -       struct nlmsghdr *nlh, *rplnlh;
> +       struct nlmsghdr *nlh;
>         struct nfgenmsg *nfh;
>         struct nlattr *nest;
>         unsigned int portid;
> @@ -259,7 +258,7 @@ static int conntracK_count_zone(struct mnl_socket *so=
ck, uint16_t zone)
>  static int conntrack_flush_zone(struct mnl_socket *sock, uint16_t zone)
>  {
>         char buf[MNL_SOCKET_BUFFER_SIZE];
> -       struct nlmsghdr *nlh, *rplnlh;
> +       struct nlmsghdr *nlh;
>         struct nfgenmsg *nfh;
>         struct nlattr *nest;
>         unsigned int portid;

