Return-Path: <linux-kselftest+bounces-41066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1ADB507D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 23:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C967C173E10
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 21:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D37B254B1B;
	Tue,  9 Sep 2025 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cywXSafV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBC253951;
	Tue,  9 Sep 2025 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452344; cv=none; b=bgL+LyruDP1mIxRlg5KKiKXWR58HoH6/arVRYcIcgA76R6rqGIlpFH+FWNbVb9F+dM8J+Jt877EBnLamF4d5dSiSwPTUC1F7x/+U8wMp6efvO4nK3rAKJrMslTVYXbcJV2gLoCfG9lo2I43FGKR2dFC4P2s3z7zPOXVwROKimbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452344; c=relaxed/simple;
	bh=c3SyJQ57FSqB3XnVUxPYlihJ10MSLpFeLzzdFD6BwHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6it4Te/ioN1S/AlF2cQ/0ModkWQeAZ6H8HJlsHDLWpSR0H+Dvx7kIGkSrvWaCJROtERCgLvkkWvDmb6dUtn24aJJCBkJ9S7txb4yTxI/Glw8NS5qgTpliXQY03MIsy+i3IbVn/ExgL9frZ+UHXN5hVWKmLMyKHNYpLW2uI/EEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cywXSafV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B48C4CEF4;
	Tue,  9 Sep 2025 21:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757452343;
	bh=c3SyJQ57FSqB3XnVUxPYlihJ10MSLpFeLzzdFD6BwHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cywXSafVp9YvJ6T7ky6frjfZ2//mKk/FKatrTOn2PAfJZdOVf8ZoYIlsFzRDu8EeB
	 2KPXlF3n2H5wi9gL7RTADWCl3l+Y5vXuu+cEFu5CrP9CmtOhHZWmlQfLNk0Y0UYt/M
	 VZssDnBLX4AFwtFtINZqms5bQet5efAxPGmNxmbUvjtnp31XJ/lteY0pC82kgbWh/2
	 8x2UgllauKBlfgimppmKGLms6UVq9zLJyynJThNBZqztwm71Db4CpgRTQtAtkihmee
	 bL1dEDObCUKzXNNcW9JuHJIKCwt5VX3KTAs2AqUW5cyuwyrzvoBKo5DghfegsTTiNL
	 chdSjRm/sCm6Q==
Date: Tue, 9 Sep 2025 14:12:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nimrod Oren <noren@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH RFC net-next 0/5] selftests: drv-net: Convert XDP
 program to bpf_dynptr
Message-ID: <20250909141221.4a10bfa5@kernel.org>
In-Reply-To: <20250909085236.2234306-1-noren@nvidia.com>
References: <20250909085236.2234306-1-noren@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 11:52:31 +0300 Nimrod Oren wrote:
> In cases where the program does not return XDP_PASS, I believe dynptr has
> an advantage since it avoids an extra copy. Conversely, when the program
> returns XDP_PASS, bpf_xdp_pull_data may be preferable, as the copy will
> be performed in any case during skb creation.
> 
> It may make sense to split the work into two separate programs, allowing us
> to test both solutions independently. Alternatively, we can consider a
> combined approach, where the more fitting solution is applied for each use
> case. I welcome feedback on which direction would be most useful.

Ideally we'd make the BPF code work in either mode. But not sure it's
achievable given the verification complexity. Failing that we can have
two BPF objects and parameterize the test cases.

It'd be neat if we could capture if the pull actually pulled anything
for a given case, so that we only bother re-running with the dynptr when
we'd end up with different packet geometry. But only if it doesn't make
the test code too complex. 

