Return-Path: <linux-kselftest+bounces-23523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF5F9F6CCD
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 19:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 223147A0F9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACBF1FBE8C;
	Wed, 18 Dec 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx8gXtt9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750BD1FBCB8;
	Wed, 18 Dec 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544815; cv=none; b=BeU6sGR38IMRonyHb+1BmGI1wH/+y3SEP8EvzE6xsyFAjahBM4Ab8yEtAUqBVoQ8xpY5gutAi1BCjCxLx/UI281ZVv3ssJWMSXbDUG1BO1L61CxRNp7n1rnI1WaqVwMTFwUOBoPN0r4Vdu233i8xs+okg6p+NtLRctMfP4Ft+jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544815; c=relaxed/simple;
	bh=KrFtZTkvNLg8jGJuRIG3Se+sYB/V7HQf3f/RnlVQrnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTUNmv3Ixx+5YHCjDmpw0QzKnrqaRBoD+7iKsi9lffT7E+4OuxD8Ajujc4OCitNPXy/OpNLKLkBZ7eZEsNBpiNWqy8+lG6BhlLU2TTetEurc+jERVS3p5o1Jh/OsEKc85P2hrtI9QZbNtG59Bh4AMP0IjAx5PeBslJb52yiI8ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx8gXtt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0E4C4CECD;
	Wed, 18 Dec 2024 18:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734544815;
	bh=KrFtZTkvNLg8jGJuRIG3Se+sYB/V7HQf3f/RnlVQrnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fx8gXtt9HdU4yKO8k9z6Hflt3ebNMSGXiEiFHIFGUfBolJb1gRDsdFp2H4lshvy6E
	 cGygzcNY238AnSPmVkl/nGZ7qP3ekm3OlFT5ebqIJuFBa2PcuNYf5E7PwvElS/JT3w
	 f76Q/434GDlxAPFW1N6kl7/LXlITO+HHQfR0sL7/9qSGpBSPss79WPZ2sxJDieJ83+
	 7gQ5dKRnU06Y5jsI5ljWqQtzO8F/BBS1Grav9tqoZ8pyPQBE6fIw3LR+iGRnId1YsG
	 yb6egruVOA+itrsGRCwoBMlFVCZHbBc9sVwXVWcJ9PxLDATjCBLlGK+/sLVfcG+oi4
	 WXVdGrbStSIeQ==
Date: Wed, 18 Dec 2024 10:00:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Soham Chakradeo <sohamch.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kselftest@vger.kernel.org, Soham Chakradeo
 <sohamch@google.com>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 0/4] selftests/net: packetdrill: import
 multiple tests
Message-ID: <20241218100013.0c698629@kernel.org>
In-Reply-To: <20241217185203.297935-1-sohamch.kernel@gmail.com>
References: <20241217185203.297935-1-sohamch.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 18:51:57 +0000 Soham Chakradeo wrote:
> Import tests for the following features (folder names in brackets):
> ECN (ecn) : RFC 3168
> Close (close) : RFC 9293
> TCP_INFO (tcp_info) : RFC 9293
> Fast recovery (fast_recovery) : RFC 5681
> Timestamping (timestamping) : RFC 1323
> Nagle (nagle) : RFC 896
> Selective Acknowledgments (sack) : RFC 2018
> Recent Timestamp (ts_recent) : RFC 1323
> Send file (sendfile)
> Syscall bad arg (syscall_bad_arg)
> Validate (validate)
> Blocking (blocking)
> Splice (splice)
> End of record (eor)
> Limited transmit (limited_transmit)

Excellent, thanks for adding all these! I will merge the patches
momentarily but I do see a number of flakes on our VMs with debug
configs enabled:
https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=packetdrill-dbg

In the 7 runs so far we got 2 flakes on:

 tcp-timestamping-client-only-last-byte-pkt
 tcp-fast-recovery-prr-ss-ack-below-snd-una-cubic-pkt
 tcp-timestamping-server-pkt

1 flake on:

 tcp-timestamping-partial-pkt
 tcp-eor-no-coalesce-retrans-pkt

LMK if you can't find the outputs, they should be there within a couple
of clicks.

I'll set these cases to be ignored for now, but would be great if we
could find the way for them to be less time sensitive, perhaps?

