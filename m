Return-Path: <linux-kselftest+bounces-32824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA53AB2608
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 May 2025 03:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26280189DF69
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 May 2025 01:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E39208A9;
	Sun, 11 May 2025 01:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="fzfiC2Ct";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="uPhnhPGs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6CA139D;
	Sun, 11 May 2025 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746927323; cv=none; b=q0IR570MtpHurmn+0NU1Pv1uhtuWMcocxVLx5pIXV0HRmNstfoWI8YAebA5bRplyW4r+Lu6xfhHWbXDM8MPko4LzY6lOB59xu+WG67bTQc4dDOEBoiQRwVwoj2rkwqsFDpiP9+SOOB8QhED/rYQeFw5LC2MUzBKpEHiGtrdIb3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746927323; c=relaxed/simple;
	bh=Rs6jpnBP7P1WnzGa9WTZgmxvwHQOZBb+PfH5fr7joxQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kdGmg5kxMSjkMQDJsuoSVBNq6mGBXzpWUPoBAkcm9pljd8QQjez4esdgmabpJUtH95CFdXgcX30JLf5ik3/q8MN4zRfiyAwLGZVH854wuojqwh8MhYCEzbnAhdOs4BaKxVY1GFzYKFLgrtnU0LKSXC7p7Qr9a3n0zSmIj0uXYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=fzfiC2Ct; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=uPhnhPGs; arc=none smtp.client-ip=160.80.4.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 54B1YXnR024460;
	Sun, 11 May 2025 03:34:39 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id A46BE12288E;
	Sun, 11 May 2025 03:34:29 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1746927270; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofX56hdJp36rarI7IXO8x0nRNPdV54JQ4yA2f+BTyKs=;
	b=fzfiC2Ct4a6SnKma4CIVLfAL9UyPHOlQI0zaCEeLA1kMgavI/qkeINJIeteYJRtFGdmv/1
	Ol0rQxix6EiAxTCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1746927270; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofX56hdJp36rarI7IXO8x0nRNPdV54JQ4yA2f+BTyKs=;
	b=uPhnhPGsWi/y8my6VOCZKHsvEmoF6BOkbNffNxISp2rxY0hP0DIqvUqytonz5mqQgA5rQu
	p8QeCV7HwFSB10uD83gp9tu0KnMmaMZh/DSQ56RQ3eCIpAhLNII4zfeEZMxWZProA7oQKd
	RSIbkjEmrSNKD+nGvDvJ2wnC9kWRXaURRebdw4seAAyj2L/qVKyiINxwjIF2elSzlj3SDL
	kRKpGLBcbSPUZGS5JBQMv2FkztMzPW78CRHEnoQEnGpyg4gpVF2pQIQmNZy64WrivweW16
	i9FeZUkpclGg/BtKaEO4UDPYUTnSGMMzH1Av0wXzXuNQRxLUHDs0MS1uEivtiQ==
Date: Sun, 11 May 2025 03:34:29 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan
 <shuah@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
        Mat Martineau
 <martineau@kernel.org>,
        Geliang Tang <geliang@kernel.org>,
        Pablo Neira
 Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Paolo
 Lungaroni <paolo.lungaroni@uniroma2.it>,
        linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCHv2 net-next 4/6] selftests: net: use setup_ns for SRv6
 tests and remove rp_filter configuration
Message-Id: <20250511033429.aabb9627fac2d36a61c3d64d@uniroma2.it>
In-Reply-To: <20250508081910.84216-5-liuhangbin@gmail.com>
References: <20250508081910.84216-1-liuhangbin@gmail.com>
	<20250508081910.84216-5-liuhangbin@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Thu,  8 May 2025 08:19:08 +0000
Hangbin Liu <liuhangbin@gmail.com> wrote:

> Some SRv6 tests manually set up network namespaces and disable rp_filter.
> Since the setup_ns library function already handles rp_filter configuration,
> convert these SRv6 tests to use setup_ns and remove the redundant rp_filter
> settings.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Acked-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Changes look good to me.

Thanks,
Andrea

