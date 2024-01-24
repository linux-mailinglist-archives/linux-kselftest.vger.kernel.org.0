Return-Path: <linux-kselftest+bounces-3488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8DB83B383
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 22:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0458288A1F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 21:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AC41350DD;
	Wed, 24 Jan 2024 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpIcca8d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3FA811E4;
	Wed, 24 Jan 2024 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130148; cv=none; b=E2pBT+a/jkixgmLZTqWibxLOgrWx9HB5Txypqt7CFLOlVcwxoXDe+5XCi2MYMjKXVBByem2vAsHbSyL4LDjwMUNheBjofe/tYwkZbNEGgEz2epmoaKivnBtaeLFJYk/wA0M0Bw17GwpMv1F62at+N1GQnlf5riyEHdMndgleeR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130148; c=relaxed/simple;
	bh=GRLg7Fttd7YkkhBg0ew3v+e7tGu/q9kze+tM6Iuq/X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCBvv9HgQ/W8EFtEa/5XMRO4bBFFyNus2otpDve2DZTdEBFtSjTEQw8CicNeoI1QuxiTCXfp4W8VON4BakbVN9brCeXyAYjEy7MiNcw5Yrlc5MXrgAhWqwcaPYfxlgPhUBp1QdtpTO5eNaTgYGvNNQ+vq1IhltGVYCRmkrHYqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpIcca8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848AAC433F1;
	Wed, 24 Jan 2024 21:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706130147;
	bh=GRLg7Fttd7YkkhBg0ew3v+e7tGu/q9kze+tM6Iuq/X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpIcca8di4rparosYDqBdumPDaTqwMUXRU7uIA4G3UfU2QZZgjT16huRflLWB5SpG
	 Hmgy9fbtM8hhhrsnsV3AWlCgP8nKldAh/P+sHW9bjluCseSDBl4vBSRInVp3TKP/P1
	 SadyDfruDp3nmigLEH817zET38Uzy++//LggqVZnOdurCmjE8CCYUPPu0FtdIfnsp8
	 z53evmErpHmlpyjxVKmJ3FvOszEbzWfOh3DNhyL0QzbZg0lYHiVKfKAlALvvVv2DlM
	 3qqAw2jgq0cQ8AVqYDv3t+tgq1+J8BUlLlGRpqM9P+p+BzBrz02b4GMnXoF8E+GiNk
	 b8ZTs632Ls3Aw==
Date: Wed, 24 Jan 2024 21:02:22 +0000
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net] selftests/net/lib: update busywait timeout value
Message-ID: <20240124210222.GB217708@kernel.org>
References: <20240124061344.1864484-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124061344.1864484-1-liuhangbin@gmail.com>

On Wed, Jan 24, 2024 at 02:13:44PM +0800, Hangbin Liu wrote:
> The busywait timeout value is a millisecond, not a second. So the
> current setting 2 is too small. On slow/busy host (or VMs) the
> current timeout can expire even on "correct" execution, causing random
> failures. Let's copy the WAIT_TIMEOUT from forwarding/lib.sh and set
> BUSYWAIT_TIMEOUT here.
> 
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


