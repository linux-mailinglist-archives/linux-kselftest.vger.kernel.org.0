Return-Path: <linux-kselftest+bounces-44775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A31B9C3386C
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 01:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8703A63D5
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 00:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAF523D281;
	Wed,  5 Nov 2025 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwPlDIQ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350D34D396;
	Wed,  5 Nov 2025 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303882; cv=none; b=DMf5R/A4qI7Lb5STJnRhMmrIwhj7fhknkkndSupsrotwos4FAeU1RngJaPYfur6omE4+sm7y8mV0Wm2ZnCrnlxX+AA/HD/rKdS5/mesTFmNcpJCc6NS71aMkabAdXwAXwHeZYPyVS6sV6BXa8X5NFfkj8eP0WqHkE2NwVOiERk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303882; c=relaxed/simple;
	bh=NqR0JQLnp0z1BzUXQHDYRmpxANJlaUCShrV17cBD+DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVwQYXY2VOU19k15aOvpraGlpzYma5hCXyXBJW8i5zaQQJOFcR7Ay4SQ5XtGG8y19XJBu9VoKOpTJinMm5n9OBqcTvPWa8+QS0RsXQKAD6591n6VSnDKcsYvqtyhJ5sgvr2OSJbl8tggUWKlx2u1M31V64CZqHw1uGKQXKOKnDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwPlDIQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85FCC4CEF7;
	Wed,  5 Nov 2025 00:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303882;
	bh=NqR0JQLnp0z1BzUXQHDYRmpxANJlaUCShrV17cBD+DQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kwPlDIQ4/8e453vE5NbLZEHs3WZmcGPCecA/dAN7PnhPfBt5H4wJS+IuLMi0wg35C
	 TNohzICdw/hRxNU0uX974nYpTKOVxLrHyRUDGAJXWSXXrrxiwwFLO8YB6XfcbgnQ7U
	 N1swVcn7+ZSpeSXT+7WFTVr2fRKWpHmfDP+BU8bejCjNYxudQCXvw8k6WGSjOTceRk
	 RZn57UQc1xv89t4am/c9ixUpIJ4pqAy06jHGosWAc+LEx/auqAVeskNj60d+tbX87V
	 0JI+0REQEwMcP2CjzfuYo0kpewA+BZhX3psNbS2SKk/QUQg6RKMqvX9WMWaeFPNVJP
	 k/hudIc7e9Waw==
Date: Tue, 4 Nov 2025 16:51:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Wang Liang <wangliang74@huawei.com>, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com
Subject: Re: [PATCH net] selftests: netdevsim: Fix ethtool-features.sh fail
Message-ID: <20251104165121.7069ad66@kernel.org>
In-Reply-To: <aQnd1HQ-b7wFI2WP@krikkit>
References: <20251030032203.442961-1-wangliang74@huawei.com>
	<aQPxN5lQui5j8nK8@krikkit>
	<20251030170217.43e544ad@kernel.org>
	<aQiANPQU9ZEa0zCo@krikkit>
	<20251103160133.31c856a4@kernel.org>
	<aQnd1HQ-b7wFI2WP@krikkit>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Nov 2025 12:04:52 +0100 Sabrina Dubroca wrote:
> So I guess you would lean toward not accepting any such patch, not
> requiring new tests to have SKIP checks, but leaving any existing
> checks in?

Yes, IOW leave it at the discretion of the test author.

> (and I suspect removing all the existing ones wouldn't
> actually reduce the flow of "add check for too old $tool" patches, so
> it probably doesn't make sense to do that)


