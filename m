Return-Path: <linux-kselftest+bounces-16353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD43095FF17
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 04:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A99F283913
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 02:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAC610A1F;
	Tue, 27 Aug 2024 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hclob048"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE5F17591;
	Tue, 27 Aug 2024 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725798; cv=none; b=QS5lQZSbGxA8Ui10InOqTpOF7R+mxSE+dMdlCMEVUr7czyf3IFyvsKoSclohXKv+FlwBTvcTTrh/w1lPdQGv1MZI8tmWOMLxLsFgpJ6hUvKp8AclpYNsaccK3dvCP2L2sIHhChgOqWWQgpJPNIE8JqqeFLrCD8F7NN8z1nj4JAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725798; c=relaxed/simple;
	bh=7k4gb/RyJ7mSJ3IzlGHqF/WYxxP6KqEPsos34rR0RS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELK4sv0KVglOfbNGPN3nBCfXNfLEpQYv7H+bt+HsybDTNPv96lNtMIKdRF+gsDckN5wy1l+9hArBeRwkJK9/QCX2UfbLkSkxMRKIk0Po9jl2Rf0MbH2NTDckDJuJKHkpLeBE5/VMilMOVhuQ0lAuq9aZxIjCq83KqQBBR/TrVec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hclob048; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE151C8B7A4;
	Tue, 27 Aug 2024 02:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724725797;
	bh=7k4gb/RyJ7mSJ3IzlGHqF/WYxxP6KqEPsos34rR0RS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hclob048UdBCgo/uKFC9M9XLyraGmd8WhMcAXUk5+RxQEvQK31hkjOgKXCPBEPels
	 CHnsRYC/0NToLTfJR29w6k1ytIxV+9SruFPOCklgVpNxn5u/O1YE7I2E84lZ5dA2Hr
	 DstHALYp+ar4zsiD3IUJ31MK3fwTfYeT64xL5J5V5XBXLZeUl7ZhGfiHUjF2U7TcTA
	 p3iRVY9dNufqmlol7VLcbnTlokvaum4v+PiR+5kwi8px7TMNFtU+e7wfYouzQhbx4Z
	 9+ca4+ddW11/LL+Z0sOGYfHLIgzVXC2JrF6xK+VDhN9oxrleYpmbNCCegEZWtCbG3r
	 f1q3yr9A0X7Pw==
Date: Mon, 26 Aug 2024 19:29:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Florian Westphal <fw@strlen.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, =?UTF-8?B?QXI=?=
 =?UTF-8?B?xLFuw6cgw5xOQUw=?= <arinc.unal@arinc9.com>,
 syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com
Subject: Re: [PATCH net 00/15] mptcp: more fixes for the in-kernel PM
Message-ID: <20240826192955.3dbb469d@kernel.org>
In-Reply-To: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
References: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 17:58:59 +0200 Matthieu Baerts (NGI0) wrote:
> Matthieu Baerts (NGI0) (15):
>       mptcp: pm: reuse ID 0 after delete and re-add
>       mptcp: pm: fix RM_ADDR ID for the initial subflow
>       selftests: mptcp: join: check removing ID 0 endpoint
>       mptcp: pm: send ACK on an active subflow
>       mptcp: pm: skip connecting to already established sf
>       mptcp: pm: reset MPC endp ID when re-added
>       selftests: mptcp: join: check re-adding init endp with != id
>       selftests: mptcp: join: no extra msg if no counter
>       mptcp: pm: do not remove already closed subflows
>       mptcp: pm: fix ID 0 endp usage after multiple re-creations
>       selftests: mptcp: join: check re-re-adding ID 0 endp
>       mptcp: avoid duplicated SUB_CLOSED events
>       selftests: mptcp: join: validate event numbers
>       mptcp: pm: ADD_ADDR 0 is not a new address
>       selftests: mptcp: join: check re-re-adding ID 0 signal

The debug runner is failing mptcp-join-sh fairly consistently with
these applied :(
-- 
pw-bot: cr

