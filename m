Return-Path: <linux-kselftest+bounces-3696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ECF840BEC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 17:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDFF71F2101B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 16:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2631915702C;
	Mon, 29 Jan 2024 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzTtLe2v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C81157026;
	Mon, 29 Jan 2024 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546375; cv=none; b=gfGJjPLcdg9vGUiK9cYcEoAePM6ar5Jt8iW4LNDL7RpBnQZMcaNnExCnSndy4REmmg2ZGmWFRmZFrqx39ICyabLGbAAIu0qy32jL/1JtzxK8dRJsUcvUFmIfhpcZZKuNVUeLWRzspLCYiIrww5aAE9Whk2MI7dxH2AFb1/7/vM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546375; c=relaxed/simple;
	bh=Wx2ncxs11cOVQIR52Fc1zeUx2i2z6BCmR5mLf3EPhcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxGhDXtHDQTjrutpvcAV/tmDIPJ7+jwRkNuApGgud3XNBm711QIZScUQBqjq9Iq6PBnRgMsoC4OyBhYRfqW7iFoTh42zSGTuw+ScYxelcYO5/57aIG/qf0Wnk9TOFMZT0GirrY7ALYgIeQBBFjQx6dyrYmb1MEwbpgsyM2hMJ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzTtLe2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CB7C433F1;
	Mon, 29 Jan 2024 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706546374;
	bh=Wx2ncxs11cOVQIR52Fc1zeUx2i2z6BCmR5mLf3EPhcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzTtLe2vx7jkI7Ww83TJ3QP+5hmAV3MgM1XL8f8QuA2SUHHUKVe+ojnhGGk5g0UeI
	 AjtvGTIMuCBXeiBUs5T2GXbtBWvr8dNy2zQ3kJ4+gwrPVWg9Xn2BhceTbKJI/Ce/BS
	 mfO1ISSf5I4vR8ZZWB5LXBduALN8N7fvtJkubkzw5tp9p3wE8o/sV64PZXcvWFT1mw
	 MNfuFHmZz3wSCnEMo0LrBzwxU/4ZAMOgJu8IBV9m0bCBv53mDSizZk2qotC0vGyixP
	 Un0IjgSLLrhlFFGzWsdjyXfBy/Q+vMW4nxrdNhCFYuvnGfPAJ3jEjwcPvask3ZWG3K
	 I0AVhYN9KnN/g==
Date: Mon, 29 Jan 2024 08:39:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Xin Long
 <lucien.xin@gmail.com>, Florian Westphal <fw@strlen.de>, Aaron Conole
 <aconole@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: add missing config for big tcp
 tests
Message-ID: <20240129083933.6b964b3f@kernel.org>
In-Reply-To: <d67d7e4a77c8aec7778f378e7a95916c89f52973.camel@redhat.com>
References: <21630ecea872fea13f071342ac64ef52a991a9b5.1706282943.git.pabeni@redhat.com>
	<20240126115551.176e3888@kernel.org>
	<a090936028c28b480cf3f8a66a9c3d924b7fd6ec.camel@redhat.com>
	<d67d7e4a77c8aec7778f378e7a95916c89f52973.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 17:31:33 +0100 Paolo Abeni wrote:
> Uhm... while the self-test doesn't emit anymore the message related to
> the missing modules, it still fails in the CI env and I can't reproduce
> the failures in my local env (the same for the gro.sh script).
> 
> If I understand correctly, the tests run under double virtualization (a
> VM on top AWS?), is that correct? I guess the extra slowdown/overhead
> will need more care.

Yes, it's VM inside a VM without nested virtualization support.
A weird setup, granted, but when we move to bare metal I'd like
to enable KASAN, which will probably cause a similar slowdown..

You could possibly get a similar slowdown by disabling HW virt /
KVM?

FWIW far the 4 types of issues we've seen were:
 - config missing
 - OS doesn't ifup by default
 - OS tools are old / buggy
 - VM-in-VM is just too slow.

There's a bunch of failures in forwarding which look like perf issues.
I wonder if we should introduce something in the settings file to let
tests know that they are running in very slow env?

