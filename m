Return-Path: <linux-kselftest+bounces-5732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9550686E368
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 15:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4374D1F2262F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832451FBF;
	Fri,  1 Mar 2024 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLcMwXej"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484751FA1;
	Fri,  1 Mar 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303876; cv=none; b=VXJW1sLvHCXIdKt+hylyWboOTdQz1NhWFXczWvsbMpTSOMrSPLhV43oaH+80ItWJCzHkQc5PqPFvLMjyQ6AXv71gxcqfWxm9I+pwzc5Z0bmiqUsltU7iCarne6Lb6QwJ2s6MQ4RicYxvtsyDttJdjq5inBZZ3X3atWpVP8D+0/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303876; c=relaxed/simple;
	bh=2r1Wp3rYCpQCXBRXRGrQRKnkowj3xl49dA+H2NJnMBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsLOdZJnR0DV8Qve736fQ5+A0a6YjzsgbW0lMYHFdmFo8EqzqABdcPjgUst+jTKh6QWoPgIvVFgi0wrpAor2x6mbZt7trGSQ8Y0a7/jgC8CmcB3ur6oNYKxLgSkDDhbTajXOFQ0TnGI3n0hnFsarBhn8Ubs5k/gVxnQIJBMr0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLcMwXej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4500FC433F1;
	Fri,  1 Mar 2024 14:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709303875;
	bh=2r1Wp3rYCpQCXBRXRGrQRKnkowj3xl49dA+H2NJnMBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jLcMwXejD/CL3+8qjIs5Xj3U6dmo915+bS91i0UNfhbY253V+tu4oVODlVblYPfIK
	 kBbJyaJFzSnPbMfHsBljKPLYaDqhB5LDPn9cjmmFucHfOs97juG4NLacHkyaeXJFnq
	 KRzG2NgL8sxQCK8gpLrl56up+kw9N55G/Tw7S1zvNyQomdVACQLEaeAahE2nupVWHp
	 Yt/4BL5t28vLoTWaClOc+rBGN1zQqc0b29ciA5scV8eXufEMsPJvjdKioJRV4fyHew
	 6XY8fr7/coD3tETytB8GrViKeA/CBmmcZ5a0/ZuEjsCBnL3FrneePy4UPD8aV11hWZ
	 Yb523th9q7o6Q==
Date: Fri, 1 Mar 2024 06:37:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Florian
 Westphal <fw@strlen.de>, Kishen Maloor <kishen.maloor@intel.com>, Shuah
 Khan <shuah@kernel.org>, Peter Krystad <peter.krystad@linux.intel.com>,
 Christoph Paasch <cpaasch@apple.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 10/10] selftests: mptcp: explicitly trigger the
 listener diag code-path
Message-ID: <20240301063754.2ecefecf@kernel.org>
In-Reply-To: <20240223-upstream-net-20240223-misc-fixes-v1-10-162e87e48497@kernel.org>
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
	<20240223-upstream-net-20240223-misc-fixes-v1-10-162e87e48497@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 17:14:20 +0100 Matthieu Baerts (NGI0) wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> The mptcp diag interface already experienced a few locking bugs
> that lockdep and appropriate coverage have detected in advance.
> 
> Let's add a test-case triggering the relevant code path, to prevent
> similar issues in the future.
> 
> Be careful to cope with very slow environments.
> 
> Note that we don't need an explicit timeout on the mptcp_connect
> subprocess to cope with eventual bug/hang-up as the final cleanup
> terminating the child processes will take care of that.

Hi!

There's a failure in CI under debug after merging net and net-next 
in diag.sh. Maybe because of the patch which lowered timeout?
https://lore.kernel.org/all/20240223-upstream-net-next-20240223-misc-improvements-v1-8-b6c8a10396bd@kernel.org/

