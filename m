Return-Path: <linux-kselftest+bounces-9030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6B58B5BF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 16:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A518A2874BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 14:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4E780022;
	Mon, 29 Apr 2024 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/Kv3oms"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03042535A2;
	Mon, 29 Apr 2024 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402320; cv=none; b=vF5R8nDVqXRegkjlBByV+3HGhf9D1tgFA87Xo2tIvcGl3t6qjrcxP5rSJeG87PeqSpMvhVmz+ayrtkrj92+j9Qmvm+Iw+vZ7CuVyKwIR0VGGOj8zd4AujA5s+/n84YwX1sV1kwgcNTUFCwtUOlRx1vlgfE1Nc5oezlITt/W1y68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402320; c=relaxed/simple;
	bh=KBmQLdrKWbY6Yx6w5tXJwf208CEEBKROzHu5YyBxMgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPa49bupL7NwzGkGfW3uRotUU6I5kIjGCw5FKfxkQas7bYM1b7xjFZCeYyitNV+tQbZxoYGvTrLg7j/F1lOwb90mRzKQYeKJ9wU/aqVbRmrPK/XTctIkjx+lLNx1z/8DyBnksIfnFwbIGMRmCTYH2xKjSDrQmJzBhI7COHzP/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/Kv3oms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419C6C113CD;
	Mon, 29 Apr 2024 14:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714402319;
	bh=KBmQLdrKWbY6Yx6w5tXJwf208CEEBKROzHu5YyBxMgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T/Kv3omsX8+ptGUwbwtEBOnHhbmbAvQGYAGI2KHBCP4lsnlZ0aGE7E2rPf78zp808
	 q5pe2u1pcfDIz6ykOtOKjmAyTsAkTRk8ryadYU3EsHJi2CfsvmkqLgqgU9i1Xv9b6N
	 PMUxvusxk4T30ueI38TqVcD6EAL8q6887xhtNdfyJ6JS0pJ3qaXoT+DBsuJTp4f470
	 qHlNDGkjDO/m+lwdYmKjNHNiKXWj31wl8iu5rGXV5dvE4wHAO1MoGbZOwNrz3KJyua
	 I0MU91vT1dIpifyatvHatcidZQcbe+M9ip6a5yMSqRP1x/tWtx2RPXpY/K2Gimz7zx
	 E+LQ9jfHc7pXw==
Date: Mon, 29 Apr 2024 07:51:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 6/6] selftests: drv-net-hw: add test for memory
 allocation failures with page pool
Message-ID: <20240429075158.51b3f8d6@kernel.org>
In-Reply-To: <662d0268e71c5_28b98529417@willemb.c.googlers.com.notmuch>
References: <20240426232400.624864-1-kuba@kernel.org>
	<20240426232400.624864-7-kuba@kernel.org>
	<662d0268e71c5_28b98529417@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Apr 2024 09:49:28 -0400 Willem de Bruijn wrote:
> Eventually probably want a more generic fault injection class.
> 
> And for both fault injection and background traffic the with object
> construct to ensure cleanup in all cases.
> 
> Maybe even the same for ethtool, as ip and ethtool config changes that
> need to be reverted to original state will be common.

Agreed, the nice way of wrapping all that has not revealed itself to me
yet. When we discussed it with Petr a while back he was suggesting
"with", and I was thinking of creating an object with test as the
parent. The with is nicer but here we'd end up doing:

	with a():
		# some code
		with b():
			# more code
				with c():
					# check traffic

which offends my sensibilities.

There are many options, hard to say which one is best without having 
a bunch of tests to convert as a litmus test :S So I stuck to "finally"

