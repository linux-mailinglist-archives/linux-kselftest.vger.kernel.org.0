Return-Path: <linux-kselftest+bounces-24805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE19A172FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 20:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68393A2837
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 19:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE961E9B19;
	Mon, 20 Jan 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYNRCuAN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769B91DFE0B;
	Mon, 20 Jan 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737400015; cv=none; b=dg4Ohr0PTt6fKu1ya8F/lq6WvWY01dRhsrHKn8XQq0584Y524QS7qEbVBVCC9q36XJOR0aBXHoAyIXaVtxDK82hZJDcDyHbm7KFUWWtCA4lPqYfbPcDW/v6To5FrZ08jJUKq6ybnQPyEI3bOocPWImxcd+0cNiLeEYI3U/m0frg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737400015; c=relaxed/simple;
	bh=jkZm3DGDoAj/io0coHmiJe0JSoPgByrZ9bxYiNRiS4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDL0dr07IZFCsZBnSFwmatkKKXdc6h7JQwMb2j20toTtGm28nsGMsowSE64VZNpp8lsfPmgqcxKQaR13e+zCB2HvCdZtRCuwe/vdH3C362B7LHKWTeCRpKjC2LviB+5tjZ7GGWfcp6nNzdqANB7p/2mj12jZfInPUe1FYBw+KuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYNRCuAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44299C4CEDD;
	Mon, 20 Jan 2025 19:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737400014;
	bh=jkZm3DGDoAj/io0coHmiJe0JSoPgByrZ9bxYiNRiS4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LYNRCuANadi/OR50ZOBYOdiqI8HIPqhdI2GWgANdn4fqimH0IfF4b4WOCHUplFLfE
	 YqVtay8zckFjUHQOmW0CVlj0hLuwCtXLVzsf10lYk4Ldw0Uq56JeMqVCVJz3xZwWz+
	 D0nEjRb4ziYCqmrS6DCBP79SlYUjV+PRggJQ1+kVOiI9H3iLeEBjObtPKMsQ135c4r
	 3Q2S557oAqp8COvR6EkqvS0JqSdtexQ2DTGDrbQvdbNTBFef9UScQL4KCPYtRlp3eP
	 2H6KXGdHr3may++nsIEjkoqaW5sh6ig375u/8REgdKa+X0bWftr4sjc21Y/IwnsPWW
	 5woly9KJ7kdGg==
Date: Mon, 20 Jan 2025 11:06:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com, max@kutsevol.com,
 thepacketgeek@gmail.com
Subject: Re: [PATCH net-next v2 3/5] netconsole: add support for sysdata and
 CPU population
Message-ID: <20250120110653.693fd5ec@kernel.org>
In-Reply-To: <20250120-rational-bullfrog-of-tornado-2cd6f4@leitao>
References: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
	<20250115-netcon_cpu-v2-3-95971b44dc56@debian.org>
	<20250116174405.20a0e20b@kernel.org>
	<20250117-terrestrial-clam-of-satiation-cf312f@leitao>
	<20250117183520.11d93f4d@kernel.org>
	<20250120-rational-bullfrog-of-tornado-2cd6f4@leitao>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jan 2025 09:30:48 -0800 Breno Leitao wrote:
> > > Not sure I followed. The data ({userdata,extradata}_complete) was always
> > > inside nt field, which belongs to target_list.  
> > 
> > I mean the buffer we use for formatting. Today it's this:
> > 
> > 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
> > 	int header_len, msgbody_len;
> > 	const char *msgbody;
> > 
> > right? I missed that "static" actually so it's not on the stack, 
> > it's in the .bss section.  
> 
> Since you raised this topic, I don't think buf needs to be static
> for a functional perspective, since `buf` is completely overwritten
> every time send_msg functions are called.

It may be because it's relatively big and stack space used to be 
very limited.

> > My thinking was to handle it like the release.
> > Print it at the send_msg_no_fragmentation() stage directly 
> > into the static buffer. Does that get hairy coding-wise?  
> 
> I suppose the advantage of doing this approach is to reduce a
> memcpy/strcpy, right?

Not really, my main motivation is to try to find a common way
of how various pieces of the output are protected and handled.

> If this is what your motivation, I think we cannot remove it from the
> fragmented case. Let me share my thought process:
> 
> 1) sysdata needs to be appended to both send_msg_fragmented() and
> send_msg_no_fragmentation(). The fragmented case is the problem.
> 
> 2) It is trivially done in send_msg_fragmented() case.
> 
> 3) For the send_msg_no_fragmentation() case, there is no trivial way to
> get it done without using a secondary buffer and then memcpy to `buf`.
> 
> Let's suppose sysdata has "cpu=42", and original `buf` has only 5 available
> chars, thus it needs to have 2 msgs to accommodate the full message.
> 
> Then the it needs to track that `cpu=4` will be sent in a msg and create
> another message with the missing `2`.
> 
> The only way to do it properly is having a extra buffer where we
> have `cpu=42` and copy 5 bytes from there, and then copy the last one in
> the next iteration. I am not sure we can do it in one shot.

FWIW to simplify reasoning about the length I thought we could take the
worst case, assume we'll need len(cpu=) + log10(nr_cpu_ids) of space.

> On top of that, I am planning to increase other features in sysdata
> (such as current task name, modules and even consolidate the release as
> sysdata), which has two implications:
> 
> 1) Average messages size will become bigger. Thus, memcpy will be needed
> one way or another.
> 
> 2) Unless we can come up with a smart solution, this solution will be
> harder to reason about.
> 
> If you want to invest more time in this direction, I am more than happy
> to create a PoC, so we can discuss more concretely. 

I don't feel super strongly about this. But hacking around is always
good to get a sense of how hairy the implementation ends up being.

To rephrase my concern is that we have some data as static on the
stack, some dynamically appended at the send_*() stage, now we're
adding a third way of handling things. Perhaps the simplest way to
make me happy would be to move the bufs which are currently static 
into nt.

