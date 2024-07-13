Return-Path: <linux-kselftest+bounces-13709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E479307D8
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jul 2024 00:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4C1282DC9
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 22:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD94145350;
	Sat, 13 Jul 2024 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pL2DW2pC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF45044C7B;
	Sat, 13 Jul 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720910776; cv=none; b=f0jzQ36nw09JhxwMeclOA/gW4+uud6CHQeEXJ7HuQQccD8kCrJ3TPgUVoI8fpBWvsFf9zzWm2qMKzTkQlMQ5J/0Wc4EbYS8Vm4Q0BUAxYA5ZhRK2jdwLqw9uYPMGyW+4mByEc+P4MFKxi1J0Fs7dYO3O/gtbFWaPlBw0ezLgdDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720910776; c=relaxed/simple;
	bh=UwofqbVZqwaGSdtJu7hNgGk0S78WZ1m7zs7Iyxom9Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imX1D8q33rOtbS0gy2O0NM3Ej8Wr27CvlnksfHoebUE587j79nL1X3jLuMU1E8zd6ndYSZAL/SRMoj63sdWktSq5D9LJFmcYH9hkprdnw9J5IlASw6J7SH0+C5KVpGUiDUF0HEidATMkxXAfmwWzvbi32EixmgCYMZPDD3HS4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pL2DW2pC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048E3C32781;
	Sat, 13 Jul 2024 22:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720910775;
	bh=UwofqbVZqwaGSdtJu7hNgGk0S78WZ1m7zs7Iyxom9Qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pL2DW2pCE3ihMNvR25rHszj7M5f4HJPWWvnxIgylzPGwBEAIfxVJOFMyKm5dLAdPG
	 5VMGjr7OcvpMMrHHLE4Www5hissobknwvO3MQchHspgGI8bZZRYzsfbVhH4lp4tRFf
	 5UTtnkPws0D72NdvQZPNdPvQncKQ/8NzU/EVMnygMNYVpjkdB0lNrknyVDIt8TUoLf
	 FY7VhJbnF0TnQirwLD518v3H8EAefwigV6b6tfyCo2YUbwKmjUdL+j4TSSlhuHaVma
	 J6pNmusLISAIdR0zMfKSi+BjWDGTGRIfOHt0DziphCxPx4qKRq+BZYaRK52LXu5IhK
	 bv/NEIyxzmYkg==
Date: Sat, 13 Jul 2024 15:46:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: mptcp: lib: fix shellcheck errors
Message-ID: <20240713154614.653f30ce@kernel.org>
In-Reply-To: <20240712-upstream-net-next-20240712-selftests-mptcp-fix-shellcheck-v1-1-1cb7180db40a@kernel.org>
References: <20240712-upstream-net-next-20240712-selftests-mptcp-fix-shellcheck-v1-1-1cb7180db40a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 12:00:15 +0200 Matthieu Baerts (NGI0) wrote:
> It looks like we missed these two errors recently:
> 
>   - SC2068: Double quote array expansions to avoid re-splitting elements.
>   - SC2145: Argument mixes string and array. Use * or separate argument.
> 
> Two simple fixes, it is not supposed to change the behaviour as the
> variable names should not have any spaces in their names. Still, better
> to fix them to easily spot new issues.
> 
> Fixes: f265d3119a29 ("selftests: mptcp: lib: use setup/cleanup_ns helpers")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Speaking of MPTCP tests - I added the connect test to ignored today.
Too many failures :(

