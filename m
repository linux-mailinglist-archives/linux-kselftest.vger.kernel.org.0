Return-Path: <linux-kselftest+bounces-23109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 070D09EB6FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 17:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104211885CEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01646234991;
	Tue, 10 Dec 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuvuqV7t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357122FE15;
	Tue, 10 Dec 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849240; cv=none; b=VbCqa6IMw8vB2BAIXuqPszmXPy+uiG9gi73fdRafhKo+y6VEe3OFZSwxEESUEEvopOw82a02zssc6rLZURcmlwxr7Q01hLXWcw9yL5/aJ3FvKcVhKSMzW52YaQ4ghj8fF7touZ/+5xLff27VOwnTlxupw8LOcpfGfd6JFZ4glLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849240; c=relaxed/simple;
	bh=4E9UcODkTzlnyGiPllZZQKei0tJHJsIeAjz2mpZXrRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtR/8WZro42aS4QiIYtanrOVfP1ZlUdyqiBPTXG3+ghCl+oCSROZB2dT5xoFOILp3IjfAxihzJ/LlWCSfPgpQhyiRtqr6nND7+VK0TpfB0RkqJqbe7rcv2INSbGL8jTdgIAx4wZAfELZdsYVsnZ9lus2PgMSKLQGSvYuBMgMonY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuvuqV7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D612CC4CED6;
	Tue, 10 Dec 2024 16:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733849240;
	bh=4E9UcODkTzlnyGiPllZZQKei0tJHJsIeAjz2mpZXrRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EuvuqV7tAVz0qYUrGDkvAsVdXoqVlXgN1uHc3AYDFjn4gLa5G49CW6zCYgoACSFq2
	 3XvCr6PDbntNHGIbsijHV5WJfDESAzkY7hOVaz3YCbQ8FB8wumufPp/3QnGPD7Uh0x
	 xDOzSeUTGZivQRLYQZPL4+sCJdmWvXD8i4gacIZzGzOtaShGesrrSw4t/wHtFvAtRE
	 OLQ6Qn+pB/4z9xVqwD9QCrTn/SGfdxaMYrHehb2fycW9/Uk+joKzoX99k6W23kK1n6
	 hrkday/yS2kae5L2QSe4QATKZzFzkzRg6+ihkM9c8jvw6cVNm/oTLcTQ3iHWMHxF03
	 tl/lDKClYjZcQ==
Date: Tue, 10 Dec 2024 16:47:15 +0000
From: Simon Horman <horms@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
	ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH net-next v14 22/22] testing/selftests: add test tool and
 scripts for ovpn module
Message-ID: <20241210164715.GB6554@kernel.org>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
 <20241209-b4-ovpn-v14-22-ea243cf16417@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-b4-ovpn-v14-22-ea243cf16417@openvpn.net>

On Mon, Dec 09, 2024 at 09:53:31AM +0100, Antonio Quartulli wrote:
> The ovpn-cli tool can be compiled and used as selftest for the ovpn
> kernel module.
> 
> [NOTE: it depends on libmedtls for decoding base64-encoded keys]
> 
> ovpn-cli implements the netlink and RTNL APIs and can thus be integrated
> in any script for more automated testing.
> 
> Along with the tool, 4 scripts are provided that perform basic
> functionality tests by means of network namespaces.
> These scripts take part to the kselftest automation.
> 
> The output of the scripts, which will appear in the kselftest
> reports, is a list of steps performed by the scripts plus some
> output coming from the execution of `ping`, `iperf` and `ovpn-cli`
> itself.
> In general it is useful only in case of failure, in order to
> understand which step has failed and why.
> 
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

...

> +/**
> + * Helper function used to easily add attributes to a rtnl message
> + */

Hi Antonio,

This comment starts with a '/**' but is otherwise not formatted as
a Kernel doc. Probably it is best to simply start the comment with '/*'.

Likewise elsewhere in this patch.

Flagged by ./scripts/kernel-doc -none

> +static int ovpn_addattr(struct nlmsghdr *n, int maxlen, int type,
> +			const void *data, int alen)

...

