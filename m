Return-Path: <linux-kselftest+bounces-43837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EA5BFECE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33C1C35503F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5F81E520E;
	Thu, 23 Oct 2025 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUWeDzHp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31017A305;
	Thu, 23 Oct 2025 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181269; cv=none; b=qFKXDRpTolvKAGI9HjtgEAgi7syJakxUWyHofMBC1p449DCTyl51xjHmtQBrLnU1kOT5Qt2VVPWP4PU5gGkJvoCZ/vZiTiM4vGJO2vn+WkSA0XiWNMhMoW2t+Gvwmy+zj0uxFS6AFmOEGkCMUu24a4BbKoHfqEpvWdXnJEMg6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181269; c=relaxed/simple;
	bh=XEkbu0iGLWOG7wCG5SIbdJ9Qe5+uq0vSYOn5vxQGxNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MG0hH1ayfbC7hNwNRYPik3akH+YhEcHlUrhZgM8HEwL2in2KPiNjj68gErJAQfF4C0IqAoidjNlxCQcKseuGCuL63X0f73mgtWSFVpZLDvfP1q9l6RWM0Z5WmpyizyktmPgOpEybuYi9oMUMMcIkVnHWGbsJCUfzbUTBKMBYHNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUWeDzHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F493C4CEE7;
	Thu, 23 Oct 2025 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761181268;
	bh=XEkbu0iGLWOG7wCG5SIbdJ9Qe5+uq0vSYOn5vxQGxNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oUWeDzHpxUTpzQ2ye7AiBrr1U37kZOrT5mdYG0LeJ6MtZgxmDck6j5XJe7mnhTow7
	 mUfHCxy6/AIRXOCNmKwUSEBkl3khYIIc2SyVcgVQOGexgSpuT8j3N701PNS+YRgvJ3
	 i2b6ixBCbLd2mda/qUTmF0HBRDr/6m94tAKnQu7wqM5ve/kVxxVoF3YIL43sURoyL5
	 GWLoFxJLyOx44/PD4ZVJZzYs3SZb/oaBoNqvnZuD8ShifNT702BScRq0Au01SWNYaJ
	 A1bqTaVVFw9EvgOpyyLGyf/wj1Jn9uQWqO5nhwthKtoligOtaIq620ksXNYpcrloSN
	 n4i08u5cE27qw==
Date: Wed, 22 Oct 2025 18:01:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>,
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthew Wood
 <thepacketgeek@gmail.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] netconsole: Fix userdata race condition
Message-ID: <20251022180107.3a7d1198@kernel.org>
In-Reply-To: <20251022-netconsole-fix-race-v2-0-337241338079@meta.com>
References: <20251022-netconsole-fix-race-v2-0-337241338079@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 10:39:56 -0700 Gustavo Luiz Duarte wrote:
> This series fixes a race condition in netconsole's userdata handling
> where concurrent message transmission could read partially updated
> userdata fields, resulting in corrupted netconsole output.
> 
> The first patch adds a selftest that reproduces the race condition by
> continuously sending messages while rapidly changing userdata values,
> detecting any torn reads in the output.
> 
> The second patch fixes the issue by ensuring update_userdata() holds
> the target_list_lock while updating both extradata_complete and
> userdata_length, preventing readers from seeing inconsistent state.
> 
> This targets net tree as it fixes a bug introduced in commit df03f830d099
> ("net: netconsole: cache userdata formatted string in netconsole_target").

This test is skipping on debug kernel builds in netdev CI.

TAP version 13
1..1
# overriding timeout to 360
# selftests: drivers/net: netcons_race_userdata.sh
# socat died before we could check 10000 messages. Skipping test.
ok 1 selftests: drivers/net: netcons_race_userdata.sh # SKIP

We can't have skips for SW tests.

I think Breno was fighting with a similar problem in the past.
Not sure what he ended up doing. Maybe just leave it at the print?
Don't actually mark the test as skipped?

Slightly more advanced option is to only do that if KSFT_MACHINE_SLOW
per:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style#dealing-with-slow-runners-in-performancelatency-tests
-- 
pw-bot: cr

