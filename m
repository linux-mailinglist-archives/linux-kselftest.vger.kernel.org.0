Return-Path: <linux-kselftest+bounces-46765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE32C95188
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 16:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F419A4E0230
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C07270553;
	Sun, 30 Nov 2025 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkDUqyZS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5718A6B0;
	Sun, 30 Nov 2025 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764516846; cv=none; b=CZdj/JQxDX+ik2JFVa2n+hSNCOn6GzHLL+3X3HgsX2gOL3lI7B+blEMD6oO3RDtu7PX6MJ1CjeY7DK4wm07aO19D5+tNcKTutkCeWBDO7rKbX+TDp39n9kQmgzH8aW3/gsTnAJYCXhmBk8+qwlj+wLCs9Nupcus68TobQQE+2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764516846; c=relaxed/simple;
	bh=qzOr5H2XZZfCU2NX5lz1FYoqRZZJK08aRkmlkx95/Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZnQ8xcTiTyK2AB8FSoDAJVpnsOq2ntsHlkSsgTJDOe+DYu4qX+MAcN6wWPljrO1TTET4oOcp3WbHf4IGmP4yq7A9dOZPTM/lNIEUUqZe6815UJGsYTXqvWYazH8/xX6CrRf0stUoAQDoBRv2Ox0zwCnbaCuUIrBdsrAg1ZInt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkDUqyZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7651C4CEF8;
	Sun, 30 Nov 2025 15:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764516846;
	bh=qzOr5H2XZZfCU2NX5lz1FYoqRZZJK08aRkmlkx95/Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QkDUqyZSycOnihLk92ndnlRaA8gKMFi93iDBwzsGeGmly4st/fIxPsnnxt0TvnJBY
	 5gOl9osOKHcd8c0m8KE+tTD3Xc5E3gXZLi6ve4dwcpIbugmk0o+DbAuF6V12sKlOZZ
	 NjYqdTuxlJ5VYBQQlqCr50Ku/gyNsuofBu50cY4w9M/p0U5l1BUWDMNqJzVXdEHtPw
	 do99bi6vvnCZq04MsWtzI6MbqT44dvC9ePLaRkju6x+aOfx8ZYaavmIbGHnsBQj7PJ
	 LrkwJmjyTQGe6dzwR9ZffrS7dp/00c31GKZVknSmKNfpqWhqBqpH5yIsL0d1qYClJB
	 GOdaka6VRtgrg==
Date: Sun, 30 Nov 2025 15:34:00 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org,
	kernel-team@meta.com, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH net-next 0/4] (no cover subject)
Message-ID: <aSxj6BFgfdPyUwD0@horms.kernel.org>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>

On Fri, Nov 28, 2025 at 06:20:45AM -0800, Breno Leitao wrote:
> This patch series introduces a new configfs attribute that enables sending
> messages directly through netconsole without going through the kernel's logging
> infrastructure.

Minor nit:

Hi Breno,

The patchset looks good to me.
But the cover-letter (this email) has no subject.

