Return-Path: <linux-kselftest+bounces-9445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A38CA8BB8AE
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 02:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E96C285ACE
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 00:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE03A2A;
	Sat,  4 May 2024 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kdvu8jFj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4DA80B;
	Sat,  4 May 2024 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714782324; cv=none; b=AyzjqQqft7TEPZ1K6VS4JGZrtXrY9L6wCi5CInbmyivS17fYEIeSLrc7IjQXUzgeakpPDJnZJlQ8AqS2Wf0Rq21dp2HjR7roLfvvz4oVFV800B5q9h83NiGAryMst7LURxj6SxYjr9i4nwANfiGw5gWN38xffPW6s1LfA5X4dpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714782324; c=relaxed/simple;
	bh=08NdiI0KLbL6G/kzwyE5PDlNUA3Tnx1mcCUXG13KCrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRae4yDL6uTjzBG79w3q7/qiGFDhTVPr/JNjIii6ysNV/dlgkKhWF2eFaau3I+510ghJHe60OL6LbB/lqrPru2dYycCNbFCpwgsHINXofZNhePH72luPRjPlTSShRU9xweT+L3gcKs0rIFUs45X2hbqvv1weKK8J0UrtMFlKSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kdvu8jFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAC1C4AF1A;
	Sat,  4 May 2024 00:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714782323;
	bh=08NdiI0KLbL6G/kzwyE5PDlNUA3Tnx1mcCUXG13KCrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kdvu8jFjlvNJGIhQNhRRFEIpXeLyOA9JDtSj0QPTTeZRsFLc/sZedTpOlcAhxglMr
	 xQJak+hcuZQJZA4qDUA6j0dk1ESyPcUdEQLPP28GAHZz7Gg/2GQ6X5hEoqjVvC09m8
	 rB9ZB44nHW6SDu2/3RV9OwoD8nWrvERuG0GjcGkmfcN/A77WoU38/w2/Yo2Fk6xdaL
	 BfgMefljvrgP137U+bvupqEAFliaW82RMY8E8MDUmkidsaGQPSW+flgb+wcAaS9zrH
	 avSH8zGxl3Rw1ywSkM8fGF94flR1WDrDoSW7uG01OITjceGBl0Y5cNn0cSZ3rbD3k5
	 pSyknIwoM/wfQ==
Date: Fri, 3 May 2024 17:25:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nalramli@fastly.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next] selftest: epoll_busy_poll: epoll busy poll
 tests
Message-ID: <20240503172522.02656db8@kernel.org>
In-Reply-To: <ZjVuuVj2qGHrvqtT@LQ3V64L9R2>
References: <20240502212013.274758-1-jdamato@fastly.com>
	<20240503154939.79f7c878@kernel.org>
	<ZjVuuVj2qGHrvqtT@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 May 2024 16:09:45 -0700 Joe Damato wrote:
> > "GEN" is for files which are built for other tests to use.
> > IOW unless there's also a wrapper script under TEST_PROGS
> > (or the C code is itself under TEST_PROGS) this test won't
> > be executed by most CIs.  
> 
> Ah, I see. OK.
> 
> If I decided to go with the kselftest_harness as mentioned below, I'd need
> to include a wrapper script to run the binary with the right cmd line
> arg(s) and put that in TEST_PROGS?

harness or not, the only two real requirements for including in
TEST_PROGS directly is to:
 - return non-zero exit code on failure; and
 - not require any command line arguments.

