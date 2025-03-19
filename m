Return-Path: <linux-kselftest+bounces-29442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32481A69467
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 17:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E646D3B5B15
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B9D1DEFC5;
	Wed, 19 Mar 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EvtO6g37"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B301DE884;
	Wed, 19 Mar 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400627; cv=none; b=Npde9h/tdnkgZ5XdqwDHcdMmuGcZMrvQG4Lumteaw0KnQfLqMTSLWF+ksGCF3rNdrQOnzCwhQWR/dd3CaCNwqTSmnqH1vuC96ZZ640J1XEgWWki0I8Uq7kBnu0Zq2u3YhswBapt8lr7IQvgj4nMy3njQP0Gv5tPM7p24tj1vsIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400627; c=relaxed/simple;
	bh=wQH1ImZR2MCOnMn7sAGHDKs6nYnyNfWPy4MNNVn3xUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTZGBhz5Xsj/ROTtBxoQDaMgLjZotE3X4fpQuRGCaiC28LBzXjaTe8Kgom+iewUzksnS0gra+G78hP5VqtxHJe09iAo+gFT84tsgbES8L0fJ5TughFm/ua8oEdg1W1xxo1/I18xVdeFP74Pfak0QrHivmArUowdzQ23x6hY9pno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=EvtO6g37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A10AC4CEE8;
	Wed, 19 Mar 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EvtO6g37"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1742400624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wQH1ImZR2MCOnMn7sAGHDKs6nYnyNfWPy4MNNVn3xUA=;
	b=EvtO6g37q/AUhMihU3ZZhr8nyNKYB04s5LH3pE00D/ZDJWn2AlnDocX5gqs57ORoZ1qBoj
	aJM3G3HoNkDsukKfPcNHpUMUmj0u3MYuOovAWW/Gpr1xt9K4mFL3HwPauGx0Zc0UYwL4rT
	4nBaJX5BrKmAmzcVni46bwp4xpczM04=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cabd55d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 16:10:23 +0000 (UTC)
Date: Wed, 19 Mar 2025 17:10:18 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>, Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 RESEND net-next 1/2] selftests: wireguards: convert
 iptables to nft
Message-ID: <Z9rsahBCpwUkDTmf@zx2c4.com>
References: <20250106081043.2073169-1-liuhangbin@gmail.com>
 <20250106081043.2073169-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106081043.2073169-2-liuhangbin@gmail.com>

On Mon, Jan 06, 2025 at 08:10:42AM +0000, Hangbin Liu wrote:
> +n0 nft add rule ip wgtest INPUT meta length 1360 counter drop

What's the point of `counter` here? It's never read back.

> +n0 nft add rule ip wgtest POSTROUTING ip saddr 192.168.1.0/24 ip daddr 10.0.0.0/24 counter snat to 10.0.0.1

Ditto.

> +n1 nft add rule ip wgtest OUTPUT counter meta mark set 0x1

Ditto.

> +n2 nft add rule ip wgtest POSTROUTING ip saddr 10.0.0.0/24 ip daddr 192.168.241.0/24 counter snat to 192.168.241.2

Ditto.

> +n0 nft add rule ip wgtest INPUT iifname "vethrs" ip saddr != 10.0.0.0/24 counter drop

Ditto.

